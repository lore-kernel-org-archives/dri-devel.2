Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E42C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B750410F328;
	Fri, 24 Jul 2026 08:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MlcVgs3A";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E155510F328
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryVjdQoPYOyv8mW109OGB9cee1tb6kH419a7aR/HpptuxWrWypRbBPmVcxEv7i23F0FpqwDgkzgEd6tcv6ILspkeLcdUOinxDs0BTEKm6V92aIj+fpkSg1cgAoTR3suhPtTxRN8PAXwuifBdHlH3UQOE+p7OB0cIGJNqwIFIbqAkmSLEdattiuJIDjTJdBB2lkOsrsudYlLVZIs8TLoCuKTr2mVSN3ID07WZCTWz00J7F9LyChNfOUDiDibdIYHNbJ+7Tu5JMxtjvvn+k3IhzfCfQi2M/AbtDNdpnd7+RMG+CTn+B6dYoAgHOTM5YS2z8WZ9qO3wFAtf8pkUfkMn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK+cM4BNEoqgdvrL/bbIvZMO9dQn9vVkKWJyVNWi4JI=;
 b=Lu2NQJwx6BH9k3ZF+yi1fXSJAmS0nkzfk8/OsUIN/rO0IWDuZfRUuZD/nHJ/i12HeCrnQB/AzlsFHtuRCcxwLcH1/Bcc6PjjV5UQDHAv3kwYOwNW454vFlVODmGqDCWoYtvWFH5JNDzhz2U0JoV1RBEa5ZkLC2T3VrEDae8lN/Rhtu6NMD2V/Y+BWrEej91yN4q/Ib1e7L824cq1w7KghTjh4omMYY7bJ6hjAEHQIykLsEQr8XSA5AlHY8UKdiR8GRfeI9vqegJNXDCO65WeQNZqRCVK5O6RjFUnNBDL4UnrrmB6T4I9ARgsV9I10pm9F2YlKhhsQDeFxOY8dRtcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NK+cM4BNEoqgdvrL/bbIvZMO9dQn9vVkKWJyVNWi4JI=;
 b=MlcVgs3A7Ty0Prnf3tkBzphP3/8SKfsQJw5RemxboEPSqwwCrA4kmELweLQsc02oHUtOvz7v6XQJxQ/DUVM/5npJQj2dwH7s9MNjufwwezqJP/9A5FXvOvB27LafNnJay+VqO3GMSC3oia/t644DWlF3pRrfDKQj3D4O8aJQ/0mgZkEGUR15Vx7Z//eYIzjLast5LhxuHfz+rr1EvzfuRmiKpQDxBla0Os58DMVlBUFFDROLezQDD7NGd0JB1A/KbaTrw/1DRweSjxE9hH0DBWSIH+H3kbt3w7goYiDDCBP9MTOb1U7R712pMaPq+5lUJGN8uV6XpPU2lg3nQey/lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by VI0PR04MB11940.eurprd04.prod.outlook.com
 (2603:10a6:800:307::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 08:08:12 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 08:08:12 +0000
Date: Fri, 24 Jul 2026 11:08:06 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: festevam@gmail.com, m.felsch@pengutronix.de, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13] drm/bridge: imx: Add i.MX93 parallel display format
 configuration support
Message-ID: <gvp7mfhjpgon6hju37ebswo5fjkdzio5lqgcdkhq25zfidayj5@kenuryj2sg3s>
References: <20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com>
X-ClientProxiedBy: AM9P195CA0016.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::21) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|VI0PR04MB11940:EE_
X-MS-Office365-Filtering-Correlation-Id: 008824f1-93a0-4a18-6398-08dee95ab455
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|376014|7416014|366016|56012099006|10067099003|18002099003|22082099003|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: abq30PL+eaG4AKoTH5+NFoJpzpIYbhjGCvy7H+Nl26DihRhbbqTx2PyP6bOR6Z7ALsLCL9H9VL2Bztaj7+pBxtMhGSHqMsVY6yOJdTNGkFjmvoPUo2PgfFgqM8mACq8ZEno0uDq/E6lG6Hx0kOoyrc91yYlGrOPgWkxw38hY9y0aGeK1SSzWCwWlB7Fzu1siNZ0wdZzCeVyUMNb1VU2hNLR/GUlr6kAKbwi9K/bSs8kTcWrfRkigFERRl++Pk2KquYaxos5clgnqU5+Xfwg6XeLhdAsDSzjjjqdltodiSpJ2CVvPwWRDfRV2LDweOIfdVfgZjupmbpBG+C0gcXV9EpajL69LAR4jWCa0+ZZObfToBEsRxKxKq0AbutqnB2snjh5antzTP9lmce72ejLm2EE/b5tc6uIDcOhf/d9qEAdC13C6rWXOlZTjJe67xFF16AoAIFIhjUjdaf/zGNEj0mLZa0Az54ClsehO6LR23qfrhbMhTPyZ3cucMCTDL/55RpbYY/PGC/GPn+Za87UKCNbKbKUXlagYI5U836PdTUPJZQFbDaiTKqiKfHc8LFAkA1GbyKlpjklLQ+lGLG0tXgfD+vn4trdSwGkw7LQWu680zCYla9PKu2fK4zNL40VZs7G+Am1XmtavRxP5I6AN95qE4/g98cG1hMfc7JuJkvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ijBxzvpfUmRbenI7hzH1G4NcSa/8DsxfDWg4NK9+b+F6DNG8YQcEsL6mVlW8?=
 =?us-ascii?Q?DndIHBdiSs5zU6E+v9LH1nl8R7MFVLIskomqlSudtQ4wSq3pNJc/LOmgdaYf?=
 =?us-ascii?Q?1BV7ZJjpysRMi6Bdhy6a3KJFltVXItqYMl2OQbQFzsmPSE8vY5XOPdBVidB7?=
 =?us-ascii?Q?26bj+aiTmdnJ+nzoqgbBtzq2tXQiLUJmQpzIj6+y3kQqRdXxxBNOAsmk2hSN?=
 =?us-ascii?Q?P/ONQ/wGEjSYVyU1Mrw//7KVcrRMG8npJ3b4+aHyk028e5AUUitQ3ttJg6nn?=
 =?us-ascii?Q?Tnl/RW0SvgPLAnRYwnf3So1eQ5qubciZAxOEpOB9Tgte9qpuEyXleXdYZJGm?=
 =?us-ascii?Q?AeiqrmvE3rS3SXlxsnGEEeuZOK7jz6uzxfEHjXLAWtnva3klAk5tz8UhCUre?=
 =?us-ascii?Q?81DbFzC8t2oGlSdjXXkxWhIHtc7xvMeZFjRBVWnjXy2rGLUOy31LbZ9VLFsL?=
 =?us-ascii?Q?Mm+04gqyA8UW5uR9132ajTnQphVRnMjNC9/ui/IoKcrXCeph/GdGrKfKmyQy?=
 =?us-ascii?Q?9C2o6jvrrTDTiuEg6M8Sv6NNgI4houZ2iFiBZMPUjmj0OouAWEnH+p5B9Sd5?=
 =?us-ascii?Q?ne1QfAW6pmrhtTWKSo5NUeNZIJ68iWwjhbU+tjvxjCPP12oe3NcComYQpEKc?=
 =?us-ascii?Q?eANOthF38bXoUu0m1C9OGpDZN8B5ba+23PKL3N5rSNpUqLDinVhA+G4Eo/qw?=
 =?us-ascii?Q?X117A2uerpR44qt+JOZ2o4Lnzav5NLs2SBZ06TWaebDTgxyLB/2E5gKDd342?=
 =?us-ascii?Q?w5pqf2YDHKigSDd341lMOROpmOjh4CotGNeMJ/QjPUl0q8oxXMVXch/0QEad?=
 =?us-ascii?Q?v6cSg/EvRh2hx4IvUnkp/B1dtuB6UkLtOcNCc59Ylu+us4eEqhf60n9dRECo?=
 =?us-ascii?Q?DjDl9a099Jw49u4U7Ma2L8ZZcLcdhzaoGGUSbxZ3/nUbhU84AK7XSZlJTSrs?=
 =?us-ascii?Q?NtsBvRyLtXDjU27wWKeFJcS1vQRKsSM/X/1LHZ/tETsgj3boOrt6YYz/eiSy?=
 =?us-ascii?Q?FJ+2UYXjGUV61/xUYRjboYkqTOV+lq2NhyP7prOZLsMvrjsCttF0bMf4nvZR?=
 =?us-ascii?Q?inLWkA9gPOHoC8jC0ttDIRkkUW6BZsqrJmDSlMVWpMmKtXReNBndcLQlDuXg?=
 =?us-ascii?Q?td93chicgWlBpNfxIUFbGeEFNzmE1YGCeyeMriDbW4O/Q1M85vdlqA4XPFJ1?=
 =?us-ascii?Q?wSFhM0zdNJCa4mgsKYM+OTp1ineqWNe/DWCuWKpj4Id/9G8q+sO2jWW/90Hw?=
 =?us-ascii?Q?g+qF/JrPeLwos7g/gGk3+bOhUrX6mqkJacmM+mJf/b6yVcTT8seY41fHLPXK?=
 =?us-ascii?Q?2Tgc1sHH9GAPgxZfrdN8v/lTxoC2lljGbuxzDXM9oqGYYhcXlN9LNCIrThXP?=
 =?us-ascii?Q?XOWpsDTf4tEqQ0Gu05hpuZniSckHryVe0eUn2dx6eDchKu6ND/sf8w9nZsDS?=
 =?us-ascii?Q?Xr69lMrU/SYLbIt0xuwQZ+3fGHw1USVF3PSO8vVYYj5rsiFC8ZyE73mbLGt7?=
 =?us-ascii?Q?MJhXiSvRjAVGPX/WGRMdfYXEmuwSF6fTqh1QaBTPawrAcTv38afEn5VNG2ge?=
 =?us-ascii?Q?01m9qigB0Lu8XSXkJ13BilWb+/8WUG7oTBXI+9p0xthUUa7PQvLoTPVsR09F?=
 =?us-ascii?Q?V14QkLh1AeEhw7BiBnUQXe/O2CnWuR4eUZ3bQpnDyrTko6gpOiK7Au8PkPyC?=
 =?us-ascii?Q?gLxjgxGq0ISZ2tL2WNgPLTEYw54AG7PTj4r3UVQOTzcUXS2E/7X5XqVz/kLN?=
 =?us-ascii?Q?paxfdjzI0+8tJjwCPoOY8QBNZWcTPuE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008824f1-93a0-4a18-6398-08dee95ab455
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 08:08:11.9180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: io9qR6ftCs37bun6F3wNLW2Ywn+q/ulSR0ylPf2lZgrb0ZUc1ynQ6M/u9fyOkshpKj2kNxUcbNUJ53yNJA5g2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11940
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

Hi Ying,

On Thu, Jul 23, 2026 at 02:37:32PM +0800, Liu Ying wrote:
> NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
> configures parallel display format by using the "PARALLEL_DISP_FORMAT"
> field. Add a DRM bridge driver to support the display format configuration.
> 
> [m.felsch@pengutronix.de: port to v7.0-rc1]
> [m.felsch@pengutronix.de: add review feedback (Alexander)]
> [m.felsch@pengutronix.de: fix to short Kconfig description (checkpath)]
> [m.felsch@pengutronix.de: use "GPL" instead of "GPL v2" (checkpatch)]
> [m.felsch@pengutronix.de: add bus-width support]
> [ Liu Ying: Port to drm-misc/drm-misc-next(v7.2-rc2 based) ]
> [ Liu Ying: Add nxp,imx91-pdfc compatible string ]
> [ Liu Ying: Call drm_bridge_get() for next_bridge ]
> [ Liu Ying: Reject unsupported output bus fmt in .atomic_get_input_bus_fmts() ]
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---

[...]

> +static void imx93_pdfc_bridge_atomic_enable(struct drm_bridge *bridge,
> +					    struct drm_atomic_commit *state)
> +{
> +	struct imx93_pdfc *pdfc = bridge_to_imx93_pdfc(bridge);
> +	const struct drm_bridge_state *bridge_state;
> +	unsigned int mask = PARALLEL_DISP_FORMAT;
> +	unsigned int val;
> +
> +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> +
> +	switch (bridge_state->output_bus_cfg.format) {
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +	case MEDIA_BUS_FMT_FIXED:
> +		val = FORMAT_RGB888_TO_RGB888;
> +		if (pdfc->phy_bus_width == 18) {
> +			/*
> +			 * Can be valid if physical bus limitation exists,
> +			 * therefore use dev_dbg().
> +			 */
> +			dev_dbg(pdfc->dev, "Truncate two LSBs from each color\n");
> +			val = FORMAT_RGB888_TO_RGB666;
> +		}
> +		break;
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +		val = FORMAT_RGB888_TO_RGB666;
> +		break;
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +		val = FORMAT_RGB565_TO_RGB565;
> +		break;
> +	}
> +
> +	regmap_update_bits(pdfc->regmap, IMX93_DISPLAY_MUX_REG, mask, val);

Apparently, the 'mask' variable is only used in this call, nowhere else. Why
not use PARALLEL_DISP_FORMAT macro directly here instead of declaring a
variable just for that?

Otherwise,
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
