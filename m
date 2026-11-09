Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCD606D818
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=whUukJrP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9844D10E130;
	Mon,  9 Nov 2026 13:44:12 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012069.outbound.protection.outlook.com
 [40.93.195.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BECDE10E130;
 Mon,  9 Nov 2026 13:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMqEeBdDXMK8CrgHBAYycgmSjqehoqpe+j2GqC6VY8W+SDFwNPfoN9YcwjQi5nPuzPK9li5pzdnT7+Zjile194k0KybenuIR0CsVw+NmSVtlZQgR1LfEHRF1OAq3lxDdfsmwXYW7f7AnZIpKQG3SDyL0KiV8OHlVl0Ufq+5y3+63Sxt/qrblLf6wv9lMAvXBA9tc8QZS8Qj0XgE83F7WILvD1Q6C10s4nSaX23iNqbAL9US9NqrBa7JYGXDZM2pBPXY1SoBDdrkVO30OXYFgXBbWUnA60kxDdDRvUNwT0tdFAqf42ipFMd3Wbf70MCNJVYEPaLxzQ0ofw5YoeSmrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2M1o1ba4v3PCbCAr1JPtXsbnZdmsAOyg2ETasB2wEuE=;
 b=WVMGApHSgK5VyDJ/TUcFHJRJQOS0IqohFdfw7zu4mlbro+2xCtsIuhcVsSa1pHgcLNGAAVcksnPJBtNS61kFAMrRTxnOiSeIm0j3pH2ce/ycxMkodu+9NGeAbWhRWsWLJDkBkH9HB8JIhqYgPUwYhZjN081zPJDDcPbkcrniGA9UbxkVKzKYBN8X+n4fP5Q0mvs4eSblC/KEmEcegG+8z5RG+wi8yo5iDRw81FhY467QtB8xTFZmrfZUqJCgoFtO7JK5ykx6OLwcO8m+66sI6ATexQHPnFmHb+iErYF+xsZGRt8IGbzr3H8Ez1vdc/5Wtnn4lCPdoOSFu9cpVaztEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M1o1ba4v3PCbCAr1JPtXsbnZdmsAOyg2ETasB2wEuE=;
 b=whUukJrPrwfRtUbqy/nZOgd+LuSSdBUivCdUnm999qdT/5UkLE6k4VpeOu1tzUcbP68hieQHDpm9BReP15nPXMI/s5uydSmTUh2r+6JpxNTiGNVOXp7OXD58u3SpKYNNvFMXnJPKm0eeSsr9gZUhJEAsaF1kcvkE16ii/MPX4XU=
Received: from PH8P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::16)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 13:44:00 +0000
Received: from MW3PEPF00001659.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::10) by PH8P221CA0064.outlook.office365.com
 (2603:10b6:510:349::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 13:43:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001659.mail.protection.outlook.com (10.167.249.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Mon, 9 Nov 2026 13:43:59 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 07:43:57 -0600
From: William Palacek <William.Palacek@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, <matthew.auld@intel.com>,
 <arunpravin.paneerselvam@amd.com>, <joelagnelf@nvidia.com>,
 <sanjay.kumar.yadav@intel.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] gpu/buddy: find range-biased blocks in the free trees
Date: Mon, 9 Nov 2026 08:43:45 -0500
Message-ID: <20261109134346.3169162-2-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109134346.3169162-1-William.Palacek@amd.com>
References: <20261109134346.3169162-1-William.Palacek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001659:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f5e98a-ffef-493a-a5b3-08df3e678227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: BOEg2n/GxdASp4XjMD9oct2nJ5LqZ6/MEMgsi0eCwvNgITEPmVxx3d5SzrOihj1hUpEjVN4KP5oSuVSWobO3lGeqjAho1tGJOwZARt/yeVIdYzXiyy9C37r4ftbePt63wYchU0QgWAyAKY6dg7DAzJAnpb7eTIVpjdNOQJB46t9UrmfCQXM3uSg5Whs5YLkT3YMbN9LhHnTckW50JVLmJM0n27pV9pnbHpitUA7v/8zEQKsP8MJFnyZWFXlm6OsDcNKCQyMRQWGoje44YSb/ckroUUsfUSF1DPNXdNqL09Jx3RioHzyRfc/0hRB31gKV9/FfzKcWwcvjm1mUpsXCHsv3yO2DbKGtGhVD1++gASGeaOPG+yYs3kcimdmLlzYZBHFCET8YsZ5+olz7pB8r0gzEoQW7uyi18dwVI2F40tRKcut/rit9cFu1HCmyjoVoPPvCk3nSLHyolgwf6n53q8aefqTpsYUnmDs0MYWnx9ZK+DohhCJyyVXFjWPUZqIj6cnTnZayGqeKwX/Mak3CLRucQHaRgCm1a8dk9pUP28aPtds7Z2PN44erM12fQ9kZg6W8HsqSQQV0CZAhG+Q3EXGk3+3MO5jundLv5FcLq22VLZCXtNGiNBcOSdPbEcy1iTCQkw/ZJX39JeRtBmNr403jr8DEwIdotY9/HiA5ilHmcpekX9+RtdulbcAHCsuMa+yle+4CAfe3huRiWELdrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I9MNNPuDM/kEEj/V1Yr155QCwiRF3d9B1xREb5Gk6HKkpYaiw/igNoyOZ/f492oa96MliehkSuAtM5oPAnpDBOOEjs5iBspZmR9zkgJJ/kMcDnbK2v00HOen3g8Nc4ywIapLmFWVufBS93sniV44gRKGj8nXRtg0nwTOkrd1Xmhp3dWnuhdaiRt19hOpVXgJ1QdVnyGCUu8WnhoJND06cTYawOKm+WwPHGVml28Q3XSrVgkx6teCs8AGn6uaUfwr10NjXuCFMU7FUpZbSv4VlgkTgqpYl4ruwxS/k7+Thth9pGC/1V+/lpjmV3PYzn81PsT1Gq6xOf5ioIxFOy0M9sWc/8j2LnWDrPTMR14d0DxeaY4BmUFhSeeGiZOjBHwWUFjOnIBuNAf/JP/BtGOayGkEvgyn8Yv82hx8fWcdM/ehX6nkuVVv4lIR2RKDXXWm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 13:43:59.4748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f5e98a-ffef-493a-a5b3-08df3e678227
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW3PEPF00001659.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__alloc_range_bias() walks the block tree from the roots and visits
every split block overlapping [start, end) until it finds a suitable
free block, so a range-restricted allocation costs time linear in the
number of live allocations in the range.

amdgpu pays this on every VRAM allocation when memory is partitioned
(NPS2/NPS4): each BO, including the page-table BOs created when memory
is mapped, is restricted to its partition's range, and KFD requests
cleared VRAM. On MI300X in CPX/NPS4 the compute partitions that share a
memory partition also share the VRAM manager lock, so the walk is
serialised across processes. hipMalloc latency grows linearly with the
number of live allocations, and vLLM piecewise graph capture slows down
with every captured graph.

The free trees are sorted by offset. Before walking, look up the highest
free block that lies wholly inside the range in each free tree from the
requested order up, and narrow the walk to the highest of them: it then
only visits that block's ancestors and keeps the existing split and
error handling. The full-range walk remains for space that is only
available in blocks straddling the range edges.

Placement changes in two cases: a free block straddling the upper range
edge is no longer used ahead of a lower block wholly inside the range,
and for a clear request without GPU_BUDDY_TOPDOWN_ALLOCATION the clear
steering only applies within the chosen block, so a lower clear block
is not preferred over a higher one that is not clear. Otherwise blocks
are placed top-down as before, including with
GPU_BUDDY_TOPDOWN_ALLOCATION.

Filling 1 GiB of a 4 GiB manager with 64 KiB range-biased allocations
that request cleared memory takes 1190 ms before, 3 ms after (KUnit,
UML). On MI300X in CPX/NPS4, with 8000 live 2 MiB hipMalloc allocations
on one partition, the median latency of the last 800 over the first 800
is 1.60x and 4.45x before (two runs), 0.98x to 1.03x after (four runs).

Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/buddy.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 28cff97d57dc8..8652ae35d323c 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -665,6 +665,26 @@ rbtree_last_clear_free_block(struct rb_root *root,
 	return block;
 }
 
+/* Return the highest free block with lo <= offset <= hi. */
+static struct gpu_buddy_block *
+rbtree_last_free_block_in(struct rb_root *root, u64 lo, u64 hi)
+{
+	struct gpu_buddy_block *block, *last = NULL;
+	struct rb_node *node = root->rb_node;
+
+	while (node) {
+		block = rbtree_get_free_block(node);
+		if (gpu_buddy_block_offset(block) > hi) {
+			node = node->rb_left;
+		} else {
+			last = block;
+			node = node->rb_right;
+		}
+	}
+
+	return last && gpu_buddy_block_offset(last) >= lo ? last : NULL;
+}
+
 static void rbtree_insert(struct gpu_buddy *mm,
 			  struct gpu_buddy_block *block)
 {
@@ -1247,11 +1267,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
 		   unsigned long flags)
 {
 	u64 req_size = mm->chunk_size << order;
-	struct gpu_buddy_block *block;
+	struct gpu_buddy_block *block = NULL, *tmp;
+	unsigned int o;
 	LIST_HEAD(dfs);
 	int err;
 	int i;
 
+	/* Narrow the walk to the highest free block wholly in range (top-down). */
+	for (o = order; o <= mm->max_order && start + (mm->chunk_size << o) <= end; o++) {
+		tmp = rbtree_last_free_block_in(&mm->free_tree[o], start,
+						end - (mm->chunk_size << o));
+		if (tmp && (!block || gpu_buddy_block_offset(tmp) > gpu_buddy_block_offset(block)))
+			block = tmp;
+	}
+	if (block) {
+		start = gpu_buddy_block_offset(block);
+		end = start + gpu_buddy_block_size(mm, block);
+	}
+
 	end = end - 1;
 
 	/*
-- 
2.43.0

