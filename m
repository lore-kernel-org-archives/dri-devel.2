Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D31CC44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7A210E241;
	Thu, 16 Jul 2026 15:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E96XcMRp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7217310E241
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1iKwNnTpC7OQKKCV5Qxj6aVvx7WQYb0uSczVxBjADnBq1TwLB4fLvpm9SNfy0UymhNwd4AsA/bQZVMu3b7w1iUcGcGAvuWoBi8Uh7a7IBL/+Pb1ayPrcWsLI43bhLKPg1QsXTe4yHgHmXDR5S7fEezNblY4eaZYw0Oot46iiQ5BYjPmRp5AAdxO+CSUp0EFXpY7iqBswS10OexxHkgsA0GaVdQ2aB9zFvhOOhkfeZk2h0MXhgZhRj3jcNnOcZ1KMvW/kYN/sIKANKZ5zXtJGzxOGybkrNS7Gy0T+jgavxIs+LkCudQJLTwMZ6J7FsZYWc0zXTqFmYHCkDunG+ovfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LuYeOf4cFthSQWSx2qzYYZzmoq4HHlEi41J+rYlRhY=;
 b=s62Mal2YIiVPP5jT8kcRzG7b9stYoX4TVNflACzE1TaSWFXToXrNmc6zjK1mJ8ZC+UTyIrSP0gHZJ32GY6yCFXHdzCRthUwkW/n9YwcpKu+nxR309X95PlcqPLIdq02mbcM3tcUtALMhZoxKwW55Mx1DncJAMmbwRyOxHfJSKxl4H7OwSR9jtW1D66OHrkDo5Kqp+j7Q0rxolqnTRGHNYE2zt3rWOIJSWKkmjrN3ysVj+FZUgpF4wPw2Zhm2opaRFa2bLyMJpCcOm8mtGprUZyWGUbwD/m4O4DBvrAzSMsPzhI3XhLW3kOQ39U0PklMyiJfWXn9AgQwy5vVtCKrKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LuYeOf4cFthSQWSx2qzYYZzmoq4HHlEi41J+rYlRhY=;
 b=E96XcMRp67qGL4obS7VXNf+IFiSSmRRPfT7/F5MyodSsl05xTCXmBQaegjPFK5oLGYq5ERh6l1HCZT1AZGEsj2F2yqb9by7Cf4BK/92EKlW5yXMU/EexX11UT8e/ml/iCE/d+ENNvFQo8YLqUkV5V0rL8mIc+sFsyOD9PEEwZFU=
Received: from MW4PR04CA0112.namprd04.prod.outlook.com (2603:10b6:303:83::27)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 15:13:11 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::64) by MW4PR04CA0112.outlook.office365.com
 (2603:10b6:303:83::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 15:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 15:13:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 10:13:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 08:13:10 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 10:13:09 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix use-after-free of mm_struct in job
 scheduler
Date: Thu, 16 Jul 2026 08:13:05 -0700
Message-ID: <20260716151305.1595780-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: fa075abd-9f5c-4041-e748-08dee34cc01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: /dmn1zicvnmTGnilOKXRlTENkK/tAJdwCpzhFl2vm9QzEWofYE3BVxe/g8aS8hLtR8XF6/0BFC3/B1hh3CB/frbEMaa52OpfOL+eQpPPl57JNg6tT8KQFDeJzBXiG/Ut+lkg+cHB41Qa2LY/y3c++gmvZIVuZSdJIl4E33Fc4hLLD/QOoSOiPEVSPBakvS7w0xI74g8PXJvdBGLThuzNUeeU5fZASTVuU3ctXmaY3SZXlur+ZpF+0UlbJFyzdkpNGHHZsVH32jVgUynneEF+TDn/w1jCy6VIatrUFUJ73DDqW/5D4dRRQKopekalA0qANljKWF88xVlKMST7jTZmN6yu7uVfCQqkolklL74W8Rx9x+zaYhwZGOFW1SrIK7RbI1wmTx/1NblOJw+c+xb4MU6W0DVIhNiBvWBWC27O9QaXJTCRPbdUGsha1JqbngYkyoWbbinEZVcoUEnDXZ3B2zX/7xCjJZ3lv41b46w29J5STWlMJ98JR9vjJ/gBiQD7Z4SKrSdN+TKlDS/T4gsE0evofXY0YWHs/sAmfndQsF5rzUt5hoCbvRqIK2u6ffy6pOKFGySCvi7k/ctvojnC/nghzGmGRF6BUfPijnPpVrY811NYDI75Juo3i9Eh3zt6bYMLL0SBB2ppuIX6QHEZhtHZUPxHp0RRQUXAxSpTEia6wry5IgU7EqocTs+lYm4M04lJyx1orpnsoyrXdvc4aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a0wJkCsodF/gQjYAR6dqbJNKmVOv3L6jFz7IL3gwsj4A+Wu1qBkdnqAaKXaP7RQ9Rmbny1pJBcf0YdEWHDmDbQ3snYiZpSDSz1MFv4ovO3GTIhuZ6nBdOLu+jIHqUqPTLeVQNDAU/g5JaJSvOqo2JVLg9mCd7IVw0+NMFGENYobUs0HnWJlLYKC+5etlJm/SsllQwwgkIi+bzwaIW3KwSVwMtIQ8soucWr/AeEiy53WmxlvihmizzC0/fI2H2U/EERH4UCgzKTSwbGMc832ThOs+HcK77xgkTL0J07Cyh1KTtqtyNbL4HFk1sj4/XnFAr1ueoBoJcNOJc5Bcii6Wz9Kkm7XjeAhSRrIT1WJ1h0NFWc4Wt4ucjTShth2ajLNOPJhFOOwNXbr/3Gv5YXPX+gLO31JfUK8KaDgZ9XMf7ZCYmLHT4b3SItYe0YXQVLDC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:13:11.2136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa075abd-9f5c-4041-e748-08dee34cc01d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
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

amdxdna_cmd_submit() stores current->mm in job->mm without holding any
reference. aie2_sched_job_run() later access job->mm from the DRM
scheduler worker thread. With only a raw pointer and no structural
reference, the mm_struct can be freed before the scheduler runs the job.

Fix this by calling mmgrab() to hold a structural mm_count reference for
the lifetime of the job, paired with mmdrop() in every cleanup path.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index bdbd3db12a6c..31a414c3f0d9 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -577,6 +577,7 @@ void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job)
 	amdxdna_arg_bos_put(job);
 	amdxdna_gem_put_obj(job->cmd_bo);
 	dma_fence_put(job->fence);
+	mmdrop(job->mm);
 }
 
 int amdxdna_cmd_submit(struct amdxdna_client *client,
@@ -642,6 +643,7 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 
 	job->hwctx = hwctx;
 	job->mm = current->mm;
+	mmgrab(job->mm);
 
 	job->fence = amdxdna_fence_create(hwctx);
 	if (!job->fence) {
@@ -676,6 +678,8 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 cmd_put:
 	amdxdna_gem_put_obj(job->cmd_bo);
 free_job:
+	if (job->mm)
+		mmdrop(job->mm);
 	kfree(job);
 	return ret;
 }
-- 
2.34.1

