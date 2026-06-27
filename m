Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A835FC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1213710F751;
	Sat, 27 Jun 2026 03:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xCjHIX1D";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816A110F756;
 Sat, 27 Jun 2026 03:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1E9vZWgLffWlULW9NX9BFN9dM8Z0JEjpVpor7qwRf4I8YQrfNlKaL/S9TxPvWh/mYnhLnvx6K3I832hTyaHBIzXHYMqf+J6wVo1/Bp2ZPgKaFz7DkTvJatVGNJzVJDjZyVgrHRHIbpXEZSFZEh1xDf1Mp3Yu/ykzDVbjmnGXYkf9IQuXgMz7bifuYef1b0s9NLVCl4uT/CGSn27rOufZOvBZH/HnqB8WSeZRThhQ6hSJ8oQiW4HTQrJiBSVWghkoLthPPIBzxp1w4+6UJbMZzT3iX552R+KjjmDh1Sk0ozeUBvzT9GyNeU7CF7C/01PWsDsps1ZWBNepc+m/3nmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmT+Q5Ifnp2aHlYXek7HwKUlTITqXByo105/txGSaTE=;
 b=x6UcKLjJpZyTMPqs2seYS7tFTbmi5bdNHz7J+iCDVWee1tuMd1B15HaHsn4Kqdo6uq/4nUBnxoKgCMTl+GfYo/6ghdt4T6/+P8VKtlBtbO6IEA2n58Gxnke9AJ5lKKTCCxXtFKqjwsvK44T8hhS5yFyhdI4yTwzY7HrPyI116eLhUbL0hsmFZkcMzzD7xfV1UVZEcKK4E9CKM96/iEDlHfvsaeZWyqlzis32UBcKjhlbXPYBxrC1D0NVzJhkmiId6y1X9WzpmZeSV1BY9GHyQMc28Ta7ipSzgPGnVUgOsosSEL0k3ntR7Xnd5ygnpqrMO2Wd3gHmihbucnmz7tJY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmT+Q5Ifnp2aHlYXek7HwKUlTITqXByo105/txGSaTE=;
 b=xCjHIX1DrJTqK8gxSwOhZ0CwIYyZk1Qv+NrAsFLVNtJfPLok22uc+OGmFdT8ZjsA2aJVXyiM1s0LrybuiZLkA4txIvbx4oziEy+Ff6+YGxxI7MGP8drE4qx7g/srvPyAMNAdNU6YBxiXuvco2/DqAjrvlHnlqDjew0eu2OP34HI=
Received: from IA4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::17)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 03:33:48 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::96) by IA4P221CA0007.outlook.office365.com
 (2603:10b6:208:559::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 03:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 03:33:48 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 22:33:45 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH 2/2] drm/gpusvm: do not route system pages to device_unmap()
 on IOVA unmap
Date: Sat, 27 Jun 2026 11:33:25 +0800
Message-ID: <20260627033325.3795298-3-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627033325.3795298-1-honglei1.huang@amd.com>
References: <20260627033325.3795298-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 1252fe1f-5185-463d-6c6a-08ded3fce63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: JZWCYtM1BtGf+x3DuZOV8lE8ltYhTgbnqKXNMpF/55Xov+rgGlF+SrDP51jcSeCHsrwgbvwWuqFrSfcsH7D22RRX16OnvKzoVGTrqfUu36BlILb9+a0rdFl9DtauOQNsn/OUZTpXjUSuniewJJaE+EnIZMRds9uHQnkDiAu/ylnHE72tZF+5aXb7A6vlNALqZqmFZQbLTK7iHTwh0MBJeoyTw81gbzcXdpECslkp6t53nHAAmbJM4qIMl5m3Q36IqOYwkohakDpOTFQYZxfn/XZ3HyjE345XMkc6IUKZFhsVmYCAJ5T5emZcLghPm9hVzs5swkfLPLNJKC2Jcx9Aw2J22sV1oW9mBukIaxk/QY/ugDMGns58oVMXE2EHz13p5632IIQjf/gQ2+fZ5lB7A0VMs5pWzQy8zxXI3wMKkPeOUjrj3lRbhOGcvpXLuBmgnDsOfXNmeqPUSuD1Y3mIijO0b+JSWQxIjkdWhXJwzOevqLWfuZEHvqko/KjCykx67UTvQN4IjldMVo4I30smFB/G2l7i7n6wnwJ1YZtBiKxFKUjt/DwDs0vXsfjXE8f+aqGsd1rqqD1dUjAjQKHrKdjAe9E7AsWkrZWYUsQK1zVdrlcm9ABFGph5j94xOG/tp7k0+haKkr9bWg1U/GcYrHVEcbDEzClILArjZrzy6eKMrYsdFDfG0A2DcL7jq3CjTwKnbhvyH1kx+Fz+w3hVdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xNYMyX1fTBT3GMYnM5zDv3X+BuvUvH6E234G0hWMjxIOCjzcmNCULoSar25hjpqD4kmtJCWlMi05HR623ZPGwe6uIuXzyvhvwYk6iu70Sc4RdoQ9FwIt54vmABfFg0WWFS8liZZc7I3KGltqXgPSN94LdsMMCk2bW3Qeh6BgpyCHVq+iaCjWwXduC3KLMdgr+WO2bO+bWNjPAzatuhdLR3r/3D/2dDkxBK2H7xjbGIu17HdOrWppm6gdOZHMVOmAT8QxUSBrBFNtCwdCYEQVLT2uskuwVb6cyF5mhrhGOOZHq8WHS6ZufDbV40BIW6po2YP/4lDYfE0XJBKAdiELNcM8uKwuOer1l+5vORjvvGOz8BoZq1wHueLWu83d2+yNuHOqP+MFi39Xvy6xGGlhn5CvIIcjvClIueokjXs4fzHvml9j9JSyy1N66vfpwLvt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 03:33:48.0712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1252fe1f-5185-463d-6c6a-08ded3fce63d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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
 drivers/gpu/drm/drm_gpusvm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index a9adf128eec..96c14618591 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1239,12 +1239,17 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
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
+				 * IOVA pages are cleaned by the ma_iova_destroy() above.
+				 * only the non IOVA mappings need unmap here.
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

