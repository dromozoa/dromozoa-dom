return function (c)
  if c < 894 then
    if c < 123 then
      if c < 91 then
        if c < 59 then
          if c < 58 then return false else return true end
        else
          if c < 65 then return false else return true end
        end
      else
        if c < 96 then
          if c < 95 then return false else return true end
        else
          if c < 97 then return false else return true end
        end
      end
    else
      if c < 247 then
        if c < 215 then
          if c < 192 then return false else return true end
        else
          if c < 216 then return false else return true end
        end
      else
        if c < 768 then
          if c < 248 then return false else return true end
        else
          if c < 880 then return false else return true end
        end
      end
    end
  else
    if c < 12272 then
      if c < 8206 then
        if c < 8192 then
          if c < 895 then return false else return true end
        else
          if c < 8204 then return false else return true end
        end
      else
        if c < 8592 then
          if c < 8304 then return false else return true end
        else
          if c < 11264 then return false else return true end
        end
      end
    else
      if c < 64976 then
        if c < 55296 then
          if c < 12289 then return false else return true end
        else
          if c < 63744 then return false else return true end
        end
      else
        if c < 65534 then
          if c < 65008 then return false else return true end
        else
          if c < 65536 then return false else return false end
        end
      end
    end
  end
end
