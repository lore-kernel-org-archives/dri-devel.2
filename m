Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3773C43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 235E6890FE;
	Tue, 30 Jun 2026 08:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J25EOFUU";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C7610EB88;
 Tue, 30 Jun 2026 08:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCLGd9aRwsmrHLzVsWV7HKk6IJMDPPW26fLhHaRM2EY2C1sy661fq6uhbXAiLWkD1e3BbGI7Z34i9oWcIJVTzYAsL88qxIA+kMZiQfLP/7rAFGn6VykNMGAROwPJRCGLba+pNTacu46SmqyY0yGu04pOTDN/xCLRtkT24L3dkNXJujdLIrE42lq+Axh4ZcdOpt+zde0JZkyC8RpmiJdTN5/bzCPfz2AqQhJMDWhnvNRhqpzBJaMPJEAcSjnGX+NOdDUkXObAeiv7JPI03Id9hOqxuzQSFyzJ1ZhM+XwigMhBCfshtAcQC4ywMk4qCNwaGkVVYl5GwUGStYgYDNu1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1Jp7Z0LCldMaZKnPFExtzeBWvBDo+p953k43Wy6gq8=;
 b=hoQ73YDO+gPQXBrW5EXkLd6lf2Djt8HTH/nHyZTmi5E2eBfyHmDpoRegP8AoQBhZRPH+aqNysUJaeM0UMVP30E5sbV/XpMuCVQXfDtomfGEwhIrmlAexnhekPU0xeMYeu4id7Zk1QgCx8+hhf/KM4yGROue5PR2e9J0Z8Q1f4+xv8uAyKjKeGlyFRo4Eg3eH/9YcMoQWZjEKjZT0UYTduIRF7Dy7pxKDEaG3rALuHkvdmsnei08XUsrPatRQGoDgiGzyNiNlxlpwq5VTf6nTPAyYPFi7J70L8jbNkfVssk88FGHAkhg0RhzkflO710QlVD98E7mkbqpV+Y8xgDZRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1Jp7Z0LCldMaZKnPFExtzeBWvBDo+p953k43Wy6gq8=;
 b=J25EOFUUGRDeqlg/Rl3BQxzQVHpe89b/9yQoRjsIH5WGbJSs/UrPzPg+FWzoW3PGZM8c9YPxsaqBaLlXUSBSs+acyXYIJrcsRCSvzoERtV/FSxH/ICEE+EF0RgOZ+k0CtohTTMemKYCWQ1XqrgQGdTnf+afveKyc17AyiZUP2Iw=
Received: from DM6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:5:174::28)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 08:34:08 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::5e) by DM6PR21CA0018.outlook.office365.com
 (2603:10b6:5:174::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.2 via Frontend Transport; Tue, 30
 Jun 2026 08:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 08:34:08 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 03:34:04 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v9 5/5] drm/gpusvm: let the drm_gpusvm core context purely MM
 level
Date: Tue, 30 Jun 2026 16:33:07 +0800
Message-ID: <20260630083307.381909-6-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630083307.381909-1-honghuan@amd.com>
References: <20260630083307.381909-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8aec50-2733-4985-0456-08ded6825a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wmpBU4JhS9b0pzELjiQcQYAl+rYO5TTfmAfSG+3InVTcFhIYga2GHMxyeOKWtQzGR8OpyWnp+M7Wy5wyZ3GjUHkhuXJfuGeIzwIR6DWVLdXr0bf3efZzjjfE3sKUAQiGziAzbhJujaVvScvDeAWwFMrXpO1oyHwNrZDocSymeYuyNlRhivYGwiFvuCyOcg6WabXbe8vSMqGtq4k7o/VUCwuQFvYzvvtuAdbxiCIT5W8iVExUbWlg3o+nOlSWeumLmV7GtERYq7KMYcrvp4pVmipqb8ejb0CwHW3azWG360Tp0X3slHetoYuAniTIJWhNLBuF5G9PwIq3gg0PG+tFJSDwRNsBDtobc+CrC+6hMhpqqO246qgcloIbAN522dVNGlswlz3FkVjTRgzSoyEChtd85X6dWzcmRxoUozJuDlyAcsG+ejv4DNnB8P/EPTyVV/8jJ3eThNx42lUz4hcDmSB4xWB1338HTNZG7fxFwM2KI+T9iUlfHoAOxEPvVDaof0G0l7g98j8g7LVpADaYJ62xVkh9YUhKMySi2SujtvptQqHqqnG6oJoTx/5nDnzRLiYoN8vqe59e/NP0PW8+jXaKlRq1V7ec6lW6/v5GYC3kTJtaDjwKQacwVcLb3ToTv0nNyrvwCHI7Q7ksE06YwDPZlBt+G0V9EuDKBTOzjKgXKE0Tl93IlIsCvSVGYLnJ0MTXi+tyI5Ymd4V6aaSQJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xIi+zdOP8gUgkN7oki3HqOGAwUfkhi5MlSA3Xj0dRPOtjZry6GGVzjhUS0qcsW2+WFelp+fGnUy3Yv5JQ//y67HBAuS4cbfaNpyfkA2q84eUm86UHbtcuFdEjMqGnVenOIx3/VjSX2YwwHeyCjuC9YhcsJaLT57dz4wIs7D3CHgWYhoy8W7KIqGTSnmu3dMRezUkk6jEvc+ADzCNWUq0sR/c155k6/Y88+rLxEuFsoidSsc9o6VBv8oBBVXyoYxT9qQY5iAh7XKsPbwxZaNGjf++VAPRmLzl4daAy4SICtdlgpe3oCVpq2OJPz2Xj+j3S528Y7wn4hcTS3IePImSHsF6UNhvcKR8f+2EMsw7RGvbGV2EyuPN550Exsoj2kpbRr4uctJUGCuPYzsgxQyK+TENQz9mhzXc3c5NVX5/XM2eMuamDZHXtmE6ZLVqFN8m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 08:34:08.4975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8aec50-2733-4985-0456-08ded6825a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551
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

The core mechanism of drm_gpusvm is HMM, which is fundamentally an
MM side subsystem. A drm_device, enters the picture on the device side at
DMA mapping / GPU bind.

So move struct drm_device from struct drm_gpusvm in drm_gpusvm. Let
drm_gpusvm keep its core neutral and leave device side decisions to
the driver. Make drm_gpusvm a pure MM level object.

  - Move the drm_device from struct drm_gpusvm. drm_device now stored in
    drm_gpusvm_pages.
  - Drop the drm parameter from drm_gpusvm_init()
  - Update the xe call sites in xe_svm_init() and other callers.

drm_device does not disappear from the framework, it is
relocated onto each drm_gpusvm_pages where DMA actually happens.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 8 ++++----
 drivers/gpu/drm/xe/xe_svm.c  | 4 ++--
 drivers/gpu/drm/xe/xe_svm.h  | 2 +-
 include/drm/drm_gpusvm.h     | 4 +---
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index e0fd0b2fcc5..fcfe635bc19 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -439,7 +439,6 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
  * drm_gpusvm_init() - Initialize the GPU SVM.
  * @gpusvm: Pointer to the GPU SVM structure.
  * @name: Name of the GPU SVM.
- * @drm: Pointer to the DRM device structure.
  * @mm: Pointer to the mm_struct for the address space.
  * @mm_start: Start address of GPU SVM.
  * @mm_range: Range of the GPU SVM.
@@ -453,7 +452,9 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
  * This function initializes the GPU SVM.
  *
  * Note: If only using the simple drm_gpusvm_pages API (get/unmap/free),
- * then only @gpusvm, @name, and @drm are expected. However, the same base
+ * then only @gpusvm and @name are expected. The @drm drm_device for dma
+ * mappings is bound per-pages via drm_gpusvm_init_pages() before the first
+ * drm_gpusvm_get_pages() call. However, the same base
  * @gpusvm can also be used with both modes together in which case the full
  * setup is needed, where the core drm_gpusvm_pages API will simply never use
  * the other fields.
@@ -461,7 +462,7 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
  * Return: 0 on success, a negative error code on failure.
  */
 int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
-		    const char *name, struct drm_device *drm,
+		    const char *name,
 		    struct mm_struct *mm,
 		    unsigned long mm_start, unsigned long mm_range,
 		    unsigned long notifier_size,
@@ -479,7 +480,6 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
 	}
 
 	gpusvm->name = name;
-	gpusvm->drm = drm;
 	gpusvm->mm = mm;
 	gpusvm->mm_start = mm_start;
 	gpusvm->mm_range = mm_range;
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index d515647192e..3283b74f7d5 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -911,7 +911,7 @@ int xe_svm_init(struct xe_vm *vm)
 			return err;
 		}
 
-		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM", &vm->xe->drm,
+		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM",
 				      current->mm, 0, vm->size,
 				      xe_modparam.svm_notifier_size * SZ_1M,
 				      &gpusvm_ops, fault_chunk_sizes,
@@ -925,7 +925,7 @@ int xe_svm_init(struct xe_vm *vm)
 		}
 	} else {
 		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
-				      &vm->xe->drm, NULL, 0, 0, 0, NULL,
+				      NULL, 0, 0, 0, NULL,
 				      NULL, 0);
 	}
 
diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
index c8f4a7ba0f4..a921556d346 100644
--- a/drivers/gpu/drm/xe/xe_svm.h
+++ b/drivers/gpu/drm/xe/xe_svm.h
@@ -235,7 +235,7 @@ static inline
 int xe_svm_init(struct xe_vm *vm)
 {
 #if IS_ENABLED(CONFIG_DRM_GPUSVM)
-	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)", &vm->xe->drm,
+	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
 			       NULL, 0, 0, 0, NULL, NULL, 0);
 #else
 	return 0;
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 2862104aa1b..b7d987bf76a 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -195,7 +195,6 @@ struct drm_gpusvm_range {
  * struct drm_gpusvm - GPU SVM structure
  *
  * @name: Name of the GPU SVM
- * @drm: Pointer to the DRM device structure
  * @mm: Pointer to the mm_struct for the address space
  * @mm_start: Start address of GPU SVM
  * @mm_range: Range of the GPU SVM
@@ -219,7 +218,6 @@ struct drm_gpusvm_range {
  */
 struct drm_gpusvm {
 	const char *name;
-	struct drm_device *drm;
 	struct mm_struct *mm;
 	unsigned long mm_start;
 	unsigned long mm_range;
@@ -271,7 +269,7 @@ struct drm_gpusvm_ctx {
 };
 
 int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
-		    const char *name, struct drm_device *drm,
+		    const char *name,
 		    struct mm_struct *mm,
 		    unsigned long mm_start, unsigned long mm_range,
 		    unsigned long notifier_size,
-- 
2.34.1

