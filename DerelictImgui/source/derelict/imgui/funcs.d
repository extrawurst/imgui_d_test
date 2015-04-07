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
	alias ImGuiIO* function() da_ImGui_GetIO;
	alias void function() da_ImGui_Shutdown;
	alias void function() da_ImGui_NewFrame;
	alias void function() da_ImGui_Render;

    alias void function(bool* opened) da_ImGui_ShowTestWindow;

    alias bool function(in char* name="debug", bool* p_opened=null, ImGuiWindowFlags flags=0) da_ImGui_Begin;
    alias void function() da_ImGui_End;

	alias void function(in char* text, ...) da_ImGui_Text;
    alias bool function(in char* label,ref float[3] col) da_ImGui_ColorEdit3;
	alias void function(in char* label,float* v,float v_min,float v_max,const char* display_format="%.3f",float power=1.0f) da_ImGui_SliderFloat;
	
    alias bool function(const char* label, const ImVec2* size=&foo, bool repeat_when_held=false) da_ImGui_Button;
    alias bool function(const char* label) da_ImGui_SmallButton;

    alias void function(in ImVec2 size, ImGuiSetCond cond=0) da_ImGui_SetNextWindowSize;
    alias void function(in ImVec2 pos, ImGuiSetCond cond=0) da_ImGui_SetNextWindowPos;

	alias void function(ImFontAtlas* atlas,ubyte** out_pixels,int* out_width,int* out_height,int* out_bytes_per_pixel) da_ImFontAtlas_GetTexDataAsRGBA32;
    alias void function(ImFontAtlas* atlas, void* id) da_ImFontAtlas_SetTexID;
	alias int function(ImDrawList* list) da_ImDrawList_GetVertexBufferSize;
	alias ImDrawVert* function(ImDrawList* list, int n) da_ImDrawList_GetVertexPtr;
	alias int function(ImDrawList* list) da_ImDrawList_GetCmdSize;
	alias ImDrawCmd* function(ImDrawList* list, int n) da_ImDrawList_GetCmdPtr;
    alias void function(ushort c) da_ImGuiIO_AddInputCharacter;

    alias bool function(in char* str_label_id) da_ImGui_TreeNode;
    alias bool function(in void* ptr_id, in char* fmt, ...) da_ImGui_TreeNode_IdFmt;
    alias void function() da_ImGui_TreePop;

    alias void function(int column_x = 0, int spacing_w = -1) da_ImGui_SameLine;
}

__gshared
{
	da_ImGui_GetIO ImGui_GetIO;
	da_ImGui_Shutdown ImGui_Shutdown;
	da_ImGui_NewFrame ImGui_NewFrame;
	da_ImGui_Render ImGui_Render;

    da_ImGui_ShowTestWindow ImGui_ShowTestWindow;

    da_ImGui_Begin ImGui_Begin;
    da_ImGui_End ImGui_End;

	da_ImGui_Text ImGui_Text;
	da_ImGui_SliderFloat ImGui_SliderFloat;

	da_ImGui_Button ImGui_Button;
    da_ImGui_SmallButton ImGui_SmallButton;

    da_ImGui_SetNextWindowSize ImGui_SetNextWindowSize;
    da_ImGui_SetNextWindowPos ImGui_SetNextWindowPos;

	da_ImFontAtlas_GetTexDataAsRGBA32 ImFontAtlas_GetTexDataAsRGBA32;
    da_ImFontAtlas_SetTexID ImFontAtlas_SetTexID;

	da_ImDrawList_GetVertexBufferSize ImDrawList_GetVertexBufferSize;
	da_ImDrawList_GetVertexPtr ImDrawList_GetVertexPtr;
	da_ImDrawList_GetCmdSize ImDrawList_GetCmdSize;
	da_ImDrawList_GetCmdPtr ImDrawList_GetCmdPtr;

    da_ImGuiIO_AddInputCharacter ImGuiIO_AddInputCharacter;
    da_ImGui_ColorEdit3 ImGui_ColorEdit3;

    da_ImGui_TreeNode ImGui_TreeNode;
    da_ImGui_TreeNode_IdFmt ImGui_TreeNode_IdFmt;
    da_ImGui_TreePop ImGui_TreePop;

    da_ImGui_SameLine ImGui_SameLine;
}


  

