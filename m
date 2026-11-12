Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5685606ABE6
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ipLNJa6n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EC010E00C;
	Thu, 12 Nov 2026 05:36:26 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2807B10E00C;
 Thu, 12 Nov 2026 05:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsnJi/wOLY7lHhbivJQmn1LlZbj98eZ3yGdi2t30YovsotdSdLpg8n6C3fN6KN0BzcystJE5VvBE6m696JNYbOT/4YlIhlh7yvfVA0ljv4vgBIHr65IOU3OUsPhgvMixOrdLB8kQt5DcHfJ7w8BeAzUjz2u8mEfVSh3g1rJ8WNH4penzAgsiy6/NUarrXDub06bVR4+kNiwPvUe5VaDJ79cCcJIFtFh5y4TGs5F2r1RKzWVCJx8aJeyI1AVrKioP4fCyw+qzxIHFsVqSGanP1FOexx8X3QclDNDiP5F7X/vYsfvyr3OalycpFWmGaoKoZ23qVd9nv+UmTsO668X8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4L2droYwPuQiGvQHNhcMSTOaHDL2TEmf87Rb8ua0eo=;
 b=gG3+U+TJI4/PfjGmXdBDMNuQxzLsDCujRiiyNAk4PK7Vd9N6vIQYKiWZeubCwNxirgyya23ZlDROHzQdJ+ZmsJ8+H58pkyDLVZu2Evn8MV7NRcJlYHNYbtOHOkR+7mZtNxr8Bzeq7+wkhczb9K91Z9ckc0vuFvkJAL07ogJl2suVJD7FNcQ0QPmqrr4D5p88+6CQNCpyqej3lx9kl5YDv5FN/yHsvKtlz8BjQ0UXtnMz+q1YyYtJxK0dRQnX6hS1cMQj7y5EEhWb1cVtIVNVa2kIHbo0d61kDdb0XlNMxhPIHQrmeFKMUBc65c+hhxeuuUrt088uPcnQ1WEqSr+sSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4L2droYwPuQiGvQHNhcMSTOaHDL2TEmf87Rb8ua0eo=;
 b=ipLNJa6nQbZMrLuSz5E2zQfHl/IUcC/MaZ/7EiJvDOgCqsYp6Ez+0HVgmQHsftfQM73NqeCd6VAAGOB8jzdTdO3742o+6RoHmj8S5sTCUnwKbiWpZxflg/65qLMp9726fyApgpq+/TV9tB4+Z0SxzrxlgqZsiS0Nkqd9x0YuoDs0ysMp5mIPxmSpVdbGEyNkkZCIQiYklTk46VQq9+qn7jndFLb/XtRw4hcUSxCqUSQdpjtLWZXFRRrA3bKhhAm0Vv9bmhvIH3lmwpUVOHyBTeGDH4+GinUA7X4FMwXS+qh22EIx2jGYeSubbz7LI7k6iEZ1P7HPedYrDuNTOqPOeg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Thu, 12 Nov
 2026 05:35:49 +0000
Received: from BL0PR12MB4914.namprd12.prod.outlook.com
 ([fe80::4921:cbe6:78cd:b445]) by BL0PR12MB4914.namprd12.prod.outlook.com
 ([fe80::4921:cbe6:78cd:b445%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 05:35:49 +0000
Date: Wed, 11 Nov 2026 23:35:44 -0600 (CST)
From: Vidith Madhu <vmadhu@nvidia.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
cc: Xaver Hugl <xaver.hugl@gmail.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
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
 Andy Yan <andyshrk@163.com>, 
 =?ISO-8859-15?Q?Michel_D=E4nzer?= <michel.daenzer@mailbox.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 11/27] drm: Implement VRR rate limiting
In-Reply-To: <20261105-vrr-limiter-uapi-v2-11-55f4215be2c2@collabora.com>
Message-ID: <ebaad99a-ef6e-3829-2c27-5ccd5dc1b498@nvidia.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-11-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To BL0PR12MB4914.namprd12.prod.outlook.com
 (2603:10b6:208:1c4::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB4914:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: aad75563-a42c-4be0-622a-08df407ecf1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|6133799003|3023799007|10067099003|261102130727099003|11063799006|56012099006|261026140227099003|261022105027099003|261102123227099003|261021135927099003|261028144727099003|261026121527099003|261009221227099003|261022075727099003|261021121427099003|261022113327099003|261021123027099003|261009223027099003|4143699003;
X-Microsoft-Antispam-Message-Info: t/iQ8nQ0wrOIwWAuwaA1zkfRa2I/3bMRpmKQ9nUgoHb4E5iojKl2wYK2l+dXKksN45QG8asVPqo8ErleamcEY5JWdIQaW8xReoqxItZ1uA8Ys1bM/zAOAeKkNwR2Rzziq2wLv6q8jBpk3o64FMBuQPpI/Iz3uQA4YvPPbHBq0Mxr3b/xwh3hmQ2EeK5Aa2SPlqaWjyFgdDX1PMpHTnaH4TLpETI3EphAJZARXlPzt1Xb0uBQD3mV8rFCSDQMDexqb5wzVv5a/2+heUBD5Cr3S6wJwDqEQ8A7SJookfDUdRaN8EDTS/3JeVyp4s67jSnotj0M78kJLGk1TRQI0vEpOXWsVrMR1s0Gldg/q9ql5VBJMCIsEOZLWGDAOoH+YkJ1p8GdhkkkFx6UXjTX9aX/Esr35OFhBXpKkKS6xkyhDrPeAZUJbPFCEZmNfjUuJjH63y/PXjl9fsJmg3m/7xGpzLWQvldcx6njxhliwfudvOub8HIfM5/mmTVo9asTNfDqiE3kAdCK7dvcSXLzN+HkxcLdSn/eQu1VzOTYGNohokW3pHwk0PrS9KIQ6AVmmfhOL9f5HsNqP5dUwMJwro+cXkXUu6n6kKgpB+BVfrgIKk2xbB3JMdVjh/BTRQ0sjrFhD1vTfprSjr69xZzNdJuIIK5Wh5Vzx2JdNi+DLcjzmdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(261102130727099003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261102123227099003)(261021135927099003)(261028144727099003)(261026121527099003)(261009221227099003)(261022075727099003)(261021121427099003)(261022113327099003)(261021123027099003)(261009223027099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4n8p9Ca2NXLVCCRHUUgGWbqG0wJCSY551jrRWf74ilCIgb3dxSJtljsA2/N8?=
 =?us-ascii?Q?6zMICMNNRM1p2sMG49cJcxZVKz85QQEf1nbu1rKEJyus0xOj0NnKg6AH/RVK?=
 =?us-ascii?Q?xggVFSg8u6gmUhOyVX1UPviI+ZDloTEepWiZ77Q7QXn/5QsPeYLaAtbb5YS9?=
 =?us-ascii?Q?i1tSKrUyFyPEjXWbLAZ+So2BJqBJg88u/wUKAau5JBhA3/n8A/66Hi42qCGh?=
 =?us-ascii?Q?XH5mJw4C+bWwhG9F39GvUkN6VWx9//PjwXHc4i/bPZWWZNsRJPdlTsTe0AJ4?=
 =?us-ascii?Q?r78CsujUpNqGmHi8dVlrXJhPG3Mq1Wv7YWEi7jljHVxDRYNqKLP9K/QZenrQ?=
 =?us-ascii?Q?Z6sDoeKAWMgIvKGgETTRqOW6LuJMr/CahUNXoFzbUtwQc5jZihI65AHc53fS?=
 =?us-ascii?Q?BjsGffY0BhX3TZMkjTb4C+lv5itb9uwqV8iyToJsa0WGRERm8aZyfURtWWIS?=
 =?us-ascii?Q?rfEDu+AeeebG27pSx40F5k4j42NmXFxFuTabWCqbxIzuv07wylFumnTJe5QP?=
 =?us-ascii?Q?mAid9Y8I3paHY3B9HJ4c/+cn9B52I9OVd+PO/QmEwO7SM5XjFK5xZSpIQ7u5?=
 =?us-ascii?Q?m0LT7yf2wr66VYZonpOiJiYDG9yL1FlnLYF/jFcaxvg+YbsBOSRehPnF4kdl?=
 =?us-ascii?Q?mHy87wHGJpdPrtY1x82Ia8tqKRcQagZfA6xug25gaV35HBuRQUo9Agvjhuuo?=
 =?us-ascii?Q?72UBXuvByLXLRbbwtB4XfbL4cUyOrUqwl3cu6YZz46RIubPCkEXTcNrwDLQK?=
 =?us-ascii?Q?SIXqF42SO637nHIGxxsZRdvwemrkD6ObmTHNCIYFF2TVQbNx1CTgKi+vSNxS?=
 =?us-ascii?Q?Tq1obWuwkiIn2jFcqqKpZMjxa544KDcsxvJTcfLlfxe3Cjf0IH1OQEJpmi8O?=
 =?us-ascii?Q?CZF6dLOAy5Emg6Qm0CXvYfhwVmwGg6Rx8xku0c1D/laNV7/Mmup5WyFRXoUX?=
 =?us-ascii?Q?sF1qWugQ7cf0EMpdeqUBoaU5lWIX37wFF8z8D+4KzNOK6wSN19quf/Yg5utO?=
 =?us-ascii?Q?CqLW+su9Azca4T4H0tueQXCDfyuwjB/kvwV1xhajbsWK6UPggpKDl6swdNS5?=
 =?us-ascii?Q?MPkNbuE18vsGKiQ6LRDuHYgTGqfGX60kkCwdAqjUk+6tA7HArcpxFQbJFG2l?=
 =?us-ascii?Q?4kbJbE4WHe3SBaIbj4jCHmFjrm7dDKtMNmBfJcX5KR7iFeJdwoYEvtdWD15p?=
 =?us-ascii?Q?JKws0gE9vvwgE5KVt+Rm5DiId0XDxpA2POGCwL56k1QdZLSm4Lbw2WbUivgH?=
 =?us-ascii?Q?xmylu4LI3Svq768pZVX7rlUhMNyDvzmjOeOQP7cYr27LXdbMYhj/PXaN5q0g?=
 =?us-ascii?Q?a/nTgup6Ktv+lOqhjHEFxmPblCpBKCdGMbjS0uHrzC3CxpGz2oHBTjNHqESG?=
 =?us-ascii?Q?OAhwL8wHDIcx2KwI8pmBreMKWRg2SapObNq160YVA7PW9KsyMvtCvtw+N/Yx?=
 =?us-ascii?Q?3HmPjsNtxAkPnTc/UfgweexopvWAkDjrmNG3elFY0mABf5TfAI900tabqsQB?=
 =?us-ascii?Q?VKhHyUqwykcSmPp4PKpk4Bux08L9tULXEUJiHi94GmlXGawHn6RsAw5Pln7S?=
 =?us-ascii?Q?F3al4oywlS0IP3tTrb+spj5N82EfPDNQLrpC0bcLuS+q+4ysZq6TIh1D+Zzp?=
 =?us-ascii?Q?E+9HWLDELaQghrKzZ/CrHaxUed58c0LbIwtv8XmrJzVokVNAsCal7bDjMezL?=
 =?us-ascii?Q?CqJ9Ei6vsCtbs6iP7K7bo3YLkNNeocAV4DO9ByemIQUSTlt5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad75563-a42c-4be0-622a-08df407ecf1a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 05:35:49.8293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sF+3qjLAx2ektGrlFawxRguBhZoJYigh9xYyWRJimIYtrfxeQqvjiEolRdNf0X8HdLQiGDkHghw6muTnErvpFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 5 Nov 2026, Nicolas Frattaroli wrote:

> Currently, VRR is allowed to use the entire range advertised by the
> sink's EDID. Userspace may find it desirable, however, to limit this
> range, or set a fixed target rate entirely. The latter is mainly useful
> for multimedia playback applications, where judder can be avoided by
> matching the content's frame rate precisely.
> 
> With the new VRR target frame rate properties, the necessary
> infrastructure is in place to allow implementing this.
> 
> Add the necessary logic to hdmi_validate_vrr, as well as the VRR
> helpers. Since not every target rate can be reached precisely, the
> per-frame error is calculated, and dithered one row at a time across
> subsequent frames. This means some frames are one vtotal larger than
> others, so that averaged over the frames, the desired target rate is
> achieved. Such dithering is explicitly permitted by HDMI, and is still
> considered a constant target frame rate.
> 
> Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
> Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 134 +++++++++++++++++++++---
>  drivers/gpu/drm/drm_crtc_helper.c               |  34 +++++-
>  include/drm/drm_crtc.h                          |   3 +
>  include/drm/drm_crtc_helper.h                   |   2 +
>  4 files changed, 156 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> index ce680eaa5047..846f7a72fddc 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -5,6 +5,7 @@
>  
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_connector.h>
> +#include <drm/drm_crtc_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_print.h>
> @@ -1051,15 +1052,60 @@ static int hdmi_calculate_vtotal(const struct drm_display_mode *mode,
>  	return 0;
>  }
>  
> +static int hdmi_validate_vrr_limits(struct drm_crtc_state *crtc_state, u16 vrr_min)
> +{
> +	struct drm_crtc_vrr_state *vrr_state = &crtc_state->vrr_state;
> +	const struct drm_display_mode *mode = &crtc_state->mode;
> +	u32 limit_d;
> +	u8 round;
> +	int ret;
> +
> +	/* No limiter, don't need to validate, but reset the error */
> +	if (!drm_crtc_helper_vrr_is_fixed_rate(vrr_state)) {
> +		vrr_state->per_frame_err = 0;
> +		vrr_state->cur_err = 0;
> +		return 0;
> +	}
> +
> +	/* Don't allow rates equal to or below the minimum VRR rate / 1.001 */
> +	if (cmp_fraction(vrr_state->vrr_min_n, vrr_state->vrr_min_d,
> +			 vrr_min * 1000, 1001) < 0)
> +		return -EINVAL;
> +
> +	if (check_mul_overflow(mode->crtc_htotal, vrr_state->vrr_min_n, &limit_d))
> +		return -ERANGE;
> +
> +	ret = hdmi_calculate_vtotal(&crtc_state->mode, vrr_state->vrr_min_n,
> +				    vrr_state->vrr_min_d, &vrr_state->base_vtotal,
> +				    &vrr_state->denom, &vrr_state->per_frame_err);
> +	if (ret)
> +		return ret;
> +
> +	/* Allow rounding up for the vtotal check below */
> +	if (vrr_state->per_frame_err >= vrr_state->denom / 2)
> +		round = 1;
> +	else
> +		round = 0;
> +
> +	if (vrr_state->base_vtotal + round < mode->crtc_vtotal)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
I believe in the previous revision we discussed factoring out the 
protocol-agnostic validation of the CRTC frame limit ranges properties
(e.g. checking against min/max_vfreq, checking for a degenerate range)
to the main CRTC atomic check path. Is that still the intention?

>  static int hdmi_validate_vrr(struct drm_connector *connector,
>  			     struct drm_atomic_commit *state)
>  {
>  	struct drm_connector_state *new_conn_state =
>  		drm_atomic_get_new_connector_state(state, connector);
> +	struct drm_connector_state *old_conn_state =
> +		drm_atomic_get_old_connector_state(state, connector);
>  	struct drm_crtc_state *new_crtc_state =
>  		drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
>  	struct drm_crtc_vrr_state *vrr_state =
>  		&new_crtc_state->vrr_state;
> +	struct drm_crtc_vrr_state *old_vrr_state;
> +	struct drm_crtc_state *old_crtc_state = NULL;
>  	struct drm_display_info *info = &connector->display_info;
>  	const struct drm_display_mode *mode = &new_crtc_state->mode;
>  	struct drm_device *dev = connector->dev;
> @@ -1068,10 +1114,14 @@ static int hdmi_validate_vrr(struct drm_connector *connector,
>  	u32 min_vfreq_d = 1;
>  	u32 max_vfreq_n = info->hdmi.vrr_cap.vrr_max;
>  	u32 max_vfreq_d = 1;
> +	bool is_fixed;
>  
>  	if (!new_crtc_state->vrr_enabled)
>  		return 0;
>  
> +	if (old_conn_state)
> +		old_crtc_state = drm_atomic_get_old_crtc_state(state, old_conn_state->crtc);
> +
>  	if (!info->hdmi.vrr_cap.supported)
>  		return -EOPNOTSUPP;
>  
> @@ -1087,6 +1137,21 @@ static int hdmi_validate_vrr(struct drm_connector *connector,
>  	if (!max_vfreq_n || max_vfreq_n > mode_refresh)
>  		max_vfreq_n = mode_refresh;
>  
> +	is_fixed = drm_crtc_helper_vrr_is_fixed_rate(vrr_state);
> +	if (is_fixed && info->hdmi.vrr_cap.cinema_vrr)
> +		min_vfreq_n = 24;
> +
> +	/* If the VRR target changed, make sure to reset the error accumulator */
> +	if (old_crtc_state) {
> +		old_vrr_state = &old_crtc_state->vrr_state;
> +		if (drm_crtc_helper_vrr_is_fixed_rate(old_vrr_state) != is_fixed ||
> +		    cmp_fraction(vrr_state->vrr_min_n, vrr_state->vrr_min_d,
> +				 old_vrr_state->vrr_min_n, old_vrr_state->vrr_min_d) ||
> +		    cmp_fraction(vrr_state->vrr_max_n, vrr_state->vrr_max_d,
> +				 old_vrr_state->vrr_max_n, old_vrr_state->vrr_max_d))
> +			vrr_state->cur_err = 0;
> +	}
> +
>  	if (!min_vfreq_n) {
>  		drm_dbg_kms(dev, "Could not get minimum VRR rate from sink\n");
>  		return -EINVAL;
> @@ -1098,25 +1163,64 @@ static int hdmi_validate_vrr(struct drm_connector *connector,
>  		return -EINVAL;
>  	}
>  
> -	if (cmp_fraction(min_vfreq_n, min_vfreq_d, max_vfreq_n, max_vfreq_d) > 0) {
> -		drm_dbg_kms(dev, "Target max (%u/%u) > target min (%u/%u)\n",
> -			    max_vfreq_n, max_vfreq_d, min_vfreq_n, min_vfreq_d);
> -		return -EINVAL;
> -	}
> -
> -	ret = hdmi_calculate_vtotal(mode, max_vfreq_n, max_vfreq_d,
> -				    &vrr_state->base_vtotal, NULL, NULL);
> +	ret = hdmi_validate_vrr_limits(new_crtc_state, min_vfreq_n);
>  	if (ret) {
> -		drm_dbg_kms(dev, "Couldn't calculate base_vtotal: %pe\n", ERR_PTR(ret));
> +		drm_dbg_kms(dev, "Invalid VRR fixed target rate: %pe\n", ERR_PTR(ret));
>  		return ret;
>  	}
>  
> -	/*
> -	 * Even at its fastest, it can't go faster than the mode, so
> -	 * clamp to avoid imprecisely rounded mode_refresh values we
> -	 * can't do anything about from ruining our day.
> -	 */
> -	vrr_state->base_vtotal = max(vrr_state->base_vtotal, mode->crtc_vtotal);
> +	if (!is_fixed) {
> +		vrr_state->dynamic = true;
> +
> +		if (vrr_state->vrr_min_n) {
> +			if (!vrr_state->vrr_min_d)
> +				return -EINVAL;
> +
> +			if (cmp_fraction(vrr_state->vrr_min_n, vrr_state->vrr_min_d,
> +					 min_vfreq_n * 1000, 1001) < 0) {
> +				drm_dbg_kms(dev, "Target min (%u/%u) < supported min (%u/%u)\n",
> +					    vrr_state->vrr_min_n, vrr_state->vrr_min_d,
> +					    min_vfreq_n, min_vfreq_d);
> +				return -EINVAL;
> +			}
> +			min_vfreq_n = vrr_state->vrr_min_n;
> +			min_vfreq_d = vrr_state->vrr_min_d;
> +		}
> +		if (vrr_state->vrr_max_n) {
> +			if (!vrr_state->vrr_max_d)
> +				return -EINVAL;
> +
> +			if (cmp_fraction(vrr_state->vrr_max_n, vrr_state->vrr_max_d,
> +					 max_vfreq_n, max_vfreq_d) > 0) {
> +				drm_dbg_kms(dev, "Target max (%u/%u) > supported max (%u/%u)\n",
> +					    vrr_state->vrr_max_n, vrr_state->vrr_max_d,
> +					    max_vfreq_n, max_vfreq_d);
> +				return -EINVAL;
> +			}
> +			max_vfreq_n = vrr_state->vrr_max_n;
> +			max_vfreq_d = vrr_state->vrr_max_d;
> +		}
> +		if (cmp_fraction(min_vfreq_n, min_vfreq_d, max_vfreq_n, max_vfreq_d) > 0) {
> +			drm_dbg_kms(dev, "Target max (%u/%u) > target min (%u/%u)\n",
> +				    max_vfreq_n, max_vfreq_d, min_vfreq_n, min_vfreq_d);
> +			return -EINVAL;
> +		}
> +
> +		ret = hdmi_calculate_vtotal(mode, max_vfreq_n, max_vfreq_d,
> +					    &vrr_state->base_vtotal, NULL, NULL);
> +		if (ret) {
> +			drm_dbg_kms(dev, "Couldn't calculate base_vtotal: %pe\n", ERR_PTR(ret));
> +			return ret;
> +		}
> +
> +		/*
> +		 * Even at its fastest, it can't go faster than the mode, so
> +		 * clamp to avoid imprecisely rounded mode_refresh values we
> +		 * can't do anything about from ruining our day.
> +		 */
> +		vrr_state->base_vtotal = max(vrr_state->base_vtotal,
> +					     mode->crtc_vtotal);
> +	}
>  
>  	if (cmp_fraction(min_vfreq_n, min_vfreq_d, mode_refresh, 1) >= 0) {
>  		/* refresh <= VRR min, don't do VRR vtotal adjustment */
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> index 4ffb3b0b7878..dd696f0c5016 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -838,6 +838,22 @@ int drm_crtc_helper_set_config(struct drm_mode_set *set,
>  }
>  EXPORT_SYMBOL(drm_crtc_helper_set_config);
>  
> +bool drm_crtc_helper_vrr_is_fixed_rate(const struct drm_crtc_vrr_state *vrr)
> +{
> +	if (!vrr->vrr_min_n)
> +		return false;
> +
> +	if (!vrr->vrr_min_d || !vrr->vrr_max_d)
> +		return false;
> +
> +	if (mul_u32_u32(vrr->vrr_min_n, vrr->vrr_max_d) ==
> +	    mul_u32_u32(vrr->vrr_min_d, vrr->vrr_max_n))
> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(drm_crtc_helper_vrr_is_fixed_rate);
> +
>  /**
>   * drm_crtc_helper_vrr_flush - Update VRR state on frame ready
>   * @crtc_state: pointer to &struct drm_crtc_state of CRTC that has a new frame ready
> @@ -864,6 +880,9 @@ bool drm_crtc_helper_vrr_flush(struct drm_crtc_state *crtc_state)
>  		return false;
>  	}
>  
> +	if (drm_crtc_helper_vrr_is_fixed_rate(vrr))
> +		return false;
> +
>  	if (vrr->cur_vtotal == vrr->base_vtotal)
>  		return false;
>  
> @@ -889,10 +908,21 @@ bool drm_crtc_helper_vrr_vsync(struct drm_crtc_state *crtc_state)
>  	struct drm_crtc_vrr_state *vrr = &crtc_state->vrr_state;
>  	u16 old_vtotal = vrr->cur_vtotal;
>  
> -	if (!crtc_state->vrr_enabled)
> +	if (!crtc_state->vrr_enabled) {
>  		vrr->cur_vtotal = 0;
> -	else
> +		vrr->cur_err = 0;
> +	} else if (drm_crtc_helper_vrr_is_fixed_rate(vrr)) {
> +		if (vrr->cur_err >= (int) (vrr->denom / 2)) {
> +			vrr->cur_err -= vrr->denom;
> +			vrr->cur_vtotal = vrr->base_vtotal + 1;
> +		} else {
> +			vrr->cur_vtotal = vrr->base_vtotal;
> +		}
> +
> +		vrr->cur_err += vrr->per_frame_err;
> +	} else {
>  		vrr->cur_vtotal = vrr->max_vtotal;
> +	}
>  
>  	if (abs_diff(vrr->cur_vtotal, old_vtotal) > 1)
>  		vrr->dynamic = true;
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 9004f7c2f21e..cfd051ccbd2e 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -70,6 +70,9 @@ struct drm_crtc_vrr_state {
>  	u32 vrr_min_d;
>  	u32 vrr_max_n;
>  	u32 vrr_max_d;
> +	u32 denom;
> +	u32 per_frame_err;
> +	int cur_err;
>  	u16 base_vtotal;
>  	bool dynamic;
>  };
> diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
> index 0c8c11ea36dd..7d7b75045bd9 100644
> --- a/include/drm/drm_crtc_helper.h
> +++ b/include/drm/drm_crtc_helper.h
> @@ -45,6 +45,7 @@ struct drm_framebuffer;
>  struct drm_mode_set;
>  struct drm_modeset_acquire_ctx;
>  struct drm_crtc_state;
> +struct drm_crtc_vrr_state;
>  
>  void drm_helper_disable_unused_functions(struct drm_device *dev);
>  int drm_crtc_helper_set_config(struct drm_mode_set *set,
> @@ -63,6 +64,7 @@ int drm_helper_connector_dpms(struct drm_connector *connector, int mode);
>  void drm_helper_resume_force_mode(struct drm_device *dev);
>  int drm_helper_force_disable_all(struct drm_device *dev);
>  
> +bool drm_crtc_helper_vrr_is_fixed_rate(const struct drm_crtc_vrr_state *vrr);
>  bool drm_crtc_helper_vrr_flush(struct drm_crtc_state *crtc_state);
>  bool drm_crtc_helper_vrr_vsync(struct drm_crtc_state *crtc_state);
>  
> 
> -- 
> 2.56.0
> 
> 
