Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0DAC5DF88
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCF610E23F;
	Fri, 21 Aug 2026 03:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m2DwlN1O";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8247510E23F
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 03:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCCe/LmQN6WnUSKsgF86W3ZSx2iSPTDCY2vYJgexqDi4nBIGNJp0vQUkf1aOCBkFFwQ1knwAng1yaWwcKXppeBxGf+2t6fIyzhOk8ND8lDj96rGXnmjObK6l4arwMV0Vpr1KWPv4y1x/E2msUTSteX+0nmoXF4dxnGB1pOAlrwbkDpb48MLfTqNLCimvBFfyFOsWdGClS+sUV2wL46pCFHk4UWC5ezYox4y2vkCOrTHAaDtVpGSxTFNZ3OD4OBnY37Whd0DMo0DlBsx4yH1TLnoBJKNWDkeCyRPv3SQtuJ55OyejXw5xeeaDRGW5FyYDdF5RoQjo5ykzCSej0hkSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMvn0kTw6QVZaIwgOpN9kofjKiAjbdwIonH9ipOEuic=;
 b=h+RA1BnasURU+TlNm1aBgvw4AFTnhaQyqIcrbAZqM/yaUALfmEmExDYv7q2ra3pFqhGn8Dl6qThdnZh9/8LAWU11il8J0MpLEPGmU7aFrx04oA3Sb60x3dPbN3goViYcxKhAWhw2Mndm/QrhODh2UJOuWdjkAu4840oPhmTf1uWiQ4R17RtYK3BJVriMtVUlo8r1DeCcuEuVEgNJLJcaHh/Kf082e3bfD2b6xAOFZ8802Vhjq9CbvaKTStGum2zZAY/ebMrnrukbOToMgz8TeM4CmkDxg5naCPCz/EWybwje+QFe3v+EKIVvBcXAcTjeOXRBmBPO4/Yf/nnX9ZRvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMvn0kTw6QVZaIwgOpN9kofjKiAjbdwIonH9ipOEuic=;
 b=m2DwlN1Ow91TxrzLNtrmSPAbmfme31R1fbsQu6vHu+7y689vV3PbYIm3AcFX8LnVPEdC1nBEjJL6bbfX9xSny+ldyQaEufSBQVGy2SFewLtGjuCBm5Lm9eYZaM3v1WDMiAcqdyZMKVgCqfW41639FsT+p67p3U44S5Le7aYq8GQ=
Received: from PH8PR02CA0029.namprd02.prod.outlook.com (2603:10b6:510:2da::27)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 03:35:49 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:510:2da:cafe::3a) by PH8PR02CA0029.outlook.office365.com
 (2603:10b6:510:2da::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 03:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 03:35:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 22:35:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 22:35:47 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 22:35:47 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Remove __counted_by from struct
 amdxdna_cmd_chain
Date: Thu, 20 Aug 2026 20:35:43 -0700
Message-ID: <20260821033543.1839719-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fd54d5-db5a-476d-6963-08deff354ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: TVYiKGhPKY5zUsii86mF7o6AA553Wx3XwN1Jh9A3b6EQEVo0MtDMssOBvzrHO5RPT24yZUDrXwc6cRevul6l5MS901JQ4LlE/OtKYdaTX95EVoflSSxvDylBt1x54V+pMw5yJK6HFprt6/P7OTPmMyNED9WhR9OR90hzyipZsUREf77wCtnkAejHvU2ORodouuYSzTJans0RgoY1MvkxQBengWCkW9gGeIgH9ZgdiCMNfgRy/WqiWE4knDoP1eoAWFbIPn+h/trLY8vVyqcwe1y6RXXnhajutcRs99v1Beo07sQHGBFOmnpzq5YM+3UguMVyNhnfqRZbYNXEi92586b9n6tPYQNjAN73+NuJawDWtpYBbD0ecBKPEkBhAUPvVNzTkBw/3p32ionvPR1V0srlHs1cUuaUUxuRtLfrgYuH4tScJ7/d5lg7Ar3rBJ7NwH6jYhnPoNoRiYLSLyhdDiSNqDoiOOD/zp7LKBU+KgtEzQtqZQviOG4HBFCDYY38Bon2aYGha7t7DkHcViJuqILzI4wD4jFYgqCl4FIkFPe6O+Rjx4nnGtemnTPFKc6P9uo33kHNicVI2W6HEIE+PbdseizBKGRGuaQqhjRzSNnWWugL2cDiXEbhbfHSXWYwB7a4aC+zDemsIpYrfvo85lMMRsH8zqfl5Y/FCOmgcSWtZlaDlCekvOD6+P+hfz+re+Qfozvaen9FG4IPgUe8wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xh+altdkv8Mjf4agwvMmu2GnTcepRgYTWqasDhEXrMrgDpsz5Qp7Wtz32oF4y8MWnS4UYkIA4/iFa2X08gg/khr6FBfc29ekSBAZADGhgAK9g86IJbG/2s+Rmv0P+oMSnUQ3Tox+i9An7sgx2ZERkzR2r7h8DqHU72V/vhWxIQVVVbE1WpaWVpU44tLnvcDEUUucyNaq+LNvh443z+fCzcclb5R0TMjraZK7pK0YbHitTQToKEiRqUzloAJv22L/kYjIJQ1l64PozD00d55ScFHGaRzj4hPQoa2xKLUtKlcfKgIeBT3z7MerSYFt5yCSasuBLBbCIIaCLAhBbWN+7na5wmL+2RnUkdelj7OrNy5ofCyKavG7+AyKoLmrDl164pzrWm0v/pBqYz9ns+7pdoN/3umYikk7puXieWEdlOuHfrBnuq7Ja69l9G8EA3Vy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 03:35:48.4123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fd54d5-db5a-476d-6963-08deff354ab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
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

struct amdxdna_cmd_chain contains a flexible array annotated with
__counted_by(command_count). Since the structure is stored in shared
AMDXDNA_BO_SHARE memory, userspace can modify command_count concurrently.
If command_count is changed to zero, the bounds check generated from
__counted_by may fail and trigger a kernel panic.

Remove __counted_by to avoid relying on the userspace-controlled
command_count for the flexible array bounds check.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index e6155f4b5db0..010538cb05a3 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -56,7 +56,7 @@ struct amdxdna_cmd_chain {
 	u32 submit_index;
 	u32 error_index;
 	u32 reserved[3];
-	u64 data[] __counted_by(command_count);
+	u64 data[];
 };
 
 /*
-- 
2.34.1

