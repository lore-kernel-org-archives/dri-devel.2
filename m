Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0B3CA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4282710E64C;
	Thu,  8 Oct 2026 03:24:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j6ZkUi/O";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A6210E64C
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQQQJzAMA/R9ZJiYOzvEUqTsu+napdY3PYgNBn7gMTL+MtGaYzGT27iDukKWWb/4t1FdWAGNT8onncc2CY8kB026C9td+5W9mQc5G8JJYaz5v4pgpYXktINEdNToyXXftm6j3rbFIGNg5sYm8lh+tUZtftSqaN11IeTUGD/ibXag2Na0BdUON5N+49EpWlBrihXARVwKjXZQ9D6agV/D2iGnT0ygJLSgMxplDx5C1vB7FnwcNPDMxGC/iEbuNdu8JcSrN/3rDwL5pgilZZ34XEe9pVMP4IWfPbMeersVERxgkDlJBU+RrUdTUDWXpXwsa2OqmyBRhG/X8daZ9uXWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USEZ9Vq9X9/bvUoahsLbqlJDt9bC0WFukiuVAXa0dnU=;
 b=q6JBmifH5OkCMDOpx8oD+4gGY0zW6MaOtcvwjp/4rtFo3aUAmdhADrZzZt53wuHmUdPNpCNMRqlwIHQ2jPq7B7sDMgt/E9Ydi+vF5BZdAwULVqXYuVL6tBb+3BoF0hiCBWsKDum2QpRSEFBKQ8eZbiS1y5A/lddJMmzlWArOzeTLkd9IPnhnHOau0ZON1QtzzXj7ztSA28Cyw7Ie6O6ZTOwynm+p/Z2Jdyt0nRD6s7ht/aBalPaQqijRlAt2TRQ2R5vAXWSQRfKN3FYRDWlI+RXdJtVmJJ17ZNFAPYpt38uNwg2uDPSd7pw8kMV+NsKZjmqgPMYJZ+rSq0PTjy1Zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USEZ9Vq9X9/bvUoahsLbqlJDt9bC0WFukiuVAXa0dnU=;
 b=j6ZkUi/O9nF+4PWgAEOioQA8UL5BznZsnQPU7EobSXFu8DhLOrRjRDKkHMMlgyiXJLZInxMesy0Ns0km1yifmBIY8TCllIsko4tRKMzk5+lBQBcvtQQjjM/mGfvzNYjX0ui96nVAMuhwJpIPzOBNebUH2eSMiUKPr3rH4hnzlT8=
Received: from PH8P221CA0065.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::13)
 by IA0PPFC855560D7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 8 Oct
 2026 03:23:58 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::ad) by PH8P221CA0065.outlook.office365.com
 (2603:10b6:510:349::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 03:23:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Thu, 8 Oct 2026 03:23:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:23:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:23:55 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:23:54 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V3 01/19] accel/amdxdna: Rename NPU3 firmware files
Date: Wed, 7 Oct 2026 20:23:30 -0700
Message-ID: <20261008032348.2044667-2-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|IA0PPFC855560D7:EE_
X-MS-Office365-Filtering-Correlation-Id: 560fa2c1-f036-47c5-fe63-08df24eb9695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fr72C+ywsp91QyNgWqJxbEvNo4d6vo5yTq1R704SN0LBQLH+bCTlqCWSqVKknLV2Zl1ZEdks/J5zl8jBUHuHGwwPX6fKFBvr0mS8a3zcA6qzmmX5V6gvTrzqcxkuLOHHl9KXTYdc/6eAKxvphmNmYY6IhKtkdWkb5pjp9eV92XQpgsIfbS1LEVCwMnpQ6JokiQQhUyBkhG16abIGJEgd8xODTgJYU+MJmTkxs1BQGTXBO8ylYKh5nG3yTSrRFcJLI7OQAc8zcZiQ0W3ERAZLiNKlgPl1EKSGNuiLlhAdgVIKlckiRwx43t0Yxm/an5uQspn/14rNveCDNDx97PrLT8iKm0O4D+ECTMPmzW2k6IRTKkECcPPnjYyADWfKc2z7JrnJlhLVFwzksR+selK9Am54hPiegsLI7q0dJrfe8AkXemVzWLlavWsdeMigXwEFWlPnZgiolYRiHdDIRQeJSZbHmo5ixb5apz/b0z3GSurTXg8GbRT+y8+MBGlu8BAxP8ZWcj7FxVAAygDUbb9fJJBQh33XxerkFrtC0vPItxuiAF4wOOVySx2uwhsNi5fLTeJqnC9jBNulrOXJgR5u8tmomTCuZU3g1BDAvCJJf7zU+2rGZ8AQo/0gfICIOdVAKX8JNX/shFgIvie4oGK0oG/W5uRliuWECc6/fLZ9okg/mxXYRhBEmAGnAn6XHc3l5R5yQzoc22hXjGlykd95Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ntqOp4+Jup6w5ynnQ2g5Bu/RjzGy72aAxQEn7uxSvk018yHafmylBuSCer4/LkhA1hItJOLq2QpzXmTrTkU+FN0gRJPdJYvaYu0QcVBBLdNkXjvvPqVXp11dX7BwOIx5uLJnpl46+12CtAr5P9NedwN3j19ITTGHRpsONTvmOFxU8Xs4ctSGxmbYtL9ITJy5eDR7NhZ5OABg3XTCzc1u4VcXIGMgpKcswfhNHZpNKBFptFeoSF/VYEZ6gsOMPTGrZRQcIKpnlhnonzdBZrKKHOvs8yR0GuJAc0f41DChcEOIyTTi5rKP1Ig8Y2qbWRDMtBYISU+F4LgoNNQcHBmsBx9QOJUwXGGM5lIkMVFtMCet1e9khGjPcbM3dlF5FxBxiDbDdxadJt5OnrXo72Vz2ofD4Got9oGRdx1s2gQqrPLWyGx9qJKlTIj3L0g6wZif
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:23:57.0867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560fa2c1-f036-47c5-fe63-08df24eb9695
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7
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

