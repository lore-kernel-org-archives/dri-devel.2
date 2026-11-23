Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B526B606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ka/WZfDT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F2010E802;
	Mon, 23 Nov 2026 17:12:53 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BDB10E802
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bv2ZaKyhhSXliaXcMoGdiClgn0SLNeMFoiH/26vkb/eVaClMBOeYSM5X9Ddvj7evo21vhQbkPuFWGowfUxnVzR16Fl4KqCvnJ5RULx0MYawMuMaU/JLyKC7sfF1dm1SCRRLASWki2oiRTm0GwuQ/D5xo7HEyNl/jJqzhJYi+5/Qi+4YX0dWU/M4/X1co/7dn4cuDh/g8pDQwERL1WrCw/svYKlK0C22g9wL5mQ9jb5ypebHOqLrltn/L0nDkwlSCr9NFOrZn/TCeusy70NSUNdcJ1SxXfc2nKljljRFrm5r4txcMGXaxLzMBreaEy+e2d792Ysj8D0uhqMRKYjLwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpLoVlc9tX2Rs3QCeBnRSCtER7J8w7PDQc7l/1ziU0Y=;
 b=HxWWYE4m5oruOcL+NytkeJUtRGLrdcuNG9Zbr1p69aawTkKdfCiol4KT4iwtjBp3EcwW/dK8b/I3hjD4NhHSmsAGXt7oKnP49gNSIamjBeitTbKf0VQyZEq7lILoxBV19xG2MtV32p68BRFuqe7ndF+URNyXFHrM9lEyYKgjj5CxRhMGt9C6/8iYcxB9nrSgXUIM5QH2AO7wEoKhKQjPbgkMLREhj+4cmlLG27/tJkJxdO8OKTLPPHCkYwjCEEootqeBsXg+v4LIptz5fv+LJjHNRbj/cumlIOnEvGAVGKugNiq7rKVWG/OPPHfx/XZc0FmbL7eJ9GZPo8E3tsJjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpLoVlc9tX2Rs3QCeBnRSCtER7J8w7PDQc7l/1ziU0Y=;
 b=Ka/WZfDTruC8pvTb6oY55pMjQJ++x3SrmqwKphVdL6U3PE4Q99LdWShgi1CgBwKmX+GW7Fg3fTRtn4G63DNn6uvLYmNMJh2vmy4LADdoK9XDXp0jfF7IIIYNlMYTomUiOF/9swYLa9ACh1AAa1yGqczRxgkvIw0JTv3P66OSnus=
Received: from CH0PR13CA0045.namprd13.prod.outlook.com (2603:10b6:610:b2::20)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 17:11:30 +0000
Received: from BL6PEPF0006C3DE.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::3) by CH0PR13CA0045.outlook.office365.com
 (2603:10b6:610:b2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Mon, 23
 Nov 2026 17:11:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DE.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 17:11:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 11:11:28 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 11:11:28 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 23 Nov 2026 11:11:27 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
 <phasta@kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-media@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] dma-buf: Reject attaching a zero-sized dma-buf
Date: Mon, 23 Nov 2026 09:11:14 -0800
Message-ID: <20261123171114.1451429-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DE:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a81d7db-ef81-4ff0-5aec-08df4984d0b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261102130727099003|261102123227099003|261021121427099003|261026121527099003|261022075727099003|11063799006|5023799004|56012099006|10067099003|18002099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info: H900ZZeSLPWe/vKLEh3w2YQH3hSZREIqNgZDBn3hLTkSzIiqzJI7HDOR5mZ9OrM28RaNqWqLrxUDuROf81iEpEFKROidEL2R55/P8YMg/EzHlOAqLTLikoTWmNzv2tkAqnc895Me0Q6djzU7qCe8d+b4NVPRXz0GwxnGdd9OFNuS3oS52JNu5M6yF7V155jg3FADiMwbot3O9aZAMniuUiMMmqmV2k1r222LPv1RWq1C7FDZm7igZ9JUEdDVe3iFM1Ec26bRHfdp5MpuKTNdTSq9Opnj2aDsdxmqgp8op63qO/egFX18C9uN8AtsBt0J0Qd7YaEugyfp72lTO/zpcYIVJiriv0ZYTxM2fEmgQdrPbH9u0WHaZZPjZy/3b39S+vlr79hrZD0hWLhVmvAhQ71fay9Q79vxjwy4buIOch20CV6yf3GSqn/LM74IG6OgV7Oz7MsYhyJyGouJn7ghv4DZR3TNKCjPip9O+PKdz4sV7bAX7e/BX/AKYUscFVcm5rTMQ5hP4oh3EKRvnL1HRK7F5Dff5a+2fyz1O5e3+lJ04q3lWklrVMP71bBwXqE3tXmLON7ibRkVl0xn8roWjdDUKGFefr4nPHgLsALYmpD+yfQgrinm2bxFJUNyZ9FOUiCIO1xN6qpcciVtOTfL0p+hOHXfAE5vdCQi6WSXU5DogjpXEfZuXPhTlJweQjTILkdNUaKtRkcsAJTInC8zUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261102130727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261022075727099003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(261009223027099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U4lsczPKF5fqK5yrg0iOeErowwcAEZtjNmzsBwxSavlcpJUhXfQaKngLCxeus3CUNJ1vK6lZvqGpaL5S1WnuZDumno3NgTmSKtvjt28ixT079KUeYWBKxvzv9OHjw+jNkIf0b/+/ojhnOYXqlMOxxjePSb0DF/EYu5HtGas+5eh0Ws+ivS1sXk7dl7Ti5+MhJ0/c70u4X5NWQ50SgsToKiEP7e7NzCd9790Ls2dEZmS4N4I1Q9SceIT2z5xaUblv8goIINO4JTbfffWRKt/9tjbLhAwbrQfmVIXRM+Wg1A4LlExiN99LoELcBosr60b6KdOXhfC9eziv8BfAtEJqN9lp2GPqu3avy+9x6tgfyIvpdwOkWTbhF5GnMExrmX9Ozc6+Fw+Y0nvVeprmElr+gnlCKEQA1UotBLFOT6xKlr9NQCtMYKes4UvzXKncg5ap
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:11:29.5338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a81d7db-ef81-4ff0-5aec-08df4984d0b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Attaching to a zero-sized dma-buf does not make sense at all: there is
nothing for an importer to map.

So reject the attach, using WARN_ON() because a zero-sized dma-buf is
an exporter bug that userspace cannot trigger on its own.

Adding the check to dma_buf_export() instead was considered, which
would prevent zero-sized DMA-bufs from being created in the first
place.  It is not done here because drivers may be using zero-sized
DMA-bufs for driver internal buffers, and refusing them at creation
time risks regressing those users.

Fixes: d15bd7ee445d ("dma-buf: Introduce dma buffer sharing mechanism")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/dma-buf/dma-buf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 5c6957f8839a..8be7b6023e4a 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1050,6 +1050,9 @@ dma_buf_dynamic_attach(struct dma_buf *dmabuf, struct device *dev,
 	if (WARN_ON(!dmabuf || !dev))
 		return ERR_PTR(-EINVAL);
 
+	if (WARN_ON(!dmabuf->size))
+		return ERR_PTR(-EINVAL);
+
 	attach = kzalloc_obj(*attach);
 	if (!attach)
 		return ERR_PTR(-ENOMEM);
-- 
2.34.1

