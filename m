Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D417CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC12710F420;
	Thu, 30 Apr 2026 18:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Gv+ZQD0K";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A014810F420
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 18:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/YbnYD4id6MS2ReVYcrPUF8nBn6ylfB9+y0GWQHGsk18xmHMO1DZdLG+Xnp9lt5BF/Ho+1ooQgeNlEP7eDNtOELHUrPgnpLaeTvCREfcOf/dqTKYjnYeZzAxZyQQFJuJxmceVGM7saApYQwcsz/ZaeL4W60AsXhmilAibTw26R8n+kSzwhIw/Ft7vzzpXjqHrHehwncFzIkucx5y9ZX7x97715QAXhW1k1hr+jDLl2Ijelm73ziccd17ZF+126QDIWoLicyq8muPpJGoeac9DDL29t/F9ZW5kOnhIEcVZNf6/oKO9TtoZZuBZeSodKUSuwFRGV3qvE9StYvi8Ophg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz/PXbKylf/WjI3n7mtkp6qtoxkTz6DTseHp1My5NSU=;
 b=A7Xk2J/16o0e8Vb06TNEoECjQy2fcxWfFZvcgD4Bi72nnAS/y1ggTPk8sPYqvuCX8928kqUND+FM/FOpWlk26pOJJw8co8AY8F+t8yOmrsbqs412GudvkCRuu14YBaS/kF5jXI41mZ4+P6NVBptoU3EUwTRt7H1lf943lDvQ6Zf1C05lTvnClfCXNuUbYtNR4x65VAiESJbSMQ3kg7qt3rgcrE1PIKb1bklWqS+9ZMpOwlBPksN31EwfeKOco51pDqRi2ReK5VzjIjjdmw971yFM/hk2G8pEyPZijBiRKF/noQtD58MI5CNYKxQqsoxsO9St+LOCZGWLv37CRsLELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cz/PXbKylf/WjI3n7mtkp6qtoxkTz6DTseHp1My5NSU=;
 b=Gv+ZQD0Km/GVnkcfp+L9eOlLz42v8sAOoOVrmPcRa85AsXYtbyMjLanfJ/cU+PLyOn7ul4WdlIZ4wdCPyNp/RO2MWN0NGPWrxC++cUNKBHyIhZV3HwDlqFuFAkTZSwF0NOl7W2ry+y4U4tWH3l+jjDraCHvgMN7+4P/zRHxRE+M=
Received: from MN2PR18CA0013.namprd18.prod.outlook.com (2603:10b6:208:23c::18)
 by SA1PR10MB997654.namprd10.prod.outlook.com (2603:10b6:806:4b6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 18:34:13 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::fe) by MN2PR18CA0013.outlook.office365.com
 (2603:10b6:208:23c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 18:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 18:34:11 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:34:10 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:34:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 13:34:08 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.233.157] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UIY78d1699400;
 Thu, 30 Apr 2026 13:34:07 -0500
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
Subject: [PATCH 6/6] arm64: defconfig: Enable DRM_PANEL_SSD16XX
Date: Fri, 1 May 2026 00:03:11 +0530
Message-ID: <20260430183311.2978142-7-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260430183311.2978142-1-devarsht@ti.com>
References: <20260430183311.2978142-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA1PR10MB997654:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0573a8-2e9b-4484-155a-08dea6e712b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZfOIpdvU3xKzpXo41pyvZpyOFj7IcWZG0ZJM8zSNEqkT9p0pzu6+uDIAKG4gc5VQbj5kAf5C51xezt9LHMdFyvxe74XfqMfGV4kPL428LsxEEZGULS6jwUEtisj3+sSi8QmIqVY85ObQB9nXi8tLouw0CNwP04z7BrhVcPhl1hOENiEdA6JTFmYorFDkOOrEmypI7Z0XK9uNygyKh9EpMODkE/2GP2BCFzCQ845xH+SiaGbksOmYP5ZfOwi5Tsh3K1GOI73msZfEmf0/ime5xsikGSs3IyS6KY9eTqaZbWpELRwwjINj324T9Driq3XL0yqeV1J0idxV4+L4KN3wcmLIFOjo4js/PJpccnKjfE0zd9qSPTe022O1nptiA8fV3bSJs2FjxC69F8UbbPR0JgwPWP3qfKOUhlszJkmywHj+FGn+MU4fQUnV0eIvngOo6qsM75BMyGeXvrmq3bH6Qq8An+MPbfMBZI1gu8he8d2OjEapsn/Z/9qe3NulBQQUzazXpbObdfc0ocImqchJ8YeKfHtTfCNOFk/tMMMPvfCJ0rD4/F1QyqmiZ5QiG7Y3BJx2iE0eB1L7CzSiPsfyAVM8FTQj075cDcwFofeysMiHDx/DDI8IePZOBCZRH7wyJwRjRYsohCo0ugLW9/RGfD0nT66gn+sY5fHoRk6p8OBinbp+nTItrvUXYLz5T+ZCs7K7NRRwRD4tr3aCBURzgcoA6a0J3cF0pLhvqJ1LGFGLt6dz+yF0ShjMKHvxinDQKlj3g/b+WSROtamrVdIcVw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5R9dmNG4JaPV+3H5L4l6wLQ11f0O3yuM8GK4PLvscLEwQNcvius3EXK4xmFJUSN2ZGJySvvHsCoa6Phdn9zzKOH5+v4hvxHUAX6+i5VD61vTpVmCEm8nEOKA56NYaj64HDQFlabsxbCc+KE46wwLibHZxlx1v7wxT/I+r6CDK9ZhSTs2ObZ1t1Vv3wo5TL0SUTUI3L2NbZCvrpb41JPiw1JazkV4H/2CjbOoV/hCqMgm4L9jzmyLokaaUKgwE8mOrzyfvaPpog2AJT3W1Mn/XtjfvIKLLBD+otz6E6K3krjcmmTpeZqCV4cGZjj2FpsszsaNO0fsuz7yADTdtw9S4rA3pbIqTcAAxBi9F60FjA+OO/Aha1O4NRH93Ri1kmz2ey7j6f967KCivijWPYMAD7V+e0KNQb4vxhU1BUxmfJqKAY5Mocay3AbLMt31pFYF
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 18:34:11.3571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0573a8-2e9b-4484-155a-08dea6e712b6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997654
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

Enable the Solomon SSD16xx e-ink display controller driver as a module
in the arm64 defconfig, making it available by default on TI AM6x SoC
platforms that use this driver.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 430219656640..0815384f955f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -995,6 +995,7 @@ CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_RAYDIUM_RM692E5=m
 CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
+CONFIG_DRM_PANEL_SSD16XX=m
 CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
-- 
2.39.1

