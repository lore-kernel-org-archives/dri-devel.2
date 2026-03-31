Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3321061B2B
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 03:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D3310E840;
	Tue, 31 Mar 2026 03:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="hi3L3XY8";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C486410E840
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 03:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXup4tSqWQUugY5t9JvbxQVwmVxP+4zMuuCLcoocvzBlDCfTzX7BeY6orYDwHJPZ595ymjWhX6BB8YlCUODsp5zEEg1+KDecquEjxsGJOHNNZ3MUvSen8uJnFak1j/KCgh21674RMY3HmBKxm5zOghYAmd0ed7DsGs0hu0rYQR7oXIwGoMYF+kzdoy9JSfCStnSfVvzikd1BgoHJ6uBGrVH/8awIUyxVXsJ5DcqMYfa2jc8QogTm/UIM9lvhJQtKCco6G0GpDRxZeBNM7XQDSiLCd8cOvZjrN1s9lI8DWSBlBhyiO3UqeSC9Dqs0auUdoboyVBBPM2L90A7oeMtVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvpBgWS7U2b6h2vo3zcaPZZU+/nWrCzii+JNQgSTPGI=;
 b=aKj6qNN4CVJwKfyrcr25ebLMbhHwUn5zpF4fP0mSiq0AOCJfc6P4d/2TZAH3CFKdaIbo6xmSrDUOpdZUBVYReLf+qfbdmN3AnB66p7BE+qzT9eHwHBpOtN+paWLyy0BruFTHciA5fnEouZBX35tclmxP2AEumWkRISH3YwfF60l3fiybpFp2kItSWAw3Vcvq2PEVQXz6AHHnuAD7oXMg59N3hUKDnfrZgoAr48S1bWlG6+pgjm7CaVXhbDH4kkw5c68HRJByMRmOErXuJs0S3HZAJ954KSi5Au0slyXJscY7HSv+GDgzyVAEgWisiAZhFFTfR8XrEbBBxGALyqLOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvpBgWS7U2b6h2vo3zcaPZZU+/nWrCzii+JNQgSTPGI=;
 b=hi3L3XY8XLuaV9ZN9/i6jOVw53qqlyS3yGYo9mdV0/Vf9LUPeUmE32TR2o/JxOg7fWPiUWPQiiRvBN4x9me8++zT03xQUfPrpagq8w/3vw+LXCR9SaLLa62yyqdu1/ZqwbqJ4bCft44yIyWmldhm1y4kaXrK8u/2e3l9tN24CCHN7QrpJw9w/KLV1IO3yHOsHJ+gPKz+gSFdVcVMxvwIFZ0Xxac46cW21gaAMuKcAavxQTtUKMdzZtRR1+P3tHsWl4UPxd2CMKU6+5tSD6Dz0wgQ3OUGF9EZohtrYS0TjUr8g2fKaq1CWl9/bRGdaM+Ub+18Vzv1PZSIDPcIVt4xRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by GV1PR04MB10306.eurprd04.prod.outlook.com (2603:10a6:150:1c9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 03:02:10 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 03:02:10 +0000
Message-ID: <9a6e74ed-d4ab-4f11-ab17-25e1a2b64b2d@nxp.com>
Date: Tue, 31 Mar 2026 11:03:14 +0800
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
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <DHG8G8FMXA6C.U6LU563OZ8NR@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MA5PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::10) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|GV1PR04MB10306:EE_
X-MS-Office365-Filtering-Correlation-Id: 31439cb8-3b04-44b9-e168-08de8ed1e6ab
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|7416014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m/CydDk4M/hDGZpf34sFgM+sJdlBg4/D8C4QZpaM8JVZuvFCG0LGuP3QsHaHbSv/h4Tua8+3gGlgM7aUpZIknLtu+lQj5mH6lDFn7hhR2mKO5wXVxg6WzlR1LJ84zY3JZakHGHni1dKaHEks0/GLPAJ9A2/XC0xTXOpN8QyUCpEPzJnQA2bT6HonFrD7jb5dznAKCTFA80UCtP/imQXGBqwtfbgGmxGR5scYwNMx+YIzUanefGBidBGGF8NJKy9hiwUlK+KCdYaiZklx/k2DoB/qdUqq9gmuzq6sgCVGTfUNcs0xjbnGQ3cfn8xDgUukMlhFlZcSS9/k1DMjygW625nqO8DffdlS1thMgjy2QNeRwYpeWZJjY9cgnG5P6SRs2aoYxuGwycVk+XE02zJvPYO73B2VcwEwAk1pyzl38tGShE9gfxTnFyJ53brb0a3RBMbyCgJgOHb9tB+VXYEEC/pObxQb/CySCL2GyrnHoxW6/1JE3L4BAubz/t3uJTekMizqe2v3Vkr4L0Pk3QymlRvrByVjkiHKKQvoJKWaPSnG9uw08eZ7GMMJgZHx0BdiigVn16KT6Vk08Z2k+Lp5olNNnn4uw2ndGO6DghpgpjjrDEeMwVkS6eoodGFeZyuqmgOuEBjfvOQxUz84ab0+XMFVmuA1AdiRIN9wjxqe6XoIYyDhd7ismMe/k+ECtVlQjybL+IhZL94cFZ+vX5zuF6UUbT/zZr3Ugal4yizru0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJTYlc1U2Z0ZkJUMVhLMUdLaHFUTkZyUEcwcWRBd3lyOE5XWTNSbXh5NFJz?=
 =?utf-8?B?K0pwSTZ0NkFmYS9xdzhkQjRPQjBTVmsvRWpGU25nVTRURFlaTW15Q0l4N3Vt?=
 =?utf-8?B?U25sbjhCRnA1cjM4TXdSMXFid0g5cXZVanJzQml4dmUydHVDOSs2cUhHY1dq?=
 =?utf-8?B?NDBlSjNBVVdVR0RkV1lyVkszQjVONFVraVVwWWN4OGJOMUxlcXNrOVFXVU9S?=
 =?utf-8?B?SkxxSzVYaThrdzdRbzd2R3F3Z0Z6WjRQQ1NHblVqLzY2VFFuOGtDUkg5cnlE?=
 =?utf-8?B?cFdwYmVGblhBTEVFeklnM0RFMExlTkZLN0luRmtCU29OZEMxVlBBZHNMTHkr?=
 =?utf-8?B?TEhLZnV3S0VVYWJtNmdjcWlMOVlaVFkwZFlyUjR3NDdZZUh5NlJ5WnpNSTYz?=
 =?utf-8?B?RU44RVdURVV0cFRTV3MzVnNsM3JEbzhPdG5wcElNdWVXYlhQVHNOYjAzdUh6?=
 =?utf-8?B?ZjY5a2Z4NFFJYldHc1dnTVhSWi9KeEtyT1JLQklGdjhmaitrRXVqMmUzSXBj?=
 =?utf-8?B?Rmxwck9SekgyelFyMU9sV09sbWthYUlyb2k4MTVLOEFiQ0tmd3FtaGVoNmhP?=
 =?utf-8?B?ZExLc0FvTTJuYWtrKy80QlU1dlR0S2pYQWtBZWNTRWhGL0V2Z05SOU9Vc1Fn?=
 =?utf-8?B?MWtvNTZDS0tPZFcybjA3VmlyTnpxYzRzSWMxWFBwemRPdDBxY2NLNEhvMHA2?=
 =?utf-8?B?S1ByK01wOHFpb1QxVy9nZnQ1ZllrakY3RUNNTklZaVNHMlg3NUdHaGpXNm9T?=
 =?utf-8?B?Y2Y0WGFkWjZlbWRmKzJGZmFMai9NeUFqMlVLWCtPaVZBVy93RHBTUTl6L3M1?=
 =?utf-8?B?MUdkWWl5UHg4WENwRUtIK2hmUFc5K2JGTEZMRjJvUG5hTVBYZEZLRnZIZ0x5?=
 =?utf-8?B?RUdnS3VRM0JOWi8xVEgzRnUzNWl4RjIyNjVva3lGMDc1QzY2eGQ5N2Y2cGZL?=
 =?utf-8?B?QS83RFY3dWJxclpub3N2bWJ6ZVRzL3V6bCtLUmxZSENKVGRCeXdLdkhCc3d0?=
 =?utf-8?B?UkxFdm95NSszemdtQVhCYjNBbHhmeDg0eG1sOWRSOGNvdTY4ZzQ0Rkhackla?=
 =?utf-8?B?S0JGaUEzNkhoQXNKUnQvSWRpZHJSQVNyd3FPUCtjcVk1SWJxaXMvYzI1TjIv?=
 =?utf-8?B?Z0ZIemhhWTdqRVM5RmJGeVZRMEFmQXVoOHlLRnhmVkdUYnNWZ0xNRXQ4bmRN?=
 =?utf-8?B?WWFEbkxxZ1g5YWExbXVCZDBlb3pzQUNvK3N6UktOOUZmWVNWSUFlQ0w4T0dn?=
 =?utf-8?B?Qm9Kaml3TU5nZ2R2SkdWWHladHF1UjAzUllKREJUQ1dJVm42QWFoREcvV01C?=
 =?utf-8?B?Z2EyOFU5RFRTdm0wZ1l0RGE2VzFKN3ZvWDNVczVTbmxtOVczM2lzVFJ4aFZR?=
 =?utf-8?B?VGI3RjVnMkorMUJoSVI2S3lZc0hvZkhNaEkvdUFDaGEzQ3ppazdNcGxzdFV5?=
 =?utf-8?B?SkhJb0N1cTdYOGs1amlMQzJyd1RJYjBWTFNjL282OXUrbHg0UmcwQ1hES1hB?=
 =?utf-8?B?S3VkRHgzSnc4MTlIbUhUU2FFcStIaUdQbGZHM0F4WHVFMitIWVBRdWFDaXha?=
 =?utf-8?B?NzkxSmxqRXFRTitESWg3QkQzNjdsWnJWOXF5V1JXeklxeDBSWDhSYXAyM3VO?=
 =?utf-8?B?VE1sNCszR0JDZXlBdmZ0emlWUDh2ckV6bkZMU2hrLzVEcjkvOW1sazlQd2Vx?=
 =?utf-8?B?K01xQk52ODlvMUNyYWpidkp1b1dlWkc2MHg2b1J3OFgza0pxSFZnUUNENFVU?=
 =?utf-8?B?RkppbG92dFR5elZWMmRza1ZQbGk1SlArNEV4ZzJCUGkxcXhZMjJuZjl2YXlU?=
 =?utf-8?B?MFEwd1doRzJTWkxMNmEzS3I0RXBhRmxzaGVRTEVzdHhXZnNMeXhQcTIwNHMr?=
 =?utf-8?B?VkMxdVFaY2QrZjFvNVZxTENJTTJjTXNLR2kvcGFuYnQxc3pNbEdsYXlWUExM?=
 =?utf-8?B?RWN0eWtWMjJQaXB4M2I5Z2RXNngvZ3c3RUIybU9KZmgxdDRhN1ZJK29yWCsw?=
 =?utf-8?B?bFd4L2lHdDhzRHZya2hLSG05ZzJEUVZ0NVc0ak0vUGtzL1F4Vm04bDA5NmdN?=
 =?utf-8?B?OHlubC9wQ3pab0VPLzRFNThjdDV2Tm5TMmkrRFh3a0ZBOEtkZ25Bbzl1QXZy?=
 =?utf-8?B?eXp2ckpvWlF4Z1FaZnF5dlpLVUdONVFxRENncnBBWWFkNE5XYU05WE13NDQx?=
 =?utf-8?B?SXgrNEZUN0JPL1VWZWJkbU5zLzB4MW9VUWQ5aVZLVWx5NWV0aWI3TFNVRDZD?=
 =?utf-8?B?azVsUDZmZTRoZm0xeWZGcjR1RHBLelVKWmhGTTZaeVFXQXdHVStWa3JPc0tU?=
 =?utf-8?B?YW1ydlVHcVIrNEVXSGRPWXZmQmN2cDdETzBGVFl3ckh2U0p5UHRQdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31439cb8-3b04-44b9-e168-08de8ed1e6ab
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 03:02:10.5468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1rJDFy8c7r1INyhb0q51ihZAm1ts5spnjlB8VqC4NRexNhHTaA4WobI/1ESlESKrHHpAsVGfUbrTStCFz9hIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10306
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

On Mon, Mar 30, 2026 at 05:47:23PM +0200, Luca Ceresoli wrote:
> Hello Liu,
> 
> On Mon Mar 30, 2026 at 5:02 AM CEST, Liu Ying wrote:

[...]

>>>>> +	fixup-hdmi-connector {
>>>>> +		compatible = "hdmi-connector";
>>>>> +		label = "HDMI";
>>>>> +		type = "a";
>>>>
>>>> What if a board uses another type?
>>>
>>> For boards affected by this patch, currently the connector is created by
>>> dw_hdmi_connector_create() which hardcodes type A [0], so there would be no
>>> difference.
>>
>> Yes, that's from driver's PoV.  However, userspace may get the type
>> from /sys/firmware/devicetree/base/fixup-hdmi-connector/type and use it
>> to do something.
> 
> I'd say this is incorrect, the device tree is not an API for that. The
> connector type might be known to the driver by other means (ACPI, DP MST,
> whatever). So I think this is a non-problem.

I just feel that it's not great to report potentially wrong type to users
through the above sys node ...

> 
> If userspace needs to know the connector type, that should come from the
> ioctl (DRM_IOCTL_MODE_GETCONNECTOR perhaps).
> 
>> Maybe, that's trivial.
> 
> Not sure I got what you mean here, sorry. What are you referring to?

... with the above potentially wrong type being said, I think maybe this
drawback is not a big deal and could be ignored.  Sorry for not being
clear in my last reply.

> 
>>> OTOH how can a common module know the specific connector?
>>
>> Hmm, maybe add a module parameter or let users set the type through Kconfig
> 
> I'm afraid none of this would work for distribution kernels, where who
> configures the distribution has no idea on how many different hardware it
> will run.
> 
>> or even define an unknown type to honestly tell users that we don't know it?
> 
> This sounds like a potentially valid idea, even though I'm not fully
> convinced. Also I suspect it would be a pretty large change, and also
> adding "unknown type" in the device tree seems not compliant with the rule
> that DT describes the hardware (not the lack of info about the hardware).
> 
> But definitely it's not needed for this specific case, because:
> 
>  * with current code, every imx8mp-hdmi-tx usage adds a type-A connector [0]
>  * with this patch the correct type will be created when described in DT,
>    and type-A will be used only as a fallback when the DT is lacking
> 
> So after the patch we'd do sometimes better, never worse in this respect.

Well, kind of a bit worse since the sys node exposes a potentially wrong type.

> 
> Based on the above I'm sending v2 soon, but don't hesitate in following up
> in case I may be missing something (this topic is tricky).

Agreed, it's tricky.

> 
> [0] https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L2601
> 
>>> Boards with a different connector should describe the connector in the
>>> device tree, if they need to instantiate the exact type.
> 
> I think this is the only valid solution. It's very easy to do, nothing new
> to invent.
> 
> Maybe on top of that we could add a warning when the overlay is applied,
> e.g. "imx8mp-hdmi-tx used without a connector described in device tree;
> adding a type A connector as a fallback; please add a valid description to
> your device tree".

I'd say this doesn't sound a bad idea but I hope the message is clear and
short.

> Maybe pointing to a TODO entry in the documentation.

To parameterize the HDMI connector type?  If so, I'm okay with that.

> 
> What do you think about this?
> 
> Thanks again for your careful review!

Thanks for your patches! Appreciated.

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
