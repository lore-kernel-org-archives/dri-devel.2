Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D57FCDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DE210E5B6;
	Mon, 22 Jun 2026 09:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XHe9Bc20";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD6710E5B7;
 Mon, 22 Jun 2026 09:30:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6KHRL98BIggbBsIDM6jWEqWH2HwLXgSMqSLgyKWzSyqGfFjoQJjA232JjPUQDiDszW6x8VjVFZ0UmBhzDwV2tys/O4NChLUE+CDHSbdZIerCR9p1YoVrHflQ7WAjEwA/RuiGwNP5pKKLeI9ryQjhBGiS+HdeYEcRk2mhle2x7vasMzLGmcHPsLIbPkjDK4fD5rOi0F0u6ks0V92y5duZGeNg9ptbNr40pJ1CZnIyNJa44nU6LZpqVwg9Y16UO3Hz6JglkJFraGA3oS7axln5sU5kclbU3hodyOSJyzN29ecFy2RjJWTpCYc4eYSIC8zCqFmY1fx/Iq4O68T+NWKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnKMqfeA6AlP5U0Xuzvvrf6g6yPkiSHyY7wpoFMyQOM=;
 b=OdnMIMjkKwhNWP3vq3tqrkGlfT+dNgAVIU35Pl2Pc5tOlgnRxWckAxszvRPkPM11PwLtei724j1jTdD/x9ldibITnWRBzw+z/CT84VXm313ibJsvRSy5uA7hwlJ/u7SL6p1lV65/Ii/MvorsiZ0ic0zaiHpInGLY4FI6HScNnl4K7vdGY2vqjnxIw5p87qN//8o89OR1Px0lwH1FpRIN7pmUg4KflSJwxI44Zp82QFG2pUtDZAR7sxYQ6jZ5mcohzMvs45/D6qU0JUuEcGhqbZ/000fcilbU2eFYpt6yu+P1zyqYWDsODVGZ2abnZmBKwwOktk2T0/zhAYiXcjDNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnKMqfeA6AlP5U0Xuzvvrf6g6yPkiSHyY7wpoFMyQOM=;
 b=XHe9Bc20cI9Vw5MWo/PIflfC5qIZVW+PMVD7YMjuZd2d0LsiVwNrXupPLATV9sNEV7iKz+MAL8+pbjNU4b2lpcpcYVIUU2uDMq4bQbzsz/3Cg44k7LMomwcQVXYp54lOMPM/2XVp5+YhiFn3FhQoQjXLSkWBEp0YFDN1Y4xpS6s=
Received: from CH2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:610::38) by
 SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 09:30:10 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::7) by CH2PR05CA0025.outlook.office365.com
 (2603:10b6:610::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 09:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 09:30:09 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 22 Jun 2026 04:30:08 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] drm/amdgpu: move debug_vm handling to
 amdgpu_cs_parser_fini
Date: Mon, 22 Jun 2026 11:28:57 +0200
Message-ID: <20260622092859.3600-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 9013d20c-3bf1-47f8-b73c-08ded040dacd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: x6nPcQ+PEX5ZtNwtoQ5g9oHvDa3H8Af57+Dkr5nb0tDPvi3AaCfVX7LOeI6ebrLfXw50CkXzi9Jk5UUJvCvlAc0NBNMl804K7du6VXKMpWsJYXar20u1mBltJWE1yr9U4fhj0FsbuHMs1umH/pm03R2btdJoTmRWGlsOpcicwOYc7x0FS96gLJlY8/2GZtzqnOIZSLho/8UQKXnH5R1QREoe+J8aCcRJDdMJxYrFfVV+ZmUkPyezXbfDwidXGPoqvtGdTQWGjmpJWETqppYqcDFNNi2ubN2omNd4PXpS8TSHKcNwCqzTNgnbS0ypU7JpzBQzhnZC/tG7QuNqSGzuGNG2nCgoWyononCQcGNMx5atv0gBuNaAWscRJIyM6boeyIb2YaEgzkw5h67ePbRSYpesS2Ga6tDUNyuOSFBVYTWn/QBjn1gMrezuePA1+rTl5g1ZYA6JWmihifOcEYDNcsC3lAmQ8/HK+Vq7QsDg42+UGb5GLVjtFNzw55ZOZRpvSSWJt4Zx/67+PFs5wOVHICEMVA0DU0oi64BrjILftWBGvfDRHWh/uRSZK21RP2x3qPYHrjrJq2a4pVjyXxR9NafcAoLga0kwste8aSwtRMEj7mg2yC21bHpq7M7RbzFM4SC4SaARneIu1FYx35MbIsCQwR/z6IfVFChxC6BcdDzEeD57XcsOzuDtM/b54GtWwt5jcvgine8/aj/xkoJyFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7SyS+yvwKkBcl3zMu8ekneAKUCqTST4YllQH6uVsNVA5zTvO/Zxn97d6IzqH1q8zMzDOZCnsC70+QC64AT/enTFLsgF47FJOMzz5eT+UkAY8wu0dR1nugjMQZ+1FfrL0wFE0ICkxjOkvCOMuxcK13sndvgtwHQZjLWYqyzuHAzSgCV4CheeEPC6t1iUSrwTO1DQpw3pBs2OWWDdEmSd0pdYANTcC6lKZr5OFqDZGVW9Une7Efyi7AfQdeJF2o8LXu/B3g8VxlDmQHXmfhCRYAzW4MRc2ttNdPD5sSMu4dfbHq82bEP5mtRf2bjx4mo2s10gLupC7rwSgR6pZW0Z5ICBKFQHulZQKG8AXMACgqOaIYgmAwuRARsIsnWEMwzHUhoL+VFDqWQ8NmNJyBx7/yhDVBcWXcLG6LVnQn2DkqRl4wBF50tMncgXq6J7FXreC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:30:09.9805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9013d20c-3bf1-47f8-b73c-08ded040dacd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244
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

The commit referenced below restarts the CS if the validation is
still in progress. When debug_vm is enabled, all BOs from the CS
are invalidated so we will hit an infinite loop.

To avoid that, defer BO invalidation to amdgpu_cs_parser_fini.

Fixes: 83ac717d7837 ("drm/amdgpu: restart the CS if some parts of the VM are still invalidated")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 30 ++++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d63fbc7c568d..7e75c536dab3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1180,19 +1180,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
 	}
 
-	if (adev->debug_vm) {
-		/* Invalidate all BOs to test for userspace bugs */
-		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
-			struct amdgpu_bo *bo = e->bo;
-
-			/* ignore duplicates */
-			if (!bo)
-				continue;
-
-			amdgpu_vm_bo_invalidate(bo, false);
-		}
-	}
-
 	return 0;
 }
 
@@ -1382,6 +1369,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 /* Cleanup the parser structure */
 static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 {
+	struct amdgpu_device *adev = parser->adev;
+	struct amdgpu_bo_list_entry *e;
 	unsigned int i;
 
 	amdgpu_sync_free(&parser->sync);
@@ -1397,8 +1386,21 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 
 	if (parser->ctx)
 		amdgpu_ctx_put(parser->ctx);
-	if (parser->bo_list)
+	if (parser->bo_list) {
+		if (adev->debug_vm) {
+			/* Invalidate all BOs to test for userspace bugs */
+			amdgpu_bo_list_for_each_entry(e, parser->bo_list) {
+				struct amdgpu_bo *bo = e->bo;
+
+				/* ignore duplicates */
+				if (!bo)
+					continue;
+
+				amdgpu_vm_bo_invalidate(bo, false);
+			}
+		}
 		amdgpu_bo_list_put(parser->bo_list);
+	}
 
 	for (i = 0; i < parser->nchunks; i++)
 		kvfree(parser->chunks[i].kdata);
-- 
2.43.0

