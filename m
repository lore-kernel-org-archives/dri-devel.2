Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9750606A323
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=T3g3CL5j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 246C0112D1C;
	Fri, 23 Oct 2026 19:45:46 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 239CE10E68B
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 19:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7yS+FIPSN8JklFqqCXJye0YT8yhlM5h2To9dIfxe2kWEgNSJyQ1dP3VQd473jtdoxbYj3/RbHLAQbWWwBqs0SSDNlN8WF6q6T6Fj4RkpIt0X/lqnnfKWW6K4XT68YtvFB5LR89WwuwR+A6XvBMDj/dQQEWwrPGEO7Ot5vRT73RQGB63R6S0Hg7bbuCwmy6jq9UBrvcEctXMEonN0B1acAv6bRQZcApPhn3gsr4zRD1DtNdE4SIWu02s0nt+tfURKjMJqZm2Fr2v8e4CnhyEA2sHYdhJBvEnFq7Krt7MW0nTTdJqIVRHW+ynn8U7qd4Sl0+wLaph2tOI9BZBWXdqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkuWfRC5B63qs4o1ZzuHa9fBLYWjbRj9n1aebzOvlQ4=;
 b=OD0mqEXBPoPt2fTOW40goHbHLAtaFzvKR7m0wW4DBo7qyuCzlP9gJ587/Ad4/l25Vlikjks91ZgJHzrDx2p7/NW1tS2cG7V8onAx0GC00DCZVDAwgygATjwU4frJ3u02Mjd3zP3OsqfxAvis3A1zbU8qJIgNGLBOoyIUWQOljIUS4DL9BwBzQ5MM14XYf8UoMQ88K87wktk/cbd52h9Ilx1U8sKGOIcEkGAbs/1ZmvNkAR3YXCB/6c46FvDWytd2LO+gFE+d0B29KFBcem7fURzEi2ns+BmWm7Ttjl1xdkKOks6saf/sIHM841TTc7Kegam4sxx0js3B2RuA74CPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkuWfRC5B63qs4o1ZzuHa9fBLYWjbRj9n1aebzOvlQ4=;
 b=T3g3CL5joBfa3gzmEch1l7GSyrLIAdrYBU8/82N0sqYHae3MXHmfG/rDFpViY0JX4Tfz+ur9mmMRNA7s0zUf/Z/XrvdQlcfNsrv8+gigjbL69SuPMuiSu9ZnSlbJo4RWBjdSICrEjyy9mYJy1z3vlkjAo6nRdcd3NY5NTwf33eNlVGhHsfnW9k13Jxx5A376ADTns/H1Z238PVSqlR2oG1hiZMGBqY8Z+B/3wIXKVS89IDBnwwfBgQ6n+K4pxcIXmlOPw/w+2syZ9WEwkhvsZvEXbSSxM9ciZF6mHiL6Ix0XRsNwZ0n113otRxXHSz1/9jM3kAykR2RK7qMQVrl63w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB10597.eurprd04.prod.outlook.com (2603:10a6:10:581::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 19:45:36 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 19:45:36 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 23 Oct 2026 15:45:12 -0400
Subject: [PATCH v4 4/7] arm64: dts: imx8-ss-dma: Add lcdif support for
 i.MX8QXP and i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-dxl_lcdif-v4-4-4ae8395a4b23@nxp.com>
References: <20261023-dxl_lcdif-v4-0-4ae8395a4b23@nxp.com>
In-Reply-To: <20261023-dxl_lcdif-v4-0-4ae8395a4b23@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792784713; l=3594;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dYCFdYWt0mJ/Z95BbTgLPz0Doe60DEGSIG6bS6sLXkk=;
 b=ZwCpy76rzH0IPDzZZ6ai01qAAtWlcdhM5NOWoYl4CRokZnrLWirOjg/IeKxEvLRCrMPIKeDwU
 BqXznlx0yEWCto6bRf8Umt/n+GxHb79b0vfrHqAHrXeWWcezOZTXmJk
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DS7PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:5:3af::26) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB10597:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf7c544-be24-444e-2ea6-08df313e35a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|19092799006|366016|261021121427099003|56012099006|921020|261009223027099003|11063799006|18002099003|22082099003|10067099003|261021123027099003|261022105027099003|3023799007;
X-Microsoft-Antispam-Message-Info: q9bs+GUqhzUK4PmUjRQBV+x170t81H4NwhJt18ioc6X9vK9VVIY1IC/4kc9jWA9KK3vqW0VwHIBVr7YDIX+wyOxJsquuFDvQBuvU0ZojCvr9tpLM/vfwxZs+9fa/LvXbFenUy591aU4DZoGT7aErlvU4rAY056p6+BhsB+cHoAQbTDFUCIdZfPKHHFDhNFo4+ccyRmf4D2bReaFvpmgJtBXew2GxOVLPbfbMcOMuuM1e2OqbNot0MTE4lgL+mRZOSbTQ/BjXjLnvoYfzEUB70NC5w2CAwa+VAazSnOxJRKSxMH6OmnqU1dmA7A3+S+vnBtCaRrm3Uhpfy20/ds9yBAfP19MoeiIlSCnotWHaJaJZZVHD/ik59WEnjdsWuHnQoVOjgymiRuPr06hHyMGOlsQTKyJDzxVBcfwr/ad1FUCCZdgRfSTUh7DMd6pUVIQcBfRy3BKWbTMr4lsad9aQmMnAUXIapcTP2bGdyFn6nlfRIlBZRDpWID1mn3edqq0887uUHgm+FJ7T8Le0Z7GOwXx4KXr61QZArOXDeAKWoHR7EGDeSyiG2zLPbT5iZAtIZwfuJ+3CgkeTEglSISVo6YnHK7Yckno1g/7wC/hCLkNxkXyhETTmE1NN7qKKuH9NkvvmVjyyaix04nWyytJqPil9ME/kGEgTVnTV5jH7euqK8A34nrnRE8A/S/RSj7XMM8S9p+MYy9TC1UQOPRPDLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(19092799006)(366016)(261021121427099003)(56012099006)(921020)(261009223027099003)(11063799006)(18002099003)(22082099003)(10067099003)(261021123027099003)(261022105027099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmRITnliYUpFM3JBSUZkZlhlbWpra0JRaVNuZlYxVkRtNWg4SjZneWRsb1RG?=
 =?utf-8?B?VVgrWXByeHQ0RnJmNkI4dTVWaDV5VEtHalVIZ21kMmJNK3RQcEFyc2lCa2RL?=
 =?utf-8?B?WWtXeXd3OVhFcldnN2R1VURlbm1PMFJmWlozak56dGFxNUM3NXEzUEtCaU5H?=
 =?utf-8?B?bzQyVWJraFV4YmgxMjlLbDVnZndkY2p3d1AvQUNMTm1CTXRBc3YwcmFZSzJ3?=
 =?utf-8?B?c1VCZ2dRU3M2a1IwUmZFangxSENlVVlMdkN2Z2FDcDNmUmFvV3lrMWtmUkZE?=
 =?utf-8?B?ZEdVcHpXYStQa0NIT2Y2SmsvenhGeWIyRk9ZMXdFWVhzSkdSeTNMYUxLcDdv?=
 =?utf-8?B?cUVRdThacll1R2JYcnF2ZzBIVGlkUngyNGVjUXNwSlBkZ2FnMkdHNnBLeFFY?=
 =?utf-8?B?NWttM2d5TG9zUW1PbDY0ME9iVzRMRE1nTVhTUW8yNXBvNFVHekNZcm13M09D?=
 =?utf-8?B?dG54dHk4KzBsbGpOa2hweW40N2NhVGZoQ0swK1JubzYrdWZFZ280ekFCUmZB?=
 =?utf-8?B?RU53N0ZlMUEyR1N3RlArQ2p2dHhXd2ltUSs4MU5LL0lzY0NINUtXM0FaSEZn?=
 =?utf-8?B?NkxxcjNIazN1TnhRcStaRmtFcjljUE9DQ3NrSlhGcm1DbU0zdTNjanpWeElj?=
 =?utf-8?B?MG1MbzRHaEFKV2lUMWNWZi9UU3NmT1RkeEV4clBPZXRmMVRkcFBJQWtRSGdC?=
 =?utf-8?B?UFhqUjlPMzBFbERyVFUveTlIMm5xdTlxanh4OTkxK3ZHR3QzSWt3TldGeGNY?=
 =?utf-8?B?Z2dGK0E3cFQwaURBcXdqNm13cEtjUmpFUm9lWWdBcmRuVmxOaWM3S0VmalU3?=
 =?utf-8?B?YkhGNUM5MDhoS2RVR0J1YSthd0ptN21NeXc0aTlJMEk3V0lSWjBqRXpEczd6?=
 =?utf-8?B?YXlLNkhHc3NIbDR4ODBkUWVnNzRDN0ZjcFhmN1lobjdiZlBUdFgxSXlIUFI3?=
 =?utf-8?B?Ynp6cnNGNmhwTTdaQWZuTmJkMmIvcEI3SU1oN2o5WW1OQ1NnOGo0a2pOYURx?=
 =?utf-8?B?SndIZjV2UmgyTkNUYTNLMEpWZzJ0V3pIeUtwTDZlcFZVK21BbmNyUnJ1SERX?=
 =?utf-8?B?UDdYSTRKZE4vZk05T3lnZ0YxS252NVNMVVlFVVV6Sm93NklXVVQ1dzVxK1I1?=
 =?utf-8?B?R1RBVEQ3RUxjTTZMVGpLZHgzNkhGZmR2RHpFS0RKVkZ4dmgvdXI3dGI4YWhj?=
 =?utf-8?B?K2hjRlZ6TWtIOUxSeU4rdjhyeTUrOWtjL3c5ZlBnMEhDVWs2SGhHdjZ4TkJO?=
 =?utf-8?B?YXN3NDFKQVdHZkJCdmx4VEc4bU5rV2c1S0NaZW1MbWpoRGFNeC92ZFB6ZVdQ?=
 =?utf-8?B?eDhxU01rcnQzOEZaTlVjTWZGNW5OTXdaQzgzWVp6eVhPSUhhTytVbHpteEZp?=
 =?utf-8?B?UXd0bFJEM3NuM1oybkxSWXhLK1VvYnUzdCtJaHpMN082d0VpZ1dldHNOOHI0?=
 =?utf-8?B?bGJ5cXdJR1lHN0VkMk4reDZqcXZQTzVwcmNSbUNrbGtDcUloVlF2eGl2eUtM?=
 =?utf-8?B?Ly9xYmpWZ1RxQ1ZhRHRQVmU2S1dWWkR6NVh5TEpFTHdUNmU2Ymt3QSsrSEdj?=
 =?utf-8?B?RWFMVHBpdkVkaE5yWG1ZSnBHdG9oRy9nT2lOOUVaQ1FhNU5uRTNlMmFJeEVO?=
 =?utf-8?B?YUpPWUd1VXB0TDZoaUg3ZXdmNytSR2tTa3N2MmZhSk85NXRmS1hZaVFwVFZT?=
 =?utf-8?B?dm95eU5udE5FOW84RjJUOW04TXd5QWhvU3NBWWkwa05kcmxxdU9DamdnbFkx?=
 =?utf-8?B?Nk0vRUNDKy9mb3VhUktIN3JUUnJwQkhNbmxpaEtFL1BRWUlURHZ3OXRMMVBT?=
 =?utf-8?B?eEJjWGZFQmJpUGRkaXhWYVdZMzRyeUczV1pHcXoxTHNiWTk5SExQTXFCMndH?=
 =?utf-8?B?UGtTVW9iaFFOUGFTbXMzbmtzN3pCVHRoK1dHQ1dwK2VZUG5pTVdWR0lxcU9R?=
 =?utf-8?B?Ui8ycnBoYTJDVFJaa0l0dFJ2WWpQWC9ZWUowaFVyYzkxa1crcHoxZFMrc25B?=
 =?utf-8?B?RS82RStHZ1ZOV0FPdFUrclJKL01IeGtzMTRNN2R5QWFvWG9hRi9RUEtwVFIw?=
 =?utf-8?B?MU9jTUlUR05SQnVrL3pSbHhZN0Qyc2VkVFJsRTF6VUJHU1IzVTZFcFFWNmZM?=
 =?utf-8?B?SHdGOFpvUW1hOUdaaWNMVXNoZ0RnY09FTWNjdjNvSEFraW9jSC9ScUVmOW5J?=
 =?utf-8?B?TStpMitrYng2ZUhnSlIwK210MWI2YzY1enlWeE1BNU5MQmlMNEtHN2JtNHh4?=
 =?utf-8?B?TDhKeU4wNU5QcGtuU0F6WFhtVGpBR056ZWpiWFU0eUZIWWVIcDE2NUJDU2tt?=
 =?utf-8?B?L0tKTUpxamhpb01Edy9KbnZEeVROZDd6S0ZBWkJLSXhzbWZqWlR1bEFIcTJW?=
 =?utf-8?Q?kSZScxuu4coA91MOCky7k8LwldDtAwj/Hp+/K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf7c544-be24-444e-2ea6-08df313e35a1
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 19:45:36.8096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F598nPct8cUj6nO2FhalcT0jYCf1toSh4m33NaenJWb+Ry5KC0wAF5GpesN7TkLMqxyFLsePwPHgvcgMDjv8kWdh3/dXCOcRi7ogqzd/LLuH53lGux5V2BY4GVvnK4eX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10597
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

Add lcdif support for i.MX8QXP and i.MX8DXL.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- delete adma_lcdif and lcd_clk_lpcg (sashiko AI)
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     | 29 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 11 ++++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi   |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 4de78f870c05c..87082c3fa9338 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -149,6 +149,24 @@ lpuart3: serial@5a090000 {
 		status = "disabled";
 	};
 
+	adma_lcdif: lcdif@5a180000 {
+		compatible = "fsl,imx8qxp-lcdif", "fsl,imx6sx-lcdif";
+		reg = <0x5a180000 0x10000>;
+		clocks = <&lcd_clk_lpcg IMX_LPCG_CLK_0>,
+			 <&lcd_clk_lpcg IMX_LPCG_CLK_4>,
+			 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>;
+		clock-names = "pix", "axi", "disp_axi";
+		assigned-clocks = <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
+				  <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>,
+				  <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>;
+		assigned-clock-parents = <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>,
+					 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_BYPASS>;
+		assigned-clock-rates = <0>, <24000000>, <804000000>;
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd IMX_SC_R_LCD_0>;
+		status = "disabled";
+	};
+
 	adma_pwm: pwm@5a190000 {
 		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
 		reg = <0x5a190000 0x1000>;
@@ -298,6 +316,17 @@ uart3_lpcg: clock-controller@5a490000 {
 		power-domains = <&pd IMX_SC_R_UART_3>;
 	};
 
+	lcd_clk_lpcg: clock-controller@5a580000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a580000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lcd_clk_lpcg", "lcd_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LCD_0>;
+	};
+
 	adma_pwm_lpcg: clock-controller@5a590000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5a590000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 7a191195dbd97..febf5f8b54ac4 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -60,6 +60,17 @@ &acm {
 		      "sai3_rx_bclk";
 };
 
+&adma_lcdif {
+	compatible = "fsl,imx8dxl-lcdif", "fsl,imx6sx-lcdif";
+	assigned-clocks = <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
+			  <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>,
+			  <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>;
+	assigned-clock-parents = <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>,
+				 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_BYPASS>;
+	assigned-clock-rates = <0>, <24000000>, <711000000>;
+	interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index 738c6f05c4ea6..7ecb3be730b2f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -6,6 +6,8 @@
 
 /delete-node/ &adma_pwm;
 /delete-node/ &adma_pwm_lpcg;
+/delete-node/ &adma_lcdif;
+/delete-node/ &lcd_clk_lpcg;
 
 &dma_subsys {
 	lpuart4: serial@5a0a0000 {

-- 
2.43.0

