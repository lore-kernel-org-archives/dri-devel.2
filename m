Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576F606A324
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dR9VBBX7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD54F10E4D9;
	Thu, 12 Nov 2026 06:18:39 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01D7B10E4D9;
 Thu, 12 Nov 2026 06:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twN1qiGmhTKcRdK14xaii7vjLpn5dgWxrtFzq+4AVxtTGz5HYiE4pthVRZISwHFF81SkLUwgMDlSGeZWE91YCucOFkn45hSH8QCWWL2aYBTwj4iNXChz4Omlw5kmbtEqlk32GddczijcdvhNdvHa0Jvd8+e6BcqbmmX8hGxCfu/m/T/RLH9uwCeyX73TbO7Aq+5LwuGtDc5IGR7/2HWZSjStkg2L5JdpUfi84Paa7mUSjDqa/r9o6/dmFywz+XvTBv13lurOc2aNlO0U7x/Re6VnCyHYfMyykfR8nS/1j+DugNU/aO77EwOM1K6rwItawCTjOB+itKZn7/ad+EQtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQE4wH07HskksBy081BLQaHeHPxim4J9SFvGunClQ0Y=;
 b=MRnXScW6mPKbFIzgSFV/cXS5kQB1QMw9irpNj+7NNTrT17VkmsBqrUQr3frn4ma7t88MTUqCYzQHxTN5J+6oYR0zF7uZywUcBeQbjmUxkxi4cMq4qxsR0BkXAvHsr1lM6Mj/Sgwy6Ea5DQGAiBtxA+ZwPkQNrDWvlvU7WZYo1oTT0Ayb3nYswag4ADtb0rrDwJ/TpDLtN0LDYUr0S0vaAue5IJPhjqVlejcs1It8Z+xAjXERSZfMdBIZ4xAvXtWoAcLL1ivSb23XCmdA1ilmKJtdZJ+jNS3AQo+OkkfkVRmNRgJqis/wjDbxwBDFJHYfqMMSY5g/kbcM+m0hD7+I1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQE4wH07HskksBy081BLQaHeHPxim4J9SFvGunClQ0Y=;
 b=dR9VBBX7mRwx1MP721tQC3kEQJrAguuugeEmaGwArivsBf7ZhGUandfkA64RGDkrT7QTsc3iRyaPVdH8Sc7o/Et0WCWwKg84chXAugmctJTSWiJHYr5laxZemIL3noYi6TCOeECoWXW0NPqpj5Kk8z9YYa8iqBRAjODYWEq7jqutH5zjfiNFqW1l2ebTxbC9yd0xW6Gqlxh3xEFZAX0qT6+65eM+vg1D907O67jCphhjEP4QpQ8xehu1HlYc573wl62b+jqwzBKJyInEFq8O8ojvKqXpP68DvcoRUgo0SV9LhG60TgvzG4NFCdkbEgE6spQf2DdT/bvOYsMmluBmtQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 12 Nov
 2026 06:18:28 +0000
Received: from BL0PR12MB4914.namprd12.prod.outlook.com
 ([fe80::4921:cbe6:78cd:b445]) by BL0PR12MB4914.namprd12.prod.outlook.com
 ([fe80::4921:cbe6:78cd:b445%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 06:18:27 +0000
Date: Thu, 12 Nov 2026 00:18:21 -0600 (CST)
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
Subject: Re: [PATCH v2 17/27] drm/connector: Add "Media" VRR display mode
 for QMS
In-Reply-To: <20261105-vrr-limiter-uapi-v2-17-55f4215be2c2@collabora.com>
Message-ID: <3e4c8552-5dc0-f189-dee8-2ca0ebe01629@nvidia.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-17-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ2P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::19) To BL0PR12MB4914.namprd12.prod.outlook.com
 (2603:10b6:208:1c4::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB4914:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ecfe5f-0317-458c-7b36-08df4084c373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|22082099003|18002099003|261021135927099003|3023799007|261022105027099003|56012099006|10067099003|261009223027099003|261028144727099003|261026140227099003|261021123027099003|261102130727099003|261022113327099003|261009221227099003|261021121427099003|261026121527099003|261102123227099003|261022075727099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 7ap2RKfZ2jcc2TKYc74ETJo5FWJy7Ez5VkBrUV47LZyJLPolXpYt0MNL41Q3GrAFWPPlhoSOXxRoBX3xHHWy64zretiEGQnFaZX5GEwSU+ci3GpoEeVUYQKfMf7vwV43wSlNyaOJ2+2g7dwoMyrO2SkRzwtHp2HEk0Gk0wmIB0QBglQe1q6lSdxeBnLNwnqCDYZgM1YLADnb8Xyw+NMXcQMRppPjH0aeNHFKUg6ALgvr0wJt809yKGGi93X3oWB+0evf/r+CCLVjsEJ9H1xOwbGHvG4bu9FIoEkMYuTpxlwF3uzVoCE+gH9YH/9amt5vewtVmbHEkMmZrJutZDDAJhC97DoKLPaOT+hu6qxKGhfAlg+EGiclk9c4qKmyYi3pkDI9DzsLuDByrLDUH9mUG3Gk+aTUYyLz6teLEZZ3NUfagvLFPw5zIEowCSiRj0A8XU6uYsHTnTY2j27Sq7VJKK6NVNsEtctYtCKro3dGuLpNQsffA65QWI0lDLUBrdb3OecQixF33A2rOg7y/jn7GoziX3brhUk+YaCcJb6RoUxK2x8Bon5Fg8JiPSMvwvxA68LNDw9fOh5P8u6J+YT1X0jeFDCcQiRsvB16swGDPU0T7EEvIrE/RRfcZmj8/TNnl6AT9fCgnJ52AYdKSGwF47vAJwsK5W8IbstP5l3BEKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(261021135927099003)(3023799007)(261022105027099003)(56012099006)(10067099003)(261009223027099003)(261028144727099003)(261026140227099003)(261021123027099003)(261102130727099003)(261022113327099003)(261009221227099003)(261021121427099003)(261026121527099003)(261102123227099003)(261022075727099003)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rs1j8hAfNwBmcKnIXuQbZ9L9SrX3EUhKTzgXBp20Narsv/4SeSgkKiZXG+5A?=
 =?us-ascii?Q?cUq72M4/TXnmCBXNMsnRSL4bEUwtRVugS0EnbaOMMSZrc97L80ytDtKTq8rW?=
 =?us-ascii?Q?WjF2q99YyQuMIe3VCTDNlTAU9fMn+QFnG59OshmKifnC/5OooIUSPKPTb9eQ?=
 =?us-ascii?Q?xo2TADD5z4Dmsa6pRawvJgu88g7ixDPcKdj6yQ6JahMkXEBFW4EsfServuez?=
 =?us-ascii?Q?aYHtLSREE1KbEy1HbLS5izLM4+hqqQTYwAP/KymHzco4r3t0yUh5JfPpcOlv?=
 =?us-ascii?Q?hGP9p1PAs2Awfx/e8SpTXgQuiGXdxuEPfmJ+wB1KBGGOspWVChwKdKpSbpYr?=
 =?us-ascii?Q?ZfvkIKUucumNh+cMsvIJOcje3gqutjyCFj+VBa8DoaykwMrEUyk/7ymPmm02?=
 =?us-ascii?Q?Yq9MkzkZUkifo6mrFJAwPcavXQZ1GKs5VEMvmIeCO7f315xvVICqlJimJRPJ?=
 =?us-ascii?Q?dDF6lMSTonGYVdrneBiD7D9Wb8HXvmiJwZalgpk4ytOyQjR+JZbz5pymGmcJ?=
 =?us-ascii?Q?zFu4DoL9Ej3UA9MTlOOJYDcFmLkcXnKbpm2Eet7ZclZ9W1d8WyyGvHs3AP6N?=
 =?us-ascii?Q?hQ9899JFbnYHfsZAPbwwUALni2TPx1vWcsTfldB0xOsGqMhpSf4KaNyFLJvW?=
 =?us-ascii?Q?h1p+xfnGN/DQN6LnI91s8vj/Aps8MWAMCq7Rf4bNVaOVBA+4SrETxS5nNQ6u?=
 =?us-ascii?Q?hfNjVyJ6P6mkpRjGZO3cPMvgsemshzU+weL6gqg0h9nUR+X7fPDZHusNG0t4?=
 =?us-ascii?Q?CMXc9931078YHXu1Q7Wo8lkUKyALGIHvXxfa+8Dm6lH56ELBzzCFB8DQgLpj?=
 =?us-ascii?Q?HwwMYljpbnLtxh2SjeUAALkXj2RorpygCDaZGh6Rr3fjiKHlVC/GkcD1y9V7?=
 =?us-ascii?Q?PO+dUWHWpsWeJyfJjSVihQ9vq840SKNVyXl0EsOLlUxnE0BLQKSXhYwguZiN?=
 =?us-ascii?Q?JgGHSKa7CRZpBsZSaW8/a3jJJ1zKIMnddwUCYGyBsgEJxHCjvzN3dVKYahhs?=
 =?us-ascii?Q?8xgiEHVRsjLbwuls1/XGKQHBIMMIXiKQZv8qhZZ5PsgPLYknUZ0fQ0gdCsfc?=
 =?us-ascii?Q?uVwns7Uxm6MfKkp2muj5O02TCNQca5XDhuEdK4xqCvDQ7yXw+yq/Z0kSoqZ1?=
 =?us-ascii?Q?OYSJn+NnqYTEqjpc9sCdDL1wXHAP/pDsHfoDXnPkehG6A41sXVw6VffK6qM0?=
 =?us-ascii?Q?X+hVqkZC12QYbXahxI1eQFL+4HolfB5+iwRgs8DPGORPs6cej76bGQ+Lwmbf?=
 =?us-ascii?Q?MyB2/QgMj4uBsrPIibmQVYlPbiszL1vdhSreycNk5Rdib/JeYftyVDFS/a5a?=
 =?us-ascii?Q?Df9wt0ZWgB2U9vQAY1HT8eawC8i5pgWDqsddXt4c3HXYzvwwJ4zo1pAdafV7?=
 =?us-ascii?Q?U+13UTpfIk293Nv53oiCH7DZvFVnEcNy/pJGATUS+mdScJS7TALGqyiK+XvY?=
 =?us-ascii?Q?xF8YQQ4qxnYe60rSjX86LjHe+8MwnPmhzk+u+XgJrKkdPpntBOUYsFfSsvCe?=
 =?us-ascii?Q?IkOj1Mswxt7gpL6jjDpLHCuoO6DyFvXyRfi8DebNfJ2wtwQbAkwHzDupQesE?=
 =?us-ascii?Q?eIDFo+Cj1391tacjX8gLa9+A84cvpd5U5xmJqyO0VvQq5n6PQuI4tin2/D2+?=
 =?us-ascii?Q?2jWARmvgLqlO3JQAS+p0uV+UhAl195T/1GKkFeLPBbWSQ+Oh3rr/HpeklaV8?=
 =?us-ascii?Q?nv2FKiJjcgPyNl0yR7yRYwko4BzfXCW2BOPMku+x7tRAfifD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ecfe5f-0317-458c-7b36-08df4084c373
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 06:18:27.0615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/8BAtq163Nr/aODFj8mnjYBYgPcKBqI7V2bVt/iZeh+2mBzt7XrjbIUjQDlscBZmwA08CsZBqBmL5mefkhXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604
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

> HDMI includes a feature called "Quick Media Switching", or QMS for
> short, which builds upon the existing VRR to allow for quick switching
> between a select few common frame rates.
> 
> Add a new VRR display mode, "VRR_DISPLAY_MODE_MEDIA", to the
> vrr_display_mode connector property, in order to expose support for
> this.
> 
> Additionally, add a boolean flag to the connector's HDMI sub-struct with
> which source-side support for QMS can be indicated, as well as the QMS
> tfr byte to the HDMI state sub-struct.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_connector.c |  6 ++++++
>  include/drm/drm_connector.h     | 14 ++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 21222214a843..f7d619926e2d 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1456,6 +1456,7 @@ DRM_ENUM_NAME_FN(drm_get_tv_mode_name, drm_tv_mode_enum_list)
>  static const struct drm_prop_enum_list drm_vrr_mode_enum_list[] = {
>  	{ VRR_DISPLAY_MODE_GAME,   "Game" },
>  	{ VRR_DISPLAY_MODE_OFF,    "Off" },
> +	{ VRR_DISPLAY_MODE_MEDIA,  "Media" },
>  };
>  DRM_ENUM_NAME_FN(drm_get_vrr_mode_name, drm_vrr_mode_enum_list)
>  
> @@ -2593,6 +2594,11 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
>   *	    - Game - set display to game mode if display supports it,
>   *	      regardless of CRTC state
>   *	    - Off - set display to VRR disabled mode, regardless of CRTC state
> + *	    - Media - a "media" VRR mode that only supports a select number of
> + *	      common media refresh rates as fixed targets, but does so with
> + *	      possibly better display-side processing. In the HDMI display
> + *	      protocol, this is QMS (Quick Media Switching), though the mode
> + *	      enum itself is vendor-agnostic
>   *
>   * VRR Limiter/Target Properties
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 4801bb2769e1..41f272afbb1e 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -829,6 +829,8 @@ enum vrr_display_mode {
>  	VRR_DISPLAY_MODE_GAME = 0,
>  	/** @VRR_DISPLAY_MODE_OFF: Turn off VRR on the display */
>  	VRR_DISPLAY_MODE_OFF,
> +	/** @VRR_DISPLAY_MODE_MEDIA: Protocol-agnostic fixed rate media mode */
> +	VRR_DISPLAY_MODE_MEDIA,
>  	/** @VRR_DISPLAY_MODE_COUNT: Sentinel, not a valid mode, keep last */
>  	VRR_DISPLAY_MODE_COUNT
>  };
> @@ -1241,6 +1243,12 @@ struct drm_connector_hdmi_state {
>  	 * deliberately not requested by the helper.
>  	 */
>  	bool scrambler_needed;
> +
> +	/**
> +	 * @qms_tfr_byte: Target frame rate byte for HDMI QMS, or 0 if QMS is
> +	 * not in use.
> +	 */
> +	u8 qms_tfr_byte;
>  };
>  
>  /**
> @@ -2270,6 +2278,12 @@ struct drm_connector_hdmi {
>  	 */
>  	bool scrambler_enabled;
>  
> +	/**
> +	 * @qms_supported: Whether the connector supports HDMI Quick Media
> +	 * Switching (QMS) on the source side, irrespective of display support.
> +	 */
> +	bool qms_supported;
I'm not really understanding why a source-side capability is being 
captured at the connector level. The way I envisioned this is that
source-side Media-VRR support can be determined by whether the driver
attaches the CRTC frame limit properties. The ability to maintain an
arbitrary fixed refresh rate (implied by attaching the properties) should
be the only QMS-specific requirement the source needs to support.

Thanks,
Vidith 
> +
>  	/**
>  	 * @scdc_work: Work item currently used to monitor sink-side scrambling
>  	 * status and retry setup if the sink resets it.
> 
> -- 
> 2.56.0
> 
> 
