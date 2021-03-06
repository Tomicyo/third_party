// Copyright (c) 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef LIBSPIRV_ENUM_STRING_MAPPING_H_
#define LIBSPIRV_ENUM_STRING_MAPPING_H_

#include <string>

#include "spirv/1.1/spirv.h"

namespace libspirv {

enum class Extension;

// Finds Extension enum corresponding to |str|. Returns false if not found.
bool GetExtensionFromString(const std::string& str, Extension* extension);

// Returns text string corresponding to |extension|.
std::string ExtensionToString(Extension extension);

// Returns text string corresponding to |capability|.
std::string CapabilityToString(SpvCapability capability);

}  // namespace libspirv

#endif  // LIBSPIRV_ENUM_STRING_MAPPING_H_
