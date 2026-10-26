Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A1606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fjXcKznn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFA3E10EFC8;
	Mon, 26 Oct 2026 15:49:16 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A36C10EE94;
 Mon, 26 Oct 2026 15:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpaChKlHhJ69/YIKr5j0oCLiUq28gN14n1OuSJ1wqX5qG8zkpqFyrCdgxcBDtpQcPWcVSy4mdgLjC17QWnwAZQQiTn22ypEdCxPlbDTnI68F3uqRpTAd+vBpSq1yZJpOYHgLKo1UtHLhZ79glLLVF4aq5voiED1FxGTS/nT8r6D+RTLdRt/6VZZjilyth2XF/kiYxyAE8rNWmVdkg9dZKaQWVcQ2ry38wcGLXgeqeles5lmHTW5H0iv4HkPKSfBnDzKSCrIMAr2BIoHpfBc7SRyNqPyNZVb9Q8caz/Gv/X+gChlbVYaUQukeBxU/fYYIKNLKx6b4dm5fOhfLplKWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22ywsYlIXPLEZhJs/rKkSRGb+sdBWcXQ3G5P+0AZq5U=;
 b=GQm9FnWI8BaLEn+qFC6PQVHTMJz9dOge+0DwL5Pv8p13yc8SzHDf42VgJoX1DVEZkPI3i/XFqrfEfk++lCOvxv8WnFBTjcxzr/JF9OuY1zxkDZjeYo34mksxVPOvr5WXHCHTvkUWkNiRe03UNxy+6RG22UVrbVwxUtXRm6GZAfXXzrr2AksrluFkLE3V4hSHRNO08zxSVj/CpAq1pADdAPVYLdEpsyI+RBz9Xyf66ee2P4TXcOsH1bCLaSYvzOqovLrt5kmt4O3QAmQxatmlGPvRPtnyOSej4xBhAvmriklPLNjCA6A7kkW9/qvtIF2gPtCi9/JBnRAhD82ZBWNNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22ywsYlIXPLEZhJs/rKkSRGb+sdBWcXQ3G5P+0AZq5U=;
 b=fjXcKznnVJgX3v8xEYb3NosnhaP/F0/KfiZ1ZvBpTJ2Z7A/ZcO2SrLE7VBjneMWQjYRBOmh9Nj+FuZXpczCqLB0pqvGThUmY37cGVpQPu2E9tcd0WLTbELGURTyxt2bDFv5rEMmhmBn+oLdeGljOwHx9LIGh0T+dp17sRxfyUzs=
Received: from SJ2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:a03:505::10)
 by DS1PR12MB999189.namprd12.prod.outlook.com (2603:10b6:8:495::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 15:49:03 +0000
Received: from SJ1PEPF000037A0.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::76) by SJ2PR07CA0004.outlook.office365.com
 (2603:10b6:a03:505::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 15:49:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A0.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 15:49:02 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 10:49:01 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 26 Oct 2026 10:48:34 -0500
Subject: [PATCH v3 3/3] drm/radeon: Match VFCT using initial PCI bus number
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261026-vfct-regression-v3-3-fe9586ed6978@amd.com>
References: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
In-Reply-To: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A0:EE_|DS1PR12MB999189:EE_
X-MS-Office365-Filtering-Correlation-Id: 32921129-4a9c-4e5d-61f9-08df3378a8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|261026140227099003|11063799006|56012099006|261026121527099003|261021123027099003|261022075727099003|261022115727099003|261021121427099003|261009223027099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rL/ciiKB/XXBq5zEGKBBkIcB8LJR5Xq1PHPF1ARQtR0Fr1KSznYgLGj2dKfrFguu8SNnsoLs1wjw6cqx23ox2px8lPrMtnU+S+uT6O0ONnnF2ojIzHuhZ1yyFuv7nUSDRwe+LDvLIgcM60+qMpIFb9qf6vtfzwrwXqTG1l1lt5/7GaYQu+q306AxEjwCwSXIvSbSG0lDqcFy/xi0F3IoPnYECwINlKEas7NvcTTeXRyp50L9JLrc7f1Ecl5VF/l0p+ewHDgVWhc9eyJpRgvkW2Gh4aPK1DBes15vj0thXQKS8VB62ErCmXL8PSfebWGevy9iaROm4/2LVT65D6/YGjWclKqJ/MFzprSwAlfs7+Of3bgC00JCABVCTRcyOdDoobWdNPw1sUzCw3RJfMbe1jLmE+Ag6QEWwXmRy3b/wAvVDa0SD13EC/t7SQxC5bd2VBy8EuSYAKv2S/kRCr02jTET6/Ct0qAWNHppvd2ss8d4yghVZ2nd4opsj634ac1yYv1BjynXg5Ii1FJH18TS4W5MXWFoHvQ2leMDCSbb7vsXqtkvC3Bh0m8E7w6KxPMoDtDtwGfYZhg8pkNlGzW3O+JTGE+I3sx79aK6860oDu+kGiaYBkgmLRtVfKyTkSgcOrsmLIjzkAw8eWohQkfD9ouEJDcXdcDTIOpx7EDYjp8G+P6ikfvBpDOWbuMdELQn2hApJfrWftvo7iom/CXCkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261022075727099003)(261022115727099003)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /dY+xun6fF9wM+ojmotPrjUNjoLbWSI2Ye74710aprL5roRY4UtkBDLu7iFIxVhH6dQU8xRiUgBJSJrSdDQ+3r0btSTxau+q2lKtc2eNn8MTsxIY6YxBf9NOlobQLzUsXJjnD6BXcFHKhi7UXpyDz+yGaJwu2pyktoHQNv2fZx5JgTI6o4EzgUraOUhgtBzPNkF4kvKSNXmAXF77kXoBI5sJFHhx8Q4te8dXCb8Na+sJ2gdFLLL2glKf77Rugt589jLK5zcy4Am0zuNletRKWiK7VcSXbz33Xi2yQ47K48AzEKraoiKbzgZjqfKc+RqvcVIbrJ2Ds6oAMBwPsvKAjJuUxcy/Ui8icvkG5GLSsS6D/h/PWQTD3VorEi+Qfu8/H7da6YEJ/ycDFGqvYNTcw1LUBPT2Wo67TxGX8nfl6NylIKdl+PoZ/MtHDzwfxVfI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:49:02.8963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32921129-4a9c-4e5d-61f9-08df3378a8c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999189
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VFCT records the PCI bus number from BIOS POST. The current bus number
can change after PCI core renumbers the bus, while accepting a mismatch
based only on device identity can select the wrong VFCT image when
matching devices are present. Compare against the bus number captured
from the firmware bus assignment before bridge renumbering.

Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft filter")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 1da6bf1c17ff3..bdbca4fad6b8c 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -609,10 +609,8 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
  * VFCT entries contain the PCI bus number as recorded during BIOS POST.
  * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
  * resource conflicts), the runtime bus number may differ from the POST
- * value.  Match by device identity (vendor + device + function) and use
- * the bus number as a preference: exact bus match is preferred, but when
- * the bus numbers disagree we accept the entry if the device identity
- * matches.
+ * value.  Match using the bus number captured when the device was
+ * discovered, before any bus renumbering.
  *
  * Returns: 0 on match, -ENODEV on no match
  */
@@ -628,16 +626,7 @@ static int radeon_acpi_vfct_match(struct radeon_device *rdev,
 	    vhdr->PCIFunction != PCI_FUNC(rdev->pdev->devfn))
 		return -ENODEV;
 
-	/* Exact bus number match - preferred */
-	if (vhdr->PCIBus == rdev->pdev->bus->number)
-		return 0;
-
-	/* Bus mismatch but device identity matches (PCI renumbering case) */
-	dev_notice(&rdev->pdev->dev,
-		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
-		   vhdr->PCIBus, rdev->pdev->bus->number,
-		   rdev->pdev->vendor, rdev->pdev->device);
-	return 0;
+	return vhdr->PCIBus == rdev->pdev->bus->number_initial ? 0 : -ENODEV;
 }
 
 static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)

-- 
2.43.0

