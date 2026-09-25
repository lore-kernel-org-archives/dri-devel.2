Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43A1C98306
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 03:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F6F10E518;
	Fri, 25 Sep 2026 03:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lnCbgU6q";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D77410E518;
 Fri, 25 Sep 2026 03:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4lGgf3ageA9LZWjNWW/djHDWUJUso6sv9M6OraKDeTkEtpPGkYGf0JpnKUBYUXKbLOr5i9w4+INVQoLhZ5aP9mZdlz6s1HgNOzxdF/cG+6W3+prnEDBeQSBdAUvUGsVeD+F5CwUgOCM9h+AlpEBnb7BgBLIN2xOh2WV1MXCWKR5DB82JK5FrwDgQFI9rr1baz0xSZN2MurhoeiNCm8uXKvgwdsdOto5xze/jifWYnnU2UdrVBGsn42InWuTXsnpro8yvIhfGPGrmhE93+lYEJIjCeeQ6QC+WD/T/nPg6WKm1RriOOXNzcxeYkv30iKhw408IXBDNT6fEuP1LOCK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woQhDygZRnqq3mpxfJFy5+nbkVh9qMmLeuJAjO8IX98=;
 b=HeKQM7PTFQRQwx3zjLHbodK1RB6khH1lc7XNw7qPS/k3Cdpk7J0KdiaKZNPrDRAct9m3lBHm5r56vPLA6/vesZtayqx5wQgFKgO9w1Yc2fy1rDowa9DiA7tRXCnvHEI4GzTqDA3+/IPiu2Xh3QUvDjahvgaQg/q6K4Q5iwXtKuiiWtnCIUBplIe7TgobV2c+dCtxFfQRWw5+5AgqXpV9ja1xVC4F7JDlNxezcvE5whjzH0jimlj3hctvGhAQnMaPS0P6X4pPHt98h21NFG9XwnSPddhxT62ct4WX8F5BTbdyaElrQoGkej522HZ4GkssPTIBOcgT2EP3sstDjTRLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woQhDygZRnqq3mpxfJFy5+nbkVh9qMmLeuJAjO8IX98=;
 b=lnCbgU6qjjCj0vJCWh3Y5ztq8hpFkcwAmvqnRzcSFH5tUqt/jZEQgmAITlQWA8IiGnWuQNUIFZ6MvVJFzG20NVWLG+zSykczknHGXU99Y+kSegZTKzfG1lfU9edj5/80W7VJsnD4x/eHjzakgDGpXCUvLDak0UU1wp7CIJ2+U8PzN8SyVigNXL0Q0TY9aWhoYrIoQsjX33Q7RpGuuX2IJjQhHq9GvVOb6Sv+HILLFByVv7BojwcMTbWgaGpE07AG0aYIEHnAALqrHpS1YJATLHXrg4k8Un+uXAnVOiIt5sAkGPEtaTqmxBRKt/a0IEsdviUwP9VKfm3Exrfvtz446w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 03:49:01 +0000
Received: from BL0PR12MB4914.namprd12.prod.outlook.com
 ([fe80::4921:cbe6:78cd:b445]) by BL0PR12MB4914.namprd12.prod.outlook.com
 ([fe80::4921:cbe6:78cd:b445%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 03:49:00 +0000
Date: Thu, 24 Sep 2026 22:48:54 -0500 (CDT)
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
Subject: Re: [PATCH RFC 06/25] drm/connector: hdmi: Add VTEM EMP generation
In-Reply-To: <20260921-vrr-limiter-uapi-v1-6-2fcd7d011646@collabora.com>
Message-ID: <a5bc012a-9b9e-eb2b-d67e-a91f2d93d6bf@nvidia.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-6-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BY3PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:a03:255::24) To BL0PR12MB4914.namprd12.prod.outlook.com
 (2603:10b6:208:1c4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB4914:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 67861e9f-92d2-469b-2665-08df1ab7eeae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|5023799004|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DMlCuIILU5gYnDdrtKowYbX/GuxYTpkF7s8/NhC8ux5XSrPBXR0rj9ujRqlbHWcerv0vNOGMP0e6lNU008iA7flXQJACjsytOC4vmpc48rZZp3Ub+yVvu9Jc7dwHsYiUNyR70Cy4ary2+6yeorxx7UyUxG+I587AINYhb7Z/lra53Tv9DmSiULDu3SV8mBUMCBzJ7D49aT37SGB+BUhBibKBn9MiAMl55xUt/0fCrcYobAUQOUFohuR+P4KXedzFdWi7GLf0qD7pcHhzl7930Fd+8b3M3Eu9NtP/JUbkZkiln1HhzxU9+gtXSwU44uIk3wnvFeNOIO9yxG63bn6Ja73+99uhUx4jZzy2jLaqXgTsJi/z8SHoeel2+29uwmfq9oLuctao9B7EWV6WEuFsFpNqpacWY8EMGIj+6vZZHqAhb2XIq/YLCqP7tpRkC7zH2ZPMIdFyB0v6GK4xXAYGra4nLW34O4xczp/H2/2uK0K4w+3hHMjCw25F6U7vc7xE/Os8A48iqWUw1LJYJDGLm/xqr5bl0X6FOPRIrLyKQg+tPxaO3CjJvKTDDXLkHBviMnYKwrjNJGXmKrieTyO/RtwN+EL8bttxdoPLtlV91IPY3vDYFw3AvRTnV28dd/GEvkMzhp1uvIVzMt14mz4ZES2loSkd+23HFsh8Nv17Z5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ukvNWoKZ7SVC4UaMRGrm1lEcoWiR47fYeG1nes2FpXbfI79jWdA/jadOQQ9w?=
 =?us-ascii?Q?bkYz5HTe15U83l9pHBozOoHXNEu+oGUPx2s/LcGn3Z7a/rphVshWeMneecu4?=
 =?us-ascii?Q?vw+cMdFsP1rrK6o0tv8QWBRideKIupHOWxX36mZWdqgPEpmthAoE7ZfZPfMf?=
 =?us-ascii?Q?RHJgqSL/XflqbgpbJacb3zgRFOXIfNXqzez2xyWSml0LeKMzO8dfVws760bO?=
 =?us-ascii?Q?lb9qaxT9Duvk1I3Kk+y/Gwnur4t1ltbzEpTDUSqNtYX+NXyW98BROlRbGLd0?=
 =?us-ascii?Q?zrzQXXzanfK5HDFpzy5wNPMH8gfutm0Jb2hmWvi752NEJ+6Ar5Moc3pOHyRk?=
 =?us-ascii?Q?wgjYoNm/3Ru4aEhdbxCIUtL1eNGq+oPQ3i/3ZJz93oO4bTAtxziknB27AI4B?=
 =?us-ascii?Q?kO5nmBXYrqNTxXBNg3JMGMrf04xNNAfKqK5We3pRTCEHOC7dF8pi/0N3qvxJ?=
 =?us-ascii?Q?HHLlQi8M6iKzbG5zf6x6KYlF7KwNuyidsj1Th3o1vDGnql9PY3O5BhHef5UD?=
 =?us-ascii?Q?oYnCwxOdL1DHZrKNw2GHaEB/2EeZWjgstsL3GMaymDT8IDNbChLEpOd6i0kv?=
 =?us-ascii?Q?qBM5pfIX9RPyfh7fY1pg38IYemfcJ23ig+UFO3s/m+Z5M1A/nKvB8hdu6NOP?=
 =?us-ascii?Q?XZB8XfbFEq14/bOo1fQufhuF7NX/GxSDdPEGkcHgUgLrwilTEluEXoCMJLSL?=
 =?us-ascii?Q?kzxw5eOtqj63fM30lua/gJRKCVZbpcCeX+te6bCeocmJ4ZOZ8qcc5yA2r46o?=
 =?us-ascii?Q?M2xxKZSiLXWcTzULS4INo6zhCTeRnTtAnEAtK1I8rCyNp+RrLD8EPFSECqY/?=
 =?us-ascii?Q?35AuOQ8V7Okf1q+zuVZ+iZtyLm/yatT3+ymzcw/7ymgAITEx8uCxkV1e5A22?=
 =?us-ascii?Q?oZtHYX9oy2vB/UWRviVV9LpAEMaUyheLftA8qOpTdIqbbr/7z1X8Nhpd01Tp?=
 =?us-ascii?Q?JDWFjuYHJsAKXBF61htu07GNi23gDNJPkS5etPFZDG4SpqXH1zLZnbAbccIt?=
 =?us-ascii?Q?aGZBvoJltA/d0VBIghxCPR1M+HwhTeAf6sZF9K3Fz+ymQA8wpo5r1yr4oB4s?=
 =?us-ascii?Q?dpBNEYyYBox01hRrdFAFGaqkBEkmxXgstL1qbtxojP8Iyv8BiKtEdAXaBV7W?=
 =?us-ascii?Q?ParJAr5DffGlic1cU1T8/8e0vYTQMMWBbY6GkHnrlrKsTlsUAkiQWS/WPLZ6?=
 =?us-ascii?Q?0i1/d3ee73r/y9nrFien1oWZVjnzxDomuEfE10qoNZEmqHqCM7XnpHLatifX?=
 =?us-ascii?Q?q02msrPQAu9cD6FTKbJQVia4WhM8ZhqypFfvUXkICmgWErmFYfIbH3zmEyYI?=
 =?us-ascii?Q?X7sceAN78Bo6mmEfryvVK+brL7YjpL9a5EFVLsuot8zlivQp6JwQqReakjrj?=
 =?us-ascii?Q?ioYkwforOocrX54WFMVgoZExYChifC4MAtBWwNTjNq2jYLhzK8zWxFm0FZRg?=
 =?us-ascii?Q?L+zc3iam/pxiZsHGVHP1sF7DOHP8zGYBxLqPyxuac3WRzYBs46ztXzTI7hw5?=
 =?us-ascii?Q?l5VSU4b/GJiFlMgilwFDh0xu/ssOwcVH1DJ+/RaBtiYpPa5h7Z9OFcZwMimx?=
 =?us-ascii?Q?Q3i8t3W5uFjZq00GqTto7vdELRHvc3yunYlpUVws9h2AF2YeXAhQfAAoiPur?=
 =?us-ascii?Q?RUHhZaV3JMdxzywxUiJ03lHLdvvAg9QiqXNGSI3JkKE0Px6ZkYSNwhkxnMrv?=
 =?us-ascii?Q?r1G4t6Z9lQppM0gY25Yb5TYvLC4U35gY0GMWJkisPelz88aq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67861e9f-92d2-469b-2665-08df1ab7eeae
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 03:49:00.7899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNW36uIioo2K14jlnH5gBoROKzB9D/cKslDb7g5PnJvvFmIYAHvuYzI6yhyN1opsEyan557a8vcrLkvIwawzjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914
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

> From: Derek Foreman <derek.foreman@collabora.com>
> 
> Add VTEM EMP generation to enable variable refresh rate signalling over
> HDMI.
> 
> These infoframes are only generated if the sink supports VRR.
> 
> Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 60 +++++++++++++++++++++++++
>  include/drm/drm_connector.h                     |  5 +++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> index d55548399687..33d0c9491643 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -853,6 +853,56 @@ static int hdmi_generate_hdmi_vendor_infoframe(const struct drm_connector *conne
>  	return 0;
>  }
>  
> +static int hdmi_generate_emp_infoframe_vtem(const struct drm_connector *connector,
> +					    struct drm_connector_state *conn_state)
> +{
> +	const struct drm_display_info *info = &connector->display_info;
> +	const struct drm_crtc_state *crtc_state =
> +		drm_atomic_get_crtc_state(conn_state->state, conn_state->crtc);
> +	struct drm_connector_hdmi_infoframe *infoframe =
> +		&conn_state->hdmi.infoframes.vtem;
> +	struct hdmi_emp_infoframe_vtem *vtem =
> +		&infoframe->data.vtem;
> +	const struct drm_crtc_vrr_state *vrr = &crtc_state->vrr_state;
> +	int vfront;
> +
> +	infoframe->set = false;
> +
> +	if (!connector->hdmi.funcs->vtem.write_infoframe)
> +		return 0;
> +
> +	if (!info->hdmi.vrr_capable)
> +		return 0;
> +
> +	hdmi_emp_infoframe_vtem_init(vtem);
> +	if (!crtc_state->vrr_enabled || vrr->vic) {
> +		vtem->base_refresh_rate = 0;
> +		vtem->base_vfront = 0;
It shouldn't hurt to always populate base_refresh_rate and base_vfront, 
might be cleaner to skip this check.
> +	} else {
> +		vtem->base_refresh_rate = drm_mode_vrefresh(&crtc_state->mode);
> +		vfront = crtc_state->adjusted_mode.crtc_vsync_start -
> +			 crtc_state->adjusted_mode.crtc_vdisplay;
> +		if (vfront > U8_MAX || vfront < 0)
> +			return -EINVAL;
> +
> +		vtem->base_vfront = vfront;
> +	}
> +	vtem->fva_factor_m1 = 0;
> +	infoframe->set = true;
> +
> +	if (!crtc_state->vrr_enabled) {
I don't think we should use the vrr_enabled CRTC property to determine 
VRR_EN in the VTEM EMP. Transitioning the VRR mode sink-side typically causes
blanking, and it was discussed in patch [03/25] that drivers should be 
free to handle vrr_enabled changes as a seamless switch since it only 
concerns source-side VRR state (this is how the NVIDIA driver handles it).
Maybe it would make sense to extend the qms_enabled connector property 
introduced in this patchset to an enum of {Off, Gaming, QMS}? This would allow
a standard path to control the VRR state on the sink, separately from
vrr_enabled. 
> +		vtem->m_const = false;
> +		vtem->game_vrr_en = false;
> +		return 0;
> +	}
> +
> +	vtem->game_vrr_en = true;
> +
> +	vtem->m_const = !vrr->dynamic;
> +
> +	return 0;
> +}
> +
>  static int
>  hdmi_generate_infoframes(const struct drm_connector *connector,
>  			 struct drm_connector_state *conn_state)
> @@ -884,6 +934,10 @@ hdmi_generate_infoframes(const struct drm_connector *connector,
>  	if (ret)
>  		return ret;
>  
> +	ret = hdmi_generate_emp_infoframe_vtem(connector, conn_state);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> @@ -1494,6 +1548,12 @@ int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *con
>  			goto out;
>  	}
>  
> +	if (info->hdmi.vrr_capable)
> +		ret = write_or_clear_infoframe(connector,
> +					&funcs->vtem, "VTEM",
> +					&old_conn_state->hdmi.infoframes.vtem,
> +					&new_conn_state->hdmi.infoframes.vtem);
> +
>  out:
>  	mutex_unlock(&connector->hdmi.infoframes.lock);
>  	return ret;
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index e561a444515f..6e431eb81705 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1180,6 +1180,11 @@ struct drm_connector_hdmi_state {
>  		 * matching our state.
>  		 */
>  		struct drm_connector_hdmi_infoframe hdmi;
> +
> +		/**
> +		 * @vtem: VTEM EMP infoframes structure matching our state.
> +		 */
> +		struct drm_connector_hdmi_infoframe vtem;
>  	} infoframes;
>  
>  	/**
> 
> -- 
> 2.55.0
> 
> 
