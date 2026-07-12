Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69733C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 10:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E1D10E248;
	Sun, 12 Jul 2026 10:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SHrCHjqs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qm8Zst8T";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF2A10E248
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:44:59 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CAcKxL2195435
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Sb4ApefZutryRdB75QWmCb7+
 x6M/kUCog+7gDuEDR90=; b=SHrCHjqs4df99NJG9bdHq119sHRuizAVPkyTBsbi
 mP51su7CI5aprYTPnlfhgyhKnr/zIt6o7Z01lHjNMV95wVeOyfWqIG7WJOeQqTFV
 w08ooD1SMRKwk0y3KWWKl/aO9UdzS/vjtU1NJwSCQzXEY7AD3Jf0GSyAyzKO1oZr
 nrEQxsMlq7BKi9Sm9pjThbaKr5hDuSSrARY8SZHy6EGueoQuiD6xmPVoJSIMUnPv
 keiJctLBV1zCeh2Yw/ZSgwgB6/cA1fyd8VoF8A7V60DZjcVl9z5UJ361uQsa4Oet
 jDuWGQnsv1DPTrXlstLtpV1WASkoIhBCtH1KGa673UFq+Q==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9jp0q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:44:58 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5bdad49fe15so2561982e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783853096; x=1784457896;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sb4ApefZutryRdB75QWmCb7+x6M/kUCog+7gDuEDR90=;
 b=Qm8Zst8T2gQIMmZgQk3ZUCk+IyrF6W5HaohQnUyVKAHdv7Ra8avD5P2EvGXIZUUCfQ
 aElqFo9hBsOlQihbAs0DAtF9BBow2tWolFfjZHpMtyORW4gJBv32fRNq6SL+CavHIjsz
 0eGwU1RRgHFdAZD8vrAS83MJ68ISYEH4jzpOpMui2qFFIpe+WrEG3UrVpWh/NXIf7qoA
 e4+T4lRv5HfUOacPRxGo/Chf7fuoNlsUVVkrkLM0fJ2BnVDaGxQyIED7gCKnPguMniNk
 FJqkD0/UUxmeTMLoWEEvkXqCV8qb7VumoxoVudCMfucMGSZ/Ir3r/LNg2bufBWKqruBB
 Zt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783853096; x=1784457896;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sb4ApefZutryRdB75QWmCb7+x6M/kUCog+7gDuEDR90=;
 b=La1Uht80bulvQ39ZCdNlL1VB015E2Glie1vkoO5VPiev7dO10fWNszy4wh8aCe08Lc
 V5uV4jQKeX8v22bQCdhrSueCos+APXYAt8OCQKcAywMuVZqninI/n8FsL5sg+rBSHGFh
 NfSPYIPq0WMERqEGUrXKymH7Hs1bX7UxRR18bxzkHzQVK30KCWs/JnvNtM05yjB716bP
 0Uw4LEXiaT+JRcjMiLh8pUwqe8ya6XPoR74UNqr9KvoG9MGY1a6MeyUhbJS2ss4k4TnO
 tu+B3OQKw4L8i5h6AfmeJvbe6wxmulWywOdl4EnnyvkZBi6V/2hpCBjwK8/AFUWgHAHo
 KvKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGKNFId6OE62qhDsGk2CbnzWTrF5iF2MEtrUgsQVqJ8RYF78aTayv3kE2sVOyKbWLNKGRmeIeB5ZE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2g1lqp/afLYM5omXE5+SWF3SlNnsa8kIkShQZuNWDIuhHeyaX
 ZrpXs642+TpRsjWdB1ECqzH9erPPSDVFsp20DlOousqXbFMRDqKXrXQuP2I3wd9+9ikdmrZSj2e
 zhZxHOE8+b2Fr0WN7AUAOA4x/TR+nKigcwxblyxI8TiNGmIhH+9ZoL2qvp50aZueSENCmB0U=
X-Gm-Gg: AfdE7cneQyLOsvdNuJ779gRi1YGz5mvT1599b/MeQwJKHkbNyVUd0kD+mzXJKHmZEQg
 aHEeuvta3EMlEFXjMx7J61WdqtUVKnbPHL/yEK2qaafbbbziryQ9qcLzs28hjA5JtluBFhjM+ea
 ssB5tN2wQ6YKrmWXdXU8KJmxrLUThLt5f7uQPBtyO2kRvrcY+2jYArYxoTaL/8zTIu/rSIvkKlW
 TVEfOlVrlqE7WNVuhIpwWxutN9jNTkA9IiEgQcmsdYouM4CgYAe83kzo8hWQXzZDTJfDy3sj2kf
 DeAis1gIKkWHLayIPjHu5k6cgIWJwf86E/HDbw324qeJ2/9752Im/0E/4OA2/1UE+U7/tM9CXF7
 NGoHSunl9qDyp0w6uac5009iwyTMUDy1P+JbWkLCyzNqzVOtTJmzawoq1fOB1ijbhH6RG1Sl5zb
 hwQUeaeobUoW3MykvCdkDLunrj
X-Received: by 2002:a05:6122:d29:b0:5bf:bbe5:372 with SMTP id
 71dfb90a1353d-5bfbf3b676dmr3706433e0c.12.1783853095625; 
 Sun, 12 Jul 2026 03:44:55 -0700 (PDT)
X-Received: by 2002:a05:6122:d29:b0:5bf:bbe5:372 with SMTP id
 71dfb90a1353d-5bfbf3b676dmr3706406e0c.12.1783853095217; 
 Sun, 12 Jul 2026 03:44:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b854cesm19921011fa.27.2026.07.12.03.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 03:44:52 -0700 (PDT)
Date: Sun, 12 Jul 2026 13:44:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH 3/5] drm/msm/dp: suppress bridge hotplug events during
 MST operation
Message-ID: <fozk5fz6bgat55vmlgyvovnmfzabjprna46cmcaoh4jyrwmbtu@k2qtjgip5vg3>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-3-646a10256233@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-msttypec-v1-3-646a10256233@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDExMiBTYWx0ZWRfX2wrsJTfFQvvG
 HyDJL/yBUnIfZX8eJ5Wyo+Eg+3CHtgKmB9P99TiTru51tzXobmAyoMX07FkBmCf+fH1djsScaS/
 Lf3Jg0LxfclLSLRbIUXPJWw1uZeOBNg=
X-Proofpoint-GUID: 9TTcCfPgLAyKNtXacO5H7Bm4yH6Mh0i6
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a53702a cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=dRlQVyWoEjKAXtvccWIA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDExMiBTYWx0ZWRfX/DT58LFjMQmQ
 epc+epoYXt3veYwHIkGz/Yxlo8prxQX1OATSVrf2Ioj87UwDnRKArZpuim2e49ci5RpIBFEj7Vn
 YZlWZThLoQ83hQVsZquax2EfINTWv+BE0DaRSB8j0kVzPxyiS2C3bpjN5nY5JnhllEkywqmVF1j
 qNiWt9Dym3nfUCnVIIj89V6WgvDy9HtFI4CAratAhtDNhb4uxI4m+CeQwD8IPhAcQgiWAA8CFqM
 0J993J7jYZpdQiVg2224bp9a+QIupKmQs/U1+i7Mg52O4Fh5E+Sy6j+KfjbaHv8akEl3YUA2+Kl
 h6x683leLV4WLiTPj59UZbtHLQhBWU5hpO1K7d7+2WQRxK2dPJb7xBFXAdraoTFxygLtQtdCD0F
 G+7Irmto/0L50jh4fI/tuCbLF7q5ANW/M5h7hBvzvleisneM13R97gZ4FNA9qsgciC/4J3tcoCJ
 D074phJwthL2A2gEjJg==
X-Proofpoint-ORIG-GUID: 9TTcCfPgLAyKNtXacO5H7Bm4yH6Mh0i6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120112
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

On Mon, Jun 29, 2026 at 10:48:05PM +0800, Yongxing Mou wrote:
> The DP MST framework already generates the required hotplug events for
> MST topology changes.
> 
> Suppress connector hotplug event generation from the bridge connector
> path while MST is active, and continue propagating HPD notifications to
> the DP driver.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 6 ++++--
>  drivers/gpu/drm/msm/dp/dp_display.c            | 9 ++++++++-

No, it can't go as this. The drm_bridge_connector part should have been
a part of the first patch.

>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 7334d6677604..82ed0dc450ab 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -162,6 +162,7 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
>  {
>  	struct drm_connector *connector = &drm_bridge_connector->base;
>  	struct drm_device *dev = connector->dev;
> +	bool send_hotplug = true;
>  
>  	/*
>  	 * IRQ-only notification: extra_status carries the event but
> @@ -179,9 +180,10 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
>  	connector->status = status;
>  	mutex_unlock(&dev->mode_config.mutex);
>  
> -	drm_bridge_connector_hpd_notify(connector, status, extra_status, NULL);
> +	drm_bridge_connector_hpd_notify(connector, status, extra_status, &send_hotplug);
>  
> -	drm_kms_helper_connector_hotplug_event(connector);
> +	if (send_hotplug)
> +		drm_kms_helper_connector_hotplug_event(connector);

But now I can also see that the idea seems to be incorrect. You are
preventing the kernel from sending the events, but it doesn't really
matter. If connection status oscillates, then other components might
notice it even without the event being sent.


>  }
>  
>  static void drm_bridge_connector_hpd_cb(void *cb_data,
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 6835c68fe510..bc93b566fbca 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1790,10 +1790,17 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>  			msm_dp_hpd_plug_handle(dp);
>  		} else {
>  			msm_dp_hpd_plug_handle(dp);
> +			/* mst_active is set in plug_handle; suppress SST hotplug */
> +			if (send_hotplug && msm_dp_display->mst_active)
> +				*send_hotplug = false;
>  		}
>  	} else {
> -		if (hpd_link_status == ISR_DISCONNECTED)
> +		if (!msm_dp_display->mst_active) {
>  			msm_dp_hpd_unplug_handle(dp);
> +		} else if (send_hotplug) {
> +			msm_dp_hpd_unplug_handle(dp);
> +			*send_hotplug = false;

Why? Disconnected events definitely should be reported further.

> +		}
>  	}
>  
>  	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
