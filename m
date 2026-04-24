Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB19CFB44C8
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06CA10F3BA;
	Fri, 24 Apr 2026 07:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eFwFd9te";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8D88825E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 00:49:58 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12dbd0f8063so2737714c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776991797; x=1777596597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6kEj1wIg3L0vvI4zp06FIgoSHqbRAMXfy1o/X7ZFcc=;
 b=eFwFd9teSks97nrru8NaAMf5TXjXmBZbnliKR7fwlkvN4IX0GRRH9B5QyE5ekX7GHx
 tpn8tEIUpmSY5zFvJRmzy0q3xPgiRF9n6n0ir/SecyWXO06NuQYxzZm3uWQNXlJLTUK6
 jqqHTy+ljEXQwqjqLQuJV5BYFz62ZQXZgwlYYuueXAr8c6l5KXFCYxd8OusuFycLvEnL
 pPJfSbnlpt325V0elZW4Eu4zBQc/O8zURViJ+6u+CsofvNjXof2u8Z02euoCEIR1JmRV
 KDlvz3m68bB2LZioJTdfBGttzSRCO+54vuyRkfuPSpYqGWmMTXsSEivqPSKtK0GHn33T
 ht6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776991797; x=1777596597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/6kEj1wIg3L0vvI4zp06FIgoSHqbRAMXfy1o/X7ZFcc=;
 b=QSrWnu33QyIB8gKiJ/CaPF6CXHDf+gOo5CqBDvMm672bYPJqwG4+/dkMdKpwJtMLrS
 Jogu3ilRz0AMjjzzBg4Baxk/yqOcnvKna+UGOn0PiF9+OBdUu7i5k3jODM3Bhqk6aJU+
 IS1E2x24iSVpC33kqpzN+9DXishGbX3el9LhyYFfi9a6fxKw5aW3ZIk1KALKGhv3hEwp
 AUEgBlytMkM4yHEamppsWgrWQmWbLLQTJNdreYu/ITQ+LmQ4DOxSsOfWyJb9U1NsPE9e
 wypRjADRcjPnHf5En/1Upjpl5BfOaO2QqGbC0cXW+d8LmJyW67E4Kiocf4UBxI8PwZMc
 Uddg==
X-Forwarded-Encrypted: i=1;
 AFNElJ94wFeMBsa5ia9kW3F+W3fkI8SayNC/xJHsO73mzrtgEOzRONcoVlFdRFYLRJtAj4cAAJSYtd7s+fs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8ixJ6ogz/88rx9qQW9o/fTIe+v1eH36Qr8+Fe0CKw0KwNH/Qe
 258lgZu0xToaKy5wfK9jdREFmqJqe2t4WG62yUD3tcbpBu1z217321tf
X-Gm-Gg: AeBDiet7FGkizhMuPi5fsRQ9O0Kf4PfNtP0LmyIdOS4/pUvsOe7VDpdSD7M5wUOdbaw
 s3j3zJ9ssvfZhY9eI9Yad634JXkxzQsfBL2on94qXKtuE4BBN2z1y40LfvHTjYBM3JG2GyyorKu
 qatmUi92sSi0MChEIbDU8xIPEXsbF85O8BopsfOlKzDJcT4VEECWrjBhPPLW5h+tOxn8XbxBt7/
 vfwqXxWM+2OkTlqgx8nwxTDRPWdtZDGACp5Ljnyz1OHI7oMdAE3dYCe9G3n54nnte5SmxHlqXro
 weAujAC+8aPh3BJU+aMN59LrJKqfL82y4+5DtRMgcmXk7EFr4NZ4R2Xmwn33hnWO26LY0daPdA2
 gxPiSUvdqWHrl5Q0JJ2QY7JBfS7VCdVa/LFOvsSMtXcog54SGCLCLIOJyU2YTlVpCx62AOhsYlN
 SN1wEE9eU3t8vAynr/jLaxIn6fEfp3NzHP9c/L2Q==
X-Received: by 2002:a05:7022:11c:b0:12b:ec67:3523 with SMTP id
 a92af1059eb24-12c73f726eamr15041738c88.9.1776991797381; 
 Thu, 23 Apr 2026 17:49:57 -0700 (PDT)
Received: from osabio.. ([2804:14c:498:1391:e297:f15e:34f:a801])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a185a8sm30930634c88.9.2026.04.23.17.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 17:49:56 -0700 (PDT)
From: Gabriel Almeida <gabrielsousa230@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, gabrielsousa230@gmail.com
Subject: [PATCH v3 2/2] drm/amdgpu: move read_indexed_register to
 amdgpu_reg_access
Date: Thu, 23 Apr 2026 21:49:10 -0300
Message-ID: <20260424004910.21003-2-gabrielsousa230@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424004910.21003-1-gabrielsousa230@gmail.com>
References: <20260424004910.21003-1-gabrielsousa230@gmail.com>
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

The read_indexed_register helper is duplicated across multiple files
with identical logic.

Move it to amdgpu_reg_access.c as
amdgpu_read_indexed_register and update all users accordingly.

No functional changes intended.

Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
---
v3:
- split into two patches as requested

v2:
- move read_indexed_register to amdgpu_reg_access.c
- drop amdgpu_common

 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 18 ++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  3 +++
 drivers/gpu/drm/amd/amdgpu/nv.c               | 19 +----------------
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 19 +----------------
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 19 +----------------
 drivers/gpu/drm/amd/amdgpu/soc24.c            | 21 +------------------
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         | 20 +-----------------
 7 files changed, 26 insertions(+), 93 deletions(-)

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
index 030d80664..72edf5326 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -354,29 +354,12 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
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
-
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
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 27bcbbae5..87b398dd0 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 7e4353d0c..93c002e51 100644
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

