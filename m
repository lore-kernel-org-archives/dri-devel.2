Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9780C5DF67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1459F10E51D;
	Thu, 13 Aug 2026 17:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="08zP6Ik3";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EDC410E4F0;
 Thu, 13 Aug 2026 17:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBQjWPH5Btx8CMbYh+7QcEKNUGrCZ5DCOi+PyAlbdplEq5udK+sitWvybfMFE9YTYsyLdZiE+6cC5qphZhYSa0Wc3mNIwnmXTe2SBp2dVQPxbEMQ83ix7GnEfXLXho8ic2/La1gWgJq3Lnblb+XgjnJQkt6PCz/+OfXt9K/zqQ6II8kZDZ5s8Yy07DmNNGAZC+v9qf5FOC8CmNQcWxsqZUKz8Mw8HavEOm5dx6SDqnEpQ7y9mdnD16abs6HqXxzjYbUWbPBp2ELSJ2PEgTHxrVLoHryFLRLn3z+Tb+IOgg1wJVTj69MYBpaGHsN41XxPwNCXgmJgjF9OLmrAWbEeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IopHJdkEQliuWZUqeOLGuEOmHT5/BAxN5lMj58Bc7E=;
 b=rlP5Z5ld8gmA55ULoiLfQwInIHO5Mce2KULzL1GAnT8Z4CZ8S/qwC1Gt5ip9Orh2k/I9/r8pXDD5QhGOAIHP5bE6vwId3USX4YKOr53IIHNusXhAIfRWTrNlP5W8k3fqwQGJW1UX0TTDRTL/SU6FVLdD7tHEybZDeqSjV+xVSxC5lg1NEI/IYNgcZTF0DGFB1msDGCbIjjscBd4RDXtfjivyLRj0Z7hmJU/kOCJo8fXWg7U5JviL8deUE//FyuB+YiPVSfp0z0ts4QBLQe4qrOqMtr4PCCvuuyjs/3sCziHshvLQSA3ScVcgLrYfXxQA6Sv2R9zFuPIanvqdmFokMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IopHJdkEQliuWZUqeOLGuEOmHT5/BAxN5lMj58Bc7E=;
 b=08zP6Ik3swIv5NEjVKMm1dDrKstb7UX5A4jDWzhriy5E/MJViqYxGTr75E+uM5X72+s41T+4E9cRSzfJwaVIHZ2w0mxOLn6E/U8vXBqo2iPPFFNVpXly1yGDZ4upja7BdnMXlgDVAwhQqZ8LtNMa94lEYCzCVfMEiI4EYddBFy8=
Received: from PH7P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::25)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 17:08:00 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::7b) by PH7P221CA0011.outlook.office365.com
 (2603:10b6:510:32a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 17:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 17:07:59 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 12:07:57 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] drm/amdgpu: honor gpu_recovery_allowed in
 amdgpu_job_timedout
Date: Thu, 13 Aug 2026 19:06:59 +0200
Message-ID: <20260813170705.15745-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ead004-749f-4a5d-4caf-08def95d6d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: bSIKX5eld9Y1WR11xFDL1xAW14KnpNcIgj8xfhpPOuspRS5T+PtrZwMFBeV8nPoHrdfH7hUBY4baF1ZA5SDOvnV3lK2oGL4TtJSPjcEClSnYQaXqe6iHPTs1/JOgQMdDyOs939g5MD4gm6hnurUcXGWQOzzbLG0EJl+q/SZ7jNrIbI0DbwlsN7cBoPhWfg36YT4DCcEPWKxdX6otTEZ0Z23Ge4UupAsYVruRS12g0q8P5x4Hd0AXk67yWmAU5KkO5gIlCb8/ccWBhzjfPiKSh09nlzWSF66Cevn6URKIKEVgMaWmlTNrIGcL3Jq/sgY2/t2bxpCdQsR1yXgjr9td1Q0I5hmai1cq2WAx9htb0V0zEeitL9kXnS7OHrOTRUAOoQkGRNmXmurIu5gLwxTFpDE/T2rsqLnxH3v2V0iasMqFDtj+bymCVWssxCdunTTdH6LJV9fP1E/c7OgOAFJTybjVFZ54rTkTKBlfaGzUPXb/fYUwLit98bAxzmor3P8QH7syh6GiNEU/87jvm9/FJPSPZ5MZpMjiwZ4jd+oxoqxHhPoTLgKUYRcatFUafDjOE2qMRK+srNIRXkHgNgrJRiOIcO/E48HF+pv5c1V6zwsQcC+4X/JRtJq+9qaOt2wicODqW15x2mrb6IPw6LE6U2IYD58eVgnIs5HtS9Zn+uFg0brHi8QmIoD21lU0K9kfgolbhGminqPoZDo9OX9A8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yEzXnWDzQlug3LtTlsE8Hcy6H5AmGGc0Va8wWjfBKMoHpHfGZ6velPe04iZ5TrMlQ3jZtO7sVXnus3XtkwfBbxWF2zwN7E2XBKZ+xbI79j1MCQawLv/BKgZUHqmVdqPHVXaPdlR2a2tGHDxDBXl3MQvrazkT0qbcbty59uapWhV3D+6rx28u2PStWMhuIBT1oQn28l+RZB8a+OGMJeZXmiCzIEVSDEJMl3asQRrb2aGy/2WvFD9xn7RC26O4ZXF/IrZ2wYB2psp2qH1SRK/P/TbDWn58xEYUqGAj9xUUkJxAmcls15AE28PILf2CQyoNTnOpNa8GrsNyOlnQyqAD/1Olh41ZK64px6KPooBo9uwrxhlexCDtmGQUk1eiZCGfBILEg7tukApZk6RIVzcKLuPJyHkop0xgA/LQIDrXGSmZUb9js4mOuAQdKXVT8qPM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:07:59.0175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ead004-749f-4a5d-4caf-08def95d6d14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092
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

The soft-recovery, per-ring-reset and IP-block-reset attempts in
amdgpu_job_timedout() were only gated on the global amdgpu_gpu_recovery
module parameter. Introduce a single can_reset variable that also
takes the per-device adev->gpu_recovery_allowed flag into account, and
use it for all three attempts instead of reading amdgpu_gpu_recovery
directly.

Assisted-by: Claude:Sonnet 5
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index d97cf1212e0f..43511e0419a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -92,6 +92,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct drm_wedge_task_info *info = NULL;
 	struct amdgpu_task_info *ti = NULL;
 	struct amdgpu_device *adev = ring->adev;
+	bool can_reset = amdgpu_gpu_recovery && adev->gpu_recovery_allowed;
 	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -111,7 +112,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	if (!amdgpu_sriov_vf(adev))
 		amdgpu_job_core_dump(adev, job);
 
-	if (amdgpu_gpu_recovery &&
+	if (can_reset &&
 	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_SOFT_RECOVERY) &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
 		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
@@ -130,7 +131,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 	/* attempt a per ring reset */
-	if (amdgpu_gpu_recovery &&
+	if (can_reset &&
 	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_QUEUE) &&
 	    ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
@@ -152,7 +153,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 	/* Attempt an IP block soft reset, if supported. */
-	if (amdgpu_gpu_recovery &&
+	if (can_reset &&
 	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET)) {
 		r = amdgpu_device_ip_soft_reset(ring, job->hw_fence);
 		if (!r) {
-- 
2.43.0

