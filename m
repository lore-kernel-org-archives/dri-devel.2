Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AB3C98316
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2035610F339;
	Thu, 24 Sep 2026 06:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="naOuY6rc";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CCFD10F339;
 Thu, 24 Sep 2026 06:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoMvYpk5MaiU9Eyawk8MAX+O+U1R2u4mLBECPWQ6KtXyTl3BlZ1JPs0R2C2tOjIqxJbrQ1lcTsq2VP11Sb+ksSTHOuWCstHyih6hcY0WIahPsNHaK29d0q2+jJ0THMu8yhWaQl4MZhftkBV/HPddYcN5Eurj9bBbWBosyDUdv1/0aL4SibKNJZ4fLMFELF4HOxEFCLD8/Gq5VluB82THqoexpHoE/K+WmixTrcbD9O0XNpiuORPjlQH3lmE1qrmTtQDhzbO5L6cXoejV6bmOkG91SkSxfuJgHIpfr5n9Qn5lcYlX0RZL8FJIEnCYwt5UDVRc1/ARqOH21NyOzjEHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVfFu4PUeajg1ABEa5xa7PUUAKSajpANyrE8pxU7RcI=;
 b=K/KODGVly+v11V+okVe14CWG2y74A8xad/BAaKKBasJuPEy4fwQduYgL6x1ufNizE8/jhzdsJYIa/HQMP+VRGMet7soVFldSNEUCf+4WOUvXFX2lDu8CsItE/2jnSTJYIwS64Od75Ma6y5mPNKbKnc436A8v/XKFPdfFFQKPbs1Zuzm8D72rS3PBSHZ6yMtpO6Dp8B81TSdGq+7ouKb91aUOZxPuJHOVJN+o0KZvcIMeD98MDGC5LzybvEfLaSzx5A9jqjBzvLTNq+NQy5Vtqg3YrcPI9O2+ExxC46bENWhyBiZsi/8dz6uZiK+HiLWHJopzcTAkqkalpiRfqs80FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVfFu4PUeajg1ABEa5xa7PUUAKSajpANyrE8pxU7RcI=;
 b=naOuY6rcfNXjTGxN74lZfKPOA0t6YkcLeNhghmRyFzbol7WegXcE25BS9KaSitW4xOnq3NPa2BFbP4tTPlpvGPAzIkOK9OJbZJIY8C1ZcSns0PJFbQVmhV65YEtF9KwAixoQfZ6wQ8sxVZZob7PjcUoOHyYh4q0c0fxoecrHWzN17CRj2uei7PRpkBXOnemdXzbiZjYDl0Clh4G+hJS3mi50XTwktpomBLEZv5EZAti6KBwmNe/y3g0ZDOcEz4MLBgn9BWjkvZq/kaxea5a3BCS/VKvcFRUFGGr32chu3GCoxS1X+6ke8/B4t72nVrURBNCKthGxJzZnEKS7clKgaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 06:55:07 +0000
Received: from BL0PR12MB4914.namprd12.prod.outlook.com
 ([fe80::4921:cbe6:78cd:b445]) by BL0PR12MB4914.namprd12.prod.outlook.com
 ([fe80::4921:cbe6:78cd:b445%4]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 06:55:07 +0000
Date: Thu, 24 Sep 2026 01:55:01 -0500 (CDT)
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
Subject: Re: [PATCH RFC 02/25] drm: Add VRR state
In-Reply-To: <20260921-vrr-limiter-uapi-v1-2-2fcd7d011646@collabora.com>
Message-ID: <6835709f-e2d1-54ec-7dee-057004b08a90@nvidia.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-2-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::34) To BL0PR12MB4914.namprd12.prod.outlook.com
 (2603:10b6:208:1c4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB4914:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 128682e3-d62e-427b-18f9-08df1a08c3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|4143699003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UPV21w6U4p/r+YPtclOZMJpo444ikwW8llr/KOuzjJmRjgqeSMt0ycGLzFR23ZxK5Y+lNydKPXJYvln5RLMbLBIHB9UdkqdKk3Ul4IzOQ5qE/uxHIMgJFe66VdrYn2MCOM9tssvhvGCflOYqQe73l5UFj/btqsS8b9boSQtyoWTJjBKIfTFa9RwsjMT6fC9Kl9xaYaknt/54u2G/HjxsvI5baCcBJD6yJTLtBJeu0NOKjnFV0VfyfCXEKhOv0bhnyT1OipM4l1ENx10oDALO1GhGm2Pntzvc1XPprqWycP7Ck5TDm+FYkniW63koqjvA+vAZbrSB3fJPyDzjA9mvyx/zGcuiT36tF/S6qBOhgqisAW8oKHjtEHy/ZJC/CgWohCKWzn9C8sT0cihzzGNGEhsN5ynzlRjy0kLkBNzX0nBz5PUPGB8zlObz/bfuO5D0NM6OyANmCq2tX0ttkOIhTsIUv9ih0KRQNZ7UNOnN0MNiGsoau1feapIZ96ia50JahEfzcWGGyc0IK01REBqYtWfFld5FEl44aM/888mhpA/SjJtxb3lKwUWmLUa2w/vE7xQO1h+QJeKii6vYc7YHFyJQ3qZ4VH8rm3vGFrQWPjIkBbgghV7Z54gJoYZMNHSp6EuGD+DHay+8IMxN6uxTydjheAON7bZqByLzJqVwNzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vTYM6NYngDRyLO+VHWAd3ystW3SXHiqVWNp6P1C4LlqJiq9hEuiQzcUYlyiV?=
 =?us-ascii?Q?CWQMMOO7sYsSbVKWp3BGd69g5SXuTNsUs4DCQr1rQsJakOla8RkCBMgOkrMm?=
 =?us-ascii?Q?vtq65WbZNhabr5MvzY61Ax9cFl7GyETXW66uICpbu6BJiwnvoy49Ro3nylpL?=
 =?us-ascii?Q?k5dxpd1KukaKM/TXEw5PmdpY4XM8WWXfixiH0JMX3CVNETopUVuCvl6i7rW8?=
 =?us-ascii?Q?RpTAkMRfRZT537B+MfjTZcA2efXAUP1mzZL83H8vF5JlJkL67t43Y5TdL4fU?=
 =?us-ascii?Q?bY8V1aNR7mQQMdJOLxtkcwunBgPnXIpxtv19TzTzIkVtqSP/kpAmR4C5tn4Z?=
 =?us-ascii?Q?TpyDyGih6hYyw473wrw4/7I42jJPzcH2ObVVmvJ5atEB0/a4MK7aYxtyQMYL?=
 =?us-ascii?Q?eTujyRdJvi6fV/bNeGL8+PI3Qty76OQM5VVqlkm94hg30st8MHrXvPFFqJ16?=
 =?us-ascii?Q?xzGqLwx3oh/11xYPQdESN937GdIyntpKXOCchxG9LBmnS+kGDP2odDUUIR7l?=
 =?us-ascii?Q?x8CIQfOf/9BziZ1mZgnizip4W9FAkTx0C6qP3306p+adjCYg3xdYorzkWO3k?=
 =?us-ascii?Q?Ci6zSu2SrJJid03eLaSYuxFdf+r5zOyGQiLeWjE1AFhFHI9HpumlX+iZYIlH?=
 =?us-ascii?Q?liuZjqVsAbB8ri/g2GoDpEnuOUpHRlsE/KwOrRKpCvMUV/rMXVnAcyvE7LXJ?=
 =?us-ascii?Q?W0/t5v7k6LrM+tOhvWoRKaf5HAAqiDXR2fEDb2jD5Y1bBckr2PIZupowKNrY?=
 =?us-ascii?Q?tqq52SbVEJIENDdvp+TAkn8mGjw199sWV9PBQk+bRo3cDmYn1ObKwrtHRnjV?=
 =?us-ascii?Q?bPqup8kM0f1Q1NS9EkDk2tFL4jW606vZNDexFjZcFGiZD6sSKqH7qUNnekKX?=
 =?us-ascii?Q?Azudw+b/EEoEmVwYNNzDgFt5eNFaXHC5CIhgqlnqBPp80lH29kiFIQEoZGPI?=
 =?us-ascii?Q?DnZ/mNXYzhyjmxpEpBcm2eQnucixqvm65xfdixKCMS+sDdLEXKKA7Q5Avme/?=
 =?us-ascii?Q?u3idXxO12n70ZSy7Hpb5dHBdu5k8iVg1nPyXIv/DDoKqeugWYdfgkQjrNWPF?=
 =?us-ascii?Q?jkcEcLAJZWpBPqtBc5ovpNkgodWp1jun+iGYGiMLUBMSZkvGMYOWt7vmniWg?=
 =?us-ascii?Q?3d5/jXCDf0LwDOcSFJXJQ4mifRgq7yW0JupxyoJcmvsPfAnbMG779rYCvChh?=
 =?us-ascii?Q?70mtQuGwjtO9Bx7dkL5/EfDBcQDAnC+w/UoWXpNRmZ1ov4Ize1yyq/lm6S/P?=
 =?us-ascii?Q?7gZOUUT2DZX3h5131wr0tyNxO7rV0FO9RQ3WhKJ0VAadhSTgIufwpa3z/8fg?=
 =?us-ascii?Q?dnjyfKpYvw1LSH7R5VB0SYBOGRjcQQKNTAFS/6X8lXgxqXnLUh0wFRV7ebv9?=
 =?us-ascii?Q?0GdaUlEVDtMptQVjkQ/1ueLP2isswEu45lMNI3/gw3GRNtG09OqcvBSbzWmJ?=
 =?us-ascii?Q?W3g0B0pbcbMd1tw//TBgletsy7FpmSpwJHfdpCxI/b7gMbslnjBZX+zw4Jsq?=
 =?us-ascii?Q?38IKPPycjzMvPq4TW2OFdkLebbt+jsVc8E+DOd65Rp+6CoXjCxKNdkDDaEgW?=
 =?us-ascii?Q?iS12eFU00tx9FzWxLuEKbAoGrlHfaTKQIFNaSGPd3/7y5/P5iGWFs+F+//up?=
 =?us-ascii?Q?YVr/UkA/E1q59IgYi2LJwTrKYSBYP7KkZHaqxFlH3tVYhei9SJwFl60Ey0uO?=
 =?us-ascii?Q?tMbHE3FVjy5NmRQHVz5r1qp9VzirVqmvADC3jx9s13OwX3jf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128682e3-d62e-427b-18f9-08df1a08c3e7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 06:55:07.0665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKXpHaGjpsTHitL3qKCpyIsEKd4wDIkB+tN6MUfCKstzcCDZSswG5bp2Obq6Cxo9EQFniw8FIi5LZmgYUxjqQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
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

> Add preliminary state tracking for VRR, and VRR state validation. This
> will be used for generating VTEM infoframes in order to support variable
> refresh rate functionality.
> 
> Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
> Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 227 ++++++++++++++++++++++++
>  include/drm/drm_crtc.h                          |  11 ++
>  2 files changed, 238 insertions(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> index 7cdb7ca3dc12..d55548399687 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -887,6 +887,229 @@ hdmi_generate_infoframes(const struct drm_connector *connector,
>  	return 0;
>  }
>  
> +/**
> + * cmp_fraction - compares two fractional numbers
> + * @a: numerator of the first fraction
> + * @b: denominator of the first fraction
> + * @c: numerator of the second fraction
> + * @d: denominator of the second fraction
> + *
> + * Compare fractional expression given by @a divided by @b with fractional
> + * expression given by @c divided by @d, without running into rounding issues.
> + *
> + * Neither @b nor @d should be 0.
> + *
> + * Returns:
> + *  - %1 if @a / @b > @c / @d
> + *  - %-1 if @a / @b < @c / @d
> + *  - %0 if @a / @b == @c / @d
> + *  - %-EDOM if @b is zero or @d is zero.
> + */
> +static int cmp_fraction(u32 a, u32 b, u32 c, u32 d)
> +{
> +	u64 a_d = mul_u32_u32(a, d);
> +	u64 b_c = mul_u32_u32(b, c);
> +
> +	if (WARN_ON(!b || !d))
> +		return -EDOM;
> +
> +	/* a/b > c/d */
> +	if (a_d > b_c)
> +		return 1;
> +
> +	/* a/b < c/d */
> +	if (a_d < b_c)
> +		return -1;
> +
> +	/* a/b == c/d */
> +	return 0;
> +}
> +
> +static int hdmi_calculate_vtotal(const struct drm_display_mode *mode,
> +				 u32 rate_n, u32 rate_d, u16 *out_vtotal,
> +				 u32 *out_denom, u32 *out_frame_err)
> +{
> +	u32 denom, result, err;
> +	u64 numerator;
> +
> +	/*
> +	 * We perform VRR based rate limiting by adjusting the vertical front
> +	 * porch. We do that by picking a new Vtotal to pass to the hardware,
> +	 * which extends the display period. Since we can change no other
> +	 * timings, this rarely results in a perfect integer match to the
> +	 * target framerate. However, we would like to correct for this error
> +	 * using only integer math.
> +	 *
> +	 * For a given refresh rate:
> +	 *
> +	 * Vtotal =              clock
> +	 *          ----------------------------------
> +	 *               Htotal * target_refresh
> +	 *
> +	 * We specify target_refresh as a ratio, because the possible target
> +	 * framerates include rates like 23.97... that are actually 24 / 1.001,
> +	 * or 24000 / 1001.
> +	 *
> +	 *                        clock
> +	 * Vtotal = ----------------------------------
> +	 *            Htotal * target_n / target_d
> +	 *
> +	 * Some algebra brings us to:
> +	 *
> +	 *                clock * target_n
> +	 * Vtotal = ----------------------------------
> +	 *                Htotal * rate_n
> +	 *
> +	 * The amount of timing error we accumulate every frame will be
> +	 * the remainder of that division.
> +	 *
> +	 * We store the remainder for later. Every frame we add the remainder
> +	 * to an accumulator, and when the accumulator exceeds the denominator,
> +	 * one Htotal worth of error has accumulated.
> +	 *
> +	 * In practice, as soon as the accumulated error exceeds half the
> +	 * denominator, it is dithered across frames by temporarily extending
> +	 * Vtotal by a single row on that frame.
> +	 */
> +
> +	if (check_mul_overflow(mode->crtc_htotal, rate_n, &denom))
> +		return -ERANGE;
> +
> +	if (check_mul_overflow(mode->crtc_clock * 1000ULL, rate_d, &numerator))
> +		return -ERANGE;
> +
> +	result = div_u64_rem(numerator, denom, &err);
> +	if (result > U16_MAX)
> +		return -ERANGE;
> +
> +	if (out_vtotal)
> +		*out_vtotal = result;
> +	if (out_denom)
> +		*out_denom = denom;
> +	if (out_frame_err)
> +		*out_frame_err = err;
> +
> +	return 0;
> +}
> +
> +static int hdmi_validate_vrr(struct drm_connector *connector,
> +			     struct drm_atomic_commit *state)
> +{
> +	struct drm_connector_state *new_conn_state =
> +		drm_atomic_get_new_connector_state(state, connector);
> +	struct drm_crtc_state *new_crtc_state =
> +		drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
> +	struct drm_crtc_state *old_crtc_state =
> +		drm_atomic_get_old_crtc_state(state, new_conn_state->crtc);
> +	struct drm_crtc_vrr_state *vrr_state =
> +		&new_crtc_state->vrr_state;
> +	struct drm_crtc_vrr_state *old_vrr_state =
> +		&old_crtc_state->vrr_state;
> +	struct drm_display_info *info = &connector->display_info;
> +	const struct drm_display_mode *mode = &new_crtc_state->mode;
> +	struct drm_device *dev = connector->dev;
> +	int mode_refresh, vfront, ret;
> +	u32 min_vfreq_n = info->monitor_range.min_vfreq;
> +	u32 min_vfreq_d = 1;
> +	u32 max_vfreq_n = info->monitor_range.max_vfreq;
> +	u32 max_vfreq_d = 1;
> +
> +	/* Save on the expensive vic lookup, if nothing else. */
> +	if (!new_crtc_state->mode_changed &&
> +	    old_crtc_state->vrr_enabled &&
> +	    old_vrr_state->vrr_min_n == vrr_state->vrr_min_n &&
> +	    old_vrr_state->vrr_min_d == vrr_state->vrr_min_d &&
> +	    old_vrr_state->vrr_max_n == vrr_state->vrr_max_n &&
> +	    old_vrr_state->vrr_max_d == vrr_state->vrr_max_d &&
> +	    info->hdmi.vrr_capable) {
> +		memcpy(vrr_state, old_vrr_state, sizeof(*vrr_state));
> +		vrr_state->dynamic = false;
> +		return 0;
> +	}
> +
> +	if (!new_crtc_state->vrr_enabled)
> +		return 0;
> +
> +	if (!info->hdmi.vrr_capable)
> +		return -EOPNOTSUPP;
> +
> +	mode_refresh = drm_mode_vrefresh(mode);
> +
> +	/* HDMI uses 10 bits to signal the base refresh. */
> +	if (mode_refresh < 0 || mode_refresh > 1023) {
> +		drm_dbg_kms(dev, "Mode's refresh of %dHz > HDMI VRR maximum (1023)\n",
> +			    mode_refresh);
> +		return -EINVAL;
> +	}
> +
> +	if (!max_vfreq_n || max_vfreq_n > mode_refresh)
> +		max_vfreq_n = mode_refresh;
> +
> +	if (!min_vfreq_n) {
> +		drm_dbg_kms(dev, "Could not get minimum VRR rate from sink\n");
> +		return -EINVAL;
> +	}
> +
> +	vfront = mode->crtc_vsync_start - mode->crtc_vdisplay;
> +	if (vfront < 0 || vfront > U8_MAX) {
> +		drm_dbg_kms(dev, "Vfront of %d would not fit in VTEM packet\n", vfront);
> +		return -EINVAL;
> +	}
> +
> +	vrr_state->vic = drm_match_cea_mode(mode);
> +
> +	if (cmp_fraction(min_vfreq_n, min_vfreq_d, max_vfreq_n, max_vfreq_d) > 0) {
> +		drm_dbg_kms(dev, "Target max (%u/%u) > target min (%u/%u)\n",
> +			    max_vfreq_n, max_vfreq_d, min_vfreq_n, min_vfreq_d);
> +		return -EINVAL;
> +	}
> +
> +	ret = hdmi_calculate_vtotal(mode, max_vfreq_n, max_vfreq_d,
> +				    &vrr_state->base_vtotal, NULL, NULL);
> +	if (ret) {
> +		drm_dbg_kms(dev, "Couldn't calculate base_vtotal: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	/*
> +	 * Even at its fastest, it can't go faster than the mode, so
> +	 * clamp to avoid imprecisely rounded mode_refresh values we
> +	 * can't do anything about from ruining our day.
> +	 */
> +	vrr_state->base_vtotal = max(vrr_state->base_vtotal, mode->crtc_vtotal);
> +
> +	if (cmp_fraction(min_vfreq_n, min_vfreq_d, mode_refresh, 1) >= 0) {
> +		/* refresh <= VRR min, don't do VRR vtotal adjustment */
> +		vrr_state->max_vtotal = mode->crtc_vtotal;
> +	} else {
> +		/*
> +		 * Allow additional front porch until effective rate == VRR min
> +		 * In essence, this is mode->vtotal * mode_refresh / min_vfreq
> +		 * but the relevant factors factored out from drm_mode_vrefresh()
> +		 * to avoid working with rounded values, as well as using the
> +		 * hardware adjusted crtc_* values instead.
> +		 */
> +		ret = hdmi_calculate_vtotal(mode, min_vfreq_n, min_vfreq_d,
> +					    &vrr_state->max_vtotal, NULL, NULL);
> +		if (ret) {
> +			drm_dbg_kms(dev, "Couldn't calculate max_vtotal: %pe\n", ERR_PTR(ret));
> +			return ret;
> +		}
> +
> +		if (vrr_state->max_vtotal < mode->crtc_vtotal) {
> +			drm_dbg_kms(dev, "max_vtotal=%u < crtc_vtotal=%u\n",
> +				    vrr_state->max_vtotal, mode->crtc_vtotal);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	drm_dbg_kms(dev, "VRR has base_vtotal=%u max_vtotal=%u from %u/%uHz <= rate <= %u/%uHz\n",
> +		    vrr_state->base_vtotal, vrr_state->max_vtotal, min_vfreq_n,
> +		    min_vfreq_d, max_vfreq_n, max_vfreq_d);
> +
> +	return 0;
> +}

I don't think we need to restrict the frame rate range limits validation 
to just HDMI. The frame rate limits themselves are not dependent on any 
specific HDMI features and can be enforced source-side while signalling 
the standard VRR mode to the sink.

> +
>  /**
>   * drm_atomic_helper_connector_hdmi_check() - Helper to check HDMI connector atomic state
>   * @connector: DRM Connector
> @@ -919,6 +1142,10 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
>  
>  	new_conn_state->hdmi.is_limited_range = hdmi_is_limited_range(connector, new_conn_state);
>  
> +	ret = hdmi_validate_vrr(connector, state);
> +	if (ret)
> +		return ret;
> +
>  	ret = hdmi_generate_infoframes(connector, new_conn_state);
>  	if (ret)
>  		return ret;
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index be5dca538d87..9d58158af459 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -63,6 +63,14 @@ struct drm_atomic_commit;
>  struct drm_crtc_helper_funcs;
>  struct drm_plane_helper_funcs;
>  
> +struct drm_crtc_vrr_state {
> +	u8 vic;
> +	u16 cur_vtotal;
> +	u16 max_vtotal;
> +	u16 base_vtotal;
> +	bool dynamic;
> +};
> +
>  /**
>   * struct drm_crtc_state - mutable CRTC state
>   *
> @@ -397,6 +405,9 @@ struct drm_crtc_state {
>  	 */
>  	struct drm_pending_vblank_event *event;
>  
> +	/** @vrr_state: State related to variable refresh rate. */
> +	struct drm_crtc_vrr_state vrr_state;
> +
>  	/**
>  	 * @commit:
>  	 *
> 
> -- 
> 2.55.0
> 
> 
