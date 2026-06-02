Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DAECD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31D910EC91;
	Tue,  2 Jun 2026 07:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sEyr3UyR";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFB910EC91
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4BdhPhEmZIIWvfb4k20l3BzooPxY+edFmv84ZQHTwXcBXHVzQcqUOowE3TM8jhqXbQ1DOFAIqlIPg18YKpC0o2zurxk735kNhqwf1YqtSZ4b1tp0p/kA1Os2UXr5rZkSuDqcxKj4313iPdlC27AMFoZqPgL998sFIKWNstoOMyPwbw0jh8eGruAYuRPge4nAyG0ZPPSxDSJ25IPEC1fOGsNiZrEZET4cKTyVVxtEhBlKNyQXbkzKSKQ7kK6QAmYcqSiHQXNh4i1npijJUeM78QYsVP2w5wkBpxyf6UJ1a4oG1sQCw26c5Zkfh+HTz6wTLJ2UO6pzWSghofSzp/+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU0Wpltx3VpSxMzo0TcyvwSF8ZBYZHheiDrIdv9g9Ug=;
 b=rnkdlIu46WqsFPFrbqfm3E8t97VZJ0jr29NkPr2NZvFZy3yu2MMeUJCMrjEPABJowTzmI7reexbgF3nlynoVG7VUgODgTQDJgd4L6MZGG0U6gtqLcz2bGmZ3XLs/ZBUhLOQ3eAygq4apovntnsmASs46rgFnOFH2TYBknYoHrmqd9hAMvgaZO7bb3+OpbFIR8blsKj6+TNF0MXOgt8ds4dLSQZu70OAUF7FhInF//r2H+UqPwfj3+Ocy+KDHuTsI//r2PbXfysg076JpXV6wGpF9qXHELelFN51eXddtr7u2NH6wGVt+ShIIH1z8xy4KQpiOHLo1Y5kz14rNt+bVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU0Wpltx3VpSxMzo0TcyvwSF8ZBYZHheiDrIdv9g9Ug=;
 b=sEyr3UyRbGmDyeYVK5CCl2hEpomNxyqZQMHkOfsyHYjuG3n2uCF0beDJx+b2Hl0T5OyN5nskvtJHr5ei6SfwPhJP8Xm0BA6z54J5xkM1jiEJ/luQ7G0P1gg1xlx+uU2A+y6bFUJW9i15h8VS3xwytxQwNUtir+3iCcvUiZTr0m9HHYWsobmK7dXQUS55xCXMQQw4+MWLzqKubvnLZxv7/TkQcDLedTS+KBd7xbqcKFkJEB/U21v1tLB3sy0GJfSsAbprYQiDKO37xes34EE5JULqp1TzAjUL4tKIOOjPK4J6dBnNpVTtjxfAA0PvkmW5M5/1O9J5dTWgF+b06xqkcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by PA6PR04MB11872.eurprd04.prod.outlook.com
 (2603:10a6:102:518::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 07:18:41 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 07:18:41 +0000
Date: Tue, 2 Jun 2026 10:18:35 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Lucas Stach <l.stach@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/imx/dcss: add missing kernel-doc parameters for
 scaler functions
Message-ID: <rjx5f3hwi34s7vzoibo74e7ih5yskuj3y4fmejqyy575yshlk7@aj64vn2dxalr>
References: <20260530195925.5477-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530195925.5477-1-rosenp@gmail.com>
X-ClientProxiedBy: FR4P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::18) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|PA6PR04MB11872:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be47786-fb20-464e-f253-08dec0772c3e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|7416014|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: v+2zIRD1iNORS0sO3Zt3l7L+DBISvdVVpH8F/s/LYSSeClrDjUyEjM12/LAoVoj1/EowELQXNuI+zmg/DVhV2DejwOrXY1KtM62dNC5HrNnZhye7ANXGLRpUf+NOASJhUxztPPxFMhBRnNJHxZCW1avBMD2m1u+/7CtRATYP3xuDr7vL7V7dM5pEif/9lDsJlfBLmneQo1X0eDSFqvVdWei1w4Qu4lr54uQXUqKyRuIr1TlMzev26OOgp+ZKbWmpN36akz7cmjpNwQi795oOlm4A2QjP7V/EbHFaheqcD2IvlqWG8i8BAyjs1lYfyMa0IdTDX/d3hgbjC8E23/V6wJOh7ckoHgIM2SOrycjV+GLxa94r7pUSUgUt0t2gqVKJlK3MMxL29cX7YsuWTzdf1DTjW2L4WTDd9VWxmfelZ0uFB1JsP9FdaQfllwHM7cyO1rSrjPjiu3GshDMaKuaPLDFfpdrJosdJZoLpjc6JKitrPYamz9miNegoj9/+vC0erfVpaknIRwfvFKTa+8ZJ31fbu6Uvb9dLGKqOsCpkPjb+CGZSw/lHJ8m1G5G6k1WrJLuZE9DCW7VPyjFtoxe66BJpdZ3qTaHjMMKin52/WxvR/AArQSdtoC1MZnWSpFuCHR+YShLyLvsj9kH5hpL198ZaRsY9wTqfHCXkdptm18pvdfopgcn9Yj4tXAwbKTel6vryAo2/jr+WRI9oGntEtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UeQtqwttM6WKwmWrc3+zU84Y+F0v60bUVKXb+5f7b/2t0QlMuHihAlpjPFQ1?=
 =?us-ascii?Q?a1NzHnKpHfgV3X+FIdZ/Xb7yfYTyq6i8AU60xrb10E27jvfWUw0x/WVqwLb9?=
 =?us-ascii?Q?25BOjL9xGwGIN0RuiTTmfJZheaT0aizIymh+jHXifYf+ts2kHk7ukuYTpQIT?=
 =?us-ascii?Q?Fx2QQIN2diOWfLPS5igvf+WabCESG2629o99DZ6k9tue8Xr/jRlrEj7PsQ14?=
 =?us-ascii?Q?VJXLjCyPSopNM5bNQTAm0Nfj7GDbN3AIAjo3upHq6908Stc6lV3sOZL2+4Kk?=
 =?us-ascii?Q?UjZXts0jSnmdxFmHUd4GrePA1m4vPgxGfaxbSshUpbxFLEucOK3EFgduiT3y?=
 =?us-ascii?Q?FU3tbXLhMuvW2zSjlO+u8yeunYyH07CfbSbg9TiKK4VXUgxNa4IfPgKGTTMY?=
 =?us-ascii?Q?dDHKsfTVZJAbXdZqVjhqyI8yo02kXtDdPEHuGA9oR+/vHRwGUYGqVYJLYdHD?=
 =?us-ascii?Q?OtUcmqqASoZdQ0Px4QD8d+jEVaXtNXaP6Saj4nR0YCoOT4Scg79aLHkmWp7u?=
 =?us-ascii?Q?FUYhX99mJkYTByovCmfIfx1SD6YMO1KA/bL0F8OFtYK4IgJY5LTP7g2/cQu7?=
 =?us-ascii?Q?u0JhtGZxPOfrskJRQXiIfe+1ZbZnE58hTXDV6y4t3dQ02PHyevBriMm4Nk75?=
 =?us-ascii?Q?cnQR41nSn0WS9zVwzE20udnvsqSbA47VUO6j00SSnehfgplcG5gc9+cTmQkH?=
 =?us-ascii?Q?Wvhgqzmp28GH5L/Itd41nsI1TsoGOoFog3DUjXWlfpuKqjy4RPv/tom2NulL?=
 =?us-ascii?Q?6ls3Qw/Oxp8j+d2lSHR1qefDVbrD7KdH0US8u4Cf5G/ICw5yT6rpVLInqsG/?=
 =?us-ascii?Q?fYgB4f7VuL8aWSwuqt8PJzKMOc2u0H9ifx8byRDjtT9dR/JUKyJLsFeqUCCg?=
 =?us-ascii?Q?q1uNB3qWdUr1Lux6bjvKUCUCNitYzPuDh1aLkn/879E9TX4rF+Es4RvDz/SA?=
 =?us-ascii?Q?sUt55B/83D4J/035jhJjZpN1nrfQvgi+33Ac/zsmakm4OCvfp3A2nBaqp8CY?=
 =?us-ascii?Q?jja0hAA6av5UsjTyTzrF5dojupVBzg9Km7cIwpDtKBne6naMc9NOw8IJjV+w?=
 =?us-ascii?Q?x1P11YdZWcn8lRE8yGY5hC04S+v/3QrVvSAFAy9CVuimcAxD2OSBDyXyBXOI?=
 =?us-ascii?Q?gKktJxYBddfO/xzRpuuY5BeeDufY2es3pbbKq1TiqyDNc0iRHhVInQRpIAwX?=
 =?us-ascii?Q?3cetip1ClqBcRWI5WcE2DGaDwZfZ1ZFQORcKVoAF/MHzc9kRb8CQRcCfjQ6q?=
 =?us-ascii?Q?+EWtlBrkCqAC1CY+lvE83aKC9/rO7pLQZMQZhj8Bw/6z2pciecQL6g+MIvv5?=
 =?us-ascii?Q?aM2gKGI5HY3IdoDmpxJilIlNrWaog1KYk2pfY76P1sTIfrvWdpMQqbBEVOSR?=
 =?us-ascii?Q?U2/YJXJQjrEjmtnX8dJkxjDhAvXSWTyk+oOoQZcEHu6VugpXUy6c64UEhWUk?=
 =?us-ascii?Q?1pcUUMyG8EzoC+RvffEVkN32G0DLrsGv3V8oTWKIFsPIzxAMPRv5lgiHTSJ6?=
 =?us-ascii?Q?grbqPSwLzTj6Tgo5XYhIA6J9iTHUtmIMnCN2vFMO0zoXL1E3sm+gS/c8dJLD?=
 =?us-ascii?Q?SxlkxBa3dafMFAVdoBi7kNBRmXJKwsZIShT3OcSSHoKyDfE60tMj4SWOs68d?=
 =?us-ascii?Q?9Ym79B6EacQd348fA773oBZ5M6NEZ40LvZeSDPesQC8R+rCXlD5j+1c8HBtN?=
 =?us-ascii?Q?9hbluV4q3C5Qsw2Nl3cluL3IXX8uvYM9sKxBFHIf7jr4gzWI52LEAScwTz7t?=
 =?us-ascii?Q?9spv1yRuJs4UnHrlqsLHVai6BeSG1xM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be47786-fb20-464e-f253-08dec0772c3e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:18:41.2954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Fo/3ZyKZyVE3M2NpKRZIYli8WMZ+i8/ZFho6h4/MdN2bODLkTzdEUSoqqymw9WHUAYmisD1L0xW4YEGOjwwAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11872
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

Hi,

There was already a fix sent for this:
https://lore.kernel.org/all/20260406180013.2442096-1-yiconghui@gmail.com/

On Sat, May 30, 2026 at 12:59:25PM -0700, Rosen Penev wrote:
> dcss_scaler_gaussian_filter() was missing @phase0_identity and
> dcss_scaler_filter_design() was missing @phase0_identity and
> @nn_interpolation in their kernel-doc comments.
> 
> Assisted-by: Opencode:Big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/gpu/drm/imx/dcss/dcss-scaler.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-scaler.c b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> index 32c3f46b21da..e48b3117efb9 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> @@ -166,6 +166,7 @@ static int exp_approx_q(int x)
>   * dcss_scaler_gaussian_filter() - Generate gaussian prototype filter.
>   * @fc_q: fixed-point cutoff frequency normalized to range [0, 1]
>   * @use_5_taps: indicates whether to use 5 taps or 7 taps
> + * @phase0_identity: use identity filter for phase 0
>   * @coef: output filter coefficients
>   */
>  static void dcss_scaler_gaussian_filter(int fc_q, bool use_5_taps,
> @@ -262,7 +263,9 @@ static void dcss_scaler_nearest_neighbor_filter(bool use_5_taps,
>   * @src_length: length of input
>   * @dst_length: length of output
>   * @use_5_taps: 0 for 7 taps per phase, 1 for 5 taps
> + * @phase0_identity: use identity filter for phase 0
>   * @coef: output coefficients
> + * @nn_interpolation: use nearest neighbor interpolation
>   */
>  static void dcss_scaler_filter_design(int src_length, int dst_length,
>  				      bool use_5_taps, bool phase0_identity,
> --
> 2.54.0
> 

-- 
Thanks,
Laurentiu
