Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50DFC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 849DF10E5A6;
	Fri, 14 Aug 2026 20:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cmE01wu/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D6F310E5A7
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786739761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XmXy8TGZMtUdUflzhbcwpO5PBzlQNsR1Xi5VVFI9N3E=;
 b=cmE01wu/y3fIwPnf+28+A3f615QjoCXrZ38KP8nhBUNv8vp79CBxsxY8ckaWQ5iLmc7mtS
 Am9NzlijryLZKC4KPfFYs0pMcxAQ2VT83f84qoV3BaZutpkCT2W8kSnmWnQ02skm1ijrC0
 cv1zbV4nE9WWiQajyNE26lC1gpdMtH8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-zePa_GbsMtmTsuH5SevbYw-1; Fri,
 14 Aug 2026 16:35:54 -0400
X-MC-Unique: zePa_GbsMtmTsuH5SevbYw-1
X-Mimecast-MFC-AGG-ID: zePa_GbsMtmTsuH5SevbYw_1786739751
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6B6219560AE; Fri, 14 Aug 2026 20:35:49 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 02CAB197750F; Fri, 14 Aug 2026 20:35:44 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 nouveau@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-sunxi@lists.linux.dev,
 asahi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-samsung-soc@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-mediatek@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 linux-aspeed@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-mips@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 imx@lists.linux.dev
Subject: [PATCH 0/5] drm/vblank: Enforce all-or-nothing vblank support
Date: Fri, 14 Aug 2026 16:35:28 -0400
Message-ID: <20260814203542.1405135-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: uxw0v163-G1HXIkgYBFXvTouim-8r_PHWX12YLQ_dSc_1786739751
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

One of the oddities with DRM that is leftover from the old days is how
vblank support is implemented by drivers. This has caused some minor
issues for the rust bindings for KMS which could be worked around.
However, it seems like a much better idea to fix this on the C side.
Those oddities are mainly:

* There's nothing in the vblank core that actually ensures that all
  CRTCs implement vblank support if one of them do. On Rust's side, we
  can't have this and have to ensure either the whole device has vblank
  support or not - otherwise it would be quite painful ensuring we don't
  expose vblank methods to drivers that can't use them.
  This additionally means such a situation would lead to UB.
* There is a second variable for keeping track of the number of CRTCs
  and it's kind of broken and confusing. Even worse, we currently allow
  the vblank API to allow a driver to specify a different number of
  CRTCs then it actually has.

So, let's just go ahead and fix this across the whole tree, and enforce
that a driver must either implement hardware vblank support for all
CRTCs or no CRTCs.

Lyude Paul (5):
  drm/vblank: Add drm_device.has_hw_vblank
  drm/vblank: Remove drm->num_crtcs
  drm/vblank: Remove num_crtcs argument from drm_vblank_init()
  drm/vblank: Use drm_for_each_crtc() in drm_vblank_init()
  drm/vblank: Require all CRTCs implement vblank support in
    drm_vblank_init()

 drivers/gpu/drm/adp/adp_drv.c                 |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  2 +-
 drivers/gpu/drm/arm/hdlcd_drv.c               |  2 +-
 drivers/gpu/drm/arm/malidp_drv.c              |  2 +-
 drivers/gpu/drm/armada/armada_drv.c           |  2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  2 +-
 drivers/gpu/drm/drm_vblank.c                  | 60 ++++++++++++-------
 drivers/gpu/drm/exynos/exynos_drm_drv.c       |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  2 +-
 drivers/gpu/drm/gma500/psb_drv.c              |  2 +-
 drivers/gpu/drm/gma500/psb_irq.c              |  4 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  2 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c   |  2 +-
 .../drm/i915/display/intel_display_driver.c   |  3 +-
 drivers/gpu/drm/imx/dc/dc-kms.c               |  2 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c           |  2 +-
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c      |  2 +-
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c           |  2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  2 +-
 drivers/gpu/drm/kmb/kmb_drv.c                 |  2 +-
 drivers/gpu/drm/logicvc/logicvc_mode.c        |  2 +-
 drivers/gpu/drm/loongson/lsdc_drv.c           |  2 +-
 drivers/gpu/drm/mcde/mcde_drv.c               |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +-
 drivers/gpu/drm/meson/meson_drv.c             |  2 +-
 drivers/gpu/drm/msm/msm_kms.c                 |  2 +-
 drivers/gpu/drm/mxsfb/lcdif_drv.c             |  2 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  2 +-
 drivers/gpu/drm/nouveau/nouveau_display.c     |  2 +-
 drivers/gpu/drm/omapdrm/omap_drv.c            |  2 +-
 drivers/gpu/drm/pl111/pl111_drv.c             |  2 +-
 drivers/gpu/drm/qxl/qxl_display.c             |  2 +-
 drivers/gpu/drm/radeon/atombios_crtc.c        |  4 +-
 drivers/gpu/drm/radeon/radeon_irq_kms.c       |  2 +-
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c   |  4 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c |  2 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |  2 +-
 .../gpu/drm/renesas/shmobile/shmob_drm_drv.c  |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  2 +-
 drivers/gpu/drm/sprd/sprd_drm.c               |  2 +-
 drivers/gpu/drm/sti/sti_compositor.c          |  2 +-
 drivers/gpu/drm/stm/ltdc.c                    |  2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  2 +-
 drivers/gpu/drm/tegra/drm.c                   |  2 +-
 drivers/gpu/drm/tidss/tidss_kms.c             |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |  2 +-
 drivers/gpu/drm/tiny/bochs.c                  |  2 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c            |  2 +-
 drivers/gpu/drm/tve200/tve200_drv.c           |  2 +-
 drivers/gpu/drm/vc4/vc4_kms.c                 |  6 +-
 drivers/gpu/drm/verisilicon/vs_drm.c          |  2 +-
 drivers/gpu/drm/virtio/virtgpu_display.c      |  2 +-
 drivers/gpu/drm/vkms/vkms_drv.c               |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c          |  2 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c             |  2 +-
 include/drm/drm_device.h                      | 10 +++-
 include/drm/drm_vblank.h                      |  2 +-
 64 files changed, 114 insertions(+), 92 deletions(-)


base-commit: 568d4cb5dcc5ec4e22975699b6ea67a30806884c
-- 
2.55.0

