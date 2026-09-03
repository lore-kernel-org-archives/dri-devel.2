Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B6FC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65CFD10E115;
	Thu,  3 Sep 2026 13:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="vPs1Qrxq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3T/XYSEh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NbrOeo7D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kl7I540v";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17A2E10E0F2;
 Thu,  3 Sep 2026 13:06:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3416521DE1;
 Thu,  3 Sep 2026 13:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788440754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CBB6HYiQF1MZeCHfO4RVgRJ9qJBcmb0aqGxirsR9i3w=;
 b=vPs1QrxqGA5rCKjbjmjVJjVgX0popqWZgLuw4uM0vkkAnbNsLZE7NcRX8UwuW3mEUlR5UI
 Yi8ITpZu+j6rXfxyAKURbbQ52FrSsIEpkx8ywtqnzm1SCJ/5+kkdlbSnUvq34teRU6tnEk
 iTElc1Y/POYSQ8Av7CXz5zd9njAvDHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788440754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CBB6HYiQF1MZeCHfO4RVgRJ9qJBcmb0aqGxirsR9i3w=;
 b=3T/XYSEhlSKsi35UFKuU/DyjxAzUgNUGlR0msByLLu8HJAg4PHWm2FWsqHpqL38862Ig95
 WMo5HxLS4LeY1lCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788440750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CBB6HYiQF1MZeCHfO4RVgRJ9qJBcmb0aqGxirsR9i3w=;
 b=NbrOeo7Dhc1Xo/P2M7mFpRmHRYUfsZRcORSgvLlzW1/NVhPD64wKP+IQw4QLclxfOsh8wC
 ENAN76jroZ2k1CQtXe2WMaso3OtIgrMwU90Gl34lW4oy7JMl+TAKMHHPC/ROU5u7NedzIt
 Eux8bxBNhGfBA7IRe39NsPCQXdjxL5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788440750;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CBB6HYiQF1MZeCHfO4RVgRJ9qJBcmb0aqGxirsR9i3w=;
 b=Kl7I540vI3auorv+rPBqpBkLRFBwIJk9fPeCpzZ7lhJgi6xqOHV28ohE3an9Z7cLacx+0e
 SzEdKBCAuLOGAfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A122B13736;
 Thu,  3 Sep 2026 13:05:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uPUkJq1wmWrLQAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 03 Sep 2026 13:05:49 +0000
Date: Thu, 3 Sep 2026 15:05:48 +0200
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
Message-ID: <20260903130548.GA91506@2a02-2455-9062-2500-3419-2212-e55c-8a45.dyn6.pyur.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
 2a02-2455-9062-2500-3419-2212-e55c-8a45.dyn6.pyur.net:mid,
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

this is the first PR from drm-misc-next for what will become v7.4.

UAPI-wise it adds DRM_COLOR_OP_FIXED_MATRIX for color ops. Cross-subsys
changes appear to be minor.

There are two major refactorings that affect drivers throughout the DRM
code. One is Maxime's rework of state-allocation that changes the interfaces
from reset to atomic_create_state. The other is the inlining and removal of
drm_simple_encoder_init().

And of course there's the usual amount of smaller changes, improvements
and fixes.

Best regards
Thomas

drm-misc-next-2026-09-03:
drm-misc-next for v7.4:

UAPI Changes:

colorop:
- provide DRM_COLOR_OP_FIXED_MATRIX

Cross-subsystem Changes:

cgroups:
- fix typos

dma-buf:
- fix typos

sound:
- adapt to changes in omapdrm

Core Changes:

atomic:
- convert most of DRM from state reset callbacks to atomic_create_state
- remove drm_simple_encoder_init(); update drivers

buddy:
- improve dirty-page tracking

clients:
- log: Improve vmap handling

display:
- export HDMI SCDC status data via debugfs

edid:
- parse AMD VSDB entries
- parse ALLM/VRR capabilities

log:
- add drm_warn_ratelimited()

sched:
- add missing locking

Driver Changes:

amd:
- display: Use AMD VSDB for FreeSync
- display: Implement YUV-to-RGB with fixed-matrix colorop

amdxdma:
- various fixes

ast:
- support 256-byte EDID data

bridge:
- clean up redundant error reporting
- ti-sn65dsi83: Simplify error condition logic

hyperv_drm:
- remove support for pre-Win10 hosts

komeda:
- fix usage of GLB_CORE_ID

nouveau:
- improve runtime PM on R570 GSP firmware
- various fixes throughout the driver
- dispnv50: Support 2.147 GHz pixel clock in GB20x

omap:
- report HDMI hotplug events to ASoC HDMI codec

panel:
- panel-edp: Support MNE007QS3-F, TM140VDXP15, and KD116N36-30NB-A001
- samsung-s6d16d0: Use mipi_dsi_*_multi() functions
- support Ilitek ILI7836A OLED plus DT bindings
- support Novatek NT36532 plus DT bindings
- convert several drivers to managed cleanup
- fix Kconfig selections

panthor:
- provide gpu_cache_flush tracepoint
- improve dma_fence signalling latency
- improve locking

qaic:
- reject BOs that exceed maximum page count
- add missing include statements

verisilicon:
- fix hardware cursor offsets

vkms:
- implement YUV-to-RGB with fixed-matrix colorop
The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-09-03

for you to fetch changes up to 99c95ce1b07081d7944d637ba7d72d835c0d520a:

  drm/tidss: dispc: Switch to drm_fb_dma_get_gem_addr() for framebuffer addresses (2026-09-03 14:04:52 +0300)

----------------------------------------------------------------
drm-misc-next for v7.4:

UAPI Changes:

colorop:
- provide DRM_COLOR_OP_FIXED_MATRIX

Cross-subsystem Changes:

cgroups:
- fix typos

dma-buf:
- fix typos

sound:
- adapt to changes in omapdrm

Core Changes:

atomic:
- convert most of DRM from state reset callbacks to atomic_create_state
- remove drm_simple_encoder_init(); update drivers

buddy:
- improve dirty-page tracking

clients:
- log: Improve vmap handling

display:
- export HDMI SCDC status data via debugfs

edid:
- parse AMD VSDB entries
- parse ALLM/VRR capabilities

log:
- add drm_warn_ratelimited()

sched:
- add missing locking

Driver Changes:

amd:
- display: Use AMD VSDB for FreeSync
- display: Implement YUV-to-RGB with fixed-matrix colorop

amdxdma:
- various fixes

ast:
- support 256-byte EDID data

bridge:
- clean up redundant error reporting
- ti-sn65dsi83: Simplify error condition logic

hyperv_drm:
- remove support for pre-Win10 hosts

komeda:
- fix usage of GLB_CORE_ID

nouveau:
- improve runtime PM on R570 GSP firmware
- various fixes throughout the driver
- dispnv50: Support 2.147 GHz pixel clock in GB20x

omap:
- report HDMI hotplug events to ASoC HDMI codec

panel:
- panel-edp: Support MNE007QS3-F, TM140VDXP15, and KD116N36-30NB-A001
- samsung-s6d16d0: Use mipi_dsi_*_multi() functions
- support Ilitek ILI7836A OLED plus DT bindings
- support Novatek NT36532 plus DT bindings
- convert several drivers to managed cleanup
- fix Kconfig selections

panthor:
- provide gpu_cache_flush tracepoint
- improve dma_fence signalling latency
- improve locking

qaic:
- reject BOs that exceed maximum page count
- add missing include statements

verisilicon:
- fix hardware cursor offsets

vkms:
- implement YUV-to-RGB with fixed-matrix colorop

----------------------------------------------------------------
Aaron Kling (2):
      dt-bindings: display: panel: add Ilitek ILI7836A OLED driver
      drm/panel: add Ilitek ILI7836A panel driver

Adrián Larumbe (3):
      drm/panfrost: Check another bo field for cache option query
      drm/panfrost: Prevent division by 0
      drm/panfrost: Remove unnecessary header file include

Akash Sukhavasi (1):
      drm/panel: samsung-s6d16d0: Use mipi_dsi_*_multi(); fix minor bugs

Alex Huang (4):
      drm/edid: Parse AMD VSDB for FreeSync refresh range
      drm/amd/display: Use HDMI FreeSync range from common EDID parser
      drm/amd/display: Clean up FreeSync capability detection
      drm/amd/display: Remove unused DMCU/DMUB EDID CEA parser

Andreas Kemnade (1):
      drm/omap: dsi: avoid sending bta sync all the time in writes

Arunpravin Paneer Selvam (2):
      gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker
      gpu/tests/buddy: add dirty tracker performance KUnit test

Boris Brezillon (9):
      drm/panthor: Make panthor_irq::state a non-atomic field
      drm/panthor: Move the register accessors before the IRQ helpers
      drm/panthor: Replace the panthor_irq macro machinery by inline helpers
      drm/panthor: Don't update might_have_idle_groups in process_idle_event_locked()
      drm/panthor: Get rid of panthor_group::fatal_lock
      drm/panthor: Protect events processing with a separate spinlock
      drm/panthor: Don't defer job completion checks
      drm/panthor: Don't defer FW event processing
      drm/panthor: Automate CSG IRQ processing at group unbind time

Chaitanya Kumar Borah (1):
      drm/colorop: Add DRM_COLOROP_FIXED_MATRIX

Chen-Yu Tsai (2):
      drm/verisilicon: Switch to drm_fb_dma_get_addr() for framebuffer addresses
      drm/tidss: dispc: Switch to drm_fb_dma_get_gem_addr() for framebuffer addresses

Dawid Osuchowski (2):
      drm/print: add drm_warn_ratelimited logging macro
      accel/ivpu: Use drm_warn_ratelimited macro

Diogo Silva (15):
      drm/exynos: remove dependency on DRM simple helpers
      drm/xlnx/zynqmp_dpsub: remove dependency on DRM simple helpers
      drm/tegra: remove dependency on DRM simple helpers
      drm/fsl-dcu: remove dependency on DRM simple helpers
      drm/kmb: remove dependency on DRM simple helpers
      drm/virtio: remove dependency on DRM simple helpers
      drm/tidss: remove dependency on DRM simple helpers
      drm/imx: remove dependency on DRM simple helpers
      drm/mediatek: remove dependency on DRM simple helpers
      drm/renesas/shmobile: remove dependency on DRM simple helpers
      drm/hisilicon/kirin: remove dependency on DRM simple helpers
      drm/arm/komeda: remove dependency on DRM simple helpers
      drm/meson: remove dependency on DRM simple helpers
      Documentation/gpu: remove completed drm_simple_encoder_init() todo
      drm/drm_simple: remove deprecated drm_simple_encoder_init function

Haikun Zhou (1):
      drm/panel-edp: Support MNE007QS3-F and TM140VDXP15 edp panel

Hao-Qun Huang (1):
      accel/qaic: reject BO sizes that overflow page count

Haojie Li (2):
      dma-buf: fix coding style in dma_resv_get_singleton
      dma-buf: fix comment in dma_buf_llseek to match implementation

Harry Wentland (10):
      drm/vkms: Fix limited-range YCbCr to RGB conversion scaling
      drm/vkms: Add fixed matrix colorop to color pipeline
      drm/vkms: Add atomic check and matrix handling for fixed matrix colorop
      drm/amd/display: Add fixed matrix colorop to color pipeline
      drm/amd/display: Implement fixed matrix colorop color space mapping
      drm/amd/display: Use GAMCOR for first TF if YUV conversion is needed
      drm/amd/display: Check actual state during commit_tail
      drm/amd/display: Set color_space to plane_infos
      drm/amd/display: Force GAMCOR for subsampled surfaces with PQ/Gamma22/HLG
      drm/amd/display: pull colorops into state when recreating a plane

Icenowy Zheng (1):
      drm: verisilicon: fix cursor offset field update

Ivaylo Dimitrov (1):
      drm/omap: Report HDMI hotplug events to the ASoC HDMI codec

Jammy Huang (1):
      drm/ast: DisplayPort edid supports 256 bytes

Junjie Cao (2):
      dt-bindings: display: panel: Add Novatek NT36532
      drm/panel: Add Novatek NT36532 panel driver

Konrad Dybcio (1):
      dt-bindings: display: panel: samsung,s6e8aa5x01: Allow common properties

Lizhi Hou (2):
      accel/amdxdna: Fix unexpected wait when flushing notifier_wq
      accel/amdxdna: Fix possible use-after-free when freeing device BO

Luca Ceresoli (6):
      drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: don't select unused DRM_PANEL
      drm/bridge: ti-sn65dsi86: don't select unused DRM_PANEL, select DRM_PANEL_BRIDGE
      drm/bridge: ti-sn65dsi83: select DRM_PANEL_BRIDGE
      drm/bridge: parade-ps8640: select DRM_PANEL_BRIDGE, not DRM_PANEL
      drm: of: drm_of_find_panel_or_bridge: simplify freeing the remote node pointer
      drm: of: drm_of_find_panel_or_bridge: simplify error return paths

Lyude Paul (9):
      drm/nouveau: Fix cleanup bug in nouveau_drm_device_new()
      drm/nouveau: Print the nouveau.atomic parameter in nouveau_display_options()
      drm/nouveau: Fix drm_driver struct/nouveau.atomic parameter handling
      drm/nouveau/kms: Only allow enabling atomic modesetting on nv50+
      drm/nouveau/kms/nv50-: Enable atomic modesetting by default
      Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"
      drm/nouveau/gsp/r570: Set GcOff = 0 in fbsr
      drm/nouveau/gsp/r570: Enable S/R Display workaround in GSP
      drm/nouveau/gsp: Increase delay for magic sleep in r535_gsp_fini()

Mallesh Koujalagi (1):
      drm/drv: Convert wedged event string building to seq_buf

Manush Prajwal (1):
      cgroup/dmem: fix comment typos in dmem.c

Marek Czernohous (4):
      drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)
      drm/nouveau: disable the fence uevent work instead of just cancelling it
      drm/nouveau: cancel the DP IRQ work before freeing the connector
      drm/nouveau: don't dereference outp before checking it in nouveau_dp_irq

Marek Vasut (1):
      drm: of: Fix drm_of_get_data_lanes_count_ep() return value documentation

Maxime Ripard (80):
      drm/simple-kms: Add create_plane_state hook
      drm/gem-atomic-helper: Create drm_gem_create_shadow_plane_state()
      drm/gem-atomic-helper: Convert simple-kms shadow helpers to create_plane_state
      drm/gem-atomic-helper: Switch DRM_GEM_SHADOW_PLANE_FUNCS to atomic_create_state
      drm/gem-atomic-helper: Remove drm_gem_reset_shadow_plane()
      drm/sysfb: Convert to atomic_create_state
      drm/simple-kms: Switch to atomic_create_state
      drm/ssd130x: Convert to atomic_create_state
      drm/st7920: Convert to atomic_create_state
      drm/appletbdrm: Convert to atomic_create_state
      drm/hdlcd: Convert to atomic_create_state
      drm/imx/dcss: Convert to atomic_create_state
      drm/ingenic: Convert to atomic_create_state
      drm/meson: Convert to atomic_create_state
      drm/msm/mdp4: Convert to atomic_create_state
      drm/sun4i: sun8i: Convert to atomic_create_state
      drm/komeda: Convert to atomic_create_state
      drm/malidp: Convert to atomic_create_state
      drm/msm/dpu1: Convert to atomic_create_state
      drm/msm/mdp5: Convert to atomic_create_state
      drm/vc4: Convert to atomic_create_state
      drm/tegra: Convert to atomic_create_state
      drm/adp: Switch to drm_atomic_helper_crtc_create_state
      drm/arm: hdlcd: Switch to drm_atomic_helper_crtc_create_state
      drm/armada: Switch to drm_atomic_helper_crtc_create_state
      drm/exynos: Switch to drm_atomic_helper_crtc_create_state
      drm/fsl-dcu: Switch to drm_atomic_helper_crtc_create_state
      drm/gud: Switch to drm_atomic_helper_crtc_create_state
      drm/hisilicon: hibmc: Switch to drm_atomic_helper_crtc_create_state
      drm/hisilicon: kirin: Switch to drm_atomic_helper_crtc_create_state
      drm/hyperv: Switch to drm_atomic_helper_crtc_create_state
      drm/imx: dc: Switch to drm_atomic_helper_crtc_create_state
      drm/imx: dcss: Switch to drm_atomic_helper_crtc_create_state
      drm/ingenic: Switch to drm_atomic_helper_crtc_create_state
      drm/kmb: Switch to drm_atomic_helper_crtc_create_state
      drm/meson: Switch to drm_atomic_helper_crtc_create_state
      drm/msm: mdp4: Switch to drm_atomic_helper_crtc_create_state
      drm/mxs: mxsfb: Switch to drm_atomic_helper_crtc_create_state
      drm/qxl: Switch to drm_atomic_helper_crtc_create_state
      drm/renesas: shmobile: Switch to drm_atomic_helper_crtc_create_state
      drm/simple-kms: Remove unused reset_crtc hook
      drm/simple-kms: Switch to drm_atomic_helper_crtc_create_state
      drm/sitronix: st7571: Switch to drm_atomic_helper_crtc_create_state
      drm/sprd: Switch to drm_atomic_helper_crtc_create_state
      drm/sti: Switch to drm_atomic_helper_crtc_create_state
      drm/stm: Switch to drm_atomic_helper_crtc_create_state
      drm/sun4i: Switch to drm_atomic_helper_crtc_create_state
      drm/tests: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: appletbdrm: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: bochs: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: cirrus: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: pixpaper: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: sharp: Switch to drm_atomic_helper_crtc_create_state
      drm/udl: Switch to drm_atomic_helper_crtc_create_state
      drm/vbox: Switch to drm_atomic_helper_crtc_create_state
      drm/verisilicon: Switch to drm_atomic_helper_crtc_create_state
      drm/virtio: Switch to drm_atomic_helper_crtc_create_state
      drm/xlnx: Switch to drm_atomic_helper_crtc_create_state
      drm/mipi-dbi: Switch to drm_atomic_helper_crtc_create_state
      sysfb: Convert to create_state
      drm/komeda: Convert to atomic_create_state
      drm/malidp: Convert to atomic_create_state
      drm/ast: Convert to atomic_create_state
      drm/atmel-hlcdc: Convert to atomic_create_state
      drm/imx: ipuv3: Convert to atomic_create_state
      drm/mgag200: Convert to atomic_create_state
      drm/msm: dpu1: Convert to atomic_create_state
      drm/msm: mdp5: Convert to atomic_create_state
      drm/mxsfb: lcdif: Convert to atomic_create_state
      drm/nouveau: Convert to atomic_create_state
      drm/omapdrm: Convert to atomic_create_state
      drm/rcar-du: Convert to atomic_create_state
      drm/rzg2l-du: Convert to atomic_create_state
      drm/rockchip: vop: Convert to atomic_create_state
      drm/rockchip: vop2: Convert to atomic_create_state
      drm/solomon: ssd130x: Convert to atomic_create_state
      drm/tegra: Convert to atomic_create_state
      drm/vc4: Convert to atomic_create_state
      drm/vkms: Convert to atomic_create_state
      drm/vmwgfx: Convert to atomic_create_state

Michael Kelley (1):
      drm_hyperv: Remove support for synth video protocol of old Hyper-V hosts

Mohamed Ahmed (2):
      drm/nouveau/dispnv50: program pixel clocks above 2.147GHz on GB20x
      drm/nouveau: honor HF-EEODB EDIDs by converting to struct drm_edid

Muhammed Sariyildiz (1):
      drm/nouveau/clk/gk20a: fix undefined behaviour in signed left shift

Nicolas Frattaroli (8):
      drm/scdc-helper: Don't use ssize_t return type for scdc_read/write
      drm/scdc-helper: Add scdc_status debugfs entry
      drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields
      drm/debugfs: Move HDMI debugfs registration to state helper
      drm/display: hdmi-state-helper: Init SCDC debugfs for HDMI
      drm/panthor: Add tracepoint for cache flushing
      drm/panthor: Revisit reqs_lock handling in flush/reset paths
      drm/panthor: Take reqs_lock in soft_reset for clearing pending_reqs

Osama Abdelkader (4):
      drm/bridge: chipone-icn6211: use devm_mipi_dsi_attach
      drm/panel: Use managed helpers in Samsung panels
      drm/panel: Use managed helpers in Himax and Ilitek panels
      drm/panel: Use managed helpers in display vendor panels

Pan Chuang (10):
      drm/bridge: analogix_dp: Remove redundant dev_err()
      drm/bridge: cdns-mhdp8546: Remove redundant dev_err()
      drm/bridge: lt9611: Remove redundant dev_err()
      drm/bridge: samsung-dsim: Remove redundant dev_err()
      drm/bridge: synopsys: dw-dp: Remove redundant dev_err_probe()
      drm/bridge: tc358767: Remove redundant dev_err()
      drm/bridge: it6505: Remove redundant dev_err()
      drm/bridge/sii8620: Remove redundant dev_err_probe()
      drm/bridge: ti-sn65dsi83: Remove redundant dev_err_probe()
      accel: ethosu: Remove redundant dev_err()

Philipp Stanner (1):
      drm/sched: Lock drm_sched_entity_is_idle()

Raveendra Talabattula (1):
      drm/komeda: Fix bits parsing of GLB_CORE_ID

Sean Chang (3):
      drm/ttm: drop stale @ctx kernel-doc entry
      drm/ttm: make ttm_swap_ops static
      drm: bridge: dw_hdmi: Fix constant truncation warning on phy_mask

Shixiong Ou (3):
      drm/log: Batch vmap/vunmap and flush for record drawing
      drm/sched: Fix incorrect test description in drm_sched_basic_cases
      drm/sysfb: Clear entire framebuffer in atomic_disable

Suraj Kandpal (1):
      drm/dp: Add EDP_20 rev definition

Thomas Hellström (1):
      drm/gpusvm: Assign maintainers to the DRM GPUSVM helpers

Thomas Zimmermann (1):
      Merge drm/drm-next into drm-misc-next

Tomasz Pakuła (1):
      drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB

Vincenzo Frascino (1):
      drm/komeda: Set display/writeback clone masks

Wojciech Dubowik (1):
      drm/bridge: ti-sn65dsi83: Simplify error condition logic

Yongxing Mou (1):
      drm/panel-edp: Add support for BOE panel used in KD116N36-30NB-A001

Youssef Samir (5):
      accel/qaic: Add missing <linux/device-id/mhi.h> to sahara and timesync
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_drv.c
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_debugfs.c
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_ras.c
      accel/qaic: Add <linux/device-id/mhi.h> to qaic_ssr.c

Zhenhao Wan (2):
      drm/nouveau: reject zero-size notifier object allocation
      drm/nouveau/svm: drain fault handler before freeing svmm

 .../bindings/display/panel/ilitek,ili7836a.yaml    |   58 +
 .../bindings/display/panel/novatek,nt36532.yaml    |   83 ++
 .../panel/samsung,s6e8aa5x01-ams561ra01.yaml       |    2 +-
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
 drivers/gpu/buddy.c                                | 1345 ++++++++++++++------
 drivers/gpu/drm/adp/adp_drv.c                      |    2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   28 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   85 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |   27 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h  |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  255 +---
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
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    4 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |    1 -
 drivers/gpu/drm/bridge/chipone-icn6211.c           |    8 +-
 drivers/gpu/drm/bridge/ite-it6505.c                |    4 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |    4 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |    4 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |    3 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |    4 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |    2 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    4 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |   45 +-
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
 drivers/gpu/drm/drm_edid.c                         |  189 ++-
 drivers/gpu/drm/drm_gem_atomic_helper.c            |   80 +-
 drivers/gpu/drm/drm_of.c                           |   38 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |   37 +-
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |    3 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |    3 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    3 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |    2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |   10 +-
 drivers/gpu/drm/gud/gud_drv.c                      |    2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |    2 +-
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
 drivers/gpu/drm/panthor/panthor_gpu.c              |  117 +-
 drivers/gpu/drm/panthor/panthor_mmu.c              |   39 +-
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
 include/drm/display/drm_hdmi_state_helper.h        |    3 +
 include/drm/display/drm_scdc.h                     |   21 +-
 include/drm/display/drm_scdc_helper.h              |  103 +-
 include/drm/drm_colorop.h                          |  127 ++
 include/drm/drm_connector.h                        |   69 +-
 include/drm/drm_gem_atomic_helper.h                |   11 +-
 include/drm/drm_mipi_dbi.h                         |    2 +-
 include/drm/drm_print.h                            |    3 +
 include/drm/drm_simple_kms_helper.h                |    6 +-
 include/linux/gpu_buddy.h                          |  101 +-
 include/sound/omap-hdmi-audio.h                    |    1 +
 include/uapi/drm/drm_mode.h                        |   12 +
 kernel/cgroup/dmem.c                               |    4 +-
 sound/soc/ti/omap-hdmi.c                           |   52 +-
 272 files changed, 5652 insertions(+), 3322 deletions(-)
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
