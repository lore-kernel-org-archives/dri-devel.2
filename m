Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF5C606A887
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Vlt6wk3J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4FE10E11E;
	Fri, 13 Nov 2026 00:54:21 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59CA310E0AD;
 Fri, 13 Nov 2026 00:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwn2XqVec2nmAtONsQ4ItggIy1NoLD5xICURQncdi1fB9EIbSuR63plLbuBRe1N7d7MbsHjfc7qitBQfw36eRILCzTzCrhaS2ByoY1dtfOA6KuVm1y/eQB+ajBy9dzOrx13pxNQtFsqYkDFUBYT6uYRGlc2iA0wWvCkhdX0nqLA63QiOuHcbZZIAJW1tCi58SGpgNMW445fEQVQhoPQ8QZeQMwhPqWr66wWsicXG5uwKuByG5PhZm0o/nAFIh/nF822OT4wov1hChEr++c6J2nLbuYVvEEV9HF2uRBY/CUuLnWuex1OXFxaa0tYB5RXOzSW7UFbj/nb3IICgdvCUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ0Bz1hPv5O2qx+E5MPu+2FgjsX16i7WQUUNCqOeMv4=;
 b=BVGRVVMQvxU2wOuxtwNjZUTYzR2BApP7U2Nx8/B8ijlXa94hvjiVS3pHpqKFiCqfZfYChKfz13no7vLu/hMLw1K6eZcujH7Aksy6zgb+ZpaCJrqEUctLH9KS4qjx3HWvIkW/sLDjR6isdJo09z8frTHTVtRs+tkJRhP5hJ1a+8GNTk+hCRQQj5BSP+Rb59kkJct7eW4eZ/X3yaPqdgJMp6mMxD3B5lAHOs2cwapDCRJkLka/Vx/yjW88NDtfLXncGjZ87T3FmKCj/ezRLasX5wG6ZMmDkBkxOiEijYUKQ3HOh/FKQW51Cf3//r8ctmLEHFz400q7BkTMxrQzGCTmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ0Bz1hPv5O2qx+E5MPu+2FgjsX16i7WQUUNCqOeMv4=;
 b=Vlt6wk3JtNHJoAZB/GLt7UIP70iUmjNGBl57KN4lSUd5stZhi2z1guhHi5vOcsxkH8wgKiRycBh/y6DYRP2hc04dcyMTY/NsUt5fP+naFqXcaYlO6YK1kOFc5gYbkGwNsBvC188gar5uuLCFdj2a1ok/QxH327M4cqz4VQ6DuhY=
Received: from MW4PR03CA0356.namprd03.prod.outlook.com (2603:10b6:303:dc::31)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 00:52:05 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::96) by MW4PR03CA0356.outlook.office365.com
 (2603:10b6:303:dc::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 00:52:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 00:51:53 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 15:55:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 12 Nov 2026 15:54:55 -0600
Subject: [PATCH v7 3/3] drm/radeon: Match VFCT using initial PCI bus number
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261112-vfct-regression-v7-3-69b1e0cf45c2@amd.com>
References: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
In-Reply-To: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 0190b5b0-ab5b-4b64-e641-08df41204fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261022115727099003|261022075727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261021123027099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kJth+L9EaAG+vtWR/Q3HSISTAXdCGU7ry3+IPMrhWmtoiKOJquykeT/2d3ca6hOizX+Gk3tbQJkfylPDShLp1Ek5qk9D/3saQVhHeF2PZOPHkfydSdxmAYSkCy4zo1msd/J1vnQcRi178qMoxc9tHqXdpqbEkhonejFtx1fdERrpB1WaJkH9663dmF9Nv9+EDpBEami+3IZhxox2j4CoRJ9h3990SCM5ugQ8SF13bN3JtsBIJJW0Yq50oBgKQb5cFdUoRC53oXIe5otTGw7mxXkQU7kPPiAZDpZFSqvRX0Lfi7sa1WOVG89nIN51NMM0m3jvH2d0+GVPWH2m2+K7yG+qVF0a/LbxdqSpTkmlPrfbF0bhYhZAnLONZVDQKhdE4DTWu0GQvRF2Ny5p9EfDgF3JM0aR0yShFHuRuMFO3NmKHgrWi6A4g/dURYoWoS9ICJMIsdV/ogoX0TNBdQ58okUx7KicV48HSwlZ6lDPO38PmAwPdmEYKmmVIH4prWVxtDaZEIi/cACGqhBtwkbgPRC9YPh2vg2VHkn+TEZr2UT9ysHgMweei85uQ8njP0+26J5IqYRw/X5foQfQLjuh0VHRcv47Y7b1Ady8tcKAaO+Uq/m3J2H4a7wxWLZFKzX8lYEk6CrGLIQiTs3wnK28XzuZSrLKHZjVi/+mctYLQx1W+0rkLeUwQIDQc1egryJhX7EwrSHbDl1t/73YYY7T/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022115727099003)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +wZglADTIDM6r3S6q6qjaoQB1iaK4A+YbZFYVrAPWE9waP8SyHDzqGI8vVW3R7AA9vYLNP/2Tb6g2FsuV3AgpS95KAMWZLPwdhPjIPuYcYhfKSj+TxXpJUOrWa4JGTntD7i1MJak5qg8CW+Hgq6mGdwBeGWsewm2TrLIs++E+qIZAXJuunsCVK4AowejH9MCov94ha/iIO19d8Sto2IO8t6SnKdllCWPg/DfmRkUg+SruaQCJ1uG1CnP6Eck+ROMp49ZdBmL9vd41/0pEOVFmsn3X9y+gDgk9KiZQAhtOHkzWP1AQSYAPPLuMTW2bDssFqirjDEtY/mZzggUXsezrxFug1hr6Q5MTTUhetHImhx/oy4YS1/2q8uzT1Y5ki2Qc+84oQcUrm3vi+RTT/+rrlwu8xdMuH84qZzKKWLn8H4RIvbmVyiiWYO937pgSa69
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 00:51:53.9841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0190b5b0-ab5b-4b64-e641-08df41204fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836
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

Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft filter")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 1da6bf1c17ff3..707566e376d05 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -609,16 +609,17 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
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
 static int radeon_acpi_vfct_match(struct radeon_device *rdev,
-				  VFCT_IMAGE_HEADER *vhdr)
+				   VFCT_IMAGE_HEADER *vhdr)
 {
+	struct pci_dev *bridge = rdev->pdev->bus->self;
+	unsigned char initial_bus;
+
 	/* Vendor and device IDs must always match */
 	if (vhdr->VendorID != rdev->pdev->vendor ||
 	    vhdr->DeviceID != rdev->pdev->device)
@@ -628,16 +629,12 @@ static int radeon_acpi_vfct_match(struct radeon_device *rdev,
 	    vhdr->PCIFunction != PCI_FUNC(rdev->pdev->devfn))
 		return -ENODEV;
 
-	/* Exact bus number match - preferred */
-	if (vhdr->PCIBus == rdev->pdev->bus->number)
-		return 0;
+	if (bridge && bridge->fw_sec_bus_valid)
+		initial_bus = bridge->fw_sec_busnr;
+	else
+		initial_bus = rdev->pdev->bus->number;
 
-	/* Bus mismatch but device identity matches (PCI renumbering case) */
-	dev_notice(&rdev->pdev->dev,
-		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
-		   vhdr->PCIBus, rdev->pdev->bus->number,
-		   rdev->pdev->vendor, rdev->pdev->device);
-	return 0;
+	return vhdr->PCIBus == initial_bus ? 0 : -ENODEV;
 }
 
 static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)

-- 
2.43.0

