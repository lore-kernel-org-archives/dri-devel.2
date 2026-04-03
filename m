Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD5DE7E344
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2025F10F3D3;
	Fri,  3 Apr 2026 08:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jmsrDgrk";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5615A10F3D3;
 Fri,  3 Apr 2026 08:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot/1ezaFH4ix//ILGcv0u9PyQjFfepgMMJ157+L/SCD0AJlFfBR9GDzRgdHppkmIiY+tQLEbh6Fng+qrHWgNbyly2zIFmLuUkCtecNnpJdG2x2K7zRN//LfW6Mp1lLXY13GnXH+XB0uIvBwyoIVgFNiWJuRJVaWQVpfsvMndkoiT9Pf+GoVDvokv9pqttOqg38Mfe7tQg4Vys7T8hecGwx7vx5VHuAdlTpf9qygyMaId6L34AQPyV+qwbfkrV+ZbxRvQLhshYGNL/6wZ2dDn+w5/++yZcKRSApSHxYRmDWv3Md/TFjnk6Dy6r7XLbkHD6eIfgZeY94csl2Gt74s59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AMvaLRfqHcJGZm/PMXpDqZ0YJS+fmKVt9bTdLcgB44=;
 b=zJTL0vj3Uy25+ANSjxhb2XctLwcBpdipViMtrvET//n8TWfgpHwtIdx6drWDjUvq8gpw/451JmvR7RbvhP82PfbiLRKDgWpObrFqJkIC4jNnH+5IQmSTA0X5ol8bjld2ZvenWMJKm0OdFa5pnD8Es6chm/WrU86LAcIyS2RgnANyIu9dFtliZB2EuYPs7LLrRq7CL8TCv4Yf9eqSfHq/EbU9rA4mE2mrDlD5jIlAXCQ3218kCg9vC2m4FvXaHPe1PApAdcef9a4pZphHDcquhuFq9OqkobkGXuvxC2YXU1Lu+IIMxRKhbE6oY2wGCdXvC77gikvqFez51KFrsWuJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AMvaLRfqHcJGZm/PMXpDqZ0YJS+fmKVt9bTdLcgB44=;
 b=jmsrDgrkBCRR22KXYsy1lc4PXtmBRF7AcocJnsgCFshD0/ft+z8ehMfQu/ji/ZQexgEeax8iqcJf9pvqdU1sV+gaX3jR0lTRE19DK7ezAUD1J7ie+P5yeEZDNgRCxErXG8etsN/O1ceabNc0z0EGtVQYnJKNP9qpPNhVhm8O7jk=
Received: from SJ0PR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:332::35)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 08:36:57 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::e8) by SJ0PR05CA0090.outlook.office365.com
 (2603:10b6:a03:332::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Fri,
 3 Apr 2026 08:36:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 08:36:56 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Apr 2026 03:36:54 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/7] drm/amdgpu: give ttm entities access to all the sdma
 scheds
Date: Fri, 3 Apr 2026 10:35:52 +0200
Message-ID: <20260403083602.1771-4-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: ea7db226-0682-4d82-90ae-08de915c2a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Qg+pLBa47YiOZE1dWVnXgcq/Q31baRXSSQll9dWVVBicHAWCsEgf2PEwh1vfJ5WqKkBOF3uscyh1Jg6DEiMjPs6EC0K/MIj+WmFgsaEGL7DYvazHD5NDAmzbHK+0DXEcoxUkhzOgxJnR4Iny9foctdZbFxmh6gnX5Kwq3NcBEnfRtpSrEBuuj/uFFCOvn3kbs8Cne7MUUZBBEaBWG7PA4h8BQxUSPoO+6xECrnlWPsdFSwWwhy4+KmXmSzh2lhZa8y37G1g4QjflXJmUrLc8ea3y266HWlBkkVfuhPuyA5KHvSUAZ1Bsoj8R7r6e9nKRdWpEcDhjd3XjkqlzBdk8/bfgl1BZeMmQhHoBxXhczI1i96YUDScjTakuABdfA9zwg+G82+YKKxPWiBW4o8mhgYXz9gpi6Sw/YmDIisgd8tqd9F2hSVcU3doSXfl0aaKMf/WCOGFAeWpS6ASBYwXBvLCWSOt+FLKZmnchPY8r81/ks9ZRH8ahtBNwPlamLstoLSycAh8pPc7Wgcsa9Dg1vrDhrzEGqTDuvWftcg1TXc/tkjGE37SphkridzFtp9e6tbZR+ILlI2OlFdWcCr2itZT3ePfuDoYv34ydSJfGUX6PluLKk5HglotsS5jdw7fz6szh96eS/c/kBqhlxoRVukg7VLDQc0JLbbdCW0bQuKoHegh5UadaMvWD3iOlqpmIQiH9NJT5yPbf9boeigoub7VfoiKCzvA1HucwlI9sejAcRH+5c5jwYjUx0N4CxW26yASScIwlh29BhLdkbCqcdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NpUgz4c4vkhShKE3hNikv1L6ZBL+IyrWvzUP11XOnU//03SIYAMt3xyYkwh7/9IRNA6DIJvMcDM90NhZHJBLkf/E5XTYWVtzPfhX0Zs7vc70OueZTwkIyikYYCFsbQxRUTc06h+gh2ywZH4H+3ddSd+hOG1lh9jAisDxjJJRlGGFdkXVySnOixzpFQ2UqkFz8jMEIzr7NVAyiWtXuUhY7V5khjlXROJ7ktzx1my7ox25ABA+uv5mmK2c4//UvMQzpHLZauumhAaUsL0VmjuK3rheyWSOfnPefIdxApJhEquzYQe8D9BjLHq631ixYecUWN2+QPzL9vDspoMiQCJMhs/8qLBsoz5hVDqepspW5KpKNbVAMpn5eJVgojvSLRs2HlNWwae5uBjTa9VaO6ls5tzi7CZ1x/8oiUYYAhjlNHiUQ/NWKdqKua8nGXp4LCdJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 08:36:56.7327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7db226-0682-4d82-90ae-08de915c2a77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

With this change we now have as many clear and move entities as we
have sdma engines (limited to TTM_NUM_MOVE_FENCES).

To enable load-balancing this patch gives access to all sdma
schedulers to all entities.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 83f6d00dc3a0..648ad344e89c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2349,8 +2349,6 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 		return;
 
 	if (enable) {
-		struct drm_gpu_scheduler *sched;
-
 		if (!adev->mman.num_buffer_funcs_scheds) {
 			dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
 			return;
@@ -2358,11 +2356,10 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 
 		num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
 		num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
-		sched = adev->mman.buffer_funcs_scheds[0];
 		r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
 						  &adev->mman.default_entity,
 						  DRM_SCHED_PRIORITY_KERNEL,
-						  &sched, 1, 0);
+						  adev->mman.buffer_funcs_scheds, 1, 0);
 		if (r < 0) {
 			dev_err(adev->dev,
 				"Failed setting up TTM entity (%d)\n", r);
@@ -2380,8 +2377,11 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 
 		for (i = 0; i < num_clear_entities; i++) {
 			r = amdgpu_ttm_buffer_entity_init(
-				&adev->mman.gtt_mgr, &adev->mman.clear_entities[i],
-				DRM_SCHED_PRIORITY_NORMAL, &sched, 1, 1);
+				&adev->mman.gtt_mgr,
+				&adev->mman.clear_entities[i],
+				DRM_SCHED_PRIORITY_NORMAL,
+				adev->mman.buffer_funcs_scheds,
+				adev->mman.num_buffer_funcs_scheds, 1);
 
 			if (r < 0) {
 				for (j = 0; j < i; j++)
@@ -2400,7 +2400,9 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 			r = amdgpu_ttm_buffer_entity_init(
 				&adev->mman.gtt_mgr,
 				&adev->mman.move_entities[i],
-				DRM_SCHED_PRIORITY_NORMAL, &sched, 1, 2);
+				DRM_SCHED_PRIORITY_NORMAL,
+				adev->mman.buffer_funcs_scheds,
+				adev->mman.num_buffer_funcs_scheds, 2);
 
 			if (r < 0) {
 				for (j = 0; j < i; j++)
-- 
2.43.0

