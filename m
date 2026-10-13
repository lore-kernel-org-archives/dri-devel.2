Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824A9CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25DC10F66F;
	Tue, 13 Oct 2026 09:32:55 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6982810F66F
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:32:50 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-487049569b6so1892076f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791883969; x=1792488769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rrwyteEkSmVugKNDSB7rq3Nq/U0fxherldXaw1AGqq8=;
 b=SPFE17xj4Fe23kkO4vz8Kmzj/j1bPzKfZchDjAAf9DvM0rDbi4piS6CBtbA6hh8da1
 V6+FWBfNNYy/AvxieQdfYoHRaeWA4I3DGGQt1sqwLc84upa/643bufYJDtfw6Uv4Mcug
 WCT5FdAFrCdTDiSU8MIfrXqyAkAmrOvG5rwZ1MNGXqszdYdKyXTo9k1Msy0cqu3hzWPs
 NXurn+DXzOruqjC7zxYcDvT3DpFLo/qzDOxOwMbpvkvWLszOdnd1KLYOt6XTru1KrPv7
 39AuHkdWd8TnmbjP2qZRPUVA+Tfnnpi3HBAO1NAgbUzgrMMj9P/EYT6zNg33eqadqpfw
 ErnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883969; x=1792488769;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rrwyteEkSmVugKNDSB7rq3Nq/U0fxherldXaw1AGqq8=;
 b=pbsIfPkcYZDl488aDerG38OF3T2gJuqSxGbK0N62GHsSNQEZfdu5sryKRgkGKcYowP
 3TAQHkbJWzA15Fpm8xhSUQTOaczdjY3y9NSIgC+PJbYTtrSnQUxEtiKnWBosBm2ACLff
 KIbXCS22YTAg+L26Fysb6+s6PCZ7zLdp7cJRBZVNMHhaMiGEKF3vJLV1Zl51rOI3+dvk
 GjU3cHC4AK0KJ9HsED2/FNM3T9/JDOn9iy+F4nUeQGcL4EvsoVGkQ/WjqMiPy0bTrdPl
 FbfntNksiAXpApRnKFKtlwPRXNDnrz5POAWjFKyJWwMtAHA6/NOVrU1lClBJQuOCw1f0
 L5fQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuv6jbDVI+P9jvxqPXV9RYVTcIcn0rHUH8tbLHOrUyG5wxYICov0Z7EGorIYabmjSLDjHWznyqW+4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ7PyG1GSV6++FAeP9wU5wfxExq5LNuUS0OlvLZILWq7RLYiiL0
 tzxzgM0l91hduOK5dLpcE3LLV1/j10hbuhai+4TjAH4Of6/z0AcfXF/H
X-Gm-Gg: AYBFou2Vfk+MOXEEXzKvTiMCZyzdbWmv1bwjKiWwNZ0NI9L5Czy/TItu7E2rJkJvfLx
 5qKKoe4sad4uFnyZ1+06VbQ0pthLRY/SgAWXfjyVRajEIuXa2jOTwZLPiHWdaWD0JXhQ75l8J0c
 HyMUN+CUo7s+ijmzB5Ic3iz6R5FL2JX0g/QU+fHK8G037kw/FgOxHJ7Ozx9X06QtjkNCom7lNIz
 C86Q/RfififdQpupczZDMnZ06iCtsp/tmZsifycvsglFWu9kE+WVSU/SgJf/1GCsK5ak5+R6qDl
 Rvw37TWrtsin7p/ZcdwmSeN4FxCZVDVcmeJTl+/7tmXutpTE0SLtQ9RbvtYDux+Z8bXBbEcVDQQ
 kChdykuVAbZXh5CwvcvM0DvuHRm0dPt50uyuTlxuRoD2HS+nsiX5Ztazo0x+54EHbCo+DiNTtln
 GqZ4oZU3mFVH17wqLTW0n4I/PcE858SBHifndUtrgkjYbxVwU0RSBfwKN8tBljwIrVS2a8MPVOF
 JVulhq9wfyb+/Wcc+eZTcvahxLthfXSUko=
X-Received: by 2002:adf:e009:0:10b0:48c:7dac:8957 with SMTP id
 ffacd0b85a97d-48dbacda6b7mr16184465f8f.32.1791883968322; 
 Tue, 13 Oct 2026 02:32:48 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ec6sm3986774f8f.48.2026.10.13.02.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:32:45 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/13] Add splash DRM client
Date: Tue, 13 Oct 2026 11:32:30 +0200
Message-Id: <20261013093243.505776-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is the fifth version of the splash client, which I took over from
Francesco with v4 [1]. The changes are the review of v4: the BGRT is now
read through accessors in efi-bgrt.c rather than exported data, as Jani
asked, and the issues sashiko found are fixed. Testing now also covers
several outputs, a tiled display, the error paths and Falcon mode.

Why this is in the kernel
-------------------------

Maxime asked in v1 why this should not be left to userspace or to the
bootloader. The cases it is for are the ones neither covers:

  - Nothing initialises the display before the kernel does. U-Boot's
    Falcon mode, meant to cut boot time, starts the kernel from the SPL
    and never runs U-Boot proper, where display support lives: there is
    no bootloader splash to hand over, and the device tree is the only
    thing that reaches the kernel. Userspace comes seconds later.

  - One kernel image for several products. An image built into the
    kernel, with CONFIG_EXTRA_FIRMWARE, means one kernel per logo, or
    every logo in every product's kernel, all of them staying in memory
    for good. Francesco described exactly this case in v2: one board
    support package for a family of devices, each with its own logo and
    background, picked by the bootloader.

  - A splash handed over from the bootloader does not always survive the
    native driver taking over the display.

Where the image comes from
--------------------------

In this order: a BMP named on the command line, the device tree, the
EFI BGRT, and "drm_splash.bmp" loaded as firmware; with none of them,
only the background is drawn.

The device tree node lives under /chosen (patch 6) and carries the BMP
either in the node, which dtc fills in with /incbin/, or in a reserved
memory region the bootloader loaded it into. The region keeps the image
out of the device tree, so that it can be changed from userspace by
updating a partition, as Francesco suggested. A node is only there if
someone put it there for that board, so it goes before the BGRT.

The command line wins over everything else, each parameter for its own
part only, as console= wins over stdout-path: splash_bmp (or "none"),
splash_color, splash_pos, splash_offset and splash_rotation. Without it
a BMP loaded as firmware could be neither placed nor turned, and it lets
a placement be tried without rebuilding a device tree.

Placement uses a position with -1 centring an axis, plus an offset, in
screen pixels. A rotation turns the image and not the screen, counter
clockwise as for panels and as DRM_MODE_ROTATE_* count. A device tree
image is placed as its node says, a BGRT image at the table offsets, and
anything else is centred; placement given on the command line applies
whatever the source.

BGRT images with the ACPI 6.2 orientation bits set are no longer skipped
but turned (patch 11). I took the meaning of the bits and of the offsets
from Plymouth, the main user of the BGRT, so that the kernel and
Plymouth put the image in the same place and the handover does not
jump. I have not found the specification text to check against;
corrections are welcome.

Changes since v4
----------------

  - efi: bgrt: patch 2 adds accessors for the boot graphics instead of
    exporting bgrt_tab and bgrt_image_size, with stubs in efi-bgrt.h for
    CONFIG_ACPI_BGRT=n (Jani [2]); both variables are __ro_after_init
    (Ard [3]). Ard, this is the shape we discussed [4]: it is no longer
    the patch you acked, so I have not carried your Acked-by.
  - The client reads the BGRT through those accessors only, and drops
    its own wrappers, its stubs and the #ifdef around them; no "static
    inline" in drm_splash.c any more (Jani [5]).
  - Fixes from sashiko's review [6]:
    - when the render thread could not be created, the framebuffers
      were freed but the modesets still pointed at them, and the next
      restore committed them: a use-after-free that closing the last
      DRM file is enough to trigger;
    - when no buffer could be created, the scanouts were not freed, and
      a later restore committed a mode without a framebuffer;
    - a BMP loaded as firmware that arrived after the render thread had
      left (another master took over) was kept until unbind; it is now
      released when it arrives.
  - The binding and the documentation now ask a bootloader that loads no
    image into the reserved region to disable or remove the node, rather
    than to clear the region, which left the kernel an invalid image to
    complain about on every boot (sashiko [7]).
  - Dropped the RFC tag: v4 drew no objection to the approach, and I
    consider the series ready to be applied.

Changes in v4
-------------

Fixes to Francesco's patches, folded in and listed in the commit notes;
most of them were also in sashiko's review of v3 [9]:

  - the render thread stayed in TASK_UNINTERRUPTIBLE for good when the
    BMP firmware was missing (hung task warning), could miss a wake up,
    and kthread_stop() was called on a thread that had already exited
    (use-after-free), never existed or failed to start;
  - a use-after-free on unbind: the image was released after
    drm_client_release(), which frees the client;
  - a use-after-free in the firmware callback when the device goes away
    first, as the request cannot be cancelled; unregister now waits;
  - the BMP bounds check could overflow and let a crafted bitmap offset
    read 4 GiB away;
  - the 24 bit blitters read a byte past the image;
  - buffers went to the wrong modesets when one was skipped, tiled
    groups dereferenced a buffer before creating it and swapped width
    and height, a failed dumb buffer left an ERR_PTR behind, and the
    modeset list was walked without modeset_mutex;
  - the BGRT symbols are exported (Mario's report [10]), GPL only;
  - the DRM_CLIENT_DEFAULT entry is indented with tabs (patch 1).

Additions: the device tree source and its binding, placement, rotation,
the background colour following the image, BGRT orientation, the
command line parameters, and the documentation.

Testing
-------

  - QEMU versatilepb (pl111, 16 bpp): 39 cases for the device tree
    source (inline and region, invalid nodes, placement, clamping,
    rotations, rows with and without padding, backgrounds), plus 17 for
    the command line and the order of the sources, each compared pixel
    by pixel.
  - QEMU virt arm64 (virtio-gpu, 32 bpp) with KASAN, with the BMP loaded
    as firmware from an initramfs and the driver unbound afterwards: no
    reports, also with a crafted bitmap offset and with the firmware
    arriving only after the unbind (sysfs fallback).
  - Several outputs, on virtio-gpu with two heads: with the first output
    off and the second on, v3 put the buffer on the dead output and left
    the live one blank; now the splash is on the live one.
  - A tiled display, simulated by forcing on two virtio-gpu heads EDIDs
    with a DisplayID tiled topology block (2x1 tiles of 1024x768): one
    2048x768 buffer, the image centred across both tiles; v3 oopsed on
    such a display.
  - The error paths sashiko pointed at, with a debug patch forcing them:
    without the fix, a failed thread creation followed by a restore gives
    KASAN use-after-free reports, and a failed buffer creation a WARN in
    the atomic code; with it, neither.
  - x86-64 with OVMF for the BGRT through the new accessors, including
    forced orientation bits, and drm_client_lib built as a module.
  - An AM335x board (tilcdc, 800x480 panel of which only the bottom 297
    lines are visible, 16 bpp), booting over TFTP and NFS: 27 cases,
    plus 9 with the BMP loaded as firmware from an initramfs, checked
    by reading the scanout buffer back through /dev/mem.
  - The handover on the same board, with the product's Qt5 application
    drawing through EGLFS and the SGX GPU: it takes the display straight
    from the splash, and when it exits the splash is restored, pixel for
    pixel.
  - Falcon mode, on an AM335x board booting from NAND: the SPL starts
    the kernel directly, with the device tree appended to it and the
    image inline in the node, and U-Boot proper never runs. The splash
    comes up as the node asks, checked pixel by pixel.
  - W=1 and sparse clean; every patch builds on its own on arm and
    x86-64; checkpatch --strict clean apart from a quoted modpost line
    and the MAINTAINERS reminder answered by the next patch;
    dt_binding_check clean for the binding.

Not tested: a BGRT with orientation bits from real firmware.

Open questions
--------------

  - Rob: how the image should be described, a BMP in a property or raw
    pixels described like simple-framebuffer [8]. The binding here uses
    the BMP; the client would need a second drawing path for the other.
  - Once the binding settles I will send the dt-schema change that lets
    the node live under /chosen; until then dtbs_check flags it.
  - The splash is a DRM client, so a device using it has no fbdev
    emulation and no /dev/fb0. That rules it out where userspace still
    draws through fbdev.

Based on drm-misc-next as of 2026-10-12 (725953d4da85).

[1] https://lore.kernel.org/all/aryqYhHqFk3cXh9d@bywater/
[2] https://lore.kernel.org/all/5c92c6f27b0778124d2365603374f70bd9b69b8d@intel.com/
[3] https://lore.kernel.org/all/001eb42a-ec22-474a-83c6-371f1f4b2b8c@app.fastmail.com/
[4] https://lore.kernel.org/all/9cf259a5-6083-433c-8544-ca3f6286334e@app.fastmail.com/
[5] https://lore.kernel.org/all/1800459b75ea057c42f8c601a09646cca938b3db@intel.com/
[6] https://lore.kernel.org/all/20261002091339.B64EB1F00893@smtp.kernel.org/
[7] https://lore.kernel.org/all/20261002091338.E12D61F000FF@smtp.kernel.org/
[8] https://lore.kernel.org/all/CAEUXW=Gh6wMk1i=x_KT0eSdkHeHs8Hkxkj4hfsuTRyY6=aphpw@mail.gmail.com/
[9] https://sashiko.dev/#/patchset/20260510-drm_client_splash-v3-0-a9aee9f0b2fc%40valla.it
[10] https://lore.kernel.org/dri-devel/5d7067de-97b7-4232-9cf6-e4b978696482@amd.com/

v4: https://lore.kernel.org/r/20261001195847.141192-1-maximpedraza@gmail.com
v3: https://lore.kernel.org/r/20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it
v2: https://lore.kernel.org/r/20260106-drm_client_splash-v2-0-6e86a7434b59@valla.it
v1: https://lore.kernel.org/r/20251027-drm_client_splash-v1-0-00698933b34a@valla.it

Màxim

Francesco Valla (3):
  drm: client: add splash client
  MAINTAINERS: add entry for DRM splash client
  drm: docs: remove bootsplash from TODO

Màxim Pedraza Padilla (10):
  drm/clients: Kconfig: indent DRM_CLIENT_DEFAULT with tabs
  efi: bgrt: add accessors for the boot graphics
  dt-bindings: display: add a boot logo node under /chosen
  drm/client: splash: add a device tree image source
  drm/client: splash: place the device tree image where it asks
  drm/client: splash: turn the device tree image as it asks
  drm/client: splash: take the background colour from the image source
  drm/client: splash: turn the BGRT image on panels mounted turned
  drm/client: splash: prefer what the command line asks for
  drm/client: splash: document the image sources and parameters

 .../bindings/display/boot-logo.yaml           |  151 ++
 Documentation/gpu/drm-client.rst              |    6 +
 Documentation/gpu/todo.rst                    |   17 -
 MAINTAINERS                                   |    9 +
 drivers/firmware/efi/efi-bgrt.c               |   74 +-
 drivers/gpu/drm/clients/Kconfig               |   91 +-
 drivers/gpu/drm/clients/Makefile              |    1 +
 drivers/gpu/drm/clients/drm_client_internal.h |    9 +
 drivers/gpu/drm/clients/drm_client_setup.c    |    8 +
 drivers/gpu/drm/clients/drm_splash.c          | 1465 +++++++++++++++++
 include/linux/efi-bgrt.h                      |   39 +-
 11 files changed, 1844 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/boot-logo.yaml
 create mode 100644 drivers/gpu/drm/clients/drm_splash.c


base-commit: 725953d4da85cfb97a4c309fad6346b72f8529e7
-- 
2.39.5

