Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE2606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J6LAXMR8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF3010E4D9;
	Fri, 27 Nov 2026 08:42:14 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E464E10E454;
 Fri, 27 Nov 2026 08:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDvUznAr9FXEnmnJc6Tut8gaGogLn/SIh3vwUi3jtrziDcPFO8g7/8xEkznA0khJ/vzHPz3+9qoqo0YwpwcJ+hF63SY30SWVDtrdXvu7KpQdhldcqj4/Bp6z9+MNbaDvMPPBE0YMWqpVJYG/rdZGcqNkgZK2cT5XAp2XKFlpD0jjLk/sC6xyMSQl5IKBTkDgGG5WGUsSOzNhFr3H6WqJaG7ZRdpz/WnGLc1rCDDMDPJkwtdp190PiDTxQZm1PpT9oz+dV5+qPLZ7Nrn14/Hjfasu3YgDZIUHpDE73eD4buNb67pVE4pFKmUNol+KCsaPiOQQfAbZR/JcVrgTb1Av9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEFPRFU88bE/nTv1if7ysAegem9Brkz7LNIdFq1f39M=;
 b=dpbpRhfkYw7kCrZLq9kxdNK0GH8zORAyd878ttoFSMGhqCXFCanhqNTkCnEGMJAVMK/7P+koKf4uuGIxJaadu/D5D9xKBFWei8OyG6/mkxD4FfruCDHn4hAaDihtinbnJsm4aDBIuwDO0HPpAEkJTQH6k09nFamNoBVp+taBIIeaVSgz595hIgKZHydx3zpM+HT4LNiXtBkc0oWMgQpXgjeiLac124oM1tggKK0HJHXDHB8htokH3XxjLB/Mzpojdw24gqiVncAXWtigtqXrtF4U+i/joIgolh6/px7qHaIgrAHPs3l5jo9g3KJ2BslB/nfjGoTTxML4gymhLefCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEFPRFU88bE/nTv1if7ysAegem9Brkz7LNIdFq1f39M=;
 b=J6LAXMR8tw6A1/AHeisdcPGnTCcUl21+jdrH6MaVvP7X9Lem5Sr89aknJwF0mNZDvpUkYO2ezNcpe9EAWDz8Q9eiR5OvHE/+7JE6J3rko1A4Lyx+Lo97FJNmrAMuWENM96OJHzTwZNg5Mpu9KQmTqJrqYeXUZSi5IiY/0itJXc0=
Received: from CH0P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::9)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 08:41:56 +0000
Received: from CH2PEPF000166BE.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::58) by CH0P221CA0008.outlook.office365.com
 (2603:10b6:610:11c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 08:41:55 +0000
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
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:41:55 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:41:50 -0600
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
Subject: [PATCH v11 01/22] drm/amdgpu: decouple PTE encoding from buffer
 objects
Date: Fri, 27 Nov 2026 16:41:24 +0800
Message-ID: <20261127084149.925625-2-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BE:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: fe07e171-8cb8-4df0-8b63-08df4c624ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|6133799003|18002099003|3023799007|22082099003|921020|56012099006|261022075727099003|11063799006|261026121527099003|261009220027099003|261028144727099003|261009221727099003|261021123027099003|261102123227099003|261026140227099003|261009223027099003|261021121427099003|261009221227099003|261022105027099003|261009223327099003|261102130727099003|10067099003;
X-Microsoft-Antispam-Message-Info: rycRVDjbpiL9tb3BHDjzrRh+28zEZUdnTO8QYfwYzUiIRNqDsGHAh0hY5FyqQ/iPmuqj6NcSJd9KeDKkxOCRTEmuGyu4OBdCC0lumRQ5zsAbN8RTm1tNPOP0z5y442sgxDVgjQq9ZsNzL613euGKPtNS2tBOoFQ5KiiJnFo1Nd5kOqYi/tfpxO1kJJdDM/wOgcEp/E35963RKx0frVhtbHsI0Zaj5/Y1FpLrasXrD1KYpMmqDj55C7ADG8b/ZYO8jw4aRldNuQWQazbwGrXbLPD6ieasud749a01AFWZBDtWPIT52ztvy6tzatVJ05m+8HBj0MyBkcu2a461ky8TEoE/yZ1Ax41YWhHG2hsCTt+vVaw6zM/fG3IVckA00yjih61Oh9QxDadvnQ1VAg7n1Z4f/YsQ6MnGvApK1+JVfVgawf7J5fjIrHaC4DBzoQKF+0Jzkf0NsFgtNjopM1bLfS5+7eIOFHXZ2FK/yYlR5xN370fzHRUOOnRXmBK7HL1lyMWQ2RRRec6iOBGk8MuWK3mL2O38IkvibhfWrBcr1H8kXXi7nKyE2DCs8PI/X033zaBCfKXDsXdbQ5WIGEE9k3ET4miPSbql/TEsiXjv4EjyoL121LnC1fzBrznaT69RzZsTn4Mt1YIuQswhxggceg8oFjM77Q0hGf0kNq4yhwcmqXHdELnwu5Xfd0CjDBMUpMSPje3PrpEyXsfXxTgZK2PCWV2oYwX5Yn3g7EcFSp8JRtvVzQ6xlje/1E6Xew60
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(6133799003)(18002099003)(3023799007)(22082099003)(921020)(56012099006)(261022075727099003)(11063799006)(261026121527099003)(261009220027099003)(261028144727099003)(261009221727099003)(261021123027099003)(261102123227099003)(261026140227099003)(261009223027099003)(261021121427099003)(261009221227099003)(261022105027099003)(261009223327099003)(261102130727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PzPTsN4Kc1nGzHmX637p2YM8cYuYmZ6dKgb3OSCCXc3UcY5t5wXQMCggxz8SUwF9kV0S9BZQM8VZ3YwCSetF+I796GvqKgRswOR9F3Qktm1xPaXgtisn06Ky5Ckzgj98PYCuswnA7Dym1JTm3wSJYeAWrer/BQt7O0VzXG0xjjDkjPcJjcQHCJFDEVuSr6YYydNibD1I56Cn1/7DEPviXzuvl5zrPG+O8hcFTHTaIMIZdT391/vv0OvuutC2phZ0ahzNsdJzg+wSD0rYhPWpVNwuG3UB+v0bPkOclHwg8maEXKStyoiiUncy5PMyzPwT/DYiUqoSDEjwgpSYAcpsysmTxADU9ny8/OWgHPn8+yrHIaWvgjh9WDJ/Hj6M9ZMmNaJwDsYug46b1f4q1I2lj5R9nPiclHxO23bTyoABiOoMFjmt5zjJsoAe9vyWlW+R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:41:55.6555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe07e171-8cb8-4df0-8b63-08df4c624ae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
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

Describe backing memory with struct amdgpu_gmc_pte_mem instead of a BO
pointer. The GMC encoders need the owning device, memory placement,
partition and coherence flags, not the BO itself. Populate this
description in existing BO callers and update KFD and UALink callers
with the common interface.

Provide an optional destination address: convert VRAM offsets using
the owning device's VRAM base and leave system DMA/IOVA addresses
unchanged. Existing callers without an address output pass NULL.

Keep BO reservation checking in amdgpu_sync_resv(). The NPA debug
message no longer reports the TTM resource range. This prerequisite
does not introduce SVM UAPI, attribute types or a separate SVM callback.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 34 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    | 24 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 12 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  8 ++---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     |  8 ++---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c     | 31 +++++++++-----------
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 25 +++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  3 +-
 13 files changed, 106 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 08d3ff61edccd..c47d43e1193be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -410,6 +410,40 @@ void amdgpu_gmc_set_agp_default(struct amdgpu_device *adev,
 	mc->agp_size = 0;
 }
 
+/**
+ * amdgpu_gmc_pte_mem_from_bo() - Describe the backing memory of a BO
+ * @bo: BO backing the mapping.
+ * @mem: Output description for amdgpu_gmc_get_vm_pte().
+ */
+void amdgpu_gmc_pte_mem_from_bo(struct amdgpu_bo *bo,
+				struct amdgpu_gmc_pte_mem *mem)
+{
+	mem->adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	mem->flags = bo->flags;
+	mem->mem_type = bo->tbo.resource ? bo->tbo.resource->mem_type :
+					   TTM_PL_SYSTEM;
+	mem->mem_id = KFD_XCP_MEM_ID(mem->adev, bo->xcp_id);
+}
+
+/**
+ * amdgpu_gmc_get_vm_pte() - Encode a GPU mapping's address and flags
+ * @adev: Device receiving the mapping.
+ * @vm: Address space receiving the mapping.
+ * @mem: Backing memory, or NULL if unknown.
+ * @vm_flags: AMDGPU_VM_PAGE_* and AMDGPU_VM_MTYPE_* mapping flags.
+ * @dst: Optional address in @mem; VRAM offsets become GPU addresses.
+ * @pte_flags: Base PTE flags, updated with the hardware specific bits.
+ */
+void amdgpu_gmc_get_vm_pte(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			   const struct amdgpu_gmc_pte_mem *mem, u32 vm_flags,
+			   u64 *dst, u64 *pte_flags)
+{
+	if (dst && mem && mem->mem_type == TTM_PL_VRAM)
+		*dst += mem->adev->vm_manager.vram_base_offset;
+
+	adev->gmc.gmc_funcs->get_vm_pte(adev, vm, mem, vm_flags, pte_flags);
+}
+
 /**
  * amdgpu_gmc_fault_key - get hask key from vm fault address and pasid
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 8f0672ed5b67f..37ae9730c802b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -150,6 +150,20 @@ struct amdgpu_vmhub {
 	const struct amdgpu_vmhub_funcs *vmhub_funcs;
 };
 
+/**
+ * struct amdgpu_gmc_pte_mem - Backing memory of a GPU mapping
+ * @adev: Device owning the memory.
+ * @flags: AMDGPU_GEM_CREATE_* coherence and caching flags.
+ * @mem_type: TTM placement of the memory.
+ * @mem_id: Memory partition of the memory, or -1.
+ */
+struct amdgpu_gmc_pte_mem {
+	struct amdgpu_device *adev;
+	u64 flags;
+	u32 mem_type;
+	s8 mem_id;
+};
+
 /*
  * GPU MC structures, functions & helpers
  */
@@ -175,7 +189,7 @@ struct amdgpu_gmc_funcs {
 	/* get the pte flags to use for PTEs */
 	void (*get_vm_pte)(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm,
-			   struct amdgpu_bo *bo,
+			   const struct amdgpu_gmc_pte_mem *mem,
 			   uint32_t vm_flags,
 			   uint64_t *pte_flags);
 	/* override per-page pte flags */
@@ -375,9 +389,11 @@ struct amdgpu_gmc {
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
 #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc_funcs->emit_pasid_mapping((r), (vmid), (pasid))
 #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
-#define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
-	((adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
-					   (pte_flags)))
+void amdgpu_gmc_pte_mem_from_bo(struct amdgpu_bo *bo,
+				struct amdgpu_gmc_pte_mem *mem);
+void amdgpu_gmc_get_vm_pte(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			   const struct amdgpu_gmc_pte_mem *mem, u32 vm_flags,
+			   u64 *dst, u64 *pte_flags);
 #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
 	(adev)->gmc.gmc_funcs->override_vm_pte_flags			\
 		((adev), (vm), (addr), (pte_flags))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index dd0653e6194b7..45654d9561abf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2032,13 +2032,15 @@ static u64 amdgpu_ualink_get_export_pte_flags(struct amdgpu_device *adev,
 				       u64 mapping_flags)
 {
 	u64 pte_flags = adev->gmc.init_pte_flags;
+	struct amdgpu_gmc_pte_mem mem;
 
 	pte_flags |= (AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE |
 		      AMDGPU_PTE_WRITEABLE);
 	mapping_flags |= AMDGPU_VM_MTYPE_DEFAULT;
 
-	amdgpu_gmc_get_vm_pte(adev, &adev->ualink.npa_vm, bo, mapping_flags,
-			      &pte_flags);
+	amdgpu_gmc_pte_mem_from_bo(bo, &mem);
+	amdgpu_gmc_get_vm_pte(adev, &adev->ualink.npa_vm, &mem, mapping_flags,
+			      NULL, &pte_flags);
 
 	return pte_flags;
 }
@@ -4951,6 +4953,7 @@ static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 	u32 dst_accel_id = ualink_accel_id(adev);
 	u64 timeout = msecs_to_jiffies(2000);
+	struct amdgpu_gmc_pte_mem mem;
 	struct amdgpu_bo *bos[2];
 	u32 n_bos;
 	struct dma_fence *fence;
@@ -4977,8 +4980,9 @@ static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 					    remote->ring_bo->tbo.resource);
 	dev_dbg(adev->dev, "init pte_flags 0x%llx\n", pte_flags);
 
-	amdgpu_gmc_get_vm_pte(adev, &adev->ualink.npa_vm, remote->ring_bo,
-			      AMDGPU_VM_MTYPE_DEFAULT, &pte_flags);
+	amdgpu_gmc_pte_mem_from_bo(remote->ring_bo, &mem);
+	amdgpu_gmc_get_vm_pte(adev, &adev->ualink.npa_vm, &mem,
+			      AMDGPU_VM_MTYPE_DEFAULT, NULL, &pte_flags);
 	dev_dbg(adev->dev, "after get coherent pte_flags 0x%llx\n", pte_flags);
 
 	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 792b87ee2fc3c..9fcafed0b598c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1400,6 +1400,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_gmc_pte_mem pte_mem;
 	struct dma_fence **last_update;
 	dma_addr_t *pages_addr = NULL;
 	struct ttm_resource *mem;
@@ -1466,6 +1467,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
 		vram_base = bo_adev->vm_manager.vram_base_offset;
 		uncached = (bo->flags & AMDGPU_GEM_CREATE_UNCACHED) != 0;
+		amdgpu_gmc_pte_mem_from_bo(bo, &pte_mem);
 	} else {
 		flags = 0x0;
 		vram_base = 0;
@@ -1497,8 +1499,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 			update_flags &= ~AMDGPU_PTE_WRITEABLE;
 
 		/* Apply ASIC specific mapping flags */
-		amdgpu_gmc_get_vm_pte(adev, vm, bo, mapping->flags,
-				      &update_flags);
+		amdgpu_gmc_get_vm_pte(adev, vm, bo ? &pte_mem : NULL,
+				      mapping->flags, NULL, &update_flags);
 
 		trace_amdgpu_vm_bo_update(mapping);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 49f593fe2a876..62ce278bc9ea6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -477,7 +477,7 @@ static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
 
 static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 				 struct amdgpu_vm *vm,
-				 struct amdgpu_bo *bo,
+				 const struct amdgpu_gmc_pte_mem *mem,
 				 uint32_t vm_flags,
 				 uint64_t *flags)
 {
@@ -516,9 +516,9 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
-			       AMDGPU_GEM_CREATE_EXT_COHERENT |
-			       AMDGPU_GEM_CREATE_UNCACHED))
+	if (mem && mem->flags & (AMDGPU_GEM_CREATE_COHERENT |
+				 AMDGPU_GEM_CREATE_EXT_COHERENT |
+				 AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index bc3b1ffb54886..36fa9927023a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -483,7 +483,7 @@ static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
 
 static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 				 struct amdgpu_vm *vm,
-				 struct amdgpu_bo *bo,
+				 const struct amdgpu_gmc_pte_mem *mem,
 				 uint32_t vm_flags,
 				 uint64_t *flags)
 {
@@ -522,9 +522,9 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
-			       AMDGPU_GEM_CREATE_EXT_COHERENT |
-			       AMDGPU_GEM_CREATE_UNCACHED))
+	if (mem && mem->flags & (AMDGPU_GEM_CREATE_COHERENT |
+				 AMDGPU_GEM_CREATE_EXT_COHERENT |
+				 AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3bb13cfed92fe..180543b0bbbb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -510,7 +510,7 @@ static void gmc_v12_0_get_vm_pde(struct amdgpu_device *adev, int level,
 
 static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 				 struct amdgpu_vm *vm,
-				 struct amdgpu_bo *bo,
+				 const struct amdgpu_gmc_pte_mem *mem,
 				 uint32_t vm_flags,
 				 uint64_t *flags)
 {
@@ -545,10 +545,10 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
+	if (mem && mem->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
 		*flags |= AMDGPU_PTE_DCC;
 
-	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
+	if (mem && mem->flags & AMDGPU_GEM_CREATE_UNCACHED)
 		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index b676830120026..ef839d6e5cb45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -672,17 +672,15 @@ u32 gmc_v12_1_get_coherent_aql_mtype(struct amdgpu_device *adev)
 }
 
 static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
-					  struct amdgpu_bo *bo,
+					  const struct amdgpu_gmc_pte_mem *mem,
 					  uint64_t *flags)
 {
-	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	bool is_vram = bo->tbo.resource &&
-		       bo->tbo.resource->mem_type == TTM_PL_VRAM;
-	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
-				     AMDGPU_GEM_CREATE_EXT_COHERENT);
-	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
+	bool is_vram = mem->mem_type == TTM_PL_VRAM;
+	bool coherent = mem->flags & (AMDGPU_GEM_CREATE_COHERENT |
+				      AMDGPU_GEM_CREATE_EXT_COHERENT);
+	bool ext_coherent = mem->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
 	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
-	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
+	bool uncached = mem->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	unsigned int mtype, mtype_local, mtype_remote;
 	bool snoop = false;
 	bool is_local = false;
@@ -692,7 +690,7 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 	case IP_VERSION(12, 1, 0):
 		gmc_v12_1_get_mtypes(adev, &mtype_local, &mtype_remote);
 
-		is_local = (is_vram && adev == bo_adev);
+		is_local = (is_vram && adev == mem->adev);
 		snoop = true;
 		if (uncached) {
 			mtype = MTYPE_UC;
@@ -730,12 +728,10 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 
 static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 				 struct amdgpu_vm *vm,
-				 struct amdgpu_bo *bo,
+				 const struct amdgpu_gmc_pte_mem *mem,
 				 uint32_t vm_flags,
 				 uint64_t *flags)
 {
-	struct ttm_resource *mem;
-
 	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
 		*flags |= AMDGPU_PTE_EXECUTABLE;
 	else
@@ -757,15 +753,14 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 		break;
 	}
 
-	if (bo) {
-		mem = bo->tbo.resource;
-		if (mem && mem->mem_type == AMDGPU_PL_NPA) {
+	if (mem) {
+		if (mem->mem_type == AMDGPU_PL_NPA) {
 			dev_dbg(adev->dev,
-				"Setting PTE for NPA BO, mem->type: %d, mem->start: %lx, mem->size: %u, cur_flags: %llx\n",
-				mem->mem_type, mem->start, (u32)mem->size, *flags);
+				"Setting PTE for NPA BO, cur_flags: %llx\n",
+				*flags);
 			gmc_v12_1_get_npa_flags(adev, flags);
 		} else if (*flags & AMDGPU_PTE_VALID) {
-			gmc_v12_1_get_coherence_flags(adev, bo, flags);
+			gmc_v12_1_get_coherence_flags(adev, mem, flags);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index a7c353d1ac09d..e0b5c668a4430 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -338,7 +338,7 @@ static void gmc_v6_0_get_vm_pde(struct amdgpu_device *adev, int level,
 
 static void gmc_v6_0_get_vm_pte(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm,
-				struct amdgpu_bo *bo,
+				const struct amdgpu_gmc_pte_mem *mem,
 				uint32_t vm_flags,
 				uint64_t *flags)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index c09f5153679ea..e946a6ee69628 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -461,7 +461,7 @@ static void gmc_v7_0_get_vm_pde(struct amdgpu_device *adev, int level,
 
 static void gmc_v7_0_get_vm_pte(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm,
-				struct amdgpu_bo *bo,
+				const struct amdgpu_gmc_pte_mem *mem,
 				uint32_t vm_flags,
 				uint64_t *flags)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 15592027e7c0c..b6d01aeda2b01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -673,7 +673,7 @@ static void gmc_v8_0_get_vm_pde(struct amdgpu_device *adev, int level,
 
 static void gmc_v8_0_get_vm_pte(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm,
-				struct amdgpu_bo *bo,
+				const struct amdgpu_gmc_pte_mem *mem,
 				uint32_t vm_flags,
 				uint64_t *flags)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index a705830ef436c..32ad64313cde7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1046,24 +1046,21 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 
 static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 					 struct amdgpu_vm *vm,
-					 struct amdgpu_bo *bo,
+					 const struct amdgpu_gmc_pte_mem *mem,
 					 uint32_t vm_flags,
 					 uint64_t *flags)
 {
-	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	bool is_vram = bo->tbo.resource &&
-		bo->tbo.resource->mem_type == TTM_PL_VRAM;
-	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
-				     AMDGPU_GEM_CREATE_EXT_COHERENT);
-	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
-	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
+	struct amdgpu_device *bo_adev = mem->adev;
+	bool is_vram = mem->mem_type == TTM_PL_VRAM;
+	bool coherent = mem->flags & (AMDGPU_GEM_CREATE_COHERENT |
+				      AMDGPU_GEM_CREATE_EXT_COHERENT);
+	bool ext_coherent = mem->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
+	bool uncached = mem->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	unsigned int mtype_local, mtype;
 	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
 	bool snoop = false;
 	bool is_local;
 
-	dma_resv_assert_held(bo->tbo.base.resv);
-
 	switch (gc_ip_version) {
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
@@ -1122,7 +1119,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		is_local = (!is_vram && (adev->flags & AMD_IS_APU) &&
 			    num_possible_nodes() <= 1) ||
 			   (is_vram && adev == bo_adev &&
-			    KFD_XCP_MEM_ID(adev, bo->xcp_id) == vm->mem_id);
+			    mem->mem_id == vm->mem_id);
 		snoop = true;
 		if (uncached) {
 			mtype = MTYPE_UC;
@@ -1162,7 +1159,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 
 static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm,
-				struct amdgpu_bo *bo,
+				const struct amdgpu_gmc_pte_mem *mem,
 				uint32_t vm_flags,
 				uint64_t *flags)
 {
@@ -1196,8 +1193,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if ((*flags & AMDGPU_PTE_VALID) && bo)
-		gmc_v9_0_get_coherence_flags(adev, vm, bo, vm_flags, flags);
+	if ((*flags & AMDGPU_PTE_VALID) && mem)
+		gmc_v9_0_get_coherence_flags(adev, vm, mem, vm_flags, flags);
 }
 
 static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b2d49876a7800..0d419268d8adf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1409,7 +1409,8 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 	if (gc_ip_version >= IP_VERSION(12, 0, 0))
 		pte_flags |= AMDGPU_PTE_IS_PTE;
 
-	amdgpu_gmc_get_vm_pte(node->adev, vm, NULL, mapping_flags, &pte_flags);
+	amdgpu_gmc_get_vm_pte(node->adev, vm, NULL, mapping_flags,
+			      NULL, &pte_flags);
 	pte_flags |= AMDGPU_PTE_READABLE;
 	if (!(flags & KFD_IOCTL_SVM_FLAG_GPU_RO))
 		pte_flags |= AMDGPU_PTE_WRITEABLE;
-- 
2.53.0

