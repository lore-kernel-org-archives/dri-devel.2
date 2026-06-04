Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E156CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8599211A2FE;
	Thu,  4 Jun 2026 20:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GccWVbNu";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02CDB11A2FE
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laDJ9EV7t0mfijf4O82qIJ0YJ3pl95DSMPRbEQpLI7M76QdKb83T9ED9Wa8tyc53dBNGYJy4VWsjt9s2eCFpCPt3GyYmBq8lTMDmKBvsoUB+hpEaMNYhE1QvZ67ppWC6XSo6Cl2G8R4Is8V4yPKHe2aUAxKHGGJIm6sG0V509geapGjg+bpyHOMOFg1ClQNKCEFegU2jxR+FsCMDF4FcZlZvZ3VeVyi+yc/Irewatlmcb75DpZ6wTkpY4vGHd62OzpST0T/5y1V7Z+u+2zTkOr4axIpkGlAIQ5s74ym4kSHpdFqGoCdvQDGsy8GD+b4B/veOGHA35OaSMP0gm76tGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBIOrAdrAIXUqO6QXMZNieMgfp8YxdLGcw8OXvHHDBk=;
 b=H9qFAWccH5ZCR8Glq3sczactKEXG2FRCwD8kKqTWBjADfJLgYRVnT222hH1JfxzXmeaTMAlw2dbuElEuRcp0kSeSF+/A5XQnxaYEXHYl89EA7letPBh37uUpZW89/ZyKkyPw7LVyXVc7Noluk16Db9wlg1ThMgCKc0fhJLy54Smg59SIh4VPlURWv37gZf9AG0F46Nh+WJqCWvNVxUgz6Bnimc6hKrUCPhGDK9Ceodp6d76VL4j4B6a66VEtYK6Lag7h/WlSIFfPlCuwS56p6WRmyldBXKJeWw9qyA9746P93cHNAr9obis45Zywl8/lIjTnJYeSJhumUX/dW4yb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBIOrAdrAIXUqO6QXMZNieMgfp8YxdLGcw8OXvHHDBk=;
 b=GccWVbNuF0fXMUDSRMkqDZRMfai+IuH7hTvGudIx1JFeYbzmlm+j19TSmycGl1D+0JeTKwwocDkjxVKKCs3PIurUoOy/5hL77LIxEgH+O8NQrlwNICEQNQ+CP2mRFH+2QOaBVvY7DWAS+9GNhfiPWOpDFchJlg+0R2amwmYFw6Q=
Received: from CH2PR14CA0019.namprd14.prod.outlook.com (2603:10b6:610:60::29)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Thu, 4 Jun 2026 20:28:18 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::86) by CH2PR14CA0019.outlook.office365.com
 (2603:10b6:610:60::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 20:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 20:28:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 15:28:17 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 4 Jun 2026 15:28:17 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Clear sva pointer after unbind
Date: Thu, 4 Jun 2026 13:28:15 -0700
Message-ID: <20260604202815.2425882-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: cf30c0c7-18cd-4254-ab1a-08dec277d027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: aeSjwmlZcQ/fDgN2jqgMxMp8m5K/7AIzvpCxmZDhHga2Xj8GSuZ36hwe/fKHCwKKHPi75fQaRrRsRHApllxcHcaJN/81pY4RcRnrtR4oQkPfOWGRe2tPtvF5yGgc9Z6ybKoEYvqJW2kDjf7233rFPZEcspgfRQN/WnTgvY7utvQZU2a/ojrHMjoukKwuxnmuCL55FJR3oYH/vwvniL+7dEoOaM0k4vjfMz+Lgucahz+EvwAkJePgQzeM7EEPSzsqLZGVPefUcDCAC41oDmmZoLbysGXcyicy2CmA3C7Fuks9A5/MHivGcx7mb5wziQUDUQxOmAdxIKxGDR1QHTKt6pwnn4q39b+2aHDEvMnfCy6G3esgKYcoBvjih/BIxRXHuUAKoiM/dDWV6hQ1wEJ+ErgAMoPogQF9fXEURXKzkvrpdvHIWHZlTyCJ8luSaThOTQxVXYTDDTRWKJTXHtUGJyHWbWoKPRZyY0GAgDRZZDe9KecuYtul1STQVhJgIOMuvm/ouyLcX52B9mxrTuCeCFvBiHqH4A1A22tgEQGmP5EiXp98OLN3gfTg4N9O0jk+accz9Cd27Tkw1XxUELY/0x3r5si4rcIZGJdKHWfsAA5Pud2ihJVODJ6YMFjsXkHhqL0V12OEw8ypoPNCB/gOX+MjEFqFjzqoKJy9qsTqJDx8RP9mCdcCjyRwlzemvUUe9zfR2crAZMm4dGmEKsxZ66iC3gHPzWXaeiCy1UBqycM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z7L5AJI5+0WYuxy3k1T4ZX/18ERUOFsLn9clSS8RPSllttT9XY4g9jtpUTL9iPXCHUVZDP5bP3vPwEP7hXu80dXfptxJnwnfgqfC7ePIjSXMv+YtFsDEUOuVZbmNrdrlHxs7uJ+HOAvCU3z6HLLz4b+Oslzk2MRyCmiDTSaj4XQKbrAKa4zWnI72e85lq8aB0+9dSKH1XgPA10w+Z3uJOsmu1XqgcPT+32oVQn8qm/aJ0+WGbq0tGVM4bw1YJmFUK4DJ34z5wWyzdwIAD5GZBKXlMTerkRFH2SMx1rGZjf+j6jYupGPFKr1ebRYjMS6zyTT/BQn1n4azOMOAjRFCk4Ir/VHcpLGVVS/NghpPaCGqun03hHu7Z7u9CLok9Z49brtnM7BUyBc6XzTNAMjgZ6vF+IBouUz4ohBP6ut4h+CEE5XodbQW21NrK1QlSco6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 20:28:18.1688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf30c0c7-18cd-4254-ab1a-08dec277d027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
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

Add client->sva = NULL after the unbind makes it consistent with how
amdxdna_sva_fini() already clears the pointer after unbinding. The
IS_ERR_OR_NULL guard in sva_fini will then correctly skip the second
unbind.

Fixes: 3cc5d7a59519 ("accel/amdxdna: Add carveout memory support for non-IOMMU systems")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 1f066ed8d236..65489bb3f2b0 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -87,6 +87,7 @@ static int amdxdna_sva_init(struct amdxdna_client *client)
 	client->pasid = iommu_sva_get_pasid(client->sva);
 	if (client->pasid == IOMMU_PASID_INVALID) {
 		iommu_sva_unbind_device(client->sva);
+		client->sva = NULL;
 		XDNA_ERR(xdna, "SVA get pasid failed");
 		return -ENODEV;
 	}
-- 
2.34.1

