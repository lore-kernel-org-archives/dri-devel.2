Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8251073C8A
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA61F10E5F0;
	Wed,  8 Apr 2026 10:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ptpPPgPC";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32DF810E5D5;
 Wed,  8 Apr 2026 10:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwYHiWmc6BvX1MCb6CAcj736PAWJZ3r8unGEZuDSDQB1a1bxTL8J0r2RGXArK8EnzGwwJ812xbo3eG2rgiEh6gfZPlbmU8ZbV1g/L4/WUw2ZvDTFJtxL47KgvF4KjO39gbKwsLaHgv4mhE76wMJOnLSD3u2qE3OD+Q6y8vtVZ7LRrgCtmF2SpkcIoo1jznJHss2yZiOEoGgwdzYk5CySuq2mFUuTw1IIDwNoCsKYSKhNU4sUEWu3xLsVfLmA5r03AQ8UU5XuOpDg4qipi0+SPjnXyb2qHmEdpB0RFmquVSR3aBFklh68CvQoN5WtT0ErhE9lR2T+THSTHVjH9/cVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V8BLUIy41v/ksUxJEnq0GqwC9DNN4HugjOvnTksY0E=;
 b=rDEUaFYE1nnKMv87cFOP0ORcazQa6r/P/ArUt5ShM0NuJkiGcqq2fMbwc019VCAiPXa3SAo5oKz1te1qWaA1nttLoz1iNGTFy1maOHaWHTJX+JVfN9hVZ1psEhgYapDm7Q6/cRVzIxAvhipR7esLrhR/ZfWQKWy5Me21Q+cOGlO07BDW/eQg9UF0U01ac4NQWAET5pf7HFEGqClO8eoBjYzjCuQEpJLdWMQZMm0w8L0JCJ+PB9JTLw0UteWTYDOiT1bfndnybd9acUN7Un5qKyeJk8YwLIFcHGE51S6eIaHVNQzIcv9e1tJeD5N8hc6iVtnGLdXQIW+Nj33LXcevgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V8BLUIy41v/ksUxJEnq0GqwC9DNN4HugjOvnTksY0E=;
 b=ptpPPgPCGaYKhit1Qj8tJz8MLeELNRrPmuBPiM8/OBgB2eFJr7+N/AwJ8KQTxd2WIw92RnkvM4aNc7GLltCmjk6htBwNFWUH0Psq599pRzXyUskOPXeicvw1oDHtwJC/YutBMONwLB2iNp9EaeZOOFyTh0dhJVy1BasWPNSPGu0=
Received: from CYXPR03CA0091.namprd03.prod.outlook.com (2603:10b6:930:d3::14)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 10:06:28 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::4d) by CYXPR03CA0091.outlook.office365.com
 (2603:10b6:930:d3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Wed,
 8 Apr 2026 10:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 10:06:27 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 05:06:25 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/8] drm/amdgpu: create multiple clear/move ttm entities
Date: Wed, 8 Apr 2026 12:03:14 +0200
Message-ID: <20260408100327.1372-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: abfd07f1-a68d-4385-cb68-08de95567fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NZOSIvbCSnXZbMKmaOXEv9wauxpZIZUNkZ2hyw6wO1RLsJSy42NNvPXkkhEWHg51xkNxQZq0L2tF2t+TlxDuF4Njycjln3WYGguulfApI6M6ic2Zjk9XxvUNX5RB6+R1Wxn2CIeNU/s+KVyWbYGPZQMFMySsimnDyaAnueurtHRyO+POLJhW3lentX4WsBTBvpyIZMhFZP00YBw/j18YQtODpbC+cuLA0FbVz5IFzKoztWK+vZo4FHZszk/02sFehRtxDNMNK+INBPZE6BbMLBGtzDnZ+836TCyyuu80AVYPdElzu/l1irRwetGjratoFuA0oXzzso8Zm7+thCjN0RtilanpvRsgAf0lVF2UZ0PbbPgx+UfHJhwb1y8bJlvouwc97umb7TXWOflBk958xO2dyg/oceAUmnKLNwm1m6bAxlnViqyMsqSERj2u+lPEOQmjqaOZBTRE5Odu85rnBnrlIVtCk2jdLUMA9Q5O9kwRy4cxEz4SZ9lU1oZGx3oxeN1WWBOp+BQ6waHSeWCe6rhugvrPr9SLBcVo4WBSOmtKq+YLOL8Fi3a9wsT6iLOwFu9wZbBcPnR++mvm/89tvNoof2zJCJdtwj3sL+X+shThjJeyEIvxf2tLj1KUNUGfAgPF0f1x9LD3hCUWrqr2WIYD9guY1Po4lbfVpvQc0u2f8wRaHD6Ge7G5qDcpWeJhJA2CLVR88C3M/N4WE2BknUwR3u85XEy7JlvDbgWycj5p6hgVho7kwRubzk52QDb81fkd7gCNSyQKNlXY4SidkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yvNdNjJsLa2DEONENcx9HoJjjh9ZI7a/FfKZGvMyWUFc4wIextUQYPfrV+j0QugbzykAdUOkkGx796pTdve0yAaNqwq+6L3uGe9ae07bIlFx7UjCWWOBSgOF/pAe8lo7IJYbI9Ywu4SZUf+tXT824hmP3XgQs6x4V4H1ThK94hViZcVJy0KopOR3KXDT8a1RvG3G57L9hIlw+nDGvw4iB4/yzhWQlDi2yRbizMvnaGNNLAWY3NzyNMXzCzyCjvhtgcUyUvfQzoBH+jIXIV3VGO/ySxjMyoOaddt9d0kCASZps5YkMXGl4yrttYgoNvCPYtfECdZk5xVdH75+1lYAmTY8Rywj21Gfd/XShiaCepEegRCshimZMonECj5yleQKtvj4OAaVYh+Yl673MLPjflDCDOI8bsizLL+Yh9ui4H6FD4s1k/SRoea464oSbI3Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:06:27.3551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abfd07f1-a68d-4385-cb68-08de95567fb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0e9620df91b7..5d10c08fd989 100644
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

