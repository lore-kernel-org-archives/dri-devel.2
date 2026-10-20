Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF52606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PvsTdNBX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6621910F5E3;
	Tue, 20 Oct 2026 14:05:09 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0AE10F435;
 Tue, 20 Oct 2026 14:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dT7dzbrh9sARBfO9A6oljmR0AkfZZSGqh1d7pHypuy+htOWGublRJK7sbydDnnWqmNnrRXcWeXaeRT81Bsrkjmi0OKj7Fs4YfTTRuwlrqi544x1k7CKCbuK3MfhGsvC6jHD1vreVoJpL1cqElv9V7jzO3A3JGS6bYifEwS925u2Tq3zK1WhN2F6mxlO8dv5/majqI/4HveHtXtmTtAfcxsm57pYksQ7ayLcmnnF7krpLUhJXR2X+GN1Ww//yVNSIFzg0Dum8EIHcEGn+F1rbGlZ4zkKjE5d2B2wMDhQh+SVt1IbCzLoAn6k1Mr5D+vfycomVkEu6ZHo5mfErWa1l0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO4spEKe9JdRgj12wcWijTRNiRAWdhbaHRwxG+rLjS0=;
 b=W/oTWLGk3Rr33l3F5jsuCDvNWPO5fWtfhklzI+9ZbaG0sEYuG2J5xvW1dGc+eDfsVQ+JahOlaLdFkLm2DREOFrXzUVOCG0vjligBG5FH7dtM7jbJkQKh/eCkVVafTzJ+5vdE1hegVzQkx4e9hR3pjJ7A7t0CF2pngNirFIaKHAM26PIu+Rwo4ankqXN2ttpwxdVju/8PE61kPlfSme0BhG0GA/TpA8mxXszWQ1LAylmnFWYYreRKXvfTgT1wbS/qeCSkFuT/FaEAUvFOzQ0C+SkzUlZcUYTN+/NrgpnUUJesJFyUUPCMk4EGUaIiTYZREGqL3E6vhg8klIWk09vNpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO4spEKe9JdRgj12wcWijTRNiRAWdhbaHRwxG+rLjS0=;
 b=PvsTdNBXydOkKg/y/g9Jmm+FQr+KQZYBUuJHLvVHmB/CJ9RuZiVZghvREtWo3XFq4hv1pWvYzkPCG9rOG6tGKpF28hVBfQwT0fNz8y4AmGC84zwjsrdmXIijyXxqpKym8RNUdcLzyS82UL+FrNyI52VJncEnzEt+cJS9fSikEwI=
Received: from CH0PR03CA0194.namprd03.prod.outlook.com (2603:10b6:610:e4::19)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 14:04:58 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:610:e4:cafe::1a) by CH0PR03CA0194.outlook.office365.com
 (2603:10b6:610:e4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 14:04:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:04:57 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:04:56 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 20 Oct 2026 09:04:42 -0500
Subject: [PATCH v2 3/3] drm/radeon: Match VFCT using initial PCI bus number
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261020-vfct-regression-v2-3-d2394d11450a@amd.com>
References: <20261020-vfct-regression-v2-0-d2394d11450a@amd.com>
In-Reply-To: <20261020-vfct-regression-v2-0-d2394d11450a@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: a202496f-af00-4324-407a-08df2eb31fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: +RCXLWAUGg6/EFLfkbzBeZs5Str/v5eLbghve4X7DPjNFwxF6L2GHzOGR6hMeK3JTQ2IYSo/+VGAtvSwGSMZ1jWLtvQPEAWETGg/PG3ZcbZYM5jHPsdlRbPGqOZpO+E8LEgAkCgR95paxpfo+4SOqiRfjoBVYar5kYSkLjTtWvgNtYEFtSkLHiR3M/nsLgoZKU8SZqrFzYSwOBei1s9coUxC+/qFyiKpUiLSg0zlMVY6UIE6bCH0ZLSFvz2ZiS6lRgIRCfzrNxdRCkvfChMF5+WRuHKvftSxZJM7x071g3HWZH5Ffwj42Y2lDsSxejIjjodDIclLfs8RNHreUvOIUu7HkgO6xrVgXLIpE6GvhTVtE5l1qiJybr3uEYx/J3mcNqhJzGJheZXMRtaZEmS6BSTx0kyLHcypJpFXPV4+Tmc48wQJ65TGJsLG2cvhbIVFpUUWgVK82r6tZhCTgss1W79L8QEevFal2asPqKEoQMSMC0IrBlG4AaINsJEHRkn59pmk9TLEVq5pZok/alyujKdkCTci4qz9lS1QFwi2FIOVjBiUtPbr7aktLmfFo8i18qQvhGMHHpRdpDVzCJdNqDyWeMiMT6KogoJ5ygteFSkfVkjBYVJccBeF8U3so+lAtQi052TWrUDdcIVeO9YO39fe+AXEzgusQBD8lj/4ZkUR5AXXtzyokm9REU9f+7WdRwwwnT3K2tpZJQUYG9yfoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p/yAFshDAd58NDiJThLMRmdmy6svxtobsgG8jOjxELxQMsVwS6OoZ7ad/SvbN8Fk6jTpCW5qfDrHYwUuQU8/k4DRonmHwMXfwxBTcqEK1/3DXKlgZJzbl9TKbPfV4F7hpt3v+NOxyTmcZ8QudF3c1923M0CNUdQSGxu250uVkYq40YXy0wWpT8n02uw4P+tHnubACr1EObGtAnz/f4ojIoEd9ZLUvcDXu/zQ8q015B5lBYHAO+L22DaZPGPmAC2d6wTJfqp4wfF/lSRHxM/EC2gvBo/3DaCWunkXDcjW6xA+J7EbHzdKPxe5WvUffWyiionBz0ILIUG5H2EIIt/JYGafgUUuSOJDdcmnZ3rD01CITRJEK2WAd+HZGK6EvybdOLAWyJj3rf0tmBQSX7fJsraBv4YzryXTgyBsL63n3ix55qFopXulnugB6JoDC6un
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:04:57.7962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a202496f-af00-4324-407a-08df2eb31fdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
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
index 1da6bf1c17ff3..88989c93757b1 100644
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
+	return vhdr->PCIBus == rdev->pdev->initial_bus_number ? 0 : -ENODEV;
 }
 
 static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)

-- 
2.43.0

