Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A52E109C038
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 07:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BEC10EA0C;
	Thu, 26 Mar 2026 07:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="UqO21WE1";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D4710EA0C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 07:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+fOklmtwyJYuSUPTCyN3J+o0dpl09LtsBq1CCAI9zTF2HscC4BscWoSfAlAONcI46XGVHEmvnOcc28mfhWLt6ww0ntGgq3OeFOS6tvEUpsKbqu8l3r4V9eAsgssOm3bY7LeC78XzQc4BOgzWCrfosVWpQEhMXC8ThGOq+7Zcs0Abj2MgGFS+MtIX3SAkgBPozHIgxLllBBki2lcve3gnYiMOTjTZ656CJs8cXadgi+wDtwsi+he0OlcXXHuR2KmqRzhcs7HDtXEBrxmhbm2em48hBR6MJ98kwgYZzp7O49G71un5w+8G8tGMGCuXuLgl0HZY9H4D5TS7I2DIz687Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5M+GGCDZlAcAR4Vuvyi27XIb5lqJyceXnVZaaextJg=;
 b=KSFyeTbePK1LR6U4q+RwU6X/nSQGsdFyqGWDbiPNxAQu32yPLoaeSJRhgxiWWGGSh0864SGWUUtbkkSgmL2N/ekcN3mA8Tf/bosMMNZsYtx2+8Qv7cC7HVuVnuJKdGZzWNdLAey/EKffkB34PPPKQjMxDpNi3y6fI8uUXdRmnuTDucv4hKMvJfgzPXctsnu/GUmJGPmJXzzNV/VAkQmK/0din8jW0+XsNMHp2QH4OdkrmdQDV28fw/uNZpyCYKJFdRg9o7MsDRPpmGT1PfWzy0Xtlv/5m2HokdCU/OEMRZM+gyvotTIv1OSVW8tNaeE/87XbjmTHRejvcpq3INYLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5M+GGCDZlAcAR4Vuvyi27XIb5lqJyceXnVZaaextJg=;
 b=UqO21WE1/fmyu4t0bx62GC4opJMEfOe7u469onfbJWzKf2oQKrfQWowj6pyIJx92o6bDqR7E6QudgMHIQ9Pz8EK4lOffDUfM4aDcRKKSPic8QJUhyUU+5uRc1eL39jKJDradA/T0xAG6B6bRcd2Tft+NL8jwGA1donp9TrC8O/i5iUpuQTPhRqHgZ9MOpI2UZtm1aoYQtlEwEob48OleC6L0gJrTmRU/J1qkUKvqhf8KpbaKCQIA0pCVvH8rKniCAc4gOc3HTIbQuaYg8H8BY49LDc4PrMS0GSRb54lsszKnyFKU1zznukbSOQFmHs+FZxn9Hk2nuG8Ntk6UvZfuCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by GVXPR04MB10109.eurprd04.prod.outlook.com (2603:10a6:150:1b7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 07:34:01 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 07:34:01 +0000
Message-ID: <bc91bcbf-1829-411c-b67a-57b468fb9930@nxp.com>
Date: Thu, 26 Mar 2026 15:35:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/bridge: dw-hdmi: warn on unsupported attach
 combination
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
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Anson Huang <Anson.Huang@nxp.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
 <20260320-drm-lcdif-dbanc-v1-5-479a04133e70@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260320-drm-lcdif-dbanc-v1-5-479a04133e70@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|GVXPR04MB10109:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c4e1d0-5e47-440a-08b1-08de8b0a0caa
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 99z252inFUBWGeOPRbqxI8A6RjAzQ+0Y/6uSvqE1sjF0ziNyZ0XJNNZn39z0wuRi4d4byvnAyPeDCkRQpgbKqc1BseR3Tzdjtc30sFEq9XdQtdYgztJjtDGfHRQEiZGcWFXFbRBCDjR9Nsn1UNPmd2aovFV45zEMoxrKaNHX05Tzy7VhlNw801PlAY19hsSxV5FI9QhYJvxGXj86z1yv6UzN1iozAuuXL84NUn4E25RMEzX/Zrf/diCNCV4l7pU55Sa21cj8xLn3VsMHHoGgBL3mysRqQBnunTKAVOh09G7dpSG1JCumXE7cXRBvJTsEtxvujF1DT/4CNxCjCklpywh3PYKMosvt8s+/xTY2Nz8P1ce9pBcuocCAVm4We6SRX2P6nRnCa7rDTphhxQdFrooWQ1hklaCsJfI21Vy6eDy2A35MuPpZRyioEV/amEfwbTMyHLVDEBp6UIWJ8i3EbjsLfslcLvmAMbUsAUqlByN/WHWFI8I0fvn+a3rUZ/Y9yyk3y6xEutxpzO7RhXbPYgEpI8Y7DYln4KsyuzuTEHFk27JceIYoHTeUJsBsHfnEfVSLKJYBmzryiGz4twrYu+vBa1JICSvGVcxT0BtESMuTXuYnC1ZP8YRSbELGCRyd2h6tdnm2zxepHYSFCO7/eMgnA/qGDiW6j10cJkFhieqCg9fOHmCBS7r48X0yX0wZxz2ES6Bfm5ugahS2Oyi2ZdYDXiyuoHl4ovck5lSMCKsyjoCWWd+d+u4DwQLeIb3tpsp2ydN839GUAZqZUE1j4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlnMWdicjYxNGJtaXFsamFkelBpLytRWkY1VmVocjF4SkZpcHFtZi9VVDFN?=
 =?utf-8?B?Vkk2V2FHazU2UldVaUQxSTAyZlJBUHhZQUc0MHFaSUhIQzF3Q2tMWGRQWUZX?=
 =?utf-8?B?SDIyQngwUVF4cUFGOWxaM0szSXc3Q0lEMFJaY0Z0S2RwMzU3VDgxOHBQWDhF?=
 =?utf-8?B?M1M3ajBTQWJ6SGJHV0VJZFhEeWhaaCs0U0RlZ1B1UTh2VEtxdCs4eHFNQUYy?=
 =?utf-8?B?UGxydHBCSUhlWjVJK0w1QmpFdTg3K3M3dGdFTDEwQUo0RDd0V1EzdlI5d2ZI?=
 =?utf-8?B?LzdYKzM5Z1pHQko4b29Lb2NjakhBQUNXUlhXZW00L003Q0d4eStiNWhLK1Nj?=
 =?utf-8?B?YTdUNUFGNHRsVlVMTmdYc2RINUZaQTcxa21NNHpmZjBlb2FKblpoeG11TWts?=
 =?utf-8?B?c0cxYks4dzRsSXVLTFl3TUdxV1d0ODZyWk5HRy9RZm11cldRNUo5OG1MWW5n?=
 =?utf-8?B?SFZ5anorNlltTkI1SEdab3ZUWWltWC84dExSa0pxQ2pUdGJDd2N1RWc4RVNO?=
 =?utf-8?B?V2MxWi95ZG5ybmVpQjl6TmNKS0FSZHBQVVJ3R2VDSGlDRXhMUlR5Q0dVMTha?=
 =?utf-8?B?TGJGZnpMY1RQSGxwNmRnRmtQSlk3SGZtV3c0UlBOVUVPUmhvMVpTUGxvcWEv?=
 =?utf-8?B?WnFDdDFlNnZ3cmgwaVJ0aDM1OGorU3J2QnUwTEVTUks3bzZlM3NMQmhnOGdl?=
 =?utf-8?B?Uzl3djg1RE84b0U5cy9waW55djMycTBKK216Vk9oZE1UK0hjTElzbmdpaFJq?=
 =?utf-8?B?Nk1ZV3Y2RXhWNGFjdGtCUUZYN0ZJNWMwajRpckt2aFAvNXUwQmpkb0xsajM5?=
 =?utf-8?B?OHN4Z1YzN0VabWxiSkRiaXdtbXoxWlRoV2N1NDVOSmhFYzJka2hJZ0ZhRWox?=
 =?utf-8?B?TmYxWVQya0FIa3NzWlpldUFtSGdqOHh6RUlwclU5SGFWNGREYTVtUXIrNDN6?=
 =?utf-8?B?MmtKZ1J6STNFcnZCaklCcENhY0JJSy9LdXlzaisycFVkZFFUMXpyY1QxVDRY?=
 =?utf-8?B?czBkK28vZE1telpjS2JTNXI1N1VpWHhtTSttcEdyL0NPd2hoVE1FL05EN3I2?=
 =?utf-8?B?dVByVGlidTZDWjNtcXNXaVhDQnVzWmM2b1ZFRXhRWkFMZjJvb2sycUx0YXJL?=
 =?utf-8?B?aTc3KzNPdjhSd3BnclhaNlVHNmxsQ2ZzbVdKRDB0VVJuNXRMdWhpNlMyUmhr?=
 =?utf-8?B?Ym5jTlR0Y2NHYVltbUVhWnFNeWJvcVczNFdLZmV0YlBLQVJIbldndndtZ3Mv?=
 =?utf-8?B?N2t5TlVhdnArQjlGM3VpcXBiRTVNblRlWC90NGhkZExNV3RodWRSSHc1bmhr?=
 =?utf-8?B?bVg3citzNWVGa2lDcXNJcWxYUHRMaWNwVTllN213aVZ2ano5TzVnNmRQbUZB?=
 =?utf-8?B?VzZrSDloREdnU2N2akp6b1czZDIrVWlVeUxaQmhwdnZVUWNabWxWaXFFdzJm?=
 =?utf-8?B?UUJCdFZab3ZZUFhvQ25QZ3R6SVF5N0NXNU5YNUJqcG1tMkxiVk1OZnpDTXFo?=
 =?utf-8?B?QW1kRGVGY1VBWHB0SldFaFVaY2hPN2YxMTdvMEVlUVlKZ3FvWHJCVXp6OW03?=
 =?utf-8?B?UStBeGM1RHJjZFo3dTBWTStHVEVnT3lGZ1ZySVJ6cEN3TzJwZWxUbkxNRFc2?=
 =?utf-8?B?NG96SkZoTllaWjdtQ3VmOXp6MEQyaUZuVnh4cmdPTDArZFlVNDc5RktVMFdC?=
 =?utf-8?B?cHlKYTdGV01INW55dnh0eHdpd2xOS3ZWSkd3SFdGSGg0WTV6bUVzTTc5ZjRh?=
 =?utf-8?B?czJBZmJvY2dMMWJ5ekxEMGYvMC9oNXpMTm9JN2xHem9CT0Y2R1NuOXFlejdy?=
 =?utf-8?B?QVdKTkJ2NzlrcnNzWkFDR3UvdlFXNXYzQUlsc0pUWW4vaG5NanJldEsvYXc3?=
 =?utf-8?B?Ujd0NWgxWGFpL3ZoamFpT3psc011aTBuMTBmNHdmZmFxN3Q2Um12NGZRcThm?=
 =?utf-8?B?WTJENzJVRGJNMGpKbUpBS3puNkMyTHhTV3NlRmZ1ZFVYUHcwVkpPb3Z6YkJp?=
 =?utf-8?B?OGQ4RmpvM1VISC9pYUF0WThORzZNK2FFaDJzcHNNdExKbGlwcHIrYlJ1Q3g5?=
 =?utf-8?B?U090SFViU1RnUlRxdVdGczJyZk5WVEpPcnJ4eStGMU95TFdZQ3oybStUclFZ?=
 =?utf-8?B?UUsxTlFUblhaMTE4SkNLSGt4cHd6Q1MrRHVFZHRhTGZ1S2pZSGhUcWlWRG1r?=
 =?utf-8?B?Nm5HYUlFUUZFdlo2TzBTNTRHTVhQT0xHL0V4Ny9Sd0wzbTNBWWVJT2tCaXkw?=
 =?utf-8?B?UkZ1TTBGRGl1Yklkam41TTg4aWpHTFEwUmJET3hUZTg1R3N6a0dMUW0vMFZY?=
 =?utf-8?B?VXVsRGRBZkNvdHFmQ3pSeWZ4OEtlclJaM1ovVkJFUkdDa0QxQ3JRUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c4e1d0-5e47-440a-08b1-08de8b0a0caa
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:34:01.3216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5ICma3QphQ7ZTUtaD77FkU5IEIYgm5w5DGsD/YIychRlOANpl4eOi4DJh7wOmdf7I65c45AXvVLBiOqZi0iKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10109
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

On Fri, Mar 20, 2026 at 11:46:16AM +0100, Luca Ceresoli wrote:
> dw-hdmi can operate in two different modes, depending on the platform data
> as set by the driver:
> 
>  A. hdmi->plat_data->output_port = 0:
>     the HDMI output (port@1) in device tree is not used
> 
>  B. hdmi->plat_data->output_port = 1:
>     the HDMI output (port@1) is parsed to find the next bridge
> 
> Only case B is supported when the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is
> passed to the attach callback. Emit a warning when this is violated. Also
> return -EINVAL which would be returned by drm_bridge_attach() right after
> anyway.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Note: Returning when teh warning triggers does not change the functional
> behaviour of this function. It is not strictly necessary in this patch but
> it will have to be done anyway in the following patch.
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Liu Ying <victor.liu@nxp.com>

-- 
Regards,
Liu Ying
