Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C910FD58CCE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 04:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3689F10E3B9;
	Mon, 23 Mar 2026 04:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i7kecrEV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KgTGdoG1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0114110E3B9
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:10:28 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62N47rAK746966
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=sQGEJXGCGP1VT5nokRdn3QZg
 aBAAwrlU3lx1pdI7M98=; b=i7kecrEVBLxO1WNf+l5nmTc2n+Uzo/nysllO0FnQ
 hbeqyVQsO9lmxoRPFiatAESTJXCA8eVSpw5OfaSJbcdhkTF/N1TPrtV/f/q0FEYl
 VlWbN2Ms4pzCJGQp0A4A0hnIfUhYvgig+FROqZ3fKWWu8EjxjsKBg7+fzAaBis03
 GEkWpvszzEevqzO8lVdYQMInB4zOdGLjJgW7M8nsg0VsQnzLtoIKQz9qNccJz67X
 9j0TO8uUebepnxQM4MMlABNs6ApY1DEps+N15UmcVqtj2IaOXoHw/MG8hWlNRAfT
 vOekq4oJi59jpYJwBZnCYkszmNMG9AtJDnL5BsKdqUB9yw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jb5krua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:10:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b5f675be9so69248581cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 21:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774239027; x=1774843827;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sQGEJXGCGP1VT5nokRdn3QZgaBAAwrlU3lx1pdI7M98=;
 b=KgTGdoG1ATo6Soj3n+HFsZd0p6HKy/WN7/5jeuPIkwN9EKJUrOqCoxLtZvmRygDPDr
 2EL8VM/3TejFxPpd7/WK7ua1GhXXakJ++VX7137ZZLGwPBYWWp7TV7GYHh5nmssQTOwf
 sJTOpiArFjlBxXnpN5oq8Ie8EQwBszoPA+Yj6BI62Lp/Jmaf4niGRwdgXJk+fkmxD+l6
 lBEZeaNa4ETZFVfhu6UvsHu9i7U8Gvf03qEf9plm6t9uIMF6Q4yv7ajAaQJr5yyyxLDP
 c59cP84vXQ9/F0YdYqejG34pBTG6TAER2uDZ/v/1RGATfw5ByDwwxrbhxlolOQf6jHhn
 J/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774239027; x=1774843827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQGEJXGCGP1VT5nokRdn3QZgaBAAwrlU3lx1pdI7M98=;
 b=ZXQGrMUG7jtPlhK4Bokn1OTXlI5oagFDx1Z7+b2n3cWIRANsCeLSRMZGgzLozSfXlT
 rKpKTSVekeTCo6jpOdZXoMeExkbX+E5WEFVluWtZ34qv9P/aq/cl3MwlPtsC+18CI7pn
 r8MJP6m63hchQ1b0U1T1o4sA4iyvMewrde9Vqx5xOT7KVGuVjlZGb3NPlKhuqncGXNBp
 /ioO2LcZb1U0tA9lHY48lVXav6S7UNmgqkqu/dMfF3SDEm8+BXAd2qqlMVsRntZut4Cj
 s/T/eJWvIhOO0uI6wwDSpZapkbhIKqpwM2emJmcmc6FtgmM1LIHo0zMlgdKl7NzmcPZy
 wa9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjKwhEyf/6kLJoEKeboAhhtVgzvWe7l2dBWDqLax8gtBK0Xq2KHw5WeqkCUsTFTrRle12MgqVxMas=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxg9hltvHi9qSSlz1bUSjh8b2L2u/4QbpmukZhFC2odeONufgEL
 42hx4QcbPRIptsXlBKfXzfbPxE4vgqeazJVfqwanBZlEaF91zyX4rg48SWVUDemPN9GX3tfB4Gx
 /I9neBsTkOsLPIM8B2R/bgILfRVw1nlUVDjCZk3CkPLMT05XtTHW9KLXMMvCd8cDcCsheRiw=
X-Gm-Gg: ATEYQzzYhdBpdp+4eh7XGMtdZyJwfCxfJcFiAsL+K1OP+3IHVU9uxS/3DN6yNPWyuWx
 n2Fz0eT7KCS7klnx/UZKVSZf3wx/WcgV5axhLJ+ZD6K33YSu/sKqTYQFn9bV/RaItvQId5PEGLR
 PPujGatY1adu3VEsr34wpn5uz5EenqTbCrvnzNEtwFEvW2UMr4NPtLs4fuuIXy2/rOxhdxMQS9q
 MyHXd5vGS+SE99ueqfMLJA9t+J5ZtzJHdp6j2VgqtqkoNWf8lQkCr+xXVwY6FnCAvv2lsnKs1aL
 FXqzbys7Fwp88rW+HKFHvMiygc9YhRDwEkyVjCqoicyo8oM1ngdfX9HOCnjMxPM1GFD3HKkdMZ+
 X06LtYER8lK3m/XwAPYu6sty2cSHB8awcH5uNBegVa6jQ4N3kVDXt/w5i3+Un3jeBUxX0MhDkDP
 PtFyHfWof63e7h8EZIM/zCO1j/jc3nptv039c=
X-Received: by 2002:a05:622a:4287:b0:509:f36:497d with SMTP id
 d75a77b69052e-50b374a7a76mr157306361cf.30.1774239027585; 
 Sun, 22 Mar 2026 21:10:27 -0700 (PDT)
X-Received: by 2002:a05:622a:4287:b0:509:f36:497d with SMTP id
 d75a77b69052e-50b374a7a76mr157306021cf.30.1774239027086; 
 Sun, 22 Mar 2026 21:10:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285192b44sm2215746e87.5.2026.03.22.21.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:10:25 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:10:24 +0200
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
Subject: Re: [PATCH v3 14/14] drm/display: hdmi: Use drm_output_color_format
 instead of hdmi_colorspace
Message-ID: <gcl34au4vrbew3gtr7z3ui5tpkiehiatiicrawe7ls7ulq5vk4@tecy3vwgihcr>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-14-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-14-f3935f6db579@kernel.org>
X-Authority-Analysis: v=2.4 cv=aJv9aL9m c=1 sm=1 tr=0 ts=69c0bd34 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PZBe32_PtwNt9AllZ3gA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: FdILPcjSdcwxkuM3RJtqEymiWiTQ5e3Q
X-Proofpoint-ORIG-GUID: FdILPcjSdcwxkuM3RJtqEymiWiTQ5e3Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfX3mcQpEB11tbM
 gpIy2iyIvZpkVsI0JklMrrxA/xdpeeyFFQv0OoCfG5hknPNn1Mk3pD7bREn+lnmJO+8vW4HiS6H
 TcMPnZveTYCjIQn9MnLNxzHVSP4Zl1OWSVf2HoZMDkEyPOM4lc8Q/sXhPWf/zYKLeodda41h7X2
 BRBUWMRUvqOBxqX/qKRZrYLvhxL5WEY8RwEEfQqLtOg1ceK7cqHKt23ge9J+Sjy3a8mDF2gzi1a
 dzzxr9/G2SgdIjQhMxAl3P874+JLBRX3lnyas4TWhNyQ+Lg9ICVqribEo+iqY4xipLWslK4IJ2P
 Nhgfob2/zp0HRRYjI3esjXJ5H6FsnlTqzXLfjsPhtMs2fA7W0/Qc39ZtpG7jyEK+NYwIEUtVGRb
 xCuw87FE2EKnZyLJz/ZzCyDiqxF07bT2c5kSRNceK31graMps+IoE5VzTyLurK/uGf+cOGYl7ZY
 t191HPZrWEGokmgEoRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
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

On Thu, Mar 05, 2026 at 10:05:06AM +0100, Maxime Ripard wrote:
> The hdmi_colorspace enum was defined to represent the colorspace value
> of the HDMI infoframes. It was later used by some HDMI drivers to
> express the output format they should be setting up.
> 
> During the introduction of the HDMI helpers, it then was used to
> represent it in the drm_connector_hdmi_state structure.
> 
> However, it's always been somewhat redundant with the DRM_COLOR_FORMAT_*
> defines, and now with the drm_output_color_format enum. Let's
> consolidate around drm_output_color_format in drm_connector_hdmi_state
> to facilitate the current effort to provide a global output format
> selection mechanism.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/inno-hdmi.c                 |   6 +-
>  drivers/gpu/drm/bridge/ite-it6263.c                |   2 +-
>  drivers/gpu/drm/display/drm_bridge_connector.c     |   4 +-
>  drivers/gpu/drm/display/drm_hdmi_helper.c          |   7 +-
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  52 ++++--
>  drivers/gpu/drm/drm_bridge.c                       |   2 +-
>  drivers/gpu/drm/drm_connector.c                    |  16 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             |   8 +-
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   2 +-
>  drivers/gpu/drm/tests/drm_connector_test.c         |  80 ++++-----
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 182 ++++++++++-----------
>  drivers/gpu/drm/vc4/vc4_hdmi.c                     |  18 +-
>  drivers/gpu/drm/vc4/vc4_hdmi.h                     |   2 +-
>  include/drm/bridge/dw_hdmi_qp.h                    |   2 +-
>  include/drm/display/drm_hdmi_helper.h              |   3 +-
>  include/drm/drm_bridge.h                           |   5 +-
>  include/drm/drm_connector.h                        |   9 +-
>  17 files changed, 213 insertions(+), 187 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
