Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBD1E7E344
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47BA610F3D5;
	Fri,  3 Apr 2026 08:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pHTRPgHH";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D9A10F3D4;
 Fri,  3 Apr 2026 08:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnCNkrh+FZjRFMCJcLq2KjoMXgSDx+NJOtOS1Z1JRgmxd0eQklqgnQxTH5RY6m6I0DdvZWJnj63FYoW+01OmMGBKEPT61slcAFmxSNzJLW69E+Bi4FwSZuv8eBMBy0ruiRvmrfciHIxTia435i4QVemDQ07Ph8p/6pYa6lj+QVkB/a0DN3sgnToAO8IshSM7bXoI6/I6UnRqaFYFjGoz8cLFS0Pj3+oUf3D1KhJhLZuEUtVREWjcdPFRL4aadYao1hfZwXqyIq58oQvVS3vWlrmNRVjGyblTBuId1JXEbFFEK6iXwdK9Tqjc+oOzPP82wqnityd6xgied4TYiB5gFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEtTb5H7JlJencc88eFzHNENqNYaEwyE5BcWeymsh74=;
 b=ZH+Gwh5Kdayq4HduDT0ca6gGHQzBOHD1aEh+mzsL1p7lE8xz4V6+ZWhPeAWLWRPavepEJgIy/K9VmAzhurwrd0u4G6B3O7kxvuiVTh8CMSDsJZY58XFQLWUSGjdlUXCmKZGZzIyeq5Gn29oivddtz+Na9HFrjhrwn/oRi2vzqFW5/4g4sLGLy3mRxW5sbAqc1w1/wzK6Np3w1D1urFKRRk/auzV+k3cZS2Vy3N3WbV6+sONOn9CUqqxiEiN5M49nMkU6qUV2d5jaRRWW85PXYkuqIsNB/KOZBfx08rra6japJEje9aF4Vi6Zx1k/vthOiRR7ntf1jBTl+eDNW5hsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEtTb5H7JlJencc88eFzHNENqNYaEwyE5BcWeymsh74=;
 b=pHTRPgHHZTL0aUL2FWU0UnDwq1eqMkLk6fc3J8odLcV+RMtWy0SjxYmV89uvEiqDCBeOtaLNsqoF5h7tru3jRMOtgL9OD/N6M80MDXUy03DG6TRNWVEPYpI6wvX5HvS9g/+zd+l9vUIxyTz49jQEBFxD4MDbZnVFPTXM1KzUqEQ=
Received: from SJ0PR13CA0238.namprd13.prod.outlook.com (2603:10b6:a03:2c1::33)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 08:36:53 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::fc) by SJ0PR13CA0238.outlook.office365.com
 (2603:10b6:a03:2c1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Fri,
 3 Apr 2026 08:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 08:36:52 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Apr 2026 03:36:50 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/7] drm/amdgpu: create multiple clear/move ttm entities
Date: Fri, 3 Apr 2026 10:35:51 +0200
Message-ID: <20260403083602.1771-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: b539e3c7-691d-4808-74ba-08de915c2835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: MqT+cm5ep5DgiWGa5J+0XUUze6/1PiYTo7FbhBNFP+c1F/nrSoUjCX/LqTRCjLjeR5/utpUEeVFH/SEX/NbzAQjW0dFFrHJb1Xo8RmPKQngk+1QgF7/m7xX5GNZM79V8Yy/MK/L7Ozr1R/PSfUBv4NAA61rmXZBsqojiecJjOrsNJQ8G7g+WUP/4LgQBe/oWVL+dgYqw1uTAvH/Bwdn4F+6j7YxmHAnPGpso+TxAc525xKjK8pEWIpi996/KOupbqOi9bSnvoR/41SLTjKoXpB0/cAd4p5LtiE5mQCP8SKqvZ13KZ/ru3FbQwLUr/gm4SsPsbVmQRvUstdJVRnUUJGTJC29YaDzxTxoydi4Y7O6nbMco6vrP5cwAuFmoL3AFtrpXahgyMPGOZtJv9pcOdzgeSOj4LPkqz/KfHTfli78TBMb99caVZ1SYYkN0Y0x6plvLQR/I11EjiO/sy+QZvZnyF922y0yq0IASWLKsM08j3XoOiOnhLuHNfls4uwclXE/bWlBWw8KQRTbvKaMrI9mkeAA87noO+bISZkvFYggcJEYtLXpAkdV708pY4qy5Qpp2RTpmHhmXmw21GBhjHFVSdb+gAskCbf1nLlj4IQg6PqFToS2Y5ium82ze0pTqeFnkmxRouMkiDTURwJa36opZ1NnInrtr6xUCnxnr7M1e9bf1YsQHIr63NKuG5Ll/kLdcOV7QzBXd75+x400MrmRCpJJlQ8V/5Itdv4TLVmgse/yEsjqmCKwtrZg/UylbMIrqzD2G1PCtI24vae/Mlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QieyTDn618ZCJUuwcfrZ8d6nPf0M3eKxMuFDTdAgW5cAZcEBf7Ay3efVKfm4A34QgOEiiIJE3VamlFLLai91BKAAHulL3i/w78g2GIYXIZ1jLTX/BCtDqPP4Sv0t7SVHymkA6sABaW/BRPpqG3qyYUNPAoaK95fq7jHKg53ojSit6hNLOlWvamud/6WQnsiuIvQdeTVH8ub0SH3bgTNAQwq8NZyNLBdNCx8dBosf4IHzfLhQSj3CDxJ0Hf/ZaT8vHYKXayKixysXRz08MUP0kgqNahPgTYzE7cpis8uELmObkrGkpED57zUJ+xoWMQmCOUwdIxuwb/oor/kjyec56HI/ffpgulCrHNSDsXaqvKaAVAW5hgX8DvymcQeGycxlAeZA/cjujNr0PRHOKaKhztlZNB3ZMge25tMQVorIOapqT/92vJWq9rjIRuzsS1CF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 08:36:52.9446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b539e3c7-691d-4808-74ba-08de915c2835
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675
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

This enables parallelism of operations.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index bd32113292ec..83f6d00dc3a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2356,8 +2356,8 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 			return;
 		}
 
-		num_clear_entities = 1;
-		num_move_entities = 1;
+		num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
+		num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
 		sched = adev->mman.buffer_funcs_scheds[0];
 		r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
 						  &adev->mman.default_entity,
-- 
2.43.0

