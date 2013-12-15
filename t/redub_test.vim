source plugin/redub.vim

describe 'Redub'
  before
    !rm -r tmp
    call mkdir("tmp")
  end

  after
    close!
    !rm -r tmp
  end

  it 'renames the current buffer'
    new
    normal iHello, world!
    write tmp/foo.txt
    Redub tmp/bar.txt

    Expect filereadable("tmp/foo.txt") to_be_false
    Expect readfile("tmp/bar.txt") == ["Hello, world!"]
  end

  it 'renames a file on disk'
    call writefile(["Hello, world!"], "tmp/foo.txt")
    Redub tmp/foo.txt tmp/bar.txt

    Expect filereadable("tmp/foo.txt") to_be_false
    Expect readfile("tmp/bar.txt") == ["Hello, world!"]
  end
end

