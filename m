Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CC6C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5DE10E31C;
	Wed,  1 Jul 2026 06:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="udA3ZurH";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDA210E2FF;
 Wed,  1 Jul 2026 06:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx/nf3mevFfhmRztV5oFB5Wy5/4TOFKTuc39TRmIEymolqyk8D2twzELa6wJyxbWCunylRxs6TgjcDeTkxa1BfRUeeUdTbZzEob4mWf9Q+DaE6EA+CBMfhUfDJM8TgqiFDMr31+Q2czHHVu+VY6r0Ezkxv4sMLn0fztWkY+oYg6WeuOhGhdMVbkDHvs2mXpxU+EIZwH++bNdlUCP4NzqI/ULPGm/HJOA3F1CU1q/S2tPFu26040XTxgT7nayHizGchF7rI8+TIbbKkwYhPEPCPjdnV3bNDAaLVFZWO6/AfC4VrJPaD49QT/MLpKSY9PiFi1s6J+kul08OpKJWJHSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngbR43pKY8YTZJlF1LsFcIm3cpyWyFPxSk095iCe8zk=;
 b=QYrzMk2ZlcMLdVeyKpyZiLwjd8Fz0xw+G1//Wsr3I04yeeBGfkgO931oAQ5mOohRmai+MsRC1PYwbDz1x1a4fuyDoNhIXYKGoRLyxnrWPrXsotFx9Ypy/lfhM81O2tJnoyZP4kUcL6daBLp1OYz3PvbuDZXg+SP4IC51/DIDNnPJx9t9MWUmHsjCAghlNOWSNiS6WGPg/dNtEIf1H8ILFGWoh7CSrCcqVoBdYu/WfUv+gZfPJA6+47gcQzpsNtw6lm/4FGkGGM9z+yzoYe7Mdkt3KadldpEFxTx+SJ1Htl3Y9ST6Crh0iH/D1TtHOYhMnIwlG600Wbl44AoEZu0DEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngbR43pKY8YTZJlF1LsFcIm3cpyWyFPxSk095iCe8zk=;
 b=udA3ZurH2k4QC8mMH9mEjz6qpDbqpPwRxcwjcECMTYRLAy5E6rVoV+EYkufZdbKhn3yrxeznxjfxX+xuYX8M0rcu1veMGysaNSAyaw2Hyf1+0+jMqmH3aSefoekWYCtPAkRPy+NHbWM3R5ZDmaVhK0X7eTjNgkuzTR/RDkjbJU4=
Received: from CH2PR14CA0031.namprd14.prod.outlook.com (2603:10b6:610:56::11)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 06:28:19 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::5d) by CH2PR14CA0031.outlook.office365.com
 (2603:10b6:610:56::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 06:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 06:28:19 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 01:28:16 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v4 2/3] drm/gpusvm: do not route system pages to
 device_unmap() on IOVA unmap
Date: Wed, 1 Jul 2026 14:27:59 +0800
Message-ID: <20260701062800.409248-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701062800.409248-1-honghuan@amd.com>
References: <20260701062800.409248-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|CH2PR12MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: c08ee8c2-1072-4687-908e-08ded739f126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uhCRaBS6Lx2mJbeU/tsy6e1dGhsK0R8prm8EWfubPbRQj5UDJgvkasgCMC77P7aHhGB+rlnxQUFcckcSUy5w5TNpJ1vEl5CoTwD/ICH90LkSIBrQBXXpWLPlefVYjaK91YF9NGTvrLJOq7y4y5O9LOzGInelG8JWWoipriDQgqUirpmT/1sriUfzbTsclyqVlYvvDsbzQ9sr/KWdHTebv3M76MQWQ+yxX4oUsDbKqh/c0cUeuGScksAGkESI+DXBRMVMw/UOPtRhSH4oNex7MWjrXw9/bp1802sZaGwoDIIMo1AxsGnvxViQn9w+C4/p4RitcLV7j9P4nJn3RkY5cJNQPXgdpH3LJSCXaB44NxUaX7en85uvI6Cm/YiXU33pKoWHj7IL8GzxjMHgGEe0OsHMh5kBy6gMatEn4y5HKrr4DfLHFSDAjQ8Wxzp3OnHVeJ4mM+h3FRCyEmO1yKRgckOUIL9q4w0gMpj9FVLONFfciGrKNh2YIZSOy0QM3FSoH9eZrsT4BpVNX74Ev00xke0lnh7urN5FfbB7RQdMrq2/eX9S8X+cFhMdvexOduz/f41nQxgnu+fNSkBDvI393xUrQlVfg62A3yhcxVt3E9ozOecxpDSeBYrulWeHN2sqy0uTSfZHQoUI7KoD+EGzK0atkH5PVQVuS93WQ1y/dBG9IPqfwvXIBSResEqLHFTMqoKEe4FVhiZqKv3fnQYFow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PIyUmFZiwMSdcdM2+wdjWsIxlVjnTmujTj+ILh818oR+fb+RGUX+tYNr4/52FAxndp9L/6oWsF/25iWxIVZIy6NA6qySxecGyb1wp2KLImWtwES/KBvW8eVyXYfwvDCif5Mhn8sqz3KTcHsHFyUTI+pAplOIRI0u9jIglLpSWInhKOrG6wi2DsJDzTyefdH1QDu5mkPB2O0b5uRUDlk+XKyTR2XBHaIWhRVThVuqV9CL2JhsDeRaD5s+XJJBEwWOo8KFpG7pHBWekQJnGxBldS81UgKBRiUIjEysR+VdfOw5fbm7assGv/3qYdlZGHR70Fd3bAsfiZn30G9ZnTCWzXHXn0/VyfuE8PEkUy/WAUy/JQH6P8F7lKS3UyUZiCb1pRxIKGSQy7lu3Y8STd+exg0V0itQKXLHvVcLktTyYOF1LHS42wmWwkGeVNGziPlX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:28:19.1592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08ee8c2-1072-4687-908e-08ded739f126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543
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

In a mixed range: ctx->allow_mixed dpagemap is not NULL while some entries
are system pages. The unmap loop used:

        dma_unmap_page(...);
    else if (dpagemap && dpagemap->ops->device_unmap)
        dpagemap->ops->device_unmap(...);

When use_iova is true the first condition is false for system pages,
so they fall through to device_unmap() and a system DMA address is
handed to the device specific unmap callback, risking invalid accesses
or state corruption.

Key the branch off addr->proto instead: system pages only need an explicit
dma_unmap_page() in the non IOVA case, IOVA system pages are already torn
down by the single dma_iova_destroy(), and only genuine device pages
reach device_unmap().

This issue was found by Sashiko AI review.

Fixes: 37ad039fb367 ("drm/gpusvm: Use dma-map IOVA alloc, link, and sync API in GPU SVM")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 3145d55cd86..44bb19658dd 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1163,12 +1163,18 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 		for (i = 0, j = 0; i < npages; j++) {
 			struct drm_pagemap_addr *addr = &svm_pages->dma_addr[j];
 
-			if (!use_iova && addr->proto == DRM_INTERCONNECT_SYSTEM)
-				dma_unmap_page(dev,
-					       addr->addr,
-					       PAGE_SIZE << addr->order,
-					       addr->dir);
-			else if (dpagemap && dpagemap->ops->device_unmap)
+			if (addr->proto == DRM_INTERCONNECT_SYSTEM) {
+				/*
+				 * Linked IOVA pages were already torn down by
+				 * the dma_iova_unlink()/dma_iova_free() above;
+				 * only the non-IOVA mappings need unmap here.
+				 */
+				if (!use_iova)
+					dma_unmap_page(dev,
+						       addr->addr,
+						       PAGE_SIZE << addr->order,
+						       addr->dir);
+			} else if (dpagemap && dpagemap->ops->device_unmap)
 				dpagemap->ops->device_unmap(dpagemap,
 							    dev, addr);
 			i += 1 << addr->order;
-- 
2.34.1

