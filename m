Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56CBF99355
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7083510EFE8;
	Thu, 23 Apr 2026 08:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p6dl/TRD";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1015710EABC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 00:06:50 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so9779311eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776902809; x=1777507609; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4O6lko4zi306GH3gds5YYnP+riJNi0HMENwF4Fn7N7A=;
 b=p6dl/TRDCQ8yFEZFAUm45UWOF+W6yeew/VdOA62hhv96lObCfhEf9F2DMqfdkXJQC0
 amWjxDS4fTsIhIs+1RP3GRWgUkWxRvDW8ubaobI0R8FIqp4lMwfgVy9RkNRgIDNdoCbb
 SMkcrji0WBrmMcm8KUVKMOqGYd5nfCsGluGbkRmdIbl6TbO+vTl5JNCBRKMnCmZLb9Ye
 tAHLN6Y1Sb6SdtwvYU7W+rVYr8gF2BPpMEUKsHlqqLVo6qYcZe8AzW9cTWO52nIBKyxy
 hXriuiNsswepIZb4LUM2Wncmm3HiMEHInl1Q9g2dPfdPNKgMohC+uUrUpVUbF9DLvmQl
 9IoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776902809; x=1777507609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4O6lko4zi306GH3gds5YYnP+riJNi0HMENwF4Fn7N7A=;
 b=rX/sjpYyMbIDNYcye6bUQjCmjg4JsspMT1JBkaFXW2zrjBJu+nSJ9TmnwANWYNQr4L
 ZJ9W+BSj7EDSotIu0kLlEjbbXs406WFNzNwHH2h14ejafTf8yUPahncciUqCccBp3PgS
 mjEgWlE36lrMfPUIyKLG2jgeGWKFwPsHKITqPkHGPryalpl0oqmxD3ZSCUq9gcUlPKmi
 VVJSp/Aard5FHGnq3uLtIO07BjKm8gslSauwM32BUceyvPfdfW357e6mplwLbDoq4wTe
 1dQkL0kxgh6pFAcnxTrfZC0ENCmLXekbAnsL/8OFB46Px41tMR0KOj3aHTyi/cQfn06v
 uzFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BYIKR1yWkb50rRho5eVwMPLgw3YpD68Ys+f2QMY4gKQhCWXAMgNAh/0WiMHFrA52sf5S4qB2Cr0c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIj4Ngsd8E4g0IMPoOirbdacm1iy2ig3buK4lpXpQPViPjT/2R
 DSN+b32500RZ0ti8gYOlJTAv9jwEDm/68w2ekmtqCRokqTXHXXQvckDN
X-Gm-Gg: AeBDieuzktoWp8yPpztYtXSgcBAOoBLEjm7LBAyD1D2tSA6IT1xvQSbq4xFyOWwwNfl
 ZdLxDs7fr0ADjrjGov6xnBzqLHxKJNfwO7nMxhbhBef1+Bth6apKKp1mB7BqlK3bEg9A51dbkhS
 iHFpKlVxW08A2pAYA1MEM5/4qGjL6MOr8AJuTsTIdQklhlMrUpuSn6d/HXGXvnfQu5W5pOsLxoo
 jNzXGtOarjuDMk3eteI1DlgfEXPgBIioWpWcuPRS/nWWy2XnGe7rGqMpGjyBBeIExyAwbQmZ9EH
 A9167Lm/TZ+klzCe6AJyTTlKUtFPKA3jLVWp4+nwW8S3s3NYgrOeIu+d/Vi2tNt5qBvvw5tVLW/
 aWFbdk5nAGUf9E7bOygXpxmwGlr9W8bgEz/UhY1LxEdB5ldvYs6bVsgfRdrgmNyrFm4BlHtQPmm
 YTy+U7oa0/Ehk3qHQWkXf47JZyRmZh4EIe1i2EkH2PYb+OcM0=
X-Received: by 2002:a05:7301:168a:b0:2d6:78af:ef5f with SMTP id
 5a478bee46e88-2e464ea6ee1mr11927085eec.3.1776902809071; 
 Wed, 22 Apr 2026 17:06:49 -0700 (PDT)
Received: from osabio.. ([2804:14c:498:1391:82a3:269:c35e:9c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d2cfef3sm24342342eec.24.2026.04.22.17.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 17:06:48 -0700 (PDT)
From: Gabriel Almeida <gabrielsousa230@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, gabrielsousa230@gmail.com
Subject: [PATCH v2] drm/amdgpu: deduplicate register access and helper routines
Date: Wed, 22 Apr 2026 21:06:29 -0300
Message-ID: <20260423000629.47095-1-gabrielsousa230@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Apr 2026 08:51:37 +0000
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

Several helper functions are duplicated across multiple files with
identical logic.

Move these helpers to more appropriate locations based on their
functionality:
- move read_indexed_register to amdgpu_reg_access.c as
  amdgpu_read_indexed_register
- move program_aspm to amdgpu_nbio.c as
  amdgpu_nbio_program_aspm

No functional changes intended.

Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
---
v2:
- Move read_indexed_register to amdgpu_reg_access.c instead of a new file
- Move program_aspm to amdgpu_nbio.c
- Drop amdgpu_common.[ch]
- Drop changes to common_sw_init

 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      | 10 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |  2 ++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 18 +++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  3 ++
 drivers/gpu/drm/amd/amdgpu/nv.c               | 30 ++-----------------
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 30 ++-----------------
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 30 ++-----------------
 drivers/gpu/drm/amd/amdgpu/soc24.c            | 21 +------------
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         | 20 +------------
 9 files changed, 41 insertions(+), 123 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 540040c76..daefbeeee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -956,3 +956,21 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev, uint32_t inst,
 	}
 	return ret;
 }
+
+
+uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
+			       u32 se_num, u32 sh_num, u32 reg_offset)
+{
+	uint32_t val;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	if (se_num != 0xffffffff || sh_num != 0xffffffff)
+		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
+
+	val = RREG32(reg_offset);
+
+	if (se_num != 0xffffffff || sh_num != 0xffffffff)
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
+	mutex_unlock(&adev->grbm_idx_mutex);
+	return val;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index 4d88e5cd1..a1011af6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -160,4 +160,7 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev, uint32_t inst,
 				    uint32_t reg_addr, char reg_name[],
 				    uint32_t expected_value, uint32_t mask);
 
+uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
+					u32 se_num, u32 sh_num, u32 reg_offset);
+
 #endif /* __AMDGPU_REG_ACCESS_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7ce1a1b95..1ab9d450e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -354,29 +354,13 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
 };
 
-static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
-					 u32 sh_num, u32 reg_offset)
-{
-	uint32_t val;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
-
-	val = RREG32(reg_offset);
-
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	mutex_unlock(&adev->grbm_idx_mutex);
-	return val;
-}
 
 static uint32_t nv_get_register_value(struct amdgpu_device *adev,
 				      bool indexed, u32 se_num,
 				      u32 sh_num, u32 reg_offset)
 {
 	if (indexed) {
-		return nv_read_indexed_register(adev, se_num, sh_num, reg_offset);
+		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
 			return adev->gfx.config.gb_addr_config;
@@ -511,16 +495,6 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
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
@@ -984,7 +958,7 @@ static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
 		adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev);
 
 	/* enable aspm */
-	nv_program_aspm(adev);
+	amdgpu_nbio_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index b456e4541..87b398dd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -401,29 +401,12 @@ static struct soc15_allowed_register_entry soc15_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
 };
 
-static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
-					 u32 sh_num, u32 reg_offset)
-{
-	uint32_t val;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
-
-	val = RREG32(reg_offset);
-
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	mutex_unlock(&adev->grbm_idx_mutex);
-	return val;
-}
-
 static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
 					 bool indexed, u32 se_num,
 					 u32 sh_num, u32 reg_offset)
 {
 	if (indexed) {
-		return soc15_read_indexed_register(adev, se_num, sh_num, reg_offset);
+		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
 			return adev->gfx.config.gb_addr_config;
@@ -695,15 +678,6 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
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
@@ -1284,7 +1258,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	/* enable aspm */
-	soc15_program_aspm(adev);
+	amdgpu_nbio_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index fbd1d97f3..93c002e51 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -306,29 +306,12 @@ static struct soc15_allowed_register_entry soc21_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
 };
 
-static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
-					 u32 sh_num, u32 reg_offset)
-{
-	uint32_t val;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
-
-	val = RREG32(reg_offset);
-
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	mutex_unlock(&adev->grbm_idx_mutex);
-	return val;
-}
-
 static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
 				      bool indexed, u32 se_num,
 				      u32 sh_num, u32 reg_offset)
 {
 	if (indexed) {
-		return soc21_read_indexed_register(adev, se_num, sh_num, reg_offset);
+		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) && adev->gfx.config.gb_addr_config)
 			return adev->gfx.config.gb_addr_config;
@@ -470,15 +453,6 @@ static int soc21_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
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
@@ -925,7 +899,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	/* enable aspm */
-	soc21_program_aspm(adev);
+	amdgpu_nbio_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index d1adf19a5..265db9331 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -132,31 +132,12 @@ static struct soc15_allowed_register_entry soc24_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
 };
 
-static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev,
-					    u32 se_num,
-					    u32 sh_num,
-					    u32 reg_offset)
-{
-	uint32_t val;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
-
-	val = RREG32(reg_offset);
-
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	mutex_unlock(&adev->grbm_idx_mutex);
-	return val;
-}
-
 static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
 					 bool indexed, u32 se_num,
 					 u32 sh_num, u32 reg_offset)
 {
 	if (indexed) {
-		return soc24_read_indexed_register(adev, se_num, sh_num, reg_offset);
+		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) &&
 		    adev->gfx.config.gb_addr_config)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 709b1669b..4a5fe8e9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -184,31 +184,13 @@ static struct soc15_allowed_register_entry soc_v1_0_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
 };
 
-static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *adev,
-					       u32 se_num,
-					       u32 sh_num,
-					       u32 reg_offset)
-{
-	uint32_t val;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
-
-	val = RREG32(reg_offset);
-
-	if (se_num != 0xffffffff || sh_num != 0xffffffff)
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
-	mutex_unlock(&adev->grbm_idx_mutex);
-	return val;
-}
 
 static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev,
 					    bool indexed, u32 se_num,
 					    u32 sh_num, u32 reg_offset)
 {
 	if (indexed) {
-		return soc_v1_0_read_indexed_register(adev, se_num, sh_num, reg_offset);
+		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG_1) &&
 		    adev->gfx.config.gb_addr_config)
-- 
2.43.0

