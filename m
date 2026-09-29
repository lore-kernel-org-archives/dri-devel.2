Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCD9CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21BC710E19B;
	Tue, 29 Sep 2026 16:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S3aDfofh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dDHAQXrR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED45510EF94
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:20:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqh0B858094
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SKXSfs161kjW32HtCfejw+Tq
 SHrqUFuiYkbURsHolXo=; b=S3aDfofhAVbQ+GB7FUrhXjF6RxRCIGDQ6D2/Odio
 oyFv18xsM/esDMVZEl0CQyPaU3lY3I0fw3ovIxVSHQuBWTOLlnZ+/Sgi4bEKIVXs
 coIefEryno0zgmQEfkwH2Q5kTUs39mvd2sPhLhCHwDugO1Eort+VG5AcNF08CI82
 6iq16IA6dFCDJIb40bnjbyqEPaFoDhAOI7ZieAQvqFnLZ/Mn9558GO1ZsM7dvaDu
 47l49G+4SIT3wo91oL4dsAZvJCWWs9xuwVPRp0W/K5f4izgBgDskd0XBQn/ienM6
 QoUoQSju6bO+k0rbGsef5OLldobdmupE0Ud1KH7+NuAVrw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0jfsv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:20:45 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-98527cdac1eso452227241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790698845; x=1791303645;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SKXSfs161kjW32HtCfejw+TqSHrqUFuiYkbURsHolXo=;
 b=dDHAQXrRGOLPWV5oTNBQwpBZdvxH/TG+JUc1iZuQdWS3pK6A/Az0tjYpoXObftSsOx
 UX+sIAfNRXEdtaIkUuV3yQCg9HggixNbvLMJv0SALdNxqGuEihPCNnKys/+sn5h6vqjT
 7rxLL6fvURAYhJXJUMi7OyTRgUvmjRqVaIU6IDpHqRkLe2tBMJ+9DZa2H2gfPy5rlU5O
 jOuwUCKbdIvyk2iOSfn5EZhw64OfjFMLQt11w3jIDtTLsqtqUrXUJfUQ8Kt04ADGP54e
 Vk9mBg5oyW62IhrTvPyiXd/8evnRw+aGtbRDZjZDzLTPiEnrnF/ZSMhf9L/8DPJoyLh6
 MHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790698845; x=1791303645;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SKXSfs161kjW32HtCfejw+TqSHrqUFuiYkbURsHolXo=;
 b=D62+yO1a39YX9wGUw256RDlgcO2RKXgZcro524Zy8LENw8ms3EV3R/K21cuDDZ2kKa
 POhEuf4VM88x6ASUD9Oq3hq/3J7Yr1YpG3B8DNRi5k2ZnElQsjajV4h6grhJQvdY7465
 Y8Mqmj5UH8X6PbCi/a1T46WLMtK8fRYZgOgAoo1HI0RohPvWsXxRRgeg9Vfdg968A9b+
 7d3tKs9/TivV5kEXtv6zmDDwSBuzerRL2Cw8yX6cbYwCGWWztfp0biV0NdzAZ/AiNiaI
 1tL2ga/5JlB+VEYSskjIdtaRQxA41CijN4yvO4e7laqOBoWSfnth7m5ZX9QuJvNlKb2y
 kxog==
X-Forwarded-Encrypted: i=1;
 AKwUvBwu0osgS7A661wlEJhNTQXY1E5nzS8W62TrTIIyC0P9iMpDEDyopWGRxByFkNx3UTcQxkyILc8sVfY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIS2UdY8GjpoU+HWhqrsG8FXmFgAbE4+JbdGtYrj4mkY/GYMMqS
 dFKNKmm1HcWXZLR3Mp26EKYeDS/Za7olRvueEZ/MEr1zO3BB1fKKE7lMY1lAagSZAa3hSzhEMe+
 GECIyjqlHGck161a2LJelBqtXhddHS83cjDVlvIy5y3o0iNrGTi6K3H98Ao1iDI6bzm0Z+kQ=
X-Gm-Gg: AYBFou3MexFXNRd353kIyZq/6Vn6cCrL35bFCpzlOHTRraOT7XelRp7jiycy6/FdQRG
 gOIWtLNupeCeBzGoTQOhacj4LRzbMOI0+PqeBMrbLDxO1/zlereexFGappP6en//mg9nsyVwtli
 43q4YJgeZ8wXkToPcyszlacZ/h+yJ91YrXNFSKZRwFOIYJt2G/a7m3i39tc9o3FVdtA88LLI3rN
 L10QHCv2r4nVd+H6X4JWW2axQb0JruKgKD7123VxShiw8jV8M9rS/WsGNf4L3gz3W2lq3NJH+9R
 BFXhXvjLysjsr59eLjeLNaUjmc3edqrgc0ar33xqO6N6veEXM1oz3D2coGC1whY2RwQ5WKbcg7y
 3MbuVkWEj0jKEqKD3mLOUmIwzIiG0VzNbaKbZW2fkBwjosR5Tl0XW3Rio4TizCRsJWvLAoW7jhu
 zInZgyu79mfBK6
X-Received: by 2002:a05:6102:8615:20b0:7a2:2f60:b9d1 with SMTP id
 ada2fe7eead31-7bc3c4a8df7mr5357137.6.1790698844686; 
 Tue, 29 Sep 2026 09:20:44 -0700 (PDT)
X-Received: by 2002:a05:6102:8615:20b0:7a2:2f60:b9d1 with SMTP id
 ada2fe7eead31-7bc3c4a8df7mr5331137.6.1790698843874; 
 Tue, 29 Sep 2026 09:20:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba3b486489sm32770e87.54.2026.09.29.09.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:20:41 -0700 (PDT)
Date: Tue, 29 Sep 2026 19:20:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/6] drm/msm/dsi: Support dual panel use case with
 single CRTC
Message-ID: <jwlmzhhgpvbi47lt4biwn4razrvbf2rfi5uyyvfhjomzo7uqyh@ahf4ubqvegst>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-4-c042266b9eeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-sm8650-7-1-bonded-dsi-v5-4-c042266b9eeb@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NSBTYWx0ZWRfX77ZZrSAvHxld
 gpmMq5W+evd1zr/fcFB4nAZodnze1QDz9nulZaOyjxtq+hPdjN0QJd86xmEPa1DQUZT4N4fbuY+
 KHewdCviI1sCokYdC07JckqThjSPM6k=
X-Proofpoint-ORIG-GUID: iR98CbMmyaRgxgnteCdDx3LbPk39kuQR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NSBTYWx0ZWRfX9jDPahtBY2wn
 v5ggD9koXB4f3pd3CL5fuzS+Wc//8YhCk+qM56BmalO8+BPHocyr8CdMQ59FjwV/jnpypP5RFro
 Yg1yrJ58rNRFjSF7DcuGi26NubY5GiF3tHAymUKueX3xjE+Bxfs1MrCrQROaRhGcdDaqXAe+fo5
 FSQf/e5SMxwwhPzLNOuQZSgfEzz/1KVX/grrGq72wZKfV1Uhjgnh0moxrFW1NJZrUTdYdGE95t5
 Zo9dOok1GtWSEnHoyc3+r/ZFxuWFYXuelDq5jfy8MKGqc/37jNaFD+4h3TOkUej2G6G/Cu9K1y2
 n8TOQsu/E9zHH4AVE9NGisnYMkhYQ588yuat4oRzoqbBx+da5sv1C5mHJdiVVMmDrn26UBXp8XM
 txkJOTxBDSSigXuVYrJeTWeEbBXYRweGYusFYSWbXrpXj9fmv8uUjrLlApmXTiJbPOcfE29CqU/
 pclCwquiuKg9kc54G1A==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abbe55d cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=KKAkSRfTAAAA:8
 a=xngG1aiKzArpkGo9upMA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iR98CbMmyaRgxgnteCdDx3LbPk39kuQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290065
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

On Mon, Jul 27, 2026 at 04:08:43PM +0800, Jun Nie wrote:
> Support a hardware configuration where two independent DSI panels are
> driven by a single, synchronous CRTC. This configuration uses a bonded
> DSI link to provide a unified vblank for both displays.
> 
> This allows application software to treat the two displays as a single,
> wide framebuffer with a synchronized refresh cycle, simplifying rendering
> logic for side-by-side panel arrangements.
> 
> At the DSI host level, the frame width for each link must be that of an
> individual panel. The driver therefore halves the CRTC's horizontal
> resolution before configuring the DSI host and any DSC encoders, ensuring
> each panel receives the correct half of the framebuffer.

I guess, the flag from the previous patch should be coming from the DT
node of the DSI host. The DSI should then get the mode from a single
panel and then set the adjusted_mode for the CRTC (note sure how this
will work for the compositors though).


Also please note that the are other possible configurations. For
example, for some time I've had a setup using two Raspberry panels
attached to two DSI hosts for exactly the same purpose (please check, I
think Neil might still have it, or maybe somebody else from the team).
Each channel is an I2C-controlled DSI-to-DPI bridge + a DPI panel. I
understand that it's not your target, but it's something to keep in
mind. I'd say, the bare minimum would be to resolve a second bridge (be
it a full bridge or a panel bridge), possibly create a second bridge
chain (remember, bridges don't support branching, so you are a bit on
your own here) and at least manually call the callbacks. This would
ensure that the second panel (or a second bridge) is properly controlled
(and thus would get rid of the second reset GPIO from your patches).

> The pic_width is used to calculated DSC parameter for DPU DSC controller
>  together with panel's parameter. While panel driver that support dual
> panel shall provide slice_width parameter of single panel. This patch
> only impact DSC configuration, so crtc is not aware of it and not impacted
> by it.
> 
> While the DSI panel driver should manage two panels togehter.
> 1. During probe, the driver finds the sibling dsi host via device tree
> phandle and register the 2nd panel to get another mipi_dsi_device.
> 2. Set dual_panel flag on both mipi_dsi_device.
> 3. Prepare DSC data per requirement from single panel.
> 4. All DSI commands should be send on every DSI link.

broadcasting of DSI commands is controlled by the DT flag.

> 5. Handle power supply for 2 panels in one shot, the same is true to
>    brightness.
> 6. From the CRTC's perspective, the two panels appear as one wide display.
>    The driver exposes a DRM mode where the horizontal timings (hdisplay,
>    hsync_start, etc.) are doubled, while the vertical timings remain those
>    of a single panel. Because 2 panels are expected to be mounted in
>    left/right position.
> 
> To maintain synchronization, both DSI links are configured to share a
> single clock source, with the DSI1 controller using the clock provided
> to DSI0 as below.
> 
> &mdss_dsi1 {
>    assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
> 		     <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
>    assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
> }
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index e39938fb0f502..a3c56c3dc7904 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -186,6 +186,7 @@ struct msm_dsi_host {
>  	bool registered;
>  	bool power_on;
>  	bool enabled;
> +	bool is_dual_panel;
>  	int irq;
>  };
>  
> @@ -1024,7 +1025,10 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  			return;
>  		}
>  
> -		dsc->pic_width = mode->hdisplay;
> +		if (msm_host->is_dual_panel)
> +			dsc->pic_width = hdisplay;
> +		else
> +			dsc->pic_width = mode->hdisplay;
>  		dsc->pic_height = mode->vdisplay;
>  		DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
>  
> @@ -1705,6 +1709,7 @@ static int dsi_host_attach(struct mipi_dsi_host *host,
>  	if (dsi->lanes > msm_host->num_data_lanes)
>  		return -EINVAL;
>  
> +	msm_host->is_dual_panel = dsi->dual_panel;
>  	msm_host->channel = dsi->channel;
>  	msm_host->lanes = dsi->lanes;
>  	msm_host->format = dsi->format;
> @@ -2600,6 +2605,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
>  	if (!msm_host->dsc)
>  		return MODE_OK;
>  
> +	if (msm_host->is_dual_panel)
> +		pic_width = mode->hdisplay / 2;
> +
>  	if (pic_width % dsc->slice_width) {
>  		pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
>  		       pic_width, dsc->slice_width);
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
