Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BF8C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B72810EB10;
	Tue, 30 Jun 2026 07:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dG8hYri7";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3015210EAE9;
 Tue, 30 Jun 2026 07:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e//um6/iy9p1Beaexi8EWlB9sZ9dtMxh8lx4oehfA1ghrkSWgaZIP9v6HrRxCLBoUEy5SLe6IzlX0XF+Ek8KCi+cNs1Be7xrkDCY9JoLokqRSxPVoaVKEU0WdHO6QVpaLGyDLavB9O9YL3d5vgdixwFpSc7BvUKntOPgHIkEQdBQNrV29VWoQIDgK/RXrOOf9iiKObkDAN49GsjIn8ziYM8yYqw4ah0ca8HAoJlWcxmdBbk8dQI6ZTAddYbJii3gaw8gL/LIVFDf4WlDpzEMjwxPYz4QB05UTCMGJKCiq7VfJHxS2z26E3qc7leh7YVAyhxw+SGTVBfeVqOZTM+MTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsxQLgRMH6IW7B2u9jyhxICkSleEw85FXdhirVPGhhM=;
 b=h0pkqb5zdSwJM4MvdviwQpsVJSuw6pxzNQZq0dlx3y6ypOGIYknmIzTzccy5BuppVDym4Tn9cYdHxQp3DQV6QR809WhE43MrX60XY9sxVMJt3DMWGz6XjPT+mRqib5fO83OCj7GN8vL00iTk/f9HiDDifZrTYC8UfOBQEokoD4xwmbbL9roGeEWLPKvpQYJcC58sVEn0c0zcWRkZ0QQlSdys9WyVcSlQOFOv2Iaxacyj0NvkftNdcrBFOYn3CUOVtdeSKpgDeSPWXV0a5sh4xUh5CAKNDtWSDgyR2LvkcPse/pD+toR8IFFuf1e9bKQI0Ymi7BChzspNSNxyfyCF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsxQLgRMH6IW7B2u9jyhxICkSleEw85FXdhirVPGhhM=;
 b=dG8hYri72bhKLeeod/tzbaoLD8YpjWiGU9evyk3f+t5FPH8bKC6P+W8dkAOwVYMCQxUsiwjeNcTiIk+VRpJdqhHeo2UV4hhR2XQTjZURxjdUZP9PVcPQM4B7+zUzcuuNGgmaVr7TH3uP/aVJi7eU+Su+QGcVBqfhI5lu+8amg5U=
Received: from BLAPR05CA0033.namprd05.prod.outlook.com (2603:10b6:208:335::14)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:09:19 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::46) by BLAPR05CA0033.outlook.office365.com
 (2603:10b6:208:335::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 07:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 07:09:18 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 02:09:16 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v3 1/3] drm/gpusvm: free the whole IOVA reservation on unmap
Date: Tue, 30 Jun 2026 15:08:57 +0800
Message-ID: <20260630070859.372954-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630070859.372954-1-honghuan@amd.com>
References: <20260630070859.372954-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f23784-a545-4152-7c00-08ded67680c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: QCt73bQ+TAI3JnqlDIGoHQLsMRbw9dx+68wIDEuQmgFdH2YiTy3GuotCLRxtCSpAjTHJL68uvpNof4yJomWV37yqIDJxlunQTMC3e4z4itkwSv45fnKNXoTjJUnXgRaK/zrasJ7gyHuzX3KwhSfjf4pdlfAMLZ+Zc3JYn2PqEcQEBXXd+yugJzDiyqpF912EtVtRb4YK8HEDvzE+iNlOOQT7u/YcaHJ7e4cobx/U4UkL2v6PwYLyzaCtupLb9a25H68t/QNn+x2AzNvNaulXos9KCkgehZbXQsSlXLM/OuySRJes+8YniJBHtFt8bRVZEeCYTCrSeKkpudg7hBl3e8/keBSjm8nVGHOYCuE1PT0tclxijZ7wcjkaGZiPOBpeVUmb8tBqqBPuAS+4jR6BJbzqWJNLdWVrja8oWSblaqW8ZPIrTsNmbxkJu2u2yfTGJot55phAwB/vJNytDv15a1CZQpET3OJMhxGd2a77pknB5+LMRB5Se0tAcRQjbSoG55FMBhK1KpYn0cuJp9VN8Ny8TxdudEXN8MR7mTD6gbQXur32dqD7YY4N961zLDemzJk9XQuinPG32gBd1VFrl9uUsvueivBGiUH41CDfEcrSmbMlxsNrIlXsHEbY9HsT4Fqr3LFW3+beePqRx5eb62UQpB92rwbicnq9q/BsNKpnOUWTgNs9EdytzpOwHXdivGSeKDZYaNFSwvFV80x4ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0CmxxucGG/HODJBxWDsGjB2+gkOoz6yYvvtQvb97CFqKMTTkxpCConsE/VqXSlA9WY0GrmoSxfPI1mv24SncazLtESrAsqc5w5j0f1jy/XRnv2RJKyfMOuD92w10mW9YRN15LViaDQ8ROOEB5L2GWFOfSqiOqXL6HEvDDlTorjiAkXJz98hgnGuEsS1IwgzZZgca0nEPDDcT0ZjoUiHT99hT2HRhHdsceryuzuCuS9msph8D1UXIC8n43DAz3RCBTtHu4Z0j3ADpa6eTllwIaQgaOGdHLC80jUrGk7u4DhOPSOYRfZxSB47LduTWCIGFtAV6vFefR5nj4/RHd4sZhJ3rS9XLrZPjZJJSiI4fC9GlEY6TaAPRKZx86I4uoV/j3wC7NUebz8059MQYYfLVZFRK7P92AhuXnXyDGsTQX0eJyA9/0o+6GPGDXfW5CYrg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:09:18.7740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f23784-a545-4152-7c00-08ded67680c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865
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

dma_iova_try_alloc() reserves IOVA for the entire range, but in a mixed
range only the system pages are linked (their total size is state_offset)
while device pages never touch the IOVA state. dma_iova_destroy() with
state_offset only frees the linked part, permanently leaking the IOVA
reserved for the device pages and eventually exhausting the IOVA space.

Unlink the linked system-page portion and free the whole reserved IOVA
instead. On the get_pages() error path state_offset is 0 (no page linked,
dma_addr[0] unpopulated), so skip the unlink and just free the reservation;
this also avoids reading the uninitialized dma_addr[0].dir there.

Allocate the dma_addr array with the zeroing kvzalloc_objs() so every entry
has a well-defined value.

This issue was found by Sashiko AI review.

Fixes: 37ad039fb367 ("drm/gpusvm: Use dma-map IOVA alloc, link, and sync API in GPU SVM")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 958cb605aed..3145d55cd86 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1146,10 +1146,19 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 		};
 		bool use_iova = dma_use_iova(&svm_pages->state);
 
-		if (use_iova)
-			dma_iova_destroy(dev, &svm_pages->state,
-					 svm_pages->state_offset,
-					 svm_pages->dma_addr[0].dir, 0);
+		/*
+		 * IOVA is reserved for the whole range but only the linked
+		 * system pages (state_offset bytes) need unlinking; free the
+		 * entire reservation to avoid leaking the device-page part.
+		 * On the error path state_offset is 0, so just free it.
+		 */
+		if (use_iova) {
+			if (svm_pages->state_offset)
+				dma_iova_unlink(dev, &svm_pages->state, 0,
+						svm_pages->state_offset,
+						svm_pages->dma_addr[0].dir, 0);
+			dma_iova_free(dev, &svm_pages->state);
+		}
 
 		for (i = 0, j = 0; i < npages; j++) {
 			struct drm_pagemap_addr *addr = &svm_pages->dma_addr[j];
@@ -1486,7 +1495,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		/* Unlock and restart mapping to allocate memory. */
 		drm_gpusvm_notifier_unlock(gpusvm);
 		svm_pages->dma_addr =
-			kvmalloc_objs(*svm_pages->dma_addr, npages);
+			kvzalloc_objs(*svm_pages->dma_addr, npages);
 		if (!svm_pages->dma_addr) {
 			err = -ENOMEM;
 			goto err_free;
-- 
2.34.1

