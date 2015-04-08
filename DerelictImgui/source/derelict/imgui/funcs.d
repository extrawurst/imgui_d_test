/*
 * Copyright (c) 2015 Derelict Developers
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * * Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 *
 * * Neither the names 'Derelict', 'DerelictILUT', nor the names of its contributors
 *   may be used to endorse or promote products derived from this software
 *   without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
module derelict.imgui.funcs;

private
{
    import derelict.util.system;
	import derelict.imgui.types;
}

ImVec2 foo;

extern(C) @nogc nothrow
{
	alias da_ig_GetIO 						= ImGuiIO* function();
	alias da_ig_GetStyle 					= ImGuiStyle* function();
	alias da_ig_NewFrame 					= void function();
	alias da_ig_Render 						= void function();
	alias da_ig_Shutdown 					= void function();
	alias da_ig_ShowUserGuide 				= void function();
	alias da_ig_ShowStyleEditor 			= void function(ImGuiStyle* ref_);
	alias da_ig_ShowTestWindow 				= void function(bool* opened = null);
	alias da_ig_ShowMetricsWindow 			= void function(bool* opened = null);

	// Window
	alias da_ig_Begin 						= bool function(const char* name = "Debug", bool* p_opened = null, ImGuiWindowFlags flags = 0);
	alias da_ig_Begin2 						= bool function(const char* name, bool* p_opened, const ImVec2 size_on_first_use, float bg_alpha = -1.0f, ImGuiWindowFlags flags = 0);
	alias da_ig_End 						= void function();
	alias da_ig_BeginChild 					= bool function(const char* str_id, const ImVec2 size = ImVec2(0, 0), bool border = false, ImGuiWindowFlags extra_flags = 0);
	alias da_ig_BeginChild2 				= bool function(ImGuiID id, const ImVec2 size = ImVec2(0, 0), bool border = false, ImGuiWindowFlags extra_flags = 0);
	alias da_ig_EndChild 					= void function();
	alias da_ig_GetContentRegionMax 		= void function(ImVec2* outParam);
	alias da_ig_GetWindowContentRegionMin 	= void function(ImVec2* outParam);
	alias da_ig_GetWindowContentRegionMax 	= void function(ImVec2* outParam);
	alias da_ig_GetWindowDrawList 			= ImDrawList* function();
	alias da_ig_GetWindowFont 				= ImFont* function();
	alias da_ig_GetWindowFontSize 			= float function(); 
	alias da_ig_SetWindowFontScale 			= void function(float scale);
	alias da_ig_GetWindowPos 				= void function(ImVec2* outParam);
	alias da_ig_GetWindowSize 				= void function(ImVec2* outParam);
	alias da_ig_GetWindowWidth 				= float function();
	alias da_ig_GetWindowCollapsed 			= bool function();

	alias da_ig_SetNextWindowPos 			= void function(const ImVec2 pos, ImGuiSetCond cond = 0);
	alias da_ig_SetNextWindowSize 			= void function(const ImVec2 size, ImGuiSetCond cond = 0);
	alias da_ig_SetNextWindowCollapsed 		= void function(bool collapsed, ImGuiSetCond cond = 0);
	alias da_ig_SetNextWindowFocus 			= void function();
	alias da_ig_SetWindowPos 				= void function(const ImVec2 pos, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowSize 				= void function(const ImVec2 size, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowCollapsed 			= void function(bool collapsed, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowFocus 				= void function();
	alias da_ig_SetWindowPos2 				= void function(const char* name, const ImVec2 pos, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowSize2 				= void function(const char* name, const ImVec2 size, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowCollapsed2 		= void function(const char* name, bool collapsed, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowFocus2 			= void function(const char* name);
}

//TODO: rework
extern(C) @nogc nothrow
{
	alias void function(in char* text, ...) da_ig_Text;
    alias bool function(in char* label,ref float[3] col) da_ig_ColorEdit3;
	alias void function(in char* label,float* v,float v_min,float v_max,const char* display_format="%.3f",float power=1.0f) da_ig_SliderFloat;
	
    alias bool function(const char* label, const ImVec2 size=ImVec2(0,0), bool repeat_when_held=false) da_ig_Button;
    alias bool function(const char* label) da_ig_SmallButton;

	alias void function(ImFontAtlas* atlas,ubyte** out_pixels,int* out_width,int* out_height,int* out_bytes_per_pixel) da_ImFontAtlas_GetTexDataAsRGBA32;
    alias void function(ImFontAtlas* atlas, void* id) da_ImFontAtlas_SetTexID;
	alias int function(ImDrawList* list) da_ImDrawList_GetVertexBufferSize;
	alias ImDrawVert* function(ImDrawList* list, int n) da_ImDrawList_GetVertexPtr;
	alias int function(ImDrawList* list) da_ImDrawList_GetCmdSize;
	alias ImDrawCmd* function(ImDrawList* list, int n) da_ImDrawList_GetCmdPtr;
    alias void function(ushort c) da_ImGuiIO_AddInputCharacter;

    alias bool function(in char* str_label_id) da_ig_TreeNode;
    alias bool function(in void* ptr_id, in char* fmt, ...) da_ig_TreeNode_IdFmt;
    alias void function() da_ig_TreePop;

    alias void function(int column_x = 0, int spacing_w = -1) da_ig_SameLine;
}

__gshared
{
	da_ig_GetIO ig_GetIO;
	da_ig_GetStyle ig_GetStyle;
	da_ig_NewFrame ig_NewFrame;
	da_ig_Render ig_Render;
	da_ig_Shutdown ig_Shutdown;
	da_ig_ShowUserGuide ig_ShowUserGuide;
	da_ig_ShowStyleEditor ig_ShowStyleEditor;
	da_ig_ShowTestWindow ig_ShowTestWindow;
	da_ig_ShowMetricsWindow ig_ShowMetricsWindow;

	// Window
	da_ig_Begin ig_Begin;
	da_ig_Begin2 ig_Begin2;
	da_ig_End ig_End;
	da_ig_BeginChild ig_BeginChild;
	da_ig_BeginChild2 ig_BeginChild2;
	da_ig_EndChild ig_EndChild;
	da_ig_GetContentRegionMax ig_GetContentRegionMax;
	da_ig_GetWindowContentRegionMin ig_GetWindowContentRegionMin;
	da_ig_GetWindowContentRegionMax ig_GetWindowContentRegionMax;
	da_ig_GetWindowDrawList ig_GetWindowDrawList;
	da_ig_GetWindowFont ig_GetWindowFont;
	da_ig_GetWindowFontSize ig_GetWindowFontSize;
	da_ig_SetWindowFontScale ig_SetWindowFontScale;
	da_ig_GetWindowPos ig_GetWindowPos;
	da_ig_GetWindowSize ig_GetWindowSize;
	da_ig_GetWindowWidth ig_GetWindowWidth;
	da_ig_GetWindowCollapsed ig_GetWindowCollapsed;

	da_ig_SetNextWindowPos ig_SetNextWindowPos;
	da_ig_SetNextWindowSize ig_SetNextWindowSize;
	da_ig_SetNextWindowCollapsed ig_SetNextWindowCollapsed;
	da_ig_SetNextWindowFocus ig_SetNextWindowFocus;
	da_ig_SetWindowPos ig_SetWindowPos;
	da_ig_SetWindowSize ig_SetWindowSize;
	da_ig_SetWindowCollapsed ig_SetWindowCollapsed;
	da_ig_SetWindowFocus ig_SetWindowFocus;
	da_ig_SetWindowPos2 ig_SetWindowPos2;
	da_ig_SetWindowSize2 ig_SetWindowSize2;
	da_ig_SetWindowCollapsed2 ig_SetWindowCollapsed2;
	da_ig_SetWindowFocus2 ig_SetWindowFocus2;
}

//TODO: rework
__gshared
{
	da_ig_Text ig_Text;
	da_ig_SliderFloat ig_SliderFloat;

	da_ig_Button ig_Button;
    da_ig_SmallButton ig_SmallButton;

	da_ImFontAtlas_GetTexDataAsRGBA32 ImFontAtlas_GetTexDataAsRGBA32;
    da_ImFontAtlas_SetTexID ImFontAtlas_SetTexID;

	da_ImDrawList_GetVertexBufferSize ImDrawList_GetVertexBufferSize;
	da_ImDrawList_GetVertexPtr ImDrawList_GetVertexPtr;
	da_ImDrawList_GetCmdSize ImDrawList_GetCmdSize;
	da_ImDrawList_GetCmdPtr ImDrawList_GetCmdPtr;

    da_ImGuiIO_AddInputCharacter ImGuiIO_AddInputCharacter;
    da_ig_ColorEdit3 ig_ColorEdit3;

    da_ig_TreeNode ig_TreeNode;
    da_ig_TreeNode_IdFmt ig_TreeNode_IdFmt;
    da_ig_TreePop ig_TreePop;

    da_ig_SameLine ig_SameLine;
}


  

