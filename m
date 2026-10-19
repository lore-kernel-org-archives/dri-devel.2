Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1B606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aaScpiNi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCBCC10EAEB;
	Mon, 19 Oct 2026 19:41:25 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F3210EABB;
 Mon, 19 Oct 2026 19:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+bK1117tMey++g830ibB5ZKn+jUgfDofjU1o99bn1ZPe2Ldk3hOxOEY2wdPDV81F1udUkhlfy0fyC95+/p7vyPPTdu/RnNP0kmgX2PlPjbMaE5mWRbxrDDClix5ZpFfpCSHBE89qU6TwtRkRHIVDVIRSoNpY7/ixVGfso8yzH8ty3ozKfC/6OrVuQcVhkXT108Vu8KOVnX1HYdXMs6CeehVulVdKPKCZih/woslja1DI5bts062H7SxheDQTBDYt2uMlZavYokpVyYXN7RuChTx0ZHM/n8TQLoqjpdoS7exB/KFEdFeEtdA/iIMwzjnWvKYAnCDUdiEJnctH9zsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkZYNECj1A2GOY5KIz7Bo+U+8GAVINv7nZVI7wil9ik=;
 b=P2eWm4TKxK5b2rqajyzIw7ak6Ildp7SeDdH6IFSDoTggnHvdTv0WJqJcc2qT9ueuqyN4OQeZmel+Izah4Nt7bEoy3Pi0h2Fs91tpH5tGuEnGHkizVfE1TVQOo1AyMdIFMKFbTUVmuMhLKz6wIKrmNdIDEZTu088xAdsxOr41t6ACD/HRIDe25/n5WUeGRI3IWiQuQTtrM9RkR/XHXMRHgz/hFF7CKMSHcODR0cbYjfmmdFdAO/7mZaI+cwqE0b/V1EHm6UZ/uqdK+FgMtvL2Oz0dXTZWSzEux3GHGH12vbu0iY6QmBcO96h3Dq/2gxARKPktKDlu2O5W52Vq97q8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkZYNECj1A2GOY5KIz7Bo+U+8GAVINv7nZVI7wil9ik=;
 b=aaScpiNiC8xNt9CwNZ4CXhJQF+WggCcA8S6XL2B1/na81fp7HY4kOMooNc5rUW2mRnfDtaxR5WBQdqCr7a0aa9CUDRWbHVUf4yPOmAaBTYE+vT87EmtEj9DbT+v6wrrnugklvyMdFtxZP5zYvMTTPMIv8Hlgrm3K7/ER071Dm78=
Received: from DS7PR03CA0054.namprd03.prod.outlook.com (2603:10b6:5:3b5::29)
 by BN7PPFD91879A44.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 19:41:14 +0000
Received: from CH3PEPF0002457F.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::3e) by DS7PR03CA0054.outlook.office365.com
 (2603:10b6:5:3b5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 19:41:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0002457F.mail.protection.outlook.com (10.167.252.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 19:41:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:41:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:41:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 14:41:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] Revert "drm/radeon: Fix VFCT bus number matching with
 soft filter"
Date: Mon, 19 Oct 2026 15:41:06 -0400
Message-ID: <20261019194106.2796150-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019194106.2796150-1-alexander.deucher@amd.com>
References: <20261019194106.2796150-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457F:EE_|BN7PPFD91879A44:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb1f51e-5ada-4565-25de-08df2e18ef76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vpUOu5SxcGeiNE/Mk42InnyERVDKDdCPBGG4SXUagMi+NKru8BK0SF9pFiX78SFOYVWj2rrDfIrziSjaRV3kmkIAsuXH6yb7FK+4Lj6U/JNQKSqS6doPUecaEXlgn6idzslb7vUbu/lUG87KJOBa3i83zQvEUG8ndzLAAMSpJrpdOxZSlrFlq+cZQ3xnkK/PKTW2+GB7svy0m3LH7Ic4ngVbtC/2v/YpwC7J2C40hk/eVm+0TfhdW/JhNa9QbRYgoKq2QLbkDfW9CUIZqIGRXARfvdV1V97vaR/SxxsEDIwMzmHyzbb570QjKh+wysuqTmGwPlyIqcqAWHVFspSTDgSWkk5mU2KpDayE5m76usBLBun4UgkAKXTo40V2kc6+0hwH5TgvnIiH1TmnX3JbIVTXVDUwptf9nEnhSj/sPzo+uI2Sx5viG0OcSc0IWmI9GUS3HYjscPxGVINS4EXekmHNd3rhQcinSZReTkQskpaBKt6JODvPfKHHw16ihO7jnauFn5wQgHZNhCDDCvn+OmB+4aPPc0NOFTm5nTHTxl0yFWVLvL9bY7d9Fr271O7IZintdvzaoBKfPn92NVPw4J8kKNAwoyR094CkAliMjKPRsXYMX9o/A4i5uOEWFdPu/DyNLDwcJ4zvTci5fzpL+zfptqeDcLB9hN5cTqzX+og9zFw1lD5zvtz75BWYzH52iCHQCMUSHqrXuIr6M+LKMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 92frsmhcK4d4K9TAn5wMpZkIb51+gDSKRrGA7m2BwhjLKm3wQhGTbpuwecqixg7Dcx0mb8ffz8QiaU+CHxAMQawJbXhgNb2ZtMfkKF6hTOF4s+37Gc9si77Qv18Ybkj+3/VmtjEU/mesPH+CXlJuHeoxJ1F7AJBcwgbw0oxAUp6Zj5+DvAGh0eg7mMHXHkRE8m0tKfjqBAaoy0Rzb9g13UIT4sSRK3gcG/7EnzvbyGE19c8PCmmi7o0T2LRaLybdDXVSKBYMdxbxWjKEITjk6NkYxSLuUfBUnvLdfnvNMYdaYj6UUTrJQR7Tvcc3ICmY1dqQCf7NGnG3p8ua6ReQqfrJPxcMw0Ch0+UPeDI7krMupqfUPE7MmaUmyVMNqNoyxp3J1lliCo6durkLnkGfKESudRs5NO3ynwCzBsfRqs2D3+HEkDC1DYpqu8XLZoo+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:41:14.0946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb1f51e-5ada-4565-25de-08df2e18ef76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD91879A44
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

This reverts commit 4059e2f02c8a2a51ba78860775877d721df6a055.

This was added to work around systems where the user specified
pci=realloc on the kernel command line.  The firmware specifies the
BDF to match, but those may not be the same with pci=realloc. This
causes mismatches when there are multiple cards of the same type in
the system and failure of the cards to initialize. pci=realloc is
not the most common case so let's revert for now to fix the regression.
We probably need to store the original BDF in the PCI subsystem so
we can use it match later if the BDF has changed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 45 ++++------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 1da6bf1c17ff3..23db87155e778 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -601,45 +601,6 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
 }
 
 #ifdef CONFIG_ACPI
-/**
- * radeon_acpi_vfct_match() - Check if a VFCT entry matches the device
- * @rdev: Radeon device
- * @vhdr: VFCT image header to check
- *
- * VFCT entries contain the PCI bus number as recorded during BIOS POST.
- * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
- * resource conflicts), the runtime bus number may differ from the POST
- * value.  Match by device identity (vendor + device + function) and use
- * the bus number as a preference: exact bus match is preferred, but when
- * the bus numbers disagree we accept the entry if the device identity
- * matches.
- *
- * Returns: 0 on match, -ENODEV on no match
- */
-static int radeon_acpi_vfct_match(struct radeon_device *rdev,
-				  VFCT_IMAGE_HEADER *vhdr)
-{
-	/* Vendor and device IDs must always match */
-	if (vhdr->VendorID != rdev->pdev->vendor ||
-	    vhdr->DeviceID != rdev->pdev->device)
-		return -ENODEV;
-
-	if (vhdr->PCIDevice != PCI_SLOT(rdev->pdev->devfn) ||
-	    vhdr->PCIFunction != PCI_FUNC(rdev->pdev->devfn))
-		return -ENODEV;
-
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
-}
-
 static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 {
 	struct acpi_table_header *hdr;
@@ -676,7 +637,11 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 		}
 
 		if (vhdr->ImageLength &&
-		    !radeon_acpi_vfct_match(rdev, vhdr)) {
+		    vhdr->PCIBus == rdev->pdev->bus->number &&
+		    vhdr->PCIDevice == PCI_SLOT(rdev->pdev->devfn) &&
+		    vhdr->PCIFunction == PCI_FUNC(rdev->pdev->devfn) &&
+		    vhdr->VendorID == rdev->pdev->vendor &&
+		    vhdr->DeviceID == rdev->pdev->device) {
 			rdev->bios = kmemdup(&vbios->VbiosContent,
 					     vhdr->ImageLength,
 					     GFP_KERNEL);
-- 
2.56.0

