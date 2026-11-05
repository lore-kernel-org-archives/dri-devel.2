Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E2606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AZy9JqnT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1732810E002;
	Thu,  5 Nov 2026 20:48:30 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B265D10E0E3;
 Thu,  5 Nov 2026 20:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikOUIrTadUqFb6YBOrR3di06fzX6vOh6B8y9CfyTpsyblI4OCBpyykAnw8ntf9mT3dCBwA+m9VGTrwde/DfL+cI1Fl97uIAhT5fqZ3Gjjs9uAJubPj14LYeQlu9kMfYvxHnEH3R1iNR+Tx70Eq/MNIgbtLmiio0NzeS7sI8AM8lm1z+5xCoaC2ifs1DzMkX593Dca1RQnDARAQVsEuqueGJ5116m61JesY1neoYwtPzAHL5HUuij+Uq29zsJz7anoIprQX1X8F48Ky0baacBrs0IZrWSPK+LlxxLIXdj7qpbyl48vOp7JK1sVW30x8z+cc4yW41F1jxodhKCDX/Fag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l78nOZIJSIp9koihsVMInjn+BHxXo+QnzVxUJvl7i1g=;
 b=XuzWM6Wh5hpDpoISDp3fuKVabOL00sIPX9H5eCRcstn9Wx1J/7HepGmFXFfPIYne+RlN0jnjbjICHjlEVD4fWLwsE8VdTT/1u/qBnprqe6zi7j12fssTd0xDXNOkA7+uTBW6ferX4896w3ahASEbL+TEyXavc6P0JegGjoZ/4kpaFUON6RvY0g0SBRPuQnzDjFWISSPm8ZWmkXQnxYg866fgXAUiOBhLhlWRILrlTesxP/BYv7hUys4I47+qjELmm02hSgm4jVCC4hAuAyfYAwrtnNI4A+/WUW6tbfP5q7hjeMT1wDnEMzJaVSJ6eicfYrq6uoZ2ihrS/zy/061PEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l78nOZIJSIp9koihsVMInjn+BHxXo+QnzVxUJvl7i1g=;
 b=AZy9JqnTqIrXG4Ii5Q4aJWlPmpgjti8wtPBuZmHy9gzGmILLCoQqZ7Je9DYC0CctvA8Wviy/2L9mFFpHq3paGfGszMVBNZ/I6KdLtnnqvFbVLBX1PUvybe6SEyneFAR0iBm65pFUIDCT5IGhZLrH6LESHgbgodBvAM3TYQ8XUq8=
Received: from PH8P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::25)
 by IA4PR12MB721289.namprd12.prod.outlook.com (2603:10b6:207:10b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 20:48:19 +0000
Received: from CY8PEPF00000059.namprd21.prod.outlook.com
 (2603:10b6:510:2d7:cafe::43) by PH8P222CA0012.outlook.office365.com
 (2603:10b6:510:2d7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 20:48:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000059.mail.protection.outlook.com (10.167.247.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Thu, 5 Nov 2026 20:48:18 +0000
Received: from MKMFKUEHLIN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 14:48:17 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <matthewkrebs8@gmail.com>,
 <jm5905938@gmail.com>
Subject: [PATCH v2] drm/amdkfd: Check ownership of device pages for DMA mapping
Date: Thu, 5 Nov 2026 15:47:48 -0500
Message-ID: <20261105204748.100841-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000059:EE_|IA4PR12MB721289:EE_
X-MS-Office365-Filtering-Correlation-Id: 799af893-8ead-4c4d-0216-08df3b7e1f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|13003099007|261022113327099003|11063799006|10067099003|261022075727099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|56012099006|261009223027099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: XVNXG8tfpSGr93/80aH9rg3TzxpgCWfs7yjm0JBK1KnS0HhEgW76aLua2soqRkbR1/Fmv6iCXQ2XxHRQkHA8p9j8lkivJAZjR64UHoC8Zp2Iy6hIM593MYMIk/bAp30gRQvD0KZY35hJxuaQGxctN+W54XpA6pDTikozG5LoC7K0mhukN/eWfusZ3fggKFKHOopqRLesU+rrT6qXRHYVu2MhbjFG9FpbVhcTmgCPZ8J5uC5VsuKljyzNFi8Mt4S+h/TZfSSvwI//jmFjO+kqVssv5/2YhsrhVLsIalHj+p44f1urdSZ2SdUmOY/nRJU/yLQDR6ezwzVsaUE+9R/jTgkjzfTyiXOMmzQzia8FUd+XCZ+7WHe5OeV8Br8d3CUtHRvRMhCaqy/fsTQp9+FeqVwCygjJxw/Mv8/lZ0kyZC1ygHJ98I9rvTGqWzYEuNOhvOkhlqhhSjsw/RISRZYwqLITFYVxGX6I/wLNYUl3ErX1oHj7INWRHH1B9YfbpoMyjc7NA5CcneGnzLU8f6qCwTmmW+pVCx+BagbIZ3FuPKJrvhadM6kWBMvujjR/LhnRm7XF1wuY4hUIlFMYAa5fQeb+c1hKbgiWQK2Yv+bmqWjPLisXDbmEAGR5KAlRjTsJI4UbuCDUsQelxKX+YqedOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(13003099007)(261022113327099003)(11063799006)(10067099003)(261022075727099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V0RzKJJGUNr9yNGeC926pZ1TgrzcIt4+cs207nq8NGViUA+Q/dGIKFCZZi67km1Iwd90TedPKQ8HoRq8L6sVh7gt+elhzOLGy9nJKHB9KyPEl4d6GKfBlVeCGykEadjNwXq/9vprd8ZRmaQfdosQ3+0zymOEDV8gx6szoQoSN1FO9ijTb4OPXqgxM2ELHQX95IufEpjheMYLrOXcYBHL18YqVXRt/TOgnEpEtXVJXMkgWHc9Xv9fhzSVMCkGV8RN77Y8qChr7WU+ZOw5ETVN+L5FhV+3xRwwp+5GrlsSK1NgqHzRNdSbMrnj+IBOuZAu+XnKoM1aOQg2RbKOwQBGtcsnLGDJqKNYFsdjFDja8irZ/HYFW7LKi6JYzrDsa1A1PRF8Amlk+ifFXdyaXQNTx7AG3pisZEJoNtwuyV1cPbMUSliiaFhz6b82g06RdzLx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 20:48:18.5224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 799af893-8ead-4c4d-0216-08df3b7e1f40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000059.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB721289
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

This issue was raised independently in two contexts: pages from DAX
devices and pages from other GPU hives or inherited from other
processed. This patch addresses both concerns together along with
Sashiko comments raised for one of the previous reviews:
https://sashiko.dev/#/patchset/20261103-kfd-svm-foreign-vram-20261103-v1-1-d6282053cad3@gmail.com?part=1

Before treating a page as a zone device page belonging to the SVM range,
check that it actually belongs to that range based on the
zone_device_data. Non-private pages belonging to other devices or ranges
can be treated like system memory for the purpose of DMA mapping.

Cc: matthewkrebs8@gmail.com
Cc: jm5905938@gmail.com
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>

---

v2: Addressed code review comments from Sashiko
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 876476046926..2aade0183578 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -156,6 +156,18 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
 	       !(dma_addr & SVM_RANGE_VRAM_DOMAIN);
 }
 
+static bool svm_page_is_range_owned(struct page *page, struct svm_range *prange)
+{
+	bool is_owned;
+
+	mutex_lock(&prange->lock);
+	is_owned = is_zone_device_page(page) && prange->ttm_res &&
+		page->zone_device_data == prange->svm_bo;
+	mutex_unlock(&prange->lock);
+
+	return is_owned;
+}
+
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
@@ -180,7 +192,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
-		if (is_zone_device_page(page)) {
+		if (svm_page_is_range_owned(page, prange)) {
 			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
 
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
@@ -189,6 +201,16 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
 			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
 			continue;
+		} else if (is_device_private_page(page)) {
+			/* Device private memory from another driver or range.
+			 * This should never happen in practice but it's
+			 * theoretically possible for read-only VMAs after a
+			 * process forks, creates a new KFD context and maps
+			 * the same page.
+			 */
+			pr_debug("Trying to map device private page from another device or range\n");
+			addr[i] = 0;
+			return -EINVAL;
 		}
 		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
 		r = dma_mapping_error(dev, addr[i]);
-- 
2.43.0

