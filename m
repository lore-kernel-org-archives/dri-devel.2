Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF42C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A64D10E3AC;
	Mon, 21 Sep 2026 14:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S+A2jMpG";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B776B10E3A2;
 Mon, 21 Sep 2026 14:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGZdLIzb+bKzcI466v29cW2Y46cEUur4HVjGHtDfG0majdAxrCkuRENxn6ArxAneqNtK7UHVh6iwFj99dASwjTcPGL45BG7hDVjnDn/ugCdJQBH3pvLHetffP+dJ3i1xT3AtLaEHXsWQyYGzRAgvNXvKyG1zF0apJfD6k+hPUKjAqfOozilcmOECVRsc5oueqr0/40qsO+TiSpmKEK/Hz7MtHt9XefZzY0eKwBhuKtjvoYN07BjPBGDpZdUI09wDmE+hX6gN8DL1eruySvwpiNTYoR0cmS8DGTGyKWl5o+VpHu2PYIeoAJ/N9M4Ly0DG/5rzrvjeEX0gvwlrsEFjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLMPFEgSAqZyBdWsP31fIJ4sgcL2+0aVY2gTJcAODLs=;
 b=xoQ/tIXVZh/mOI9//8f5QkM3NTbSfX4DSPnpyerGIlrFzOujBQYURPyUcWVp/Vuu1S8StLEZBuhse+1K2IQMjUhQdlmij7M1UDRDe4cbj8Du9xTSxlWVn6yTLKn7ynbgItRnWt4YYYW2XNOfSTrZdpTfa0dO6a2AX8LzMH5vl8s9zA1Z002GvumaW2EhWlbtdqQdkh2b5itO3Yxiyg03UvQEZwLPSsHVdeJ26NkY7Nwn56lJC00wCQXGL6UN+xzbbAnuYKCpTYwDjq9OFsSnP37FqYa78ugpEuDJBVI8NHiusqq8Ob3mdrkbqAMY345iBqMmMBEXqiD0744dXtT0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLMPFEgSAqZyBdWsP31fIJ4sgcL2+0aVY2gTJcAODLs=;
 b=S+A2jMpGA/JEBpHNaGAAILRR8dbzJCnHmolno7c2ljtwXgzojWUqBG63PjqgF3L8m2o3xATkvRWn+gwA/9o2SVT15lUkTip2poUyhBLWXEeG5hGg4JWoSJD4eYoNFAOvfvtKZ4/NdorlCwG+UebZCEoRsS1Sxws0XeLgiIyVxTLV1W1jT8wqAGPhTleBfI0CX87WYnhVZUCQUOitk6undrZa5ZHJVFKRUHevnOx3AkwONpCJC30P3w1MuA0BzSg4Pv8yLLUX9OtcvPxFnA9guUgsVuLQM6oo3TUANusCqLTkchQeo+TH7Xs7KquAkJYScoGpmc70S1rYhfqTQ0s6Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GV1PR04MB9214.eurprd04.prod.outlook.com
 (2603:10a6:150:29::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:22:38 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 14:22:38 +0000
Date: Mon, 21 Sep 2026 17:22:30 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Paul Cercueil <paul@crapouillou.net>, Paul Kocialkowski <paulk@sys-base.io>, 
 Linus Walleij <linusw@kernel.org>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 13/19] drm/bridge: fsl-ldb: don't create a panel_bridge
Message-ID: <wge4c6p4ijsk6skitl5slznxagmuw5m4lhqmz56v6bbrsu4r4f@fhmo5hpibut3>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-13-83afb4f1a707@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-drm-bridge-every-panel-v3-13-83afb4f1a707@bootlin.com>
X-ClientProxiedBy: AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::12) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GV1PR04MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a00f19-e95e-419c-3f3c-08df17ebc9d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|19092799006|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6Ry210RMWU1m99zK2Th985rcEUcrtllfN1seDfAStbM9JRA6t+vfF6og33g32fnz5X77Qr5HrH9WjIw6nBhKQG2CD5kHNWPxti2JEgo0Zm4tVMW9lfD0etHojTT6CzlQ2hyapKszjRQJVuSIpzfZu8vKElHVcSbYpsaXTXsKPanLOb8uqve/t3m8pqbNz1EUw/NV1hP3Rv1q6RLo8esk22wgQj4DQq3jPqZavSW4ninhWIXzJId5DV54FaYeWNHgh1YIgeaKfOtZVT7b+qyB9cGmyUG3hRUg8upP0/uH2c4dSOP01yS5w4PkPKV3hifwaFjAzJzHrXQ5ELiSLUUynrTBEPCRVWDJD+MraNllDYsvnB6Q85JC/4VYsxtE7p86XlbIMoLof6cYqtRtAO0xIxd6f5r17+FHLYdJeiYH0ydFjC+hZ/fmXsKrvmqbZmR6RY+Pxcc+PDx9X2NzMSmjGN5PeJgl27gIZlZirgyvRlw6AV4thGgbjAEIm1i/cmWQW5uOHsKEgAyCp5XAO0ekalTIkEzcQRUzf0w0j0pWF1ttFsWAqsMzLKgzd863DAoT4ARqr3ccK+oCF6le7Dc2AN4sIQx6yx+A9ZtZnuw8wbkWpmSMCEJrbpQQo3JT/QYlD1OSobOb8rqvm19cumpOh+uFqT80JJk0sPY/GG9nf/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(19092799006)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H95D/SW4ZJ5x08QD7PJCQg2DI0haQgLFNEtphZR+/K+dg6LeB8d3fZaEgg7w?=
 =?us-ascii?Q?Eqrw1s69lYD45VxU1rbU06vL6TORFmomLjS7ZniegKZ5XmX3/3haaZ57JeNl?=
 =?us-ascii?Q?oOiH+to8uDIOvSVlj7q1C7hUcMTnBXCwc2tUILImjsbICp+Zh8tiYs0/C/rX?=
 =?us-ascii?Q?zWUO3r7roCClx34UJ1Dm6aeUhRb0PL1K+mxEws7auYUV6i5pWbUe6Hh9F5jA?=
 =?us-ascii?Q?RCDcyERxRuHVebif+5BObX1NIUooEfyZxEXVKJF0miz+m8BYVb2rlfGTR/i7?=
 =?us-ascii?Q?LA9h2yhqU5uJNn7VgbaC0n76Z6JHfnfJxtmTjqOB+2vgvFg6VWv0WiSmYuFw?=
 =?us-ascii?Q?szdTlq8JLcU/JnyasBNEz9FPdQ4Qi3TFAGvMwPHVUUySFI73i7eEmVNe+qsx?=
 =?us-ascii?Q?JXXwwoEatHBWgNZXPtZo4hv1olS1e7VjkLtO8bg3tjgqGaVZzxyshTl53PuX?=
 =?us-ascii?Q?VzJA0GDc6FKo13vZwb8Xiw0UaG0nDGtso3GoLfbjmM679BYls2uRuD5TuFMv?=
 =?us-ascii?Q?3hN7bLMzWCb9ls1Fa6CqaUVoOCtyouWZq94Q94AhJDy0HPUUG/1QZXQUGZ25?=
 =?us-ascii?Q?JVwI1l9Ots045/HgOQvWkfqhOvFUMyudcnIKEp3oV6v1F4Q/9J/KZcm/K2yl?=
 =?us-ascii?Q?9xiPe2rtY3VdPUKLPYl5JlVxjFgzKdt0L/OvQr+lPMKbTak4YEyBTUOSykuo?=
 =?us-ascii?Q?dQJStoT6jDhrKfx++yvc0ImyXjJE4VkEP93X91Orut12djmPhJkA75ka8tCS?=
 =?us-ascii?Q?ppwi24A753/9FxZrMwdAkBVhdCp9boi/UYgasZt4NybCD5vZ4OYMOc9UdYXK?=
 =?us-ascii?Q?Tub1Hk8SYMBTP12brAD8T49+/pNl++HY/1RRnBKxSYQetRAp1ACXApsxNLU5?=
 =?us-ascii?Q?07cFOYdp06VTmU7l5uiiQlpghKfB2nkzFP5DpuyRUhux7wT05cJA9rhYwERD?=
 =?us-ascii?Q?8RSWrGpxX7JXwNDAbgvIpZAWqVEPdvRc3iew7YBzkuSvm5e3Ag5d45a9UIpv?=
 =?us-ascii?Q?ijqlONABEEcsxO5srZCvwuACN/fFrlKTgWbIoss8//J+8aaditT7LKFhS9Zb?=
 =?us-ascii?Q?iS6qK6KTzCl62OhEEx3dFMMGZPoOe5XLe9pdQvjQHyaBvqMEjm4cVQXiUT7h?=
 =?us-ascii?Q?q4Ait352Fuji3lif9StJhaeqizBYQp/pqeAtKU/vsD9gXtTjRMPBaP8MkVPm?=
 =?us-ascii?Q?C8tPQywB4iO5/EdVz1ZTtcHICjW2NhDl3uqon0sy//7/woL3m0P0sLcRyCZ8?=
 =?us-ascii?Q?JAdguOTRJlDAu95emlSeZESdqiHpm/ZDGeWtJl6a9EsAQepJ12bzaz1ilKU4?=
 =?us-ascii?Q?9NXOS1C1W1mpqNvknKUZHAi/B0sRkWYxjRzTa5KUyv+1mG1EBQqbXEHNYoXI?=
 =?us-ascii?Q?cZVdt7IfTuidFdc6lysDVkz00QuCjYcEdj5+oFpwuGtgvsM5vnuKCt74SC92?=
 =?us-ascii?Q?XGLVK9Tg0q/V8E1Hk/UJ5ZkQDEx7njPj/Hrw56qUltUD/G0/HB2qes81h3u0?=
 =?us-ascii?Q?AY4/Ld3yfnHjv740unHdZvpI1rBgWO0BZmQDWQ8XX5Pe4sQohsrc7AgLComZ?=
 =?us-ascii?Q?3eK2bM0ts6KF4nJfI6WBhWx/M59fI8pEOej5IUyjy+qpw0zUJM+5nwXJvSvz?=
 =?us-ascii?Q?LoR4G4NPXDDjze0DPzkYmhZUl/FrSSW60H6hieroDZIMelmXoV5wi7dvUnpw?=
 =?us-ascii?Q?9RnqwSglOHFUMz4RowLG4VVoS/CAMZSUACRnJoyhhsJWJljkLzF0oC+E8asX?=
 =?us-ascii?Q?ResjsnOdAUtAc0/aC0cTCh+t28gcruE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a00f19-e95e-419c-3f3c-08df17ebc9d4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:22:38.4915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bs+8VLkYNnpIoq06RpXBn2mI9S3fceP1a3JMZz7tjv9osAhAQUwnt+2hS4uQUCewHfHdN9zbTxBKoAiO0ipT5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9214
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

On Wed, Sep 16, 2026 at 03:45:37PM +0200, Luca Ceresoli wrote:
> Now a panel_bridge is automatically created for every drm_panel and the
> panel-bridge API is just a deprecated wrapper to access it.
> 
> Update and simplify the code by just getting a reference to the
> already-existing bridge using of_drm_find_and_get_bridge().
> 
> And since of_drm_find_and_get_bridge() returns a refcounted bridge, take
> care of putting the bridge reference by using bridge->next_bridge.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
