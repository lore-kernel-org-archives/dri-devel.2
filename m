Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1609F36C58
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2167410E551;
	Mon, 20 Apr 2026 12:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SH8mKScJ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D4610E551;
 Mon, 20 Apr 2026 12:08:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/VMjiP9jYH70UwYI/iZvojyyAsztgULYRE+V9PcBHrfnYARP+nypthWkiGtn6Dhv30IzSUNEAlp/UldiAnl6aNElq/LjPsrMw73j2d3bXPzSM5N9N66jtIx/18K5NavFJj5iTINleGPBBe2qY46/bmvZOWmMqV53P190MWgnXQkul74TLdsWonTF2X+hPSGvxjLs96QxKOCX/MyAfdt93RqRqNNYWXbbhmUlmpkzzVB/FQuiDwnRs6QKluDgiQCBmxZfB6riRS0J3/vyL/Q/B75DTdOHOHWhX955YcyLbtSKTmiZ8GheIlsOljnuKbEBZwXBjpM+YE85TgpTFkj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOzZJIyuzoGYu91R1tr1hgD6ccIGwL/QbTNSjFLQyLw=;
 b=pXlNbpaBMFvv9zXzpC9QUweQgDQaMQMBDAmmn+ceyrVqja6+iZVMVzwxT3zHVx31cnIEIS7odQrVfibMeuCnuNlE/odlEtSHR+d6EhAjsID0UUhubGw2kzkArtAUSvcyL1twFw0u6a+WbizKTUdnNV/acWSpLJR+t+GQeGsybhFud9NWIZgw4Y36nvxaiL49oyJJh6I3SrBOFhWpbsW3Zb/OKXgi3JV7JQfD+lhj0jpke6HpWw4oOTnZhSB6Sr5nEyhlmTEBxKoTl4aFmdnwf4KFpZ/rZ0twUSRh9oOJ9AhMHwh/5l9086ku0d0R9Chmy0XNpnUPd8CABmRojFt+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOzZJIyuzoGYu91R1tr1hgD6ccIGwL/QbTNSjFLQyLw=;
 b=SH8mKScJ9Di75DYQPWTBhsVI+2vU4xSXikHTlMkxiIfKd/IoYG4DWlTDGlk+6FqQ+p45wMXmeVGYrRaYD8grZVF54fnUxZeEbaslO6IW70eb2/Bf12S/xmbZRZwBb97mhHY12zRw/L0gop4lystFo7jTQoR1vG6yfcOq83xypJA=
Received: from BYAPR02CA0019.namprd02.prod.outlook.com (2603:10b6:a02:ee::32)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 12:08:52 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::37) by BYAPR02CA0019.outlook.office365.com
 (2603:10b6:a02:ee::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:51 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:08:47 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 12/12] drm/amdgpu: wire up SVM build system and fault
 handler
Date: Mon, 20 Apr 2026 20:07:39 +0800
Message-ID: <20260420120739.1811731-13-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420120739.1811731-1-honglei1.huang@amd.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f323ea-6360-4311-40ba-08de9ed5964d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Jh+azRKPtTwHvsUU+qTuNf/89Mvs2P3QsMXyr3gTrnUFQB665uCqf3kdHnpVjlp14bEfeLUgP8L2cZmyJLRAkKCZnqbvLPZSXxXyeZWP6jCD7hwybvMKem2U6qbAsvxMO3y20OqUmL0VrfxP0KkA44I2rajfRnXUpQY1cPXJ3AVrUiM8Xp+9ogAbTcrOOHg7ujhVe+iI6JB1YrlSfcf3MJy2r3VlvLBJRXx2Mlpx+zQk0OE1LiqhhcjTolVRZLXNY60maAghHh9NRMe2f4Z+YDvy0YxDFL4J56v4LeV54k93wWJPVG4U4aag9X6Xraqywi84gTkE4yuY26Qgr3t99PO/MQTzKLz7JqDg5FJSaxkK2/qo7C+BMVMG/Aa1LDJXpvPVD8yw7E5apJdYOp1I+esxBvawCErQkUczX9pjGlRQd2CAImvAV/a9rIsUOPjBMapM5enM19z/jzvWHa49zsUTUCR7L214FjEnksbuQ8wKoHTqJbJyKK9pnCM890fSm5DvGI7pcibcguUmspJCokz8DHn8h9BH9gChNHLQLch2B2Glt6iWWoqLQI3CdXFEEn/NoanIeMl8uWKXCkFv4Odhjtt1cMmStWfrOUlPcUzlLwgMDQY0/a/K6x+nqruZTxsk+fCuwNb5ELtSpWMUb2CFKWTwd6etOaaU6W44ABybEXQqvV3uTVPYFGfhckkr9BHGuDdWbnHSLyeZjvbGk0q5Jx2t9Beg2FecETX25bH9+ayHu1JYFeIrclLHwLyKdw5lXfGwh76fQ/4ubRX6R0PpnE2lwXmjMz7hKn15x36K7yMqHknaTD6wFlhIfkhL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lX83VXqkRVuH9TsaaephuM+bvl2P4W7R5rwMhuLRLHS3uhdfhvSwSBTjH6kmfIiKrUUuq8LvyGNqK8DeyKhAVPXZUMOd/GPdItvDJywPQaJIQPKxp0aoH6HSo5Ib2wd1cvTXTkh41Gby6rwTicoWA1nG7xMddGJc7vnGjIKzbtk/JhS6fFPN3qdsSKP55+157D253dC4ATQDTsUGa87KsXP+yI8uXx6588pyV0HgDzvablkRY/zGcLlXGBIPHMxi0t2s7BQPO2e0+f197sEiSdSaCCtBLhtWuCxQIf4HQTtyrwoTSUidKfJmqn2dqPT+NmDv2yw7fUW19MKV6Op1DiZzfuAF5FrmQanDwxbIS6nHmCxyyuiXC/QPBQqTF47uMiXeTWad1UMyfaDwbriIdJweFKxsZV698ouBSGG7CdBgCuT8blQi+bTNOHRVOcuw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:51.8714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f323ea-6360-4311-40ba-08de9ed5964d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757
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

