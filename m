Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8747DC43638
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 03:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD15110EAD2;
	Tue, 30 Jun 2026 03:32:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5nTAaW4t";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE4610EACD;
 Tue, 30 Jun 2026 03:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BB1tnvhmg3g8YiG3OBwGefuOW4pujfNo/DmkVGbFfxylL4uqcyO7xATFH08DGWjmIfg1mg/WWMZuABg70Jl0wE2ixVeRyoGMfeZGlPbGsSQ4Agv9Ak/a52VZ6bxFv8WDG4gdh3W3VeF/7VLtauV/BV8ss5fNpF6L7FZpMUIfDgM092RYjXrXTM4nxCAUaVMPUkxKHnfkicr11vOCo2ihFOGd3n3DtEHvjjOe2bOguZdm71WW1EbPu6AmbZsLsvDkHHtHOTtPTUVG+K1GhYNPlWvJaSrnh2ctSPdIufF1jGTPXpw7/KdziW7z46PVGQGBz5Hl/M+DDi6QyfY3QuozYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7wMxMpnvXESuaXJ6s8vdF6r0Hb7tjt4Owp+PUNDk8A=;
 b=lMPdDqmkCTwQqK/RXJHrUzzIXK8otelG4rfT9a4KKtmOXVucggNm7y0fNJQXvRoLZd9kJJ+Rkb8f2m1gLQBpA95duixU9A/RIf+0FzMABTdx/58h+kEspWzU+022MtGMcbIn7mkTbuBDONcWOJ5HjihuqXKEbqQNzyUSoyj66dKO+5BRcrhCfwxwvYlMJwRSV7yk0zxzhEzKHMF19Bs6Iy4N+09QArekxxGUOGpdu2vv9k31i12lWOuiJsHnV8NKXKnf7ylzKEJmGGVty5ne7g8QKaGZ8M4kWC6UGOB4K0RtujBtRxCuZs9OiyxgZKQgU49jD8rK/8xSDZUiKtr3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7wMxMpnvXESuaXJ6s8vdF6r0Hb7tjt4Owp+PUNDk8A=;
 b=5nTAaW4tptV6sGgN8dxQ8k+pGpH1ARY5nyecIIqlxT6sHCpadWHbE7dOAYkvExuDzJ/a8ipG+b4uX7MhQbIdfjPp8WA218Fy3S6ElYYRNMKNaGQw+MdzV03YwsxokLO0RanQVVXcTOCymQz9V6cGDSe1zAicoDYvC4TsmxVAkWI=
Received: from MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 03:32:16 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:237:cafe::57) by MN2PR15CA0057.outlook.office365.com
 (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 03:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 03:32:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 22:32:15 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 20:32:11 -0700
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v8 5/5] drm/gpusvm: let the drm_gpusvm core context purely MM
 level
Date: Tue, 30 Jun 2026 11:31:32 +0800
Message-ID: <20260630033132.361144-6-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630033132.361144-1-honghuan@amd.com>
References: <20260629022921.17533-1-honghuan@amd.com>
 <20260630033132.361144-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fa5829-7034-4aa5-982a-08ded6582e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|11063799006|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 5HwhuaSyBgq/yZpTNs4eS2hUJWNm9pFZYBw0CK+UfnQqR/gmvz/D2PbcrwXV7r4DoyQmC1j3gLtyZlEzjbe9DgR4bBLa+XBMiVNrumTCrD2HalZpdoNGobMC2pZQUa5hHl621d2JR0r2q3CAUkuSK4YSLkBVT4DmsKJUnS1RqVbkWlB1SoxsOQK9AIqWkogBCSoUlxUO+XLg4/LqnEeHEIdsSUzG5Ajy+1QJp0kYicjldpOX5PFVmxUFQqJTos8ZxTpRhAd3i5Gu/3qfWAKnBCT+PPsi0aJKld4o7SVv5nfIznlPSsoTQKb6tw54oblo2+nsbhwprkXm3o6+9IeVt80z8usqc22AqSNu2rj17xhDF1zsWIKY8D/QfFl398AugAjgLQMSnL+4JudOwX7nENjgmNtIMV8UX40lrNnswwA+GjWZFxGMUFBNq0MS9kQQUErx/YInnmlXNaMUFN/Qax4iKXUssrrhEoBlcTVucZmzubCgfn9GmlUqpBN588pA97tOLb9rQ/tdDHuG8rbHwjguE7raswg2h7ElGxhXhlKcxHMFlFCz5NZL6u2fMKg+1igg9HMbvViLESyPSKgdIEk5/Lo0Mbrdj2GAKgljuvRQ9dfgxNrxR3P0gf45qiaBXVCFL9pb/RHALIZzpjXqq/Sxg0qNACvQlttKnO882M7cI6mC3lZA8MERRc1H1F7uygXo/GK7pkM3ePSU+jo6/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lfmGjK9wG+R49nO8cuJv1CAX099YcAGzum7boElIrLobjdi7cxKhp7Y0Y9G3vgDpd1Jh/9ngmR/LZNDXrSOR369IQySx2Lt5o0EajjuNo1iD/0j09t/3J0dYjujOdQFZygjd+EKe0LP6yyYiDjEdxYFY1QxbmYUwUn7n4Af0n9mStjd6yRzh1K1NBvBrcKwuaJE6v4htNAjvBEtOOjiF+el+3N56TILQncN6ei6VcdKgNPbKWTsNFYG1KfJbqII6QOze3qWL0E7xChhAWpp/3V/A7wYyugcHqdYUmnlrKxZvAnxP4a9l6efpzS+i1EPXIlbf6CU6ppCu1kCOxxdrjyJra0FiXcAvsVONg0P17jCmY0QckABg1XoN01irYVyyX6Odqgk9QUcwt0IVzURZKwSA975S8D4mqV4imuzLZ97uZzoLVOr02ERe+ZZjk6YQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 03:32:15.3699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fa5829-7034-4aa5-982a-08ded6582e37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
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
index 1423ab2f1d6..63ea991e2cb 100644
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

