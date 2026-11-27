Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C832606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GN6bqs8V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F2111287F;
	Fri, 27 Nov 2026 08:43:10 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FDAC112877;
 Fri, 27 Nov 2026 08:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+MP9JxieAajRwiULOo1nHR7JVHwafNK3hoUvVOEZyfW6drWoSqcXGZypYimklwWYT0JJudTIXp8JZ16Td1Q9ZDu1AB2plxE4NtoEoAhuA7zEyRDXhPcxp9pY9+Et5a8WJ8Vma+ZX58yeypnI4TjejN4LLzRYao4MPHIvXvNPfdrEwcGMyqX1nt+aq5+3v/foNKCykMHQvwbKIW/6mSBwE6oaM+rYjO6OKJX9JYaD74qPBvRN381vEHQZU01SErK/+aNhmPs32mxizKmZins5RcaA9oEGb7Hf+e9jQXqSyqHwCy72CJ8eTfEMlZfTQsc7FTPAcclao2axISWSngbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEJEbVU8Su0j2VFKjU3eDYhbDuWc9vXUxCLPpaFFXAk=;
 b=fbZ3ugKBSS2V6oRbFOqowUKJzzytXaa+L50Cl6oyigNQsA6PH8lIpfVFASVI69NvRUKQ9iZFFdLypFOK/0Dsx2YD7Xc5+RE11Q2FcXWqmvcrKTnC3yTRoXyOXLOLnvN4zgcaLJ4ClyVAcTYBXTG1JoqO5evNmOpyV1NSguPjE13+USKnZRdzmujoBn6BFmxjDT9kT+wfbfZVJrCy8QQH6l0yELv2ofj3QL+eNomHHQ2WoyIxc6d3+cxVzS1OFkNUT5jHejFmwQ4Rv1DEYdLbZ3t7cwPSZyZtHX89A3Jsb9BijhVzqKS9WaNGuoOQq2hJL6HzIpTtnqzYOOqAHjxZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEJEbVU8Su0j2VFKjU3eDYhbDuWc9vXUxCLPpaFFXAk=;
 b=GN6bqs8VBY/GUzCJxi7/pXSFvjsqPqm28LIz5U3xFs68U4esoDPjjLMXjKsisGyFi4sdOPgwZgqU8WXkIbo0GNguIOSF5vGcNxBBy+g51DSl2BQCA91nmce4fvnv2BWzrYIxBLbjfA0DzP4PWCsbhM6Zub+D4eFk4E/iQLSpIc8=
Received: from CH5P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::7)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 08:42:50 +0000
Received: from CH2PEPF000166BE.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::58) by CH5P220CA0001.outlook.office365.com
 (2603:10b6:610:1ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 27 Nov 2026 08:42:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BE.mail.protection.outlook.com (10.167.252.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:50 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:45 -0600
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Aveline Noir <jm5905938@gmail.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v11 12/22] drm/amdgpu: integrate SVM into build system and VM
 fault path
Date: Fri, 27 Nov 2026 16:41:35 +0800
Message-ID: <20261127084149.925625-13-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BE:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 12da2690-e20b-4aec-c39a-08df4c626ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|921020|261026121527099003|10067099003|11063799006|261022115727099003|56012099006|261009221227099003|261009223027099003|261021121427099003|261021123027099003|261102123227099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: frLJ6eG8L3dFSN0gZw6gfzCr4VJm541Hvr1u1UtRyEcOddbGbgxMbARwQK0fNig4K2+bjDSB1bV4mVEl33nhM2joOQVUzARPIUyTQBzD4o12tpP+ytsUVoWKKI9GMrSCTcCIEtEZls3BG/3G7UnMu4LHM1s0yGr8kOwcoe4p5S5Plcb1aHE/fbtQrZY7m5ImqlzN3DQeUWa9vmt26sCYWAUbRyz5LC2hSwlNOC3D1vMUdFqXE64K2WmrL+9nRKDhNsmoP+hpbKgCALh1dckp5p6wO6qoel+A49FOmoRC8lA82vDYACBEh3FHLjKBld6JVHWQG9akkcpdsdFkjbxsuENTLL/E2RJbJFDGFiJSYZbtI9DtrR7GaRVAhYKJtG/S5/E/EHQ/xjm9AMvX+ZCFtH+JXiHDPadQ4mxflTOypsZPGDJNP8o6Xhh83bKJomtT6OdhLIA0JdU1lpdiE8z0RyzY3CQiB2RP/fBjT66L0s9X3TDUg2L+NMISk0v3MZGTM/uWxmB3w8Dfcv0xEBdZNVqFAZ2fQ7j2BHDBkxVTYQlYk/y+/qQwGpaZ3Rv6RTW/w2dYzhVleZ2B+uEs11/0Qw7R5zYriScR6spj4Him1M5xZbLucgdrHprFTqxoVujiyzX43bNZ3rlztJbzfyjOZleo/jQvHg7b5+onXMOxkvBIEc3SYB2iEXcesk3Ohi4kPSLLahC4VZoOanP/tri4aje1jg3J1KdJM8d7ZkhoxwoYlzQdYvw+I7Vis4FTwWXr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(921020)(261026121527099003)(10067099003)(11063799006)(261022115727099003)(56012099006)(261009221227099003)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lxx8BGOP10UbZjll4e61mhAFRsWnwZVDI1CDZ02LAGjJBfe3sofrOZJI/s5Q7dt9QfzR7LQWWRYbUrZ8HqBpuzGTgdel0SD55n9gps+pHPtDdvf4KU8Oh9BQUrC4wgY2OuGIQdzogdvef1IhUgTMWpb0UFjU+Q9jy7mawCKgDrfYQlKM0lAvnF9t+g+4KfD8JKRUwhmAl2xJCA5Qm3wac5qm0k99O016Yoq1+rMX2sfJl9GZggX6JnGbpoKkZy7CSgtbXIx4S+USQAGGult+TZfLOWS5BwqdDX8KOglLeI3URU7RKYMFrf/gJC7FSw61LjRWKIpgcY+uDVx8rIt/+Hm7ZEBa/DGj94KBLH0xaR6c6m35xGzdPKzEDH7P7B/+7/HkqeOh8urvZbM8KuDHppIfHGjc+GJoZTkmUiaRESaCjX7oGnrV974vcGyzZGDQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:50.5896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da2690-e20b-4aec-c39a-08df4c626ba5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Add the default-disabled AMDGPU SVM configuration option and build its
core, attribute, range and fault-handling objects when enabled.
Register the SVM ioctl and connect context initialization and teardown
to the compute VM lifecycle.

Route faults through the SVM handler when the VM has an SVM context;
otherwise retain the existing KFD fault path. Keep disabled-build
stubs so ordinary AMDGPU builds do not depend on SVM implementation
objects.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig      | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/Makefile     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 23 +++++++++++++++++++++--
 4 files changed, 40 insertions(+), 3 deletions(-)

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
index 8687afc00c24c..ad84e57115428 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -330,6 +330,10 @@ amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
 amdgpu-$(CONFIG_ACPI) += amdgpu_acpi.o
 amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
+# svm support
+amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
+	amdgpu_svm_fault.o amdgpu_svm_range.o
+
 include $(FULL_AMD_PATH)/pm/Makefile
 
 amdgpu-y += $(AMD_POWERPLAY_FILES)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 541f02ab4d420..97059d12eb0a6 100644
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
@@ -3124,7 +3125,10 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
-	DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW)
+	DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl,
+			  DRM_AUTH | DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_SVM, amdgpu_gem_svm_ioctl,
+			  DRM_AUTH | DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7b77577aa5621..8831eb7c7cbc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -45,6 +45,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_svm.h"
 #include "kfd_svm.h"
 
 /**
@@ -2725,6 +2726,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r, i;
 
 	vm->va = RB_ROOT_CACHED;
+	vm->svm = NULL;
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 
@@ -2869,6 +2871,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->is_compute_context = true;
 	vm->need_tlb_fence = true;
 
+	r = amdgpu_svm_init(adev, vm);
+	if (r)
+		goto unreserve_bo;
+
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -2942,6 +2948,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	unsigned long flags;
 	int i;
 
+	amdgpu_svm_close(vm);
+	amdgpu_svm_fini(vm);
+
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	root = amdgpu_bo_ref(vm->root.bo);
@@ -3211,6 +3220,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 {
 	struct amdgpu_vm_update_params params;
 	bool is_compute_context = false;
+	bool use_amdgpu_svm = false;
 	uint64_t *dst, flags[AMDGPU_VM_MAX_LEVEL];
 	struct amdgpu_vm *vm;
 	struct drm_exec exec;
@@ -3230,6 +3240,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	is_compute_context = vm->is_compute_context;
+	use_amdgpu_svm = !!vm->svm;
 
 	if (is_compute_context) {
 		__label__ drm_exec_retry;
@@ -3241,8 +3252,16 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		 */
 		drm_exec_fini(&exec);
 
-		if (!svm_range_restore_pages(adev, pasid, vmid,
-					     node_id, addr >> PAGE_SHIFT, ts, write_fault))
+		if (use_amdgpu_svm)
+			r = amdgpu_svm_handle_fault(adev, pasid,
+						    addr >> PAGE_SHIFT,
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

