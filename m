Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2C6CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 16:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F8410E446;
	Tue,  5 May 2026 16:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pY0WSgTe";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E6D10E446
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 16:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWH//YCNm8wNIV8LI68NH0zUfqdWmmot1hZmXzl1I+09TjDPjCb/lGVjI5EZh4qHreTKKVtjXsgLefZUTkgwWslxHMLzdpbgkvdF3ZaHFJQEQVODwRPa7GyIrHsJW6cWIczPpPcFIPjA+ytlE+NB83NovIKhaDBPtbpfhsvz+Va2kCtzxx2VwBsNMHUFDmMj+O/BhTb/WiDmNWVQaSFi2g0jhc0+KguBrgdByovnFQ6k6/rubhgmdEwiPM888c0zyCTRjO9YOGb+p8IKcFfR3NhaY2Bf9TP+dWhgyQJoZbhFF0TN0RrPIwOUalGyuwT1hYWkNPdlFhDjhvCAiwkRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGGCmFTCMNTFLF5F95Y2BtEN711XeRAzoNDNl3DHTPs=;
 b=qR1c0y9EeMg/M4b6PBmAXJLuIPSO0Gdb+pslQ0FCrzMbfFmJdGjPcxgqTTtnOxT29SwU/LtHk905psH68sQQV0kVUWuZpEsmzheVH8sgsJfnvzAKfcZbuEI5CwhXwuiMrOxKpMWCuBDcNyLhT1JT1NzhYHcT6vwJVE2M5QdXzoUpdkFeiL8dIhjiw93EX5a/EwaOihhgJ42GVIdUhtbEs3QTDEiFxXL/4Tgzjpfys4f1zx/UGyMA5Ub4pUeq5DpOpIkiPyKU68xlvy7FxuJB8LSYeAdDF/rrMOnehsYzSMOLOECgGzedrfO4rjt5MHWa1cM4aZjOAUhiKUQOizUImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGGCmFTCMNTFLF5F95Y2BtEN711XeRAzoNDNl3DHTPs=;
 b=pY0WSgTevm2FR/aKJuvtzWNlUzLv/YVOlDB6RSC0J3Z6sd4hUp2da73SYEOpQWaq15DOGHcbRBzb9R+oMn/SHx+VuNzMenHJ/WDHABCGlc4aWsL29nf88Yj4Wb/61TUF754I2HQLR5AcRnVvkKqGQtO4zOktRrCvRjFQ6JMnF2E=
Received: from CY5PR13CA0037.namprd13.prod.outlook.com (2603:10b6:930:11::31)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:11:04 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::77) by CY5PR13CA0037.outlook.office365.com
 (2603:10b6:930:11::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 16:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 16:11:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 5 May
 2026 11:10:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 May
 2026 11:09:45 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 11:09:45 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: David Zhang <yidong.zhang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1 2/6] accel/amdxdna: Init AIE4 device partition
Date: Tue, 5 May 2026 09:09:32 -0700
Message-ID: <20260505160936.3917732-3-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505160936.3917732-1-lizhi.hou@amd.com>
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 7974a473-3c5d-4483-e267-08deaac0e78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: kucGZoyzG5qEHfHWf3bELojfPw9i/teUIIGvVFYhC/SuJ5Z0Lhq0Jqxj3w3Tg5bnWgDOaNBGUwEciLGN9Gt28coaIL2++Aq4rWicIP+z0SHhePE+C/wsJZQKgnxKy98tCYZyvTek76IxoZJ9snmyi+/rqIJZccy3nOzFSgL2KkgrW85ME+e43alUEmVLhhgst8I03th7rt/1C6UhTMGu8y4CR/zwQd1Hc2Yd7VX/i6SXLSdOmbQoKJczqCsD8fzVSXbs5mQ/YN00CkKcrDErbthEDdx4JSGi0v2zRaFweX0SXE1DIGVmg+GerWP6n5NQYOzKFXCPZpql8/uMLrqhAKab29ggUHa8KP1M097wfyubBJCd8BJw2S0muT9ohQYa0R52ITNrM0RN+26YS8unqDJ4xjSu2grv5url+smyFtYJQGzdWpI/5iCpAHlqBk3SyICgeFfHjDwOEXlwCoa95h4jOSi0/K3a9ICCnzJ4PM80LJP5wvnVcj32IcFDarRx9JZBlfI74a2hcC2jl0gLrSZXF60tXbKY63B15QWVdgEwODNAFXcoWredS94FVGIuuNLXXnrVWH0UdME8XBQGbJtHHzH0O7XjctY4bWRBXnCFE+1EnyTFRsPPJvkYHNb1TZQOeQg3Yz8n5Nq3Yn4cZBgQkzs5Ccm6QUBDQDPsTe9MRVkSS6zp2r8/TQ+77kqn5wh7u0mb6V02ts/RBh1EWKs1zlAiYuQ8sgutJntg4vg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6vtbqnzl7L3i2fyN8J+Y9+MKCf3PuL5EWmkeqIM4oYJTQy46gg2PoPUuhVaL7RAzkN99JEf5WCz3E1WFn5hRZ8X+W0LM8nLbyPtFF/ZqdOdLRigqz/xj+TfACdKTK/O67RTP/zTFzZQuHVGbS+UQ6YMTad8KXz5CDLe5aDgx7gTRvpeJnUCwZEZLphdLRaA208Ss9Frw+8W0gBNEL2yR4fQJy0uciMZ5oYScu5j/cr8wh5Skq5GRPn98p2lbMXiSDd7DAPhrSfGwM/mbLIiaAqbBi1KthQvI1ng7GNUQvVxk5l/jp4EjlyFGW61XHISiERMvJd7OzoyARJhfmpN+3JKC4VUAxRoThBAo4T1hzWDOGzE9gkvp94sHvCgc0GiyM3KDAHX1G9GjXIV0ap4xf83krKpgghzLtIU/jSJsCimwfEVRtD5458FF9iPQH9Q+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:11:02.7561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7974a473-3c5d-4483-e267-08deaac0e78d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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

From: David Zhang <yidong.zhang@amd.com>

Send partition creation command to firmware during VF initialization.

Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_msg_priv.h | 21 +++++++++++
 drivers/accel/amdxdna/aie4_pci.c      | 52 ++++++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h      |  1 +
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index 88463cc3a98a..cada53257921 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -13,6 +13,9 @@ enum aie4_msg_opcode {
 
 	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
 	AIE4_MSG_OP_DESTROY_VFS                      = 0x20002,
+
+	AIE4_MSG_OP_CREATE_PARTITION                 = 0x30001,
+	AIE4_MSG_OP_DESTROY_PARTITION                = 0x30002,
 };
 
 enum aie4_msg_status {
@@ -46,4 +49,22 @@ struct aie4_msg_destroy_vfs_resp {
 	enum aie4_msg_status status;
 } __packed;
 
+struct aie4_msg_create_partition_req {
+	__u32 partition_col_start;
+	__u32 partition_col_count;
+} __packed;
+
+struct aie4_msg_create_partition_resp {
+	enum aie4_msg_status status;
+	__u32 partition_id;
+} __packed;
+
+struct aie4_msg_destroy_partition_req {
+	__u32 partition_id;
+} __packed;
+
+struct aie4_msg_destroy_partition_resp {
+	enum aie4_msg_status status;
+} __packed;
+
 #endif /* _AIE4_MSG_PRIV_H_ */
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index a967e2db7ebd..13f5d45e388d 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -9,11 +9,16 @@
 #include <linux/firmware.h>
 #include <linux/sizes.h>
 
+#include "aie.h"
+#include "aie4_msg_priv.h"
 #include "aie4_pci.h"
+#include "amdxdna_mailbox.h"
+#include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
 
 #define NO_IOHUB		0
 #define PSP_NOTIFY_INTR		0xD007BE11
+#define AIE4_TOTAL_COLUMN	3
 
 /*
  * The management mailbox channel is allocated by firmware.
@@ -234,6 +239,36 @@ static int aie4_fw_start(struct amdxdna_dev_hdl *ndev)
 	return ret;
 }
 
+static int aie4_partition_init(struct amdxdna_dev_hdl *ndev)
+{
+	DECLARE_AIE_MSG(aie4_msg_create_partition, AIE4_MSG_OP_CREATE_PARTITION);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	req.partition_col_start = 0;
+	req.partition_col_count = AIE4_TOTAL_COLUMN;
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret) {
+		XDNA_ERR(xdna, "partition init failed: %d", ret);
+		return ret;
+	}
+
+	ndev->partition_id = resp.partition_id;
+	return 0;
+}
+
+static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
+{
+	DECLARE_AIE_MSG(aie4_msg_destroy_partition, AIE4_MSG_OP_DESTROY_PARTITION);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	req.partition_id = ndev->partition_id;
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		XDNA_ERR(xdna, "partition fini failed: %d", ret);
+}
+
 static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 {
 	int ret;
@@ -267,7 +302,21 @@ static void aie4_pf_hw_stop(struct amdxdna_dev_hdl *ndev)
 
 static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
 {
-	return aie4_mailbox_init(ndev);
+	int ret;
+
+	ret = aie4_mailbox_init(ndev);
+	if (ret)
+		return ret;
+
+	ret = aie4_partition_init(ndev);
+	if (ret)
+		goto mailbox_fini;
+
+	return 0;
+
+mailbox_fini:
+	aie4_mailbox_fini(ndev);
+	return ret;
 }
 
 static void aie4_vf_hw_stop(struct amdxdna_dev_hdl *ndev)
@@ -276,6 +325,7 @@ static void aie4_vf_hw_stop(struct amdxdna_dev_hdl *ndev)
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
+	aie4_partition_fini(ndev);
 	aie4_mailbox_fini(ndev);
 }
 
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index cbf3424a4341..620fb5bd23e4 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -31,6 +31,7 @@ struct amdxdna_dev_hdl {
 	void			__iomem *rbuf_base;
 
 	struct mailbox			*mbox;
+	u32				partition_id;
 };
 
 /* aie4_message.c */
-- 
2.34.1

