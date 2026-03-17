Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D39EFD8745
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A460E10E607;
	Tue, 17 Mar 2026 11:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v5HF4Bx9";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2079710E607;
 Tue, 17 Mar 2026 11:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoLXiJSGmzr3YuNBIrOPiaTyqBsCrJRagd/AZHVt7/jqIbN4ytmDRVAg2Eo42DOcQI6UsQ6bAWU5EsXfeGA4Z0sfvVMpnZ4KbT10ybzca4OOIdixfF5o0X12Ri30nb6+MHgnS8hW2D8DB8nfN4EGDrs6Rn3cCPyQmr+WGKe7D0qcu4LFn93pkNLEISSX6tuIKCQqv2Bc0MOfxxgyKXZ4YSPX4KeQ2bvg5/BtIdgxI8WPNIkNgsU9+VzwoM++9qwlHj776FZboD+p6noP3NMax3pyWIfxfFagCtEEBGh7SEmnU8olI0UVxTmnpbXaQ0jvhhgLVpWXljW/p4T4XjyCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOzZJIyuzoGYu91R1tr1hgD6ccIGwL/QbTNSjFLQyLw=;
 b=VSIjE8006pyxzwMeDDjf77d5eho23rkmWWLqnvKmOawB4GPG3SKP7hYI+xxvnOk+g8GdN3mi17szkc1PWzWflOtGDV1ndFIc5vBDQGtLz1/nFxjbRY/Cqmnt0gOHq23Iu1XAhS8EC9P933NlLsQmXc33u1HzAEt6p5ouNdrACbG+XpxKUIjVf2R2TlRVAsuABME/qje6HDfW4toCojFJ+8CmuHIHsNwacRqBnbsPrSACGA+3UduWzIzbGzMm3JNKQlckKgm4pgSYpfj583U7JJsWAszKbOZoMeKggcV2UVKbZ+czAxELFOzJ7SGwW/PaID/J4jDsjveHct4a4G+Qlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOzZJIyuzoGYu91R1tr1hgD6ccIGwL/QbTNSjFLQyLw=;
 b=v5HF4Bx9meAPinnGKy5jABsgeNgRpQ3u+y0u4A95++CcXnaBdyd1E7SVc908lau04rI9wPvU1qgWjXPlBHAMkh9KCuylRW6MXC58Np7nrakFBnvnVszav4PeSzQPFUVUzhMEAICFhV/T+Iuupg3GTJuDIg6xoOCCHd3asBPzDtQ=
Received: from SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 11:30:55 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::d5) by SJ0PR13CA0136.outlook.office365.com
 (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 11:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:30:54 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 06:30:50 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 12/12] drm/amdgpu: wire up SVM build system and fault
 handler
Date: Tue, 17 Mar 2026 19:29:58 +0800
Message-ID: <20260317112958.2925370-13-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317112958.2925370-1-honglei1.huang@amd.com>
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: b51559be-1975-4d29-e4a5-08de8418a6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: dU8XXds9MgJFGc/yOIYbsJR99+e+CeoShvzKSJ/UrgeOfa5BqtJw/881C6Wj20GiqOj4q8dqBUm9N1MSAgwHBhKH7DP+DUf4jRQ7WeYsNO8+66BtGMb+lRdG+0w1FpuxKS56yyOpxnZWhtEN3Txq3xYl2yV1SUNuuTqFphEtvk9B0mwq1HqcTOUTN3UbJ+6CckTZ1lRAoCmbxtaZl0EVY4fZFqPuXNq/Mv6J2pzIqPg0YgvG167fPKs2QAVBU5F05JOVbyT1DeCtYvStJkWdhWndJSGy9DqhgEHBUMkOfBYGwM6EPIM57a9EDvategsooDUDZA63gIMVQUjqt1DLw7SWGGBRFdsj3+J6kUjWgouITUQE5OWv1iHVXK0VU4YgQExJTRTh5W4qVK8eHO/wDbHUPpE4XaS8WM3+sDGbFwlgHQ/UhuAY6iPWztFfCnmBYv4HI6PmzH4AktAN2rDeDRVY1ZlNQImbXvUNP/L0CXWPpeSoricboOGDGRNY0RrmU44keIf/ewM5FFfEZD7ANYjTKftLUElypz0j/oVxHpkc7+A22jz7ibTZmd4YcB6E0a4s66Iz0UiH25zgXnE6xCk9sJ+9TMjAqXg1JF4An8NvcQVQdCpo9yEdglAGzFFFzpKL5XzNoUId+J4kCt4AcDI/S3GCGYtMYfZfHV1jHxyNOKzz4Qgrp2AxO+aycQ43ybAvC9flz7Ig/Hv6qDoyFtpntAWx9xufhtUuOkL8Oi5Lhl5/wdmOkFy/CkbrX94wWpPXhxKE7Xv4bSp6QjCJ1aqgCDSirtWpp+zm60n4TiVstHOOD7kUsQH8ZjoVRCAq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cwWoCXSObP52FP2PC/7lT4LI+sf5tfrDmhccW8eiKPATml8+xFrVcLdrDmjve8bJ9M1wEssMsk3V5n4MYlclNeVxkVPI4asM5HdAcrWUysuY7XfSrzSoSz9zXyPAgmXlXNnCDJsFoMy7Xd9KA/34H3EU3uxdm4/nyWSlOPfO2628u24/s5hx8IIatr4EBokNmtKhQoD65MKDH1E2XEXQ8EUZGyNNDDhI7TLs8EeAEzBzlQFH3XrLPYCu0EZqq5P25v5k0f6rld/DF5bFYZWrQgcXz3mfYuOGijJXmD7dHE1NtZ+Q1RbghJNVMVbLLXqFcbpS8kkUKPH0YNysYYV0lL3QiIPLkipyJC0/oI9WEGXpRMIrhei+AGn7ksxwa9Qt8tEsdrTnNwom+QcfH2J+0g3gXrPRQaxnhdm1qqkT4nqeBg4Koi8VS9zaQE7QthFW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:30:54.6186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51559be-1975-4d29-e4a5-08de8418a6f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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

Enable SVM compilation and integrate it into the VM subsystem:

Kconfig:
- Add CONFIG_DRM_AMDGPU_SVM option (depends on DRM_AMDGPU and
  DEVICE_PRIVATE, selects DRM_GPUSVM, HMM_MIRROR, MMU_NOTIFIER)

Makefile:
- Build amdgpu_svm.o, amdgpu_svm_attr.o, amdgpu_svm_range.o when
  CONFIG_DRM_AMDGPU_SVM is enabled

amdgpu_drv.c:
- Register DRM_IOCTL_AMDGPU_GEM_SVM in the ioctl table

amdgpu_vm.c:
- Initialize vm->svm = NULL in amdgpu_vm_init
- Call amdgpu_svm_init in amdgpu_vm_make_compute for compute VMs
- Call amdgpu_svm_close + amdgpu_svm_fini in amdgpu_vm_fini
- Integrate SVM fault handling in amdgpu_vm_handle_fault

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig      | 11 +++++++
 drivers/gpu/drm/amd/amdgpu/Makefile     | 13 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 40 ++++++++++++++++++++++---
 4 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 1acfed2f9..22f679b85 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -74,6 +74,17 @@ config DRM_AMDGPU_USERPTR
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
index 64e7acff8..6507d9a39 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -43,6 +43,10 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 subdir-ccflags-y += -Wno-override-init
 subdir-ccflags-$(CONFIG_DRM_AMDGPU_WERROR) += -Werror
 
+ifneq ($(wildcard $(objtree)/drivers/gpu/drm/Module.symvers),)
+KBUILD_EXTRA_SYMBOLS += $(objtree)/drivers/gpu/drm/Module.symvers
+endif
+
 amdgpu-y := amdgpu_drv.o
 
 # add KMS driver
@@ -303,6 +307,15 @@ amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
 amdgpu-$(CONFIG_ACPI) += amdgpu_acpi.o
 amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
+# svm support
+amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
+	amdgpu_svm_range.o
+
+.PHONY: clean-svm
+clean-svm:
+	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_range.o \
+	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_range.o.cmd
+
 include $(FULL_AMD_PATH)/pm/Makefile
 
 amdgpu-y += $(AMD_POWERPLAY_FILES)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7333e1929..12b587f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -50,6 +50,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_sched.h"
+#include "amdgpu_svm.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
@@ -3068,6 +3069,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_SVM, amdgpu_gem_svm_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 676e24fb8..f64392117 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -43,6 +43,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_svm.h"
 #include "kfd_svm.h"
 
 /**
@@ -2564,6 +2565,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r, i;
 
 	vm->va = RB_ROOT_CACHED;
+	vm->svm = NULL;
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 	INIT_LIST_HEAD(&vm->evicted);
@@ -2722,6 +2724,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->last_update = dma_fence_get_stub();
 	vm->is_compute_context = true;
 
+	r = amdgpu_svm_init(adev, vm);
+	if (r)
+		goto unreserve_bo;
+
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -2754,6 +2760,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	unsigned long flags;
 	int i;
 
+	amdgpu_svm_close(vm);
+	amdgpu_svm_fini(vm);
+
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	root = amdgpu_bo_ref(vm->root.bo);
@@ -2939,8 +2948,10 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
@@ -2950,6 +2961,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	if (vm) {
 		root = amdgpu_bo_ref(vm->root.bo);
 		is_compute_context = vm->is_compute_context;
+		has_svm = !!vm->svm;
 	} else {
 		root = NULL;
 	}
@@ -2960,12 +2972,30 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
-	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, ts, write_fault)) {
-		amdgpu_bo_unref(&root);
-		return true;
+	pr_debug("vm_handle_fault: pasid=%u addr=0x%llx compute=%d has_svm=%d write=%d\n",
+		 pasid, fault_addr, is_compute_context, has_svm, write_fault);
+
+	if (is_compute_context && has_svm) {
+		r = amdgpu_svm_handle_fault(adev, pasid, fault_addr, write_fault);
+		pr_debug("vm_handle_fault: svm_handle_fault returned %d\n", r);
+		if (!r) {
+			amdgpu_bo_unref(&root);
+			return true;
+		}
 	}
 
+	if (is_compute_context && !has_svm) {
+		r = svm_range_restore_pages(adev, pasid, vmid,
+					    node_id, addr, ts, write_fault);
+		pr_debug("vm_handle_fault: kfd svm_range_restore_pages returned %d\n", r);
+		if (!r) {
+			amdgpu_bo_unref(&root);
+			return true;
+		}
+	}
+
+	pr_debug("vm_handle_fault: SVM paths exhausted, falling through to NORETRY path\n");
+
 	r = amdgpu_bo_reserve(root, true);
 	if (r)
 		goto error_unref;
@@ -3020,6 +3050,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 error_unref:
 	amdgpu_bo_unref(&root);
 
+	pr_debug("vm_handle_fault: returning false (unhandled) pasid=%u addr=0x%llx\n",
+		 pasid, fault_addr);
 	return false;
 }
 
-- 
2.34.1

