Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B66CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 09:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF7210EDAE;
	Wed, 13 May 2026 09:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qoNayJSA";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012036.outbound.protection.outlook.com
 [40.93.195.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEE410EDBF;
 Wed, 13 May 2026 09:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfBshuz40+NlLzjBTr2uV/8X+ZaZCOCt3aZvqEJ/J5p16lrv020jTT+BLFgaC0q5K6GX8J+SYcPHuHbewAJoodI3tRaqti1BLN8imGGIOaKRYXNfm5O5cR/BaNCudmc6+IIZYebEztod+yyLvsmGesVENlemf0Qml0iDWBlkhT1Eti+DA/UrDx64hFzNaPDV12feEixPFoSu9C6HYnztVZRSK8muPXj2uktlOZpn4wy3fvwOLa0ujVlGJDxnaqP+OpZxEx3D36Zp4j16D754mjvVD1LAwNq6jziS3DsSrJ1HvEYviNpPREAW+fcrFLvMbkh6YOY4kqkg5dVfaIoKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/Z25Cq83OxSBnw5zRNfWh12SCDQ9CUCAUuTPPqjzVk=;
 b=GwBpeTNpJ9w6k1cIBHvzi1dOneRrTFBoOF/T6+6pvCWgqEZ0Wk10sTzfcC48sY45GxQ5HpnP+YpESQO1QKSsp14dDT1YyFwOi401jApVBLjQyg+XVyIrLXLL7LVkayotvLRM7ZKvjLLVz2sU4plC1b3FTjSQOchY3dB/Yx1gGwXXLK9pQluVXlR7YzzMz6RJYKoN7kaqOUt9aUE+uVf8EMPIbFWQk6VQlgfuP3tZf3vf309/9Y4BLIPMOlXSjvNky4bNeRGWJXyjIYvny1upWcCpYT9D8GvheuucGfRRxJZLYfaap66+strxAtFcqyY/FUyGnkoe+hXrwWaw/pEtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/Z25Cq83OxSBnw5zRNfWh12SCDQ9CUCAUuTPPqjzVk=;
 b=qoNayJSA04MXBx3uIm0zi5hyK7PTR0lf3g9mVHiSyZtITp2ZfHCHq0cRZXvjLciMJcnFw5sLvB0TtgKfWXvMXvLbpoVB35Dvx+YRR0k062IGZguutnnbJZU56onPYoIPSJ/ngQJ7BiX3Gomb8UTtyeteE9wIflnJjxovvMajVP8=
Received: from MN0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:52c::21)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 09:57:56 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::92) by MN0PR05CA0017.outlook.office365.com
 (2603:10b6:208:52c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 09:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 09:57:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:57:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 02:57:54 -0700
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:57:51 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v4 5/6] drm/amdgpu: hook up ZONE_DEVICE registration in device
 init and reset
Date: Wed, 13 May 2026 17:57:33 +0800
Message-ID: <20260513095734.69598-6-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513095734.69598-1-Junhua.Shen@amd.com>
References: <20260513095734.69598-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: d8346f52-403f-4221-2861-08deb0d61b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003|921020|11063799003;
X-Microsoft-Antispam-Message-Info: FAhjU2HolJBjuNihgv1wFTPHq6zaCmFO8WXbaRoYbrmhr1lsTrMyjJSoe980+keglukS67zY0WJ327l1ZPEDzE5zVrDNUd3KNZCCQq7jmqIcrHeWSv6kZbpFE1LAh0Tf8fEXyS2H1/mc0I7D3gMKCZh14WyGaK22Uva7SrwzbOH4Xss3AXI10v+zqPPu/tJdcUQJVmGGiZjWPP7TYz5cEe6roUrmyi/Ks6WBIYNydLbFxEPEJNZHredRwRvKCtPZ3BdWeKSE5D6BvNTZW77xUClN6iBZaZ/OffJktz7Ce2LFcS53K3sLfRn1DcM22xZ1mQ2gtvgSJkDHm+pZbjmagfX0Uw0EEZZYhltm04qgv9nXbRPO6fZnFjYHQMWmtAUHPNy/OgZxOR1Ril7AUBYU6MNa6VcFK0wkNrc4E7WfGNPiDbbkqgC/GOYRmK6jwuIhtE+TwxM3Lhqxf7iTRrR5b/wnHbgH6XE7nMcUlqhOwyDYyeurFIM7rMke4OoRnzscNpcSIExsXbViKoHWTbDW7EO25duNncCcpGdYSX5pz2Q+TZMFysfSWBYDKlkM5bUQtnaZNUjM/eounFrgrxzPnQ+fI6wv2CCK3ifT2x3wweppu/KX4VbV72g1juMA8LqOVPkttKFPYgEhlTfYu7fuAtmHKyNZ125l54+iZoIo0cVBS1ZLVynGDPocJs4cFCDL+J2vSiyK+bqqRqvT27VEXUFXrUhRS31TxoVOxGqtMAM2O4maiqWZR3aV7qXRQgC258VULtZhmUeQspt/LxrY/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003)(921020)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K5rJ5xnu+QvdSOao3hbL4MAJFJHc0wkuEBsTVNUpUeNW24TeRbO0TuXlYAQTmQqGvHySt33/8sn0VkVs/Z3uysGV962VKjPdjqvyOt2B7dCMyQXHzJnCumav41V4bsq2jMdRkSQ/HmQpgM1G8yvL+64YozHnspjAvsc4s53n7ESP0098qK3i2x135dwqf3HGsLKwgZV5gpG6tN7NL/PSnhtWkaSHXvy6VcIncJHmKv7DBBWHydlkvfuoaVO1j0XxmW9nNCuJhydxOl5mJiWzC8kUFRQn/paBw5KCQTvP+FPyaxAezJA6avkQD1lIvVsJvT+lsCSXKrloLtdsRSFKXibwuz5hOZ59BP6AGj8129baQKyL/VxVoKpsrPONK0+QbDNP83CwN0lN9kkBwDoACZwRiw0ezw3vRdblP/AFU/ItghSAMZ7Z3rH9sZV/TLoh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:57:55.5313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8346f52-403f-4221-2861-08deb0d61b01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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

Call amdgpu_svm_migration_init() in the device initialization and
XGMI reset-restore paths to register the GPU's VRAM as a ZONE_DEVICE
region before KFD initialization.

This activates the drm_pagemap migration infrastructure.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fbe553c38583..3be51a2c0106 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -78,6 +78,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_migrate.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -4076,6 +4077,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+		amdgpu_svm_migration_init(adev);
+#endif
 		kgd2kfd_init_zone_device(adev);
 		kfd_update_svm_support_properties(adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 28c4ad62f50e..c94d43f3ab42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -25,6 +25,7 @@
 #include "aldebaran.h"
 #include "sienna_cichlid.h"
 #include "smu_v13_0_10.h"
+#include "amdgpu_migrate.h"
 
 static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 {
@@ -87,6 +88,9 @@ static int amdgpu_reset_xgmi_reset_on_init_restore_hwctxt(
 		return r;
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		if (!tmp_adev->kfd.init_complete) {
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+			amdgpu_svm_migration_init(tmp_adev);
+#endif
 			kgd2kfd_init_zone_device(tmp_adev);
 			amdgpu_amdkfd_device_init(tmp_adev);
 			amdgpu_amdkfd_drm_client_create(tmp_adev);
-- 
2.34.1

