Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48769C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D7E10E26D;
	Thu, 10 Sep 2026 14:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="lhokwLFO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EXHknNQA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Stw98jXk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yCeUDoHw";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD09210E00D;
 Thu, 10 Sep 2026 14:03:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D27421D15;
 Thu, 10 Sep 2026 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789049030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4n/fLMFAsNQH2e/B2AuZRWlQCHkEQfHSg1JNUPvxdLs=;
 b=lhokwLFOmgvekJu/TA2JDcaJaRvYPDPDJlR41Fsq/URjm4mrgEA1ck9e1/R+oMuebSroQc
 GKAu8/Xj0iCtYRp/wtAbsrGv8azU86mJun5Z0uIoHTjNI448/XK/sI/EDF0mgQn4EFpipu
 MBEWYOBd3GyUXD4c1DeVjVqlpcfR29c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789049030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4n/fLMFAsNQH2e/B2AuZRWlQCHkEQfHSg1JNUPvxdLs=;
 b=EXHknNQAEqiQBY+SkYuUvwo2KeT/7B12FkE0QzGrf0nOSrcPqmFRsypWJ+r8TFdq0DH6vF
 ucSb5AMV35LoBECA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789049026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4n/fLMFAsNQH2e/B2AuZRWlQCHkEQfHSg1JNUPvxdLs=;
 b=Stw98jXkULR1jx1FiPu+XQVi03/zl0yjNRuB2Qb5zwu7FCjOHYELIaX7RHXbZgjWrwDLRz
 +ny6ES2BgFxwBsQQr5kqRUnbgD6GNsMt53vvv08wn2dorHI9JqnQC6YnuaYZjS/6jhPXDG
 TuAA74qv47yozmUudy0wWTpsVLZHPEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789049026;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4n/fLMFAsNQH2e/B2AuZRWlQCHkEQfHSg1JNUPvxdLs=;
 b=yCeUDoHwLz79Jv0Cp8HHFs+Y2iX1xjClAF1AK6OGRhdsfke5YBdwJqzdTIv1b4USJwcy9m
 yD/DDZe3CEkaweCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96DB81326D;
 Thu, 10 Sep 2026 14:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HYbJF8G4omqVNgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 10 Sep 2026 14:03:45 +0000
Date: Thu, 10 Sep 2026 16:03:43 +0200
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org
Subject: [PULL] drm-misc-next
Message-ID: <20260910140343.GA404885@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 gitlab.freedesktop.org:url]
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

Hi Dave, Sima,

here's the week's PR for drm-misc-next. It's rather small with mostly bug
fixes. It feels more like a -fixes PR. :)

Best regards
Thomas

drm-misc-next-2026-09-10:
drm-misc-next for v7.4:

Cross-subsystem Changes:

firmware:
- sysfb: Remove obsolete quirk for Lenovo D330

sound:
- ti/omap: Fix build error

Core Changes:

edid:
- support detecting panel size from EDID

Driver Changes:

amd:
- display: Drop obsolete KUnit tests

bridge:
- analogix: Support eDP lane mapping
- ti-sn65dsi83: Support LVDS Channel B on SN65DSI84
- minor cleanups

gma500:
- avoid unsupported ARGB formats in primary plane

hibmc:
- handle vblank interrupts correctly

sysfb:
- fix panel orientation for non-native display modes
The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-09-10

for you to fetch changes up to 75ee88dae80d8c1141ef850bda9a26dbd1fe3c21:

  drm/sysfb: Use preferred panel size for panel orientation quirks (2026-09-10 15:44:52 +0200)

----------------------------------------------------------------
drm-misc-next for v7.4:

Cross-subsystem Changes:

firmware:
- sysfb: Remove obsolete quirk for Lenovo D330

sound:
- ti/omap: Fix build error

Core Changes:

edid:
- support detecting panel size from EDID

Driver Changes:

amd:
- display: Drop obsolete KUnit tests

bridge:
- analogix: Support eDP lane mapping
- ti-sn65dsi83: Support LVDS Channel B on SN65DSI84
- minor cleanups

gma500:
- avoid unsupported ARGB formats in primary plane

hibmc:
- handle vblank interrupts correctly

sysfb:
- fix panel orientation for non-native display modes

----------------------------------------------------------------
Damon Ding (5):
      dt-bindings: display: bridge: analogix-dp: Add data-lanes support for endpoint
      drm/dp: Add helper to validate DP lane counts
      drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties
      drm/bridge: analogix_dp: Add validation for samsung,lane-count property
      drm/bridge: analogix_dp: Add support for optional data-lanes mapping

Esben Haabendal (1):
      drm/bridge: ti-sn65dsi83: Support LVDS Channel B on SN65DSI84

Krzysztof Kozlowski (1):
      drm/bridge: lontium: Drop redundant vendor prefix from I2C device name

Rob Clark (1):
      drm/gem: Drop ticket arg to lru_scan()

Rodrigo Vivi (1):
      drm/amd/display: Drop KUnit tests for removed parse_hdmi_amd_vsdb()

Shixiong Ou (1):
      drm/gma500: Create the primary plane in the driver

Simon Wright (1):
      drm/bridge: dw-hdmi-qp: use drm_hdmi_acr_get_n_cts() helper for audio N/CTS

Thomas Zimmermann (6):
      Merge drm/drm-next into drm-misc-next
      drm/hibmc: Return IRQ_NONE for unhandled interrupts
      drm/hibmc: Set up vblank event to be send on the next vblank
      firmware/sysfb: Remove rotation quirk for Lenovo D330
      drm/edid: Add drm_edid_detect_panel_size()
      drm/sysfb: Use preferred panel size for panel orientation quirks

Tomi Valkeinen (1):
      ASoC: ti: omap-hdmi: Fix build error from a merge commit

 .../bindings/display/bridge/analogix,dp.yaml       |   19 +-
 .../bindings/display/panel/ilitek,ili7836a.yaml    |   58 +
 .../bindings/display/panel/novatek,nt36532.yaml    |   83 ++
 .../panel/samsung,s6e8aa5x01-ams561ra01.yaml       |    2 +-
 .../display/rockchip/rockchip,analogix-dp.yaml     |    1 +
 Documentation/gpu/todo.rst                         |   15 -
 MAINTAINERS                                        |   22 +
 drivers/accel/amdxdna/aie2_ctx.c                   |    9 +-
 drivers/accel/amdxdna/amdxdna_gem.c                |  197 ++-
 drivers/accel/amdxdna/amdxdna_gem.h                |    5 +-
 drivers/accel/ethosu/ethosu_job.c                  |    4 +-
 drivers/accel/ivpu/ivpu_drv.h                      |    2 +-
 drivers/accel/qaic/qaic_data.c                     |    8 +-
 drivers/accel/qaic/qaic_debugfs.c                  |    1 +
 drivers/accel/qaic/qaic_drv.c                      |    1 +
 drivers/accel/qaic/qaic_ras.c                      |    1 +
 drivers/accel/qaic/qaic_ssr.c                      |    1 +
 drivers/accel/qaic/qaic_timesync.c                 |    1 +
 drivers/accel/qaic/sahara.c                        |    1 +
 drivers/dma-buf/dma-buf.c                          |    2 +-
 drivers/dma-buf/dma-resv.c                         |    2 +-
 drivers/firmware/efi/sysfb_efi.c                   |    9 -
 drivers/gpu/buddy.c                                | 1342 ++++++++++++++------
 drivers/gpu/drm/adp/adp_drv.c                      |    2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   28 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   85 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |   27 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h  |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  255 +---
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |    3 -
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   73 --
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   16 +-
 drivers/gpu/drm/amd/display/dc/Makefile            |    1 -
 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c    |   80 --
 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h    |   44 -
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |  121 --
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |   10 -
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   71 --
 .../drm/amd/display/modules/color/color_gamma.c    |    3 +-
 .../gpu/drm/arm/display/include/malidp_product.h   |   10 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |   27 +-
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |   18 +-
 .../drm/arm/display/komeda/komeda_wb_connector.c   |   33 +
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |    4 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |   18 +-
 drivers/gpu/drm/arm/malidp_planes.c                |   18 +-
 drivers/gpu/drm/armada/armada_crtc.c               |    2 +-
 drivers/gpu/drm/ast/ast_dp.c                       |   24 +-
 drivers/gpu/drm/ast/ast_mode.c                     |   18 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |   19 +-
 drivers/gpu/drm/bridge/Kconfig                     |    7 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |   88 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |    4 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |   15 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h  |    4 +
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |    1 -
 drivers/gpu/drm/bridge/chipone-icn6211.c           |    8 +-
 drivers/gpu/drm/bridge/ite-it6505.c                |    4 +-
 drivers/gpu/drm/bridge/lontium-lt8713sx.c          |    2 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c            |    2 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |    6 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |    2 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |    4 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |    3 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |    4 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |  209 +--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |    2 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    4 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |   79 +-
 drivers/gpu/drm/clients/drm_log.c                  |   54 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |    3 +
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  156 +++
 drivers/gpu/drm/display/drm_scdc_helper.c          |  289 ++++-
 drivers/gpu/drm/drm_atomic.c                       |    4 +
 drivers/gpu/drm/drm_atomic_uapi.c                  |    7 +
 drivers/gpu/drm/drm_buddy.c                        |    3 +-
 drivers/gpu/drm/drm_colorop.c                      |  107 ++
 drivers/gpu/drm/drm_debugfs.c                      |  157 ---
 drivers/gpu/drm/drm_drv.c                          |   29 +-
 drivers/gpu/drm/drm_edid.c                         |  236 +++-
 drivers/gpu/drm/drm_gem.c                          |   14 +-
 drivers/gpu/drm/drm_gem_atomic_helper.c            |   80 +-
 drivers/gpu/drm/drm_of.c                           |   38 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |   37 +-
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |    3 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |    3 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    3 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |    2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |   10 +-
 drivers/gpu/drm/gma500/psb_intel_display.c         |   34 +-
 drivers/gpu/drm/gud/gud_drv.c                      |    2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |   18 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    5 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c       |    9 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |    2 +-
 drivers/gpu/drm/hyperv/hyperv_drm.h                |    1 -
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |    2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c          |   44 +-
 drivers/gpu/drm/imx/dc/dc-crtc.c                   |    2 +-
 drivers/gpu/drm/imx/dc/dc-kms.c                    |    8 +-
 drivers/gpu/drm/imx/dcss/dcss-crtc.c               |    2 +-
 drivers/gpu/drm/imx/dcss/dcss-plane.c              |    2 +-
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c             |   18 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |    4 +-
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |    2 +-
 drivers/gpu/drm/kmb/kmb_crtc.c                     |    2 +-
 drivers/gpu/drm/kmb/kmb_dsi.c                      |    9 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |   10 +-
 drivers/gpu/drm/meson/meson_crtc.c                 |    2 +-
 drivers/gpu/drm/meson/meson_encoder_cvbs.c         |   11 +-
 drivers/gpu/drm/meson/meson_encoder_dsi.c          |   11 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |   11 +-
 drivers/gpu/drm/meson/meson_overlay.c              |    2 +-
 drivers/gpu/drm/meson/meson_plane.c                |    2 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |    4 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |   15 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   18 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   18 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |    2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |    2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   20 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   16 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |   22 +-
 drivers/gpu/drm/mxsfb/lcdif_kms.c                  |   17 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |    4 +-
 drivers/gpu/drm/nouveau/dispnv04/dfp.c             |    5 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |    4 +-
 drivers/gpu/drm/nouveau/dispnv50/head.c            |   14 +-
 drivers/gpu/drm/nouveau/dispnv50/headca7d.c        |   21 +-
 .../gpu/drm/nouveau/include/nvhw/class/clca7d.h    |    4 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h  |    1 +
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |    4 +
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |   32 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.h             |   10 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  151 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.h        |   12 +-
 drivers/gpu/drm/nouveau/nouveau_dp.c               |    4 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  114 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |    2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c              |   13 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h    |    4 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c |    2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  |    8 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c |    8 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c  |    3 +-
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h |    8 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h    |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild     |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c    |   35 +
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |   63 +-
 drivers/gpu/drm/omapdrm/dss/hdmi.h                 |    6 +
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |   29 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |   37 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_common.c          |   14 +
 drivers/gpu/drm/omapdrm/omap_crtc.c                |   17 +-
 drivers/gpu/drm/panel/Kconfig                      |   25 +
 drivers/gpu/drm/panel/Makefile                     |    2 +
 drivers/gpu/drm/panel/panel-edp.c                  |    3 +
 drivers/gpu/drm/panel/panel-himax-hx83102.c        |   24 +-
 drivers/gpu/drm/panel/panel-himax-hx83112a.c       |   26 +-
 drivers/gpu/drm/panel/panel-himax-hx83112b.c       |   23 +-
 drivers/gpu/drm/panel/panel-himax-hx8394.c         |   26 +-
 drivers/gpu/drm/panel/panel-ilitek-ili7836a.c      |  297 +++++
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c       |   21 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c |   12 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h |    1 -
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c  |   16 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c  |    6 -
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |   15 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c      |   24 +-
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c       |   19 +-
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     |   32 +-
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c |   20 +-
 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c |   20 +-
 drivers/gpu/drm/panel/panel-novatek-nt36532.c      |  431 +++++++
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c      |   74 +-
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c      |   20 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c      |   20 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c   |   20 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      |   30 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c      |   20 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   |   31 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c  |   13 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c  |    6 -
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c      |   12 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.h      |    1 -
 .../drm/panel/panel-samsung-s6e88a0-ams427ap24.c   |   20 +-
 .../drm/panel/panel-samsung-s6e88a0-ams452ef01.c   |   20 +-
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |   19 +-
 .../gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c  |   23 +-
 drivers/gpu/drm/panel/panel-samsung-sofef00.c      |   20 +-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |   31 +-
 drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c    |   20 +-
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c      |   20 +-
 .../gpu/drm/panel/panel-sony-tulip-truly-nt35521.c |   20 +-
 drivers/gpu/drm/panel/panel-visionox-r66451.c      |   23 +-
 drivers/gpu/drm/panel/panel-visionox-rm69299.c     |   21 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |    2 +-
 drivers/gpu/drm/panfrost/panfrost_device.c         |    1 -
 drivers/gpu/drm/panfrost/panfrost_drv.c            |    2 +-
 drivers/gpu/drm/panthor/panthor_device.h           |  286 ++---
 drivers/gpu/drm/panthor/panthor_fw.c               |   22 +-
 drivers/gpu/drm/panthor/panthor_gem.c              |   14 +-
 drivers/gpu/drm/panthor/panthor_gpu.c              |  117 +-
 drivers/gpu/drm/panthor/panthor_mmu.c              |   44 +-
 drivers/gpu/drm/panthor/panthor_mmu.h              |    3 +-
 drivers/gpu/drm/panthor/panthor_pwr.c              |   24 +-
 drivers/gpu/drm/panthor/panthor_sched.c            |  518 ++++----
 drivers/gpu/drm/panthor/panthor_trace.h            |   38 +
 drivers/gpu/drm/qxl/qxl_display.c                  |    2 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c     |   17 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c      |   15 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |   12 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   18 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |   18 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |   10 +-
 drivers/gpu/drm/scheduler/tests/tests_basic.c      |    2 +-
 drivers/gpu/drm/sitronix/st7571.c                  |    2 +-
 drivers/gpu/drm/sitronix/st7920.c                  |   12 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |   22 +-
 drivers/gpu/drm/sprd/sprd_dpu.c                    |    2 +-
 drivers/gpu/drm/sti/sti_crtc.c                     |    2 +-
 drivers/gpu/drm/stm/ltdc.c                         |    4 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |    2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |    1 +
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |    2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |    2 +-
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |    8 +-
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c          |   64 +-
 drivers/gpu/drm/sysfb/efidrm.c                     |   17 +-
 drivers/gpu/drm/sysfb/ofdrm.c                      |   18 +-
 drivers/gpu/drm/sysfb/vesadrm.c                    |   17 +-
 drivers/gpu/drm/tegra/dc.c                         |   18 +-
 drivers/gpu/drm/tegra/dsi.c                        |   16 +-
 drivers/gpu/drm/tegra/plane.c                      |   28 +-
 drivers/gpu/drm/tegra/rgb.c                        |   15 +-
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |    2 +-
 drivers/gpu/drm/tidss/tidss_dispc.c                |   38 +-
 drivers/gpu/drm/tidss/tidss_dispc.h                |    2 +-
 drivers/gpu/drm/tidss/tidss_encoder.c              |   10 +-
 drivers/gpu/drm/tiny/appletbdrm.c                  |   14 +-
 drivers/gpu/drm/tiny/bochs.c                       |    2 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |    2 +-
 drivers/gpu/drm/tiny/pixpaper.c                    |    2 +-
 drivers/gpu/drm/tiny/sharp-memory.c                |    2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |    3 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |    2 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |    2 +-
 drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c          |    2 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |   14 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |    2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |    1 +
 drivers/gpu/drm/vc4/vc4_plane.c                    |   15 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |    2 +-
 drivers/gpu/drm/verisilicon/vs_crtc.c              |    2 +-
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c      |    8 +-
 drivers/gpu/drm/verisilicon/vs_plane.c             |   20 -
 drivers/gpu/drm/verisilicon/vs_plane.h             |    2 -
 drivers/gpu/drm/verisilicon/vs_primary_plane.c     |    7 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |   14 +-
 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py   |   87 ++
 drivers/gpu/drm/vkms/tests/vkms_format_test.c      |   40 +-
 drivers/gpu/drm/vkms/vkms_colorop.c                |   66 +-
 drivers/gpu/drm/vkms/vkms_composer.c               |    6 +
 drivers/gpu/drm/vkms/vkms_crtc.c                   |   18 +-
 drivers/gpu/drm/vkms/vkms_formats.c                |   64 +-
 drivers/gpu/drm/vkms/vkms_formats.h                |    2 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |   55 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   22 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |    2 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c                  |   16 +-
 drivers/gpu/tests/gpu_buddy_test.c                 |  160 ++-
 include/drm/display/drm_dp.h                       |    1 +
 include/drm/display/drm_dp_helper.h                |    6 +
 include/drm/display/drm_hdmi_state_helper.h        |    3 +
 include/drm/display/drm_scdc.h                     |   21 +-
 include/drm/display/drm_scdc_helper.h              |  103 +-
 include/drm/drm_colorop.h                          |  127 ++
 include/drm/drm_connector.h                        |   69 +-
 include/drm/drm_edid.h                             |    2 +
 include/drm/drm_gem.h                              |    3 +-
 include/drm/drm_gem_atomic_helper.h                |   11 +-
 include/drm/drm_mipi_dbi.h                         |    2 +-
 include/drm/drm_print.h                            |    3 +
 include/drm/drm_simple_kms_helper.h                |    6 +-
 include/linux/gpu_buddy.h                          |  101 +-
 include/sound/omap-hdmi-audio.h                    |    1 +
 include/uapi/drm/drm_mode.h                        |   12 +
 kernel/cgroup/dmem.c                               |    4 +-
 sound/soc/ti/omap-hdmi.c                           |   51 +-
 296 files changed, 5952 insertions(+), 3704 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili7836a.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili7836a.c
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36532.c
 create mode 100755 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)
