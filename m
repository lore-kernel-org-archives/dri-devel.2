Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E773C44501
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 10:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C0EE10E28C;
	Sun, 12 Jul 2026 10:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9m1b+1k";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IIJL+xhk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4145310E08E
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:55:40 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CAcNro2332417
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=auFn13uC31yp9UcYtu9hmPfT
 LxwSp7w1fsylGewneOo=; b=O9m1b+1k6ty2rzLZmRjvVmojaRI22qGhHfUpbc0O
 4/CORof1ep0kJAlM0oxexNVXCrV4g9EPMHBwF3RfExvQIYpMNXjYPuQwzKuuHLZj
 HAyJ5D7ococJhk+O2LuP+kN7WB25xnNcO9TIDj0o1GNhN+pKzg87Ohkc7usdihTs
 usG1sd8uLn5HYRI+CoEV2XQPoyh9ulsphj9wfKeZPznBFJyeWoi3uV/kZWij0anA
 wGH05YGQHYRqjetok6c388B/iuMePlNlFeAojN0i0MzuwNWD9ZT325QLc4QeqohT
 /BDg32An9aMvdcVcNkwyR7VmPViPyLMBrPEd/uQA02pXAA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeamtp5s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:55:39 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9743f0a939fso119924241.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783853738; x=1784458538;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=auFn13uC31yp9UcYtu9hmPfTLxwSp7w1fsylGewneOo=;
 b=IIJL+xhkjQ+jWv6kc0Sn+WyQ829aEH43dMqj8O2Xs1So86ZO9dTU7QCgSC9o/PI4+G
 9DCnnldZa61mXrJg9uWE8GTMOzUfahemnITyNqHeuZct22MrE1pJ+jicYdKDLqkfkMvo
 L7kx/ztpxKGC1BAL8xQ/JcCRvSf0xRMwI6U2hocLqGRp8QssPNm0JcP0PEzF1dnBznxE
 blt/fVhkzxMjh9Ze5JPSi83zuBT9UjRJWqZTxSJnv9g7JQU23LWa/iAFNFyLD+DA7Qso
 1wLRfv4TXajM/SYIov0shud7R2bxjpH5P3ahBevJxjj3OJt3kaBFsyTXmrGUaYtjf02r
 /V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783853738; x=1784458538;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=auFn13uC31yp9UcYtu9hmPfTLxwSp7w1fsylGewneOo=;
 b=Pdwe9L+emZE1jG1iuBlwRogp5CUCdtrcuR7RZ93k19nGs382GCpD80akSul9xRsMG+
 Rb4TU8Ol4TayHjeWuqYO8iKIhraFIK056nzAFhCeZGXhnRBVcHBEnC80t3/u29YCYe+J
 zuWaW0lmmLLgyKDt7r3hBii+XR/9ybdCVfiO9CGXIe9dMRK17ZfNoTauEuQoxnhNenxP
 ow9cGbrS88AuwhNIwcATXvC0ejmJDKSim8aXKYXpEHMwgqejMZwlNzs8jZtf4IcVnk9y
 ADxTBAwd3oxvsQi7gyL5k3e145fn1+/H1eNrDZ9vdTKXG0wHVu/UkEE/Yw9c6lEXrNNM
 ivxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLEEmms6CzOu1LIsWOmN9VA0KEOB7gx0FT4uTlIqOQe6AnQu1/KzRkxvmk9wKpuPW8pF8tZ9XZd9c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzz6+s9b9iFPeH+d8q+e3Qo2HCkZgaMb5kMofN2N9fwhu6p7Yb4
 tmk+/IcJi9beB0YtrXTAm73zU/W+m0IgrPl8NIcHUAU1PFyMe722En5AU4FJ4/kEsZLCwC7QFOX
 uNbzndKhWgo6TPd/Cgdn9Pr+oL5BbE9N0LGdj8Jz4l+00x7uiCPD2yIeZ5AwFRYWQNumRCLU=
X-Gm-Gg: AfdE7cliLrGcjL5Hgjz7xoJVv7ibnv+qCdiNDEWkYvbPJ/h/mAO9o4UNPGtXTYNg1jv
 +ZObpTMQUTvcftdn+2OIyWJS3ii1S9FUYRveHm/t1Cxu1te1UuiMyQp3HF0F3aYHrA2Sbf172cj
 SPwux2cXgxqZppU+qodhgQUOAhRtVGzuSjkd5ysXRLSuzRTtFx0WhudlZ09J6B8dWbD62akwBwT
 z0RQOlrjmdVNsRflbUgSKe9+PDzWA7+miQU8SqpZAgNOGAsMPp80RkNpNqrHfM5UXnnmAN/CuBf
 khbOQ6GTY7wBW/axU6E/u4oFnkG+l2pHqxf1z2/9Sz2e1WbEDgf3djjY7ysBN8dhXfcLYd5xzG3
 7rB7pZi+q0gUtLk7fsKrjt0suwvnjhglkGn+5EqsnIQhAr28Xza7kZtpZfUppEvlUBqUnLdq9kP
 Zjd0oFFvm1FyA5VTVsDqiGMGg2
X-Received: by 2002:a05:6122:65a4:b0:5bf:a181:d46d with SMTP id
 71dfb90a1353d-5bfbf09b771mr2585496e0c.3.1783853738060; 
 Sun, 12 Jul 2026 03:55:38 -0700 (PDT)
X-Received: by 2002:a05:6122:65a4:b0:5bf:a181:d46d with SMTP id
 71dfb90a1353d-5bfbf09b771mr2585485e0c.3.1783853737547; 
 Sun, 12 Jul 2026 03:55:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c849180ddsm20446691fa.3.2026.07.12.03.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 03:55:34 -0700 (PDT)
Date: Sun, 12 Jul 2026 13:55:33 +0300
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
Subject: Re: [PATCH 4/5] drm/msm/dp: report IRQ_HPD as an IRQ-only notification
Message-ID: <zmnftag6s6mxvnoqdzouhpdcbwscm6sfzrqkzgwrcptgbr53cx@jetw2gtov7qp>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-4-646a10256233@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-msttypec-v1-4-646a10256233@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDExNCBTYWx0ZWRfX+yBSiZ8WPe9N
 8EOq/V4st8R4R1h3iWefv1Amk3dyt2izI5a6kwjGHyliKYWzDOXZFkNpOI5DuAqkn4oJ7u/xMPM
 /NwA4JPlGx8gVhCqvOKDhEms5wfuV2k=
X-Proofpoint-GUID: vJ96-uTSB3wCuRPxY08nLsqsVXNA7pDe
X-Proofpoint-ORIG-GUID: vJ96-uTSB3wCuRPxY08nLsqsVXNA7pDe
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a5372ab cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=byx_Kl4d9wP9hOeXrbAA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDExNCBTYWx0ZWRfX2oY5OfmIFee1
 QJfKurMQfl9u0awncazdCZG+GefW2TqP5qIPDkXAmzWGtZWvpLgYgZDyBWlfTeq/mG8MfPPyji8
 HWxh0CEF5W+Wl9i5azLts1Z7swkiInJ5CCsqVegWOp3OQTSrTdT6pyQmHY74djJ/88D2m55KId+
 y8uPcDXSs3QGKBHT6Ue0uSxGXZ9QhoaSVxcHexHDAcooLBODczs7XowLvukwDktTdvor3/9UG2w
 5rFUZUZL39qBFcQrAAwV1lcGFmwJ32Aid6/mTgx84LCAzOnUMNlWmOvPynmYv5gKJG7o/NU/Loc
 5FNx9p8EXGW9DctY4Q8XeG4XNq9i/5YTHNnVJZ5wdSJhPaVaOpbo5+Sbo4rIZpPltvL0GY5OASf
 9hpA/9BGe8h3cncPfH9EnoLqFWt0BZ5aoDDIF6rbVAVAZJKMPxOW+mvaOWz71hSCZgHHHxSzCiL
 w/47IHDB1tz9OqVoqeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120114
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

On Mon, Jun 29, 2026 at 10:48:06PM +0800, Yongxing Mou wrote:
> MST reuses the SST connector bridge to propagate HPD IRQ events through
> the bridge chain.
> 
> For IRQ_HPD notifications there is no connector state transition to
> report. Use connector_status_unknown together with
> DRM_CONNECTOR_DP_IRQ_HPD so that the bridge connector framework treats
> them as IRQ-only notifications and forwards them without modifying
> connector state.
> 
> The DP driver handles IRQ_HPD events based on
> DRM_CONNECTOR_DP_IRQ_HPD rather than connector status transitions.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c   | 22 +++++++++-------------
>  drivers/soc/qcom/pmic_glink_altmode.c | 14 +++++++++-----

And which tree (and why) would be able to merge this patch?

>  2 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bc93b566fbca..4ee391cc7165 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1119,14 +1119,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>  		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
>  				      connector_status_connected);
>  
> -	/* Send HPD as connected and distinguish it in the notifier */
> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
> -		if (dp->msm_dp_display.mst_active)
> -			msm_dp_irq_hpd_handle(dp);
> -		else
> -			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
> -					      connector_status_connected);
> -	}
> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
> +		drm_bridge_hpd_notify_extra(dp->msm_dp_display.bridge,
> +					    connector_status_unknown,

It's _not_ unknown.

> +					    DRM_CONNECTOR_DP_IRQ_HPD);

This should be fixed in the MST patchset. You should not be doing any
actual handling in the ISR routing.

>  
>  	ret = IRQ_HANDLED;
>  
> @@ -1781,11 +1777,11 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>  	drm_dbg_dp(dp->drm_dev, "type=%d link hpd_link_status=0x%x, status=%d\n",
>  		   msm_dp_display->connector_type, hpd_link_status, status);
>  
> -	if (status == connector_status_connected) {
> -		if (hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT ||
> -		    extra_status == DRM_CONNECTOR_DP_IRQ_HPD) {
> -			msm_dp_irq_hpd_handle(dp);
> -		} else if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
> +	if (extra_status == DRM_CONNECTOR_DP_IRQ_HPD ||
> +	    hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT) {
> +		msm_dp_irq_hpd_handle(dp);

ANd here you missed the case when IRQ_HPD is being reported together
with the first HPD event.

> +	} else if (status == connector_status_connected) {
> +		if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
>  			msm_dp_hpd_unplug_handle(dp);
>  			msm_dp_hpd_plug_handle(dp);
>  		} else {
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index 946eb20b8f83..28ab8cbb5ef9 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -373,11 +373,15 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
>  		else
>  			conn_status = connector_status_disconnected;
>  
> -		drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
> -						conn_status,
> -						alt_port->hpd_irq ?
> -						DRM_CONNECTOR_DP_IRQ_HPD :
> -						DRM_CONNECTOR_NO_EXTRA_STATUS);
> +		if (alt_port->hpd_irq) {
> +			drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
> +							connector_status_unknown,

And this is completely wrong. The AltMode driver (btw, you also missed
the normal altmode driver for DP) doesn't know if it should handle the
events in some way. It should report the HPD and IRQ_HPD as is.

> +							DRM_CONNECTOR_DP_IRQ_HPD);
> +		} else {
> +			drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
> +							conn_status,
> +							DRM_CONNECTOR_NO_EXTRA_STATUS);
> +		}
>  	} else if (alt_port->mux_ctrl == MUX_CTRL_STATE_TUNNELING) {
>  		if (alt_port->svid == USB_TYPEC_TBT_SID)
>  			pmic_glink_altmode_enable_tbt(altmode, alt_port);
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
