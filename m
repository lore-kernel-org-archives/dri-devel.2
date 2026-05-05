Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3406ECD343F
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 07:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A5D10E4BB;
	Wed,  6 May 2026 07:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="miNyr8iq";
	dkim-atps=neutral
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C5A10E13B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 17:50:23 +0000 (UTC)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-5752b279662so796403e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778003422; x=1778608222; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsyB8L0ph4cC4uwcAMz3kIiPlavHdL5/IakECCF4TVU=;
 b=miNyr8iqeRjwcirjt+PVRqT4abzC7FGaopot77puDrpt0KzZwabTdbdTh0HDeoXbLJ
 d2oNweUS7Ob2V0LEA0UVVZWoox0wfK2t+w9TWsxpkeaj4QnLWG9c+ftXG7ASfA9nFIn3
 gMZJwy/57alC8z6/Nvt7SiDa01sedfc022mXaIq8e7Z1+wLHddgmfzlGacgMkmw9aQZY
 8oA2TbLWTyXlKpgXPbgMiEI/DqWT1ioDyU9iqiTyg069gWmzusnpEOOOSOUweDg7Zpof
 cNrBjhgeGg9r8niG3A0gRCKlkNQ5ZwjCGz4PBXd3jYqyDsFrzQWhCywguK/EkSc38ccJ
 3Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778003422; x=1778608222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XsyB8L0ph4cC4uwcAMz3kIiPlavHdL5/IakECCF4TVU=;
 b=RENRfeS7Y/+4AEk+njM/ZU3RfCUzS4kCTjP6Kheb3bTCiuQmFXwJ5FGdYXhCsPgp6g
 Psm67J7Y47s0OCSs+NsPLfHY0kRmErRkbJQkXc+hgMtEtNbDpELjb+/XtQzOjop1ynyG
 20ly51Y3711u+vVXVP4OnuENj0hORhIjhmr/re42SSTJhwOwfpHFOQEnyqzEg1ewXyIU
 Sy07ac8W9gWqr8/h3INmf5ZEJ8qp32+n959qWtwJDG1X/SN0NcMUEyG7DVS91LwXoIvK
 1sHqU2Z7wZ1NMcBDZ5AQYi3seCoKtyNHWKzME2hgE9hRrDmM1boODgSSzYYJaDk8kvBf
 C1WA==
X-Forwarded-Encrypted: i=1;
 AFNElJ97xlAkIMKNoaVc+crJ4L39a3x+WRIseojgwJihPhTikvu3IxiHOctPk1VHKjuNfwh6vn+Mc8hxvYg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxR0rm3lZgPbq/RzK1UWMdy4wA8bghzqpq1KhsLCQysx/7BHpUz
 V6bq7Yb8yo4oQeX30w6jC302H6wqNQrEz8z6yVZrCG25aq5RHW/14fhRzL31svoTMGY=
X-Gm-Gg: AeBDiesF422vGwv8J3PUjDKgY818jaCMUDXSSXZmBeOYiQejqNks1+c3+AphEh8KLP5
 xgWQVKaOdYLNk6GfvUSfZ875mMWaxW6d4v9OFDMOo8cjRPVW15DHKSFXb0xkmpjVo8h/Xuryku9
 2m7SJW/C7UUKG0FET+KiYu3ozcdAjhhqe5O1cyWk6l1EINFT3rQnJQ6zvJx7U/9i6zhTlWrhXid
 V2XodJ9PgxI1bNDLvbNCVq0jXfTmCW4zWqC0XDPYPoRydZUUSHObRjcoGJWv803ZswbnPruwjtL
 LbDBbuVxoJ1Kd4UCzm+ikd+xgD+bz2B4h9+IlScKWUNVYRSvVoP+1RcVDHfTzlW268aZ3aeWKg/
 JCN+9w7z5Bjlme9vfQ9Z+DajiAPjwqx/EUAW1CnNHiVyFISPcc/TmIfKm6k/XWKKaEDofm/p0i7
 boc191paXgeFrg3YElbvdjjt4XpBEEadufjF9Ovp7h8lO2cgs=
X-Received: by 2002:a05:6122:8294:b0:56f:694e:1f10 with SMTP id
 71dfb90a1353d-5755958167amr79509e0c.5.1778003422048; 
 Tue, 05 May 2026 10:50:22 -0700 (PDT)
Received: from localhost.localdomain ([152.234.115.70])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5749f835632sm8442672e0c.5.2026.05.05.10.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:50:21 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
Date: Tue,  5 May 2026 14:50:06 -0300
Message-Id: <20260505175006.13519-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fe76a5db-7d18-4f67-be38-723a5821a818@amd.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 May 2026 07:47:21 +0000
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

---
v3:
Return early if the ring is found in the gfx rings loop.

v2:
Keep the HW-specific decoding in gfx_v11_0.c and gfx_v12_0.c.
Remove the redundant check for adev->gfx.disable_kq.
Simplify the search loop in amdgpu_gfx_handle_priv_fault to iterate over
all gfx and compute rings without a switch statement.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 34 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +-------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +-------------------
 4 files changed, 38 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca87669..0e9f9fec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -830,6 +830,40 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
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
+ * the faulty ring (gfx or compute) and triggering a scheduler fault.
+ */
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					u8 me_id, u8 pipe_id, u8 queue_id)
+{
+	struct amdgpu_ring *ring;
+	int i;
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

