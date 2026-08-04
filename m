Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7DDC55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0AC010E127;
	Tue,  4 Aug 2026 20:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JLq8Q9QQ";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E92110E127
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:56:23 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso1550515e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 13:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785876982; x=1786481782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hay/eMDbf3VXXM+6XzN2pJCbmyh5c1JHPJBtoOoDqDg=;
 b=JLq8Q9QQN7xvIYu+3sH5BpMT9XDeFniZtikG7ihPbkNoijv0gt6gVmQw7O0FSb9wQV
 JJ4O0dZhpR59DnQGoiEVpr3w0SGI5GSCeTtgj63AJNFnLrGD+EYIZidSCtxgtk8uUYKN
 vhujoNJgQTMGGLwAwAcdviXCuGnsXyEEltlMqo5GLt9ti/QO/hss43jXr2aP3DtyHoz3
 9ww8KOIUSO8z3d6SHAcAjHjXDCfD306mr1PdGLUlbmz0mA8HmNAh1VI1D734fkTkDerR
 TN9JtTo4+GwUheWMh+fmWaZX65qqAC0v6JiREUgZZCFsRqpcZ03ndrbpjEZTg17xQAyM
 RLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785876982; x=1786481782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hay/eMDbf3VXXM+6XzN2pJCbmyh5c1JHPJBtoOoDqDg=;
 b=jq+8IeDWFQkYqWpEy0q7au3ulO+XQTjlRFFr5Khkr0emJkGf4OSH4buUPKPODWxNQr
 /CKCqQDNeTS+NmnML3YOJgQXhFBHISZWwGGsts/FIH7BDIXK86zVhrwntH0UGv6U6hk9
 A7LTn5j0CICTX/+taIEt8iD96w6LWe3DPgBZ9BRJYNXNq+D3sMe6yws5nYIpS/ojU31Q
 jrr29THMEIjFQBNruZmtMQw1+cSGCsb1EzsYhuPcWidMXCItXj+lB9BFhdpTgBvu1fIj
 5o3NN4WUHe2LHv8yecHFBkIUyQ0g8oRYpPXSHO9uNStL2c3wlH2H66p6JFs8iU9M2M5G
 ExKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqUiUPE/qDisV204OhzUvctS8sj6JeozmoDqOGaRGPbflLT69NOVL9CSuEVAW+pIcCjD/vQhRLgwA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYBcT9VePR9KQ71VTiP2YsEG9SuRB3SJQOQPtXyL1KCH1Xvv/d
 YY7dzisoA+tMekbnVaTDpWgFqcKUadnkilsktyfzv/fMbow+fLDXpFvV
X-Gm-Gg: AR+sD137u5GKw0zFe1BbJd+EW1brqoYs0ALkLwjEo8EBqr6LwAiWgyof8qZOSYAr2X/
 cvmrHrCVJQAZtIm/vDbejrjzdOQYgXcdaIY1i4mhY7tgVGuTsDU/CqRk/PpWbiBcvkCNwlUT5ns
 EwajQuWOrgHxMLH1kW6LWKnkoB2mk+iJ25HcZcQ8G9RAp5SnCRDeGy1pOd22o7vV46vk7hr1U55
 4kTHNov4EPI/tooWTFt+aPJzuXisyBpUk12G1LGt84hTR0KESsyRePh/ga4NmjDcqSKW1787CyS
 ktoMOw9NvwjRgOkid8AW5DhUN5K6dxQhk+5KLhc3Wc2Zi+E7B6Bk9yHtsQ5PXu0vri+OUBp86fv
 nfCucAXdGX5Hy0wJUsuO7NC2ZTB7T5Lk1sQRO7D7VmYMB9v3oN57mPoGT5hBJ7p/GaDYP+PFfDj
 8OQRZFdLoIJpw2ljw42KVQNkOrDxA+HA5pTvEN5t847zCJ84vjfS9NmvJbSV4nNdEy04V+gjTEl
 cP7UbZCQESllBZBtCvOSXe8oBo=
X-Received: by 2002:a05:600c:3b18:b0:498:273:3271 with SMTP id
 5b1f17b1804b1-4994e72f648mr14489415e9.1.1785876981674; 
 Tue, 04 Aug 2026 13:56:21 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.176.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e4bf820sm12070645e9.0.2026.08.04.13.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 13:56:21 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v2 0/6] Boot logo supplied by the device tree
Date: Wed,  5 Aug 2026 00:56:11 +0200
Message-Id: <20260804225617.264861-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series lets the logo be described by the device tree instead: a node
compatible with "linux,boot-logo-clut224" under /chosen supplies the image in
the same paletted format the built-in CLUT224 logos already use, and the kernel
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

The v1 discussion turned on the obvious objection, that a bitmap is not
hardware and the device tree is not where it belongs. Geert pointed out that
configuration which is not hardware description goes under /chosen, and that
Open Firmware, which the device tree descends from, already carried a boot
logo in that spirit as the oem-logo variable under /options. The node has
moved to /chosen accordingly, which is also where simple-framebuffer nodes
live, for the same reason: they describe what firmware handed over rather
than what the hardware is.

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
16bpp, both ways round. A 160x120 logo placed with "logo-centered" plus a
"logo-offset" of <0 120> lands at exactly the expected coordinates, and every
pixel matches the source image once the source is truncated to RGB565.
Supplying the same image through a reserved region instead produces a screen
whose logo area is identical. Blobs with a bad magic, a geometry larger than
the reservation and an out of range pixel are each rejected with a warning
and fall back to the built-in logo, with no crash.

That boot test earned its keep: the first version of patch 3 drew the logo
correctly and then had it erased, because fb_prepare_logo() still reserved
only the logo's own height while the logo itself had been moved further
down. Nothing in the build or the static checks catches that.

Also boot tested on real hardware with this exact tree: an AM335x board
(tilcdc) with an 800x480 panel, running the master this series is based on.
The product logo comes up where expected both ways, carried in the device
tree and taken from a bootloader-loaded reserved memory region, with the node
under /chosen and nothing reported in either case. That system
builds without CONFIG_FRAMEBUFFER_CONSOLE, so the drawing there goes through
the separate drm_fb_helper hook mentioned above as not included; the parsing,
validation and placement exercised are those of this series.

Changes since v1:
  - Rebased onto Linus' master; v1 was based on the v6.19.14 stable release
    and did not apply anywhere useful. Sorry for the noise.
  - The node moved under /chosen, per Geert's observation that this is where
    non-hardware configuration belongs. The binding and the tool follow.
  - The binding notes that a product logo is normally covered by trademark or
    copyright of its owner and that such a device tree is expected to be kept
    with the product, after Ulrich raised the licensing angle.
  - Dropped the second binding example: with the node under /chosen both
    examples define /chosen/logo and dtc merges them, which then fails the
    oneOf. The reserved memory form is documented on the property itself.

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

