Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27594CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5F610F067;
	Tue, 29 Sep 2026 19:17:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="U+zQnG+1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E9C310F067;
 Tue, 29 Sep 2026 19:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx/6QB0vZBMP/L6Bg2sHywHV05hZ5cvhCnnYXbt7Lj0w/fOajznjQxUrdD7v2aKlpeZi5wb3A5n3sp/th/gqKmldcBOMILvU+Neo4mqKQt8kgMg68B+Wq9TdFv5bGgBBo7pRjiKpS7onKF1ylA70ndkK+kweekAFOV4huw/DVxWIH+YoRmG88f+jC/LKq3e17aWXvJ7cWfT4rgXnN0d4vYWkeklfK9wvLPA9s2chxRt4AwpGUiI/UDl64UzVv5o0yQkY4L6hiS1hedEFuG0U0wFEYFIZwvf7K2MVzxdqfDJ6azaKfFSyPrcHMcUrVyG7MaZtv4GYK4NM31dJCtGSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4O03XvYCn6/SXHU97qsTuLYimMdGLLJY6ENefQb1Os=;
 b=KJmG41j6yYfyXxT0zCobnc4kTUiNAvvc7kqp8mgICd2SSctl8iewfz9ZvwpnwNkAqIZRt+xg/Nwnzw5wlgxIXa/GWPT72AeeREpyFd2JbVQ/rPo/CxxHzE6LZKfOitatHMWWi8DL45o4vapR4N6ysaCgEpZrECSJAwFoQI+cdmX4G8LJnCUfxJ+usHveijCx+tcEhEChVm5JlP3bmHhR1j6KHZSSexA/vCb9OnR27nDRBgBZ5Bv11qTLABuW1k1Mnd7zcbWDy47CnwCr8naheXukcG8dPrCThTgKGc+IBAf442QO6fq7DSDS5dzsvrJWtm5rBNo/y4WRsHY5L3F+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4O03XvYCn6/SXHU97qsTuLYimMdGLLJY6ENefQb1Os=;
 b=U+zQnG+1DYW1jeggDQZa5/FIv0TLBwVk7INK2MuCUgROmFAms0L81MULwMw+44X+7eI679C2HuZfKtLJZ4YwJNNZ1y01Pi6FGnggOzeP2CQjZRlMqTV73zwsxMy8LlIAOeFHZN+3sKmnV9tQ6PiHfNNGRZjg9XwEQrZBd626wBEOBhLuPW7qjsJ9saqZ8uY0zY8stkJAIfsKRkam5yA5zs6gFx9uYqRQ1KlhhmlEWFnmSeOCDCCU4ANZkzMkmTjmyp2PtmPsuvs+dfKGE8o3TaaqMyWIidyAT5WcOwKPQQi2rbIjL27hL23biwyIXnxbSTBYIllI8nimRyFqGoJ6vQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) by
 CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.25; Tue, 29 Sep 2026 19:17:07 +0000
Received: from DM6PR12MB4925.namprd12.prod.outlook.com
 ([fe80::9ac7:5274:235:5d72]) by DM6PR12MB4925.namprd12.prod.outlook.com
 ([fe80::9ac7:5274:235:5d72%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 19:17:07 +0000
Date: Tue, 29 Sep 2026 14:16:57 -0500 (CDT)
From: Vidith Madhu <vmadhu@nvidia.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
In-Reply-To: <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
Message-ID: <1b722d71-93d2-93a4-acdd-bc02b9a36f95@nvidia.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BL1P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::23) To DM6PR12MB4925.namprd12.prod.outlook.com
 (2603:10b6:5:1b7::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4925:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: a4018eff-47c1-4738-c006-08df1e5e3c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|366016|22082099003|18002099003|4143699003|3023799007|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: NV8n9sJRM8XxtoFVnGVWgoJYODFzuMwyxQQb2qDVFyiBU7tzK5Zou12nRmwpApIObdhdfpjX30EW1YVnAMzFcxk/CymQff3mTz1LVhDyNvIcjHRs6Va1NW6M+3hcUrXtCqoZ9KY0zsye+a4fhCxn3+8fv3g2h7ZhKcGhp/ijIExh2z4Ad93qHylGEQ0S3PFwcbe0ML3GjYdvIovVDQHqPCyebHIq7LZOQEeyjFNa57ulE5Cb01CViSKaZR4T1c23P0ZbZsClzoyuG/hr9xH1cHwoAPVziFZhvGNrQd75Rez/SuPbToc5liYbWWTYxLPVQ4Fm1sBfzoFNpMOs4KpmcyU+7deH1o5hT2NllenWq+D6e7yNZSlyYR2dFa+08wPcs+kZ/0vaBlNOKPCxT0T3/OPeZsblauGkiHsCkmuoiBcWguxZjpaub9aoynH9ZHSCljwb22E5yMiFKGNrYxkfn4cZrC6kzkfLDnIUfvfB48xeF2cc/w40yoprg0M3DbekYNKBdt45pQelBzLVWejPOgMo7D+Iwo15rvE46GO56c/Owh1dSuRfkJqdQNP4K6sYBlJOnRxYg0C8fz5NFn9+agYSxniUvYIRzUdH2hRApUx7DeA7FB2Tk7bjAH3GVsjFJQstahp1B0D+FNTSSeNQgigzi2eoiNqSiXHS3U7qXB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4925.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(22082099003)(18002099003)(4143699003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewE5WswE4dW8lgkpDIzHRD6KLR0SqniecxhJ8mHXIggsHEa/SUNmeP79UeqP?=
 =?us-ascii?Q?dhVxKMaFnRDKCG+6PIGDYd+PIBOMqCScqjFVqCjKR7t23apSJDQex2wYmU27?=
 =?us-ascii?Q?2668H6V0rfvbescv9qvU1P90ZTbFeBeAuSLS8Fo+qFCnzmDtayZWahTAe56t?=
 =?us-ascii?Q?nkouCHBmaH576hHJWSBDpUr5VNvedLNopBgKXIB/xoE82gUuiBvsCaf6RZO+?=
 =?us-ascii?Q?Hq+giiXkSYAyF+4Lgw9yKe1qaGoay2EpcQAwjMMKhkbQVCgiHUlcW+y3ZQ0u?=
 =?us-ascii?Q?LhfaIpcg+qa3rkUyfUrW+HJLfbfpVDNO5pnypjE10fwHfOH9ACceL306EHBf?=
 =?us-ascii?Q?3QSdP4aceLJ0kkl98ghKowGuHgvM4x30dHvmZXhURJoMU6j7vUqg78/oZMy+?=
 =?us-ascii?Q?o7M6jR0isWiTfl3NKLjaA6FzTOZp1aED0rSxsFH+DHkWAjn4PtZ9MKY/Uizd?=
 =?us-ascii?Q?SoJZVzFFni2DwWfDdrB3+aPSptTzNSJ0+eIoiBdBDw62xYjVPSrWhAPESXTB?=
 =?us-ascii?Q?czr8T5WAU35HGTaNOQIsOKyC+D4HpmcGSffnj3X/TNfDYy8QGIHg+jKMprkJ?=
 =?us-ascii?Q?5V3SjKgUsa8pkVGPsNt2YB2WAhPExKfPL6kWXvz7NSrNfHqrOGQaU+iFpJuv?=
 =?us-ascii?Q?I5+7a5ShqxN6NVqXrbSNTUHySSh6aSjYOxxo83zkkIoSgfR1qx0rSAoR90wm?=
 =?us-ascii?Q?kiiEiYEYxDw4+8ZkDEmx51gn/TPhr7UD6J1NL9dcLWsNIRSsnf7m0cLqlKA1?=
 =?us-ascii?Q?3tVAi0fvlpvREN/T8jmCe49PdksOmkTKXlg0gi8f072PA9UxVYm/KwPoV9ys?=
 =?us-ascii?Q?r/ybs8Wk35/d5na0bQBddBdraxr1fL9hDPT+vfro1qHFIymyD9ZDTWbcaJv7?=
 =?us-ascii?Q?zAGryTj+yQoFwoYGrvrKt7YFnrU0gSf+qJJlhuV/cfykZd0tK4z9Zr84lN4m?=
 =?us-ascii?Q?ng5cpebI6EDBbq4OnvmK9sV03n7O3LU6w7rJtPmb6wZuHBppPiEiCxlMb6vu?=
 =?us-ascii?Q?DYy9c/UKnkfG7kznrTT9X+2eBE3CqX8GVcgMxv9XrEt+2DbID5DEQk+W3fzV?=
 =?us-ascii?Q?o7ZVpOIcwc2VDSlbqaZz2YGMBS52Pqt8u6YNBEGUdgoAGv37rRLS6JLaeGcf?=
 =?us-ascii?Q?86Vw+1k9ZV/ACAQxypKM5hiuel2JeGSyOfUpWhYPYdszsV53myHU/zNS78TP?=
 =?us-ascii?Q?eHGtVQiQ/j2UC0WN9LpqDnDlgYEri9veckG7nLw1A08dywKJL8kSUJ7qLpje?=
 =?us-ascii?Q?re6476NeLrITuFOVnn74yIaMSa4S7r4U5nX1DrqfzfgalpuONWQpMn+Q2Dxq?=
 =?us-ascii?Q?jAjhAytviuYu7iYYOWkw1O7PIGbpkmDfF2oleAwUnzm/Sit+6qtuaPxJtUA5?=
 =?us-ascii?Q?gjzEahhUp0oQOHwj4tCCeq6P4H4Mp5jRCZK6ZwdI5nF01Au1ZnO/ETi1z8ns?=
 =?us-ascii?Q?7ekUQJsDOGjXwRVfDR+bq9Q+FFg0VO2kpMg5bPc9/GKnbA1Y1ScvBvGnAMcW?=
 =?us-ascii?Q?Uy/3+t1Oeo4F0u5hnQIQuczIjJpTbgB/NlwWVl4R+iOcnkNOXLCA8OLthCJm?=
 =?us-ascii?Q?1N93IKLTzmq5L/pwSzmX5gMPOG1riUu1qm94SZwcOY7TLUa4bidIFnXOoger?=
 =?us-ascii?Q?ct1NDZ+ZhggOghRRAzOh+XF6GhbzY5dC58SM+c/yuSTMvr0tlnigpufLJ4UY?=
 =?us-ascii?Q?En3MULQkEYqkHcOj3SsQSNgUklgjOupc4gMUxCV942n9A8pv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4018eff-47c1-4738-c006-08df1e5e3c90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4925.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 19:17:07.5276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zk03WeA6F2ep/LmfdTI3X3A+lDV/4VuIkroOo2Qo5k6GwyqIUQ+vvdWDoPjgtBVvHjGLAY+OF7i6k+APha82uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904
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



On Mon, 21 Sep 2026, Nicolas Frattaroli wrote:

> Userspace may wish to set a target frame rate for the Variable Refresh
> Rate mechanism. There are multiple possible ways such a target could be
> communicated.
> 
> It's desirable for userspace to not only set a fixed target, but a
> target range within which VRR may operate. This is because even if a
> sink advertises a certain range as supported, said range may not be the
> ideal range to use, as numbers on the extreme end of the range may
> induce flickering or other glitches.
My understanding is that flicker may also happen if the refresh rate 
fluctuates significantly within the sinks' range, although I don't know 
how common this is in practice. I would imagine these frame range limits
would also be useful there to "dampen" the fluctuation.
In any case, if we expect userspace to use the frame range limits for the 
purpose of flicker avoidance, it may make sense to expose a read-only 
connector property for whether the display is susceptible to such
flickering. For example, NVIDIA G-SYNC monitors are resilient to this and
it would hinder the user experience to unnecessarily impose such a limit. 
>
> There's four choices to how one bracketing value for the target range
> could be communicated:
> 1. Target frame rate in something like millihertz
> 2. Target frame period in something like usecs
> 3. Target vtotal value
> 4. Target frame rate as a fraction expressed by two integers
> 
> Choice 1 is unpleasant as it would introduce some amount of rounding to
> common broadcast framerates like 24/1.001, which seems minor except that
> exact matches to standard framerates would rely on making all userspace
> and kernel agree on a specific method of rounding. This is sure to go
> wrong, so is disqualified.
> 
> Choice 2 has the same problem as 1, with the added complication that
> the EDID's VRR range is expressed in frames per second, and other HDMI
> features express things in frames per second as well, which would
> require possibly imprecise computations.
> 
> Choice 3 is disqualified as mechanisms other than VRR, such as FVA, may
> also modify the vtotal value. Additionally, it has the same drawbacks of
> choice 2 and 1.
> 
> Choice 4 is therefore what's implemented. The frame rate 24/1.001Hz, for
> example, is expressed as nominator=24000 and denominator=1001. As there
> is both a minimum and a maximum, there are 4 properties in total: two
> numerators, and two denominators. A fixed rate with no variability is
> expressed by setting the minimum fractional and the maximum fractional
> properties to the same value.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 24 +++++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c   | 45 +++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_crtc.c        |  8 +++++++
>  drivers/gpu/drm/drm_mode_config.c | 20 +++++++++++++++++
>  include/drm/drm_crtc.h            |  4 ++++
>  include/drm/drm_mode_config.h     | 45 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 146 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 1eebcf6f5e05..c9eb01d740b3 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -420,6 +420,22 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
>  		return ret;
>  	} else if (property == config->prop_vrr_enabled) {
>  		state->vrr_enabled = val;
> +	} else if (property == config->prop_vrr_min_numerator) {
> +		if (val > U32_MAX)
> +			return -EINVAL;
> +		state->vrr_state.vrr_min_n = val;
> +	} else if (property == config->prop_vrr_min_denominator) {
> +		if (val > U32_MAX)
> +			return -EINVAL;
> +		state->vrr_state.vrr_min_d = val;
> +	} else if (property == config->prop_vrr_max_numerator) {
> +		if (val > U32_MAX)
> +			return -EINVAL;
> +		state->vrr_state.vrr_max_n = val;
> +	} else if (property == config->prop_vrr_max_denominator) {
> +		if (val > U32_MAX)
> +			return -EINVAL;
> +		state->vrr_state.vrr_max_d = val;
>  	} else if (property == config->degamma_lut_property) {
>  		const size_t elem_size = sizeof(struct drm_color_lut);
>  		u64 lut_size;
> @@ -505,6 +521,14 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
>  		*val = (state->mode_blob) ? state->mode_blob->base.id : 0;
>  	else if (property == config->prop_vrr_enabled)
>  		*val = state->vrr_enabled;
> +	else if (property == config->prop_vrr_min_numerator)
> +		*val = state->vrr_state.vrr_min_n;
> +	else if (property == config->prop_vrr_min_denominator)
> +		*val = state->vrr_state.vrr_min_d;
> +	else if (property == config->prop_vrr_max_numerator)
> +		*val = state->vrr_state.vrr_max_n;
> +	else if (property == config->prop_vrr_max_denominator)
> +		*val = state->vrr_state.vrr_max_d;
>  	else if (property == config->degamma_lut_property)
>  		*val = (state->degamma_lut) ? state->degamma_lut->base.id : 0;
>  	else if (property == config->ctm_property)
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index fc7d9fcf9d9f..5c07bd221977 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2579,6 +2579,51 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
>   *
>   *	The driver may place further restrictions within these minimum
>   *	and maximum bounds.
> + *
> + * VRR Limiter/Target Properties
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + * The ``VRR_{MIN,MAX}_{NUMERATOR,DENOMINATOR}`` properties expose a mechanism
> + * through which userspace can control the desired range of refresh rates in
> + * which VRR is allowed to operate. Each rate is expressed as a
> + * numerator/denominator fraction of refresh rates in Hz, allowing for rational
> + * target rates like 24/1.001 Hz with no loss of precision or ambiguity.
> + *
> + * If the minimum and maximum rate are set to the same value (and not 0), they
> + * are understood as a fixed target rate. This is especially useful for media
> + * playback, where the content's frame rate is both constant and known in
> + * advance. In such cases, a refresh rate that is not an integer multiple of the
> + * content's frame rate will introduce judder, since not every frame is
> + * displayed for the same amount of time. A modeset of the display with a
> + * compatible rate may in those cases be either undesirable or impossible, but
> + * the rate can still effectively be reached through VRR.
> + *
> + * .. _VRR-MIN-NUMERATOR:
> + *
> + * "VRR_MIN_NUMERATOR":
> + *	Default &drm_crtc integer property forming the numerator of a
> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> + *	target rate. Set to 0 to disable.
> + *
> + * "VRR_MIN_DENOMINATOR":
> + *	Default &drm_crtc integer property forming the denominator of a
> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> + *	target rate. If :ref:`VRR_MIN_NUMERATOR <VRR-MIN-NUMERATOR>` is not
> + *	zero, it must be non-zero.
> + *	Otherwise, must also be zero.
> + *
> + * .. _VRR-MAX-NUMERATOR:
> + *
> + * "VRR_MAX_NUMERATOR":
> + *	Default &drm_crtc integer property forming the numerator of a
> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> + *	target rate. Set to 0 to disable.
> + *
> + * "VRR_MAX_DENOMINATOR":
> + *	Default &drm_crtc integer property forming the denominator of a
> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> + *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is not
> + *	zero, it must be non-zero. Otherwise, must also be zero.
>   */
>  
>  /**
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 63ead8ba6756..9244fbf97029 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -322,6 +322,14 @@ static int __drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *
>  					   config->prop_out_fence_ptr, 0);
>  		drm_object_attach_property(&crtc->base,
>  					   config->prop_vrr_enabled, 0);
> +		drm_object_attach_property(&crtc->base,
> +					   config->prop_vrr_min_numerator, 0);
> +		drm_object_attach_property(&crtc->base,
> +					   config->prop_vrr_min_denominator, 0);
> +		drm_object_attach_property(&crtc->base,
> +					   config->prop_vrr_max_numerator, 0);
> +		drm_object_attach_property(&crtc->base,
> +					   config->prop_vrr_max_denominator, 0);
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 48a56f23dadb..da967d60f832 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -535,6 +535,26 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
>  		return -ENOMEM;
>  	dev->mode_config.prop_vrr_enabled = prop;
>  
> +	prop = drm_property_create_range(dev, 0, "VRR_MIN_NUMERATOR", 0, U32_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_min_numerator = prop;
> +
> +	prop = drm_property_create_range(dev, 0, "VRR_MIN_DENOMINATOR", 0, U32_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_min_denominator = prop;
> +
> +	prop = drm_property_create_range(dev, 0, "VRR_MAX_NUMERATOR", 0, U32_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_max_numerator = prop;
> +
> +	prop = drm_property_create_range(dev, 0, "VRR_MAX_DENOMINATOR", 0, U32_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_max_denominator = prop;
> +
>  	prop = drm_property_create(dev,
>  			DRM_MODE_PROP_BLOB,
>  			"DEGAMMA_LUT", 0);
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 9d58158af459..df37f4ebb58e 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -67,6 +67,10 @@ struct drm_crtc_vrr_state {
>  	u8 vic;
>  	u16 cur_vtotal;
>  	u16 max_vtotal;
> +	u32 vrr_min_n;
> +	u32 vrr_min_d;
> +	u32 vrr_max_n;
> +	u32 vrr_max_d;
>  	u16 base_vtotal;
>  	bool dynamic;
>  };
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 084517beb924..c8d5286f9267 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -702,6 +702,51 @@ struct drm_mode_config {
>  	 */
>  	struct drm_property *prop_vrr_enabled;
>  
> +	/**
> +	 * @prop_vrr_min_numerator: Default atomic CRTC property to indicate the
> +	 * numerator of a numerator/denominator variable refresh rate minimum
> +	 * target frame rate.
> +	 *
> +	 * If not zero, @prop_vrr_min_numerator divided by
> +	 * @prop_vrr_min_denominator must result in a frame rate above the
> +	 * sink's minimum VRR rate.
> +	 */
> +	struct drm_property *prop_vrr_min_numerator;
> +
> +	/**
> +	 * @prop_vrr_min_denominator: Default atomic CRTC property to indicate
> +	 * the denominator of a numerator/denominator variable refresh rate
> +	 * minimum target frame rate.
> +	 *
> +	 * If @prop_vrr_min_numerator is set, @prop_vrr_min_denominator must not
> +	 * be 0, and @prop_vrr_min_numerator divided by @prop_vrr_min_denominator
> +	 * must result in a frame rate above the minimum VRR rate.
> +	 */
> +	struct drm_property *prop_vrr_min_denominator;
> +
> +	/**
> +	 * @prop_vrr_max_numerator: Default atomic CRTC property to indicate the
> +	 * numerator of a numerator/denominator variable refresh rate maximum
> +	 * target frame rate range.
> +	 *
> +	 * The fraction expressed by this property divided by its corresponding
> +	 * denominator must be equal to or greater than the value of
> +	 * @prop_vrr_min_numerator.
> +	 */
> +	struct drm_property *prop_vrr_max_numerator;
> +
> +	/**
> +	 * @prop_vrr_max_denominator: Default atomic CRTC property to indicate
> +	 * the denominator of a numerator/denominator variable refresh rate
> +	 * maximum target frame rate range.
> +	 *
> +	 * If @prop_vrr_max_numerator is set, @prop_vrr_max_denominator must not
> +	 * be 0, and @prop_vrr_max_numerator divided by @prop_vrr_max_denominator
> +	 * must result in a frame rate equal to or above @prop_vrr_min_numerator
> +	 * divided by @prop_vrr_min_denominator.
> +	 */
> +	struct drm_property *prop_vrr_max_denominator;
> +
>  	/**
>  	 * @dvi_i_subconnector_property: Optional DVI-I property to
>  	 * differentiate between analog or digital mode.
> 
> -- 
> 2.55.0
> 
> 
