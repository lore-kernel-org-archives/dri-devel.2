Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4E7FF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BBC10E24E;
	Thu, 30 Apr 2026 18:33:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MtrK2Vz7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013049.outbound.protection.outlook.com
 [40.93.196.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C7D10E24E
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 18:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ykf4k08ooeQEQiK5ivYhdigz9Qr43Wb2kafV12UhCrNx+w3CU3Thm0TTXMgP+vm6UGXSXLphin77dWS0hsgFwZBLayqvAORxIKhQJWyknsKB+sVL7fmnyOGRgfXLYrUhQ04HJrFrKckxaT4f+8aO9I8w39yDCPlOK3hlVyyWTMpE+vHuveDA40csm7RReU6oAgMPw+QR+TKKLr+aUKyCGZP6extx0O59fHB3lMweAmG5VdLdKhDIFTiPOp8MTnV3JRF72wwyNXdSbxl4Grp4vhNyMU2dS4csBcCvhLPVuohI4aqiM7ZhnCCEGtvOk3s+NJJTafIpKLjRAYkw/WlQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcVfyWYA0wNj5xpf1WtrZ0XxfW8KYrpUIVu1RsGaJEM=;
 b=In8EFGMMrLhob9EvK2IihRgqJBKR5QGE6lzxdf8inK1j+FUPeInouhYL3niON8Rqg8Ten9n6rVuWKSy3zmIT+PaSl36n9mXoYBryn7RNAwjnQ+cUaflncoO60Lsm8DBTgMmN9ZeXvOeA5qgrzLU5Nrj8b/LjgvbuWezv/UKbX7tbzf6m4YueL0Ly3AfOtXJT26L06wRK1zMA0FBVjG0P2tW1nCy5tW1fXBBVvNKg0TA4KrSBj6Qm+8D/X2d7Jr+pL6Zvq0bPnMnmQ1qF/LzuGwbtfsIoD8A7S6xEy3ThoID7Fbw9y1y8YqZ+jtbjZY/ZUP6QrjT/EYXCnx3RMDGWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcVfyWYA0wNj5xpf1WtrZ0XxfW8KYrpUIVu1RsGaJEM=;
 b=MtrK2Vz7XZ767zXE0bx5sKMxegvI/huHaf22AUNoTKXt/BYNCfdNJsd15TDZ5QpkYiAAYToIgjnQmNlJfBlQkpyf75XdYpCHhnNoHxU4nEs/rg0inHeTLiKPOqpS/5vUNWt4HvKEYMAFeERyNjeNrSp0eEBvoV/CHMBIu86UaiY=
Received: from BN9PR03CA0711.namprd03.prod.outlook.com (2603:10b6:408:ef::26)
 by PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 18:33:38 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::dd) by BN9PR03CA0711.outlook.office365.com
 (2603:10b6:408:ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 18:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 18:33:36 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:33:34 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:33:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 13:33:32 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.233.157] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UIXVjm1698367;
 Thu, 30 Apr 2026 13:33:32 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, "Bjorn
 Andersson" <bjorn.andersson@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <s-jain1@ti.com>, <s-wang12@ti.com>, 
 <r-donadkar@ti.com>, <r-sharma3@ti.com>, <devarsht@ti.com>, <afd@ti.com>
Subject: [PATCH 1/6] dt-bindings: vendor-prefixes: Add Dalian Good Display Co., Ltd.
Date: Fri, 1 May 2026 00:03:06 +0530
Message-ID: <20260430183311.2978142-2-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260430183311.2978142-1-devarsht@ti.com>
References: <20260430183311.2978142-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH7PR10MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 288b51ae-1405-42bb-43f8-08dea6e6fe01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: TzaBR9GjuSaqtar0gurFEs3fYOxSG+GFQW/+YAzDDNPTNHoVEV5P27DG/izZinKR3i+Or7Ko88tgPH8KclfhmLDKB9wax/VjdworZiLBGrAztyU468+jFzhMs9O5kjhjJO5k9lctWrmaFRXCr+PXfWcOIz7w/8ZEAkWvIJvjGlS1kD4eUTitEJr/iVBHw8O3wf2i4PgbVU7E37c7ovcoUzIylKXHM1TOSv5zOARYqy7X0RjP71JQHI8clxHk3ytn4KAsrrWDoqdkmitWRsqTatBUo0Q12m8EnXHfVxzmpNa95tmBhq1e+WEOSZsU3r6eAiAx3eFm0SjOhcjKy8jXLXYCEVqtRsnu28tBejgfakMl1jYrPLADXiy9iDzzOrvA/lV+9pSwFBaP3KG9TprwCkYRpZvMW8PR5/Sy1JXiflicys9mq4hvyCZqXUgsHKqIHnSC0nhZni+rVi7e9wtQ0GBuE6nPw01nXIZMTpuDZVDC8HU84dUdSUgSQmnxYrRsjNULHMQt2VWn+Qt5es7qPYEaWeFPvAxTFnbqdzi4ihe8RSeN1/4+GfbrIEod8q/MhRdTNkybuAmtDGnHyS56RalWb1lq8AOnwO6+vH0OtpzORIwPqyXkqaWB24axx7LJ0ZED1aq3/Faf0XPTB62ManlC+0hJV5hNljkHvqQdMeIAGPn1vpqYX5d1GzDwj4U8rOOiv/dxIQRE8owtJOtasi8dEJt3OMwyh/MhtoyM9A+0RjnSglEves5d70ASmMgrm9q3gMBSM1/uuBFQbkUphg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4S/YN+t3ZxKwTKQlkGc2vITi0m4BqzjMeqVKu3fgw1TU4nZQQKrOVXkUIKtB2euVdDW2+aVCv/mWfA+r7cfMYJxsywFrJaQw9lljU/Oa5J8HPD39mq2LWQcHTT4FO1FiRZn2KH3U3Y4mH5YtXC9d4ruC5fuA/owEH9lf/RxaYKlS8Q+1ECqEuMqi6eBSp/MVss0LciAKFULmV/HOFgkyMyC1v7j4Y3/K3p+MKnz55JjVeHgyj9v5RzD7LCD1LN9N/U5tucCWibPX8D+EBacimzUjgy+eLOox59RmQPDDXuC3Ta7L211Y+fg1EvOKaoIA8raoBR+taM1dF689kHMD84pmg/lIg/iscl81JV7HjwtUrpRt2aE7wGY6YNBpx3IU25cNDgcY6vuJ9dlNQ40IFfui4Xw3iQyq5yfpCjZiq5mdlWkL//CKAYzOdV8gdrSi
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 18:33:36.6143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288b51ae-1405-42bb-43f8-08dea6e6fe01
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6379
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

Add vendor prefix 'gooddisplay' for Dalian Good Display Co., Ltd., a
manufacturer of e-paper display panels and modules.

This prefix will be used for the GDEY042T81 e-paper display panel in
the solomon,ssd16xx binding.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 00bffb9c4469..04daa3245919 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -662,6 +662,8 @@ patternProperties:
     description: GOcontroll Modular Embedded Electronics B.V.
   "^goldelico,.*":
     description: Golden Delicious Computers GmbH & Co. KG
+  "^gooddisplay,.*":
+    description: Dalian Good Display Co., Ltd.
   "^goodix,.*":
     description: Shenzhen Huiding Technology Co., Ltd.
   "^google,.*":
-- 
2.39.1

