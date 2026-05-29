Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03BFCD6E50
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 15:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F7A112100;
	Fri, 29 May 2026 15:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VXbOUNJw";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 682F3112100
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WijxljeMURt094fH09HLGceymhOKvwlTD39EBb1UM5BTpQXMwMNB82mNM29ujfcPyRjc6nL8rywxTBEM4lPocGXUAEzBV/wI/JIaVRec/7ghhDu3bkiACspMdgwA1HDyLYcXKdlIbcb8wC7EcZfIPqXzq/lqcQfVKPR+5CSfpMfxB1RXVdUgggtDhs+I8rAo2WCl1U3fsv+c6YGsuUHFss0DK/fcxCG4TH3zfyCP9hzcq2t7xXOcNWv63PQvA3DSklECBp1B98GG4+TbhBLGxuAT4raYF6h80nJ1jZNBtXye5ocleS8dJ8yiZBLQ+Km84uvo5WbmegTcrNF/Z+6yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZfgVtLK7k15103REFv0+JCEi+Cwc9N2bho9GPGVmKM=;
 b=orMWmqv8eX7Nc76RRsF/BwCj7tB8g075ImciYti/mJHTbS4bs2lTYtb/14AlS7D+w6p8DbTXT1sVYTtfONvFHhszNdAyfwCWmhg63oKFBaJiX0i3bSpPms+1X7E72I+PFfkVpCem+r12UsBOhYOqSuZrAHsVWMBsnOv8xjGJOxzrQI8f/onTiDhSbim0lHyyF0a0AqR/i12llj3aDjaI7U3nOtCh3BK5BhOOONGiBktuU6Fsptf+6AC8mQcEMJocCbIR6zY2U9BrBYV2iHsulEQy3iGrcdnZ1MDORrVLSzDPEkepfrAqYCWpRyIJ0I1XNCSxaY1OEOY0ql4/e0ytRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZfgVtLK7k15103REFv0+JCEi+Cwc9N2bho9GPGVmKM=;
 b=VXbOUNJwXYjY95wQDcmtwBrSh08AZADylAo3tAj1bHiJJ3ukk6Do5PkbvFb4louB5Kho0/QZy0PbIskwHE8e3mwXX3lghR02BQ5F4u5EhrLMOwQfJTJo4eziDAWbLaAUw6Ab9seq/A8s7r6d8szfnxTB2NwMPvlZfrlw0B93WaQ=
Received: from SA9PR13CA0054.namprd13.prod.outlook.com (2603:10b6:806:22::29)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 15:28:44 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::59) by SA9PR13CA0054.outlook.office365.com
 (2603:10b6:806:22::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 15:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 15:28:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 10:28:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 08:28:40 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 29 May 2026 10:28:39 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Remove drv_cmd tracing from job free
 callback
Date: Fri, 29 May 2026 08:28:37 -0700
Message-ID: <20260529152837.1973405-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d8b487-81fb-495b-1f28-08debd96f6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: oeUf46zr/OvxZQonIw7oayoxQsuB5mWy1Qe85Im6Exzg/ItHmQdQlGZdi+blH7LFC/2/hC1u11aLMx6q8O6YQRXL7JEZ1fCVKn+rmP53EtPBgge96NRfOqXqh0rqcjDHIeQTXmY+k4o3VrRTneG+I85zQKixFNc1oNYxOnBFPQQ1eQRQxdNvukpsVIMTzLoeaY64lHhWIPXb1p80FDwfCphNsV3k0Rak1Mape+8jneaPQf1v/5gR1KKur+oX2npRujAkw76FHgFqcMoYwJNz2TMO1MB75L4YjluiOkPM/YjgLmo8SkdBeJwmvNgZnJ69zutIPvZWzvxI8jzFGlG3PDPVUekpHvzCkjNPbTnReuSq1xDfkPwPf8kvOzlWEk8uUu8dvSP2xkAnc+5be3nMCeG/S1M6/UZvNeV2RvonhmY8vOoat7FkT5amwAuytM4HcvCR5poWVGAqyBy4qWGxfpxcy2xsrcZaLH2K07H9TFPuXKTd98PNJF5q4UzP7Jk9ljjNqyTR6BddSr7t3oJ82vjSYMYeMym3iDtG3tmuwfukqCFa81MbmFfakUiVipBFOSVBvVFqKqm4zXhqFJPBDBPEgq1JbLmdDJWgYAmrykCiKpyd2KJwWXCrcLahIj5Dn6jaG6ov/xa4pLbD7EN6jilCZFTcRUZ3GWt2lnFhOBqrecukmGGzMCH2lbFbhNh+oNujTqSoHPeKBEq0a68ocCLWb0uQTlTb6LoZrUyF5IE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9eTRzSdgCl1KHaf9/U/0RerDaFdv2kGwnF1ze6hrUh7mWOiqybLfCdPanmrvq3cNeUEMkxJDm7x5hWOMLnzpUQXxjgmsqYnqbsHxQuTGrNGpJxaqH6N3iCmJHsWgQ8weHu+GCgVOQJcTdsbCK3BTNfvCLCBscSslwGGNBla8sCOHHD89x+IllowSgFRbNig7qWrPWFyZn4Te0NnTULehp8XKxMQnPOfNPeyqCXvarIHZhtY3cBz3gpx1htZElg5fOdvuDJOR17EJfWhq6BPrJu/xNn8mQRGyQqtMWM/am6wZFBJHYycdNcYCnWU0UuWQsMN5tw/kkyOBSGMKVngO49yGsp8mADFBghzJNpF5xp9niSnEZhkiB5CTrdy6hBfmJa14SIjjvlZFMicI6riJrXx+NWkDO5wttKJ4acFMhE9/cC8Csv/PlISI/vCDe5lN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 15:28:41.8670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d8b487-81fb-495b-1f28-08debd96f6f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
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

aie2_sched_job_free() accesses job->drv_cmd for tracing purposes. However,
job->drv_cmd is owned by the caller and may already have been freed when
the job free callback runs, leading to a potential use-after-free.

Remove the job->drv_cmd access from aie2_sched_job_free().

Fixes: 8711eb2dde2e ("accel/amdxdna: Improve tracing for job lifecycle and mailbox RX worker")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 658a5fb1fda6..2ad343728782 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -437,8 +437,9 @@ static void aie2_sched_job_free(struct drm_sched_job *sched_job)
 	struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
 	struct amdxdna_hwctx *hwctx = job->hwctx;
 
+	/* job->drv_cmd could be freed, so use DEFAULT_IO */
 	trace_xdna_job(sched_job, hwctx->name, "job free",
-		       job->seq, job->drv_cmd ? job->drv_cmd->opcode : DEFAULT_IO);
+		       job->seq, DEFAULT_IO);
 	if (!job->job_done)
 		up(&hwctx->priv->job_sem);
 
-- 
2.34.1

