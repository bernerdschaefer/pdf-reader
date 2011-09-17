################################################################################
#
# Copyright (C) 2006 Peter J Jones (pjones@pmade.com)
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
################################################################################

class PDF::Reader
  ################################################################################
  # An internal PDF::Reader class that represents a inline image from a PDF. Stream
  # objects have 2 components, a dictionary that describes the content (size,
  # compression, etc) and a stream of bytes.
  #
  class InlineImage < Stream
    ################################################################################
    # See Table 93 and 94 from the PDF Spec.
    ABBREVIATIONS = {
      :BPC => :BitsPerComponent,
      :CS => :ColorSpace,
      :D => :Decode,
      :DP => :DecodeParms,
      :F => :Filter,
      :H => :Height,
      :IM => :ImageMask,
      :I => :Interpolate,
      :W => :Width,
      :G => :DeviceGray,
      :RGB => :DeviceRGB,
      :CMYK => :DeviceCMYK,
      :I => :Indexed,
      :AHx => :ASCIIHexDecode,
      :A85 => :ASCII85Decode,
      :LZW => :LZWDecode,
      :Fl => :FlateDecode,
      :RL => :RunLengthDecode,
      :CCF => :CCITTFaxDecode,
      :DCT => :DCTDecode
    }
    ################################################################################
    # Creates a new stream with the specified dictionary and data. The dictionary
    # should be a standard ruby hash, the data should be a standard ruby string.
    def initialize (hash, data)
      hash = expand_abbreviations(hash)
      super(hash, data)
    end
    ################################################################################
    # Expands abbreviations in the inline image hash according to the rules in
    # the PDF spec.
    def expand_abbreviations(hash)
      new_hash = {}
      hash.each do |key, value|
        new_hash[ABBREVIATIONS[key] || key] = ABBREVIATIONS[value] || value
      end
      new_hash
    end
  end
  ################################################################################
end
################################################################################
