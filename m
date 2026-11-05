Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E12606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hsEE9o96
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D5410E310;
	Thu,  5 Nov 2026 18:59:05 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFBC10E310;
 Thu,  5 Nov 2026 18:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOcZUrvbkTZzcAtiMaovg5SoqpmRMUoYvDZAMmefPDSq/nGahhOmHS+dVUUJfV/9JVfUsej+NSmWr7JPSIoJuYZKxLxapMMkxxruQiSFM5lpjSOn5b8GY2QvNQIxYsZKvJkdLTl+po4SJFv5km3uoBuqreMwJqL9ZY6OsnJ0MjBmSaDFJXZV7wIdJRUFIbe9wqtrT9uno3swWhLB0zjqEqQ7QfoWi2PL/iBh8GnrGhjtswEeaHZMrFaPn8yOUSO3dVgfgnjj7u+8O8Ql3fL/MU/r4l03M5wQP+zYxvlLBh5WBEn0TkfmNk/wMiTcFYloXCN7QpZuecoEPrGPnVe4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuY4L/exY7bMsxENrSLe5Z3fKLP4p6o99+Xzqmp6qDc=;
 b=o+z1qoisb4D+0o0wrCC2b+Rm16te591D8X+3Bu+2TKzbeKfoz16CkwDFQCQcAnjdeIogfqZPzD/Bp3ezIh7Vx44RbrEGSpELFSFo4zaCAC24/qH1SYP3QCbSxRWv3zLNkzko73IafIQEE66lh/E/3oFRcJSQr4B+Gn1ZU6FMFQLS2T6EkvCDBXTlQjLVaM4JDomFuarH5/EfLE6jx6lkm1TKpXmgxLDUeRRIMrq56NMcIL6w34Pn9hGfgeZDA27+iUG4J4LOWaLB6x0zZZr7OKCxSVeD0EQcoNoZYmQuP+PxPAzWMgUIZYCM8pLB1fcmb6ZA4xoeEmhGfv2MGmoN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuY4L/exY7bMsxENrSLe5Z3fKLP4p6o99+Xzqmp6qDc=;
 b=hsEE9o96QUoNvNboOam/hOPWtDmZ4HtY3/eTDesJNDF6yAR4qLC4sKYvkoxn78AHb/N+5dIfiGrybtGDF98EEbYTn6HY62DsNmnsEuLjz+4BPmAiZ3g25tmxgwXHdZ/eMhI5ZwTOAkd2cJbksGo2oBgbS4iqeldILsl4mE21RJk=
Received: from SJ0PR03CA0147.namprd03.prod.outlook.com (2603:10b6:a03:33c::32)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:58:54 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5d) by SJ0PR03CA0147.outlook.office365.com
 (2603:10b6:a03:33c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.11 via Frontend Transport; Thu, 5
 Nov 2026 18:58:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 18:58:54 +0000
Received: from MKMFKUEHLIN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 12:58:53 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <matthewkrebs8@gmail.com>,
 <jm5905938@gmail.com>
Subject: [PATCH] drm/amdkfd: Check ownership of device pages for DMA mapping
Date: Thu, 5 Nov 2026 13:58:28 -0500
Message-ID: <20261105185828.85367-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: e68d8434-728f-424c-87b0-08df3b6ed6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|261022075727099003|11063799006|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|56012099006|261022113327099003|261026121527099003|261022105027099003|261021123027099003|18002099003|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info: whLwEAT7c5h1jkcRB/zt++YyKkqlX3QtMCmLbL9ReLbw1Qw1e+UogpboQixmvt7vHfdaWd+prVFFw03Xi4Z/5VSqY+dh5KQWsQQCmhgpwK6KUa/j+itTDyU7/2CzZaLFe6xXuIFQkkklDIQWR4CDCFyKpXO8XX5RqdcTUB0XmtzEwZpZsqIdMwOF4b1DdIGIK4noLVKSO32454t8D/ZBesSR1T2eRm7y31zQXOzWr/c/WKcvJtZyb52plOBLdDiEnr6ituBT2NLRtyMbAGTGuErShKLwDveg8Y6LCffpkp5DkOmvWvZnysjFO21zRkxYAFYkaNiTcRVexMUXt/MAOM8ffRuc+0zttSC5/+qi22Isx6KgMPtlQZ6D0Zrh++HPCJyINQB6esC9tJRbUuFsrPa/6TW9HuFS4RRGbtVhSU1rgIfdX4RU6vQwOvL+C2ecbfLPiwDls9ixWMuud2FHUwJQSglAwacjLAugoQttUtejeB6RogWu1sF3f8KVus5bhKq/n9bLcEvpKM/Anq76mdpbZswnEcaeUw7xdVzM7w8ZUDR/Oh4rdCRUarMuIftPI53QBUjAMKwM4uU/Z4XXzEFmacPrSBtAUA0tXp7A/voI11E98E6h2aeSuZY+inZF2AM/Dr1S/imTssZDsihIjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(261022075727099003)(11063799006)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(56012099006)(261022113327099003)(261026121527099003)(261022105027099003)(261021123027099003)(18002099003)(13003099007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A8/MNAsjSmnfVJQImDMqwYndzLy3vWr8G7bjpy7xwoAkthAvz49AaUqkKSP9CQ2LMwY528EjWLjmplOSPn59vvRlcsdUj6Ss5NuKTvrR+V/l+PNnVH+kIDVvj8X5kZE4XeYgijnfZ3sktJ5ceNdGXX724SVtdYZUA+nDscpkrD5eDS4EQQd5Tp6yQBVyPLXtnxyn3SRYaCKUvuI5FIdW0/v2DNwdZwdOZz8SgxdPX75qmhJLzanLyHB1+6vwZeBEd/lgjJNf58V9KvTuW6Aku1uL3r68jHvdEymM7BD//jDwpyyr0HxWrHo3WC/hv1OJYJKKj4SnJh//kovDYeC8AbR4RbhKVf0/cKsnb5YGojDZGp1fVwxACUI6NcAVWiAgZ7crE2pDIF3zmjUilimCQ4S+DH9ddJIuG0zaNpPFl0wPFQl2Fao+U6ifOeQi7XM5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:58:54.4648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e68d8434-728f-424c-87b0-08df3b6ed6cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 876476046926..649f7192b861 100644
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
@@ -189,6 +201,11 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
 			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
 			continue;
+		} else if (WARN_ON_ONCE(is_device_private_page(page))) {
+			/* Device private memory from another driver or range.
+			 * This should never happen.
+			 */
+			return -EINVAL;
 		}
 		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
 		r = dma_mapping_error(dev, addr[i]);
-- 
2.43.0

