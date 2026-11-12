Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFFD606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=x4OK2jq+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A5A112341;
	Thu, 12 Nov 2026 23:37:30 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013054.outbound.protection.outlook.com
 [40.107.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1EE10E6FF;
 Thu, 12 Nov 2026 23:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rB+UXbdlTSraG13XdijvU8srLWSjrOX6GS5JrVpxFCKYX5p347dQgwBxhFISBl00m7baz2rGEgSx1vKPIZxsgMiLszJFLmiGyKALAvlShiZAMLKG9H8KZAzfTRcPYIDpfA+Bmf2Fc8zQ/lFNFLmNAcJmFkQwzfqvrJ0DfntBzn/uWMhVVKy7i/1QK0Y03VG1I3FcmzWca/g9f+f6IBd9Ig3KMrvHOl2K/wKbw1fSZfecfyRO+MIBtM9goILeLiCukzpwGNIr09CrZqLy1mpKZmc5OELs/MOxdSW8apP8V4suUsDwIBZ4bJpWRhPNF5uXOjYWdWzXGgul+7Afdv6ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvEtPhKA0/v32b7y2MVPCN7d/SVffvp7nqYfKBD80us=;
 b=ePsJW3vZq2A79gKYItyxrQdAyplwlYkyL7lZKBS8FqgiilqSkYTokVF+dQ3z4gOkkcT6X7PQHYyG8XE0cgE+nvp75lCHbx6FlsBd7mwWSRifivzjjsK2BUmTbrvOhpkyTEmArMi10xbTqMfOdVvLv2Jj9ZMM6SgEiuVer3Q4/cG67+V9wrMttA0RNz6BynVrGdjLlEqoBPCW4OEZjWYs5Rzd1KLl95qIU8jFPGyY6Y783qZDSq00oENyHMtFRJxMrNkESHCp+D/9s3cqXKFHVkvZBrAmv9LlZ3TlunKpGY/Lnv1UheiiTTMT8p2KEUDaUim9N/f3UEqJ1AU9JU499g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvEtPhKA0/v32b7y2MVPCN7d/SVffvp7nqYfKBD80us=;
 b=x4OK2jq+1RpX/jsRvxec1joL6TifFc6/czECYBjH46uPG0V4w1bp5f7bR8jB9nGTrVIOMWQ/Yi4sjgJGJNvgV5DWrCVzmbrMrtXfYzWUWPka2tmW38K5Zqvx0wGn+1TUCVbybNST7H0/d9kTCcULhavU7ji3cJ0RFzmnvC2TxMQ=
Received: from CYXPR03CA0029.namprd03.prod.outlook.com (2603:10b6:930:d2::13)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 23:33:56 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:930:d2:cafe::75) by CYXPR03CA0029.outlook.office365.com
 (2603:10b6:930:d2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 23:33:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Thu, 12 Nov 2026 23:33:08 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 15:55:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 12 Nov 2026 15:54:54 -0600
Subject: [PATCH v7 2/3] drm/amdgpu: Match VFCT using initial PCI bus number
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261112-vfct-regression-v7-2-69b1e0cf45c2@amd.com>
References: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
In-Reply-To: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b1c996-93ff-4a8a-0e96-08df41154edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|22082099003|261009223027099003|11063799006|56012099006|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261022075727099003|261022115727099003|261026121527099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 64/V2YNpjyy4jeE2UMjl+KwVCQB1WCWvFgXPBRKyLB3Jz0wYD33x0dbX4VuO3wqok/+rIEhR4bFcw1C/lWv6IrqIdQjOfeifMFMjcup1Xk9uw7+2y9uKIznvRhShsV/J/atzKSQsFOR/chwxVARNdNt93MpSSK8tRiYRl0VnBhZWzsVYwUGy9VQz5aKygCGJxhlwOAA/X8dTrjjpx/LlL8iBTwk0PzPRbdwXWpYwBtJsd1apKLipCBUmU38gL65bEkvH3NhtjvD1kz5uMElfDePN9fZd4x71mxLC/8uU1X54hJVr4S6417o0OSOLQRqglvnqnqJB04dsP8VDRIKodnoUyc6wRgd0aAPRNTgPQQKLT/Ut4g3x3N+69dDPkwkkhogclzHclhfoBgRCOmB8rWPXhBfwh9sdVvQA6MVIEfjXwD9ra3rkPSaDfoPpDk7FhN/zGdnuhYs8BHbL/UifcPUXlsiR5CrN1sXEBA+AJeKDqOgL3HDFWAlB304kxa77DEzF1MWOO+CrAlmAns2+TKUI7rJAmdRWsySbX/Nk+gpD8cLJvfiOnvnMgqIRW/WxauLlCP9tCCVGy8QR7ZVDlT4hmNlzqhMqDf9Zp4+oa+EYRC7CHl7DIIElv7UoIisaabi6x36VvbemuXcOwMxrLaMRWAvFQ13T7KbmCwlNlKI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261022115727099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b/g927Sg7K5cL3PF/3MeJTxMdJlpPadmlbNEBE5enrP7glHXc9nE1v8nU4pVobk02OqRxcApHIzfJ9R2rx+iIsydD1N2zFojPDn8wHcg1emuSvQMDx/IjmwihqHAz+jvas2m/BFXO1KRds/kQJTXZ7bd/+8Qv6h3FsxN7Z5XDyRahshTjHSgSRYzcLaOtmMIy8YlA5w0c2t3QwcpgvIlBbzFqPc7DlPybqXA7q5xoYAjYqP+CxmfhJ6e41uBtRursB3oSE0LZyR/1X8o6NBmCcBf/Mk/Hz75+bczClpIvWwFvz0Tdfh0iZ41KNXyzikqFTsqsj2ATbpgI763XoXbkX3u1M5kZf5H3zQkqwt8YZwy0uv+P7/CZJfMwkiJd0DKNjf+ZoH9gBjxmSDNHFBHRiVILKBwn98OJWBrHn/cvk9lmIGjP9DKL36nKyU1mXEM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 23:33:08.2694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b1c996-93ff-4a8a-0e96-08df41154edd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 08ed1eb695586..0ee4c6462c4d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -386,16 +386,17 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
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
 static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
 				  VFCT_IMAGE_HEADER *vhdr)
 {
+	struct pci_dev *bridge = adev->pdev->bus->self;
+	unsigned char initial_bus;
+
 	/* Vendor and device IDs must always match */
 	if (vhdr->VendorID != adev->pdev->vendor ||
 	    vhdr->DeviceID != adev->pdev->device)
@@ -405,16 +406,12 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
 	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
 		return -ENODEV;
 
-	/* Exact bus number match - preferred */
-	if (vhdr->PCIBus == adev->pdev->bus->number)
-		return 0;
+	if (bridge && bridge->fw_sec_bus_valid)
+		initial_bus = bridge->fw_sec_busnr;
+	else
+		initial_bus = adev->pdev->bus->number;
 
-	/* Bus mismatch but device identity matches (PCI renumbering case) */
-	dev_notice(adev->dev,
-		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
-		   vhdr->PCIBus, adev->pdev->bus->number,
-		   adev->pdev->vendor, adev->pdev->device);
-	return 0;
+	return vhdr->PCIBus == initial_bus ? 0 : -ENODEV;
 }
 
 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)

-- 
2.43.0

