Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F40EFF8864
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 01:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A208610E9E6;
	Tue, 28 Apr 2026 01:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ny5n8i94";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="amLmtBx5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E2AF10E9E6
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:42:00 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RJ525b2006990
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mYLhrY4KD15wk36W8v+cBLgX
 +4JBrZDZkrOmUImGT2I=; b=Ny5n8i94X4j+0BqT3Ik9x0vssW/x3lKEpDe777Yf
 EO/XPk774Sw2g97FxpflCcGYVYPpik/neEh2B5XkPRJF4Xc/FGXSfLO6Oy1W4uRs
 JXfgPTiy9qUGA1fbCHfZJfanK7QLX3gt9oPmv83rHRaQmWLJQ2CgBP0bo0Mqq5Z/
 W7yZXHb20L53CKu4cDBjqADb8+9o3GhMguqtRI24DZow00sTjyGW9e0DKz743bkC
 2gGaRByjePdSER/Y4bHJdrojPDs8Ew9wZ+JXStw53RGtFSdcvLwtTGOEr8vMRbGT
 Eu+pN2y2ODW6IK30ajqyBkgV125/vaCyz5Gm1qywJrMO/Q==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7gkjsn9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:41:59 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-56f1fe60919so18928543e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777340519; x=1777945319;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mYLhrY4KD15wk36W8v+cBLgX+4JBrZDZkrOmUImGT2I=;
 b=amLmtBx5b00LFRSXQ0hKMluT4+iGe/WVKp7Fjcg4l3KiaPuJe0l3Kv/tSPEejNun/z
 XW3fqyHQA4orboMZK/Bk2jTuH/c8Rc2VR+0Hg4j9yJfhrbD6RhoVfvNS9a3d+MW4O8w7
 EbZT/axStkIAIZGcNUS0Mqy2tnGbvClLo4RQNvWp2OpGPKjUbkH3fW9ZiP2ZPK8vJMK3
 pqGItEOjrmrQEwLrOSAsfvpbRr4aUmQ8aej7WedMyyna3mTRZZkWRuhypFwNNUTlr/5X
 zJkEVrBj3VGmk12YfcEY6IGa6V85EO3bbSYJUnJd27lv4fynsA3LAqaoi1eXVsdeMvmJ
 eW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777340519; x=1777945319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYLhrY4KD15wk36W8v+cBLgX+4JBrZDZkrOmUImGT2I=;
 b=kgIbrzrNKE2dlvu65QJYnlA/Lfnw1R9dtD6vyAetqlAAkEvlpc6ac9suNJqNp4sUF7
 MiMb2nyl/U9X1jUy4+DbYdyFpOKqQ2FYIu3+gG1s/TUWtvWJeLNA6Ime1rPbL1yiScp7
 eDlgJjY+z4+S3LjKRFylOa+Lq+CfAhj+AbRW9JfJuzOalaiqbro6GKNW5oj7HQY0r9AO
 FftgIrkejxJJQ5HcVlOiRcDP1EHhppBFbqANYqq2MKKTx7/jVWKuGTefrB1LoVb1KvbL
 r1G0lElBZU9M7h47Kc2TvZRZr0EZv3gFhMd87wGhNTP/5A2RP4KU7WRfbX4ABMOL1qTI
 shHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zs6z+TZlIJSR/SIZ5j+HLXyTglrb5LcbvO/FrDjmQCjO6zVCvMtdS1hlSzxzGdbsiv9lWfj+PtRg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGaXmOCkLLVtEwYlv23PHsKHjf3E6LGCghfgCqY6dQZ77SvWpk
 hCbnSwzD83k+fHvDtu8d3Dg5dSsNFI3EuwLgJYy/RXHes/4wm7F8FtMToYPv4QgUFwKo48I4i5D
 SvtdWp7Ckk+n1Q0JR2fjnVC48bnUgYR3zmC24oj3MGE2Gncgnk/9ag4G4cDwvhQ3o1Tn1vmQ=
X-Gm-Gg: AeBDievi9f6GXQQVBg23ofm9spRw69OY2+Tt8d6DEPYMMUo74BIUArovPnRvn49DxE0
 IRud/vTMO8ZrMVBeCrFUdd5hCk4/W6bhDEGZ/vfJmyn+O1zdGMZ1sa4dkkwWGPs8VyzkMMCRYZn
 yZChDYLqzoGCw72wbm5CT0WNb5zxmfkSL2EuEJFTtLx48ZdAkHZi82JV5aXEs3NrBzps2iWU7OR
 Xz9wL8OX1zh12sTlTPf5LTHBnOW75stvG5OTIdRbGdPiF38G3GmGRNWxZMck2sDnK9F1+zPGx+6
 kdeEzCKoOzUwK/PzN1OJgrNW1gbBVjnFrnWi4FFSky8LbNAxcMS2a3UmMVkE3o90rQ4ndwAcyhk
 LQodGY+MTvmiB9VADAFnu52ekxsHYWFR8jQ5Fexg3Zj6CIkikgJxVL0naTPpW2MCnA9PwBv6MIu
 Tx885MUsYR+Ir1E+YkUy3B2O523WluyDMD3EYZxJYofN6rHQ==
X-Received: by 2002:a05:6122:786:b0:56d:b337:4709 with SMTP id
 71dfb90a1353d-573a555926bmr542831e0c.6.1777340518701; 
 Mon, 27 Apr 2026 18:41:58 -0700 (PDT)
X-Received: by 2002:a05:6122:786:b0:56d:b337:4709 with SMTP id
 71dfb90a1353d-573a555926bmr542820e0c.6.1777340518195; 
 Mon, 27 Apr 2026 18:41:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3923f58cc6bsm2697611fa.37.2026.04.27.18.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 18:41:56 -0700 (PDT)
Date: Tue, 28 Apr 2026 04:41:55 +0300
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
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
Subject: Re: [PATCH v5 09/10] drm/rockchip: dw_hdmi_qp: Register HPD IRQ
 after connector setup
Message-ID: <hnbecmgviu7jl4xrsksna63sa376gpcaa6ate2qp2o5lgg35ot@wdthrayons3k>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-9-d778e70c317b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-9-d778e70c317b@collabora.com>
X-Proofpoint-GUID: GAl_b5TmPgizIPDsunG2eNRW9Tg6zWPj
X-Proofpoint-ORIG-GUID: GAl_b5TmPgizIPDsunG2eNRW9Tg6zWPj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAxNCBTYWx0ZWRfX8NKIxnOfd0ab
 qqCwMfh4J4eZmAC5li6qrPGt4NG4snNgudBFG9J4jMXb4mngPDrHkvw6ElqOON8KOMM7sHzJEor
 tI8/j56G94juW78m28N23j3cSFqxbxo4lDLzDxXa2JtmbqaifFezr5vUCZKLiS+dqVCypdPetD4
 Qw+H6wxJhME+CmjNzajLKzFKXXGndkih2WX2mfLN8QQ+bauRlBYvRXMV/6gl1kXQj26POO4dIah
 cO+tU14Qodk3hztp+Wc8yveLQi1Y/MRh4gLM/WqWDoxqcKDltnDL17Cmq0tFM0ifBz0JsjQ6q1E
 WnxaWNVo/hsB7WNd+bVGtbTAod6lcQ8Zxyl8HcGi3iUAM9qnNxnPwFOP9ljvOmPhtYnXeD4IW1K
 kOZZ0v3O+EH1800uG7/ubCJkN0yZzVf8a8NK8fNoWCr4biP/0AN76F1y9XZ9xiR8xOp+O4Z7Ngm
 rrohJb5dbyImoWgAXXg==
X-Authority-Analysis: v=2.4 cv=bJsm5v+Z c=1 sm=1 tr=0 ts=69f01067 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=JfrnYn6hAAAA:8
 a=MTERcTr8AAAA:8 a=69EAbJreAAAA:8 a=QX4gbG5DAAAA:8 a=XxVGwUkuwzZ9F3MZWY0A:9
 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=1w2Y23rLpnaGpkO2nlKf:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280014
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

On Sun, Apr 26, 2026 at 03:20:21AM +0300, Cristian Ciocaltea wrote:
> Move devm_request_threaded_irq() to the end of bind(), after
> drm_bridge_connector_init() and drm_connector_attach_encoder(), to
> ensure all DRM resources are ready before HPD interrupts can fire.
> 
> While at it, add error handling for drm_connector_attach_encoder().
> 
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 618d2aaa5c7d..fbbe26f8730c 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -577,14 +577,6 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
>  	if (irq < 0)
>  		return irq;
>  
> -	ret = devm_request_threaded_irq(dev, irq,
> -					cfg->ctrl_ops->hardirq_callback,
> -					cfg->ctrl_ops->irq_callback,
> -					IRQF_SHARED, "dw-hdmi-qp-hpd",
> -					hdmi);
> -	if (ret)
> -		return ret;
> -
>  	drm_encoder_helper_add(encoder, &dw_hdmi_qp_rockchip_encoder_helper_funcs);
>  	ret = drmm_encoder_init(drm, encoder, NULL, DRM_MODE_ENCODER_TMDS, NULL);
>  	if (ret)
> @@ -602,7 +594,15 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
>  		return dev_err_probe(dev, PTR_ERR(connector),
>  				     "Failed to init bridge connector\n");
>  
> -	return drm_connector_attach_encoder(connector, encoder);
> +	ret = drm_connector_attach_encoder(connector, encoder);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to attach connector\n");
> +
> +	return devm_request_threaded_irq(dev, irq,
> +					 cfg->ctrl_ops->hardirq_callback,
> +					 cfg->ctrl_ops->irq_callback,
> +					 IRQF_SHARED, "dw-hdmi-qp-hpd",
> +					 hdmi);

And if requesting of the IRQ fails, you have a lot to unwind. It might
be better to request IRQ early enough with the IRQF_NO_AUTOEN flag and
then enable_irq() here.

>  }
>  
>  static void dw_hdmi_qp_rockchip_unbind(struct device *dev,
> 
> -- 
> 2.53.0
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

-- 
With best wishes
Dmitry
