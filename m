Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAB2D58CD1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 04:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AEF10E3B4;
	Mon, 23 Mar 2026 04:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hm87qYBK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W7+HWP2B";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C120410E3B4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:41 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MJGj7X4091856
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=L0DNNdGHDR5wlsCt28DXVO7/
 ykGGtL6iZ7ih/B1pDZQ=; b=Hm87qYBK6EpqLzvsAKKiVfisJdYCA29Rw9vKImJz
 lU+T3ZSsQtEyN0sicc1mVQfFiOJsMlFjJdAn1ibQornp8c+1tT3rdXIfazxKoT+0
 r3paTKRMYcrOnDzrgpbSpH8tw/vChxTcx0bH62Dg3aYq57KgrNidMW8QBuaISVjp
 9YDOiKfjC+4FZQ48QIHNEtaGcdKhYgUIL8v1syDcBi7YbkbLuQbMbfbS/qXtxWnO
 xii5Fg3z6LruZZPDsJ/9otr4vKpZK54kJwDez+Wlgw8qNYeYn6a45LXb7YJua2dX
 FswqKzTSGkiGIaMaAod2Kfk0A9WqVRW8/qqRoxGYxhQxuA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1h1e3sv2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5090e08dcfcso349814991cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 21:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238920; x=1774843720;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L0DNNdGHDR5wlsCt28DXVO7/ykGGtL6iZ7ih/B1pDZQ=;
 b=W7+HWP2BA566RV+D6jiReDCG+S90AjlYtFZl3p1X/usFYoWOSbR4WNfBkWWF5EwRKi
 64mdTZPjTSBVmg+6uRMNfeozumv5oIyrO3K4hD5VHMy9IzKVF9iShMwCvqFhdxcZA9tN
 BCrvUVoeJ+zCtN9ZvFqFarlsjG/EKPWdemMzQCoUG4qB4qRTHVFhkyn7g9LMKu79SOzc
 7cuYChX1pq+6C5u82DZLrPL8rtHBvRauIxP1300mrSO0/TjMPt1LulgvQOPiUrDHRj9P
 q8uI9OuADvbmroYtPk2vdEKDX+v/3i6J4cP1h+JD4ZweEu8OAjaSzbksj8esVksQP8ki
 xSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238920; x=1774843720;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0DNNdGHDR5wlsCt28DXVO7/ykGGtL6iZ7ih/B1pDZQ=;
 b=VQrmx1/MNrErQ2E22q0vkKGcZ7yD0CMVncCKo+cCmcJlQLDK7LDlJeHleaWuIs+NCl
 UL4byvs/HlRULRPkhEjqpmFwUp/+darD9u7LL7LkSgG4JzYvna2HREBoDE7AVSV9ECz+
 T+Y74qz8tIlNM9mEQa+ldLFGpwnu5m4P71LhB5o2vkV7z2VffPxZFKWRLLOJgwPPdEXM
 uoGCYNtUF+wZ47ACCxRNa9+e0bbFIWYvqI0nC/QMk9FfWpVnHv3Z1eJKfbIY7k6C6JhK
 iLTT/ra1OOa6yI8XFRnJ5BYC0hoo/uX4SGERj4ro1oT3AWfW2EREDoQ0nVwtGrmwXtlP
 p9tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrNgR/SVF8YeE+y1BzdBFbrr08XaOYw5aY0ooBKk46R+EFWsqniyLm6yZUTsGHQlQ+Qglxqo0tiJ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+zgJfuF/Phbnak8AlZaeoia68+W4TzWImpSHBtgcprKZnZk+r
 DB2XbSEpuxP1+um/xKFWBRqJF66cFzicvqvPvbsizewJrrcs4bm07QEs2qgTGC9Jd7+2vFI75oH
 bUm0OQ7tUTRlABCJ/u6BPAzoiKA5zW2nhuytW097f0Uur084fDLy2W9s7kJb3q2fjLT91xLo=
X-Gm-Gg: ATEYQzzLHoJzOrY5T4gsuNZO3zS9Ct0b7MlUIQ2FteA1+O9L/+F3BDLiM/OowXhy+5O
 PU28biGN9NkootFNbUXxOEsy0a7v14BcnrgUY+A3/6v6NVJDDxDIV6pZmZb9ubRK7Fv9oOZxD5n
 e9IWvxpUGxLxWUv4RWKazv5uX1BHcRu0QXnO0rlqBDMTnTQeyNJHpaQdiI9g0310ZEpaJbEPWwk
 xmQ33RdxHw6hffl0LbI5GBCqMSIACFDbHpJN9yoXW5iLMePgH8LgxyWCPjKg6hsOmDKSLOdYQ4P
 1VFvYSCA36ilU56tBizMdsSjlzSa9QbmVPXLtMVLMht4LhdFwF3bECilOH45YvDfKHclMHG2Nyw
 8wa+SjrdR7RN/lWisjhxEVkuube6noxRC77NnP0FBsDBmPQ5d1OAIDLFofr1PmDsgSD+quJYLqU
 Fx2XE6eZOpkocjOBu4yN/J+qAKFWHeoCjyOXE=
X-Received: by 2002:a05:622a:901a:b0:501:b1d8:637a with SMTP id
 d75a77b69052e-50b37597952mr157491901cf.61.1774238920220; 
 Sun, 22 Mar 2026 21:08:40 -0700 (PDT)
X-Received: by 2002:a05:622a:901a:b0:501:b1d8:637a with SMTP id
 d75a77b69052e-50b37597952mr157491621cf.61.1774238919820; 
 Sun, 22 Mar 2026 21:08:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285206f73sm2204742e87.54.2026.03.22.21.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:08:38 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:08:35 +0200
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
Subject: Re: [PATCH v3 09/14] drm/bridge: synopsys: dw-hdmi: Convert to
 drm_output_color_format
Message-ID: <dahh4njgirmhll7tttfxe6dlqaz5qhpyz7g2vztgvbys6xysyq@ord6abbyjt2i>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-9-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-9-f3935f6db579@kernel.org>
X-Proofpoint-ORIG-GUID: DC490rGZ38phJAdw4I9Arl-dr4xIalBU
X-Authority-Analysis: v=2.4 cv=epXSD4pX c=1 sm=1 tr=0 ts=69c0bcc9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TUq2ns179Pknwtu5XVYA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfXwdEyD4gFab2G
 teisIXqK3hMCU34SRkSBysmRWeI0jadZKH1ly8KDuw0At0fkUcJhil5v6F3t5MrFO37VTB3xIRI
 LNDYCMGEpwl96oBkhl91UDiMiTPbAgIbwuET+QZ8gxO8WY0DLTAIq/CEalzO6xypSSZ5HXQKqPd
 b26TTlJUp+QeLCr/XAWn41rNePnl7uWcHQAQfShJTUpcoAu1QLoTrGHjtwHgDBEwBXZbMwGM+u1
 bQ/TikgiBadttrMg0xE2JfwqI0yyFA94iq063Rg2lwdzz+hRq+9AkUuh3HshhDBjtR40cV0Z6d5
 fj4XB0/3obLjLfpxWpfb8mNLwAoO3HojWdPDjI2AXx62HvpC0u6+g9PqyVAgsThIh9FFdNd2J29
 vvvUJgHcNYIemTTwg7WKbmLq8jTpDUxEvurzmGeF8/ADIQ7/jWnkwR+o1A5KikedvblmIhK3w9k
 5VoICQiofOYzWPE8SwA==
X-Proofpoint-GUID: DC490rGZ38phJAdw4I9Arl-dr4xIalBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230028
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

On Thu, Mar 05, 2026 at 10:05:01AM +0100, Maxime Ripard wrote:
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
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
