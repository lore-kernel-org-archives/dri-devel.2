Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038BB109E55D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0F810EA09;
	Thu, 26 Mar 2026 06:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="MzLD9Djq";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013022.outbound.protection.outlook.com
 [52.101.83.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAB810EA19
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHdjFxyNGJqxeWr/Xm37CSVp5t7/F+lf/YiiVWHNRifwzNg6R1rorJHJA7dLqCYX/WIX3Fs92w5zXXHKYU5154s4N8aPJOzrkFP75nOGuP6JeSKa5n0Jg8Wgua04/5AUNLxQ6fdBsf4UC4ixixmcRFhyrpwfLvYe57OxLX5sDjwkqKQ13t2AFhJl1EDZp+KWCP60Vw4GwA0CKNuOkZ28NzXrFlCRDAmXruETM93FBSa1aQ7Hd3QbprTZmvFqItYumF0PlgFgFshqZJAZbfesszdxhU3oRP3ZiEss/dbotGD8/nJDp7oqlseCwf5YooSsCRo7oWPCsQ4na/SHQxX1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgWYvRkvAa5X4azX7BSK6y2mI7ax3agQ0W4G9Z0Teag=;
 b=WkZpMXJZdxiHWI64n7eSUiBpxLujYU4xBgBC/tSkm0lEGm2Hq63pi5c2VOJqnpvmwpC9LXCF/g3n8HLDKhn9dlF2DaJ8pGc2Wltu/QshMLedLAU3tOAxZkOPpU/8y+kTIsWyUP+xgClU61l/L/At4S3en7L9dlsNv+6E+ukE/dsa++yU7JIsHr2lGH4JDNOIayRklznBhFccy4cD6xI8pm9jO9WCPk3novWj5Fl7qfRlMRHRQ9eC1MDiTMO7zwNEVWQt4LgIHySkcmhsrXuxwbP1NHI/+B4UZayZRoWLBC+s1/ZwhbaX0+CmVPVAb17nkVCvHtCYIsf9LJOLxTwPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgWYvRkvAa5X4azX7BSK6y2mI7ax3agQ0W4G9Z0Teag=;
 b=MzLD9Djq+JUrfdW//WVITO2KZuEvg3eyiIatHgOCj5jDV+ry5ZZn2zTNtfHMKr/LMIwYClq41GSAf+cnHZHqeQ/9JCQl18pgB0mvDaftZoCaA/mDLOJkdoJZG1DjPzPRGL6B74p7pcgOnhiUaA/GWwP5d5gKo7B6qJ33ixW8kS8i5PBE6bMpzhcOwsvtth80+ndW1xrAayISYqNn92AiTn8HDBVQfUwpcHkxCtB/0XxUqBFP7h2YPtDMECLapVWgwxAUWZN486J2X/w7Ut20/DPZ4Npm+zzjEFRQvCpLAw498M+Wp31DBk7keOAmS68yDt95zygGeWEmsP088ioQxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:58:46 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:58:45 +0000
Message-ID: <299ea117-c628-4094-88f3-47c8d898e15e@nxp.com>
Date: Thu, 26 Mar 2026 14:59:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/mxsfb/lcdif: don't unnecessarily loop over ports
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
 <20260320-drm-lcdif-dbanc-v1-2-479a04133e70@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260320-drm-lcdif-dbanc-v1-2-479a04133e70@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0230.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::14) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DBBPR04MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 8558d67a-6327-4b3c-f30e-08de8b051f92
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0YONILRC0gUPcS3JNIsUmBq8PrM1zjVGJGnmYiecUEpojGqXjytnq3a64izerA664iGWFBYYBaTEc0VwwWKufgH4cQztxCnLVFZvEFt9wgMmABhdNziNnqPpaMulmNq/0SiFvahpoH99IOdtlwrHYnZ2JBoOa5KhKPN+s/wkGHSb/Fk68o6pR6RSWvBK7X3uK+tRSUj3fhPRWjiWsT9nxSvvqrWx5N/UcBiGY6trHIN9U1UQ6f9q1WDXQuBqJdrjvRg3r8XljGraM8cTLhnr4IxKQ0bRwZ9nRaGoPJV67Ak+6nzP8wYb1EfQMns2E4yUWaLke46lngUamSJf2OrpgkAT9f8GtneQdD36J/f73z50BvID/dFAj3RVMBlpP/zfE6jyWUGhJ3KyBEQ22ekDZlU5xonsa2EvEXt/eEVYx8BkKFRJoxVxiIUpQ1QD/fM8W+q/SEAdLYlA3fQyVY5gGv/En4LXXPpX0LeCUHBxJzAWJGKvc+ot1wU+ZhP7hY7hAhV4BfKutwOFRmAUHxLjrTEdmlMf4ojyaWfRoJOrzd10kUdhmFaDhcyaawL8aHqPx4iogbxsrg/oI+cOm9vI6RJAF43QB8ROnV0coUixL/C+aQtCZDYTNN7Nny0tW8mZScdBgPohEEdWRdXaXv66e9owmvpDNLqD+JNTz0zcaPtYjINK9lkybRWsPI48ZU599v6MKcwSED5Jk9ahuKUxebWk4rr+MddwDmTxYsU6QMnvV5TX5K6dnguHEojrE+V1ygJiyyqdDPCnSNQ40eFcCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBaM0Z6MjlnS1VyaXhpS3NHWHY3dDlIWTFrUXdyVmVqVEdDYXlnK2gxK244?=
 =?utf-8?B?eCtVQUVkektjTWRVaU1aOUJvQXpPYzZZQnlITTl3L3VzTVRhZEErNGp3NnFE?=
 =?utf-8?B?UzAxSU8vbjZ4UGJUcWM3eDRCMG5DckZ3TU13d0lkSTdtN0t6dzRkZm5aY2FP?=
 =?utf-8?B?NGY2dnBVY3lTT0trMmE0dEFTRUgzTHpBR2JaRHJpMTNsakljck8yL1Bva25u?=
 =?utf-8?B?RFlFVWRrYi8wODByVFo3NWpXc1BwMmZSK3ZwNTN4KzdIZ0pyN3had0FtNHlW?=
 =?utf-8?B?ZktJbkZleTJRRVpPSnhhZU1ROFgzS2orbDMwVHJaYkw4NUtISE81bCtDLzVw?=
 =?utf-8?B?cnR0eWtpV3IvVHBEenA1SE4zZjl1RkZQeXl5Ty95S2NodTRQaURETjA1bzRJ?=
 =?utf-8?B?TjRMbElhOVY1TWRPZTFNSnlIajJPOHYrY1o3REJlUllFcWRMOGpMdDV4ZG56?=
 =?utf-8?B?S3huTTVaQjF0NWRjYXBWQ2xoby9ycFdEUnhUUWd2YVQwMGJLaTNMemxKNmpU?=
 =?utf-8?B?aGxvMDVGRFoxOE9VOFloR2M1LzlzdVRXSWZqdXpoUE55QWxndjM2Y0lYUDBR?=
 =?utf-8?B?ME1vUlBTeUY0cVp6Y1p4c0d6WDVsem9iQThRUGU1ZDFHajlXQ2IxSStVejB4?=
 =?utf-8?B?dWhEbkRqb2ljc01tTjJNQ3V6dEFZMzVDWFVmUlFPQzYxOWxMRWhxdXdBR0xU?=
 =?utf-8?B?VHkyV3NxMTFoVTFWNXpWYkQ5WnFWbXVCT0ZPbkdqMEhsZyt1MW05SDRaSHBw?=
 =?utf-8?B?aU44OVdIeUlTanM4WThBNlRNQkRKb3g5eVBOOUtFRmJuNFY0UFFJV1lFNUtt?=
 =?utf-8?B?d2RhLzF4QWI5UHBEV2xTTE5kQ1pRWlVRMmRqUGowQjZkUTM5N3NYVmRkNmZQ?=
 =?utf-8?B?V0lSK3VFTDB2QWxnUmczUjg4ZXRXVDdmWWJSN3FtWVAxbzBGUlRKT0RaMkNF?=
 =?utf-8?B?MmN3eTdhV2x4eFVIVlA2SmFYV0NmbzJGZWZhTVBrMDFNbGdWZ0tWc2pJSGsx?=
 =?utf-8?B?SlNEN2pHR2N5cUwyK1ZPd3RRd2p1RE9tTFo5YVJ2cW44Nmxkb2NqVkh1UXAy?=
 =?utf-8?B?a0hYdEpGZVRpUEhjRlV6OXhMczEzVzlLVEg0MzBIbjhEVlFydUI5QjNSRUty?=
 =?utf-8?B?empZaUNhVHZ1UXd3UWtRdGRMYi9GakFDTTdybE9QKzdTUXJqWEhRK3pkck5Z?=
 =?utf-8?B?bFZWVXgwWHRweUtuSmEzOTU3SjNOOUlPWnhQMENMTWxHUm9weG90eUQ2TnBU?=
 =?utf-8?B?WXZpSEgxMEJ4aVgyQVgxQWlhclA0TDFPcEUralBPbktQajBYdXI3c2pqQzZN?=
 =?utf-8?B?dUVYMysvUEJNc1VDQ2Q5azl2NTVadVlhL1FCNmZRMnZHNDNaaGRxOGlEOWVM?=
 =?utf-8?B?STVSbzZ0S1dvN203M3pQM1I3K3pDcGRiUmw2NFphY2s0OU1zcDUwUjZGcXd5?=
 =?utf-8?B?TUxzMnNvZUxzdUpXcjR2WURCTmkzVnpvMmdtREhsQ0xjNXc1YWF3ZGRLK0kx?=
 =?utf-8?B?QTFOZXh0RjJrVHJ1WGpWeHBNeFVhdXZ0dlRzVWMyeU5IQlZORmg4Nk9hL0Jo?=
 =?utf-8?B?SlJ0WXg0Qjd6QmkyTVBnVy9IR1JVbUVLWHl1TkNGMVlJZ09BN3BaZjBMVWR5?=
 =?utf-8?B?WFB0QzZjcG1BbWxtWWJpZGkzRXREdXE3elBnUURqNXJQb0ZudkkwR1VrNS9L?=
 =?utf-8?B?ek1HQ21BMVF0ZUtQQWtFU1F0blZTbkc5NW9hVzU5U2w1TGNnUEU1czVJZk15?=
 =?utf-8?B?L0NkQ3lId25admYycGR1c01weGtHSzFWa3RzR1ZGVjY1Qy9qMzIvNWZDV2ND?=
 =?utf-8?B?NFAyeTNpMnVmcHBQRVVTd0RpL3IzcEdyTVF3YmZmRm53NGVmNnVzUUE0M05w?=
 =?utf-8?B?WW5lS1lHZ0lmRWlrNXJza1JzT1RXRXZOdml3Vng4ZVN2c0lBSmRDelQ1Y0xF?=
 =?utf-8?B?MmZZQThQcFdyazJxZklFcmREYmZjaWtMNXBnb2xZUEl4OXV2akVsSjJGTnZQ?=
 =?utf-8?B?SHBRem9wQUZwLy9Yd2t1Q0lXemxYTTRoYkQrZHlldThzRnU3VkZhZjk2MjhI?=
 =?utf-8?B?b3RMWmo2OG8yZUJnNGorZE9CT2NoQVQzNVZJcXJ2eGltRkxlVHJSNVV6Nk5V?=
 =?utf-8?B?YUlKSHlvNG5KOEVEaE5UamVVdVMxWCtsaEFFMkx4TXZ1d3dyYTMrT2ZCSWg1?=
 =?utf-8?B?dGdqbk5pcFNUSGo2QUhYRTlBd1VreS9nd2ljMXNBQzdkQXg0bGFMZjVad3VV?=
 =?utf-8?B?Um80SW5rU3JEaklURlhYSTVCSThuL3RQVXBHcmZ4b1o3M1pUK2E4c2hRd21W?=
 =?utf-8?B?cUc2Z0gwL1FYanJCaUJTWnVDQU9NM0tqazVZWnlzUVZ1ZGNOTDBidz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8558d67a-6327-4b3c-f30e-08de8b051f92
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:58:45.8570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rhl0QAVqs78gtx0KWv7HkvX+OfzCvgfIlo2BciVcEfe+h8VhH9jmvnBFLuj6zgI7x30rG8KbbX4klMBmkknmnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7740
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

Hi Luca,

On Fri, Mar 20, 2026 at 11:46:13AM +0100, Luca Ceresoli wrote:
> According to the bindings [0] there can be only one port. The in-tree board
> device trees also don't contain multiple ports (searched thos matching

s/thos/those/

> 'fsl,imx(23|28|6sx|8mp|93)-lcdif').
> 
> Avoid an unnecessary loop around multipltle ports. This allows to greatly

s/multipltle/multiple/

> simplify the code.
> 
> [0] Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Viewing this patch with '--ignore-all-space' is recommended
> ---
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 77 ++++++++++++++-------------------------
>  1 file changed, 27 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> index 756ca96373c8..83e134c04882 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -48,61 +48,38 @@ static const struct drm_encoder_funcs lcdif_encoder_funcs = {
>  static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>  {
>  	struct device *dev = lcdif->drm->dev;
> -	struct device_node *ep;
> +	struct drm_encoder *encoder;
>  	struct drm_bridge *bridge;
>  	int ret;
>  
> -	for_each_endpoint_of_node(dev->of_node, ep) {

The single i.MX93 LCDIF may connect with a DPI/LVDS/MIPI DSI encoder.
Each encoder maps to an endpoint in a port, hence 3 endpoints in all.
See lcdif node in imx91_93_common.dtsi and imx93.dtsi in linux-next/master.

-- 
Regards,
Liu Ying
