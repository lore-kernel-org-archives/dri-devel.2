Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09C7C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 06:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C69D210E583;
	Sun, 28 Jun 2026 06:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kGFx80ke";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D5710E581;
 Sun, 28 Jun 2026 06:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0ZFxB3a6DtHSxjbMdGVpPTXRZKl/8VNuKrSaRnAZjUir+nGOrY+q05fgN0gUtv3zAKYGZNI2CYvGKAU1fFDzVjcWozYgiMajNiM46MQATc0uTgS62e224sW8J7VnE9gWGjCYtQtbzJwKcHuZSOOPzhn8E+uAl93CBj6UyHkkXAxeqfjlKXXWFfOw1eKwPwnLXFhLHbQNIPf/4qdCl1XVDjAp0RxEW7z1EZBw4rz1iuCh3V3MwYxo3ghaCRnW410+MTZSoWDkHJtEZKruKekMEHGl8Gny3GDFv2CMwp+K/JmVQgIfs0G5idoYoz7+n0FmnsmgQcLxD9wry+1k0kw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKoR83e3Os4CdvDDyD5HRZ1AekkFeQNwVTDVaZXmUKM=;
 b=g/WucNI4eEuwmv3YUzohtwJz+b8hrqlwRKJRacn02XE+vbyOBUwl+34Eh3AFHB1ChFTZeTqcKwqDIrm6+4gzzReooIHG+25bzwmiNr1qYP+y4ZLWi5hZ8m8QZ6udt+ZhzsmlNsFuisRKKXyHDk+OOEWENr+/F6UUaSqr78ZxiS0ARZlf/AooAlyCFmdSI40g3Srt58Q17F+sHnFrfG7OCfKuVJlEVCwES1uvN18wCsRx/jiYaLLzfE5QuA6MPdaVJr/o/pwJ52+v3eTsUc9oMOAPxAgStDp7/+fZczWaY6Nf38QFPOiw3wdm8xwlxcBP5gmpc7IirDuhDpZ/IwkjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKoR83e3Os4CdvDDyD5HRZ1AekkFeQNwVTDVaZXmUKM=;
 b=kGFx80kedayagph+/ZKAAGhGwUgIpOq/l8JEhG12gCplGfIgOIrPucOJvw0K02kJZkr2HBtyBl1La/keYrfw/vvX3YuToz21KTlv651GVQU4GvjBnBn4ZPV4aVaXYWiGMgxTzTr9b53OpRyFlL3LYQvuz6V0Ytg4b4FAJqqRbZs=
Received: from DS1PR04CA0021.namprd04.prod.outlook.com (2603:10b6:8:243::16)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sun, 28 Jun
 2026 06:18:28 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:243:cafe::53) by DS1PR04CA0021.outlook.office365.com
 (2603:10b6:8:243::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 06:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 06:18:28 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 01:18:26 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v2 2/3] drm/gpusvm: do not route system pages to
 device_unmap() on IOVA unmap
Date: Sun, 28 Jun 2026 14:17:56 +0800
Message-ID: <20260628061757.4093701-3-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260628061757.4093701-1-honglei1.huang@amd.com>
References: <20260628061757.4093701-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e904d3d-6a5f-4f01-1dd5-08ded4dd11f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZBAiVG7pAJwNd+RexOx9UOgmDBf1kJEQHeC+556llB0R/MMghb+kh7QMH/ghD1t3dmYobuKpaxw6P8mfKqUaeZ2O3IgorWOHi1gphXNNU5R4ssXUa7ctjoMP+qLBCGvKUvnYg/WYGkOJtjz0R/rjt4wcDbrKO/A1gnw2fdZ41G2vpndC5s4yqVFPn7ghy2sFNRq7Ld7YKjin/s5oVPcs7f6G4yME42GTgwFaqkv7AWsswIFoqHEpzTxKYkqpmC//4EyuiMTay9tZhAR2HORUyhksn3dM2dWAEKPm7U5TFgvtr2ypG/4hfrgE2EnhtqGWme0blBwdzeRQ7qkf0GE3f8aYN/X+i28OIYlJWeP0WbI97wr7ikFbKQrufcV/bJ+ue5gbaO55QXZ1OHEpuo6OfAqUreRGMYQ9nHoo7U2XuqsmI+4Ez7Pgj35NKJ35549Tq1bWr1u+EHHDJEc1+UuA+onixcXu3/Y3NjiZBJ3jHrOQMjit5G3Ap3NNydjdB/YOdP/I7/vxOjCHrWlwUSAolrDgtMsAyY9Lc1r1qZX85FS8Luy8C0gIQx/5GUxC3gGvvf+AFeXEJOVndrBRu4Cs9CPwmNz6rbtJIxgKcVbGVC8pePOPFO9OOSRaJMC3mmsfbJSN6nfk0USsM/hsI0RFD2CqWmWkTaBrad/tNcADfnNaWd18E4SlWwj6R3IklILSozN8rIQ0rVc9+QSymG1nPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lA3miI4ZbNEqStkCXwwqZGkrol2VldOYUjLG5y9crbOIN04g8JdGgQC3g2kjUIGoI2kc3YVNilXSzH5ozXgnTvx5h84MQfANdCAoC8Dmzm/v1CTyFg+XTodgccd+f5DyRvAmCUmDeONSH6EOovCA+EHnKAOBDvtkS5Zrds9M244JJ1DSQWqSdQTtwXbVutXx1LJ2CZvVWKBk0C/vBm3tW0IdSt6EQdMFlZa7nBi07ZYsq1SjaAmR9ET7ZO8oYsCIF0XpyAzYoQXsKvt+O/AlulL85JvXBgVDXhy5Cy1250Ufhpy3L5tgF6LQOV9YNcC4wP1Vgj75n56z/6sD1fGOBlYmiivF9SDtPgmn+BD1JqcHIgXHu5QN6eBR3ilJENeg7eInHxxhRu3K2MTkUR3NdLKdOM7VlknO2rJP3dHuL14ThFi7EdHjyNYTHqcEOmF5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 06:18:28.6735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e904d3d-6a5f-4f01-1dd5-08ded4dd11f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908
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

From: Honglei Huang <honghuan@amd.com>

In a mixed range: ctx->allow_mixed dpagemap is not NULL while some entries
are system pages. The unmap loop used:

        dma_unmap_page(...);
    else if (dpagemap && dpagemap->ops->device_unmap)
        dpagemap->ops->device_unmap(...);

When use_iova is true the first condition is false for system pages, so they
fall through to device_unmap() and a system DMA address is handed to the
device specific unmap callback, risking invalid accesses or state corruption.

Key the branch off addr->proto instead: system pages only need an explicit
dma_unmap_page() in the non IOVA case, IOVA system pages are already torn
down by the single dma_iova_destroy(), and only genuine device pages
reach device_unmap().

Reported-by: Sashiko AI review
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

