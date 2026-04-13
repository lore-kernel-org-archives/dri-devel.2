Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F450F34C78
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA01E10E4EF;
	Mon, 13 Apr 2026 18:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hjbZNO4Q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UauUa6y1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE1110E4EB
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:01:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DF5pAH3751102
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=RrgntLZaILeSjci3xZg8PBfz
 PBDaxQ/Aw+fi1cSA980=; b=hjbZNO4Q9bt4h/2K5hMOt14QfyAOqVQt5MCjIkup
 9siXOZX6diiUjWPHX6nHDCjw0+xVApMKOpQI4O+oC6Oj8RUSh+3Qok4H/d35fr+J
 62rsGvOkqgdG87A8D7CIJ0t2PTo9S7DGMeQmMqG1BuHJyY5gVJmFgf8Cv3LXSrVh
 rQTqfAc87o0a3xj2aVUWzgOAB6nEEeXJw2colnA1gmAqQFjYn+8tZ1Drh2JrHOUY
 m8olujJBYOnDeQM2z64twFi9HD8PxrnbK2aLJK1hqF7WW2sLlw26/CpCpkDcUXUw
 RiN9OVcN9jXa7XrXmiQthGd4DY4fTXnZumqk7t4tEXjUxA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh2tu8ma8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:01:41 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-47545742e67so6568226b6e.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776103301; x=1776708101;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RrgntLZaILeSjci3xZg8PBfzPBDaxQ/Aw+fi1cSA980=;
 b=UauUa6y1tfOxNZPMrl+oSxIKKKNAr/KHE4Q8EGDsrpe2JH9cvzV+hTXOT+YUn1C91K
 +HyeSAvzYqEV+bJtponAvj+yDboeh/kjU2w4Q7BOvFyQZfup1bUtCk80YJt+nEZ1DuR7
 t6QQL+b1GfrA6dz6ErdWE97po2UxRNy9Euj6TfrXXAD6OnFzYsfjkf24BOb/AANAAKvo
 KsUg5NwN+myzBwgRLgaXf0EyuEcEG6TruHrn9MqoWJAnHzBLdjnEGs0TOopDfhsoYIRq
 /QafPeERJkzssUrSvn1O5nrcTqr3JD4lUiD5gqnAR/iJB5I2UPcC0M0zAOR4ZG+vn/rE
 Gi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776103301; x=1776708101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrgntLZaILeSjci3xZg8PBfzPBDaxQ/Aw+fi1cSA980=;
 b=R4DrDBL7qxfJ8bwcLTk/Ot637kTkyHQyaHS39KCNxaNDJRGvAsTGreIQmHuvm9ArpF
 IWA3CGvTqITv8rLr2sD3nDp6jwycGKfGtIAdfoYcS581SSgFGzZ/49HyzDA2laHOm4tc
 d/7WjblXH+5YU4j336tfBhk8ni5NRBWdoPEJehLtQuQ2AhFZftr6a0Q4/SlW8aqQ1qKU
 YiT65/Kv0AGI7PTPFPgOTnrcEU7gwuAtzCnSPZS0kD6kCkbWq8r01/WLjqBlMhTLpZxV
 EbHJvk6V3WTKATux2Cp/x4/gHzJ1mK+9fQTntRQl+qdavGsE4foIkGEgnrD9Y4beTCHg
 vJkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ849WOam7WGhwDJDNVWEJszwP4O5a3CH4nvCHZzFgbILDfSRAC7dEuYRg2Drszyhc8caX6l88IAZew=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8qME2eUir7A2R2ZSqCSh8jnSDhSV5sDB/1cEX8Bea2l6x4Gf/
 jxRh+q+KfKAWY8qCcmdJLHSuoVJy+pJqXqzxrzoUYOQwKwE3uX7ZC3XDFEzc4Jzd8BzX41Ug5v2
 TNBQmvPuksfLtBLqmU6n/4mU46QZBi5xAB+HRprUwvQKrdkdHJjy8Yb9wocK4r/iPBWdJh1o=
X-Gm-Gg: AeBDiet2o8TMyiNMIYPVfq6/7UcBRUMTm7ZrQ7fUFoEJ0kCapc2uoR49yPI6UIJtjQd
 tZWmEoVDTZ/q64pzDnNC70pESTgjRdfcqF7aG6l2C/eyHAn29R8dQX4RbeXbqDj2OwXmqTLDWu5
 rHaUHoEaazF/6R4xcAnzupFckpS+JzN3P0DhooHWBOmnUHaGNJb5xpzd0GED+PH6Rm+Xcw9KnqD
 gc/GJuZGMhuLyKvouHCdOQsd3FJy+BudH50b9PL2jdxZ6ebceCNxiDaBUkIjGQ+Pg/gY6c36GAP
 vfXCQ5vFJIYvwoMDiTWDwzSupxi9xgRIZsF4zUWZ4Y7mV7F4HzZzMGy6wBpKWYRcKPMnft+8xd0
 iptnHmkLuEUD9DPbH1+If1CQyMZw8pQsD5gA24/0nlq9UJGotjvI6tqBKM2eiXRNPqbDiNgwYUu
 9h0pqteEvZIi7nc2N6OrR+c1ioNzb5Yo7Vw3lDp+w0u+/GbA==
X-Received: by 2002:a05:6808:c1e9:b0:467:fd08:2826 with SMTP id
 5614622812f47-4789f30c472mr7094112b6e.40.1776103300581; 
 Mon, 13 Apr 2026 11:01:40 -0700 (PDT)
X-Received: by 2002:a05:6808:c1e9:b0:467:fd08:2826 with SMTP id
 5614622812f47-4789f30c472mr7094006b6e.40.1776103299515; 
 Mon, 13 Apr 2026 11:01:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e492710ccsm26015781fa.7.2026.04.13.11.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 11:01:37 -0700 (PDT)
Date: Mon, 13 Apr 2026 21:01:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/10] drm/bridge: lontium-lt9611uxc: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <rivgablnl6s7u54gyv77vr5pitlvvgzby7qnu4ryc4tttaqa7t@hztujmxw5njt>
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-5-acd01cd79a1f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-5-acd01cd79a1f@bootlin.com>
X-Proofpoint-ORIG-GUID: nHFaVFZTtvHcxPJC2gfNhflYgKkzocsG
X-Proofpoint-GUID: nHFaVFZTtvHcxPJC2gfNhflYgKkzocsG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE3NyBTYWx0ZWRfXwVL8LgEpvVW7
 D0RMj24AFUgzot7Ily3EnnM80cqs4kfCY7uCApEjeU4lWz9bij2CBeh3U7KWG49o0O41kVqvFvn
 dSw+3TetUKBuBiaf3NqqsFzb6h1FQ1ZdSYPy0PH7Q6UMGRZIr2uJ2PBPdsPlm20SEXkjujXlT6p
 /FGPiHmD7oJzC9qtDyE0RsUJDoRt8wUYQGPKveZzKF3OoXY/X3xPmqQO5xPBd0jWLPrBIEM5vd9
 hvM4qs5vMkQ21Z+oFKzElT+I8Kya84lGv2Gh7U4Mhqu8HIFiUbYpgkAMAFSt4Vd2nUO+EOmNImO
 hgWxTs0tc66MvQzNILkutG2zB3kfJGkl8Wx6VhCUAxVTbNbzps5CH2yUgZoMfxAW9/0hWnUfmnX
 RAA1X6HjL9KjzKYOCcnwXnoCJ6n5uhJyiRnHlXwswBAduqcYIcDJ3xfFMo+iFHEZZx6v8RTW5zw
 lKqRERKuhryRcgrlR8w==
X-Authority-Analysis: v=2.4 cv=RJ+D2Yi+ c=1 sm=1 tr=0 ts=69dd2f85 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=P-IC7800AAAA:8
 a=xZdyE3pWI4XlTmgEQ5MA:9 a=CjuIK1q_8ugA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130177
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

On Mon, Apr 13, 2026 at 03:58:37PM +0200, Luca Ceresoli wrote:
> This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> @panel parameter, thus using a reduced feature set of that function.
> Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> 
> Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> returned bridge, ensure it is put on removal. To achieve this, instead of
> adding an explicit drm_bridge_put(), migrate to the bridge::next_bridge
> pointer which is automatically put when the bridge is eventually freed.

What if the driver's _probe fails between increasing this refcount and
actually registering the bridge? There are enough possible cases. I
think this also applies to other patches in the series (BTW, including
the msm/hdmi, which I ack'ed).

> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index 11aab07d88df..55b80a488c33 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -35,7 +35,6 @@
>  struct lt9611uxc {
>  	struct device *dev;
>  	struct drm_bridge bridge;
> -	struct drm_bridge *next_bridge;
>  
>  	struct regmap *regmap;
>  	/* Protects all accesses to registers by stopping the on-chip MCU */
> @@ -284,7 +283,7 @@ static int lt9611uxc_bridge_attach(struct drm_bridge *bridge,
>  {
>  	struct lt9611uxc *lt9611uxc = bridge_to_lt9611uxc(bridge);
>  
> -	return drm_bridge_attach(encoder, lt9611uxc->next_bridge,
> +	return drm_bridge_attach(encoder, lt9611uxc->bridge.next_bridge,
>  				 bridge, flags);
>  }
>  
> @@ -487,7 +486,7 @@ static int lt9611uxc_parse_dt(struct device *dev,
>  
>  	lt9611uxc->dsi1_node = of_graph_get_remote_node(dev->of_node, 1, -1);
>  
> -	return drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt9611uxc->next_bridge);
> +	return of_drm_get_bridge_by_endpoint(dev->of_node, 2, -1, &lt9611uxc->bridge.next_bridge);
>  }
>  
>  static int lt9611uxc_gpio_init(struct lt9611uxc *lt9611uxc)
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
