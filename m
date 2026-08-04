Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24609C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E0D10E97B;
	Tue,  4 Aug 2026 09:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2BS5ym5v";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4B110E978;
 Tue,  4 Aug 2026 09:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1IpPAFvBUQn+fiPQxCEofTlzU5QW4QI+dcVTisetZ2c07G1rigf+WAbgutYMRfq98T3y6nI+gfFGhoZzOOMxUtV+Es4FRNSQEp++GRls79PygSEQKWDq2sXwUDz4XIlxwwXwPIplBz/TjTZ9UVWXW+zdrhbp+04dsK4j6acriaKIToiw2Xyup4r6Vui0u/nFA6wJpvi7TRIFEQvAb7I5xQE5TAU3PdD5QQvoZGynXqIbBzyoN3tP3yK/to3NplBHCPptB8Uob9ccknXQsfCILXRJ3c8hp/0Sy5K0YU6dH+r+8e6woFBysM4YOWqBad5lOR/NcKradhJQo3aDGxz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iBZr/42FOYZPvDOoadtnPKHf3RJxshzt2ICCiocSI8=;
 b=RRx7lF+ijgoIVEAQkS0jay2S7L2ShwwjUwEIqIa1XBc2CjZwiJ6re7+tvgJNtWdXNbQ7ZdL/ZtefKTL0Ofo3K1LCh10aSo5txnsH8owbOY6OjS8GwS3HyQVuvvhx4H7De7dUr6CyJYDh7kJWbgh1oA4b1xqsD2UfaQFygfEV+OOa4P7vQ4lbzIriwE3CQWl5sAD1w78wIqVUiwnDYdj3Aq6T9XmPepnVpy0NnmD1dhm07Kg0o8ylfkjFVoRUVqETwxLiOVrXsT5tiJoKPpsDhdHSvHebxfOTH1D4aEYI+ZiX6j9+EkpQAEl1dofB/NXD6sERUI8MiUIjHpC/U7A2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iBZr/42FOYZPvDOoadtnPKHf3RJxshzt2ICCiocSI8=;
 b=2BS5ym5v2Ie3k7WiMPrf56y3Cr7ZOOTSYr9k+3Ps0kRpqmcGcOX/CZ2wq2fJLQgyXvsSFsiytCzTaMiDKdegYL0957F27PJxDW2yCcF6n6Z+bIkBXCqACUXAbGeWPZcdXU9Gj4kdcMwJQqcr65cuN5jq9G+pJ6P0pEP6KSvhUYg=
Received: from MW4PR03CA0135.namprd03.prod.outlook.com (2603:10b6:303:8c::20)
 by SAWPR12MB999165.namprd12.prod.outlook.com (2603:10b6:806:4e1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:44:20 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::8) by MW4PR03CA0135.outlook.office365.com
 (2603:10b6:303:8c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 09:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:44:19 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:44:14 -0500
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
Subject: [PATCH v9 16/18] drm/amdgpu: hook up ZONE_DEVICE registration in
 device init and reset
Date: Tue, 4 Aug 2026 17:42:42 +0800
Message-ID: <20260804094246.1719318-17-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804094246.1719318-1-ray.huang@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|SAWPR12MB999165:EE_
X-MS-Office365-Filtering-Correlation-Id: 633c5500-1e56-4fec-2819-08def20cf4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|921020|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GIyyySorYy6hFBhhnHoJrOsc3y8qxST4NQbrLqs3diz7hpqI1MPXeM5S+CwPF55zJrIG3J6o06i0ZgHsKZBWcyDj6UL1XQf/UqOVih3TSmcLO9ziaIrDzoYcErLQGf8wVXtB3wp+YUKVJMkHl/ThrFqef8HtohfY0rl0a3hMyuuDoYGyU1hFQ8Mjs7PvU/rlNYx2ofuZMFJkslfeoALVjcfhIcX28DQpqfDM2Fu1UR7CAjpEFc4y0MxnIe+DfGdGVQtzn5jO4LKONE8Nxl86CY79mjtL5mPHisdk8kS8zuMNUgIWhMg9zthJXMCorKxszwFWJz+WtrEI/RiRHkqhgcGcXO8hOTTS2hgugXl6Xms2sOCfytInTHNp4awk8irHVq6GrY+FYjZu6+4sr3mUnZ4yP2VAoDBqTV0U3QgW9Kh6OzmVgCjrzrRVsmhrCtioBfutoJIpD6qL9MidCAHmKRQN/QFJV8wPp14qj05uA8SIyiREKZS5qSacfrBA1HpCPqPx7BzB+hCr4gXDicUg99qluxSnDQAXyHyeCXYkdwacttuJyEwYFovE6PJL4kc5v9GveFwL/1Vaprr8hXESChpw+bkTJP+BNzHNKRHMEKyBVpp1oaBAtgBamkVQIvdUAGMKYlKkUurMVVCZ3yBhuTLFGLPYx5wtNUGrkBNlC1Co+r54kKQanbSIMtPOLNh8CjJjtZisrZTz9fHPb+9RSo3wuRGfdv2o+xktb/6LEvOe/vDlt6O92T/V4spFewAO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ddKtTzbpJb1CrmyhvKuR9DHA8DVEMsdWRZMRvDirvl2SSeqraNEgXnlm7l01TMOTHnYjOFoIjr0+f3ZU2QNl1WxGpP5k3GYpT0fUw8f41ROkSRLkEHU08BiFk1GFgDu4emVrW8v4WeEDG6FjObHcFqkyiDn8uQSD4cxrqCkDun3LjVgv9ar2jjdjugpGWkNRh9eSe8XlsjGJ7H5cPiXHv0rcNuto/HRa0EdFVMZiQJ9nttqni1XN1sKeKwX2mWzvuazKCxorEsU/ClhutXS/pu7sKDY0QoQ+mCBXindsO3wNx7RNC2l54n5tjYlOEQzyXw1WN34rrXMVJN1TAgiCD0NYFhtNeBw/N2xQGRZxxQJfsgfsz1a1NMpdZfkMTQOTduLYdWKEom1zO3ykWBZh8TBoBqUJ7h4sUShbCruDCcaQkFUqysbl0g6TquHwnzbH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:44:19.5137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633c5500-1e56-4fec-2819-08def20cf4ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999165
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
index dc8c650fc3416..b5b6b2a1eb066 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -78,6 +78,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_migrate.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -4102,6 +4103,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+		amdgpu_svm_migration_init(adev);
 		kgd2kfd_init_zone_device(adev);
 		kfd_update_svm_support_properties(adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index da77e0ef129ba..c2ea540e392b4 100644
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
2.53.0

