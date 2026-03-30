Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E3BFF60CF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D69710E8A0;
	Tue, 31 Mar 2026 07:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IY/yWiEi";
	dkim-atps=neutral
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A41D10E05A
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 22:45:27 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-60319f32a59so1290882137.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 15:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774910726; x=1775515526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YyMKSyJ5pE5wHB1zuiBld9F84C6sMv1AiRN68buAW4A=;
 b=IY/yWiEimhsacrI6zw8hZQYzKaMKwDbHhJHFbAV3vPqs38LSov47WdmSYcCOdyPaCJ
 hX85plv8e0p320shZOJaCDJ8cIkwIDyBbFqF5nCjqMebd7OiE81n5r/NjCrrwX2UAEcz
 TQM7sxfC6k0k66KiiAJqgZqr3J8gGYC2/dyd1rZ2AcxARTtthwXS9Z2XiZ6cGL/EKOki
 lEPueikT9adNB2/pK1i6qgJN5E10NX3tumna0qbNIgP02BarOs5wCANPTx8DLFUU2uHP
 tV7e7jasqA7c/3emUTaPcd4i5bE3/efoph+TNo5Xd0fUP1k8bywnzGAsTkKwp4RnNAR1
 NWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774910726; x=1775515526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyMKSyJ5pE5wHB1zuiBld9F84C6sMv1AiRN68buAW4A=;
 b=Ym809sxOBpDGmVZ/Qkn16xsQPaSQKN3EenL7rbWw202liV2zlxSEucV//+OXHV3NTC
 Bxk9jAApB2WYxLRg1OT3i4PyDKBq5YKhWMZHCMsSwN0OtQlnlDKJzKJgZMNNysbvCEnE
 yImK6Kn5utKDjLhviV5DZIdigdYNAw/rtxVl335thZVzzW0jZrCnYi0on+w/f9sqx/0j
 g6CDBVBhetA65q4XJQ9uYhZHUoCsQITCJKIFpxj7o6uzSAKZCFTjecL4l2ayf0rERrKJ
 G0/jSJwNJOIbl6bwpIN84qaKolFJYDUQpext0X+NES/SZdPzg31B38r2sZZkXgVKWx4d
 a5Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqHO3l7n6cyOb/MItvofatP1C7AUFCcjVmK7/MdECfR9iJQ/tC/FaxN4n8lrYvywYGORTZXVJAGeo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjIBhJmrVy31SOw+6+KIBICRg2PtM0bvWKAgjQJUz4O6lpwjTb
 3DKbHg9zdUtvV/Bbzv3nOZX5OP1nimseJQzziVSROyVbFHLWMC1ea9fQ
X-Gm-Gg: ATEYQzyJKmmg4mKDImIlbE4cDilpjKn0DSuu4TGUw/YzaCwpV+w35zV8+4FiYuaIsX4
 7th31wlsMHsbwHVh/0PdeWT+QUkx49AUvLpVAvJw1OQZD+/+r3ZihJBMRNhERDAP95Gz+3otRgh
 XNJT1ei+ZXkC15CfL+dnFqFZMnu7phS6s8pHOT/hbmqLWw/Gde82XeRclxnCKToDhBooMteyrD3
 uFmsWfTb0tvGH0XpuFmhh+l+sdJlGrTme0VZXj89cslUNby/CutZ9ZGroPLnEqlrPPOL6KX1+Wp
 qUDDZE0+eUQo1ikqr4kuyMI/TJfPA2Jw8tySzOinAQ4NY6z6xNrXxovYVag8FI6WwgNrqDoRjtZ
 lOpsXjk4HnvXGBsgYlaJMzdVwsz++ocsug78JL+lLYCRh2dgUafuEF6nNgzgE9gSPtx8sH0PJZh
 Pd85++3Vrk0MQG+feZXrfVNSXOlA==
X-Received: by 2002:a05:6102:3710:b0:605:3556:6619 with SMTP id
 ada2fe7eead31-60535566a13mr1976654137.31.1774910726457; 
 Mon, 30 Mar 2026 15:45:26 -0700 (PDT)
Received: from osabio.. ([2804:18:133:b9ee:165a:1d6e:ccaa:37f5])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9539e2e7926sm9255600241.7.2026.03.30.15.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 15:45:26 -0700 (PDT)
From: Gabriel Almeida <gabrielsousa230@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, gabrielsousa230@gmail.com
Subject: [PATCH] drm/amdgpu: deduplicate register access and helper routines
Date: Mon, 30 Mar 2026 19:45:03 -0300
Message-ID: <20260330224503.548284-1-gabrielsousa230@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 31 Mar 2026 07:23:33 +0000
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

Some helper functions are implemented multiple times with identical
logic across different source files.

Extract these implementations into a shared helper file
(amdgpu_common.c) and update existing code to reuse them.

This simplifies the codebase and avoids duplication without
changing behavior.

No functional changes intended.

Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_common.c | 42 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_common.h | 12 +++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            | 38 +++-----------------
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 31 ++--------------
 drivers/gpu/drm/amd/amdgpu/soc21.c         | 38 +++-----------------
 drivers/gpu/drm/amd/amdgpu/soc24.c         | 29 ++-------------
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      | 21 ++---------
 8 files changed, 72 insertions(+), 141 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6a7e9bfec..84cce03d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -69,6 +69,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
 
+amdgpu-y += amdgpu_common.o
+
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
new file mode 100644
index 000000000..34ade6f63
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+
+#include "amdgpu.h"
+#include "amdgpu_common.h"
+#include "mxgpu_nv.h"
+
+uint32_t read_indexed_register(struct amdgpu_device *adev,
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
+
+void program_aspm(struct amdgpu_device *adev)
+{
+	if (!amdgpu_device_should_use_aspm(adev))
+		return;
+
+	if (adev->nbio.funcs->program_aspm)
+		adev->nbio.funcs->program_aspm(adev);
+}
+
+int common_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (amdgpu_sriov_vf(adev))
+		xgpu_nv_mailbox_add_irq_id(adev);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
new file mode 100644
index 000000000..314b3506b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __AMDGPU_COMMON_H__
+#define __AMDGPU_COMMON_H__
+
+uint32_t read_indexed_register(struct amdgpu_device *adev,
+			       u32 se_num, u32 sh_num, u32 reg_offset);
+
+void program_aspm(struct amdgpu_device *adev);
+
+int common_sw_init(struct amdgpu_ip_block *ip_block);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7ce1a1b95..cf8052c73 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -29,6 +29,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
+#include "amdgpu_common.h"
 #include "amdgpu_ih.h"
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
@@ -354,29 +355,13 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
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
+		return read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
 			return adev->gfx.config.gb_addr_config;
@@ -511,16 +496,6 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
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
@@ -965,12 +940,7 @@ static int nv_common_late_init(struct amdgpu_ip_block *ip_block)
 
 static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (amdgpu_sriov_vf(adev))
-		xgpu_nv_mailbox_add_irq_id(adev);
-
-	return 0;
+	return common_sw_init(ip_block);
 }
 
 static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
@@ -984,7 +954,7 @@ static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
 		adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev);
 
 	/* enable aspm */
-	nv_program_aspm(adev);
+	program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index b456e4541..a6b91363d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -28,6 +28,7 @@
 #include <drm/amdgpu_drm.h>
 
 #include "amdgpu.h"
+#include "amdgpu_common.h"
 #include "amdgpu_ih.h"
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
@@ -401,29 +402,12 @@ static struct soc15_allowed_register_entry soc15_allowed_read_registers[] = {
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
+		return read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
 			return adev->gfx.config.gb_addr_config;
@@ -695,15 +679,6 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
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
@@ -1284,7 +1259,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	/* enable aspm */
-	soc15_program_aspm(adev);
+	program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index fbd1d97f3..586d62202 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -27,6 +27,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
+#include "amdgpu_common.h"
 #include "amdgpu_ih.h"
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
@@ -306,29 +307,12 @@ static struct soc15_allowed_register_entry soc21_allowed_read_registers[] = {
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
+		return read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) && adev->gfx.config.gb_addr_config)
 			return adev->gfx.config.gb_addr_config;
@@ -470,15 +454,6 @@ static int soc21_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
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
@@ -912,12 +887,7 @@ static int soc21_common_late_init(struct amdgpu_ip_block *ip_block)
 
 static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (amdgpu_sriov_vf(adev))
-		xgpu_nv_mailbox_add_irq_id(adev);
-
-	return 0;
+	return common_sw_init(ip_block);
 }
 
 static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
@@ -925,7 +895,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	/* enable aspm */
-	soc21_program_aspm(adev);
+	program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index d1adf19a5..f9341c0e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 
 #include "amdgpu.h"
+#include "amdgpu_common.h"
 #include "amdgpu_ih.h"
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
@@ -132,31 +133,12 @@ static struct soc15_allowed_register_entry soc24_allowed_read_registers[] = {
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
+		return read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) &&
 		    adev->gfx.config.gb_addr_config)
@@ -455,12 +437,7 @@ static int soc24_common_late_init(struct amdgpu_ip_block *ip_block)
 
 static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (amdgpu_sriov_vf(adev))
-		xgpu_nv_mailbox_add_irq_id(adev);
-
-	return 0;
+	return common_sw_init(ip_block);
 }
 
 static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 709b1669b..2f77fb0b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_common.h"
 #include "soc15.h"
 #include "soc15_common.h"
 #include "soc_v1_0.h"
@@ -184,31 +185,13 @@ static struct soc15_allowed_register_entry soc_v1_0_allowed_read_registers[] = {
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
+		return read_indexed_register(adev, se_num, sh_num, reg_offset);
 	} else {
 		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG_1) &&
 		    adev->gfx.config.gb_addr_config)
-- 
2.43.0

