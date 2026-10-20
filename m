Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE6606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Vnsy92Gd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3EF810F4F3;
	Tue, 20 Oct 2026 14:05:18 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D5A910F5F7;
 Tue, 20 Oct 2026 14:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElHoM1nHOHfHyxe8uMsSz+n1OzQBhPs7VJLM2+6siq9lVWvudKerODfnOd+tc9D7ulSJsT/55eKHggdVeku6kOkPqzOQ19YQyMeMBVrJ6o1H0AdxG3QuInh1cX/pma/eCyV9UxZvHoDMiQgqgWELazEXlT2xGiNYyxqDpRPzv46Ieu5WQ9YwmJoQXvHaO4mwhXP3Khw9uiAlzt3QPClvoDigJ/ROKqF34hYjf24zcV4ifqKkc15oX4WKBFwYoHLnOoNoTHrqS1zc+4t674WABjATPLOah6KZN865G30dMtWW5v664IvRPlxUx2Pt7v1dw4cqHB3iab1C8vw2/LGVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96u6dN83pudNMD23xsJGIQXlEUMc1OuvAtONo2iq8Hs=;
 b=F6GZzyClXtL+EIlrCmtKNsNHGf4t9xRY5ik5w959oa4FANl/qLlLIhV4sptSCUXA32NFIDsdpO1fhnfh70GpXNUgrTe1lpUax8Gpo74Y95B9mVmiLtZljUqrc7xMGSeD2qh5aSNzNaKieDqyvCmMIeoKdINKb7A3kiy3eoNH6x1SB/3DlLE0Sc8ZqTwyBqrqUo/UqV3nIN5FVPtiyaEGi6Mp5GCrk9cVKRf/AbbymSU368vnTUiwlYb7er5H1gA5o1k+jvBGIVLrgzqIa6hthwWIeRZrf86AH+6KiWdAWQAO4kGGUzjBoOhV9+Q8WhLxtV+GPPEPYFMYXUysXqYTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96u6dN83pudNMD23xsJGIQXlEUMc1OuvAtONo2iq8Hs=;
 b=Vnsy92GdnYTRIoRGKs3/VPEd4YUM6bHIJCJ6/VxMi75GQdw2P5hULuwX0L9iiXxZun954BR+c+54N7CnS6pHZ7kMW3mAIicR/vFfm93vOzFzvYiCoKC7dKJkefG90dxZ/xA7LFb6O6yMwtw1U2vtQlOxR+6Vxa5qdrDSXkNB+7s=
Received: from CH0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:610:e4::27)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 14:04:57 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:610:e4:cafe::14) by CH0PR03CA0202.outlook.office365.com
 (2603:10b6:610:e4::27) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 09:04:55 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 20 Oct 2026 09:04:41 -0500
Subject: [PATCH v2 2/3] drm/amdgpu: Match VFCT using initial PCI bus number
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261020-vfct-regression-v2-2-d2394d11450a@amd.com>
References: <20261020-vfct-regression-v2-0-d2394d11450a@amd.com>
In-Reply-To: <20261020-vfct-regression-v2-0-d2394d11450a@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 32365f5d-02c1-4162-a2ba-08df2eb31f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aQG4OqtpNlFMtBI3xdq4xLspA4G7igX890JsNGRTXJgO21KcI2EzDjANT+wF2XSnZ7XkdgVrzF982K9FaIg4pYEnWQfgF0YiEB4jCg8T6piksUK9pEjzKN+1QK5vXfRbd0llIgzwubQQNb+rLQWJhRQ/Uawp7eNQfgLLYFLUYLC6DSssPbE87vSfwXPHt2vj4TBEnBGVhAmRHsKZUl6PxuZPZLTqw7poEWhrq2DmjlRxn8ga3EwF0aEi8paAVl4GOonpO5zwuSARIBUGi3nLsDg32KR1Kjxch4y+MlScUQXfSLlYKS7LnaRs0/VOJZ3KkORjBW8pbR/YBTE7bxEsaktJ/CVWDnwvgb79NCmeBUi+QvJ/FvFXYGXCEzF6lmjoxJ7mUk7j07lnXT5bxLdZk6mmf8kYgx1j/DHKXnSbiyn/Jfy48dbDXlxfZ+w8dg5mgNrnLiKWLS6gxM2KOXCFAgIhY9cJQAp78/YPi30n9SVYH8wS9AnnkQxncITpQxw/v/KdI/QIcbUfBYYS+VUQUwhDe0Qy+tZsJRXbvrbHO5D8BEOu+Td13+Iz579+MMQqKM9UmJEc7r+fz4s3lFyVeNQmGkWPmYpfG0BN2Fo0+nonGVQ5f09FHA55XVcu17QOJfQ5jP/63D2ltydK0JXHdYYUZJPndcMsZIkBJrs6G+I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LOEsLVJyWmwRGCsPVTENbIVqZZXrNu2MjG72OOYNxTZjbNOXD8WZKB6KoGkapxyqh37Q5qHNXX9QszThKj34E/aJd9uiNk0OXkePzrj1AAyr34shRjBOx3mm2jU9yk09bt787XMrAvlC8p9x/xDIM+qQPnBGS/ICf6NB0O9863zUYrSYm1i76WUdCkXXCJskLrtHsmNuYZgh4EBahWK99sI4P3i/UcCImmf1klkaFUhq1twfiBt3i02J2EJ0OO+bBk4EGbgqS47g+Yc2SghFCZQaXnZYG2Mz6Gcz3YhPxiGU3U0YfJpA3c1AdWts1PkWwJlNpGu5P6yaDad+L8d7DoL1grhqKiQAt3sbW5LcX5k/YON97Ablf8vwLJRQqGsdKLiurArOPXEaplwbJEM+cMpU+ex3r/npaxQIWMJcGuCf0HUh5Qvp6O3G4LZcoh8I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:04:57.2161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32365f5d-02c1-4162-a2ba-08df2eb31f82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
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

Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 08ed1eb695586..2b375e6b39d5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -386,10 +386,8 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
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
@@ -405,16 +403,7 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
 	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
 		return -ENODEV;
 
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
+	return vhdr->PCIBus == adev->pdev->initial_bus_number ? 0 : -ENODEV;
 }
 
 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)

-- 
2.43.0

