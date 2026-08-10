Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F77CC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD8A10E7F7;
	Mon, 10 Aug 2026 12:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="whKbpBCo";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BFB10E7F7;
 Mon, 10 Aug 2026 12:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNxLjAiNmAWPe5wYwhUrimxXBRqO/XFSTidatztBfmmEihqa2r/2DDKcUzUYVY7iCQ4QniTiphOqEvSvbloelyygec6ux2QaNph1Nz64DRq9RJlV5wzgMlvYbkTbcGXDrbcCGPhHQabu6BNxJnYDpPUPITmHIJpgKCgjTYkPIYWkgwB8z2Y+lZXJB5X7N+oX26sWz0tGz9GKsljjfYjlA0AxVt8JSuOQBPsTVPHBEYz9dYL2nHNthH/PkM1EAK4tJlFKsph+zaFg/wi6ACkDIFPByxeihClgNnNWBLmYFPZL8ulZhM6EhqYu4l54ICaBp/s5MEyCXxriPW43Nit2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxZpH7s81kpZqJPb/kQ/GA5XHLnbwUKYsF+zkilHtqc=;
 b=D8x4wZdPD2DkbpwjIKJaZnX/ZoHUYdLbSqFv8kOOu+J++PzFSd+PNRliL0q7JzGuAH0gLAJcVlbW05Fb0S8j3bNsopBO6QfKFVacZLXUAMeltvs4l0Ut1pzh8KaI4S5hrMN1d9mZkPdqQGWFujxYi8RP9PSO71yiXKsUGxw5u6BfJvuQMOS7hRQRsaI7EDtSLOSb3s6yvdiIvnh9PULlZMn3+6i75Wpf9u8Eq1eDDz6dbcIatJQ2+zex81hvKYk+rUDv/4/kWpKCi9ZsS3w5Z3BjzOcGdbWmRHCXKekmVO5qO8LnYgtAApnX4AXRo6m0KEsPHeIggn3pI1fV43FpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxZpH7s81kpZqJPb/kQ/GA5XHLnbwUKYsF+zkilHtqc=;
 b=whKbpBCojxb/19S0N4MllRMa/yav31uUMCJNs8VgnVLojN2OZJsW0QRq5md+7vmkMScGz8ZGU3eaeA/lli5/SxuFWyeLwMyd+l171woIyjXFRyOIH3ZdxwE37h6ta3ayf9P5feLFbHJsb8GXTzYSWg6e4CK3B363SSXpOeTJ9g8=
Received: from MN0P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::18)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:03:25 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::98) by MN0P222CA0013.outlook.office365.com
 (2603:10b6:208:531::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 12:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 12:03:23 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 07:03:21 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] drm/amdgpu: remove useless enable/disable of ttm
 buffer funcs
Date: Mon, 10 Aug 2026 14:02:16 +0200
Message-ID: <20260810120218.23000-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810120218.23000-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260810120218.23000-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: f68bb4f4-3328-4f3f-3600-08def6d760d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 43L4Fb+XqF0vH93ePqZZsqRWfePlvodA2V8rHvXgxsetHGYFGa5cPX2DzpdhtW4Zxq9k7+k3XCl8PdBIhEVgr6tpurj95BgHwMQKfBnLynct5I9k0nkrWGTEDPY7i4o65fO2BAGUeYqNLFKXxCVohGNOp132nmOcnR5/F6kbk5Ao21qCrFYvvmxne9wAcsfEgVQknlMlNFt7X5/HyMCX7B4dpVqyIWaIvjJflopoddLOjyt2mSoa+oxeTdWHoynVM7r6DcJMstI9kJ0oWimyV3yPi1eLlyi5vpEBVF9ACWDyYToUXTcYj6xK8UQHDWSIdxI6zmdnmH0vJyUGOBoTA3ifwmrY40P+GUrhWRFRBwPXpytMCoevTiWKuZ+pYl3ROPIyveoNYorKJG79cky47ROT5U9P7jzbB4ow9pYxIgf8e8uj4/+UxK5B9rmy/s9oWrnXFDeOxXMGGfb5Xnk5AAB8fI7LMGwg6cls2OFy/RsnFbuW7TwcUB2Hnel0njj+/L1dNci3ourZ4kZSFCeJ9B48drgCpu2HmYpmDlxQ0KHd9kKJNkqgFBe0d1f2nw96poRBG6i89NEJpI7g0ETg9DuK/V9AoNAgDB5qWjo8QR5buwsg4lmqAGjpjfvU3uGMBjWN5oOcSm60ztSwMCV8PzFmdwUqevwCu+4/unTW1YD+kZ1W2N1l+oMRFsL8nZUppfLcSYw8bCwJ+IfHsiHXQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ePverTeLmMjU0j7hfhWRtKFUYCaqMfbD9xRSAb2c1XqM7aquFkTfqNqka9/3Q7lc25DfSr5vuKOanWY4XBwmB8gJeGXaP2v7WhgO1q081k/SJ5TN7Oxz1keZ1buDGOqbn4Yzfo/p5EgqbTfPxC8GqmB4kO1wBuNShiaSZzPMHKNuI8yzGabSCThzzPj8QDAlC6xLIjmPq8ariI71LAfVILmHtL1d39UnsdTvE5sTZ/iwqFCfwjCdVLw3KOCPsiQcIGuw9bYXhxq4OYudzsCsRWjjA4932N5ElSBynHoy/Xu/RLocBPg1YOhQHO+DrGrqt7YoNBhDqCMeOY6/r2+9SY8Ly+3seiXvELJ3dyvyURqMgEWdislzeCMh0EXlCF5/oI2qEJN8i3sKZcfGG6l30hFaMydf6aeRe/yeABnf/5V05D6CttTXLUpimz6mDGiU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:03:23.5942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f68bb4f4-3328-4f3f-3600-08def6d760d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
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

amdgpu_ttm_disable_buffer_funcs and amdgpu_ttm_enable_buffer_funcs should
each only be called once per amdgpu_device: at startup and teardown.

Therefore the other calls are redundant and can be safely dropped.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1ec3162cb175..e966e6f7d2fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3379,8 +3379,6 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 
 	r = amdgpu_device_ip_resume_phase2(adev);
 
-	amdgpu_ttm_enable_buffer_funcs(adev);
-
 	if (r)
 		return r;
 
@@ -4511,8 +4509,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	if (r)
 		goto unwind_userq;
 
-	amdgpu_ttm_disable_buffer_funcs(adev);
-
 	amdgpu_fence_driver_hw_fini(adev);
 
 	r = amdgpu_device_ip_suspend_phase2(adev);
@@ -4525,7 +4521,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	return 0;
 
 unwind_evict:
-	amdgpu_ttm_enable_buffer_funcs(adev);
 	amdgpu_fence_driver_hw_init(adev);
 
 unwind_userq:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5bcb6a966941..ba99edbfe3a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2137,7 +2137,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	}
 
 	/* Change the size here instead of the init above so only lpfn is affected */
-	amdgpu_ttm_disable_buffer_funcs(adev);
 #ifdef CONFIG_64BIT
 #ifdef CONFIG_X86
 	if (adev->gmc.xgmi.connected_to_cpu)
-- 
2.43.0

