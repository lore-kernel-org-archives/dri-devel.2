Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A448C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8744B89A4E;
	Mon,  6 Jul 2026 22:12:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cTd08tI/";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA24E89A4E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 22:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIGtHRee7BVDAdqJ0DtglfoO8CXf2J9cimyrPmiJ1azNbaEZe6JX9+KrvRVLIaSQWvQ17UUnR6CbVOM2U/WwebholyfpZX21Qu0Xq8cYxTZFHAcVMwYgmxvFb2FgXOTfGtXrJFh459QoENsQETMnnro7tsWE3Q+svvkv8hbIB2FZ4qFRV4pIyvKzBWAfmHvtPIsG8feIcZUfCuOdKkDkDbS9d4BTgF0u1NL4heYmCJl/etC5D+KMN2US+kJfYSxPwfmRJ3R6VzOlpIKIwrbejVu0l7cLGCzg+Hfqnfr9C8cj+bbwKjZMaH8hGJljReBq7p1mGSA0SdtYIb7tIBX9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JJcJswCT3q6JPyA08+8/7+/d3iMiiJuZqOZb6/wOc4=;
 b=HTmd6lexXpUn5NsjLGdr8pk+3IHIofkP3Uspl7D2xxiZXcuNCufw5rclVB9gD54PqwqOp+1WrTQDYxBvzp55NP6lerQ6GlHl1sEE6cAftjCjz0ynFV8VhIBmvTgQvaRdoBDyF2NORHT4TART+m9OM6ESSpV4eA+hLBsywKtvkhuiJ3519yd4EGR+Kw6vo/jz8BJlqCdtgY6B2pIVWZXZqE0g2DWSgZFIrNIxKro7XUgdvls/fvonps4tYowVPXvw7Aa+V1epUr2oEvOiK+8+YbVvIaY7J1PzdjORUCH8ANW5g4xJIvGxfUmLBCkfFEgEYGI2+q49I+CY7ncpr5ZB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JJcJswCT3q6JPyA08+8/7+/d3iMiiJuZqOZb6/wOc4=;
 b=cTd08tI/RZN2hmm6OpAyogd5QgmFZIxdbMFOk4Ya7NkGxXEf9sR7ItY5hJ1X2N7otC7FXAfKnDzyd8PjxVk1umIy4nra/Gn/K+hQcK2FjGw6K+Nj86ARJA3XuY4b5TBsQIgeOaN0tjcCHN8KDha3qnPGoBDcdBbHuIausxqHfCY=
Received: from MN2PR05CA0050.namprd05.prod.outlook.com (2603:10b6:208:236::19)
 by SA5PPF06C91DA0C.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 22:12:41 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::52) by MN2PR05CA0050.outlook.office365.com
 (2603:10b6:208:236::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 6
 Jul 2026 22:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 22:12:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 17:12:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 17:12:39 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 17:12:39 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix potential amdxdna_umap lifetime race
Date: Mon, 6 Jul 2026 15:12:28 -0700
Message-ID: <20260706221228.434099-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 4891c17a-83bf-43d4-6986-08dedbabb247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Cj+jzkqFbJYaox2DPsAvoCYorFw53EqMo4H0yT1zPJ72ADTCPBcJ6Q6LEs7H1PK7RGGRIICWPr+DW8qdot3eQAKY92M4cdWMOFluSzd+ex+/7n2wOCp709Coe3FqRxa6mwab1qCs/Yo4N11XcnUc2t28VMd1vBWRRyksePlPhQZCz0GG175EW4sQIUDEyoMTZN9IobvV36iKMp2lpUh9rbFTBG2pjC0UisCK7PZeuCtnPc3i6G3EJCGG0Tmc5HvynFo8vBdDlUrZbWGidDAmFZBghRs85r4WlLdOwh8e2d7DOmdnp/bhA2U4cJfJ/NJ22VywPpzQVrUZZ7HtxzhnSQ9XlgZDuQQviNgb1HZfmXJHnJTEeMrm6gc1lmCLjty1gY+z86J5pWRE/mzi1zG1weiFXpoeowEJwiSQUOqXpwnWJEWaFRQEzHhLxnrWFHfxy2wtd1PUOdJ/vaTZxyrrhuKBi9WsLUYuRES4h0efGL3x459wbu6q89bXepsc21wPz3aLFr4buBu9WspS3wevsAApOYL/GF2L8Gc3RYIeNgLv1VH5UTWdp8pnQz9KznzcrsxcJRW7+w7Hrec6sRNCIoY5y79Evu/5i+MMEnFWto0E1Jc8MO0RRe4Vp76OIG0vWKOg4fmgMIa6j2AgoqTR/ISsFEYPTQwdWdNkunIu70dDdUvQa/FjlpspU3HkevxzCil5WQ63wtKkwYPIV8/+gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Cled5aeoRPBJtX2HTnTjoBEvG0Z41ut2MDY9Jp0wplpACBGZkmQT2bVgRexi1iU6OTe0e9Yu0FlUroOkGHJz9BA86JB0GlcessHOORukPcGTDOf7oEHYTpXM2XiBDifNwbAM5PxrfHNJHfLBEL80mEmRluZwtrsqLXKey24W1Kyn+RhvhwzYtGhXLQHIpjQnhvkQ/J8+Cs8sLtBjwGo137ncxOgyFCHWa4x24ygo/vkJ/AlV8yZbfztUu+5qe6p5+wd8v8aDNP8bvlQ/XoVL2xN8bxhyCGeuL/Rf/9CFihYisS0Ek1ZY8XbFq9GQvnDEme8/hoN7KtBffJWXjSvfOBRBPg1Z/vVcCSSp9sosE8QmRKEK/6vvhP9GjszrErU+C2X8CRTnxvLVmw0I5zU1DEvPJCJxko01W9y5NbxwdsRxWRARenh6X2LTnvv/qG2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 22:12:40.9684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4891c17a-83bf-43d4-6986-08dedbabb247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C
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

amdxdna_umap_release() calls the blocking mmu_interval_notifier_remove()
before removing the object from abo->mem.umap_list. If
aie2_populate_range() runs concurrently, it may obtain a reference to an
amdxdna_umap that is being released, leading to a potential use-after-free.

Use refcount_inc_not_zero() in aie2_populate_range() when acquiring a
reference. If the reference count has already dropped to zero, release
is in progress and the entry is skipped.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 408ff7e2a272..7bf635634e64 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1039,7 +1039,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	found = false;
 	down_write(&xdna->notifier_lock);
 	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
-		if (mapp->invalid) {
+		if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
 			found = true;
 			break;
 		}
@@ -1050,7 +1050,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 		up_write(&xdna->notifier_lock);
 		return 0;
 	}
-	kref_get(&mapp->refcnt);
+
 	up_write(&xdna->notifier_lock);
 
 	mm = mapp->notifier.mm;
-- 
2.34.1

