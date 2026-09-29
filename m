Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FB0CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7753F10E1BD;
	Tue, 29 Sep 2026 18:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Nv9pbBm";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8EB10EFF1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 18:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mD4PvDU1FPYNK8cMsze5wI+lD6g+V1ZLqUBQy3r12Zz3NERsZ4bHw4m3ECsY9D9OfVZWCTeuQ6yQPlDgVYgCJmT0dnOM7im15gdjmmbjg45L2FXVWcqEjgbNzfl+hhUgYXdZTP2wqlSl/iKDTUHqN1t9Xy+gQ/gVXS5cpMcxLZxy4M747PzI0dyvc4W2rDbP3AYGmi2DJdPJqgLbt9lbcA6lhxkASgSnrNHKbuOSToEcdLL0063msuSa7cMjbsWWcttOLeDtPM3i30vtoZvs8EPvAIiVaiK+/MFUsg8mSrgM7EsGj5qbv7gfpZ6V9mJu/Q4rSN4MraEWcRknmam+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VG3abgAxwAYOTW4P7Tv1ubniPMRBcEIqEiWuqXvvaAw=;
 b=v+QNX8SOTk8Nqfr+x8jW3zLEHlm5iJKQrcfO1hKm65M1V5AxdGUs3OIZS1wAdoOdHO0QACOkaWazLqaczHQPQ0ezViNVegQ4SEUHV49gSj5HcgkK/Lao24lRkkZXKaD4QGU9m8F40hkSDdOBX0Dssjc2IgdpRSIRfIg5iAeV2I9dVg9qPHCTGwfkF/at57cwwtXMhXTCbChp2kKkntEtCAEYtHD0CL/GE3aQaP9KiH/sUs716iitHxkAayPwf1uJRvp4zsd1ksa/6FgA2t2Z0ipbxbNdU4p3wAzk4ksS3D8smnsCvXGj2nrWzQDwGFZL8G6v5uBoBeA8fMIdCi6aiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG3abgAxwAYOTW4P7Tv1ubniPMRBcEIqEiWuqXvvaAw=;
 b=4Nv9pbBmj32ARBWkLjXYCP9eCsaJkcOG1bLdASGD8vSDO0Ba17j6SEILjhPQz65X49dnKJVmIxhrluMEgyiKsxhZ9jRCjq+7k2iEH3WqXCjjA8POG57F+YwB6YwJOT8P7L5megXF+GvqkgsZ15WOykJUIMp+M+IrSOR2ppLPDCg=
Received: from SJ0PR05CA0079.namprd05.prod.outlook.com (2603:10b6:a03:332::24)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 18:15:05 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::26) by SJ0PR05CA0079.outlook.office365.com
 (2603:10b6:a03:332::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Tue, 29
 Sep 2026 18:15:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 18:15:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 13:15:01 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 13:15:00 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Add support for AIE2 revision 9
Date: Tue, 29 Sep 2026 11:14:59 -0700
Message-ID: <20260929181459.928468-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 1010b067-a8a5-4871-88bf-08df1e559600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TZap/afYlsQVmT66cTR5KKVMuFG8wefaegJK3BuOyegXFxmK2pisQkpJNtf9435yMcexzGVF1Ms5YAKiSvr/QAwHV0WaRQy/y0kqGNyk/GXos0+h+ibaFNjfP8yUPjV+jAJZQn2yYVtxqjgCu6asajQIM66r00yhCPvPH32Ne7sl54HPcdPgMJ8u17w5qXNqPDUuVUWWwrUvb/3i8+R7rB87OmNsGtsmdBzwTBhzp2a2Fsk+WtmT42nMhD2vtk6bMlaMLUbtsCxg7PdypjUCLmFHrAtrAvsLzLdFzcU1ZmdigjNG74+vXkAH9f9SVpZIN+6aiakJifKkCCj3u/f55Tn4Er0Nd7Nb3FdAoGOvTYccOQZp5zlAMZJkA6eHU4e3klqXqY7WAXsybmL6CDe3eZwLMua5SXfOqlfvdVq1rBkZ8C4frnd6If+8Wdv3Kz9jLcEKAwT+wI+H4HMQ8tuSDkIBA1PXNwS8hIQrefa+LS3bksUAQvkiI+7MYi3Q/HPb3f7f7OQ14iwmQw/HBZ33pFEblMvUd7CFNtherCROAShRFwqaxPR3Ey/JaPP7O9L6S582APUst9Gs+hTk2g5rSa4tBKeZsI7jNvoB1NWAMB0+s+DUZR/e6lnvjjpYTu5ZPzw5ko+Hl9MiHkWl3h+jYb/pM7F9DJ/nV0jEQH7CSH2TjZcRH77DrXqyocGj3v1tbfNJB8xL+M7ct/7bbtI+VA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +jcAmjuvSVvEDcznF8xRJl3wf5psAnhS2rWYLNIZZY3qY1aqDx8MmI8y8qBg3t1gdMxavVw3Jnz2oBpbykdMAz2pGavEojc6QSr5WfFsC9XO8bkJ85CFo9aSIgIJQYhNs782dO+1LVwO9yAVMWT4JUHPh8BAs3BJFGYaH1yLnDATKHUdO/j/p6ifmH82XZZ1ET9LdOMcmW97DWZt4o8yhfIGa5VW/hEmsyWMNU9scXpbVhkDJ4ZEKMHbG2oXbAMTawjVrLs4M8RjMIhVysacrLvZyNRPgr8eojxCttRqOGUylvG3RQSv3/3EIy91ISP/3yis2MSTqjdhKFLgIhH8uoToOKGaIW3Dp0zDlQszhwKmJUNhahK09zEKsf+cKo8WIfIyLJKMkbN73K0Zge0dlSjpJrfU/vSfnGtrOiUirmvf403/xkyAOiEZOL1DjrtT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:15:04.6732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1010b067-a8a5-4871-88bf-08df1e559600
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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

aie2_get_dev_revision() fails to recognize AIE2 revision 9 hardware.
Add AIE2_DEV_REVISION_GRGH to the list of supported AIE2 revisions.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
V2:
  Fix sashiko comment: add the revision string.

 drivers/accel/amdxdna/aie2_msg_priv.h | 1 +
 drivers/accel/amdxdna/npu4_regs.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/amdxdna/aie2_msg_priv.h
index fd65a4236d49..8ed2b5701dcc 100644
--- a/drivers/accel/amdxdna/aie2_msg_priv.h
+++ b/drivers/accel/amdxdna/aie2_msg_priv.h
@@ -530,6 +530,7 @@ enum aie2_dev_revision {
 	AIE2_DEV_REVISION_GPT1,
 	AIE2_DEV_REVISION_GPT2,
 	AIE2_DEV_REVISION_GPT3,
+	AIE2_DEV_REVISION_GRGH,
 	AIE2_DEV_REVISION_UNKN,
 };
 
diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
index 15a161384625..c9648c8032ec 100644
--- a/drivers/accel/amdxdna/npu4_regs.c
+++ b/drivers/accel/amdxdna/npu4_regs.c
@@ -153,6 +153,7 @@ const struct amdxdna_rev_vbnv npu4_rev_vbnv_tbl[] = {
 	{ AIE2_DEV_REVISION_GPT1, "NPU Gorgon Point 1" },
 	{ AIE2_DEV_REVISION_GPT2, "NPU Gorgon Point 2" },
 	{ AIE2_DEV_REVISION_GPT3, "NPU Gorgon Point 3" },
+	{ AIE2_DEV_REVISION_GRGH, "NPU Gorgon Halo" },
 	{ 0 }
 };
 
-- 
2.34.1

