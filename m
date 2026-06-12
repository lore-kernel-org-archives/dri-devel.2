Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E5ECD98D9
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6705210F39E;
	Fri, 12 Jun 2026 09:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ebWAOtwO";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E7A610F396;
 Fri, 12 Jun 2026 09:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoaapD15UXPNUJDOppR+7a8xWn5jSBZPx1CBmXmBa+Ak0PuCGgHS4FtsPGL/xoeESyycHmZIhDHefAxHkN8Z9NKnvUL5D3j/QgpQFTGMICACJli8kszxLmuJ4ZRWqFhcc5RlaFljg8M1XpGVr+zmhoJPapjCl/jzz9RRnrBMXzVPMFLYH9bW7ESPFDHEw1/QwPBkH3pJelQt9QzpUIs2mAhA4MxrT4dJTVcp3CPjb8ikjcO92j5SsXlPlb6ym0D3r2vDuSG9MMI97xaTiWpvXCTbH6BOrpZG/cksb0nyh2lBu/fjwuvfSYAmX8n9carlJHM8ecfEsOLcyhHAczwHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iBZr/42FOYZPvDOoadtnPKHf3RJxshzt2ICCiocSI8=;
 b=lah/qfXSUmNInJSxrGdXLKilKbjCg4SgouDn+12femVt9NCkdwvCMeJ9CIb+3Y9RxxRgGNwiKbLzsyIvKnpvoFelCmgA3W3F5Z1BgK98vf1ElpgQ0VwwGKbraHbncmbhDkvFCqoXv6F5MMafrwHj6SAS+iNJHftIQ8pTRNr4IhxrQA59b33u2PAwtHvYyXl0zxtzUOGK0VHBwBMphN42Xnt3jJvi1uuhTljSw73ub5kRCPTKWYznfdom4eqKhb79iQl5KT4wZ9eLiEus2iN5KhyyCFZw4VoUeXnVGNWjcUXyrChnm2dr3+uFgdLY1kmkEbS06RD+0senh6R3itRI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iBZr/42FOYZPvDOoadtnPKHf3RJxshzt2ICCiocSI8=;
 b=ebWAOtwOdxJwNT+gVbr0Ix2NfN23zoTef0ZvPgwmLXnNf9Zgrn1r2gsV1YjUvzv0KMrlmStXB93kRlHEmwmoLPwqvmnaCBtG7hQlTitVSEIlBAmA1T5OlzAYB9grq+uQd9GDkBVhYX5EnLgjwcT6b65zNFiY+3Ir+aPwoW/IJQU=
Received: from CY5PR15CA0118.namprd15.prod.outlook.com (2603:10b6:930:68::7)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 09:11:21 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:930:68:cafe::7e) by CY5PR15CA0118.outlook.office365.com
 (2603:10b6:930:68::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 09:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:11:20 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:11:11 -0500
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
 <yiru.ma@amd.com>
Subject: [PATCH v8 16/18] drm/amdgpu: hook up ZONE_DEVICE registration in
 device init and reset
Date: Fri, 12 Jun 2026 17:09:18 +0800
Message-ID: <20260612090928.29682-17-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612090928.29682-1-ray.huang@amd.com>
References: <20260612090928.29682-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c40f3b-6dfd-4dd4-9271-08dec86291a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|921020|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: XgaG9eEcSXfmxA4rKJPbGD20paFS7sanORU6bufiwTOkCEKH1BEwOfE+d9SVB7VhV4Ym+nz4EV7XSMJV/Fhr+F/+Nuu2yvLQsRcwYbAFqISWiLX9OTTMK2FpfooxIkd6x6ZFEopUDqMLYLnmJ/yAu1u+EpiLZn/OFnn/jrK9qdAyeCaZwYADDSsbfaoe4t8PK26NDyCd0Ba2MRffPTc5VLSTudJi4ydXNJZrHhntb5Goq+G6KDjL9T8Tb4CMaeE3iGmR0OXX9BKrUFCe5KSxs5TD49uUP/92DjjAnaK/qba6TRj5FOnWVkzMqzeEw4WcUDRCblnJwvqMZQwM0FDlQL9hGprN/5CR1fKJpZYvdcbaiBAvz5ziZWo7i2j1olqC8NThRT9jpLh0MCQYY97GE8l/b8Y9KazjpK6ZAJeBPFUdn8FUtijy6ncWAkMO2lGME5hoo7q25JSHxij7nYL+hiRIbEm4Kctvkc6RjwSKuaoipJn3pRzNF6s2zQassSTHvkSWp69QqDa9YA2GaUL+TNFVG6g0/Cc0oQxBeKzzjaojwD5pmhOl5rFnzIMXin8o/AllmMOBEfZks2Z5eKb8Y1cGowVfY9as9Bfz9Tt3CUz6Xq3W9UmNy81ngHflJ0rwd4RncLyYZbuRaXRo2F1Hb4HOl3yOgZ7LVxfd5d7nIQs9VS0cpho4tMOK+0Sg68C8HFCMA6u8SxyzC1AqRdfo4pTqbTLxvoQ6+RInlTeA7lQOlKzq+e976UkanMlCd1OANMGQEj2t+kSz83d8xXpnOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(921020)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +xolLPyP6XEut2lt4rNVFWifz4t4MPBkBxTgIndYVqd3gz+PsiUca1co1nEHJtxID1K/hwLiWZJo/7BVC8d2T/8dnqyC567RwrieBeYBcHRGEpNNAMiVwreRaVbKtzRBAhctvbP9pwbPxf7Vi7nzke0TsJj4o5jZlggeGUHnuqFzAckydrc64i/MHwFOQqprAsMFBDxYOaucrNtlfdqrGm/X0lOJSSCqTaY2DUg/xp7PczqLAa3HR/QN3OuYV7+wEbSU5vdYxwDJhRLslBFzBv0IQTITU6f990pfZuxF3v3/s83yN9WgVky+aHv9FtRbCpq7FjVFGL9GMjgQvKPVBQcKCY1A4+7yNC66zaU/44Yncu6/yA70CYGMStRWxGzsbs2rWWeEdFSJ4E0skdn6vgmDSbsR+33fH3RSn/U+Ee3duNmZU5bt7ZEX/na8mXns
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:11:20.8876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c40f3b-6dfd-4dd4-9271-08dec86291a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
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

