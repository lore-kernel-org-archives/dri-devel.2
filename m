Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEA3CC6B00
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D44310E2FB;
	Thu,  2 Apr 2026 05:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="crFGR6Dq";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B42710E2FB
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 05:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U15COvhKavBcqYic/ED4ll93Y6VqzTdN8sj3gL5PFOVdwliyCfmjChCgTqiCabdwc0ASZE7MfraZdVGxQpuTlxakr62pppe+RAJ3pgG3S1zHje7qjYGstz10AQNk1FCCRorYT2yUixMM2yKSaKlbp9JprAxy3S69xJLeu0n5nY+q7gBWZvNZ9Wn9n9qqtTHqRsmpHZ25O/xE+ADMq52eE6XYDm9HJNi/4bq1oc9VBUxtspv8+yH3MnjfB66fOc5NwEwZQmFdVpPBlT/fWDIPyZfYgXo8bSL9whHyyWK5JRtzXBKBWmjZflqMTi/RdfDVwEU1dbAYsC7WwxmQAjkrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XoFwOqs3FSXe555QGfz6iLmzBb6+dl5jG7pKsmBQMM=;
 b=vBu9mX7KkNBk+tkVYf2oXhBKOhxAa26lG4vG9kOR6bWyyH4T2XoNAN4Mjny7mmFFJbpKvd9hCIw1lA2NqWCttZz3RvXPtE/dxTedjNHLKZVG6psCmN0b23hFfOV68Nt37laAT6DwyOY6nlr7+hkKvqznNF8w7Ii5iEW41b4iWUE0aXDLhCtDzwxqfGAJvxxUhF3QW38GF7+HRnpU44iudkZLwGlRKRNVgFIoGZL87ZfQ6MnHEtQ/7zBrM/BZtyzereSnvRQ2jvOBki27eO3AUkPalZSGeMF+00enpeD34Tlupx9b5o+pY3hvXjMicEhcFhhlUDGqMFpwMF7geJyGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XoFwOqs3FSXe555QGfz6iLmzBb6+dl5jG7pKsmBQMM=;
 b=crFGR6DqVG2WWQuU39gmBKGLFbnAaOouZZQlO8OQnph1ehZdFeUtGsoeHgteGE5lgTDv3iQ8ybg2T1GpwqV+j2d7dgq9m6+lfBnW/Q2Oja/p3pClrqRIy7JCTyYJyiLRhGCxwU+luhg71lp5Y90HH4PcN+oHc8PtIa46VlYWH7bTZ445LTQEFPMU/StCktfJal77eV6XD5BtvVXlscxuIsl+GDBKRiq4HCgsumariwmN/YZAkYcCGGKcPvv121BmxGYbyxcXDV+TKvsdrscB3AWDKWWsmcht5/22Ne1MMR+VSgfiWlR3XNP1asUfTSHg7EDnyDA4qzcH6h3al7Nk0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by GV1PR04MB10487.eurprd04.prod.outlook.com (2603:10a6:150:1cc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 05:05:56 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 05:05:56 +0000
Message-ID: <c9133b15-69b1-4d7d-8d1a-7f033c25ec52@nxp.com>
Date: Thu, 2 Apr 2026 13:07:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] drm/mxsfb/lcdif: use
 DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-connector
From: Liu Ying <victor.liu@nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: Damon Ding <damon.ding@rock-chips.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>, Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
 <20260330-drm-lcdif-dbanc-v2-10-c7f2af536a24@bootlin.com>
 <1a8b1a34-89bd-436e-8b5c-64ea71e8f333@nxp.com>
Content-Language: en-US
In-Reply-To: <1a8b1a34-89bd-436e-8b5c-64ea71e8f333@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::9) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|GV1PR04MB10487:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6be9ca-1179-4f39-df53-08de907585b2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|19092799006|376014|56012099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1YqSqTm+SIv7IkHclUh+Hv8kl0F+/bemUcE5sXPVvGnNoPa4l9N00H37c+SGRs2lDH2drsFV16ZfI6OJrWO8WuekRP7hYMzfg0RPIAUuawhU6tjpPHkWenA7cHkZXnUGTYjrzg2+LOtPWRwucI6g3E23fLTw4+MUxvXSVOMrjwyPi64AbCsv/ooQNWr55FMoFFSy2gg9jWu8mdynqCzaxN0G2MQJot2uDNpyNUUdbRxV74rneXjWazWyQ1mf0E4kXxHfOZkygZLtJXgBbCnJaZ59h0AI+OgatNL1/o9LdBnBdC4voDpGg4YAcYsta4IL22b0mx7Bm5xmZGg7VzjaxNb3R7cSc8b8m3xQ4Ga4NejsN32H2q489LrbLCIjDTCT2PjJ6enyg3fE8SoT0ZoO0StdpxSfDCd6hM54jC3cUJzZ+qeX0lx9DkLAaQRmadGUZV07jK/0pzXsml4LyutF3GOJIBqT8zJLRDj6LAT0QWPgGbAMHkQ+XqypIBQBInF1Iy8TKs4IDUSnqy0uTd6rl6+NdQusNuKy+kU+NTibahq7Fca66zl21rDjJZxpMldPCRb3P6MFdzIY5gDiXkv8eMeWQAI3BAAHaRw0rbykKMXDWYV9iwSLelBuTUaSLWFD2SdKRkBD0FhNSVDqrhadRVf3axk703YusUqcgMKjEl7GFpSf/hIpiCdlCEzHMwsgTGga9ALwLcUBARiAHqSds42qxoU9aImLMmgRhAlVEF+/gKYx7ojXougwj4s3sYv2iD9pXZR5mRGyaTZHzFTgig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(376014)(56012099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zit3R3ZUODBEaG1mbjFVT1hwU2VvdkVGcyt4R2I2YWptRmNaVWlYUlZNelI5?=
 =?utf-8?B?aHFRZW5mbUpob09RcFRaVmozTE9QdXBndVRGZjkrblcrTWl0L1lCVWdaSzBj?=
 =?utf-8?B?RTNHSmRlUHB1WmxPcEE5VENzbGxyZW1mVU0rVDI1MmtoOFpvUkpkREx4RW5G?=
 =?utf-8?B?anJ5YjNqYllYeXBYSU0ybHdOYlZRRmREVFZVRFdpbnVvbWFHQzBzNjlkRWlS?=
 =?utf-8?B?RXZURE5EUFZCSnE0TUlndklkcEFvV2xYNithUlpWM1BTb0V0MXlmcVJ6dTAx?=
 =?utf-8?B?M0RYR0tlL3BiWnZTS0diNXpXUDJNNHIvNkRPaXZ5NmxQMGdhdDlacVZPaE1Q?=
 =?utf-8?B?OVVHeXI4NkVTTzBuT01LcStjdkxtbWlVaXVCV1JnK2s2K0M4aTlrbkdMdkEr?=
 =?utf-8?B?OTAyQitPRzZrdjdrdW9NMkNIQXJOc0JiMFhnR0IxMWJSd1RzUEFwK1B6cWcw?=
 =?utf-8?B?cmQ3dyt1Q2MwVEpwc1N0RnNPTmh1TFhJQ2gwYis3K0hMYmJMSXYzZDVGNDZz?=
 =?utf-8?B?T2dQdGkwT0QrYStXdTlkbk9jQTlRSFlpQmE3OTg3RGRMQWJkVGw0Q0wxZVM3?=
 =?utf-8?B?ZDFIenlKeTZ4eGY2UUZ1OXY2RzZKUk0vV3JIWVZ6MGZQeUlXWGtWUlgxL04y?=
 =?utf-8?B?dGtMWlJQSk1HQ1hTM0UyblZHVDA0L3FnTEpPNzJiK3E4KzBqeVZpVVdSdGdk?=
 =?utf-8?B?dmVFUXBzZ1o4eUoyK2V4U2VmTTFOajhobnd5UDFMRncyVHcxbkNhQ0RDUlB6?=
 =?utf-8?B?TUthMXllQkFiMmJjRmRSV29zZ0ZQNGhZalRKK2d4c0N5RlRISVc0OHl5MzNW?=
 =?utf-8?B?cnNZQVZCemNpMXZwTzFISVNZbGRsd3BXNStyR1V1SmxmVllMOS9IUnhPb0NV?=
 =?utf-8?B?bmZWM0NzUzJKTUZ5OXVyaGROREkvdTU4eEVCNE45VTB5Qjd1cjh3YlQ1TnJy?=
 =?utf-8?B?MWZuNWc2YTNEUUZYbjRSR2NuTVhYbmo0OEx3NVdndEp5RE9ydmdGWWVpMWhG?=
 =?utf-8?B?YjNRNWtHTEcvenRVSzVvcU1KWjFOdXF0U1pnMXUxYVYzb1RDV2RXRkNvbmti?=
 =?utf-8?B?MVovazZNa1cybGd5UlJHaDZzMmpFVTJiZ040elFKR0R6MDgzajZXRFVBeTdy?=
 =?utf-8?B?blJSMk5jWmI5S2UvTTNlZTRweEZzbDZmSUFiWGJrSTNzYWRudXA3cUFxTXow?=
 =?utf-8?B?dGdzSXlGUjhscFdjSXNBTEhsY1pNcXcvMVBRdFFXVDEzWDZrL0pYYmNERlZ4?=
 =?utf-8?B?WDU2c3BVWjVkMDgxWUg2ZUh2K3loZEU0VG5udDJySzBvcTNiT3Z2bHYzbkJG?=
 =?utf-8?B?SDl5akYzL0VQUDdlRE1qc29JRWtlQTYzalpxL0crQ2t0alV6b0E3WFRWZW1z?=
 =?utf-8?B?UnRVanBmR1hsME13blhmb2d0YjhaVlB3WkV5NVZmbXBwblZoUFZJZ2YvTFpJ?=
 =?utf-8?B?b3hsTEhRRFdQa0JKb2piUUxQbE42SG1qMUNlMCtrSlFpVGQvZkVOWUkweXRi?=
 =?utf-8?B?K0ZLcXlSZ0FacUYzNk5sa3ZHMWtMd3FJdHlvWmpwUEtuaWVFQWNFRzlITDZX?=
 =?utf-8?B?M3JSMGQyWTI1MkhITGNwdHJsZWtQTWo1dE9Cd3E3bGVPZGVyMDRrMFk3RGJH?=
 =?utf-8?B?anJydFVoNEdxN1M3T20wVXdJUWQ2Wk9pZXJUTng3ZStobDJzeVh6WGJZVk15?=
 =?utf-8?B?aGdkc0hLSXl6VWM4eWFLdFQ0bndQMS9RRmlxcG94Uzg0d3ppa0FVY3IyNkRl?=
 =?utf-8?B?dFAvOUE2WDQ2Si9qR0JYRTR6ZWs3Vmg4MVIyUWZQd1BQN0t3MU5iUy9scHFt?=
 =?utf-8?B?QThLN2ZTckN0TE1HZy9qejI4WDNHNE9DMFhqTGV2ZllpRzRlQmR1ckxTbG1N?=
 =?utf-8?B?V204RXpTRjQwd2h0UWJPR2V6dDBSUXIrRkFyZUd0VkF5bVNPQU1xWnkvRkor?=
 =?utf-8?B?Q3BpMG9zSDZRbFk3bzRCaUFlODBVaDRSb1JsbG4wMEk0d0QwYUpibUhkVTVZ?=
 =?utf-8?B?YnQ0Qi9zWFVQTGlsZlEremZmRXNPNUUyR013V0dBeG00Y3lFOUpXTWkwU0dU?=
 =?utf-8?B?eUFXSlBIYnFoZnlYQVBYKzdNY1I5VENVWWNtNnh3ME1VR25Vb2taWld3L2Jp?=
 =?utf-8?B?cVllTzB1WlZvOXZwb21LRGxQNkFhd0F6cjdrakpHVFcvU1gzR2pPdlVOVm1I?=
 =?utf-8?B?WXpIY0tLZm91OWovbjZnVDNVYlcrSFFveHdENnJzd0dKajVVYVA1TG9nQlRz?=
 =?utf-8?B?czBHeW0xWlF1VkVJQk9xMCs3VUgwMC9lQnBZV09QcmVXNFFqSDlFNUFzOUQ3?=
 =?utf-8?B?a0tNQVdzZXdVSjNMNVlick5vOGV2ZVI4MkxWVGFIRjlGaFhVancwZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6be9ca-1179-4f39-df53-08de907585b2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 05:05:56.3202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAbq1qii3tWnmL5FzN0MFzzytpIVWvu0dMZDKtLqEVau/FeXWK83q5s9hgfduQFs5fUNFxpDiX7iwb3XYVJg4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10487
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

On Thu, Apr 02, 2026 at 12:55:32PM +0800, Liu Ying wrote:
> "pitfalls" in commit mesg, which makes me a bit more worried.
                ^^^^^^^^^^^ Typo, should be cover letter. Sorry.
