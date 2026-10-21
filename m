Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D4606A31B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XsKDCpqd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDDB610F89B;
	Wed, 21 Oct 2026 03:00:39 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1050310F892;
 Wed, 21 Oct 2026 03:00:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6uP92NZT1gM/5Q/V/u0Rvu5Z2bfKfOK+rTaHiStOX15IUUK+WiVXePmPVc5uZIrQ0jaaqZpWlkrvmh7LPj1jnedYwjGAW/tLqnkYR0iP/GeRnteRzFEO7KNxADJyM1jvQoYGwmORflxAIfizZdr6L36lE5T4dnkk8xBeC0EFtCa4z+vVPgn5IcdLTtDBuN/tECgML/cG8bWh7EH2Cs4buqny4BmWPYY0xLP3PT10Im3m0mgAKpJeR9FPaIhfnGBBAWpfT3dW5EVNlTODzH4Ra6lqk9mBnx1EJOiNteskFjnA1BXzX61QQCLDPrPIs7c4fjir53MjUrxMdpTA/WDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68zuo3uANqiHLRM+xxsycgbu7h7kAbmzPTHlAb8gesA=;
 b=mKKJFA+fEzyDp/0//NJHUVdccQU4Dts1o6IRG4DIvXbHRI25usDSoht0wiUx7g/ACfAwN2dgoNxI7icEh+4qJlNowdq/igxVV3lavhsVSNCd7FrwghzfZz9jKvldGwSRLoLwE4iwnMKwy5068HpZc+A54SoKMsVNH5+uopznW+zaFyNWx4aDr3piD4tHVBMQz+wI9QHR6b2l33evh8wq9S9vdpqhuXe64Rnp67+pn0xsbbLEUuvU76JxTG9Gtx1Rq7q//byyTDWOQ0kx47keJie2R7nqBY2yrBwI8egy1uhZJQU1iUBkDSri0M1TBw0UcRJaeSagiE1l/xMaNuwdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68zuo3uANqiHLRM+xxsycgbu7h7kAbmzPTHlAb8gesA=;
 b=XsKDCpqdxm1gcVdMwOKfQXqBthn5KQV4KitSrIZMCDv7UtX4YmGJwla37eph4/W79uQRvqhRKpu05Qp2xutZ9bkZACfHGJpi7xrIFIJEnBvVD937fLNv92nx4JPq3n782o7+4Hvlfy1hexTIDMf6rx0WUSOae3tmv9NKYrQbkF8=
Received: from BY3PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:39a::9)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 03:00:28 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::80) by BY3PR03CA0004.outlook.office365.com
 (2603:10b6:a03:39a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 03:00:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:00:27 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:00:21 -0500
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
Subject: [PATCH v10 12/22] drm/amdgpu: integrate SVM into build system and VM
 fault path
Date: Wed, 21 Oct 2026 10:58:51 +0800
Message-ID: <20261021025915.2433837-13-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 808e40fb-96f8-4e94-4b1d-08df2f1f75e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|22082099003|18002099003|10067099003|11063799006|261009221227099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9sYaqL26E5WP79dWVELvfQ2k7GBSyWr0sFYQQ+eJ8ZOFuPJHVRlQIlVKHbayovGbwCh2P0Jw2mmdoMqkN1/1TXIwLO5TDTnkpxw/WEdsPw0OH8UW/iDrxp56MGb0kWUWt6FdEePU9cE6q608pfc8BIfOOEfGZwdc+3VbhLtGMzLwQrFf4VzZ8rKWiVt+da5AqloN5Ehuf5Kfa4eXNCKwFuOISs18IpJWIY1rverE6q5EdxypSO6l45ayX4TDKCZqzLm6BxYagZ4VZxvPeNZdVx7pNW54jyp2vTbVmpIIc4UcOxcwM8PWmEcAnYZi0u69H7MwgrfU/4yJdutsXk/3viMGez/Z6mUvhSK0YLYjwOH4/EqgJAtqOnw4VE4uSxw9vM0/YyHC/A1c8jyMdGpNPYLDYgvd8BcUGoNVG+tEzA0eROoVfNanJ1tbzrWh9NGr1Cc+gsxuwqjH9+Ofa7MsuQBjgmExpN3hcP9bqgc0x+s6KFhg6XMYz9UgR4Htb1WVvvoTQfBoH6359de6YQcd/5bbzBlwSNDNSjLQoBLSG5fxxrqLjMPEBSq11W24i1qZYMgo3KFAr3EQHJmKmpebR06NPySBOIUI9ITzRsJllZf4Xn77w3L+VufBN4Kw2PTKj+q0uz34mO6+Idxi0c7miomvkaYMSN6HxRMVhCkQje1+rZqFTD4xubfjQ22gzsFLIHs8TB/IUvs6edlMhBM7WMXNYHuss+zv+0tyt+ioEgIuNMj1hYfp4pLZK21XwnWM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261009221227099003)(921020)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w990lErip0P+xJvSH7JM5tpaCOnTnGZliGPEvkpX5FSWZOQ4AIIOQkiyIc0ta+NKDEu6b2JYcRpKa5mJ8dgj1N/apD6YYwTx7AvMTmrDB/VEaZvxzzQnAvYe9L//7JYR2HADaO1WlsULaxIcNPsOl0XvoB8hWErVXHT2oxOLENDNFo5mQ1k8z5n0dLTqvTNHchAhTelNml79AUYdaWdeAutEN5fHmiaokYRq0VT6x9RVDybQqkVk92Ze4F377lewjZjMSUt+FG7T0cysBhABagl5R5O6j8pTL+2HqNxXjOAjSNecRzLLvwGMDy4ACUu2h2R2Yw/mtPI9PFXM5bvGfLYtM/TzDrPVxjvFzfVC3EDJwhvb0NnGsZW7P/7kjlrSDWq9Rzck73+C+mngEOIqzrslfl/HkhEZEKzMSZRUeRj9mzYax5CNzjTZHdoZlh31
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:00:27.7304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 808e40fb-96f8-4e94-4b1d-08df2f1f75e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Wire up the SVM subsystem:

Kconfig:
- CONFIG_DRM_AMDGPU_SVM option, depends on DEVICE_PRIVATE, selects
  DRM_GPUSVM, HMM_MIRROR, MMU_NOTIFIER, default n

Makefile:
- Build amdgpu_svm.o, amdgpu_svm_attr.o, amdgpu_svm_fault.o,
  amdgpu_svm_range.o when CONFIG_DRM_AMDGPU_SVM=y
- KBUILD_EXTRA_SYMBOLS for drm Module.symvers

amdgpu_drv.c:
- Register DRM_IOCTL_DEF_DRV in ioctl table

amdgpu_vm.c:
- Initialize vm->svm = NULL in amdgpu_vm_init
- Call amdgpu_svm_init in amdgpu_vm_make_compute
- Call amdgpu_svm_close + amdgpu_svm_fini in amdgpu_vm_fini
- Route GPU page faults through amdgpu_svm_handle_fault when SVM
  context exists, without falling back to svm_range_restore_pages

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig      | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/Makefile     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 23 +++++++++++++++++++++--
 4 files changed, 38 insertions(+), 3 deletions(-)

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
index 7b08814a24da4..96fd2b195c295 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -326,6 +326,10 @@ amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
 amdgpu-$(CONFIG_ACPI) += amdgpu_acpi.o
 amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
+# svm support
+amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
+	amdgpu_svm_fault.o amdgpu_svm_range.o
+
 include $(FULL_AMD_PATH)/pm/Makefile
 
 amdgpu-y += $(AMD_POWERPLAY_FILES)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9c5e93cd3ee64..2a03d5cd78e85 100644
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
@@ -3121,7 +3122,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
-	DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW)
+	DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_SVM, amdgpu_gem_svm_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4fb22195607a5..77f1794eb5011 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -44,6 +44,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_svm.h"
 #include "kfd_svm.h"
 
 /**
@@ -2672,6 +2673,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r, i;
 
 	vm->va = RB_ROOT_CACHED;
+	vm->svm = NULL;
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 
@@ -2816,6 +2818,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->is_compute_context = true;
 	vm->need_tlb_fence = true;
 
+	r = amdgpu_svm_init(adev, vm);
+	if (r)
+		goto unreserve_bo;
+
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -2888,6 +2894,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	unsigned long flags;
 	int i;
 
+	amdgpu_svm_close(vm);
+	amdgpu_svm_fini(vm);
+
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	root = amdgpu_bo_ref(vm->root.bo);
@@ -3127,6 +3136,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 {
 	struct amdgpu_vm_update_params params;
 	bool is_compute_context = false;
+	bool use_amdgpu_svm = false;
 	uint64_t *dst, flags[AMDGPU_VM_MAX_LEVEL];
 	struct amdgpu_vm *vm;
 	struct drm_exec exec;
@@ -3146,6 +3156,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	is_compute_context = vm->is_compute_context;
+	use_amdgpu_svm = !!vm->svm;
 
 	if (is_compute_context) {
 		/* Release the root PD lock since svm_range_restore_pages
@@ -3155,8 +3166,16 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		 */
 		drm_exec_fini(&exec);
 
-		if (!svm_range_restore_pages(adev, pasid, vmid,
-					     node_id, addr >> PAGE_SHIFT, ts, write_fault))
+		if (use_amdgpu_svm)
+			r = amdgpu_svm_handle_fault(adev, pasid,
+						    addr >> PAGE_SHIFT, ts,
+						    write_fault);
+		else
+			r = svm_range_restore_pages(adev, pasid, vmid, node_id,
+						    addr >> PAGE_SHIFT, ts,
+						    write_fault);
+
+		if (!r)
 			return true;
 
 		/* Re-acquire the VM lock, could be that the VM was freed in between. */
-- 
2.53.0

