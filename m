Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A250BD35140
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0369810E2DD;
	Wed,  1 Apr 2026 06:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VUKNCyuC";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC3A10E2DD
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 06:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dS/GMP4ymBL4DKuw+1Xpvh8AHVBN5y7j6Hw/g3zzD86d4+noM4Au9a5Frggm9q1PenBviGg64QOf0Hx4r6lqY4c2C58O1YKe7ZgCEXaawNgrZ9SQncMB8Mmr0JFEYh/G6uSNpLgb6qfSO79wXdXvy7Gd9UAu+nwGV0SF9nff79/Xd274lim6P1dJEEiyRMdWmjiIrsDAXDf10S+s+6A4nQyMUlq8VX4kIQPn03o1jKoxBBFB887dUvg4RixxMtz6X0PJEJ+Cyjoso7Y2LdFYNul9MsHOqTelMo/W+MQI6RLzuex2o57T6oCdnd4HscNryOA84mhp+KxruqdLAae4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAEZMs+c0bvADA1eB6UKHM7N4PadNbxhoWIn2ePaD6s=;
 b=tQ8361X/T39W4TeZ8DI0gGjSI1a+o5iH2m0DB4O1vO46yMv3MYJMI0nWCmkQ3pYQFPVAm4AwBreCRZXVAQfEFfBk2HDEtypQAGVpZAFyag9d63+5kXgRyn1b3xzbTXEAaJaQ2DrbAOWLWBE72yJUtGNAHeiv5iSkFsr+mLBwX36Iv8JRsxNkXrB6e9nZ9gsnzQxUNIt9zh7NbHbCyr/RQvjlD8ZwC0rwInm6Ay8VMwrO4uNxK0l/W631oUSxHbhYDMjEF55bZE+tiqHEAPM/SK5TQH+PYCvqcqDdvDF3qcPbclumf7UFpcox5hwhBmh63F9g7jMWYcay6z2PNjEEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAEZMs+c0bvADA1eB6UKHM7N4PadNbxhoWIn2ePaD6s=;
 b=VUKNCyuC1T7rgMyj4kWnABnNUh6s4EcJAzEIvp2b93qQxRryFDla6kIqwA1yGTvy57kIPX699pBVo7VtZy2orvltR4D7MygsnDDFtp/SnWmGlMADpKBoA1fbWZ3duLW2ualtkjlAO67e3Ql/D2KxOLpl2PQD4/Viu4oNi7AC0mjw33g365iMpnIR0XSk1mA+04xJbjffKvWV40ZPBDfmwO83jDJaEk7eek3p0tKCzMSgJEcRIE30fmvJiI2mKz+z8RDbnH2rG26Hy/dLYcsX+UyjhIHSTJk6NJom8s+Ez/+ccuuRlogtRFRrnPVrnN8bl5WdF/7vI21nZE732rhf2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU0PR04MB9587.eurprd04.prod.outlook.com (2603:10a6:10:317::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 06:43:56 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 06:43:56 +0000
Message-ID: <246ca728-1be6-4dd9-b228-7d99f28e1abe@nxp.com>
Date: Wed, 1 Apr 2026 14:45:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/bridge: imx8mp-hdmi-tx: add an hdmi-connector
 when missing using a DT overlay at boot time
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
 <20260320-drm-lcdif-dbanc-v1-7-479a04133e70@bootlin.com>
 <544112ab-8ca0-4622-b680-233457198e3e@nxp.com>
 <DHDNA5HLQPIB.3F21G9QPBUQG8@bootlin.com>
 <5f06ea5a-5388-440f-91d6-cebb0bee0a88@nxp.com>
 <DHG8G8FMXA6C.U6LU563OZ8NR@bootlin.com>
 <9a6e74ed-d4ab-4f11-ab17-25e1a2b64b2d@nxp.com>
 <DHGWUIUIKETI.1F1636GUBB3VI@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <DHGWUIUIKETI.1F1636GUBB3VI@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU0PR04MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4606ac-eb52-426d-beb7-08de8fba0bd7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|19092799006|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: nCS5djSfDesV3KXzdlFomSsIdm+s7c/rgxphnESneDM12lqVY9jJDCWEjmZYDv8EPTKZKorKRWWIZK8L46VXtnkbM7l7HnyCR1+h6ubOSDQCzu8M2iFzCX8lOZL/YDxEpfRwUkJO8tAnxMs6C1hycXchMxJgEcZLL7sTb5gMjVQFfUiObeiO3gw7GPFj5T+wjYJ9L7g2eKXeYmNLTzc4RJTvIxNXYhkBvtQEpSC5945pTXPrhxk74FlL4wF9nIJNnlKNGiAmcoDTkT+b4f3NdtbuLHyZGToJMskh2LBfB+Kwc4yLfehiJDcFiOT9j8fK81e68ha9tlRhUvcESIrSglzyNrMBs84Hf1eTXBzAgqkcHIFN971LlvdVc5pB9fQi014093JyWlN+y0pFWOtkSVWl+sExHveqyzgEZG/TeyIQNSRL2zI6bEk2TlqYuQe21M0z5IbF9nQty1+0f2UbWX7Jo+lE5wbJSAqMXgH2vgZLoLkL3ObRTDkEsddpldFPxZu13rVy5c1Dqw5S7X/xt3zUGH+U00Z53kqeOMOKY9URbHRR51KLRtEX/LoVdXjpcJn0jMGte9q0JsgISiUL90x+UYbXlR8q0i0mhwjrzoYF8uOzWe1ml2UblPNUNiWvdXWBNrE2Ww11kiRu+UDgFZTR9A7U0iEP6V0PDOMONM+mnIKZxB27ekgKOdPhhkc/XwccZkRs0zwnsll9aSRxHUSF9FG6V0AcgsvCRpquJn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(19092799006)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LytQV3pYbDA2b2VGZGNEQkd4U1J0Q3N3ZExwQ0NGMUtsdlJrNHFkREwvRGdo?=
 =?utf-8?B?TU1WTjNlM2ZVNVZMMlMxYXBnQlFIRkFrMnhiaHg5MXlHcW1WbCs3Mmg2dVND?=
 =?utf-8?B?d2c0c0RuNUtONmlLRHJxU3o2dHNVbVUreTVaelRXSGpSS1U2WVNHY2wzU1U1?=
 =?utf-8?B?RVpDSldCd3Fhc3JWZnA4ZWhuRmFnV20rQ0JEb1lrcFZvb202cUl5aklQVHA5?=
 =?utf-8?B?NTM0TGlSelVGN3oxMjMyOTlvTnBMZmN5Y0VGZEVhWW1ydW5hWnJmbjIzaUFq?=
 =?utf-8?B?aTdyOWtqTUtVU01PeHNrb1JwUWxhMEY5ekRxTk82YW9qSEtyV3pvaGFmTXZL?=
 =?utf-8?B?R0NSTThNb3p6KzNLdUNIbXl2Z2J0alprZU1BRVJZL0tvWlpLSG1kU3hJeml2?=
 =?utf-8?B?V1FnNHk1eEVRWkc0b2puSGk3YkFnOXhaWDkyOW12K21qeG1qSytRRVZsNWZP?=
 =?utf-8?B?MmFzQk5LZC9ESy9mMC9xaTZGb0JBOXpENkFhNjVxdmIyMzlaQzhpNlJON2FZ?=
 =?utf-8?B?bklmQmJJY2FUK1l6VUVjOEZ1ZzBqbGhVaVp3REFocnV2bXVSM0RCeWJVMkpQ?=
 =?utf-8?B?MWlMQUpFVnhkQnl4U1lqc1VKUTFRbWdScGZmTHBhdUZ1ZW5FbHZZeW4ycGV6?=
 =?utf-8?B?emp3K1RrSEgxZWlxSjFoWEl1MTZzQTlqVUxpQ2pubTl2alBRcWN1enlqaHNR?=
 =?utf-8?B?azdUdHp5ZzVscEZFZVJYVUJ6RExGOEdkajIxMzRVK2VoRFhIanRUa3Qybkkr?=
 =?utf-8?B?bWdMUm02TUN3bEs2andBTWVSUjYrRWNCM1ozbUk3N0ZOcnZoL1RWVFdXdXdU?=
 =?utf-8?B?Z3lMVlpObWtScHVjVXUxcVpydnZ6cnAxaVZSa2dyWWdmUUlZYTNFQ3VsRFlx?=
 =?utf-8?B?UHhqazNFODdKQndsV3FscjJXcGlPQ05Ub1M0VUZHdGVNdE5yUlphZHlrZmFw?=
 =?utf-8?B?MU5YR2xLNUNNQlEydkdvcWwrS1dnaElmbkZGbFlRWHRxblNFaEVIS2pDUzlU?=
 =?utf-8?B?bGR3RHNTNi9mVHZWcVRLZVBZMVdYbUdhWlc5VmFwcFUyN3piNEdwSjVqdUpJ?=
 =?utf-8?B?UlZMOWlYTkNWTURZaUptZG4vRWtQazBodE1QNkE5NUhDRHRNWkNkVk1xM0Q5?=
 =?utf-8?B?M3d3SDlXaHM3Tlo3ZTB3aTRKTzlEdTFEVlJCb29qYVFNZkdPNGRQZTR5TmF0?=
 =?utf-8?B?ZjVQSlFyN0tkVWlsNlRJKytUcmtMSCtVanFhdkE2Tnl3MkY2WXl2THl0REFn?=
 =?utf-8?B?bnVjN0JSN0NodVN5WlhZaGpvWG8rbFQ5UXhhNUpNMG9LbmM3MzJsTU9nWnBS?=
 =?utf-8?B?ZWRaaGJuQmNBblFSbUdRUVZpL0dHampKZU5HRVNWVkpsMGJablZOc2tnRFdU?=
 =?utf-8?B?aFZyZ1Q2QVMxaDdhOXFFNFZzbnZTN0VjcE00V0VvNEZ6MzZyQ3l0YUFUb0Zm?=
 =?utf-8?B?STZUMXJ0bUZDMlpaN1FOYitMY0ZiY245YzRoNFVQVXRuWUFhdW5KdTBEenVG?=
 =?utf-8?B?amtPMjhSVEZ1aTFDQm15dVpqeW85MXFBUjJwZmJBTi9mVExBZmNtd2FHRzU5?=
 =?utf-8?B?dnJTWHNUVFYvazd2Q1NZenBCQU9xeWN0RVJ0aGhxRWF0WmpWNWZwQTZSNExr?=
 =?utf-8?B?Nk5XUWZhaVdnNzhDZ3JpNFZkaXkzQ01uNERTcHR4WS9aS01yd1BxeGU0TjlE?=
 =?utf-8?B?SzRQZzVwR2N6WEtYYzVvSmpJYUdjdnZ3dGM3ZnFJaTRpcnBxMnhxMExZMG1Q?=
 =?utf-8?B?MXBNU1dQZDVjb01JWFF1L2JkYnBWR3lhUmdZVmFhWnQ3RytwQmIyRjltZEg2?=
 =?utf-8?B?V083NFpkT2VoMFdVUEh0aldNKzdaak45OVdGV3hXRlJDZnRLSjFMYnZXeTlC?=
 =?utf-8?B?aGQrVC9YNDMwb3NtcmlOdlQ0VDhJeGZZS1oyUy8vWnpCbWN5REtSL1FySVNm?=
 =?utf-8?B?SVo2emlVVnRHbHB3NE1OOFU3aWJrWFhqMDdBQUJSZkkvRDZPeVBVY3ZZVEMz?=
 =?utf-8?B?VVhnQnZhdWJZdDNzRDBPUkVqQ1VtMEdsaVAxME5yWnpQSWhvbVJBQmFUQU53?=
 =?utf-8?B?OHFnWFdZUXIxM29VZ2VEOWhsVTNETThSbnBiaFVvSW94MERmc0pMREUvbWpR?=
 =?utf-8?B?RTU2NEtqL2FNWU5wQUh6SFh3cnNyNklBOHo4NXkxZWNCZFdYRzdCRmJJRVhJ?=
 =?utf-8?B?cG1VTWpDYTFpYkp1UUlPbHRoRTBXUHprenhlbENmbDJFdG1vYW5kMG1nc3Vv?=
 =?utf-8?B?MkpVTnBiQ3lsbythUlZoVFQvMlRwaFJ3amE4MmpTVUthNDhoc2dYSkV5MmtB?=
 =?utf-8?B?TXh5MUhHUU8xSG51WERNeDNhOExGVEpra01BWjhYWkxqTit2U0xlQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4606ac-eb52-426d-beb7-08de8fba0bd7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:43:56.2898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sb7I5YzczVUhgttnPqCdtdPuoq+jvhATNI/8yj0iIej83EZL6RcbXWwj0zpBnz6or0ZoHkxPLVpY5Hs6mZCoAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9587
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

On Tue, Mar 31, 2026 at 12:54:30PM +0200, Luca Ceresoli wrote:
> Hello Liu,
> 
> On Tue Mar 31, 2026 at 5:03 AM CEST, Liu Ying wrote:
>> Hi Luca,
>>
>> On Mon, Mar 30, 2026 at 05:47:23PM +0200, Luca Ceresoli wrote:
>>> Hello Liu,
>>>
>>> On Mon Mar 30, 2026 at 5:02 AM CEST, Liu Ying wrote:
>>
>> [...]
>>
>>>>>>> +	fixup-hdmi-connector {
>>>>>>> +		compatible = "hdmi-connector";
>>>>>>> +		label = "HDMI";
>>>>>>> +		type = "a";
>>>>>>
>>>>>> What if a board uses another type?
>>>>>
>>>>> For boards affected by this patch, currently the connector is created by
>>>>> dw_hdmi_connector_create() which hardcodes type A [0], so there would be no
>>>>> difference.
>>>>
>>>> Yes, that's from driver's PoV.  However, userspace may get the type
>>>> from /sys/firmware/devicetree/base/fixup-hdmi-connector/type and use it
>>>> to do something.
>>>
>>> I'd say this is incorrect, the device tree is not an API for that. The
>>> connector type might be known to the driver by other means (ACPI, DP MST,
>>> whatever). So I think this is a non-problem.
>>
>> I just feel that it's not great to report potentially wrong type to users
>> through the above sys node ...
>>
>>>
>>> If userspace needs to know the connector type, that should come from the
>>> ioctl (DRM_IOCTL_MODE_GETCONNECTOR perhaps).
>>>
>>>> Maybe, that's trivial.
>>>
>>> Not sure I got what you mean here, sorry. What are you referring to?
>>
>> ... with the above potentially wrong type being said, I think maybe this
>> drawback is not a big deal and could be ignored.  Sorry for not being
>> clear in my last reply.
> 
> Ah, clear now. No problem!
> 
>>>>> Boards with a different connector should describe the connector in the
>>>>> device tree, if they need to instantiate the exact type.
>>>
>>> I think this is the only valid solution. It's very easy to do, nothing new
>>> to invent.
>>>
>>> Maybe on top of that we could add a warning when the overlay is applied,
>>> e.g. "imx8mp-hdmi-tx used without a connector described in device tree;
>>> adding a type A connector as a fallback; please add a valid description to
>>> your device tree".
>>
>> I'd say this doesn't sound a bad idea but I hope the message is clear and
>> short.
> 
> What about:
> 
>   Connector description not found in device tree, please add one. Falling back to Type A.

Maybe:
Please add a hdmi-connector DT node for imx8mp-hdmi-tx. A fixup node in type a is added for now.

> 
>>> Maybe pointing to a TODO entry in the documentation.
>>
>> To parameterize the HDMI connector type?  If so, I'm okay with that.
> 
> I was meaning a TODO entry to suggest people to add a connector description
> to the dts. E.g., expanding on the above suggested warning:
> 
>   Connector description not found in device tree, please add one. See https://docs.kernel.org/gpu/todo.html#<...>
> 
> And of course adding a TODO entry describing what one needs to do (add an
> hdmi-connector node and link it to port@1 of the hdmi-tx).
> 
> The drawback of the TODO is that items in todo.rst are supposed to be
> removed eventually when done in the code, but this one cannot be removed
> until some kernels printing the above logging message will be around,
> i.e. potentially for decades.

Not a big fan of adding a TODO entry, because those DT blobs without a
hdmi-connector node could be out there forever, meaning the added TODO
entry can never be removed.

> 
> So maybe the simplest solution is just the first warning message + a
> comment in the code right before the warning line, so it easily found with
> grep or a web search by who sees the warning.

+1.

> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com/

-- 
Regards,
Liu Ying
