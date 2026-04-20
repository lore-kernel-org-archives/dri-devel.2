Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59533F588C3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AF2210E5E3;
	Mon, 20 Apr 2026 13:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KHkalqWV";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B78010E5E3;
 Mon, 20 Apr 2026 13:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RW2+j9BYupk4fmbgkUHjGv/gKn0yEub7WBROFH2mIouOXU6QIxOzBSC+jWevRU7Ey3E9qpqY8+fENAsXDRDFZobREh0BU2fpvvDVlN7cuX/1ahZ2QK8OO2ner1jB4t3gqzEgjW1rvX2oLh1AOV7a3Ro32VLMOeMnfQrjsKirGY8avj4TdbtrUYDVQI9HyBFjVuX+mCt2Yx+RVogB7UClXzcwEjWMCurpp6d3stNeAIzhwpFrogUkET6cIQKDSyGlRsyxAkvmOaqtjo1QpU1gpRup+MHIwy93z/zYNWfdyZDr5NjuWp/Fiq/NVXqls3Obz4vdjTm1qGH9pjlP1m4xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOsQcBgl7FQ1l49wVLGNt+PkmDAXZvQatfna2QD2CCM=;
 b=UCwcTA0Aj6rk8CWY3gAe0x66+MKaRmVwsN17mW8fHnW9bS934iHvtwba7AByq9iZ2qf0FCnsCa1ovPwTGHi3MjhduDufpeybCUaEK0wmWA6yQqBb5ZuJV/yyj8X1x1EpcoBSTbX+gl1ruP7F7tPPLEPWvd1AbyuMQojkUZjjwQtRvSqTXttdm4TBICOry3FlQMGJnuH26z7MPIZM1Xjr9AiG4ZMApRWDaNxdBh+L6AWxCPCin/e5s0qChrmJmoAIdDEnef4L+H6hpxTZ5LiTfEyR4hRBY4Cvwdu3woau6D/4n+AzBYFTVK3hFagU+aG0xje8REPvXDcrUcmE4azQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOsQcBgl7FQ1l49wVLGNt+PkmDAXZvQatfna2QD2CCM=;
 b=KHkalqWVc7UXfS+oKXfFe2vpxWQzlpSoHfEkSSwOlvxi7DH+Mk9fB2ixkAR1YuPkRdMMWGtVL6AWrnCvpXPzjvCFIXh8PYdl01DTAchtElMHk0DR1kmjjkci3C/vs1xGqORHuwpyj9VO6fZfKa/nvX+lX9pn6XPJsYoQmghQY94=
Received: from CH0PR03CA0311.namprd03.prod.outlook.com (2603:10b6:610:118::13)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 13:14:30 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::56) by CH0PR03CA0311.outlook.office365.com
 (2603:10b6:610:118::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:14:30 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:14:23 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>, Honghuan He <honghuan.he@amd.com>
Subject: [RFC V3 12/12] drm/amdgpu: integrate SVM into build system and VM
 fault path
Date: Mon, 20 Apr 2026 21:13:07 +0800
Message-ID: <20260420131307.1816671-13-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420131307.1816671-1-honglei1.huang@amd.com>
References: <20260420131307.1816671-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 6feca37c-4968-4772-87eb-08de9edec1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info: p1fOGx1VyVIG8BiLwwOdgMWQQxSE5GZRXjsBx3DR9b14i9MMbYVPTUezcG6IoB/dlEXAGZSYI5Stje1/GkaNY55nom63VBvzBIa0fKkDA3v2YGvIRmyM+UmXba0ZirkexNgy8AcaPYZx8UR8riLxPDUJSxMg4xYcc0Q/9XUWwxNM8yZhwmK/a9oHvrmPxudzgGWrvv04al3XrJc9mffKQ/4fQ/861CTllVUzMop+Jp81yO3ey93ylOzb3fIcsJ/gpscVLX60w6M+U5KpJy3+OHa7yzXxBBizYFHx386cfvEGM/UHaQ81JiUaoQEclSDX5X4lCqBZfQ5vHQ83XEdYB8LQ82V9AdwQGA666b0TCAxUKcac4MuD3VYuOx4aatpllNBxo4/RawlQMcqc8yXhIUKEZprIrSYm+0sxYZbQSWYYNy3KbluQJ/G2YP/N7yI8zAP5tKVgH6XuwpIX90cz+mprcXtvrut68lOAP3HqZfFK9Ma6/QNfbyC3QgaCp2cBgZHbbr4hQ9bSLzsYhN++DCtMMg9KoNVSW1iLBVJqyfXtdAOVKopKxhGZfzqPl5kMj+1OuZh2Me+CNvF2wU45vnEBTBjOAtbgCAJ9NF46KxEZszqhCbwTk/zNOlNEggT5YvIl2htBW3Rtfc4v5uSkx5Q3xu+yarDVb+FcjPjk23POVPWBnDcn4ZP8OFeyubIAq1t5r04OECAQHkWDHVxtk+BQ7qAhNeLS0BMjTjQ8kCVzYCE2YFav4W9RaKqgTUXd3vJpdUuAwLnPLq74LSCdivP2WehkKKeuqgiqlp3NNhAPH22WvI1xKTOVl/Uh5xLz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(921020)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R9QGeSaZCmqLTMR/OPz7aXeEd2oUDhP1Xh3bC4aybISRuq5buolFwChWykv+VJ5/GqOZPvJNIWHx6qehaFrY8ccwGVofr+Py/c7Wj2DPMtt3DXoKFJUh4WjB1n5FH7djPu66/0rRtZvJg1G4VQyYP88nqPxgPt/FrowNmYPnioirKRLq6+WJvuXP0XrbaSn4jbdHghJWlgUqBoaLAYVdzwyLL8nscIJqqg+geiatf02JfRkVgCAIKVsoEuziCobPIluFctCXLUmEx3cuTeiEjasernji4nUyIFKXvar0vnXmsgp1oQrcUFjvDaeA4a1KS5JDRKD2DIgX6dPb+LDFhvOOT9aCnml61c7uAgKrx06pj8PvES5UNCtFmYx64dssDzpryVtVMFuN/xg5u4xScZ6ruO0nhc8vGwtDG1er65DpBAbl0HxtYeZFXrY2txX+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:14:30.2911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6feca37c-4968-4772-87eb-08de9edec1bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
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

Wire the amdgpu SVM subsystem into the kernel build and the
runtime fault handling path.

Kconfig:
- Add CONFIG_DRM_AMDGPU_SVM (default y), depends on
  DEVICE_PRIVATE, selects DRM_GPUSVM, HMM_MIRROR, MMU_NOTIFIER

Makefile:
- Build amdgpu_svm.o, amdgpu_svm_attr.o, amdgpu_svm_fault.o,
  and amdgpu_svm_range.o when CONFIG_DRM_AMDGPU_SVM is enabled
- Add KBUILD_EXTRA_SYMBOLS for drm Module.symvers to resolve
  drm_gpusvm symbols

amdgpu_drv.c:
- Register DRM_IOCTL_AMDGPU_GEM_SVM in the ioctl table

amdgpu_vm.c:
- Initialize vm->svm = NULL in amdgpu_vm_init()
- Call amdgpu_svm_init() in amdgpu_vm_make_compute() to create
  SVM state for compute VMs
- Call amdgpu_svm_close() and amdgpu_svm_fini() in
  amdgpu_vm_fini() for cleanup
- Route GPU page faults through amdgpu_svm_handle_fault() in
  amdgpu_vm_handle_fault() when SVM is enabled, before falling
  back to the KFD svm_range_restore_pages() path

Signed-off-by: Honghuan He <honghuan.he@amd.com>
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

