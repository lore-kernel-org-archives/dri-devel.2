Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F9DCD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76FFE11A53D;
	Fri,  5 Jun 2026 07:54:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WFMXeUb6";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013033.outbound.protection.outlook.com
 [40.107.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F8011A53D;
 Fri,  5 Jun 2026 07:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu4P6fNG5/HHE4X/ZTvkBjmXP7b3jY41mwhM07dE3EHS2zeiQa56R7DZ/JrgmPV3prfA+Mr+ywq4+NsIOOctqgncjIlppO90tJ43u5X/6j6q13NYHtBKmrGLCPbfGVN7ahwT3tTFz5fLk9kzhvuStZR8DuqR8Ucn4JMajEjsyuokazuWJxRlTuTYZvDypaCsrGz3TLOo9RC0aKOFRwv2PxkdNVyryDQkda18Qy/J51ftjDBm0KuzjudiNqPOdZ9IR4YCcYrasOJM6DGhKIc80QIF547jgnnlFjxdXPBrzf0Zm7+Gmj5XgDA2C23VMfwfJnJol6h9gJ0+NS/BLncL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP4928xiJcEy9gXcNS6XnKBAbX0O9KC/pbZaoDjJL8E=;
 b=htOm8SyhJcORpEDuctHco6FdPTmCx7b6LzTA2itSmMw6FoCO68UOYyU8q84Ji4DyfOFn2BhNmzK9GR2Z/uYwFwJqNvP65vn2JCGb8aW4TYhbaoCv9jdRr9SU72bi0dNdUCglIcAAwMLHPlIZjcRvOQu14qTHYCuIAF1AQlquSnDpJxkDDl9mHHB4FxrChy6PGMuMSIvBKfLjDiEA1dX4BMVvMo9BAiYe0hpxQIA+q4paScwvSPdoUzfNFu/3CLYyutR/h1DIvuDgj7JUEDq3PM5yk7NUrAoYEuiMhhTNu+ZW9UTtcvNIhx/QQgYYIULC/9yoU21qxncP2TnNUg4gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP4928xiJcEy9gXcNS6XnKBAbX0O9KC/pbZaoDjJL8E=;
 b=WFMXeUb6y17ivlk9NEvS6bSv57wswUxjjx3EKr/42rtxkn1NhVec77puvdi+ZPEPwkuFCpAmcaV+uVSUYCjCIynGay4b6T7rxyOpiGDFT5nJQEmz2FgELUKTg02ChSeL1HqAYTeOiGRomp9iHPCtvKAKSwYkF5lELTxPDaetcFg=
Received: from CYXPR03CA0003.namprd03.prod.outlook.com (2603:10b6:930:d0::21)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:53:59 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:d0:cafe::70) by CYXPR03CA0003.outlook.office365.com
 (2603:10b6:930:d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Fri, 5
 Jun 2026 07:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 07:53:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:53:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:53:58 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 02:53:54 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v5 4/8] drm/amdgpu: hook up ZONE_DEVICE registration in device
 init and reset
Date: Fri, 5 Jun 2026 15:53:36 +0800
Message-ID: <20260605075340.20199-5-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605075340.20199-1-Junhua.Shen@amd.com>
References: <20260605075340.20199-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e6a0ad-c84d-4e32-a9a8-08dec2d799d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|921020|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cCpiOkFXYqQ6AiFrztguSGr6X+je6KnI2Av9lSgVsi92Z0OvH45QJ9ZE7Aui82aEumr2ng4gKT/z4o9Y6QwDXOepIkC1PpC3T/WOt5YbM6sqqlHdL5v3zt3VABp4C3P8yZCMbul63iFARKeoNl9H4GYPvKR2oO8c6YUy7kFZS+sFhNkT6BVE3CvoUhkRjhgO2Matd7MiuA0vsOmrLgnqQ5Y42hVrv3IX8lZcg7Qk77VpUZxLbL9kv+T3R1WVKrEBSmjRcs8wQlfIz+uNLLTTSNv+WOfNeH2GIXUpe/4pW4kePQEG/e7DinuzNy2eGhH/Cex8nmaBdAY6qZkOf8nI4gaYJ9MvLDWb/1utDBVMV399D5r5QQ8SqKOQPC7XlUvvkDuoIspUgInEqOtk3JtoDg+sjLmF5oDRunhcRQjQ9b1Rk4wwB0AaXPj8W4MIZJOJdZltmLZZ4X5tpxpFTtwlR3j9WXF5ASh56xn9wmKPTgrl63KPtZ3uSYRBR1plggMf97MPRiR5FhDw2qOQ9vUNcWCmH6IGEq8MJwBJrZsMeHHQm5P7IklnAYEhVKI90xnMj/O0+zrrABYs/egK6AHsytR0ePGmJLIozN0gCAwkoZNDsrWesD7b110+3fzWMtp41isVB8DH3wusODCmK+eXAhvPOzvrgJZPbfCtpvPSSFbOsQE3KKw2u0jr9rW/E3XNFKxMivdAQLihU4qoHV/b3y9fsMMvch3R9BpiCbT2EK3ltp4cckkkMrLFfASaf0fPPhVOWXIaXSr9JTgvS6KWvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(921020)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EKUBkYkJxxWfuXSRQn/KybrOc6ajI/0OBt8ZkpMSrVT5XbN7Gj7dxJTUpZDAnrRe4iSEA+RF+1h/03/1NeVSpGWZ/2Nw/4ubLDrVKXB6gWn7oD6Ic+H7Y2GRw/fGMfcTHipCAUQd8gS5h4TkClRV7fpfp2t1ZngNPwCQMemRUDLXeA7+pg1IWdFTLKQ1mA/lv1F7zSxjyzfo4LAECDBwLANg1aJy/MnmVB2Xe8gmc6ZpDSrJfDS+B6uevVa2D9opid7SUuB6bCjwsfdXYnW798EPkzfy+atArl4af5DG4IAV3KGpkmaPPMx7vPYHIxgXIppjCDHY838yiKrHBd14t7SUIhZcAQ5KwWu93lltsENYRPakESWliC+xJCJGq0GiVwa2cRtdzpFYkNcEJdMxsp3ZFpHZQFFT82y/bVLdUlbF96lCX1dw3FoHSRBOh+lZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:53:58.7261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e6a0ad-c84d-4e32-a9a8-08dec2d799d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ff224163bab..5297bee6fb72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -78,6 +78,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_migrate.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -4093,6 +4094,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+		amdgpu_svm_migration_init(adev);
 		kgd2kfd_init_zone_device(adev);
 		kfd_update_svm_support_properties(adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index da77e0ef129b..c2ea540e392b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -25,6 +25,7 @@
 #include "aldebaran.h"
 #include "sienna_cichlid.h"
 #include "smu_v13_0_10.h"
+#include "amdgpu_migrate.h"
 
 static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 {
@@ -87,6 +88,7 @@ static int amdgpu_reset_xgmi_reset_on_init_restore_hwctxt(
 		return r;
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		if (!tmp_adev->kfd.init_complete) {
+			amdgpu_svm_migration_init(tmp_adev);
 			kgd2kfd_init_zone_device(tmp_adev);
 			amdgpu_amdkfd_device_init(tmp_adev);
 			amdgpu_amdkfd_drm_client_create(tmp_adev);
-- 
2.34.1

