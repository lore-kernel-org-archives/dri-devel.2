Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C188ACD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026EE10F231;
	Thu, 30 Apr 2026 07:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="AGz8tEj7";
	dkim-atps=neutral
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE1DD10E2E5
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:37:10 +0000 (UTC)
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-9589125e047so44195241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1777484229; x=1778089029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9jIAgqmNQYvaI7Z1F5IA3p1ashE9xvLiL45a/VfhazQ=;
 b=AGz8tEj7LCvd0qmhBww4UeHOJjveUQFjIg63SOEfXi1qYlMM6lW2hAkUEgNz5tJfaB
 Iu61kzU2miuE5Bu9L1XDo6Id2Sb3UZ8y0nELvbmR1ew9RptSGwBSc0A/LKPbRkPjw2z1
 xytsm6Bw2JEJpvjIdmkZ0LJIW1UrTCTsvTlqIKyHWu/M3PPLqj9GhZJbNu3o39jwKYDZ
 my/mwvPJV87awSsPonrcftAUO/f9lun2j334aRmht/CAmJwtNeQEODjDP6bYx7onrTwm
 WAe0u94yeHLxVtnkdXhiR9CKy6PLrWVET5ZNw57P10ptl086qXiE6dck1vvZmW/975Ba
 b2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777484229; x=1778089029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jIAgqmNQYvaI7Z1F5IA3p1ashE9xvLiL45a/VfhazQ=;
 b=dYfd1GzNR/4avcIhYfVoOpXo85e5xxyrGSGK+tlKSMcRPvCWneTfw1s81Y7a1VfJyt
 5oY4tI+8z3DPXDG7/Bzhus6bJFXgJRDdyL8l+epf8PwMYyZ4ACyc3KH70QCjBXJ6Mpk8
 TXE2i1ndZ0GzLqdiy9OhwZSUN4MR5kXn3C7bYlSjGjOINXoSVAdyP71Cicr2KrZrpb3I
 FLfknvdp07mezJrdfaybFPe/XEK0GmZj/TGO4nQ74zV6GrApa6qOsVGzTKaFHnQtFSnM
 neFjdm2Zun0mtC29ddN/85b0napCRpiE+G7NKqn2XzibNjvIKRyVHOpd8IyJ6PhffMtQ
 dRAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+q29DOFBjw8nUWR5j2LlZjqvxMLaa3AYfFEJjS/skHr1U35c9wr1LO1GmTk5gh6zZqUIu1/ejghBY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpmEjWcujuWIIsPAOnDn03r+Bwxvpe1OBoNewTeiA3S/4HV3U5
 9e18yf42gdwA45Imytn52qGax/w1j09hCOcnVK4X/HUOTTYtG+C2HNVyQOF7uzI4wTQ=
X-Gm-Gg: AeBDievLVRpNq7h6IKQJ8r7sG94y6ZJl4Y8kITYnRg+hEgpOpwibC45w8Gwm1vw/3iX
 BVvT/Yv1BpZ1t2cVXJy4fiCmbnsjqDuCKG7Al1CHDdE+cp6pTyQWpJBv2mNhPuM3Q6yE5ii+mkW
 jy/UY0RYugYMaVxMtgIE6lZdYt6fRanveR7kN+U4z8JvJ/FFBYc17LuWiFgiV4vuWvahzrMZtmn
 qSTmve5cDJIo5AtYZ0FCJWjrXvDQij9YaW1mSv3Pj/Oif5eQhsPFn0dlIj2IMDKCUBWS1m1JWhF
 yl8soeOC4eRf026Nyor6SA4mHQjMKaKSK3v4+TTVXSfhBX46+4uOxbxjE9Dvyqb5ovnJmyFgQac
 lI4prDm8oEEt3eU7i6BDJlwQEmWDONWW3IRHaE4sgrc+/HzLMsLwPaYJaLS1hLICQwL9yRYD+sC
 QHjgX4zPP0YPV2z/BWTDWmvs6zByNvxrOa1Fa1Lec9g5EO5qc=
X-Received: by 2002:a67:c512:0:b0:610:347f:9f3b with SMTP id
 ada2fe7eead31-6296a37b409mr1241963137.3.1777484228886; 
 Wed, 29 Apr 2026 10:37:08 -0700 (PDT)
Received: from localhost.localdomain ([152.234.115.70])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95cb760fbe7sm1389109241.7.2026.04.29.10.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 10:37:08 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12
Date: Wed, 29 Apr 2026 14:36:46 -0300
Message-Id: <20260429173646.7653-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 07:37:56 +0000
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

The functions gfx_v11_0_handle_priv_fault and gfx_v12_0_handle_priv_fault
are identical. This patch replaces them with a single implementation in
amdgpu_gfx, called amdgpu_gfx_handle_priv_fault, to reduce code
duplication.

Signed-off-by: Ulisses Paixao <ulissespaixao@usp.br>
Co-developed-by: Felipe Sousa <felipesousa@usp.br>
Signed-off-by: Felipe Sousa <felipesousa@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 46 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 43 ++---------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 43 ++---------------------
 4 files changed, 54 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca87669..c8d769cb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -830,6 +830,52 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
+/**
+ * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
+ * 
+ * @adev: amdgpu_device pointer
+ * @entry: interrupt vector entry from the hardware
+ * 
+ * This function handles privileged instruction faults by identifying 
+ * the faulty ring (gfx or compute) and triggering a scheduler fault.
+ */
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					struct amdgpu_iv_entry *entry)
+{
+	u8 me_id, pipe_id, queue_id;
+	struct amdgpu_ring *ring;
+	int i;
+
+	me_id = (entry->ring_id & 0x0c) >> 2;
+	pipe_id = (entry->ring_id & 0x03) >> 0;
+	queue_id = (entry->ring_id & 0x70) >> 4;
+
+	if (!adev->gfx.disable_kq) {
+		switch (me_id) {
+		case 0:
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		case 1:
+		case 2:
+			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+				ring = &adev->gfx.compute_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		default:
+			BUG();
+			break;
+		}
+	}
+}
+
 static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
 				   bool no_delay)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b4..5655af43d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -611,6 +611,8 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
 						struct amdgpu_ring *ring);
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					struct amdgpu_iv_entry *entry);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2c6f1e25c..da869f928 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6684,49 +6684,12 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
-					struct amdgpu_iv_entry *entry)
-{
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
-
-	me_id = (entry->ring_id & 0x0c) >> 2;
-	pipe_id = (entry->ring_id & 0x03) >> 0;
-	queue_id = (entry->ring_id & 0x70) >> 4;
-
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
-}
-
 static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal register access in command stream\n");
-	gfx_v11_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
@@ -6735,7 +6698,7 @@ static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,
 				struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal opcode in command stream\n");
-	gfx_v11_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
@@ -6744,7 +6707,7 @@ static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal instruction in command stream\n");
-	gfx_v11_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6baac533a..883878e23 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5015,49 +5015,12 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
-					struct amdgpu_iv_entry *entry)
-{
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
-
-	me_id = (entry->ring_id & 0x0c) >> 2;
-	pipe_id = (entry->ring_id & 0x03) >> 0;
-	queue_id = (entry->ring_id & 0x70) >> 4;
-
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
-}
-
 static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal register access in command stream\n");
-	gfx_v12_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
@@ -5066,7 +5029,7 @@ static int gfx_v12_0_bad_op_irq(struct amdgpu_device *adev,
 				struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal opcode in command stream\n");
-	gfx_v12_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
@@ -5075,7 +5038,7 @@ static int gfx_v12_0_priv_inst_irq(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	DRM_ERROR("Illegal instruction in command stream\n");
-	gfx_v12_0_handle_priv_fault(adev, entry);
+	amdgpu_gfx_handle_priv_fault(adev, entry);
 	return 0;
 }
 
-- 
2.34.1

