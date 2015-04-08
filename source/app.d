module main;

import derelict.imgui.imgui;
import derelict.opengl3.gl3;
import derelict.glfw3.glfw3;

import imgui_glfw;

extern(C) nothrow void error_callback(int error, const(char)* description)
{
	import std.stdio;
    import std.conv;
	try writefln("glfw err: %s ('%s')",error, to!string(description));
	catch{}
}

void main()
{
	DerelictGL3.load();
	DerelictGLFW3.load();
	DerelictImgui.load();

	// Setup window
	glfwSetErrorCallback(&error_callback);
	if (!glfwInit())
		return;
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, true);
	auto window = glfwCreateWindow(1280, 720, "ImGui OpenGL3 example", null, null);
	glfwMakeContextCurrent(window);
	glfwInit();

	DerelictGL3.reload();
	
	// Setup ImGui binding
	ig_ImplGlfwGL3_Init(window, true);
	//ImGuiIO& io = ImGui::GetIO();
	//ImFont* my_font0 = io.Fonts->AddFontDefault();
	//ImFont* my_font1 = io.Fonts->AddFontFromFileTTF("../../extra_fonts/DroidSans.ttf", 16.0f);
	//ImFont* my_font2 = io.Fonts->AddFontFromFileTTF("../../extra_fonts/Karla-Regular.ttf", 16.0f);
	//ImFont* my_font3 = io.Fonts->AddFontFromFileTTF("../../extra_fonts/ProggyClean.ttf", 13.0f); my_font3->DisplayOffset.y += 1;
	//ImFont* my_font4 = io.Fonts->AddFontFromFileTTF("../../extra_fonts/ProggyTiny.ttf", 10.0f); my_font4->DisplayOffset.y += 1;
	//ImFont* my_font5 = io.Fonts->AddFontFromFileTTF("c:\\Windows\\Fonts\\ArialUni.ttf", 18.0f, io.Fonts->GetGlyphRangesJapanese());
	
	bool show_test_window = true;
	bool show_another_window = false;
    float[3] clear_color = [0.3f, 0.4f, 0.8f];
	
	// Main loop
	while (!glfwWindowShouldClose(window))
	{
		ImGuiIO* io = ig_GetIO();
		glfwPollEvents();

		ig_ImplGlfwGL3_NewFrame();

		// 1. Show a simple window
		// Tip: if we don't call ImGui::Begin()/ImGui::End() the widgets appears in a window automatically called "Debug"
		{
			static float f = 0.0f;
			ig_Text("Hello, world!");
			ig_SliderFloat("float", &f, 0.0f, 1.0f);
			ig_ColorEdit3("clear color", clear_color);
			if (ig_Button("Test Window")) show_test_window ^= 1;
			if (ig_Button("Another Window")) show_another_window ^= 1;
			ig_Text("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / ig_GetIO().Framerate, ig_GetIO().Framerate);
		}
		
		// 2. Show another simple window, this time using an explicit Begin/End pair
		if (show_another_window)
		{
            ig_SetNextWindowSize(ImVec2(200,100), ImGuiSetCond_FirstUseEver);
    		ig_Begin("Another Window", &show_another_window);
    		ig_Text("Hello");
            if (ig_TreeNode("Tree"))
            {
                for (size_t i = 0; i < 5; i++)
                {
                    if (ig_TreeNode3(cast(void*)i, "Child %d", i))
                    {
                        ig_Text("blah blah");
                        ig_SameLine();
                        ig_SmallButton("print");
                        ig_TreePop();
                    }
                }
                ig_TreePop();
            }
    		ig_End();
		}
		
		// 3. Show the ImGui test window. Most of the sample code is in ImGui::ShowTestWindow()
		if (show_test_window)
		{
		    ig_SetNextWindowPos(ImVec2(650, 20), ImGuiSetCond_FirstUseEver);
		    ig_ShowTestWindow(&show_test_window);
		}

		// Rendering
		glViewport(0, 0, cast(int)io.DisplaySize.x, cast(int)io.DisplaySize.y);
        glClearColor(clear_color[0], clear_color[1], clear_color[2], 0);
		glClear(GL_COLOR_BUFFER_BIT);
		ig_Render();
		glfwSwapBuffers(window);
	}
	
	// Cleanup
	ig_ImplGlfwGL3_Shutdown();
	glfwTerminate();
}
