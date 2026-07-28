Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955BCC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3134F10E74C;
	Tue, 28 Jul 2026 07:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="awvPFk1P";
	dkim-atps=neutral
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A8910E49B
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 02:50:59 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-8143daf89c7so30100197b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 19:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1785207059; x=1785811859; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z29Jn7Z+oZ7PC1rJvwh1pAjNavUuUm55iKxWhWS6e6w=;
 b=awvPFk1PyMOUpUXp4f45L9CzH6cM7EPwMC6R6IdNr2CkTEe3rL+NkYGQAFJpOldlzd
 eOwEVmcm2pbc0sFOJyL3D5XjkYiwY1wfRnjJq6qJNEHwnPc5qo35lsO/ulJ8RONzu8By
 CHkMsyqdihQ7RAMzDBc68yTxDdb4DacQp+NY2jZ6kpjIwkbEpjXqbjuvIklIuJt4BNXH
 Cq+2P/8gqx2nxHap4Ju3eTjeE6FVSQLSOtDhLrbbBkqmHixuiGJnQcvcdVuaVMtUVw8L
 41Iz5Vh83r/k5hiV1Ag8SYDkH0tA+Rfqq+PqhSkBoPP6cCP6KPGIWTk015UGhowHQzT3
 Vj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785207059; x=1785811859;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z29Jn7Z+oZ7PC1rJvwh1pAjNavUuUm55iKxWhWS6e6w=;
 b=qfVRqODX0It7dByfJGyTxGuhrv0vQ/XkCgcpz+RsWiufC9oMR9neteBNvlJITwV5dG
 mrOz1xyA7SmZpObDvskzkc7yeev0/f925eIyQmhydKmdBqXISdrt6/U5TelgCTwDJ4Ew
 FmwAkzdG+K1gQl3MBPQ6agfAgP4cLzEvADrMp1Op2iAB/aJ+BdUjP04C32YH2HW9peB0
 DDK7BbVqrAX5gWhaLFtDZmltrgT1KOTd6TVj+ufsvoJTQMXbe9OCbDPOpdz/TMnH28Xn
 +ThGAl5SjJCuDQx3hdiVz+1ZfVuSCAn/dztxBK05nBM/urdf20jcBkuKXX3TGT9s5F4a
 wxAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFBXyuYAqL9Q5zbx63Y5j1axV2wBqa+plYBIPxIcNRdBOSpWKuNG4s7C9PVb/6sIO0eD1IbpI3aN4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFmO5FqqAzJPEyI3b975F0D2nrZ8l2BhdGM6mmnKPqfoL7OEr6
 STQ7DM1UQUGEEEdqS79x3Itai+I0KRRD+JT1YN/mV1/Jlxui5w3bQn0KR5cmeT9mhv0=
X-Gm-Gg: AR+sD10NrmZS697H/Sgi8A/IY7raWJYfwgWiWQs7uCKk00S29gcOBRLdU8AF75LUlLX
 7rvrrA1hNOZODF0rAf/Aq3tCSm6XO9JMaY48kVj+84UQv7rsgref0NXQCZerN8Y2DwYV76/tXOR
 w3SbXhy3gAiXOWnWXoejQLzI/TUikD2DVx3B6dDsm7ePQS9m2xp5Y1fwqeuJjZeG/eDFNImZsdx
 v2z1dVWgXw7qNOCKkb9YhDmrM18A/0ftLZDv3MOcSIaCsziII5p5/gOAmCZrQR6ILyC1x7SpULx
 K1SHaBdlJLHEGS7DTpnTw7RWCMf8bdaDWbUuKeLitd74cnRRQgoxzI6xLnl2ZToulFfpVQH9GoV
 740cbdQwKw5K7T358Ys/GYCxC7IsrR8a3nQ1+IadaS6yy/jN6T7HWsdIRnz0vaxxd4VQbo3iaii
 djnrtxf5SRYADdRSw=
X-Received: by 2002:a05:690c:698d:b0:81d:2254:8504 with SMTP id
 00721157ae682-81f993c9973mr1812387b3.56.1785207058670; 
 Mon, 27 Jul 2026 19:50:58 -0700 (PDT)
Received: from localhost.localdomain ([152.234.118.71])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f657bfddcsm40714637b3.18.2026.07.27.19.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 19:50:58 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v6] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
Date: Mon, 27 Jul 2026 23:50:48 -0300
Message-Id: <20260728025048.14970-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CADnq5_OkpYczJu0LK9pEmBWFx=3Cq4GXNhSghRLGO-jXQvomJA@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

The functions gfx_v11_0_handle_priv_fault and
gfx_v12_0_handle_priv_fault share the same logic for searching and
triggering a scheduler fault on a ring. This patch moves the shared
ring-searching logic to a common function, amdgpu_gfx_handle_priv_fault,
in amdgpu_gfx.c. The hardware-specific decoding of ring IDs remains in
the version-specific files to maintain proper architectural separation.

Signed-off-by: Ulisses Paixao <ulissespaixao@usp.br>
Co-developed-by: Felipe Sousa <felipesousa@usp.br>
Signed-off-by: Felipe Sousa <felipesousa@usp.br>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
v6:
Updated code with latest changes from amd-staging-drm-next.

v5:
Return early on adv->gfx.disable_kq check.

v4:
Restore the adev->gfx.disable_kq check to prevent falsely triggering
scheduler faults on idle kernel rings when MES is managing user queues.

v3:
Return early if the ring is found in the gfx rings loop.

v2:
Keep the HW-specific decoding in gfx_v11_0.c and gfx_v12_0.c.
Remove the redundant check for adev->gfx.disable_kq.
Simplify the search loop in amdgpu_gfx_handle_priv_fault to iterate over
all gfx and compute rings without a switch statement.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 51 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 49 +++---------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 50 +++---------------------
 4 files changed, 64 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9d3b40c38..06df4d1c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -34,6 +34,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_mes.h"
+#include "amdgpu_userq.h"
 #include "mes_userqueue.h"
 #include "nvd.h"
 
@@ -855,6 +856,56 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
+/**
+ * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
+ *
+ * @adev: amdgpu_device pointer
+ * @entry: interrupt vector entry containing fault information
+ * @me_id: micro-engine ID of the faulty ring
+ * @pipe_id: pipe ID of the faulty ring
+ * @queue_id: queue ID of the faulty ring
+ *
+ * This function handles privileged instruction faults by identifying
+ * the faulty ring (gfx or compute) and triggering a scheduler fault
+ */
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					struct amdgpu_iv_entry *entry,
+					u8 me_id, u8 pipe_id, u8 queue_id)
+{
+	struct amdgpu_ring *ring;
+	int i;
+
+	/*
+	 * Try KQ first by ring_id (HW slot is authoritative). The
+	 * KMD compute_hqd_mask contract guarantees KCQ and user queues
+	 * never share a HW slot.
+	 */
+	if (!adev->gfx.disable_kq) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			if (ring->me == me_id && ring->pipe == pipe_id &&
+			    ring->queue == queue_id) {
+				drm_sched_fault(&ring->sched);
+				return;
+			}
+		}
+
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			ring = &adev->gfx.compute_ring[i];
+			if (ring->me == me_id && ring->pipe == pipe_id &&
+			    ring->queue == queue_id)
+				drm_sched_fault(&ring->sched);
+		}
+	}
+
+	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
+
+	/* No KQ matched: HW slot is a MES-scheduled user queue. */
+	if (adev->enable_mes && doorbell_offset)
+		amdgpu_userq_process_reset_irq(adev, entry->pasid,
+					       doorbell_offset);
+}
+
 static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
 				   bool no_delay)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index aefd4f03b..c15f45a73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -620,6 +620,9 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
 						struct amdgpu_ring *ring);
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					struct amdgpu_iv_entry *entry,
+					u8 me_id, u8 pipe_id, u8 queue_id);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0cbbdc369..489e0c97e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6710,52 +6710,13 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
+	u8 me_id, pipe_id, queue_id;
 
-	/*
-	 * Try KQ first by ring_id (HW slot is authoritative). The
-	 * KMD compute_hqd_mask contract guarantees KCQ and user queues
-	 * never share a HW slot.
-	 */
-	if (!adev->gfx.disable_kq) {
-		u8 me_id = (entry->ring_id & 0x0c) >> 2;
-		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
-		u8 queue_id = (entry->ring_id & 0x70) >> 4;
-		struct amdgpu_ring *ring;
-		int i;
-
-		switch (me_id) {
-		case 0:
-			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-				ring = &adev->gfx.gfx_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id) {
-					drm_sched_fault(&ring->sched);
-					return;
-				}
-			}
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id) {
-					drm_sched_fault(&ring->sched);
-					return;
-				}
-			}
-			break;
-		default:
-			BUG();
-			break;
-		}
-	}
+	me_id = (entry->ring_id & 0x0c) >> 2;
+	pipe_id = (entry->ring_id & 0x03) >> 0;
+	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	/* No KQ matched: HW slot is a MES-scheduled user queue. */
-	if (adev->enable_mes && doorbell_offset)
-		amdgpu_userq_process_reset_irq(adev, entry->pasid,
-					       doorbell_offset);
+	amdgpu_gfx_handle_priv_fault(adev, entry, me_id, pipe_id, queue_id);
 }
 
 static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b3887c526..32cd9ad66 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5041,53 +5041,13 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
+	u8 me_id, pipe_id, queue_id;
 
-	/*
-	 * Try KQ first by ring_id; UQ as fallback. KCQ and UQ never share
-	 * a HW slot (compute_hqd_mask contract).
-	 */
-	if (!adev->gfx.disable_kq) {
-		u8 me_id, pipe_id, queue_id;
-		struct amdgpu_ring *ring;
-		int i;
-
-		me_id = (entry->ring_id & 0x0c) >> 2;
-		pipe_id = (entry->ring_id & 0x03) >> 0;
-		queue_id = (entry->ring_id & 0x70) >> 4;
-
-		switch (me_id) {
-		case 0:
-			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-				ring = &adev->gfx.gfx_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id) {
-					drm_sched_fault(&ring->sched);
-					return;
-				}
-			}
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id) {
-					drm_sched_fault(&ring->sched);
-					return;
-				}
-			}
-			break;
-		default:
-			BUG();
-			break;
-		}
-	}
+	me_id = (entry->ring_id & 0x0c) >> 2;
+	pipe_id = (entry->ring_id & 0x03) >> 0;
+	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	/* No KQ matched: HW slot is a MES-scheduled user queue. */
-	if (adev->enable_mes && doorbell_offset)
-		amdgpu_userq_process_reset_irq(adev, entry->pasid,
-					       doorbell_offset);
+	amdgpu_gfx_handle_priv_fault(adev, entry, me_id, pipe_id, queue_id);
 }
 
 static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.34.1

