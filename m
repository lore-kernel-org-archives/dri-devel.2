Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B373ECD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E43210F907;
	Fri, 29 May 2026 05:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iAcG1ILW";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D4F810F900;
 Fri, 29 May 2026 05:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnCeRrHOOAF0miAFNIZyuGxBOyd8BWmXvDNjAegf18dsUwj9wCU0DwjjZyVyIf0Jy8jzhSEUB3R9aITSqVyOtqBm+Z5iYYYKT71RnpWSmK51bFm78zfhgPkwgIN9aFiePWfy1PzpwFvrzKihza4gxQQO3KlIUfUid63YULtFYXJ2Kwbyo11WAg8M16HBfzY4X7UByWjln6H8eNof2eFBycu8659JQW3ajs2KysFgwoZxbxfLyyZ46BZEbFN5UWlMkJKQJfYvoJ148/JapM5JYpuO867eJvbwGFAho0kZMN+PMGo+huuDA5GTe19ojFsmhK5tBYd6rgQ9+FrsqdCXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgdHiSzfsnrW6o1Yn/asSQHSIi+qV7rvoUiKDeDwg+4=;
 b=H6SobhR1kVfSxO3jm8F5gsUt7S3pmo+1U27Gi0K122q8kaehGd+ztIG1PIKdKT1DSUh7tUG7Ua9TdMjZZ7eefeEpWTKbu5whPBogOyDw/PPmS8XCX2LwBLM4TZylHfRknFtYYj4X2tLBnA8pfXT5WnrON2mHQ9BfIP+Nii7sP5vadeSD/xINYqIDbbeJ0p3EHq5M1DbqIv7Shp+BeXHU1+TYWRKrGV/CWjPch50I//YTPuBF5HEgUdHW6RAwQ3qUwwXaWkIApqpc27ThQ1tty7SvfHxGAXaGUVRO8B9mJW1NmYQotOUXvYNRsaF/XZu97lBllmFqDELdnNoAqUNDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgdHiSzfsnrW6o1Yn/asSQHSIi+qV7rvoUiKDeDwg+4=;
 b=iAcG1ILWmSX4QqWzGZANGEtnAQa5mVUaD9Z/XF1wnG0pQOOyWT9romfyUFm3NkobUl1d5uC/NhUeDG8pZ5zr/sXpXQZifypXI7zOC0XD8ACz6pMmlqZ+WTTW0DdywxmM4h28SDFQUWGz2Vkk0XpiLHgnpqie54d3KHetz38dQ3c=
Received: from CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::8)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 05:49:54 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::63) by CH0P221CA0027.outlook.office365.com
 (2603:10b6:610:11d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:49:54 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:49:49 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [V2 RFC 2/8] drm/amdgpu: integrate xnack-off restore types into core
 headers
Date: Fri, 29 May 2026 13:49:22 +0800
Message-ID: <20260529054928.596825-3-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054928.596825-1-honglei1.huang@amd.com>
References: <20260529054928.596825-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: ead586c6-b329-4e72-ae92-08debd461bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|921020|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IQc5LMyt+j6YvNuTD0QssiX7IQYTpxa6hCzJtFyNHBGpBkHzqRgsCRm9rnBHpFt33LGLamdraOenPQOyXX/zs8xeDLlPGsmuCyc90v+F3K4QuCpAuFcVIZToAbefAmXVnydL7zneuM8L8PtuUZ283wv/5A/LaDeIrDXOLoo1SgGzP7w6lCQHVqlA7Ka6+JLmsulIHRj4OPKkPV+ZGeDmkZIh2gONDgJE5C9I19lMdsd5x28BG4NvjZOco6edCt2ut0CcWFwD7p1pDGkTshCdzZJbFsuHg28JiF+ZYfm/fabBjFF8Kvao8osOCP2BP1IxcirLOv7aNk1Whd9voJrsErBS/aczQ14XdYaacQUdURtaIQa9Xw6RYB47DYygdSs5UDy35qM1ay6aS0iT4IdKMMKmsFvGGYcQmzyeyXjzeM0LH99+yLGk7U4gjqSsjKBIkbetY4vn6Uan9U5UurKAVVsx6Kn4bz33kxtQyCxMqQ14B5QHvdiQCUWUJWdrtr3sWBa3M2BYriqwbyjr0nIIbQ6cKcI5puuHeRHWt65XBawuw0CKvNKS/1HluwKhYlnGoVYeoI/o6M9vo8k6LbASNYjWK0bUPEKbHpBqnWRvYfHkWfV0cq9Ykn/LPMeB4u82cz8Jn+HkQyuw2d37gLASIsrGqtg+P2pPJWJibyoetSWTTghdMSe+ejzE37wgYjnzFKmHkcs7AY/bBOFCXwWVW+VSvJi875yYTCik72USdsDzwtUOARHvSAO+lot2ViyLJhIRyA4IOo4TxQNY7WV9Kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(921020)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T9Jy3I1fYfYwL10Esf+3zLKDB2aR688/ubD+HPAQCG3BsS6A5V7TFr6BKUxAeuxYboLK+z45aD7JIfybOT0j8JZH1ZF3EvfmPb9Ws8/V5dPzW6lNk3SKvmxjuVEjKc17CBA4v3BJHV9Dk2MuyQ0D/gezPbGsaDsoiBvrd5RGEHjFu2anOlhLO0tpwfeisG8HGjQn3wF/0MD6skFgiFOsa1wSoOpA2cYQwdq0YaBvRJ+IeJo63MmnvNDnjxjjEiv4xfdll8LR3av9dK/V7ut/yQD0sgKIdvDoF42inievdfW8MHAKR4LR9ZELEjSOERK7bR53xM6AjYZJamJTt1ODDXl6TFSmkvIqdKiVC0QmUpwdc6yBJLL+WSahzg4YEaZtMwa+8r7Bqsgju6V/9GU4Yef0blAnyFflEbGae60H0V4tJGIcnBZTR8cDdW5e/4ax
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:49:54.4744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead586c6-b329-4e72-ae92-08debd461bd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
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

Wire the restore types into existing data structures:

amdgpu_svm.h:
- Include amdgpu_userptr.h, add restore field to struct amdgpu_svm

amdgpu_svm_range.h:
- AMDGPU_SVM_RANGE_OP_RESTORE = BIT(1) in range_op enum
- RESTORE_WORK() helper macro

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index b04ef1617..1ab9c84ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -38,6 +38,8 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+#include "amdgpu_userptr.h"
+
 struct amdgpu_device;
 struct amdgpu_vm;
 struct amdgpu_svm_attr_tree;
@@ -92,6 +94,7 @@ struct amdgpu_svm {
 	struct rw_semaphore svm_lock;
 	spinlock_t work_lock;
 	struct amdgpu_svm_gc gc;
+	struct amdgpu_svm_restore restore;
 	atomic_t exiting;
 	uint64_t checkpoint_ts;
 	u8 default_granularity;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index 82d4b353b..2d677f096 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -90,6 +90,7 @@ amdgpu_svm_range_invalidate_gpu_mapping(struct amdgpu_svm_range *range)
 enum amdgpu_svm_range_op {
 	AMDGPU_SVM_RANGE_OP_NONE    = 0,
 	AMDGPU_SVM_RANGE_OP_UNMAP   = BIT(0),
+	AMDGPU_SVM_RANGE_OP_RESTORE = BIT(1),
 };
 
 struct amdgpu_svm_range_op_ctx {
@@ -100,6 +101,7 @@ struct amdgpu_svm_range_op_ctx {
 };
 
 #define UNMAP_WORK(ops)		((ops) & AMDGPU_SVM_RANGE_OP_UNMAP)
+#define RESTORE_WORK(ops)	((ops) & AMDGPU_SVM_RANGE_OP_RESTORE)
 
 void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm);
 
-- 
2.34.1

