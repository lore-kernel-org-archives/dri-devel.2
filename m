Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1286C43638
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE8B10EB16;
	Tue, 30 Jun 2026 07:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vsxbhPrt";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011009.outbound.protection.outlook.com
 [40.93.194.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FCB10EAE9;
 Tue, 30 Jun 2026 07:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2eHsLeHA2wOowKQEPcmM/M4yCbEl+nwU356SLPhJ9pgkkATu1eJJd/f0ILL+AUAMJ2uexSiFwWyMWCpV+pG7eg2XXFsHuqF1vT3pTkL1xCSgkKFV6QC0C3zjMneCzvFL0fVPZz6qsjC+txYLGz788bBnn9yKWKPEXVJOd2BmY+lly9ff/EeFGrAK3W7X7eouTnE0xUkpv/4hsp3eSq12E2w5S/wXeqY1Xhi3F9uQhK35bDtlBIPZgE2mNXCBC7ip14jO+KtwVtUSrK5witpwiqyNPfFVJA8SWveTxCWceeewsGzrNfXB1qDPST3Lmn04shVbQ671kpAGZTos/q8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIrnZPdBJiTQ50lyAdJqVLvL4+hXOFdTg0LJ9kNdn7c=;
 b=jFtdnXGuwudaRU1eGMKWYXQ0seApYQr7uejk51xNubZGVqAk5jeJLlvG3CInVhauL4cUVBTHiowHZ4ao375sh5g+u5cpjwQ+NCJsy1kk/YcFZozjazIBVSlBCd0aduxQ8HGwUJut/fb8m+78XCw8RmM0s0KT7EvMP7lrkNLZPlAKE4i8LP1wI8WFurNQsBz2ITpQ52g7TbjzGayej/QGC96QsE7jOMOjDdu4UGUZumtmlg04ab7du0XhARRvwNX7Ps9FFD84Ns4yr7UTH9XSEdSzj+7arBzP6WkbQZ1+ndSHl1BUmP64ZyJoVRgV4woWrph9RID21dLRKuYW3V+Flg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIrnZPdBJiTQ50lyAdJqVLvL4+hXOFdTg0LJ9kNdn7c=;
 b=vsxbhPrtgljt/z41lLvPYW5EFenIuINm0Pc0Y2JOnodsmVfwOqMAZA8mB1dD/h77M10FLw45BFMAl8L/2lXxGcP3D0mTuAczBQ6Q/CxBHUR8y8+N9R/ba2+vQ6GHYMfqSEp4F9shY+Mwq28PO9cGZWu/9EM8iIC8uqwty9vzY6w=
Received: from BLAPR03CA0169.namprd03.prod.outlook.com (2603:10b6:208:32f::21)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:09:21 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::a3) by BLAPR03CA0169.outlook.office365.com
 (2603:10b6:208:32f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 07:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 07:09:21 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 02:09:18 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v3 2/3] drm/gpusvm: do not route system pages to
 device_unmap() on IOVA unmap
Date: Tue, 30 Jun 2026 15:08:58 +0800
Message-ID: <20260630070859.372954-3-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 66aa72b3-8e93-4955-daa0-08ded676822f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /TUjRTAvWq3zOvL3iqNVpZ6Q7A7lM4qQwt/5GDsCkmGB8AeqL2WYEiPZ/Pgw+EozmyOQgHG/bx+9ehYJDE93Jxe33bGXHw3ukdfgB0QDRoHBKzF6pWj+ihYvE0H2zlH1riBQ5kwJg2T+nPZ3VxwtZ7DNtJSntjkCDkcYMKq3LnKpCLSh3HL+TTnC8U9HQNINYi19hSUkrCvjB+4YuW3WCP7moawJ0tqdxSkIKctvd1kyO9ofV67n340zTg1R0r+Abpgk6/uULts1bMbG+/Zvzr9tx5fxBsKC606XCx1HcFKYtKEvdawXyRhpkKVX3t70dGhd8SjuTdsWhqursysNaMSy/dPxCNs8XVNf+46ayE8l7cFqP4CQWhw79pDry2gxIuaEVmiZV6AGLsHD0EgbFtAVERpTChWGb8egD4xG3dU5wQLZ3+mH4rcnf3Rt608tkMoxlbLMmPZmBpyCv8OlTghTd0Gbi6PHqjEeonDqx3PNi8HUlUa7pd4fjM9ccRsJ+Yy2SWvFrl6BuQp6CML5AulnxTmPMyMz7/cEFbuu1hacQ84w4iN3CKaYNk6pSA1HUVL15ZCg7XoMq3mftWrAB0ge2UEsnQ4sS37079qo9xyeHdPHShr+2lY/HmOE1oHP9HrY1gk437nk8XPmAgRojhdvOOlQGmf2EgermKsksAgR1vQQNZsIw54uWGUInqdnKVfe87LAj/BuFm3sv+hODw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lJpYAgdLdna2cfgbCMXfOe/nTlJb+cdhfLcSUZK+Db0P4vwtHEtbouBA1XQscbhcRuv6i6Ew/MJh/bW5iNsoqVCA8TIXydHxPCup1HluU+XbNTvEcuq7NjhyDZdYVtoJavMBWaJ1hRUE8ODNejljqm4TdXRerkc04FfIfSmuaPSDieqZKhxhmKooHk7K+roSVaRw1Ex1/pPABvtueUKqV+hX5kBm/y7jUppBK9abGJmLs8pi0tt/aj9aVn0L4UNYzqzbLVadouxXzEbDqkQ3L6toOgI4pEzjBnzyrMp+J4Sophp7jxrmxU0165KOWel2lvMLwf6TVx8uV3RmWhyJ8x+wuOXOWJm3BxkvNvqJZLGj6wbKxLbCcsVekbOJ3F7GfodyzfCwNEUa0iH4X0kEliYdoAuc+UzHDIzZ7SDRUMGLe684F9H86XYyK4ikE9XM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:09:21.1395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66aa72b3-8e93-4955-daa0-08ded676822f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

