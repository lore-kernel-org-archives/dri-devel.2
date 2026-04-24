Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E143FAD41C
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C1F10E26E;
	Fri, 24 Apr 2026 04:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1XL0WSWk";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ABBF10E26E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 04:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4BlCz+dh5L/rTVaxWW9HoULUCvGpWlumYkqIZ2nCC3e+zFXtx1XzFT4kNqTMTrWIF/GdrODoSY5gCXe+VE808ty19R9p1fRsUe3LX9t9gkBgpcf4ccVbRfyst1A1ljJBxWjaa3JqsucIriwCOZ62iFlQ1JI2nUlvnr3MUcL11X6DkQ1BKtUp05ESTGzJEmt0P+9EBjbNz4KNM8pTxzSjfuxMhkYpwZItY611/CzJnPsAkaxR2NOhW8usOyh5Vwiq4+PtKSBU7UfDjA9e5GL1ZJHYOQmE5M/67NCZyi4PI2oB6tO20cI9sb5p80fQnf/F6a6gDbZ6P5rLxhlwYiBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7eR0z7O9ua8N2Kaa0E+pzblhRmzD13pYlwxMaqs80A=;
 b=Ti//81g2TFWyNGAk1NrSc+fevFzuOg4VB8CAiXxi42kcyVRqCqX96eQxWOS2HW6Gece5pwdrrFrZ/jDL5mfEutwpsJVa1C46mBNdEpTJtu9ZfXp5r0X5G1Wr2RWgnD/pfjwJ6nkyPjvJ6/fL3KcLOFenpiGo1T6tSvzSplEQ/f78HvmXXdjRGYEjMz21Exb2gwJKK2uUmy9s3LN7x4/ydZ73YzLs9i+LkOouptLMTrHU9HCRu4hV2/tzDUAZbRoYepU3zUub42yU8eef7axfXKJUNAN5mWVvOCZYYt0JjLbWZkSwxNxdwSudgF/giQG16LIII8hJRjdgfKrx3amxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7eR0z7O9ua8N2Kaa0E+pzblhRmzD13pYlwxMaqs80A=;
 b=1XL0WSWkCrq1KJHTiRt7EJzCMYfijbU6vgBTWth5Jr1SuriimOO3KSanc7M6Lq1M0FybNhOvbbPYSmaUwU68vGnsiBjglBD+WQJ+M+AyPuOUodeuxdnWSUcWaRCAMG+DcBGr3Y+sDhc1BUKE/azowpAsPpTI6HTjpLATEPvPwyc=
Received: from BN9P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::12)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 04:08:35 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::42) by BN9P221CA0004.outlook.office365.com
 (2603:10b6:408:10a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Fri,
 24 Apr 2026 04:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 04:08:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 23:08:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 23:08:33 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Apr 2026 23:08:33 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Nishad Saraf <nishads@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1 3/3] accel/amdxdna: Set the system efficiency factor to 2
Date: Thu, 23 Apr 2026 21:08:24 -0700
Message-ID: <20260424040824.2253607-3-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424040824.2253607-1-lizhi.hou@amd.com>
References: <20260424040824.2253607-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: a4762faf-5753-40b4-e45e-08dea1b727b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TKXTTuJVQiDdObVcrX7nsOLVJgiRvica7ss3/MUzaeq72Brrido9ry0MhEIXppiuvTGYp93vfgzoK//86IRLIzZipHcLb7eGS3QCMG/yhCMlzpnDknENWT6XWxbSz8ExBQnIUCT5FObaJc9LGmz8wciEFj+GRRsE/VFZkCcIx1K2GZGntJRcLTCvetYK9hT+vE+h6yeTsoOa/QtelgujobzggZirO2YoFBDwHsPs1BUsUebFYJaRIrdCGABWglSN3l/U2kltV6wvr0CR0m6YGaHDPz9QnVmggQaBKLGo1B2vzYH4baTX3gvQbbTeqkolG16XRfWTPoum4+cVhrUu4k+L+Og6qv1o2Gj1aVLVwxaOI+nwb6Xz7feVHDxmbbPCCaS5YjegLXAJADlJ+/i0/0Be6k5P2PnQj572yMSN01emiWj4D0o4n6V1gB0lf6oNyhp/1Ns+vxSB+hrS55sn0zveU1DsihRoo2VNuixz63BYwH5PTmg7pEZbU8QnGuEcKdejFXycCPRS1nVGzUQuh+wq7LcClDyUIOI9N/vkueHbOHFKZma56dyQh/svA3OaOqr0nJm6oF6HQSJ5H/D/8gKpa98JRToMdvc9GMAa9hJQ0rQn1WQW6rV1M3u7aHU9y4RlaRir++ks4EmK693GVIFCWX+P3TQdZPZOR2bjkUfxI53kqA/vknx55fCeTJKWD22TU+PyjYxbSXO5jpG6Ms07lhR4aBQHLMZFMr1jL2xhlHPKB0OMoCNVYPLfMu5MHR0L4XVR/LBRTCQGTGU1EA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NvGTtw2KDqRnDU/PAA8KZVX82ZWJG3RkqRSKgUwi5bc32lJYM3FTSGnmHQCfM2La5wdAnE/wzmqpSB5QeSC5WEIXmXVUXeIYOBjYXIbDtY+c6to/0aZpGrhiH6ttKONZFsdZztXMOAKnaSOoqa6YIL60/2at8SM76xUShXFOZiW/cb4iyW3FFy4JzlsuSkh6nlZXosWWJPo2+ojB2xbsScKakT1+e+5EHkFPGSiulBFdaq7mG9qP52xmR2AbNGFctI3Zoy7FXU4qFJ/muzzr1404er3FBmEmrPKFT+iW0S7Dt+DbBIU9CLsygS4ylIF5DxShQR/DdDpFptRg575IOlUhI0UvP25Tn2anKljXQTRJNAVHQRHln213ZnFeO7wKEMj3uAsKeHOz3FWobQqyepm21R5pudEhVOJ9NdAYre7tMrKY5CXPY8+LqvtfNK7j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 04:08:35.0178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4762faf-5753-40b4-e45e-08dea1b727b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
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

From: Nishad Saraf <nishads@amd.com>

The system efficiency factor is used for QoS calculation. Change it to 2
to account for the efficiency overhead.

Signed-off-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index a07e453a1721..f0ddb843eb21 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -595,7 +595,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	xrs_cfg.clk_list.num_levels = ndev->max_dpm_level + 1;
 	for (i = 0; i < xrs_cfg.clk_list.num_levels; i++)
 		xrs_cfg.clk_list.cu_clk_list[i] = ndev->priv->dpm_clk_tbl[i].hclk;
-	xrs_cfg.sys_eff_factor = 1;
+	xrs_cfg.sys_eff_factor = 2;
 	xrs_cfg.ddev = &xdna->ddev;
 	xrs_cfg.actions = &aie2_xrs_actions;
 	xrs_cfg.total_col = ndev->total_col;
-- 
2.34.1

