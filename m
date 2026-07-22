Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD91C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B3D10ECCF;
	Wed, 22 Jul 2026 08:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="QAiz0Ghk";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E63210ECCF
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5rECU6IBn4YCScdmYT5CA0a73zAtg+NqZJRSaf/tHq7+QIbhZN6Lujjir8aVXI0AkR70HpR9/QHFjeKwOsgJPTSnjNGB9DgNKuXl8gAAATtyslgY2kbMy/aQQpUCK2DR/cUzWfC2UcSSlC2HzihnHsuWWwXe418w3qCKM6A5pQ3dLOnm28NYcRUN+dpDhHcZnvXamEbrzTczkpJtiWsAHZR1oUU064Pw5t1ODsaiqjHSoSn/+ezfGYcu8m5xyD9+OoiS9Xnm6MDpO/JGIXCRE2jAb6FniSzHR4K83ClFFwlQ1X3+OA3Og8frJqH3T8JG1S/8fFlBdepCRyAPZrlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB9H4Yc3tj3XQuWFvl+WBptvC4ciYJ4myUSCVO+/Vlg=;
 b=xhZfE/+wvEl832SOhyp+xruCCQLinsPsufXvg44X1rfyC32MLHW8sZUQuEZWpCLjJIMKiiBrNcBZLm/EW+vIJSQNSqgWOYcdSdhMi6Sn86F+MMCfuSpisVTaUIGrqZWT95+DIzmBXUAtjUzoli7Y8lGBxNPLVSw+J3lTC7OvQ6DnDdDavYqV5n5eR7vxLeyL5BZW9yWGfznZUJNmk92V4a3xb4xp9xsJtHDBMfIwg5aVuG8q9B5pDy/k7Uc1LFIAHNUgbQftiTW4KqUrw3X8Nc0YQA85AXV6uVQ1k869g8qNyrUgTqfOYfJGUNUgwTXSaLBIC2fNlzpWZUpw6Tf7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB9H4Yc3tj3XQuWFvl+WBptvC4ciYJ4myUSCVO+/Vlg=;
 b=QAiz0Ghko+pw/MOSqB7yPisFsuD5ywbVAmuiyHX5C55M13oL8U9sOPi3bLY6yOI5cC6q/4B2lMPAZH8lu32XKi3pDvKG96bIdY5RuI5nVVdTdsxhG35eZZCSUxHNkbeMTL0jC7Rbi1DmxqQTNfenqopRHkNx0fyR6h4qSVYctLVbdlEGXfMoVysXBp+vKmriSgoKddWKHUjVQdYBofKu86PBXGDl12Y+EANPbFR2CSyjM6JXlpeODvzjyjWTYpkNRZS8d3gMA4fCJ4q0RdrKDAhlvkRrpzpMglRavIqRnSjxtBshB0AdTob62qNu2Hrbq/ahaWqDIERpiSTxWBPpsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by PA2PR04MB10160.eurprd04.prod.outlook.com (2603:10a6:102:407::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:11:50 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.008; Wed, 22 Jul 2026
 08:11:50 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Wed, 22 Jul 2026 16:12:30 +0800
Subject: [PATCH v12] drm/bridge: imx: Add i.MX93 parallel display format
 configuration support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-v6-18-topic-imx93-parallel-display-v12-1-a59dbb4dbc13@nxp.com>
X-B4-Tracking: v=1; b=H4sIAG17YGoC/5XQy2rDMBAF0F8JWldFo7ey6n+ULvQYJwLXNrJrH
 IL/vYqhNFAv3OVchnOHuZMRS8aRnE93UnDOY+67OgB/OZF49d0FaU41IJxxBZwBnTUFS6d+yJH
 mz8UJOvji2xZbmvI4tP5GnWocFzI0OkZSoaFgk5et5f2jztc8Tn25baWzfqT/4usKoyYwpRFQB
 cC3AbvL11T6Li+vCcmjYzbPLj/kmuryGFFA0lIzu+vaH1czAHHItdWVPsSYojTCq13XPbvqkOu
 2exVTgDKAlLsusF9YHHwEsCprIRvkxtho/B95Xddv8dehLDwCAAA=
X-Change-ID: 20251201-v6-18-topic-imx93-parallel-display-95f9234bf6cc
To: festevam@gmail.com
Cc: m.felsch@pengutronix.de, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::7) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|PA2PR04MB10160:EE_
X-MS-Office365-Filtering-Correlation-Id: ea22e40a-1fa0-4c4c-dc74-08dee7c8e1d8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|23010399003|7416014|376014|18002099003|11063799006|3023799007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: eFvDnrQWcpZ7Ecpr9voooXOtqDV7SogTcPgB9U2ZWj8mQvlJ6JaRsfEerT3MhfXtdxy77q4b5qtRSjw2oWmVtv2ExQPo8m3xQbxNHQ710VUwE6SsDiLy+7wARMj6CJggWn3m3DgzBb9mz+v2cifQQZrwiqLgVcaolzKsWEWBukhNhLmcQte/KmWr9+3hraQMWBk1+FgKGQ49+k5pYktIo1buBosc3mYR2MO2FNEBDexCzGRP3F+ldo7t9hmn6v4YfBY/9o1RkZoQ7PuVOVjgHPPjuJ9JbqqxJh2cUGX0gEFUwn/ZWsbgIk2t98+jeq2kBgdEpxBSv8KxVd1Xo84/wwRRYgCsl+WNVSBHl0Dk0z0YdfYcfxiylBHC1nWGZXf5/MUBT6JwE85gOvtPwxYgsnvIl+i/AdxQ/Nr2Zjp6w8tp7nAzi3Z39itM/zKdY/pmo7cLPvbWePGNO03odTNKtKvoQz9NRMXP73qK4VZ7LV1Dm3RdC/KEhTP3MRkL/DGVhuhmlMW97YVrLlFp140VZUo+1TuiwmO5dU96zUXR9a9URnSb01BuUlBiXQf6XSAhVc9r36gwHC5yMwQdCoBSr695A9VKUctlNbjrzTPH2yta7HR7HWOuBxFnG3LVMQEkT8PideIpCrPL1J3cTwnrKkgL0WkG1UGK7aQIVBy4ki4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(11063799006)(3023799007)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdQWi9EWEVBZVRDZHlTcm5QenMzdEx0dUJSSDdUak1yOGFDMVJlN2hDQkQ2?=
 =?utf-8?B?UTBrWHQ0NSttS2tRQlROaVl6OTNEbHh2eFMvaWsydmlESXF1aEdDTGtDWkhk?=
 =?utf-8?B?KzBZR2NWN3hvdW84YisvV2l3cWJyYW5kZmcxdVJpR2Zaek1oZitleWh1d0tP?=
 =?utf-8?B?dmdEZ3lYTUtBYmQxSFJ2N3VFa1BYazhtU05FZ0lENUh6VGVpdkhZZ1YyM0Vz?=
 =?utf-8?B?cTZZaUxoQXJBNlliN3pPMmVVdXRyQ0YwMzg5YWorWXRLOEdCaGF5KzlwSXZ6?=
 =?utf-8?B?Q3JsZTlPWmYrNnhYOTd0T2JvZFdMTWhYVFI5cUZLQW9Palh5YUZ6cDVURzRy?=
 =?utf-8?B?WjdaZDJMSE1NVnZlWDFyODZTdEVXM2tzQ1IxcWQrMGZYY1k5NkFVNGlwSTlT?=
 =?utf-8?B?TGk4WFpyRFdzdk1CK0lvaEI5UFVkOHI3aThSVzU4T1lkUWwxWStKWnBiQnZE?=
 =?utf-8?B?Y3ZPL1dsSWNINUJJcHJDRmRqc0JKTWNQWHIrM0QvNjNtT0RtQUFQcFNBVElu?=
 =?utf-8?B?aUhHYTJkQ1d6WkJxUTlJWG5UcjFNT3l1Nks1TDNIZUtVdEZhRWVtSXI1T05i?=
 =?utf-8?B?cmlYMG5DU3pGbUpOUm8wZFVNaXRNaHZSZGxuTUZwcDByeUtrWkJneGY1cXZK?=
 =?utf-8?B?NFJtMlZNZG9rcDRxOGNqUSt3akVnanROWnhXRERONWdITWx6K2VtZmVpWmVM?=
 =?utf-8?B?OXVVS1AvSjVPM3F3eE1yK1BrRVIwNkJLWXFsTHhXYlJnTkxYS1k2bXhPaWNv?=
 =?utf-8?B?M0RGL1JUSmZhVDVQM3czWUhBUWVmNlNzZUJwSlZXeFVOQzE5aTZGQWh0Wktj?=
 =?utf-8?B?WWVaZEV0cjluWFdEOGNQTm81UXpiRmVNZmtjOEZ3cDQ4UU1jVTVLbjR5Tk9r?=
 =?utf-8?B?cDdOZHkxZXp1alRlL09jSDFGdlA5NUhIcjRjdlUvQzdoMHpWZFR5eW5GbUE1?=
 =?utf-8?B?eEt4anJiQmlETGl5TjMweTJCUXBMOE5aT2N6STlvOVBOV3Jqa2VENWZqY2VK?=
 =?utf-8?B?NWJaMVhOdTlSN0h5QURWYUVkRTgwREd4YlNUOHExTDl1VzBpN3l1aVhzVDIw?=
 =?utf-8?B?ZTUxTWtJWURDb3Y0S3hVWUs2ZW85RkZGK3A1bHpnUkJNazBuZGhBRDByYXFj?=
 =?utf-8?B?S3d0ZmhwSXI5K2NjYUdORThGRjJaN2hMTktvVHNQYjhrcEVTYk9ERm1UQzB3?=
 =?utf-8?B?OWtNMTJrNWc2dXI3RUx3eHE1bXVDUVdOV1RZMm5QVkoxWHN5bVNFQytPc0Ux?=
 =?utf-8?B?UjRweTk3MWNMMzA3dzFEUmR6WDZDaWMzU29vYVpJNEF1UHFYSGh4RTNWRm8r?=
 =?utf-8?B?V2lJVDNZakNpZ3kzMTZQckVPaW1hSnIwUExPOXdqaDNLUFNQcVlPUkhtZzVG?=
 =?utf-8?B?RkFhUmcrVHhWL0dpOFEvV2tHYmVWRXA3VzRWTm12VzZBMXV2QWw5aEszcnIx?=
 =?utf-8?B?WklxSFUvRlpaOVh0M3R3UllocnY4Nk9CZkQvRW1janlMNG1HdlZmbU10eUJC?=
 =?utf-8?B?OGdjRThKN0NxUzB2YWhEdm1Ia08yWXFmMDZSbm03bmxORmw0UDBoa29BTEdl?=
 =?utf-8?B?QnVRenVqbzE1RkJRUHRTa2tkOXNvcTdFODFzYy9nc3Zlc3VKTVIzQ2FkTmpO?=
 =?utf-8?B?L29MeWZDeDFnRUltRkRQYXZTVURlT051dkdOcTJVYUNwR1BBSUtSd2lWSjUz?=
 =?utf-8?B?TGg2YUZVNDRHZHNKM2Fnc0NnLzB5WExKVGg2clRTRjl0WGpkbHVpU3MvQXdX?=
 =?utf-8?B?R1VtZ1FIVW1NVTJzVWhDdHIva1pPZms0TW5PSmpVZHU5eldYU0hQMWd2VXRl?=
 =?utf-8?B?QXI4MUkwcE5XdGNEV0xvZ3hKby9xUEZLWDV1T2s2MlUyL2RFSzhEdlVNM2ZB?=
 =?utf-8?B?aHNaS1BQK1RhVURiTVcwWGh1OG8wS2pzZ0h1Q3Vyc3lBWEdKMXdZU0E4Ny9q?=
 =?utf-8?B?dnZVcG80dDMxeWJhN09FdW1nZXcvYnZCTVNTUDhxM1p1allpaGUxbzlNK3VO?=
 =?utf-8?B?ektML2VuWDVMMkM0SUNPR3FTYmxnVjNpOVNkSnRVbDZQYjhLMVFWTFRveGl0?=
 =?utf-8?B?dlQ4RkNZbXkxTlpsQnhCUEF0VVpuZllBSW5NV3NwSEw4KzBPRk00cXdRWDRn?=
 =?utf-8?B?c1ZsSXpwbHQ0aDVEWXNoUEhLeENnaGU2enE0WXlIZHVwMWJmdngrT0g1MlhP?=
 =?utf-8?B?cTVKSlpSWkNmclFVdXZvZ09nZEROSUZrcE5xQ1Z0YXlsRkc0TkhRdnVOWmNE?=
 =?utf-8?B?TjRyRVFNaUN4YWpFL3c2ZEZ2TzlWN3FXaWNhcnUyV1pNdlBuU0NweEZyVkph?=
 =?utf-8?B?ZkIxajVmeDJPWjJtSm9jTUljVTZQUHRucHQrVkxwNTdqdG5YOVhsdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea22e40a-1fa0-4c4c-dc74-08dee7c8e1d8
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:11:50.4706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iu2pYvlEO3MMOQ4ORFZqPb1TMgHcVb3ZnYgPFIm5cd/pnBGhYPxuj/fI3p3KWXNQVPadfr3kslNeM3kDprubsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10160
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

NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
configures parallel display format by using the "PARALLEL_DISP_FORMAT"
field. Add a DRM bridge driver to support the display format configuration.

[m.felsch@pengutronix.de: add review feedback (Alexander)]
[m.felsch@pengutronix.de: fix to short Kconfig description (checkpath)]
[m.felsch@pengutronix.de: use "GPL" instead of "GPL v2" (checkpatch)]
[m.felsch@pengutronix.de: add bus-width support]
[ Liu Ying: Add nxp,imx91-pdfc compatible string ]
[ Liu Ying: Call drm_bridge_get() for next_bridge ]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
[m.felsch@pengutronix.de: port to v7.0-rc1]
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
[ Liu Ying: Port to drm-misc/drm-misc-next(v7.2-rc2 based) ]
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Hi,

I'm taking Marco Felsch's v11 work over and trying to add the imx93-pdfc.c
driver.

DT binding patch and DT patch in v11 have already landed, so only need
to send the driver patch out for review.
---
Changes in v12:
- Link to v11: https://lore.kernel.org/r/20260303-v6-18-topic-imx93-parallel-display-v11-0-1b03733c8461@pengutronix.de
- Rebase onto latest drm-misc/drm-misc-next
- Drop DT binding patch and DT patch because they have landed
- Add nxp,imx91-pdfc compatible string
- Call drm_bridge_get() for next_bridge
- Cc Marco

Changes in v11:
- Link to v10: https://lore.kernel.org/r/20260302-v6-18-topic-imx93-parallel-display-v10-0-634fe2778c7a@pengutronix.de
- Fix double space (Liu)
- Drop 'const' (Liu)
- Drop GFP_KERNEL from kmalloc_obj() (Liu)
- Add r-b (Luca)

Changes in v10:
- Link to v9: https://lore.kernel.org/r/20260115-v6-18-topic-imx93-parallel-display-v9-0-2c5051e4b144@pengutronix.de
- Add MEDIA_BUS_FMT_FIXED (Liu)
- Drop next_bridge from driver struct and use bridge.next_bridge (Liu)
- Drop linux/of_address.h include (Liu)
- imx93-pdfc: drop bridge.driver_private usage++ (Liu)
- Make use of kmalloc_obj() (Liu)

Changes in v9:
- Link to v8: https://lore.kernel.org/r/20260113-v6-18-topic-imx93-parallel-display-v8-0-4abccdc473a5@pengutronix.de
- dt-bindings: drop unncessary changes (Frank)
- imx93-pdfc: drop bridge.driver_private usage (Luca)
- Kconfig: Adapt Kconfig symbol and prompt (Luca)

Changes in v8:
- Link to v7: https://lore.kernel.org/r/20251202-v6-18-topic-imx93-parallel-display-v7-0-2cce31d64608@pengutronix.de
- dt-bindings: add nxp,imx91-pdfc compatible (Liu)
- dt-bindings: use video-interfaces.yaml# (Liu)
- dt-bindings: s/data lanes/data lines/ (Liu)
- dt-bindings: drop 'reg' poperty
- dt-bindings: drop #address-cells, #size-cells
- imx93-pdfc: drop drm/drm_print.h include (Liu)
- imx93-pdfc: s/exist/exists/ (Liu)
- imx93-pdfc: drop MEDIA_BUS_FMT_FIXED from imx93_pdfc_bus_output_fmts
- imx93-pdfc: imx93_pdfc_bus_output_fmt_supported: make fmt const
- imx93-pdfc: Rework input-fmt selection to always fallback to a sane
              default.
- imx93-pdfc: imx93_pdfc_bridge_atomic_check: make use of
	      imx93_pdfc_bus_output_fmt_supported()
- imx93-pdfc: drop 'reg' dt-property usage
- imx93-pdfc: imx93_pdfc_bridge_probe: pass -1 for endpoint reg value (Liu)

Changes in v7:
- Link to v6: https://lore.kernel.org/r/20251201-v6-18-topic-imx93-parallel-display-v6-0-7b056e1e5b1e@pengutronix.de
- Add missing bits.h and bitfield.h headers (lkp)

Changes in v6:
- Link to v5: https://lore.kernel.org/all/20250304082434.834031-1-victor.liu@nxp.com/
- Add bus-width support
- rebase onto v6.18-rc1
- add review feedback (Alexander)
- driver license "GPL v2" -> "GPL" (checkpatch)
- make use of reg of-property
- fix to short Kconfig description (checkpath)
- add OF integration

To: Liu Ying <victor.liu@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/gpu/drm/bridge/imx/Kconfig      |  11 ++
 drivers/gpu/drm/bridge/imx/Makefile     |   1 +
 drivers/gpu/drm/bridge/imx/imx93-pdfc.c | 226 ++++++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+)

diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
index 005a745e5c47..49fcecfee38e 100644
--- a/drivers/gpu/drm/bridge/imx/Kconfig
+++ b/drivers/gpu/drm/bridge/imx/Kconfig
@@ -107,4 +107,15 @@ config DRM_IMX93_MIPI_DSI
 	  Choose this to enable MIPI DSI controller found in Freescale i.MX93
 	  processor.
 
+config DRM_IMX93_PARALLEL_DISP_FMT_CONVERTER
+	tristate "NXP i.MX91/i.MX93 parallel display format converter"
+	depends on OF
+	select DRM_KMS_HELPER
+	help
+	  On i.MX93 and i.MX91 SoCs the parallel display format output is
+	  controlled via the MEDIAMIX BLK-CTRL DISPLAY_MUX.
+
+	  Say 'Y' or 'M' if you use the parallel display output path on a
+	  i.MX93 or i.MX91 SoC.
+
 endif # ARCH_MXC || COMPILE_TEST
diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/bridge/imx/Makefile
index 94ac8c40ebe9..99f28cd013ae 100644
--- a/drivers/gpu/drm/bridge/imx/Makefile
+++ b/drivers/gpu/drm/bridge/imx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_DRM_IMX8QXP_PIXEL_COMBINER) += imx8qxp-pixel-combiner.o
 obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK) += imx8qxp-pixel-link.o
 obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI) += imx8qxp-pxl2dpi.o
 obj-$(CONFIG_DRM_IMX93_MIPI_DSI) += imx93-mipi-dsi.o
+obj-$(CONFIG_DRM_IMX93_PARALLEL_DISP_FMT_CONVERTER) += imx93-pdfc.o
diff --git a/drivers/gpu/drm/bridge/imx/imx93-pdfc.c b/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
new file mode 100644
index 000000000000..b084409d22ef
--- /dev/null
+++ b/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2022-2025 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/media-bus-format.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_bridge.h>
+
+#define IMX93_DISPLAY_MUX_REG		0x60
+#define PARALLEL_DISP_FORMAT		GENMASK(10, 8)
+#define FORMAT_RGB888_TO_RGB888		FIELD_PREP(PARALLEL_DISP_FORMAT, 0)
+#define FORMAT_RGB888_TO_RGB666		FIELD_PREP(PARALLEL_DISP_FORMAT, 1)
+#define FORMAT_RGB565_TO_RGB565		FIELD_PREP(PARALLEL_DISP_FORMAT, 2)
+
+struct imx93_pdfc {
+	struct drm_bridge bridge;
+	struct device *dev;
+	struct regmap *regmap;
+	u32 phy_bus_width;
+};
+
+static struct imx93_pdfc *bridge_to_imx93_pdfc(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct imx93_pdfc, bridge);
+}
+
+static int
+imx93_pdfc_bridge_attach(struct drm_bridge *bridge, struct drm_encoder *encoder,
+			 enum drm_bridge_attach_flags flags)
+{
+	return drm_bridge_attach(bridge->encoder, bridge->next_bridge, bridge, flags);
+}
+
+static void imx93_pdfc_bridge_atomic_enable(struct drm_bridge *bridge,
+					    struct drm_atomic_commit *state)
+{
+	struct imx93_pdfc *pdfc = bridge_to_imx93_pdfc(bridge);
+	const struct drm_bridge_state *bridge_state;
+	unsigned int mask = PARALLEL_DISP_FORMAT;
+	unsigned int val;
+
+	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+
+	switch (bridge_state->output_bus_cfg.format) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_FIXED:
+		val = FORMAT_RGB888_TO_RGB888;
+		if (pdfc->phy_bus_width == 18) {
+			/*
+			 * Can be valid if physical bus limitation exists,
+			 * therefore use dev_dbg().
+			 */
+			dev_dbg(pdfc->dev, "Truncate two LSBs from each color\n");
+			val = FORMAT_RGB888_TO_RGB666;
+		}
+		break;
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		val = FORMAT_RGB888_TO_RGB666;
+		break;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		val = FORMAT_RGB565_TO_RGB565;
+		break;
+	}
+
+	regmap_update_bits(pdfc->regmap, IMX93_DISPLAY_MUX_REG, mask, val);
+}
+
+/* TODO: Add YUV formats */
+static const u32 imx93_pdfc_bus_output_fmts[] = {
+	MEDIA_BUS_FMT_FIXED,
+	MEDIA_BUS_FMT_RGB888_1X24,
+	MEDIA_BUS_FMT_RGB666_1X18,
+	MEDIA_BUS_FMT_RGB565_1X16,
+};
+
+static bool imx93_pdfc_bus_output_fmt_supported(u32 fmt)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imx93_pdfc_bus_output_fmts); i++) {
+		if (imx93_pdfc_bus_output_fmts[i] == fmt)
+			return true;
+	}
+
+	return false;
+}
+
+static u32 *
+imx93_pdfc_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+					    struct drm_bridge_state *bridge_state,
+					    struct drm_crtc_state *crtc_state,
+					    struct drm_connector_state *conn_state,
+					    u32 output_fmt,
+					    unsigned int *num_input_fmts)
+{
+	struct imx93_pdfc *pdfc = bridge_to_imx93_pdfc(bridge);
+	u32 *input_fmts;
+
+	*num_input_fmts = 0;
+
+	input_fmts = kmalloc_obj(*input_fmts);
+	if (!input_fmts)
+		return NULL;
+
+	*num_input_fmts = 1;
+
+	if (!imx93_pdfc_bus_output_fmt_supported(output_fmt)) {
+		dev_dbg(pdfc->dev, "No valid output bus-fmt detected, fallback to MEDIA_BUS_FMT_RGB888_1X24\n");
+		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+		return input_fmts;
+	}
+
+	switch (output_fmt) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		input_fmts[0] = output_fmt;
+		break;
+	case MEDIA_BUS_FMT_RGB666_1X18:
+	case MEDIA_BUS_FMT_FIXED:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+	}
+
+	return input_fmts;
+}
+
+static int imx93_pdfc_bridge_atomic_check(struct drm_bridge *bridge,
+					  struct drm_bridge_state *bridge_state,
+					  struct drm_crtc_state *crtc_state,
+					  struct drm_connector_state *conn_state)
+{
+	struct imx93_pdfc *pdfc = bridge_to_imx93_pdfc(bridge);
+	u32 format = bridge_state->output_bus_cfg.format;
+
+	if (imx93_pdfc_bus_output_fmt_supported(format))
+		return 0;
+
+	dev_warn(pdfc->dev, "Unsupported output bus format: 0x%x\n", format);
+
+	return -EINVAL;
+}
+
+static const struct drm_bridge_funcs funcs = {
+	.attach			= imx93_pdfc_bridge_attach,
+	.atomic_enable		= imx93_pdfc_bridge_atomic_enable,
+	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
+	.atomic_get_input_bus_fmts	= imx93_pdfc_bridge_atomic_get_input_bus_fmts,
+	.atomic_check		= imx93_pdfc_bridge_atomic_check,
+	.atomic_create_state	= drm_atomic_helper_bridge_create_state,
+};
+
+static int imx93_pdfc_bridge_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct drm_bridge *next_bridge;
+	struct imx93_pdfc *pdfc;
+	struct device_node *ep;
+	int err;
+
+	pdfc = devm_drm_bridge_alloc(dev, struct imx93_pdfc, bridge, &funcs);
+	if (IS_ERR(pdfc))
+		return PTR_ERR(pdfc);
+
+	pdfc->regmap = syscon_node_to_regmap(dev->of_node->parent);
+	if (IS_ERR(pdfc->regmap))
+		return dev_err_probe(dev, PTR_ERR(pdfc->regmap),
+				     "failed to get regmap\n");
+
+	/* No limits per default */
+	pdfc->phy_bus_width = 24;
+
+	/* Get output ep (port1/endpoint) */
+	ep = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
+	if (ep) {
+		err = of_property_read_u32(ep, "bus-width", &pdfc->phy_bus_width);
+		of_node_put(ep);
+
+		/* bus-width is optional but it must have valid data if present */
+		if (err && err != -EINVAL)
+			return dev_err_probe(dev, err,
+					     "failed to query bus-width\n");
+	}
+
+	next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
+	if (IS_ERR(next_bridge))
+		return dev_err_probe(dev, PTR_ERR(next_bridge),
+				     "failed to get next bridge\n");
+	pdfc->dev = dev;
+	pdfc->bridge.of_node = dev->of_node;
+	pdfc->bridge.type = DRM_MODE_CONNECTOR_DPI;
+	pdfc->bridge.next_bridge = drm_bridge_get(next_bridge);
+
+	return devm_drm_bridge_add(dev, &pdfc->bridge);
+}
+
+static const struct of_device_id imx93_pdfc_dt_ids[] = {
+	{ .compatible = "nxp,imx91-pdfc", },
+	{ .compatible = "nxp,imx93-pdfc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx93_pdfc_dt_ids);
+
+static struct platform_driver imx93_pdfc_bridge_driver = {
+	.probe	= imx93_pdfc_bridge_probe,
+	.driver	= {
+		.of_match_table = imx93_pdfc_dt_ids,
+		.name = "imx93_pdfc",
+	},
+};
+module_platform_driver(imx93_pdfc_bridge_driver);
+
+MODULE_DESCRIPTION("NXP i.MX93 parallel display format configuration driver");
+MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
+MODULE_LICENSE("GPL");

---
base-commit: 9499d3bc41a2c4e6a1badfb55f943b9d0c34f034
change-id: 20251201-v6-18-topic-imx93-parallel-display-95f9234bf6cc

Best regards,
--  
Regards,
Liu Ying

