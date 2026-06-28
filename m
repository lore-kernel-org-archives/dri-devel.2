Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B6CC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 06:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087A810E581;
	Sun, 28 Jun 2026 06:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oQxyHuXH";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D595810E581;
 Sun, 28 Jun 2026 06:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XouYlvnP2SlzB5KTYxWBCd+OBNgItlK9nQIOKJQ8APct6RKIriuqyDr6evI986eeYgpMHUaZ7LNjPaRfNpitYlJiBajcJJx/snGMlrAiO/JraFe3Uhl5blc5KX8SlX1NZr16pnK6XRrhdIYasCfwJL7Pqzha+fFJLv8DhghGNSKjYOMbRCfIFSeTjCiMhY/hArOBq65BhCyXhxvtwiw13JPum1d2H+vfBjHxGjzimdL06SIZudJogOuWhFAzDroFIxPv/7A3NcuZxL0VBBd5mo/sYTbeDZJLCSEZJ158FUdgjonk35yEY32nY3ZQ2MUWWN0WReDm61AXQZtUGGos8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P04+h1N1wzbQ3ZNbEGnOLxeV8YXU+e+b+Fjur+xV1EA=;
 b=ovuR4+B1RmOW5lw8nnQVitRZ0ToTx/n3Yo/B7IYVyQKOrw88GtFkTNewwtyK1na1/xzFmEa9uNwVmEtew2EBJHctLfNsextPn6IArYpQEtCaRBtA0EticfmlxeDnHvszhMi7kGLfH1m8dbryEbQVVqxuCWT8J7HaixuX9nAPbE9zGf6itrDVLPLKYugDiGab1d4Qb9SO8nOfR/ASTcekF/g84rKmmhl1HJcxLDxYOvJB/D+g/mUwToaqAzN4YVpJ6w/dL0Idi0U7kgoyaFrkHxrvRmq+30z7fX4vuPW7sqGlqayi19Hbh49GYjq9R33IGbVt6kzB695dkmAUPYxu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P04+h1N1wzbQ3ZNbEGnOLxeV8YXU+e+b+Fjur+xV1EA=;
 b=oQxyHuXH9mR5d3ETQDSDPLt6thP02BhL7d8D6pjQNH66nraLmj+I8YVe6ga3A5F5vSvm879hLH8MvsdDD4Lo6bVMNSoomtRrNicG/dhpxw4CBRp2n+/qN5s4e/JZ9rWsDJCHVSmjLwCrqTvnx6vTfPdpPcdmx47Y+kKLPTQNfMw=
Received: from DS1PR04CA0027.namprd04.prod.outlook.com (2603:10b6:8:243::7) by
 PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.14; Sun, 28 Jun 2026 06:18:31 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:243:cafe::71) by DS1PR04CA0027.outlook.office365.com
 (2603:10b6:8:243::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 06:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 06:18:31 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 01:18:28 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v2 3/3] drm/gpusvm: publish dpagemap early to avoid device
 mapping leak on error
Date: Sun, 28 Jun 2026 14:17:57 +0800
Message-ID: <20260628061757.4093701-4-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ad19b4-6bc4-406b-cf37-08ded4dd1363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9Cl/dKca0KLbVTN8go6l3ug1OJ/iQj4b4jO7igKdyj0/yTKzn7FeCs8H/4CGinZMUB1VzNst+BWaMHy0qM30FPjJRxtRSeZRXYL/vSy3f7KC2SiFSHPxnDl6t9bHVfIbg9bblftZkrfnQdCMDC44c0+3ZvUll1eyxFBhqgeRjmo9tpKmQdRrMmezTRVcDJb+yagjO561Wh7z2SC7HwYfOVFi5q7Aijs8JObmJfu18UWOCELrCLjDmDdXMoJRQh91kgKlKgj+JkLT6yBFJntIJED8J4nW24yEO32nyhu34CVUvoKZ6PZf+SrXap5Qkt8f9143scYx/2u0KuqRq0XtiVig0REnCHpKMXpgeJeg/CVmxn42uWTgDV265i0gMuR2nAlQoYj7nXcrsY49RJbg2grRR+tgxLpDCfwGRLkYB2Y4GREKiKjG/QO0KoaZNYHgvSd2r5cLaE7craw5CoilFCLSaSWIDLSsRfnSXAYXdjcNyvwWjf7pZb+bVXO//d410DnRXvRmhPLvHhaYzP3SNfW5YVYuhBsz0K67rwndZgwLaEextWvlHV/29l3lLjkRVRtlUpNrpC9YXuYzv9v5OIQXi7JMhnLo6fST+hLfCfugNhjsI1kTt2rrLe27Cbnb7v5mbQ8KxRlKsCdwxIwlj6o2lm6ejMTCI5hoXr5B4C+bgyJ0i3FiwLoslr7Mqfuy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mJ9wFTEFJYrZr9DCdE07MTx9HLic1DFasEWfPMwXpuiuQLqpPzFvNnEPSV2LPcyo2ZtFEFatDTq1ExJwEcTVevKbSaJ7Zi8vrmXtnwKMNsG/Vd7LdwZu7xci3gLl77nsrl3k3qsgqRwbvmuzaUuQ2mPpYiX81cKnPNm8ZfqpWVTj4+NxDAzRbMeubnK/jiS12FZhLpZa/1K+CUR/Ca91mRMuzZy9kiwlphFC8GGKzjbZm3OhGGLf42dpG8KR1gtNgNn+4pP2ng9TKHn8GOwIZaeVf4xBKmcqME6SDga5Ek/uM/zyrORZ/6skvx8uE4T9K8F+3ioTzY3Lz6QkdUJWteKZnVGCWQtE8/A3GUgMJ/12Le62dTvsp5NtlSq98wSGcr/QIe8IzDsweW8LtXIZf38vNKLwSSWD6veKUFa2C8vBwS9SNDfukwuwMxGYh3cq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 06:18:31.0874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ad19b4-6bc4-406b-cf37-08ded4dd1363
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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

drm_gpusvm_get_pages() only stored the local dpagemap into
svm_pages->dpagemap on the success path. If a later page failed (e.g.
-EOPNOTSUPP when ctx->allow_mixed is false) and jumped to err_unmap,
svm_pages->dpagemap was still NULL, so __drm_gpusvm_unmap_pages() skipped
device_unmap() and leaked the device mappings already created.

Assign svm_pages->dpagemap when the first device page is mapped so the
err_unmap path can device_unmap() those mappings.

Reported-by: Sashiko AI review
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

