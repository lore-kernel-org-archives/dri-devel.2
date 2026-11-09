Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B783606A322
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2PcmwRh9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E544510E8AB;
	Mon,  9 Nov 2026 13:44:43 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247AC10E8AB;
 Mon,  9 Nov 2026 13:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7qFX7173Ml0373yICZ0HTRwpqse1uU4DUULB9fyYwFd9JatO/zd/NIG6BAbPaO6m5v1nxwKj6uqG8LmL4N7jEZYqI+aIVrS4yh7andS0tnK3r/ztO21a6xd02CMPE4KvSHIONB3tkYuf9/ibONpyFbegsnSQOcnpwxkH+Qy210xjL03MZ9b5rRARgoXkt6Q1s9Z9bEskgC0dPo0OsceV2v+GVaF0OplCtD53MZMIbZ4+YTKXweVXViU+UsgxzHfkpq752y1xE/iZ1MNrueWs0+zyaT0ZoQdyYZKQeAHLwjNH4nD0RU492Mn2cYvIfg++pQvfNU/Wn/fU0oO6ozF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIzvUKUICb23eFlHyYYodZ+ZuF8+iNxg1iEmDvfWwWM=;
 b=GvQd01knTgSYKNxfoLOZ7NWb6feC50Vmp2FQIqbYXSzP+F1fZtYLSfXCTJ0OwxBfcbdtETll9u1lRGFIa7zQBk/ECZ3v5RlpyoMXNcvwSUfWV83zU/F0GGPiXYiZ55lu6w2EsCigUUvk4tlMsxEFJwoL4PZeNEwBuc2SM1anwrOHsw74SdYrC4SRCGQo1ZpXjjWhGiPcG1WXiLFEBNnayIDGVNdyHBYC6EQo+v65IXPB0BoeaE/Xw6n0B6M5m5ZwtPoIyOoM66eBwOGrXrUPeNxsxO0fU0YRPv/DI9h7+qYydyvyf4xBiAQ2ctZHjx0tG0AZhx/ZqTVz8zy2qWCk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIzvUKUICb23eFlHyYYodZ+ZuF8+iNxg1iEmDvfWwWM=;
 b=2PcmwRh9GKMVPnmrtbEMv+whRDRUGyjoGmkcSOBv3FriN/jPEHTqmPfsT4HBSu4JCq+IMCVRG3i7rU3Tn5lHEOs6rI0t0YOU+6EVFOdrglI2kvta+QxaELI2bVI3cUBzdTk+6QCUDnt/3FGnSJ8meNfmlVkechkhgEUcUBzdT7g=
Received: from PH8P221CA0062.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::14)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 13:44:01 +0000
Received: from MW3PEPF00001659.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::98) by PH8P221CA0062.outlook.office365.com
 (2603:10b6:510:349::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 13:44:01 +0000
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
 15.21.592.0 via Frontend Transport; Mon, 9 Nov 2026 13:44:01 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 07:43:57 -0600
From: William Palacek <William.Palacek@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, <matthew.auld@intel.com>,
 <arunpravin.paneerselvam@amd.com>, <joelagnelf@nvidia.com>,
 <sanjay.kumar.yadav@intel.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] gpu/tests/buddy: add range-biased allocation
 performance test
Date: Mon, 9 Nov 2026 08:43:46 -0500
Message-ID: <20261109134346.3169162-3-William.Palacek@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW3PEPF00001659:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: ee15c633-d8aa-4f76-015e-08df3e678323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PWclW6rsO11PoiC6NSEuiVfEv8dpiJifgULSiwSIuwjqb8S7Do7HfEg8GNuJawtn+p/i2QuOdxxIdcOrQtFI8t9Rup+V+7kiLWyu2J8+NZ7Thaun6osHqwfHx9XV12Qy2BwL8SWD0Z6MDha32BHcvnQMqf9WGhecybnwiZ3XHzxcxzuPSfIneQlZGMt3JjrmNX6NYDyKn89pExkbq2Qo44Jf8xA2/jcIhnnptMQECJzWkerwFQD6k3O3ptEBtX8Wt3+m/uercD7NhFAKpLW9fhkdGnjjvDuiYyXyMb9rSlGr3jOVyC3P43mV1f8HDZoLn0ybjDlhSFjozpAPy16iZTs3OpfQL+/9lgWwQNxaNBIcD8qWgytGKqUZ1TuNthgfYMfh4dlUS+GAniHq1bsadd2a5UyE8+TkJ7bi+NqqoeC8Y4I6zXvImCPubN7kSeYw8sQwL2FrjSeNO+54EXiCA3d4Zgkmesff7krNGTCNhJW81XU9wmvWw9QJ/z5W5VjFCtDQ6dNEM+lmSaQt2RGgs1iQIP7CtwZQ5250xTnQpARe4X7yRZ3FEXXKbsqTF0WUKrygCn7A3xACRSnRVimDnPu/0PPzA8bqTwwtreuYGvuquF99W9qry88nl0Ev+BasuBzkiOcsNOsMglFCs8xHULGk2nksKZt7+NahggNCTVeYTZnkcIkPYIXs7mCIMDeyPWeOjD1R6mPE4q4tds+eNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j1CUO27SXi8YK+c8+IkO2s+tSmOe05uvOkXKh5Cmp2+xJvn/o5CZwx5uyfKkrydeHJC/s7ZSg8KIxVi7rSO4AUghuuQXyLJpokZW7l6aq1j7LdaBkVyYMb2bfVQLGwYgrwjllJriFqXRLOrEf9ww1mr9O5V5x37JR+JukL/RbKik8Pb62c6EBDhrv/GET2nrgrBzlxw/YUZsen8VJUuaFXm9u5QQSbnoWnb9G09TfNml9yqrKYTPFta0CLYIs9FXfLrrig60rgCKmNgIdJLeZ2qLL6c2WrGGuadW+TsrR0BRymCNyRycFrhFaC15Pzv3wWMEIzJ7r+6IB4MxDxumkahCPTMlGZUR0GRjuwvhgQ04EHQord6DiFeM11n/UWaBOVt+mPIj2NXx9BZt2wa11uL8cRbKSNIiQdT0YmUHVMYE2azpACSLcsmT4rhuG8y4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 13:44:01.1200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee15c633-d8aa-4f76-015e-08df3e678323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW3PEPF00001659.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810
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

Fill a 1 GiB range of a 4 GiB manager top-down with 64 KiB range-biased
allocations that request cleared memory, as amdgpu does for KFD VRAM on
NPS4 partitions, check that each one is placed directly below the
previous one, and report the time taken: 1190 ms with the full-range
walk, 3 ms with the free tree lookup.

Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 2c6f1da1a6d1c..ef4176b4baa39 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -283,6 +283,32 @@ static void gpu_test_buddy_fragmentation_performance(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+static void gpu_test_buddy_range_bias_performance(struct kunit *test)
+{
+	struct gpu_buddy_block *block;
+	LIST_HEAD(allocated);
+	struct gpu_buddy mm;
+	ktime_t t0;
+	u64 i;
+
+	/* Fill one NPS4-like quarter top-down with cleared 64 KiB allocations. */
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_4G, SZ_4K));
+	t0 = ktime_get();
+	for (i = 1; i <= SZ_1G / SZ_64K; i++) {
+		KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, SZ_1G, SZ_2G, SZ_64K,
+								SZ_64K, &allocated,
+								GPU_BUDDY_RANGE_ALLOCATION |
+								GPU_BUDDY_CLEAR_ALLOCATION |
+								GPU_BUDDY_TOPDOWN_ALLOCATION));
+		block = list_last_entry(&allocated, struct gpu_buddy_block, link);
+		KUNIT_ASSERT_EQ(test, gpu_buddy_block_offset(block), SZ_2G - i * SZ_64K);
+	}
+	kunit_info(test, "Range-biased fill took %lld ms\n",
+		   ktime_ms_delta(ktime_get(), t0));
+	gpu_buddy_free_list(&mm, &allocated, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static void gpu_test_buddy_dirty_tracker_performance(struct kunit *test)
 {
 	struct gpu_buddy_block *block, *tmp;
@@ -1617,6 +1643,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
 	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
 	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
+	KUNIT_CASE_SLOW(gpu_test_buddy_range_bias_performance),
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
-- 
2.43.0

