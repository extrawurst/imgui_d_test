module imgui_glfw;

import derelict.imgui.imgui;
import derelict.opengl3.gl3;
import derelict.glfw3.glfw3;

GLFWwindow* g_window;
GLuint       g_FontTexture = 0;
int          g_ShaderHandle = 0, g_VertHandle = 0, g_FragHandle = 0;
int          g_AttribLocationTex = 0, g_AttribLocationProjMtx = 0;
int          g_AttribLocationPosition = 0, g_AttribLocationUV = 0, g_AttribLocationColor = 0;
size_t       g_VboMaxSize = 20000;
uint g_VboHandle, g_VaoHandle;

extern(C) nothrow void ImGui_ImplGlfwGL3_RenderDrawLists(ImDrawList** cmd_lists, int count)
{
	if (count == 0)
		return;

	import std.stdio;

	// Setup render state: alpha-blending enabled, no face culling, no depth testing, scissor enabled
	glEnable(GL_BLEND);
	glBlendEquation(GL_FUNC_ADD);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glDisable(GL_CULL_FACE);
	glDisable(GL_DEPTH_TEST);
	glEnable(GL_SCISSOR_TEST);
	glActiveTexture(GL_TEXTURE0);

	auto io = ImGui_GetIO();
	// Setup orthographic projection matrix
	const float width = io.DisplaySize.x;
	const float height = io.DisplaySize.y;
	//try writefln("io: %s\ncmds: %s",*io, count); catch{}
	const float[4][4] ortho_projection =
	[
		[ 2.0f/width,	0.0f,			0.0f,		0.0f ],
		[ 0.0f,			2.0f/-height,	0.0f,		0.0f ],
		[ 0.0f,			0.0f,			-1.0f,		0.0f ],
		[ -1.0f,		1.0f,			0.0f,		1.0f ],
	];
	glUseProgram(g_ShaderHandle);
	glUniform1i(g_AttribLocationTex, 0);
	glUniformMatrix4fv(g_AttribLocationProjMtx, 1, GL_FALSE, &ortho_projection[0][0]);

	// Grow our buffer according to what we need
	size_t total_vtx_count = 0;
	for (int n = 0; n < count; n++)
	{
		total_vtx_count += ImDrawList_GetVertexBufferSize(cmd_lists[n]);
	}
	//try writefln("cnt: %s",total_vtx_count); catch{}

	glBindBuffer(GL_ARRAY_BUFFER, g_VboHandle);
	size_t neededBufferSize = total_vtx_count * ImDrawVert.sizeof;
	if (neededBufferSize > g_VboMaxSize)
	{
		g_VboMaxSize = neededBufferSize + 5000;  // Grow buffer
		glBufferData(GL_ARRAY_BUFFER, g_VboMaxSize, null, GL_STREAM_DRAW);
	}
	
	// Copy and convert all vertices into a single contiguous buffer
	ubyte* buffer_data = cast(ubyte*)glMapBuffer(GL_ARRAY_BUFFER, GL_WRITE_ONLY);
	if (!buffer_data)
		return;
	for (int n = 0; n < count; n++)
	{
		ImDrawList* cmd_list = cmd_lists[n];
		auto vListSize = ImDrawList_GetVertexBufferSize(cmd_list) * ImDrawVert.sizeof;
		import std.c.string:memcpy;
		memcpy(buffer_data, ImDrawList_GetVertexPtr(cmd_list,0), vListSize);
		buffer_data += vListSize;
	}
	glUnmapBuffer(GL_ARRAY_BUFFER);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glBindVertexArray(g_VaoHandle);
	
	int cmd_offset = 0;
	for (int n = 0; n < count; n++)
	{
		ImDrawList* cmd_list = cmd_lists[n];
		int vtx_offset = cmd_offset;

		auto cmdCnt = ImDrawList_GetCmdSize(cmd_list);

		foreach(i; 0..cmdCnt)
		{
			auto pcmd = ImDrawList_GetCmdPtr(cmd_list, i);

			if (pcmd.user_callback)
			{
				//pcmd.user_callback(cmd_list, pcmd);
			}
			else
			{
				glBindTexture(GL_TEXTURE_2D, cast(GLuint)pcmd.texture_id);
				//TODO:
				//glScissor((int)pcmd->clip_rect.x, (int)(height - pcmd->clip_rect.w), (int)(pcmd->clip_rect.z - pcmd->clip_rect.x), (int)(pcmd->clip_rect.w - pcmd->clip_rect.y));
				glDrawArrays(GL_TRIANGLES, vtx_offset, pcmd.vtx_count);
			}
			vtx_offset += pcmd.vtx_count;
		}

		cmd_offset = vtx_offset;
	}
	
	// Restore modified state
	glBindVertexArray(0);
	glUseProgram(0);
	glDisable(GL_SCISSOR_TEST);
	glBindTexture(GL_TEXTURE_2D, 0);
}

void ImGui_ImplGlfwGL3_Init(GLFWwindow* window, bool v)
{
	g_window = window;

	ImGuiIO* io = ImGui_GetIO();
	
	io.RenderDrawListsFn = &ImGui_ImplGlfwGL3_RenderDrawLists;
}

void ImGui_ImplGlfwGL3_CreateDeviceObjects()
{
	const GLchar *vertex_shader =
		"#version 330\n"
			"uniform mat4 ProjMtx;\n"
			"in vec2 Position;\n"
			"in vec2 UV;\n"
			"in vec4 Color;\n"
			"out vec2 Frag_UV;\n"
			"out vec4 Frag_Color;\n"
			"void main()\n"
			"{\n"
			"	Frag_UV = UV;\n"
			"	Frag_Color = Color;\n"
			"	gl_Position = ProjMtx * vec4(Position.xy,0,1);\n"
			"}\n";
	
	const GLchar* fragment_shader =
		"#version 330\n"
			"uniform sampler2D Texture;\n"
			"in vec2 Frag_UV;\n"
			"in vec4 Frag_Color;\n"
			"out vec4 Out_Color;\n"
			"void main()\n"
			"{\n"
			"	Out_Color = Frag_Color * texture( Texture, Frag_UV.st);\n"
			"}\n";
	
	g_ShaderHandle = glCreateProgram();
	g_VertHandle = glCreateShader(GL_VERTEX_SHADER);
	g_FragHandle = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(g_VertHandle, 1, &vertex_shader, null);
	glShaderSource(g_FragHandle, 1, &fragment_shader, null);
	glCompileShader(g_VertHandle);
	glCompileShader(g_FragHandle);
	glAttachShader(g_ShaderHandle, g_VertHandle);
	glAttachShader(g_ShaderHandle, g_FragHandle);
	glLinkProgram(g_ShaderHandle);
	
	g_AttribLocationTex = glGetUniformLocation(g_ShaderHandle, "Texture");
	g_AttribLocationProjMtx = glGetUniformLocation(g_ShaderHandle, "ProjMtx");
	g_AttribLocationPosition = glGetAttribLocation(g_ShaderHandle, "Position");
	g_AttribLocationUV = glGetAttribLocation(g_ShaderHandle, "UV");
	g_AttribLocationColor = glGetAttribLocation(g_ShaderHandle, "Color");
	
	glGenBuffers(1, &g_VboHandle);
	glBindBuffer(GL_ARRAY_BUFFER, g_VboHandle);
	glBufferData(GL_ARRAY_BUFFER, g_VboMaxSize, null, GL_DYNAMIC_DRAW);
	
	glGenVertexArrays(1, &g_VaoHandle);
	glBindVertexArray(g_VaoHandle);
	glBindBuffer(GL_ARRAY_BUFFER, g_VboHandle);
	glEnableVertexAttribArray(g_AttribLocationPosition);
	glEnableVertexAttribArray(g_AttribLocationUV);
	glEnableVertexAttribArray(g_AttribLocationColor);
	
//#define OFFSETOF(TYPE, ELEMENT) ((size_t)&(((TYPE *)0)->ELEMENT))

	glVertexAttribPointer(g_AttribLocationPosition, 2, GL_FLOAT, GL_FALSE, ImDrawVert.sizeof, cast(void*)0);
	glVertexAttribPointer(g_AttribLocationUV, 2, GL_FLOAT, GL_FALSE, ImDrawVert.sizeof, cast(void*)(3*4));
	glVertexAttribPointer(g_AttribLocationColor, 4, GL_UNSIGNED_BYTE, GL_TRUE, ImDrawVert.sizeof, cast(void*)(3*4 + 2*4));

//#undef OFFSETOF
	glBindVertexArray(0);
	glBindBuffer(GL_ARRAY_BUFFER, 0);

	ImGui_ImplGlfwGL3_CreateFontsTexture();
}

void ImGui_ImplGlfwGL3_CreateFontsTexture()
{
	ImGuiIO* io = ImGui_GetIO();
	
	ubyte* pixels;
	int width, height;
	ImFontAtlas_GetTexDataAsRGBA32(io.Fonts,&pixels,&width,&height,null);
	
	glGenTextures(1, &g_FontTexture);
	glBindTexture(GL_TEXTURE_2D, g_FontTexture);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, pixels);

	//TODO:
	// Store our identifier
	//ImFontAtlas_SetTexID(io.Fonts,cast(void*)&g_FontTexture);
}

void ImGui_ImplGlfwGL3_Shutdown()
{
	if (g_FontTexture)
	{
		glDeleteTextures(1, &g_FontTexture);
		//ImGui::GetIO().Fonts->TexID = 0;
		g_FontTexture = 0;
	}

	ImGui_Shutdown();
}

void ImGui_ImplGlfwGL3_NewFrame()
{
	if (!g_FontTexture)
		ImGui_ImplGlfwGL3_CreateDeviceObjects();

	ImGuiIO* io = ImGui_GetIO();

	// Setup display size (every frame to accommodate for window resizing)
	int w, h;
	int display_w, display_h;
	glfwGetWindowSize(g_window, &w, &h);
	glfwGetFramebufferSize(g_window, &display_w, &display_h);
	io.DisplaySize = ImVec2(cast(float)display_w, cast(float)display_h);

	ImGui_NewFrame();
}