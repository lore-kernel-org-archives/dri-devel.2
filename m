Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0D2C61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3DA10EEB1;
	Thu, 27 Aug 2026 07:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CRq0VHG9";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9F210EEA8;
 Thu, 27 Aug 2026 07:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKgHndLxVVcH9TmYKDESeITHwFG17ICVcz+WK0B0uwjZf2byM31L+sYXNMGbn/6iKS94NqEPysHgZo3fWPhd+KT4+yj4iPza/Rb5Rg8cDazOc1jzPt23bXfu5UMuHwEe54D4kh0EmZEM4Xnqz/5qMJRQUYzGCPOrYCJ8Cq0vIkOFT6QwDTiXO0Lrzv+cPH7XTHRm43t7wZcumBgyGEW8uv7jnTnLqzY1qtK7Xx6yqhAICMXG0nhWrmTdR+b/lijJRYLQLdV811TiPMbBpC8O6sR3yZPUyqrfnDscjcr9xb2MwUoO1s3437Z8Pkcv41F9f5jyWHrHixlQ4NfdIS0gVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlaBJsx/j1F9YLkidmcrMRpXq0USHH8z6uR2F0rIePs=;
 b=afxnRkvCrenhMDNZSMr4/FqFBYLXZlwngUnCS/LDVL0pLYBAvtKk6K+oMsn3Kja8yE6UKZYJWxnbR2xzuTliFBsB/f0Pi/yDgqI23B4reNAOlswIUmnMmRc/8XHyDVdLAF7YUu3Rxpa3MU++GH6hMKIrn4R202qmWbzXX6XW1nw1qkaHRZ8nndB/ClLv8hhtJWYLrowJOv1l3NMDSzll4RQK+v1bgoQHfYzv0CT3T7YQyQr44tZbU5Cb/D4KL+o9LR8RLsid1vxaVX1RhGVhA/N2xDV4lqNQocQNbsWk7ROYE6qthCL0hdqanBOYm6E0PLs3LxKVLt0h6HmpB/Opow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlaBJsx/j1F9YLkidmcrMRpXq0USHH8z6uR2F0rIePs=;
 b=CRq0VHG9ur0iMcaOjiDKXKde2hIdDilOGkFMBaUe/Z2RSJ0W1Jopdn8eumgPkcM1QYt41/5c1JVIivcM/0B9J/CdqG02cmvLuO48KDcQGPU9D8I8qS/qKWF+NUWX1N46oBI8TN2lyE60M6TVv68tYcBKqnSIwzZ82Zv6+MXOO1U=
Received: from BLAPR03CA0069.namprd03.prod.outlook.com (2603:10b6:208:329::14)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 07:15:14 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::9c) by BLAPR03CA0069.outlook.office365.com
 (2603:10b6:208:329::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Thu, 27
 Aug 2026 07:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 07:15:14 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 02:15:08 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC PATCH v1 2/5] drm/gpusvm: move dma_addr allocation before the
 notifier lock
Date: Thu, 27 Aug 2026 15:14:46 +0800
Message-ID: <20260827071449.520398-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827071449.520398-1-honghuan@amd.com>
References: <20260827071449.520398-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 878ca71c-a203-4a13-9202-08df040af0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YqQO9vlC4dL1CnfpWDXpA1y/jeMDzLMmC3AzZR3boC5Xra4rLTiqG5kBfJCDs8Tqm7P1pBC6wl2i1TTv9wliUYQXfKYF2GsbLeOTzCuUELBiJRJr0OQX5+uHsR97hFE2wlCzAAGOF0F9B08Kt+BzfADR59uP2GW9h5xAYYD9Y1xJmvqUSObx2csAGri6hXb1138PHe9877ZLW6Guihjom7XkIv9B2OtBZNr7RhPQscQ+wWoGAcjaRVGSI4OriGurf6Ss/KAUyGAhrIlpV+hr9qZQVJN+0fusN8Fg38WLTfMMrE+xytVaCvMff5LutOib8F8Nj8+CPdiVLxhGjL1/6x9IOE7xepAPWIhqG5UJlrIsmk3F+A/N902dkSj1Lo6lCS3N8T3jbGrNDrzqM5kqcOLL6nw2J+sNXQJ5ewNFn0QoXTRygYvX5elf0Glefrk+O/BqTddmlmVLJNL1kp51TATmw4FgI3DqIuM0c8/+QeIycOc/bPdKf5Rlh+jLE0deiXFdIY5b83tPAuQXLZFjlWOqSEIvm8X8V9stOrBL9XbXnP3wdH2a/3O1OBCEd3MQM4QLV5dB7GfwNe2QjVHVwzotXD3XQ7cV2zrEYZhuHUYl81KHHHxmbuCYxk/+PRyn3zWjuxqCk78DpqD228jquaMjwv8/uvIEvEWVu7LFq/6wF6XYQLzCCIik2VbwHU5n83wBWifshpMblJ3OLd21HA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MAvCB8FGpns18theGaAldZXBjTDQHErHpbFukYkgKTf2v3ZKPI2MWZV7cUb7QJFv8CHK+N9mFTZQMJ0ka1fPh9AsfO4NkK+nWB5u4P4LWlAqxySLZwjf6YJF6erlJT2s5jKE4BXJCQm3xP3Dl4K7+tN3dEj81zLNTES3OjTpN3X8eKV3wcXVlk7yHG1PEmTwClCyjrD88jUQtbHEP+EiqhfoXV/ni74uDnrjty7/XHNPBVY19q+0XdAe/JCb30IsGTiDrTrt6oAbNBQCimw4va4M+7hZdxcxrqjBYlyTtoHAJkCWrXDPeqWebq62A2LA+He5Xfm6EBUHhhxULAJnFWioDm3gOMjCFlF9NbGxNixeA2hPf6ut03jn7BP8gFcEl/HrE+2SioEDl+IPe1wCbY4xOBzahLtkSGpZlfnp3zMkpBfY7nqkptsRx/YKemZi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:15:14.4346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 878ca71c-a203-4a13-9202-08df040af0b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589
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

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 507ef6f0a60e..3496cb568836 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1551,10 +1551,18 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	if (err)
 		goto err_free;
 
+	if (!svm_pages->dma_addr) {
+		svm_pages->dma_addr =
+			kvmalloc_objs(*svm_pages->dma_addr, npages);
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
@@ -1575,18 +1583,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		goto retry;
 	}
 
-	if (!svm_pages->dma_addr) {
-		/* Unlock and restart mapping to allocate memory. */
-		drm_gpusvm_notifier_unlock(gpusvm);
-		svm_pages->dma_addr =
-			kvmalloc_objs(*svm_pages->dma_addr, npages);
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

