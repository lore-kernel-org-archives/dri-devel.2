Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802B6CA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B7910EE3B;
	Tue, 29 Sep 2026 10:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ev4MJiiB";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7730E10E15F;
 Tue, 29 Sep 2026 10:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5DsGKsXU3YuTDRQIoiNBhHxb6EBvmGJ4IhoXK1WzSybvgYeboi2gdHeeVuV/1Fk+0bWt02Bo90vrkKfbe3kZuF/qR8i302ZXGIW+QiAPhVrLOIWry//ltYo5AIVQdl3ZZ9EFDSUOPwxf3dZ8gMRs57Phmb2FpbsI5Hb75TbM6ktrTQLLVnxt2xsblBvmXQWtLC1QqO55lq7rceNUgPp0cQ0x4yvrru1+0IEsSU7pNI87Ptsv5Nap2BnJavnr/4+CMLVjydScsCO3cWjVo1KacKPSR0W5InkqRl1RsDLcj5a2HQKLMFYeTjt7N0TovFj4nlYfjX64FrVWGNkvw8w4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmY+905tA6UI1hOzElYxI5iX0dPVN9AOAvxO9lieO2Y=;
 b=s5dzMTiu9NDJobiayXCU63GpzwS/qBgVi776kta/RhfwhSFNbPm8ETXYWEppKbwjOymwltZGOSWqiaP+cESYi0S9RAPf3gNGI4YOt1+jT2RanOhs0AhBe90EnMorXlUZ8mKTCQzf0P5sPKMl0nZ+48ECN0684YAhmExU28moO6dHGDwTRAKr5XVMx+Ie5WdeFYQQq2IiPyJ+02m6hXodbxD1BP7M8+m8uteupa1xVj90di4bCrQTaeZbBTP7qoVC2L0IzgyjB1JzSY0vu/3vip8+igeO+vCx65oKRyiUhLSYIx+O5qzX8gC89YnfUjeghwA+2U5t5UDGqsoI8FT5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmY+905tA6UI1hOzElYxI5iX0dPVN9AOAvxO9lieO2Y=;
 b=Ev4MJiiBQTS2WKN+xeGL0Jwy92tDHowSDRt5Ez6gQFXlocNYcXb+W50ChqxWvzYrDMHXF5QhI8lhhMzf++rDSuBYkKUE6OzEo1YYArEySPCCPGgrPhuPOM8gP+/Z97q62KyPf3j9ZT0B3BEKhH6gl1XvaJyu2mJwfWKLCa7ZgA8=
Received: from DS2PEPF00004565.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::506) by DS0PR12MB8786.namprd12.prod.outlook.com
 (2603:10b6:8:149::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 10:54:23 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:f:fc00::20a) by DS2PEPF00004565.outlook.office365.com
 (2603:10b6:f:fc00::506) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Tue, 29
 Sep 2026 10:54:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 10:54:23 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 29 Sep 2026 05:54:20 -0500
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 1/2] gpu/buddy: fix missing split-undo on allocation-search
 exhaustion
Date: Tue, 29 Sep 2026 16:24:06 +0530
Message-ID: <20260929105407.484707-1-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 49402063-561e-4c48-743e-08df1e1805c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: tU4LJWPaI8p1kazD6kNlJJ+9St+fNqr94AmdTLH3zPKDRcZYPCaQ44Zm9cyHESDZn4mvcVT2bkH/+fBsdQZash1eJ9TU3veMkAgZi9zNuTmZuuTrmGgf829wZOoslKaGS8URnaJy5i1Zt7Q2I4WlJ3TxVDPi+ueADHqiKqtKLXTzRqOl/iJOY7U0zFhUov+rY4H5QaCAOuHr1oVUo7B36TKBmEy6buTUELbVcXdk7u/MJB6h7skSNsL6y7K8FpU3TGW0cuQbOZrg8u2cr0ISAHHLT6bJTqMDAXFHGc5sThyQoidh9S39UWQQYhefPkW4XPW0CNsc4bO53jRxwOROFs4bXCfJSRTTEMSa9nPkAvY5UFaV+zyODrUfE1PffMdRFEG5ncARmS6n/3yhxh4J6Go8vH9722Bb8A4C3SjJQerkfMFD7y7M4/vwjBTNqs2uMXw8cXfSNU9mfnNdiEoFBFlTT3qvQKc77MRZviGPGP3JzdVvt+k4oB6VjepB4hnp6y6dbTlFwnK79V1q8rrTDEb2xl+zRsILgp5+ukn+U7r+XjwMZeGXnmMdI2ktxPfM/nII06FB7tMDIVY9h+k7uTIz9HL1BwIyQ48XzWyvsSnVPuPWS3Ihq/3v85ZnVGmHhNHkrfES9hQcz0hgHIB4ZtkXc8DKHGPuj+3k/6EqeYZcU9Z8glTwXkocWcSf2oAe5G7yaa+/ID4Bu4PH+HscTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SQNm+T0PvJ0LBj8O1iek2akd4STck8SzkdcJusKeCWy/42FBEEBFlX5b3IS2wcOMb9mSMHPTgBUyZ9OzqVAnXIBpPxh2X4vY9YP3yctaRlJHEsfdG/z3nGrsB7lnUp+GAQ8MnWpDFdicgjSal/Xb4A8Y6syZg13a8bzUWYBiMkfQe6lLeJ7teSFchGfYgplWLDxvs+eWFrEkKWs3ztN1g5OfITu68/o9WPFSEHiXAg/Uiun+gtPaDqOpep0GzbunY6GOcZTW68uTVpfohf62wYVE7lSVTo8C8qQFS24ec7nvDgH3sFhYYyl/hNUEYcqHQQap+MKBxPglGZQCRbkrUslD/KBwMgZZ+te/aGLmmI9e98HHuViED/VXRd3aSwCG3v+hm7qp71jweQMI9lvcm/8UmR5ShzuqZ7eAGCzP4DHt4BqySmSuqkCaYyrRdPAb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:54:23.4494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49402063-561e-4c48-743e-08df1e1805c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
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

From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

__alloc_range_bias() only undid splits made during its search when
split_block() itself failed. Its DFS-exhaustion failure path (-ENOSPC,
when no suitable block is found) skipped the undo, leaving the buddy
tree needlessly fragmented over repeated failed allocation attempts.

Fix by recording every successful split_block() call in a list and
unconditionally undoing those splits on every failure exit, via a
new single-level gpu_buddy_merge_one_level() helper (the original
__gpu_buddy_undo_splits() cascaded merges upward, which is unsafe
when called per split-list entry).

Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
regression.

v2:
 - Drop the undo from __alloc_range(): it allocates every block it walks,
   so freeing that list on failure already merges the splits. (Matthew)

Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
Assisted-by: Claude:claude-opus-4-8
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c | 54 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 2f2aaadafe35..e5c9e21cd077 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1240,6 +1240,52 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
 	}
 }
 
+static void gpu_buddy_merge_one_level(struct gpu_buddy *mm,
+				      struct gpu_buddy_block *block)
+{
+	struct gpu_buddy_block *buddy = __get_buddy(block);
+	struct gpu_buddy_block *parent = block->parent;
+	enum gpu_block_state block_state;
+
+	if (!buddy || !gpu_buddy_block_is_free(block) ||
+	    !gpu_buddy_block_is_free(buddy))
+		return;
+
+	block_state = gpu_block_cached_state(block);
+	if (gpu_block_cached_state(buddy) != block_state)
+		block_state = GPU_BLOCK_MIXED;
+
+	rbtree_remove(mm, block);
+	rbtree_remove(mm, buddy);
+	mm->free_scoreboard[gpu_buddy_block_order(block)] -= 2;
+
+	gpu_block_free(mm, block);
+	gpu_block_free(mm, buddy);
+
+	__mark_free(mm, parent, block_state);
+}
+
+static void gpu_buddy_undo_splits(struct gpu_buddy *mm,
+				  struct gpu_buddy_block *block,
+				  struct list_head *splits)
+{
+	if (block)
+		gpu_buddy_merge_one_level(mm, block);
+
+	while (!list_empty(splits)) {
+		struct gpu_buddy_block *parent =
+			list_first_entry(splits, struct gpu_buddy_block,
+					 tmp_link);
+
+		list_del(&parent->tmp_link);
+
+		if (!gpu_buddy_block_is_split(parent))
+			continue;
+
+		gpu_buddy_merge_one_level(mm, parent->left);
+	}
+}
+
 static struct gpu_buddy_block *
 __alloc_range_bias(struct gpu_buddy *mm,
 		   u64 start, u64 end,
@@ -1249,6 +1295,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
 	u64 req_size = mm->chunk_size << order;
 	struct gpu_buddy_block *block;
 	LIST_HEAD(dfs);
+	LIST_HEAD(splits);
 	int err;
 	int i;
 
@@ -1313,6 +1360,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
 			err = split_block(mm, block);
 			if (unlikely(err))
 				goto err_undo;
+
+			list_add(&block->tmp_link, &splits);
 		}
 
 		/*
@@ -1349,7 +1398,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
 		}
 	} while (1);
 
-	return ERR_PTR(-ENOSPC);
+	err = -ENOSPC;
 
 err_undo:
 	/*
@@ -1357,7 +1406,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
 	 * bigger is better, so make sure we merge everything back before we
 	 * free the allocated blocks.
 	 */
-	__gpu_buddy_undo_splits(mm, block);
+	gpu_buddy_undo_splits(mm, block, &splits);
+
 	return ERR_PTR(err);
 }
 

base-commit: 90780f2c3d30187116128f71bcf92c8ab63400e7
-- 
2.43.0

