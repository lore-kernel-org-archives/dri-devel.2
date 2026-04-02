Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE15CC6B01
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 03:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8C010EECA;
	Thu,  2 Apr 2026 03:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Bss/+XtI";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F2D10E35B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 03:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/m3dXml0/469euUAHahtCG9+Iz9qlmeanUrNM7esoBODuMkJPoNVOafwO8vyJxvkSdx4o6MPxM3NhKy2fK9Hj8edgKeKbN732KWuUUkcEnNQ750M/UROzkYJd5lqzKa8nNURU0/t5vktK/q/oIpxm3YeNTVupN1gaaWgS8w7aKnbtsFOckqIBuKWQaoYd1VgbS2hp9geeUUAnjyOHDoDheeUK9H0mqLqGt/GdZph1aCA9eiUhkJ9EmswvYbLR9jGuoPZZqK6R68rLJYWEYTeCHTLdp7TEkGXJ3KJMjkno+a2fxjbhsB5eM6ZdtCLWq1sa8nyO7y0rVQeT76qJtXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbGWUaX6MAIh2wDmr/y6foFvprPeVOy/CFKabqvkNQs=;
 b=SgnjxOX2KxpjrVK48JT7w240raKmSQBr8IawjKyBhp+7YqAYz2zSt0ga5pkW4rlMgwgA1JSqxFG78rWXMWmUuwIeSgB0mcy1obtrDpePDnVSbYAS8+vgs7lqRdGIQ5o7invLSKqiD/fa0uAKYNGqJfCoE3VFWCXs8ZP3OygYYZty4/cs19WTHY3Iff+P77iInjiI31DwZTDk41saKeD3tU1bIb7cFTMW8eGbQ812HHDoX6Dq+DtSId9ovQz8seVEAqgV+HxKdzLniyoh3OyBsg71WPae2VcwsXCinTchDZfWqTGhgv5nIMy6+1VmJgT1x5GKZtLoXYKwuIvC01LvFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbGWUaX6MAIh2wDmr/y6foFvprPeVOy/CFKabqvkNQs=;
 b=Bss/+XtIgkt56y1hNkENMzOoHwcxrpbEE1dhmMdJWO48kzkj8kwa1/a0n4JECbOPuJ5j9Idey4MsmfwOjD5KlCapglxjXMbqphsClJ08nMylG31D8400+dsbalpOcEx7c+nD0rXCubcesEjKG05PZZAwDUn8UA3JSfyElxKgVkhXnOKQZpWc5DUNII8X5/k1s5u79OOSVIEYBeKm6+EWOiydyTichrGe0pWGaU9qc3/vWb5hfpg/daMlNPorfSiZ6Noy7gS1d6WgRUHCuaQ2xXhOwkDubuZxp5GmCvr3TStC2Jk45n8p4s/ShG2q3shcadrw+xuxCer6Hr0a9XW4TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 2 Apr
 2026 03:56:18 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 03:56:33 +0000
Message-ID: <344217e9-8f8a-44cf-8a35-82f00c76220c@nxp.com>
Date: Thu, 2 Apr 2026 11:57:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] drm/mxsfb/lcdif: lcdif_attach_bridge: move
 iteration-specific variables declaration inside loop
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
 <20260330-drm-lcdif-dbanc-v2-4-c7f2af536a24@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260330-drm-lcdif-dbanc-v2-4-c7f2af536a24@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: d6160cad-244a-49e6-032a-08de906bd41c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|376014|1800799024|18002099003|921020|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CvyBEPMSaqLiC4VoXpWOTD2eoq1dqmNLyLUoz0AMvBkMhPARs3Ufsk+iy73Ik44W9aodyqzg12g/a6fL1Erie2PxF2r/pGx2bUQWuReCD8Ha7WlhRITDqyFddZLS5Gru6etv1WZ/FCdqSd5h4vTC0nOxvua/Mr3BWQzceNbl3qeSN2lKXU+JzeCB602hd7WBEwRObF9xYOlA32miSCpCJJD4xyvdLRTuBR8lq2CGSahiH7UxXroHBiOlqQH7gIFysJl2bGcQPACM4CXXbCGkvuhinDaoVHYEtgV3+NJKY24xkfw/kaq8Fmdjb8iKtGE85IBDWmN2K1OpsogEgtXpAIH0m2mzhOpb1jxiJHgv0BKrKQOZl+wAM/HaWwWglAlmJOsh+zyjvzewJD4rdKzfapkKDZc+a/yg5P0P83eGYa/FnopBPUDahhp6xhSDhQ7coFyQd8X30mV/B0q4eGk8/GRSkKL0tB7+cbW3rTvkQbvXrsyYqiMFBtUPKjN0HUdLmAzov/qD4cjxkxw9qVF5N3jmqU2+PxvJhws5GYP6Lza/uYtwpje1uOecb/LsvD3N0KKOOnlZ61Y2MdIhzNFk8mO0kX/cX8N04XCchk2sdhmZVC9omnWg8fBfWWuiPdC3un2HruMXjtsnK0S41tT/pcnUsxpJIlmbPCHDP6an3hoVahkps4julDxDnclaMCWnRi9EdblB6lZZqkYRJ3ko5/nOEdetweflF3NRzBqsdzngs6aX1OOyp8FSRxx2FPNgsZJhdZxmV9vBu37nyfSDVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(18002099003)(921020)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blBjNGR3OGRIaWthU0NlT1lDaGJTTEtzcU1UL0E1QzVicnQyYWVvcFJnUlFY?=
 =?utf-8?B?QVUyQjRjSG95L0hNNmRtQU5WMnB0QmhPYUlkRGVUUzd6Y3NpcC8yWThXSTY5?=
 =?utf-8?B?eDVWL0F1TFlLMG4xNXJQL2pnQ080OTJrSFZOQzFQbktnTmFsVWxVZURrekdh?=
 =?utf-8?B?VEFOQllEeHJ5ZFJGb1d3OGRLWDM0UzRJTUp5cWZIMGdtdm9mUTBRRFJmK2sv?=
 =?utf-8?B?anFzTUdrb20zbTZ3KzBlZ0wySWRNOXo0a08zVU5OMXZPUnBPUGZkbVRaSFV0?=
 =?utf-8?B?UzdrWVJMYjRJQnhhYWZRMStySlczanJxTXhuR3hJMm9NNDIxYWxzbmsvWm9Q?=
 =?utf-8?B?cGtUKzRrNHR0WWZUa1VJc1JDQmN5Q2hHdDhrUTdJWmI2YTRlTHB3UWJxbU94?=
 =?utf-8?B?OGM1cVZoaUl6TXpEVHF3eERWMkRTclpQNWZDbGdoQnkwMmFMWS9YT3NzMnJz?=
 =?utf-8?B?L1NEWWIzVGdLdHJvNytjNXc1eHBGSlJMRko2RUFYRWIxQXlJbHhSVld2b1h5?=
 =?utf-8?B?NytNaUlCeGkzeVlQRVpFQUgrMVVTMjlrZWdjR2szQk90bEo4Qm43b2VzT1dl?=
 =?utf-8?B?a3QyaG1lZ3l0enRnSHpsMHpLc2U4Vi9TQmJLZUZJRmhwVko5YVYrcG5yVlho?=
 =?utf-8?B?dlUyMHp0Y1lHaTRzK0NJVit5VzlWOHFYd1ZFMWdLTGh0THRYNWJyRHZINGlh?=
 =?utf-8?B?d0lTdmQ1MFpvNWRlYW5hS3lreXRSWlpydDRLZ1NieGd2V0FqaUU0REVCbjlj?=
 =?utf-8?B?Q3BjZXY4ZUdYVEwxMWZRZnZaZU9RZndBUyt6bEJGZEJzazRMb0s2Si9SU2FE?=
 =?utf-8?B?aGFlNWRGOVdab0E0WlNhVUdyb2xZcGNvblM3QUxjMFNKVkU4ZVRsY1JjemVw?=
 =?utf-8?B?emd4Y3gyVU15QXFCUXdmS1F1OUJnY0ttZG9Yd0JuS1BGOFJUWVFkbitMSUs0?=
 =?utf-8?B?dWJEYkFRdURHd1lCWC9LMzdFWndOVHMvdWRtMjVXTXFZaERMUm1EUE0yYlVk?=
 =?utf-8?B?bldwejFBbm9HZFNsSERwSi9Vb0V0a3YzdkN3MjNQOWJWazhubndsR1ZUTG14?=
 =?utf-8?B?TnpjNFJ0OWpzT2N3TEJmWVlBTjR1YXB5aGRocGlsTEF1K0hNRmJodW1jaS8z?=
 =?utf-8?B?U0NvQjZ6WTA5K3VtY3BFTXNYczBtR0VIUlR0UHQvUXZDWHdIc3I5QjdQY3Z6?=
 =?utf-8?B?WENCYWw2VzVZVVhZZzB2TEpBWllyOFBzRkJpbzVPNWZncWpzRStBaHZJV1Vh?=
 =?utf-8?B?cnNiWU91UFp3NTlzMXJnc3MwVFlhRWtaMHJjZ1JNbFFvVXBHVHI2UVRiRFN3?=
 =?utf-8?B?UzVOcWVHdmlQSkNCZlBVR09MeDl0a3grSEs4N0Rzd1lRbnpsVi9WNDhvblZz?=
 =?utf-8?B?OWN2S3dhbmFjdjFxWitrcDFROHluVjJoRi9FaXJLUnYyY1ZNV2NXSFpEeFQy?=
 =?utf-8?B?UTdlbVhLMUhjMnVTN0hHbkE4VGxNR2pVUjZ5eW5vWTdXSFFubWhEei93Nng3?=
 =?utf-8?B?ZENCeS9BRUltaFNtWmZ1cVhJM2sramdJSDJkWHFKYWV0S1lVOU8zc2ZLZ1pw?=
 =?utf-8?B?cVRwdmlxNWw5aEZsNW9XVmhCK2IwU2xEcHE4b1oxL0lxWVYrbGZldFQzNXZC?=
 =?utf-8?B?b25ldnR0TjZ1NWcxRTUwMEc2VkY4R1JVdk1MdkJNcmN4R0VpanZNM1FjYmgz?=
 =?utf-8?B?V2VCNWhuYjN6YTVpR1BiejVrQS9PUGJxS1BwMWx5NWZCSGpZVzdVaHI2Vm54?=
 =?utf-8?B?VW1aUnlQZ1pia3FpVDFZb1oyRUVoRzk4ZStHMFlDdEY0bVhnSXNvbXZxY05I?=
 =?utf-8?B?TkxmRHQ3ZHhkdUpqQzhNSjhzVEZpVXJMTVZRUjdmMHJDWFEyVWxPUXBhVjBP?=
 =?utf-8?B?S0lzdW92MXZ1ci9jS2Q3cW40aDI2a3pxVTEvVzlWOUZwcUEvaDBTZUhQMVR3?=
 =?utf-8?B?b2JVYkQ0Q053QVZENnVBTVFXK0l5WDgwdDFCVEFRa0ZLMnNwTUdKUWwybjFI?=
 =?utf-8?B?Qk1IYkZHRTJENURBSHRBSks2RW5xOFkzc1NtK09BTUl1eWFvdFA4WmpMdG8z?=
 =?utf-8?B?NnpJR2pxMUF4N1dZT2VEbmNsY3BsL1k0dlZzb01kQ2V1Sk5ZK0owSzN1UDJB?=
 =?utf-8?B?YnM5V2hiMHFWR3FSdHBjdzJVVGVVNVhNRjdXT1pZVFAyV2RPUnZGRFpuSGh5?=
 =?utf-8?B?MWp3QzBNUFBqdFluZm9haGxCTlg0dUhNM3hKN0kxQnZKSDRhN2gwaXhRRzkz?=
 =?utf-8?B?QU9kc2VVS1paSTZsMkNiZCtSdWh3TWxrWEFoNDdwbmFKdU5YSzRyNjJGL2x0?=
 =?utf-8?B?SCs5Rms2c2laVzZpL1RmSTIxKzZaQ01DZHdmSnEvby9xbTQ5SlN6QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6160cad-244a-49e6-032a-08de906bd41c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 03:56:32.9390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XIZDeD+PIq5WiU/U2g+ilJECvNE/+zLnZ5Yug/lJTDk+ek7p8mVEFBYUlpIPTbYGhvR964SzCw5Re4GV2k5zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
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

On Mon, Mar 30, 2026 at 09:25:45PM +0200, Luca Ceresoli wrote:
> The bridge and ret variables are per-iteration variables, whose values
> don't have to be carried to the next iteration or be used after the loop
> end. Move their declaration inside the loop scope as a cleanup and to make
> code clearer.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> This patch is new in v2
> ---
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Nit: change subject to:
drm/mxsfb/lcdif: move iteration-specific variables declaration inside loop in lcdif_attach_bridge

Reviewed-by: Liu Ying <victor.liu@nxp.com>

-- 
Regards,
Liu Ying
