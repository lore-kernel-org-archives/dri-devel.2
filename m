Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EB3C982CC
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 20:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A431610E1F9;
	Sat, 19 Sep 2026 20:09:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DvVJDzHX";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EA810E1F9
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 20:09:30 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-398b1e63c49so2112513a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789848570; x=1790453370; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yt8mYcrHfU6wtp+xuS+0jjsvHTtir7paMP+9tSkwoLE=;
 b=DvVJDzHXrrhWPlZO6GkRr0JGlenJ8wQ8raqyCkFfcbXHC4zw7A33kaugKUtDbkLDjg
 CrqG/OOjHMaLizlwEGb1N2k6Ggb2xHdHDneIpv0ckYAn/jWW2GGEPoBU1EYFVY/MFg5V
 rQsYoNeQhZBeskCsnhoUmxAC3jbFGluDWs9W/7SIHqlZ6efwTvu2ibAbavYACq9raSnu
 NqUdgVKXrEQDQ1oQAhQxImYki29cs+jq8kmRYtcXFHTgA7r162XedeBVBz4EzhM5v8OJ
 COMNbFLaYJj0eIWvyVYQOdvVs194/qjDx8vKYNCLRpFf9oSg/ZObDsgnHJBJduCkRYoq
 Mz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789848570; x=1790453370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yt8mYcrHfU6wtp+xuS+0jjsvHTtir7paMP+9tSkwoLE=;
 b=jJ3FHnkPLCnDo/tIRtZBhi5PTmVu94HAK6qnwJU5IkbWN77b2IO6DHQ+vyYbdnkRLd
 fa+1fkgpbIm/BFUFCxwtpLQgTXcIHYSbCE7xMsQripLSodSg0FMpwGmGPSP/pjaA3WU1
 CgkTePAzACyPadq31tf6Cjid8ba0D1rA2H+PgoWztnrshlOPzlsq2tZJvWVdiQX0sQQK
 jVY9k3I7nKSBM16sBkfoRzyrfwyZKz67cB8wqd/4DsRdhmpgFuIL7rkH7GPX7/j5e9Dv
 KqdCCtRJj54CQCn8PMrNZSlChecsu4wtdygiH3nQBCGFYYcgEnYgO5UeTODSQfzhrAze
 7Kww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzk3zSuc0xGyO04j7v2bVyq3Sk5McpbcV1s39VjwhulUOpTJNFJomX5vcMYZiG9MSilxGdE6bPkN1g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kTU8Zp94QCl1xVUz1T0YZOEzjv6Jvx/cNOePumzUeQrDagLu8J
 +zPphBX4hSAcDNdTX9tZiQwDeZeprNpv1wVTO3zVJe7xAtgC15LMM/l3YM8bKYY/uDE=
X-Gm-Gg: AYBFou3mJtrd9w4mTWPfm2jZXqBRF/4icPr41y6P6pkEcJ8RgMcQPbp5GwoihP9qYW4
 zGnpYKxUem4Wqlo3k9PqI/M7bEMjrRfmZcOL8f6mF/IICO+yOXXZH7lJOiYHKMqplp9adVkq0W1
 8CTgnNswRsQf6i+fdjHuBC272Trd+9Hg9RUz4gk84wftzu3/18aynrKQ8o1/ArzZoji/RCu+8hf
 302CBbSFrKza+twaASHgj+rXmgCS504NF5xDcg7rjYSU1glOSa5fBdMnI40B23DaXuLxqljDyl+
 jYtzKsFiKx1fZ43SM/2FzOHLMddceNmDfyeKvZjPSOcyo/IEoh47/6oUzs8ueTGHHLH5MsKPsdc
 lPIakkZaWEczEt3eIwogG5Y1f/x7D6ibU4aXYLyjxOkLmrIDVA0GIHPpHvQHErojEFZqnb8FqXV
 ATnLBI06K2kHJ97f/kf8C3ruTowF4DXRGXFOunCvERc4sIBcyWzhkA80axvwzgqFnVQ86GpCBI
X-Received: by 2002:a17:90b:4a4b:b0:39d:e7c7:8044 with SMTP id
 98e67ed59e1d1-39e36106e8dmr14968242a91.17.1789848569823; 
 Sat, 19 Sep 2026 13:09:29 -0700 (PDT)
Received: from G15-5520 ([103.206.144.242]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55d45a6sm7347221c88.9.2026.09.19.13.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 13:09:29 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH v2] drm/amdgpu: replace kcalloc() with kzalloc_objs()
Date: Sat, 19 Sep 2026 20:08:32 +0000
Message-ID: <20260919200834.114637-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919191432.99342-1-lalitshankarch@gmail.com>
References: <20260919191432.99342-1-lalitshankarch@gmail.com>
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

Use kzalloc_objs() instead of kcalloc() to simplify object allocations.
Convert only the instances with sizeof() passed.

No functional change.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c       | 2 +-
 19 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 132d054900b5..3ffb0f5f7574 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -420,7 +420,7 @@ static ssize_t amdgpu_debugfs_gprwave_read(struct file *f, char __user *buf, siz
 		return r;
 	}
 
-	data = kcalloc(1024, sizeof(*data), GFP_KERNEL);
+	data = kzalloc_objs(*data, 1024);
 	if (!data) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 		amdgpu_virt_disable_access_debugfs(adev);
@@ -1267,7 +1267,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	thread = (*pos & GENMASK_ULL(59, 52)) >> 52;
 	bank = (*pos & GENMASK_ULL(61, 60)) >> 60;
 
-	data = kcalloc(1024, sizeof(*data), GFP_KERNEL);
+	data = kzalloc_objs(*data, 1024);
 	if (!data)
 		return -ENOMEM;
 
@@ -2035,7 +2035,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		return -EBUSY;
 
 	length = ring->fence_drv.num_fences_mask + 1;
-	fences = kcalloc(length, sizeof(void *), GFP_KERNEL);
+	fences = kzalloc_objs(*fences, length);
 	if (!fences)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3043ad041bb4..017638dd5491 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -460,8 +460,8 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring)
 
 	ring->fence_drv.num_fences_mask = ring->num_hw_submission * 2 - 1;
 	spin_lock_init(&ring->fence_drv.lock);
-	ring->fence_drv.fences = kcalloc(ring->num_hw_submission * 2, sizeof(void *),
-					 GFP_KERNEL);
+	ring->fence_drv.fences = kzalloc_objs(*ring->fence_drv.fences,
+					      ring->num_hw_submission * 2);
 
 	if (!ring->fence_drv.fences)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 363b99168478..94e39c486128 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -465,8 +465,8 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
 			       const struct amdgpu_hwip_reg_entry *reg, u32 count)
 {
-	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * count,
-				     sizeof(uint32_t), GFP_KERNEL);
+	adev->jpeg.ip_dump = kzalloc_objs(*adev->jpeg.ip_dump,
+					  adev->jpeg.num_jpeg_inst * count);
 	if (!adev->jpeg.ip_dump) {
 		dev_err(adev->dev,
 			"Failed to allocate memory for JPEG IP Dump\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 1a86a47406b1..f257df1c39c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -252,8 +252,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		}
 
 		adev->gfx.mec.mes_hung_db_array =
-			kcalloc(amdgpu_mes_get_hung_queue_db_array_size(adev),
-				sizeof(u32), GFP_KERNEL);
+			kzalloc_objs(*adev->gfx.mec.mes_hung_db_array,
+				     amdgpu_mes_get_hung_queue_db_array_size(adev));
 
 		if (!adev->gfx.mec.mes_hung_db_array) {
 			r = -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 17db7264269e..34e1242d66ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1571,8 +1571,8 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
 int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
 			     const struct amdgpu_hwip_reg_entry *reg, u32 count)
 {
-	adev->vcn.ip_dump = kcalloc(adev->vcn.num_vcn_inst * count,
-				     sizeof(uint32_t), GFP_KERNEL);
+	adev->vcn.ip_dump = kzalloc_objs(*adev->vcn.ip_dump,
+					 adev->vcn.num_vcn_inst * count);
 	if (!adev->vcn.ip_dump)
 		return -ENOMEM;
 	adev->vcn.reg_list = reg;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 00798d80479f..6e8a0cf23d6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4716,7 +4716,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
 	uint32_t *ptr;
 	uint32_t inst;
 
-	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
@@ -4729,7 +4729,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
 	inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
 		adev->gfx.mec.num_queue_per_pipe;
 
-	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count * inst);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
@@ -4742,7 +4742,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
 	inst = adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
 		adev->gfx.me.num_queue_per_pipe;
 
-	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count * inst);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX Queues IP Dump\n");
 		adev->gfx.ip_dump_gfx_queues = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0ff5a80aa918..92ff34e38e74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1568,7 +1568,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 	uint32_t *ptr;
 	uint32_t inst;
 
-	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
@@ -1581,7 +1581,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 	inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
 		adev->gfx.mec.num_queue_per_pipe;
 
-	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count * inst);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
@@ -1594,7 +1594,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 	inst = adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
 		adev->gfx.me.num_queue_per_pipe;
 
-	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count * inst);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX Queues IP Dump\n");
 		adev->gfx.ip_dump_gfx_queues = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index e2a81a55c63b..59b99dd37c58 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1367,7 +1367,7 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
 	uint32_t *ptr;
 	uint32_t inst;
 
-	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
@@ -1380,7 +1380,7 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
 	inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
 		adev->gfx.mec.num_queue_per_pipe;
 
-	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count * inst);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
@@ -1393,7 +1393,7 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
 	inst = adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
 		adev->gfx.me.num_queue_per_pipe;
 
-	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count * inst);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX Queues IP Dump\n");
 		adev->gfx.ip_dump_gfx_queues = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index e49d8a79045c..db6b8d18bfab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1278,7 +1278,7 @@ static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-	ptr = kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count * num_xcc);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
@@ -1291,7 +1291,7 @@ static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
 	inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
 		adev->gfx.mec.num_queue_per_pipe;
 
-	ptr = kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count * inst * num_xcc);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c3322058720f..2accca6552e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2190,7 +2190,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
 	uint32_t *ptr;
 	uint32_t inst;
 
-	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
@@ -2203,7 +2203,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
 	inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
 		adev->gfx.mec.num_queue_per_pipe;
 
-	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count * inst);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 522981fa182d..edf36e5a3b9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -946,7 +946,7 @@ static void gfx_v9_4_3_alloc_ip_dump(struct amdgpu_device *adev)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-	ptr = kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count * num_xcc);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
@@ -959,7 +959,7 @@ static void gfx_v9_4_3_alloc_ip_dump(struct amdgpu_device *adev)
 	inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
 		adev->gfx.mec.num_queue_per_pipe;
 
-	ptr = kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, reg_count * inst * num_xcc);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 20c8ebf0e159..0160e0b05bf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1926,7 +1926,7 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	/* Allocate memory for SDMA IP Dump buffer */
-	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 6fe3d3d56c40..144280dc7583 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1531,7 +1531,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	/* Allocate memory for SDMA IP Dump buffer */
-	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1ca0e7f65442..0a2acd7a5f2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1434,7 +1434,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	/* Allocate memory for SDMA IP Dump buffer */
-	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 81f1e9882177..43aab715a061 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1352,7 +1352,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	/* Allocate memory for SDMA IP Dump buffer */
-	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index cf3d2997fff8..92f5243e4a7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1363,7 +1363,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	/* Allocate memory for SDMA IP Dump buffer */
-	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 69cb89298a3e..2bf783422ec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1345,7 +1345,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 	/* Allocate memory for SDMA IP Dump buffer */
-	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 18366e16ef3f..2d97fc9e0d66 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1333,7 +1333,7 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 	/* Allocate memory for SDMA IP Dump buffer */
-	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index e9d790914761..393de1399328 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -202,7 +202,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	r = jpeg_v1_0_sw_init(ip_block);
 
 	/* Allocate memory for VCN IP Dump buffer */
-	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
+	ptr = kzalloc_objs(*ptr, adev->vcn.num_vcn_inst * reg_count);
 	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
 		adev->vcn.ip_dump = NULL;
-- 
2.53.0

