Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68610FB44C8
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E498810F3B2;
	Fri, 24 Apr 2026 07:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j65xhbmC";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704738825E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 00:49:42 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12c565dd3a7so10623080c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776991782; x=1777596582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2TqsQ3VTtmFOdJXnJ7xYfxOi+4kprx1dikYuBadGme8=;
 b=j65xhbmCIzKvyfPvNrRqDdzLAaar7M1tkDgOSkE8rdhM9RZO4O+4i/7z/GhL+Ww+Tm
 MpqHDpyKsslhms4G26K+wgfLjO+EJwrBQaMRcjTHCa49KiVRPmQ/oJl5O9Y+0mK3KoC4
 6c5LlpZ6whqutqvQzkMyuXnuEtY0E0uDT5YML4yA9rOiS+ry3dVe5x6H/Jy6zRlQO+vO
 W9TYhAzhDIn0aI9tT16uSUNUCm1ZX2QTTkQTbfdOTrE01A/J13CzDrsn4qj6JozuyLyl
 Nws7tsyZGpWX4xTMAjppMkKG98UIX3AfadhnULbhBr34Wlii8YZc66ziakUgsKAIHr34
 DGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776991782; x=1777596582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TqsQ3VTtmFOdJXnJ7xYfxOi+4kprx1dikYuBadGme8=;
 b=aFQO619yEHW7E2l13OiBf6mYhDZ+sQDon7KopjsmVl9iEL8sQX8JFEpZ/RSoi+PAmN
 YUyOrIFIC/J8ZnI1ZDOhWhlS6uy7wZ0VYvE7g9iXaDcXrXIqNtGwXdAcK99sEzDz4prU
 XqjEADp7doKJ7l/FXlpV2c+rb2IIAJ8zy/U4npJt18HhcpP7yoWDqCQh0Wfmsfmdwglv
 1WrKeulnr42tCF7G73o8UTGLDN1Vh+SZ4uLwq7jxBjT/zWAg77v99uAsc661JXWcMz7w
 DJibzAYP0HE+nym5EV6zSywIbmfvrGqSwkXaZgQKnez+UuQntNvodVxHhmi9OGdJ6TXy
 Y+jQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dHcDIGXLZcNcz0aA2whb0gd1A9DgWOXij+jTw4jqyJTe+RwNpJn4dWBJrX8x/Ud0JY5Wi5I5MSBA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoLe07OrZW1cXz8D47qJlsrmBbFxMBW4icqjOOcTnNsk35oH9z
 yXq8oTVsbRnd66AbI6hGHtH1iXtt1IHd9y51u1OsJKz4AKATpVxXcaM2
X-Gm-Gg: AeBDievN1yKs0S9SVU1TdSwKhtwIUt99KXkN++AjDC/IDnccPMjQmj0y37X2XH3pVEE
 wvsIkG+Q3afQp9Rz3EwFS6IM+0/Gh4AphEr8vZI1lhV1gVddNnW6E7K+afPTQoLe5pBHvqMIT8i
 kK89wmpb9xrj6yQCnQLZkxFrEmJyP19Vv6dAt5++Cd6rQzuwUN6CTVHdmlt1tEBUWBlGlh//UUp
 CvXwKydSf57Wt6J7zUlsREz2I4YssjHpXP4j4WTl3WKUMn0TYTZM3hirYq+lfrS1aZ5FBxEr5DX
 loGLfDZaxJchcMBmbbU2BTZlpQgvNh/tpflWck/OMCMvz67XGtMo5hrZ06QE1OpzG/v9aiOMXm6
 f/VuG6KCf2H4mS2XeSv6UIKMi0ToGZBUBrBtREshIocbmAR5paMrJx1HKhTC5/mOjKQSdb1+ghY
 hgaO9zv1+Mtw5EDcRKtdlw+nOcw5RZs1YFpqZIuw==
X-Received: by 2002:a05:7022:68d:b0:123:34e8:aec2 with SMTP id
 a92af1059eb24-12c73f68419mr15738793c88.1.1776991781564; 
 Thu, 23 Apr 2026 17:49:41 -0700 (PDT)
Received: from osabio.. ([2804:14c:498:1391:e297:f15e:34f:a801])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a185a8sm30930634c88.9.2026.04.23.17.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 17:49:40 -0700 (PDT)
From: Gabriel Almeida <gabrielsousa230@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, gabrielsousa230@gmail.com
Subject: [PATCH v3 1/2] drm/amdgpu: move program_aspm to amdgpu_nbio
Date: Thu, 23 Apr 2026 21:49:09 -0300
Message-ID: <20260424004910.21003-1-gabrielsousa230@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

The program_aspm helper is duplicated across multiple files with
identical logic.

Move it to amdgpu_nbio.c as amdgpu_nbio_program_aspm and update
all users accordingly.

Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
---
v3:
- split from previous combined patch

v2:
- move program_aspm to amdgpu_nbio.c
- drop amdgpu_common

 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/nv.c          | 12 +-----------
 drivers/gpu/drm/amd/amdgpu/soc15.c       | 11 +----------
 drivers/gpu/drm/amd/amdgpu/soc21.c       | 11 +----------
 5 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index a97426583..e4c8e9872 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -84,3 +84,13 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
 	amdgpu_ras_block_late_fini(adev, ras_block);
 	return r;
 }
+
+
+void amdgpu_nbio_program_aspm(struct amdgpu_device *adev)
+{
+	if (!amdgpu_device_should_use_aspm(adev))
+		return;
+
+	if (adev->nbio.funcs->program_aspm)
+		adev->nbio.funcs->program_aspm(adev);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index b528de6a0..a61f3a6e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -121,4 +121,6 @@ u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev);
 
 bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev);
 
+void amdgpu_nbio_program_aspm(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7ce1a1b95..030d80664 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -511,16 +511,6 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 	return 0;
 }
 
-static void nv_program_aspm(struct amdgpu_device *adev)
-{
-	if (!amdgpu_device_should_use_aspm(adev))
-		return;
-
-	if (adev->nbio.funcs->program_aspm)
-		adev->nbio.funcs->program_aspm(adev);
-
-}
-
 const struct amdgpu_ip_block_version nv_common_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
 	.major = 1,
@@ -984,7 +974,7 @@ static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
 		adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev);
 
 	/* enable aspm */
-	nv_program_aspm(adev);
+	amdgpu_nbio_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index b456e4541..27bcbbae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -695,15 +695,6 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
 	return 0;
 }
 
-static void soc15_program_aspm(struct amdgpu_device *adev)
-{
-	if (!amdgpu_device_should_use_aspm(adev))
-		return;
-
-	if (adev->nbio.funcs->program_aspm)
-		adev->nbio.funcs->program_aspm(adev);
-}
-
 const struct amdgpu_ip_block_version vega10_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
@@ -1284,7 +1275,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	/* enable aspm */
-	soc15_program_aspm(adev);
+	amdgpu_nbio_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index fbd1d97f3..7e4353d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -470,15 +470,6 @@ static int soc21_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
 	return 0;
 }
 
-static void soc21_program_aspm(struct amdgpu_device *adev)
-{
-	if (!amdgpu_device_should_use_aspm(adev))
-		return;
-
-	if (adev->nbio.funcs->program_aspm)
-		adev->nbio.funcs->program_aspm(adev);
-}
-
 const struct amdgpu_ip_block_version soc21_common_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
 	.major = 1,
@@ -925,7 +916,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	/* enable aspm */
-	soc21_program_aspm(adev);
+	amdgpu_nbio_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
-- 
2.43.0

