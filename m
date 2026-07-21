Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE7DC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBEA10E770;
	Tue, 21 Jul 2026 11:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b04gTSTA";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010009.outbound.protection.outlook.com
 [40.93.198.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE38610E34B;
 Tue, 21 Jul 2026 11:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYGwBB0mi7QJpgG1IhUlushELx794EWsXiWLcWhNMMieLoOmMIVA0uYe+qDMeF0UBK2xk4fuDLn0CTRcevV7O9XPaUPHIr5avgKFrIswiuqqimLfVFdj853ofo+Jr0hpDFf84Um9lJxxLrnVuY7bJ/UV8h+uGFDNWYouD6uEdxXGNb6YQnwYe1tRes6e0nYBTHj5fln1zqwqjBgGCzcswWHiJ0IJRNIieB73NYMKv44AMJvXYNilXuivuJxUbPJP60Fs8PThko55pC476vlNhD8gXHMaCGbvHlbFZNEtbVyqdA6pXkwBgGv2W79w8apMUP0OL1/cimh+yVUa0RsasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7N/HdavdWyUmF5+YaGNBKT110155ZjaTO8v3FW8Igrg=;
 b=v33gkXajh12aZByXn7LLHr9pL0RBIsA8B5dyYNYAkaOXrmqDHY7Jt8EkS1NfKOcidxdM0IB3RNKDMRJbc9YlcmE5y5+VCmhPvYIwKPJZ2NU1fw+dLN3N9WX7abMWZBxsTY4jkoS27LDYG1hmu0sRUhqNYo9O0iy8L5vqUr/jMubSnjvIsNTEPGSdnK15TlGd41YHNBpu+wVm/oskyU5B9i+cDww7T9i1tUrQ5yHKfo74dzsVgsvaxTCyZq+XFIGy4C/ajLxovLUYcNtJ4kJUNoL9kudI+kpyeGcv3NbskGIrYXYC6lYTOJRfLP4A8BaP+/d+nxAWuSI4J5fr06n7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N/HdavdWyUmF5+YaGNBKT110155ZjaTO8v3FW8Igrg=;
 b=b04gTSTANV6ylC+Ded0ejCViUxoZnLcaYORFmGfZN4qhSh/9svahJFyUJgc2659560nSIkS8ayKEBx1OCVw5WxM6DnIj6VSITDacBHemJMvcBqDzkKw8Z/O/RiyR1udV7xooFbxmXrdaEeM8lg4UZt3IrNYSTF0KeO7hYEt7Izs=
Received: from CY8PR12CA0040.namprd12.prod.outlook.com (2603:10b6:930:49::7)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 11:43:04 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::3d) by CY8PR12CA0040.outlook.office365.com
 (2603:10b6:930:49::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 11:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 11:43:04 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 06:43:01 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v6] drm/tests/gpu_buddy: add a new test case for buffer
 clearance during resume
Date: Tue, 21 Jul 2026 17:12:36 +0530
Message-ID: <20260721114236.507578-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fed0e95-1b92-4ad8-dd6b-08dee71d3a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|5023799004|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: woyyVycRKsedmiA/9JLr+b9BA5IpOKHokVgFXKAKHJ9+mEzlxO0QmDCM4Tb45QGL7rmAzcQWZI8T0UOERjSPIIaeu/aEb+vp4HBtGZ3vtrSYqYw3wHridKNmRvBXikurnziGQJXvfaOAesP/ge/OiygmBlE7HLgoce3yW6lQJ1okpH3w9E9PRl/32dCrjnV9zofmV96WMRbgpqWvuSumscUkUcRXTEo/8iDAHYMImGwZazhVWa2PBFnPA/tHNBHGZMeVI9cxd4+ckw5yMRuDy3qGafYCXDD0xi2mitNGeKcGQ5oJI+dJbk1kHtXSePwYc6dfEhuUtgstZC4LOLlzWEknXWJEoTVWBPFzrU0z15gwfXzvrNlO0ctBRPlJNeKcJCgb7F7kuiN/jzU1H7VD0kYlSD48BmYwNmiJPz76Eb/8eFEcZjLVuE/WWMt+kUZpA/3kLetGY02QuMcwc8wMF0JwqfAgJeF1tm9xB/VJayr2vgUslu3jUuWaK7cR3ho5QHqGYmXsQClIVoYNXXNbBldMrt+L16bnMMycnG6qJGRMD6cF51L73o0+4ncEuzbRqqDd6EClYhvFSN7wPoeH6zLL9HE96ntTZ4IKjiNrBG89CRZZVcEKVAS0C4bNYmMdYVcVEXMe9ws4CiXBUt781G2uQX8oM2b64BQNV3yAFhHmGisv3h/UAQ1tOEIR/qLCRKitvnIwMa1rrcNuaFPl6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M3uEeuNJrIrvuM2pC1Ve6YW90zSR+1c6YsdV74mhdUUTmX5EwssxnQd4NLQCliTguEA+Y5tlCcBJ5Pf6IDx4fBvRg2Dmosk6+jBvVKE4TQfU92RuH1lnauSjXi+ErwYXAWcyEM0RjBRlpVtpyT64MCNFquT6HKCYTzoeG5uLxgRVrq2kY83h2uAi2oIbgO/vNxNru+R35YDQ4gBkDw9h4cDuXHtEkhsDw6JKoi2NoHWISeG8auRG2O95qTUtox93bkWSPJH/HSdUPYcIZ99Y1O3TqtQUSCS7ew7Ym37Bx1VMsLmFps/VKhcEa5PjsEXRtwT1ZFUzLwGpSxj5VAG4HdtZQ9Sgn1lab8SrDaYsI2R3Ff18/0chTQ/TvIqzn8AJa+qyMjywtNp+GtpcmeXYtrj4j4vR0u+KiD5T3oM3Rg5hTtZ4iuylrj5ajSE7z4gk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:43:04.5510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fed0e95-1b92-4ad8-dd6b-08dee71d3a01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278
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

Add a new unit test case for buffer clearance issue during
resume.

Using a non-power-of-two mm size, allocate alternating blocks of
4KiB in an even sequence and free them as cleared. All alternate
blocks should be marked as dirty and the split blocks should be
merged back to their original size when the blocks clear reset
function is called.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
v6: Standalone repost of patch 3/3 from series 151686; the other two
    patches are already applied. Rebased onto the gpu_buddy rename
    (drm_buddy_test.c -> gpu_buddy_test.c, drm_buddy_* -> gpu_buddy_*)
    and updated the subject accordingly. No functional change; kept
    Matthew's Reviewed-by as the port is mechanical.

 drivers/gpu/tests/gpu_buddy_test.c | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 7df5c2ae83bb..89698563c61b 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1002,6 +1002,47 @@ static void gpu_test_buddy_alloc_clear(struct kunit *test)
 				"buddy_alloc hit an error size=%lu\n", ps);
 	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
 	gpu_buddy_fini(&mm);
+
+	/*
+	 * Using a non-power-of-two mm size, allocate alternating blocks of 4KiB in an
+	 * even sequence and free them as cleared. All blocks should be marked as
+	 * dirty and the split blocks should be merged back to their original
+	 * size when the blocks clear reset function is called.
+	 */
+	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
+	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
+
+	i = 0;
+	n_pages = mm_size / ps;
+	do {
+		if (i % 2 == 0)
+			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
+									    ps, ps, &allocated, 0),
+					"buddy_alloc hit an error size=%lu\n", ps);
+	} while (++i < n_pages);
+
+	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
+	gpu_buddy_reset_clear(&mm, false);
+	KUNIT_EXPECT_EQ(test, mm.clear_avail, 0);
+
+	/*
+	 * Using a non-power-of-two mm size, allocate alternating blocks of 4KiB in an
+	 * odd sequence and free them as cleared. All blocks should be marked as
+	 * cleared and the split blocks should be merged back to their original
+	 * size when the blocks clear reset function is called.
+	 */
+	i = 0;
+	do {
+		if (i % 2 != 0)
+			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
+									    ps, ps, &allocated, 0),
+					"buddy_alloc hit an error size=%lu\n", ps);
+	} while (++i < n_pages);
+
+	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
+	gpu_buddy_reset_clear(&mm, true);
+	KUNIT_EXPECT_EQ(test, mm.clear_avail, mm_size);
+	gpu_buddy_fini(&mm);
 }
 
 static void gpu_test_buddy_alloc_contiguous(struct kunit *test)
-- 
2.34.1

