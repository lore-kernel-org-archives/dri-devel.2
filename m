Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09C606A326
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=P1NOMSjE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D51E10E2B3;
	Tue, 20 Oct 2026 20:13:48 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B31210E2B3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5RBUfMfabG+8iqJ+0ovZ7e9e40r6zRoXGWCy2YmleylG6e9ZI6fuv+gj9aBej2Jcr4Fe9pD30+yS2pKotn5Zt1AsTU4Sw9PAE7OfaWk9mwIXkcWJYPAS41Dbqk1bvAYIHbW78o1r3opUCx2adI0arEo/1cgp7F/KjQp4hJa09c0yOKGCejPt9B2It8KZhDlw2ax5r3zQOQxGL/cK2VUW+91JSJE+meR6adFA00zoyLbrPnKUtUyCxES73XipMdq4+eqAfwMsravDPKPuwlEK5Lt2khG/DYiCsC2mBnrZrCUhzitNuL02+NsYfMciPMQPve0vQm6hz/jawGsEC8VcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waiW7y4gaSSgTqihM/DyWEzzFPXStaoJNPUbAJ4pxuM=;
 b=NlRMrzaAj1sG2au+MN0zyOcj+txj6Hjrpa3NZTJ286lrSwmAbSm8QQQisj8SJyuo+vrfbTlsdp5fCHfcFVz7ouvlRKKJDXJo+e//+ZOVVc8AXlTJAz+xCMy6FKJQbAUHZXjMT9nAzBlON8X2EJBXc45sft8P01SM8MfhuwPBvBQyQm4n29/TFXbHNU6WbjLEB4hTdQt1wKjNKSaAe0ElS0ES5qIzQleft/wiIZmfuhergTrUtR4iNHnjPqye2OczTXCQtwOM9RyDnRTAEHhAonG0TF63Y3AHptfxp1FUaw1NMa8e36t0ccQt+fdu3c3wSQEqsVi7yX6hCJkQnq2Z2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waiW7y4gaSSgTqihM/DyWEzzFPXStaoJNPUbAJ4pxuM=;
 b=P1NOMSjEmXyMof8Y7aNXhmnmgBJD0Tq2WIQmtu4VZnNehpkld9DU9Rni5IpBNbCZF5qFHZX4OY3V4btvC+b+6L+ftJYRpC1vDLiMB9zOjXLzAXp4mfksp7XeaHz30nSdkEbBieIzBN/UAxSVq5UG2ObouQcE9xALCVCM7lNjeRE89Y3Gm1blOU3bPTBWyQXD6PuWW4oGAoOAci9HIOQ6vGECqBOattIMJHqUnxlu7VsLcn6BY1gX/9r5zCDuQ8MevqX4kFcTC94bykpVnNdQSEDlDawF5DQXM3pXkdfAtVvb8SjzNTAAiuV9I2ICBe+2+NbiIf22hBsWxPdr42lpQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by PR3PR04MB7323.eurprd04.prod.outlook.com
 (2603:10a6:102:88::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 20:13:32 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 20:13:32 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 20 Oct 2026 16:12:53 -0400
Subject: [PATCH v3 3/7] drm/panel: simple: Add Waiken WKS101WX001-WCT panel
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-dxl_lcdif-v3-3-adc944659e14@nxp.com>
References: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
In-Reply-To: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792527183; l=2478;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+q2gM2DXNbueO5stnatfhsFC0kK/u96cn+SENWzzgn4=;
 b=2kZR4bLZdJx/R8nU430Yh3cgsswHDERMhQAMaNTOHMTLf+JHVjkhH3UP2WEi3A1dEZHehQ5zX
 DuIxKPyC48WD+THEsTIczWmi/7ye3861Gyvz9xoLfFoEVqYZa9Phmlh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:510:e::24) To AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|PR3PR04MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: d55f1320-ad6b-4ab2-ada7-08df2ee697be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|23010399003|7416014|1800799024|261009223027099003|10067099003|56012099006|6133799003|18002099003|22082099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info: jNEF/gufEJZsuaL17HLcu1O/k0goMVeHEmLr3YS8EJHDxSiR+qX7UTLdbdX6ZflRNAW7v+TJRt9u4J0nNrazWEUyRhRTwltj8Ya4Nr3RBoYqAJZb2+yIbHfFqNfyyEKw+27mj8GM0XEf+d7pJMzrFgC2d0vdbk15wtPJMV4R57+sng9XbXFfnAu2RPs4VvWmB+sRtPbtfGLKFN9UEz9yyU1BFFt1dEcp/WibDqR5fP0E/weewHiGs4E3MY53XAze/ZXkWfxfImxPE21vJRlQU3GxmLgol7Kyd8i2YO9MWDjiMgpUPcuu4scEt5sCwb4YD/pXf569JkvghQ7pzJMZTFqXg9f9jMil+A+53O2cWknGf0b7jwjmm5FX1hRUiBwLM2D6kft6ya4mw21a+YxKLQm8uIcog0rP4IuPf8bkeqOuqJra3pvkVfItjTmsBFqMPMn0unYnYUeYIlJbKHZkLnDe/YTc5nFQ6liuZgOjF7oE766eVnswLLixHqQL6+ybO3VzF+1+OTk6DocGsbCCeKazxwzFgLIW5rfrWybjDlQHUFGZGip1+bA9OkAbIMB7f12XCQHCprU6O9j7YXzp+tQSwDvUvcohHYII4MsPWN+23KIQibuNJzeeejjtBAO65FxPueSlIoeoXLQ95cqQH2kMOVpfkbylahwEmR+GQ5Vz7Do9QQbkCz1yDPVvOAvV8OT6o/uKOe2T/hA0JWhGWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12445.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(7416014)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(921020)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpNMVhtMXNyQmZoWTR2Z3g1ZHV3U25CaERhR3pHVnBQNk5WZVpCU3ladlZU?=
 =?utf-8?B?ZTVyOVVvbnVGYUJ1RGc2SjdDK1dRY21PcTJ2endFR2JKTG90ZWpZNmZyNGw2?=
 =?utf-8?B?Wmc1azRkeUdOVDQ2bitqWVR4YWg4M1ZJUFFXdEg3Q0pLbi90M3J6UlkvSnRt?=
 =?utf-8?B?SWJldS95dUVaZGc0elJWM3ZoWWFaYmtsLytNZnhOSi92YmFnSFhGZFdxM0Fl?=
 =?utf-8?B?QVgrYTVCMTJJMHQ4MDN4TE0zaWJPVjREeEQ4cDU5a0ZmY3dCTm9QbXpmSmxG?=
 =?utf-8?B?YUt5ZHlHRGpWY0JFWWkrMWUvVmN5YWZXMUlvWjZCYmdGbDVldi9IRjc5bkNE?=
 =?utf-8?B?V2VjOVdYYVpNVVJ4RUlyYXE4d2dCTWpST1dRTFIyMHB0ejB1ZWpITTBKbUdi?=
 =?utf-8?B?NitKWkt0MHFnL3B6akxQWVBPaERHeEUwaGdhdUNpTXFvZ3BmZGtFTGxSWGtG?=
 =?utf-8?B?WitVYVZKdFVHR0J1MkI0WERmTzMweTdVVGs2UzlFWFYvdHFOMDJIUUVkTVpk?=
 =?utf-8?B?U20zR3ZIUHV5Umx1T2FPdm9KRWUvcFlXVlkwaUxFZndPMHc0UEFtK25EQ1RT?=
 =?utf-8?B?dHhtWDIvNC9zTFlQZ2FzWHRHZlg5MUtoTDdwYjY5NUw0blIySE8xRVNKZ0FL?=
 =?utf-8?B?VjFKeks4L3ExMEVJakVFYWcwdWJucFBZazNlaUZWQkk4Uk1UMUN5bnBUKzE2?=
 =?utf-8?B?cEpkR1Z1MWdMVXVGQXBXR1l3WEZ0RkMyN1dNMWxGZXFrSEFvMXZqaStvbUlV?=
 =?utf-8?B?VldBczVzcDJTMlMwRm8yQmlnS2h0dXkvVlFwcVd4d0M4SGFiMkI2Rlo3T3Vm?=
 =?utf-8?B?SmpLcWRFQWh2N3VPR1lKUkZYaE1lU2VoQXlmTC93OGF4TkNRS1FUb3plSWpY?=
 =?utf-8?B?S2VyZVZQbHlXbVlIU2tBRmZlMTBIVzVQOGg1d1VlYlMyMmpPYjBWcmNLYkk3?=
 =?utf-8?B?UWgycXdYZDVJK2FkRE5VQVd1TWx0NWdWVmhmL0dWanUwTzZlN1V3V0kxTDhX?=
 =?utf-8?B?NUFDZUtkSlF5cExMZFBkQ1dFeUFQcFBQb084R1lLVkRsVW50dGFOQ2s1VEZ2?=
 =?utf-8?B?MkZjOVMvQ1RyU2swcFdTRWR5cEt6VkJUdWt1MFZVN0h3YnAydmdMTkVzRjhW?=
 =?utf-8?B?Ujg2eElSdHFiK2lhaE9aRzI5VitLN2EyMkZZNk9VTXZvYVRINUNpR2toblQ4?=
 =?utf-8?B?UVhGYjVUYjlIYUlXRzcvc012aXRwR0tLU212VGFsQWdFY0ZURmYxOW95bnc4?=
 =?utf-8?B?SGZHalVEU0VtaXd4N3piNnAxdnlxbTBTRThua1VETUgvRmY4STRFclE3MEhj?=
 =?utf-8?B?eURIVENDWHp5dmk4NFl3ZnNXVFQrYVhOd0pNTk5CUjRXQjBldk5VWFRnYURD?=
 =?utf-8?B?K3UxbDlHVlRKeWlHMFgraTRRdU9QZlQvdE9PTFlCRE13V3I3OUs4endRUjRm?=
 =?utf-8?B?S3dWOHVsTHJqeG1qU3I3WllaQloxOEluTXZyNjNUOFhjZnUvRFoxOEhBcVFp?=
 =?utf-8?B?UHpMd3FkY016N3d6SisrM1dlSFo3QUR5MXpIM1Zlb0MwLzhTemtIZG8wOGtI?=
 =?utf-8?B?dVFWKzlNbUUwUzEwQkRtYmJ3T0JhRUN6ZWtFSEtNOHkwRk43M1VHL0RzR0Nl?=
 =?utf-8?B?eXgxM2VhN0YwVnJHUGkzeUk2bGg4QWpucnJGYUtmUXhGbVVubXA4ZWNNYTFa?=
 =?utf-8?B?OFFZZ2JJd3lnckZ3bnB5NHVpRkVKc2IxdjhZYzZyeXVBK2M3ajJGSGpmTkFQ?=
 =?utf-8?B?L0MzTGJMbDFIdmN6emkzNmhnN2RHeEVDSTMxTlFzbkhuSTJkSFF5a0o2SW5u?=
 =?utf-8?B?b2VqQ092NUdzb09BYnplRDV5L2V2aEI0QW9ubGF3bXZJdTlQL0t0Z3d3akFn?=
 =?utf-8?B?UkVCTzZBVEprUjcwRWxJQS9TMUI0MTdjcUxRTWNGQkoyK2VwdDkwakZaTk1C?=
 =?utf-8?B?aHh0SnBWZDd3ZmNnTUIwNTcwMS9hTDZZZVNVWlp3akV2QmhZZm1sRXhjY0RW?=
 =?utf-8?B?cDEweGcyeGx3RVVBdEQyNzkySmdrdHNSdGJ2NExtNnVONnpyT0hzNDNRS3ND?=
 =?utf-8?B?KzNXMVo2MmsyZjErL2FqdnduVU9TVGlwU01oQjFHRFJlU0ZsWStKWTFMQnhq?=
 =?utf-8?B?eEpRVU9HUHV5cTJrQmRFUS9xaHJxWCtHUlFONGR1Qk8vKzVZZ21qWEVyd2NK?=
 =?utf-8?B?ck14Tk1IeitWQXdyRXdoSGliT2JUT2FrWGJZRVdpSnQ2MjZ2bFpBZ2htUVRq?=
 =?utf-8?B?YzM3UlZ3U0JSRlV2RzFjcHNBMm9LSlZmbUN2QWVFNU9BNWxRaVhQMUMwZTVD?=
 =?utf-8?B?U25icGxUanJ2QURRdmhvM0dhZTVUT3RmRFFaNDBudHJYZjAxR2VJOThHUnZs?=
 =?utf-8?Q?8GU/gaR/JWILpX50a3VKiOQqsnacXheujafFW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55f1320-ad6b-4ab2-ada7-08df2ee697be
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 20:13:23.3837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yD7jFk/gGY9wMAFaNwxnEBwiCbxWx9zTrkiPJDrffG23GTSckpk0/y/dn58oJZZ+b3ksIwCA+4LnuIk+dHnZn44q0gBRDquShCkssfjTTGlwEHa7p6Gy+EMSzTa3XkK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7323
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Add support for the Waiken WKS101WX001-WCT, an industrial-grade 10.1-inch
IPS TFT LCD panel with a capacitive touchscreen.

Although the module advertises LVDS support, enabling LVDS operation
requires hardware modification, including the removal of several on-board
resistors. As there are currently no known users of the LVDS configuration,
only the default interface mode is supported.

If LVDS support is needed in the future, a dedicated driver can be
introduced to handle switching between LVDS and LDB modes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- add wct surfix and change to use MEDIA_BUS_FMT_RGB888_1X24
- Add information about lvds support plan.

change in v2
- update height to 135 from 136 (sashiko)
---
 drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d7dbd7442919b..f2a1668087de7 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -5252,6 +5252,34 @@ static const struct panel_desc vl050_8048nt_c01 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
 };
 
+static const struct drm_display_mode waiken_101wx001_mode = {
+	.clock = 71100,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 70,
+	.hsync_end = 1280 + 70 + 10,
+	.htotal = 1280 + 70 + 10 + 80,
+	.vdisplay = 800,
+	.vsync_start = 800 + 10,
+	.vsync_end = 800 + 10 + 3,
+	.vtotal = 800 + 10 + 3 + 10,
+	.width_mm = 217,
+	.height_mm = 135,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc waiken_101wx001_panel = {
+	.modes = &waiken_101wx001_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 217,
+		.height = 135,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+};
+
 static const struct drm_display_mode waveshare_28_lcd_mode = {
 	.clock = 50000,
 	.hdisplay = 480,
@@ -6248,6 +6276,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "vxt,vl050-8048nt-c01",
 		.data = &vl050_8048nt_c01,
+	}, {
+		.compatible = "waiken,101wx001-wct",
+		.data = &waiken_101wx001_panel,
 	}, {
 		.compatible = "waveshare,2.8inch-panel",
 		.data = &waveshare_28_lcd_panel

-- 
2.43.0

