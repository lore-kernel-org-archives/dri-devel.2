Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F123CC6B00
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 03:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5542510EEA0;
	Thu,  2 Apr 2026 03:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="nOCPNw+4";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A227710EF5C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 03:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U960zmI7htpfFR6yIbfhPj0ohXgLro887JcAlP+pqFFzH+zjk46X63vs6hbnivCBJ8eG7bvuFTL2PPriX/MZZet+/2dAv+I0Med6StJRVRvMBu5BPg2icS2K5+xiuQ9EKchaCJmSMi3Kigl0bWVdtDVsahdze3hifyE/d/FwyTEiW/bv/SFEMuu7nzw2y3RdNvxnXC3Q16l6p2JEL+Q/aWvQ4+J8jG9QvqwTz/ope8zMbNarCDr3cB4mlHBVVW5XL3WjMUCv6ZwY3pl6RUUEzQGKQLGy/CgPsfIlIuLIAUXbAlMRpseL9ghC7w1+6ZMUQAumCW1yemJm7Il18ObAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImWOLwtL1miewGwjHy1dbdoOTuWHbbEEdBMCNuZPVi0=;
 b=Nj/sSNjARrmZ8d4BelbhX6SkjDjpi9DPg+wgA7soBHNiz8JlemQEjAMsLRAwnLYqYiQMhdzDGPI4NNP5We838GFSU/vn16cJvgIMpUMzOf3XY98nrE4Mn23QSTL7Ap8OgX+s7TB2DejjfQrZZfj6YVgmR5p2Pih9b0LnWQXxROEezPa3sGKI9FsYWmf2Rx1jl61/BLX9jkt2jKoaG1l9t818Yh88D1BVS5lr6nttmsFJEloAeXjWC9STqBWscy3EmGf1t0tanYN6waayDz9qqw0dOnjJulSUFcx2/AocHRb+jZMfDy2irbdqKqlYCuYZO/qCIK+DSfxgNDsAsWiFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImWOLwtL1miewGwjHy1dbdoOTuWHbbEEdBMCNuZPVi0=;
 b=nOCPNw+4/o6vRJk7uDIBS1M8kKVchCyh9/r8sYxtsW5dckU7un9JeglCAbYVOxipw4WDeBMqQy4IKy9ri69AdarCPceVOII5x/9Q1R3I8MtRyN5DhKTiL8dbmzLGn+DpM5+cWCPDDJGhEvEtEpCL8HWr1tlHCwbnbaSfjwLJGkB9WlMFPWBRY2rAg7FylfU5Jof0QQNs0MLahc9gLUJRfTMlythFOQqkJETtL5cKRypFJSd1zk70yufTTqthIqSihR5zRttxmi4mvdXO26kav1s3p5JKW/pHCSsAbDik3CCtu9Ucqud2f74ScpCm6ivABt7RABk4H9wpLWKxDmUURg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 2 Apr
 2026 03:49:15 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 03:49:30 +0000
Message-ID: <10c8f222-e60c-44ca-a754-1b6e71902676@nxp.com>
Date: Thu, 2 Apr 2026 11:50:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] drm/mxsfb/lcdif: simplify ep pointer management
 using __free
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
 <20260330-drm-lcdif-dbanc-v2-2-c7f2af536a24@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260330-drm-lcdif-dbanc-v2-2-c7f2af536a24@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da1e81a-bcaa-4719-d7f4-08de906ad7ff
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|376014|1800799024|18002099003|921020|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: +skFA4VCy/C62D6Xra/0Cftz+Do2hRvPolSxjBeX4343FKPbYUE7FQ59qTt8NMF3JNma29CsNcT15755cfW1JI9QqY8VhDuYOBlbxpe4I/9UoqBRt4ANymLoZ90cideiEK29mGr+tVIckZe3v5AxmSdDurkku/cvaU0ur7BRRCmd/yI3hAed6ktXhzNafNyDAQxJRh7aOLqjJHXNdP5WjJgExWdB0k3N9h3yFBaKVIgM0zTEv/yFws74VFgJzp48PRiCrgcnLQ8uXtG9d9ldJquyRIWECas02uI9SMJ6L23PraTmhj+1rez5rmDnwDpD+XD+rG+O399Pz8FxZ2FWNYwlKhpqTTxfcUyiMiiPUhVl+l2VXcDLOYIihDn5ir/zo444TTUJjRckpO/HDsDs+yqqjh64ruO98jAhUPZsFvsnPnJ+eSy7qm4H480b63ZdUyMY32ibBTgt+SqItOGfGIqNOnpiG8TdKLjFwnRpCIVX7vczjRBt45VOfki5b1SgKnF/5NggThL2BlBdwEJ4IXPDm7ynjU5zBp5cnz68ZXrW1hk3CmsEzsmblhS5T3bliiVDcrxk1WgAvOjQCzQ4Wjy718IWaZZeQvGM9hSjjYQg5W2TMJj/LqGx3ywiCSOn/qoPzMjz/kGgjRkNF1Mgz1lSN9zJKgq6l0dCpcnC5HUPjXHfF1E8tvbgdEIdjMBu8BAaaaj7h5kyxOn+rIjl5KHsrlxpUocMyRNDHn29z/cYOTmWVk0EVfdfa50xR2gufjB/6A20ig8SMJz6jXKquQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(18002099003)(921020)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnV6RnFCODh3Z1NFeDBWeDVESVZxcTNTTFR4TytQY09UM0U0a3VYZzdTczRJ?=
 =?utf-8?B?cnhXWmx3M25BN2tUb2RUMGJxNnlHampVSmdibnh1Q244WFlkSDREeC9yYXJ0?=
 =?utf-8?B?SVB3WVpINVI5bDNVYkhNK3hWUEpTRWRUWGRReHEveE9xaE9PSWFRcGl0djdJ?=
 =?utf-8?B?b0tqNWM2SWY2bmdMcGpVWHM5ZkFsa25JVUQ0OFZFREpBUEt5TmszaGFLbGw1?=
 =?utf-8?B?U1krR2VPa0xVbmJnV0NJbDVyK0FWUDd1MDhZbUtldjg5RUtodHN1UTh6SWJQ?=
 =?utf-8?B?QkxaQzdxOUdGOVNieHJ6bkRtQ2F0Y1Z6blN0bHZmUVhTZmsyMUdlSVl1b2U2?=
 =?utf-8?B?SVFjK0p4R3h6STBOa3RkM24wbGhDVGc3S2IxTTIzdzV0dHB6S05UUithYW1R?=
 =?utf-8?B?c1N4SFBIUlc5U0k2MTN2Q0VjQlBUd1hYdkVXTFgyRWNWMkc4UFFNbUhkNlBR?=
 =?utf-8?B?RWJGeTBqOHlnR1daQVU1cXJMMTN4alZEa2JvdUQwd00reVlxd01vcFJ3azJK?=
 =?utf-8?B?cXRxWjdFSmFHTDAxM2E2RWpJeTdIbFMrNzkwZHhneDkxVkNUSi9BN1IzcjJN?=
 =?utf-8?B?UUgreDZURGw5L3c4VFBxSFNIdGxmUUtjeWY1TVVZNG1kMHgwR0xod1c2TndP?=
 =?utf-8?B?UnVMVWhXM0wzUkNkbC9keFVZSS9xRTQzdUV1dk0xQ2JCQW9BSlpiWUg1VXVM?=
 =?utf-8?B?L2VBTnh2S2llYVNXK0tkbWRGYWhIczhKYUkrQjBtejg1a0cwQUM0VExEWVox?=
 =?utf-8?B?UWlNQ01qc0hPQlpFbUdJRW1FcnNtYklJUjBKVm1FZ1Erd2dScFBTYnVkVzA4?=
 =?utf-8?B?T1M5WmdrMUNWR2dUQVY5c2V0ck1YNXNVZnkxMTJzeUxyOHBHNXRFTEoxV1pD?=
 =?utf-8?B?K0NDWklHUHQzVldyc3Q4TFBPclIrYXpDUUpVRWVBVlNSMmhRNVVtT05iZ21N?=
 =?utf-8?B?bHFubGw0QitvZTc3UjdvTU1DUmNUamJ6SzNtUjcwc0doMlFFUzkvTVpXaFZp?=
 =?utf-8?B?dHFDcnk5YlRPYjRNV1FoSFpZeTlKcUZya1cxWjNZUVJ3WnpRYnJsV2M3Ri8z?=
 =?utf-8?B?UzhQMVFvQkEyNG5vS1Q5czZLS1hNSjNlQUhodUlYZ3pIc3NMVDJkY0k4NkMw?=
 =?utf-8?B?Q29oaGVhazFMZzkwRmwzTFkwekJwR2ZpeTYva2JtQ2h2QnZpZEpTblBCeFJr?=
 =?utf-8?B?WE82ekgrNE02R3ZDZm1Yek1oMncvSFRLa2llVXlNcXcvM0tnRzdMVHA5bkxJ?=
 =?utf-8?B?bkpwcE54VWg5dlhHazlVMmtPcklIbnltSWpmRERpMEtacTM5RTBEWThGTGxL?=
 =?utf-8?B?NzZ4RVB1amNoQ05nQkN5WWlrTFVZR2twak5kMlA1THZMWlJ5V29FV25xQ1E0?=
 =?utf-8?B?M3hQSnU4K25aSldqZ2hIT3VZNUF2S3I2M21NcCtOQnFnMjdMMG9BRzBYNGNM?=
 =?utf-8?B?L21LYVpsOW1vZ3Q4RTlZd1VaR1RXdkIvakNpSVNvNmxoaitRaGM2RzdjRTE3?=
 =?utf-8?B?WHpEMUFldndEUnl2dzdqc1U4dFEvcnlDVE1yWWU1T3RHckU2NDZpVllZZXdy?=
 =?utf-8?B?bFBKbFhSRGo2RmE1WTc0akFOWWE0aTc2SENkZUlydnZjS1FNYzlCdWdEZU9k?=
 =?utf-8?B?RW9vT2VvdzJWNkl0MGx3WVlINTJYUXhYcUovVnFEYWNaT3JHL0dnR0hZSUI0?=
 =?utf-8?B?KzNZUGFtU2dhcERPb242OFplNXMwdzJrSXZQdVVYYXF0RGNleEFRWHRqN29F?=
 =?utf-8?B?STNiRncyeVJZdmVZcS9JZldTOG1nMFAyVEh5MTd0QTRVeVc3d3UzbFgrcUJy?=
 =?utf-8?B?SHk0azFMbXlTMVhaZFQ5dEFLQi9aYWdXdWEzQ2ZsZ3BLNVBFNDJEZ1lVRkZq?=
 =?utf-8?B?U1ZVL0hQTnFZbitOUFJQNXpnMEVkSytob3pzL1A1YXFvby83Nkgzd3hNWlAv?=
 =?utf-8?B?M0hmbFVsTjBIMmgwQVFycS9JYWNYOFFkbWNXWlZiVmlxNk9YMkxkMDZpdGFP?=
 =?utf-8?B?NkZBZ0FCOVBLNGVYRjNoRHNqcVFqb2ZlVklCNFZXVUJZaEpIVkpVMGdjQXdS?=
 =?utf-8?B?MnV5YkZmUGsyb0M3YWVKa2RsYTdpY01ybTJseis3bHVUQnpHaEdIVzdRVEly?=
 =?utf-8?B?TXVWdFAyd2VGN2JKK2JVSmxlL3FCSTJFZTUxQUFLZkxkNkdRUU1VSVZZNFpm?=
 =?utf-8?B?SVBLTkpLTGlZTERXNXJTdmxQZk4xSklteUlIRUQ0ZndId1M3blY2bisyc0Nj?=
 =?utf-8?B?bG52Y2hUeFNYdUdrYTBzQ2NMaGVRc2xWUFZ0M2F4NHdmV0FHNFp3emk3YVRN?=
 =?utf-8?B?MFlOZUhGUmgyNWhHNlVCd0VxQkhlR2N0Y1crODB4ZzhtZUlFTTZPUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da1e81a-bcaa-4719-d7f4-08de906ad7ff
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 03:49:30.1685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pA5UkcG/IEMwRZ6OhBnVXpTNE4n+UtGX7CGp1FKQIK0YehGxBY6kTy1aAeOPx4Sjx4yfPJIg0ypYZq0191xGOw==
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

On Mon, Mar 30, 2026 at 09:25:43PM +0200, Luca Ceresoli wrote:
> Putting the ep device_node reference requires a of_node_put(ep) in many
> return points. Use a cleanup action to simplify the code.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> This patch is new in v2
> ---
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Liu Ying <victor.liu@nxp.com>
