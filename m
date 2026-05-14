Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C95ACD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 17:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDB0610E3BE;
	Thu, 14 May 2026 17:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KS3pxNmU";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9790710E3CA;
 Thu, 14 May 2026 17:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ER5QfBArXa8ppSjP1odOyotK+6I6CtLucjUau9VTIX5XZzf5xHNDQf0hgtpt2O0eoxUAflp7qgJPaycZ/VBFMhqFGtA2SefyvJc+3vFxgDAscND3+KbWl9MmpZNZ4jzutWuhphWxxzKZH8tPugLInAQ/ukhOX7KOyFtqTBiAXez9d348HYTX7BJZHkXC2V3ZCg51vGlx7qgfejUGImD8JuSRftP2UnSDLJg9EM2d9h97IF24duN6HQRt6yEs8pP6NWoWaLJENsnmtcShs/FEIamat3DV8k6ctnYD4XS6rotA7PgA/e2jeW42d3EKb3PIO/DZSoQnOjFLjDwBzgaWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNBtypnnMPtjA2redigw9vdP+OHc++8G5ZSIEwEI9wY=;
 b=aIQ7h2D9KyViS2RpAiYXwS/KWghiIYcRtLif1i64Rq/GA8ljqUojNft3uDp1a+rZpaW5VEYMBzFe+5JuOJnJx0ntaLvV/UCWcca1cy64vOhyg70XbSsP6KfKtqYZiezj4fKoi95QO0OD5jPElP/7F25A1TQ1T4TKxUYHa2Dimpdi1tVR+aWjc0aeAkOOiTFtZsU9EGtoHqUoEc6MKeBQlz/J/Mjem3aMtxhAAhsu/Pu4ab4jTExP9ILn2jusCXa7fqyyGsH9jrAOJPE0FaDR1B9vhyUD83jvG6BhIsERzwNAPoNCAUm8n0CBKhumPzh6BQIpYiycPIRTSIbdwltt4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNBtypnnMPtjA2redigw9vdP+OHc++8G5ZSIEwEI9wY=;
 b=KS3pxNmUQaEpz/0UA5Ws4lrN2Y7+8pEUKX7jlUA4JdQlJjlqp554YuphchezUSsu5zj93kl4MtFHg4sbQmGBFm6GoWenpQH5oEsrC9+821yYTCuPQ85ZhGrm43U04UruKL7DdEnfbW1oLO9+Arj5Ip6GOBekgVUcqbkjN9JQMUM=
Received: from PH1PEPF0001330D.namprd07.prod.outlook.com (2603:10b6:518:1::1c)
 by DS5PPF78FC67EBA.namprd12.prod.outlook.com (2603:10b6:f:fc00::655)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 17:02:50 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH1PEPF0001330D.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Thu, 14
 May 2026 17:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 17:02:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 12:02:49 -0500
Received: from kylin.lan (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 10:02:47 -0700
From: Alex Hung <alex.hung@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <alex.hung@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdkfd: Fix UML build guards for x86_64-only code
Date: Thu, 14 May 2026 11:01:39 -0600
Message-ID: <20260514170139.335618-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DS5PPF78FC67EBA:EE_
X-MS-Office365-Filtering-Correlation-Id: be88f994-2a5a-48c0-6376-08deb1daa122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 4qqQJMrRij/cqwlEqSr1X0wDUKx08XieRI8YZOyRR4HOVf+fk8WUjM1eEeOZ9L7VY7A3BaffGic7rYGJbnWCMlzd6V5RYOaU3o6jimyJYBJWjDiCiiai1Al1X1w9cgizF0yS3wnbWzE9Ue6oToXx9iXGlJ9D44jT2U4LtcugvQRmY68bljKNe+uxp0W9WoB+HXyTirK5DV1cyGzIIIcn60K64HoIO4hnuUNjxWd5a30Yo/qhOZsAcZSwWscuBnKnmmgIT31/2cc7R7i+Hdkw6G/G7L9eT0tX7CkMDVDx6a0zqK4tVwhJOcwnXSX19Jm1j2LbexxIatGimrJ8TDaKeZh6FjbqqWGsV7z751uMnXjpaDsEWwnHnyfnNUVa7t8kbbGj6bUT7KQOzpRqn2hdJWIUy8i7a3VlXuUKgc4CtLRApkCwam36O3RSJO03ZHENZOY26Gs5x7vqFjxhfLHM6pUIuM9SxXSCsswXb6Bs1RgHIe6bdsonTe5HmC7mqLbB1IQGrtx4bNqqs5QtHK0xtsBj11AwVpol4PRh9ydzNv4bdcir2YjERB5c/zwDNN7Xizkbdkko0/eXQfNmg4UdvwiztXTr/5D4cEzN48Q9ZUCEiZex0El7Fo6yeGwQgt76Ug+tUkYSwQusIggq9VycyTzaMH9VFevDD5XPnX6ikozcjbm26bJioDONmoLzeUDMvlxVZk8RTqq70ByTVhEL1o7qqqI0Z6uccl1UCF0LOEI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yXIkLPSWO9xKT6AGSXlIG8Y4jM/9BvXZU55dz8irsYalxl45Lp00WdPdtl3wSBy3XP0OTzR9c3qETgpIC5a88nZ6rOMaLbVu1tewJmhaUqC5zS2e0G98GI+3kpQbPZuol2avA43/NTSMu1AokogRcqmrrnbztb1/7WDjrL5deQt1t/EEQU55oFaVbWsoQwH0IS9XD3Ec9gPue70Fl+kLwacIA+pq/AyvpxWYM6448kJzZG5yRX8WfAqEPHpJ+HsxGjTkSGy0xy9U5rf70kauLnAqJ3otj6V3syXjXusMr+T36BWgdOd4jXl/eYnZxnm7OMDqQI0M50nz9XqN+x/E4iToOWoKnM52rtNd1vKjqz0IXzHCNvOahlxKJj18JqO+CatEed1KTceNpIgzLqDevwaHvY1gbM4/cnFGgpofhKSKf8P5ihVamCXQGRMjT2YR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 17:02:49.6530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be88f994-2a5a-48c0-6376-08deb1daa122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF78FC67EBA
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

cpu_data().topo.apicid and kfd_fill_iolink_info_for_cpu() rely on
x86-specific structs not present on UML. The kfd_topology.c and
kfd_crat.c were guarded by CONFIG_X86_64 alone, causing build
failures when CONFIG_DRM_AMDGPU is selected on UML.

Update guards to '#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)'
to ensure x86_64-only paths are excluded on UML builds.

Fixes: e6b71bcdc409 ("drm/amdgpu: Remove UML build exclusion from Kconfig")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605140506.TI8zPIBG-lkp@intel.com/
Cc: Harry Wentland <harry.wentland@amd.com>
Assisted-by: Copilot:Claude-Sonnet-4.6
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index a1087c13f241..cf7b1b038d5f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1821,7 +1821,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
 	return 0;
 }
 
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
 				uint32_t *num_entries,
 				struct crat_subtype_iolink *sub_type_hdr)
@@ -1880,7 +1880,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	struct crat_subtype_generic *sub_type_hdr;
 	int avail_size = *size;
 	int numa_node_id;
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 	uint32_t entries = 0;
 #endif
 	int ret = 0;
@@ -1945,7 +1945,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 			sub_type_hdr->length);
 
 		/* Fill in Subtype: IO Link */
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 		ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
 				&entries,
 				(struct crat_subtype_iolink *)sub_type_hdr);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 46db0d65d242..87e13f021457 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2349,7 +2349,7 @@ static int kfd_cpumask_to_apic_id(const struct cpumask *cpumask)
 	first_cpu_of_numa_node = cpumask_first(cpumask);
 	if (first_cpu_of_numa_node >= nr_cpu_ids)
 		return -1;
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 	return cpu_data(first_cpu_of_numa_node).topo.apicid;
 #else
 	return first_cpu_of_numa_node;
-- 
2.43.0

