Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FE5C4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 03:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A26310E4C9;
	Fri, 17 Jul 2026 03:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="iq6QCAHb";
	dkim-atps=neutral
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E3910E4C1;
 Fri, 17 Jul 2026 03:35:34 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
 by smtp.qiye.163.com (Hmail) with ESMTP id 46879f815;
 Fri, 17 Jul 2026 11:30:28 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kevinyang.wang@amd.com,
 kenneth.feng@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, runyu.xiao@seu.edu.cn
Subject: [RFC PATCH v2 3/5] drm/amdgpu: convert 64-bit ring writeback accesses
 to helpers
Date: Fri, 17 Jul 2026 11:30:07 +0800
Message-Id: <20260717033009.649538-4-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
References: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f6e2024d203a1kunm4f30d1372210f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTh4fVhlKSUNOS0xMSEIYHVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=iq6QCAHbk7Ft8mS5wB7tW8qy/+7DAgYtgDoB102m8oo4exZCbff5jU6D+IC8+Zy8TFZ9bWhZfgWV09kHyUVj1yXBveP5u64FLkFgIqHgYesXG40y74okrRZbgO4JBlRTl+gcJfIW8UgJaG4SMTCYVMA2fcWdYQYs0FeT9KbxEIM=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=dLT+mVUrd+JVxV8J3gAEmb4SDo/4YjdxGRBXchfxq38=;
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

Convert the ring writeback users that operate on 64-bit slots to the new
typed helper accessors.

Current 64-bit writeback users still mix several different access
styles, including plain u64 casts, READ_ONCE()/WRITE_ONCE() on casted
pointers, and atomic64_t casts. Convert those users to the typed 64-bit
helpers so they all follow the same access model.

This also converts the related rptr read paths in the same set of users,
so both rptr and wptr accesses to 64-bit writeback slots are handled
consistently before changing the stored pointer types in struct
amdgpu_ring.

This is a cleanup only. No functional change is intended.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 18 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 18 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 18 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c   |  9 ++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  7 +++----
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |  7 +++----
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 20 ++++++++------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 14 +++++---------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 13 ++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 15 +++++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 13 ++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 13 ++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 13 ++++++-------
 18 files changed, 97 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 0a34a27d1..579fecd7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -710,7 +710,7 @@ static uint64_t vpe_ring_get_rptr(struct amdgpu_ring *ring)
 	uint64_t rptr;
 
 	if (ring->use_doorbell) {
-		rptr = atomic64_read((atomic64_t *)ring->rptr_cpu_addr);
+		rptr = amdgpu_ring_wb_read64(ring->rptr_cpu_addr);
 		dev_dbg(adev->dev, "rptr/doorbell before shift == 0x%016llx\n", rptr);
 	} else {
 		rptr = RREG32(vpe_get_reg_offset(vpe, ring->me, vpe->regs.queue0_rb_rptr_hi));
@@ -729,7 +729,7 @@ static uint64_t vpe_ring_get_wptr(struct amdgpu_ring *ring)
 	uint64_t wptr;
 
 	if (ring->use_doorbell) {
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 		dev_dbg(adev->dev, "wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
 		wptr = RREG32(vpe_get_reg_offset(vpe, ring->me, vpe->regs.queue0_rb_wptr_hi));
@@ -754,7 +754,7 @@ static void vpe_ring_set_wptr(struct amdgpu_ring *ring)
 			ring->wptr_offs,
 			lower_32_bits(ring->wptr << 2),
 			upper_32_bits(ring->wptr << 2));
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr << 2);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
 		if (vpe->collaborate_mode)
 			WDOORBELL64(ring->doorbell_index + 4, ring->wptr << 2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 58c69dcb5..b8fc3893c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6880,7 +6880,7 @@ static int gfx_v10_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
@@ -7195,7 +7195,7 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring, bool restore)
 			memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset ring buffer */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
@@ -8549,7 +8549,7 @@ static void gfx_v10_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u6
 static u64 gfx_v10_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)
 {
 	/* gfx10 is 32bit rptr*/
-	return *(uint32_t *)ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 gfx_v10_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
@@ -8559,7 +8559,7 @@ static u64 gfx_v10_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	} else {
 		wptr = RREG32_SOC15(GC, 0, mmCP_RB0_WPTR);
 		wptr += (u64)RREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI) << 32;
@@ -8574,8 +8574,7 @@ static void gfx_v10_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		WREG32_SOC15(GC, 0, mmCP_RB0_WPTR,
@@ -8588,7 +8587,7 @@ static void gfx_v10_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 static u64 gfx_v10_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 {
 	/* gfx10 hardware is 32bit rptr */
-	return *(uint32_t *)ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
@@ -8597,7 +8596,7 @@ static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
@@ -8608,8 +8607,7 @@ static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		BUG(); /* only DOORBELL method supported on gfx10 now */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fabdbbd0a..4521e81ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4233,7 +4233,7 @@ static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
@@ -4604,7 +4604,7 @@ static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
 			memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset ring buffer */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
@@ -5849,7 +5849,7 @@ static void gfx_v11_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u6
 static u64 gfx_v11_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)
 {
 	/* gfx11 is 32bit rptr*/
-	return *(uint32_t *)ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 gfx_v11_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
@@ -5859,7 +5859,7 @@ static u64 gfx_v11_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	} else {
 		wptr = RREG32_SOC15(GC, 0, regCP_RB0_WPTR);
 		wptr += (u64)RREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI) << 32;
@@ -5874,8 +5874,7 @@ static void gfx_v11_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
@@ -5888,7 +5887,7 @@ static void gfx_v11_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 static u64 gfx_v11_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 {
 	/* gfx11 hardware is 32bit rptr */
-	return *(uint32_t *)ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
@@ -5897,7 +5896,7 @@ static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
@@ -5909,8 +5908,7 @@ static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		BUG(); /* only DOORBELL method supported on gfx11 now */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f47928dcd..6779ac539 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3092,7 +3092,7 @@ static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
@@ -3463,7 +3463,7 @@ static int gfx_v12_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
 			memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset ring buffer */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
@@ -4366,7 +4366,7 @@ static void gfx_v12_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u6
 static u64 gfx_v12_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)
 {
 	/* gfx12 is 32bit rptr*/
-	return *(uint32_t *)ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 gfx_v12_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
@@ -4376,7 +4376,7 @@ static u64 gfx_v12_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	} else {
 		wptr = RREG32_SOC15(GC, 0, regCP_RB0_WPTR);
 		wptr += (u64)RREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI) << 32;
@@ -4391,8 +4391,7 @@ static void gfx_v12_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
@@ -4405,7 +4404,7 @@ static void gfx_v12_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 static u64 gfx_v12_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 {
 	/* gfx12 hardware is 32bit rptr */
-	return *(uint32_t *)ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
@@ -4414,7 +4413,7 @@ static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
@@ -4426,8 +4425,7 @@ static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		BUG(); /* only DOORBELL method supported on gfx12 now */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 033f15e21..1502ff1ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2462,7 +2462,7 @@ static int gfx_v12_1_xcc_kcq_init_queue(struct amdgpu_ring *ring,
 			memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset ring buffer */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
@@ -3365,7 +3365,7 @@ static void gfx_v12_1_get_clockgating_state(struct amdgpu_ip_block *ip_block, u6
 static u64 gfx_v12_1_ring_get_rptr_compute(struct amdgpu_ring *ring)
 {
 	/* gfx12 hardware is 32bit rptr */
-	return *(uint32_t *)ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 gfx_v12_1_ring_get_wptr_compute(struct amdgpu_ring *ring)
@@ -3374,7 +3374,7 @@ static u64 gfx_v12_1_ring_get_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
@@ -3386,8 +3386,7 @@ static void gfx_v12_1_ring_set_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		BUG(); /* only DOORBELL method supported on gfx12 now */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 64511ee05..c3e2f9ae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4648,7 +4648,7 @@ static int gfx_v8_0_kcq_init_queue(struct amdgpu_ring *ring)
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct vi_mqd_allocation));
 		/* reset ring buffer */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index bf270e605..c335fcbcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3914,7 +3914,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring, bool restore)
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
 		/* reset ring buffer */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
@@ -5351,7 +5351,7 @@ static void gfx_v9_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u64
 
 static u64 gfx_v9_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)
 {
-	return *ring->rptr_cpu_addr; /* gfx9 is 32bit rptr*/
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr); /* gfx9 is 32bit rptr*/
 }
 
 static u64 gfx_v9_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
@@ -5361,7 +5361,7 @@ static u64 gfx_v9_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	} else {
 		wptr = RREG32_SOC15(GC, 0, mmCP_RB0_WPTR);
 		wptr += (u64)RREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI) << 32;
@@ -5376,7 +5376,7 @@ static void gfx_v9_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		WREG32_SOC15(GC, 0, mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
@@ -5631,7 +5631,7 @@ static void gfx_v9_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 {
-	return *ring->rptr_cpu_addr; /* gfx9 hardware is 32bit rptr */
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr); /* gfx9 hardware is 32bit rptr */
 }
 
 static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
@@ -5640,7 +5640,7 @@ static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
@@ -5652,7 +5652,7 @@ static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else{
 		BUG(); /* only DOORBELL method supported on gfx9 now */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9f76e1af8..dfe51d96a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2191,7 +2191,7 @@ static void gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id,
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
 		/* reset ring buffer */
 		ring->wptr = 0;
-		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 }
@@ -3002,7 +3002,7 @@ static void gfx_v9_4_3_ring_emit_vm_flush(struct amdgpu_ring *ring,
 
 static u64 gfx_v9_4_3_ring_get_rptr_compute(struct amdgpu_ring *ring)
 {
-	return ring->adev->wb.wb[ring->rptr_offs]; /* gfx9 hardware is 32bit rptr */
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr); /* gfx9 hardware is 32bit rptr */
 }
 
 static u64 gfx_v9_4_3_ring_get_wptr_compute(struct amdgpu_ring *ring)
@@ -3011,7 +3011,7 @@ static u64 gfx_v9_4_3_ring_get_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)&ring->adev->wb.wb[ring->wptr_offs]);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
@@ -3023,7 +3023,7 @@ static void gfx_v9_4_3_ring_set_wptr_compute(struct amdgpu_ring *ring)
 
 	/* XXX check if swapping is necessary on BE */
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		BUG(); /* only DOORBELL method supported on gfx9 now */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a926a3307..46f6dfd77 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -76,8 +76,7 @@ static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		BUG();
@@ -86,7 +85,7 @@ static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static u64 mes_v11_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return *ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 mes_v11_0_ring_get_wptr(struct amdgpu_ring *ring)
@@ -94,7 +93,7 @@ static u64 mes_v11_0_ring_get_wptr(struct amdgpu_ring *ring)
 	u64 wptr;
 
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 023c7345e..fb6f34b06 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -55,8 +55,7 @@ static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		BUG();
@@ -65,7 +64,7 @@ static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static u64 mes_v12_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return *ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 mes_v12_0_ring_get_wptr(struct amdgpu_ring *ring)
@@ -73,7 +72,7 @@ static u64 mes_v12_0_ring_get_wptr(struct amdgpu_ring *ring)
 	u64 wptr;
 
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 4217b3fea..b00b65090 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -58,8 +58,7 @@ static void mes_v12_1_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
 		BUG();
@@ -68,7 +67,7 @@ static void mes_v12_1_ring_set_wptr(struct amdgpu_ring *ring)
 
 static u64 mes_v12_1_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	return *ring->rptr_cpu_addr;
+	return amdgpu_ring_wb_read32(ring->rptr_cpu_addr);
 }
 
 static u64 mes_v12_1_ring_get_wptr(struct amdgpu_ring *ring)
@@ -76,7 +75,7 @@ static u64 mes_v12_1_ring_get_wptr(struct amdgpu_ring *ring)
 	u64 wptr;
 
 	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	else
 		BUG();
 	return wptr;
@@ -2113,7 +2112,7 @@ static int mes_v12_1_test_ring(struct amdgpu_device *adev, int xcc_id,
 		wptr <<= 2;
 	}
 
-	atomic64_set((atomic64_t *)wptr_cpu_addr, wptr);
+	amdgpu_ring_wb_write64(wptr_cpu_addr, wptr);
 	WDOORBELL64(doorbell_idx, wptr);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -2326,4 +2325,3 @@ static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id)
 	amdgpu_pasid_free(pasid);
 	return r;
 }
-
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index cb64d1700..1c4ab6d5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -651,13 +651,13 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
  */
 static uint64_t sdma_v4_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	u64 *rptr;
+	u64 rptr;
 
 	/* XXX check if swapping is necessary on BE */
-	rptr = ((u64 *)ring->rptr_cpu_addr);
+	rptr = amdgpu_ring_wb_read64(ring->rptr_cpu_addr);
 
-	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
-	return ((*rptr) >> 2);
+	DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
+	return rptr >> 2;
 }
 
 /**
@@ -674,7 +674,7 @@ static uint64_t sdma_v4_0_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
 		wptr = RREG32_SDMA(ring->me, mmSDMA0_GFX_RB_WPTR_HI);
@@ -700,8 +700,6 @@ static void sdma_v4_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 	DRM_DEBUG("Setting write pointer\n");
 	if (ring->use_doorbell) {
-		u64 *wb = (u64 *)ring->wptr_cpu_addr;
-
 		DRM_DEBUG("Using doorbell -- "
 				"wptr_offs == 0x%08x "
 				"lower_32_bits(ring->wptr << 2) == 0x%08x "
@@ -710,7 +708,7 @@ static void sdma_v4_0_ring_set_wptr(struct amdgpu_ring *ring)
 				lower_32_bits(ring->wptr << 2),
 				upper_32_bits(ring->wptr << 2));
 		/* XXX check if swapping is necessary on BE */
-		WRITE_ONCE(*wb, (ring->wptr << 2));
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr << 2);
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 				ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
@@ -743,7 +741,7 @@ static uint64_t sdma_v4_0_page_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	} else {
 		wptr = RREG32_SDMA(ring->me, mmSDMA0_PAGE_RB_WPTR_HI);
 		wptr = wptr << 32;
@@ -765,10 +763,8 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		u64 *wb = (u64 *)ring->wptr_cpu_addr;
-
 		/* XXX check if swapping is necessary on BE */
-		WRITE_ONCE(*wb, (ring->wptr << 2));
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
 	} else {
 		uint64_t wptr = ring->wptr << 2;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 88428b88e..14680520f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -221,7 +221,7 @@ static uint64_t sdma_v4_4_2_ring_get_rptr(struct amdgpu_ring *ring)
 	u64 rptr;
 
 	/* XXX check if swapping is necessary on BE */
-	rptr = READ_ONCE(*((u64 *)&ring->adev->wb.wb[ring->rptr_offs]));
+	rptr = amdgpu_ring_wb_read64(ring->rptr_cpu_addr);
 
 	DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
 	return rptr >> 2;
@@ -241,7 +241,7 @@ static uint64_t sdma_v4_4_2_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
 		wptr = RREG32_SDMA(ring->me, regSDMA_GFX_RB_WPTR_HI);
@@ -267,8 +267,6 @@ static void sdma_v4_4_2_ring_set_wptr(struct amdgpu_ring *ring)
 
 	DRM_DEBUG("Setting write pointer\n");
 	if (ring->use_doorbell) {
-		u64 *wb = (u64 *)&adev->wb.wb[ring->wptr_offs];
-
 		DRM_DEBUG("Using doorbell -- "
 				"wptr_offs == 0x%08x "
 				"lower_32_bits(ring->wptr) << 2 == 0x%08x "
@@ -277,7 +275,7 @@ static void sdma_v4_4_2_ring_set_wptr(struct amdgpu_ring *ring)
 				lower_32_bits(ring->wptr << 2),
 				upper_32_bits(ring->wptr << 2));
 		/* XXX check if swapping is necessary on BE */
-		WRITE_ONCE(*wb, (ring->wptr << 2));
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr << 2);
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 				ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
@@ -310,7 +308,7 @@ static uint64_t sdma_v4_4_2_page_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 	} else {
 		wptr = RREG32_SDMA(ring->me, regSDMA_PAGE_RB_WPTR_HI);
 		wptr = wptr << 32;
@@ -332,10 +330,8 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring->use_doorbell) {
-		u64 *wb = (u64 *)&adev->wb.wb[ring->wptr_offs];
-
 		/* XXX check if swapping is necessary on BE */
-		WRITE_ONCE(*wb, (ring->wptr << 2));
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
 	} else {
 		uint64_t wptr = ring->wptr << 2;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index fa0290721..553b712b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -325,13 +325,13 @@ static unsigned sdma_v5_0_ring_init_cond_exec(struct amdgpu_ring *ring,
  */
 static uint64_t sdma_v5_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	u64 *rptr;
+	u64 rptr;
 
 	/* XXX check if swapping is necessary on BE */
-	rptr = (u64 *)ring->rptr_cpu_addr;
+	rptr = amdgpu_ring_wb_read64(ring->rptr_cpu_addr);
 
-	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
-	return ((*rptr) >> 2);
+	DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
+	return rptr >> 2;
 }
 
 /**
@@ -348,7 +348,7 @@ static uint64_t sdma_v5_0_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
 		wptr = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
@@ -381,8 +381,7 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 			  lower_32_bits(ring->wptr << 2),
 			  upper_32_bits(ring->wptr << 2));
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr << 2);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr << 2);
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 			  ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f6ecbc524..3ae05ae93 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -165,13 +165,13 @@ static unsigned sdma_v5_2_ring_init_cond_exec(struct amdgpu_ring *ring,
  */
 static uint64_t sdma_v5_2_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	u64 *rptr;
+	u64 rptr;
 
 	/* XXX check if swapping is necessary on BE */
-	rptr = (u64 *)ring->rptr_cpu_addr;
+	rptr = amdgpu_ring_wb_read64(ring->rptr_cpu_addr);
 
-	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
-	return ((*rptr) >> 2);
+	DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
+	return rptr >> 2;
 }
 
 /**
@@ -188,7 +188,7 @@ static uint64_t sdma_v5_2_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
 		wptr = RREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
@@ -221,10 +221,9 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 				lower_32_bits(ring->wptr << 2),
 				upper_32_bits(ring->wptr << 2));
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr << 2);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr << 2);
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
-				ring->doorbell_index, ring->wptr << 2);
+			  ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
 		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(5, 2, 1)) {
 			/* SDMA seems to miss doorbells sometimes when powergating kicks in.
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index bf09ac841..f332969e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -167,13 +167,13 @@ static unsigned sdma_v6_0_ring_init_cond_exec(struct amdgpu_ring *ring,
  */
 static uint64_t sdma_v6_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	u64 *rptr;
+	u64 rptr;
 
 	/* XXX check if swapping is necessary on BE */
-	rptr = (u64 *)ring->rptr_cpu_addr;
+	rptr = amdgpu_ring_wb_read64(ring->rptr_cpu_addr);
 
-	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
-	return ((*rptr) >> 2);
+	DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
+	return rptr >> 2;
 }
 
 /**
@@ -189,7 +189,7 @@ static uint64_t sdma_v6_0_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	}
 
@@ -216,8 +216,7 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
 			  lower_32_bits(ring->wptr << 2),
 			  upper_32_bits(ring->wptr << 2));
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr << 2);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr << 2);
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 			  ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index f154b68dd..03d63498e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -166,13 +166,13 @@ static unsigned sdma_v7_0_ring_init_cond_exec(struct amdgpu_ring *ring,
  */
 static uint64_t sdma_v7_0_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	u64 *rptr;
+	u64 rptr;
 
 	/* XXX check if swapping is necessary on BE */
-	rptr = (u64 *)ring->rptr_cpu_addr;
+	rptr = amdgpu_ring_wb_read64(ring->rptr_cpu_addr);
 
-	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
-	return ((*rptr) >> 2);
+	DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
+	return rptr >> 2;
 }
 
 /**
@@ -188,7 +188,7 @@ static uint64_t sdma_v7_0_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	}
 
@@ -217,8 +217,7 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
 			  lower_32_bits(ring->wptr << 2),
 			  upper_32_bits(ring->wptr << 2));
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr << 2);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr << 2);
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 			  ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index e1c0a4ff0..3b541db0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -160,13 +160,13 @@ static unsigned sdma_v7_1_ring_init_cond_exec(struct amdgpu_ring *ring,
  */
 static uint64_t sdma_v7_1_ring_get_rptr(struct amdgpu_ring *ring)
 {
-	u64 *rptr;
+	u64 rptr;
 
 	/* XXX check if swapping is necessary on BE */
-	rptr = (u64 *)ring->rptr_cpu_addr;
+	rptr = amdgpu_ring_wb_read64(ring->rptr_cpu_addr);
 
-	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
-	return ((*rptr) >> 2);
+	DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
+	return rptr >> 2;
 }
 
 /**
@@ -182,7 +182,7 @@ static uint64_t sdma_v7_1_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
+		wptr = amdgpu_ring_wb_read64(ring->wptr_cpu_addr);
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	}
 
@@ -211,8 +211,7 @@ static void sdma_v7_1_ring_set_wptr(struct amdgpu_ring *ring)
 			  lower_32_bits(ring->wptr << 2),
 			  upper_32_bits(ring->wptr << 2));
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr << 2);
+		amdgpu_ring_wb_write64(ring->wptr_cpu_addr, ring->wptr << 2);
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 			  ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
-- 
2.34.1

