Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4A606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=feUikZmW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C1910EAF9;
	Mon, 19 Oct 2026 19:41:31 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563EC10EABB;
 Mon, 19 Oct 2026 19:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwRR8urEdjM7Oa+l2I8JsDbStA7B4vvXQ8IYPI8eHWUgTOOelsVe90U72KmvekZfLRKEauL8DB91c5rFNfXdtz2WjBpxmeyaDJZgainP5TX8AKui9MriRyFdvTxiEsQ6HgR13ztmGL8kxOnXJeIdCEnPS3AzHTg25kKASIwJX3rlHh3sejavCrAimsjXHwxzgGMyiL/MWcD6GG4u28G9Lq0lyBqblQASnkpgrOkgTh2/CyfprQizWSZnZ8IYgu7aEiaLwlkNC/p01DcPtRLKfWuPzj7lrGIyUzrt/+Loz9buyvWVBeJtUwFbSks33+Lm1QIn8pnsttNdSHcJg4sa1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63aoWYrB2jSTs/ezHPg6t3SiooQM8QlJyQrGVeKlkZM=;
 b=DqQfHELfbr9uGP/i4H51AuujYwaci3dc4DZfNaQyVFz0AtES6XqJcAnmZzFFsPzYlt5RsgNRJhCMp+Fa7L6U4jO83NchPvMVorN3HkB9ydbt4zYp5O71p0pKVzKCOseUhZoW3X70pPrSRJCkCAy4kjQq0mprJKqwOgaZQk2VLH3CxK4I9ldz/Y9IQlOYwah98Pi9v79YtdpzG6A7EL6/U8zrBO08CGs8cQghcMXdkMqwYzCIxaYqgTgsptWItW1wDVj20r0dNSOcYh1ehy34Fs+kx7Di2rNaZR5umKEGqfIhHMZwAy32pB7rYOez+47DNJi+HErQo/w6lI+BcQ/bBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63aoWYrB2jSTs/ezHPg6t3SiooQM8QlJyQrGVeKlkZM=;
 b=feUikZmWz2A2FrSF3DzufBf2yrwqScw+rIq1fiG76JT9GyKVVOIlYDw/eWlf3ShvzDTcNNFbdLdyj+4Vavlp/kvalkziRtG470W8CHwHsVLyhD112l5rCVIxKVHj5ODwHSKI5jy+ECjappc995ntyue3d+IxKfj95jGX8j+TZo4=
Received: from PH0PR07CA0082.namprd07.prod.outlook.com (2603:10b6:510:f::27)
 by LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:41:16 +0000
Received: from PH7PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:510:f:cafe::c) by PH0PR07CA0082.outlook.office365.com
 (2603:10b6:510:f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 19:41:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH7PEPF0000000B.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 19:41:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:41:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:41:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 14:41:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Oz Tiram <oz@shift-computing.de>
Subject: [PATCH 1/2] Revert "drm/amdgpu: Fix VFCT bus number matching with
 soft filter"
Date: Mon, 19 Oct 2026 15:41:05 -0400
Message-ID: <20261019194106.2796150-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000B:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 2def2751-cb3c-4f80-ed5f-08df2e18f082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|18002099003|13003099007|11063799006;
X-Microsoft-Antispam-Message-Info: peTTnNr2PFrtgMF8V+KVOrgzhT0H8/nM5m/v+J+6+mvHisD8hORMkClA/Prs3Zj0wVSrm36OIlX9XSTc4ufKUfjBFz97IPpZV3GRj+82aX7KdKM1Qf9E0pe8RKElic6hRI7jxoDHcEMSMNq4A0yVzsPcVnB9SUnNtyJoqvkENYGHujDZeocmZpHvh/jXBE/foT87VlC8xXaDI1FKKPz4OaGx1NdyYssOEB0fEneivpJphEyMrUyvOt7XepbxGxFnZZGLavo7xn2mdlobLjQQcKa2Qt/b6Ep3f8d2kjsjNPBbCgfFL0gvhCzkK4oOO3w/ENH6Sd8UVf7YRyobqJu2KZXqtgXfh9vuXEjsvJGxL1x+c0/FCE/ctdhgIALyy/d6ZdzU/b4audFkGCy9n2MvhP+i71k0UTRBUi/NpqNk0bK5my7vLVdfbXNweh0jZZVIvuzzQKQNVRYyfjuxa9K048R8vxu8Ej2OS+n72QYyxGjq7klZGdFxELLf/g79brCctRqz3NFmIuDlUWiYm1Acq+8QzqvT9i2eAJkwWk99avHqXo0+GAFJF9CDQCpOGkv4edA5JgdDj/5+wuXBaHgSFafRVMgz5UgRIjhOIO1AXHlOarGGJynarvCh5FvD1Dd1dRqAYvdwgQFzOZi1hKeaug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(18002099003)(13003099007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tmrN26YP1QHIr0g6YfpuXBf+R7vP7pzuweED4TAGRI8N9xIvSrayPrCuKEmuD6XH+rOHRoXu9jRAx1ms/a+fKQEHKVsPzCmEKlHch6Qco6/AAyRrAbXyu6QRA8uBicJqVd0wkb2N1Di9nYE0TYbuLG322Q+irFvBOJeRbxeNe2wwm8hz5k4Ohjik0oPjYeQg97U7o+vv8LyuN3Hzj+7SrycbydwYSD3iKE0vS2WW5r0l7RkK304tWWGazHjHBr3NTcerB5NMJkuC3N63pwRsCg3qXLVoO6rb0zHUKwMyyODg4S1dpQlhqBw4tpKR/8rOTlBudiDPQO5K08bbdvdts+mmeDbjK0rdSBr/tnB31vYWoHNQPCmyNNIgql7Y8+117ZrCr1wZYZNfIwRRlDiIOXx36EYFseGa7OoSGxKjNiwuepeVU/95o3sKM1pDVONL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:41:15.7982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2def2751-cb3c-4f80-ed5f-08df2e18f082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156
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

This reverts commit 11c141672045ffc0187aa604f2c0f597bc334fb2.

This was added to work around systems where the user specified
pci=realloc on the kernel command line.  The firmware specifies the
BDF to match, but those may not be the same with pci=realloc. This
causes mismatches when there are multiple cards of the same type in
the system and failure of the cards to initialize. pci=realloc is
not the most common case so let's revert for now to fix the regression.
We probably need to store the original BDF in the PCI subsystem so
we can use it match later if the BDF has changed.  This can be properly
reinstated once we have a general solution.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5762
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 45 +++---------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f9315e0472fe9..6bbca70a4e2eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -428,45 +428,6 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
 }
 
 #ifdef CONFIG_ACPI
-/**
- * amdgpu_acpi_vfct_match() - Check if a VFCT entry matches the device
- * @adev: AMDGPU device
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
-static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
-				  VFCT_IMAGE_HEADER *vhdr)
-{
-	/* Vendor and device IDs must always match */
-	if (vhdr->VendorID != adev->pdev->vendor ||
-	    vhdr->DeviceID != adev->pdev->device)
-		return -ENODEV;
-
-	if (vhdr->PCIDevice != PCI_SLOT(adev->pdev->devfn) ||
-	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
-		return -ENODEV;
-
-	/* Exact bus number match - preferred */
-	if (vhdr->PCIBus == adev->pdev->bus->number)
-		return 0;
-
-	/* Bus mismatch but device identity matches (PCI renumbering case) */
-	dev_notice(adev->dev,
-		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
-		   vhdr->PCIBus, adev->pdev->bus->number,
-		   adev->pdev->vendor, adev->pdev->device);
-	return 0;
-}
-
 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 {
 	struct acpi_table_header *hdr;
@@ -503,7 +464,11 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		}
 
 		if (vhdr->ImageLength &&
-		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
+		    vhdr->PCIBus == adev->pdev->bus->number &&
+		    vhdr->PCIDevice == PCI_SLOT(adev->pdev->devfn) &&
+		    vhdr->PCIFunction == PCI_FUNC(adev->pdev->devfn) &&
+		    vhdr->VendorID == adev->pdev->vendor &&
+		    vhdr->DeviceID == adev->pdev->device) {
 			adev->bios = kmemdup(&vbios->VbiosContent,
 					     vhdr->ImageLength,
 					     GFP_KERNEL);
-- 
2.56.0

