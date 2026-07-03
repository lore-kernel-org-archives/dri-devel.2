Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286F8C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787A110F822;
	Fri,  3 Jul 2026 14:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X+a0dWsQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pr6eJpl6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1E210F822
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 14:19:05 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663D19uu053953
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 14:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YKo6OPhVEgyLPX0yHK/easdg
 O+usCoQyvOamCjz3XwA=; b=X+a0dWsQ9cZuaaIyMj61+0hDJJZjyCRiqV/fZMJg
 dE+L7cUwNkPgEwelSfjEIG+7ea9v/gkwaIwvaJTiUF/lL6FWGSn1DPYWYtv9d5tK
 Q+ecSfKBk/yLVLIQBKxFLnhfn32t1/a9JPdfsf4bNzRSipOSWrAAo44yfRnV7f+M
 3E+Fds1MRs2t0WCK0a1cn06e22yQWBbA5S591GPqKd8Rdzv47tEJKWDeoU2dthkp
 GBbJC1i/3OzRAwbWPS+lRXgrA++g2Lkv5wmPHCrRmsHp8fRjlPTQNka6uwPNgKJV
 RJrUCeN+XZSgorizlNgs1FZ0QBiw2wmA6g+a85xmnPn5tA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkg801-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 14:19:04 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5bbd3241499so400604e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783088344; x=1783693144;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YKo6OPhVEgyLPX0yHK/easdgO+usCoQyvOamCjz3XwA=;
 b=Pr6eJpl67M2XqQgG2a0211RTiVvy53XJlOYL0sO2uZ4T5BJcNnHmIZa3fKq/CPik2h
 iKVivSNIHtVmqIQGwnxDp6rJ22/zsnUJf8oBVDip+T9Exci2lcom7OlhFPSLL5OlImyJ
 r52c7PGE+od0HJzl7URkpyVQwQOaXIZdYpqSM8TSGfa7jQ2wjf+VgH8pTZ+heAVP6OkO
 ceYAzBs8VRHyQbgxW0C1OccuwDwkic1RGbMH73UUYw1MZ2e3Fg/PTvJ0W7Uh6SHomfKT
 O8ZNqn7xWK0PwLjdAhToxhLlvanqK1ZRr8SE8GVRn+jLC9j5+GELZxxJT2YV2ffDDfYA
 PEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783088344; x=1783693144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YKo6OPhVEgyLPX0yHK/easdgO+usCoQyvOamCjz3XwA=;
 b=ohUjgfBPBQKiLpflmS2DRCjeBNBYXCX1NbLpDctV5maTlqC4B0dFRpofJHNOQprTLu
 a3RHhwEQ+XTVk275tFiKHyKrko6OB1nM9aBRtiJDhbDfUbJB6q4zorFnOKx6sj5THLef
 nVaN6IRHd2kss4cwGWXrqDBbkpE+SenuDK5+egQtXFibemgtgXMLbi4AUA+n0RWd55SS
 qLlTWJvaHfvAtQVu+QUondZljDW7FJ5XcpeZWHOCjcVaC4yZj0m8042rzehtjOGTaGjB
 7r6D9H/2G6M956MvwjVqCUDYHlQmGSs1ZmrNodw0XRtsNvpR7CzIX7gydDP6GUURMTB1
 6TcA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFYP1rfos0ZHpO3/Ge0Hzeqaau5ONmxTPunU8K+/l+eKOjvkmiBoqw+PhFYcq5EIWnesAbqmLE9HA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXPSrVvRrp7hKrio1UpGYVtYVPBbQWBtwF4BqDusimuYFRcemL
 t+AWkNOBJ5WSuoEBM2pbbcpwqFn/8vupWPyc+2+0Eu9XwK+dOr5idrEKvlBT8u42pjiW+cHl2tu
 U4OysL/4tbduCCvDsi5r18t6pUk0Cmqu0RMu5BdziUgr8lqlRZXOZwYVD9G69GZymoTZBnM8=
X-Gm-Gg: AfdE7ckDJeRU5yaDUKSAa1xDmmjXv3q4s+eydxummwLeF8Z3oJROJgbEXJn+SSJkqdy
 kasG20s3WJ4z6CC4XAYuVRhflAq9uAHvhyt5V1k9DhxnH5W4OHu0yi9Fw7Xz2Vaiz8nCiLOPJ4J
 8tdbVBQPb3l9RhX94EtB9cD6Xo+w3YRwJQ8VOY3q+PjCTlS0s5Bc9rWmIdfoh8NiA0ShckRubJj
 sFl0clwkpeFd/b+1so1D0ECmbZ/AdW/d8hCc3UadtMZIhq64IMS4rmLF1i2TUN/ZZwfdvgtJy3w
 y4QgQ8KiDZ/8qWyTV3fd7F6XlEN0xunZEgXHV02nS+MEI+CA/cDyCrGr7JqD8qsqekS6O5wavoX
 L01k6UDAKb+SYvgloTk+B6F+S6hqY7BibL/O3A1hbEeoGXtrj/HY9HpxR6ASNUiY/qhYMon3KPH
 DhxtFLb0IeGTFdSqWb5E3vjIGe
X-Received: by 2002:a05:6122:8b0f:b0:567:4e8a:fb13 with SMTP id
 71dfb90a1353d-5bddf5de64amr4308828e0c.8.1783088343877; 
 Fri, 03 Jul 2026 07:19:03 -0700 (PDT)
X-Received: by 2002:a05:6122:8b0f:b0:567:4e8a:fb13 with SMTP id
 71dfb90a1353d-5bddf5de64amr4308805e0c.8.1783088343359; 
 Fri, 03 Jul 2026 07:19:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed1377180sm514920e87.33.2026.07.03.07.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 07:19:02 -0700 (PDT)
Date: Fri, 3 Jul 2026 17:19:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v8 03/39] drm/display: bridge_connector: Pass HDMI
 capabilities through caps struct
Message-ID: <eqnr2hfclbdkry2jqe2kuufss5kus6qpjblewq35upnjwlhxhl@4awqxpwrnxk2>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-3-d79890d00b6a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-3-d79890d00b6a@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0MCBTYWx0ZWRfX6VR+Z0mPg8UN
 2ytVZZAyE9cbCivCLjXmAfvF1JCJ2jcjUowedaN/D6gUub9tqHy8X2fgGn3QB/D9fS/ex88BYFM
 h4Q3LkB7U+n2gZyaB2i1EYQeB8EZIfvFDbFOPrpnGI784Vd4Qzjdeu3y0AVumrmfir1GUHM8bsS
 /RqaVBVJBbxvfemKFlP/64olXwZgGKMz0ZtNeYhfoCEvj1DJyvPPNf5fDKM3eD9R6d4NnGmR2Ow
 hbzbBBFJQpa/a+9hexAcQ65T69uB96mlX2/MDVgTMwIx7883ju1do5MThwJtn590B9FV+UKEZUd
 FXidnIIxDf95sxdMseVZr2qlQtsMm/wBoXem97oDYDkOb12+P1sYphI1UaDjRgGgZQDrUanNPb0
 QRrSQm74/yMP0KyEy2es5Aspar0/9lP/Vgk6bfQe10UHNrjyvJlpGgaaiCrH8G0+ldE0TRGHy30
 GVlhzXhEo5LmA77/tfg==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a47c4d8 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=QX4gbG5DAAAA:8
 a=VsKdElH_S0EtIKHoY5UA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: ojGXE4UwDeojZt9n5Gb-MV48G56XPQ_I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0MCBTYWx0ZWRfXwFlLvRv/fsvu
 XpS63d5Q862TORqjdGgn1DGF3xp8lRIeVr3E91I3gONoAWPI/6PZcZh2o06I37jEcYoUBvo0xZI
 gH17Ui8O4rMkZIuEi6WGSapw9x6GDB8=
X-Proofpoint-GUID: ojGXE4UwDeojZt9n5Gb-MV48G56XPQ_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030140
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

On Thu, Jul 02, 2026 at 05:46:16PM +0300, Cristian Ciocaltea wrote:
> Switch drm_bridge_connector_init() to
> drmm_connector_hdmi_init_with_caps(), collecting the bridge's HDMI
> properties into a stack drm_connector_hdmi_caps so future HDMI 2.x
> capabilities can be plumbed without growing the argument list.
> 
> Introduce struct drm_bridge::supported_hdmi_ver to let bridges declare
> the HDMI specification version they are conformant with, and forward it
> to the connector layer through the new caps struct so HDMI 2.x features
> can be gated on real source capability rather than guesswork.

And it's left uninitialized by the bridges, which doesn't mean anything.
If you don't want to touch all bridge drivers in one commit, please
provide some migration path and hopefully get rid of it by the end of
the series. At least, there should be a drm_warn() if the version in
unsspecified.

> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 29 ++++++++++++++------------
>  include/drm/drm_bridge.h                       |  6 ++++++
>  2 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 92f8a2d7aab4..796069dbf1a1 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -823,8 +823,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  	struct drm_connector *connector;
>  	struct i2c_adapter *ddc = NULL;
>  	struct drm_bridge *panel_bridge __free(drm_bridge_put) = NULL;
> -	unsigned int supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
> -	unsigned int max_bpc = 8;
> +	struct drm_connector_hdmi_caps caps = {
> +		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
> +		.max_bpc = 8,
> +	};

I'm really not sure that we need separate caps. But if we do, it would
make sense to embed it as is in the drm_bridge instead of having the
scattered fields.

>  	bool support_hdcp = false;
>  	int connector_type;
>  	int ret;
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 18f3db367dc1..2d8b5e4c64ba 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1176,6 +1176,12 @@ struct drm_bridge {
>  	 */
>  	const char *product;
>  
> +	/**
> +	 * @supported_hdmi_ver: HDMI version the bridge is conformant with.
> +	 * This is only relevant if @DRM_BRIDGE_OP_HDMI is set.
> +	 */
> +	enum hdmi_version supported_hdmi_ver;
> +
>  	/**
>  	 * @supported_formats: Bitmask of @drm_output_color_format listing
>  	 * supported output formats. This is only relevant if
> 
> -- 
> 2.54.0
> 

-- 
With best wishes
Dmitry
