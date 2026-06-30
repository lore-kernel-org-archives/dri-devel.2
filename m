Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F660C43638
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6342D10EB25;
	Tue, 30 Jun 2026 07:09:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fDRUvaVW";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C6310EB22;
 Tue, 30 Jun 2026 07:09:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5uZbeXGtTfqY9WRVWvKds1SG6ZDebzRBNw0Nk7Mq+djRH2k64qqohROBBtOtgJVdbfcUquDpfM9nGXLxd/u8bInLCeVIfLiF+OgfOll22pAxTDxpEdNYGjuj7CcYQirh2s4btzRXno3Zx4pinscxl1xP7UJoeNzBkULKa5sIsOEaDOvDKnF6baEeWyd/uENBJFC67es8lkRuqQynS4eJOQ1Ikr96NKeQ/taf8bPhzydoS3FR7PPv1jGfscqJQZw/fOP2K9BY+P4tAUOCYNd+h7xDDWS5NsAIXRlJvcixWf4Pz8MpKos9GiXSqJjpK8n5+b8qKZGV1DZw9bL7u23fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUB3R0FCUbtaV9iebejiOlrnhZS17QWpyZJU7K7rONA=;
 b=kjs6b0bMqL9htBECOfY8moDD5lKEg82vqeLl+4+p4kSxaIEr0aM72bHTKkGQKATCNcM2BS29mvAU6NT9PwOKgGbY9Xn8tfvsENYWv32Sd2tYve2nFrNDTG5+WRT+CyIQKGd1ruxkD5WUxG0OhhD0kiEIuIM/xiO61lxJcZMQXPdxpw/ef5VwTz8Dts8yXX0cIpnKiGbPYl3cFk133dlk0j6Gkx4qgDg+1p1sUiZpHP5r8VphFg6oFvyq7P3r0T4rSdAiFsjK81I8Asqvd9e57/mF571jAsG6Qo0CLcwf16MAOriD64/xzHsgTiadyLQpgwK25dU0x+le/8xiWDjVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUB3R0FCUbtaV9iebejiOlrnhZS17QWpyZJU7K7rONA=;
 b=fDRUvaVWdx2hUslOCzx3AkG0OeGc+/D5nj9OeL8+ux22/+23TTU98jQTKfvoNdqiQ5HRmLI9UUGY3RBJwQMRNlAx7RHEammDeUPFEa0uXx/b9W0WDM8SwpJ8dY8ot08DUi4XVR4SvVOnGFdkhPfo/TYIwGsPUbyn4mxAPb7CjBg=
Received: from MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21)
 by PHXPR12MB999232.namprd12.prod.outlook.com (2603:10b6:510:3cd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:09:23 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::aa) by MN2PR15CA0052.outlook.office365.com
 (2603:10b6:208:237::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 07:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 07:09:23 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 02:09:21 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v3 3/3] drm/gpusvm: publish dpagemap early to avoid device
 mapping leak on error
Date: Tue, 30 Jun 2026 15:08:59 +0800
Message-ID: <20260630070859.372954-4-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|PHXPR12MB999232:EE_
X-MS-Office365-Filtering-Correlation-Id: 056deff9-6606-49c7-84f8-08ded6768379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: KzqLXnBIvIVwyGn3r6LibxPquJLiw5awARoLU3EgnOBPuJUkz0VN6XwkwHcHRE0TWsJB3SqbA6+n4OnuktdBrMWS6wtcIZ5iuTx/COGYwDv5YZBftwkyXDE2dZFJM3LcdyQnaRwE4AxLttpv+BSY0jMORlv3olgsB30/O5it41y0+RvfW0tVOsT1tIESvXdtNGNyzl08dFICPyz2R3beJuQCZXQZd+4FOrsCStVQINQsGDaB1sk8J2PT59fYOb8y5IeqwTZs3UHncoshDtCDF9IVpr7HeXKtUAXQOpRNAahuLfHx4IkJ84HPnr483J7Bp0kgGk2H3JNnssqaxOPvcnEqB4Rw4xSBIdf6O2P8xuLDQVJdnZ8UNB3CO30DHsvTU993HOrRnzGIfmcQM8uatpWl/NmaCe2JKlCIroXeP7BUii2hzPRCLICuGhMoOFRmYhs/UMvKT3J1ukGU09QR23Vo14c3GGgpqf/3v89ggcm3k0KiSgoWgywen2bv52c3v96yStYkMe8H4GObfMg3qrTSIXQeGOBF2l7knBd4nH0c4K0zVUaMcJbNvP1vTGdh5hqKsJOFb2osc08Ig2wnBxs8PYROn2VNzpfq0i0FyMt6K5+eAsruADrMQ7myk1iIfyiDEUQyxCUD1tWVxN4SYBRZGcQWoUWVBMonsbpl/wTieC/odwWESO5r3DIb3y0ReD/avcbdfh0SNzWQ/njP+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uq+NOgkmi8LAFsYRkv8Qg4vxKRbRJIM2ezcwbK4CC226evstRO+dRnmBDDWJHthpPDBfAcETi0lyt4+RsOI98YBaoyMt0uIJDhX8iIu3KgB8lumdJVQhsN/uxzGtj9ZaxUXTuu70MwRjS8OvW6VOhON0zCI0v+HMvvapYbQriwQkKq5qW/2ZcsYhZL4wdC4inyLs8CYLa+70wY0WW9+8sjzlzYYbg7dVH7WTtbaOYwpccKFR7S8JHfcmJQDXorjI6uYM2Ahcyr8OyBuCzc/Ja2rtbM7IXD9tAL/NhkdmKXvZS0l6G4xVVDNi0KmmLH2aBezRovjuFNTquccg2kcvDKMrIp+IzpXd6jDxoXYPLnLhzZTlo8KzI8YuJYJ4IE2qXHAERQTfb5+DkX1MY9P7BlpCbU8xbitHoVQ4tcn2HfYWrdpdoh7/81omin2E5tEL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:09:23.3109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 056deff9-6606-49c7-84f8-08ded6768379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999232
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

