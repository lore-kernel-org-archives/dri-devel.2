Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA440606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uV0UvZDs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24DBE10EA8A;
	Mon, 19 Oct 2026 16:48:03 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CBF210E6E2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJ+oo9GlLgO8wJ1bC3Al/RMAraxfHgj+fRPgPAuAkFzJqObiKJHCxNVIxp93sxS6Xq8e4CWV1vtovnDVgoExi9qnxihW5vLWlhdG4wdDzYmpv+2i9g/U6CK7IpbuEQbomhyPNTLnQ9Pig6bmg3gNq7htXPkIN3HQ9VjTMRsv1iIVwKA774ZShnXxPXR1+fj2nU79PEfvamvzE+Lay293h3/nfuYCzxti+VN7ZSR6YNvtoMHkMZRj8XuzhUBl4wch//fcL80F/1ue0yUMdBtOUzlpLj0hkM1frx13z8jcVdO2/5041a3Pxwa3dh8rAxkPDhDV9l4iFyuuEkAdb2eqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+T3hn9ujKpQu8Pyw+hmk8vgt/YulwmOMguATaRMVIDM=;
 b=XkEDL0Mi7qsnmYgFWHNxNhjAEewMRtaSXucHKoK5f/5R1uO0xWC04rCLGiXpEPRTzfid08BGkXHOGc/JuGoUEHBWbAbcisEdziSLyYjiVoipYtJPHJZddUcabDk1POinUs2qrIpKS+SFXRNOCLJ1urlkc58a2/RQ+6Qz0uXyihL+L2SsNSU4WHOHJOBo9/RM6AdcilrbcA+1YMPyr0lpFXEBD3IURnUe6GxhyncWFtAKltI9g6QR8MOjzMkI11UdPWtBJMpzLNiZJC17VPAH6lnFGsSaGOkoEx5zDzypMugtNC8cuNrXCRym4KvtcuPDDGQCClEWWmm3wbTjuJD9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T3hn9ujKpQu8Pyw+hmk8vgt/YulwmOMguATaRMVIDM=;
 b=uV0UvZDsr7Kn1BmcB74jlh2zavNmfWqhgOZUBN6DTNblUhCoFpnj+E2fdQ43kd/0fyQccsYtwN+TKhZG45QjUNK/fnuk2k9DpKYCxtVBp0Txcw20Lw4JETUHYD4SOqP1W+mkj5Qt0ARKPapnn/sVE5AkeKJHSHGrPJENIg1Ckvw=
Received: from PH8P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::7)
 by DSSPR12MB999238.namprd12.prod.outlook.com (2603:10b6:8:374::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:47:52 +0000
Received: from PH1PEPF00062F2A.namprd02.prod.outlook.com
 (2603:10b6:510:345:cafe::4a) by PH8P220CA0006.outlook.office365.com
 (2603:10b6:510:345::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 19
 Oct 2026 16:47:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F2A.mail.protection.outlook.com (10.167.243.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:47:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:43 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:42 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V5 01/19] accel/amdxdna: Rename NPU3 firmware files
Date: Mon, 19 Oct 2026 09:47:28 -0700
Message-ID: <20261019164746.827277-2-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019164746.827277-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261019164746.827277-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F2A:EE_|DSSPR12MB999238:EE_
X-MS-Office365-Filtering-Correlation-Id: 6774fa69-5e40-46e9-7cbb-08df2e00b77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|18002099003|10067099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: LfoCCJ12Gi1q5mxS2l3bv7/DWpeMMm4Y8U/a25qI/fpKvYaKoH8vuA0wsSkdcxrs32eZrjkrRTiw4TxOF+nPp8G7A0mXXcXJdzMG52FYENbRz7pGGE4Y5YtesfLR5889ZKJJhbi4KLBTWag64nEhyoaidOZzrvQjguyvTAVuDTqW1PquHcB0TQnsmPUftzvkVvZt1nbMZ1AdDEFGqZaYnKz94Mf3hjWeyATGk5WZTfcWOzm4rXVykDyfGbpc/yD/5AI+uOxcaf3h/Uc16ybOucT8u/3gf5rBa1EAzKaULWeaUv/FCtF1Xni8XP38rwI1bXFyDPY/c6oQYlS1brEvthKtiKgumPC3WX4ZjMW5UXj89WiC04FjocXzkqmpmdDsdPl+cHtTJITsMKgvyuwMhtN2NX22z81Ygr7XzwRH5+Oj9d+rQY+KDzyq7u9f+CJzJ0wYER67pLBpnA44e+45jpVdZbtXzQNe3DKq1I4mtYIbh9UHKwT98EbayO155qHnrDu/s976jWkF69GzA+2mM1eelp6JnzUQVUNthxET3hzplWqOehHj+m/IXtU/eyHS98EVmAvf3HqP1P1ZEc2A5+Lsr2v2y1ZdSsi75N9EPyQL2YRVmoi4Ifmeilpr5egr1yCeq3RcTlujrgwJFh4+1sKmwGyo7nuMQnjRX3UMoRxb4N7Eew0Wucp6fOH47B8nA0Gl8VyZEGPKaafQQXv4OA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ek57aW3QxYF0tzrl1MG7UG12HczOej6L3pjJl++zpzY9d4X/9b2foDepbKWtIqhIywYwYgfPz/IVTGABWUOIbTTmr8XBRbCznIDXacZcawyVaNmZ5bMGbLMTALVqURKxNhptTkwMxVLuQOecc+G2Z7XimTBkAKIxq9cZU/D9MRNFL6P3BV3KV4BCkKbsdJg0dsBAOHuB8g2D9PQWrGfb3F8G8p8Ik1Rh0tqiSG9By5E8MHCGctC7miG4ecf2PtjTZk+khXiMSn0n14Td1qAKpzBluDelarmPtn4fM5s7tk6Ro9CTfFE7bKpuWa0R3yUBPvyRO4FKyGeGorN1Rqc26mnWozWlm8GzZ/3W1XDtuZKYQw+67Sc6zdwzBTbR3rI2I31mYhvuASswxzLTRJ6EdW381IrQKIgF/B9pgffCryr05DyUoSYRgrAVNGS1v2Ia
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:47:52.2240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6774fa69-5e40-46e9-7cbb-08df2e00b77f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F2A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999238
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NPU3 firmware files will be released as npu.sbin and cert.sbin.
Rename the current firmware names to match the firmware release names,
and add MODULE_FIRMWARE() declarations for the new 17f2_10 npu.sbin and
cert.sbin names.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 2 ++
 drivers/accel/amdxdna/npu3_regs.c       | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 67a02d6b7f97..bfc8bedf6de1 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -29,6 +29,8 @@ MODULE_FIRMWARE("amdnpu/17f0_20/npu.sbin");
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

