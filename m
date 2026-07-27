Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6F5C531FC
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482A610E424;
	Mon, 27 Jul 2026 14:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aL9HE5lf";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B599510E424
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=LV9515Eo124m+s+bMGZhydKnLoqTNcA+ZyjkLF4O3Bg=; b=aL9HE5lfkbOdIjHjmsw6LU03wM
 mvOOkt6xQS00TQ16PuRBu6FOfT2DtiShQObv+ZJ/nnoqWvtZJaFeM3HZjNKZG6xDOgMysY2SlhCIJ
 TphfwEQrJmdSl3s7cVSdHh0W/CfZwzDwPPKKAdaTMLQyAnc4dGO5L+XV8gKhwQTZk0xhcEMI7z2kk
 Zs5/ynlIVK53E85tkW4piBQL/XX2ZuSFItQwScrjy2m/zM63TyVbIpzoeyQS5nLE/SZZLAaWEdX60
 n7uWIT8uOyohrkjSiOA3cv68+Lm7sFuMSL9ljl0yf3qtNNNgDB3uIOS9zXyI/vJ4d6RpIaOgo2fyU
 50blxL5A==;
Received: from [187.36.208.132] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1woMNo-006B5g-14; Mon, 27 Jul 2026 16:32:44 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 27 Jul 2026 11:32:29 -0300
Subject: [PATCH RESEND v2 2/2] drm/vc4: Zero the tile state data array
 before each BIN job
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-vc4-bin-oom-fixes-v2-2-0d8a5eddc7c9@igalia.com>
References: <20260727-vc4-bin-oom-fixes-v2-0-0d8a5eddc7c9@igalia.com>
In-Reply-To: <20260727-vc4-bin-oom-fixes-v2-0-0d8a5eddc7c9@igalia.com>
To: Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3679; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=dWOhq4vj1voznDDgyaSr7a6vuOXR1PUmuFeTCZA9pQk=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqZ2wBudZ63cfxwkGsh7ZWJtTVahMoJgUlFTvVL
 8n8fThL8v6JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCamdsAQAKCRA/8w6Kdoj6
 qo7KCADOhWxRLzQgIahqkNwvzDVafI1brEoNOTNT+VszbYYGkXSthX8p3oePeJboRf/+fHjBXPD
 x0izRMStnn3QbdNsl56XEPgSKzSr1HPKKtpQsNBLA/0GUDccBWeteS8AGAeukErlVLNiYlGUQ4p
 B+hoOLjCNIxPHKE3hwR5Ep7Dhpz3SegswobLQpOdFQZNl0Aug6ipZy1Q2u1lip6TSkWSESp17fm
 u2VTUTYVBeGRiwbfHl7jFbVdt+0Cy2q9SuavVgnSZ/8z+XmKiqZMXQJidCxa4Oj2Yy0LwqsF8Dv
 ZRtz8MNdfyn+af9ivtGCCLUX/ULJJ5cJQ9JyfT4bjd1qNIlU
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The binner BO is a single 16MB buffer split into 512KB slots that are
handed out to jobs at submission time and recycled as jobs complete,
without ever being cleared. Each slot holds the job's Tile State Data
Array (TSDA) at its start, followed by the tile allocation pool.

While the tile allocation pool is only walked by the render thread
through branches the binner generated during the current job, the
TSDA is the PTB's own per-tile bookkeeping and is consumed by the
hardware itself. Although the kernel sets the "Auto-initialise Tile
State Data Array" flag in the tile binning mode configuration, the
PTB demonstrably still acts on stale tile state left by the slot's
previous user: the binner ends up creating invalid command streams
with invalid primitive streams and branches, which can cause GPU hangs
as observed in [1][2].

Zero the TSDA when the job's binning slot is configured. This clears
48 bytes per tile (~24KB for a 1080p frame) in the submission path, and
guarantees the PTB never sees another job's tile state.

The tile count is only checked for being non-zero today, so the 8-bit
fields it comes from can describe a tile state array almost six times
larger than the slot it has to live in. Bound it before the slot is
handed out, since such size decides how much of the slot is left for
the tile alloc pool.

Link: https://github.com/raspberrypi/linux/issues/3221 [1]
Link: https://github.com/raspberrypi/linux/issues/5780 [2]
Fixes: 553c942f8b2c ("drm/vc4: Allow using more than 256MB of CMA memory.")
Cc: stable@vger.kernel.org
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_validate.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index 7f2fadfde7a8..d2a65c968b1f 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -385,6 +385,23 @@ validate_tile_binning_config(VALIDATE_ARGS)
 		return -EINVAL;
 	}
 
+	/* The tile state data array is 48 bytes per tile, and we put it at
+	 * the start of a BO containing both it and the tile alloc.
+	 */
+	tile_state_size = 48 * tile_count;
+
+	/* Since the tile alloc array will follow us, align. */
+	tile_state_size = roundup(tile_state_size, 4096);
+
+	/* Reject configurations whose tile state would leave no room for
+	 * the tile alloc pool that follows it in the slot.
+	 */
+	if (tile_state_size >= vc4->bin_alloc_size) {
+		DRM_DEBUG("Tile binning config of %dx%d too large\n",
+			  exec->bin_tiles_x, exec->bin_tiles_y);
+		return -EINVAL;
+	}
+
 	bin_slot = vc4_v3d_get_bin_slot(vc4);
 	if (bin_slot < 0) {
 		if (bin_slot != -EINTR && bin_slot != -ERESTARTSYS) {
@@ -400,13 +417,13 @@ validate_tile_binning_config(VALIDATE_ARGS)
 	exec->bin_slots |= BIT(bin_slot);
 	bin_addr = vc4->bin_bo->base.dma_addr + bin_slot * vc4->bin_alloc_size;
 
-	/* The tile state data array is 48 bytes per tile, and we put it at
-	 * the start of a BO containing both it and the tile alloc.
-	 */
-	tile_state_size = 48 * tile_count;
+	exec->tile_alloc_offset = bin_addr + tile_state_size;
 
-	/* Since the tile alloc array will follow us, align. */
-	exec->tile_alloc_offset = bin_addr + roundup(tile_state_size, 4096);
+	/* The TSDA area must be zeroed out before use, otherwise the PTB might
+	 * consume a stale tile state.
+	 */
+	memset(vc4->bin_bo->base.vaddr + bin_slot * vc4->bin_alloc_size, 0,
+	       tile_state_size);
 
 	*(uint8_t *)(validated + 14) =
 		((flags & ~(VC4_BIN_CONFIG_ALLOC_INIT_BLOCK_SIZE_MASK |

-- 
2.55.0

