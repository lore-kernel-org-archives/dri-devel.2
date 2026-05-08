Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3424CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E94E10F3BA;
	Fri,  8 May 2026 07:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="upRGJq5j";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC93E10F3B8;
 Fri,  8 May 2026 07:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/GTsnMr3ZaUrMNVUXWESGmzRoFejwwt2am/EgV3K22edX8A9MAT+5wivxrDvwE6+jQaSMH8KotSg+CkTARkmWtO9JRiqv9bsOSJk9HuAQkHDHzRaY8QCHnvmA/v0hAdLhSdAp/Judh38hFAwAjYCHUij5nQ0c2V3gozDkFN2AZljmWYz9Jh74Ayo3yWP1tDRZGHH0XamA8seaoOFUKOxvE+UFF9+MOgqcN1H1aM1Bm+llwAVXzYMy5vMva5KKVSb736JGdPC2uMDsa/PSV2efH8dhkgSXZaUreEbCWq2HQzFOLf+Db1Y2sbIErCN7FjuWslItKCLzceOD0LXgYe8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qoko8jELsGi9dTaw8s6Cs8VJlMgH4MHNzutwE+8Z4cs=;
 b=F8pN4XY/u6LDdm+CxDAXrdiLWJyMboPPjHUP/9BeXSjmFGLdWIwTFqjg4nhxtc/G/YypaFvBPunyQPpSKx9vy+V3kmy50iJCNNm+d9ggmrHfDv69YJV+vgIHJZPp5j5XsOEsmYAF4A6tq+D69WKYSk5tYitZUhq5RjrTrbfPgH8N1ePU+H6944WZE7FdYoyify98Oy1MKgLCM9GtZQywa2flkqhJKouS1QbbWFrXFnSQw+V1DWzZE0TIfxWcrm/F6b1bbAaGy0eUEXUAST1aI1uj0RyZYgUdNVvfAoI+OL4JfU1EyXlbrUP4n2iUoV1VwJorqPHGXxe5cxnXa6KaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qoko8jELsGi9dTaw8s6Cs8VJlMgH4MHNzutwE+8Z4cs=;
 b=upRGJq5jm+PWEJGC9qP9kkowns0ZeSdYDp64PcCBHqdabut/nWQ/XrjDtEtVT5oAvRpJbqluZ0ykzJ+aXW2duEqDHcQxtLkrbAIPH+A8CfwyNst/ze8uLhNKc9Fgqgi5Z1yyO7Ypx1/l175p+E+ib57UZnSycJGnbVNUJxd6Ya8=
Received: from MN0P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::24)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.16; Fri, 8 May 2026 07:52:42 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::6) by MN0P222CA0015.outlook.office365.com
 (2603:10b6:208:531::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 07:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:52:42 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:52:37 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V5 12/12] drm/amdgpu: integrate SVM into build system and VM
 fault path
Date: Fri, 8 May 2026 15:51:29 +0800
Message-ID: <20260508075129.1161157-13-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508075129.1161157-1-honglei1.huang@amd.com>
References: <20260508075129.1161157-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: ef479939-50c3-4d44-2ba8-08deacd6c8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|921020|3023799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: M03hiE64GkfsLJ2nsy5/VWws3EemyA1ozVC3Xc/7DvFwg8EH+409VsqrgaYISIWXwbsubDAEQZLauAV03qOnLPKAPCblWC9DrP0qVfLnMn3qr8FfxVPctbpe1chDv6g7gyhf7dhe6NwbNJVy1pOSLGS2aCvlICh/a23nTGH4SuvVoDRe8JqP1FSiW9jXMCW4117QUXh3B/g8mRQQP/Uw9ztZpdjNUg68jyVdohfVx6enuWLdZqu0ticBV3llJpGsmjY9NI6GUzJgQ+NkLEbv7FJYUSfv3zrCTjeLKFCkPesxQ/TwBenZc5xwGXvisLJadTG+4hrLW31aftIvt7eJdD8YXCnAmNsaifgVgfekOWSoQb719dl1/KU5hQoa8zIgBiFrCD2p31G4HydowZKMVDY1vXMg/YwlKdC+YBTyRo9GCroG+utVLclPWaFrnLr5McqCuAF/PjxykRQAZQZjhZI8AXeWFYCF4h7bSyiBwQdvs1jspdSOu7DF4ar21AqlG6aecLVzTJvh/ePmhlnPrj2J4AKAibEFQbWKxMH6Kwbttcx7tkue1B1DdJ1XEV1cACeOvwMT4/EnLjSMXutPDfV23/csRDWzSgR1CKfg3HUUEi8Y/K6kTpBSt/eJerpU0eETAOZiZSPxeaJy9VTHo/PXj5AOwIbyyFzHO7CXy2E6kMpN4wm/Y8A4R7dDHVY0JPwL9FqCwFmRAKESTtJp7B8H1T52ePRrE0PyafidD7aQZhGevk4V83kBGqZQAriZbIMDxR9SFRkuffDzD8kcHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(921020)(3023799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cBlxWirHOFuyziHkqJgd3OsBTzG1Dyocr2n+JI3BwktEc8sMnF8oeKE0iXh3oKZj+cuwxz6ZhVPrNpZqVFYHlv4EPvi/oznXApGpAAXx3s2FRc3NZccPajJ2grYlg5ZhGukb15V4A+xYVwQ+T7dFLW153TIysKXz7FXf8RkmXYIliocs55iMeeCJ/Inm7Wco2rz0DMXO9/ykawGjoGlGOalDi4h/eSTCnj1Y3u5XMUVkQLZYGukzGL8xuebGktn8LoTRdyvlQLK631OnBroFGwAdl4ypSXGdTEKNdcb4Rr+5umN3tPU1H979MZPoVAq1ABvsdOPx1GGLcDK5EvTZxLlIe9h/cVWYKnjDxzMAkFiBzwQFfg64WKjGJSzbh/mPiECFow5/FnMqe99sTImvwqKPEqDSr/tYhQJ1K9fLDMGI+ULeEoPlaglHQ0PT61z6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:52:42.5794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef479939-50c3-4d44-2ba8-08deacd6c8df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
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
  DRM_GPUSVM, HMM_MIRROR, MMU_NOTIFIER), default y

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
  context exists, falling back to svm_range_restore_pages otherwise

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

