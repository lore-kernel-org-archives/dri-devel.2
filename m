Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF53F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5550610E41C;
	Mon, 23 Mar 2026 20:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HT2lfBvx";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C3710E0AB;
 Mon, 23 Mar 2026 20:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT/l6eUBTrAR0Xtu5WNKB0CUJO215Oaa793Wu+eCxLmJF26AaPgJ7+QSiFK5jTTkHzr648HqNt1AS7YF4B5NgWG9o7/vEU9Gt//bJMJSXLK3/Qy30nITun0adOv5bsKyi6PWcnxidAjKLU5Rp+C6VRiC3oHKUDOsom8h0gDT7xFEuyxwKwxmiBANeI6Ngy+IncFYcFnIaS2Xaj918/d8lJXVsPC3D2PGAN3eJw9gPqTqndWqsKqK8+I0eBbRpH7IBFATkaAQ2PUAv25A/lgsEFfIhApEgiiEbThBZ/Brm13AIOL4u8AkwMo6XidluUE+Rj1UzmkHulWHvl4kuD9HVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx/fHoFagXLx3gjjIB751tAmDf7jCgcMbgM9//qax54=;
 b=PWqLp4sPBDrlAd19RLX5x5SRFOmxpE6uzEfYHSi/tQEiWrHMzpw5m63B7qHlgIuWH47NDrf8N6eiGf9ku2jAl0V15vCYL9gfSCwamHPaihXAy3coW/vq/wnfFxm4iLFnHOD+yUYBTx5cYJBLsI8+ZVYJy/OmmJLG/LxUpgR6iSOEN9hb5A4vPZ6HqNKgiZ8UAor06IbJyEN8FhhbRXkGNjrA16BSjxsWTyaA73n0sVr/VABHKthkteV/jLSln7//rArf+WN3lG+2Kw+7T954VQ7SlWdmf0eqJCkeqKatmvzGH8XMLmCQ7IHIf1UAkKF0f2gVrUweySUU7kzb5LGU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx/fHoFagXLx3gjjIB751tAmDf7jCgcMbgM9//qax54=;
 b=HT2lfBvxOl6JH4r8kcQ+XMldmhUqD3+7dpO/sfWJ4yJNB+JxGzNDSN9Q0fCZBI2UIl0MJgVS4KBPDB8RkZrPs7yJUodfnIpAVAG2zxQ90qw83/6uG/EnUGZjBjk4YzPWKl9gS0p0d9vvTHdru6eXqodBIphgUYtyKSPk6PGoa7c=
Received: from BN9PR03CA0104.namprd03.prod.outlook.com (2603:10b6:408:fd::19)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 20:30:05 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::a8) by BN9PR03CA0104.outlook.office365.com
 (2603:10b6:408:fd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 20:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 20:30:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 15:30:05 -0500
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport;
 Mon, 23 Mar 2026 15:30:04 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <simona@ffwll.ch>, <airlied@gmail.com>,
 <jani.nikula@linux.intel.com>, <ville.syrjala@linux.intel.com>,
 <superm1@kernel.org>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 0/5] drm/vblank: Deferred Enable and Disable
Date: Mon, 23 Mar 2026 16:27:50 -0400
Message-ID: <20260323202755.315929-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 57821205-1ca2-4b3f-2a02-08de891af7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: V16vC0E8rtCvJS0C/MOxj11twYJcSIyZiQbZ+3gjOUxsVRYWGLruitMDCJQqao1mBruIiRZrHU/ME8ZGSwFmnh0/ugKpGa13NY8610jbpfImgU2FHYfXTQqYqZHqDO+0ka6nHD0rpR5/0CQN0+A1+w0+rE986Hc1Hnm2U3pcgHcHSMp7bMUO7m+SzGIBjwuOXi1S4pm7Vfy69ZSBLpYMYOunFpI7JzRbxD1XAid76BOSOvjD0VFDdGbFCKUGxP4p9gTviXxkrIR7zYrrx/i9+jMoGTr/jQKglPjVCNfEVvZ2Z95cXXw21C2FDiBk71s41pTxCN2+gCMU6MYpwcEuy3obI8Omqw964sa8gGbpzbCfkMuG1FRqOQhvwloz9xYaVCEMFTAI6y8gu+ntK6CYfQ6YAWtmhWD7fzP6vPeK2I1HdPcDVfrS7jXwZKPeYHEZOHzqI04nFjMMB8VJWAzJxioKoIz4lh0p9Sxbx8Kf4RdPOhktCHyaB+kC9LG1UaQaaVZeWpsDjEBvWXxzj7VcXU781VablEsIS8A9QP5XW+acYficLs0kupF/MssKtoiYezRWClWRSfTNweEfKRQYA8gSinheIcPvI1qDr8P2cJNhrIjoWZzXQFNEM8+pPQd/Wa1mjVPt+jCaiSh6Zt2KL4BlCU2qNbV8eZd0Y23dNuOES44lSpsIcDGN8q1sCGF2Ce2IHg6sCItAItTuqtAE5mckScdx3zkW4L/RcPiRDCnZeDsnYI9/T8r/0buUXbBwPDuj+OGMkfWEMvnDQvig8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l8tq8JWjhzet4gsTtyYmsryD2I5am28Lkio/M230xFeGko3CVlYULKy4QV7qEj2HdTApjmIsfkghJATghD2EX8WOe3yGUCf+KQC8R/BmvateHuropHVPFmTLGi1l5gx847N2cEVNryI4Syg4NbyTqi+ZiYGZlH9UYWibU2hE/lxUGcVVg++Ih7UDfKQZzQyxhnKEzPi0xVKfVNKe1wrJ96UukI86vftb0iCbTGJ3Om5h06T7S0B89s994O1mnDfAFfvnlb7EUwtfXpQuvficHWDAPqNOARHboDDTId1yQkxCgZJBxw02HvTuCYvVjVxgChDLef+WcftllyBjOXFBZazIPt6qRBl8FGsTeYpQv4iMlsCrTv4SNBHUU5HHcYXxYzx/ZJQE+XE/biVdRWig7U+4IbKXRrdhN1SsP8ZW8XyjyJO8jfLLQKRpCDAkIHy9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:30:05.5088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57821205-1ca2-4b3f-2a02-08de891af7f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
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

From: Leo Li <sunpeng.li@amd.com>

See cover letter from v1 for motivation and details:
https://lore.kernel.org/dri-devel/20260224212639.390768-1-sunpeng.li@amd.com/

v2 contains fixes to some failing igt@kms_vblank tests, namely
* any test that calls wait_for_vblank()
* ts_continuation_dpms/modeset tests

Fixes are all in patch 2/5, the other patches remain unchanged.

Leo Li (5):
  drm/vblank: Add drm_crtc_vblank_is_off() helper
  drm/vblank: Introduce deferred vblank enable/disable
  drm/amd/display: Refactor amdgpu_dm_crtc_set_vblank
  drm/amd/display: Implement deferred vblanks on IPS platforms
  drm/vblank: Add some debugging trace events

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   8 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 263 ++++++++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   4 -
 drivers/gpu/drm/drm_atomic_helper.c           |  11 +-
 drivers/gpu/drm/drm_drv.c                     |   5 +
 drivers/gpu/drm/drm_internal.h                |   1 +
 drivers/gpu/drm/drm_trace.h                   | 112 ++++++++
 drivers/gpu/drm/drm_vblank.c                  | 239 +++++++++++++++-
 include/drm/drm_crtc.h                        |  34 +++
 include/drm/drm_device.h                      |   6 +
 include/drm/drm_vblank.h                      |  20 ++
 11 files changed, 654 insertions(+), 49 deletions(-)

-- 
2.53.0

