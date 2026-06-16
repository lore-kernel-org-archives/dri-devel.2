Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB7BCD98E6
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5240A10EB8C;
	Tue, 16 Jun 2026 12:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vg9wPSMb";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B979910EB82;
 Tue, 16 Jun 2026 12:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvAPlzAMlxcq7QMLVHhZKl2TxDo65Y5Nz3zYnD0L/mX4dOiCC9UZASBLTd7Vk+ucOBmHba0Sf4H3iznsAJaj+vSH8gE6k1aNJkT/fY04J4JzKeRMDpsw6iwxzH56+izZUYdwbmZjIaOQUDd+zSOgfL1CebQDtPVLvYMtGL3ErewXHn0txVhOYWR60SulUtmSqvWsVXTmoQU3hOaex6L7YXCMfFDJO3KeViux6AgxpQOQSPHNfhlGu6vCRTkYENFFmzWvyaXs+pMRu8xhG3x2aX+VNkmOBBbAuhTFwDEse/X647Yv5Uy0JYQk0iSkDCqyZ3zOnliTEEt+U18/9ADZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duogGEUR9FMCGuI+ll4nO+UyJ+5ncsyjknuANRCLIXA=;
 b=ugiDKPsKv/KKFZup/ebXmb1jzoqKsIPPvJrn6nrOJ2gVR8EHPd8cTsEQHESFSkyRsMinHglxuzqkhn4gkSna3tbijA6uKFR8CbzAbS3GrYIC5jJVRutP2+hoDs7UGk0yoW9pY20SEKJ+VtEYPGoUerUbwPEzFXmTvN+aUf4Lr29V+PNaV5+XrtGa4laduFJ/aD6b/dnZa9yldRYNf5axsDhMXhver4iyKBfN1FEfTk6yOkMPiLlkPLIZQB8t4opv0t0wy6rbuE98904/QakZMnnHWv+AXPiqpGA+53s1V+v9rxWrufts3WY1Zn/KRlPE+b6s04HW/Q54qDxHvUr1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duogGEUR9FMCGuI+ll4nO+UyJ+5ncsyjknuANRCLIXA=;
 b=Vg9wPSMbLs7kjpPBZZbuqSDaXpx6cb9aVFBHLxIbqNQNaOm0nOvHPhMNmDO5idb3R20oKM1PBV0eTbb3k/DmMLcLZoDgIAB2KEV8ZclJxYXGaAHfL4NZ9wcJ/aySgXB62BUO9JLfLHWgooicmrZFXjbjITx3ekdCUXRMkudy4b8=
Received: from PH8P220CA0056.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::35)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:51:07 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:2d9::4) by PH8P220CA0056.outlook.office365.com
 (2603:10b6:510:2d9::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 12:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.0 via Frontend Transport; Tue, 16 Jun 2026 12:51:06 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 16 Jun 2026 07:51:04 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] drm/amdgpu: delay ttm buffer func enablement on xgmi
Date: Tue, 16 Jun 2026 14:50:39 +0200
Message-ID: <20260616125040.9977-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616125040.9977-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260616125040.9977-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e342e50-7980-4fde-721e-08decba5eeb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FcybdjYENxzkCql8eb9oopd+1fhS5eSKl4zEEBVbQtACly2QUP+6rNakn8k+jz5RfMrb6OHFEGcoHncr4lej4zWLqK5EWTL1MmZ9UGg6LuXgtjP97cbkImKSAhjBgOooMxwzSUaWWml3OkdF8LKDGIroq7+OT2L5ut3AMG/qrz1pIcBpbCf4lTgDC3nOxIU8SqjWwogdgrVwel5lyyCZv4DKOmolvx85NGn6b8TvbRI2jzzn8GbrIrX8V+lrmIfjQeQTOAfSyLs+p127fy/uZoejpmNbSIC9JLK77Iaiq3cJbBGcUzWTW/9dV4coY/9lbfiX+wO49GPL6WQqFetUADJ9n3azwMuuf1fvQeHWci+UVxn0ssHcO/01/CFADxwM2TxelhdPjQI6TtPP+RXfrE7spocbXNjSl1aEBRvIOgifl/8rs22naK0gVkTkDdH6mwNvo9v72M7Kqid6EtYSwikZSle1/tDzXGvxC2DlfQdQzKmBayBNDsCZ85gWuQLbKm/vQ9zujG1GSHJFEUnv/M//AEcY6qfwBpWSra+628E210iW2+gkrNbEN19+eIgWL8h9QfjYkWZbyHFvvviwOyqvxbpPsrHLQEo3KpsfeleIyxrhAmxRsZSceB3M+zv2/wsdI703jl8Q9+wX1P/f9OCRxko62ssDT3ZwlImmyM270xgZm3+Si3GgeoUA4svQPkNuBF6QwAG3RokI34OBuvjy2pYOYi335A7W2I/nzBo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KnB9CTKTa3saqTDXbWab5fxuuu3hNZU6KVZkMbqe67bfJTjhIfRqUKZKl9hZlEkvJZi9jJNEcqZm1hhCsivderdCgtWSBHKEZGKbEXWtFFAUM0VUmBx8m2GVp9JM30aKYO7OrAFHxd5idzHUYhSTLg0P2sQdG2QLpteUu1zrlhC5LngmPjLhT1G3FngTi+tHFYF+uK/FQ0KfLnOaSVzzzA2aTNAplS2Pyxuwjh9L2/3c+/4z++ZoHslTB3eflunzjruvrvnClGvDnxgBO3udd4mn0ClVLkOOoJXDM9l17WGsVVw1CnsEj4L+66WmuoGZk650qRFbhx3JodBDcHFEFnCa1PfTmDYuRTD9xSpNp2oenJ5bWeFZSTPShSshXV9ztRn7sofdTDXmLpoCQE0M0sh7Vm6Ih0kImTnIKi3T2VgSN7ebD5hf/xZxA10XqcUJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:51:06.7593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e342e50-7980-4fde-721e-08decba5eeb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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

When amdgpu_init_minimal_xgmi is used, SDMA engines init
is delayed so amdgpu_ttm_enable_buffer_funcs must be
called later.

Without this, the check for num_buffer_funcs_scheds will
fail and using ttm buffer funcs later will fail.

Fixes: 3a5da695c8d1 ("drm/amdgpu: only use working sdma schedulers for ttm")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 57e10afb4714..2e8954fa5c40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2479,7 +2479,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	amdgpu_ttm_enable_buffer_funcs(adev);
+	if (amdgpu_ip_member_of_hwini(adev, AMD_IP_BLOCK_TYPE_SDMA))
+		amdgpu_ttm_enable_buffer_funcs(adev);
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index faac80a8a6eb..c0dca209335e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1663,6 +1663,8 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
 		if (r && r != -EHWPOISON)
 			dev_err(tmp_adev->dev,
 				"error during bad page data initialization");
+
+		amdgpu_ttm_enable_buffer_funcs(tmp_adev);
 	}
 }
 
-- 
2.43.0

