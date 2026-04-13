Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CD2F531C1
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5365210E4F0;
	Mon, 13 Apr 2026 18:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NGCVlB8Y";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E1510E4F0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LudatK/T48w4A9MNebyrMAMTRklGhGEeqms2B9+ki/bjI80nGYYrFA2YmwFGQRmTFIb9FRBhRwMdltwJPOiv46OccdOsL3xfqosT+vV+X90u5vq/AfqkBGLsBmPYsxdJGMH9kR//Gqehytq8fScgwRltsw/XGafn9WuJOFE+7GYwMjiOPkNiugQiZ2XtmAgR0MP9S22G3uPvKVU4IUe82obV8LkmdFubi+Qd+Lq390OK2x0Mk7E+IqlmxCkF4HlUAZGnSmAOsQkMvdajS4nPlEWAuVBetKN06KZSLFud79Hgg43TVhoPdwz9WwVvTUWm764uL1GRS26FNmy245gO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxvqhdSmypCcP1Ru5dPB7hUhJTX8ntYISQa/gQVVKyQ=;
 b=dFvcpN5NLb5Q7AHXcefXCC2ws027bp1m5gTNPfBQG3Z9H1wj8qi5Gw00r8nBT0XNOddILED4XGTd7PilFhLFyH8ZJCAft1rAz3t6OmhuvFWS4/PB7BqBBdSwXbDhgPVEVeno5zQ28m5Xv0NUicqpE7ma0oNcAsyEm7nK249lX/CjhFGlKNGJDJPayyusjSW6U5DSELTTxpfKe/UBriH/z+F6YerlRqNvqgBY3Xdq35J/CQc6sVL2TJ6LVtwmmu/mbNvUGki3QKXz0Uddi556j9U7y5oZ27sOfpf+38LwrniqMQ25xf4nle5tkPSD6aGrit0EQCkZxKh1GjhwX2Z8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxvqhdSmypCcP1Ru5dPB7hUhJTX8ntYISQa/gQVVKyQ=;
 b=NGCVlB8YGb4j73oFyoLJ0J+riq02N/r/0Zb0lbLX1Lo7EhC8ucXltMJ9tW7GoEayRNjVBagv61vMzUSbEw3LnNrUAAOZUYDytvBFuxW2p/IjKkIgjBLFVPoEj1cjlTY6EPVrOgosUIJazO3MtFfqn2nIs67kxm+AwLfMJgTQv58=
Received: from PH7PR13CA0013.namprd13.prod.outlook.com (2603:10b6:510:174::11)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 18:11:30 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::4e) by PH7PR13CA0013.outlook.office365.com
 (2603:10b6:510:174::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 18:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 18:11:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 13:11:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 11:02:52 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 13:02:51 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Dan Carpenter
 <error27@gmail.com>, Wendy Liang <wendy.liang@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix iommu_map_sgtable() return value
 handling
Date: Mon, 13 Apr 2026 11:02:38 -0700
Message-ID: <20260413180238.668441-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: eea09407-9d4a-47cd-41f0-08de9988167a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Xa3IAcFwH7eAdh//iuwJ4Nrw7M0oCMfv/ehaVgx56VtfnpZrL27Mr2o/NzTeU1dbc+5Nw7nx6eKF+x3jcK45v2u1BdM/hZdQXIeg2EE6btZlq6BveD+GKmOE/V0Oe3NWSfrb1w62TmtNLZebACAsW/I+AsbL6rjAyMEMdZUegW14AIG6J3VetJb+2xVl+oGcXBsAYrzCAOevTaaw4v3XQSSmX9too5mBLunu9qry46syVoRjrRpig4TteOy2FC3l3iui93VXlbIT7dETmhs4iJf0zNSVnf8RBfubjqDFZFEfY2TaoHEOQZVAJOaSIJo/wvG+Ql8WVUdyQhNd0N3IxJGDjU5V1bezrmph+nShkR4Uh8i9l5iJGr+MfGzF5K5N5a2r1ZECfCT4ZHRjHgQCEgp7LZhvq56jZpWuwLuhMezolanIBZ/K11WRQmpGrIHig0J/3BxwyX0VmkJvXZZX52LBWlobb8/lHicVmtSQwk0QwEoevkZzsotf2U0t3nTiXZfdOIqH9onwAwFOUTuGTQ0MtzQGLh4ztLUvU3h4BFPxfMjsH+SQAMtMaTjCdJGOwarYgP0kV6pq9/pCxScZcPltRL3A/T+Y0KTG7KFX8fPM8ZFVqFRd8i4Ml7GOwdb+3lBG8ngfUIJN41vwDjBvCbbytnLfQgwa83nCesKp/6ElgQeOx92VvSFSYLewvrAFijo4UmbpUUHr/apg4Z6I9k43Nsis/VgezDHXLHpdEVfZT7JLJimnySy9CHGj0u4WbDXDzXWUxCH2XzzJFxeh50JbDJ7aG+53MJ8cQeM+rGo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qjtO01zSFUuAqh73+uh8H8igtA7UEtUHbovC67Jnkryz2XA7iyx/uiC53wV1gXGfZMUR16MYv3ciXxESZQrBsAmyImEXEQlEzE2XdwIKegJIGOC60Qqsx6YYkIvcw3TlPraFlFZXZN26Ms4tP+/kEuNeMUu8xxwYw9gp2J+Kh2wgRaZHW6yijEORGbZsnSe9V4/DrIYMoxo94o5kUuXbZ60TuyH6ujskJAwl6hz5d3+fYaaqBfXSdcR51Bf0AlgRaqvatVxYxi+k9H5Ny0H3MDhdKSgsT3p1PaaHrATYyKDJaow/0MXfO/n8Cx6aNXUPlZUXfEBK/CfRf5TiJts+2HW87afZcyT/cUYlcYbRzO8WflghaxnFFQvW4cQOIgyCRn6UAm0KRER9v2jEEFLqCiZGNjIUL2taTElSd6z/31DwWbRTVYBYDT/hFOeZuyg+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 18:11:30.4024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea09407-9d4a-47cd-41f0-08de9988167a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
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

iommu_map_sgtable() returns negative error codes on failure, but the
result is stored in an unsigned variable. This prevents proper error
detection.

Change the variable type to ssize_t so negative error values can be
handled correctly.

Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/all/adk7kOUBwIyYnX1M@stanley.mountain/
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c b/drivers/accel/amdxdna/amdxdna_iommu.c
index 4626434d4180..2676cfcfabee 100644
--- a/drivers/accel/amdxdna/amdxdna_iommu.c
+++ b/drivers/accel/amdxdna/amdxdna_iommu.c
@@ -40,7 +40,7 @@ int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
 	struct sg_table *sgt;
 	dma_addr_t dma_addr;
 	struct iova *iova;
-	size_t size;
+	ssize_t size;
 
 	if (abo->type != AMDXDNA_BO_DEV_HEAP && abo->type != AMDXDNA_BO_SHMEM)
 		return 0;
@@ -65,7 +65,14 @@ int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
 
 	size = iommu_map_sgtable(xdna->domain, dma_addr, sgt,
 				 IOMMU_READ | IOMMU_WRITE);
+	if (size < 0) {
+		XDNA_ERR(xdna, "iommu_map_sgtable failed: %zd", size);
+		__free_iova(&xdna->iovad, iova);
+		return size;
+	}
+
 	if (size < abo->mem.size) {
+		iommu_unmap(xdna->domain, dma_addr, size);
 		__free_iova(&xdna->iovad, iova);
 		return -ENXIO;
 	}
-- 
2.34.1

