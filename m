Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C5EC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 03:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4948810E4C1;
	Fri, 17 Jul 2026 03:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="jnpIKQpE";
	dkim-atps=neutral
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931C510E4C4;
 Fri, 17 Jul 2026 03:35:32 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
 by smtp.qiye.163.com (Hmail) with ESMTP id 46879f812;
 Fri, 17 Jul 2026 11:30:26 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kevinyang.wang@amd.com,
 kenneth.feng@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, runyu.xiao@seu.edu.cn
Subject: [RFC PATCH v2 2/5] drm/amdgpu: convert 32-bit ring writeback accesses
 to helpers
Date: Fri, 17 Jul 2026 11:30:06 +0800
Message-Id: <20260717033009.649538-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
References: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f6e201dfb03a1kunm4f30d1372210b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGRoaVhhLQx5MT0pMHx8eGVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=jnpIKQpEOfSBeKlS5RJdFJQV6qYElGXqG2gdsykLgV5waZ5Tv16efUiOS2+Cw/sLE637iHcQ0heSZvFKf9gmLg/Ry4IhDLke1OrTD2Cp6q0AZJMGLLopX9CnPA4racAIhh786ZsyzDEOxrS/viHSuFhdhHkTHKv+1XOZ49cWRV8=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=7obJpam+ipbtcFPLGEBs+2Mp+UQF3RkCehPGRBygpjo=;
 h=date:mime-version:subject:message-id:from;
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

Convert the ring writeback users that already operate on 32-bit slots to
the new typed helper accessors.

These call sites currently use open-coded pointer dereferences for
32-bit rptr and wptr writeback slots. Switch them to the helper wrappers
so the slot width is explicit and the remaining 64-bit users are
separated more clearly from the 32-bit ones.

This is a preparatory cleanup for the later ring writeback type cleanup
and the MES reset fix. No functional change is intended.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  5 ++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 11 ++++-------
 drivers/gpu/drm/amd/amdgpu/si_dma.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  4 ++--
 31 files changed, 79 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 004edc28d..a9fa502d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -500,7 +500,7 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int count)
 	mutex_lock(&ring->adev->cper.ring_lock);
 
 	wptr_old = ring->wptr;
-	rptr = *ring->rptr_cpu_addr & ring->ptr_mask;
+	rptr = amdgpu_ring_wb_read32(ring->rptr_cpu_addr) & ring->ptr_mask;
 
 	while (count) {
 		ent_sz = amdgpu_cper_ring_get_ent_sz(ring, ring->wptr);
@@ -528,7 +528,7 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int count)
 
 			rptr += (ent_sz >> 2);
 			rptr &= ring->ptr_mask;
-			*ring->rptr_cpu_addr = rptr;
+			amdgpu_ring_wb_write32(ring->rptr_cpu_addr, rptr);
 
 			pos = rptr;
 		} while (!amdgpu_cper_is_hdr(ring, rptr));
@@ -541,7 +541,7 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int count)
 
 static u64 amdgpu_cper_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return *(ring->rptr_cpu_addr);
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 amdgpu_cper_ring_get_wptr(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 80fbbcbe2..b0c44d8a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -320,7 +320,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		amdgpu_ring_get_cpu_addr(ring, ring->cond_exe_offs);
 
 	/* always set cond_exec_polling to CONTINUE */
-	*ring->cond_exe_cpu_addr = 1;
+	amdgpu_ring_wb_write32(ring->cond_exe_cpu_addr, 1);
 
 	if (ring->funcs->type != AMDGPU_RING_TYPE_CPER) {
 		r = amdgpu_fence_driver_start_ring(ring, irq_src, irq_type);
@@ -341,7 +341,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		ring->ring_size = roundup_pow_of_two(max_dw * 4);
 		ring->count_dw = (ring->ring_size - 4) >> 2;
 		/* ring buffer is empty now */
-		ring->wptr = *ring->rptr_cpu_addr = 0;
+		ring->wptr = 0;
+		amdgpu_ring_wb_write32(ring->rptr_cpu_addr, 0);
 	}
 
 	ring->buf_mask = (ring->ring_size / 4) - 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index cdc855285..82c6bc782 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -503,7 +503,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 static inline void amdgpu_ring_set_preempt_cond_exec(struct amdgpu_ring *ring,
 							bool cond_exec)
 {
-	*ring->cond_exe_cpu_addr = cond_exec;
+	amdgpu_ring_wb_write32(ring->cond_exe_cpu_addr, cond_exec);
 }
 
 static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 120da838a..e68b1a03f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -161,7 +161,7 @@ static uint64_t cik_sdma_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	u32 rptr;
 
-	rptr = *ring->rptr_cpu_addr;
+	rptr = amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 
 	return (rptr & 0x3fffc) >> 2;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index ac90d8e9d..40a99ca6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2188,7 +2188,7 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)
 
 static u64 gfx_v6_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return *ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 gfx_v6_0_ring_get_wptr(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 65b8497ad..1a335691b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2586,7 +2586,7 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
 
 static u64 gfx_v7_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return *ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 gfx_v7_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
@@ -2607,7 +2607,7 @@ static void gfx_v7_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 static u64 gfx_v7_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
 	/* XXX check if swapping is necessary on BE */
-	return *ring->wptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 }
 
 static void gfx_v7_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
@@ -2615,7 +2615,7 @@ static void gfx_v7_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	/* XXX check if swapping is necessary on BE */
-	*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+	amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 	WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 130196859..64511ee05 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6009,7 +6009,7 @@ static int gfx_v8_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 
 static u64 gfx_v8_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return *ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 gfx_v8_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
@@ -6018,7 +6018,7 @@ static u64 gfx_v8_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell)
 		/* XXX check if swapping is necessary on BE */
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32(mmCP_RB0_WPTR);
 }
@@ -6029,7 +6029,7 @@ static void gfx_v8_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32(mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
@@ -6220,7 +6220,7 @@ static void gfx_v8_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 
 static u64 gfx_v8_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
-	return *ring->wptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 }
 
 static void gfx_v8_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
@@ -6228,7 +6228,7 @@ static void gfx_v8_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	/* XXX check if swapping is necessary on BE */
-	*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+	amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 	WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index cffb1e6ba..8f1a2f3ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -430,7 +430,7 @@ static uint64_t jpeg_v2_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR);
 }
@@ -447,7 +447,7 @@ static void jpeg_v2_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5208312e7..d34670dc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -458,7 +458,7 @@ static uint64_t jpeg_v2_5_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(JPEG, ring->me, mmUVD_JRBC_RB_WPTR);
 }
@@ -475,7 +475,7 @@ static void jpeg_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(JPEG, ring->me, mmUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index d0445df39..77a32e2a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -449,7 +449,7 @@ static uint64_t jpeg_v3_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR);
 }
@@ -466,7 +466,7 @@ static void jpeg_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 6fd4238a8..4142341bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -609,7 +609,7 @@ static uint64_t jpeg_v4_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR);
 }
@@ -626,7 +626,7 @@ static void jpeg_v4_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 0c746580d..1f5a9ddd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -693,7 +693,7 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 
 	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_WPTR,
 				   jpeg_v4_0_3_core_reg_offset(ring->pipe));
@@ -718,7 +718,7 @@ static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_WPTR,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index a43582b9c..ffcf70969 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -625,7 +625,7 @@ static uint64_t jpeg_v4_0_5_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(JPEG, ring->me, regUVD_JRBC_RB_WPTR);
 }
@@ -642,7 +642,7 @@ static void jpeg_v4_0_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(JPEG, ring->me, regUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
@@ -870,4 +870,3 @@ const struct amdgpu_ip_block_version jpeg_v4_0_5_ip_block = {
 	.rev = 5,
 	.funcs = &jpeg_v4_0_5_ip_funcs,
 };
-
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 72a4b2d06..3b7c1144b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -535,7 +535,7 @@ static uint64_t jpeg_v5_0_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR);
 }
@@ -552,7 +552,7 @@ static void jpeg_v5_0_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 250316704..d0e9e792a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -626,7 +626,7 @@ static uint64_t jpeg_v5_0_1_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 
 	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC_RB_WPTR,
 				   ring->pipe ? jpeg_v5_0_1_core_reg_offset(ring->pipe) : 0);
@@ -644,7 +644,7 @@ static void jpeg_v5_0_1_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me),
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 7a4ecea6b..6286fdb29 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -469,7 +469,7 @@ static uint64_t jpeg_v5_0_2_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return adev->wb.wb[ring->wptr_offs];
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 
 	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC_RB_WPTR,
 				   ring->pipe ? jpeg_v5_0_2_core_reg_offset(ring->pipe) : 0);
@@ -487,7 +487,7 @@ static void jpeg_v5_0_2_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me),
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index e7546816b..a1671e9b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -518,7 +518,7 @@ static uint64_t jpeg_v5_3_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR);
 }
@@ -535,7 +535,7 @@ static void jpeg_v5_3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 93ec52c1f..22cb3c262 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -188,7 +188,7 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 static uint64_t sdma_v2_4_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	/* XXX check if swapping is necessary on BE */
-	return *ring->rptr_cpu_addr >> 2;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr) >> 2;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 3fde9be74..321fc87d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -346,7 +346,7 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 static uint64_t sdma_v3_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	/* XXX check if swapping is necessary on BE */
-	return *ring->rptr_cpu_addr >> 2;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr) >> 2;
 }
 
 /**
@@ -363,7 +363,7 @@ static uint64_t sdma_v3_0_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell || ring->use_pollmem) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = *ring->wptr_cpu_addr >> 2;
+		wptr = amdgpu_ring_wb_read32(ring->wptr_cpu_addr) >> 2;
 	} else {
 		wptr = RREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me]) >> 2;
 	}
@@ -383,14 +383,11 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		u32 *wb = (u32 *)ring->wptr_cpu_addr;
 		/* XXX check if swapping is necessary on BE */
-		WRITE_ONCE(*wb, ring->wptr << 2);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, ring->wptr << 2);
 		WDOORBELL32(ring->doorbell_index, ring->wptr << 2);
 	} else if (ring->use_pollmem) {
-		u32 *wb = (u32 *)ring->wptr_cpu_addr;
-
-		WRITE_ONCE(*wb, ring->wptr << 2);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, ring->wptr << 2);
 	} else {
 		WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], ring->wptr << 2);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 549708075..a4ac288df 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -48,7 +48,7 @@ static void si_dma_set_irq_funcs(struct amdgpu_device *adev);
  */
 static uint64_t si_dma_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return *ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index df2c83348..6979f6816 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -118,7 +118,7 @@ static uint64_t uvd_v7_0_enc_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 
 	if (ring == &adev->uvd.inst[ring->me].ring_enc[0])
 		return RREG32_SOC15(UVD, ring->me, mmUVD_RB_WPTR);
@@ -153,7 +153,7 @@ static void uvd_v7_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		return;
 	}
@@ -760,7 +760,7 @@ static int uvd_v7_0_mmsch_start(struct amdgpu_device *adev,
 		if (adev->uvd.harvest_config & (1 << i))
 			continue;
 		WDOORBELL32(adev->uvd.inst[i].ring_enc[0].doorbell_index, 0);
-		*adev->uvd.inst[i].ring_enc[0].wptr_cpu_addr = 0;
+		amdgpu_ring_wb_write32(adev->uvd.inst[i].ring_enc[0].wptr_cpu_addr, 0);
 		adev->uvd.inst[i].ring_enc[0].wptr = 0;
 		adev->uvd.inst[i].ring_enc[0].wptr_old = 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index ee445d8ab..afb128312 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -83,7 +83,7 @@ static uint64_t vce_v4_0_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 
 	if (ring->me == 0)
 		return RREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_RB_WPTR));
@@ -106,7 +106,7 @@ static void vce_v4_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		return;
 	}
@@ -177,7 +177,7 @@ static int vce_v4_0_mmsch_start(struct amdgpu_device *adev,
 	WREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_MMSCH_VF_MAILBOX_RESP), 0);
 
 	WDOORBELL32(adev->vce.ring[0].doorbell_index, 0);
-	*adev->vce.ring[0].wptr_cpu_addr = 0;
+	amdgpu_ring_wb_write32(adev->vce.ring[0].wptr_cpu_addr, 0);
 	adev->vce.ring[0].wptr = 0;
 	adev->vce.ring[0].wptr_old = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 0442bfcfd..830c02af9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1441,7 +1441,7 @@ static uint64_t vcn_v2_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
 }
@@ -1462,7 +1462,7 @@ static void vcn_v2_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 			lower_32_bits(ring->wptr) | 0x80000000);
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR, lower_32_bits(ring->wptr));
@@ -1670,12 +1670,12 @@ static uint64_t vcn_v2_0_enc_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst->ring_enc[0]) {
 		if (ring->use_doorbell)
-			return *ring->wptr_cpu_addr;
+			return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 		else
 			return RREG32_SOC15(UVD, 0, mmUVD_RB_WPTR);
 	} else {
 		if (ring->use_doorbell)
-			return *ring->wptr_cpu_addr;
+			return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 		else
 			return RREG32_SOC15(UVD, 0, mmUVD_RB_WPTR2);
 	}
@@ -1694,14 +1694,14 @@ static void vcn_v2_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst->ring_enc[0]) {
 		if (ring->use_doorbell) {
-			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+			amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 		}
 	} else {
 		if (ring->use_doorbell) {
-			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+			amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 8b8184fe6..f55d488dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1751,7 +1751,7 @@ static uint64_t vcn_v2_5_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(VCN, ring->me, mmUVD_RBC_RB_WPTR);
 }
@@ -1768,7 +1768,7 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(VCN, ring->me, mmUVD_RBC_RB_WPTR, lower_32_bits(ring->wptr));
@@ -1837,12 +1837,12 @@ static uint64_t vcn_v2_5_enc_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst[ring->me].ring_enc[0]) {
 		if (ring->use_doorbell)
-			return *ring->wptr_cpu_addr;
+			return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 		else
 			return RREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR);
 	} else {
 		if (ring->use_doorbell)
-			return *ring->wptr_cpu_addr;
+			return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 		else
 			return RREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR2);
 	}
@@ -1861,14 +1861,14 @@ static void vcn_v2_5_enc_ring_set_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst[ring->me].ring_enc[0]) {
 		if (ring->use_doorbell) {
-			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+			amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 		}
 	} else {
 		if (ring->use_doorbell) {
-			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+			amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 81bba3ec2..1c589b455 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1819,7 +1819,7 @@ static uint64_t vcn_v3_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(VCN, ring->me, mmUVD_RBC_RB_WPTR);
 }
@@ -1845,7 +1845,7 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(VCN, ring->me, mmUVD_RBC_RB_WPTR, lower_32_bits(ring->wptr));
@@ -2099,12 +2099,12 @@ static uint64_t vcn_v3_0_enc_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst[ring->me].ring_enc[0]) {
 		if (ring->use_doorbell)
-			return *ring->wptr_cpu_addr;
+			return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 		else
 			return RREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR);
 	} else {
 		if (ring->use_doorbell)
-			return *ring->wptr_cpu_addr;
+			return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 		else
 			return RREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR2);
 	}
@@ -2123,14 +2123,14 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
 
 	if (ring == &adev->vcn.inst[ring->me].ring_enc[0]) {
 		if (ring->use_doorbell) {
-			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+			amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 		}
 	} else {
 		if (ring->use_doorbell) {
-			*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+			amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
 			WREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ff7269baf..ec4b2372a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1770,7 +1770,7 @@ static uint64_t vcn_v4_0_unified_ring_get_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR);
 }
@@ -1790,7 +1790,7 @@ static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 7f001c32e..ce33ba358 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1580,7 +1580,7 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(VCN, GET_INST(VCN, ring->me),
 				    regUVD_RB_WPTR);
@@ -1646,7 +1646,7 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_WPTR,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 1571cc5a1..41d4b5ac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1434,7 +1434,7 @@ static uint64_t vcn_v4_0_5_unified_ring_get_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR);
 }
@@ -1454,7 +1454,7 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d5f49fa33..f8c3cd250 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1158,7 +1158,7 @@ static uint64_t vcn_v5_0_0_unified_ring_get_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR);
 }
@@ -1178,7 +1178,7 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR, lower_32_bits(ring->wptr));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index d3db04943..33e63ca12 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1273,7 +1273,7 @@ static uint64_t vcn_v5_0_1_unified_ring_get_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_WPTR);
 }
@@ -1293,7 +1293,7 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_WPTR,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index bbc172db9..6b943a27e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -962,7 +962,7 @@ static uint64_t vcn_v5_0_2_unified_ring_get_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell)
-		return *ring->wptr_cpu_addr;
+		return amdgpu_ring_wb_read32(ring->wptr_cpu_addr);
 	else
 		return RREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_WPTR);
 }
@@ -982,7 +982,7 @@ static void vcn_v5_0_2_unified_ring_set_wptr(struct amdgpu_ring *ring)
 		DRM_ERROR("wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
-		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		amdgpu_ring_wb_write32(ring->wptr_cpu_addr, lower_32_bits(ring->wptr));
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
 		WREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_WPTR,
-- 
2.34.1

