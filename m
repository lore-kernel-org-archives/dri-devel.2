Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A24CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 16:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE78D11220C;
	Fri, 29 May 2026 16:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zyU/Oerp";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0DB11220C
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 16:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9teNrul2juhpTp868ZsNYx8s+UjUYkb5VRqLduWtfp5uNu16vsGmA6L3jXWId0GzxP8tksoJg86R7qodixBwcYugGZppcMxC/havRNvBR55wfKLZYmCLZHJRByczjsZqQrINM882L6aQKCSDuUTjkBe4aQwUUqAeJWtRDyLk9XCnIsMjLe3iwwP+y8haf698Padus19j5HEpWW6//3YK1DgrHKnm7/jONFRffMhJDTHjyAcaGjw/dmgYzqFUI8C+sdKN8CKye3uYeYEDqVwqq5VdIdNDiQEllhvH2foQMYTum/vtLWTiSwbzCKrwwKTDhVvtlB5TeBV5MANGjkILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUUGxxdpgxM2XbIkUmHghhyGuMhHLCTlu/Y9OZJLdO8=;
 b=dzZzQuIdwlnUX+RCIBp2rBSCLgEYRC1LMsXyXiJFZGaCkCMxGpCV7mV/3FQYkICYxhimP7sITx3IhBhtN5yaIUW/GaV8jsbs2oLDVSKSvG4UX2hr2nKphq6R+ycY2UE12RP+lvUNcAJ+2i3G91cOO/yw2KnCKUJxHM6w8WzIznbrutAA5eo+4L/NxqzKKJz5xy46G86R3dqRUlQVTv+zJqMCAMxJ62N42O+BZkcmJOqrLpNRqL/CNUz8tEqVXecbBYau3MYxSqVhrNlqL/ETbLJJYbMmkSxrc0aAghizzAJCQsrr9V6nGTzYg+itWNQZ0ZjnO/LSUj7HzgQHKhx20A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUUGxxdpgxM2XbIkUmHghhyGuMhHLCTlu/Y9OZJLdO8=;
 b=zyU/OerpAL+p5M9BiAtVZX4pkyZ5AvKmrVAcsDZTdU2AwvNHEl4CXNMUKdMAjPdpNdIeP72LwghJQjZDluZOXjpmTcMZQMCJxRN0xNxxa8C1e2Gtc87ZzvGEWBRy4/Z6RXmlmMj6cS+FXu0/Y6udJfDSmmnWYQmDFb9GDHemmdg=
Received: from MN0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::33)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 16:21:30 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::13) by MN0P220CA0025.outlook.office365.com
 (2603:10b6:208:52e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 16:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 16:21:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 11:21:29 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 29 May 2026 11:21:29 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Return errors for failed debug BO commands
Date: Fri, 29 May 2026 09:21:22 -0700
Message-ID: <20260529162122.1976376-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: eba9d783-b318-4cd8-299e-08debd9e5773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: fzs8UjnD+nae46dXF4ILZ4HC4w9l36al4l2ejeU8SLEQU/NQJDv9rYCpgrZ3AJJ1BUmrcgpoXXuIM8IkHMXf9ZzkHgBh2H/Gi5kFBcwRHTqoVjSDx36fV2wD4hHGot8sY1KgcHGv4r6Cceq2OJ38OWgQIIMoIzF0zg/7ejVl4cHK+KjkueLgpN//EYarfuyya30xZTmu+oAe9Oq2jH/OKauCllRkSX9vtsKj3SKsisQ4RyRM+MwNmZo480HKcN57+6wJqIQNecIjrv20vGPJk88Oe1o9FEtUNNAky6R7cUJfBgm8GmqFuAhGtk9vpggScsBIp6mHHohgDuoI7eNa1HoxecxCKDW6Ya/vw6m6caXoJ9lQN+2iL4+DMimEIfZLdbuUo0OB+6bEudia6kZ9MyJ2tjUeeXa+l9Z4JECU8FOmj0vec03XBau4yW990Ug2KczUqKsoy+CgR2oRYaNbAw4VZv1uxmWFQc2EsPMzKRJuQNysGZmAvkdCqUizhFpLc0ZAD6KGFSSeLAZEnPliKQYaGR1dGJB8lnWkkgT2Qf+nCZ9FIKPLSkXRdvnqzjge5kkUMe6o0aJHyLs+svri3TOnmYxMr+a+7O5C0C0stMCdr9V4ps+xa5ApIHNxDCkgt3hWmPshobnEJSJyUM6LdixT/0o8epEmcHARTxhpldKlulV8egj5s/k5QgZ1MqZxR9nRNjfNHwmyW5KaoGRfV9CVl1fIxy5JZsLEEt0FAYs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ac7NaXF46viY46Qu/TIukxMhiDzoU5F62yJWxgBXfbzaTrnddFOJ4bBDZHi2dJoRfJwsS2A9Krni0APng+rdk1U1nQ1+nXULN0pkjfshSzHB9umC7JMmX1ATJmd8uNvKU18eihZt53BMqo/yAGaRkFW9f94l0tMyC5h7UjJSDugfIk9jA0/JvbVLXdRBHpN9m2BvxsoUnnf/r0rO4AARGxxw97pEmHSa44Yu1Q0tEY9DZZ1nXvbL/D1sx12dLqdEIL9ScnkV+eB+xYguXtCFdvS+2B/jgAcDc7T4LM2Vhcyo4MN0Blk3hJbKuGB4HoFYfLekaVXfjPetvEAatCkV+5AFSGQ8DZLFZ5vrEeo19Gyeb6npFhDyrruc+pr1OeqZQ+JlC9o7FIy9lBSruA2fpiZlaM18qr4xwS8H3Kr6HVmUzG7QtdaS4xbBTHTJAz/l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 16:21:30.2403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba9d783-b318-4cd8-299e-08debd9e5773
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494
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

The config and sync debug BO commands currently may report success even
when the operation fails.

Capture the firmware return status and propagate the corresponding error
to userspace.

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 2ad343728782..da89b3701f5b 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -305,17 +305,13 @@ aie2_sched_drvcmd_resp_handler(void *handle, void __iomem *data, size_t size)
 	struct amdxdna_sched_job *job = handle;
 	int ret = 0;
 
-	if (unlikely(!data))
-		goto out;
-
-	if (unlikely(size != sizeof(u32))) {
+	if (unlikely(!data || size != sizeof(u32))) {
+		job->drv_cmd->result = U32_MAX;
 		ret = -EINVAL;
-		goto out;
+	} else {
+		job->drv_cmd->result = readl(data);
 	}
 
-	job->drv_cmd->result = readl(data);
-
-out:
 	aie2_sched_notify(job);
 	return ret;
 }
@@ -940,6 +936,7 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
 	aie2_cmd_wait(hwctx, seq);
 	if (cmd.result) {
 		XDNA_ERR(xdna, "Response failure 0x%x", cmd.result);
+		ret = -EINVAL;
 		goto put_obj;
 	}
 
-- 
2.34.1

