Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9575BC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E7D10E970;
	Tue,  4 Aug 2026 09:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EwHu5Gy7";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012023.outbound.protection.outlook.com
 [40.107.200.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EDB310E96A;
 Tue,  4 Aug 2026 09:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCn7l+4gf2QSQSMwMtRtGCwPfecVKDWoQLZDWVs+rFRxXHDsQiy4xIuOW4eAli/D3mHKM6+RaSmEpVJwxvzW43t5S3q8VS6fN1Z/5N21Cvb0NWXjHMP7okoCFQZUTZKbdNvGFT3bHdtoABIShGIYzm+pGNhTnvJDdxS+TMrEOgA80MQ28DkC7qwJGS/0FWAfw8apEFa6aQYcwO2RnKFqUjy9xtskH8Omzvp6ml4Z8bQZ2V8r8LSDoHWVKm+PKJuppbpCgUpC+xKFAPbfJcTBy286U+oB4tlaIdhVrzNVcvct6W4zrImliex6nLNcBT0XGrvPx4Z+RJ/t3LkJNVIWkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvL984azRr8867uQVs6i8eZCh06Uzzbi3v07C28pj2Q=;
 b=V+eU3TPYaAfE50EfOBulpwhXGs3pBqsPQf/ACEagDzD6ubgtlc3IfegypQhshtaFtGfu0GBmA4VAxn6XXLDBHDhJg+9pLRahHgHt0mAZYbCebmRi4tBbJ0j94gPBRLjWvBT3mNluT9Ifv4AHvuC+duUfUIeeylww0lLm5DQsOdVJSstx3BKCjQ3MbGqSDfGKbdg6weY8Lbd4b0NCt9IgHUVbNui7s3YbR41eO+qFQghIMqn7EcWi9OQA4/DVxTqrRGbHQ+Ah3WNsuouSrIsUvPQx0X7FaQ2zuftTF7shK05lzkMp6lsvsSBVhi0vAp90VHMm5xcZo26sMXXKgFnpOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvL984azRr8867uQVs6i8eZCh06Uzzbi3v07C28pj2Q=;
 b=EwHu5Gy7VU408cnne5IEa039lqJHaFPLVuR2oXJD8qKJMNA8+K+N65PKvfBQq8BF0xBXplaeXqbtOfQ25YRekrT4sAhdiRrxwAiRF+k+8J5QhjwqOYqdZyt2ldPH+I3TVEpI9F4QfFdB6yzwUXVyZ6VEy9Dw5KPUOVasmuQ/jow=
Received: from SJ0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:a03:33e::13)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.15; Tue, 4 Aug 2026 09:44:06 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::69) by SJ0PR03CA0038.outlook.office365.com
 (2603:10b6:a03:33e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 09:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:44:05 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:43:56 -0500
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
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v9 12/18] drm/amdgpu: integrate SVM into build system and VM
 fault path
Date: Tue, 4 Aug 2026 17:42:38 +0800
Message-ID: <20260804094246.1719318-13-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804094246.1719318-1-ray.huang@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: b75c9c0e-81bd-4889-d401-08def20cecb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|921020|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cHBM+zraqo06jV+fCDCSDFuwOUpJ1E2iwOjYqBbpnLAtb1IJa3Iry7RCLdu1Asc+C44BufllMPzZ0H3XVnULC56E6GQne2CpEFdfcYc+CegmkoUmeI0IcDpXyY28zACDIR+DbAmLR4iDc1tgfsCtwTiof8/ZIM5xCYLntToRWDFzZAg0T15ZlxsAyOpCL9Rc6gXao+4ZvKuPQ4tbd1YvYIvqXoulzug4AQ9/wrfZnTJ1RQdr7YnCN/QF5C4cejVxUUYy8APCCe2l7TdsJQg/uvj0Onfvq0/VwO1jkAXWYytY2ZU4aMwm5pRtStP/g5DbopZF03KojdUneJOHykbbHq5qPSS1EpayrhBlkzW7mrnkd2Orq4nsIhFLslRJnT+D8wtrzs+TuufGd3X2Ac4kuupqoiBII6hKDzZxl/Zqz6EnjJ9xYOPAGNJqcc8J1ErDIHKpedfCHB4K8EsqS/xkkjRVU+njQokzKc4GxgZlaCN/fDQmQBqNWPO79lBRL0rtNclNwGy25GrCc9Oavapq0Gkojs/TO/I880XVWfjKIYiNDI5h4gA0Epza85BtXHnrbsMEK/oPrT0EzZmzSMp2P9JLxYXvnHvHLlZn69h0i3DeaUArZShBAIxUO5KsNsKSuP4GKRfXABRLer53+aAG0eVg1kTSgUjoAqWDNxa110btIrAtbdrNk2oRKJ/7kP0grmeweZr7hA+neC3cQUukvzJafoV3J5PXBS5IlGswNiFhZ5F/Wo1NUC/0Jb1s0vpG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IlDGBQrDYk7jZczeaHoHYRtWpxUSH08+OVmqydWYgMJevQFRBut+pHGNHTz+w7ZQXfHUtWGgtTEuzOb3/nZ2qQSJPYG5vNFtpwnEtbo9/pgSsKeQPSsJ3okUELoFBRw8oWfpmbx6tIB8FoKQMsoELxDFhpbxXF7yhyi22N4grN07Jk29+rJ4jNFQ6zoacWF0zrQEQI9iPevu/hbeuhpg5hat63LfkuzpRrdVA0+5eLiNen+sFXMNpSapraK9zn5Pwn7erEUHPaXtfmKZ0/e9RyIAMKCx9xDgoVPgMADZamaQ3Ja2kK0ZBHbKfru3sqZd1tKwyFldDvjAiRBfNohkDM9xIU1/iSwhb9awFK9T4t4PueRs1N8i5IVFT2S3eH1n0l6jXUTx6u/dQzUeqpLEPuhCJ/m5Frb5avGW6PkRGOk8gqBfPFk2Zf7Mhs8gt13s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:44:05.6880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75c9c0e-81bd-4889-d401-08def20cecb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
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
index 7a4d452a0ed9c..e91fa4cb5a16d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -44,6 +44,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_svm.h"
 #include "kfd_svm.h"
 
 /**
@@ -2640,6 +2641,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r, i;
 
 	vm->va = RB_ROOT_CACHED;
+	vm->svm = NULL;
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 
@@ -2798,6 +2800,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->is_compute_context = true;
 	vm->need_tlb_fence = true;
 
+	r = amdgpu_svm_init(adev, vm);
+	if (r)
+		goto unreserve_bo;
+
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -2830,6 +2836,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	unsigned long flags;
 	int i;
 
+	amdgpu_svm_close(vm);
+	amdgpu_svm_fini(vm);
+
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	root = amdgpu_bo_ref(vm->root.bo);
@@ -3053,6 +3062,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 {
 	struct amdgpu_vm_update_params params;
 	bool is_compute_context;
+	bool use_amdgpu_svm = false;
 	struct amdgpu_bo *root;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
@@ -3064,14 +3074,23 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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

