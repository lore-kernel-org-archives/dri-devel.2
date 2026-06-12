Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A634CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71AF10F395;
	Fri, 12 Jun 2026 09:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rltzOUGw";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB0F10F395;
 Fri, 12 Jun 2026 09:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHw3SFKHKf5v6JLKAY7FZ050JLXvnwtieApDG0F/MWuVGKPpPYheKFWfyfYq0+V6SjelX1y5pBdOeCvlTeWplBP75tnPgGrBhIUT8Jh/OD8VwBxiNlpb4ecbAfy8bpO4E6fpPYBOGd3WfmHu0X0jbiwdL88c1rMqptZkChQx6QKomh7Y6GGjwA5mjhqici80XZVHyY/fOUTj9KosUEqaHJ1VpcFnP5RYZU8pN4Oz1pfdhbqWsngiYjcpRuqWkLL+Uc1jIww3ocWq4oSKnx+rc2q0z71C3md4sGjlu6yceLjVi628/HXm9cu8eSuKpw2L1zqqXlvfpKhmRBzkRzQ3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBQJknx899tuQY25cc11XT6ePEM+TXGRq02ffgDgPnA=;
 b=jeuiODxSPD/9jeH4370jGxPE3zFIawUQBYgVygfO+7A8F2MFYylwZ3t5vUIto6zQ7KqQn2hwWaB3uPvCKO6fd+FrcW/17EIcbS+dZQ2CB3Th+kcd7JTEWS/ntT0zARhQoBB6oG9np93AWCQeUk4Uh3FFdn0+7ZS60jlFkQ4MbNjCT2dzdFNpjbsGO9hvQiAtjT+s7opz5SLuzVrWjj/Tnw/GoPqItEWn2o0bEqC6rXf4i0r1wdmSuCZz5xEm/guq8xTWsxfmB/VF5TOikLUu5uO5h+KpIu5evKwKcAqTm1VhB4h3pp2PKu5ALZ0pteaXggeSkcRdzbXdVYoUxETrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBQJknx899tuQY25cc11XT6ePEM+TXGRq02ffgDgPnA=;
 b=rltzOUGw3y4I0EjtH7RE81wsuxTynsa1ZSsfPwYvhGIAf5rFffIthhhxyVQ+wY10Ct59iVgidfugf4GJaIJL4ZgDDhrhDDQBxg1uQr8ZUE0YMfssJ3aBpYYsHCZgyem/mI8wozbbBd05EVWj9wXRiCOSDWjmZ8hyBWWexTXIWnQ=
Received: from CH0P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::20)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Fri, 12 Jun
 2026 09:11:04 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::9f) by CH0P223CA0010.outlook.office365.com
 (2603:10b6:610:116::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 09:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:11:04 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:10:53 -0500
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 12/18] drm/amdgpu: integrate SVM into build system and VM
 fault path
Date: Fri, 12 Jun 2026 17:09:14 +0800
Message-ID: <20260612090928.29682-13-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612090928.29682-1-ray.huang@amd.com>
References: <20260612090928.29682-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: a56cf1ca-3bee-466b-e364-08dec86287a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|18002099003|22082099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: ZSGnWnqdsABVmSaVWw59gOpJ8HEX2RP6Lv6NMWwYsk6WN1LGo3H6cc/O4QwEJShWSl2eGI4CQZhliEeCTf/SuDtmPw5P8rCqEuwIuE0IaTBIbCTtmO+ler4ofYoFPAKJtP++gbwS9DEmMBvmuxadYTZQRR6c2fGdCBEYFksHJFnVPbu8bGiS5WPGVirUdaaqwaSs1r2mJgB7pnpZyhQoAz7k4kcd6S7XWmFEaHRp6STKNeiyN+hygpo+rZid9L9KTEC+b2Bp24Lfhxv/Ue9XESNc0KaiMjYK9kbyYhheTdjA4AbBhfDcAl+vhnBAWwKObAd/Y9D6AYU5cwg+nTC7PwScJQBgdr53GG21rJ+hCJ2hcRLSldzcYZ4Nf/E+DHUUE1i1UnnYP7Jx8cawlkTQBawFOVs0YRgqhXyYyL/VUJdOWvNSsEBVSUuoUONyAxsX85DeFvrBHrbahPVQv2IsCkpijKJOYi9dgkTCMAeWCYEp6WsXRwPOkWmI1ygsS9UEj8THFbN9FDuhtySzfFIy4nb9Xjz7R5FtEGA5t7MJFiLlA+UfTm/CvFCFSQWskaEv1O5b/CNQ8fepEAsbk3EAJaNv5A5YFt/Y1TO5U0I4wTAGnx/x8k+UN7rgUoUc5aOLUIwMTbZYixgWSe+5FZnj4JdLGadCb6YY1LpPBDRmY7XoTkFUInoLKN2rlNLN/qXTdK9uMgzKV6h5zFCYYXuKQ8dSJpwhoitzCY4gZ7meNeN0Bx8EKeEkDPXTDbpdC2MgxBlSrS9RQLVZKZOhUScfyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UlKNZiQdbsPFGFKxrusb+MwHUEcB486U72Htytk7h/g64q9TD1iS7AXwws0TArd3HGZBtwU7uEter5SXAHw0b11rthtZvPQLMI+PJiCEiT6CVNN79EpLyQc7Rt5ZeIGKnkYD3+1jh7RKFgscmApVieQaOvkb5WsDEtELrlpQGrQvM2SZ1abfFTOpS0Lo+9KKXNZoRmE2Ovk19EEzBaV2Occr0/9DRpGcePanPR/fvXj8fgM3gw2ufNU3lDHPzbDJ4BV6CPZ46cTALB4JDVg4cdRzowgKcTO1KK2vHkHFaoMUK116OOW4sOvMucQoh6nwgsQZz4HYOVQ6y+nyQYcrI8UKAKBpCAPDWr78Vzr1kE13bO2MX1xARIttc5HGU+PQf+BbtHjxQJiaIIh0q1GM46RAWCgaacdXZ50eGXJ9d//wXF0elAzXNjDG0rgM9khH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:11:04.0957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a56cf1ca-3bee-466b-e364-08dec86287a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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
- CONFIG_DRM_AMDGPU_SVM option, depends on DEVICE_PRIVATE, selects
  DRM_GPUSVM, HMM_MIRROR, MMU_NOTIFIER, default n

Makefile:
- Build amdgpu_svm.o, amdgpu_svm_attr.o, amdgpu_svm_fault.o,
  amdgpu_svm_range.o when CONFIG_DRM_AMDGPU_SVM=y
- KBUILD_EXTRA_SYMBOLS for drm Module.symvers
- clean-svm phony target for development convenience

amdgpu_drv.c:
- Register DRM_IOCTL_DEF_DRV in ioctl table

amdgpu_vm.c:
- Initialize vm->svm = NULL in amdgpu_vm_init
- Call amdgpu_svm_init in amdgpu_vm_make_compute
- Call amdgpu_svm_close + amdgpu_svm_fini in amdgpu_vm_fini
- Route GPU page faults through amdgpu_svm_handle_fault when SVM
  context exists, without falling back to svm_range_restore_pages

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig      | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/Makefile     |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 23 +++++++++++++++++++++--
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 12e4a41bf1f04..68f519b3479db 100644
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
index ba80542ead9d9..884cdc5c1e4af 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -322,6 +322,15 @@ amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
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
index 503bb64c1e55f..46a074caba53a 100644
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
@@ -3077,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_SVM, amdgpu_gem_svm_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2f3470208829e..9274b0359a164 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -43,6 +43,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_svm.h"
 #include "kfd_svm.h"
 
 /**
@@ -2573,6 +2574,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r, i;
 
 	vm->va = RB_ROOT_CACHED;
+	vm->svm = NULL;
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 
@@ -2731,6 +2733,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->is_compute_context = true;
 	vm->need_tlb_fence = true;
 
+	r = amdgpu_svm_init(adev, vm);
+	if (r)
+		goto unreserve_bo;
+
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -2763,6 +2769,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	unsigned long flags;
 	int i;
 
+	amdgpu_svm_close(vm);
+	amdgpu_svm_fini(vm);
+
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	root = amdgpu_bo_ref(vm->root.bo);
@@ -2985,6 +2994,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    uint64_t ts, bool write_fault)
 {
 	bool is_compute_context = false;
+	bool use_amdgpu_svm = false;
 	struct amdgpu_bo *root;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
@@ -2995,14 +3005,23 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
2.53.0

