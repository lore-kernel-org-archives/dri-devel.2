Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1451109E556
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1886610E1F8;
	Thu, 26 Mar 2026 06:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NiXa5TId";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD6E10E1F8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSpLYUs4GdD2poSTf8YJqoJrw1VMBKlrr99SCGxR5gZRJpyryS9M+tClI5O14ZBzQsKmtV5oYR2uobpsQ1so9lrr2afCEE2yi882RJa4gaqGpxlLQhYoRNdyO3rl/EyOTCVv48Q3wyWbeWkLHfIh9V83soJUqtiixvE0f6YshwR3JBbrBSPima8wO5VEpiJaPGXfY1znBdvyMRZmkQh9j+iXS7K2tR6AfcI+ZHXJDwBBytV4eJhpHFNXMLEnWmElgRTMWVmwQCrySWtO7KyKXD4OJpto/Rwd+l2ecDRJvPGp1fW6bBwzsAO/0hfT6SNPLN4zCUBLEkHBkYP8EO14/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRENcoXvZwzqU9rcO8bDskM2TeDoUmRt7kve2U0wFJM=;
 b=fO3oARzqEF8ABlk9j4o+CZUzo8jK1c54B9X6GKi1pgF6rEid2jrRQnmSjf7eH2AjRqca0rH7Sv/VfUho3egcoWhZRsLJnxvg5RzUgSIxeDIlXXIHVAmCzDO2qoi8b/256CSInKapkNZ1jR3c1h0PuFANTp5Rjx9VB1b+n8STO3zrelxxJwgiGaFzqicGxodruR8+r8I5Ty5AakD+HH7owRM5ekLM6y+7WZjhk5Ef2N7ClaPArUlVQCOKrUxugPGa2FIkNIES31yWWmR11fV2iuYV/z5Pyr1UkjjoIgpfI2Tpnx5AGE8JpRu9lnnGUjVSAW5T9q0IGoGbrf7KAc6J3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRENcoXvZwzqU9rcO8bDskM2TeDoUmRt7kve2U0wFJM=;
 b=NiXa5TId0f7Ch7NC+Jt5dE4NtW+uxhclneJNI7MjqBkJEOntHKsaMhQLCnCPCzaFt2UuW12CDRArvhyhLsPYNVRZwqBajryDIgdoMa1M7RxBl/gYWzJ+EIWHBVZV0LFV4zmvzenaC11QBpfokavY/ZlY75bYjPSnXEYdmDw9DheQuyh2Iwh5OjxvSwt9NCA4N225K5WTMWY7kT9JMyRXYl8BojBybp/7/e62DRnAPAUz3PpHfsQC10My4ovD1Lw61toGnHyCxozGdvM/0CfpgjwVvxNC7A+hIIAqWAoqisnrgqqqFE9luB5WSdy3MoL4K1Mwg3RQU75ziheqiOw+oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AMDPR04MB11300.eurprd04.prod.outlook.com (2603:10a6:20b:6cb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 06:39:24 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:39:24 +0000
Message-ID: <2d6cfad8-7f2c-4c78-9f93-136d6757ab9d@nxp.com>
Date: Thu, 26 Mar 2026 14:40:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/mxsfb/lcdif: simplify remote pointer management
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
 <20260320-drm-lcdif-dbanc-v1-1-479a04133e70@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260320-drm-lcdif-dbanc-v1-1-479a04133e70@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::6) To DB8PR04MB7051.eurprd04.prod.outlook.com
 (2603:10a6:10:fd::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AMDPR04MB11300:EE_
X-MS-Office365-Filtering-Correlation-Id: df13a71b-5463-45fb-647d-08de8b026a95
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|19092799006|1800799024|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GgIynwBXMdnR0Mi+myCnIH2wOc85WsPDGEZhfTvfET9vgQL7LJ9o2S/to2ZBIBpWX5WQIEoI2LUjGepZm4t8r2FnfkQ78XxK6rvEc7zbXqlw2EQ+0GeydC1Ecoo30z1mtbMP6R5h3ORjZxewi50gTYzS9Ato2k2PcjW7boUVwA2bvjxH3f6k+OUtE1aetSOgImgOOmgGJ5vD97bW9gcOw6WSlDZcGi3Gary0nmJUhLkK5fV69yWlCF9Kb86YPcplqlveC03HAXvveio+PewkA0LeCGok9ncHV+T0L5l0FdmmD9iAmf2ETH/d1ywI4SMkgC76HIvT/YDl3uOWtZgApsrdc0cPiKoqa3++GonL+jcE0qZeACHlPVhZm3NS8eQw2mKcZx1Dx7g8CG2U2FVDuxhDtBmGnZIToTnS34ve2YezXmHRVd784FncjVRnkNi4wqKwJyOuujZXY1hm0R4/wAxg72FlnWdsuqlowyPIlyjUH+kVrQIRsmGGMLU169kQXCeVVjwX6BYueZmCqoBbITQUE94PAMgyzA/Sm0bJ6uc7ZYicbEL5NL49gaeLnyRENP6O5m4l1fpZz63oYzBXvMk9EEPMN1xDWw3c7E6b8eWUbE7Vf97O+fN4l8XDYm6JARCGgTUEGfZdjTaRsU8F3J033RYsS/V6MLvb7R8ZQbpIVhFccmtc1PUFfT2UHjnBnG1U1/L6WnBMMbAt9kgtBa/2oUHqx/BJm54lY02rfe7hbO8iLsEQAfYxwYyIlmA9t3GfGXEGja9JBwI9ksLwFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlJlbnVURXVEM1QzaUlJWGJ4cVljN0NTeWRad0NxcDFLeEwxUWR5UHh5WjRp?=
 =?utf-8?B?RFNyYUd4cll0T0V4L2h4SmpMRmY0RVR4Vm5NcHFYWUVveUNoM3dUZUZVeVhY?=
 =?utf-8?B?M2RXcWJJMFVjc3NieC9FVEIwajY5SE5lNUp2dU9xVDBRdkpPRmRoTmk5bWVG?=
 =?utf-8?B?RGwzWk55TlE4cEhvUjNqRWtGcEFKdU5LWVM4UENvYVRXMFQxL1R0OGtPd3dP?=
 =?utf-8?B?TjdTbC9sTW0xSkgxR3V3enVYbmh3MjBtNnV5RFBLblBpamFlRk4rK1lGUDJV?=
 =?utf-8?B?ZEtiMEMzMHpObENGTWFBbWhNYXM1Um9TajdIbXpPZHRscXRwL2FFZ3FKNitZ?=
 =?utf-8?B?Z0JYc2hGNkNZRlBYbVdVT0ZFS2pTM1RNUjlsdUR2L0NBS3d0M3I5blJ4THNm?=
 =?utf-8?B?NHRJTmkxVVZYSHNCUDVHNnVHcTVHSE1wdlhSUS9zKzNJNlZ6TWI2UHNaOEp5?=
 =?utf-8?B?VU5PUmlhRXNyZEJBd1pWWHN5TmlEWjVuZFluamgxWmNWanNKdE1qOWFqdGlU?=
 =?utf-8?B?cGVhS01WNzMvbDhRazNmM0ZIOTloWVZ6SnViSEsyWVZzb1BhaEttdDVFVDFr?=
 =?utf-8?B?elgvLzdUdzEzbUlZVTVoUE9OU3BWaXJFL1JUbjBGclc4Z0wrMEdsb2ZJUXdy?=
 =?utf-8?B?aDQwSy9RR1VhWDJPdWc4aDF1RUZTZEkxUzFoanZPU0NrckdJVENWWkRPNnAv?=
 =?utf-8?B?b0NXOWlMWDhXNi9FckcySlZyekF5WXQ3RjNvMEloUnZUK0lDcFJvQ1NCd2l1?=
 =?utf-8?B?Q2pXM3JXSTU5N1cyUmtma1N5aGovdStlUW5LdVJNQjZpNTdLWEl0WGNuUFAx?=
 =?utf-8?B?dFJiRTdKKzFETXM2OUFaNUZ2NFdaUlA2ZlRYcitBOWszd3g2cFc0Zlp5cWk3?=
 =?utf-8?B?Yjh0QXJIWnNCSjAybWV4bzQyYVFaK2M5aEtDUnhzM3UyNDJGbXFtY2xLbjcw?=
 =?utf-8?B?ZXRhV2M1Zk85RVF6dldzRU95aFY1N3lIOVI2bVpSV1FqVFYyOUY2RnJOUSt4?=
 =?utf-8?B?bDU5QVpyVlVSdndZMW1SUDBGbHhEVTlzUUdKajVudGlSL3lnMHZWNUJGK2w0?=
 =?utf-8?B?RUJPenQyQUg1c3pTL2xJNFY5bFB1ZVY2amVMOHdZN2xXbnBZaDlMNUE3MFdP?=
 =?utf-8?B?QVdhVjcyd0R4Yk5qblJPVGx2U09VSmhzYVplbGNEbno3b3pmM3VWMDBmUUlu?=
 =?utf-8?B?VUJTM2F2QWc5SEpUelNGcW1mSlBvYjFsZnFZUmd2V2I1UEo1M3FuSUwxeE11?=
 =?utf-8?B?QzROays5dmp0TXNiM3RFVGxXUnM1Wlpzd3VsL3VUcVhJVW1DTWdCZ2Y2RFQw?=
 =?utf-8?B?SENZSGo0ajBTaTYvQXdFNzV3M3pBOC9zTGxEQU9pNjlTdmZCR1g3UWVRNWsx?=
 =?utf-8?B?bWlNRktkZFhIRFJYUnlIdVMrcXNjd2haTEo4NmZrdEFjM1BiQk5NM1EyZHdQ?=
 =?utf-8?B?VFFpK2p4dFowSWFGTTZYeVZFaS9lZS9PUzE0eEMwNEc1TXBlVzFCOGRNeGk4?=
 =?utf-8?B?RDg1aTBWMHF6dXIyY08zRDcvUmhFQjQxYjJpVzdlLyszSk1Mc2QyTk10ckRy?=
 =?utf-8?B?R3JUU3NnTDk0T0FkNEsvUmk5c0hFTUpSZXJnWTYxRWNZZjNlZGx5MjY4NDYr?=
 =?utf-8?B?RWlDakZaN0M0bm1yMFA1bHRBY1k0KzVWOHI3ekx5dHZzd0xiVnRmeWY5ZXdX?=
 =?utf-8?B?SmVFS044blpQaUVYcjdwcit5WEZpbHBKL3d0bWU0dkZVaWJqRHF1OGlFMFBh?=
 =?utf-8?B?elM4WG1PbHVNcU9zbFFVNHJiaXU2RURRS2JwU0ZTQ2VpZE9mVGVRSGpoL2dM?=
 =?utf-8?B?em4rMXZGdzdzckU0STVsdTdHb2Z3RmxCVTV2b0owYXoxOTVEa1NmdTNja0wv?=
 =?utf-8?B?bXFLM1VHTzZucytERjhhbVE2b1dIOHI0R0MySjdkOEtqL0JVcUJOVTA1dkZw?=
 =?utf-8?B?OHNZSGFpWW5zbk4yc3JJbENTeFg4SGZLOUJsNnVNU2RLQlNvM1dNVjVaV2p0?=
 =?utf-8?B?VmpaRmhCZU9kYm5nQWQxazlnWUdrd3NGRm5IM29hYmh3ckV2WFFEazUyK0p4?=
 =?utf-8?B?aU1LakFNa0FJSFg3S1E2UzhCNWxKRUxJdDZWWGVTeDBRTElLQVBkM1JFRHJT?=
 =?utf-8?B?QnZ0MkZzUndDU1QxWjA3aWRNVC9TL2JQVEdvdjlqNytNOEg1ZXVVdVhlb3hk?=
 =?utf-8?B?djZGc0xpU2owUVJjdGhQZEJwa2xyaXVxWi9TUDc5R3BrYjJDZEkyZWZaWDhN?=
 =?utf-8?B?cEpWS3gwSEMxOTdwQVBvWUI3N3ZEUzk0S3ZBcGVTaUhCR2dnRmxJZWdJKyt1?=
 =?utf-8?B?dG5HUGZVT0cwWjFPcjk0VURwdTdaMXVQbGNWeGVmZytpVkJoNjRxZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df13a71b-5463-45fb-647d-08de8b026a95
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:39:23.9427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94j0vyUDpQunDZQujQdmvsb8WYL4THZRmbdAW5fHPAIZKc6X40QdTIy9Y/+dtQB92qJVR/HkdJ7A4XeLa66JOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11300
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

On Fri, Mar 20, 2026 at 11:46:12AM +0100, Luca Ceresoli wrote:
> Putting the remote device_node reference requires a of_node_put(ep) in both

s/of_node_put(ep)/of_node_put(remote)/

> error return points.

Should be cleanup points instead?

> Use a cleanup action to simplify the code.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> index 47da1d9336b9..756ca96373c8 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -53,16 +53,13 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>  	int ret;
>  
>  	for_each_endpoint_of_node(dev->of_node, ep) {
> -		struct device_node *remote;
> +		struct device_node *remote __free(drm_bridge_put) =

s/drm_bridge_put/device_node/, though I know you've already realized the
mistake in a separate reply.

With the above comments addressed:
Reviewed-by: Liu Ying <victor.liu@nxp.com>

> +			of_graph_get_remote_port_parent(ep);
>  		struct of_endpoint of_ep;
>  		struct drm_encoder *encoder;
>  
> -		remote = of_graph_get_remote_port_parent(ep);
> -		if (!of_device_is_available(remote)) {
> -			of_node_put(remote);
> +		if (!of_device_is_available(remote))
>  			continue;
> -		}
> -		of_node_put(remote);
>  
>  		ret = of_graph_parse_endpoint(ep, &of_ep);
>  		if (ret < 0) {
> 

-- 
Regards,
Liu Ying
