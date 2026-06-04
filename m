Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02835CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F5B11A2AE;
	Thu,  4 Jun 2026 19:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z4UdS34Y";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E9411A2AE
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppfB8XfhJgylBapkVf3H2GWMIJ3urEwKTnbDgmHrhb9aj9yOrLQGMsCO+KSCvBNVEJR69mPUcRnxVyTYdsonH4zhgzc0XyhJMmHm8nItF6aqfCtV0djSLSwW0r3ONLZI8vdtm8nHH7QLmkMR341MlgSACRyghb1BTNig1BisWZPM0ypBAKIWtlJk46U0ZiNlMaKiZElCJwq4ZLQ3U107gE4BiLRaQZCjiRCCxAF3dOt6m5Z2LO7TD7W6oiIzitGbbEEV+XsJlpue8az+vlnQQWtpLNS4d7jZT7jZV1B/I9U2vPmFVxo9oXs9SD2RfLZDDCav+UANPmazrPHHeQwqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIueK43LqEzRajox4dcd46oerqNI3bgmAC85EE5qSws=;
 b=HxPFjJQf2sjhafdmLkZf5qoYKd/iE0NNRCPPfNctWNuj2AvLCCq9CcNHPNpmteE7z9lPIJUUzq7V1J0O4RGra7TWPONtIwZ7ZJONLPHK3Bx62YDMXIiJbgq1oSf6G8G2MrrhNFwQwQGzx3EIwXN0vMv4bbsKMn5bG2wXNCbIn3T1gfIot1f+vkQms93w+zbU+HIXa+pHxzr8fN9BGjErLx3mWXzZ/hr+RabNeiprJ95XGDZ2Nn0YgDcYcsTuLNwLzWODgOfagc4eUApupv3EP4jrMfSDVjlHSR7unC5OnrmbqzBJo9ggDrCSL28D2AwweH/6eH6AdmE35CU555EpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIueK43LqEzRajox4dcd46oerqNI3bgmAC85EE5qSws=;
 b=Z4UdS34Ype+U3sYJDNk409JX2+f40WB4N8IwLW35m3TDTymLqwkJJIQiqxRGSGA6595WhBzb2UVUME3EJ0WofVBvKqBadhmb5FAt/9m+K6JC2iExrnVIe5/+JuWwrvdHxXyWSb/2JunBJu1FCEXtv0tHrS83jlDzEbE2fKn72C0=
Received: from BL1PR13CA0241.namprd13.prod.outlook.com (2603:10b6:208:2ba::6)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 19:55:06 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::2d) by BL1PR13CA0241.outlook.office365.com
 (2603:10b6:208:2ba::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 19:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 19:55:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 14:55:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 12:55:01 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 4 Jun 2026 14:55:01 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Require carveout when PASID and force_iova
 are disabled
Date: Thu, 4 Jun 2026 12:54:59 -0700
Message-ID: <20260604195459.2423279-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 44608f78-c48f-4991-533a-08dec2732cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099006|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: BBissO5q7Hk/L98roaoGk6wpTJ4zngXsrq+cK4v3Bf/apKMCtoNZug6JxUI4JjFxVUG3S09kqDFucMDjJsoA/L8paUOJ21ihfMc7LwzJSr8ydlEudqyk/wQIoxBmjyXquGtv5fqmEggZwfEh7GdIwxNwK+DMymRglhxrMD4YQ38C4hhM0z9kA/OKDP6eOcXc1Sl/KlnwgIUH8S3+r7BnTUmdZ3mdgC3/1jPxxfjD5L1+sy/T2pmn3GC78qKbcnsnCwNRHKP8LH4pVIhh7iZ/XjL/slUJwW/lB6qkakc+poWBaIcelOSo8r2vL7aRwu6GAq00H8TYCXXJQX/uWGwrV5rVQoipPdGuLUGLvpy2QtR1MNk5qdGU+f6gn2F7nreHNwDb+S9D2NNIPR6fOman7F0zFGUfx/wRxBZqB4UHGt2U480YXEBc3qJECFX+a56ZGAXDCvFuH33d/NjNXZHqGtcwWk4792vFnxWbeqR0nDFIDISuWaalH2bFqTzf/wgd6qySQUoR7NWkVO+hqAYeu2GSyR2dLjcpu/hYR1sfu+A6c0ey9M0kzbDLpKhLcKnHt2CPZ3d+Xi88fe0BVNY2voqqS2INK4H4SGK8nc7pf0odkgtR4SudajOHY+rQDbdI0Onr4Y4OT70Iv3u/Jv3n5kUoaa15z62Z0NKh3XrUiH4iBJF354LSG8/jKlMuwhd8CSyyJB21E8Ne/9BX315XEzLmExja5lQYDCz304Cb57E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZEaQvP9KjWL7asrHGISxgWT042EBOyZ8D6/HKCHlMpZzVibnrosMw9gA1+Dfz1hOgpzi+NP6gXZgpZqCKp7Yypm/O5477ij/9IpZlyVUACQf0QOp548yhEF1TeKc2+ei1qLusoc/gumRKx/xow2alU9BKuK4CjpjsrLbzT0jz21sQWFi5wSGzai7KIUCR3Y+0IJq0qQH/2zxo0yt/rJHz30GTwc5EzVlBrKkIzsrZwZtj7m6hEQTAE4dOdHZmzwYeihAx7KZIKt75W1WWT9h14O1zYyH1mZN+/VoOEG06DdyALxnezh9xfmC/RG0r3YbnqhjF5R97aqDV+D10vxA+d+LN8M/seyZfL2QM2tjDMy1v7rnvoJsL56+uOG9rSRFSIpInMJUBtOR1Myn0UzWVsSp/sIZuJ5jnvQBMtnLSKb3ODWpjKTZOKKRjVfp0t/U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 19:55:06.1102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44608f78-c48f-4991-533a-08dec2732cc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
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

When both PASID and force_iova are disabled, carveout memory should be
used. Reject buffer allocations that cannot use carveout memory in this
configuration and return an error.

Fixes: 3cc5d7a59519 ("accel/amdxdna: Add carveout memory support for non-IOMMU systems")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index c677293c1ae7..1f066ed8d236 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -120,8 +120,14 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 
 	if (!amdxdna_iova_on(xdna)) {
 		/* No need to fail open since user may use pa + carveout later. */
-		if (amdxdna_sva_init(client))
+		if (amdxdna_sva_init(client)) {
 			XDNA_WARN(xdna, "PASID not available for pid %d", client->pid);
+			if (!amdxdna_use_carveout(xdna)) {
+				XDNA_ERR(xdna, "PASID unavailable and carveout not configured");
+				kfree(client);
+				return -EINVAL;
+			}
+		}
 	}
 	mmgrab(client->mm);
 	init_srcu_struct(&client->hwctx_srcu);
-- 
2.34.1

