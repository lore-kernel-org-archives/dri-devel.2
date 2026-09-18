Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C965C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 05:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055CB10F172;
	Fri, 18 Sep 2026 05:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qaA3YrAG";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E38110E81B
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 05:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4EymEB1PAadSAf6K3U4yWD5VUqEmuXL+HhCr/q2lKH27HRDK1ED+M8QnLYs1ZpuOwPSPUxiJX59D+vyCf2pU4URwdoeDG8DzbISxhtcIj2h8Tc/vjTn/2lfWbXRjEQ8PKdlXuEBw6BMhxItYDQjKdc3aj1NgFeOIZk/PWJ2wAn8iPAigydohpitfGuVc21rDk0kpf8/I7EW48ht7PeCAxJK8zpf3TnuA6YWPYK7dKuHRk6DMzDOW653FheIM/XiMe7QdDvnmnEf+xDP1hQ9zFCpZKsI2ZQuxZEsZI3QqCDBi20zeYK1Fmn3qfkCharK0tbc9IqpxbjPfXZMdDTvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=MYsoekJLg47f+zV/3fbGPPTAiH2pTm/vWqOGP6ukCysUwRjY/yEqt5CkbzZ+3XV0iMj4OhC1cyuXrhEGMGaDIj+1nVMpgM6DsByL3FMB+JrGbg50DNmSmOVQRACrjG3YIJhU8SxgyyieHWFroK5usQo/slfwCNzKnLMxXdE3l3hD3W2bdLNQktuRRgTGetJbNNFQqNUpiF1MVXYjAYAVheu02271F/034K3/391nne1/wMu8PDP2hCYuWhgMZnI9F7PvhxMS4cB2JCHXcK6zR+uVofwBGCHsU2uliTmyzrpGJIIuVEboNcxlztB8QdFxYIn6BoPwA/FbE3GKkfam0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=qaA3YrAGrogmSSvIcM/t5ZVapGz2FFPhWjZnMvqB23Jdki7lwwymn2ybWeQ0gVTPdGf1FU6jgTUfVx5x274iZ4AjRlsqXTJnZjb0azaMf8GC9unLpuQtPVmiMWu1VgQb+XJF/hAGI+/XKBXfTLQQ3nLsZH92eek6bVNT0OUWQOc=
Received: from CH2PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:4e::33)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 05:59:32 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::a1) by CH2PR02CA0023.outlook.office365.com
 (2603:10b6:610:4e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Fri,
 18 Sep 2026 05:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 05:59:31 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 00:59:29 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
Date: Fri, 18 Sep 2026 13:59:14 +0800
Message-ID: <20260918055917.2133574-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918055917.2133574-1-honghuan@amd.com>
References: <20260918055917.2133574-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: c501301c-6820-458f-89d3-08df154a0232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: VxBYgGKBTZ922FUVbUhZfsjwG+T6MLn8yQy+g+w+ALvd6/4Dwlz188TPFGKil9DnlhnosEPVY1Ox1Vu6NVV6euQfL0nQctyVr7srCZSTLZqzE+3cU/oAW5Wzd35pt2nRGbSYBach+mDxjxGnPJpJGuSxBTwo285MhExvd79ESDHEAHg2drWAk8mYAChTb3Iv20LJm6nx73aG21wHX6NEwnaiX4Pk7SSFE75o8sA3EaXpDg8MNwAXJaK/h4TOptSZXxUPLJ+WgWswo8ic7KO4nWoJIlaDyhOJnQ3v/TtDjeWMHdh8fVZYttiWJsKnKAhmLHh+XvETcCs0N4QQF6PRQTQ4j5ADO+LJCgYdXFmi9NJDw9nICUUTxOnvU/66jwpui45kv57IYw6Rd2TywpIkHtYAsu4vV6xx+mxRygTA2/0w+m6vqSQpNYcS/0gGW/jBT2wU8PnrT/8DbXiN8r/MftdWzfx+YIj3ZVYMqGPcEPsFJjYF5QUOjpYY0kNZbsRmdx+F7KBU45A6r2Cxdqy+oQqxanrkyqnnJZDvwr13WmmdNxlsEBcQwj/S1xi3WaLNazlDhe3zSk7bTVjVfkaEVW4wLvqXrfUQNm9sVxHDJXuFDuaDxknI+ai7OZfQ08HEFqM2smUaWOsFYJ0WDLhUz3fzcUA3ADg0X61Yn29XkctMMZ0yzTyRROyWW7N4uowbZG3vaAzho/N/7Hy0KO+5KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UqI44h8/cB76iFLKIVq5jyJrrLkVcYIlpuzLgzsTtCgh+O32e/q/LzFhU9HhAkFO4eZwEQ/vaMI3lGZzsLWm9PH3ZtKpplCRWvjSM0ZtL6OEDgNx9ods+iaYciu1hc5SvZXOvrHk4QXqnFwJjZhWNjmmN2GbYomuAJeLdnPO5l6Bvp0OkAhyK+wX5i+llKu1JYBKfa74uo0H8VTlk7k1AE8pbwyXAP/z41PFjmXAQq0/jXpZSebsiRhWQqj3GdGK/A0t712Ky7ZkC2HYqDnNqdVMmCML7lvQiVX0EKRQzxusZWHlm2uszJ1nJ8bASkQ0++GoVtYX/RYgaVUx8n/am7XquGyja+HrnFdEy0JDsrfEUSqf20jh4eqlqo4EbgIi53VFOPIVg96zSAvsjSrpdgsi9iQvAXZJbWzm6/541PlS69yYq/Ke862k/B7w0+3J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 05:59:31.8111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c501301c-6820-458f-89d3-08df154a0232
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
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

Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
ROCm compute workloads in virtualized environments.

ROCm (Radeon Open Compute) is AMD's open-source software platform
for GPU compute and HPC workloads.

ID 7 is already used by VIRCL in the virgl/virtio-gpu stack, so
ROCm uses ID 8. A matching virtio-gpu specification change is in
progress to register this assignment.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/linux/virtio_gpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 4f530d9005..3d4dfadc9d 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_ROCM 8
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1

