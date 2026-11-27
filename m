Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1558606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nOsLvJjh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E0E112898;
	Fri, 27 Nov 2026 08:43:59 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4085112892;
 Fri, 27 Nov 2026 08:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEzpjYRkmHFrXhkSfBtNaC0vVkNh7XLwOZYloPbLAveWciHjKB8WwxLpm49sLn42KlTPDOdCIRlfeFlQuc1CPdjz32lKTb02ZTW+f3p7Iy5Tn9Ux877XaattSoSnogWm9vuzJ/ycD3Jccod1FnbqRuhs1jEzLDJJPQivvNAsR07g/j7eW25g4xouIbAmcIuVVJ/jLYkNFOUwnV8yW2hQZdVLdXfC2QOmxBoMbqcpJcYnlojo8qMnH1ALKzjliMCM7Toi+K62KLuUcQ3JKnsCh+69jxqrQTFRSw8oW9611qXOS5yGb1BXa4T20dvduLUi3KtFXxFrR8qY4ZePBe2Dmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5W3rcWJeM+xhEoE9awNWFRJSEpJS/fEoRP4OLH/MhM=;
 b=qlBKAbbbgJel/cZgydD2UKRng1VieJjULilZeI+cP9i+RsqBNGkvCwD2n7RKOz77/gmSJ37nzsjTNpZsY3w65I3EaRc/NODWL4IEFMTImXYx8YDDc5r4fFEJVsGnT2CAz1kORHS/JqDn8VlGB1iiI2h18z12cvAaCKScfRqWegvthYFo/+3WwFID07dEIc39VajOTUi6rG5CtxfgFQc0N4tqxYk8ZnmhcY09P9yYUkVd2uHzQKOySlrnSd64qQQwKCaKTj8grx9WOWQZeM3zTTVaQoDlDz7gtrWkZHKikH8+UPxG/odCXnhHKVUOJJKUVnSFnK2MD/JzJ10H3P9f8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5W3rcWJeM+xhEoE9awNWFRJSEpJS/fEoRP4OLH/MhM=;
 b=nOsLvJjhLq2q+IZZpajt9YzFCaZG1SkZ50EOAXpa67fo1iRWfKz9AwTL56mrD0fLaSjTTUTvylK/aFjAvJyFfvUBUmBUGAyVXy44xf8ui/1YTGxJZtpHEHN9AK6as8E3MkFpwnegmt76NoUykYpQYlX9XHNQBh2IP46E3POV7Hc=
Received: from CH0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:610:b1::25)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:43:30 +0000
Received: from CH2PEPF000166C1.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::a7) by CH0PR13CA0020.outlook.office365.com
 (2603:10b6:610:b1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.4 via Frontend Transport; Fri, 27
 Nov 2026 08:43:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C1.mail.protection.outlook.com (10.167.252.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:43:30 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:43:25 -0600
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
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v11 20/22] drm/amdgpu: hook up ZONE_DEVICE registration in
 device init and reset
Date: Fri, 27 Nov 2026 16:41:43 +0800
Message-ID: <20261127084149.925625-21-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C1:EE_|SA5PPF8DEAB7A29:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f11c49-265b-4682-f158-08df4c628360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|6133799003|261009223027099003|18002099003|22082099003|921020|261021121427099003|56012099006|11063799006|10067099003|261102123227099003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 2pfgpBZe6aDfQikXJXX4Xo0oR4d2YQF4XkOBTnpxE2xf7X+KmzwhRS8eC8TvQHjG65Nd2iRlTFf8IRHl54WNbgMw3vmxOEYLxU47jHdZGP7X81Uy6PPelpLIzqKvCkcOKDnuHiVo5HJB7TktIaNLUg5+O4C+VyHRfA1bO4qvYy219767nJtwfLdWunikHxNUAZoY5Oy6kUw1aF3tQzRGOqkN0CeciF6oAnTOH4q48ogI+7ukA0Gw+jTXAtxU6yo1qIpskkvOuht64A4OQjvL7Zw3wA8e046e6Ig5M3YUJtNu31QcFCW7PpCa0z3iF9u7R3F7pNlK25tI2rs/qOc05ee2kRyGhEV92rdHkyXKm8wT5VhVe11CXKakFnahXI8k/F7t4NBF5DJ3/ZQCDomqVL9xG+cPUs1AorLaBD72dxzPCgitKHqROgQypYYVOhnhwDvJ7qwxRfoW8/i6I4M1+3/LL3O5Uwpiut5TXnB0evTI4SVzFqp4CoZBUb1kEIxTkLn2Gsc8gBQHjd+bI3iBF+/ieUxmjrS323FCRAaVB2hIRbTLLSC14rwRdPdW/NZeMbL+Y0tPTst4BHtYUdNRfIyizRYT0SIK27tM0fpck+6n9bYAStuA0+A5k5pEk4ChOfSg4MQxPWlL0b0LsjzLEXpeSz/rUJhToieH00cw5mNeV+MyukRTwjI8e9MD7yy4iTptldEvj8N3/54hasP89qeez0S18haMsL6Vm4QIhZ5dlHmfRupUAzfqhrTY1v64
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(921020)(261021121427099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(261026121527099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f5E4uDIISWJWVjiGwZrlP9wOHvFGFS3UcIiQoE9+q029KmICkDfaOSpnhd/wAuhYkF6GxPWj6oycUWHOHr7mdvAQqqX0P4GqMBPcOI4fr9K3EDXsIYNRVkrPpQn6ecGCNMffYpWf/fbfaoeAiWH3sZBLL1ByznbQE9RmHrhSBzEqDmE5M4FQgwGXKv9Ls5XhjJ6ODfG72NffcyeHgCiIghbXY+Ho9nVxpJP4m9H9rUEvYMUwsqqBnMduSejlgo+18U9ZzKbgkNgSBrXsdOWq99a2uPI8/Ai1H02LV7Yd6MbA9VtV9CFoRAzwDOz3CmWnGRu8R/gOX+JRZ++fb8jsyw+zir70A4iSRlU/3FEqp9aqG3uEjYSBkh/Anv2YkxmC6bJjaRAwlLA7m1XX7d42VukjsKdH0exJPmbajYWWX+HLXVH38PEwBZH+R/UFypDH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:43:30.4027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f11c49-265b-4682-f158-08df4c628360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29
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
index b249c169a39e0..01c287d72e58b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -81,6 +81,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_migrate.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -4216,6 +4217,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
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

