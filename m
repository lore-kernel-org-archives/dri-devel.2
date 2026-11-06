Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C5606D811
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S8JDcFy/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F6510E9C1;
	Fri,  6 Nov 2026 02:34:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAFFD10E9C1
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 02:34:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6530943C1E;
 Fri,  6 Nov 2026 02:34:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793932485;
 b=qKsM0oCzLHMsEMi+yrKEeL5eLyReefFP2AvQaavT6b6/8dIS1DtKEHJACYVPw0g7hUnB
 Cq35OWPWiNwqzS9DER4DFRpnEMwur5/Y+nqxF0xSftIAj6A+wxqdix6/xcMBYfxf/fGEp
 dGUYb/Jj9ReCP71oZPTGTgAcwGFoJJA0A78SV/tH8yRnjZS+Kg6/97iRhfUSMo8tO5zD3
 9lWW+uIzQWMGFpbvnBFz3Ass19mNJ6oRnERLfNyJxfcTSXfmUR1PFrd9F6Zv9DaibJf2a
 JZxPaUQTbxr4KyXMg6ohlDqt51SEiwIGPyqdb1+QtW/1BuSf/I2NWLTcTMxoPxIz83Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793932485;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=c19Lu+c4fJRiA/nlxBTG4fS9ydGJz71G0vCMsc6bU8E=;
 b=ujsAStN1xJU07Pw2p4j5oQo7Q4T9b4sXb7nTf35ED5Tm4NHdlF8K4l52JnxTdQUtfxKO
 6VwgQr7djl0uH4kdaPohrODfjr1cgeBIvAkenJ8nLNLnLcVrpXIDiEcGtmBQoa1BZZRP+
 WzNw4RWQ+rZMsAeVtVFCv90Pi8huVi7iGYiE+bLzDzYB/++mjBffwCWDJvoMTcb3GpcwL
 XfaeFPJysANC1TIw/4I67NOjLsLfHO6125apdheRHVjUr0g3rhsGGecytOXNO9lbkD/VN
 tppBBLNhdUHU7ZEuvUvzZcT5aetehm5+PuqfhvLxiBIh1+ofh4oUx+wUIG7iprIDdBg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 70DB51F008A1;
 Fri,  6 Nov 2026 02:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793932485;
 bh=c19Lu+c4fJRiA/nlxBTG4fS9ydGJz71G0vCMsc6bU8E=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=S8JDcFy/HyXzXijfqCMkXycNNr2n4gR6O971SqSXYN9zuiK8hPusd9uvy/PZdMqA3
 /aMWK8jzwit0PetFN6IVElYkmAUmp/PIT/3/wxGlO3wC31XpRzihtoShr+ifs97+cY
 GEyIlAFT517/+cqQn8IfnIVcXy3PcEP6DSawhw2Ys75UhbxyjrGwnSihJOmRBtx1CP
 SESwn3AKBZZ1Hzsp2QPHqFxLbNWUx3tG4PapV2CEuLPDqHj3nxdtOxrs2wBDv+8gHa
 XmA9Cw11WtrdtecDfoHfXGACdoSMzAYf7mnK7I2C1hOBUkRjPyhmqK8SgFSUZX9DxQ
 2hUNKJNeAoEkg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C5DE245B60;
 Fri,  6 Nov 2026 02:34:43 +0000 (UTC)
From: Angel Gabriel Crispin Valdivia via B4 Relay
 <devnull+angelcrispinvaldivia.gmail.com@kernel.org>
Subject: [PATCH RFC 0/4] drm: Add Fresco Logic FL2000 USB display driver
Date: Thu, 05 Nov 2026 21:34:32 -0500
Message-Id: <20261105-fl2000-upstream-v1-0-bb163ecb2309@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNT3bQcIwMDA93SguKSotTEXF3jtGSjVMM0A4MUIxMloK6CotS0zAq
 widFKQW7OSrEQweLSpKzU5BKQWUq1tQDUX/caeAAAAA==
X-Change-ID: 20261105-fl2000-upstream-3fc2e1f00d24
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Angel Gabriel Crispin Valdivia <angelcrispinvaldivia@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793932482; l=7669;
 i=angelcrispinvaldivia@gmail.com; s=20261106; h=from:subject:message-id;
 bh=o80ZlbLtqJbPPBYviaA46EomKJ04cMpSWmbMMVC7hWk=;
 b=VgHjT/VIfS6gH+mXP+xAAC/pqvVfOtq6y0GAKHzUkXTKsqQwTmFrQ/92tCN5Iy67byqDZxf5+
 tT9DB7xsCOnBWNNifu2+7NcCxEDoRF3MXRkAsDq5/2QS/0/wt5/IGwS
X-Developer-Key: i=angelcrispinvaldivia@gmail.com; a=ed25519;
 pk=80bQU/p2R0pLIfdfJaB5I/2obI+RxQHondq5DEM0tbg=
X-Endpoint-Received: by B4 Relay for
 angelcrispinvaldivia@gmail.com/20261106 with auth_id=1425
X-Original-From: Angel Gabriel Crispin Valdivia
 <angelcrispinvaldivia@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: angelcrispinvaldivia@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series adds a DRM driver for USB display adapters built around the
Fresco Logic FL2000DX (USB ID 1d5c:2000). These are sold under many
brands as cheap USB 3.0 to VGA/HDMI dongles; the HDMI variants pair the
FL2000 with an ITE IT66121 HDMI transmitter on the FL2000's I2C bus.
Today these adapters only work on Linux with out-of-tree drivers.

The driver started as Artem Mygaiev's out-of-tree fl2000_drm driver,
itself partly based on Fresco Logic's reference driver; their copyright
lines are kept. I ported it to current kernels, fixed the problems found
on real hardware (EDID, bridge lifetime across USB resets, crashes on
disconnect, frames that were never terminated, imported buffers read
from the wrong VRAM), added the analog VGA output and cleaned it up for
submission.

I intend to maintain this driver for the long term: patch 1 adds a
MAINTAINERS entry with me as maintainer, I have the hardware to test
on, and I will keep following review and bug reports on dri-devel.

The series builds the driver up in four steps, each of which compiles
on its own:

  1. USB driver, FL2000 register access (regmap) and I2C adapter
  2. IT66121 HDMI transmitter bridge, including the EDID fallback
  3. frame streaming over bulk URBs
  4. the KMS pipeline, which makes the display usable, including the
     analog VGA output of adapters that have both connectors

It is posted as an RFC because there are design points I would like
feedback on before doing the larger reworks:

1. IT66121 support. The series carries its own small IT66121 bridge
   (fl2000_it66121.c) instead of reusing drivers/gpu/drm/bridge/
   ite-it66121.c, because I could not find a way to use the in-tree
   driver on a PC: it depends on OF (x86 distribution kernels have no
   CONFIG_OF), reads bus-width and its next bridge through of_graph,
   requires a reset GPIO the FL2000 boards do not have, and DRM has no
   bridge lookup without OF. It also reads the EDID through its DDC
   engine, which on these boards is not connected to the monitor (the
   EDID is read with the FL2000 I2C engine instead).
   Reusing it would take converting ite-it66121 to the fwnode API with an
   optional reset GPIO, a fwnode-based bridge lookup in drm_bridge.c, and
   a small bridge of this driver providing the EDID. Is that the direction
   you would like, or is a private IT66121 bridge acceptable for a USB
   device like this one?

2. Hotplug. The bridge attaches with DRM_BRIDGE_ATTACH_NO_CONNECTOR and
   the HDMI connector comes from drm_bridge_connector. The bridge
   reports DETECT and EDID only: the IT66121 interrupt reaches the host
   through the FL2000 interrupt endpoint, which makes the driver send a
   hotplug event for the device, so there is no DRM_BRIDGE_OP_HPD and
   the connector is also polled. Would reporting HPD with
   drm_bridge_hpd_notify() from that path be preferred?

3. The FL2000 exposes three USB interfaces, and the state they share
   (regmap, I2C adapter, IT66121 client, component match) is kept as
   drvdata and devres of the struct usb_device rather than of an
   interface, so that it survives the unbind/rebind cycles of
   usb_reset_device(). Is there a better established pattern for a
   multi-interface device that needs this?

4. Pixel conversion. The stream converts with its own small line
   converters instead of drm_fb_xrgb8888_to_*(). The framebuffer is
   usually imported from the primary GPU and sits in write-combined
   VRAM; the format helpers read such I/O memory with memcpy_fromio(),
   which takes ~88 ms per 1080p frame, while drm_memcpy_from_wc() into a
   cached line buffer takes ~8 ms. The converters also apply the
   FL2000's 32-bit word swap and only touch the damaged rectangle of a
   shadow frame. Would a helper that reads its source through
   drm_memcpy_from_wc() be welcome, so this could go away?

5. VGA detection. The chip has a single monitor sense input, which on
   the adapter I have follows whichever monitor is plugged in, HDMI or
   VGA. The VGA connector therefore reports a monitor when the chip
   senses one and the IT66121 hot plug line is low, which means a
   monitor on VGA is not reported while one is on HDMI (clone mode
   needs video=VGA-1:e). Is this an acceptable way to do it, and is
   there a better signal I should look for in the chip?

The rest of the pipeline follows the current helpers: regular atomic
plane/CRTC/encoder objects with managed initialisation, a cursor plane
blended by the CPU, GEM SHMEM with shadow-plane access, the DRM vblank
timer (the FL2000 has no vblank interrupt) and fbdev emulation through
drm_client_setup().

Other known limitations: RGB565, used when the USB link cannot carry
RGB888 (2560x1080 on USB 3.0, 640x480 on USB 2.0, as there is no
compression), has not been tested on hardware; and adapters with a VGA
connector only, without an IT66121, are not supported: the analog output
is only added next to the HDMI one.

Tested on x86_64 (amdgpu laptop, GNOME Wayland) with a UGREEN USB 3.0
adapter with HDMI and VGA connectors: a 1920x1080 monitor on HDMI, and
an old 1366x768 monitor without a usable EDID on VGA. EDID, mode
setting, the desktop and the cursor work, at 59 frames per second on
the link.
Every patch builds without warnings with W=1 on top of drm-misc-next,
sparse is clean, and the series passes checkpatch --strict.

Tool use, as described in Documentation/process/generated-content.rst: I
used an AI coding assistant (Claude Code with Anthropic Claude models)
extensively while preparing this series. It helped port the driver to the
current APIs, clean it up to kernel style, write the shadow-frame
streaming and the cursor plane, track down and fix the hangs on unplug,
and draft the commit messages and this letter. I reviewed the result and
tested it on the hardware described above; the Signed-off-by lines are
mine. The series was generated and checked (per-patch builds, checkpatch)
by scripts in the out-of-tree repository this driver is developed in.

---
Angel Gabriel Crispin Valdivia (4):
      drm/fl2000: Add USB driver with register and I2C access
      drm/fl2000: Add ITE IT66121 HDMI transmitter support
      drm/fl2000: Add frame streaming
      drm/fl2000: Add KMS display pipeline

 MAINTAINERS                                  |    7 +
 drivers/gpu/drm/Kconfig                      |    1 +
 drivers/gpu/drm/Makefile                     |    1 +
 drivers/gpu/drm/fl2000/Kconfig               |   19 +
 drivers/gpu/drm/fl2000/Makefile              |   13 +
 drivers/gpu/drm/fl2000/fl2000.h              |  192 +++++
 drivers/gpu/drm/fl2000/fl2000_drm.c          |  986 ++++++++++++++++++++++++
 drivers/gpu/drm/fl2000/fl2000_drv.c          |  281 +++++++
 drivers/gpu/drm/fl2000/fl2000_i2c.c          |  182 +++++
 drivers/gpu/drm/fl2000/fl2000_interrupt.c    |  237 ++++++
 drivers/gpu/drm/fl2000/fl2000_it66121.c      | 1030 ++++++++++++++++++++++++++
 drivers/gpu/drm/fl2000/fl2000_it66121.h      |   19 +
 drivers/gpu/drm/fl2000/fl2000_it66121_regs.h |  283 +++++++
 drivers/gpu/drm/fl2000/fl2000_registers.c    |  320 ++++++++
 drivers/gpu/drm/fl2000/fl2000_registers.h    |  272 +++++++
 drivers/gpu/drm/fl2000/fl2000_streaming.c    |  993 +++++++++++++++++++++++++
 drivers/gpu/drm/fl2000/fl2000_vga.c          |  256 +++++++
 17 files changed, 5092 insertions(+)
---
base-commit: 41ecf852c07391687beb129e12a231760b5d783f
change-id: 20261105-fl2000-upstream-3fc2e1f00d24

Best regards,
--  
Angel Gabriel Crispin Valdivia <angelcrispinvaldivia@gmail.com>


