Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DFCCD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD7B11A547;
	Fri,  5 Jun 2026 07:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XgkybXi8";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E8611A546;
 Fri,  5 Jun 2026 07:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7hSBlu4X/VzDkCexKrqY2nZODQD+FE7Pc1ielUs/92816QIB3GfsncjQObDsNb5S6lszx1vM8OtvlnXr6LRWJamIK8Nro+1a2d4urpLYDrittLUNX29rTVUL+NeZqqbPBTmoj65uQ/DbeXCOxXZ9oYP0cNl9nR2Ykb2FTOKShDfUdrXmcw8+ty/HTCQ47gurlnDqrFr3QjoSWfK17KZOEkKHFE9OCpnqWI5FC8lIlYweNmryvdZLUQzK6i7SdnK1mnC6SWttC/Vm23USCFNxvgKv3zNuLFq6kc6IVx5U34KsvIMJOEO0zoF1tbO/gdHDJEalwPU+bducUOhdvzFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0jVKyBo2FQR6fNdqL7kLXBXvLUgLSg+EpCfFq51m7E=;
 b=VryZCglYX0UDk1Frqj/Ur6l4G4OYxtgwDtsCP3mYrulSOF8XK2KsnML/mWfz2V1bZ/QyUkrRK2dvwVoz8EbgGaBTaGtk1p6u9HJ0D3DdmqrK7emJg62wEl84QChytXzeZ/Yn90MRR0m6xBtT13RVplaPr9NZJbNhPinZVLkc332diTSei6o3gEt+5UFwGgU7rauIiTf+T0hYfpmsIFVYo0XU3IOlvUfYsnkOSh0bE1Hzf8Y26H0gaDEzKEJkkSuBWnK2UdpHQSXCYZduACIm8O8nPV4hwZe62NiMEGdpMfX4mZ1cp+mj+Eyqh7a81aELulzbrwASHzN7LDEKHRZT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0jVKyBo2FQR6fNdqL7kLXBXvLUgLSg+EpCfFq51m7E=;
 b=XgkybXi8pOg1ObXM5IU/kYd8sluV0IO1FxhWdrvEwZnjoCufd6X6dPKQMseCLBHYjBNYoe1+Ube+KYMl7ACUS1fm0/dwyqGrUou2J/6N2wKhRgPJIbNgoI2PTibMB0VvmBFEJ3X2+2QIyWGtC7GJ2MHOf18sF34ntxfL9Qp7jeo=
Received: from BN9PR03CA0529.namprd03.prod.outlook.com (2603:10b6:408:131::24)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:54:06 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::e) by BN9PR03CA0529.outlook.office365.com
 (2603:10b6:408:131::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 07:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 07:54:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:54:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:54:04 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 02:54:01 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v5 6/8] drm/amdgpu: refactor SVM attr devmem_possible and
 prefer_vram API
Date: Fri, 5 Jun 2026 15:53:38 +0800
Message-ID: <20260605075340.20199-7-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605075340.20199-1-Junhua.Shen@amd.com>
References: <20260605075340.20199-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de2dcb3-4522-4f84-beda-08dec2d79dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|921020|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: x1SRSno9GuTyDrp7t9pYOiyQtgimCqx1HXAWM+j505oov3AnFt3OzTCrwocpxnc24KQZWRO8eEEwO06c1LlKrj72mzbxgfj2DKjNuDM474spgsOqzjTaVDGcc+afg08a7Wdf+uGa4nU2ZyTTizFtTrMsYg/mpQPl4uhT6Gjv8mfI6q+81fF2AZ4wyL/vfzxvSooF+ncd8yWIUsm3vKPx8m6zxVB5+289l9AW2k0IR5UOJPc1ciqREJdnoZSEo6oPmZ0DvDLO2R704tYHLlSWhbyEBxiouodDzi/qOVEUboad7GTfCOj32Qgk5pmsNFIAHclYINV6PZXeLPtAzn32axyOSvXht06VndNtwsxfT1lHfmKmVLcy75nShStXKyVhPoVB8EpaznRC7+aNHtHuwT3ZmvQ+APrG8peT+pO/ncab6LD1vPQSqP/Epp1VzqUwDM5e5WDIm1QMDkhU9OaCAVza/5bqlHCHHK21cHfaTqNe+mpj0JCCP8LXabVboxcEkqT2enwK0MNcsMZT7sThNzmqOtxFclJfNsP+BYdKBIJP39mP2PN36PDRdoIPKfqtabMnImX5rsRyjnmln5AomqD9Xi+zuo0kutxogEmSnZMhPT2GlFQaTFBn5q1q83xm5ahJYhfLxR0ax5LDF7GBGIXDuuJUKMlxSs7wxroyF/h72rsmPMBrjl04TN7jggSTarbqe1FtqI5v8ulQoqo80YNS7Az4Lmkvd+L6LqEc5nVjq6wEdUykSRBzu7wTFjvOw/uNfS77jBiYrFCQPv7vIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(921020)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TNOeEmO8okLnyDQe5XKv1oSf+KpOkKQ+qictIti6n0MUZ+tJmvrfa7j6qNWywJNlAAEvUHVDQ0tzIAG6aqIgJn9/lxQYCeaBLsqUzeWcTGO2IBinaGb82OFnw8j6WOzGJm3FS/RL/ru1hKGrEHZk/eKWq48RsjWfSMyXkI0aT+SFjxJjJMxOjXgbQ8Pyvsju21LoKL2w9cvhRKLAMxSaC6noUX1gMH9rDE892THpughMOw8BS8JBy5SRUcf2Y8ZivU4MVtk0rsw6Qm+9hQGul1NQI5UaD/xLyq8VBnfk3KZ7qc1L+q39F2kbm3gQA7Gb2LlLW3fHbZeaNpIjk7Hrg/eLGA4Uj9UvULVNhnufIXwOZvhGxdPynSPQ89irIXunABSZlBqtr1lFdSnBu3C9ZUaLlIJyIYFqy+PilmPREBXYLVeTaAzLYhBT9Cqx6bRD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:54:05.6043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de2dcb3-4522-4f84-beda-08dec2d79dec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979
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

- Remove duplicate AMDGPU_INTERCONNECT_VRAM/P2P defines from amdgpu_svm.h
- Move devmem_possible() from attr module to amdgpu_svm.c as
  amdgpu_svm_devmem_possible() since it is a device capability check,
  not an attribute-level decision
- Add amdgpu_pagemap_capable() guard in devmem_possible()
- Decouple prefer_vram() from devmem_possible(), caller combines both
- Update all callers to new API signatures

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  | 18 +-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  |  5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c   | 13 +++++++------
 7 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 626c5790e4d0..47e10e1401a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -33,6 +33,7 @@
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_fault.h"
 #include "amdgpu_svm_range.h"
+#include "amdgpu_svm_range_migrate.h"
 #include "amdgpu_vm.h"
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
@@ -318,6 +319,17 @@ int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
 					  (last_page + 1) << PAGE_SHIFT);
 }
 
+bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm)
+{
+	if (!amdgpu_pagemap_capable(svm))
+		return false;
+
+	if (svm->adev->apu_prefer_gtt)
+		return false;
+
+	return true;
+}
+
 static bool amdgpu_svm_default_xnack_enabled(struct amdgpu_device *adev)
 {
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index 1ab9c84addf7..0dc04d1383f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -47,9 +47,6 @@ struct amdgpu_svm_attrs;
 struct drm_device;
 struct drm_file;
 
-#define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
-#define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
-
 enum amdgpu_svm_xnack_mode {
 	AMDGPU_SVM_XNACK_OFF,
 	AMDGPU_SVM_XNACK_ON,
@@ -154,6 +151,7 @@ int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
 				 const struct amdgpu_svm_attrs *new_attrs,
 				 unsigned long start_page,
 				 unsigned long last_page);
+bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
 #else
 static inline int amdgpu_svm_init(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index 177eb3cd501b..26e33defb8b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -52,24 +52,8 @@ struct attr_get_ctx {
 	bool has_range;
 };
 
-bool amdgpu_svm_attr_devmem_possible(struct amdgpu_svm *svm,
-				     const struct amdgpu_svm_attrs *attrs)
+bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs)
 {
-	if (svm->adev->apu_prefer_gtt)
-		return false;
-
-	if (attrs->preferred_loc == AMDGPU_SVM_LOCATION_SYSMEM)
-		return false;
-
-	return true;
-}
-
-bool amdgpu_svm_attr_prefer_vram(struct amdgpu_svm *svm,
-				 const struct amdgpu_svm_attrs *attrs)
-{
-	if (!amdgpu_svm_attr_devmem_possible(svm, attrs))
-		return false;
-
 	if (attrs->preferred_loc != AMDGPU_SVM_LOCATION_UNDEFINED &&
 	    attrs->preferred_loc != AMDGPU_SVM_LOCATION_SYSMEM)
 		return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
index ce7be1bc4ae8..36080405b504 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
@@ -162,10 +162,7 @@ amdgpu_svm_attr_range_alloc(unsigned long start_page,
 			   const struct amdgpu_svm_attrs *attrs);
 void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
 					 struct amdgpu_svm_attr_range *range);
-bool amdgpu_svm_attr_devmem_possible(struct amdgpu_svm *svm,
-				     const struct amdgpu_svm_attrs *attrs);
-bool amdgpu_svm_attr_prefer_vram(struct amdgpu_svm *svm,
-				 const struct amdgpu_svm_attrs *attrs);
+bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs);
 struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
 					unsigned long addr);
 int amdgpu_svm_attr_check_vm_bo(struct amdgpu_svm_attr_tree *attr_tree,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
index eb0e14439762..3f0c010e4e35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
@@ -151,14 +151,15 @@ static int fault_map_range(struct amdgpu_svm *svm,
 			       bool write_fault)
 {
 	const struct amdgpu_svm_attrs *attrs = &attr_range->attrs;
-	bool devmem_possible = false; /* TODO: add migration */
-	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
+	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
+	bool need_vram_migration = devmem_possible &&
+				   amdgpu_svm_attr_prefer_vram(attrs);
 	struct drm_gpusvm_ctx map_ctx = {
 		.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
 		.devmem_possible = devmem_possible,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
-		.devmem_only = need_vram_migration && devmem_possible,
-		.timeslice_ms = need_vram_migration && devmem_possible ? 5 : 0,
+		.devmem_only = need_vram_migration,
+		.timeslice_ms = need_vram_migration ? 5 : 0,
 	};
 	struct amdgpu_svm_range *range;
 	ktime_t timestamp = ktime_get_boottime();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index ef913a2363e3..21a2b0c49c53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -26,6 +26,7 @@
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_range.h"
 #include "amdgpu_svm_fault.h"
+#include "amdgpu_migrate.h"
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 
@@ -423,11 +424,12 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 {
 	unsigned long addr = start;
 	int ret;
-	bool devmem_possible = false; /* TODO: add migration */
-	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
+	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
+	bool need_vram_migration = devmem_possible &&
+				   amdgpu_svm_attr_prefer_vram(attrs);
 	struct drm_gpusvm_ctx map_ctx = {
 		.devmem_possible = devmem_possible,
-		.devmem_only = need_vram_migration && devmem_possible,
+		.devmem_only = need_vram_migration,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
 	};
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
index 4582fb9453b2..8bf00aed7f15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -247,9 +247,10 @@ svm_restore_range(struct amdgpu_svm *svm, struct amdgpu_svm_range *range)
 	if (!attr_range || !amdgpu_svm_attr_has_access(attrs.access))
 		return 0;
 
-	devmem_possible = amdgpu_svm_attr_devmem_possible(svm, &attrs);
-	need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, &attrs);
-	devmem_possible = false; /* TODO: add migration */
+	devmem_possible = amdgpu_svm_devmem_possible(svm);
+	need_vram_migration = devmem_possible &&
+			      amdgpu_svm_attr_prefer_vram(&attrs);
+
 	map_ctx = (struct drm_gpusvm_ctx){
 		.read_only = !!(attrs.flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
 		.devmem_possible = devmem_possible,
@@ -502,12 +503,12 @@ svm_restore_find_or_insert_by_attrs(struct amdgpu_svm *svm,
 			  unsigned long start, unsigned long end)
 {
 	unsigned long addr = start;
-	bool devmem_possible = amdgpu_svm_attr_devmem_possible(svm, attrs);
-	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
+	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
+	bool need_vram_migration = devmem_possible && amdgpu_svm_attr_prefer_vram(attrs);
 	struct drm_gpusvm_ctx map_ctx = {
 		.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
 		.devmem_possible = devmem_possible,
-		.devmem_only = need_vram_migration && devmem_possible,
+		.devmem_only = need_vram_migration,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
 	};
 
-- 
2.34.1

