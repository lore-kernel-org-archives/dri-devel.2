Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B627606A330
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CqmfJGzB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1CC112F2B;
	Fri,  6 Nov 2026 17:10:29 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BC22112F2C
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 17:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmb4iT3YC1XUMbj06YFPue5JsQkRia/ddzCOBtiO5+tbAD2GNBLzIaoy2sw13JVUlfDk1zWTBknMzuFHJ8z5oSAxjlBLoEC7hhGjafKn3TaGKkJPXS8FloupcO/Ejg6fGkHzlpVTZGs5BxQMnahpP+MRSlyjCYZBbQoMz6S860me8Q/Ab4Kmv0Mnx89yRtDcaMQzEb1sw9yOA17MTsQRwJ0KISXOSSF0neiYC89II+/tyyso+GVG6r71+oFkfF2jmJluEeROMm1PO+Bz/w9UGUq5nzIHIQaV2S/9nKfxvN3oI1GYDa99WK130G6FoHiVpoxXZ8r184Xw25B5BpP7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2+/+EoKVyasCsZIhp90OK+iUCDesX8pG4oXsVc0iUs=;
 b=EuG+9RVS3FWgsPd/2+ATnEKm8QrGnbl5uzlgOxIG3nI4chWyJ8RofUUYDUOiWy13qTuIBp3gIiWRRSFFMMilqbY7tGbG75Af+HiW3+44MEJ0faMzOfBMGTgPSYgjuVVbzLt/Zd1C4PN6d/lS/UQz0igfmsZSUvzQ9RQdU4wISM1cTrsGUh6tHnaf3mTCar4V+7zaWd9GQ0KoTQsLlfa6Hf5rAxreYKIcqhhUdXdMEMEjnss7sf70nHgH7UTeNQY2IzKXrjxdVY/vjwtifWcwcYn/+u+n2Dd4NdpiH5XMVzgnfLe+rMqavcJMDyc6q2ADIpsR519tcV/VMqkEtyXimA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2+/+EoKVyasCsZIhp90OK+iUCDesX8pG4oXsVc0iUs=;
 b=CqmfJGzBaBfdqFTkfnT/exbEdEtnsM4pkIIJmK8IiSrDhPntPnNMVGdDqwftrq3DbSaaaH53sL4A1dwufOYaNm3XSsBRzCKz0B913ad0Q9N8jATWB2tAg4hsSU56sWoG5fixqhrSzwAUGs8ScFukZ0p7IdK2517d8b0l5ZwG7LU=
Received: from BN9PR03CA0713.namprd03.prod.outlook.com (2603:10b6:408:ef::28)
 by SJ2PR12MB9237.namprd12.prod.outlook.com (2603:10b6:a03:554::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 17:09:29 +0000
Received: from BN3PEPF00022BC1.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::69) by BN9PR03CA0713.outlook.office365.com
 (2603:10b6:408:ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 17:09:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC1.mail.protection.outlook.com (10.167.248.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 17:09:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 11:09:23 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Fri, 6 Nov 2026 11:09:20 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <michal.simek@amd.com>, <deller@gmx.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <git@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>
Subject: [PATCH 2/2] dt-bindings: xilinx: Remove description for framebuffer IP
Date: Fri, 6 Nov 2026 22:39:02 +0530
Message-ID: <20261106170902.3656809-3-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
References: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC1:EE_|SJ2PR12MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1e14c2-1d9f-406a-6527-08df3c28b4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: tZlYDO6gQnjw0lZfuK7ub/G42HZhufZOHu7qS3waR7UYrqJ63U/VgIXhTI0MmwGCoNlxs4ku7ijm7wSWfHNaBIpu21SQAHBGFoUsbZRS7/RORv8uo4JJlaLAqcNnwEQZM/pAruDByKabAZrdSotGvRfoS9iGCT4Mrvx28hrnpGBGbyMC2cp6ntGWe7z8UUskOz+3XEOIcSDMZjK1ChUzoByfHWiX2aGw85VDHYtSLbW+TQl/9zIV4pObM6XSkmgR5ZVHaCGlQWJjY0Aa+l6o3/W/2onaxQny7M8M1F92I1KLySS+FYfX1cZzhLKVlAK6F1ufLehj5sC498gSNvJLNi9QM/fjI8jqUGhEaJvvd47GsvSzzI83lOkzLepkX0mPXl59Cy30r7NKmhadEZoVqj4g2Ik6rrjpFqgNscjeWgWnXvH3gORUO2PXgF4g5zWjxRvHvCXaY1T+Ibgn3m1Whdvsv3SlZMhyQkPs4wXX9WqU9x9FBhEua6MOl4f7ChyME2JhwnG8FpLy7JC9YbDZYvjNw4s3KtVMv6SCaiu2fUr8u72sUwy/UGhOj/7BJERwDNSsJWwdEKwOMkgr7MhaPzJR+PLWnPGSh12EGUNzsl5A6FHAokqWGfptK5LHgNMWQUVd9qCh4SrMVGBoS66Nbk8hSYEvZy828qK/u6gImnCzQSApPJh59cuOJgOFnyIQSO8DjUn4X9G6oeD6ADBN7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qeO+OL5SwS2nSpYvs8ea3ufr4UwjdO0os9w9rNe2ZO5x4auGtLYZ8pCLZLKBRC2FmNK1Y3FPHZ3+YXb63M6Dh4veksfqRKujIGfRUZcj4lj1W5rYj3F00EQAGHgi3uxWDGDhykCCuNhtb93TGc2R+M4MlIkmVPtwdwHd6hAWn9qHc0Lt3ST0wwKImdeyJuP6eIPpR5IScVQD+AsWFOXGja2OzzXV7Pwoe3PESUrXNvNReTEZVNxAKfLyzXBmYOERxzGTttnwJELK4TeFPCcuXKbeFH3OM8HBmugikGctKRNyGO9x1P28+lu4WNSLtCosSIgn1wLoV3UPc+DGPBHIM/AuRhmDRGv4fTw9NG1KDiCskx6rnp+AUgUoM7UvcL5QyP+5Gfo0d5gtlffdBZY5XmQ2DH8wDP44B/YE/ZfCIa9JP+yBzTt1O8Vy6cW7e27Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:09:24.2310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1e14c2-1d9f-406a-6527-08df3c28b4fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237
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

The Xilinx framebuffer IP relies on Xilinx Platform Studio and the ISE
Design Suite, both of which were discontinued years ago.

Driver support for the controller is removed by the preceding patch. Keep
the bindings in sync by removing the corresponding Xilinx framebuffer
description.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 Documentation/devicetree/bindings/xilinx.txt | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/xilinx.txt b/Documentation/devicetree/bindings/xilinx.txt
index a1a2cde7b7d8..935700073216 100644
--- a/Documentation/devicetree/bindings/xilinx.txt
+++ b/Documentation/devicetree/bindings/xilinx.txt
@@ -1,18 +1,5 @@
    Bindings for specific devices:
 
-      i) Xilinx ML300 Framebuffer
-
-      Simple framebuffer device from the ML300 reference design (also on the
-      ML403 reference design as well as others).
-
-      Optional properties:
-       - resolution = <xres yres> : pixel resolution of framebuffer.  Some
-                                    implementations use a different resolution.
-                                    Default is <d#640 d#480>
-       - virt-resolution = <xvirt yvirt> : Size of framebuffer in memory.
-                                           Default is <d#1024 d#480>.
-       - rotate-display (empty) : rotate display 180 degrees.
-
       v) Xilinx hwicap
 
 		Xilinx hwicap devices provide access to the configuration logic
-- 
2.44.4

