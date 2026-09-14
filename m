Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67DEC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8A110E6CB;
	Mon, 14 Sep 2026 00:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEH7RHt3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVJvGlJE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9586510E4BE
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:26:50 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E06lMj1922361
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fhHkV5ZH2IWbRWw4FpuzKYxl
 rQHT67Pv+hyugolUmOE=; b=AEH7RHt392v0JFqubQvGMbrb+Bdmsxhn89rvkWl0
 jV1+rcG9FMUUK8myYDDs19gnBQTjqNkkfjy47SYrGHSagk1R0CWqYaxZUHMXQroN
 qRQ7VdIVuVtZBKbVVkXfQwAr031KTzjdMr8oqF7oFRUt2gRCQl8CuHnKG2tf7/jT
 lf/CHAp89RGIyZ2EvXf4BPUqF8uKqVRBW0GlR9FXwEEuQx60nUdEVX9j7Eut3aOT
 IVSyWzCjHOy8JZLJbIo22hcOKTtHzZOUBJ7fBQfwSjATyv1K3FPsil+UP7oAumaS
 pSVeP23W+iMraoWttGxSSn7gHUGXao0LDZWGtsuvVI4z9A==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmywh49jj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:26:50 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c79915791eso904682e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789345609; x=1789950409;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fhHkV5ZH2IWbRWw4FpuzKYxlrQHT67Pv+hyugolUmOE=;
 b=WVJvGlJEe7ZlF2Zhpqirf7CA3sZ6XDY07ayzBbUUMEOyqsmutKPZS7LvAkNOKLPL2M
 GgsE2K8S9aKEVWKjsbTY2koGm0EsBoZKtJnsgsMWix7+LQHrXpo4Dg6BtCagP/vEgbgg
 cAYgnVmV8soDMMay+BwXWymSIVUd7HTK2G+SHfQ+zdremb/u0IOk7M+9JlqnQ5bjuPwy
 XqkB+jv/P/NVaWr88zxclR8Z0hdZ7PcwcpDFr1HLq9/N/Wufvl98pVHR3CFLcCPQovDh
 UWoPc2cN+XDzgQfhsHgil79zN1WqcXemcViv1naaGL3mtRtmFHPz9/xVnJKdWyQNr2Zh
 we6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789345609; x=1789950409;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fhHkV5ZH2IWbRWw4FpuzKYxlrQHT67Pv+hyugolUmOE=;
 b=lIPWRa9HV5zmT974rmKQULni7PJlB2dp9PxEGIH317r8QsF6kqowgWbTyTBNRqWISS
 a/Tt39zy3ODQjQScfG2/cxKNcZbIrGBacSYdzcGSOlq77OKs5jDovCRA/UJblHfcQhty
 aCKWe9JMPePuwgZSOn7K8Rck1ICq+xjAcQzju32HvLyX5RHAYIpssK8hnN66B2AC0zwN
 +1I48IsvGViDEZ8ErUEX5cMezaylwZl6KkEabyqxTcp5ah2LGRa+MgG3xNPaoro9SLHX
 vsksltUb06ZZZHDowfeOPxpy/0wVq5fGDxKqxHeIaYpmOhNLvtkrgV2vVEjrK1G33RPy
 4btQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx00NJ0xJniyKK+a1bOy86ihu4EbcBcSE8h1lKllntjkSC7Q/J/1tPZ4dAh97Ivr/iAlGO4MtmzvSk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++loPWoRlhQOjWY4qRUQ2FNheAdu5wY1OFekBnGuH2xoepgPed4A
 TMMKjPkATIV1Vp8RvQZTYYS3DMfGSxy64SOd5fXpuYeRkupqqq6eV5hNlwI6dgI6TiYFuxsCMk3
 MMMhR5wKs8jU67xCGki4sQJ+WvlxD++yhqtdN2tlC/3IjYNnk1W/S4IuHnUl1hgh5O42K6MM=
X-Gm-Gg: AYBFou2ky3Mh29hdWt/AX7zQhCAkrT/g3XgnX+JNh/llV6qZK7Jl6VTYDG3cKZ+3i7k
 /2+/ZlaF21OFj7UQ/jtk3jBVWxJ3882jw+Q2Ft36/zJbi9Xdwf8Z4yQxotS+nl9ax3988ZOczRX
 RKkFWm0z/cTW3mz1EOiAUUBMUp06iJHoFzCEGbuaHcdxp4BsvtcLTYZ4aq/DlvrvTYMrWut2V6g
 yiCEfQn7kNWwkUc1+bB33YLm64IZ1aJp51KtKm5TN+EZdwhQraAFzftwB7MMs96SK//Ijm+xZUj
 C6lGDGsB8xTsGd7CMuQM6F7gk17AzzVyWGsTjyScZx6C1TtWzhflLU0ItVla6g4wYjsfKbjIFIV
 G77jILeWLz/wk1FiFBSNYc1oSnJJDxEvUsRbRYKOHBuvmJdYl097YmrjgXyF+pah7CVBknRx6Lo
 jBrY5MnFDkQuyS
X-Received: by 2002:a05:6102:b0f:b0:785:c39b:6a1 with SMTP id
 ada2fe7eead31-79b5d8a21afmr86439137.6.1789345608909; 
 Sun, 13 Sep 2026 17:26:48 -0700 (PDT)
X-Received: by 2002:a05:6102:b0f:b0:785:c39b:6a1 with SMTP id
 ada2fe7eead31-79b5d8a21afmr86411137.6.1789345608432; 
 Sun, 13 Sep 2026 17:26:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0456644sm2091675e87.18.2026.09.13.17.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:26:45 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:26:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
Message-ID: <zfytnhu7vipotsoztncetoffnlzkw62vz2scuoogieol6et7ro@io7nslu5sdho>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
X-Proofpoint-GUID: IOzAVjg58-WxlizoRRW19EzYEGKDg5CH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwNSBTYWx0ZWRfXwzBHS2DxXCwG
 9P7ohe5sDw5LUWDMm5OXTXVaVVydim/dc3yKnX6GAd9l6/MroazeTeLTV5g6sOr9lye5k9lp37C
 SgaOAfOfXnf8UTfmJ4qcyJaEqb9jabm7q1aTXEuIqr5dFpFrtqQ/Ki4OtVZtsOVgn4ofodEd3a2
 4ejQ1k3txlgmmR5SZYzXlowJ9amP+RC2Z4orpYWx2x8JaO9ps8ZIQHE9d2zqqCd+Krk+jGeCPGj
 X5JeaaTXeKMZ7DZCgm7wLLkmktVhf2Yh2FzyNQM0/TYUg9W+zS9eCce0P3q5LF3NQdUizlcLqyv
 wASLykSDmDtys6wzdXXyf0Crbh9sZtFwzHdLh1kXzaEliSWGqTg92w6LhaftwPjGevNdsGP8gTc
 EcMQhzg4oQCvSQO7rfc9QazIJHUIfSQwU+qTiwO+pFVJo3l7INu+h2eZmUXBFlwF7bEC3gjVOHS
 aC/668y9ipe4Iq9jIfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwNSBTYWx0ZWRfX5XC4gtgVf+3J
 lE6419Q+n5mJ2KLuj8J2UJ3qBv/ZW2kXjAc7qJdYrn1fXjNqO4tXmyyBLbugrzjsapPbx/xq0nx
 xd9pGlFK9DOlZbtYBfXD5Nu8VT6bw2g=
X-Proofpoint-ORIG-GUID: IOzAVjg58-WxlizoRRW19EzYEGKDg5CH
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6aa73f4a cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dCp4QOuT8fr3gmi_UlEA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140005
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

On Fri, Sep 11, 2026 at 12:29:34PM +0200, Krzysztof Kozlowski wrote:
> If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
> it should reverse the state of things already changed.
> msm_hdmi_phy_resource_enable() is used also in probe path, thus such
> failure, which could be simple deferred probe, would leave these

There can be no -EPROBE_DEFER in the middle of the
msm_hdmi_phy_resource_enable().

> resources permanently enabled for the rest of the runtime.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> index eb1088755cb3..15e37596bdb1 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> @@ -67,16 +67,28 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
>  	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
> -		return ret;
> +		goto err_pm_put;
>  	}
>  
>  	for (i = 0; i < cfg->num_clks; i++) {
>  		ret = clk_prepare_enable(phy->clks[i]);
> -		if (ret)
> +		if (ret) {
>  			DRM_DEV_ERROR(dev, "failed to enable clock: %s (%d)\n",
>  				cfg->clk_names[i], ret);
> +			goto err_clk_unprepare;
> +		}
>  	}
>  
> +	return 0;
> +
> +err_clk_unprepare:
> +	for (; i > 0; i--)
> +		clk_disable_unprepare(phy->clks[i - 1]);
> +	regulator_bulk_disable(cfg->num_regs, phy->regs);
> +
> +err_pm_put:
> +	pm_runtime_put_sync(dev);
> +
>  	return ret;
>  }
>  
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
