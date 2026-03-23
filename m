Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EEFD58CBE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 04:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7261F10E3B1;
	Mon, 23 Mar 2026 04:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PJM5pA+8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iz5cwlvg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2AFD10E3B1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:09:00 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MAjW664045054
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5mLU7+MItDUu5Kth0lmGo6bE
 IH05p2nnnuPD4hW7xVo=; b=PJM5pA+8Rt+CP033st/WkGLskaoVd4kJ2BweO5Sh
 6RXUql+pqIyx8wo7KPHvogwy6ApWsQP1j0BPMjHgC1FBuyJnWnDgW2r2qI7TsUqi
 lqzMi6Ml1Ye0E10VE5n9jF9747H3vVQdENdPz5e1lV/gR0rao9xzqK82jWN3s8zY
 C+68PvP7iz/GbY1epbq9ej2RUlYmh+SJRFqMpVgU56cyWBwYsxkWmqfOrwhwjY3i
 yPCb5/wgJW3JLgpswMvct5EcWgxjtBFZLI9fRkVcdwy034NKz7D/cgD+XC6BYRHz
 bujwB1nCbXbN7gV/TlGRRsS6Fwg4gNHT1Tg+H3k8z7G3yA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kq5un31-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cb706313beso529309585a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 21:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238939; x=1774843739;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5mLU7+MItDUu5Kth0lmGo6bEIH05p2nnnuPD4hW7xVo=;
 b=Iz5cwlvgxFAEKDlinCt0BDySwju4SEmPy1pgWGQlBZsmL0Qlm6xRF8YBeFedgWsj8f
 3SNAE4XPKOkFg4mK09zNLkIWlO2Xyp27DR1BSwuNKBsQX0/IsWRwK7XrQO1bENpxQsKy
 7KASWAQ68zvFJGnoz6D8W+QEitIJvwqoZlHQBUyG5hDYkkEdDz8sQjxw6nDoYNzJm5B6
 MvnoZr/XcDG6xpaOcivId5eRse79dVRL37DvpgVCBLCONfoFX35cf03BwIyJQNdYM3vB
 S8NnNT5ufPvp6IwXJe7GNeWVqgIKsyg6Llydw4i5idf+VsN4+E2luxgOgOIeA5B9fl56
 Utiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238939; x=1774843739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mLU7+MItDUu5Kth0lmGo6bEIH05p2nnnuPD4hW7xVo=;
 b=X1i4wVTBc41m1ibsC8Lrib+hr0P31Q4oBWvbekUSl2jBXGf7Kkgmqe7FbSMTsd6+nJ
 9K0RBwfBCVeGcE5FfbAo2KXC0hZ2yg7U1xRXIy0m2paLejKD2pU/aEzI7u2yxJw0dcvP
 DLhsNcZEPsxD+Nyga/c8tRbIt5qURlPYU07TcgliwM0uy/IzuOK3uRQgXz2xZTOnIhIG
 G1ivAaHxCYbFavxh6lmPePD3KK8hiFMKJ0ZRegNAc5Pj8ATAjpVLFd+wlSGHjzpZHLXs
 87iMvTeaqHoZLBGwSKlI8zUagoHOoMW8XbNRBxs301JQfsp5fVUywhoQnS4K/8uwtsK7
 qw5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIl8xC4GEnZOAhVqi6OeIQMPCmfT8xGNS+MNnp91pm2qx7QwexYXcg6KrcnTPS3mFWMYgG0Lkn1rs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxXxvXCKVLmPxLX8IZElPfNa21f4vX5OXoJq3aMInZDhTfJlxG
 hI0u+9Y/kSddgK1nMMzRlUp4D0ryKXuk5R/OVncyVGPYRC0rX1qIY8dGWprvaM6F87EETnDk+7S
 6JWJCh8Z6vOe+rm5v+hjdsNlBo3Mh+8h7DmaweSk69CNF3fBLavN4TNj54FgzTuB6zi/zyow=
X-Gm-Gg: ATEYQzyIfK246d3/WVVg1VQW6fPhKObjbZxELoEHKuQ9GK6TlkOR1JDYId/YEgA3Xo4
 620BpTvs6hRjW+J5taRsqRjVOAtPdme+gzu6zzRddi9u5DN4En5WNJ1GEgr/BJwvY7kL8pwmsvn
 C54lNNBKhFs1S9IupnB2Om24lNbmzjdlG0Y+8s9xZbw2Kge2DI9T/0GBAsJ3MaI0ogbwR2FMG6O
 91TsdIGZkXq6XQ6YC0cojtF5D+PYgXGUFvRl9zj5fJsFvdHxXz3AVZsIuiucJ9ETampWeB25zwl
 kuKgpDsbH8pPpX5Gn4kLnw5TwNaRJ8gAm0HvoNsD0JEj2FMhiJIf67IVyOoJtOlCNP3itlzw/qH
 ocEN9FpNBOolYHLbIficRHI2n1oHvXzhAm0Pz+07Tc0PP9qmP3jtilGCoKh++89pZj3b6YX62uV
 mMj98HhiSflCXo9k1W+DexeT86QUWJSyuxMvs=
X-Received: by 2002:a05:622a:2288:b0:50b:55fb:1c87 with SMTP id
 d75a77b69052e-50b55fb20admr59359011cf.5.1774238939269; 
 Sun, 22 Mar 2026 21:08:59 -0700 (PDT)
X-Received: by 2002:a05:622a:2288:b0:50b:55fb:1c87 with SMTP id
 d75a77b69052e-50b55fb20admr59358441cf.5.1774238938791; 
 Sun, 22 Mar 2026 21:08:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a288268a0bsm1994449e87.14.2026.03.22.21.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:08:57 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:08:55 +0200
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
Subject: Re: [PATCH v3 13/14] drm/connector: Remove DRM_COLOR_FORMAT defines
Message-ID: <lfq2myl6gnzog33md2madm3qky2x4sasbrqkthhvdvgtfigrjf@dc5ccj7iq444>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-13-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-13-f3935f6db579@kernel.org>
X-Authority-Analysis: v=2.4 cv=GNoF0+NK c=1 sm=1 tr=0 ts=69c0bcdb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=z8SGupnk27XsGNPOeu8A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfX9+2ReOT0P3sQ
 F2SaQnbVW8m1e1glO+bkpaON9WcnfE+QbsR2RQNrZZKdK9o16bZ+w6A+5UyPd7l3CJg3liprlRs
 gHedMh8U/a3fK/dY3MeNKkiFkLIO7geD/c0ow2F1Vjag94urN5Aix1Z4Seye5zQtHPWjHJA/HnN
 CoZ46UPlM+QiWyMX+r2jJ7UDZMSrk6n+3kATe/uTfapC0hrtWOBjYXhN1avnEcYlssdjM1OG6JJ
 kOp8X8YSq9ZEXkm1A6/cz6y+uWutId9+hw0Vh6QBsW61V53pjS6ZkPk81v+RcDvISNtiJ6EiyWC
 lEfPWPIFUKHN/nPEBHXgd4VsyU/UwjSX++4/wzIJ02FE+QRzyHev/KKMecfwaYHqypFx3i9R+FR
 2vz5DwvND1p0FmoZuqzZofGub7BEYFdStm02ywXxHO8V59S34kULXp+aoDyPRL5uDIU0ub+Zb33
 VSYwtAamDfErMRov4CA==
X-Proofpoint-ORIG-GUID: Q9C4dmAWpq7PVOWqvmnbTxEH_UVCR7sQ
X-Proofpoint-GUID: Q9C4dmAWpq7PVOWqvmnbTxEH_UVCR7sQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230028
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

On Thu, Mar 05, 2026 at 10:05:05AM +0100, Maxime Ripard wrote:
> Now that all users of DRM_COLOR_FORMAT_* defines have been converted to
> the new enum, we can get rid of those defines.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  include/drm/drm_connector.h | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
