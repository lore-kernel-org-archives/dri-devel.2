Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454C8CA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91AB810E8CB;
	Wed, 30 Sep 2026 03:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DZ+G7nty";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C6010E224
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiJEZQ2YAO0kBn/G9VOujHww1wPjCL2f+6eOledYHMi9LTWJEi+rkb8Y7wxkLd4fg6TcSB5BLDHeAPIEjWD5/Wr3HfYKTKouAnWXkO33lGmWmUvJ0lIeH+M57ZzGL3LAHSnqlD6xSsapi84CilV8j6mzPboNFHRSrg+ga9pt5gPNjLqWUHtUwnhdb2J5oJndyNiKKbS9Wmtyhq2f3LWSGCQZ1Jv09GyeZNHk3VapCHcoEUpbfXEX5zuTp+YpztptcOX7WnFldh/plhwPQ/059aUwFibEs856Pj1U0xSlZJHziM6eqIY959Lju/DO/jOZ1evESsEOcaA6BjpY5OFJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USEZ9Vq9X9/bvUoahsLbqlJDt9bC0WFukiuVAXa0dnU=;
 b=UgaHTw/SaBoPZnxUU95qgmavmkNJczfvlbTLfzMFAYpcZZGec8nKtLR/UvVFNPVft55f5kdBX0MJOXwuU7wP/3lhNceLrgSri12/Bx6Hqmo7SS7hFVFhaaTQO5c2CKOzqCk3c5+ht3Mbi/WAFQVME3OMenHfUx88yfr0ZyUiPcbcCpvDq3NVLCNavwR/ahhc/3FMNoxPuP3HzxvLAHLed0d4WTOH1zG/A6ry2B3bXoIcIhYKOAY3AXElDQyi1tgGSyob6FK+Ayw74CxMk0bn2SN7wwC1lpMKtfWjAQJw/KGcoRcvWBXJ3CRNNsiZEx4F9pgwhr6HEUaY/AcchMxd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USEZ9Vq9X9/bvUoahsLbqlJDt9bC0WFukiuVAXa0dnU=;
 b=DZ+G7ntyWNGDc8fYEOAEchDErrhd+HOjUiGZYXBg8/wnLbt0iSigU7AxXZRG8L5TYg6kutNzEB8PSthsvW4RB5URWWQO84mQNItuPzstdd9+VqGCrzXadsQedXwyMYUyX7C+ci8CeFGUsG68v6mr3me91R8t2dACUR/fg34PjV4=
Received: from DS1PR07CA0020.namprd07.prod.outlook.com (2603:10b6:8:44d::18)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 03:32:51 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:8:44d:cafe::8) by DS1PR07CA0020.outlook.office365.com
 (2603:10b6:8:44d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 03:32:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:32:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:50 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:32:50 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 01/20] accel/amdxdna: Rename NPU3 firmware files
Date: Tue, 29 Sep 2026 20:32:14 -0700
Message-ID: <20260930033233.1727265-2-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: c63012a7-cbff-42ac-a9bb-08df1ea381bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: ISOlXmR+qXJ+sqJV2d0jaLkcH9IgHDsmubOV5G6focLlnQ4PLhnPbbSl90RCmvz2t9LP6Umpl7mY3a8Wq1E2jHT9DRdTaWq+ThGzFRG4+QV6So1W+Cgk+ltRZ8RZS6Lh8w/cCeHWeZ7F7J6fKlyL8uctN3CBQtW3K9IuiXgvxse+75tQCyKAQEO2ZFEBtwicCFk8qdkJpN1xqr6/z7EHqWDTr+wlcOJ6u5YJp9j1/Z+Sz7eAuZnxBkgWkKcXPHwAqeGYE+po7igoSfht08w9qGKxa89ApzanWpiiMa6Uxuy6oL1sC1fBYkBNV3VrS5M81Nd8rwYWWdHxZfkIKGE+J4cbseILn2WBUKOauuQkrFcLqdmbxavKFpsoDkoXst7qZBj/Tuu2dR+iyJpGONDR6QWLIwoayrp0cdBzKPTHnB9b9Jf+8LNyQJ3qbbqkGp6wg9SItAcaDJ7FN88Jbxr2Q3vCOaoaRpYtIk7iJ4fRqFxAWxUZdCfUk7de7UEf0jeBO9X0CUhGv2yKDkaZLnINssPZdlna+2qqRc7r4Gvi90TnSVK2TZMx0GHJw+i77yEbeCWaAANZTV6yEmAj390yts+viGacpLDkqtyNawuIt+QbbKIaCUVuU/8vGHrCmIloKpA+SYuLhK3FmossL0W3IR5YO8K0Db+w54kPNcbDlVgK6W44JWsWOyeoCQCRTr4wwLo+JJq7v/bCFtaymKoCag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nnqlh5HGjJPm+LdaS+dcRvBxQNB1Iqtco9qeB5Rm1l83frJ6OZaA08IvbEtgZkKpbykkU+Ihs1w6O99xwfvYDxxK9eWNAm7/5g1tpvTk9EelexZli8TYgzbkVlhA3wUgcsIhr4Gdzoli9UW3Eva10M/67Agoc/htK+Znxak0AbR57OVMtxVGhk2qbjnhz8XiGlCuHTvy8i3bGMtyNtKnQusjDSeeQe05nIV27dgAKTawhmXWOh4dCF+TqqAiXWUezVUD/dPu8yKN8Lrdm7AcYmpy6pt6yz2yiTF2IYTMaU0kahGTDJnNliD9a/XxTrWtYkIh4SCt9yosiGoVu7BxOPdjzwEPEXedIYP0QiLEPo0ruv+P0MBkFI1eOs1I+qlaFOGWpAubv2qoI5lAi3pddjop8zY4WitR24PmWM62hVS9nIzeCch6vDGK041A86kp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:32:51.4309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63012a7-cbff-42ac-a9bb-08df1ea381bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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

