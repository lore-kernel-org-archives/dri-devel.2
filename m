Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45B0D58CBE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 04:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3558B10E363;
	Mon, 23 Mar 2026 04:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ozc6CeFD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GdTrAF8A";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0E010E363
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:03:13 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MEwfdQ1679524
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZjTWTO9LGKbNJnCdQR2t56Ga
 qKq39XkGtlvuZ5fybUY=; b=Ozc6CeFD6p1fCbrn7gsfAUtdjoYHKvbceDQNVeNL
 gdGiq572M53A7ankXVia7Q9sS7TX+Qu5iMKQjqtSw93u/AJzb2beekF0AydNlzh9
 W2SbJM4tROlHH2oUhRrdishXFoYahYu3BPMjSSHJca+vwzSbKmC8inVkmD/zcq05
 8inmKT5xjBX66/Pda5BYtqNzP0gLZMC5NlCLIt5NcEDdAnmabFiyp/YBPUQCcdDE
 rgWB1SvrJ9EsA9J3Mxy70Du2SDeI6qLM0fgsIUWErTgvZ0zp7FmeMkxRnbPrHW/H
 OCkQ/cwWHQ11kLfWcLankx3x2yH2KW6w4Kjo+PzgcEcMNQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jb5kray-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:03:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50917996cfaso36295901cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 21:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238591; x=1774843391;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZjTWTO9LGKbNJnCdQR2t56GaqKq39XkGtlvuZ5fybUY=;
 b=GdTrAF8AQ0GdhQdCU798KcEVonfkYPD9kM5mElBMm1PrNAct+FKhANgFxjVpkDgcRj
 ptLtzqg8QBk4J6RpEeq2+4oTWkzu/dJnujMq9NInqjkPG5CzurrB6zA29e8Zmk2SxFCU
 YZHKSDmk8l88L6asn+BX+AGT2lxd55gMzLBnx0Rg1yPkmMNxFQ582/1ZHp84edVDVJRN
 V+FOycdoZHimAT3L5G4MDQ4eLR+on9SO50RpqWVZXByIYbSXq9mRr6KbGfXhpLKdd6ty
 l6FcU+o+9FlL7e8V9rVDLTkuKwKDw0pKBd9vNmW+8JDu3vwmeRCggIl2oGLFdADnyRhw
 okjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238591; x=1774843391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjTWTO9LGKbNJnCdQR2t56GaqKq39XkGtlvuZ5fybUY=;
 b=EPnu8G4lsxiRqa1RT1CSLLk++l2A2D2UYA2B58r6YZEhqWVtYVw/OMdHLdwTrCeBa/
 cvfQg36o8ijn67ev5ZosQ6n4KaZVJkio5O+Yx1s4xmo5DQzr8fFccxrBnjy4hhlFyOho
 yl7aI/n8PyDq91xTPhIUDGg7jDQY3+REkIslw4W6FAghBtL8RJ4MXcoutcsdO02rOp20
 lFN5sgNcvUWXZ+HSHXwK8u3GkUsqpzfDIQQfrvEF+wde0b/UZ2vpWfhCyhNmY+AwycEn
 g429e+CrcPgy/R66nxWKiqHDoRob52Lp4nnR6GisfgAJITj/gQm7QKnX9YVF31TTIRd9
 RpxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVqGX5BLZUEGnmGVKC5tGNFFNiTRCc0mezlfHS3/6CmglcxIlIs6RC89Igd06/ApGhjVa+iP7cp08=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCy4B6QnhtGkxGZwquQK66KaRKV6AomGNEOGKqVaNb2Ph+qHX9
 9xYtKLU4eYpNBY7/Y4cPD8HoO7bUtQInDncp1VLE3AWRzLqn//I/7Lz4GPRAC3Kf84ebokG7QKb
 14C/qAppLBp1u/u7T/B/Y3U5yv0Kw8xispchycUu8eJbKuwYNglLGsEgsjm59R7UNQt9H+wg=
X-Gm-Gg: ATEYQzz7kTtzKEEtXaynlj4IWvyV8yJENvt0vRto9xvh8BOUkl5zPX1HAsgTn0Uzfwk
 M7kzwQ/Ey0ljUVSGMwX34aKl0/kYZrwfD5oIoSpWAJfZBZMEOGJm8n51n4wQ5KEjkR4DJEGL8mN
 4mnESDBhKctssKcIermXWTdyfEGLZzX++0P5vhjadUBjNvRz4dswHIiEvfF2OXZuUDM1o/vmnrn
 dhPEJJHHRJzdC4Y6v4OFYd37uwKNN/bHGen0u6wGyedeClg8qYLdXDn7uVrflqT8XMMvgMORGib
 CxD555ygTZPzF5XMOqNRnpRS5TwZWYJILSCIX3+I68S/rAw3ci6Yfe9pL1J91NiRItB4FgZya07
 +bH+ZJG5NHHCwSldb8wupc0v9yvKD/r9t4GcufD67bugP7Xon+ibbp1K0mITxCkeekWWuG8OxsS
 zzltCk4AIc+2gIaUsaMGVenptpODtE22o0cnI=
X-Received: by 2002:a05:622a:7c0f:b0:509:3c8c:2405 with SMTP id
 d75a77b69052e-50b3744f6a9mr130276051cf.28.1774238591445; 
 Sun, 22 Mar 2026 21:03:11 -0700 (PDT)
X-Received: by 2002:a05:622a:7c0f:b0:509:3c8c:2405 with SMTP id
 d75a77b69052e-50b3744f6a9mr130275571cf.28.1774238590919; 
 Sun, 22 Mar 2026 21:03:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2853055bbsm2240569e87.60.2026.03.22.21.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:03:08 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:03:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Liu Ying <victor.liu@nxp.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 07/14] drm/bridge: cadence: Convert to
 drm_output_color_format
Message-ID: <h5giabamrwbtuumue52iu45d2jiybcwbbw3r53modge2pfe5k4@ijprwzi2qx4f>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-7-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-7-f3935f6db579@kernel.org>
X-Authority-Analysis: v=2.4 cv=aJv9aL9m c=1 sm=1 tr=0 ts=69c0bb80 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=CFmvC39ClzzmkW9Sp_QA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: KTZXgZWdJ5W719NdVnP48UMuqUyqrucm
X-Proofpoint-ORIG-GUID: KTZXgZWdJ5W719NdVnP48UMuqUyqrucm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyNyBTYWx0ZWRfX2thV4Qs/CLwj
 j55coS2/RdpGFj0qjfiEQn1Czl+EqySarK+z/9xYaHQ979uyiT1ReveiRQ99W/wcKJTBdljrbBO
 GR3hOSj1dWksCv78u6M+QlS3WhhKhWY5iskuHzr+G3L97SwwJQOgKccpVdLD3e4MD4EmiJsZCaZ
 79+PTO4xtnvwJQ2mkQc9YbHKJr5FS/nQ/t1pgITpBMKiQwBLKfKnE+1Nwby5LRvVdA/tuNMmzw8
 p3aBaL5tHhJQx8cw9bHbeg9T6bcHmZVpUpRDCFEfefV1UldlIUhEgKdSkeU8iXw8JFFILkuRFG6
 Jx4EO/4k3kFhKUKhthWQvhv2HYXY7iBv3vBmu4oD91eKlpf0pWk++2bDO5iwm+CPsQjT4LWhlmN
 tfOVGRMwnEcP0A9wTq+6F9Yi4W/trZ4a0R3cCp9VZoCF3wGM3Nw3xQXlgvQhSmY4E6EnxYZjYXQ
 aHowI9JSowWwSYmCuLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230027
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

On Thu, Mar 05, 2026 at 10:04:59AM +0100, Maxime Ripard wrote:
> Now that we introduced a new drm_output_color_format enum to represent
> what DRM_COLOR_FORMAT_* bits were representing, we can switch to the new
> enum.
> 
> The main difference is that while DRM_COLOR_FORMAT_ was a bitmask,
> drm_output_color_format is a proper enum. However, the enum was done is
> such a way than DRM_COLOR_FORMAT_X = BIT(DRM_OUTPUT_COLOR_FORMAT_X) so
> the transitition is easier.
> 
> The only thing we need to consider is if the original code meant to use
> that value as a bitmask, in which case we do need to keep the bit shift,
> or as a discriminant in which case we don't.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    | 24 +++++++++++-----------
>  .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.h    |  2 +-
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
>  	switch (fmt->color_format) {
> -	case DRM_COLOR_FORMAT_RGB444:
> -	case DRM_COLOR_FORMAT_YCBCR444:
> +	case DRM_OUTPUT_COLOR_FORMAT_RGB444:
> +	case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
>  		bpp = fmt->bpc * 3;
>  		break;
> -	case DRM_COLOR_FORMAT_YCBCR422:
> +	case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
>  		bpp = fmt->bpc * 2;
>  		break;
> -	case DRM_COLOR_FORMAT_YCBCR420:
> +	case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:

Nit: where are those values being set? I see only the RGB444 being set
in the probe function.

>  		bpp = fmt->bpc * 3 / 2;
>  		break;
>  	default:
>  		bpp = fmt->bpc * 3;
>  		WARN_ON(1);
> @@ -2479,11 +2479,11 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>  	mhdp->link.rate = mhdp->host.link_rate;
>  	mhdp->link.num_lanes = mhdp->host.lanes_cnt;
>  
>  	/* The only currently supported format */
>  	mhdp->display_fmt.y_only = false;
> -	mhdp->display_fmt.color_format = DRM_COLOR_FORMAT_RGB444;
> +	mhdp->display_fmt.color_format = DRM_OUTPUT_COLOR_FORMAT_RGB444;
>  	mhdp->display_fmt.bpc = 8;
>  
>  	mhdp->bridge.of_node = pdev->dev.of_node;
>  	mhdp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
>  			   DRM_BRIDGE_OP_HPD;

-- 
With best wishes
Dmitry
