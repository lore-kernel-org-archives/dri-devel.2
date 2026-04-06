Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51371FB5168
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 21:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C8A10E2C5;
	Mon,  6 Apr 2026 21:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="We36B51b";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A2E10E2C5
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 21:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v57mgK2SxlZncMWfIFTEisTIa8e/8SWo3FdEuVQ9LQQdHPonlxWxgI4pxNHgThJY9b/83bihDWed4lbqjKZ7zRouzPnaIJ80u2k2yvBK8tSTlz+U4xRR5Z316Hj0yXl2TpKlFAKyVxdg9Kc9v6sUSshM/ReBCuRq0oDXzdZPHAEYJBiXTyZprSo/ZW6D7b2zx36M5lB0ENJ+blBpSsg7p2uPd9viNrnEX/lC7lCzhhVZd46bpYpYhmwP1FmNiqE6woQuWFtBQVbodtaIClOBuEzlBhH70hmX9xbEwuTh6XHMGLzbbHZc8HD1nLe4MCcY+agxwIIwu2VB0MUYRBprgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMgM1tFh54nV5CsBn5tgmB1ZutIwT34nCd/yU/1wrjk=;
 b=yAAbxrpZp+XrvGZ0b2LJ+wsgwfs/ujdermQS0OZ7UizxoJw0iYSpHojCgcLzskp0oVrwMuA18z7emeVF6RBMJnkyOK7nl/yagdVc/34NisWtZJPLMIrzFcdSS8Jr4en6JcLe2aIUwHZ0tUNo9/hHEjLtbX2rjm0LfnJZ9dvIrvUyjDHIVvwICPFIfjlKcwQmkI4I8jcmICO6EnOe+UrWgAvHqXWSVAuC3rat780W8ZAmypxfWk+sMQ64itxEr38ra/qUEa6Vo1f7uAXlJ6rB0Qrb9/TUN0iMHMMtDBnX/vCtK+cW2vV7Mz1yccLvpyvW3OXNk9KnqiSU22Oddj74Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMgM1tFh54nV5CsBn5tgmB1ZutIwT34nCd/yU/1wrjk=;
 b=We36B51bZ32WXdihF2iu+L4sS4Pat4ReIEmUxep2fqlRToNR2IXUK0qJGhTUowJ6n/ATbp+S9ZXeoPNmMijLXnhoe9y6ubFdcI4/Qq97lIWCALmX40IjLrCjqSN6hri5qhLGvQRwlLX0qVCQM2CklXeMK2lLHSPr6xxasMxXiW4=
Received: from MN2PR10CA0026.namprd10.prod.outlook.com (2603:10b6:208:120::39)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Mon, 6 Apr
 2026 21:14:12 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::84) by MN2PR10CA0026.outlook.office365.com
 (2603:10b6:208:120::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 21:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 21:14:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Apr
 2026 16:14:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Apr
 2026 16:14:10 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Apr 2026 16:14:09 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: Handle DETACH_DEBUG_BO through
 config_debug_bo path
Date: Mon, 6 Apr 2026 14:14:03 -0700
Message-ID: <20260406211403.4011988-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ffbd04-0b52-47f1-7575-08de94217333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8MnxQHN8Z1gE7rAWOPMW17vSBTX5bpCTqcwGMx3uxoiOyuvuB521DgfkkQTIXOIWV23rDSElzAZlcHWdzAJt3gfDWcY/jiycrRdklZfHQ3ky/qMHjUNUiAZzces8WoiCMz9LJMMKNwexXDSDS+e/sIQz5jxS1Ry9Q5kKoUR6T+CQJ/o0ELid3PGSuY1EdFfhg3Fds+tvNA4oL2jL4ZkpabM8PZTiZVjk8DD82a12KD8ylxzYQC6uCD83jrDzkwSVNJM1XEtbtaXDrscOo+XtkY4Tzbc0zHaXmkbPpverXDSeWt0fIEs4cc3qhkA6YTepB3oCcNohJY2qH9Mvv9JoZb7vN0EM9Wz2onljkLH8whJ1GTL3vuZ0zlGkTugQuJo0J+Vz94Spt1HLeZQYiRxVZIBTUlss4AmXkXpg7GbSGVeBr+nbovE3KnXhE90rujmJmF08czDfIMiKa7WG6sz3rcOQE+ocWk5uS49r/TyJ8kALCAuCUDVG7Gc7dqVeG94aL+09Ntx5o/5mp1L5FSjnc3giAZD+Bx3xli3d7zFHhk3tsaLadLtnnSOaCq6XKCpnqe07B4wg/uv0m43Efa7XyuUhQD8KxDfv4iqFE7/JKoiAr4FFMma0WNPNydo57AKDjMVZsesYfnQm7D04FEP+famDOICzpNEuaQvQIqUSpJu3OY6zQVLvJa20Qh3A/b0bRsp9UWTSjYbxW0lZbuw7IeORsnMBvDd9Decyzwas0n3jKYXnQ6Zmd5G+Qua8DkxD4wR6p766rvq3DijZWlrUmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qZDeiViKb5OJUUkKzqd2h4eGNXSk2g7fmB4+Ez3+TMiiyK5krL6ZiwJgoCv1LuIr3FOi8z/tOtaRHDlduwuSUR+MSWtAjhocnGtyNKHsqAjZ9iDNYM56lxoSY0M7nrQS7thl65crBWRJtBUP//8PCEzB/s/nPstajF9CwNdc3K6SIOSREfKCXfDj8BKgnACRhIqwTlMHQPFJCc/eulfh/KNUZ2ihVsf+oQbXfVxl7VH0Qtbe/65oen91YfbyzwskhwmV4QyemwRVTp1awTWD+Kbi12Sm043Lh99bocONj55DNR+z0la0Sa4tG9A5GBhMCdAFz7RoOszux/36SlGEGOlvQg7kWfA2dzwQCEeBDY+AfAuJxSWFHmWsR31kFcM+LFcefVA3GfHhNERj7nCCUr/uFWGd+vmIWB62B2XUGdVbD17wj0tDzLEZr4HdNJnx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 21:14:12.0293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ffbd04-0b52-47f1-7575-08de94217333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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

From: Max Zhen <max.zhen@amd.com>

Route DETACH_DEBUG_BO through aie2_config_debug_bo() the same way as
ATTACH_DEBUG_BO.

The scheduler switch in aie2_sched_job_run() already handles
ATTACH_DEBUG_BO with aie2_config_debug_bo(), but DETACH_DEBUG_BO was
not included in that path. Add an explicit fallthrough so both attach
and detach operations use the same handler.

This fixes debug BO detach handling by ensuring the detach command is
processed by the expected configuration path.

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 8db32f8e2362..c464cf8024c3 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -360,6 +360,8 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
 			ret = aie2_sync_bo(hwctx, job, aie2_sched_drvcmd_resp_handler);
 			break;
 		case ATTACH_DEBUG_BO:
+			fallthrough;
+		case DETACH_DEBUG_BO:
 			ret = aie2_config_debug_bo(hwctx, job, aie2_sched_drvcmd_resp_handler);
 			break;
 		default:
-- 
2.34.1

