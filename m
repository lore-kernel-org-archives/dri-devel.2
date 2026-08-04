Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC21C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDEE10E966;
	Tue,  4 Aug 2026 09:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EmWPhOCL";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D6810E968;
 Tue,  4 Aug 2026 09:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXYiVWHzV1WMHa5CnLNmkpBEWRg5r304oYppnaJHL/kjdllklWENq817ZDUATlvc+AZ2WJ4wlcsyfpXO6yu9lV1dcRVK3fVmtkDzrWn8Fi5IiH8UrWg4aV2ljZyOSFY1ImJTBLCgvlKt/wXsDhDwaVL62c7bBIezqmcnaEkdeLinz7F2HwMaRxHVnWjJpsji3aoXm844hcGZCTiG3WHl1HyNbgeKATDW0ytmkEOsSrkbEPeeu2ggScSx+HplsEYqZZuOgjATA/S2lgkeNF6UTVBh0uh/1WB4v7VcBX/DFLSHGaTRiIYoVhrt/koMBqlBUqWNhNNRYYXWRlkdcTJYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFkb+Q8mQX1abki4hoLu/S4GpLvZbJ/PqVLW9GYT4Y4=;
 b=YYOwGrGNZoBZBhAcbUwYOz/aWrCPWMX2MZPn6D6IbfcGi+nPpgGfi76Io+xTBePLXhLvlGgnPC7WYzzW0EDCRI/enKg9ByEeQNq4X3No9VqWncxHPeJpVsNfdXlcs09hXvoKiNvAyX1pgqif8rmza35Qh4d5K/kndCJC/mBnQ0pExK9GaMp/eF57QZEMjq4bMd0U0i36fJcjsPHInYvcypK+QeUJFk9uGnvjPo5lyUUsmR/G4sF1eHskpF95i6Z3vsMa/seHRePWmQ+GDhWCLhR+2SQyKRts1Pi2fAkkLnf550b3CTRmff7uczWONNy8uS39ceRz3xlWCbDHpDgAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFkb+Q8mQX1abki4hoLu/S4GpLvZbJ/PqVLW9GYT4Y4=;
 b=EmWPhOCLE5z/5Rlwb2EAQ1AEXyls1LBR2lqO+tD6CxDXYbh2QCXPnhLHa6NXhqB/GsbgL3YeWQT0UPBy7uh6N6g0nrKpVzIOAsTGrs7SnRXiJclmlRwKC4up/ZnIJqb/nWLv2cTLzGarsim2pzFxY17+tuBo/FcoCfUB3gDo37k=
Received: from PH3PEPF000040AD.namprd05.prod.outlook.com (2603:10b6:518:1::58)
 by PH7PR12MB9150.namprd12.prod.outlook.com (2603:10b6:510:2eb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:43:32 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::3) by PH3PEPF000040AD.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 09:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:43:32 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:43:27 -0500
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
Subject: [PATCH v9 06/18] drm/amdgpu/gmc: add get_svm_pte_flags callback
Date: Tue, 4 Aug 2026 17:42:32 +0800
Message-ID: <20260804094246.1719318-7-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH7PR12MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed01e05-5d33-480c-03ba-08def20cd8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|3023799007|18002099003|22082099003|56012099006|11063799006|10067099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: jHvwQeMKRPCI/mqTu+EdawPrDBUtMN/r3UqV+fv4mn+oI6XPuuCTM02KKu2ncSNa3TMI48qKDnfSbTkhk38qdLey0pdHpHlkqMUL+1TJY0Gt+kRvc9k2w9yqjT+zi6jYI6mq91D6s/aAA4Hq9/G+MkwVX1NYpkJFgXovY0/Mr891wr60vNPg9O4WK46PFvXxKinUPcF+dwOnBKDsNVdSBL2i6nAnzmPn+2lP0OyCfLAHW8K2hkwf47oD/iwaEl44cZgTqkQnxgocGVG8VOEZRDgINF0RD2E71KHpf0bi2jxMJzr8OBkUijpfRhEnBlq3eRYOSGW64nZAfqWQc7EbibFAiHVC4mkI/QhA1ZV8ef9Nva4PosWyfXORpgmIItwvdQOXwndnVHsmNgXHJhlddmjkWiBVgN3GZ8XEbtUTksGrtcI54r+zo4iBeyRespzTqNn+euLrlKmd0gRZORW1GYLWlQdZKVTOOFkwm4hOEGbC1gMPV+seFuhpZD7wPUouer7NPBhmQzowTh4CiaUo/WUAi0V2nf2YK380y//+VadNPUM+8Q0XGDQzS/xeeIaovn+jn1123H4/2gfL4y+CTm6kZDurOLkd/TWNPsvRcjvUkD9oIJG0ILL/5bE8EU3KQkqvK63lCQ8OVJVuzVGHmQ/+a2uVQP2+cZ9gCsIzAlscn4H+F9FFqP98ACRKAjJGBxVP0iWsGe8tDnYSeFv+WZOq6bi195Ltj9aeHzquqq3Zl6GqVqdclVQwcljm4pxH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(6133799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FdVj5D1jVWk0FV9ul5BSxtqFXMy2GHZ059BpRVrmpoZVBQ62C9g67X2h2uctOz+w4n+M84M7V963E8LpZRZemAOdkuch5qCzpz5cbg5sdd/3A+9qCh24YF7HVQmS2ZUXVh2indHzIsTqQGosDS/VwZxp6TAcg2jDeh2GaByQ6RPq7hVDFoYp5Fz4s0o1zzpoOI2DFnYCmZ+ZG/p2S4Lamyc1m8RL3fJK0RZ2WUup0PNDqk0SJNnZwvrbWXly0h9/Q12cS/wrtSYPGeOgD3BQ7HteTQ/CFyb8/lJ/7jkEnrawXyHspIudC3lh5lgFMVU9tA4Cc8FSuP12YjI3447O27B5wi3mNpHwC9lfg4oz6GRFxeO4M51/czwW49YwXku0gfVobtyMEq+oU3UbuK0yvTARV2LYAbHF29+AxuXgLD9P8ATDGscVKf0xYSysBp/w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:43:32.1740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed01e05-5d33-480c-03ba-08def20cd8b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9150
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

Add a gmc_funcs callback for computing the GPU PTE flags of an SVM
mapping, plus a HW-agnostic input struct (amdgpu_svm_pte_flags_params)
and the amdgpu_gmc_get_svm_pte_flags() wrapper. This lets the per-IP
MTYPE/PTE selection live in the HW IP specific gmc_vX_0.c files instead
of the SVM core, mirroring how get_vm_pte handles BO mappings.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  24 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |  69 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 119 ++++++++++++++++++++++++
 3 files changed, 212 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index ddb0d500e0faa..448cfda67719d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -147,6 +147,24 @@ struct amdgpu_vmhub {
 	const struct amdgpu_vmhub_funcs *vmhub_funcs;
 };
 
+/* Decoded inputs for the SVM PTE flag selection, gmc_funcs::get_svm_pte_flags */
+struct amdgpu_svm_pte_flags_params {
+	/* SVM attribute: coherent */
+	bool coherent;
+	/* SVM attribute: extended coherent */
+	bool ext_coherent;
+	/* SVM attribute: GPU read only */
+	bool gpu_ro;
+	/* SVM attribute: GPU executable */
+	bool gpu_exec;
+	/* mapping is in VRAM local device or remote P2P */
+	bool is_vram;
+	/* mapping is in this GPU's local VRAM */
+	bool is_local;
+	/* remote VRAM BO is on a GPU in the same XGMI hive as this GPU. */
+	bool same_hive;
+};
+
 /*
  * GPU MC structures, functions & helpers
  */
@@ -175,6 +193,10 @@ struct amdgpu_gmc_funcs {
 			   struct amdgpu_bo *bo,
 			   uint32_t vm_flags,
 			   uint64_t *pte_flags);
+	/* get the full pte flags for an SVM mapping */
+	uint64_t (*get_svm_pte_flags)(struct amdgpu_device *adev,
+				      struct amdgpu_vm *vm,
+				      const struct amdgpu_svm_pte_flags_params *params);
 	/* override per-page pte flags */
 	void (*override_vm_pte_flags)(struct amdgpu_device *dev,
 				      struct amdgpu_vm *vm,
@@ -376,6 +398,8 @@ struct amdgpu_gmc {
 #define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
 	((adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
 					   (pte_flags)))
+#define amdgpu_gmc_get_svm_pte_flags(adev, vm, params) \
+	((adev)->gmc.gmc_funcs->get_svm_pte_flags((adev), (vm), (params)))
 #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
 	(adev)->gmc.gmc_funcs->override_vm_pte_flags			\
 		((adev), (vm), (addr), (pte_flags))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 84c93364d2201..2e599c0212748 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -548,6 +548,74 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
 }
 
+/*
+ * Mirror of the GFX12 cases of svm_range_get_pte_flags(), with the
+ * per IP logic kept here in the HW specific file.
+ */
+static uint64_t
+gmc_v12_0_get_svm_pte_flags(struct amdgpu_device *adev,
+			    struct amdgpu_vm *vm,
+			    const struct amdgpu_svm_pte_flags_params *params)
+{
+	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
+	bool coherent = params->coherent;
+	bool ext_coherent = params->ext_coherent;
+	bool is_local = params->is_local;
+	bool is_vram = params->is_vram;
+	bool snoop = !is_vram;
+	uint32_t mapping_flags = 0;
+	unsigned int mtype_local, mtype_remote;
+	bool is_aid_a1;
+	uint64_t pte_flags;
+
+	switch (gc_ip_version) {
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		mapping_flags |= AMDGPU_VM_MTYPE_NC;
+		break;
+	case IP_VERSION(12, 1, 0):
+		is_aid_a1 = (adev->rev_id & 0x10);
+		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
+				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
+		mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
+		snoop = true;
+
+		if (is_local) {
+			mapping_flags |= mtype_local;
+		} else if (ext_coherent) {
+			mapping_flags |= AMDGPU_VM_MTYPE_UC;
+		} else {
+			/* system memory or remote VRAM */
+			mapping_flags |= mtype_remote;
+		}
+		break;
+	default:
+		mapping_flags |= coherent ?
+			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		break;
+	}
+
+	if (params->gpu_exec)
+		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
+
+	pte_flags = AMDGPU_PTE_VALID;
+	pte_flags |= is_vram ? 0 : AMDGPU_PTE_SYSTEM;
+	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
+	pte_flags |= AMDGPU_PTE_IS_PTE;
+
+	gmc_v12_0_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
+	pte_flags |= AMDGPU_PTE_READABLE;
+	if (!params->gpu_ro)
+		pte_flags |= AMDGPU_PTE_WRITEABLE;
+
+	if (gc_ip_version == IP_VERSION(12, 1, 0) &&
+	    adev->have_atomics_support)
+		pte_flags |= AMDGPU_PTE_BUS_ATOMICS;
+
+	return pte_flags;
+}
+
 static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
 {
 	return 0;
@@ -577,6 +645,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
 	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
 	.get_vm_pde = gmc_v12_0_get_vm_pde,
 	.get_vm_pte = gmc_v12_0_get_vm_pte,
+	.get_svm_pte_flags = gmc_v12_0_get_svm_pte_flags,
 	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
 	.get_dcc_alignment = gmc_v12_0_get_dcc_alignment,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8a5c44810ba1e..b85a83ce2ce02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1198,6 +1198,124 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 		gmc_v9_0_get_coherence_flags(adev, vm, bo, vm_flags, flags);
 }
 
+/*
+ * Mirror of the GFX9 cases of svm_range_get_pte_flags(), with the
+ * per IP logic kept here in the HW specific file.
+ */
+static uint64_t
+gmc_v9_0_get_svm_pte_flags(struct amdgpu_device *adev,
+			   struct amdgpu_vm *vm,
+			   const struct amdgpu_svm_pte_flags_params *params)
+{
+	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
+	bool coherent = params->coherent;
+	bool ext_coherent = params->ext_coherent;
+	bool is_local = params->is_local;
+	bool is_vram = params->is_vram;
+	bool same_hive = params->same_hive;
+	bool snoop = !is_vram;
+	uint32_t mapping_flags = 0;
+	unsigned int mtype_local;
+	uint64_t pte_flags;
+
+	switch (gc_ip_version) {
+	case IP_VERSION(9, 4, 1):
+		if (is_vram) {
+			if (is_local) {
+				mapping_flags |= coherent ?
+					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
+			} else {
+				mapping_flags |= coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+				if (same_hive)
+					snoop = true;
+			}
+		} else {
+			mapping_flags |= coherent ?
+				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		}
+		break;
+	case IP_VERSION(9, 4, 2):
+		if (is_vram) {
+			if (is_local) {
+				mapping_flags |= coherent ?
+					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
+				if (adev->gmc.xgmi.connected_to_cpu)
+					snoop = true;
+			} else {
+				mapping_flags |= coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+				if (same_hive)
+					snoop = true;
+			}
+		} else {
+			mapping_flags |= coherent ?
+				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		}
+		break;
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		if (ext_coherent)
+			mtype_local = AMDGPU_VM_MTYPE_CC;
+		else
+			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC :
+				AMDGPU_VM_MTYPE_RW;
+		snoop = true;
+		if (is_vram) {
+			/* local HBM region close to partition */
+			if (is_local)
+				mapping_flags |= mtype_local;
+			/* local HBM region far from partition or remote XGMI GPU
+			 * with regular system scope coherence
+			 */
+			else if (same_hive && !ext_coherent)
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+			/* PCIe P2P on GPUs pre-9.5.0 */
+			else if (gc_ip_version < IP_VERSION(9, 5, 0) && !same_hive)
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			/* Other remote memory */
+			else
+				mapping_flags |= ext_coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		} else if (adev->flags & AMD_IS_APU) {
+			/* On NUMA systems, locality is determined per-page
+			 * in gmc_v9_0_override_vm_pte_flags.
+			 */
+			if (num_possible_nodes() <= 1)
+				mapping_flags |= mtype_local;
+			else
+				mapping_flags |= ext_coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		} else {
+			if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			else
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+		}
+		break;
+	default:
+		mapping_flags |= coherent ?
+			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		break;
+	}
+
+	if (params->gpu_exec)
+		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
+
+	pte_flags = AMDGPU_PTE_VALID;
+	pte_flags |= is_vram ? 0 : AMDGPU_PTE_SYSTEM;
+	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
+
+	gmc_v9_0_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
+	pte_flags |= AMDGPU_PTE_READABLE;
+	if (!params->gpu_ro)
+		pte_flags |= AMDGPU_PTE_WRITEABLE;
+
+	return pte_flags;
+}
+
 static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 					   struct amdgpu_vm *vm,
 					   uint64_t addr, uint64_t *flags)
@@ -1315,6 +1433,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
+	.get_svm_pte_flags = gmc_v9_0_get_svm_pte_flags,
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
 	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
 	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
-- 
2.53.0

