Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD42F99C6B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3405910EAB6;
	Fri, 17 Apr 2026 21:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="aXaqUJuV";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF5310E9A0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:09:12 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2d891442388so803836eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 02:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1776416952; x=1777021752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C2wKA1yVcMsJu1M0EUhRteBa/Co3QmXF+nojHfyR9YE=;
 b=aXaqUJuVYKcooJk+BD3Q8S4usDBX3oE3CCJbFcmZRteQZv+t6psF6zCkAG8DMamaD+
 CYE/KdWTl9tVR2KPj7eixSR0wHq18glSca+ZJSR0YjOvk56zZyzHVxxroLTYayzkHoF3
 91DuhzlhWsRLaJvEZdltjmy+gBpSmydyU8KMdApJnK5F5Cgjppum7Tsdzd6lb3nKdQRh
 WiLfV9h+4kqzb8583qQEgh1jdF5e/6uRJwZjE2uah9KAfAKv8B/UqpU7VtAMhBmboV2i
 fisLo2qHXjtlvfUEQwjXc9KcBAwnnJYN5nHMA5qCm9yOOGVQHVoooxj81FzlVcKjW2wo
 b4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776416952; x=1777021752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2wKA1yVcMsJu1M0EUhRteBa/Co3QmXF+nojHfyR9YE=;
 b=H2yFtElGx9dw33yN3sqyAG5QtAvjEq+E/yE4HJao3s7/cAMKz6VAbvfXHz3ZsUAyKJ
 Wp128m0LMRqHGYcTF+eZApcwNJDng8i/C4IbDJpPpvUFlxxhEXB4Su50n4EAjsnizhdi
 ZjsiLPo/VWCr2tA+FGFDFifcfkyzd3oMQSLNMPcInQEkCH8ZLzn3CvQh2XB+ttEIT8ab
 0ylMEYqyt8stcE5YLJ4EUw1e6peXwbfY+EE5heKvg+y+Tc2ylInkg5ElLrvXjzOtcEYh
 qiWycJqzO/ILUgb4XnSKQ9btCDcRZ+q8ayU1WkPV/bnX/yAqabt3UqXDwNymZAY+dLpM
 hPMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+X6420F3a23mAXz5ySBg91um8RBEAUFWAkH08AFIHM2f4Id/Jo3yRWaEuamdQNAj52eIaXHbwL1aA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8rC51Yxbf/VtW2g+2IpAu+BWZsAs34yiXtiv2RQhwaFekznvR
 jMXBTj30ogCzIfKzsNg3yTjuN/5dlI7vHoi8YtlyZDtcAfrTlPmUwmhJEeDBLzc8m9s=
X-Gm-Gg: AeBDietpEF7n9Lw9gygZnskCh9BKq61+TTOJIEMd8YicmgGIiKZEpWwT0yTacKjJWnx
 Gyzn5E11nbqWbPVLIc3UGReBkm/8IJeJYKotwhaHUaeqT5uDQgye3IqcfltKpTALoZj4XByRunh
 7v7XmlWSjy0iVnBKIWuhY8nLYYjycitIwNv4KjJIyxtM0Bb3sEpZRtTm82NXYyLFi5XS+hFX4Wg
 YSa/C2l4RqC+YaY+HIE2gBNNERCNYPtT/3gFaxnf6i4yvPPiUpbHuPnDwpyKyw7wCQ1qd9BlM5j
 wWhjpVdWUMQsEuYv4mhLl/VVWBs57mxjjvPJjjF8arcUQY2n/m8VIf2C1P/Svw+4an4PZYELzkV
 QGWeMYQUMRd3lDO5QrIP0KYC/ramlcnQsoXXq2hpHfHxVyONetKHJzT8RBvUdYsh+ESLiYcn2Vm
 YrEzYU
X-Received: by 2002:a05:7301:168d:b0:2c5:50fe:c771 with SMTP id
 5a478bee46e88-2e47930a618mr949576eec.29.1776416951823; 
 Fri, 17 Apr 2026 02:09:11 -0700 (PDT)
Received: from nitro.. ([2804:7f0:bb81:28ee:8f54:2ff9:60b8:deac])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d8b3dd9sm1284328eec.27.2026.04.17.02.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:09:11 -0700 (PDT)
From: Erick Henrique <erick.am@usp.br>
X-Google-Original-From: Erick Henrique
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Erick Henrique De Araujo Moreira <erick.am@usp.br>,
 Lais Alves Da Costa <laisalvesc@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Deduplicate eop_irq v11/v12 functions to use
 helper
Date: Fri, 17 Apr 2026 06:07:52 -0300
Message-ID: <20260417090841.6190-1-erick.am@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 21:55:06 +0000
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

From: Erick Henrique De Araujo Moreira <erick.am@usp.br>

Identical code implementations to handle the ISR for the EOP signal from the
graphics and compute engines of AMD GPUS on the gfx_v11_0_eop_irq()
and gfx_v12_0_eop_irq() functions.

Introduce a shared helper amdgpu_gfx_eop_irq() and convert the EOP
implementations to use it.

This reduces duplication and improves maintainability without
changing behaviour.

No functional changes intended.

Signed-off-by: Erick Henrique De Araujo Moreira <erick.am@usp.br>
Co-developed-by: Lais Alves Da Costa <laisalvesc@usp.br>
Signed-off-by: Lais Alves Da Costa <laisalvesc@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 55 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 48 +--------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 48 +--------------------
 4 files changed, 61 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2956e45c9..3ac7d9305 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -34,6 +34,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_mes.h"
+#include "amdgpu_userq_fence.h"
 #include "nvd.h"
 
 /* delay 0.1 second to enable gfx off feature */
@@ -2684,3 +2685,57 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 #endif
 }
 
+int amdgpu_gfx_eop_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry)
+{
+	u32 doorbell_offset = entry->src_data[0];
+		u8 me_id, pipe_id, queue_id;
+		struct amdgpu_ring *ring;
+		int i;
+
+		DRM_DEBUG("IH: CP EOP\n");
+
+		if (adev->enable_mes && doorbell_offset) {
+			struct xarray *xa = &adev->userq_doorbell_xa;
+			struct amdgpu_usermode_queue *queue;
+			unsigned long flags;
+
+			xa_lock_irqsave(xa, flags);
+			queue = xa_load(xa, doorbell_offset);
+			if (queue)
+				amdgpu_userq_fence_driver_process(queue->fence_drv);
+			xa_unlock_irqrestore(xa, flags);
+		} else {
+			me_id = (entry->ring_id & 0x0c) >> 2;
+			pipe_id = (entry->ring_id & 0x03) >> 0;
+			queue_id = (entry->ring_id & 0x70) >> 4;
+
+			switch (me_id) {
+			case 0:
+				if (pipe_id == 0)
+					amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
+				else
+					amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
+				break;
+			case 1:
+			case 2:
+				for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+					ring = &adev->gfx.compute_ring[i];
+					/* Per-queue interrupt is supported for MEC starting from VI.
+					* The interrupt can only be enabled/disabled per pipe instead
+					* of per queue.
+					*/
+					if ((ring->me == me_id) &&
+						(ring->pipe == pipe_id) &&
+						(ring->queue == queue_id))
+						amdgpu_fence_process(ring);
+				}
+				break;
+			}
+		}
+
+		return 0;
+
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b4..a180d1903 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -664,6 +664,10 @@ void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
 
+int amdgpu_gfx_eop_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry);
+
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
 	switch (mode) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5097de940..767887d7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6494,53 +6494,7 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 			     struct amdgpu_irq_src *source,
 			     struct amdgpu_iv_entry *entry)
 {
-	u32 doorbell_offset = entry->src_data[0];
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
-
-	DRM_DEBUG("IH: CP EOP\n");
-
-	if (adev->enable_mes && doorbell_offset) {
-		struct amdgpu_usermode_queue *queue;
-		struct xarray *xa = &adev->userq_doorbell_xa;
-		unsigned long flags;
-
-		xa_lock_irqsave(xa, flags);
-		queue = xa_load(xa, doorbell_offset);
-		if (queue)
-			amdgpu_userq_fence_driver_process(queue->fence_drv);
-		xa_unlock_irqrestore(xa, flags);
-	} else {
-		me_id = (entry->ring_id & 0x0c) >> 2;
-		pipe_id = (entry->ring_id & 0x03) >> 0;
-		queue_id = (entry->ring_id & 0x70) >> 4;
-
-		switch (me_id) {
-		case 0:
-			if (pipe_id == 0)
-				amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
-			else
-				amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				/* Per-queue interrupt is supported for MEC starting from VI.
-				 * The interrupt can only be enabled/disabled per pipe instead
-				 * of per queue.
-				 */
-				if ((ring->me == me_id) &&
-				    (ring->pipe == pipe_id) &&
-				    (ring->queue == queue_id))
-					amdgpu_fence_process(ring);
-			}
-			break;
-		}
-	}
-
-	return 0;
+	return amdgpu_gfx_eop_irq(adev, source, entry);
 }
 
 static int gfx_v11_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 65c33823a..aadebb4d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4846,53 +4846,7 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 			     struct amdgpu_irq_src *source,
 			     struct amdgpu_iv_entry *entry)
 {
-	u32 doorbell_offset = entry->src_data[0];
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
-
-	DRM_DEBUG("IH: CP EOP\n");
-
-	if (adev->enable_mes && doorbell_offset) {
-		struct xarray *xa = &adev->userq_doorbell_xa;
-		struct amdgpu_usermode_queue *queue;
-		unsigned long flags;
-
-		xa_lock_irqsave(xa, flags);
-		queue = xa_load(xa, doorbell_offset);
-		if (queue)
-			amdgpu_userq_fence_driver_process(queue->fence_drv);
-		xa_unlock_irqrestore(xa, flags);
-	} else {
-		me_id = (entry->ring_id & 0x0c) >> 2;
-		pipe_id = (entry->ring_id & 0x03) >> 0;
-		queue_id = (entry->ring_id & 0x70) >> 4;
-
-		switch (me_id) {
-		case 0:
-			if (pipe_id == 0)
-				amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
-			else
-				amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				/* Per-queue interrupt is supported for MEC starting from VI.
-				 * The interrupt can only be enabled/disabled per pipe instead
-				 * of per queue.
-				 */
-				if ((ring->me == me_id) &&
-				    (ring->pipe == pipe_id) &&
-				    (ring->queue == queue_id))
-					amdgpu_fence_process(ring);
-			}
-			break;
-		}
-	}
-
-	return 0;
+	return amdgpu_gfx_eop_irq(adev, source, entry);
 }
 
 static int gfx_v12_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
-- 
2.43.0

