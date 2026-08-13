Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44174C5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6607410F325;
	Thu, 13 Aug 2026 17:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="luxoTVFK";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013023.outbound.protection.outlook.com
 [40.93.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C0F10F32D;
 Thu, 13 Aug 2026 17:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtjsDg4J9zAHIKr3yTb0uq1XzstDHW7ncdEom8+enTtjJLi3bbch7jHR1z+peQwMLoE0f+CfuIJS/R3ZpoT8nuKyPHZqE5jyYZsZ0FPw7j29IwytbhPRfe1ANaj6FvHIDFO3y4s1wAohyhwZXqKYLWUDU8WcfZ/54HL7TV+6UGSf6HQne+kmAQOnHv9fsWgrdM3Oa57RLNAn9cbxQLSkbmQvxwcdrB5cJ/LGrG8oXKZcwejYimHoagwOdi9cKWK8nqVgqTeGlCNhJ77Vg2XEX64JCvhytwo3FppslaRgLGFq/Cq2TRME8V1VdiDXBlrhW1mFkbKi4bTopybt0pIvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nm+yExJ9gQJudgoni9Lwx1AYLIaOkCoYon33XCwqJzo=;
 b=cPx9yx+qXvH1B+7aYIQw4F9DXtqAGfGxi1WopHaUB50+iOkXHCiQqUpS3Fy8PQFiJWIcMpWTDV6buLJf0rcK0QLovEuexkHT0l+BCWg9JuDs3jYRRSkAMGkphksfoPaHjC5Tlldnmsog+NNeWxsxXwFjmV1IR3VM0Y+nwfPiORZn81PsjL+fCze6DcAYHorGhuwVlj1F4NwMcxWXx/PR/9GILVLxsWdzULJXSRRIPIj+iQRpoGW3wDXcDpjMKH2Nd4ivZRqLXkK/Zvhehwbz5QTaAp3QLNqfgEbi8x/uElpLEDCrA/fwD66wTdB2sqGJkreRC9MZIK+9JeE/bQTklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm+yExJ9gQJudgoni9Lwx1AYLIaOkCoYon33XCwqJzo=;
 b=luxoTVFKdBfIJZEZ8qAjYNbWGk3Ij4dUJQjS9qxxM96r5aAIrwEwqFpvDHDtmIBZ5vAFwqEf/380cGVaKe1sNywcmEToyd2EKtWvOKiOqIQE7w3fbCCCxRxA7r110ZXFvF2XfDwe9Bnkgk3A0S+hMNCynxfzsOXMHp6Ytpa7Wng=
Received: from SA1PR03CA0022.namprd03.prod.outlook.com (2603:10b6:806:2d3::27)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 17:08:24 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::96) by SA1PR03CA0022.outlook.office365.com
 (2603:10b6:806:2d3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 17:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 17:08:22 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 12:08:20 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] drm/amdgpu: skip amdgpu_gart_unbind if the device is
 wedged
Date: Thu, 13 Aug 2026 19:07:01 +0200
Message-ID: <20260813170705.15745-4-pierre-eric.pelloux-prayer@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9f6513-6d0d-4d18-f87e-08def95d7b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: +uwXkPtwKTkECT9CkvfmReBCeWsr80xulh6RNLbSIh281rHMKOOxCRXs4Zjajrif9pG01pzS9gGemv9lVvcs4XrIkJ8vepsjmGepGjph9/o+SodfJ6+txM/aqkqMMXOGULBD1CrDbdEyuMu7DfW4A8tM58bLwE02wIdvmLEO/J/fX6EG5s02k0DlEKnMZID/rVXqyMKF8QtUyT8Jexm/ut0s892ShIxu5bde+sK4tbgZ3ojxamohUkqWP+eXNMEI9kZFxxrFfH+ms8SXZHYKYYNL0wU113NSW8xp4teQ70nigz7liiZdFN8YaGc3atRsXdAJvGfH5M/LeLXtITTjwuLGIRqgLfP6NGyF9uBkQHc4i5oX/UY2lKQzvK+gKr8Eq1E0EORZGHQg59aUuUsmZGVnOIe7j3ZMkeC/w10xx0bw8FALFqgQa/MyxgHpFFGFIzC/OQSkFA8DOJNuXuVrC59IvJAu/jEnruyPKJwQBZfvwR7ZSOKBXmD+AQ550gfJQwtxd+gE6IjOup1vEiy3hYEPi3JpTNjHuk/8P4+XHU1c5u4CL5az6DbzrMdy7TP8qOgLnwQubf85tDvqk7aObB+YFJFClmmrof9Btkb/DC5RO2zP0qIRCJsuAVmV7HtLDALdYaVclw/7hmsFrKqZcp4lgdRKQgG4pEm/Wn2NIJqL6iomplabXDUJDMSQa7VB+8sGy5Oujnpg9qBSNlYC4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +lNBP8zCoZeNCeqXWZNArJx4UBrIno1yDw0E3D8tARRbexNTGIE1TuYSbzQMs219vmkDI88JoYlWcf0MRV+vqj5WRPb1nnNS/eq5oJq0B35IO1dFWQZP5FF7EjqbYuY3S7aPnBoaw+BTlQY9dsn0NhHPcmkrxgoNiXL4PBikEvjGDDmQexD3qXE5llZ5d/j7Le38gc0NG1i45rN/nTuuX7oZzMc896j6WAPQxpHpMeZnHz7GfLMq6w5VHGTUTu8JnpBDELaGbzAb+6V9DFOFOEmINMWrJiv1sg4om04UG1J10B0v4r4LRVCz7GlhrdHiV5IxZNlI/hzcu+a4OPoAqVKt8uT0/Ss23kZB0XKQ3//BZ1Ie9njg4bTBpqMV6mZCiyLBQPtWi4pQUtS4+KLDC5NA7VkNCpvhBf95jnR/BkoxO4Bh1FnIlWMRt2GdFs3f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:08:22.9530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9f6513-6d0d-4d18-f87e-08def95d7b5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393
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

This operation requires access to the GPU.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c4c21dbbbdbf..09ddfccb8174 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -315,7 +315,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	uint64_t flags = 0;
 	int idx;
 
-	if (!adev->gart.ptr)
+	if (!adev->gart.ptr || amdgpu_device_is_wedged(adev))
 		return;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
-- 
2.43.0

