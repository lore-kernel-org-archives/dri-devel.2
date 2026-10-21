Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB20606A322
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sdpqodU0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B6DB10F8B4;
	Wed, 21 Oct 2026 03:02:27 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB70B10F8B4;
 Wed, 21 Oct 2026 03:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr1RvX5Huuj9SwMJvCWqX34SeOkhY+gqec7QtMEEgLWC7C+r/lUvam+mN9zDGYqCMQ9ADpZERk73dmPo2uo+yT6xNFltthJ9jaRiligDkql6PAh0Xc6UdF1mqnFbYeEImmMbYvLp1dk9bGmBZtLs2CeCFE6n3EUyb5bFky1cKnbHv5Er7jE3YUddOyn0dZG/BemAA0xp6sNRUexiw73bJpwWRldqvTurC41uDy5mUgFFJ+aeQDIhylcoKxbLfzS6qnGaV5PUb1lSHKMTpLLU1Pbr9dRHT2Dq50kRXsNldtI0qYfLklDuC16auWLti6TNawXzEA+BDyVc8mRpGt/BJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ja9jgfi3sF4A6a/doWXmko3UZMc6yvJK1K+E5i2HsM=;
 b=JyfSOoQMtb9oVpB+GvtjEjSSEbQUFqcLFzC0y/t6Q063S3qPtWweP2PGUO3UvCcmZpbZsUj6nydeVLcuLi6IlmVEAO1r+Gk2rti/QvTqfp65dfGHPuPsPlqy9Jq8507a0jmDaD3kdCwR7dtS3eKwcWHZX5VACuUcVvByoldvEuipC8pRGN14orQnDCBgdomBQVddRX7eHghuoIsAECvsQr8Obqw7/ukuUA/kV0Mf12Ua075pF3vrE4v0NoXMEcwErEHl6QuIyL7/SsqUuHY+4d1MnNCt/7iwyqH/JSgBGoApmfoEiuw3l6LbMMth1IFPlWG9ScKmMPUSblYMdMJJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ja9jgfi3sF4A6a/doWXmko3UZMc6yvJK1K+E5i2HsM=;
 b=sdpqodU0+vd+bxyN55xtkHechTpj2aYsKZ8G78AbzKg3a3OIaWcPc/pzEn28R24GPggnmpJfHbWN2DDGpqAo39lA7giey6pl6lfBWjomY2AnrC16/uAVFkcLD/um7wesQWz/cMwoMYoGTEbNZ1tY5Sa6yUVg+DTKnZTvtm3WOhk=
Received: from PH0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:510:5::15)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 03:02:16 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::4c) by PH0PR07CA0010.outlook.office365.com
 (2603:10b6:510:5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 03:02:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:02:15 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:01:00 -0500
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
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v10 20/22] drm/amdgpu: hook up ZONE_DEVICE registration in
 device init and reset
Date: Wed, 21 Oct 2026 10:58:59 +0800
Message-ID: <20261021025915.2433837-21-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: e8aa10c3-4648-417e-66ed-08df2f1fb662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8D8Am2yEZ3syH0ft+zGsz0caMip3cCqhwe3YW8V987RITzJvUvdFe+zFOKu0NBe5WwkIkJdmOPbbUYRhVVMOM8LALZikdcWbBDNLgJ8qNP0cFXXXKPaJDj6HOtvxNA1V3CopRYDkh1vCBLKJu1vTQa7+NtBiQNvG2MiVumwIGn/vwmHIr1k9mHHaQB4LzpnhJGWHAk8u3lh13ixXSwfBwWE4H78IF+1FbQRL7LAm8TfFdNlWYYrOxHW+xfqOZIVFS7xaQnNSmubBNnQFrJrmki9XdUTGonhE/z5mPr1S3RI8aC64Z4mfdA2GyJnh2h/BN0XDDSzBWYUzmLUHcdoChXDl0ld5Pzv4BrzokXflJzRaFCeLNZwVFPJNG8T8vziOKlJQtP9cYqYketynLEDVqEfzXN2DqBDxClgoF00krHElpqkFGZcHDgUGbJIqFHr57t5t0fqhG1D4Yj7JK50r2NmW8rNsubH3QVd1RUC0O9opypJIcUNsAc8muouNEeNZSis463Mu3YAYEJ5+YEIMXjiBMkyeOtMYwXYLcCEQqTI9WZC+xayoidavFmvYD7jRPy/d8f5UpYIJVWc0B4i3QnX6vcMaiKygwn/pxT8+cnBZXK+XY9zJeK9ccjf8dECBXp7TdSePXmuHYiaaKH8UOg4M99H6NltBeqsi68oN1r+LQW5TLp8gYpTWdoOqn5wj5p4FZv7iFaaB8fw53u5o2OlQTb1+u4Vvjm2ax8EgsFxgjGo0Fuk6egKfAfH+tMNx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qtYiQfhmSgteGgROe3l09vjOIDAyC/kSxQ8PpmglQazdIyWiAqnWvBsEeeUmaucXuiYD2fyvrasZu3qpQaX6ew5S3bxjOnW4DkC6DotXSG7kM/9YlrUgwGRSjuUGis/XxacEbbLIHBdorU411SP4LCTZ8I0mAlGq/DnfK1Pnfj55bqtZ8eYFoaibjSdXxJcv7jlOf49z1TK/8ZkwxMaJ6PNRMC9C+Xq/mPm4JcXa/QsDL+MuOHypg8xAOPuzo5RhOJKR8hRTKsJX3ZI+xNXQ0msU05YqgzHsBP3mpTfsMj1bFoaN/DcvP9NkQu7eDPYLzt7cVs0b0oDnpI+HpkM5Ddr7m7xdnuCmVwf7wmfrp4NWPjN1q0hPBQ3MeSbEAoeEogIDyQLXG2bJf38v1aZlQ+sOMSgvcjHUSmpIUTSI8bwRiphxJNoKT4TJqEoBecFj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:02:15.9599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8aa10c3-4648-417e-66ed-08df2f1fb662
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745
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

From: Junhua Shen <Junhua.Shen@amd.com>

Call amdgpu_svm_migration_init() in the device initialization and
XGMI reset-restore paths to register the GPU's VRAM as a ZONE_DEVICE
region before KFD initialization.

This activates the drm_pagemap migration infrastructure.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 44091ac12fa9c..ef3a5f844444a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -80,6 +80,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_migrate.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -4181,6 +4182,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+		amdgpu_svm_migration_init(adev);
 		kgd2kfd_init_zone_device(adev);
 		kfd_update_svm_support_properties(adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index c8016fa55a92f..571dd062547ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -26,6 +26,7 @@
 #include "sienna_cichlid.h"
 #include "smu_v13_0_10.h"
 #include "soc_v1_0.h"
+#include "amdgpu_migrate.h"
 
 static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 {
@@ -88,6 +89,7 @@ static int amdgpu_reset_xgmi_reset_on_init_restore_hwctxt(
 		return r;
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		if (!tmp_adev->kfd.init_complete) {
+			amdgpu_svm_migration_init(tmp_adev);
 			kgd2kfd_init_zone_device(tmp_adev);
 			amdgpu_amdkfd_device_init(tmp_adev);
 			amdgpu_amdkfd_drm_client_create(tmp_adev);
-- 
2.53.0

