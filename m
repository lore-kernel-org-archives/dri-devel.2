Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715E3C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A49B10F16C;
	Wed, 23 Sep 2026 20:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hh6Yjd/z";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB9710F16C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:10:54 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso9629975e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790194253; x=1790799053; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xvoHV0YGRd2DvHEw1s5i4Tx9EoZPZBx4yBYx/JIF9lU=;
 b=Hh6Yjd/zlZEJL/cpGQ8X9iyh7o+k8lYqR3q1uzLrP8b6mSQHM/YTOnStL1m3dJBQi1
 eGomyapKedKu0XFcvljN7DmTedFTuHjPLz4jKbxrRdgJ3oXjaKVCown2GtuJ0o5dIzGx
 p88yTgFGBQ7pJ0Todi98uvw0l0QHCaJ1OoIAKMSU++H+GiLR1dHTJ4iuemjmKLeNfwaf
 qDWbbMI3xbZz0Odk+eqZFG9ODDwqzaU4kxW6T38fz/6QrFJVud60toBHnK3YL5RdGTTz
 xDYj5doB2CD+2U5YmdG6S8qKtgDVwC6fVMd7fUtizHJrGcE62fFCrtNzszDiOIOARo70
 pCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194253; x=1790799053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xvoHV0YGRd2DvHEw1s5i4Tx9EoZPZBx4yBYx/JIF9lU=;
 b=q2guUmqizCAhMsHlJzSZPCneCfN2hfsqyhES6xUWjnBHUO23Mt2BCOUSZMYDsMAYdi
 Bb+oNwv+Tp2+/KyUwaZ0oyi3dBnOjqNKmKMyvhVwC3AQ/81RUKp/OG2ktyEb2I/tUOd1
 bLC9pj74/kPN3M9lwc78txY5IJ622KNgI2rFSbfMWRXyUj9YsS/PUAQ13vel+a/v2f1h
 lfdP9PGiim+J/2+vs54624t5eG/ATP0n8kwd7DI4SLBiXi9UA73fBUTyIX1HZiM0eOJC
 l1+z/Z89TFdrprg3VYmeTAuBidRd82DxxYT6H34evvrCsshlDMUdKiOUXjudbU2G2GMj
 NfZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwj7JXx6KXOtbjRUoXu4gWJndc2/Qcsxso7eBvUfWxMfVYQrJ3PxMjc1/7QfhvkfcvI+0oOT+6qlhM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mGVE0E3LynIfooL3s2o0i9Xf8jgA7uieJDF/RHd9ZoZGbwHiAc
 jzUhjS378avbETwL6pYIsRfEjOTgjuav+NrJ/Q9BezEU2L3GNdh3ZYrq
X-Gm-Gg: AYBFou2Txbd7N4kX1wML6JJzMLUuYa9qNQ8SC7YXtD5gc4mb9N/WrMCrL5+EzMA4nLv
 PHXWdH16CMLT10sjoASTyVXFu217Pjj2ZyrCOqmZgfyvGowHkMAH48SEb4LNXRls8jmj4eO88wf
 YAzI4Ufwzd/Tta/HZobuivdFPUf9dKbqdIWlAz2W+iengva7efD10M+QVnd/FzW8SvVqvPecu+Z
 Oc8bqkyEz5go1UwvoLUJJnOQo3I6ZGNsC0O2yWDPuXU2l9q2aN2VM7imdOxNbmUSXeWcEOPUR2U
 nZtoSHpOniO3dB0qclGaaiUkAh0E7oMKqRuSWISEohXzIoV1AcBE9CakNAc/bhCQP/VT7sbmNld
 N99hun7D1UiHzWyM7UXB1/6wZdjVwVAO9zaXva2hWECIoz2cPCJu/CUyNT/Fh6gJ7GwG9g2Bzlg
 c03XcE5frFY+xAqenHn67NTa9sZtMaj4H2MsmPLS8DbQUyb4nCF2y2sWSG4gYL+4REhr0v3BRsy
 Pgg7B26yEXE9kuPcQ4CCZNuSPZpfGThpGmY
X-Received: by 2002:a05:600c:5489:b0:49f:d71f:9a39 with SMTP id
 5b1f17b1804b1-49fe66c9ad8mr4896715e9.1.1790194252722; 
 Wed, 23 Sep 2026 13:10:52 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4c8dsm13559295e9.3.2026.09.23.13.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:10:52 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v3 0/7] Boot logo supplied by the device tree
Date: Wed, 23 Sep 2026 22:10:28 +0200
Message-Id: <20260923201035.51007-1-maximpedraza@gmail.com>
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

Embedded products routinely need their own boot logo. Today that means
pointing CONFIG_LOGO_LINUX_CLUT224_FILE at a different image, which bakes
it into the kernel image. Two products that share a board support package
but differ in branding therefore need two kernel builds, and rebranding an
existing product means rebuilding and requalifying a kernel for what is
purely a cosmetic change.

This series lets the logo be described by the device tree instead: a node
compatible with "boot-logo-clut224" under /chosen supplies the image in
the same paletted format the built-in CLUT224 logos already use, and the
kernel prefers it over the built-in ones when it is present and enabled.
If the node is absent or disabled, nothing changes.

The image can come from the node itself (patches 2-3) or from a reserved
memory region the bootloader filled in (patches 5-6), because the image
and its placement are independent axes of variation. One board sold to
several customers wants several device trees differing in the logo. One
customer with several products built on that board, with different panels,
wants the same logo placed differently on each: there the image belongs in
a shared binary and only the placement belongs in the device tree.

Patch 1 is a cleanup that stands on its own. fb_prepare_logo() works out
how many rows to keep clear for the logo and fb_show_logo_line() works out
where to draw it, and both open code the same decision; nothing makes them
agree, even though fbcon erases whatever falls outside the rows that were
reserved. It gives the position a structure of its own, in linux_logo.h,
with -1 on an axis meaning centre on that axis, so that fb_center_logo
becomes a value rather than a second code path and both callers share one
calculation. No functional change. The device tree placement in patch 4
then only fills the same structure in from the node, which is parsed in
logo.c next to the image that comes from it, so that everything that knows
the binding lives in one place and the frame buffer code only asks for the
result.

We have been carrying a cruder version of this downstream on an AM335x
product since 2020, across a handful of board revisions, and it has
removed a real maintenance burden for us.

Where this fits
---------------

There are already ways to get a picture on the screen early, and this does
not replace any of them. A bootloader splash handed over through a
simple-framebuffer node is the earliest of all. A userspace splash is the
most flexible, and is what most systems end up using. What neither covers
is the case where nothing initialises the display before the kernel does.

That case is not exotic. U-Boot's SPL can boot the kernel directly, and
display initialisation lives in U-Boot proper, which then never runs:
there is no splash to hand over and nothing for a simple-framebuffer node
to point at. Falcon mode exists to cut boot time, which is the same reason
one cares about how early the logo appears, so the two tend to arrive
together. Userspace is far too late to fill that gap: on the board I
tested, the kernel has the panel up at 3.2 seconds.

Rob Herring asked in v2 why a simple-framebuffer handover would not do,
and I answered that it did not work on our hardware. That was wrong, and I
am correcting it here: the node I had measured it with was incomplete, and
with a complete one it does work. What it does not do is help where there
is no splash to hand over in the first place, and it does not survive the
native driver.

simplefb registers fb0 at 1.79 seconds with the bootloader's image; tilcdc
initialises at 3.16 seconds, registers its own fb1 and reprograms the
controller to scan that buffer, which starts empty, so the screen goes
black. Nothing is evicted and nothing is cleared: the two frame buffers
coexist, and cat /dev/fb0 > /dev/fb1 brings the picture straight back. It
is only that nobody does it, and by the time anything could, userspace is
already up, which is the moment a splash was there to cover. With
simpledrm it does not even survive in memory, since it hands its clients
shmem buffers and blits them onto the firmware framebuffer, so the first
frame any client commits overwrites what the bootloader drew. A logo the
kernel draws itself has none of this: there is nothing to carry across.

Notes on the binding
--------------------

  - The compatible has no "linux," prefix. Rob asked why it was Linux
    specific, and nothing in the node is: it describes an image and where
    it goes, which any consumer can read. A bootloader drawing the same
    logo before the kernel starts is the obvious other one. The 224 is the
    palette limit of the format, which is what lets the kernel use the
    image the way it already uses its built-in logos, without converting
    it.
  - The palette size is derived from the length of the "clut" property
    instead of being a separate property, so it cannot disagree with the
    palette actually supplied.
  - "data" holds plain palette indices. The 32 entry offset the frame
    buffer layer reserves for the console is an implementation detail and
    is applied by the kernel.
  - "logo-position" takes -1 on an axis to mean centre on that axis, which
    is what fb_center_logo already meant. A boolean could only centre both
    axes or neither, and next to explicit coordinates it would have to
    override them silently.
  - "logo-rotation" turns the logo, not the screen. "logo-position" and
    "logo-offset" are screen pixels whatever the rotation says, and a
    quarter turn only changes how much room the logo takes up.
  - "logo-position" and "logo-offset" are spelled with the prefix because
    plain "position" and "offset" are already used elsewhere in the tree
    with an incompatible type, which dtschema rejects.
  - The reserved memory path takes a "memory-region" phandle rather than a
    bare address. The reservation is what makes the memory safe to read at
    all, and it is what gives the kernel a size to bounds check against.

The byte arrays are not written by hand: patch 7 adds ppmtodtlogo, a host
tool along the lines of the existing pnmtologo -- plain C, no
dependencies, no quantization of its own -- that turns a PPM image into
the node or into the memory region blob. It is what produced everything
tested below.

Until chosen.yaml knows about the node, dtbs_check rejects it on any board
that uses it: it allows only ^framebuffer under /chosen. I sent that one
line change as dt-schema pull request 204, and Rob closed it saying he
expects it is either not needed or will change, given this discussion.
That seems like the right order to me, so I am not asking for it again
here: once the shape of the binding is settled, the schema change follows
from it, and I will send it then.

On a system that has DRM but no frame buffer device, nothing draws the
logo at all: fbcon is what draws it today, and without it there is no
consumer. Showing it there needs an in-kernel DRM client, which I have
working on top of this series and will send separately. I mention it
because it is the reason the node is parsed in logo.c rather than in
fb_logo.c: the same node then puts the logo on the same pixel whichever of
the two draws it, rotated or not, which I checked on the same board.

Testing: built for arm with CONFIG_LOGO_DT_CLUT224 both enabled and
disabled, and each of the seven patches builds on its own, with the option
enabled from the patch that introduces it. Also built for x86_64 with
CONFIG_OF=n, where nothing is left unresolved and the placement data is
dropped from the image, and for powerpc Cell -- where SPU_BASE makes
CONFIG_FB_LOGO_EXTRA real -- to a linked vmlinux. No compiler warnings,
W=1 clean on the files touched, checkpatch --strict clean apart from the
MAINTAINERS reminder for the new tool, which the existing drivers/video/
entry already covers. A full dt_binding_check has one complaint for this
binding and none other in the whole tree: the chosen.yaml rejection
described above.

Boot tested under qemu-system-arm -M versatilepb with PL111 and fbcon, at
16bpp, over a 26 case matrix: absolute positions, per axis centring, all
four corners, offsets including negative ones, out of range values, the
three rotations, and each rotation combined with an offset and with an
absolute position, each compared pixel by pixel against the source image
rotated to match. A position out of range on both axes is clamped to the
corner, and the console text then overwrites the rows below what fbcon
reserved. Supplying the same image through a reserved region instead
produces an identical logo area. Blobs with a bad magic, a geometry larger
than the reservation and an out of range pixel are each rejected with a
warning, with no logo drawn and no crash.

Also boot tested on real hardware: an AM335x board (tilcdc) with an
800x480 panel at 16bpp. The product logo comes up where the node asks,
both carried in the device tree and taken from a bootloader-loaded
reserved memory region, and the two produce a frame buffer that is
identical byte for byte. Dumping /dev/fb0 and comparing it against the
source image, the logo lands on exactly the pixel the binding predicts:
16836 of 16836 pixels match, and one pixel of displacement in any
direction drops that to about 90%. With logo-rotation = "ccw" it lands on
the rotated position the same way, every pixel.

Changes since v2:
  - Rebased onto current mainline (v7.3-rc3).
  - Dropped the "linux," prefix from the compatible, and renamed the
    binding to match, per Rob.
  - A rotation asked for by the device tree now turns the logo and not the
    screen: "logo-position" and "logo-offset" stay in screen pixels, and a
    quarter turn only changes how much room the logo takes up. v2 fed the
    device tree rotation into the path fbcon uses for a rotated console,
    which places the logo in the console's own frame and maps the result
    back, so a vertical offset came out horizontal on a screen that was not
    rotated. Found by testing it on the panel. fb_rotate_logo() is split
    into the part that turns the image and the part that moves the
    placement, and the console path is unchanged.
  - The placement properties are read in logo.c, next to the image, and the
    frame buffer code only asks for the result, so that the binding is
    parsed in a single place.
  - Added patch 1, which pulls the logo position out into something both
    fb_prepare_logo() and fb_show_logo_line() share, after Helge pointed out
    that the placement patch was stamped in rather than merged with the
    existing code. That turned up a real bug: the reservation took the larger
    of the console position and the device tree one while the drawing took
    only the device tree one.
  - IS_ENABLED() instead of #ifdef, per Helge, so the code is compile checked
    whatever the configuration.
  - The device tree is read once, from fb_prepare_logo(), rather than from
    every accessor.
  - Dropped "logo-centered" for -1 in "logo-position", per Helge.
  - The position and offset are added in 64 bits and both are bounded in the
    binding; in int, a large pair from the device tree wrapped instead of
    landing against an edge.
  - The copy of the image is no longer freed from a late initcall, which ran
    before async_synchronize_full() and so could pull it out from under a
    display driver still probing. Pixels are allocated with kvmalloc().
  - The example declares compatible and model on the root node, and the
    binding no longer requires the image properties unconditionally, which
    made the reserved memory form unreachable. Both found by Rob's bot.
  - Extra logos are not drawn when the device tree supplied the logo; they
    stack up from an arbitrary point once it has been placed.


Max Pedraza (7):
  fbdev: describe where the boot logo goes in one place
  dt-bindings: display: add a device tree supplied boot logo
  video: logo: allow the boot logo to come from the device tree
  fbdev: honour the device tree boot logo placement properties
  dt-bindings: display: allow the boot logo in a reserved memory region
  video: logo: allow the boot logo to come from a reserved memory region
  video: logo: add ppmtodtlogo host tool

 .../bindings/display/boot-logo-clut224.yaml   | 161 +++++++
 MAINTAINERS                                   |   1 +
 drivers/video/fbdev/core/fb_logo.c            | 221 ++++++++--
 drivers/video/logo/Kconfig                    |  12 +
 drivers/video/logo/Makefile                   |   6 +-
 drivers/video/logo/logo.c                     | 332 +++++++++++++-
 drivers/video/logo/ppmtodtlogo.c              | 416 ++++++++++++++++++
 include/linux/linux_logo.h                    |  59 +++
 8 files changed, 1170 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
 create mode 100644 drivers/video/logo/ppmtodtlogo.c

-- 
2.39.5

