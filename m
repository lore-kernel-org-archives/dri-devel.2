Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB7BF8A147
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F63410E847;
	Thu, 16 Apr 2026 08:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="vzJLddTH";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD32010E24C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 16:41:14 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-127337e3870so1002163c88.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1776271274; x=1776876074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oXcD9MfeX1GJ1n1RE7y6mO2yX5tgwCmyUH9mMTiyKCs=;
 b=vzJLddTHVGQM3owW4UJlJLuIYvjw63Rl2/uJz9NDSGw5aFMOEmcP+7dB+ZHQOol7Xv
 VZsapBg0NdikzPZwK4CDOrzRz4Y81+Rb121KbxbxeAbeCCX1oN03b2/WDKivBKVSKaPe
 IDyGWJftwEfJ8tOxuBYlgCdYjbDM9sQB4bPwaZAIVQTpBLe1kun7EzJL8SVveSrTo6hT
 tVT9FRe03apyGL8xP4KjkzAndLzDYJBMwa64FgB8TOCEvFZzDuaAaD05qH4a/Ra6aimS
 dTPIpcX6C7iVScfntyH7uuMyfEWKsd8kxfl71+BUflIlY7Y5wXbf7h1aToxiunnI5J9m
 2uDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776271274; x=1776876074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXcD9MfeX1GJ1n1RE7y6mO2yX5tgwCmyUH9mMTiyKCs=;
 b=cphHf79c3jB7gyWV2N6ze2X9nmgZ+taibzGiH7y5+zQHxmx/6k20kJsLbumFq5TDu3
 fWrDNRmwp4SVNGCDlYfiS6nUh8kPBxWDuY9jB6Ij3xoIZMaZNW04BTAuB//h1/nFbz8Y
 2bdGuC++xUgbvvO47uA8jM+3T+x58DwpBqBB9zuw+4Upm23exikON82BJXISx7IFm3UA
 wEWKHd8yHRKAUU4U9uNbiXgvU0UoqaQhfT6p+2Kn+8/fX89puFtXwg1vFS5Ccb8kkTcH
 bnV84vvXUa0Sgu3yMDwjydSSx+TLDl1RI9Zda/d2UH1a1Cwenv19QzLJqxbYo6bt4Kx1
 /YAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ++gE5c0K0UvAKa/B4AJ8O4k6MtWHsVooRCMWiAmijOqWY6p45tIfZNFbSas3QpdyRxv4OZctGkmf0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfaK+umkdpLESRL5isMa0qpArGapSTmc0CmUTIp9zlrsKVpy8t
 l8ydfpL4J29cLKplQ9QSzsO/R9blJPFf8fn7Xuc/Glmss+uS2+frZltqhCH5yJw8wnM=
X-Gm-Gg: AeBDieuZns1MTxz716jVbcy2VB3n9TnQWqXMaE6tyf/MOloDJif+d080K9kX/oK5Pka
 UJjORAdKCIgPwDFPLOE60fRPJ11d96Izxvd1z0gJ/w388H5GZN1g9k7xsAkIpMWiOuiBrzEIS6r
 vQlmtQ824y6pRNZbDRx8ksQkaJXZHJ7yZe2eSaea8Cr5SGDeFUoW8S+qu3pZU9SwbjtKneMSurm
 syCUM+00jcuP60C/hP4iQt8kV2Gmw86buDyOZtl0ajB1+UYqI5UeZEHDzTzX2jQ8ksLQmXgj6lL
 N3mrbrQxGhk9EaYYrPzCGVR3q9G/zoHbsAiggmUEsDFuBjOgngRCnBGcQCZ+Wu9X4nxLO7bGHm5
 SV/GoTHf89cqBxGc4eYJYglc2kSVHcONUboddgCYF0vvOjf1XJ5oVhBqbqXpsk46+GyTRYFRHqP
 gigMcDVNUMgSwsHVsxjqPfijrjKEl4kICX2XACq3CqZ4xu1twt6xH8UnrP/UI=
X-Received: by 2002:a05:7022:6085:b0:12a:6d14:df9c with SMTP id
 a92af1059eb24-12c5d455d04mr739574c88.1.1776271273580; 
 Wed, 15 Apr 2026 09:41:13 -0700 (PDT)
Received: from Haru.. ([2804:1b1:f982:8e77:e072:4b8:656c:6b18])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c5f3f3d93sm1830325c88.15.2026.04.15.09.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:41:12 -0700 (PDT)
From: Leonardo Cesar <leonardocesar@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Leonardo Cesar <leonardocesar@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: deduplicate ring preempt ib function
Date: Wed, 15 Apr 2026 13:40:23 -0300
Message-ID: <20260415164029.52537-1-leonardocesar@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Apr 2026 08:39:27 +0000
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

The ring preemption function is identical for both gfx_v11_0 and
gfx_v12_0. This patch refactors the code by moving the core logic
into a generic function inside amdgpu_gfx.c to reduce code
duplication and simplify future maintenance.

Signed-off-by: Leonardo Cesar <leonardocesar@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 51 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 47 +----------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 47 +----------------------
 4 files changed, 55 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2956e45c9..a157cbd8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2684,3 +2684,54 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 #endif
 }
 
+int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
+{
+	int i, r = 0;
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+
+	if (adev->enable_mes)
+		return -EINVAL;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	/* assert preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, false);
+
+	/* assert IB preemption, emit the trailing fence */
+	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
+					ring->trail_fence_gpu_addr,
+					++ring->trail_seq);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	/* poll the trailing fence */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (ring->trail_seq ==
+			le32_to_cpu(*(ring->trail_fence_cpu_addr)))
+			break;
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		r = -EINVAL;
+		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
+	}
+
+	/* deassert preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, true);
+	return r;
+}
+
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b4..77050f988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -664,6 +664,8 @@ void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
 
+int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring);
+
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
 	switch (mode) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5097de940..ef9c61d9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6208,52 +6208,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 
 static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
-	int i, r = 0;
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	unsigned long flags;
-
-	if (adev->enable_mes)
-		return -EINVAL;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	/* assert preemption condition */
-	amdgpu_ring_set_preempt_cond_exec(ring, false);
-
-	/* assert IB preemption, emit the trailing fence */
-	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
-				   ring->trail_fence_gpu_addr,
-				   ++ring->trail_seq);
-	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	/* poll the trailing fence */
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (ring->trail_seq ==
-		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
-			break;
-		udelay(1);
-	}
-
-	if (i >= adev->usec_timeout) {
-		r = -EINVAL;
-		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
-	}
-
-	/* deassert preemption condition */
-	amdgpu_ring_set_preempt_cond_exec(ring, true);
-	return r;
+	return amdgpu_gfx_ring_preempt_ib(ring);
 }
 
 static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 65c33823a..fc5ec2778 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4613,52 +4613,7 @@ static unsigned gfx_v12_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
 
 static int gfx_v12_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
-	int i, r = 0;
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	unsigned long flags;
-
-	if (adev->enable_mes)
-		return -EINVAL;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	/* assert preemption condition */
-	amdgpu_ring_set_preempt_cond_exec(ring, false);
-
-	/* assert IB preemption, emit the trailing fence */
-	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
-				   ring->trail_fence_gpu_addr,
-				   ++ring->trail_seq);
-	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	/* poll the trailing fence */
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (ring->trail_seq ==
-		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
-			break;
-		udelay(1);
-	}
-
-	if (i >= adev->usec_timeout) {
-		r = -EINVAL;
-		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
-	}
-
-	/* deassert preemption condition */
-	amdgpu_ring_set_preempt_cond_exec(ring, true);
-	return r;
+	return amdgpu_gfx_ring_preempt_ib(ring);
 }
 
 static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
-- 
2.43.0

