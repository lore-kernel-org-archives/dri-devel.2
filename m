Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEAACA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966F210EF70;
	Tue,  6 Oct 2026 04:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ro5bDBtg";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD1910EF70
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWWs+SlbU4hQT43oBtJwTLi8ZbxOIYVMMq5tDLMJRIHINdpxBx5GvxYWLowLSWTaJZ/dY7+reyA2k8v8ITJYaG0GuRI68gRih6GBnilMO9CE9VHGQ1h8dlDhxuiZfxai3d7TjY4oZ2KXpewDWacEYblmpZT5zIO94Es0IZbmLZcMwRHOGZ2gytr4mYUYcCngj9vlCBLIPTDQYdTbVxJCvmN/wmICpOCi4GhNuLA1UFs3GuASMpAb4e8SbIMygSdKTgl/wIWTxidGO2560o9LSp+4K0QLtBLVux/gYaB9qMfT+AuM++TuEQVrZfIC7lg1q1FfOCPmwnySiTJ9TBELJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USEZ9Vq9X9/bvUoahsLbqlJDt9bC0WFukiuVAXa0dnU=;
 b=SBqqFsowM8CzvgBPm4nBtlqq9NYGAdQscmDJz2g8l4cH+vVjUroFIgoXVK1U9JVbUphbzUJZLq60ISw2/PVxkjLOtnr2iNzibZMq8eKerimyWKpzMKwvM5bUmOP3B0S0byws9w73qaNT7H3M2VO6gCaLFasju5aXOKsnJFvL4g3TIPZOwE6uTp57y8J52samzirPlyoXGy0UliYbUqkESeMuXfIk5V7sJosFFU+V44Vodkm9nu5bthaJ0wMwCXHNKUxQc9ztDSaEsbvIsB6occtsWMZY0xjvxWlRyK9vOLTXXiKjhoFbJBLc4CEmf5RoSa9USdT7xnD7+s5C0W+WVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USEZ9Vq9X9/bvUoahsLbqlJDt9bC0WFukiuVAXa0dnU=;
 b=ro5bDBtg9KJeofnU4YHzJV4ixUrWPp0qqrlzCsbtEgyS2kgCGVN1ZG5TUmxNGSl0e+EMdWx2MwtvK1xwmNbm+WCsZFMP76XDNESR6bdY1Y2iAgWR6W30QuubCbqOA84nprq/AoiDs0Jn2YhxTkiZ7Zm5reKU+W8cAsDiQ4nf1Mg=
Received: from BN0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:e5::11)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 04:22:47 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::84) by BN0PR02CA0036.outlook.office365.com
 (2603:10b6:408:e5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:22:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:22:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:47 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:22:45 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V2 01/20] accel/amdxdna: Rename NPU3 firmware files
Date: Mon, 5 Oct 2026 21:22:11 -0700
Message-ID: <20261006042230.547807-2-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 79400866-826b-4d9f-9a41-08df23617a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qo9lQ41Rzd2KXJGs7TYvO6eZ6KOR4hH2OWdYcT2X+QV5658iI73GAO8SeZPqRm8nfa2nJ68g2YjhnE+GagMCNfbVjtUwVW2fgoHvD5yGPotBm4qmarko89fzQFiSy2PgIE9JbeSsCEvyYfw2sUvloLum6cPeTgPNBxj8EiKhV+zmsYQSMg8gJSgSS8mk7xJ5QgzHnd8GdB0fjxMINfpwR84MRQN3hq6pUPVY7fYwNNyJPJ1Izw+g4ABpPhmiM0LV+/ubqqcw3AscXEgdQiMAs6zb5LxNuhJMMgwHEbhQusktmTjrMlHVrNzLzbzYKuqfKydYKZw6+yYtYon7+Tvl3cnr0EdRlmNj4VJv298tOcfGm/+R2sWarPnWUNALWcnVZm+u2JhfeAPJmyL79FSOL0B80XeqaP9Bf6FalKJmPUhEiEG+8as3U7XPPlEo6gP2qB1JTHK9fYOWIzWtMgLvV2o27L3MJwEnp8+3HlnFW6fBbFnowIDpnh9llC9wGJC5G7FklqwY40bO06GPJyplLBiVLePgGQIfqOSd5rhB90e81EVS54cyA1wRDi6Wv3rPtp8lPN5gs8+8rSTDXzD4/uccrQaRAGti5rbmmk6Pi2490vq8yb5HAgxIVOVlyK/pHrkUhjssvMTvmwco4oCHG1SItbbLl83DPiD/j1vcpN8FvtYl8ce4bSuNkZr89R5VJJHFbkkpQ9BuBqTQvHVFFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZwxjVUpIBKmI5EcAhetVOAQ34KLDTktXg3QYFrsRamR08n70l/Jjb1uH1/J2euZYHwILJ6/wun4v568iJR6rqk56ckEEheQyEve7w4NEXSnmUsBDnwA9odBoDggvmWSx+Nvji23Nk0ct4SyCMxqf77cE/bIJwAtpln2ln+mYY39rft6T1y6coq3JLpfZAv6Mlk/sr64LLYDfPUXzfRx5X9/UJ+d3ktzbHgal1sOYMfh5PK63+RE/xq7YzMPjbB9UHz6g1gf7MoVCdgMIby+xlaccMLFQpsRr1ZWmtmZIDFFPQoiiyQr6RSsCbRI4mJZe6JZMRnr2we6rejzJMZl0JEF699gPJuXhBCPb1+KDvUlanXqYBOrkMnyXL/JRFHbbCxT5FXntXvgIEaB7dSrpjy+KJPBdvM8zsieqnQAfneVBxbFO0VB34wy2Gc4cu1lc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:22:47.7270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79400866-826b-4d9f-9a41-08df23617a21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
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

The NPU3 firmware files will be released as npu.sbin and cert.sbin.
Rename the current firmware names to match the firmware release names,
and add MODULE_FIRMWARE() declarations for the new 17f2_10 npu.sbin and
cert.sbin names.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 2 ++
 drivers/accel/amdxdna/npu3_regs.c       | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index bb339e641416..d9e2e71d3e05 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -28,6 +28,8 @@ MODULE_FIRMWARE("amdnpu/17f0_20/npu.sbin");
 MODULE_FIRMWARE("amdnpu/1502_00/npu_7.sbin");
 MODULE_FIRMWARE("amdnpu/17f0_10/npu_7.sbin");
 MODULE_FIRMWARE("amdnpu/17f0_11/npu_7.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_10/npu.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_10/cert.sbin");
 
 /*
  * 0.0: Initial version
diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
index d76b2e99c308..8d287ef32fff 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -43,8 +43,8 @@ static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
 };
 
 static const struct amdxdna_dev_priv npu3_dev_priv = {
-	.npufw_path             = "npu.dev.sbin",
-	.certfw_path            = "cert.dev.sbin",
+	.npufw_path             = "npu.sbin",
+	.certfw_path            = "cert.sbin",
 	.mbox_bar		= NPU3_MBOX_BAR,
 	.mbox_rbuf_bar		= NPU3_MBOX_BUFFER_BAR,
 	.mbox_info_off		= NPU3_MBOX_INFO_OFF,
-- 
2.34.1

