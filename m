Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D715C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 22:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F77C10E51C;
	Mon, 21 Sep 2026 22:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EQbRSifm";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012044.outbound.protection.outlook.com
 [40.107.200.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C632810E51C;
 Mon, 21 Sep 2026 22:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyZkPIB5nt19l788l15U54aj1dKlM/57EVFGMVMnXx/aj3gPXKB7Zf3XxS2kDq1KaJeINwkrWhXwsh72FzhBK+MF/T7aisGrl94Y2xOiwau9btswXb8NN8GBTifaKQ75O5e0d3EKhI2eDgUOzvEsh2xzen2TTlI9uw5mv/0SqwisXDGu7asqQs0lv98UPHHb+sYWhaRapcAibLbhIM1k7ccG+VnA9BorDI5ZLtR5qxTTCCAAdArv3kl8rrne1IDOluR7BIGFGIFx6iYDMu1dqr+P4d9ruaDwnFj06WG4C7tlWu2vhOQ10GZTd7pzZ9aP1YyBL1JjPXjj0UwNQAvqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FuJXJ+S+MFgkVXXYAuRlBx9hLARNm4JnIUAlxt5zhM=;
 b=dUn/p4Slnkei+1I4okdXdaLn7vEddiMhHzlrMiiIYj9D89TPjzSddqGjirBAxDcNS17DdoRVGpK9mTc86DJoyq9gfAN8HYw2lbFsTiljrgsqBKuHToDT4A/bt+dgeBD7JCdr4bPEdRzQ2YJ1ijUvs3SMNNZTaNtG5VQpqmkxd5WZ9AxscjJIDIRd59kT3C0muR7C+uT1t6wAWsSwXZ6Q4lee4PAlLIWKTeQuZHpqDNdh3dqPSiJGbEZ3H4Zw6BC9DqAELBvLxkho7jsQBZ9k6jagEWBSk++V1toHeeSK+s+LtRzhRvUqCbDfck/SBf5X32XHKGvaYHYK65e6CQRjSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FuJXJ+S+MFgkVXXYAuRlBx9hLARNm4JnIUAlxt5zhM=;
 b=EQbRSifmLtxFH6lruuXhoVaUtZklaj57JCCcyl41o4wvSazVTTQen3iM1GYTwSYWzb3QfH72AeSQmpDFtjHy750nzojkIvopSezpAm8ZGOC0ShtqOb8qrWdMu1w4Q2uNPhZ6orPdiFw5a/LZIWswpkEE/5pnVDccDga8GtcmhUs=
Received: from PH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::16)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 22:23:34 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:510:d3:cafe::5c) by PH0P220CA0011.outlook.office365.com
 (2603:10b6:510:d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 22:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 22:23:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 17:23:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 17:23:32 -0500
Received: from [10.254.92.51] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 17:23:31 -0500
Message-ID: <0226527e-ee38-40ab-a2a8-1ae62013b950@amd.com>
Date: Mon, 21 Sep 2026 18:23:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, "Borah, Chaitanya
 Kumar" <chaitanya.kumar.borah@intel.com>, Daniel Stone
 <daniels@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-fbdev@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <kernel@collabora.com>, Derek Foreman
 <derek.foreman@collabora.com>, <wayland-devel@lists.freedesktop.org>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: a323075a-413f-4c5b-372f-08df182ef956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|42112799006|82310400026|1800799024|7416014|36860700016|4143699003|56012099006|3023799007|11063799006|921020|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: T9RDJe4EBH3ZFjIjYjtFh3OkL9K4GodEFHegc6exyejkM8fAWAS/7/rq67aIvBVdu23O6iCWQIFIU2Ga0EGNCOiwZMBxgerTu5ZhjGaiITA51QccpGSOy7ta3oVFXPsFwN8pJSPXeVSWlmawWW7uOkLJ0smW3oKifCm7bYtlWN/73B2QrD45Wdty3TGJKhbAvxWjO1LgyjYbOj6bEGp7x0shNTP9MWEKlpZuoign7u9ZXGT7CVK9U1mYEabgySV3C/u2yHDowgUWRAWzMwtN3+2b4kYHa7NdHJnL3Z7EBqpa47320szAgs05Le7+ZMfhjh6mvnK33YI07JHlNg3j1C8ZG1A1XEEQtug9i6u+fTM0giwMQGsjnogbsVX/R/izc8re3avneUnldfTwhOsxMwFUvMFfacki40t773FnUgRq4MUkKINSHes0vojSDwm8Crulc1RAApBEJVkGN3SCaEbWzvQNKBiCR3xsjN0278We3tKT87w22JUbW70kig7m+6r9gHY/4cg62NPpfgtJBWfKFaeUdtChyl5VqAVzm/+3Ssdi0k+dVyTcSnLzL9ifkzKb5/X9PDF0Fcd6CoYc/rfevRQerUGx6QdKML7cec2J0y4C+Hh4+ckA2ai2ENUpJb8ahiPRbi3QBm9RhradGJ6JD6rcfwua/99UWPiAXXwen2dQT/poZiSA4Yho70khAGph84Lvhh5mR5ObybsOeyHL4/8b9Ou79kyvS6p5+A9EL/ZfTxKKsYOm8Iz+XWr/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(42112799006)(82310400026)(1800799024)(7416014)(36860700016)(4143699003)(56012099006)(3023799007)(11063799006)(921020)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hlSomVcSpTtCoNd3vNbOgJrMFRdXMKfDxFze8l6Z5nX9N6Lq9znm0P+UJPTbeFqONANSZGl3UEQYLNIBungrvFGE8g6vsXswBIf/+3xD0dnqdR0Idtt4jtgr402ptHs/ghucs/G+0w6HE2a5vb6KsWUMb0xt4rvSzLALFrz42rrKH/qqWuS1y1Y0BRNS4f+PYFoqfCrOHhEsCRaxmtm5ZlivcUU69AG35F8zLcHMSuljuZ+mRWcbzndigedDLz6Mj8tlLvn1GUTCb0JqUIbQKoyHPjHKjiK1zpPS115HpYQB5xVpdiwJ0CJzlfGXbPI9g7KDXQEapYC0LkVExxHrIzGAVVdsz8Xvj6whzV2xm7spkNVbXGHXJPP6pn5gQEnB2wC7+BuciEH9Y6by2wo987hNKVf9CVCKnHj6bIGKe2fBqNNiVxCC1jO4IHf2xS9d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 22:23:33.9359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a323075a-413f-4c5b-372f-08df182ef956
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
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



On 2026-09-21 11:51, Nicolas Frattaroli wrote:
> Userspace may wish to set a target frame rate for the Variable Refresh
> Rate mechanism. There are multiple possible ways such a target could be
> communicated.
> 
> It's desirable for userspace to not only set a fixed target, but a
> target range within which VRR may operate. This is because even if a
> sink advertises a certain range as supported, said range may not be the
> ideal range to use, as numbers on the extreme end of the range may
> induce flickering or other glitches.
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

If VRR_MIN_NUMERATOR == 0 && VRR_MAX_NUMERATOR > 0, do we interpret that as
vrr limiting is disabled?
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

Would it be better to let vendors attach these properties themselves? That way,
they will only exist if supported. Otherwise, I'm not sure what would be the
expected behavior if they're attached, but not supported.

- Leo
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

