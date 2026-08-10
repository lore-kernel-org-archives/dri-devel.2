Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA64CC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA55210E7E8;
	Mon, 10 Aug 2026 12:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vDMK92ge";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18DE410E7E8;
 Mon, 10 Aug 2026 12:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXdwlFAtWBCf/cu8lVAwRe3ntqiKS3yuksBRCawutsemcj/pRhb0XcbYXSWD0N23V8kpEjm3V1MfAhqvkS039qvvACdtKru/tvI62P/GkvqeUGE1dwBindSWwtLeKZ8ksKbD1rnsQgTH4G5yE+0RU3TDMsvoHLmR08n4MDUyda9DwmG+Bt6ZCBIFN8DDTgrPCXcWiI993UX8w+sNeRART968zqFeaOTqvQP3KpDQ47h03XGKh6dfIou4G8EA+SluAgZhw7i6rwWM3yvUZL4sroKu37Bb4qdxOGfJahH2qqV90z0lMQ8Z2E4z6KNJhjxckjWjudSABzsIojDy0k5RVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/3aRSGV6LtniVGzs0AI4k/74O8Pn8blhFUduVq8wek=;
 b=hs/A2Zfe8sdVWiqENvwy/y8DHII5ZMHQUxBBVV01sSMW/x9XL3589MJS1gvtMlaVqB9j86fpnPlsyRTkuvdG/j+e7W9e2i3L2C8dztq/TorkUJrCrptFokHN0LB2vay2VV2EzeWSulbzDwPK8Fg+/N/snF5d6I7GF/WIwAVyrBkhS9VyMM6vC+kO3bNJMq665nhDACQ7pwjxxsEsxBKuWRxnH77FMUG8N/Wj19OfdQ0RiEEEqiImkzpcKMYRhsu6McoCSBWgp8ROXucEN2JiCvOTrmMo46Nrqd0FsDssXpZqGr7o2ao8+Q8/5X60RAC3kkGAfjkOIBOeBWNW1p+gnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/3aRSGV6LtniVGzs0AI4k/74O8Pn8blhFUduVq8wek=;
 b=vDMK92ge4CdM0zSiCLF3yWWBy9BBArKZ+P+b7zCFMvzyF8ZYNYJWg6jl+3wfJo8o4Q4qsxblqBmoV/kM6k+CSXHRyniLHkcOsodoULYUpl/gr5kwztRqJdQqeianOuCdmqWEdyTfghJvcF2ttWy18BGjRb4uKpNRmEvabJYrL7A=
Received: from BL1PR13CA0271.namprd13.prod.outlook.com (2603:10b6:208:2bc::6)
 by CHAPR12MB999247.namprd12.prod.outlook.com (2603:10b6:610:2ff::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Mon, 10 Aug
 2026 12:03:01 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::5c) by BL1PR13CA0271.outlook.office365.com
 (2603:10b6:208:2bc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Mon,
 10 Aug 2026 12:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 12:03:01 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 07:02:59 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] drm/amdgpu: don't disable ttm buffer funcs on reset
Date: Mon, 10 Aug 2026 14:02:14 +0200
Message-ID: <20260810120218.23000-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CHAPR12MB999247:EE_
X-MS-Office365-Filtering-Correlation-Id: c62f207f-21bf-4d14-3010-08def6d75364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: aPgMgxYRgvY/FIjtlCkWDXMeoamdDIjSrBZy4ZCWZNBglOkVoJN9uiMPgTWCXl8L7flNHgs9F5tkAesNvktCCwuUzp1G1IXEWrdi7A3JTynXMRwqeJrFF2yakSazUTjIHFR0b06ly2y4daMHT8v1YHxtcDyVslEd7MRpAD/240Vs5Ka6+abEIlu53e0twdv+Fzv3yVoi1T00kBshnMF0N1hLK5GgHH/h4oDP1UZiwxkyGoVb24BwZdl13rCZJOZE/Pa2XyVDXNwLW+pEpdFj72X/o6dj1KMyT5xJG5f6WJZPxFm+ZSAwkaiVSWPmYWwYduPAAJnH4nfQ5idkxmXETr3W3Nr83cvKgR4BGYxoqHFJli9AIAkctgAn99z5Y12/Q1+Qrb4eUufhZp21tq00q4/zB9So6vAM2we9tXZVCU+SUmgTxDF3rGFQG+A8qGbEp6M3bcmdkNnt/Fc1miH0fD3XO3BE0hqjR1nDy8dyByaI/APl0bM71QkbnFoahdy/sAz6RcNJ20/26BtywvVSedAvSiOTVPxgjODLSd8n/rE4uoHqfy38vu6vTH9MWfmp5R3dhTBwsuhrVkGtUDobmmzRvFgZwZfIT+hdctKAkzNz6j2iU2ky65Y52wJCS8Hhix92A3FmgUOK+4yae6oDBhy549EVNNSsByluQ0RJEh7L/8bAMaVGTAcxtcZXkJOgc3obUG+h6ckM5n5kWl9BqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sUiUp0djdc8dHeQS3xcUZUnGRpmmgHtMguLZdkKALkudsEpDvATFb/KxerBeugFCQasnxD9ji60pJvP2fRcmn4HJiBxKShB2r1WNN9SKgN0vDj5MJmxYMvsWUtHUo2km/MhQq1Kpf8duc5VUw6yVsgeJ9bJuco5BkWiFRGMdZD5QO3lHlcDKnrLwO9ipgq53Do3o0SdQnvahugPhYQsv9w8u5oQOj3gL+Ivyzv3x01HywFqk8hgngDpYB3Ro0uB7Ql2rFf/CX/Pe/UUzzgc/Fjw4+VbMltaubrBWz3vfnjsHWMimyeSbM8D+ORpdhC3JV3ht/NYsp2h+CN9a6pX7yFPtZ0cx9ecY5METfADjkfYksBnK1IvlR0QrJxp4HES0IaJwPlPK/u+xTmIzpNSYxso7l/rJZVYWXt599fhBmASkd88g4er8aNlyixwxPh74
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:03:01.0237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62f207f-21bf-4d14-3010-08def6d75364
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999247
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

Access to hw is already suspended so there are no reasons to
disable ttm buffer funcs.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 964efec0d335..b7751dde2894 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3162,8 +3162,6 @@ static int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 		amdgpu_virt_request_full_gpu(adev, false);
 	}
 
-	amdgpu_ttm_disable_buffer_funcs(adev);
-
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
 		return r;
-- 
2.43.0

