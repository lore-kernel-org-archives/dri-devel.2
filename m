Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2BCFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A3610E21D;
	Wed, 29 Apr 2026 10:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="ANz+d50p";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E7910E2CF
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 19:16:11 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12c87f1f8c8so702450c88.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 12:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1777317371; x=1777922171; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/gnG/TV4QlirwEhC4yr5r/hW1goyUy/VqJ4SZeh+gDg=;
 b=ANz+d50pEOgqZW9ADk7BlDe4vHVc5v1KgJrI70JjWOciAvfrDOQFHVnnXef0T4eqiT
 T8+gAzvVasxJQye+bM/rSvdc1zIpVrClD7ulntQIjPHroxez1zf/+X/BK2Mh/kv2X60j
 4g+HUlivWnm21k1pb8wqDzBh1lyDwJ6V75z6E6JemCa3m4K9H2Z1sFe/xK43aLdwtOG/
 LCIDrs1B5/0BUglNzlsPW7E+bdVJSukR/OAF8p7tPPepJjSo2D4sXlxFulohAEQvCFpM
 Si+HF3XNa/9G7/LAzE0e9nQhz1hv8dpMI5gGZb2xIfXGIuYm+EXTemp2gZhnph0qZXaP
 CAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777317371; x=1777922171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gnG/TV4QlirwEhC4yr5r/hW1goyUy/VqJ4SZeh+gDg=;
 b=OQgB5xx81skbHAWSJ+zvrGbz1l9sgU64FtxL+sJAKD2uIij1ZMLwbznueRFmms2Mf4
 lJlG7+T5LPCIV2PD0f82MDobu8HHTb630cGowO9Dsoz+pmsyTXkf5g2INKuYPLwiO7/y
 Yj5n50DGKl9jwG+1hFWaNE29s2vE6TgWBiZUSyNN0Ssj0uR88pvlsYllNsXkKbHgktVL
 imHFph+LZbLY6r6OrcHdq16oFA9dGemSf694qHpO4VW6Gu183m7V+VKIitiNG5Aaaozq
 MnG6WSJ25DL6mEdGEbxi1EV9zZ82AVITBOjXwLtH04eVYVxREGNhjscxqOSEs2xJJbqo
 cjpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XSdiRcDKjfJx/sc3xVJJCg7mN+O/HcH0TAgbp26BHD08RwWHNz4qZq/s0iroqA1V5u9Wn0G8Xga0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfWK5yLfnp5QnZFk6jnP580W47KwnT8oF1mTB5QNQaJeaxWG1e
 0iTMWzLlgIsw7cve1At7URZi8eFysf1AdhrXQ6yPOkQB5+/yTSYXV4Ojqbgjwt9gPAE=
X-Gm-Gg: AeBDievyCt3JPc4gSHEq5jB3ejuREJEwwS5FD9WV24XtpCaCrdv85X56/kmjmmXsUfY
 T4XNuxknMgM8i+RibwN4zRSKywrcpT3lR8lZgWqMRg43xnu3Fvhnds9mQhQenM7x4KrqF2LSFyx
 wQxpy68FxWvm7fx0dDqjGtJbDgNIyEDztyFsHGxYyBuXd4kyjn66w+G/6yN/MJEBZfy6e7MwLCQ
 y58stqLCT0JZBjRam7hGEXp3j878GkaXysB17rWYFfsuJV6QkM/H4aoL8RT0GTmbNzNW7syoz48
 /E0cN94adMqMi58GepGyKwjgRgbg+7ICX2+s7rgF5178W/jqHhNe1CEWTPuHzij6r9XCKPz7Fz5
 Dc0JR20QITX13jE+AJ/xTf9EwQRCuXB90DMbbwSHT0/GARt0nmu2wehRRYwzV4oSktbguOqyRuc
 AjwrDglGyDkOqPbilqKEERzKmzVkgAF05ynINVZs8EAfDq3Fn9RCCtEK3HON/O
X-Received: by 2002:a05:7022:f8c:b0:12d:b4e2:f566 with SMTP id
 a92af1059eb24-12ddd539d5cmr109672c88.4.1777317370737; 
 Mon, 27 Apr 2026 12:16:10 -0700 (PDT)
Received: from Haru.. ([2804:1b1:f983:1702:93e0:14bb:90e7:dc5e])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ddd9b1e3bsm144583c88.13.2026.04.27.12.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:16:09 -0700 (PDT)
From: Leonardo Cesar <leonardocesar@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Leonardo Cesar <leonardocesar@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/amdgpu: deduplicate ring preempt ib function
Date: Mon, 27 Apr 2026 16:15:19 -0300
Message-ID: <20260427191556.9672-1-leonardocesar@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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
v2 -> v3:
- Style fix: Move variable declarations to follow reverse christmas tree and do not initialize 'r' on definition.

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | ...
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 53 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 52 +-----------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 52 +-----------------------
 4 files changed, 57 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2956e45c9..45d41f24d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2684,3 +2684,56 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 #endif
 }
 
+int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	int i, r;
+
+	r = 0;
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
index 5097de940..1ba848bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6206,56 +6206,6 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 	ring->set_q_mode_offs = offs;
 }
 
-static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
-{
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
-}
-
 static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -7295,7 +7245,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_cntxcntl = gfx_v11_0_ring_emit_cntxcntl,
 	.emit_gfx_shadow = gfx_v11_0_ring_emit_gfx_shadow,
 	.init_cond_exec = gfx_v11_0_ring_emit_init_cond_exec,
-	.preempt_ib = gfx_v11_0_ring_preempt_ib,
+	.preempt_ib = amdgpu_gfx_ring_preempt_ib,
 	.emit_frame_cntl = gfx_v11_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 65c33823a..6cf244349 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4611,56 +4611,6 @@ static unsigned gfx_v12_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
 	return ret;
 }
 
-static int gfx_v12_0_ring_preempt_ib(struct amdgpu_ring *ring)
-{
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
-}
-
 static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				     uint32_t reg_val_offs)
 {
@@ -5539,7 +5489,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_cntxcntl = gfx_v12_0_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v12_0_ring_emit_init_cond_exec,
-	.preempt_ib = gfx_v12_0_ring_preempt_ib,
+	.preempt_ib = amdgpu_gfx_ring_preempt_ib,
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-- 
2.43.0

