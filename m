Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6B2606A325
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TtukYh8d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9091A10ED7D;
	Mon, 26 Oct 2026 10:04:17 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9C410ED7D
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRRiPJUvkEBDN6JymtxTduqgzlil5Qe4wxtr+JiBKrrHK2G8Ic+YU8yAaIhT1UgAIbbEBCnC6sP4qAjcrwYkiNnXxjd+3jy9hz6PpM9g+qlVYSPLqOj4hkXmB/wabVYdZ8fhFnLlSbixKDppruhG9wubjHFKFnNkMPqCXewrYxqNcTVvSCofGB9i4/v3slRzOTtQvfABmRRw72wJl8bpD+sls+EZpmEfCfP3xtWVCB1uECqfE5fAchRQ9kPpJQLsIlPYQVzjRCJY7lvQWScA6+aF14t2hKkZiGza5uIb7KxRh1CSCYErZmSoU3XvLjlRAiMRMT8qYbWcPD1f2mpidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/P+iTe+75GiYKCT6VaqOSnS/S/OQQsRF0ilQ3UsX3bc=;
 b=eGCvMVwTIjC1GCB1UpjF8GbE5OsdV9l89zof7ZgtRbKFDzo7/M80tUrkVZ35OE8tlklCdSF8XTM9aNsr/ZD9G+nOIlwOHkF26gjNX5cNtqghw2wcRdIRQF5E/owuIudpkuv6nq2XpUGuWXW5oqMoyyq0/umzkDmDTrQqN4YCjwK5N0MVLk31zJKSZyufz8S+hb9TgSbPz/x5EJIb2UPq5fUX8B4MCSFf2pE23xiOY4WIIZ6RF4iArLePezcL9vV9h3y46ve9LeYEvgDzD3Bfilds0NmAlZPVapFekqkAtygKNd1F232zvn8Y6RvNjiREqBy9+QJQLjiObPsOSX0C8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P+iTe+75GiYKCT6VaqOSnS/S/OQQsRF0ilQ3UsX3bc=;
 b=TtukYh8ddggtlmrE4N90faFTl6U+kBEaToao+jAA0nKx3iI91G2ETJJjZF89Oyd4aVouxTTjyMZAHhYV9MLqDkOyqp+aEPOYIRzKch/ZkQ5XTmJcRws5KbLd6TkF1K8W4jbMFT91DYcEhzp/kjLPRxruWMEO6vG3mkp/lTN0VCtXuILEc1yEw+VVQeCXyBa2ea87+izDYv87LC/W1qOkSqOzEyuTF5ArYLwNiKi+OBBxBYWtZqiM10wr9aAKp+ni3xq7i30Sku8PFkI0wvnBFCYHVcv2Sup6QQtA3u9QecAICosLCYPvmY0RSvEjZtMKUNtdFGu8l+1aEJ3QjYV6ag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by GV1PR04MB9133.eurprd04.prod.outlook.com (2603:10a6:150:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:04:05 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:04:05 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:10 +0800
Subject: [PATCH v7 05/15] drm/imx: dc: Flag CRTC status in GERNERALPURPOSE
 register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-5-a0b50cc4fc65@nxp.com>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
In-Reply-To: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|GV1PR04MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d11dfd4-f192-4aa1-26da-08df334877c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|23010399003|7416014|366016|921020|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4oqShlrRGQlpXMHn4XrohRu94NJ38tm9K/D3Jl6JDp29Vqr9AuafjgW2mRQ+m5Bxkd/OePGR6xTfqbrhnvBJ2kkwp7kMcEP5BREOOs+xv/e2RXSBXXmc74dyzSlDA6bxbid6G3Rtp7Y4RlGbXx7Oca/qZef/yRMWez/G2gCEoCF61ajDRYyEio9x0WIMeg+5WarLj6mKQ19Knag4YUq+U0RJasLbupo0Tn7/M2dPSSUh6oEV1uudYjKUWQ7jIP5Og6qw0nqwa7uRLVPPYhB10pw2SXH7DTGhOvyGVyvHBZfZUVmOZceG33zwj4tTGyEHRqKj3i6RbJOCeuzG6j6P/WqnktBaQqD7MfaTU3hDoebZzSZnO8ygZ44qJG1cEzHjLzTyu6t3SBzUerEN5kd52mxZowqKH6bxPjptdP2IS1E3fVyPKzOjRijAG5mR2bjORPt0OPMJNUcIRlCfGNGZMaaeo70R5a1ob6454HfDRvg+5Zp5/b+z9ntnYj/Q55FsADOAgDCRH9DaOVXLUdTUSWnY9loPExVwPGMfXxHhUv5u0t+0N4fyKgmAVCJUA/+aL0H3ucA/qi3S7KY5kwnAg+lvlf7x+4qI6eIA0stdlq/XVRYxDgnIlVyzSQCQ+N+1E56LOXEkDARrYG3X4Qre2sKlpJxvC9ly4eMNdINoCNFCczK3pYwUMHr7zudc2aDji7Wod6Zv0z+n8dgeOKrT7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(23010399003)(7416014)(366016)(921020)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amxhQjRYbTlhUndmaEhjV2h1bkZNMW94RzB3YW9CMURPYjFpa2JveCsyVy9V?=
 =?utf-8?B?eW9TWVlEMGxjYVU5R1hxODFyUy9sRGhoeHREbkNRNEtNWUVWRDJZVkRySDZC?=
 =?utf-8?B?V2UyTVp2Zk9nYmNGTm9KaUtmY2xWWXJuajJIS21zOWlWYW0yQ1JoTThZN3FY?=
 =?utf-8?B?WkIzT05oc1Z2Umw1bmg4WWY3eHVhZHRoV202UGlKckJBbXlOY09RSVh3eTBq?=
 =?utf-8?B?VE13QnNGUGIrcGFKcVU0Sm90TmhCZlJSZmdWMG41cWJZUXFqU3hPaEl2Y3dI?=
 =?utf-8?B?WTk3ZWsxdzRKQXdIeDBtWVhYeUJNakFleWNZZWR2MkJiaU5zbHlSSEZGUG8z?=
 =?utf-8?B?Tm0vbno3YVV2emxmUjRVY0VhV2hJRk4wUXhaeTJ6MXI3cklQY2JhRVB1bjlh?=
 =?utf-8?B?cmU3VUcwdU15QUEydWJqVkYzcVpUdE0rWGo4UDgyd3FlN1EwMUZLMHl3QVFX?=
 =?utf-8?B?cGhsTkdHcFk1WEd0M2JQMWU4bWM2K0NVckJNY3BKTHNvNEhrcGdOWGFVb3BV?=
 =?utf-8?B?Q2JuN0wwQVFMakd0UFNSYTd3NzBraFEwdnVZaWZLTjFpb05CRkE1VDdiSyt5?=
 =?utf-8?B?eXpzVnBmZTJmYm4xZjhOQy82SXVhdC8zWnBzb29SMW0ydXdQLzZpQ0hycGNG?=
 =?utf-8?B?TzF3ZGdWMm94VjNaVWZjdDh0QWhqME55QWZpWjFqdFRoMUpKd2l1RkpvRHlT?=
 =?utf-8?B?YTRnbWh4Q3Q1d2JqUFgyQ1R4dTVIbFowbFd6QktYQ0RobG5HS0dIYVcrRGJ3?=
 =?utf-8?B?N21qaVgydFQvUENjaUl0VlEvS00xeW84b1Z0VEJWQXltT2QzMUZ6QkhBakdo?=
 =?utf-8?B?ZCt5TUI4cGpNYjNTTndwdjBiMGI3UzVxWTVNOUJnOWlJK1l3UGpLTEw0M3Fr?=
 =?utf-8?B?V2puV1dWcXB4cVhsZmtYNzAvQUFKWG8xcEZEbmphYlBqaklNK05MMHJPbC9x?=
 =?utf-8?B?dFY5cXVJN2NiclJyUEJYT1kzSHgxVE04RUtWcmFuL0JCSS9KMEFRTGVkemdG?=
 =?utf-8?B?WVdkM1NhOGNFNWNXb0dYVEc2M1g2bzAyb09sekg1OUx6MkkrQmRXbGRzall3?=
 =?utf-8?B?VTgvdzFlaUJXOU1RTkRhUzhOckZpeTNRMWdod2RJVFcxKzUwNGpvWmZhMnFu?=
 =?utf-8?B?NkplL1h4SkY5NmtkWHR0RG9mQ0tNbGUxNTg0amQrTitxZGc2bkdhY1ZYbmNh?=
 =?utf-8?B?NTVJa1VXRzJiWlJpRStOdlVVOXEzanhPTno2SXhCRWxYTHdZTlE5LzdpNDRC?=
 =?utf-8?B?QnpEUTVYbk9WVVo0ck5EK2k1U0VMbis2aFVVRm5kYU5nMjZ0d05WeC9lbDdB?=
 =?utf-8?B?TC91cDJ6Znk5bWhBQW1xREpuSnk3UjRKVjVNVEppR1hKWGZHYlFlZ3ZpV09C?=
 =?utf-8?B?clc2NlhpR3BybUo0dE92RkxHWHdrYThDci9iWlFOY29ZU3NpNGpBMEJsempR?=
 =?utf-8?B?NUJSVC9hY1JETHhiR2V1ZEtVTW9sWWtPLzdicU1lWTBMc0JEb2JWTFZ0WlFX?=
 =?utf-8?B?YTNZWUlHcUltY0pjRUJZajdEZG9hd3hsM3hqN1F1aTFCWnp1cGQ4UXBVd1Zx?=
 =?utf-8?B?UXJsRWlJckVNSWlTQkw2YjAzdEhHMHBnU2xMYVlFaFpFelRLdUQvM2EvYTJL?=
 =?utf-8?B?aGltZFllblBGdnp4QWhjaS92dWkyRG5qWVh3SlY3cmRGS244WE5MUnI0WFFz?=
 =?utf-8?B?TkFYN09jeDJUQU9VSzE0N1AvUlJYTERqZWR1ZXZObGkwUStqUkpHQjd0bGt3?=
 =?utf-8?B?UEpSSytVb0dWcWZnZFhWN3NFdmtsNG9vOHd2dnJYNkd6UlRWZlRnSDZ4aEVh?=
 =?utf-8?B?cEtVM1h5RjV4OUFFYzdQS0FYSmErd1lPOGF3aGtEWXE1UmhkK0QxZnhrVElv?=
 =?utf-8?B?R256NkpqUlFPSEtFZ3hRVDJHakNjWTBkSDFvZzF3ZGc1SC9IOTllWm5LRFB6?=
 =?utf-8?B?ZkNDU3kwb01lcEIzR0hWdktJdnV1ZWsydkgyeVI5YkVPeDAwN0VuSml5azFZ?=
 =?utf-8?B?WjBXN3BqT0JXY3daV1lBMXhwS0tnazFWcDFiNDZ4ZFl3UllQdG54dFdDM2JZ?=
 =?utf-8?B?N2xrQU5hU2dUdnB2eXpLM0FNN21NRGJJaFZQSWN2NHNnUkUvY3JzY0RiVWdT?=
 =?utf-8?B?eCtub1NYMnhTelpkRkV4ZWNTYmVBNEV0eGI1VzJnWWtUN2V2Q1htTzRUMWQw?=
 =?utf-8?B?R3NkZm1sWE1LYUt1eUIxdHQ5dFpwTmplWTFYc0lLb2F2WW9OWkU2ajVDckpZ?=
 =?utf-8?B?ZC9TcmhSR1Z5ZCtQeFoxaVI4d0duNVR5Sms4NmtXSm5OWWFKM1k2RnhqdXI4?=
 =?utf-8?B?bzJtelVESFBjVWpNYk04QTZuUDZMaUtxdmNic0VNZ0JYZ2NHa0p0QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d11dfd4-f192-4aa1-26da-08df334877c4
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:04:05.0445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvDOF8Vs3jHqrn+MmOFAW8N2eReyjuE8Ld1bf3qsP3Vhl9El1rrK+rTSAGy1jyR3g7lN5KC2wJ7IK4adikFCqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9133
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

Map Display Controller's register GERNERALPURPOSE at offset 0x100 and
create an MMIO regmap to access the register.  Create helpers
dc_drv_flag_crtc_{enable,disable}() with the 2 LSB bits in the register
to flag the CRTC enablement/disablement status.  Also, create a helper
dc_drv_crtc_was_enabled() so that the CRTC driver can use it to check
if the CRTC was enabled by a previous boot or not.  This is a preparation
for an upcoming patch to disable display controller at boot if the CRTC
was enabled by the driver during a previous boot instead of a bootloader.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
--
v7:
- Newly introduced in v7 as a preparation for fixing Sashiko AI bot's
  comment on an upcoming patch.  (Sashiko AI bot)
---
 drivers/gpu/drm/imx/dc/dc-drv.c | 76 +++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-drv.h |  7 ++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index 13795a2ad735..ac1321adf1c8 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
@@ -28,9 +29,21 @@
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
 };
 
 DEFINE_DRM_GEM_DMA_FOPS(dc_drm_driver_fops);
@@ -156,6 +169,8 @@ static int dc_probe(struct platform_device *pdev)
 {
 	struct component_match *match = NULL;
 	struct dc_priv *priv;
+	struct resource *r;
+	void __iomem *base;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -167,6 +182,28 @@ static int dc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cfg),
 				     "failed to get cfg clock\n");
 
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -EINVAL;
+
+	if (!devm_request_mem_region(&pdev->dev, r->start + GENERALPURPOSE, 4,
+				     dev_name(&pdev->dev))) {
+		dev_err(&pdev->dev, "failed to request memory region\n");
+		return -EBUSY;
+	}
+
+	base = devm_ioremap(&pdev->dev, r->start + GENERALPURPOSE, 4);
+	if (!base) {
+		dev_err(&pdev->dev, "failed to do ioremap\n");
+		return -ENOMEM;
+	}
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
+bool dc_drv_crtc_was_enabled(struct dc_drm_device *dc_drm,
+			     unsigned int crtc_index)
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
index eb61b8c76269..dd1302382ab0 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.h
+++ b/drivers/gpu/drm/imx/dc/dc-drv.h
@@ -99,4 +99,11 @@ static inline int dc_subdev_get_id(const struct dc_subdev_info *info,
 void dc_de_post_bind(struct dc_drm_device *dc_drm);
 void dc_pe_post_bind(struct dc_drm_device *dc_drm);
 
+void dc_drv_set_crtc_enable(struct dc_drm_device *dc_drm,
+			    unsigned int crtc_index);
+void dc_drv_set_crtc_disable(struct dc_drm_device *dc_drm,
+			     unsigned int crtc_index);
+bool dc_drv_crtc_was_enabled(struct dc_drm_device *dc_drm,
+			     unsigned int crtc_index);
+
 #endif /* __DC_DRV_H__ */

-- 
2.43.0

