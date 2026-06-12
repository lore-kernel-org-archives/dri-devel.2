Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94101CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E261310E966;
	Fri, 12 Jun 2026 07:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NFXSBxlQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P+1Yzpzc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3856F10E966
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 07:27:24 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C39ZNI940563
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 07:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=I51ADhbIT21j/GY52vCSJ5Ih
 2eKhqau6635b3E1NSKM=; b=NFXSBxlQ1/5yZiO4SKHU11IOnCC+3iqBkbfpu1Gy
 pY8qgg++FF9AVr+Na1UqBdaCcJThMH1W3CudVzKXQIZCbcs9LAYFtpIWbbwzh4Dq
 Qaeu2JUYgkemkXPiFV6Cq/pDWWnPDT9psE8fNakgEK7yZ1uS6NWbaf1tPsYzJ/kG
 GUjAMVs6hiMMs2xvkXZ1OGFOHaGxZEAAK/E5+9xAmmwmgIW1Oltg590eyyEGirly
 Y7CftkV5vfusFH4m1E4XDCvJaW5rZosEMlFJ4JomdTM7eTvgj8zE7ND22pUTDf0H
 AeUHnAAdAqnsyryGgOXgo7b0Ez0uDmvOAqgzCAZh7AKp3A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er014k03b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 07:27:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517dadd84f8so13052171cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 00:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781249242; x=1781854042;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I51ADhbIT21j/GY52vCSJ5Ih2eKhqau6635b3E1NSKM=;
 b=P+1YzpzcdfLBxTrhjVC+15luL1jWGF1KMGtRQWYxpePqxRaGP2siK3yogMhPRqLRkT
 oKj/PkTligMPyCaGhKVMwjP5/RkeEoevol7Z5VORjf3oRqdQ05wYMMXDoUyH/8ow4G9l
 VnOH2175ZMaR5EQVtooybjrRp8JY6Nu1o8W0pkQIoeagJeSVmDPC3PgnF1uPR9YfBHO4
 PYxAqP9JcroCCEq9kXJ6nquC3+kCwQbix7W/y96bDZ8OIJR8V7es4dC5w/qfgE0D2EfP
 uhbJuZ6GsTIb8+k9mx2WZAsE3QoAXGwLN/f/+5aB0sMR3uNNana3LEXhns4F0FMR//Wq
 FHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781249242; x=1781854042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I51ADhbIT21j/GY52vCSJ5Ih2eKhqau6635b3E1NSKM=;
 b=cgwu7d4zA7iA7iBiY2Al2OCOkRBT41r8MX4qtBpLlNmBepSBu/fWUpVfapGSDif4XP
 2bi5XSMVqaBr9bMUAHZTQsiYdjt+JFLw+Uv+SLFOEpFtLFF4jsCE3kn8FhKYJ5x92SiS
 r4k/rscgjiolZCDxraFHI35hc5agIR65BQK6oBTUPwI8UKvphulLEK4VQ5HfILaimEpD
 llfnZag3wG26aSiCLBc+kobgUgOETfrDWDMnp7Tbyj2mQZZA7cXdTqRXajjhz+tHfzAA
 R3A/pZNkxU9ZfhRcqK8McNCxwKj1q1hfIn3yRlpt+RPNETC+voPcqGJkPjP7acY0PAap
 zQpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ozbJLrg8Bf3EXcYZ5cwen8yo2DDPUe9FX0+FGXZ6uJy7LpnX5m8SQ1c05f329pbX9MO4lydicS60=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHV3Dwi6VWmirLfsn6f+9XINsWOcxpZCsbCQSlVuLt78UHD61W
 2KE8Hg/kbChZZig4mVFAId/fjYVCMQQynIxKrhjGkYbZUPqvjMg22nJboUhCr90ah+pJ3h/VeDr
 FgVR4vYTLnCRDjSYUR3x1YlTHJIkinghzR+8I41AixdhGRNrYQhVERaYAJfnLc4yWaqwiJfQ=
X-Gm-Gg: Acq92OHiPQNpXaecxcuKSL/FSSA3cBcTd0yw2QHKEAbSD4VroeIbQKVh2NkA5sOvB+N
 yqN6ayKTWQtdOjohspSTHhGiWXgvmUYX/RWU9r7w4ubKsk/xZfCGXd8Dz81YJTIosmo8JRpDjZh
 TGuLX7O/JWNRQwKNQ0n0VPgqieub0zstZ+fyC8Kq0GYTOok7+/nG6wINm0wUw5lbQQv/BZ3zdl9
 +qB9jSEdM11/U0AFUvhFtv/420769zp35E+2kVV5dxtP3n2kH5GLk5atfLP0LsmI6RWHfSUSWZQ
 vanYWckSyfp4h4H/k2UFLtIRmJxm1QEdaG+xNFJvSPjx8Wgrl+AEvoH4Ar6i1V7ota2VCTFyIxW
 TPIdQy2jHN95B2eCXtnVIIU+O6DoSnYVUIbgYxWQr2ne82Q1NpItl54Ec9FKVCvMzxGe1tboghp
 VvON6Q+0SFOs7MN0eJRXetFIhGvQ3s0MMy6tE=
X-Received: by 2002:a05:622a:5b0c:b0:517:7f42:76ed with SMTP id
 d75a77b69052e-517fe1ddb42mr18061331cf.12.1781249242602; 
 Fri, 12 Jun 2026 00:27:22 -0700 (PDT)
X-Received: by 2002:a05:622a:5b0c:b0:517:7f42:76ed with SMTP id
 d75a77b69052e-517fe1ddb42mr18060981cf.12.1781249242137; 
 Fri, 12 Jun 2026 00:27:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1a7362sm295468e87.43.2026.06.12.00.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 00:27:20 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:27:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: contact@alex-min.fr
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/msm/mdp4: keep inherited display clocks enabled
 until modeset
Message-ID: <qkfhs5r53wmuolrddkywqqhqfokbzh3p6fxbmctuipz6fjl5ue@otwtwvisrjwj>
References: <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-0-22925600e4f2@alex-min.fr>
 <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-2-22925600e4f2@alex-min.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-2-22925600e4f2@alex-min.fr>
X-Proofpoint-GUID: LjCTEwQNRzqE4HZH-zpMp-5ZFHCIftZ2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2NSBTYWx0ZWRfX7Cs1x75I86UB
 XCvxldCj8BK51XapcjV7WaVtnWlXLxKl+WLERREj0QScL/ztoWe59QmH+Sf6c6K8OrXeRRzySzE
 KJnPU5OgmCHz1tU7fBnXqtcZ6LinEdU=
X-Authority-Analysis: v=2.4 cv=Qp9uG1yd c=1 sm=1 tr=0 ts=6a2bb4db cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VM_FTtwWbEzbSf99l9kA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2NSBTYWx0ZWRfX44bYMFQVTod7
 jqF0ZD/WTovAP1sZblqtnUKc744AmdtAbpu3DEbVxhTJVhAfimz+/LHlcLMdOn3F6Pfqu88orTm
 dc+ukLRqHjKSlX7OXxb8auBY8wzeZ1vv9D5YWcPSzxbrPxz8KwtbsUTLU8lJnNFUoYJIDxD9YwZ
 G6avKPBIWZPSnHEzlUv229Ta5J7ATZIjxQwTcu6yKhhrW4JNAkNCXn4wXr7/wH4TUbV5PrEDjcG
 bMOobZV9UzMwwZ0p9XaKlnMsORmnZhMceMNPgzt1dWbNs09bZ4P6135EPFId8IYLBVujyBMakKq
 7VAoRP4lFNHmI4iRoVrqQKhNgQsfkMZcSL7kFa/lIODJIVxmHxzHuguhoszhMN0hK3HvTeG/hCR
 HkX19IF84F2tgKZRD7gX8Ty9abWCYwY3iB9AJdQMm/07agLdp+Kh8VzCFFhUIgNs/r3B40omf2w
 wG7zkI5v8AjCh2IGRsA==
X-Proofpoint-ORIG-GUID: LjCTEwQNRzqE4HZH-zpMp-5ZFHCIftZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120065
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

On Thu, Jun 11, 2026 at 08:07:47AM +0200, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> Some devices boot with the MDP4 display pipeline already enabled by
> firmware. On the Samsung Galaxy S4, disabling clocks used by that
> inherited pipeline before DRM takes over can leave the panel showing a
> blue screen.
> 
> Keep the required display clocks prepared when an inherited
> DSI/LCDC/DTV enable state is detected, and drop the extra clock
> references on the first DRM CRTC enable. At that point the driver owns
> the display pipeline.
> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c |  1 +
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c  | 66 ++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h  |  2 +
>  3 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> index 9e53c9d956ca..0aeefd48be1f 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> @@ -297,6 +297,7 @@ static void mdp4_crtc_atomic_enable(struct drm_crtc *crtc,
>  
>  	mdp4_enable(mdp4_kms);
>  	mdp4_crtc_bus_get(mdp4_kms);
> +	mdp4_inherited_display_clocks_put(mdp4_kms);
>  
>  	/* Restore vblank irq handling after power is enabled */
>  	drm_crtc_vblank_on(crtc);
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> index 4c60b49fb784..1264ce7e8459 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> @@ -151,6 +151,58 @@ void mdp4_crtc_bus_put(struct mdp4_kms *mdp4_kms)
>  	mutex_unlock(&mdp4_kms->clock_lock);
>  }
>  
> +static bool mdp4_has_inherited_display_state(struct mdp4_kms *mdp4_kms)
> +{
> +	return mdp4_read(mdp4_kms, REG_MDP4_DSI_ENABLE) ||
> +	       mdp4_read(mdp4_kms, REG_MDP4_LCDC_ENABLE) ||
> +	       mdp4_read(mdp4_kms, REG_MDP4_DTV_ENABLE);
> +}
> +
> +/*
> + * If firmware left MDP4 scanout enabled, preserve the core/LUT clocks until
> + * the first DRM CRTC enable takes ownership of the display pipeline.
> + */
> +static void mdp4_inherited_display_clocks_get(struct mdp4_kms *mdp4_kms)
> +{
> +	bool inherited_display;
> +
> +	mutex_lock(&mdp4_kms->clock_lock);

Please use guard(mutex)(...);

> +
> +	clk_prepare_enable(mdp4_kms->clk);
> +	clk_prepare_enable(mdp4_kms->pclk);
> +	clk_prepare_enable(mdp4_kms->lut_clk);
> +	clk_prepare_enable(mdp4_kms->axi_clk);
> +
> @@ -594,7 +652,13 @@ static int mdp4_probe(struct platform_device *pdev)
>  	if (IS_ERR(mdp4_kms->lut_clk))
>  		return dev_err_probe(dev, PTR_ERR(mdp4_kms->lut_clk), "failed to get lut_clk\n");
>  
> -	return msm_drv_probe(&pdev->dev, mdp4_kms_init, &mdp4_kms->base.base);
> +	mdp4_inherited_display_clocks_get(mdp4_kms);
> +
> +	ret = msm_drv_probe(&pdev->dev, mdp4_kms_init, &mdp4_kms->base.base);
> +	if (ret)
> +		mdp4_inherited_display_clocks_put(mdp4_kms);
> +
> +	return ret;
>  }
>  
>  static void mdp4_remove(struct platform_device *pdev)

The clocks should also be put in the mdp4_remove() path.


-- 
With best wishes
Dmitry
