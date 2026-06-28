Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B35FC44501
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6CD10E5CF;
	Sun, 28 Jun 2026 11:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MkjP+jrZ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3117D10E5C7;
 Sun, 28 Jun 2026 11:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp62MqguUbvdLQt8RKbmZg4CKP5lasG9yA/G+1HII336ZYUAOtT0X/3bOOPTTEI3YrE3A0Iv9d1ZHL+bGZr8HhGT7tqTuWseGTMJ/r4h1I+F9HTqDZC3IQqRm8TTBIaGttfG/wDINH6kfA294KjzPh4BrFM0mrLPGM1yYlBX0rqf+zeR1H4C9OASzvAY06v+SawoSwfLq/KFKPFRscbzC4MQ3fH5LpUqIXLJmA4ANBl0ioniT4758QaDtxU05o4+rEFcLRD6D9j31gSUQCz6/a1FMRrN5seluo0SmPeFIQNXMT/YMJrToWBQcIy5IIslT2x50GuhTasiGxsm2/9mlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLCTAJMW0tWigGt9c2XIkQmpQbrXvm3wN3mV+mzV+4Y=;
 b=sXturZHTIigMoO6vH/ogUfcIXfk9KnO149Vjt9InhBmkKfhzzuu9DQJkbsrTFkGQapiqRvDJeUe3oHx3pQXGcXxDZuRCrJpcWCtjlE60Deh0BAUeeuI0jOPOhhkgejf3/HzhvBSt3JPhs3ekxTd/Qly0CFlyx+Qv7mqO2uL6UhCnJEbfX/7PyVhHi1miDK9SGwB31deAX/VeFrMikGbMat4I9o/bKcWQj/ulIlovUxagyThF8R/pOh1hXgayiMFbLfdSYYVqHIgDFIAHHLMTJm3P/jDdF4rSrXoBtPunkKPm43njAzspaZo0HHT5f8HnrXH3Guym8wZuL2nggPCksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLCTAJMW0tWigGt9c2XIkQmpQbrXvm3wN3mV+mzV+4Y=;
 b=MkjP+jrZleSCUEcgl+PTUZdhp6QwwxnzXKJvBN16wAJ7FQh73QiC2AMXTXVbhSAY8sSnQ8o0Hff6A33dwqlAi0ggpG518I9nyr6m7eYGcauKQJxZWsMtZqobHnTVtinMBWdPSv2QR7g8+h6/49iRAGNR6iRRtD5qQthp/BFJaiA=
Received: from IA1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::16)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Sun, 28 Jun
 2026 11:15:37 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:461:cafe::f) by IA1P220CA0012.outlook.office365.com
 (2603:10b6:208:461::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 11:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 11:15:37 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 06:15:33 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v7 5/5] drm/gpusvm: let the drm_gpusvm core context purely MM
 level
Date: Sun, 28 Jun 2026 19:14:55 +0800
Message-ID: <20260628111455.9831-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260628111455.9831-1-honglei1.huang@amd.com>
References: <20260628111455.9831-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca1d985-ce88-4b00-ad35-08ded50694a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: yr3Dy/rs5saeZUGZteH056IcIUXrapMHdvuckdZunSPbYHDm4a45R/cI2Wv+Mq3pRcj8Lgg/4Cjm5uPATCL0i71mw8zd3+K03LvCJ23aKqRaqnybIaHsLcb2ud8nx6gS7TL/sGTIPJdA8ZtLvT8RaZwyuXI1LwCjxOGMQvtSHnt2+qRNv/VPsi/5oI8S2N3BAL83zJZpB/bV8gRAZq+fk6WZvYM+JDLWdiFClObBBzgqUlZe2p6CpJQABzLkNwdZbbZPf08kLrnmymXMeNt0PY+SjaIA+yddo4xEGUzVwhiBNkUvtuYkbNKgUNHyCh0SNLHRYB3m7s7O7J2/OP9M2735G5732nCAIzSnCTfVbV6sDD4CeL+Xgzuypvb8ufJJMNnXmHTnmyV/uE1q3e+dnr8AK7ShTSGCf0YfakmBWjOUV2pjd0YcqLyo47IDB409txbkwE/ZJUbMP1s8JjsSXBSDr9uwleFk4Ng1xLK6NPWDtQFzyiQhhsHoUHWyuNvrABIkxBS2aLz+lItdLeZquCvUlSeWC7W5myyXuoiE6ur98sn6rse2yvwJwf5B96PH0tBfM+t6iKDTBn3ZKQRUpF1FbPxnbivhvtZuPIxkGN3eIzi1STtX/NVr+F4eT+KrYk7n8WKh5w6WufAvyy+GQHK0gwCLifvAxC5OwH+9UPpso7CaknfWvBsKAd/3WkQVmwKukfeXP/54vmNHo9+oIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3rWRTrdyFdzYLSlaBmwx37X9eqKwMfN6E5utxMupULjWK7U0TWf9/mbMeAoGPA2NkEARGT4MEdSxKlsrsnDC4jhmjdLrYtFZ+ULBTyoIW4/M+IkrXuaOADCtqNTGu5Dh06hQ1HsfT8O4q78ogn24c9KaVtCuP557RRrrfyIxxXnJ7MOWfDL72CiV6foUnYOGSbsb+l3T3NFTZfwNBNf+QS3GKjiZ6zuVlSeQDuDa4CAzFzFX2n/WH8yg//AWB3reI4d8SdmvqRrme2E+q5aaebkLzxpVMgL1tB6j70nA3U5uuE9D7sDMqHdqAT/oODrLMVPLRfTDLpSEqxr7xTUTTcLk1G/7bdd1Ii40ivfUNA3FR03GG2vA7OsLtfY5S+UnMU6KVqqt41aZCiQqBm1dOucYWhxZCJ+woj4IGauRzCiSxC5BpTG5pzW0XuNY8iIq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 11:15:37.2884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca1d985-ce88-4b00-ad35-08ded50694a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
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

