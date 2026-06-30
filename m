Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4990C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6A810EDF7;
	Wed,  1 Jul 2026 07:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="dfJnc/NP";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCC610E1C4
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 20:55:53 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30edbb0dc5fso4056064eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782852953; x=1783457753; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q15Zw2luJWYA16XSjllrT6+cPa1JqXGGEaoXxQ4s5kU=;
 b=dfJnc/NPECC2Y+r+sWzyDXH/R4v4ZvqFwGmRpCf+INRg+xhH5+aLOkAZt1KW/ANiMs
 vMsneIXqtbe/sq/aNQdvYVSTrh429VRA/xzZ8N2msxtg3Jcr8+CmvCkVcAj8fqZaFJLV
 /ehJWRWWQt/SiyLPjRBMSk6eGiZO/2JlI/n9NNZGdTgQ7M7+YTefEZQxGwA7dl9g0otR
 dQY5HXVTwJE5HTaEjMkmrSbtOCnIlsiiEWEuqRDg+hozUA5U18uCBECBz76RpdnDNIPx
 zf9dDgJOBFzhFFgS2EVhoNMCUAih4VOjIfGylEi2VtbCODUTeaan1OjGGM9G8y8ZZPCO
 HO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782852953; x=1783457753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q15Zw2luJWYA16XSjllrT6+cPa1JqXGGEaoXxQ4s5kU=;
 b=BHUnXsVUK6/KrFizuWPrBpdoAfdjA5RvxQ+f1NYQQCM7rIkveyVXVTMdPzLkQNWKJa
 XrYa3UtKCu3y0zDFOvR6m02WrMQXYOmcS/xId3OdPJbptGbhTrF7COs3h7AWgHPCnAI0
 Qi6dUgtv5FvoyDOW0DgNX5307b1GmOXNbrRy5ZaLe/9rBNsrK7JHzTFKHT+Ut/Xh8An0
 QSwhaG55kbYCnkVs0r0au5d3GyK3/umaqkEa4cFRUI6oRn4ISXzqHWJPgSe6KZkWMALG
 SkmgqnAtiniY1540A8JHwSHLKVm0LeGX1F6xAc5UviCSQ4z2V0vhY/atyPjfUZzUOkbN
 wv5w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rogid8eEn802DnVDs5sZuO1xpO2639F9cFZT7aD/gD4HeFHA+tPEY6PljyW0qvPC+jvGHMK9zf7o6U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfGnlZ1l0BajSQ8zH1mzHrHH0vLR82pvn6M/riLgxcUSfbB90y
 E58+RKV2JwDHYpXJUycYO7WgbSOxmrxZlsx4I86Rzflgkieup1sG5y6jTddo9vQY1iY=
X-Gm-Gg: AfdE7ckuyg2sodO/8imOhR2MdgCs34U97HPVa3LBqlFoO5egyy385Vn+WuKazEy/PFQ
 P85O2LgheIE4LlovWfhM4zUqQXSAPZA1k7qZmlvvzxqI/ZaV7Gf2TZK+h5VTREewNa7rTh4lXLg
 K8r/qE388O/SosKjoibqDOKgtvopvp93zFsNOiQkgfZm0YxhRv+0Gwo1hlLBG0wMGrXM5YhuJg2
 XCJW/vl6c0qLQwBXfg4/o7g9CQ3lqEKPqV1djNRzefPbY6zTYrd+GAqh6qgquM/EQ6Ci4fPtHXG
 ziC5doUyguiswiZWKOMnSCKuuyCT7PbxF8xEXTMVG6nor0EBH6PMh7tQTJBvqXh1asZ3Aa+/Cyb
 LJACe7/XAeHbgsnTLbyhsI/2qJbPdsp0+gDh4mzAhn7FY+bqGuR0hAT6h4A5tLm1Hr7q0pymHAd
 d8A4+8bJN9eEzb0nsHTWKpNZjyng==
X-Received: by 2002:a05:7300:6401:b0:30c:38ed:46b0 with SMTP id
 5a478bee46e88-30ee135837emr3998893eec.16.1782852952717; 
 Tue, 30 Jun 2026 13:55:52 -0700 (PDT)
Received: from localhost.localdomain ([179.100.109.21])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee327cea7sm12321464eec.31.2026.06.30.13.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 13:55:52 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v4] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
Date: Tue, 30 Jun 2026 17:55:45 -0300
Message-Id: <20260630205545.23920-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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
Note that v2 was already reviewed by Christian.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 36 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +------------------
 4 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca87669..98035129a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -830,6 +830,42 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
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

