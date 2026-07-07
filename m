Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE6EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F40910E49D;
	Tue,  7 Jul 2026 17:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="noQ+b++T";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92D3E10E49D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu2C3yIlJIBkUbmkkdaFmSEKGy/Xmshfxf4eXxn0p9U3neX1XLTs/Nqi7aFDP1vWSg2MCHq1Cwn8EpwLJE01U8fFRkIvb0lQ4ICJwmeHL4fdpI87lpe64Dwp3OYMID94QI1DntCrn6UJyvdOXipWfqzxJsKnbPPkzTauVantHyygVT6FAoshxW9VYnvzFC80+qIaKY/O48mrKTJNwWjBIBn4BP2ZLdejZpKKxcCUhwA6/fB1vNS6XoEHqMFCX/a8ErvG+PRnvJQRlWctvAP9R1q3oAfxjwpucmGKOqI4ERgzGdI/pycRwr9mkn5bzflA1WChWT451fZ8tsIS+2NNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6ts8D7+9Zjq88KEHSBrRTzDS+WLHHzvCBKfwKjfMI=;
 b=iSYyto1wtJ1j5aRjTC3B682J6eANgo3WouBilQgpp3Tr7gxcSecR2GKKxBXShpdThvoxhpH5h3ky4ZdDqtc4+4LkT1OFp6iNueY45WXOX9fqQQ4evKG0fY+AbpaDq9WIFDBz2salqPTfWQlsEEsUZ6IfDqvg5dD1edBJ9Ps4Y3NAIwI4ruYMUX24s9uLavLmjZpzRRV6WSvALnanYIgS/vUdZn8z5GqecHwz86d4wzdJJm93rMElK32PiKeoJp8HxLQotV5Wr7f15ex7rPrqaYzYvnMSGaqx32iUiVxnysSBI1YMr3DekDqOVNDrkhN9tzvn8mIRiQn1v8Bs0lfMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6ts8D7+9Zjq88KEHSBrRTzDS+WLHHzvCBKfwKjfMI=;
 b=noQ+b++TgY0gTDQo3J6Rdq1wP6LeCym/3dR4dhCkc5oaKVsK1Do8KAnDsJTlT1USWDfTVyAT1nCDSZYBfV8QFH1AEhtHsoVmq50PISvP2Q9XKmmaJW6JPoJFQU47usWwmIkLaOnp+K2MveKFOs8Gnp+9W/Of5UP4aQczdmyO5T8=
Received: from SA9P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::6) by
 CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.14; Tue, 7 Jul 2026 17:23:11 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::31) by SA9P221CA0001.outlook.office365.com
 (2603:10b6:806:25::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 17:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:23:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 12:23:10 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 12:23:10 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Check drmm_mutex_init() return value
Date: Tue, 7 Jul 2026 10:23:07 -0700
Message-ID: <20260707172307.539676-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdf885c-0b35-4f1b-96cf-08dedc4c6b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|56012099006|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 0kadhw/4pbcDCCPZ5yXPc5eF4nrZwT3rQdxLI6CgW6PCP7EImktLTRlQcsVaPUAp8JSLZhSpG2FktXmsIqYeksIVpzkUaZhnRyoKW1NsCylcfyd0gZ7293orCAMrB+uWKsxDxPC6PhFozkAUhDXIyitzEHD6OzylkyOAnxVk5XPyJT/j1UTvhQV34PmFt1UObqB1lBP2WG/Puccv0vHY0GnlrBwmYRezvsq7aCTmcdeg7Wl6/d6YcddVAZk8mx+UrXrTakwXHY/KBK+HjzfWAOsL4LPYaqPjxVpZtyHwzu2edOnqlQDltwn4uWbMSo5a9bruDvnG/SXa/irqI+SNYp0c9p79KZwwepXeeL4RKg+47gn4ay18pfEzQpTCpgyRLznRohHB5QLooX4UWX3o0QBwk6rtQj/bw7X9v3DfNJIoEHvSRDYRsLFozR6gg4gWGOGlx29aaloi4QwlMa8VPS0IgHbWCzhYxYUQcHMD9aqyeIbyIWHWZ2abyOR7krVhLm+BYxV8+6AldtWe3otndpvJ3HEM3kJPAUVfEp+ldvASHmbek080CwZ44lNqG3qxm+BOupVBLysKqvgJ4K+Wm1lNFsW/2CDqY9qE/7aBv/d2yX++dDjvNawkLrcs05PhdbcrimIucoYvBaS0M86Wrmsqb3JccB5vww2i/n9K31nZSn6t5q2VS5L6rPXRWgAvYksQBzIreJC/2WsmT2YqUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(56012099006)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ByEWp6A/4ot7pDlQniXnjAWxHFpwDrwtb5Sl0Sw11pQG0SY7fhw5/MCnDweeFfzZEHUCWMG0nARCfje/4KWokRdcNndqpPeyKT0iUf3Prd10lk0tixwkGcP0qtWiodwhC8bTV7BnccN9B2OZOFWL5/ccvXQtZDit5lfO3I0jeGdITMfwo6Ih09Cl8tI5IRjSVnMfgEX1kXhP4DxoKEoEYOO5R9j4ASrlXCscBLt0UVUUDwQq3eCY/+QLiBobmX8qPn0eyJM8LHAwO/lB0RiZkhINigctDz69aqor6+2WYg5nFJoGsIxUOvMmZxd2y+1Ua41kHLEUyIDhoRyGbSIbwAq9BuO/7lxyiqf4qgWWeGRmk5jjIF390qimwRjaAXy/ySdSdqORxGRtngZHBIptmJMFJrUd4bSdo37IVU2DDX2ytxtQ7/DIg1WONLTD1ONG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:23:11.2417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdf885c-0b35-4f1b-96cf-08dedc4c6b8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
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

drmm_mutex_init() may fail and return an error. Check the return value
and abort initialization if mutex creation fails.

Fixes: 8c9ff1b181ba ("accel/amdxdna: Add a new driver for AMD AI Engine")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index e94d8290a807..86e9c230875a 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -373,7 +373,10 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
-	drmm_mutex_init(ddev, &xdna->dev_lock);
+	ret = drmm_mutex_init(ddev, &xdna->dev_lock);
+	if (ret)
+		return ret;
+
 	init_rwsem(&xdna->notifier_lock);
 	INIT_LIST_HEAD(&xdna->client_list);
 	pci_set_drvdata(pdev, xdna);
-- 
2.34.1

