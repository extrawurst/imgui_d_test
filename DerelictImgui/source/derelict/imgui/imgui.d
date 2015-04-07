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
module derelict.imgui.imgui;

public
{
	import derelict.imgui.types;
	import derelict.imgui.funcs;
}

private
{
    import derelict.util.loader;

    version(darwin)
        version = MacOSX;
    version(OSX)
        version = MacOSX;
}

private
{
    import derelict.util.loader;
    import derelict.util.system;

    static if(Derelict_OS_Windows)
        enum libNames = "cimgui.dll";    
    else static if (Derelict_OS_Mac)
        enum libNames = "cimgui.dylib";
    else static if (Derelict_OS_Linux)
		enum libNames = "cimgui.so";
    else
        static assert(0, "Need to implement imgui libNames for this operating system.");
}

class DerelictImguiLoader : SharedLibLoader
{

    protected
    {
        override void loadSymbols()
        {
			bindFunc(cast(void**)&ImGui_GetIO, "ImGui_GetIO");
			bindFunc(cast(void**)&ImGui_Shutdown, "ImGui_Shutdown");
			bindFunc(cast(void**)&ImGui_NewFrame, "ImGui_NewFrame");
			bindFunc(cast(void**)&ImGui_Render, "ImGui_Render");

            bindFunc(cast(void**)&ImGui_ShowTestWindow, "ImGui_ShowTestWindow");

            bindFunc(cast(void**)&ImGui_Begin, "ImGui_Begin");
            bindFunc(cast(void**)&ImGui_End, "ImGui_End");

			bindFunc(cast(void**)&ImGui_Text, "ImGui_Text");
			bindFunc(cast(void**)&ImGui_SliderFloat, "ImGui_SliderFloat");
            bindFunc(cast(void**)&ImGui_ColorEdit3, "ImGui_ColorEdit3");

			bindFunc(cast(void**)&ImGui_Button, "ImGui_Button");
            bindFunc(cast(void**)&ImGui_SmallButton, "ImGui_SmallButton");

            bindFunc(cast(void**)&ImGui_SetNextWindowSize, "ImGui_SetNextWindowSize");
            bindFunc(cast(void**)&ImGui_SetNextWindowPos, "ImGui_SetNextWindowPos");

			bindFunc(cast(void**)&ImFontAtlas_GetTexDataAsRGBA32, "ImFontAtlas_GetTexDataAsRGBA32");
            bindFunc(cast(void**)&ImFontAtlas_SetTexID, "ImFontAtlas_SetTexID");
			bindFunc(cast(void**)&ImDrawList_GetVertexBufferSize, "ImDrawList_GetVertexBufferSize");
			bindFunc(cast(void**)&ImDrawList_GetVertexPtr, "ImDrawList_GetVertexPtr");
			bindFunc(cast(void**)&ImDrawList_GetCmdSize, "ImDrawList_GetCmdSize");
			bindFunc(cast(void**)&ImDrawList_GetCmdPtr, "ImDrawList_GetCmdPtr");
            bindFunc(cast(void**)&ImGuiIO_AddInputCharacter, "ImGuiIO_AddInputCharacter");

            bindFunc(cast(void**)&ImGui_TreeNode, "ImGui_TreeNode");
            bindFunc(cast(void**)&ImGui_TreeNode_IdFmt, "ImGui_TreeNode_IdFmt");
            bindFunc(cast(void**)&ImGui_TreePop, "ImGui_TreePop");

            bindFunc(cast(void**)&ImGui_SameLine, "ImGui_SameLine");
        }
    }

    public
    {
        this()
        {
            super(libNames);
        }
    }
}

__gshared DerelictImguiLoader DerelictImgui;

shared static this()
{
	DerelictImgui = new DerelictImguiLoader();
}
