Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEF6103E300
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA21310EB1C;
	Fri, 13 Mar 2026 08:25:04 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023103.outbound.protection.outlook.com
 [40.107.44.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E45110EAD9
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 03:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGOAJuL1Jkv2fesYs7rZqLSN/pmUud9RsxtrsNROsbr+y6sfeiA2qmZjXqaxWQ20VyXfu9DbhtTMGDuCZiwmpXnq4aCBooOQmdMLcpQyK9Tp1xvh2wn3adgtzE6uIFRh5ydQgdTnIVyswBoT8kRwg9CQX99uiAVtWl44TYmKsSfyGh/L6wtQv1IdOmFyY2DFXlitKLVTnCsuQXO9+BsSStfY1wczuVKKnzpdiZav0bRi4ZZ5BsQ+oNzg0TgHd7UTU3j5pDl/HLJSEi8JRBWN2OY4VZKgZOnu0OR0Yz2C4cfRc3dqtqNrIz14JihqcHSTbha5jWQ0G57k2SlhlJZ9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9MNxInqI+VQ6BWy/WlilNnPq5BYdwCKRrW8O5Hf06Y=;
 b=d7vsPUOkqIfnNInMsMN5eaGfm5DsvHVkDz1/zo9JJHx2a8ku7G49zHNZeIH3fklpOMAyUwVd2dGmZWNXy4wpKdVDeIAdLdndFj/uU82z355N2NN320WwGl0DPkPbTYPRCs5rNnwMZUekkrCFPVo1daoz5aMX6IuZNplEvnUCAAGRqtQx/yXciixf6tYFlDy3LzOgm8rP+AptFFbIGgvK0zwJfHXW8oH7NPe8smGKHezHdhJ+caS4r2RGzPDoE9p7yLnINWlyK25LbD/H+2AZL/ZzzSR3SWU8fEO89E6ZnyGb/VdD4oNegq+z4BWVoIxuj6ltFnFogXPyMd17r8kZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0048.apcprd02.prod.outlook.com (2603:1096:300:59::36)
 by KL1PR06MB6942.apcprd06.prod.outlook.com (2603:1096:820:129::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 03:31:22 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:300:59:cafe::e7) by PS2PR02CA0048.outlook.office365.com
 (2603:1096:300:59::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 03:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 13 Mar 2026 03:31:21 +0000
Received: from cix (unknown [172.16.64.42])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 2E44D40A5BFA;
 Fri, 13 Mar 2026 11:31:20 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: neil.armstrong@linaro.org, heiko@sntech.de, marex@nabladev.com,
 dev@kael-k.io, prabhakar.mahadev-lad.rj@bp.renesas.com,
 andre.przywara@arm.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cix-kernel-upstream@cixtech.com, Cunyuan Liu <cunyuan.liu@cixtech.com>
Subject: [PATCH v2 3/3] drm/komeda: Add support for Arm China Linlon-D6
Date: Fri, 13 Mar 2026 11:31:19 +0800
Message-ID: <20260313033119.33686-4-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313033119.33686-1-cunyuan.liu@cixtech.com>
References: <20260313033119.33686-1-cunyuan.liu@cixtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|KL1PR06MB6942:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 77c9a427-afda-4404-d809-08de80b0ff19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|7416014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: tVAG9aKYD8/keAprj1NZZH91wybjJwRdwTPfXE0bq85Zh3ZAHdw7rd2GbzzsA4zJCu4J6k5l65fl8aFcF3vbyltMSPKNywxpfd2G/akMamgONFxzGODsDfaRy5gvXizRclxIoHsVFdmPwgNrwUE7vbcSgF+bhWP4WQzFDMAaxwpMgwm7VK3OrBHWwWMDA0OFskj2TPDfD6jB7ZwA0LHujf15BTq01EA/EL007rESN2nSSc16PTFiIXfUDGRT1ltdV63FL59ke+p+czwgVBqI1M0lCkiZVcP0ZIB113xcaEPFakhnR9DKfNlqx9jTUMAy/tf26JShmUY7nKzge/aeuLnL7B+TCbx4KpGz+zWMddphx0EquD4TwKHu/dVX/rHSdJMFaEY9FQmKCGPDmjcR2f0S50EC5UhwCYOQ5YCl92FOGC/9aic82EdrqWMQdJS+xoMP/fJPPRvVq/BwvrGANPQus2pAUdRi7aD7//WaV3GFgwMIHFLDVoHJKY1Q1FVl5bXmn/THUmPG3a2mynVAFGmsJ1b1n8gbQqSShTD7hoVAJ6D62gKYwfccdZS00QMi3dNNtRukk6okeIvCwLjV5qOfqwDsyAgIab50ngF56NgIVXbimltSsuWDKrfTZYVDjtvSMsOBR7yeSJxKh3qHoIKCqzAHX0gaAdpEdvf/opGTVNXmcOsWL4qYX2PrPd4Mc2/BTYJrJByiTIvZH/FNmlICpzGwtJNR4KR40CRI0chLsQP3Xs2Y+4toNzLaROMUED+0BvUJWXO+yStwsbakEQ==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(7416014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lMWVkWCQSVEv9Kk+I7RHbqTboe1ljqNAmYW72bD7GYHDRaWc1MYfxgkFNOKp43oq/WAhSZBDGZRKGno3la39eGbfY50ty5mP2ID9y7+HCGw+sT24o/MYYRUEEwNl+IZPMj54vRI6+hCmLfEq0Q8H2Ruy+qA9TYbpu9jMHg2mL1eBduZwWdLyrXeSIrqTKOL7kNSrAXcJbE+KzGomeLD6GU8qV0bMC5+8Akq4W7fC84hj+R9Mt7K24REfcL13P1KWp9pdYF3w/MYT3Bu4eQIVB46QKlsWzYP787mKix+n3QoHtasUQricKKM1h0iF9Qfysy1oFCnziKaf+tdhm7CSPbno2k6hovvNztNLDf6yuLlqvQi+MGp05G+TX8iYF1AhW9NqPQY3phgtcYLrYY2KM3T8au5WmUT8UDCtT7i/8INsUXkjvvwGLrLq+Wlw9vgL
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 03:31:21.3065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c9a427-afda-4404-d809-08de80b0ff19
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6942
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:25:02 +0000
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

Arm China Linlon-D6 is register-compatible with the Mali-D71 display
pipeline for the purpose of basic modesetting.

On Linlon-D6, the PRODUCT_ID register is located at the same offset as on
Mali-D71 and reports 0x0060. The IP also exposes the same Komeda top-level
block layout expected by the existing d71_identify() probing flow, so we
can reuse the D71 function table to bring up the display engine.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
---
 drivers/gpu/drm/arm/display/include/malidp_product.h | 1 +
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c     | 1 +
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers/gpu/drm/arm/display/include/malidp_product.h
index 16a8a2c22c42..6f954bcdf40e 100644
--- a/drivers/gpu/drm/arm/display/include/malidp_product.h
+++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
@@ -20,6 +20,7 @@
 /* Mali-display product IDs */
 #define MALIDP_D71_PRODUCT_ID	0x0071
 #define MALIDP_D32_PRODUCT_ID	0x0032
+#define LINLONDP_D6_PRODUCT_ID	0x0060
 
 union komeda_config_id {
 	struct {
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
index 80973975bfdb..f105e3a2dce2 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -628,6 +628,7 @@ d71_identify(u32 __iomem *reg_base, struct komeda_chip_info *chip)
 	switch (product_id) {
 	case MALIDP_D71_PRODUCT_ID:
 	case MALIDP_D32_PRODUCT_ID:
+	case LINLONDP_D6_PRODUCT_ID:
 		funcs = &d71_chip_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
index 358c1512b087..4bb5f250e95e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -104,6 +104,7 @@ static int komeda_platform_probe(struct platform_device *pdev)
 static const struct of_device_id komeda_of_match[] = {
 	{ .compatible = "arm,mali-d71", .data = d71_identify, },
 	{ .compatible = "arm,mali-d32", .data = d71_identify, },
+	{ .compatible = "armchina,linlon-d6", .data = d71_identify, },
 	{},
 };
 
-- 
2.53.0

