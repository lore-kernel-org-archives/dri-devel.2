Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1649CD6E64
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7440210F313;
	Tue,  2 Jun 2026 16:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QFEN2V9L";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2452010F308;
 Tue,  2 Jun 2026 16:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQu6gnU1t8ffYF+PgIUs2pTa3uqjDGiX2AIUU+8D+BT6wZdi4F/NuIeFYmZMwaQMU5Et+F0/dE8tVkwl5XvRsk3krJNdC4S7W9twOQWtDwF5VuEHcik8GmYzOjxC88AbcoXDZYWAmN4PRJsunT/PWsLHl6z94MTDCo9aQQhwEdJYJF8YLSyMaLrW7XkVk++SthNuLigBAITJPsiGn5ncyhw9w/La+gS+/8wP0l82Gtl4cuO/X5irf8kxA16YVkFptZjOSWfey9fxjpbkvG0g0PhxevmHsaILWPmAiyWWwTzs8iqueFWzG7do68//zoJnF66fz5gNcqzu26JTAq9Hrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9cg9jEWfd3fDPRAcbuo1B7y9u+HcHMclRnBFfiqq6Q=;
 b=QlNFIE79OLTEVpqWGk3dKdgIRcF/8/LBzCqL4lzL7J0MYpqIShNJQKulUe5tkRFePxYe3WUvnsPMboOnYIcNqrti4qtlSxgCmgL5l+/Tvc77qxhTeVnVtMu/dFcJ5aOW3RXJYiGsJK2zojSxospl4zpF11PpP1KxFzugCMSVjgVxonKK83e9j00Nhg/Cu3AqWUsJc/slOzSfr/zMCR3/4qXbwQxDO2E/s22FtvcDLPnojxcvTC88WYXd93czVFzqLvHd68zTYG5ZL36JjenYaDDQLC8aohZ8pUCT9JtvJHcMPeXsdLGmxQ0JVLMJuwhRl3aSTbGowenTFTlL5vg4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=igalia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9cg9jEWfd3fDPRAcbuo1B7y9u+HcHMclRnBFfiqq6Q=;
 b=QFEN2V9L1JNJdjVMR5bv7d8qzAk3/3pja+uSzUJ6Vz0rBSGOLZ6jkf7iDo2xCNI8GdbpUbIXxMDdipsOUmvwcA+OS8dIq3OecKTv1XPKCPtXf4TReI7/AE+UMhCzhH6GV3kdOLQ4gX7oGwe/cRQm7o3ZbxrQcySEmEnDKqebqts=
Received: from BLAPR03CA0050.namprd03.prod.outlook.com (2603:10b6:208:32d::25)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 16:15:56 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::5) by BLAPR03CA0050.outlook.office365.com
 (2603:10b6:208:32d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Tue, 2
 Jun 2026 16:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 16:15:54 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 11:15:52 -0500
From: Alex Hung <alex.hung@amd.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona@ffwll.ch>, <ray.wu@amd.com>, <alex.hung@amd.com>,
 <ivan.lipski@amd.com>, <Aurabindo.Pillai@amd.com>,
 <srinivasan.shanmugam@amd.com>, <marco.crivellari@suse.com>,
 <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Export symbols for KUnit test modules
Date: Tue, 2 Jun 2026 10:15:36 -0600
Message-ID: <20260602161536.3909009-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecd55cb-b92a-4c08-3d8f-08dec0c2393d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: NVcaRVnsrs/oCnJBxoGim/1ISWtb4Hf5gzrWfQUYwLpwNhMbbJcC8tEOLgSLCZCBtXjQKsPzBQRtkJRJFokge692S4K24pLY+C9gcT6homT9ecCUd3cbwyKiIiJaxmqcpZDRocn/YPexspWW35RFbfgyjnsZvIL6NVGviUFgOuMSUq8cvbFIs9uEHWaKpfwre/cIjZ0HY8ped5sOPE91SV7NC6pry749hS3MkI3f3XkquRfI6OTNWmxLLIsCMPwODyxb/bAtnwoqZH0f8LjGmJ+kE9bzfbUfI7WozsH/IizC/yPe7w5OM/Yn6HGZXtDu8zpBZAmr13Z6/7MaVfLnyYux8dgSoN+ShLaFD+DJoZMpuL7XN3H+NNJRi7DLivEiV+aR3J9JGusQspbI/VSxIwkELrPDv5ArbPDweACPbYKxEpsl2VMfoA9y5Mct8nzPwaHiOGoZ82a2MFuAr8k5EK2Qb2jJW8IQCdrj/QDQfePahr4WxRYkb4eaFK1KGNYOvXQ8KU+lzcFUKV+O7oh+bferDD08xP3f1tKyMZA3IOIOITOFp/RNtV7RsZSi41LXw2QfBEbKf9sO2YakBH3fO1BDSt5wK/2T/qUPwozajsiUb7izqbGmt9Eq0I2BORWJUmQkaNjYnmAe4B4grU5yUc8aZgtOwZ0AcEO8e5WYbrQkQeOaZA7rNAWREABhzVTcNrh1WrMjhfpMu5vOnPh8Oxe0Y8TT4Q9Ct5XLwClhto9Io6ObAzkS2qQKw9GIpy0weTmXU8YHeo5iHB1rDeBA4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fxj+HadwP12xcYTOBUe14ecOWDEr4dmWh8X3oocihjJoVtVq44/SZdfe3Si+9iEj0PgIUpMdllustaZ1OoARZeEbhR7omfU/3rBQmnGgXytH87cg3gF/ZKLXOigYDOnnipjIw8YpQxoFU8DoNF/yR/XitbcO262ecdQiaxsFLjDB6S+JMYyYLIoCDykRvLXQKydkvWrAmwx9ZUpcb1tsus27f8hIuMAYWL7RZvREcueK6jYpZvWry4DGdCm7R+tm8FjQDji1yR5KO2oaUHX/raVAPzSAC/7DiOcJRA2rYDunWBY/PgJWA/dq2S30KbQ2p8qjibFJp1zyPs1MDk9ITkjX1c1ncfJS6jmgTi71Grs013HwKWYt6K2mV/gxSnlT+JVtwM+LIFnlLWEhn5YX3AhffEjUBgbztEm6Cd8u/6Xu78DKpDcqMHrnLS43P+Sk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 16:15:54.9227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecd55cb-b92a-4c08-3d8f-08dec0c2393d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
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

Add missing EXPORT_IF_KUNIT() calls for amdgpu_dm_psr_set_event,
amdgpu_dm_ism_init, and amdgpu_dm_ism_fini so that the KUnit test
modules can resolve these symbols when built as modules, i.e.,
CONFIG_DRM_AMD_DC_KUNIT_TEST=m.

Fixes: 7c1bb28ce2f0 ("drm/amd/display: Add KUnit tests for amdgpu_dm_psr_set_event")
Fixes: 4db0dd9e5a63 ("drm/amd/display: Add more KUnit tests for amdgpu_dm_ism")
Assisted-by: Copilot:Claude-Opus-4.6
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 2 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 5c0841728671..32391b56097e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -640,6 +640,7 @@ void amdgpu_dm_ism_init(struct amdgpu_dm_ism *ism,
 	INIT_DELAYED_WORK(&ism->delayed_work, dm_ism_delayed_work_func);
 	INIT_DELAYED_WORK(&ism->sso_delayed_work, dm_ism_sso_delayed_work_func);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_ism_init);
 
 
 void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism)
@@ -647,3 +648,4 @@ void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism)
 	cancel_delayed_work_sync(&ism->sso_delayed_work);
 	cancel_delayed_work_sync(&ism->delayed_work);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_ism_fini);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 85caa8534184..0dadc0bb214f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -189,3 +189,4 @@ bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm, struct dc_stream
 	return mod_power_set_psr_event(dm->power_module, stream,
 				       set_event, event, wait_for_disable);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_psr_set_event);
-- 
2.43.0

