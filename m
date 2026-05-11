Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3B1CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5280610E71D;
	Mon, 11 May 2026 13:29:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19DBE10E71D
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:29:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3EE8960129;
 Mon, 11 May 2026 13:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA752C2BCB0;
 Mon, 11 May 2026 13:28:55 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] Revert "drm/imagination: Warn or error on unsupported
 hardware"
Date: Mon, 11 May 2026 15:28:39 +0200
Message-ID: <caf5e011a5b3fbdbab8c50d064bc8342212d5cc1.1778505897.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
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

Revert commit 1c21f240fbc1e47b94e68abfa2da2c01ed29a74d, as it stopped
the driver from working on various Renesas R-Car SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
DT binding documentation updates were reviewed by the drm/imagination
maintainers[1][2][3], DTS additions were reviewed and/or acked by the
drm/imagination maintainers[4][5][6], and firmware is available[7].
Note that the GPU nodes were not enabled in board DTS files before, as
not having suitable firmware installed under /lib/firmware could trigger
a crash, not directly related to drm/imagination driver support.  This
was fixed only recently in v7.1-rc3[8], so board enablement[9] is now
unblocked.

[1] commit 18ff1dc462ef6dac ("dt-bindings: gpu: img,powervr-rogue:
    Document GX6250 GPU in Renesas R-Car M3-W/M3-W+")
[2] commit 6126a7f27f002408 ("dt-bindings: gpu: img,powervr-rogue:
    Document GE7800 GPU in Renesas R-Car M3-N")
[3] commit 67549b73f10b8517 ("dt-bindings: gpu: img,powervr-rogue:
    Document GE7800 GPU in Renesas R-Car V3U")
[4] commit 73100fa8e4ce21cc ("arm64: dts: renesas: r8a77960: Add GX6250
    GPU node")
[5] commit 6e20a9d94a459b4e ("arm64: dts: renesas: r8a77961: Add GX6250
    GPU node")
[6] commit 303a5185e024ee62 ("arm64: dts: renesas: r8a77965: Add GE7800
    GPU node")
[7] https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/powervr/powervr
[8] commit 26735dfdd8930d9e ("pmdomain: core: Fix detach procedure for
virtual devices in genpd")
[9] https://lore.kernel.org/all/20251027211249.95826-1-marek.vasut+renesas@mailbox.org/
---
 drivers/gpu/drm/imagination/pvr_device.c | 73 +-----------------------
 1 file changed, 1 insertion(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index dbb6f5a8ded12a42..b7984563627de753 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -508,77 +508,6 @@ pvr_gpuid_decode_string(const struct pvr_device *pvr_dev,
 }
 EXPORT_SYMBOL_IF_KUNIT(pvr_gpuid_decode_string);
 
-static bool pvr_exp_hw_support;
-module_param_named(exp_hw_support, pvr_exp_hw_support, bool, 0600);
-MODULE_PARM_DESC(exp_hw_support, "Bypass runtime checks for fully supported GPU cores. WARNING: enabling this option may result in a buggy, insecure, or otherwise unusable driver.");
-
-/**
- * enum pvr_gpu_support_level - The level of support for a gpu_id in the current
- * version of the driver.
- *
- * @PVR_GPU_UNKNOWN: Cores that are unknown to the driver. These may not even exist.
- * @PVR_GPU_EXPERIMENTAL: Cores that have experimental support.
- * @PVR_GPU_SUPPORTED: Cores that are supported and maintained.
- */
-enum pvr_gpu_support_level {
-	PVR_GPU_UNKNOWN,
-	PVR_GPU_EXPERIMENTAL,
-	PVR_GPU_SUPPORTED,
-};
-
-static enum pvr_gpu_support_level
-pvr_gpu_support_level(const struct pvr_gpu_id *gpu_id)
-{
-	switch (pvr_gpu_id_to_packed_bvnc(gpu_id)) {
-	case PVR_PACKED_BVNC(33, 15, 11, 3):
-	case PVR_PACKED_BVNC(36, 53, 104, 796):
-		return PVR_GPU_SUPPORTED;
-
-	case PVR_PACKED_BVNC(36, 52, 104, 182):
-		return PVR_GPU_EXPERIMENTAL;
-
-	default:
-		return PVR_GPU_UNKNOWN;
-	}
-}
-
-static int
-pvr_check_gpu_supported(struct pvr_device *pvr_dev,
-			const struct pvr_gpu_id *gpu_id)
-{
-	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
-
-	switch (pvr_gpu_support_level(gpu_id)) {
-	case PVR_GPU_SUPPORTED:
-		if (pvr_exp_hw_support)
-			drm_info(drm_dev, "Module parameter 'exp_hw_support' was set, but this hardware is fully supported by the current driver.");
-
-		break;
-
-	case PVR_GPU_EXPERIMENTAL:
-		if (!pvr_exp_hw_support) {
-			drm_err(drm_dev, "Unsupported GPU! Set 'exp_hw_support' to bypass this check.");
-			return -ENODEV;
-		}
-
-		drm_warn(drm_dev, "Running on unsupported hardware; you may encounter bugs!");
-		break;
-
-	/* NOTE: This code path may indicate misbehaving hardware. */
-	case PVR_GPU_UNKNOWN:
-	default:
-		if (!pvr_exp_hw_support) {
-			drm_err(drm_dev, "Unknown GPU! Set 'exp_hw_support' to bypass this check.");
-			return -ENODEV;
-		}
-
-		drm_warn(drm_dev, "Running on unknown hardware; expect issues.");
-		break;
-	}
-
-	return 0;
-}
-
 static char *pvr_gpuid_override;
 module_param_named(gpuid, pvr_gpuid_override, charp, 0400);
 MODULE_PARM_DESC(gpuid, "GPU ID (BVNC) to be used instead of the value read from hardware.");
@@ -609,7 +538,7 @@ pvr_load_gpu_id(struct pvr_device *pvr_dev)
 			return err;
 	}
 
-	return pvr_check_gpu_supported(pvr_dev, gpu_id);
+	return 0;
 }
 
 /**
-- 
2.43.0

