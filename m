Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BB3CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1882A10F8FE;
	Fri, 29 May 2026 05:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mLdlBtfE";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012036.outbound.protection.outlook.com
 [40.107.200.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0DB10F8FC;
 Fri, 29 May 2026 05:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmEqKxb9OUY25DRh14zB/3CvGZ5nUuINfdv3xtybXXbkRwzXB4B6bFK8E9yPkUAEQwM/6XM8XDeunSNHYMDzou8M4lZ/OJFebwcsHUhd57R19lD9maYdtrkJy3BbT++jaFdwMSiQR3ca0P3KchSyOk7Z5NBl6PR7IxhKtvIxfHliRdjy7dxBzxcuQ4dulPyJm6voi4J1Oc+cJC0rzMoFbTYUJq+sijLib33TsBwh7tQOau9qfYeKpJRfRVaxLrIqUUWLTQA3XnVUXFPgqTvuZqJY+vogyCHI+d0rdNX2gRaoeURXQrmfB82X1hbyqny8hO5VHi/i8O8gqBrTM+8oFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+i34oVWS+PUiaA2NSEks9wzZzeNAypYYymXfXDQwxk=;
 b=vwBH3LwUohIz8udY58N99yjOJqiKgbH4mW73TSINPg29M1yjxH9whAGJ/yEaSNyqTx7ESIDAZzn0SqwZOo5u5q+5oNE3cpSrWkLB+QD9qXPQr0y8nx0+RZyucYoRm8/+afx1DDwCzwkXiQk7WbnAPg4oE9YpkZLXe8JrtxWhugsQpvjSMBkkV9f3y0IFBGLHvAH3OKeRRm5NpnCjvPaTOKl7UtAoZbeb+doYPWTxNjucKofyV5BhmHuFnTUKrmbLQIM6vFJd+QmKtPgBSFb4jbSa56w90vJYtVZZ5lKzv9rCTpH0vtqy6sDMXXQxUWvDpSQ1Z1c0XRuOYh8GnxGN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+i34oVWS+PUiaA2NSEks9wzZzeNAypYYymXfXDQwxk=;
 b=mLdlBtfE6gwYfHnQR5mDt0+MyGP3ZB3LFzEyLuzVbpqRPJrc7f8J8Lij2+GgicKw4qkmdnY+FWlyMPKw8aMmiunKLkhCm1xLWi624jMrXZBO0574JbkUzCBKUgNqQXDfz2LhJu9j0Q2WQ80lKbQiT0r7N4ofFQPQGzDCKRtEDzs=
Received: from CH2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:610:54::11)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 05:49:18 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::41) by CH2PR11CA0001.outlook.office365.com
 (2603:10b6:610:54::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:49:17 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:49:12 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V7 12/12] drm/amdgpu: integrate SVM into build system and VM
 fault path
Date: Fri, 29 May 2026 13:48:04 +0800
Message-ID: <20260529054804.596214-13-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054804.596214-1-honglei1.huang@amd.com>
References: <20260529054804.596214-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 137a2b14-8e97-47d1-40ae-08debd4605c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|921020|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: D7FduapTzts0aQU5RaaPw613P51GN9nO8O1ZTapIqYhF869Rq1IU3B/OBRaiJWL/yJ/e4wwBvGJMQR87sRCFZZjPOBY1PbrCA5zql6Rx83WxaDiz4jIE63gHMZNFwtePTg4X0ZwJoWJUyC8F+RP9DBYRym1KrSLZNew/a0m1xC+kJogxBOrTWDrYgLqUw+KomxboGeolOyw5PfZgCfH5ml6lUyB3NAjZ1FWqquVqffv4rz9F/WxVmOER+ilCPbZo296GAqFPESGn99x6RT9chWaRnP8jSOffNkrVOe9EJ1YX9xzwVvn818gbZq61L0GrmGjIbx5+Vdvz/MiIXYTVWC6LtaBK1WGD20DSlgBXDyswaJjtfL7NsW9tDfqCehxwQN1x8uBw6JmBznm8Lqt62+aKocyEKX+s8XPaNRfSYGnv0qkKNzGRJQB2l+YWKoXEHgFGBbFqQAZ5ixZNkwcAaJ7YSpsg9HVkSZDli24Qt2CsSBvlWKfnWTr6pun5CLKQqIV9ekv5vAs0QboywgVCg3lCI9zy5+bQtjwkcc4uZofHgFPwOCfG0qXB3M/9eM4yXNvTyESO7VSmw1yltguYmSiN7KmSJeP+EqMHkAb7Oydwa3lzW4Ikazcm6my8twy4ebZGZGWGuKlmPq/Jdh66i3j7u/+ZubmOVcXYgUddc52WtZngDRMV2Rs+sWAMPhF5ko8DGk7u4euRbcudtOOT5bc5R9k5+jBCPxtNQY9XPnWnGmDMaccrw403wd8prtwdvDAdrBmncoILClgiH+gF4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(921020)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZI+hLbQg5j77uht9E1QFyTNq+wTWUspy/AC/5nvdO5AYpSApn46WOO5Pw1GXqDn/q6nb/ekPmQDM8irNY69QCSG1vt3Xg9SKBC2eMEmfliQ9MfyTSH87ka0sbyuk9cCEJHcV5jdrOV+MZb9rV5lMry+RManhcFhRb6KxI0AaQsQF135aDo/mGdWb3d33AJnj1mkLlKZtDuh3E6matrq4qFtM4yHMeiAfMGkQTPes+ekZGs4d0axG1n1TQYhb0eolLzCCNucXM6WD5dI2mxY3DtjFFme/rfELsMdnqiVChIf+o5Xyu0WvRcRefA+tI3nwLKMYcq1pFWjpQcSNcSF6RGA316L3wJHnDwZSbG3rVovpuPJLsQCyPEOcfAyeoWUhau0H8M0hmREQ5kBkMFySrGQbkq1ggbmq7V6R2Bz9Zccspc+Mg+7Di21gGuMGFBRP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:49:17.4831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137a2b14-8e97-47d1-40ae-08debd4605c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350
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

Wire up the SVM subsystem:

Kconfig:
- CONFIG_DRM_AMDGPU_SVM option (depends on DEVICE_PRIVATE, selects
  DRM_GPUSVM, HMM_MIRROR, MMU_NOTIFIER), default n

Makefile:
- Build amdgpu_svm.o, amdgpu_svm_attr.o, amdgpu_svm_fault.o,
  amdgpu_svm_range.o when CONFIG_DRM_AMDGPU_SVM=y
- KBUILD_EXTRA_SYMBOLS for drm Module.symvers (drm_gpusvm exports)
- clean-svm phony target for development convenience

amdgpu_drv.c:
- Register DRM_IOCTL_DEF_DRV(AMDGPU_GEM_SVM) in ioctl table

amdgpu_vm.c:
- Initialize vm->svm = NULL in amdgpu_vm_init
- Call amdgpu_svm_init in amdgpu_vm_make_compute
- Call amdgpu_svm_close + amdgpu_svm_fini in amdgpu_vm_fini
- Route GPU page faults through amdgpu_svm_handle_fault when SVM
  context exists, without falling back to svm_range_restore_pages

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig      | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/Makefile     | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 23 +++++++++++++++++++++--
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 12e4a41bf..68f519b34 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -81,6 +81,16 @@ config DRM_AMDGPU_USERPTR
 	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
 	  isn't already selected to enabled full userptr support.
 
+config DRM_AMDGPU_SVM
+	bool "Enable AMDGPU SVM support (experimental)"
+	depends on DRM_AMDGPU
+	depends on DEVICE_PRIVATE
+	select DRM_GPUSVM
+	select HMM_MIRROR
+	select MMU_NOTIFIER
+	help
+	  Experimental SVM support based on DRM GPUSVM.
+
 config DRM_AMD_ISP
 	bool "Enable AMD Image Signal Processor IP support"
 	depends on DRM_AMDGPU && ACPI
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ee3574797..608d30d9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -48,6 +48,10 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 subdir-ccflags-y += -Wno-override-init
 subdir-ccflags-$(CONFIG_DRM_AMDGPU_WERROR) += -Werror
 
+ifneq ($(wildcard $(objtree)/drivers/gpu/drm/Module.symvers),)
+KBUILD_EXTRA_SYMBOLS += $(objtree)/drivers/gpu/drm/Module.symvers
+endif
+
 amdgpu-y := amdgpu_drv.o
 
 # add KMS driver
@@ -322,6 +326,15 @@ amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
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
index 1781c0c3d..e0a9ece9a 100644
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
@@ -3076,6 +3077,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_SVM, amdgpu_gem_svm_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 519352378..a8354993e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -43,6 +43,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_svm.h"
 #include "kfd_svm.h"
 
 /**
@@ -2562,6 +2563,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r, i;
 
 	vm->va = RB_ROOT_CACHED;
+	vm->svm = NULL;
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 
@@ -2720,6 +2722,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->is_compute_context = true;
 	vm->need_tlb_fence = true;
 
+	r = amdgpu_svm_init(adev, vm);
+	if (r)
+		goto unreserve_bo;
+
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -2752,6 +2758,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	unsigned long flags;
 	int i;
 
+	amdgpu_svm_close(vm);
+	amdgpu_svm_fini(vm);
+
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	root = amdgpu_bo_ref(vm->root.bo);
@@ -2974,6 +2983,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    uint64_t ts, bool write_fault)
 {
 	bool is_compute_context = false;
+	bool use_amdgpu_svm = false;
 	struct amdgpu_bo *root;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
@@ -2984,14 +2994,23 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		return false;
 
 	is_compute_context = vm->is_compute_context;
+	use_amdgpu_svm = !!vm->svm;
 
 	if (is_compute_context) {
 		/* Unreserve root since svm_range_restore_pages might try to reserve it. */
 		/* TODO: rework svm_range_restore_pages so that this isn't necessary. */
 		amdgpu_bo_unreserve(root);
 
-		if (!svm_range_restore_pages(adev, pasid, vmid,
-					     node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
+		if (use_amdgpu_svm)
+			r = amdgpu_svm_handle_fault(adev, pasid,
+						    addr >> PAGE_SHIFT, ts,
+						    write_fault);
+		else
+			r = svm_range_restore_pages(adev, pasid, vmid, node_id,
+						    addr >> PAGE_SHIFT, ts,
+						    write_fault);
+
+		if (!r) {
 			amdgpu_bo_unref(&root);
 			return true;
 		}
-- 
2.34.1

