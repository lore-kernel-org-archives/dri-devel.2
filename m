Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90E9CD6E5D
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 02:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1511510F79D;
	Wed,  3 Jun 2026 02:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uxNiDR5t";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4B710F79D
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 02:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glsFnIOyszhKHh/xZQtW3lE7qD9wpz8a/8Unw5UjPMEjRzH71Y+z4mJ5V3iGe6pLiI6d4A+ELPIFPq4+V3awaDOEROCu5jTpV84+R7phpqCfaBTOoDd2f7K4vrG5ZWXNjW09OIHDvUvFE7kQ5ARBHyihzkvVL9qjpRUi2eKvk/3pVCzdaXCPGjxLqN+dwB2fa4bHgNPhR/NhASxhym9kOxOH85HalRpxBctN5hguEaSGNX/XMkicQtOeJc34gHv2sXQsnpSB9hIzvLUKB8w8QkrW3gDv1+OizLnJ6Z9wZbPRGXpXTOfphC1TJpVI1/MIWtrcsIF4GEQJ7TWMPInRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MdaQ0CE7LMAQDRb2fDZ9OgyIPkbZNMQKdvDc2LYjzw=;
 b=pREFgyq8TSOkxkQOOD/qHhG9NgenwWr1ad6vArlvPo+D7cYtEEvDBOp+bDWsL/DuZ0qHYBM3akOAhVXG7DVdR6aKLRgyTRzLOh2/thy/2BsA2pw/jBM0pLR4zQ7XYvrx64Lb6tNJQAsj449pQiMvwUY1S4E63PaUKwzPoZngU2BWZIabv1RaUdsOD4svXU9ZoPRTyD4pSfwFh9Uk66aK9uaVTkjl2jko9TsWdiJATWPTVtQPhcYw9il7RuSTOH5yPgq5ycQmlY+I6e9n5sNtmzHqTtOmpbbTv+3oZ7I0lI52Ep/B5BX8YBMtZC2KaFdG3DU8cPKw35pnv+X9j6NiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MdaQ0CE7LMAQDRb2fDZ9OgyIPkbZNMQKdvDc2LYjzw=;
 b=uxNiDR5tBQ7ClIQu1+7QeNvEtXIXxY7ucNrZTUI4J3NEYSL4HxQIquFviqmixf+hfURJcFc2UjqzRaW2qJsau2ctmayZ6stUH1SbY+lO0jByI10TCAkoCB7DVO1q0cbRevoX+xUZWyJmDuIciWU8H4e4HwAeT1jO8efWNlDGldI=
Received: from BL0PR0102CA0002.prod.exchangelabs.com (2603:10b6:207:18::15) by
 SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 02:56:56 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:207:18:cafe::65) by BL0PR0102CA0002.outlook.office365.com
 (2603:10b6:207:18::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 02:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Wed, 3 Jun 2026 02:56:56 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 21:56:54 -0500
From: Candice Li <candice.li@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Candice Li
 <candice.li@amd.com>
Subject: [PATCH] drm/sched: fix NULL deref when logging missing entity runqueue
Date: Wed, 3 Jun 2026 10:56:36 +0800
Message-ID: <20260603025636.1301481-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 33abdeab-7399-4733-cc89-08dec11bc5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Wu45R4Lv7R4hEjkVojIpfFvzPai3awx2ypjog7TXMypDhydn3Rs2OcFH7Z0F5kbEQEps0zYbwz0IDYdHlqGtMAJzSEyYEZ3htMXsSTPfsI9zmZSLuepCW3dAXCiFDYbp6c0lKrwL6HbbfkcKJ5W3ZNTq5QI0HFtYeonDDExCztqN15COHO+hbyIqSFxBm8SX21bqnYhjCFRwjRqEHFsqNvLmOlrl1kCLzkUMyjSquvv/qS0jtjS2do2AMW3IUcdDYzyMCrSdmwMrq10JrBr197N6GnXgGzn1Al1QIAZys7q0JITt8QdxvjCmF+jWX5Uw/PuRo3PjbYgvgK7yZtJvByeMncZyicYLqhwuaHj8FnfuJybuWO2wmliEN4IIiMP44ABDqi7bzqpv+0RuWioDX6MMmjn9jOP+I8UCfpRxFqAcBiGh/R5xZgONM5Fke5ArHYY4DTHvCaAxTsRD79tXOUvMtbF/+8rr/4yjgPI4pAQVZ0BXkNoi9AhV2AXrYECjLKBipGfn+rZC1eOZANUAR6ofcdIArBp+JXcC8L2ZMdQA47W8DMHTG7HRK793VFjjjMGNMDxVNznmq0fuW+sMcCeZHmooucUCFLtZ/yPCAu/5PhdplUU2HjZQjlEbR3Ge1WSsiSj6ElaNUyK7LdxUCsZ2Aviig3bdkNBriyXG9hlnbJhAHA4aMSi/lM5ugrc0+pyA1wYHlId1OlvqitBkmyCS/HgsuHCXOxvKLs6JAhs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CwXanX6eNXczQemQUYv5XTPrqnx+4OqHXxQT4sOOKIVhwZr5TMZ+P4Oc5asBqjaS8DlNYqw39QAPCW4zQu1Pp3mniebvVVISYkAYkecKhBtjuGW1gplalNZTCzclep2p6tPCSTWhx/H5bkdgcO86um9QBT8KZeXsW33CWjnLj8REvIaP+Z/vnHDKDkn7boRpQborOlHu2xo1023VyffuS2IrDXuupL+ZyxR06PwLrvB16qFfiuxRI06FI810OTu0A2WDWBBATgp/tDLiPtdJSiaZ0cj8vblO0hOc7vRHkyhMtSoYyU8u1dncgNPEcWz1xLWPXM/iu7DEa32C1oFi8/Xef6fnpeJQJ7OJkiTrkWAfWX+4JG0rLz1ENENdlV+D272cIDeRrmAtZaFoSODfKwOdwXKboSH3NCTTObBBkqNJqR++bA1xEwEePhPqbsLW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 02:56:56.2150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33abdeab-7399-4733-cc89-08dec11bc5f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
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

job->sched is not initialized until drm_sched_job_arm(), so use
pr_err() instead of dev_err(job->sched->dev, ...) when entity->rq
is NULL.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index bd7936c03da2aa..d21eada76cedf1 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -806,7 +806,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		 * or worse--a blank screen--leave a trail in the
 		 * logs, so this can be debugged easier.
 		 */
-		dev_err(job->sched->dev, "%s: entity has no rq!\n", __func__);
+		pr_err("*ERROR* %s: entity has no rq!\n", __func__);
 		return -ENOENT;
 	}
 
-- 
2.25.1

