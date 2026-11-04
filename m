Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490676070ABF
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4RyVKY5S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE2810FF33;
	Wed,  4 Nov 2026 22:16:03 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A3C10FF35
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiZV0x4ASHnlyRuF9ncaBmoJeedW6C2sNnzxzd/bRsE9F3T3yTv4Ih6mfRuV69n3RGWBOmxSl8+ZAXiRg4P3JAeprCD+bHpMbOlp09vHvlFmx30yxfsD579YTpX6Y4DB61qpqS19HKJAIx68h8KizzkyFIGIKwdT2h76wIDJo6DNzb2XU+i6dCL1iYbCCk+bJ0tRAUckBr/ByoYf3uznmTDtaM4j7KEZR0Bc0YwOTXDLwzf7ldJjP9YS0sdnU5vzGcDblGYMcyP9totni2GGviIoqXyEBVjRMuuLHMhJls0um9C7TZ8zoKQgt3sZiA/4wRzqf/qFdQWEV9nsiu0b3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be3ZWgsqt2XqMdil9kq6i7ZLZcMhpW2rtJtU9IAy0dY=;
 b=CG8mrYzjLMphUut0a9n5iFnEEaICD0/FbZN8lqOaiDwBQjTy3LP8XpvH0nF8x/Z8p8WAOQ0osbkImZR38XkbAs+81Z6RyyvZeD5GM7cpdUsXa1lTq2UHs+cwwfEulhrOrpi9soTbmdHYI6+vR01nGuGXCb/EaYxS/1ZzV+hL2g6pTPTG/KeRW+CdqDi3FbNhoAhuL3/TuZd7YICKPTKmQB7jZexS1csyfb9IAauGDJ5LhA7qR1iEPCsBQDPV4kFkETlXFV0J5bbodwxxC0osg8gP5w77gYCOYMkN4+Fsv6ARxUgnrUuMfdTHoxlDs+3TzDDQJHpn7EO8cOL6Y127lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=be3ZWgsqt2XqMdil9kq6i7ZLZcMhpW2rtJtU9IAy0dY=;
 b=4RyVKY5SU/w1HuLVScoOCgUzoqHmMez+pxPH8fQHo0RmxaKVQUf4uWAWQL9SVHZV8QFOehX3jqi63ea4qX6NHBpEZOTSgeGWKD4wvoWT5BpGAJhjCw0haJNGEbund7IlX4+ITdQJ7/8+sMsaoMNymSF5BmCs0Tsf7sjgi87RZBM=
Received: from CH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::8) by
 IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 22:15:52 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::5b) by CH0P220CA0005.outlook.office365.com
 (2603:10b6:610:ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 22:15:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 22:15:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:15:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:15:50 -0600
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Wed, 4 Nov 2026 16:15:49 -0600
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 2/4] accel/amdxdna: Bump driver version to 1.0
Date: Wed, 4 Nov 2026 14:15:38 -0800
Message-ID: <20261104221540.631182-3-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104221540.631182-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261104221540.631182-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: c4867604-1d1a-4fed-e3ea-08df3ac13045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|261009223027099003|261028144727099003|4143699003|56012099006|11063799006|261022105027099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: k7RCl63Uqnn6dVY1rYtKkoVYNcvTN8A101+81A8eHnfY9DtvIlbx/Ut7BI7LkC9sbj5/dCXI4ziHdBO3Z46APqHcAJMmCWeUzYFCCFMCsoYoxiJ9xz7MWhzs5YmChcrA3KPRGZGzAD5kgR/Dnr/Sbs1GqPiVSJqIB2zHKJ19qMB2rStlUdHHi5DmXOxOO9lYYzj4kPpsW9SvLBReKfzbFHGXGubbMUPyWLyWd8bqTKt7wjS7l4k0rEgsbhgdVY4Yv1dA2FY1U4jBLEx1oYpc8/0NWPE2nWfLYGibxk3+99LgxyUIL53IzqzKRBkI3R8uL+EItkxEuuDTXw1QJCQT9HLugGgPhuNg0t1T0SjqQ6+umy5FH9o0Pt6xY+A6iL3+yOmqbIvE9Vhcv3YzUx1mjVY0/KeVHPswW797G+wmPadZqjnzrakwIdGLorKtExLt1qOu3+0wilxKWsEYwm3Y0z3sLEVkUtUPVGxe7XdKXLCY0SUzpP/RVpiCwt6zh3xVvZbwPYIeg+NP0inJU+BNDZvR2cS/pF81MqjEY1LUMbL4i4XMi81rrHTl0KuCbCI9YxJHk0t5TSKLm2koZYP7KUWACdU3lkUCwUqUgLTzZ9cyDMDOOX2M4ar95i5y6x23YprCwkRgkVbVy3HRWtpQe7wDfI9IHoOIsXrHTD+Emx9zQi6lOWr1yhQbtI+d9voEpUR3oQiLJdChgKN9+Fxi2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(261009223027099003)(261028144727099003)(4143699003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z13vHRpbI0XCVrcOsZJC/5edSzXhZdHvNGIE71kqgMDBZBFmD/yWmRl1DJgvKvu1ctKwfIMmDq/czW1BPYbMINp2EB2o284mi/pigLvnM4XF4vfGkXlSJPeAVMhjQKqqMTg2XlUP/wMmkwXSDrgXP+g60J1+kQO4GbOic4nh658Qi1bGPvNnRRlxoWL1XAUG4e/rx6fLozI2MYtHui6yIRVsutHd5dChM2xvaybvKCaf6+HINHKAwSrFHgU3XkLIoqWTByM1C/sv+Fpr2s1PBO2JbnUiilR1J1zHfjcRWf1Sxj39DS0Vjs/RoBqqjloPo6Zq7NFOR1uhB2UE9V2kXholdbWzvyqk70A/IiN62lNIWs0wCcN0JKowrqoxn0nFrsvCcmoZ01KgOfpG2sAyGCostcgJdTPqypkCQl8UT4yuSObuRCrZ4cIoh3RaIm/I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:15:52.2325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4867604-1d1a-4fed-e3ea-08df3ac13045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

The driver supports AIE4 devices for the official release. Bump the
driver version to 1.0.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 685fe1a7dd56..0dc156a1c0c0 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -58,9 +58,10 @@ MODULE_FIRMWARE("amdnpu/17f2_15/cert.sbin");
  * 0.8: Support BO usage query
  * 0.9: Add new device type AMDXDNA_DEV_TYPE_PF
  * 0.10: Support AIE4 UMQ
+ * 1.0: Official release with AIE4 device support
  */
-#define AMDXDNA_DRIVER_MAJOR		0
-#define AMDXDNA_DRIVER_MINOR		10
+#define AMDXDNA_DRIVER_MAJOR		1
+#define AMDXDNA_DRIVER_MINOR		0
 
 /*
  * Bind the driver base on (vendor_id, device_id) pair and later use the
-- 
2.34.1

