Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732E60A262A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mFkMUZRJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612A810E422;
	Wed, 18 Nov 2026 20:17:30 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E90D10E832;
 Wed, 18 Nov 2026 20:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1SG+Y/k/i3UKgYLX4hStL209179VGo8QU9VFk6Z1MZcA6ZXwsZcr2gqZMqif9hhvyk4zmD9CMcW0+QwB4aaA8yZgfJmxnhC4R8q026oX8RbHveIu6uT1AlLqkokCY2aGcYSP/6jkBZ6C4EhMiDYgHOTLTqZ745XN/s1/6LyXSyAlueetCe4NUTXZRz0zwZ9PhhZ9QjEcAKLOmhmVklT2L9U/8LB/duH4Vjv9wM3AzAFLfwS1zut+uFWF8OBmY9lwA3fksfimERhc0ozkJRzkQwukZPKSDnvXabQGL/+LFpg0WeJqKTZdICEXEbSfjP8b8z3z9j1gdLgvHWQsIo3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVdh7wdKkaF43pdrqYzHZuewYgS6l+ovpzF/4lD6nyY=;
 b=oVHo7Yuaxu8nXR936Rtm8rWIgmFuI64TAH5WlCerzVU5lzllyqVHlvGluGWvPCHf8tw6t8JJ2qR3AUuwoPRwfLG0KruiDvk3nxGZbtxBAC9upcL1aRqU7eZPwYYUepmTcMKpBgrzBms5y/6pME8RfO5IxefP6VuBj+cgNl0woC1aDSYxztcIHKDC7i2p+Cp/8Lvk2gQw6C+qt3sQ41SLzslrE8UQDOX2JcDPCn3FqNkqVKINu509B2ZiHsPSJdnEpvu8IoHpt69eQzWfMx8la7n7BvjkQDdMiY50XUwJWMX7u4omVbKjnTEvpevcdSARGMdy0FMS93993WJiueXeiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVdh7wdKkaF43pdrqYzHZuewYgS6l+ovpzF/4lD6nyY=;
 b=mFkMUZRJDdQjuE3NsY15vQTIdg3+S+8rfhmPP9mp0DbYBSQQ2r8V6iZuA3Dyjn9sknHlbCEdod+ga1HVpfZ4bvtDWxh7SZ/n+uNWKC4KluCQo/bQYP7z5oAVcnNQnbkUAz+yd/GzdpLFy+2DcKhdr94VNOEqpGCNV/au/+4TYgw=
Received: from CH0PR03CA0411.namprd03.prod.outlook.com (2603:10b6:610:11b::27)
 by PH9PR12MB497784.namprd12.prod.outlook.com (2603:10b6:510:411::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:17:17 +0000
Received: from CH2PEPF000166BF.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::91) by CH0PR03CA0411.outlook.office365.com
 (2603:10b6:610:11b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 20:17:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BF.mail.protection.outlook.com (10.167.252.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 20:17:17 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 14:17:16 -0600
From: William Palacek <William.Palacek@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, Sanjay Yadav
 <sanjay.kumar.yadav@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, William Palacek <William.Palacek@amd.com>
Subject: [PATCH v4 0/3] gpu/buddy: find range-biased blocks in the free trees
Date: Wed, 18 Nov 2026 15:16:58 -0500
Message-ID: <cover.1795032989.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BF:EE_|PH9PR12MB497784:EE_
X-MS-Office365-Filtering-Correlation-Id: 977165f8-9337-4011-0476-08df45b0f146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|261009223027099003|13003099007|261021121427099003|5023799004|11063799006|56012099006|261021123027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: pHwIV7WvlqCOWcSmLZOCExIKjQDNKE92d7Gqsmx54UGIg2welv9B8LDDUPi3XObPZx1rTbVViXtgvApczqR/kc27PAQV4Ehh8wZAwKgneSuoXjbRPvPDjF9Be0VUOWpmydOw8/aHHS5FkUeT9dGgUhawMBiAMRjaV3ztu0pHxsM3PXy0vNstIwL9NgWsnqpIlhdVS7PxYFdOUY74rPtsLN6dhIjpoNsj/y3hH2puwbpP6RmM+2PyNaMC5aKe46TyGo6Srlpl1JfITSPXX57qcQwLQpOv3kiajyRO9tMv5SEJQKOaSb1jLV88o3iJ/4H4vzYeqx27bLz4ntRMI5PSiGQb+UmVXiJenalziTg4iLlIJNYG6o9KyxbMFxoCAsesJVmAtr39k1N3dZnSqgDpGI14u9+ppl08qNgzOFKNpOr+v721sQGDhw79Z5WVRcjjYwV8p784TwthOM3zN6lBgaG8ATX96HuDwhCMgdVVccnPvylkVPIstXuMty7DM0fiuswrcCHq2zsRqE9sDAUGmNB7QKZBU1YT3hs1fY0ssvQgSjlID6y4hSz3Yh/hYDT5YXkj8rqVt+3qG0vVIGTgGmTPXh7WPdQcBT6rmwWp1uo2cu5OXw/64PJYtDPs1cWywCHEB4rv/a06g/wMwE72Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(261009223027099003)(13003099007)(261021121427099003)(5023799004)(11063799006)(56012099006)(261021123027099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rIOhPLg8PPxQnByR8ucWa+iL/M0x/dSlBe4c4GW6oC7DnZpqwdAWTnCJtQBidHSsgwpGzy7tThVcoEUpARIVnIlX8vgmNVi8FExHbf9gn1by9KxPXl/c5g350oS+B77jlnRd8+g72z+ILrx1ybyyevcoLZ8cirVqtyuj1ULcKVepSkFnPQ2jdTwOSdptEdov63rvu2wzufI3atS0s/sBKEnUL62ELySOPRY59Hlttkp4XfLumwacCjodAU2RwE+USA0D7RZvKPZAhj6UaINh/V/hK8nEzuk0zmDb82Z5hvYnmNfOtwOjiTA1QkrIDAOFTEIF7RxV7yf6B2J/FJbc+DW4uteuPR6ZviGE4Dvkdt/fQN8/tfvl9xWXd+XViPZ8CrZHUTffAPUhys/srZXyEORA4IixYgGiJHRWAvXu4xIrnlP3qt6gfDUD3h6H/dkn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 20:17:17.3812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977165f8-9337-4011-0476-08df45b0f146
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB497784
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In a range-restricted allocation, the strict pass of
__alloc_range_bias() still visits every free block of the other class
in the range: a dirty request among many free cleared blocks steps
through each of them. amdgpu restricts every VRAM allocation to its
memory partition under NPS2/NPS4, so it takes this path for every KFD
VRAM allocation there.

Patch 1 replaces the walk with a lookup in the offset-sorted free trees,
on top of Arun's range guard code. Patch 2 drops subtree_max_free_order,
which nothing reads after patch 1. Patch 3 adds tests for an inverted
range and for the NPS4 fill pattern.

v3: https://patchwork.freedesktop.org/series/178108/#rev2
v2: https://patchwork.freedesktop.org/series/178108/#rev1
v1: https://patchwork.freedesktop.org/series/176957/

William Palacek (3):
  gpu/buddy: find range-biased blocks in the free trees
  gpu/buddy: drop subtree_max_free_order
  gpu/tests/buddy: add range-biased allocation tests

 drivers/gpu/buddy.c                | 334 +++++++++++++++++++----------
 drivers/gpu/tests/gpu_buddy_test.c |  67 ++++++
 include/linux/gpu_buddy.h          |   7 -
 3 files changed, 291 insertions(+), 117 deletions(-)

-- 
2.43.0

