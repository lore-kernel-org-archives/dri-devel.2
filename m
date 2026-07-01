Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE78C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A4F10EDBA;
	Wed,  1 Jul 2026 06:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lnfy3slo";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F419E10ED9E;
 Wed,  1 Jul 2026 06:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9Av3gEQ91oq3sYJ+RB8sQsVXTHPo17TBO2bm0VjEbUlp5Y0KWyGyItg26Q7/wsxcPt6IUQ8rXvmJWItYRLmHOeJj2y7fmdax3qKhqq50VpbZ7zHNadZkf1VlYWV6yb7X50Yx6pX6EtCuUU9NsjwGZmcOgWRTEr1edSm3eQXfUwkSXPnZbHkkb3W7igH5ANiaYOjd2UwvTw4vQbaiqpENLM9tTbVn1i3w+r7nFNufH6AH5JS/xY6TujgprnCTwnRps3SlFzXGuCy7Zu9OKnWx3Ej3Y/jgO5hgluVJvHSzmuQzIRzm2pq5+NB7PshjfVwa9rDmAqBJf/H29Bed29vHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tSzvtO8ekLkFY06LrbamPKxRwcboUEslA1t5EA8mv8=;
 b=heWggge1f3GsYytbRIwBUzZs5Y5t0U52UZy6sGbh2DIedoS2X1LNfbrrFA81f/9WX2++wPHE8uAP41uFIzMCNiaJC+clldCcyuWQ3InwX4M3njWiQsbRu4Bb5/DS0OBhoSbWTKGq4fygmXcs6SEX4W4e81Cdy36TLb1CrEF8Xb6PEUnMkFIrP9FWyAgNeHJbmtJa72QCn0HNqToBZGxxFNPWypDDAWNqORxTNh68fkMUwDLY94zBGsJkRW1S/AqcRLj8q7AeybogzqG/j6KSeluXQvqlgSjWj9Oa8AguZ4iO5nkE3KHBq+gXQmBntKSccE1P8In7VvuEl/0LpAVj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tSzvtO8ekLkFY06LrbamPKxRwcboUEslA1t5EA8mv8=;
 b=lnfy3sloe+iRYiRMImDGwhSRWX4gaN2bwfLJMqgsnoxSarq6jPNdDmazOVpDd8JpbGdXMEK4ZPJxxeDzzbGYeZ0K3MZ9ug3TWlzisJpXgxWKWtHbh+Em1FRniBs613O3GPWZr+lRIJDRxbw4ak05k+ty4yG7W3zC4p2OY7NdM+A=
Received: from CH2PR19CA0020.namprd19.prod.outlook.com (2603:10b6:610:4d::30)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 06:28:21 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::9f) by CH2PR19CA0020.outlook.office365.com
 (2603:10b6:610:4d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 06:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 06:28:21 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 01:28:19 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v4 3/3] drm/gpusvm: publish dpagemap early to avoid device
 mapping leak on error
Date: Wed, 1 Jul 2026 14:28:00 +0800
Message-ID: <20260701062800.409248-4-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf1164e-6f6a-4719-d0af-08ded739f278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: F79pHHytc/VzUECoiU6jKJfU7BviEr+UinK9Wyya515KkCWYs63AC5tTFje7PqNynaprQKOHgMiUlEO1PUSuZ9IzQDYL9HMJHajWQYGCE7dgDoLJusy5+HM0AZCYopOd9cUvBWoXkt5BE5CQkTlZvvAbvy1mgMVodnpqqAlCrkfMPAhr6q+QMfMiaGqWcovWKbs08me2XUAXSqJpyOhzOjcM9gnAQT+b517eLKR595rFzaqd9HtP68cfP2dSyIaqUiwSJeJqvSxZOBZi1Dws774VQrkTx37PDXRLZf2GT12XdM10WbaxuZ+6YGvFvu4DU9Ry4yRaiI0xXTy02epEUsYC241BudmdrQyoeI9rF5rTebJfvysP1W/+VCUeiO6sjXmxthwBWTC/C/KLO5THB68bPfyu9W3DRwjnPuMug21uLYBYlEOgK6ACoqMrnXbMk6HUYhPStN+LmZHWL4/eXDiY+I4Nj/LgVUz6ZgKK9m7EsYlsdAwz71AQLiY+ELbQ2i3Fz+owYrPsItz/OD0e32+DaKa9NW5rrqJ0Dcql19JXBCyF1mH92g9VUn1QDgizkDWuUd1VMX9z3FOUA2/7/YJVRZvw+KHn89uAbC8HOpcJ48bP/3M4arx2nPbzinl2aR4PCBFMsaB1wHjNHpVSo6Ok58Iompy7Ry6SxZW2OZonvpOUtbbDTPe1mxsHbrqEdQG9qzWBeLggMfAfKXKAnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pTQblCc1odURetm65ZvLfLl4nsSaS81gsy40G6RM0evv/L5NOzfn6T14/x405COd1nzSHrapBxL5ESjMluWIo8UIXCBuEQVDNKz6gDa8HdCLCNNBn7zTDzKyIIzTn9qHAGa/GRULwug021j2VMcY2VJ7GPdT7gpSFPI4SFUnJJOZtvy6ymV7rHazLr7RVKMPF/ovDWmDjAj5fOoOW6oZLHGru4SLI0qSzHk5uQw9F+VN0+DVB16u5fpRSl5254mJvr5MWdkgyQh1fnw2MGYy8yni3xCmaaBWPa800svqintny6IH1+Ihp0iFqUqRwD5Sk3hUNlTr0oOjsSUhycQrIHImYojfWWICVPTR8M2eTsuzREwYGuwn/F8sxFUyfoCgS5ABw3E2iTVvkkldaoi94AfMyN918fgBDXBzN2YiUmjev5mLLKZkK4aSJtu/OPEq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:28:21.3976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf1164e-6f6a-4719-d0af-08ded739f278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
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

drm_gpusvm_get_pages() only stored the local dpagemap into
svm_pages->dpagemap on the success path. If a later page failed (e.g.
-EOPNOTSUPP when ctx->allow_mixed is false) and jumped to err_unmap,
svm_pages->dpagemap was still NULL, so __drm_gpusvm_unmap_pages() skipped
device_unmap() and leaked the device mappings already created.

Assign svm_pages->dpagemap when the first device page is mapped so the
err_unmap path can device_unmap() those mappings.

This issue was found by Sashiko AI review.

Fixes: f70da6f99d4f ("drm/gpusvm: pull out drm_gpusvm_pages substructure")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 44bb19658dd..9a06ff7d260 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1544,6 +1544,16 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 					err = -EAGAIN;
 					goto err_unmap;
 				}
+
+				/*
+				 * Set the dpagemap as soon as the first
+				 * device page is mapped so the err_unmap path
+				 * can device_unmap() the device mappings that
+				 * have already been created.
+				 */
+				drm_pagemap_get(dpagemap);
+				drm_pagemap_put(svm_pages->dpagemap);
+				svm_pages->dpagemap = dpagemap;
 			}
 			svm_pages->dma_addr[j] =
 				dpagemap->ops->device_map(dpagemap,
@@ -1611,12 +1621,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			goto err_unmap;
 	}
 
-	if (pagemap) {
+	if (pagemap)
 		flags.has_devmem_pages = true;
-		drm_pagemap_get(dpagemap);
-		drm_pagemap_put(svm_pages->dpagemap);
-		svm_pages->dpagemap = dpagemap;
-	}
 
 	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
 	WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
-- 
2.34.1

