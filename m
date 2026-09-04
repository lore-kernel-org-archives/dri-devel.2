Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9419C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79CD10E1EA;
	Fri,  4 Sep 2026 16:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZWdo8uYw";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C1BE10E1EA;
 Fri,  4 Sep 2026 16:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPHbL5wbxq2MCiHm0UKlIIyqqB+Pfc6/PX0s8UJBFp6hjTXq/zbOE1gzx5AawFjYFPfmr4CoFKdp9eula9rHJbMGwp6kEjgOCzuR8INH0sFm8HujbRqabG4J5rZHrOj2BQEzLgIwZawyR3bFQBiEchw418tMNZGG/FSbsrpLbUozIkEXELWi2Of810/eM+J9IeIRO5EhWyLkm6SUmJqSSTQity8QJ2As2cARSAGU/pmWZQ2tqdvdlGOvEFrNVGDV3vWOUs6bVzY61/uG3NbB4nGNy+a6JvHXl3ObaZ7F5vQshbhYqEYIxCHojIaTQQ/FV3BxkTUHH9VFk1Qcb5FuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnIH29MvLpv+XU+Zi/Aghx+Flan/2kmFgGPql9LPAgg=;
 b=pKJwrCez9Z10iy185e3B49NcMIdlnJNMjKPfsW0sHxs867+1KgMOAQ/PXRlwg2wsPbpB8E4wRgjdzZgGbwnKvl/wnxhq44h0+/u54ewkrPZhvlMYFlVJL/NiFxedYtNC9nKvjatp+AF7DlbZ+3CsxJ9LkWx9KIusa7fNQ7sPo/lxYdfBNjLKQaxFeDfp4+50faQL0epzneNTQwpdF00fhPiBOBvjSl1kMZ0IcjaQcQLkggNNreDSz7rfjB2H83kF1aFWI5ZWEb+pTxqeOK9C6+xZRp0anotQyLkRFA/WA+XZ1jLRkbasBoM9YO9tgBRXocZb5joGwpSlLBxmXOTv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnIH29MvLpv+XU+Zi/Aghx+Flan/2kmFgGPql9LPAgg=;
 b=ZWdo8uYwo3zA6bfsJ8cnyE0u+6Af+5atrP7xOCJCcDDP49pCVFHhqnNUeNoPR2uSlhaNeTk8HfrO8Va19qOo8aUjl/ZeLP4vF/exz7Y4b6O1CrzJXcOcXgU5OVXekwU2QFJciT5e4+tdEetNi32ctik6xxhWrJC0hk5s6fCBP34=
Received: from CH0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:610:b3::26)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:40:15 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::3f) by CH0PR03CA0051.outlook.office365.com
 (2603:10b6:610:b3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 16:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 16:40:15 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:40:11 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v3 1/6] drm/gpusvm: move dma_addr allocation before the
 notifier lock
Date: Sat, 5 Sep 2026 00:39:51 +0800
Message-ID: <20260904163956.3433293-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904163956.3433293-1-honghuan@amd.com>
References: <20260904163956.3433293-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cb4c74-d1f4-403b-bbe5-08df0aa3329f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|7416014|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1I5ropZpefgg8XNu3cIOeAk7gdPEdiDKkzonfI9ZQni/vzFLzrah5ZjFbessPwDmySrsR7swN2om6A9y7LtYCkImyOhay3Q/u9NAA+oA56sIQK6WrRRcP9+sz1INdz2kLIwP40Xd3y7fnSBCkIszp1J0zSAxG2rSiim7e63m+2rsZezrO/BI2VyCPcrfH3v9B4Y8z4OJ9Cm6TC+45IVvojOcnZrFbq/r92dvGBkdsfuUJ3w+egQqoknRdLm+wL1I1CnB5UO0U7UNyLd3UEVsRaQQTL9xhZabYbVGYQBakJHyf3l9ASjRmi211++7zMVYl8FphWkjMmxvjClBF/YOrWGGAb/OwIWo0uodMNFaXYoixImREMSFMPwgiAPNn6eTHMN3WX/2uMtyU3dmO2qSzMF9ybA8V7GvzWznubHWfn4ozQte48nHqoqYM0RbbDpbYaMOJgnidIqNJBwpS1/CDwupoU73qhQ/ohbyhOwxnzrkKbJcZCdarXDvF8eTvNzuvTMtuV24OQCgojtHovpmIvJPrGlFcBUgSsM1cD9DZVPub89nSpIL3e9xVL594eSdpz4AcQu0X+4NB81XQk7GqqPdtR1hARnOWYZiOpQu2KODD3/iz00lP9RLGIVg0ikF+3wnB+pmQFJR+A0iz9qHWdbB3lPJi9X4R11ziZH5pGveqlq7NZEOuaCOGaK37GkrPrDJQOlfq9/YT2nDbuwwpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bw6d2+ORDjJbAyc95VGxFOJ29Q4w37lpe2c12TSg/D8q9mtpWaldZoma4xPVr5h+aFNyCgtbhHBm25K2+JT6QjDhvvLc0ujPruw+xM96z/+Ymivl6ZBcfvoUKBs2Rshdqv/7NjjqY7bFndh5kttix+dLLhoK3bu8GBGq64Ccipas1AS6+SSos/buPXTwx8Cyvy3Zks3isAcrv/WE83gt8HNVSIBX/EwaZfzxJy72l8MZXVFEy3Ddpt47jYNgJU9A0hkMMrsUI2AgvefDWIWT3KsHkTqsc5ajEElOO9saxJ2JOz7U+lXddxYy572L2ZKpjWc2dfJAczruWD5FhFlk7W69y3+VhFm+2tgCy48O/bea7q95y4Ru+NiwWQQ4FIuWj+mF7Mmgxx8i+B/h5RgrerCm12dk2jvGjTMn4icuK88YNbOYtj/7q/XcWvAY5XE7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:40:15.4736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cb4c74-d1f4-403b-bbe5-08df0aa3329f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
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

The dma_addr allocation was in a lazy allocation flow, it needs unlock
and goto map_pages. The allocation only needs npages, so just do it
before taking the lock. Drop the map_pages label and the relock flow, so
the sequence becomes fault, allocate, then lock, validate, map and
unlock. No functional change intended.

Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index a93eee7ddb9..b507de539e6 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1516,10 +1516,18 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	if (err)
 		goto err_free;
 
+	if (!svm_pages->dma_addr) {
+		svm_pages->dma_addr =
+			kvzalloc_objs(*svm_pages->dma_addr, npages);
+		if (!svm_pages->dma_addr) {
+			err = -ENOMEM;
+			goto err_free;
+		}
+	}
+
 	*state = (struct dma_iova_state){};
 	svm_pages->state_offset = 0;
 
-map_pages:
 	/*
 	 * Perform all dma mappings under the notifier lock to not
 	 * access freed pages. A notifier will either block on
@@ -1540,18 +1548,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		goto retry;
 	}
 
-	if (!svm_pages->dma_addr) {
-		/* Unlock and restart mapping to allocate memory. */
-		drm_gpusvm_notifier_unlock(gpusvm);
-		svm_pages->dma_addr =
-			kvzalloc_objs(*svm_pages->dma_addr, npages);
-		if (!svm_pages->dma_addr) {
-			err = -ENOMEM;
-			goto err_free;
-		}
-		goto map_pages;
-	}
-
 	zdd = NULL;
 	pagemap = NULL;
 	num_dma_mapped = 0;
-- 
2.34.1

