Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C82C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A25E10E5CB;
	Sat, 18 Jul 2026 17:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BWwaf0iC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94EF510E5C9
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=8D9yvYeYOOKa+ZRDj1amJqvAZMZbXyhwOeCMFXj2fZw=; b=BWwaf0iCPoiUjwfBOALehHEuJS
 Q3s0sTE1hdWEeZa+li0axYuFtAirejuwlVJO90MAJ9FPJAFsMFKzHGB9SWXcg+rKUaEAopFWiuJGa
 Zr03+GySPGrO+PEGgVJqz2RGTn1edZocyK8OIqStXKSjLCfHuaqHMCzbKP4zqDyjOOSCwipQNmOfY
 IpqzjEDczVl+Y+Ag36LQzB6dydFk3XAgYtXaPa29WkmKGhE9d9//rJxx6+7b1cMUSmbpC+wdOrExy
 faS4thGNrCENMpbrasXBN7uHNEgs2tZja/e40rrNGrhfie/cpcQOeoHGov6Mk8kqZ/toGIt82vF5Z
 Dqwxkiew==;
Received: from [189.7.87.67] (helo=[192.168.0.16])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wl8qL-00HVLn-T4; Sat, 18 Jul 2026 19:28:54 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 18 Jul 2026 14:28:36 -0300
Subject: [PATCH 3/3] drm/vc4: Dynamically size the initial tile-alloc block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260718-vc4-bin-oom-fixes-v1-3-8cba09558c33@igalia.com>
References: <20260718-vc4-bin-oom-fixes-v1-0-8cba09558c33@igalia.com>
In-Reply-To: <20260718-vc4-bin-oom-fixes-v1-0-8cba09558c33@igalia.com>
To: Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Iago Toral <itoral@igalia.com>, Emma Anholt <anholt@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5889; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=799WMY+EHe43hhr7PqIMPEnqOVR3A8MkNZhFFOcdQbQ=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqW7fHAwehq8Lm3Y65wIjj3Uu9yK7G3j9RTniH6
 QuX4pSZyWWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCalu3xwAKCRA/8w6Kdoj6
 qryBB/9bZIdd2gt2QkI4s01kITJ+E6unETdLWIIt9jUdGw8gxbCQqOyxryWo/GHkydX7VzvpsBc
 WTrb5yFmCDluLVWU1jnFgayka5ystvq4CIiqD8YF3nQwbGHOH+0SKOkYwFYGPPlDWRD6SSSKxyk
 8cITeXRBM1u9LV4uGY5Mq62qFjVuLsmkOFEu5oJWDjjhZ5ZND+C3Tnw2mhtS4y5iqfW+QpO8mCO
 6HBUsEQWadSOxp2vPg4g9Zkh85QOl/FLUpfAOWdkgMpe3zSkzkGUKFD6m6ijLswzWbrM0P71hqr
 gAC8SHnkFiDytMlia8s7tdZBaZ0bMeaEH68GW69mOEzvpFls
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

The binner writes each tile's binned command list into an initial
tile-allocation block and, when that list outgrows the block, continues
it into a chain of continuation blocks. On VC4 the hardware does not link
that chain reliably: the render thread that later walks it desyncs -- it
has been seen to fetch an invalid opcode partway through a block (CT1CS
reports CTERR) or to follow the chain into never-written memory and stall
-- and hangcheck then resets the GPU.

The chain is only walked once a tile spills its initial block, so the
problem scales with how small that block is. The continuation-block size
is not the lever: the hang reproduces with both 32- and 128-byte
continuation blocks. Enlarging the *initial* block is what helps, as it
keeps more tiles' lists in that block and off the chain entirely, and 256
bytes is the hardware maximum.

A fixed 256-byte block cannot be used unconditionally, though. The
tile_count initial blocks are laid out contiguously right after the tile
state and must fit within the binner slot, and the render thread reaches
each tile's list by a fixed per-tile stride. If the blocks did not fit,
the later ones would land at a non-contiguous address and that stride
would point at the wrong memory. So pick the largest initial block (256,
128, 64 or 32 bytes) that still fits the slot for the job's tile count,
and program the RCL branch stride to match.

This is a mitigation for a hardware limitation, not a complete fix: a
single tile whose list exceeds even a 256-byte block, or a scene dense
enough to force a smaller initial block, can still reach the chain and
hang. But the case users have reported in EmulationStation's 1080p
transitions between consoles, which previously stormed "Resetting GPU",
now runs with zero resets.

Link: https://github.com/raspberrypi/linux/issues/3221
Link: https://github.com/raspberrypi/linux/issues/5780
Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h       |  5 +++++
 drivers/gpu/drm/vc4/vc4_render_cl.c |  3 ++-
 drivers/gpu/drm/vc4/vc4_validate.c  | 29 ++++++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 0f5958c1e6b6..854204b096b6 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -743,6 +743,11 @@ struct vc4_exec_info {
 	 * (where each tile's binned CL will start)
 	 */
 	uint32_t tile_alloc_offset;
+	/* Stride between adjacent tiles' initial alloc blocks. Equals the
+	 * initial block size programmed in the binning config, and is used
+	 * as the per-tile stride when emitting the RCL branches.
+	 */
+	u32 tile_alloc_stride;
 	/* Bitmask of which binner slots are freed when this job completes. */
 	uint32_t bin_slots;
 
diff --git a/drivers/gpu/drm/vc4/vc4_render_cl.c b/drivers/gpu/drm/vc4/vc4_render_cl.c
index c264d21bc3fe..be150bad676f 100644
--- a/drivers/gpu/drm/vc4/vc4_render_cl.c
+++ b/drivers/gpu/drm/vc4/vc4_render_cl.c
@@ -184,7 +184,8 @@ static void emit_tile(struct vc4_exec_info *exec,
 	if (has_bin) {
 		rcl_u8(setup, VC4_PACKET_BRANCH_TO_SUB_LIST);
 		rcl_u32(setup, (exec->tile_alloc_offset +
-				(y * exec->bin_tiles_x + x) * 32));
+				(y * exec->bin_tiles_x + x) *
+				exec->tile_alloc_stride));
 	}
 
 	if (setup->msaa_color_write) {
diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index 7f2fadfde7a8..3961cf38fc2a 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -357,8 +357,9 @@ validate_tile_binning_config(VALIDATE_ARGS)
 	struct drm_device *dev = exec->exec_bo->base.dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	uint8_t flags;
-	uint32_t tile_state_size;
+	u32 tile_state_size, tile_state_aligned;
 	uint32_t tile_count, bin_addr;
+	u8 init_block;
 	int bin_slot;
 
 	if (exec->found_tile_binning_mode_config_packet) {
@@ -406,13 +407,35 @@ validate_tile_binning_config(VALIDATE_ARGS)
 	tile_state_size = 48 * tile_count;
 
 	/* Since the tile alloc array will follow us, align. */
-	exec->tile_alloc_offset = bin_addr + roundup(tile_state_size, 4096);
+	tile_state_aligned = roundup(tile_state_size, 4096);
+	exec->tile_alloc_offset = bin_addr + tile_state_aligned;
+
+	/*
+	 * Pick the largest initial tile-alloc block that still fits the slot.
+	 * Larger initial blocks keep more tiles' binned lists off the
+	 * continuation-block chain, which the binner does not always link
+	 * reliably. Denser tile counts fall back to smaller blocks, down to
+	 * the 32-byte minimum which always fits.
+	 */
+	if (tile_state_aligned + 256 * tile_count <= vc4->bin_alloc_size) {
+		exec->tile_alloc_stride = 256;
+		init_block = VC4_BIN_CONFIG_ALLOC_INIT_BLOCK_SIZE_256;
+	} else if (tile_state_aligned + 128 * tile_count <= vc4->bin_alloc_size) {
+		exec->tile_alloc_stride = 128;
+		init_block = VC4_BIN_CONFIG_ALLOC_INIT_BLOCK_SIZE_128;
+	} else if (tile_state_aligned + 64 * tile_count <= vc4->bin_alloc_size) {
+		exec->tile_alloc_stride = 64;
+		init_block = VC4_BIN_CONFIG_ALLOC_INIT_BLOCK_SIZE_64;
+	} else {
+		exec->tile_alloc_stride = 32;
+		init_block = VC4_BIN_CONFIG_ALLOC_INIT_BLOCK_SIZE_32;
+	}
 
 	*(uint8_t *)(validated + 14) =
 		((flags & ~(VC4_BIN_CONFIG_ALLOC_INIT_BLOCK_SIZE_MASK |
 			    VC4_BIN_CONFIG_ALLOC_BLOCK_SIZE_MASK)) |
 		 VC4_BIN_CONFIG_AUTO_INIT_TSDA |
-		 VC4_SET_FIELD(VC4_BIN_CONFIG_ALLOC_INIT_BLOCK_SIZE_32,
+		 VC4_SET_FIELD(init_block,
 			       VC4_BIN_CONFIG_ALLOC_INIT_BLOCK_SIZE) |
 		 VC4_SET_FIELD(VC4_BIN_CONFIG_ALLOC_BLOCK_SIZE_128,
 			       VC4_BIN_CONFIG_ALLOC_BLOCK_SIZE));

-- 
2.55.0

