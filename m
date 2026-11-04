Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2A606A332
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mUMsFGzp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AAD510FF8B;
	Wed,  4 Nov 2026 22:43:25 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A19A10FF96
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGnZLq3z+iB8LkUeIMlT1+HdQwN/x3eMCwgyqZ6mdDJH2zVYBibmgjGQ/kJSffCVQsqSkCI4Jv9yK26hPdaUHXjzFB+aKzylPwJ83V36vvRRVGN8WYQ9zez5pgoa1o/pXBge4xykOxpCbmRdC0Zvip97FzQYL9FCdyhTOwKCILDxQIFw27U2PJ7fpWnlulMV2dubwmCjfWqUbG2PA7k3qwQbpBa2vsacGxml4lpT8Iss0/yT2iAQXdUWOXcFrfMryYIdyB3GcoI9QknCch0JrUNgP7Fsu4P1d7+HEvj0bNdVwhuo9u+SRC6XVembmm69RxYJ8xQktWQxyKobZyc+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be3ZWgsqt2XqMdil9kq6i7ZLZcMhpW2rtJtU9IAy0dY=;
 b=UrLUeurzsPbzI58HILkVqJYb0leJioA4Uc4IgIJfd2ynlWv2F8gA1YAd7lb1fjMMZoV6A9QCpeESOYgJQ2IH1f+o6hmQtBQZM2yvB6rWGsSCpnCoSuV1Ad+7vhdheLYlawrmU8ElQdk47pkIQ+Hgdco4isdlhSzCaQ0K4+lQN1e9NfeX/pvrjgaZBJ6LGsqC3DpHGiNwISHcYE3ExTKqf2UyT+49HGAkzBuwrFpAUpdDTtsj/G1gLZzztHiDmDfItQxOKsL1s8TVP1GyohyUeqimGI1rRgZgoJT4Y9rUD5tnqb+LCqDK1iBgkDK+R5HUk2sgBMZWTBH0neLdB9f05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=be3ZWgsqt2XqMdil9kq6i7ZLZcMhpW2rtJtU9IAy0dY=;
 b=mUMsFGzpy1a/2a186+1fTRQ/K3Z+m1hngAeQZchLEeQ5dfqLy7xV2wJK1OvFze+F1focSAGoigwmM35Zso7Rp/pKV2Yy8ZUXH02a+USlNpdYIK2/e7cNdSwPRqLPG0yGuQpRwggVZ72cGRt4swLB2xqLYFYtmp1JDnNHkuNU9qg=
Received: from BY3PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:39b::14)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 22:43:12 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::7a) by BY3PR05CA0039.outlook.office365.com
 (2603:10b6:a03:39b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 22:43:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 22:43:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:43:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:43:10 -0600
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Wed, 4 Nov 2026 16:43:09 -0600
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH RESEND V1 2/4] accel/amdxdna: Bump driver version to 1.0
Date: Wed, 4 Nov 2026 14:43:00 -0800
Message-ID: <20261104224302.643329-3-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104224302.643329-1-yidong.zhang@amd.com>
References: <20261104224302.643329-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0a7841-e8e2-4418-5508-08df3ac501a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|261022105027099003|261021121427099003|11063799006|261009223027099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261022075727099003|56012099006|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nwD+ADpFnQvpyQWvN6SSYbADgnT1am5GRtQx1n73yX0NhMswSN9IC0SVWQdp7ByBNxHKSDmifA2tZgz7/AvRhEGOps+CD3D7rIlvnWEC09A2lWXKfk8DehM19BJg7r/lbp540O17QjBKPp8uNyjo05BPiuuF/ntOq2CLAFvNZaVG7IZshyEQPQ8JhMC/1lpxAy+sPBAozQWnrBvPbeyxyBir6AlPa0G6x9naaQv2xw2r0VKsbgcciRwIdv82oiY+uS3d/Gc4yo4ZLVMC+6R+zq3NT13TBPhKVTi7kUNvJsQTJclbz8filY0lkHX65ucvnjdr+1bihA8EGyDl9CuUs7ho1keWQxviZOIEtGE4cM9/8/nsbnRHbbzCuM7aaGUZUAFt1zQKznh4yvHTTViTflD6KY5FDXFF9rXT2HdmmKBbUT/2HP8ieMTiunqW7jMunqoZuJDZodSHvGNCdOUekKNRWSR4CnR1OTrR+lbUxgwU8+GKbGkgvPo4adXBR7jf5+3I5keoaltmx94JOlQdDqbcZV4WGx3uOpHooVLD7Mwaw8WmyNLY2OdS4gdjDx9xJXmSDBuXp23jiL0SlHyORhX5/CsNg9fSCK3YIa18gIQYyEiybVm0/oFeAlgOiCYSBZx5Yeb/p++3fJMIXUumwlzGi3PO/UF7DImr4rmdjUfYoCfydjhODt/qEElTFf5FccJXNPF+F5ck1i7605awdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(261022105027099003)(261021121427099003)(11063799006)(261009223027099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022075727099003)(56012099006)(261026121527099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FUElwiFXqTSGMyvJ9EkJ1JxqNhnwFt1Kv4g1AqUf4XSpkbV8JO73ISgqDh2FTC45VivQuNPbSVOCTf6GBxtQdRfjAES+BFKwwQykcmLkpPiX1XW3awZiDJfFp1IdLFowARQT7+hLK2tHB2PVqsg0tx5q+bc8CCQpleoB9s3Cm+FWLntoBBf+mcixur7HB/zTakhdpbFtNrfxR8eplVlnClA+HcpridNx7k4Z/LKJ3d9BqN7YGowfTkL+lyNyZ7au8ISVtT9R5M/a7ud9NCGnrw3LTcZb8Vxj8lJ8/g4I5inlayaKlmvUdY9OgRN6Q0l5AGNaragV26rHVcZngZ3ComT398Fi12FaRKDfwJMtT9DgKBPspQB4dysXDUw6P5Xq0V+TcfLeqHUhcPr7D36/d0EjyNQQAGOfGp/8vTiwnDixnAA5L6wFkqp3zbP67wgv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:43:11.9523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0a7841-e8e2-4418-5508-08df3ac501a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643
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

