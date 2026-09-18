Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6908FC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DBEC10F255;
	Fri, 18 Sep 2026 07:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vrA+kt3G";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C0210F251
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyVdWlaxdT4Zm12vO/DUei9ucICLTTSUhYPDZi9TlPjnIXU6FQwIG9dtwIne/IX4RnryqJ4CJ6ECD50wYKUNr/Vh6+nIMPLWJt70y2P5Pu0/BxTWraqTHje/gceanKx9dtVdq61aIbuXFc2C7E4ufYKeREPgj4dMojHt/kVJgIVQMmfalKTt2iM69p/b8a+2lnwRpVd8gx5zWarlqg4fGRSNtwIkIA8aQ9wt5BsHsBJHK3rkDYM66CbLQSgePuy1MrXT6+Avg4bVDyFNPyfuJNOIn0G2En+VI4qX4jl6Pp9X03XdW1UUrGu1BBVqN0+qynJFKG5rAD7SHl6SyCvuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=uStCa44o+8cjWa8aVw4ZCB6znGkJLYShbPCLNKxj0a9wqb6tb21P7uPWoJJcZYZUHe7ar9DBexmEW5W/2/jRpLGSEbfTmXYe9OtDo9EP+FPKyOP+51+3MPvixWCaFyZHLrWgIeCSgaibe2Ee8+EPi9NjNMUjo4O1fhnQOT23a41RHAfqLBQRRowIMNgMYdOnbQMtCcpw43PNbOlzcOZEHnSaMY7e6s5LQOtZ1Jbm5sLyx/bsPg50EXuGKE03U862lVUg+tNGd0ILELQFlMdstl03zh83BlVPHI9dG00GQAXxXr+u4Z+mtjnr/0k23vFsbl5L759uvyG2keozrG6RlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=vrA+kt3Ge3xBi9kDAq6WZMv1K0nRwDfykRV/T46gCgW1Igsx+3mm02gVVjshZR/F2r2egE7Q9bprugobcKQndO32NVP1/e7U9pkfK6SZW5dFoI9TvQgk7YkUOlSYesI72v77Ukal+n9WWxhJR3fQwV0MAvbgFFOp6JBcOEX2LWg=
Received: from SA0PR11CA0019.namprd11.prod.outlook.com (2603:10b6:806:d3::24)
 by PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 07:56:15 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::8e) by SA0PR11CA0019.outlook.office365.com
 (2603:10b6:806:d3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 07:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 07:56:14 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 02:56:12 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
Date: Fri, 18 Sep 2026 15:55:57 +0800
Message-ID: <20260918075600.2197253-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918075600.2197253-1-honghuan@amd.com>
References: <20260918075600.2197253-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed38007-8085-4498-29ff-08df155a4ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pg4U5Mh0XZQE0w4B8IG1aR5fpGaov/U7VYRdVCgXhvwYYXz1IzdUgQoH8OGxJyTkNG1576iSScdwKnVdCyBMrYTTl4I3KRaLmaE2BZBg+0uRvaFAmhCwnjOyuP6hk0M9UE8Jx1owL4CpF7/l66hVHc30qpQOTY05+KU/TFyX6ZpJW6JUu4gTFEqIFsMYTr3q4NjRvuZ0khTJlGN5bER+jz9sYs9Fz8mJSdut+r6xi/8zjyO1pcs3m6BPGAez89GpQ8Oi3FnpHL7FJ7dhVX8fQJCmdf87meNNoUSC5SrcpTNRQXT9G/Zt+1widWXMPZDtroDEFYyu02v7Lp+Ws+qp+9kM8EeCGtUPV01PhK08YqXbNje7SJ7zqIEodqzgOY3YQUXCgeCaESqHnCaxLNQITCSvUm8UalYeJ7Jpbkp7FjuTqO8eaERsDYgIVzP1yJiouk0jntMpGm+d9KQAO1ch3XHB/n6QmIOUURPB7duN9NEV3pqwSBGLx6CNnilp+9uc1349AAif6lDMAI3/SJcIEEmRtK15tT1Bxl4vO3p3OqzopIj7mjIlOzsvYixLW6naS9u66l7NCK0Zvry2+8TMUe46DlN/itZUcmj/F1Yz2aLGabWBiahx/tvaoTA6AWs/sXm9j8k2J+uVHCM0cyjOhsMt0COuSjjfnRCumuamfTH9v4v+SNJFIPzcAMtEtK3A+yoAEqb8pm5AIuFvS0R3oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZHSyjk6pX/MvDj/r6kgplUqmlPNfLjfMtWMX57oemfxYMNzJleslEcMnrng69c7LE0z8tpz/TL2gHRtEd1Ul/oIzPmqviZG0Dk3ZgU9jKDZK/zZYxn4R1LZH42SLQEe/m/GXRNf9rW9Ib2DEmt5tUY8EuZBNg3W/XaUusCd25sLvzYyC5d4Ijvoj9FnTvlUgc70Hh25FatK9Ql04FEOaCEIyxKDIigBVTcbaFIoD03KR81A2NdS82jLex9+7NtqvXFFmyJXA1Mz3Fj/QgeIEzs0CnCG0a9XC7c9So48gu7SfJbFaXwrwyt1harBMTPE5lsGY4vOQB7FaGBBeOUzDniK0aDjcAqvLOaCENT+VCJpGdqqWT5JDTL7kIpjcmRaAp54jXHcpPalxxhFK33fYOJ0kJ1/Hrw/lW0kNwy12ZH35NPEETFkS5U4cKFXRMJzz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:56:14.1791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed38007-8085-4498-29ff-08df155a4ff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156
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

