Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152E606A338
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=bhmdY6/h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184A310F38F;
	Tue,  3 Nov 2026 06:21:13 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011056.outbound.protection.outlook.com
 [40.107.130.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80D710F38A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXX07ZnkJdpY7XGNUXxrUou+CpHK9SsBkb72PmZYhhNIIFtJDvjO2hknAk1qx+ERr3+Z2oogIXxZIcB48OpjKWSKvzMA4h2vqlXJSgBZ9QwnACkoo/vY3/UJamBQOm7f9AFvP9bE9q/la83Zp34kQnJBvuLGbtHaLOl4v8M1K417NAYvmx/vXDS8/9cV5DdlHaP2Zdx9JqM+3lNx3LKOrFR7rGZuv+lGgmNg5IL/6/o6MI2tXegXgdlgdnGxCzumYa+Csqm/q4BUFPlD2b0tlxA5uL7XQy2JZDLJ2ZACIG/Ijprbw3eqS4R3+4mqBS0HoWTUsdMLuerdPQ45E/NiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tl6ATbLiUl3kIPXNMk28Drl50afqwbCSsU9KWyP4/VI=;
 b=Fke6JxJFKoDMEQfBwTMQOOGiLLOA313vihwCxxW33Cx+zUui6x9BtRi+Z6kxlRfIe69jy3MzezrhXy7+z5/JdCXSKwejnzHSLee++HbbjndgbwnumbY3x7cujQG3D7nmirzQCDK8WomtXDsRIirqt+k9weUH7VY9yiXu4cJA7XNEpYMAsgWyR3ZERwrQHxyEhd3Ux8FeySX0J08u+Dn3dVnyXF/nEFST8dOWoUA0sxfwIqOEqXSRCXvpfD+d/rXE7yvGqO9WQotr5tSghIahYljYwss1v480ln+kZUuEMihqwZYtN4W83O3K0azfdwshrt3ghfG4CcdiYcKcibXYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl6ATbLiUl3kIPXNMk28Drl50afqwbCSsU9KWyP4/VI=;
 b=bhmdY6/hr4PEFAzEH0OXg+FJXEDSn3tLqbjSAtc5bsw85eFN54LPL28yZiOX5O9ssr1edA2kr6grxuMTOwWaEjBBiSFkt1tSUEp8rDKUtcUEZiWYG4YI7N7JDBEDli4eSC4cJ1J6FaPtxwF0/O4Mj8RzgsbUq2FU8bPZZd/TecADBCAdf5hDgkHuyeP2pAIWUrRPGmZ1Q3fOch0hjb5MRfSKmUixuyAfaJjGBJKLmrLf132EjCdeFSfKFtj/qgScBDG5+uwPn5x4LWjNuZnfRX/0hX/8QzvQjb7T3hQYTYyn1yBVHMpBtXEMi13kPsa3nn2qep+DSq3ZCJFlXL6TQA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:21:02 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:21:02 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:22:02 +0800
Subject: [PATCH v9 06/16] drm/imx: dc: Flag CRTC status in GENERALPURPOSE
 register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-6-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
In-Reply-To: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Liu Ying <victor.liu@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:295::7) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4aa9a4-3760-4778-d7cb-08df3972a2b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|23010399003|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|921020|56012099006|11063799006|261022105027099003|261021121427099003|261009221227099003|261021123027099003|261026121527099003|261022075727099003|261009223327099003|261009220027099003|261009221727099003|261009223027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: FTEdp+TbVkEu/B5XEb/NIoA4uwnkqZYE9t2kURoPweXnSna8S3WUy/jroZG1V+aDqtoZtYGyelCCKb4//4BURqI2sT/bvas4o+JTSf3V+mmepexPsyLgtxjLM2HkaJW5Vt0qpIgoojgRKwJBeIMuN2IPgzcxcWSXuQRRAoNA7cEWYEqQQtry6WQxHtEATMSkvCQa/so9+l9FMfZ9db2sxdlJQ86c63qOGl6lxi3B4O9urbMlJ+J4XE/IdQn2WQyW/e0Z2mWR0XdVv40t5zxbsuk/v/B+vdDNe2V33VMyBeLYTP9PbLB2a3sGwBAV4qyPXkIVdCnol9S6oIKegc6trqwRMTyUkMsMOHqrigAtsbDSay0/ZU7p72UZF0EN9SCK1Zzl+7P3QmsjqjKaOYTutiNFsVKtlflboMKIB5gaWtqvkKQMD4mOrDau6tGshIrSLoMzv/0vymUqdGrKC1tU/3c45PmVI5gr6RLQJ9hB7JMxONq0z6FJKdCjVv/CcdCFj4Mjx9srgOYvzoJd15cpw4f++QxxRgyYlw8+6zxf/Te+YfU5A6h5fFaQWkaNezOn4QNXwSvbbOA7fL0MILi18XSSYWnbd3vUIvoBaP/VDyqt+TK6Bde3nu7VN1il1x2UXFckzm3xgk7J1xs08CSaF0VYqIo3Ab8SnPBq6gA7GmZbtj2Wum9yd5Se4JnMZ/YOYTvGOsCHJaADxI1S9EfGWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261009221227099003)(261021123027099003)(261026121527099003)(261022075727099003)(261009223327099003)(261009220027099003)(261009221727099003)(261009223027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGgyeWppQWIzZ1p6MFlSd0NsK25FUU1XRk0ySUFFYU9SbklJZ0FnYzFCSlZR?=
 =?utf-8?B?ci9oTGpVZWI1T3B1WDh0akJUdEpKZndnaHFEM21QZFRPS3BkOU11cEhTT3Zi?=
 =?utf-8?B?WENPMzltZDN3QUtPcGpRdjhwN2xPYXc3ZGN4eHBSWXpoLzVId1gwK3R3YmZv?=
 =?utf-8?B?K2VDZkk5djYvYTdHTHF0RGZhalRPVzJwYXJ5aFVGRWJIOTMvdndMUFhpUXZt?=
 =?utf-8?B?bmpPa3ErQkFoTy9UTHovc1Jlei9TbnJJOFRYRU4zVUU0cGNWSzJmM0tOMzhV?=
 =?utf-8?B?c0E2MGFyaFJLODJUU3hvTXQxM2RlbGhoK1duNE92cnFEbThmYlZLVjJHcWhs?=
 =?utf-8?B?TVJobnAreFdYRy80OG5vYk8rb0hEWjIrVWk5TnpmV0JKRWxFQjJJYUhsSmg3?=
 =?utf-8?B?aGx4RnFuMnZEVGxtWWt6RndXVzlWMDU0dUluM2UycXR4MytXb2E5NEJZQjY0?=
 =?utf-8?B?eVliUnRkc3pZZGdRNGdMWUJaeGl2SG51UnZ0OFI3Zm1GbjY5cGpnUzE0RFNE?=
 =?utf-8?B?OHY1dHFGS1pzUjBRa3E2REhSVmV5bDc1Q0o0ZkpTV2pxQjBKVUs2RFNwTkNy?=
 =?utf-8?B?d2d6VFJIdVZvRHBmRm5vZkU0MFQwcllXbVZoU0x6MHNHQjlQVEh6RVNTM3h1?=
 =?utf-8?B?TUVadUVtL1VhWGFuM09OYXhWWWovQkhyTzE1eWFEbHh6MVl2MGFCdGRMS0tK?=
 =?utf-8?B?M1RiWEFDc3psanROck5xZ1R6MTdPbk05dTVPN0FyTTBvcXEyUWpkWVF6VFVn?=
 =?utf-8?B?c29tSE9ZcE85b0lZS1QzSUxLZnVmMzlrWkNwMThWVFpXdTdldFN3UldPS0Jm?=
 =?utf-8?B?dk1taU5wdlZnS3l4OG9RUFFDbFozOXdBdDNIWXRPS0FKQk5yellBQlJGbUFk?=
 =?utf-8?B?aW8wRTFhNWs3WFo0b25aWjVRVlBibDdDaVd2SW9pNEZlTkZBRTVLTFJmdTZQ?=
 =?utf-8?B?TUoyRGtlRXlLQU91ekUxV0g3eHRjN0xVY3ZVZld0U1YreVJYanVuQkc3L2Rr?=
 =?utf-8?B?WnFyb3FLQXBHWVJHR3V4U2xEdHpSaE1PV0tnMFlQNEJYTWNYYlBLdGQzbFVJ?=
 =?utf-8?B?aTRUbGdmeFZJdlFwMTB1UWlzNmJoUkg5SmVNVDBSUERlNkEzWWN4dFUvaXVG?=
 =?utf-8?B?QXdRVzJleTNKUlJ3Vng4eEtIbmdicjBzbmJObjJzQlRuMDJKQXNUUldiUVBK?=
 =?utf-8?B?cXcwdHN1M09jZ3F4MjJtdTIzUnhtdkVramlWWHhqVlQ4Rkxjc3MyeXFSOFpS?=
 =?utf-8?B?SmJ1bUVvT0ozd2NwT1RKcENUSk9tUWk2c25QZEJsMEk0YjFPU3ZrZXNjU2x6?=
 =?utf-8?B?bHBqVENoNTJ4S290TXFXUTBvRDZEaWRISUY4cGFwckIyRUJTOXh0ay9MRURM?=
 =?utf-8?B?a2t4cmhJRzZoU1MvcmQ1N2E3M0JNb0ZZU3VjaDVORmxXcFZXTzdnTHFpRHpn?=
 =?utf-8?B?UWJSSk56eW5WVVBQQW1SSmFNMURSZXJiSVVvbEdtaGY0M25qS2RBU3FHZ2Y4?=
 =?utf-8?B?RE9PclFCVi81NWVKSGx3a3pxNHJQdjI3cVdjSzgyN2Zpem9TSU1jWGtjOEhN?=
 =?utf-8?B?ZWNvMGc5REFRb01xeTQ1MjZ4RXdOdWJjWWlIdUIwRTdDUktxQVZMQTZsMW0w?=
 =?utf-8?B?a1ZiWkI2MzM3b1JRU2lUeFhhYWRHd2t4MVVLb0xQWWZRSzRyNWwyK0huRWdj?=
 =?utf-8?B?UmNZK0V1QU8vVHhkcFVLWE5YTWR1RTRHZjVGMzZoZVo2bjJ2SE1xRVJjalhs?=
 =?utf-8?B?czdsbmlabHNDMThvbUhpYXpCUldXOS9xMDVxQkQ2aGpNL3F1Y0JyUUV6c1pW?=
 =?utf-8?B?SFJHNW5iaSsydGF1bzdpR3pYcmM0UDljcUxHK05TajZUTHpCUVhnTXc1Q2tE?=
 =?utf-8?B?RDlSVUVnMHArc2lNYUZiMGpJSCtMb0Fod2Q5TWhkNTcrRmVFOXU4UzdCTEZ4?=
 =?utf-8?B?SEFzeGlEYzZkUVVvb1d5Y3RQME1raW9QV3BqcXkyQTZJUEFJNXZHWEVyVmJ0?=
 =?utf-8?B?OXpjSEJNajRpcGZFbitYelVCSGpnelBxcmV4QXRmWkQ4TDFSK28ydmZ4b0o5?=
 =?utf-8?B?TEpXVXJvNDI4YkpoYVhnc25IVDJWSzlrZWEzMi9vYWwzZFVXZE9mekluN1dC?=
 =?utf-8?B?blQzUlljUkhudXJKSVN0aVB3RXBIWFVFbkhwWFVTQTFFZmdlNzB2R2JZdjVs?=
 =?utf-8?B?MWVLMkhYQWd5WVpEWFhIUjIrRk1TbzlIcjRrR0xtaURwR1JJWnZCQjFCbC84?=
 =?utf-8?B?dmtjSFRoRVRsZ2xmaTBnMmtOUXpyNDJKWWJuYzdEYUlNbnpLdXA5ZnFLNytS?=
 =?utf-8?B?bnNLajNXU3lvY0NqNEE1YXRtcHpnVm5ZZ3NIUlRIMDQveitJOWNtQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4aa9a4-3760-4778-d7cb-08df3972a2b1
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:21:02.9022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KigjVlgth16fDiBtsvz6aFZA3AwuR7L+LklksWD1mDz/drffsodHjd6ck5ZOSH4Iz1k3+R8QAcbk0dSt9oOdng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Map Display Controller's register GENERALPURPOSE at offset 0x100 and
create an MMIO regmap to access the register.  Create helpers
dc_drv_flag_crtc_{enable,disable}() with the 2 LSB bits in the register
to flag the CRTC enablement/disablement status.  Also, create a helper
dc_drv_crtc_is_enabled() so that the CRTC driver can use it to check
if the CRTC is enabled by a previous boot or not.  This is a preparation
for an upcoming patch to disable display controller at boot if the CRTC
was enabled by the driver during a previous boot instead of a bootloader.

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v9:
- Fix typos in patch subject and commit message.  (Sashiko AI bot)
- Set .max_register_is_0 = true in dc_gp_regmap_config.  (Sashiko AI bot)

v8:
- Rename dc_drv_crtc_was_enabled() to dc_drv_crtc_is_enabled().  (Laurentiu)
- Use dev_err_probe() to handle errors returned from several function calls.
  (Laurentiu)
- Collect Laurentiu's R-b tag.

v7:
- Newly introduced in v7 as a preparation for fixing Sashiko AI bot's
  comment on an upcoming patch.  (Sashiko AI bot)
---
 drivers/gpu/drm/imx/dc/dc-drv.c | 76 +++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-drv.h |  7 ++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index 13795a2ad735..4c0749e5aa09 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
@@ -28,9 +29,22 @@
 #include "dc-drv.h"
 #include "dc-pe.h"
 
+/* General Purpose register offset used to flag driver usage. */
+#define GENERALPURPOSE		0x100
+#define  CRTC_ENABLED(x)	BIT(x)
+
 struct dc_priv {
 	struct drm_device *drm;
 	struct clk *clk_cfg;
+	struct regmap *gp_regmap;
+};
+
+static const struct regmap_config dc_gp_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0,
+	.max_register_is_0 = true,
 };
 
 DEFINE_DRM_GEM_DMA_FOPS(dc_drm_driver_fops);
@@ -156,6 +170,8 @@ static int dc_probe(struct platform_device *pdev)
 {
 	struct component_match *match = NULL;
 	struct dc_priv *priv;
+	struct resource *r;
+	void __iomem *base;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -167,6 +183,27 @@ static int dc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cfg),
 				     "failed to get cfg clock\n");
 
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "failed to get MEM IO resource\n");
+
+	if (!devm_request_mem_region(&pdev->dev, r->start + GENERALPURPOSE, 4,
+				     dev_name(&pdev->dev)))
+		return dev_err_probe(&pdev->dev, -EBUSY,
+				     "failed to request memory region\n");
+
+	base = devm_ioremap(&pdev->dev, r->start + GENERALPURPOSE, 4);
+	if (!base)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "failed to do ioremap\n");
+
+	priv->gp_regmap = devm_regmap_init_mmio(&pdev->dev, base,
+						&dc_gp_regmap_config);
+	if (IS_ERR(priv->gp_regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->gp_regmap),
+				     "failed to init General Purpose regmap\n");
+
 	dev_set_drvdata(&pdev->dev, priv);
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
@@ -196,6 +233,45 @@ static void dc_remove(struct platform_device *pdev)
 	component_master_del(&pdev->dev, &dc_drm_ops);
 }
 
+void dc_drv_set_crtc_enable(struct dc_drm_device *dc_drm,
+			    unsigned int crtc_index)
+{
+	struct dc_priv *priv = dev_get_drvdata(dc_drm->base.dev);
+
+	if (WARN_ON(crtc_index > 1))
+		return;
+
+	regmap_set_bits(priv->gp_regmap, 0, CRTC_ENABLED(crtc_index));
+}
+
+void dc_drv_set_crtc_disable(struct dc_drm_device *dc_drm,
+			     unsigned int crtc_index)
+{
+	struct dc_priv *priv = dev_get_drvdata(dc_drm->base.dev);
+
+	if (WARN_ON(crtc_index > 1))
+		return;
+
+	regmap_clear_bits(priv->gp_regmap, 0, CRTC_ENABLED(crtc_index));
+}
+
+bool dc_drv_crtc_is_enabled(struct dc_drm_device *dc_drm,
+			    unsigned int crtc_index)
+{
+	struct dc_priv *priv = dev_get_drvdata(dc_drm->base.dev);
+	unsigned int val;
+	int ret;
+
+	if (WARN_ON(crtc_index > 1))
+		return false;
+
+	ret = regmap_read(priv->gp_regmap, 0, &val);
+	if (ret)
+		return false;
+
+	return !!(val & CRTC_ENABLED(crtc_index));
+}
+
 static int dc_runtime_suspend(struct device *dev)
 {
 	struct dc_priv *priv = dev_get_drvdata(dev);
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
index eb61b8c76269..8283795f3c76 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.h
+++ b/drivers/gpu/drm/imx/dc/dc-drv.h
@@ -99,4 +99,11 @@ static inline int dc_subdev_get_id(const struct dc_subdev_info *info,
 void dc_de_post_bind(struct dc_drm_device *dc_drm);
 void dc_pe_post_bind(struct dc_drm_device *dc_drm);
 
+void dc_drv_set_crtc_enable(struct dc_drm_device *dc_drm,
+			    unsigned int crtc_index);
+void dc_drv_set_crtc_disable(struct dc_drm_device *dc_drm,
+			     unsigned int crtc_index);
+bool dc_drv_crtc_is_enabled(struct dc_drm_device *dc_drm,
+			    unsigned int crtc_index);
+
 #endif /* __DC_DRV_H__ */

-- 
2.43.0

