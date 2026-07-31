Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BD9C54FCD
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC6610E2B7;
	Sat,  1 Aug 2026 07:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e5ATK3/n";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A3C10F431
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:50:47 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so811504f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785534646; x=1786139446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qjxvx3SRHRdNngyn+BsnRyiaEmpffW5fc35P9viCcxY=;
 b=e5ATK3/n4LIEiC7xvxTypTtAtT9Txe7H8A9UEEEoCYlDS4Yol61ythAJEs6ZErcm0Z
 DUoKYqEDvYUZfbjhvxXHHlQkQXPXU1uqI6tkq8PtNYnF4Gw5iJKK57L28yG6X47RTB/3
 g+b/9J/mNuGZtmMKcTvmbBT5IRVrqL7QgHeBEbmi5Z2R1W89mDNvQ+zFZk0jSZCAGnXB
 uAMZfVhoazx+JLt6yJw/XTEpswIX8Znc+0ecEto44TplMb3bMDWzbg0i6FHWgJzJ4wYt
 /c0LFxbdbTa76AzgviAQ9cig3cSgRqrH9LMgEvx3wJvgNysvcrf7EBhP4jcJ5yDu/Clm
 sktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785534646; x=1786139446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qjxvx3SRHRdNngyn+BsnRyiaEmpffW5fc35P9viCcxY=;
 b=oKmeFCctZnb+heGyYYs6u6WBjnXYeChfM32ZJEAgIc4Xve87xe+KdvvRYRoW3rnwgT
 f0WtrC7hkFUxpv7fvBquxa425gc6JORegZUdAEi2xbTYb/3tR04wY8Bd6apb4v04B72y
 k7olFVv8St+Wz3oaCbpT2xY3nmtY9uCRL+YXyUm2F87O9IAHhn/9h8TJCD8VHfT5KjHK
 IqZCy0ifZAIqLxjJ50wP1teQUhTxe/Nsrtj31ijG3fQozg1bh7cARpU5uABKxhP6djAF
 oUNH3YZpy5oTBOyElvAZ7W0Mqm/uMBuwHVQDKotFPUQXNjOu9gGjwIBqHkEuD74IsAyl
 qEOg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+ekjH9VtVti2EqRYjTybhsPDBfu3wL9vdzIhe+M78CTGgiiRfvhADZ65PYQMxpa9/vCvgkGsx4tU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxENbc5JldP6TJBCZDQDJ5/dREpk1V21/pD3swzgPoo/Cnj+wtX
 CcJLxg0B5VIZValqh9mKSn5xo2mUOLf3XzSjteU1cFrosaq+QWL11WBL
X-Gm-Gg: AR+sD13whGmgfFv74ays3d5ggyINgfp5cMONZ8E1OcDtnBA+dmwHtBu8/W8nhE2fEee
 vrePhRnzgWFBWYQvS7Kc8b8Mi4ztTLnUwm6Z3l0NeESIFRMwArIc6YllsTaFeZ7scgIzZbaAA6L
 bId2wp9+K9PveO70XxsliJVwDOm85ZJ8G0wOO+b8D7+yzihPM+3Ql4P641Ioijzca1zMNbUoEj6
 z9JW1H34qrvejGXK5TSTMkeOlDzjQj+bkytFj41owOuiFnz+l/31HYf/bxZnXKOQ2PQC0P9AOzR
 hBlSgft/gW0ZMa6OhMkEJTFzxI0rTc4Dl55sG9VMQZtslg3HUl/os4N1uEJZvOcCsHYSk3IZJJL
 jGij6JjM05hvjqWP4pu/SDfGC0CUy3Fit18rxSbfpRl46g/mIu0hYeGq4tmE+eYg8II2tH1Iafe
 4VrCq9mIpgIqEett4g0fbsY7qhgEXO3SYEdUwUIgL9/ha2pwkz7K3YHd7l6GohZO4arK5HXeKYc
 R70bIQGk8vhQA==
X-Received: by 2002:adf:fd4e:0:b0:47f:8e78:4d0c with SMTP id
 ffacd0b85a97d-47fd72fc101mr1754482f8f.48.1785534645758; 
 Fri, 31 Jul 2026 14:50:45 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.62.64])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2484sm10186342f8f.11.2026.07.31.14.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 14:50:45 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Max Pedraza <maximpedraza@gmail.com>
Subject: [RFC PATCH 0/6] Boot logo supplied by the device tree
Date: Fri, 31 Jul 2026 23:50:37 +0200
Message-Id: <20260731215043.30392-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Embedded products routinely need their own boot logo. Today the only way to
get one is to replace one of the logo_*_clut224.ppm files in the kernel
source tree, which bakes the image into the kernel image. Two products that
share a board support package but differ in branding therefore need two
kernel builds, and rebranding an existing product means rebuilding and
requalifying a kernel for what is purely a cosmetic change.

This series lets the logo be described by the device tree instead: a node
compatible with "linux,boot-logo-clut224" supplies the image in the same
paletted format the built-in CLUT224 logos already use, and the kernel
prefers it over the built-in ones when it is present and enabled. If the
node is absent or disabled, nothing changes.

The image can come from the node itself (patches 1-2) or from a reserved
memory region the bootloader filled in (patches 4-5), because the image and
its placement are independent axes of variation. One board sold to several
customers wants several device trees differing in the logo. One customer
with several products built on that board, with different panels, wants the
same logo placed differently on each: there the image belongs in a shared
binary and only the placement belongs in the device tree. Patch 3 adds that
placement.

We have been carrying a cruder version of this downstream on an AM335x
product since 2020, across a handful of board revisions, and it has removed
a real maintenance burden for us. This is an attempt to find out whether
something along these lines is wanted upstream, and if so in what shape --
hence RFC.

I am aware of the contentious part: a bitmap is not hardware, and the device
tree is not an obvious place to put one. The argument for it is that the
logo identifies the board in the same way the model property does, it is
available before any filesystem is mounted, and it is per board rather than
per kernel. The argument against is presumably that this is policy and
belongs in userspace or in the bootloader. I would rather hear that
explicitly than keep the patch downstream on a guess, and if the concept is
rejected I would still like to know whether a smaller subset -- say the
placement properties driven from the fbcon command line, without any image
in the device tree -- would be worth submitting separately.

Patches 4 and 5 are separable; the series is useful without them if the
reserved memory path is thought to be one mechanism too many.

Not included, though it exists in our downstream version: a hook in
drm_fb_helper so the logo is drawn when CONFIG_FRAMEBUFFER_CONSOLE is
disabled, which is the common case for a product that only wants a splash
screen. Today fb_show_logo() is reached from fbcon alone. That is a DRM
question rather than an fbdev one and deserves a separate posting.

Notes on the binding:

  - The palette size is derived from the length of the "clut" property
    instead of being a separate property, so it cannot disagree with the
    palette actually supplied.
  - "data" holds plain palette indices. The 32 entry offset the frame
    buffer layer reserves for the console is an implementation detail and
    is applied by the kernel.
  - "logo-position" and "logo-offset" are spelled with the prefix because
    plain "position" and "offset" are already used elsewhere in the tree
    with an incompatible type, which dtschema rejects.
  - "logo-centered" overlaps with the existing fb_center_logo, but it is
    per device tree rather than per fbcon command line, and it composes
    with "logo-offset". That combination is what panels with a partially
    visible area need, where the usable region is not the centre of the
    mode; the hardware this came from is an 800x480 panel of which only the
    bottom 320 rows are visible.
  - The reserved memory path takes a "memory-region" phandle rather than a
    bare address. The reservation is what makes the memory safe to read at
    all, and it is what gives the kernel a size to bounds check against.

The byte arrays are not written by hand: patch 6 adds ppmtodtlogo, a host
tool along the lines of the existing pnmtologo -- plain C, no dependencies,
no quantization of its own -- that turns a PPM image into the node or into
the memory region blob. It is what produced everything tested below.

Testing: build tested for arm with CONFIG_LOGO_DT_CLUT224 both enabled and
disabled, W=1 clean, checkpatch --strict clean, dt_binding_check clean. The
schema was also checked against deliberately malformed nodes, including
supplying both image sources at once and neither.

Boot tested under qemu-system-arm -M versatilepb with PL111 and fbcon, at
16bpp. A 160x120 logo placed with "logo-centered" plus a "logo-offset" of
<0 120> lands at exactly the expected coordinates, and every pixel matches
the source image once the source is truncated to RGB565, with identical
per-colour pixel counts. Supplying the same image through a reserved region
loaded at boot produces a bit for bit identical screen. Blobs with a bad
magic, a geometry larger than the reservation, an out of range pixel and an
oversized palette are each rejected with a warning and fall back to the
built-in logo, with no crash.

That boot test earned its keep: the first version of patch 3 drew the logo
correctly and then had it erased, because fb_prepare_logo() still reserved
only the logo's own height while the logo itself had been moved further
down. Nothing in the build or the static checks catches that.

Also boot tested on real hardware: an AM335x board (tilcdc) with an 800x480
panel, migrated from the 4.19 product kernel this derives from. Both image
sources show the product logo where expected -- embedded in the device tree,
and in a bootloader-loaded reserved memory region at the same address the
4.19 system already used. That system builds without
CONFIG_FRAMEBUFFER_CONSOLE, so the drawing there goes through the separate
drm_fb_helper hook mentioned above as not included; the parsing, validation
and placement exercised are those of this series.

Max Pedraza (6):
  dt-bindings: display: add a device tree supplied boot logo
  video: logo: allow the boot logo to come from the device tree
  fbdev: honour the device tree boot logo placement properties
  dt-bindings: display: allow the boot logo in a reserved memory region
  video: logo: allow the boot logo to come from a reserved memory region
  video: logo: add ppmtodtlogo host tool

 .../display/linux,boot-logo-clut224.yaml      | 152 +++++++
 MAINTAINERS                                   |   1 +
 drivers/video/fbdev/core/fb_logo.c            | 174 ++++++++
 drivers/video/logo/Kconfig                    |  13 +
 drivers/video/logo/Makefile                   |   6 +-
 drivers/video/logo/logo.c                     | 256 +++++++++++
 drivers/video/logo/ppmtodtlogo.c              | 402 ++++++++++++++++++
 7 files changed, 1003 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
 create mode 100644 drivers/video/logo/ppmtodtlogo.c

-- 
2.39.5

