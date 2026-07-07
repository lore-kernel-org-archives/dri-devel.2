Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E6EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE95E10EE78;
	Tue,  7 Jul 2026 17:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RmuUsLET";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C8C910EE6A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbDvQl+H23ScKtBahWKl68lEvRDpMs9nVeNW1TNcI4vMCFpqYnHoFcg5GOetqJ1JyoSxDHlAnrTjKa6QQC3u375jvY/+X7elM2Y5io7y7MQRuGLTOCok8tlBzVI504b3FVRVbHg8GM78mmBkI1V5lwpFVOdsSv4WmXMbavK6eD+tZ2uwS4tDeYKindigxvV7ejTB/dWJ/A9MLGWqh3z5vTuP1WrsXGWGyNJzOjCtJH//p6+SG2W2SzgzBF+L/AIol1Y7bfRESYlBQ/nbi6e0+aXAksH5T27TRSdfbtQd0z8qivQzs0/Q3Py7P5qVrS6TC8Pr0pw2hgdkCEgztTbECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQPUI0KV4zy/asSfrcSozW7yVPnVKVTyagCkCWmbGHM=;
 b=Ai3SDh/JdX23YA/gD+9haWLmi1dVzHrBfKTfQExJXkowXRXyvEiQ0+UcbyU3Sp9nVybEyui5QQy5RaYUx0mfZBk5sJ/P5Or7r/wkuutBwpi0qdhEwDGHTmSJ0hIsykbR9hOwVM+mFurFNU7OifnGaK16yRc7IDoLUod4aKi5nyL0SHOzyZxSMCHrhk69VZpIRL3WbsXIAYBpBAs4JgAj+LXTGpkRFndF5CLmctPYEZnOaI6CVB5/SDlQC3SG1+XQjKcHMfoimIB2TQbVicLZALSRgZ9AsaVqk0nlB0OeuWX/+px0PPmPobgkHmGbSsJA/r1g5r7tJC1bMCpWpDNG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQPUI0KV4zy/asSfrcSozW7yVPnVKVTyagCkCWmbGHM=;
 b=RmuUsLETsov+QCPVsdLr3FcpmdcdCetb5ASj15Tuj3eo4HFJ3kWIjlQ5a3S5klQkhDWzB75RJIdwtAUrsFpYS7rmTAUuLpS47utT3CiuqyAotPujme+p0X4u6vqJV/nobvawxWluY4KzSHscwIsKpdzER6NJTxtABa6A89NrpJw=
Received: from PH0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::8) by
 LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 17:23:19 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:510:d3:cafe::8e) by PH0P220CA0008.outlook.office365.com
 (2603:10b6:510:d3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 17:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:23:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 12:23:18 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 12:23:17 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix potential NULL pointer access in
 amdxdna_gem_vmap()
Date: Tue, 7 Jul 2026 10:23:16 -0700
Message-ID: <20260707172316.539699-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c93a16b-d6e4-418f-47ce-08dedc4c6fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: OhHN/nj6cZyok1+IzxUfCNYs+2ehcfD0/CuwGDkAidgx64JCAK1waQ8CeaEKxlUffxLbBQ/0N08THvf3FGOZZ2KW7u9niDOT7X+9dgByl1KJv2/nsf1VUE5cy3YWXzPIaVopP25ErK+ArHOEmSxnnTAc3TrRgaP1DYQJptrP4q4TIaxVCyQU7tMEObZWywhBL+Sqi+hrK9C8/5AAbIWwZEapeLdclG37PEQHw2woOZb6hVbb05dCLuQ5hftV24r2hOpPIgfj4nAtBkMfKPLg0OfSHjTjZqdm0I7ThTiS5we56NZC/5Zti9kFxoJpSsUjZsE7mur4Yapw0olZqrrac9qPZJbP5ja9jKoyDGbsA4tL7OIvBNL3wJp1RYNBCKLnoj4VGFbrGu8kLqzFw3BfIDW1ITeZYzCxZlOYhKBsCqchmWgdb6EEnce1qGDegVx63/nzBR9gZglVc+OaywZiYG62SXY2glQ7qsauZJjEsZt28t4S4xT0Nn/5zhLG0vZOOnTAdnopC3BbgTyF9RHJShFpwioQlf9kPLDeE/mbofploKHxYmYZrlyYfwMhFaWpA6/RUY0ko46SNs88Hu5/HsvBOTI8cAe6Da2MgWXQU4asbtbHvT6F6hFBD9yhmuUqll7+KbbsRHGZ7FlGYgGJN+A8jGRV0vlU8nM7AtbnUsRvWdkzWFI/djKsTmqmV3YmMpxA/lV50r7YQ3cKJ2/kag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2+T13iLGINBUtf54J8kKgwQcCSKz1oJFzQj2MP3LdsACuUcl9fJIdLJGopZ3B+sIIdiGx1Gyj4s6+IXSn/SL7cuNEqNbo8uXNMSpi8Wd+hMNdKsClpdbG6h8k29cYoY2SLfWSgvxG69hNC5SlI8mWpq1f8j1RRod+/eKQUY6dpT7+mbN4C4Kox1WGA88Eh8rI24R/axllOVmCAw61NN2rzpWi8N3f2hrRDEacq9ammbUUCoANkxMM0HquR0cxMgubPWKRATjADOAMPuMDgNE80UqKRFn9BzjhfKS7egd1sUKpBnPfwE4c6izu0Vi/ux8coGK2D8B7cmmlHp0OX/G2D4jXSx0P2hx6FFc5wR9uZVst0vi+rxAaWM4kWRHxSqFFCzQPp9oFgstJYgyNAwAOIJcrq6L1X+s5Ga8dIzhcligGATQhxWFSHXcnXFn7/HZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:23:18.3485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c93a16b-d6e4-418f-47ce-08dedc4c6fc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
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

If the heap BO was never vmapped before its handle was closed and the
user then vmaps the dev BO (which triggers amdxdna_gem_vmap(heap_bo)),
and drm_gem_vmap fails — NULL pointer dereference at abo->client->xdna.

Fix it by get xdna pointer through to_xdna_dev(to_gobj(abo)->dev).

Fixes: d76856beb4a4 ("accel/amdxdna: Refactor GEM BO handling and add helper APIs for address retrieval")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 64c7d82713b0..5033a0e5c6ab 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -198,6 +198,7 @@ amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
  */
 void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
 {
+	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR(NULL);
 	int ret;
 
@@ -210,7 +211,7 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
 	if (!abo->mem.kva) {
 		ret = drm_gem_vmap(to_gobj(abo), &map);
 		if (ret)
-			XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);
+			XDNA_ERR(xdna, "Vmap bo failed, ret %d", ret);
 		else
 			abo->mem.kva = map.vaddr;
 	}
-- 
2.34.1

