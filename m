Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B654C44502
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C6F10F1D0;
	Thu,  2 Jul 2026 07:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="bq8sF/Le";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C91F10F084
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:37:47 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-37fa06b39b4so599987a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782927467; x=1783532267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g62Dxf6SMlDovUW02yTNltfYRMA0PsQgdavrAfTkmdA=;
 b=bq8sF/LeC9o0OkpAaysXjoTJiHiOkbf+u0sfEUZ8QBwbVbyg8i2UfAnYOsXTmtrQIs
 31uc9Uod+hDy5tRZv7A0tLVO3BdtO+4WIyrYovzKAqrZaasweYssyViqHAYyhFybeeLB
 +gHAMNs3xt67r6pk1R8kwOp/N08wbaVP3XXVeemi/CN7NOjY0v36xkxP6GR/65Q7H4D8
 LcuvGu+6iF3FGfeaBwWpM+q3JEH9nfN6vNF6LzGhbIfPcBPMJLRlwTw9rtQipRBcIQS5
 lkGo0xd/p5D0eETn5mzrXI9QV+xOTmheLLcmQ8bl/Iyp2CM/NI5e15Twdstwjo4NuK39
 h01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782927467; x=1783532267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g62Dxf6SMlDovUW02yTNltfYRMA0PsQgdavrAfTkmdA=;
 b=SgGpa4fpGqhYJ7IAgU1Njj3BZBvFldHbHzQPNchG7YdteOhDjcx44nbrN8/lIsvEX1
 m2q3bPtysTJAvmQXtapBywNH9k2T0J5nb7Y8iUbL7Bt9Ur/xL5SXJP7hI8SEe3rn+SzF
 5+B1u8EyuvPPBPy3lkk/dcmTfSNMTHE4djuHpXpBswD+2cUq67v2HtbDrapEd5T+R1Oq
 i2u+pjliTAaMuTxnlWoMsUenejMjmSHKk9fRbvnSa0t6Em3kcUk5Ped3yRcdc5Hwz+MV
 ltvCqZwHBT1243xTMRQMdk7HDBNi+SxhTkYH5KpcvN2RjWNuRFAVMXPDWTx16nmn07cM
 M87Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9UkZoT98w6j06EL2wu0QZS6CA3R5MrQgU1XPcHcuBegsJjbzQo1wUApVvtKd/bYKjUlfG/Mj8t7s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx51PObcMYQByfLS1zpDQV+KRiIxPDmyM6GXsabWQWvfNikzIUs
 xgm/Sn2qnxFNlkkWKNYbfER4G35hAgtXryBxB5dywt1WOyI4W4rBskyYBdZGWDzsTOo=
X-Gm-Gg: AfdE7cmkCeL4DsY5xGg4iuDtEeqRKEmjbqUWarjzNVNIJAU8ITjfCZsC937mFTHG7aK
 O1M1cne5umIqjY+OZ8e3OCRv/CSzqJ0GjB+J+/L3LzCVSIUj8a1veYK0iWcQiI/GsY7tFEx1Ebp
 Nh+fVwxjf8fzjI755JSXfvEp3rtdigfFLCOEIQny3oDZwlo0eW6XVqqc+3ool/pjc0Bqkz2ZrRv
 45mVfTj9EqsL+NY+yaNuu+x9PgUCfJEt2ekTM5LszuWR74eUFRoy9/5BS3H/JwfIjRkAbYwBx9r
 K5EdQbmdpBu1VpjSb1iEQN4QajwjFFFTlpDh9OdYdUkYtoC64omWvg2lm6uBOO//+wjZcaVgcFV
 wRRiJKCE/sCLVeT3WsVbqYHkQG2I2Mudvu00WvK2DK3XkmLoxMS9YTTfw+EUtlMss5LHjkxi9JJ
 EIUbyVxqndaZFgBx1tKiDbxSgy3jGFWg==
X-Received: by 2002:a17:90b:4c48:b0:37f:db06:228f with SMTP id
 98e67ed59e1d1-380aa0be8b5mr2225408a91.14.1782927467044; 
 Wed, 01 Jul 2026 10:37:47 -0700 (PDT)
Received: from todd.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a8asm34228eec.2.2026.07.01.10.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:37:46 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v5] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
Date: Wed,  1 Jul 2026 14:37:41 -0300
Message-Id: <20260701173741.39177-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 40 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +----------------
 4 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca87669..ca85072f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -830,6 +830,46 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
+/**
+ * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
+ *
+ * @adev: amdgpu_device pointer
+ * @me_id: micro-engine ID of the faulty ring
+ * @pipe_id: pipe ID of the faulty ring
+ * @queue_id: queue ID of the faulty ring
+ *
+ * This function handles privileged instruction faults by identifying
+ * the faulty ring (gfx or compute) and triggering a scheduler fault
+ */
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					u8 me_id, u8 pipe_id, u8 queue_id)
+{
+	struct amdgpu_ring *ring;
+	int i;
+
+	/* The scheduler only handles kernel queues so this is a no-op 
+	without them. */
+	if (!adev->gfx.disable_kq) {
+		return;
+	}
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+		ring = &adev->gfx.gfx_ring[i];
+		if (ring->me == me_id && ring->pipe == pipe_id &&
+		    ring->queue == queue_id) {
+			drm_sched_fault(&ring->sched);
+			return;
+		}
+	}
+	
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		ring = &adev->gfx.compute_ring[i];
+		if (ring->me == me_id && ring->pipe == pipe_id &&
+		    ring->queue == queue_id)
+			drm_sched_fault(&ring->sched);
+	}
+}
+
 static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
 				   bool no_delay)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b4..0b2f6ce85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -611,6 +611,8 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
 						struct amdgpu_ring *ring);
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					u8 me_id, u8 pipe_id, u8 queue_id);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2c6f1e25c..888c9f3c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6688,37 +6688,12 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
 	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
 
 	me_id = (entry->ring_id & 0x0c) >> 2;
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	if (!adev->gfx.disable_kq) {
-		switch (me_id) {
-		case 0:
-			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-				ring = &adev->gfx.gfx_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		default:
-			BUG();
-			break;
-		}
-	}
+	amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
 }
 
 static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6baac533a..3f0d29372 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5019,37 +5019,12 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
 	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
 
 	me_id = (entry->ring_id & 0x0c) >> 2;
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	if (!adev->gfx.disable_kq) {
-		switch (me_id) {
-		case 0:
-			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-				ring = &adev->gfx.gfx_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		default:
-			BUG();
-			break;
-		}
-	}
+	amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
 }
 
 static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.34.1

