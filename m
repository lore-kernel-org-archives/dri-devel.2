Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20811C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B1710EF4C;
	Wed,  1 Jul 2026 12:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="j2orGYC5";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493C410EF52
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908461;
 bh=jjzPWz3DCQ2yOLeMg7giSlJjhdwPdQazv5DL60ryEvQ=;
 h=From:To:Cc:Subject:Date:From;
 b=j2orGYC5xgjKYv7lL7fesE53fmKPFHgsN/DeM7+EB+Aec6mt5ob+sf9zJwj7xx3oA
 FLjuujZSPYYaldkKCYWJ5Jf9Cdivn3MK0Orz+6Mrv/ZiiL490vt3Syl+uX0Tny3mWF
 d5w7CaV4UsnyqsH1rfbVoQudQw4XpGvmZDU6QOTA5L3x31d5VBVVzkeCZ9QHNqOFRY
 i9s33CI8Lfa+PhfgsG1mPlSjb7hjXWRLJurk1bVyfKKhKQktiY/0eLCcbq1Ew5zhq8
 dcJgOIhy0kD/zA42B9iH2habXzGBNhirYhfmS5AYUQTdNsm7HXQhMdnReEV0cKH/R8
 MkUZ3+rxkz4yQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D2F3B17E0857;
 Wed,  1 Jul 2026 14:20:59 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: [PATCH 00/42] drm/mediatek: The Huge Restructuring and MT8196 support
Date: Wed,  1 Jul 2026 14:20:15 +0200
Message-ID: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
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

Okay, yes, this is very big. :-)

This series "only" does two things:
 1. Restructures mediatek-drm to optimize components discovery,
    pipeline building, changes components relationship, and to
    make use new-style trigger-sources for MuteX, other than
    paving the way for *easily* adding support for up to 31
    concurrent display outputs (of which, 6-8 are realistic now
    with newer SoCs); and
 2. Adds support for the new DirectLink architecture and for most
    of the new Display Controller components found in newer gen
    SoCs, like MT8196.

Note that, mixed in all this, there are some changes to the mediatek
MMSYS driver: those *cannot* be performed separately, and *must* land
in the same moment as the other changes, as otherwise it's all going
to break.
That was unavoidable, unless adding another ~10 (big) commits to keep
support for old code while introducing the new (not devicetree, just
code, mind you!) which is, at this point, completely unnecessary and
just big noise for no reason.

The two soc/mediatek commits already have my Acked-by tag for them to
be picked by a drm maintainer instead.

Important summary done, let's go deeper!

(from mtk-mmsys new-style series, important context)
As of now, all of the components in MediaTek DRM, hence also in the
MMSYS driver, are thrown in a catch-all enumeration that does not
make any distinction between Type-Instance relationship, and it is
like so (mock-up names ahead):

DISPLAY_DITHER0
DISPLAY_DITHER1
DISPLAY_DSI0
DISPLAY_DSI1

... and so on.

Since the number of components is now becoming uncontrollably large,
the catch-all enumeration poses a big issue as the mediatek-drm driver
is allocating a huge array that will be only half full (optimistically,
because usually it's way less than half full) and with repeated ops
assignment for each and every instance of the very same Sub-IP,
effectively treating every instance of a Sub-IP like it is completely
different from one another (for example, like DSI0 and DSI1 are as
different as DITHER0 and DSI1).

This has to change. It had to change months ago, but now it has become
not only a maintenance burden, but also a... (sorry) big mess.

And well, that... especially looking forward to add support for newer
SoCs, using even more components in one pipeline, and using different
and newer components (of new types...), making the catch-all enum to
grow of another ~20 entries or more.
(end of context paste)

This is the reason why the mediatek-drm driver now structures the HW
components in a different way, and specifically, it now makes a clear
distinction between HARDWARE TYPE and HARDWARE INSTANCE ID.

With this distinction is done, it also made sense to change the highly
unoptimized array search with a hashtable, making the entire components
discovery process faster (with or without MT8196 support), while using
less memory (compared to if this driver had MT8196 support without the
restructured code).

Moreover, the mediatek-drm driver now supports dynamic selection of the
DMA device, the VBLANK component and of the CONFIG component, necessary
for Multi-Controller Display Path (with DirectLink) architecture of new
SoCs (like MT8196), and also makes it possible for slightly older ones
to use multi-controller paths (though very restrictive due to the actual
hardware support).

Moving on to the MT8196 specific support...

This adds knowledge to mediatek-drm and hence introduces support for
the new concept of "Layer Stages", seen in MT6991/93, MT8196/8894 and
other new SoCs, where each (one) full layer is now composed of multiple
different hardware IPs and where, depending on the usecase (which is
BOARD specific!!!), can be set to have less, or more, capabilities in
terms of number of Blending stages, number of DMA stages, etc, so that
one board may choose to have up to 6-8 display outputs featuring lower
resolution displays, or 2-3 outputs supporting high resolution with high
framerates (like 4k120, 8k60 etc).

This also restructures the MediaTek DPI driver to be split in a common
library and HW version specific drivers, and on the base of this, adds
support for the new MediaTek Display Video Output (DVO) hardware, being
a revised and extended version of the previous DPI one.

Moreover, adds support for the Extended DMA (exDMA), Blender and Output
Processor engines, providing single stages of layers and forming one
layer when chained together.

More new-gen components include the 2D Sharpness Processor (TDSHP) and
the Display Image Resizer (effectively, a Scaler engine).

This also adds support for the Asynchronous DirectLink Controller, or
"DL_ASYNC", responsible for internally connecting different display
controllers to finally form one (or multiple) display path(s), which
may include a relatively infinite (real, and full) display controller
jumps or even intertwining (where jumps are fully supported in this
version of the driver, but intertwining is only partially supported).

In the case of paths using multiple display controllers, this is now
automatically calculating the order of those, important not only for
power management, but also for actually setting them up.

There's more to say, but this cover letter is already way too long now
so, well, if you want to know more about this, please the description
in the relevant commit from this series and feel free to ask for any
clarification.


All of this was manually tested on multiple MediaTek boards, both the
reference ones and partner boards, and that includes:
Acer Chromebook Elm (MT8173)
Acer Chromebook Corsola Steelix (MT8186)
Acer Chromebook Asurada (MT8192)
Acer Chromebook Cherry Tomato (MT8195)
Acer Chromebook Rauru Hylia (MT8196)

MediaTek Genio 510 EVK (MT8370)
MediaTek Genio 700 EVK (MT8390)
MediaTek Genio 1200 EVK (MT8395)
Radxa NIO-12L (MT8395)

Note: with this series, MT8196 support reaches a 95% done state for
DSI or eDP outputs, but needs some more code to work; the test that
was performed on the Hylia Chromebook had the rest of the required
code in place: said code is not perfectly clean yet and was not sent
for this exact reason. Cleanups to the remaining MT8196 code will
not change anything of what is introduced with this patch series.

AngeloGioacchino Del Regno (39):
  drm/mediatek: Move mtk_ddp_comp_type enumeration to mtk-mmsys.h
  drm/mediatek: Rename all display component type to have DISP_ prefix
  drm/mediatek: Use hashtable for components discovery and registration
  drm/mediatek: ddp_comp: Move internal component register in function
  drm/mediatek: De-duplicate internal component checks
  drm/mediatek: Introduce and use path/comp definition structures
  drm/mediatek: Create new mtk_drm_legacy and move deprecated code
  drm/mediatek: Add support for MuteX trigger-sources parsing
  drm/mediatek: ovl_adaptor: Add special MERGE component check
  drm/mediatek: mtk_hdmi_v2: Don't warn on RPM active during detach
  drm/mediatek: Add support for hardware multi-stage layers
  drm/mediatek: mtk_crtc: Complete documentation for struct mtk_crtc
  drm/mediatek: mtk_crtc: Minimize spinlocked time in cmdq callback
  drm/mediatek: mtk_crtc: Dynamically find vblank/cfg component indices
  soc: mediatek: mtk-mmsys: Migrate to new Multimedia DDP HW indexing
  drm/mediatek: Fully migrate to new Display Controller HW indexing
  drm/mediatek: mtk_dpi: Pass parameters with new mtk_dpi_sync structure
  drm/mediatek: mtk_dpi: Fully separate HW setup from common code
  drm/mediatek: Create new mtk_dpi_common lib and move mtk_dpi code
  dt-bindings: display: mediatek: Introduce Digital Video Output HW
  drm/mediatek: Add support for MediaTek Digital Video Output (DVO)
  drm/mediatek: Pass mtk_ddp_comp in clk and config callbacks
  dt-bindings: display: mediatek: Introduce MT8196 Layer Blender
  drm/mediatek: Add support for Display Layer Blender component
  dt-bindings: display: mediatek: Introduce MT8196 extended DMA Engine
  drm/mediatek: Add support for Display Controller exDMA component
  dt-bindings: display: mediatek: Introduce MT8196 Output Processor
  drm/mediatek: Add support for Display Output Processor component
  drm/mediatek: mtk_crtc: Dynamically find suitable CRTC DMA device
  drm/mediatek: Prepare path builder for multi-controller architecture
  drm/mediatek: Enable bring-up of multi-controller CRTC paths
  drm/mediatek: Introduce MediaTek Asynchronous DirectLink Controller
  drm/mediatek: Support registering disp controller device subnodes
  soc: mediatek: mtk-mmsys: Populate multimedia subsystem subdevices
  dt-bindings: display: mediatek: Introduce MT8196 2D Sharpness
    Processor
  drm/mediatek: Add Two-Dimension Sharpness Processor (TDSHP) driver
  dt-bindings: display: mediatek: Introduce MT8196 Image Resizer
  drm/mediatek: Add support for Display Image Resizer (Scaler)
  drm/mediatek: mtk_drm_drv: Fail init only if all paths are invalid

Nancy Lin (1):
  drm/mediatek: Export OVL formats definitions and format conversion API

Paul-pl Chen (2):
  drm/mediatek: Rename OVL format naming
  drm/mediatek: Export OVL Blend function

 .../mediatek/mediatek,mt8196-blender.yaml     |   97 ++
 .../display/mediatek/mediatek,mt8196-dvo.yaml |  142 +++
 .../mediatek/mediatek,mt8196-exdma.yaml       |  104 ++
 .../mediatek/mediatek,mt8196-outproc.yaml     |  107 ++
 .../display/mediatek/mediatek,mt8196-rsz.yaml |   97 ++
 .../mediatek/mediatek,mt8196-tdshp.yaml       |   98 ++
 drivers/gpu/drm/mediatek/Makefile             |    8 +
 drivers/gpu/drm/mediatek/mtk_crtc.c           |  978 ++++++++++----
 drivers/gpu/drm/mediatek/mtk_crtc.h           |    4 +-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       |  457 ++++---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       |  145 ++-
 drivers/gpu/drm/mediatek/mtk_disp_aal.c       |   12 +-
 drivers/gpu/drm/mediatek/mtk_disp_blender.c   |  318 +++++
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c     |   12 +-
 drivers/gpu/drm/mediatek/mtk_disp_color.c     |   12 +-
 .../gpu/drm/mediatek/mtk_disp_directlink.c    |  434 +++++++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  158 ++-
 drivers/gpu/drm/mediatek/mtk_disp_dsc.c       |    8 +-
 drivers/gpu/drm/mediatek/mtk_disp_exdma.c     |  344 +++++
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c     |   12 +-
 drivers/gpu/drm/mediatek/mtk_disp_merge.c     |   18 +-
 drivers/gpu/drm/mediatek/mtk_disp_outproc.c   |  247 ++++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  274 ++--
 drivers/gpu/drm/mediatek/mtk_disp_ovl.h       |   27 +
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  182 ++-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |   21 +-
 drivers/gpu/drm/mediatek/mtk_disp_tdshp.c     |  167 +++
 drivers/gpu/drm/mediatek/mtk_disp_wdma.c      |   14 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  760 ++---------
 drivers/gpu/drm/mediatek/mtk_dpi_common.c     |  473 +++++++
 drivers/gpu/drm/mediatek/mtk_dpi_common.h     |  299 +++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 1121 ++++++++++-------
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   34 +-
 drivers/gpu/drm/mediatek/mtk_drm_legacy.c     |  879 +++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_legacy.h     |   37 +
 drivers/gpu/drm/mediatek/mtk_dvo.c            |  682 ++++++++++
 drivers/gpu/drm/mediatek/mtk_dvo_regs.h       |  192 +++
 drivers/gpu/drm/mediatek/mtk_ethdr.c          |   10 +-
 drivers/gpu/drm/mediatek/mtk_ethdr.h          |    4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c        |    2 -
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |    8 +-
 drivers/gpu/drm/mediatek/mtk_padding.c        |    8 +-
 drivers/soc/mediatek/mtk-mmsys.c              |  111 +-
 drivers/soc/mediatek/mtk-mmsys.h              |   14 +-
 include/linux/soc/mediatek/mtk-mmsys.h        |   56 +-
 45 files changed, 7279 insertions(+), 1908 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-blender.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-exdma.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-outproc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-rsz.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-tdshp.yaml
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_blender.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_directlink.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_exdma.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_outproc.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_ovl.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_tdshp.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dpi_common.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dpi_common.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_legacy.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_legacy.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dvo.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dvo_regs.h

-- 
2.54.0

