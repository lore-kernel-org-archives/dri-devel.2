Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ED5FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763CF10EE30;
	Wed, 29 Apr 2026 04:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SpMOm+zh";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012068.outbound.protection.outlook.com
 [40.107.200.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4470710ED27;
 Wed, 29 Apr 2026 04:10:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzG/KT6i0cqMkDl41Y1W0XxFtlgoRbeoOKhBoMDeFkk2yL/UJB20tFontgQm8UehRbSYdKUvHWaT+LfK43XhhC2aCcevJaw6vHRVq8xRW3X6PKQ3yxNBg9ibIp6JoejBzoleDe+MOl0VbTAyS231v7ug+E7p3zU4A9HOyhw5G6ISFfN0wkJkO3xTF9K9xd+Qyf2qsXqTOUOR8N9aaVz0P9K7mPYArnUGoqbl8/X8y/IsBBcMYsH7rtiLVd/Wsfc9hnKNvh1kvuLDDa6OPKlsudJ46ft1RKruHUAs1/p1uKYtwQ8uAN8zSBhqvGuCyW8sewu7RwIUU3+IjGEP3zerSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+wf31lPGjKbFC20PJcf/erQAd5dq2YTekmgsy70lzg=;
 b=ZoIjxmPWT66FLMxl9gSJNq5cANrBnEV5SGTeFQu7Geedv83ntXaolnhGV4VjQf71YbNx1+OXom8YqLiUAS6weBvkrLx3KkdKmI69bXp0tL7BT5jDnJhWxOQCDcK8wwWJrGysR2cSlLT3EeSPHNGSsTASlx/kGRCAqV6AbZgCt7cM/NIupOrOdrX4MaKKcwFX9cb67bAkJLBUu2oDLcmBBCSY8sXjuL+8GrmLzazWhCCQ1FFyTlw6bCUeSKokHS2JYS1hstUoXBLFi9EbMSh1wxmdiEkKG6tOpSq8F9bMUsZNTf8sKYUCFeZDfg9rsGGLqrTLAIriQ8fjMG1b16eyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+wf31lPGjKbFC20PJcf/erQAd5dq2YTekmgsy70lzg=;
 b=SpMOm+zh08YmHaERvmmIFQHbYGgCkq6RPTCFh26+kLoYUQcH1BLK/1G1u0gFbIhcEASB9vpgXQ9YwjV4XpI2/cR3lWhOxBp7vuUb7NCs9kIzr42901W9uQHg5tU9JtfVAlEkbqfsg2gaWLjWqgk3IwNe0wQfDpS3b3EdpLKA1e4=
Received: from SA9P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::22)
 by SA5PPFE91247D15.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Wed, 29 Apr
 2026 04:10:43 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::6c) by SA9P223CA0017.outlook.office365.com
 (2603:10b6:806:26::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 04:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 04:10:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 23:10:36 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 21:07:39 -0700
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <sima@ffwll.ch>,
 <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V4 12/12] drm/amdgpu: integrate SVM into build system and VM
 fault path
Date: Wed, 29 Apr 2026 12:06:28 +0800
Message-ID: <20260429040628.853079-13-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429040628.853079-1-honglei1.huang@amd.com>
References: <20260429040628.853079-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SA5PPFE91247D15:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc21c21-4acf-40a4-2fe2-08dea5a54850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: OZHx9E/rtjmZMBxRyPukImu4F7uMSx5tTUDVVyExpIHBmtxwpnVA/TPi0iLbxyavXzEjp35qzfqO23AgUQ7qEDGlgY4DkwE3gbFRe7yTpNZ5vRmAIslxMDXncv60UcIBM8rJhoYADI1n4KCLZhDxV3WVMA4CEmVpqPD4S23lOWFFB0f3kSjVxs824caxSICX8lagIn470DldyTYRMjgK5E/Z+pkgGEv+R4bJFnftQfjMVRTQtD4Es5cgjgwtlTuuni/HHvl1i8sNB0tTY4PgHIeyFB6E5Aps/dfqTFZ5e3adafj50iRH47q5NCPUYrEretXETgPlRM/KmBx0DGeNjQxRjWmEl6ns2FJhOHN89hKwdcyOdhXIEyWUoX9FGI814NkquqR766SHyS+/gwncB6vuS3C98kJKON4BSGRTy0MRE778E/VDSl7ju9wDdCXOdkYNPvufx7sb4GEhzmktbKfPifq+aE92SDtQ719SGP+goQsdhSdvfOzy+E3Nq5zRBX3SRg8vMZ1W4gHAbNeHEngoS+Xzn4QqP3lpgqymVOPNaCNuvcrMAMTMW1x+vqNf9WazGgX4sWOp4PpQGBzkKMrfFFEk+/a0gPpPpjs0gF+tmPcunip4FszVCxR6MhC8rUKViSBQQYI0XmjzzU0rUSuIrfji4AcE0RwwBrojL3v1sXd06kz5Gaiv1uQFlkLm2eCQxN82Qb85oyUEOZKNJHnkQ31FC8DzV0PcOaxnGa0eDiE5oBo5hCZx7qJVjfOeMCjT9Bs/DtxG7jw4W5Wj357HtCanhMMsM5636pXezp0kz0rUmJWxo1XMPBYScZgR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: stZByOcDwZJUaUZMEksWGsmC0xA1CdvYdJMw0f24OUVmTBPbmrB8JqUJF4X9K++ErEpAP1MgMx3VnIjmlLab8TgUwi7NkBZzutv/AkFQCkSpDZn0nslvnlIC/ZCTx2IRsDgaJpUw4I1ssvd5VNtVwUj8q+FPf7dIIzK2LWt4eFB9Z9+nbieuepPPA5FSMLpaIBWXn5EPICWuSriaz94xAQUiq4R62bxwiPmsfpT7ofRDJSEpIvNy96bMiPfzeYW+6sy37k2uk3Wn8Sl6hb8ZsOtGfjHIrgYxKx2HpuqP4p1mN0brbMK7N/j9EgBi5azoXXMCjOwwIB9iFCafwqEvorZIKovqok/0JDvNw1PIZOXKIDnFv25qX5Kg4y4gJBPBpydDJxbF32ZuwA02xtliaTi6tPQc8hxFAgDffW8STUBDyEtc6Xo+I7H7kNPs5Luc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 04:10:43.3964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc21c21-4acf-40a4-2fe2-08dea5a54850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15
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

From: Honglei Huang <honghuan@amd.com>

Add CONFIG_DRM_AMDGPU_SVM Kconfig, Makefile rules, ioctl table
registration, VM init/fini SVM hooks, and fault routing through
amdgpu_svm_handle_fault() in amdgpu_vm_handle_fault().

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig      | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/Makefile     | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 20 +++++++++++++++++++-
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 7f515be51..337314011 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -82,6 +82,17 @@ config DRM_AMDGPU_USERPTR
 	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
 	  isn't already selected to enabled full userptr support.
 
+config DRM_AMDGPU_SVM
+	bool "Enable AMDGPU SVM support (experimental)"
+	depends on DRM_AMDGPU
+	depends on DEVICE_PRIVATE
+	select DRM_GPUSVM
+	select HMM_MIRROR
+	select MMU_NOTIFIER
+	default y
+	help
+	  Experimental SVM support based on DRM GPUSVM.
+
 config DRM_AMD_ISP
 	bool "Enable AMD Image Signal Processor IP support"
 	depends on DRM_AMDGPU && ACPI
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6a7e9bfec..a40a42995 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -44,6 +44,10 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 subdir-ccflags-y += -Wno-override-init
 subdir-ccflags-$(CONFIG_DRM_AMDGPU_WERROR) += -Werror
 
+ifneq ($(wildcard $(objtree)/drivers/gpu/drm/Module.symvers),)
+KBUILD_EXTRA_SYMBOLS += $(objtree)/drivers/gpu/drm/Module.symvers
+endif
+
 amdgpu-y := amdgpu_drv.o
 
 # add KMS driver
@@ -317,6 +321,15 @@ amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
 amdgpu-$(CONFIG_ACPI) += amdgpu_acpi.o
 amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
+# svm support
+amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
+	amdgpu_svm_fault.o amdgpu_svm_range.o
+
+.PHONY: clean-svm
+clean-svm:
+	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_fault.o $(obj)/amdgpu_svm_range.o \
+	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_fault.o.cmd $(obj)/.amdgpu_svm_range.o.cmd
+
 include $(FULL_AMD_PATH)/pm/Makefile
 
 amdgpu-y += $(AMD_POWERPLAY_FILES)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a44baa9ee..d5ccacdf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -51,6 +51,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_sched.h"
+#include "amdgpu_svm.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
@@ -3064,6 +3065,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_SVM, amdgpu_gem_svm_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 429947f75..86603d2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -43,6 +43,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_svm.h"
 #include "kfd_svm.h"
 
 /**
@@ -2606,6 +2607,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r, i;
 
 	vm->va = RB_ROOT_CACHED;
+	vm->svm = NULL;
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 	INIT_LIST_HEAD(&vm->evicted);
@@ -2766,6 +2768,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->is_compute_context = true;
 	vm->need_tlb_fence = true;
 
+	r = amdgpu_svm_init(adev, vm);
+	if (r)
+		goto unreserve_bo;
+
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -2798,6 +2804,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	unsigned long flags;
 	int i;
 
+	amdgpu_svm_close(vm);
+	amdgpu_svm_fini(vm);
+
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	root = amdgpu_bo_ref(vm->root.bo);
@@ -2976,8 +2985,10 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    bool write_fault)
 {
 	bool is_compute_context = false;
+	bool has_svm = false;
 	struct amdgpu_bo *root;
 	unsigned long irqflags;
+	uint64_t fault_addr = addr;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
 	int r;
@@ -2987,6 +2998,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	if (vm) {
 		root = amdgpu_bo_ref(vm->root.bo);
 		is_compute_context = vm->is_compute_context;
+		has_svm = !!vm->svm;
 	} else {
 		root = NULL;
 	}
@@ -2997,7 +3009,13 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
-	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
+	if (is_compute_context && has_svm && !amdgpu_svm_handle_fault(adev, pasid, addr,
+		ts, write_fault)) {
+		amdgpu_bo_unref(&root);
+		return true;
+	}
+
+	if (is_compute_context && !has_svm && !svm_range_restore_pages(adev, pasid, vmid,
 	    node_id, addr, ts, write_fault)) {
 		amdgpu_bo_unref(&root);
 		return true;
-- 
2.34.1

