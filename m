Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA05FF8864
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 01:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D6B10E9E5;
	Tue, 28 Apr 2026 01:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UZaArr+Z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OO9TBPSm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D247910E9E5
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:40:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RHNx0b663244
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9m9p8k8igO9mcKqpM8R3r1LN
 43MMOEZgkj/ZwEMZ0vA=; b=UZaArr+ZaWYpiX9gsgLyMDjQLtxwvv8e5gqil9Lc
 BJrvIQVaGRgGP/+SWlFiRgpJbu9q3kAT9H6P7S+wmnCQWY4bB19PG2D7RPKeEpT5
 34iXPMXgsZXy3yGqIbnVQYKm6jax8/QFNU9NpkXw4CPM01OmohSAZW4/Bv3h0GVx
 yMNTwoCvV9mgYVjnUnsJPOk/x5tbD+RZ/iTQiJre3GRb6KSY1dnlTIbG3Mnkxr+4
 YUBvifD5McgbN37KQmQX6Ezfv7GC3ziuAY44DdPpzIdZ7TjAeQe5rxOXfbZ9cx3N
 246Db2GiaFwjNKOHJiTLnS1g5WQBgViHuV5mirTiYITZaw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n1m6d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:40:17 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-56f71e90581so8904805e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777340417; x=1777945217;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9m9p8k8igO9mcKqpM8R3r1LN43MMOEZgkj/ZwEMZ0vA=;
 b=OO9TBPSmOZ9ao5doghB9SS8QBds2R0odGw0QwU2Zgs9Rr3U144xpfp3ylHvjcdxU2m
 dCJI9hdaVv5ZXXu09IPRFVfUQ+6gJ/2iAJjII4HwRQYcjnXN4XG5S54arwqRoeEz+rkI
 pzYfeFao4hDOUzPYig6bpxxreSqv5Qa951A5hxlOtwvuj8J8opeLhwFbtUeWOgERujs5
 Cq53GAUJVsHA9I5HYzA+Y2Wasu80C7HB6UocvVO5f+t/BhlujRobFudp1n9PKrSO5I/o
 uvPVesxpYoxQfFSxlnxzn6/L4M7jILyxMSWnTT7RBslK+nABq6rMZPbv4svuSjla/iP/
 dIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777340417; x=1777945217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9m9p8k8igO9mcKqpM8R3r1LN43MMOEZgkj/ZwEMZ0vA=;
 b=TadWAOJx30jumwJwTrvrPXZRNTAaUbcgAyszXsn3Pvtl+8GS+MnRU7vCsUP0KLyP5B
 yHg4A4GfySiVnOAAhWzWswHFvssdDqYKmepl44Xi2i24zDrl2nZM0qHSXk0ACeHOz2Pl
 PRllkTMhTH3jnhDDB2WQviK/0WgfMxpnbqUdcSMvZKF8eDvbFrBDs4oJTys2EexFk8ct
 KHI70lJbf9ab0Q2QXiP2oSRslQC8KmUyiEV2k1WOOxpJiMu6ETc2gwDFIO3pO0CU63tI
 hKaDgz8yFIhJdXBGqnCXrOQPT9nT0Lb+tDALFu3nxuWgkiGwbE78OCoPQQj00yStBlyp
 POyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vrJqCSN9r+vzGK+27vgi5o7DMQxd9vWIb4d89eeNXy/hqVic/HOEpKhC+/nslUGAmrN7DJH5s2XA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyT1WtGRV2mkDKvb00ECSJm2IOAHYJ5DhlziISJZt1aJbbQ+wvu
 viopqHu1N3TLoqX9Vl9aT+HWZ+pN+yYk82lZEA3W4qjjmbdAsRQZ8b4U9zkMpGK1akvZdewa7z1
 vduYEhrtnBGNVA97i4EQjptnDISReIQ9/nzwD9tht3ZP1cyoUwApAdY8ot5oeM/6leEKbeW0=
X-Gm-Gg: AeBDietiBQ/9MblwmEwDPjwrc2x6qcNxhWM2X6SFgv4tbm2Q1TzlxNy9XtbB00stGWn
 kIWSSOz+J0ZbSG2FqNbrdhJPJIzUXzJ2Dx7DnC3JB9S/TKhlUwSMCVfJuTrUEfAJ3ioK4M5I8vp
 zzVeSm/4oTORHtCefv9DSljoYvrzZLiJD98GQCHMjqxZHQs/ib5qOOO4D8kBmxfclbhWNfYfAnU
 CjuIwoFCwX1k6rExc6MCVz8hOh329US93gkdxde/B6geLIz9dbECOPEfeePtlJbqFLzAmGCTVoX
 +GcjNc0RyA2kikBtbXfcH1U6SyKCWzmhhz7JhjRhciu6dDkh4lNHo1DGwravAolNfIUc7EtLsqX
 C2U/nmjzdoJz708TQT4P81M6Dq+fNF3PfXrfhlzhrFlzemLSwuQq/VAeE2N8A2S61YPt+BQGPL4
 3P1brrfHtkaCZkrmU8qQ8QppImQU6mgRGbVPb3It2ojKlaJw==
X-Received: by 2002:a05:6122:134b:b0:56b:8e1c:582d with SMTP id
 71dfb90a1353d-573a56ec536mr488134e0c.14.1777340417228; 
 Mon, 27 Apr 2026 18:40:17 -0700 (PDT)
X-Received: by 2002:a05:6122:134b:b0:56b:8e1c:582d with SMTP id
 71dfb90a1353d-573a56ec536mr488106e0c.14.1777340416627; 
 Mon, 27 Apr 2026 18:40:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3923f55f0bdsm2693041fa.30.2026.04.27.18.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 18:40:15 -0700 (PDT)
Date: Tue, 28 Apr 2026 04:40:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 07/10] drm/rockchip: dw_hdmi_qp: Add missing newlines
 in dev_err_probe() messages
Message-ID: <6ud63tddjz6ztmnifaocerrowml6ut75ciakaj2i7t7be2r7is@dsgdghnieyqs>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-7-d778e70c317b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-7-d778e70c317b@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAxMyBTYWx0ZWRfXxRlR+7807WOB
 KQJTTe5xahUtCp0IZdjmJhppCDZswMLk39mAL6BYuGI/e/xtvrHORctM0LhHgR7qcQT2uy9yNDE
 57ZFZHogLkj/gTpKUOLipRu2Q09cWAwzQXGJw7uzi6c+mrilHeajnLcFmDuS3qi7jjsOqT98NhH
 9CBDfMDdkXjTWf7Au2VQH9v9qthptQBmlSPwa7H09f9+W2UN1RSvEXUUX9rjJhABRP9kEqfjkaT
 OI3O0zBaR/w5x1nnHpL5x43vI+rYof5PWQk/vvM5UGc9ScQgH5p06K9CN4qMNSLnPb3kvSMzc1q
 Ft+EmQFN/oyP68nfnggtTkAhUAHcp/RNpiyw9rYRcRZm27ihEViaw00dwUOHrELPBDWLL2nC74S
 eH+1TLcGC+RGubvUsD7Zeu2QtTD2j8e1sk5RbzV+91VNMihqmKTllF5Vkyn7UgsQszWcpj2uq5h
 5shnzDDzXNyefQLMAyQ==
X-Proofpoint-GUID: lv_Od3db8-c2QGBzwKnaNsWxbXZeRqYC
X-Proofpoint-ORIG-GUID: lv_Od3db8-c2QGBzwKnaNsWxbXZeRqYC
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f01001 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=QX4gbG5DAAAA:8
 a=yOO0I3MQnx59eK1zbP8A:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280013
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

On Sun, Apr 26, 2026 at 03:20:19AM +0300, Cristian Ciocaltea wrote:
> Add the missing trailing newlines to a couple of dev_err_probe() calls
> in dw_hdmi_qp_rockchip_bind().
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Missing Fixes tag.

> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> index c78db7f8ab6c..d9333ad8996b 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -589,14 +589,14 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
>  	drm_encoder_helper_add(encoder, &dw_hdmi_qp_rockchip_encoder_helper_funcs);
>  	ret = drmm_encoder_init(drm, encoder, NULL, DRM_MODE_ENCODER_TMDS, NULL);
>  	if (ret)
> -		return dev_err_probe(hdmi->dev, ret, "Failed to init encoder");
> +		return dev_err_probe(hdmi->dev, ret, "Failed to init encoder\n");
>  
>  	platform_set_drvdata(pdev, hdmi);
>  
>  	hdmi->hdmi = dw_hdmi_qp_bind(pdev, encoder, &plat_data);
>  	if (IS_ERR(hdmi->hdmi))
>  		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->hdmi),
> -				     "Failed to bind dw-hdmi-qp");
> +				     "Failed to bind dw-hdmi-qp\n");
>  
>  	connector = drm_bridge_connector_init(drm, encoder);
>  	if (IS_ERR(connector))
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
