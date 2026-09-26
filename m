Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A555C9830E
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF6810FD00;
	Sat, 26 Sep 2026 01:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QTr+7D64";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E827B10FD00
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ty8lKtRzihmWDZuG1Z/Flt0xDn3iT8DrVEK/M2DGMyJAJNmuhSybaFCfey+4vbPA69lTjtKoSJqaOYNGh2Qa8v54s3PhxZnXj4uO4pSLG4xKWw8r/PZE8sbByhHuMpeBCbKCgx9e2U198sZ/6tHpV4mqyZxqtzVR/6xuh5bR4axQbMjAfCqXLksI0X4NWYuqwF5p9+LJ8nypMejH2TEOyOaJd+XWXVHTt9XV198AKmBP3S+ocxxaDNFCJysG7GlloPraXBvBKZRwgukE7OS7cs4QKTWV0TRq0/AqdOqPR4ZK/0kOAPeX7KmQPCru29mIi7TazZyr82PDwYWpXLoM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWtrnXTpc+J06q0UVjI5VYZmlnoH5Xa+6oozUu5MB5I=;
 b=lRwCVXZEkrykljaogdx1j9/VXVhjVG7soASvhnZgUAawRpPm3I6aDP0WKgzQKF5wCCRXDujrwkNqPbBkt81RrWfLIWqqESPAH/Ki6D0L1BN+rlCmulcbgOvWg66tH8qkR7uKSsG2yvP4IKeqWrA8taFXURDIRGOu47r0Mcf4zzklboeyoVmCkQSdopBfzkogFQ/dw9eMo0evYElYUbjkHwEjQ/t82gvb/YVp42cpDh8VAU9wQl9l918DKAK7NLB82QxH/fW3K31AmGNCQ2qdnvX5EAtAVKPDsM6lCkhMpqshHdCpJoRSgTY3xtGV26FWcP5HAbFqUU71PxPwDyGdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWtrnXTpc+J06q0UVjI5VYZmlnoH5Xa+6oozUu5MB5I=;
 b=QTr+7D64lp7tfNBqXMZirT8NKIDdGZB+cq5Tco+Me9OQzvCHsVmXyz3oLsXW8+zHdEKf1FKx4H6oWpXd7+qht2moq1861+vs8M3/7UaVnPBLodsbotU3++87V+rMmkq6zTrBYoAUWegrtjBqJNtgarigwD2kf/yluuERI5rgjK0=
Received: from CH2PR12CA0029.namprd12.prod.outlook.com (2603:10b6:610:57::39)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 01:35:26 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::24) by CH2PR12CA0029.outlook.office365.com
 (2603:10b6:610:57::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Sat,
 26 Sep 2026 01:35:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:24 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:23 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Nishad Saraf <nishad.saraf@amd.com>
Subject: [PATCH V0 08/21] accel/amdxdna: Restore power mode override on AIE4
 hardware start
Date: Fri, 25 Sep 2026 18:34:35 -0700
Message-ID: <20260926013448.3840921-9-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: f37e01e0-e565-4530-7dc0-08df1b6e70d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|56012099006|11063799006|5023799004|4143699003|6133799003|18092099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fCAae6t+Ly0q+Rf4dmjPPN3cFgqXt66rlrHj0+17JozC+mjo4xTnxeX87ZhQPoMsbCYsJ0ZXN0B3wQpmRetZl6j+KRlHGZwwA05g1sncuUtOtKxh/43KayMutKiFXnYJCch5h84Hi6dQ9lKPmQ9C+k1OGUrgkknZkZu66S7hjNquy2RwdN5eUj3+PG0MajzIGzWe/4NXxyxBk11gMIfT4degu+q6YNaDu3INRl+HBbvNmuThynCMlI2XrprbuaBg72r5qI2uBuTEgz7qiZJwaHgUkMG6JQQ68AWpt/Zpgu8W+roPzOPqOl6SYWJR7bG18D0naEVVRemliXeCDTjg0DF0fiYrIMGuluulfhEdqxbQld8uUL1LR+w0KjwQmVwUuPOlrsGt92Bw9IJV+nxAStG34VcTPVdebMizY2LSLYfFio1z0h6ELtDBRWjouFlz4gL+yQycjPwESl00/obzaEr9aWdUYQTBHuoDvqsf3GxSKJdJcMgBAtdK+6AISy+AqhjWdFrMwiWyQ1vcTlm5amj0Mz7lEIanmq33su/u3qdqgUtLk/+RT8uGjpg9eEUXnerrb4x+1z2OKiVBUXM1JAuvynxlMA5Mat4M4EmX5/ueuoRjm0IBl0NRaN0Eou/eTiFeQDBfQwJAGOSpuDHMkoTrcEYIF9JC5Bg5YLaNFY14At4wXQXoZyCvuYE6Sid0M79RKRn/c+aXG5vWYibw6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003)(18092099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zYL4W/XdKg7EtarkvVuDDZ0sh7O9L6eyqYO2UKBeAihiKJxpQqT+jrUS8hzjZJFOipMQWH9T27/B+LV+sDvvhDefYwj8nBON2CpA77Ee7hoZzjonm+AxR6u3/A6esnNYRRsmU9sbau6dw2ECSsf5c+qV/nt4dJaA6eVj8ywn99LqdrWhu681BeIgODBJ9epi/Oq0tIu6vaX6N0gAmsJPeumQr1aylpcvXEo98Yy2cuoJ83/joqWf3B4zr/Y5e84+bWmprFv6oUaz+hvccZPl81Zi0C+IXcxsKOhNrEPUx2/NCGvBBfywyYu0sZUJ/N7mNgBY5kGWzuELQmoxt2yqdMVr9W96bxAaYzSp8xHqPIiHt6+TNh13LhFpNA4x7m83xlnCeG/G+2MetGA14OI4ZLtp2GRsNVDD9KnutTIsegHE4A7VGE4tzDdkrXFMD5GJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:26.2619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37e01e0-e565-4530-7dc0-08df1b6e70d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
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

Firmware boots in POWER_MODE_DEFAULT after a reload, so re-send the
cached user power mode override whenever the hardware starts. This
ensures the driver cache (ndev->pw_mode) and the firmware power state
remain consistent when the hardware is reinitialized (e.g. across
suspend/resume and runtime PM cycles).

Add aie4_restore_power_mode() to re-send the cached override once the
mailbox is initialized in aie4_pf_hw_start(), aie4_vf_hw_start(), and
aie4_classic_hw_start(). On a fresh probe, pw_mode is POWER_MODE_DEFAULT
so this is a no-op. Failure is returned to the caller so hardware start
aborts cleanly, preventing the driver from continuing with a dead
management channel if a timeout occurs.

In aie4_classic_hw_start(), if aie4_restore_power_mode() fails after
aie4_partition_init() has already succeeded, tear down the partition
before releasing the mailbox so the firmware partition created just
above isn't leaked on this error path. aie4_vf_hw_start() needs no such
fix: it never calls aie4_partition_init() itself, so partition teardown
is not its responsibility; the PF reclaims VF partitions.

Note that system and runtime suspend/resume callbacks (.suspend and
.resume) for AIE4 are implemented in a subsequent patch ("accel/amdxdna:
Implement AIE4 suspend and resume"), where the resume handlers invoke
these hw_start functions and trigger this power mode restoration.

Co-developed-by: Nishad Saraf <nishad.saraf@amd.com>
Signed-off-by: Nishad Saraf <nishad.saraf@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_message.c |  7 ++++--
 drivers/accel/amdxdna/aie4_pci.c     | 35 ++++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h     |  3 +++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index a7025995d0e0..f5a17e10cc86 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -166,7 +166,10 @@ int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode)
 
 	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
 	if (ret)
-		return ret;
+		XDNA_WARN(ndev->aie.xdna,
+			  "Failed to set power mode %u, ret %d", (u32)power_mode, ret);
+	else
+		XDNA_DBG(ndev->aie.xdna, "Power mode set to %u", (u32)power_mode);
 
-	return 0;
+	return ret;
 }
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 3a063d3ffa94..f72d0dac8263 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -295,6 +295,27 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
 	return 0;
 }
 
+/*
+ * Firmware always boots in POWER_MODE_DEFAULT after a (re)load, so re-send the
+ * cached user override whenever the hardware starts. This keeps the driver
+ * cache (ndev->pw_mode) and the firmware power state consistent across
+ * suspend/resume and runtime PM cycles. On a fresh probe pw_mode is
+ * POWER_MODE_DEFAULT and this is a no-op.
+ *
+ * Power override is a per-VF property in firmware: each supervisor (VF) stores
+ * its own requested mode and the hypervisor arbitrates globally by taking the
+ * highest mode across all supervisors. A full firmware reload on suspend clears
+ * every supervisor override back to default, so each device type (PF, VF and
+ * classic) must re-send its own cached override on resume.
+ */
+int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev)
+{
+	if (ndev->pw_mode == POWER_MODE_DEFAULT)
+		return 0;
+
+	return aie4_msg_set_power_mode(ndev, ndev->pw_mode);
+}
+
 static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 {
 	int ret;
@@ -311,6 +332,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto mbox_fini;
 
+	ret = aie4_restore_power_mode(ndev);
+	if (ret)
+		goto mbox_fini;
+
 	return 0;
 
 mbox_fini:
@@ -348,6 +373,10 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto mailbox_fini;
 
+	ret = aie4_restore_power_mode(ndev);
+	if (ret)
+		goto mailbox_fini;
+
 	return 0;
 
 mailbox_fini:
@@ -389,8 +418,14 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto mailbox_fini;
 
+	ret = aie4_restore_power_mode(ndev);
+	if (ret)
+		goto partition_fini;
+
 	return 0;
 
+partition_fini:
+	aie4_partition_fini(ndev);
 mailbox_fini:
 	aie4_mailbox_fini(ndev);
 stop_fw:
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 98b637279257..fd2c50dc8080 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -87,6 +87,9 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
 
+/* aie4_pci.c */
+int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
+
 /* aie4_sriov.c */
 #if IS_ENABLED(CONFIG_PCI_IOV)
 int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
-- 
2.34.1

