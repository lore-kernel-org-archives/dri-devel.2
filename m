Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E984E7E35D
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF30210F48B;
	Fri,  3 Apr 2026 09:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Vec81VZg";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E474710F48B
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 09:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrqYlGjZEGqO2BnVHvcKD7Z0GpDwT9ee4Qbgk+1l7ZjB5GYdy01PTv6e4L5p5EG366juWejm1AiztnfTu/c/XL07dtvbhCivNoX0iPidU0OVvQITqiyL3GV2Rit9+YNT5LlaKU+vw4m3ksszf9SyLYlQJsXX9WMhqtAEh3J6epBDAoMJq1oAQAZb33mZJRHw401VtGbcreDnZyWt6YCnryo0we2gyOwWk5VTPXCwMVU9ROTLg8PtI02QyUpd3OE4FGZYHh2Q2WABXJpFtT6lmnjWmGySYls6n/+KuugcxBT7i0lCT4hRL++xVVdum59A9NeFtAC38Of5buTHwDJ76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVmT/WlN+VsGcSpN+sNolSrteDQUxXvGdTYtp70UG80=;
 b=hNYtQHpnZ2DdLR0dJ5x7u6IxDdruo3i/Ye9ZXl+ETd/2wEQCB0osje23kCV6VG4vvX3ve8Qh6fTDbwBHqfHuMTh3IGyBmvGT9N0FIs7AcDndUe15KWCYDPhqUGeXxCySFB/jy11gCo0MVqgdrJHl6FlGgkL4J8e21vuRM0nNaQB+gs6KpeCJm7ToGCnH7VhhuLcntZLLmpi4WgU6X3R2+81O3Z3o7aeqzzrWDcxMyUNWNjUtg/0m+sRuF6qp3JpU8pHG/rIGSa+xvKg/oSlS+y4S3BEYfxoJGIssVHa7K1uY7EXqZexO/9aelyPTDRsOd4xDluey6Qm0TG0Uc1ioug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVmT/WlN+VsGcSpN+sNolSrteDQUxXvGdTYtp70UG80=;
 b=Vec81VZg5FxtLEog+o0EI3K8YjhKW3JdExJKeOpuNSE1RRI/F3qA6VwhsoupBMKzVOvmT4Mhpj0NRept4+5kJagWs9qcELQaRBH4wo6X2B+SOFpGAyfAE0VGlzkmCG34RaEUkvRDKteWyJSOSjGz+1TecIG4ksiU423aGobbUa3CDiUIlovvOBuSeJngp5DuicJ9ObCPYCT8+RMWsJPfDkQG2F1nIa81G/+/4AcJZONiOrHp8ufJ9kJ+WK5Ibm5MTWR2sjH04xp6nbi7+CIZZ0XuPe6+0htyVjegZ84nuEyyTutZ1jf4jCLP0FiQWJV0pfuYrNz1fZDRac/sqReWmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI2PR04MB10836.eurprd04.prod.outlook.com (2603:10a6:800:276::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 3 Apr
 2026 09:34:19 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 09:34:19 +0000
Message-ID: <37b06014-33fb-4c4f-bbe9-bbaa411b9d1d@nxp.com>
Date: Fri, 3 Apr 2026 17:35:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] drm/bridge: imx8mp-hdmi-tx-connector-fixup: show
 a warning when adding the overlay
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
References: <20260402-drm-lcdif-dbanc-v3-0-27cd247a0847@bootlin.com>
 <20260402-drm-lcdif-dbanc-v3-9-27cd247a0847@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260402-drm-lcdif-dbanc-v3-9-27cd247a0847@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MA5P287CA0089.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::9) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI2PR04MB10836:EE_
X-MS-Office365-Filtering-Correlation-Id: ec22d7e4-2da3-4503-af72-08de91642e24
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z70OpVziTqJigL8YJUddQv46Rt8BwlVFs8hJVo3akyeepJ+1mrhgpZS5V7BPNQixxCebvewvXQYlEijI06jnaXPaYg0Swokrz74HKEf9ENDF2y7OO5AZCpPHpfukBaqMN8to5q1yfXgVFSSBUBtrLaGElugbGQ3n19D20nPD35AqmHyY6gW9vLpZt2u58l3TLRVrOug4SVqVvcMtkT8bHHcFGApSu8N1HEQ93b4W17lJF1aZ6llxH7+Q9+pmCpwhQUWB5tYMe5ohGllvOT14gMmTu4QNbZiY+oRJPfPCVJRNMXjtkUk75ghh/xsdpXX+xx8Lz/BTxS5Z/3vz9BKgYyZlJ26nxnrHdRlaUrykCFtfF001okMBNN1CspXPEsLy8e/oavZ/Me6AgsNOX+9V0Fz8e5K5kan/k0VNAtScLEzW0EonFp0efSmu1oNoHHrrhvinPs7fBzbBrFuFbRWuiS1MpfbcP42VtQj9Q2mIShlwvgTWbhLAv6AQhxcJ/FTrjwODVQoxCq7Lram025EoSMJsq/g49IbDpsh7CfB0ftYh7jRrgsTmvx2PCpGdHeS2SM0m3kTfltdJ2E62otF29clBxuuI+jhq/w6i0YiVmrnY8L+uDlWWQLi390tCsgzrOUGQFmH8a4I4Pl4RJPIf2w2Vf1NSLrXEGeaIFqj0MWLn07zQNPTD5Ccsc3YNj9ZQHA9xW9vt05DTliHSWb92ToIGSNJ1DYia5rVz8x6TGN5SstsLFAGMhsb/q41zlB6j4BO1cPwjkT396P70LT9saemDWMb5othPsBnuOj7An/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUI3eTVWSTh1eWl5QTQzUElxbk9jTzFXQWZMUUNjTExHVDdBTjFvMjM5cU9K?=
 =?utf-8?B?N3d6QXZjeTlWeDlEUFlPTFZiYjhaeXlLVm1ZY0duY0RMOFAxYjJRZFlWOE1p?=
 =?utf-8?B?WUJoSVptYTRDSDBlbHh3WnhPNkhwRWhadVJFdzVCdHdocFAybnJOVHNZZ0M1?=
 =?utf-8?B?VDd1RlJFQUVZZjA3aUhjUzlsVDRPb1Y1RGc4Sm8vRmxFbFZPcnc1bm9GT1l6?=
 =?utf-8?B?VXIvWG1WTzRDS0JxeGQ4TCsrNGRUYThGZWhDc1M1TVBaWkYzNG4xSXFTazRB?=
 =?utf-8?B?L2ovUTlEbW9ueGZkdHVHSFd6ZC9zaEJVWlNUSWNSOVpUM0dxelRJL0RucWI2?=
 =?utf-8?B?K2lZcUZ6b3BjcXNxelN4dy9yU1RBYTlCOGFhdmxaNXptYktUajJYN1I1SGdD?=
 =?utf-8?B?d2ZaT01YVTViTkx0V3lLSUp6UVF1bXJTSW1IZldTRXcrZVpzOXp0bTMzYytj?=
 =?utf-8?B?bWZLdE0rSjlMMGRnMlhuRU8xRlJyeEF3ZVF5Ni8ya1krY1VONEljczhqTzFq?=
 =?utf-8?B?N0FXcXk3emNJM2lmN1JHdWxFeHVuRWZ3MWo4aVdid1QyS2pLalAyUm5RL2VX?=
 =?utf-8?B?M0p2OG4rSHdaVDlrSitybnJ0NG1BRVN4b3NxT1M4cm1zaDdYbWVSWkk5Q3BR?=
 =?utf-8?B?QXJqbGNMU3NENlNKMXlmRExHeVNIMEdhZmllQjVLK2lreTdqeW92N3NxdUk2?=
 =?utf-8?B?UGE5QkVNbnNVQWtJZG9CZkZaMGtacjlPTjBKTnhuZXFQV044RHVZNjQwNDZi?=
 =?utf-8?B?QkRvQy9YdWVRdktHb1U3azl5Q2xFQ1JYakFiSWRiWEJrTHFBZkkrdTRFbFlW?=
 =?utf-8?B?S1BPUjhnMGxmekhRUXd6MzI3ckxVeHI2L01VM1hLN2krY28valJPcmljVTNk?=
 =?utf-8?B?NjErL2d1TG1VRHowcUdDWlR2RjZvVVBLUndaOEVJMWdOQ25NanhEeldWTFNC?=
 =?utf-8?B?ZUIwdzIxKzFhdkNwaW5kK04vY1A4Q3hFS01MS2RxVUZrQmNXdVZhb1FjWkxy?=
 =?utf-8?B?M0hlZDYzd2RDVTZqUE5OOVdQczlLbUNmWUoydnpncFRmbUJ2WFdVNVRNVk5P?=
 =?utf-8?B?MVorVkpVd3V1elhTcFpNSnFzNUFnTlFMMThGaitIeEhXMDZlMzVkKzBYM2xq?=
 =?utf-8?B?b1FNZDlsSUlpSkRUdGZESEdONUN0KzNpWklVT1QydXB4REEyd0YxeXp3S0VH?=
 =?utf-8?B?SGxNaDVwcG9rRkRlVjYybXlyVE1FV1F5NzJJeUlPZlpzOS81aVhGbEU0UEN6?=
 =?utf-8?B?bTlRdEs3dW4wV0FsOXp6OS8vSHhTcWw3Q2NHbVdZeC81ZDc0a2JVVGZmYTcw?=
 =?utf-8?B?RDE0NjFBNEJBb2dSZk5sNGFwOWZJaStIajM1clg5VzNrNnhUN1NLQ0FNMVlC?=
 =?utf-8?B?OVdLeWdOSTFZRzNCb2VFZ0NzRXk2S0R5M0UweTQ0QzR2Z2h2Y21zQlNlRGg1?=
 =?utf-8?B?Nnh6dHFnaGI1c3lJYzQ0ZFY5eEg3My9veTk1K29WQXhPUCtyNk5FeUlBK0FS?=
 =?utf-8?B?a3J4bGw3bDlNZWRCNTVOVXJZY1FQa2xiNEFVV28zUDBJWHhuSVZta0grcS9U?=
 =?utf-8?B?cXlPUW1pa3ZHenNXelFBVEJsZkZXT1NWbmVBSk9UTEpqZ0l1UGVwR2V0SVJs?=
 =?utf-8?B?ZlQ2YmRKend4NThRclRUQS93cnFjRm9yL3ZZb2dkM2VYdnNlTlhoVldsb3hQ?=
 =?utf-8?B?NjlzUmd2YXlPc3BuU016S3Jwb2ExSEMxTEl1VWRab0w0bm96QVVNM25pNGNH?=
 =?utf-8?B?N0N3UXJyUXR1NGE4KzNhZE1tV0VYWDlad2xub1RLRGNJbWhRTmxtK3dKQzJi?=
 =?utf-8?B?WGxqNE5tMXhuRUNLcmZGQWdJWUZ6WERjMFFsUHRmZFhUcGo2eHhIN01COFZB?=
 =?utf-8?B?d0NhZ0g0NitYczJRcWpLNEdUWHdyc2RSTU5yanZTdnVETGxWak42cWNOUFJ4?=
 =?utf-8?B?QU0xcnBySEZaQjNWcnFleUppUng1aWdPTFJXQXFJSjRPUWhFN3VqUWE0Yk5D?=
 =?utf-8?B?MWxwLzJMUHdjcFUwaVhkbjM5Yzh2bVV4UHMvYVF2VU5Na3ZpYnp1SWk0RDJj?=
 =?utf-8?B?WW5NLzdoTmRXVEhMcFVCMVRpZ1VMc0ZBSWNLSXhlRW9Ed0VyVjRicG5GNGp6?=
 =?utf-8?B?dUNic1NYek52NmhJY0RpeHpwQjZtTW5YbXJmd0JweER1UlBUQ3lCQnpINzJX?=
 =?utf-8?B?dFgvdFlPUXdRby9ub2JhcGpNd2luUU9MWXRDd2d2cmc5TytHd1JrMGpKV3Ju?=
 =?utf-8?B?R3JwZlNvTkhPWGt5VEw2WEdSUG9TOXlZUmNqdFpEZlIvWGxORzloMGpmWnNJ?=
 =?utf-8?B?LzNZeFZuNWgwL3Y5endVTlRLdnVXMkRuL3dtbGo1VVZ1TVk2Nyt6QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec22d7e4-2da3-4503-af72-08de91642e24
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:34:19.2105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wv8qeiX9ZG7zUFINt5JgWfRYWhbrX/al5+wlZJCGTMGWdDei3FyCCh+vjPSotDNlZCM6V38CvVI5g01i90c8+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10836
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

On Thu, Apr 02, 2026 at 11:26:04AM +0200, Luca Ceresoli wrote:
> Describing the HDMI connector in device tree is recommended. While the
> overlay insertion is a workaround to avoid breaking existing devices, every
> dts should be improved by adding a connector description.
> 
> Add a warning to make users aware as far as possible.
> 
> As a warning line cannot hold all the relevant info, add a detailed comment
> in the code so it easy to find when the warning is seen.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Patch added in v3. Kept as a separate comment w.r.t. the patch adding the
> overlay to let it be added in a later moment in case we want to convert
> existing dts files before adding the warning.
> ---
>  .../gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
> index dc1736bfc3ac..f6190d86abd0 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
> @@ -44,6 +44,23 @@ static int __init imx8mp_hdmi_tx_connector_fixup_init(void)
>  	if (endpoint)
>  		return 0;
>  
> +	/*
> +	 * Boards with an HDMI connector should describe it in a device
> +	 * tree node with compatible = "hdmi-connector".
> +	 *
> +	 * If you see this warning, it means such a node was not found and
> +	 * a fallback one is added using a device tree overlay. Please add
> +	 * one in your device tree, also describing the exact connector
> +	 * type (the added overlay assumes Type A as a fallback, but it
> +	 * might be wrong).
> +	 *
> +	 * This node is necessary for modern DRM, where bridge drivers do
> +	 * not create a connector (see the DRM_BRIDGE_ATTACH_NO_CONNECTOR
> +	 * flag). See https://docs.kernel.org/gpu/drm-kms-helpers.html for
> +	 * more info.
> +	 */
> +	pr_warn("Please add a hdmi-connector DT node for imx8mp-hdmi-tx.");

Missing '\n' in warning message.  With it added:
Reviewed-by: Liu Ying <victor.liu@nxp.com>

> +
>  	dtbo_start = __dtbo_imx8mp_hdmi_tx_connector_fixup_begin;
>  	dtbo_size = __dtbo_imx8mp_hdmi_tx_connector_fixup_end -
>  		    __dtbo_imx8mp_hdmi_tx_connector_fixup_begin;
> 

-- 
Regards,
Liu Ying
