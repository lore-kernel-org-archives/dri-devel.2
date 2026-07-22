Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88510C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097C010E3DB;
	Wed, 22 Jul 2026 09:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yw9RdEU7";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3589E10E3DB;
 Wed, 22 Jul 2026 09:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXYzjClntqS+JAB52tLQVFaUHi+AW7YIq2KM0IebsoDd73oyGDXu3Ug3oNWZp0kmMudqa3/4whfPIL+G3DMFmqQd/X9h1N1wPgqCVgELQMONT0FPXtopeXO9Dxz+752NYwb5X2eUnSQNTJidhGaF3sWPwt+9IAHV8mfL9ozVK2Q43qYYuJVj3W0/GYj3L13TLIRI1x146VjfgqY6hgTpngBj0d2UrJIO6DqHFczmAdWYzGB0ogvQWSh9JRK+WsLcFjnrRUpy0AKg82rxnklhjtoeG4rsaGeN/DGtKt6CGhL4CZyuh1LYQq/9BIDBgSZTHFPgMvD6QKcidQ6MDhh8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujnOGG05hxDclX2tjNN8DgJWqKSFCpRDKHdLAsUtXdA=;
 b=wd4cXUuoAAnvYgf/HGr9vjf3AJj9MUneXA+Jkruc5ebyUgnaHM32YsKxiMS7lfAs2LXdfM58B+uVrfYPAFI4Bu4ygYy87ZrgO5c1HY4ySwAZ86cc6lKuP6ZqbsrAHCx9qHZEeuqT6JiGqFbq/S1uGJcMmbJfdfR0j8xgnsfQTejmjCueZ1dXTQXz/g7qA4SIcsFjLoaUQGfOy8PLMKbOicZzas901QMknIB7KdntcAPgsa1BRiE28odljL3TMAtPuDUxFt3CRcIICVB6rYJYYeISyGPOfi0sDZbow5cg5dT/e+zyhTcLa/5Jm6A45lhm+87DNNOnZcTS3wF/oo84Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujnOGG05hxDclX2tjNN8DgJWqKSFCpRDKHdLAsUtXdA=;
 b=Yw9RdEU7trv6x6+INAgsFR3L7Qbg04/BUmhWmCFU+itLYIR6bIS6ci2HtGZioxO/zSS/CH2CU5cdKO+EDflqnbpNtlJn1xgWxbLuwvYLKLgmx8tX7mi5G40aZOApCHf1mbSWyuUSaBsCG34jdPLQIWMyu9nfmHybfFzgFO5kO0c=
Received: from BN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:408:ee::25)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 22 Jul
 2026 09:52:24 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::88) by BN0PR04CA0020.outlook.office365.com
 (2603:10b6:408:ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 09:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 09:52:23 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 04:52:20 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>, Sashiko-bot <sashiko-bot@kernel.org>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH] drm/amdgpu: Fix use-after-free in amdgpu_vram_mgr_fini() on
 init failure
Date: Wed, 22 Jul 2026 15:22:01 +0530
Message-ID: <20260722095201.658119-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: a077586a-778c-41d7-d609-08dee7d6edda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|56012099006|11063799006|6133799003|5023799004|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 86ApPVUAwEKmrQ8wRx09pT1HFV2CGw8zXBqaIrgPQQ3aZ/kbPOCxufUDkBvuCyPr8LBP6e1y8Vd43T5M+9DN2Nm2cVGn/eAdnFsbhrk+jENoOkf4FUTOYNfT5SKLruCB36fqJ9oV8/5/7bgw2uSll320RePTQpJIY0HF5LlTrQbuYqGXb+0UjyzJZ2yAnSCHP1w2PB1DZKs5vyZNn21dOQHYylY8U3Aq/3dKaYqFZF/hz3FDGOyd/k7kKKhFTIas48z4ductEoEcxjwZxu30EvOwalQ6gAeMap+ghsr3AwFhIGgDzEkR3pcqcfsX/v/pFt3aABHyTHlKliKZWq7zh9js1vuPiBrS2HWkSrO97rIiU49jZRwzIkQgPY83AtSOhm43t7Mq9DXw1wL8FmPSfkLqSiPb9hWOTtDIUpt+U6O0746cp+ywjbcfPgaHUjvDUcZmc+b3cCIddFKAG6n31JI83XqWwPnlATy/WNx8CAZh6AVsyOPf/y0B4ZNieXehdeuSwQ7ma3v4fJx/gaBgkaEz/4fudccaJ9LeX/m//sKK1OFq37AwT4f5fmqMo7zhtym+Mn3Fr2p2attqZAqrLM84IDFQ00YHDVQZJ7s2kAHVJHUBQ3TONiAt+xso6MowGS8F5bq/XUlQ2VozhEQWPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(56012099006)(11063799006)(6133799003)(5023799004)(10067099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZFopaf0fKGjh5bt7BlbgCeKsE4zIaic2r92Bf67bDMFO+FhUdiNulGUvr5JSn68mGM/Z27un6/rfJaAogmxCNbFWYBNvD1TO2uEyWkoc6Lxxqi+474j/X7jhGxD4Ug2yP9X94fMM55GngxVNkedaAouM0LvXX3vDYaEflcetTKMbu8Q33B4yxmWElL/H9ng8qWje9ne1t1E68eM61ngUEXsbnVLGy6l3JVUqAU4asxia/iEAy59YFhf1Vdx2OowjyWlm/5CGMwjhYk84AF/RmLcvD4Jd88E8y3Im1Z/6WBFUfN6m/ZNC2D5rAtkdWk9QfzDk8enytiACce/Rj2mM4hL9fROUINR0HUpE2jyRQGJv9pixUUhs/G8IB8sD5CDE7UOLmyOXXdTKG4G+aAOxEJPlSDgHwbI3+VUq0QePEDWcmBmSt4WDXzY+D8LdrN8/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 09:52:23.2324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a077586a-778c-41d7-d609-08dee7d6edda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656
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

adev->mman.initialized is set to true before amdgpu_vram_mgr_init() is
called, so any failure in amdgpu_vram_mgr_init() still leads to the full
teardown path amdgpu_ttm_fini() -> amdgpu_vram_mgr_fini() ->
gpu_buddy_fini() being run.

When gpu_buddy_init() fails, it frees its partial allocations but leaves
mgr->mm.free_trees, mgr->mm.roots and the scoreboards as dangling
pointers. gpu_buddy_fini() then unconditionally dereferences these
(iterating mm->roots, kfree(mm->free_trees[i]), mm->used_scoreboard[i]),
resulting in a double-free / use-after-free and a kernel panic during
probe error handling.

The manager is only marked as used as the final step of a fully
successful amdgpu_vram_mgr_init(), i.e. after gpu_buddy_init() has
succeeded, and nothing in between can fail. Use that state to guard the
buddy teardown so gpu_buddy_fini() is only called when the buddy
allocator was actually initialized.

Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260611173301.17473-1-thomas.hellstrom@linux.intel.com?part=1
Cc: Christian König <christian.koenig@amd.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 2a241a5b12c42..38529a904deb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -954,6 +954,9 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 	struct ttm_resource_manager *man = &mgr->manager;
 	int ret;
 	struct amdgpu_vram_reservation *rsv, *temp;
+	bool was_used;
+
+	was_used = ttm_resource_manager_used(man);
 
 	ttm_resource_manager_set_used(man, false);
 
@@ -969,7 +972,7 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 		gpu_buddy_free_list(&mgr->mm, &rsv->allocated, 0);
 		kfree(rsv);
 	}
-	if (!adev->gmc.is_app_apu)
+	if (!adev->gmc.is_app_apu && was_used)
 		gpu_buddy_fini(&mgr->mm);
 	mutex_unlock(&mgr->lock);
 
-- 
2.34.1

