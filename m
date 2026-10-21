Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865D606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=quBE9W6r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D214B10F895;
	Wed, 21 Oct 2026 03:00:12 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1DB710F88C;
 Wed, 21 Oct 2026 03:00:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/LCnAscxHPrfkd1N0cdhDusjHfkiBj5gl13nz+lYxS4xpetWhAbsFPYBXDjguROy70vW49mADecHr8g8truuyePawOJ0syHR2qYrnH7MEG0mVGD3ztrAw8oP2DaKKPp055WBnjG6dZTUk/2MbbiLAgkAcNh0uWswfPiF10S5b0xDodAYGFmyxG07z5QL0lDfA7fyvYtRpHYRcoHCkQNHfdBaC2U5vVALP2qID9SsLd+D4ZJ+H8KKswIFyoItBFX3twe+NFlxCQ4ODrg28/1coEVfQda6f8TjTo7S81v/fr/n5Gky20HuuLYoXeJ2kUJDXXF3FpRUczYdBbBpdbHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNBl0da0AtgwuEC2X9emSmkCBFYxa0d8PGxjM1OBLhE=;
 b=bwgiwDQSobVJN6Pc3mmudXD47KqlOviKAc51/XZXp9+dYXBfg+BD91DRXPAFWax1M7NWlqrPKZDZqX50/N7/EKkXYL0me+SgAiK1Iyd7ffOOnRiRWSu+AHhgJ6xZbQpoRftHLWKOlvGgARP4ovHQ5VGG7R2AR/Z1ts7dhy4VzaV4LPIfmELnW4RSnoS3LP3rvsd/7hkSLoVhEvJlzJbCvMZ+tlNMuo8ObB3f+FWocSh6gcFnJYPJXUNwJ3OA7uUclSJywn7beG9DYTENqNZTGW+pIwDVDTMjBZBT5WqWEBANIy0ayH68siifxTmv0OrcXkFjjcKg5bEPDPvrlclaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNBl0da0AtgwuEC2X9emSmkCBFYxa0d8PGxjM1OBLhE=;
 b=quBE9W6r7mK3KnjqEUbYSOeAPC/tIaSqvTJVmGTtSXzjJzAAYsZypeazbq4U6+8StWu3XYS2jFoLcIfojxeuP3PNdQzk0MlL4GfCq7HBYrF3w54JoZQ8ii2h9HwZsyAZiHUNxvXkLN5dobqpitwJf2vi2Fd2Crzn4yKRUTTwZwI=
Received: from SJ0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:a03:39e::34)
 by IA3PR12MB597905.namprd12.prod.outlook.com (2603:10b6:208:53f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 02:59:58 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::7) by SJ0PR03CA0299.outlook.office365.com
 (2603:10b6:a03:39e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 02:59:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 02:59:57 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 21:59:52 -0500
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
Subject: [PATCH v10 06/22] drm/amdgpu/gmc: add get_svm_pte_flags callback
Date: Wed, 21 Oct 2026 10:58:45 +0800
Message-ID: <20261021025915.2433837-7-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|IA3PR12MB597905:EE_
X-MS-Office365-Filtering-Correlation-Id: e857411d-d476-4ed7-7007-08df2f1f63f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|921020|261009221727099003|56012099006|11063799006|261009223027099003|261009221227099003|261009223327099003|261009220027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 3ZVlBk6mMtJOh5f0Q97tuMVPEi2YAAMwByowm0rIvsPhL88JlpBe9ezmJ9VzsO2sI/yS/2zOp1nMo3DW1BepcC/yUi9ARiq6TvsYelLQaPBY/Avxgue1+V5W96G6ikjdaqqkjr1T45gO+CCITxNCKjj7RAEeZk3zjUHBwbvtaC83pfb19D8SGB4E7OpI0XsUQXh0b+7tm3AhLds7XdkUciGwm9ZXCNfvU6NmnQej7AtWHdRnLgAT30uoh39ZuPRYh4qCu6dViTlfF8mDwn74KIj8iphCsNTKvLFUJYiT5Zs1f5gaMvMZrdFooZs1b8OGyJqMZqgWFt+tzVspb07mHU8XAv7eo/9YV3QnwV0UJZar1yh56S8gy/iXD5o6pnZKHo5cVpLczlb1hxKJ8UW69piDvD2hcDCYqFCohYnnvCePFBdwxUC80u64RFTOKsMkzmCKLorcjKlUkqYMO6vyc75ZjklbgtGedjDfOiYVnGOFyK20jqddpeioG1Jkan5CC1AyjzFK7kBoabf41hvsNoe219gMmNJoIOn9Xi6UA9U2jb46rkfBfBJYB3z6Xn3BVZQu0sov6gJPqMkBoHEQ3Za8rYoog0PiAc9tGVLiJEVCKN/FFXI5EGHIIa1eQOltgZUDabPSYNeScK8yeza1M1ybHIrjvjtTo13HLQZXtfW3u85ZLFWuJHuOzTogBwlgHWaTeBbfAauEbrQmqoQhMuuev4770Qtaifn6vy29709yQJPSNovPAgkKF9Ld9BZR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(921020)(261009221727099003)(56012099006)(11063799006)(261009223027099003)(261009221227099003)(261009223327099003)(261009220027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2KA5E8UOLLhH5ks6TwWLhpeG20uu1Nzbk3nA0Ly0lfYIj80aEy0ZNd3kwOz0llFrNFbVucIdoq9/Ope+EdDlWBnu86TJHNnXD02zBBfKdDzNeawcn4bBop4LQoQJ0qZK3QBRMECO0HX9PNeYNEbuuDfpYX3dLP+E6YhOrV1un5ELHVdf3kQ1gE3sPPdJIBv37kcq0SXEA9KJ4WCKI5PshTeXGYDmZYzkLpao4zg4jUg2kgVudsZUXLO9mtCgbsrLt6LEB5flpEbQDtBGUtRMoTe1XIQ9mngHXc9cVifN3HbB1Lju5aMAqfLSe4/qYZJLZq+XTDy40/kT5gnG5fAYev067ppLuQGqNIdJTvsYOB7DX7A17638wjnt7+YJmM38m5BvahaRwE5uzE81fxapMrxUpJxJw45Tvx4RlO7O17bsyT4mLYEhVw5eqvcDDL1N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:59:57.5811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e857411d-d476-4ed7-7007-08df2f1f63f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB597905
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Add a gmc_funcs callback for computing the GPU PTE flags of an SVM
mapping, plus a HW-agnostic input struct (amdgpu_svm_pte_flags_params)
and the amdgpu_gmc_get_svm_pte_flags() wrapper. This lets the per-IP
MTYPE/PTE selection live in the HW IP specific gmc_vX_0.c files instead
of the SVM core, mirroring how get_vm_pte handles BO mappings.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  24 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |  69 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 119 ++++++++++++++++++++++++
 3 files changed, 212 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index cffd5ca3fc66b..3f668fb71a632 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -150,6 +150,24 @@ struct amdgpu_vmhub {
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
@@ -178,6 +196,10 @@ struct amdgpu_gmc_funcs {
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
@@ -378,6 +400,8 @@ struct amdgpu_gmc {
 #define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
 	((adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
 					   (pte_flags)))
+#define amdgpu_gmc_get_svm_pte_flags(adev, vm, params) \
+	((adev)->gmc.gmc_funcs->get_svm_pte_flags((adev), (vm), (params)))
 #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
 	(adev)->gmc.gmc_funcs->override_vm_pte_flags			\
 		((adev), (vm), (addr), (pte_flags))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 0cc73982ed6f9..a541173e34a4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -551,6 +551,74 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
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
@@ -580,6 +648,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
 	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
 	.get_vm_pde = gmc_v12_0_get_vm_pde,
 	.get_vm_pte = gmc_v12_0_get_vm_pte,
+	.get_svm_pte_flags = gmc_v12_0_get_svm_pte_flags,
 	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
 	.get_dcc_alignment = gmc_v12_0_get_dcc_alignment,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 633772fa71fda..a3a5fa048a393 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1199,6 +1199,124 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
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
@@ -1316,6 +1434,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
+	.get_svm_pte_flags = gmc_v9_0_get_svm_pte_flags,
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
 	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
 	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
-- 
2.53.0

