Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368DFC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F50510F756;
	Sat, 27 Jun 2026 03:33:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pQqqiCQm";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9002B10F751;
 Sat, 27 Jun 2026 03:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eg2FaEuiRjqN6CA5kjMZbm8B7TslZzeMxnQeT2Ij+9oXqo+wfyO056ydXthlopWbmCx7jnUgNO2mNQ0HffdrtZEZn3yJidfVqiyOmyPesd6ikZLNy4JMGXnFUP/DPAOJ6szTUrYIQ9vSS36bxOJfDJTtQwkbb89r1AzVgw+4BRJcFZlnurp9C3J6kwQ5XoGt7NiSJpmLNbcmTsfxsDzPCf5av75UHk6ssV4R3/Z6ZNHOYdPHG/Vbh8UwujdaC3bbIo+33TTJc3nX81COVkjjvy8f0VwMuVZ2ZwJ4ZUpf0Buj+DM7Qx2jxWtDUpr602yow5XtI8q1vxTqKD9bxTKiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf0/lZSyAtynGpu6AQsXB2dvh0VRs7XoXdo2icAakDc=;
 b=S2sC8IrR6ENS9g2FzEwGso7DowzByxSIWbimmDCwaed2Qk31NPbqyXox1zCF6g4Q8pq1Z6apCLAxQwzOoiVH1ot41SNfSI/RE3LPVD1eeXmGFEULvLeBXo6V8QahM6zyI8Do/1whsCpUmt/zNLMHsN+CDv/VxYzRhXiU214/lo5OyUXKjvdFAU6NinO0zDccbLe/9qGl4BHJEs1eknJGWXlyDtb5azzNH6Lh/PdKxE15tEOP4+afMip9xDz4vOiRUQ1D7XuZKakTASO9IxL+AlRPDWpArMt51ekk7uKpABxctCzUp0BVlYzHn6U0K2PgUQFv8ecEJURGkIpZDnahvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf0/lZSyAtynGpu6AQsXB2dvh0VRs7XoXdo2icAakDc=;
 b=pQqqiCQmlhSxWBu1nk+UzrabMhTyiuUf7DGNxDzEXn+Tikw4MxV4B0uX/5lHN17xHr3WdLe2D779WCIWE0XfjV48LGpfX9JAG9W9cC7UeHjCVLICUFN/v41Wfoh6z/Fxzv7/ylxyWh2600aMs+r4UMcJuPSHtI1hDgGrb7BCOB8=
Received: from IA4P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::6)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Sat, 27 Jun
 2026 03:33:47 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::95) by IA4P221CA0008.outlook.office365.com
 (2603:10b6:208:559::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 03:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 03:33:46 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 22:33:42 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH 1/2] drm/gpusvm: avoid reading uninitialized dma_addr[0].dir
 on IOVA unmap
Date: Sat, 27 Jun 2026 11:33:24 +0800
Message-ID: <20260627033325.3795298-2-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 271b7354-1064-4803-1864-08ded3fce56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: WXnFlAwR+rQF9ogcqXYhqqu90JkNxnFFqEWXx3rjHZ6kvyHxAWFWAZtgRTEQ4dSlxU/FwN7473nwu9jhGAkP3gqTmaB9kYBEJgufYnx2z/R+VS812myoBTyMv+5QxyxJEXkVUIxEiec7VpWoKqTss3ENklyBxTefzsCKLcZyOK3FpTOLeXIfHhgdDJ8rlIyxDSvU0XshCtfzfKtZf3BhZNZZfKTxRYhlv3wab6sWlAO7s4k/i0h0dZbt6T9mYqD7UW4YDnZ5Xuqx6KFQhpIMyihrI7Se1KxPIp/sa/HHQHf0051C3ePOm7YBvvqtc9SiwluIeg8REMkQmJG6lJLktlwgPQQ/UHcFUhTRme/+J/TEtwJoRTaZHPMk7eYeOt1niWZ9NEhj+IbJCu5ea0cwhyBABTARngTvqR8rnehnqaiorfZn+F+Q+OzY5XUIpjXZpmiTEI6a8P4QuOdw8cwKtg61qVBZBJpbRPEQY5+v2BF42MAuWueqQYAd6tnxMI7cvNd2fjMqD3ptYCphA3E4NsPluetzMXQAlW8c5wZutg7Qobge85Pai9f50g2bjgwguDlry7MYsDMsSAz1nnSTSbGV/PulrFDoV58H/WsZUV+tkv7M9Vc6FdqJYKeqoFx6wtzh+8ck7V5zv7FJtlfWMlx7rO6kxmSN9zycCjhFVXyKHdikp+gk1fBr1vrqwvc+Lj5NsLjclLeS4zuZfDHu5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UJagdKv0iwWvI4tQFNZIf4KoJp4moUJa9OdZbUdEjEPQMrfkRR+Fdp/U71X/D6trCFHKLiuMgZLk0g1TLMUQKL/2yhxjky8//E8WUdnHnP9eGytjC/dtEpVnOONcBuP/wQ6t/G2gbnXNMR3EZnpxdtHVNHJwub/EIBGT3PxtoZh9tmrji1eUPt8JbI3ndAUDazTbORt8xxLCImYKg8RdGyRxWo0SYP0JoRCU747uHlaC/xvarNc57USjIMPCotlWS2IwmVTyU+ICol4v1ONGJ14ggR8kIe2GBcbYQuKqNMRLWnjf/OhOLLAHoC9TnTqeZIkksJd2Z6Ibzyt931v6vkBCDCJZCrlWGZ1RJP92Ch95M+vkzdag1cRqeeBgPCWYcF+nv2oedwUi8HvYmrNEsyZxb+sluKZsD4f3nG3CFlDpyjMQoq+fG7T5dSqug1OD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 03:33:46.6922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 271b7354-1064-4803-1864-08ded3fce56a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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

__drm_gpusvm_unmap_pages() unconditionally reads
svm_pages->dma_addr[0].dir to pass the DMA direction to dma_iova_destroy()
whenever dma_use_iova() is true. On the error path of drm_gpusvm_get_pages()
the first dma_iova_link() may fail at i == 0, jumping to err_unmap with
num_dma_mapped == 0. As dma_addr came from a non zeroing allocator, dma_addr[0]
is then uninitialised, so the direction argument reads garbage. This trips
KMSAN and feeds a bogus dma_data_direction to the DMA layer.

Allocate the dma_addr array with the kvzalloc_objs() so every entry
has a correct value, and guard the direction argument
with npages so dma_iova_destroy() never dereferences dma_addr[0] when no
pages were mapped.

Reported-by: Sashiko AI review
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index b2a848a7b2d..a9adf128eec 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1224,10 +1224,17 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 		};
 		bool use_iova = dma_use_iova(&svm_pages->state);
 
+		/*
+		 * On the get_pages() error path npages can be 0 with
+		 * dma_addr[0] still unpopulated, while the IOVA reservation
+		 * already needs tearing down. Pass DMA_BIDIRECTIONAL in that
+		 * case instead of reading dma_addr[0].dir.
+		 */
 		if (use_iova)
 			dma_iova_destroy(dev, &svm_pages->state,
 					 svm_pages->state_offset,
-					 svm_pages->dma_addr[0].dir, 0);
+					 npages ? svm_pages->dma_addr[0].dir :
+						  DMA_BIDIRECTIONAL, 0);
 
 		for (i = 0, j = 0; i < npages; j++) {
 			struct drm_pagemap_addr *addr = &svm_pages->dma_addr[j];
@@ -1548,7 +1555,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
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

