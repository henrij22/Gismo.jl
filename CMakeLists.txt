######################################################################
## CMakeLists.txt --- Gismo.m
## This file is part of the G+Smo library.
##
######################################################################

project( Gismo.jl )

set(IMPORT_LIBGISMO "")
if (GISMO_JL_DEVELOP)
    set(IMPORT_LIBGISMO "libgismo = \"${CMAKE_BINARY_DIR}/lib/libgismo\"")
else()
    set(IMPORT_LIBGISMO "import gismo_jll:libgismo")
endif()

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/cmake/Gismo.jl.in" "${CMAKE_CURRENT_SOURCE_DIR}/src/Gismo.jl")

# # Assumption on file structure
# # Every module needs to have the C .h and .cpp files into root/src/cinterface/

# set(gsOptional_paths "%%% Optional Modules:")
# set(gsOptional_headers "... %%% Optional Modules:")
# foreach(gssm ${GISMO_OPTIONAL})
#     string(STRIP ${gssm} SUBMODULE)
#     if (EXISTS "${gismo_SOURCE_DIR}/optional/${SUBMODULE}/src/cinterface")
#         set(gsOptional_paths   "${gsOptional_paths}  \n%%  ${SUBMODULE}")
#         set(gsOptional_headers "${gsOptional_headers}\n            ... %%  ${SUBMODULE}")

#         set(gsOptional_paths "${gsOptional_paths}\naddpath(genpath([path_to_optional,'/${SUBMODULE}']));")
#         # Loop over the header files in the submodule
#         file( GLOB SUBMODULE_HEADERS ${gismo_SOURCE_DIR}/optional/${SUBMODULE}/src/cinterface/*.h)
#         foreach(HEADER ${SUBMODULE_HEADERS})
#             get_filename_component(HEADER_NAME ${HEADER} NAME)
#             set(gsOptional_headers "${gsOptional_headers}\n            'addheader','${HEADER_NAME}',...")
#         endforeach()
#     endif()
# endforeach()

add_custom_target(${PROJECT_NAME} ALL DEPENDS)

add_custom_command(TARGET ${PROJECT_NAME}
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --green 'To get started in Matlab execute set_path.m from  ${CMAKE_CURRENT_BINARY_DIR}'
  COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --green 'Tests are located at ${CMAKE_CURRENT_SOURCE_DIR}/test'
  )

#INSTALL ...

