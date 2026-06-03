Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ECCCD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B888B10F90F;
	Wed,  3 Jun 2026 06:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ps7KW8W6";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B2A110F90F;
 Wed,  3 Jun 2026 06:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQhLvUVnIjMlmGVDJOx2kLc66fb4E0MxXn1ySK9cObOxPATiPiKhK1e/D574LWWXD10Q118Zn2/0rWNqH3ZovRZG8Y8pkzZ2kVRH5SwEQsM8cR+ZI7oZ8wCvQ6KfxR+f9nRvMZroHxqRijriU5JWwy+YT2o0NfxmctAt7lOY18DoyAwopKFddDGyfN7eUuXlv9R3F/HlRYicPXFYvfbpl06R7wzTAb7OQKVqzmMl569Z0Qw2UGQDTeGsAEwe4l/i9SN+GC04O+Tluobxoky+OIQMBDeJA65HDtm51YiUsjhhwoQ+Krh+usvsJvGndTdECNOi5lyHW7ZZqkK7TxUZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAcqaTrDRE7FWGNPC0+62tbunfr9GVVrdA8f0Cm10Ho=;
 b=CYxNK6ZbhvVIJBl8KLleBT56CvXnHcQi+naHi0sUx8PovxHzNj9XqQmFilqYQrKHgPtLjsnMCbIS2i9n9L7+58dPpHPEIhbCJ7hA6dhu5vM2nqKmQ07vrW+ypvGu2BposJT5WbO9oHD+rLOWbhWjd3GBTgJBm6mu0NLaSvAqM6b0pJ96vMBHShwGh9uxeepc2cD6fCq/TPkDhoTwYixB+YNq5cpq2RjV2xt4Xz/x9EU27WjteGrZI+NCkPSJepiiTyHEcGiUgGpyDK/bCUcyQH4ZBqpkf/c8OYB+xw1dYreixlWgCnlP3JN4rPwqRYbexolHOQMc2I//0uupJ2pFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAcqaTrDRE7FWGNPC0+62tbunfr9GVVrdA8f0Cm10Ho=;
 b=ps7KW8W61MDg3hy6fwccYPGvK8+GeoYv7Q0z9WVAAobLsSW7iHzH886B48K2CI19JVTWYDK+2L/ir8UiS3MjbXTfl1aqHmu9V98X/U+eOCaiBt53uVrjTAJhzdBX2rm+ciaiaH3QJtKwnLU0brSK8ZT9xpAeJJ88/VR1Qx+repM=
Received: from CYZPR14CA0048.namprd14.prod.outlook.com (2603:10b6:930:a0::25)
 by BN7PPF521FFE181.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Wed, 3 Jun 2026
 06:57:07 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:a0:cafe::3f) by CYZPR14CA0048.outlook.office365.com
 (2603:10b6:930:a0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:57:06 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:57:01 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [RFC 5/5] drm/gpusvm: let the drm_gpusvm core context purely MM level
Date: Wed, 3 Jun 2026 14:56:20 +0800
Message-ID: <20260603065620.2555316-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603065620.2555316-1-honglei1.huang@amd.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|BN7PPF521FFE181:EE_
X-MS-Office365-Filtering-Correlation-Id: 660838d0-97cd-4e4c-4c85-08dec13d5330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: QCjKPYXHd+1JNYlvHi/OkOpU56LfFQTdjQEguyC31gP2FFyTNMR7tykbdo3hp72M/5LuTMSHPZBRWqghFT3nR4S8vFa1v2K03ljBqwKggANneEVFZ3oCB+9n+VvWESe/JslnbLSrEistFMAf98YPzhFgZUFBG+RcOlW9l9Bro6mIRqFG7b0yLqbDnKuh0abKez3o8XWi2//0lgcRLuC1heaZRhavdLRckgxFFujSsCNksh8n/EHzUZwS2sBCJMEFHubLdHf4L8RBUP5NAEFIvg+AhQoC+EgbV5HAEcvGufGlGim5Ow2VlLbQxGqo13JXXexNC1odWOTl08Mof8devG3+e/ah9d7BjS7Z8sZut+LIXv2CybHqOsmkVQbnoX7JKbnwG02SUOp1NHC19uLD78PSrXQqgES7NfC8NYPZP5ZJQ5MPM2JANjr3ZGa7sMaR4ZhXJ/ka99yt9chMwqf2dGQvVkDClSoYS0Cz/HMXdXCDMXf9aywxo4IDuLFlUmkxcv3ymzzesnz0ddAY7fZPqcl7MmO9B9VlK8NLQaRWq7cUbwNe5zGmOMy8qen5rv9R+exPLlZxHDcbvErEuVddsnlyc7i6hzTRn6gmVkBJZYqTJnFc/RnURT5gb5hiVnH2JxIlhjxeUrAANkvW8eFKOOUmxZ6J8MO+I7NaPgz8wrDdquDmCnDUFl+2XWiiVh/5e7hOVFfmMqxy96J85hPsg5aBa20LD5bLDjqmJ5M1a94=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6+d0b4Ksu8dXdpXZ3wSYSnicilpsO1YSPrbwH1HuJ7VvcqhyC5gQBxccbM2Lmz8sy3I7cR82PrzlhiHoTd9AWyh/ywOpnxFUmKXK7t5d5Pgh8b7fhuSqlRk2QGCwT/ZBsXPO/t7CrSMRwPBlTC/xOjp4KxIoAXO3e5/gWzF4KaCd8DJc3HrRnPG8khwHh3/kmxVdnEAqaRdkhBg1emZ1/TomvY9sN1FHwGJzlCmRbO7Fmppv3Zx4DfTPcKiCj3eKMnmv+HarHe5ehDlQmta1Mq18Zq+m7UZjnOy5EVvju3aeejeM1xp6+By5/3/4d/gH3uHDgiDtejQcnHDWNGw8ua5A6v7sjcSpiFHzhUjrBc/seMaZRuvrFR0/u1pMhubR9+G4w6TVaBUrr1g2gnLq0eAncXd+F0bInN3P8bjoeLQW2isB49QKIiYeYk2k3eyk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:57:06.5141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 660838d0-97cd-4e4c-4c85-08dec13d5330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181
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

So drop struct drm_device from struct drm_gpusvm. Let drm_gpusvm keep
its core neutral and leave device side decisions to the driver.
Make drm_gpusvm a pure MM level object.

  - Drop the drm  from struct drm_gpusvm
  - Drop the drm parameter from drm_gpusvm_init()
  - Update the xe call sites in xe_svm_init() and other callers.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 7 +++----
 drivers/gpu/drm/xe/xe_svm.c  | 4 ++--
 drivers/gpu/drm/xe/xe_svm.h  | 2 +-
 include/drm/drm_gpusvm.h     | 4 +---
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 55515390c53..5cade46234c 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -359,7 +359,6 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
  * drm_gpusvm_init() - Initialize the GPU SVM.
  * @gpusvm: Pointer to the GPU SVM structure.
  * @name: Name of the GPU SVM.
- * @drm: Pointer to the DRM device structure.
  * @mm: Pointer to the mm_struct for the address space.
  * @mm_start: Start address of GPU SVM.
  * @mm_range: Range of the GPU SVM.
@@ -373,7 +372,8 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
  * This function initializes the GPU SVM.
  *
  * Note: If only using the simple drm_gpusvm_pages API (get/unmap/free),
- * then only @gpusvm, @name, and @drm are expected. However, the same base
+ * then only @gpusvm and @name are expected. The struct @drm for dma
+ * mappings is now required in drm_gpusvm_get_pages(). However, the same base
  * @gpusvm can also be used with both modes together in which case the full
  * setup is needed, where the core drm_gpusvm_pages API will simply never use
  * the other fields.
@@ -381,7 +381,7 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
  * Return: 0 on success, a negative error code on failure.
  */
 int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
-		    const char *name, struct drm_device *drm,
+		    const char *name,
 		    struct mm_struct *mm,
 		    unsigned long mm_start, unsigned long mm_range,
 		    unsigned long notifier_size,
@@ -399,7 +399,6 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
 	}
 
 	gpusvm->name = name;
-	gpusvm->drm = drm;
 	gpusvm->mm = mm;
 	gpusvm->mm_start = mm_start;
 	gpusvm->mm_range = mm_range;
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 33c26df5111..b0b737234ee 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -905,7 +905,7 @@ int xe_svm_init(struct xe_vm *vm)
 			return err;
 		}
 
-		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM", &vm->xe->drm,
+		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM",
 				      current->mm, 0, vm->size,
 				      xe_modparam.svm_notifier_size * SZ_1M,
 				      &gpusvm_ops, fault_chunk_sizes,
@@ -919,7 +919,7 @@ int xe_svm_init(struct xe_vm *vm)
 		}
 	} else {
 		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
-				      &vm->xe->drm, NULL, 0, 0, 0, NULL,
+				      NULL, 0, 0, 0, NULL,
 				      NULL, 0);
 	}
 
diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
index ea73241d3d9..1c5195f5495 100644
--- a/drivers/gpu/drm/xe/xe_svm.h
+++ b/drivers/gpu/drm/xe/xe_svm.h
@@ -238,7 +238,7 @@ static inline
 int xe_svm_init(struct xe_vm *vm)
 {
 #if IS_ENABLED(CONFIG_DRM_GPUSVM)
-	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)", &vm->xe->drm,
+	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
 			       NULL, 0, 0, 0, NULL, NULL, 0);
 #else
 	return 0;
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 250c59f0930..2bea47ee171 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -191,7 +191,6 @@ struct drm_gpusvm_range {
  * struct drm_gpusvm - GPU SVM structure
  *
  * @name: Name of the GPU SVM
- * @drm: Pointer to the DRM device structure
  * @mm: Pointer to the mm_struct for the address space
  * @mm_start: Start address of GPU SVM
  * @mm_range: Range of the GPU SVM
@@ -215,7 +214,6 @@ struct drm_gpusvm_range {
  */
 struct drm_gpusvm {
 	const char *name;
-	struct drm_device *drm;
 	struct mm_struct *mm;
 	unsigned long mm_start;
 	unsigned long mm_range;
@@ -267,7 +265,7 @@ struct drm_gpusvm_ctx {
 };
 
 int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
-		    const char *name, struct drm_device *drm,
+		    const char *name,
 		    struct mm_struct *mm,
 		    unsigned long mm_start, unsigned long mm_range,
 		    unsigned long notifier_size,
-- 
2.34.1

