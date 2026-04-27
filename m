Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF60DFF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6E310E030;
	Mon, 27 Apr 2026 07:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Grxiqruj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA7910E030
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:03:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 65EF260138;
 Mon, 27 Apr 2026 07:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93757C19425;
 Mon, 27 Apr 2026 07:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777273396;
 bh=lXFGWfWO190aKhACkqbpPq7Adnnbl3VibkdvFxIkolU=;
 h=From:Subject:Date:To:Cc:From;
 b=GrxiqrujuA38q45wI9VR1YIGmac3Y2LgAAmGw4OIXQRmhzNtHYcJwYNyUM+014Th3
 gTFhdplfgTLMZ5vCVWfytFBkMTKJM3rI7/08kFZ2L6wHDfjxobkVHt5gDK9U3nfa6A
 bMVDyFi+zAVioTJfrNpVZncshDqMZeKOqqPIHL/2GNiNsYjxVa9VYWEmlGxVUHCtK6
 Ql2RJe+FDYHuN5otaUzC6r60mODoJ0/Pl+7J25WW6BQgLElklrVEHFXKhaw5IQ8H2j
 h1RGZUZDlKaO8Nub3Ldiwgg6FChFgzrHjG89N9ZbRVIlyQE/SQzF+yIPay9e5Wvttx
 DDUjchJ6HkTRA==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v4 0/2] drm: Rename drm_atomic_state
Date: Mon, 27 Apr 2026 09:02:56 +0200
Message-Id: <20260427-drm-drm-atomic-update-v4-0-c0e713bfdf25@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQwW7DIAwG4FeJOI8Km0CinvoeUw8ETIu2hA4o6
 lT13UfTwzZN1Q4+/BZ8ln1lmVKgzLbdlSWqIYe4tNC/dMwezXIgHlzLDAVqIVFzl+a1TIlzsPx
 8cqYQR/KKQNGkzcja31MiHy6r+7pv+RhyielzHVPh3v1PrMAFRz8Yr3xvnMDdG6WF3jcxHdidr
 PiDkfCMwcYMNHrSzlkn/zLym+kFPmNkY6YRtVdgrAL4xdweGyf6OLcDlsfabDKZuI3zHMq2q8M
 GeLLQHt++AHm/QpB1AQAA
X-Change-ID: 20260326-drm-drm-atomic-update-2ef5e15eb6a8
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Jani Nikula <jani.nikula@intel.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=23963; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lXFGWfWO190aKhACkqbpPq7Adnnbl3VibkdvFxIkolU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnvudQmfWWQ5L4U8vu9cILwjpkuTNP2ng3z6Ov86cJ1a
 NKZ/83aHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi3zgYG/aVaZ99WBLsM3Oi
 ppXpK2n1amuX/NjGa6+/Ft0L/VotMb1rQ6ouX488I0PCk4Jm3vSDjA0dy35cZpB8tPv655+FDbL
 ujzS7AuYxG13x1b5oeEjr/P0Nr/rW/SgU1DntvWSpYzVXZCEA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

We've been discussing for a long time about renaming drm_atomic_state
to a better suited name, since the current one is a source of confusion
and bugs.

To minimize the impact, this should probably go through drm-next
directly.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v4:
- Rebase on 7.1-rc1
- Link to v3: https://lore.kernel.org/r/20260402-drm-drm-atomic-update-v3-0-b826f51ac511@kernel.org

Changes in v3:
- Collect tags, adjust commit log
- Rebase on current drm-next (9bdbf7eb25b3)
- Link to v2: https://lore.kernel.org/r/20260331-drm-drm-atomic-update-v2-0-7e8fe6ddcd32@kernel.org

Changes in v2:
- Rename to drm_atomic_commit
- Link to v1: https://lore.kernel.org/r/20260326-drm-drm-atomic-update-v1-0-2f7af5f4ad02@kernel.org

---
Maxime Ripard (2):
      drm: Rename struct drm_atomic_state to drm_atomic_commit
      Documentation: drm: Remove drm_atomic_state rename entry

 Documentation/gpu/drm-kms.rst                      |  14 +-
 Documentation/gpu/komeda-kms.rst                   |   8 +-
 Documentation/gpu/todo.rst                         |  23 ---
 drivers/gpu/drm/adp/adp_drv.c                      |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  10 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  64 ++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |  12 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  22 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |   4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |  20 +--
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |   8 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |  10 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |  14 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |  28 ++--
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |   4 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |  10 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |   6 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |   4 +-
 drivers/gpu/drm/arm/malidp_mw.c                    |   2 +-
 drivers/gpu/drm/arm/malidp_mw.h                    |   2 +-
 drivers/gpu/drm/arm/malidp_planes.c                |   6 +-
 drivers/gpu/drm/armada/armada_crtc.c               |  10 +-
 drivers/gpu/drm/armada/armada_overlay.c            |  10 +-
 drivers/gpu/drm/armada/armada_plane.c              |   6 +-
 drivers/gpu/drm/armada/armada_plane.h              |   2 +-
 drivers/gpu/drm/ast/ast_cursor.c                   |   6 +-
 drivers/gpu/drm/ast/ast_dp.c                       |   4 +-
 drivers/gpu/drm/ast/ast_dp501.c                    |   4 +-
 drivers/gpu/drm/ast/ast_mode.c                     |  18 +--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  10 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |   2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |   6 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   4 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  14 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |   4 +-
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c     |   4 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |   6 +-
 drivers/gpu/drm/bridge/chipone-icn6211.c           |   6 +-
 drivers/gpu/drm/bridge/fsl-ldb.c                   |   4 +-
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c       |   4 +-
 drivers/gpu/drm/bridge/imx/imx8qm-ldb.c            |   4 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c           |   6 +-
 .../gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c    |   2 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c    |   4 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c       |   2 +-
 drivers/gpu/drm/bridge/inno-hdmi.c                 |   6 +-
 drivers/gpu/drm/bridge/ite-it6263.c                |   4 +-
 drivers/gpu/drm/bridge/ite-it6505.c                |   8 +-
 drivers/gpu/drm/bridge/ite-it66121.c               |   4 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c            |   4 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |   8 +-
 drivers/gpu/drm/bridge/nwl-dsi.c                   |   4 +-
 drivers/gpu/drm/bridge/panel.c                     |   8 +-
 drivers/gpu/drm/bridge/parade-ps8640.c             |   4 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |   8 +-
 drivers/gpu/drm/bridge/sii902x.c                   |   4 +-
 drivers/gpu/drm/bridge/ssd2825.c                   |   6 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |   4 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |   4 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   6 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |   6 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c     |   6 +-
 drivers/gpu/drm/bridge/tc358762.c                  |   6 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   8 +-
 drivers/gpu/drm/bridge/tc358768.c                  |   8 +-
 drivers/gpu/drm/bridge/tc358775.c                  |   6 +-
 drivers/gpu/drm/bridge/ti-dlpc3433.c               |   6 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |   6 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  22 +--
 drivers/gpu/drm/bridge/ti-tdp158.c                 |   4 +-
 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt      |  20 +--
 drivers/gpu/drm/display/drm_bridge_connector.c     |   2 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |  26 ++--
 drivers/gpu/drm/display/drm_dp_tunnel.c            |  14 +-
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |   6 +-
 drivers/gpu/drm/drm_atomic.c                       | 128 +++++++--------
 drivers/gpu/drm/drm_atomic_helper.c                | 172 ++++++++++-----------
 drivers/gpu/drm/drm_atomic_state_helper.c          |   2 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |  28 ++--
 drivers/gpu/drm/drm_blend.c                        |   8 +-
 drivers/gpu/drm/drm_bridge.c                       |  14 +-
 drivers/gpu/drm/drm_client_modeset.c               |   8 +-
 drivers/gpu/drm/drm_color_mgmt.c                   |   6 +-
 drivers/gpu/drm/drm_crtc_helper.c                  |   2 +-
 drivers/gpu/drm/drm_crtc_internal.h                |  10 +-
 drivers/gpu/drm/drm_damage_helper.c                |  10 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   8 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   8 +-
 drivers/gpu/drm/drm_mipi_dbi.c                     |   8 +-
 drivers/gpu/drm/drm_mode_object.c                  |   8 +-
 drivers/gpu/drm/drm_modeset_helper.c               |   2 +-
 drivers/gpu/drm/drm_self_refresh_helper.c          |  12 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |  10 +-
 drivers/gpu/drm/drm_vblank_helper.c                |   6 +-
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |  10 +-
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |   6 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |   6 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |   6 +-
 drivers/gpu/drm/gud/gud_connector.c                |  10 +-
 drivers/gpu/drm/gud/gud_internal.h                 |   8 +-
 drivers/gpu/drm/gud/gud_pipe.c                     |   8 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |  12 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c     |   4 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |  14 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |   6 +-
 drivers/gpu/drm/i915/display/g4x_hdmi.c            |   2 +-
 drivers/gpu/drm/i915/display/g4x_hdmi.h            |   6 +-
 drivers/gpu/drm/i915/display/i9xx_wm.c             |  10 +-
 drivers/gpu/drm/i915/display/intel_atomic.c        |  16 +-
 drivers/gpu/drm/i915/display/intel_atomic.h        |  12 +-
 drivers/gpu/drm/i915/display/intel_audio.c         |   8 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |   2 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  22 +--
 drivers/gpu/drm/i915/display/intel_display.h       |   6 +-
 drivers/gpu/drm/i915/display/intel_display_core.h  |   2 +-
 .../gpu/drm/i915/display/intel_display_driver.c    |   8 +-
 .../gpu/drm/i915/display/intel_display_driver.h    |   4 +-
 drivers/gpu/drm/i915/display/intel_display_reset.c |   8 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   2 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   2 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   6 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   2 +-
 drivers/gpu/drm/i915/display/intel_fdi.c           |   2 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |   2 +-
 drivers/gpu/drm/i915/display/intel_load_detect.c   |  20 +--
 drivers/gpu/drm/i915/display/intel_load_detect.h   |   6 +-
 drivers/gpu/drm/i915/display/intel_modeset_lock.c  |   2 +-
 drivers/gpu/drm/i915/display/intel_modeset_setup.c |   6 +-
 drivers/gpu/drm/i915/display/intel_pipe_crc.c      |   8 +-
 drivers/gpu/drm/i915/display/intel_plane.c         |   2 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |   8 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |   2 +-
 drivers/gpu/drm/i915/display/intel_sprite_uapi.c   |   8 +-
 drivers/gpu/drm/i915/display/intel_tc.c            |   6 +-
 drivers/gpu/drm/i915/display/intel_tv.c            |   4 +-
 drivers/gpu/drm/imx/dc/dc-crtc.c                   |  10 +-
 drivers/gpu/drm/imx/dc/dc-plane.c                  |   6 +-
 drivers/gpu/drm/imx/dcss/dcss-crtc.c               |   8 +-
 drivers/gpu/drm/imx/dcss/dcss-plane.c              |   6 +-
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c           |   4 +-
 drivers/gpu/drm/imx/ipuv3/imx-drm.h                |   2 +-
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c             |  10 +-
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c            |   8 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |  24 +--
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |  10 +-
 drivers/gpu/drm/kmb/kmb_crtc.c                     |  10 +-
 drivers/gpu/drm/kmb/kmb_drv.h                      |   2 +-
 drivers/gpu/drm/kmb/kmb_dsi.c                      |   4 +-
 drivers/gpu/drm/kmb/kmb_dsi.h                      |   2 +-
 drivers/gpu/drm/kmb/kmb_plane.c                    |   6 +-
 drivers/gpu/drm/logicvc/logicvc_crtc.c             |   6 +-
 drivers/gpu/drm/logicvc/logicvc_layer.c            |   6 +-
 drivers/gpu/drm/loongson/lsdc_crtc.c               |   8 +-
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c      |   2 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c      |   6 +-
 drivers/gpu/drm/loongson/lsdc_plane.c              |  22 +--
 drivers/gpu/drm/mediatek/mtk_crtc.c                |  12 +-
 drivers/gpu/drm/mediatek/mtk_crtc.h                |   2 +-
 drivers/gpu/drm/mediatek/mtk_dp.c                  |   4 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |   8 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |   8 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             |   8 +-
 drivers/gpu/drm/mediatek/mtk_plane.c               |  10 +-
 drivers/gpu/drm/meson/meson_crtc.c                 |  12 +-
 drivers/gpu/drm/meson/meson_encoder_cvbs.c         |   4 +-
 drivers/gpu/drm/meson/meson_encoder_dsi.c          |   4 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |   4 +-
 drivers/gpu/drm/meson/meson_overlay.c              |   6 +-
 drivers/gpu/drm/meson/meson_plane.c                |   6 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |  26 ++--
 drivers/gpu/drm/mgag200/mgag200_g200.c             |   4 +-
 drivers/gpu/drm/mgag200/mgag200_g200eh.c           |   4 +-
 drivers/gpu/drm/mgag200/mgag200_g200eh3.c          |   2 +-
 drivers/gpu/drm/mgag200/mgag200_g200eh5.c          |   2 +-
 drivers/gpu/drm/mgag200/mgag200_g200er.c           |   6 +-
 drivers/gpu/drm/mgag200/mgag200_g200ev.c           |   6 +-
 drivers/gpu/drm/mgag200/mgag200_g200ew3.c          |   2 +-
 drivers/gpu/drm/mgag200/mgag200_g200se.c           |  10 +-
 drivers/gpu/drm/mgag200/mgag200_g200wb.c           |   4 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |  18 +--
 drivers/gpu/drm/mgag200/mgag200_vga_bmc.c          |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   8 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h          |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |   2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |  10 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |  10 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h           |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c         |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.h         |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c          |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.h          |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   8 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.h       |   2 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c  |   2 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |   6 +-
 drivers/gpu/drm/msm/dp/dp_drm.c                    |   6 +-
 drivers/gpu/drm/msm/dp/dp_drm.h                    |   6 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |   4 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |   8 +-
 drivers/gpu/drm/msm/msm_drv.h                      |   6 +-
 drivers/gpu/drm/msm/msm_kms.h                      |   4 +-
 drivers/gpu/drm/mxsfb/lcdif_kms.c                  |  12 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |  16 +-
 drivers/gpu/drm/nouveau/dispnv50/atom.h            |   6 +-
 drivers/gpu/drm/nouveau/dispnv50/crc.c             |  16 +-
 drivers/gpu/drm/nouveau/dispnv50/crc.h             |  16 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  68 ++++----
 drivers/gpu/drm/nouveau/dispnv50/head.c            |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |   2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   2 +-
 drivers/gpu/drm/nouveau/nouveau_display.h          |   2 +-
 drivers/gpu/drm/nouveau/nouveau_encoder.h          |   4 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |   4 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |   4 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |  10 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |  14 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |   2 +-
 drivers/gpu/drm/omapdrm/omap_overlay.c             |   4 +-
 drivers/gpu/drm/omapdrm/omap_overlay.h             |   4 +-
 drivers/gpu/drm/omapdrm/omap_plane.c               |   6 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |  16 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c     |  18 +--
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c      |   4 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c    |   6 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h    |   2 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c      |   4 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c        |   6 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |   6 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.h    |   6 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c      |   6 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c       |   4 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c     |   8 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |   6 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c |   6 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |   6 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |   4 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c   |   2 +-
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c          |   2 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |   6 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  22 +--
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |  18 +--
 drivers/gpu/drm/sitronix/st7571.c                  |  10 +-
 drivers/gpu/drm/sitronix/st7586.c                  |   6 +-
 drivers/gpu/drm/sitronix/st7735r.c                 |   2 +-
 drivers/gpu/drm/sitronix/st7920.c                  |  12 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |  32 ++--
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  12 +-
 drivers/gpu/drm/sti/sti_crtc.c                     |   6 +-
 drivers/gpu/drm/sti/sti_cursor.c                   |   6 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |   6 +-
 drivers/gpu/drm/sti/sti_hqvdp.c                    |   6 +-
 drivers/gpu/drm/stm/drv.c                          |   2 +-
 drivers/gpu/drm/stm/ltdc.c                         |  12 +-
 drivers/gpu/drm/stm/ltdc.h                         |   2 +-
 drivers/gpu/drm/stm/lvds.c                         |   6 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   4 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |  10 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |   2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   4 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                |   4 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |   4 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |   2 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |   4 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |   4 +-
 drivers/gpu/drm/sun4i/sunxi_engine.h               |   4 +-
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |   8 +-
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c          |   8 +-
 drivers/gpu/drm/sysfb/ofdrm.c                      |   2 +-
 drivers/gpu/drm/sysfb/vesadrm.c                    |   4 +-
 drivers/gpu/drm/tegra/dc.c                         |  32 ++--
 drivers/gpu/drm/tegra/dc.h                         |   2 +-
 drivers/gpu/drm/tegra/drm.c                        |   6 +-
 drivers/gpu/drm/tegra/hub.c                        |  12 +-
 drivers/gpu/drm/tegra/hub.h                        |   4 +-
 drivers/gpu/drm/tests/Makefile                     |   2 +-
 ...tomic_state_test.c => drm_atomic_commit_test.c} |  12 +-
 drivers/gpu/drm/tests/drm_bridge_test.c            |   8 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  88 +++++------
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |  18 +--
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  10 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |   4 +-
 drivers/gpu/drm/tidss/tidss_oldi.c                 |   4 +-
 drivers/gpu/drm/tidss/tidss_plane.c                |   8 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |   8 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |   2 +-
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |   4 +-
 drivers/gpu/drm/tiny/appletbdrm.c                  |   6 +-
 drivers/gpu/drm/tiny/bochs.c                       |  10 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |   8 +-
 drivers/gpu/drm/tiny/hx8357d.c                     |   2 +-
 drivers/gpu/drm/tiny/ili9163.c                     |   2 +-
 drivers/gpu/drm/tiny/ili9225.c                     |   6 +-
 drivers/gpu/drm/tiny/ili9341.c                     |   2 +-
 drivers/gpu/drm/tiny/ili9486.c                     |   2 +-
 drivers/gpu/drm/tiny/mi0283qt.c                    |   2 +-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c              |   2 +-
 drivers/gpu/drm/tiny/pixpaper.c                    |  10 +-
 drivers/gpu/drm/tiny/sharp-memory.c                |  10 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |   8 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |  18 +--
 drivers/gpu/drm/vc4/tests/vc4_mock.h               |   4 +-
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c        |   4 +-
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c     |  50 +++---
 drivers/gpu/drm/vc4/vc4_crtc.c                     |  10 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |  28 ++--
 drivers/gpu/drm/vc4/vc4_dsi.c                      |   8 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  12 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                      |  10 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |  30 ++--
 drivers/gpu/drm/vc4/vc4_plane.c                    |   8 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |  10 +-
 drivers/gpu/drm/vc4/vc4_vec.c                      |   4 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c            |   6 +-
 drivers/gpu/drm/verisilicon/vs_crtc.c              |   4 +-
 drivers/gpu/drm/verisilicon/vs_primary_plane.c     |   8 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |   8 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |   6 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |   6 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |   4 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |   4 +-
 drivers/gpu/drm/vkms/vkms_writeback.c              |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c       |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h       |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  18 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c               |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h               |  10 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c                   |   6 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c                  |  16 +-
 include/drm/display/drm_dp_mst_helper.h            |  32 ++--
 include/drm/display/drm_dp_tunnel.h                |  24 +--
 include/drm/display/drm_hdmi_state_helper.h        |   6 +-
 include/drm/drm_atomic.h                           | 158 +++++++++----------
 include/drm/drm_atomic_helper.h                    |  78 +++++-----
 include/drm/drm_atomic_state_helper.h              |   4 +-
 include/drm/drm_blend.h                            |   4 +-
 include/drm/drm_bridge.h                           |  16 +-
 include/drm/drm_colorop.h                          |   4 +-
 include/drm/drm_connector.h                        |   6 +-
 include/drm/drm_crtc.h                             |  10 +-
 include/drm/drm_crtc_helper.h                      |   4 +-
 include/drm/drm_damage_helper.h                    |   2 +-
 include/drm/drm_kunit_helpers.h                    |   2 +-
 include/drm/drm_mipi_dbi.h                         |   8 +-
 include/drm/drm_mode_config.h                      |  38 ++---
 include/drm/drm_modeset_helper_vtables.h           |  44 +++---
 include/drm/drm_plane.h                            |   6 +-
 include/drm/drm_self_refresh_helper.h              |   6 +-
 include/drm/drm_vblank_helper.h                    |   8 +-
 365 files changed, 1746 insertions(+), 1769 deletions(-)
---
base-commit: 5e9b7d093f3f77cb0af4409559e3d139babfb443
change-id: 20260326-drm-drm-atomic-update-2ef5e15eb6a8

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

