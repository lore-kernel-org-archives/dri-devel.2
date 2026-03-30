Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E023FF4933
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 03:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B123110E0B0;
	Mon, 30 Mar 2026 03:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GxoihNLE";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83BEF10E0B0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LS6DPmi3vbgZNfiiZpJLS4tAm4wG+XlN86lplzx2oi5vTsVB+aU/Qs6cUvNrgtNvdd4MsAynJvGq5CgjMlGrwd3rQP3x2cdRTKDlbqnTv7MjqdQO/aKYp79LEemvE1dlhadJ7HLqSnAX7cYJJaaAiwZHLD5Ze7Us0OqtT5eJu50N+bNOPMfOafazLNtoUWJKi06QxyRciqwsbyOyF8Sm51JTScO9Fg8Ye22Ff85y1BHmmtCy+/Z0vsWdlhBrj8PajxaHLN7tpbTACXDcKsDzxC2J2HNlTHDyWX/TmvuGUmT9CfbActroilv1mDeKDu//oLZRVJGxiaoG65wc3zwbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMSmJuGWyAQ6yuN5IaBF6OcvSuFOuet41UJ+8BQwkM4=;
 b=gFyQefEnqTKwGpYwup9apbJOruIT299F6aOj8ZhLo4Koljb5EE76SP7EXRKDR37BoTLlSvLi9eJN9JbwJm8JyJwIILABBmhALOqS/VjBHGbrhAYfNRukfStUg+Chf5RXS2OOjuLC4j01sSCLUtTZeB9f9J4T4i6jqKfxjSgUeiDEkdny+u/XG/KLum2VGtboVqr8dOQfEd3Wdl5kU9S0eEx3zQYD0P6+9JCbVadI8UxF8QIEQjzcy/jOKDLVcsNjH8L6BHxcmVQz+5UGR93bT/SqlEVJPD7NuFflNuNcazedmNUw7Ss5i7miNtBxurzzY5iwUDG718mk9jrVUHw3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMSmJuGWyAQ6yuN5IaBF6OcvSuFOuet41UJ+8BQwkM4=;
 b=GxoihNLEbAuZS6X7LZ5f4XLqSO4eg6NEdREY107kPG6y2fQnx12DhSuMPJ8SmAvu29EfnlRnFQ87unc02NYdc/RN9U08YN3+XqM/pVPMznRpwV3nu3Fs4aWrXaPjmu65C1yF89XpCXO0uHBVifX71AJEf+foBlCBNif45gvBpM5hm+ht+ZfUHCH23xPAq36yIOsBW7ipHsi5KETGNYzMTW/3uaqfwy/0xBieuh+0QUida+b7+D6WMtdH2Gg+xI2HJ/myEsjZMEPq/DFbG3X8Y7FVlle89lMx/iRqO9hstSMjqhT6hLqVNKTjxlp6L4xXYmmriZLGCcCZfH5LFZQP6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DUZPR04MB9984.eurprd04.prod.outlook.com (2603:10a6:10:4dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 03:01:10 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 03:01:10 +0000
Message-ID: <5f06ea5a-5388-440f-91d6-cebb0bee0a88@nxp.com>
Date: Mon, 30 Mar 2026 11:02:15 +0800
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
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <DHDNA5HLQPIB.3F21G9QPBUQG8@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MA5P287CA0129.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::14) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DUZPR04MB9984:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cfa555-0b08-4cca-f597-08de8e089849
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|1800799024|376014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: KofjY884xCyP/VcrueyV8Uh71TD9wyH2dJfaP+G/gEGx+U/Ct0hGmmcRf6ix2KBCwXZeGdrF4OZZIfJiOLCV49qSwVDLPn9a4rtCsBmbJaa4ZQAd1rktHDTjlxIMWVnlBsEci+iXFQMX1+bC9xFCWn4jWz9AfALnho50vhcmDzp6vJyZQs0LbnWYvW3ij/f0wadQryyxAkO4TDem3F7E4DUrLiYs3iDezRocjbJIVGmoX9COEtxydx8rQfeEXKaisAWUfrFKSn/wAR283qMWvpUXuyS6lrGvDY6cAK+zu6JDZOWD009KBKQJRnM/QrpE4IQutrhbr4cPcUQY6HJbIRoldI0xPujDl76U20aV1pURLQTffzPt6bg353OBD26lIt4gMzniRADmxbeFRJWFeJlMy1p9eOGTkOd4isi63/PGNgbdmFROGOF5Uej3WZgVTK7oo9HcUuR4PfQLuLbz0BAHiAhUmg9Q+YRapmEAEBNEpCQVE/wzmotRdoRQrA3MXrNR5BdAG6/YrLPRpuHSd0lEcC41w+skwgHRXFiUZigOwyzAB4CCd4JMr85rbYti8nXNC6o8mcVsNYE79pY0hOtcuB5ECbDaOUvZS2G/MDygwm5SaeyDoZ3a0DFvxqDWQJxMki+Jss+VP+1Cle3lxiHl2GwQtEvOH5y53N5yASP6ncLH4hlxaU1tY43Z6LqWCJ3HQKz1arLW1thOfiVGrVmPLJG4L3YTtpOkjHnUnWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(1800799024)(376014)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFJoTGtEU2VoQ1BMdFN4UHNvRkxFVWpLUmkydW5ZK0xKSEZ5WE9udWlrMmJk?=
 =?utf-8?B?UWVZbjNDaGw5UkJiSlhCbHdQaWVPeVBtVWN6YjZVWHp1aXRiMjVOR2NzZ1Q1?=
 =?utf-8?B?NnNZcStGWHo1azBKVDJSaXlWam5XSlNWNUNxSnFML2xjQS9ma0t1VFFqaCsz?=
 =?utf-8?B?QW1nMjUvY1o3YTRoK3k0UlUwdmt1UGhoQW95RzVvK1c1MWNyWGs2UUJNQnA0?=
 =?utf-8?B?cW5XejN0MU1yTG1pejYzVGk5UnEvNm1mTCttVlMxZW9maE9Bcll3eTFFRzFN?=
 =?utf-8?B?VCt3TXV6NXFZQlJYMmtZNWNxU0NSRDFkdDVtMkRVQkxGSGEwcDJ4MzkwbUZo?=
 =?utf-8?B?RXpzRklaMk15NG8vYlpxZWF6Sm5xMmlPcFdKZlpLTVMzdDJ6ZWM1MUVHYTdB?=
 =?utf-8?B?OFQyejNXQWFtWXh2MFJVQ3MzRHdhSE1kNXA1WXVlUDIxdDhNbXBWcEpRWDZ2?=
 =?utf-8?B?R2Y1MlJjN21kMmFYYVBPdzZ2U3pDcllqdnh0TG5uN05FV0t4NTJsL1RRZVJh?=
 =?utf-8?B?alJwSjRXWE82QnUxWlptUXNVWkVQejE1M0djak92NnFxMGNEc1BFcFRFNXpy?=
 =?utf-8?B?UFdZTitTbWN1N2Q3RmQwWlRRYXJrZFlVSmZncUVzaldmOW1xK1FKNjNkajJw?=
 =?utf-8?B?VnN5TXg5QUljblFMbWhGSzV3bXNBRmhWODYxVEpZekduSi9EWlpkS245a2Rp?=
 =?utf-8?B?OHdsVjJTYmhuL2pTc1c0aXYvV2xFRFpOaFI3UHRCeHYzYTJNMnpiWkl0RFNu?=
 =?utf-8?B?Q3dhNmg2VDRLTUttSVVMZTZhY2NieXRuVDl5aFM5YXZJTFpVby85alRsdUZm?=
 =?utf-8?B?S2pKNWVZVEhKNFgzeGhKckZXNWw0NjZpWVBZQ0JqSlVzUkx4TStnUWJ1T1Y0?=
 =?utf-8?B?RSt1OUZxSk1hVHNzV3BoWEFpbUNPb01vZUdwT0dPcStlaXcwUGpJQU10Q3Ju?=
 =?utf-8?B?Qlc0bEVIbXhrWEFBUDVpU2FEWmFFS2M2emM1cW51YWNLNGMyVkJlZE0vL2Nu?=
 =?utf-8?B?aENmRDdxejBhTE8vWDUwNU5uUW5UVkdmR0FQaVBYQVhuQzBrdW1vL1A0L1FG?=
 =?utf-8?B?ejJ1MlkvVEhpN012ejM0VzhQL1lBRjJscDNibTBNSlNITEt0U0R3VTN0L3Nm?=
 =?utf-8?B?b0RQM2pVVmo5THBXUXhwdktLZmdSd3JOMDgzUnJma3FBby9PRXhqS2tHb0NS?=
 =?utf-8?B?SlNWYUN5WDE4TG5SYm5xRDdJUVZXZFMxVVZ1RDhYZmI1cTRFVkdqdERPV2pp?=
 =?utf-8?B?akNvd3YycnhxVFBzOWV2SnA4VlVIazYvOUR0MXV6TUJRSC91N1UzUGhpYXhO?=
 =?utf-8?B?SE90aDVlejBtQWpUYVIySzd1Q0JmbnpYcS8xRmpYdmpzajJDbHBvK1JEb0ta?=
 =?utf-8?B?b1pCbksxdzljNGxxUkVVQmJKRHdXRW5RYW40YWlEM1NhWWVPZ2xWM29Ga3JK?=
 =?utf-8?B?L1E0bC80NEZuUXhhK0pTbHJpaS9BUEFPMHhEcHQvMmZHMmRPcEFWWnkxYjR0?=
 =?utf-8?B?TFVvMVgwNDlpSTBNSXQzcWdkUWtEeW5pNkl4UmVYZTBGa280QWJJdnZLOHRR?=
 =?utf-8?B?TXNVTnRwcFpMYVJKZGFxcmROb1BoaWJlWWFwMC9LQnJ2cHlqWjFXaHBaZFpD?=
 =?utf-8?B?U2owa29ncjIwdzFrR0dLSStydDUweGlRdkdDRzhlOUM3WGhFeTJFY1JoMnlE?=
 =?utf-8?B?V2tOc2x2RXFqaHlpUXNXMHFKc3VXb3FIVldpVkpOTnRnTElRdWVtVjV0cGFB?=
 =?utf-8?B?YkxhaDIwQjBvRDVjaTA2QWg5c3U1S2Rob1Z0a2VsWFZqdGd1R29iaklXTjdF?=
 =?utf-8?B?WGF4MlNvQXJITXB2RGVRNHRFWUU5bm5mTUo0ZGoydS83L2ltRU5NTjlWaEZr?=
 =?utf-8?B?WWp2M2kxdzdiZDdiTkpLaHdieVVaOG5ZMXBMZlJGeHhqNjlUYmxGbzZ6VUtl?=
 =?utf-8?B?b0hmRWQzZ0loLy9yM3ZBSzNjL0lScS9mNlE1ZFFHZUx4TjRtV28rWXlldExo?=
 =?utf-8?B?NjlBSy9vdXI3NGNIV1FpWTR2OGkySTlwU2YvbUE5a0JWWWM3cmZGYU9URHVJ?=
 =?utf-8?B?SXhCVkpoVDN4UWNNQm5ZbjZya21SZk4yaVJHYmZtRkZwaWQ2ekF1UzBLQTM4?=
 =?utf-8?B?bCtoQ1ZLMmVsT2lUOTBac3ExeUJOY1dvZzE1bm1sRjQvVzRtc3VPOTR3MUdi?=
 =?utf-8?B?cVpoZFkzMnlackRQVWxJVGdoRjkwTHZKWjlpUmlzdXZkaDRhWE5ZUTBZTVV1?=
 =?utf-8?B?UFp6L3VYZStxZEFvcWdFRng4NGxoc1NsY3M3anZ5R2RVQmhFc3JMR1ZpSU5o?=
 =?utf-8?B?ajh2bFpueEJ6Skg0dXU1WUFVOUQ0TWwzVE9ZbGhWRkFXZ2Z1NHNMdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cfa555-0b08-4cca-f597-08de8e089849
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 03:01:10.2391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHrRMTDhLfuTvfdb8qrCoFFaQCPfozNawftNW0lG9a7SjdRWTKvzI9AgNxSLAXLs36fnPe+AE1SoSM1gzmDdKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9984
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

On Fri, Mar 27, 2026 at 03:46:43PM +0100, Luca Ceresoli wrote:
> Hello Liu,
> 
> On Thu Mar 26, 2026 at 9:15 AM CET, Liu Ying wrote:
>> Hi Luca,
>>
>> On Fri, Mar 20, 2026 at 11:46:18AM +0100, Luca Ceresoli wrote:
>>> The imx8mp-hdmi-tx one of many drivers based on dw-hdmi. dw-hdmi in turn
>>> can operate in two different modes, depending on the platform data as set
>>> by the driver:
>>>
>>>  A. hdmi->plat_data->output_port = 0:
>>>     the HDMI output (port@1) in device tree is not used [0]
>>>
>>>  B. hdmi->plat_data->output_port = 1:
>>>     the HDMI output (port@1) is parsed to find the next bridge
>>>
>>> The imx8mp-hdmi-tx driver falls in case A. This implies next_bridge will
>>> always be NULL, and so dw_hdmi_bridge_attach() [1] will always fail if
>>> called with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
>>>
>>> In fact case A assumes that DRM_BRIDGE_ATTACH_NO_CONNECTOR is not set and
>>> in that case it adds the connector programmatically at bridge attach time.
>>>
>>> Support for DRM_BRIDGE_ATTACH_NO_CONNECTOR is implemented by dw-hdmi.c in
>>> case B. So, in preparation to support DRM_BRIDGE_ATTACH_NO_CONNECTOR in
>>> imx8mp-hdmi-tx, move to case B by setting hdmi->plat_data->output_port = 1.
>>>
>>> However this change requires that port@1 is connected to a "next
>>> bridge" DT node, typically the HDMI connector, because dw-hdmi won't add
>>> the connector when using DRM_BRIDGE_ATTACH_NO_CONNECTOR.
>>>
>>> Many dts files for imx8mp-based boards in the kernel have such a connector
>>> described and linked to port@1, so a connector is added by the
>>> display-connector driver along with a bridge wrapping it. Sadly some of
>>
>> Hmm, display-connector driver is a bridge driver so it cannot add a connector.
>> I assume that you mean a connector will be added by the bridge connector
>> driver.
> 
> Indeed, rewording as:
> 
>   Many dts files for imx8mp-based boards in the kernel have such a
>   connector described and linked to port@1, so the pipeline will be fully
>   attached up to a display-connector and a drm_connector added by the
>   bridge-connector.

LGTM.

> 
>>> --- a/drivers/gpu/drm/bridge/imx/Kconfig
>>> +++ b/drivers/gpu/drm/bridge/imx/Kconfig
>>> @@ -25,6 +25,23 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
>>>  	  Choose this to enable support for the internal HDMI encoder found
>>>  	  on the i.MX8MP SoC.
>>>
>>> +config DRM_IMX8MP_DW_HDMI_BRIDGE_CONNECTOR_FIXUP
>>> +	bool "Support device tree blobs without an hdmi-connector node"
>>> +	default y
>>
>> depends on DRM_IMX_LCDIF ?
> 
> If the imx hdmi-tx is not enabled then HDMI won't work anyway, so users are
> not affected and the overlay is not needed. Am I missing something?

I meant I'm fine with "default y" and think that this could also depend on
DRM_IMX_LCDIF, because no display controller driver other than the LCDIF
driver needs the fixup.

[...]

>>> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
>>> new file mode 100644
>>> index 000000000000..ee718ca1b11b
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
>>> @@ -0,0 +1,38 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * DTS overlay adding an hdmi-connector node to boards using the imx8mp hdmi_tx
>>> + *
>>> + * Copyright (C) 2026 GE HealthCare
>>> + * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +/plugin/;
>>> +
>>> +&{/} {
>>
>> I see build warnings(W=1):
>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:25.8-37.4: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0: node has a unit name, but no reg or ranges property
>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:26.16-36.5: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c00000: node has a unit name, but no reg or ranges property
>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:27.18-35.6: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c00000/hdmi@32fd8000: node has a unit name, but no reg or ranges property
>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:29.13-33.8: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c00000/hdmi@32fd8000/ports/port@1: node has a unit name, but no reg or ranges property
> 
> AFAIK the device tree checkes just can't work on overlays. The tools just
> cannot know on which base tree the overlay can be applied, so they cannot
> know the existing properties. That might change in the future, but for now
> my understanding is that it is OK to have overlays which produce such
> harmless warnings, at least for driver-specific overlays like the tilcdc
> one [0] which is already in linux-next since a few weeks.

Hmm, not sure a few weeks in linux-next is long enough ;)
I'd say, I saw the warnings, so simply reported along with a fix to suppress
them.  TBH, build warnings make me nervous, especially this DT overlay is
under the "DRM DRIVERS FOR FREESCALE IMX BRIDGE" umbrella.

> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0ff223d991477fa4677dcb0f1fb00065847e2212
> 
>> Here is a patch to suppress them:
>>
>> --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
>> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
>> @@ -10,6 +10,9 @@
>>  /plugin/;
>>
>>  &{/} {
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>>         fixup-hdmi-connector {
>>                 compatible = "hdmi-connector";
>>                 label = "HDMI";
>> @@ -23,10 +26,25 @@ fixup_hdmi_connector_in: endpoint {
>>         };
>>
>>         soc@0 {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges = <0x0 0x0 0x0 0x3e000000>;
>> +
>>                 bus@32c00000 {
>> +                       reg = <0x32c00000 0x400000>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +
>>                         hdmi@32fd8000 {
>> +                               reg = <0x32fd8000 0x7eff>;
>> +
>>                                 ports {
>> +                                       #address-cells = <1>;
>> +                                       #size-cells = <0>;
>> +
>>                                         port@1 {
>> +                                               reg = <1>;
>> +
>>                                                 hdmi_tx_out: endpoint {
>>                                                         remote-endpoint = <&fixup_hdmi_connector_in>;
>>                                                 };
> 
> Thanks for taking time to look into how to get rid of the warnings.
> 
> However the sheer amount of lines added, by just duplicating lines already
> in the base tree and no added value, reinforces my opinion that we should
> keep the overlay as simple as it is.
> 
> Also, what if one of the property values that your diff is duplicating from
> the base tree turns out being wrong in the base tree and gets fixed later
> there? The wrong value would be re-added by the overlay unless someone goes
> hunting all the duplicated lines around.
> 
> Based on this, do you think we really need to get rid of those warnings?

Well, I tend to get rid of those warning, because it seems that people
usually avoid this kind of warnings for regular DT overlays, but I might
be wrong.

> 
> Side note: this discussion made me think about what would happen if
> DRM_IMX8MP_DW_HDMI_BRIDGE is enabled on a non-imx8mp board (as for
> distribution kernels as mentioned by Laurent). I think it makes sense to
> add a check that /soc@0/compatible matches "fsl,imx8mp-soc" and not apply
> the overlay otherwise. I'll look into that for v2.

Makes sense to me.

> 
>>> +	fixup-hdmi-connector {
>>> +		compatible = "hdmi-connector";
>>> +		label = "HDMI";
>>> +		type = "a";
>>
>> What if a board uses another type?
> 
> For boards affected by this patch, currently the connector is created by
> dw_hdmi_connector_create() which hardcodes type A [0], so there would be no
> difference.

Yes, that's from driver's PoV.  However, userspace may get the type
from /sys/firmware/devicetree/base/fixup-hdmi-connector/type and use it
to do something.

Maybe, that's trivial.

> 
> OTOH how can a common module know the specific connector?

Hmm, maybe add a module parameter or let users set the type through Kconfig
or even define an unknown type to honestly tell users that we don't know it?

> 
> Boards with a different connector should describe the connector in the
> device tree, if they need to instantiate the exact type.
> 
> [0] https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L2601
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
