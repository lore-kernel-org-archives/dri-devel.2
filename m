Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAD2C5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 18:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323D310E21A;
	Sat, 15 Aug 2026 18:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="CWfv0Iwq";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5808910E21A;
 Sat, 15 Aug 2026 18:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=Y4/lGEu2vYYfG+J5NalSOcIf0cTtrROSYtkP45d1Cs8=; b=CWfv0IwqFlERELgK
 Bf7l6jHRcNyhi8iP9V0l/05DChh3dR3Fsrb6FVQ/zPL7WfQAM/YngRE7K9GV/ojZzB81Bu8U5d1Wr
 LW5+nX7Z2ouHqn83JfHMWzRaA5Jefffdiwl1jst6frOMDW14JMhOyWoTquMBbESzJnYPCGXfqkIEC
 kIRLwVuBc6umgKOXZvUJWoS2cqkKfTYt4FH78P1Wx1fOxJe0XgTMxWWDCYFXU31CQsM5aFXjiwfPm
 f8w7hkhJmrvyrPG8wgTR4+a05LP1cvtGBYMulWxdrst5tC4hIjnRkm1P16KKwKvHxlXA2rvXzA4UK
 6jlUax9RpDvy+NQsNQ==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <linux@treblig.org>) id 1wvIgZ-00000002HFi-3X0e;
 Sat, 15 Aug 2026 18:00:47 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/4] drm/amdgpu: Remove is_idle (non trivial functions)
Date: Sat, 15 Aug 2026 19:00:32 +0100
Message-ID: <20260815180033.8958-4-linux@treblig.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815180033.8958-1-linux@treblig.org>
References: <20260815180033.8958-1-linux@treblig.org>
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The is_idle method on amd_ip_funcs is never called.
Remove the implementations that actually do something.
In most cases the same code has been duplicated in
the wait_for_idle method implementations that is still used.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/amdgpu/cik_ih.c      | 12 ------------
 drivers/gpu/drm/amd/amdgpu/cz_ih.c       | 12 ------------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 12 ------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 12 ------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 12 ------------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    | 11 -----------
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c    | 13 -------------
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c  | 12 ------------
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 13 -------------
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 13 -------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c    | 12 ------------
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  8 --------
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  8 --------
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  8 --------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 23 -----------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 21 ---------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 23 -----------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 23 -----------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 19 -------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  | 19 -------------------
 28 files changed, 414 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 876a3256dba4..314d8f1d64cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -357,17 +357,6 @@ static int cik_ih_resume(struct amdgpu_ip_block *ip_block)
 	return cik_ih_hw_init(ip_block);
 }
 
-static bool cik_ih_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
-		return false;
-
-	return true;
-}
-
 static int cik_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -435,7 +424,6 @@ static const struct amd_ip_funcs cik_ih_ip_funcs = {
 	.hw_fini = cik_ih_hw_fini,
 	.suspend = cik_ih_suspend,
 	.resume = cik_ih_resume,
-	.is_idle = cik_ih_is_idle,
 	.wait_for_idle = cik_ih_wait_for_idle,
 	.soft_reset = cik_ih_soft_reset,
 	.set_clockgating_state = cik_ih_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index bc7a2e06ab5f..8d02602f8433 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -351,17 +351,6 @@ static int cz_ih_resume(struct amdgpu_ip_block *ip_block)
 	return cz_ih_hw_init(ip_block);
 }
 
-static bool cz_ih_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (REG_GET_FIELD(tmp, SRBM_STATUS, IH_BUSY))
-		return false;
-
-	return true;
-}
-
 static int cz_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -431,7 +420,6 @@ static const struct amd_ip_funcs cz_ih_ip_funcs = {
 	.hw_fini = cz_ih_hw_fini,
 	.suspend = cz_ih_suspend,
 	.resume = cz_ih_resume,
-	.is_idle = cz_ih_is_idle,
 	.wait_for_idle = cz_ih_wait_for_idle,
 	.soft_reset = cz_ih_soft_reset,
 	.set_clockgating_state = cz_ih_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 00798d80479f..f9154421c2d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7611,17 +7611,6 @@ static int gfx_v10_0_resume(struct amdgpu_ip_block *ip_block)
 	return gfx_v10_0_hw_init(ip_block);
 }
 
-static bool gfx_v10_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (REG_GET_FIELD(RREG32_SOC15(GC, 0, mmGRBM_STATUS),
-				GRBM_STATUS, GUI_ACTIVE))
-		return false;
-	else
-		return true;
-}
-
 static int gfx_v10_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned int i;
@@ -9821,7 +9810,6 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.hw_fini = gfx_v10_0_hw_fini,
 	.suspend = gfx_v10_0_suspend,
 	.resume = gfx_v10_0_resume,
-	.is_idle = gfx_v10_0_is_idle,
 	.wait_for_idle = gfx_v10_0_wait_for_idle,
 	.soft_reset = gfx_v10_0_soft_reset,
 	.set_clockgating_state = gfx_v10_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 69776dbe188d..a447562977ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5099,17 +5099,6 @@ static int gfx_v11_0_resume(struct amdgpu_ip_block *ip_block)
 	return gfx_v11_0_hw_init(ip_block);
 }
 
-static bool gfx_v11_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (REG_GET_FIELD(RREG32_SOC15(GC, 0, regGRBM_STATUS),
-				GRBM_STATUS, GUI_ACTIVE))
-		return false;
-	else
-		return true;
-}
-
 static int gfx_v11_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -7057,7 +7046,6 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.hw_fini = gfx_v11_0_hw_fini,
 	.suspend = gfx_v11_0_suspend,
 	.resume = gfx_v11_0_resume,
-	.is_idle = gfx_v11_0_is_idle,
 	.wait_for_idle = gfx_v11_0_wait_for_idle,
 	.soft_reset = gfx_v11_0_soft_reset,
 	.set_clockgating_state = gfx_v11_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1e5fd1ef8f1d..fdfee88e41e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3929,17 +3929,6 @@ static int gfx_v12_0_resume(struct amdgpu_ip_block *ip_block)
 	return gfx_v12_0_hw_init(ip_block);
 }
 
-static bool gfx_v12_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (REG_GET_FIELD(RREG32_SOC15(GC, 0, regGRBM_STATUS),
-				GRBM_STATUS, GUI_ACTIVE))
-		return false;
-	else
-		return true;
-}
-
 static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -5343,7 +5332,6 @@ static const struct amd_ip_funcs gfx_v12_0_ip_funcs = {
 	.hw_fini = gfx_v12_0_hw_fini,
 	.suspend = gfx_v12_0_suspend,
 	.resume = gfx_v12_0_resume,
-	.is_idle = gfx_v12_0_is_idle,
 	.wait_for_idle = gfx_v12_0_wait_for_idle,
 	.set_clockgating_state = gfx_v12_0_set_clockgating_state,
 	.set_powergating_state = gfx_v12_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 5fc19fefca81..a1e00be54005 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4511,16 +4511,6 @@ static int gfx_v7_0_resume(struct amdgpu_ip_block *ip_block)
 	return gfx_v7_0_hw_init(ip_block);
 }
 
-static bool gfx_v7_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (RREG32(mmGRBM_STATUS) & GRBM_STATUS__GUI_ACTIVE_MASK)
-		return false;
-	else
-		return true;
-}
-
 static int gfx_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -4951,7 +4941,6 @@ static const struct amd_ip_funcs gfx_v7_0_ip_funcs = {
 	.hw_fini = gfx_v7_0_hw_fini,
 	.suspend = gfx_v7_0_suspend,
 	.resume = gfx_v7_0_resume,
-	.is_idle = gfx_v7_0_is_idle,
 	.wait_for_idle = gfx_v7_0_wait_for_idle,
 	.soft_reset = gfx_v7_0_soft_reset,
 	.set_clockgating_state = gfx_v7_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 64ebedc595b5..bf089595e5da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1221,18 +1221,6 @@ static int gmc_v8_0_resume(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static bool gmc_v8_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (tmp & (SRBM_STATUS__MCB_BUSY_MASK | SRBM_STATUS__MCB_NON_DISPLAY_BUSY_MASK |
-		   SRBM_STATUS__MCC_BUSY_MASK | SRBM_STATUS__MCD_BUSY_MASK | SRBM_STATUS__VMC_BUSY_MASK))
-		return false;
-
-	return true;
-}
-
 static int gmc_v8_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned int i;
@@ -1592,7 +1580,6 @@ static const struct amd_ip_funcs gmc_v8_0_ip_funcs = {
 	.hw_fini = gmc_v8_0_hw_fini,
 	.suspend = gmc_v8_0_suspend,
 	.resume = gmc_v8_0_resume,
-	.is_idle = gmc_v8_0_is_idle,
 	.wait_for_idle = gmc_v8_0_wait_for_idle,
 	.set_clockgating_state = gmc_v8_0_set_clockgating_state,
 	.set_powergating_state = gmc_v8_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 01cadf898c00..49002c80dc71 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -345,17 +345,6 @@ static int iceland_ih_resume(struct amdgpu_ip_block *ip_block)
 	return iceland_ih_hw_init(ip_block);
 }
 
-static bool iceland_ih_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (REG_GET_FIELD(tmp, SRBM_STATUS, IH_BUSY))
-		return false;
-
-	return true;
-}
-
 static int iceland_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -423,7 +412,6 @@ static const struct amd_ip_funcs iceland_ih_ip_funcs = {
 	.hw_fini = iceland_ih_hw_fini,
 	.suspend = iceland_ih_suspend,
 	.resume = iceland_ih_resume,
-	.is_idle = iceland_ih_is_idle,
 	.wait_for_idle = iceland_ih_wait_for_idle,
 	.soft_reset = iceland_ih_soft_reset,
 	.set_clockgating_state = iceland_ih_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index c7253b908351..9ef7134149d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -919,18 +919,6 @@ static int sdma_v2_4_resume(struct amdgpu_ip_block *ip_block)
 	return sdma_v2_4_hw_init(ip_block);
 }
 
-static bool sdma_v2_4_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 tmp = RREG32(mmSRBM_STATUS2);
-
-	if (tmp & (SRBM_STATUS2__SDMA_BUSY_MASK |
-		   SRBM_STATUS2__SDMA1_BUSY_MASK))
-	    return false;
-
-	return true;
-}
-
 static int sdma_v2_4_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -1112,7 +1100,6 @@ static const struct amd_ip_funcs sdma_v2_4_ip_funcs = {
 	.hw_fini = sdma_v2_4_hw_fini,
 	.suspend = sdma_v2_4_suspend,
 	.resume = sdma_v2_4_resume,
-	.is_idle = sdma_v2_4_is_idle,
 	.wait_for_idle = sdma_v2_4_wait_for_idle,
 	.soft_reset = sdma_v2_4_soft_reset,
 	.set_clockgating_state = sdma_v2_4_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 05cce4bde73e..6198bc2024e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1209,18 +1209,6 @@ static int sdma_v3_0_resume(struct amdgpu_ip_block *ip_block)
 	return sdma_v3_0_hw_init(ip_block);
 }
 
-static bool sdma_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 tmp = RREG32(mmSRBM_STATUS2);
-
-	if (tmp & (SRBM_STATUS2__SDMA_BUSY_MASK |
-		   SRBM_STATUS2__SDMA1_BUSY_MASK))
-	    return false;
-
-	return true;
-}
-
 static int sdma_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -1492,7 +1480,6 @@ static const struct amd_ip_funcs sdma_v3_0_ip_funcs = {
 	.hw_fini = sdma_v3_0_hw_fini,
 	.suspend = sdma_v3_0_suspend,
 	.resume = sdma_v3_0_resume,
-	.is_idle = sdma_v3_0_is_idle,
 	.wait_for_idle = sdma_v3_0_wait_for_idle,
 	.soft_reset = sdma_v3_0_soft_reset,
 	.set_clockgating_state = sdma_v3_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 20c8ebf0e159..a0f19f7b39e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2027,21 +2027,6 @@ static int sdma_v4_0_resume(struct amdgpu_ip_block *ip_block)
 	return sdma_v4_0_hw_init(ip_block);
 }
 
-static bool sdma_v4_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		u32 tmp = RREG32_SDMA(i, mmSDMA0_STATUS_REG);
-
-		if (!(tmp & SDMA0_STATUS_REG__IDLE_MASK))
-			return false;
-	}
-
-	return true;
-}
-
 static int sdma_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i, j;
@@ -2412,7 +2397,6 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
 	.hw_fini = sdma_v4_0_hw_fini,
 	.suspend = sdma_v4_0_suspend,
 	.resume = sdma_v4_0_resume,
-	.is_idle = sdma_v4_0_is_idle,
 	.wait_for_idle = sdma_v4_0_wait_for_idle,
 	.soft_reset = sdma_v4_0_soft_reset,
 	.set_clockgating_state = sdma_v4_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 6fe3d3d56c40..1a2810b6f27c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1627,21 +1627,6 @@ static int sdma_v4_4_2_resume(struct amdgpu_ip_block *ip_block)
 	return sdma_v4_4_2_hw_init(ip_block);
 }
 
-static bool sdma_v4_4_2_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		u32 tmp = RREG32_SDMA(i, regSDMA_STATUS_REG);
-
-		if (!(tmp & SDMA_STATUS_REG__IDLE_MASK))
-			return false;
-	}
-
-	return true;
-}
-
 static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i, j;
@@ -2118,7 +2103,6 @@ const struct amd_ip_funcs sdma_v4_4_2_ip_funcs = {
 	.hw_fini = sdma_v4_4_2_hw_fini,
 	.suspend = sdma_v4_4_2_suspend,
 	.resume = sdma_v4_4_2_resume,
-	.is_idle = sdma_v4_4_2_is_idle,
 	.wait_for_idle = sdma_v4_4_2_wait_for_idle,
 	.soft_reset = sdma_v4_4_2_soft_reset,
 	.set_clockgating_state = sdma_v4_4_2_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1ca0e7f65442..1a022a251011 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1501,21 +1501,6 @@ static int sdma_v5_0_resume(struct amdgpu_ip_block *ip_block)
 	return sdma_v5_0_hw_init(ip_block);
 }
 
-static bool sdma_v5_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		u32 tmp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_STATUS_REG));
-
-		if (!(tmp & SDMA0_STATUS_REG__IDLE_MASK))
-			return false;
-	}
-
-	return true;
-}
-
 static int sdma_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -1916,7 +1901,6 @@ static const struct amd_ip_funcs sdma_v5_0_ip_funcs = {
 	.hw_fini = sdma_v5_0_hw_fini,
 	.suspend = sdma_v5_0_suspend,
 	.resume = sdma_v5_0_resume,
-	.is_idle = sdma_v5_0_is_idle,
 	.wait_for_idle = sdma_v5_0_wait_for_idle,
 	.soft_reset = sdma_v5_0_soft_reset,
 	.set_clockgating_state = sdma_v5_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 81f1e9882177..5543e381dcca 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1417,21 +1417,6 @@ static int sdma_v5_2_resume(struct amdgpu_ip_block *ip_block)
 	return sdma_v5_2_hw_init(ip_block);
 }
 
-static bool sdma_v5_2_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		u32 tmp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_STATUS_REG));
-
-		if (!(tmp & SDMA0_STATUS_REG__IDLE_MASK))
-			return false;
-	}
-
-	return true;
-}
-
 static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -1921,7 +1906,6 @@ static const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
 	.hw_fini = sdma_v5_2_hw_fini,
 	.suspend = sdma_v5_2_suspend,
 	.resume = sdma_v5_2_resume,
-	.is_idle = sdma_v5_2_is_idle,
 	.wait_for_idle = sdma_v5_2_wait_for_idle,
 	.soft_reset = sdma_v5_2_soft_reset,
 	.set_clockgating_state = sdma_v5_2_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index cf3d2997fff8..3fd3e530c76b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1489,21 +1489,6 @@ static int sdma_v6_0_resume(struct amdgpu_ip_block *ip_block)
 	return sdma_v6_0_hw_init(ip_block);
 }
 
-static bool sdma_v6_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		u32 tmp = RREG32(sdma_v6_0_get_reg_offset(adev, i, regSDMA0_STATUS_REG));
-
-		if (!(tmp & SDMA0_STATUS_REG__IDLE_MASK))
-			return false;
-	}
-
-	return true;
-}
-
 static int sdma_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -1727,7 +1712,6 @@ const struct amd_ip_funcs sdma_v6_0_ip_funcs = {
 	.hw_fini = sdma_v6_0_hw_fini,
 	.suspend = sdma_v6_0_suspend,
 	.resume = sdma_v6_0_resume,
-	.is_idle = sdma_v6_0_is_idle,
 	.wait_for_idle = sdma_v6_0_wait_for_idle,
 	.soft_reset = sdma_v6_0_soft_reset,
 	.set_clockgating_state = sdma_v6_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 69cb89298a3e..745ec8b67b59 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1443,21 +1443,6 @@ static int sdma_v7_0_resume(struct amdgpu_ip_block *ip_block)
 	return sdma_v7_0_hw_init(ip_block);
 }
 
-static bool sdma_v7_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		u32 tmp = RREG32(sdma_v7_0_get_reg_offset(adev, i, regSDMA0_STATUS_REG));
-
-		if (!(tmp & SDMA0_STATUS_REG__IDLE_MASK))
-			return false;
-	}
-
-	return true;
-}
-
 static int sdma_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -1659,7 +1644,6 @@ const struct amd_ip_funcs sdma_v7_0_ip_funcs = {
 	.hw_fini = sdma_v7_0_hw_fini,
 	.suspend = sdma_v7_0_suspend,
 	.resume = sdma_v7_0_resume,
-	.is_idle = sdma_v7_0_is_idle,
 	.wait_for_idle = sdma_v7_0_wait_for_idle,
 	.soft_reset = sdma_v7_0_soft_reset,
 	.set_clockgating_state = sdma_v7_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 18366e16ef3f..e9a3bcfd7775 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1404,21 +1404,6 @@ static int sdma_v7_1_resume(struct amdgpu_ip_block *ip_block)
 	return sdma_v7_1_hw_init(ip_block);
 }
 
-static bool sdma_v7_1_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		u32 tmp = RREG32(sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_STATUS_REG));
-
-		if (!(tmp & SDMA0_SDMA_STATUS_REG__IDLE_MASK))
-			return false;
-	}
-
-	return true;
-}
-
 static int sdma_v7_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i, j;
@@ -1624,7 +1609,6 @@ const struct amd_ip_funcs sdma_v7_1_ip_funcs = {
 	.hw_fini = sdma_v7_1_hw_fini,
 	.suspend = sdma_v7_1_suspend,
 	.resume = sdma_v7_1_resume,
-	.is_idle = sdma_v7_1_is_idle,
 	.wait_for_idle = sdma_v7_1_wait_for_idle,
 	.soft_reset = sdma_v7_1_soft_reset,
 	.set_clockgating_state = sdma_v7_1_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index a3e883f6f099..d84c08698dff 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -363,17 +363,6 @@ static int tonga_ih_resume(struct amdgpu_ip_block *ip_block)
 	return tonga_ih_hw_init(ip_block);
 }
 
-static bool tonga_ih_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (REG_GET_FIELD(tmp, SRBM_STATUS, IH_BUSY))
-		return false;
-
-	return true;
-}
-
 static int tonga_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -442,7 +431,6 @@ static const struct amd_ip_funcs tonga_ih_ip_funcs = {
 	.hw_fini = tonga_ih_hw_fini,
 	.suspend = tonga_ih_suspend,
 	.resume = tonga_ih_resume,
-	.is_idle = tonga_ih_is_idle,
 	.wait_for_idle = tonga_ih_wait_for_idle,
 	.soft_reset = tonga_ih_soft_reset,
 	.set_clockgating_state = tonga_ih_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index efb3fde919ee..b72a0c34425a 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -789,13 +789,6 @@ static int uvd_v3_1_resume(struct amdgpu_ip_block *ip_block)
 	return uvd_v3_1_hw_init(ip_block);
 }
 
-static bool uvd_v3_1_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
-}
-
 static int uvd_v3_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -843,7 +836,6 @@ static const struct amd_ip_funcs uvd_v3_1_ip_funcs = {
 	.prepare_suspend = uvd_v3_1_prepare_suspend,
 	.suspend = uvd_v3_1_suspend,
 	.resume = uvd_v3_1_resume,
-	.is_idle = uvd_v3_1_is_idle,
 	.wait_for_idle = uvd_v3_1_wait_for_idle,
 	.soft_reset = uvd_v3_1_soft_reset,
 	.set_clockgating_state = uvd_v3_1_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 8a9ba2276275..cf304b489d87 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -664,13 +664,6 @@ static void uvd_v4_2_set_dcm(struct amdgpu_device *adev,
 	WREG32_UVD_CTX(ixUVD_CGC_CTRL2, tmp2);
 }
 
-static bool uvd_v4_2_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
-}
-
 static int uvd_v4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -768,7 +761,6 @@ static const struct amd_ip_funcs uvd_v4_2_ip_funcs = {
 	.prepare_suspend = uvd_v4_2_prepare_suspend,
 	.suspend = uvd_v4_2_suspend,
 	.resume = uvd_v4_2_resume,
-	.is_idle = uvd_v4_2_is_idle,
 	.wait_for_idle = uvd_v4_2_wait_for_idle,
 	.soft_reset = uvd_v4_2_soft_reset,
 	.set_clockgating_state = uvd_v4_2_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 454f109cbb2e..564d8fb58905 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -580,13 +580,6 @@ static void uvd_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 	}
 }
 
-static bool uvd_v5_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
-}
-
 static int uvd_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
@@ -869,7 +862,6 @@ static const struct amd_ip_funcs uvd_v5_0_ip_funcs = {
 	.prepare_suspend = uvd_v5_0_prepare_suspend,
 	.suspend = uvd_v5_0_suspend,
 	.resume = uvd_v5_0_resume,
-	.is_idle = uvd_v5_0_is_idle,
 	.wait_for_idle = uvd_v5_0_wait_for_idle,
 	.soft_reset = uvd_v5_0_soft_reset,
 	.set_clockgating_state = uvd_v5_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 81bba3ec2a93..531643c3e32e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2212,21 +2212,6 @@ static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
 	return vcn_v3_0_start(vinst);
 }
 
-static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		ret &= (RREG32_SOC15(VCN, i, mmUVD_STATUS) == UVD_STATUS__IDLE);
-	}
-
-	return ret;
-}
-
 static int vcn_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2372,7 +2357,6 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.hw_fini = vcn_v3_0_hw_fini,
 	.suspend = vcn_v3_0_suspend,
 	.resume = vcn_v3_0_resume,
-	.is_idle = vcn_v3_0_is_idle,
 	.wait_for_idle = vcn_v3_0_wait_for_idle,
 	.set_clockgating_state = vcn_v3_0_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 0cce78b205a8..fcfb48f017aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2087,28 +2087,6 @@ static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * vcn_v4_0_is_idle - check VCN block is idle
- *
- * @ip_block: Pointer to the amdgpu_ip_block structure
- *
- * Check whether VCN block is idle
- */
-static bool vcn_v4_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		ret &= (RREG32_SOC15(VCN, i, regUVD_STATUS) == UVD_STATUS__IDLE);
-	}
-
-	return ret;
-}
-
 /**
  * vcn_v4_0_wait_for_idle - wait for VCN block idle
  *
@@ -2300,7 +2278,6 @@ static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
 	.hw_fini = vcn_v4_0_hw_fini,
 	.suspend = vcn_v4_0_suspend,
 	.resume = vcn_v4_0_resume,
-	.is_idle = vcn_v4_0_is_idle,
 	.wait_for_idle = vcn_v4_0_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 179b892fb410..3d28289bc4f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1840,26 +1840,6 @@ static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * vcn_v4_0_3_is_idle - check VCN block is idle
- *
- * @ip_block: Pointer to the amdgpu_ip_block structure
- *
- * Check whether VCN block is idle
- */
-static bool vcn_v4_0_3_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		ret &= (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) ==
-			UVD_STATUS__IDLE);
-	}
-
-	return ret;
-}
-
 /**
  * vcn_v4_0_3_wait_for_idle - wait for VCN block idle
  *
@@ -2049,7 +2029,6 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.hw_fini = vcn_v4_0_3_hw_fini,
 	.suspend = vcn_v4_0_3_suspend,
 	.resume = vcn_v4_0_3_resume,
-	.is_idle = vcn_v4_0_3_is_idle,
 	.wait_for_idle = vcn_v4_0_3_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index c8879a6e5297..660dab262dfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1531,28 +1531,6 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * vcn_v4_0_5_is_idle - check VCN block is idle
- *
- * @ip_block: Pointer to the amdgpu_ip_block structure
- *
- * Check whether VCN block is idle
- */
-static bool vcn_v4_0_5_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		ret &= (RREG32_SOC15(VCN, i, regUVD_STATUS) == UVD_STATUS__IDLE);
-	}
-
-	return ret;
-}
-
 /**
  * vcn_v4_0_5_wait_for_idle - wait for VCN block idle
  *
@@ -1707,7 +1685,6 @@ static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
 	.hw_fini = vcn_v4_0_5_hw_fini,
 	.suspend = vcn_v4_0_5_suspend,
 	.resume = vcn_v4_0_5_resume,
-	.is_idle = vcn_v4_0_5_is_idle,
 	.wait_for_idle = vcn_v4_0_5_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_5_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 886e2c2074a9..08fca20b2c99 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1317,28 +1317,6 @@ static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * vcn_v5_0_0_is_idle - check VCN block is idle
- *
- * @ip_block: Pointer to the amdgpu_ip_block structure
- *
- * Check whether VCN block is idle
- */
-static bool vcn_v5_0_0_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		ret &= (RREG32_SOC15(VCN, i, regUVD_STATUS) == UVD_STATUS__IDLE);
-	}
-
-	return ret;
-}
-
 /**
  * vcn_v5_0_0_wait_for_idle - wait for VCN block idle
  *
@@ -1493,7 +1471,6 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
 	.hw_fini = vcn_v5_0_0_hw_fini,
 	.suspend = vcn_v5_0_0_suspend,
 	.resume = vcn_v5_0_0_resume,
-	.is_idle = vcn_v5_0_0_is_idle,
 	.wait_for_idle = vcn_v5_0_0_wait_for_idle,
 	.set_clockgating_state = vcn_v5_0_0_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 1a07c3bf4425..b3b83ad20103 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1483,24 +1483,6 @@ static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * vcn_v5_0_1_is_idle - check VCN block is idle
- *
- * @ip_block: Pointer to the amdgpu_ip_block structure
- *
- * Check whether VCN block is idle
- */
-static bool vcn_v5_0_1_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		ret &= (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) == UVD_STATUS__IDLE);
-
-	return ret;
-}
-
 /**
  * vcn_v5_0_1_wait_for_idle - wait for VCN block idle
  *
@@ -1672,7 +1654,6 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.hw_fini = vcn_v5_0_1_hw_fini,
 	.suspend = vcn_v5_0_1_suspend,
 	.resume = vcn_v5_0_1_resume,
-	.is_idle = vcn_v5_0_1_is_idle,
 	.wait_for_idle = vcn_v5_0_1_wait_for_idle,
 	.soft_reset = NULL,
 	.set_clockgating_state = vcn_v5_0_1_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index b9f6ae75ea72..c4a64beacd32 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -1040,24 +1040,6 @@ static void vcn_v5_0_2_set_unified_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * vcn_v5_0_2_is_idle - check VCN block is idle
- *
- * @ip_block: Pointer to the amdgpu_ip_block structure
- *
- * Check whether VCN block is idle
- */
-static bool vcn_v5_0_2_is_idle(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		ret &= (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) == UVD_STATUS__IDLE);
-
-	return ret;
-}
-
 /**
  * vcn_v5_0_2_wait_for_idle - wait for VCN block idle
  *
@@ -1201,7 +1183,6 @@ static const struct amd_ip_funcs vcn_v5_0_2_ip_funcs = {
 	.hw_fini = vcn_v5_0_2_hw_fini,
 	.suspend = vcn_v5_0_2_suspend,
 	.resume = vcn_v5_0_2_resume,
-	.is_idle = vcn_v5_0_2_is_idle,
 	.wait_for_idle = vcn_v5_0_2_wait_for_idle,
 	.soft_reset = NULL,
 	.set_clockgating_state = vcn_v5_0_2_set_clockgating_state,
-- 
2.55.0

