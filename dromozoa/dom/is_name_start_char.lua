return function (c)
  if c < 895 then
    if c < 192 then
      if c < 95 then
        if c < 65 then
          if c < 59 then
            if c < 58 then return false else return true end
          else return false end
        else
          if c < 91 then return true else return false end
        end
      else
        if c < 97 then
          if c < 96 then return true else return false end
        else
          if c < 123 then return true else return false end
        end
      end
    else
      if c < 248 then
        if c < 216 then
          if c < 215 then return true else return false end
        else
          if c < 247 then return true else return false end
        end
      else
        if c < 880 then
          if c < 768 then return true else return false end
        else
          if c < 894 then return true else return false end
        end
      end
    end
  else
    if c < 12289 then
      if c < 8304 then
        if c < 8204 then
          if c < 8192 then return true else return false end
        else
          if c < 8206 then return true else return false end
        end
      else
        if c < 11264 then
          if c < 8592 then return true else return false end
        else
          if c < 12272 then return true else return false end
        end
      end
    else
      if c < 65008 then
        if c < 63744 then
          if c < 55296 then return true else return false end
        else
          if c < 64976 then return true else return false end
        end
      else
        if c < 65536 then
          if c < 65534 then return true else return false end
        else
          if c < 983040 then return true else return false end
        end
      end
    end
  end
end
