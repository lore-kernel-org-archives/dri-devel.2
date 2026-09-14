Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D77DC88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B5B10EA78;
	Mon, 14 Sep 2026 00:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WAAbncT5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IlWww+uv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001BF10EA78
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:07:53 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E06brT3131960
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=J9bwiN3dUdd9aP+bWdeapn0I
 UEMXk3IGQ9B6+59SCMk=; b=WAAbncT5aYE4iVuA26PKrx/TkOqCQuGMD3P8i0SW
 zXs3f58QXjx8entbqCuWonjnQjafY+bXDHP9pYslQlL3RNMAl+Hs6LWAEinbidpA
 Dw1Ga0pyEMbNlFtvj2sIm/GFcmXaQpWG2hHRg1RE0WbBmSNS9i9Q1iuP0Q0XgRic
 B3pTDW+w2to7Tyc4T2c2wzsm5D04r01/whGNtEd4hDEZlqOB4gaUsNBcerHZ+ztC
 7kZt74zdus8/sPk8aEH/yQRp2R1jZaPbC781Cde85xrcvhKGi0eAQ4nyk8vixDhl
 Zx503zZXrH6aayjKmCXUOA/zsDMxfukQuCFWp0H0zYQ6KA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c4dss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:07:52 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-97cc09260a3so3224811241.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789344472; x=1789949272;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J9bwiN3dUdd9aP+bWdeapn0IUEMXk3IGQ9B6+59SCMk=;
 b=IlWww+uvQrn13fTZIM0PWr4CycFumucdiMe/gM2ANF1BVH+Gs9hfbZjovayv7r3rWp
 ntMCfUJP4bxSBT99pGBRMHutJijCZ52lHlugXnjHfqn0oUlCK4oLqxk6Ydw1omVN1J8g
 87BOhaEtdnZlVYnuIGwlH45tJT3IgEBvkbgmBi6i6Ufz6A0qeBJMHv+1fcPS5C3vkfm7
 v/lI1k0fq1fC7Yb4MIW9lzk7iN95yGbiRUrjHiXkPaF1bREVIqrBfkUvk4I+qC2T5cAn
 eo8Jq6BSg+jGoyRk9qOd4Q33ctoGEHIlrrC21fvYjeU6muv664AMlNPdp0/yQAgfUG+O
 RK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344472; x=1789949272;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J9bwiN3dUdd9aP+bWdeapn0IUEMXk3IGQ9B6+59SCMk=;
 b=lFemOMtRaYlwibqy9ClX/P/uTjJD5VWGIBK/SX4waqA1l1tbW7wY7JvmsgTo/JzfGZ
 kwU6R20XWgK8Akk1d8dN23BTFth/D6suI0llhbXu2TgDLIxINRH6d2cv8N5STYQzg4xx
 mQIyfqG5Ns+0aXCBOQUH/Yc0SjGAAfA4usHkHs8mMghV8PVRsW45Ct2uTd9t6LVjqi6h
 y8TfkB/FIG/x1JgnfwbBZki409AVXSgoeMQKOqWICSthKzoFCl7pR7syIsyE/o0ZBVuI
 h1PvS/UeyY0tvPvB2AVs2DSUlE8NHAr+GhkCRAZXzp5wWsfnL+OGV6qMfByNjRW/zH3y
 NTHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByuNodUAaT9HmuoK+PWW9GXCYL3SzDL0vp4AGMTY4C2rNE2ounjqpOSNu28PJI5AKgf8LJ7ZsIwaPI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mpI5cc4mhBIE00dUITJYnpSMrk4qm/+uuROMZ6GPqIl4Egu65i
 R6XQPz3dOX+yIcZ8dFN3lgAYnWM7rJUNjpaiBvfBGWrxIg87UXqi8AZp1dxZVi26n1IAe4D/tJf
 gbaVdHbZJRrdzXzc/buz48MJfCCZzh4RnR2F2ASWOd0xlFIlsnUhkUM1vXL99DH4soqFcPsA=
X-Gm-Gg: AYBFou2Yrjmz9rpBOhX6RACk6yxFTSsOxOEb5RSj5Iq69btRPZhE4Hapmw07uh4+a3K
 YcxXQvIBmtPCqOu2+T72TftvNnrukjHS11cj+RLwHlem75cp2IQ7M5Ot4oZoc/+piCmr4XzzxAr
 glQ9bSBGB4mhfM9abrwSBvvC9aKKOm9PEDc+Rolis9NbSvTwa/c1ieiFJ3xD59FnPQ8Mh37+pBH
 EHWKfxIL9/XnLN0ire3cEbsGJhOWBwgvLXuX6UjQk0THFzaMmMhxrTLPBDFBzybNqEXkQ5zhYqM
 idgw+rNGJnnefP2p8hbCGYKjYJNHvjGKPEvddI6pe5MAQKMg1DNcc+PMLLUDwGaIzM2k/AUngMt
 E7f5abzE2S4Q6Oh01gYfGDK9JWiNsbbOZVUYzdXoo2VapLcfjMt3X5Sh0Zl06DX9QH7t5I89yqA
 HCLTTBr/Rnmdyi
X-Received: by 2002:a05:6102:638a:10b0:780:c9c:bfcd with SMTP id
 ada2fe7eead31-79894637907mr735051137.17.1789344472099; 
 Sun, 13 Sep 2026 17:07:52 -0700 (PDT)
X-Received: by 2002:a05:6102:638a:10b0:780:c9c:bfcd with SMTP id
 ada2fe7eead31-79894637907mr735027137.17.1789344471682; 
 Sun, 13 Sep 2026 17:07:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0461a05sm2019561e87.37.2026.09.13.17.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:07:50 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:07:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 12/17] phy: qcom: edp: Add Nord bias and clock buffer
 enable callback
Message-ID: <4z2wtovf7uzmomgoqkjfgcuu7jg6l5rsojiwtg2f5t4tmdqynd@szbd7qtdb5er>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-12-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-12-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: GxjexrVHZmzP-hGXa_4KGYEb1Uvl7ymX
X-Proofpoint-GUID: GxjexrVHZmzP-hGXa_4KGYEb1Uvl7ymX
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa73ad8 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=JfrnYn6hAAAA:8
 a=EUspDBNiAAAA:8 a=rJC6BC1qXBLC2pyjZnYA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwMCBTYWx0ZWRfX96tAQFzngfmE
 CzdVfTr138ZikEWvjvcykL19eUT/NTC9dIhaMgqbfzLt76mKWq5o3oZnPWkveYcOZcAeDiJSSYu
 bI/Kt6jKWY2uGVuUbQKNETOfhRSiPv1bVgppOPHQZYkY7nG5Wg2DHZIV7CTXvfah5h8Ad8s9VM+
 Lct5anbhLinD/W/AbM3QHQgbk7pzYdWfRn9QTyWePTI/6N1ic1mWG5qRQQ+cZmKu6xZl7tteRkx
 aF4HueEfCp9bB0eMW9A1YPvpLrStpDW5IZ6o/Lp+YaV7RQxZ3k6sby4k3T8VKX03qLez3G1ec0q
 ncOLgQsDPCwuyyrZwZxVc4WVOShGikB5pZFxjFv1jhvorQIO3jgtqYKIShQZ6aRI/8w62dA0LVJ
 oxIV0J2ycnMjuTNlebzYcWuRxwY6LS8JIdBVSqhlqont4cG7P75yHQAvXDohSM6ZTByfsE1mbx/
 wTVf4cJtJJ5iiCAvbTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwMCBTYWx0ZWRfX4Do9RZANuaYV
 IGMWDEYBUMIOt/hc+5Butof+JQTVqIjVpuRHqb+mkql1+uY2L0ijZFzYc5ms61RwZuPN81xfvmS
 3UhCafSdvLGHZbVOsrPA7UBtNOpzxVE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140000
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

On Fri, Sep 11, 2026 at 09:06:43PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord requires BIAS_EN_CLKBUFLR_EN to be set to 0x1f to enable the
> internal bias generator and clock buffer, which differs from the value
> used on existing SoCs.  Add qcom_edp_com_bias_en_clkbuflr_nord() per
> HPG Table 2-1-d.
> 
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index 6cac4b55b66f..ec4220cffe69 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1637,6 +1637,14 @@ static int qcom_edp_phy_com_resetsm_cntrl_nord(const struct qcom_edp *edp)
>  }
>  
>  
> +static int qcom_edp_com_bias_en_clkbuflr_nord(const struct qcom_edp *edp)
> +{
> +	writel(0x1f, edp->pll + DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN);
> +
> +	return 0;
> +}

qcom_edp_com_bias_en_clkbuflr_v8()?

> +
> +
>  static const struct of_device_id qcom_edp_phy_match_table[] = {
>  	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
>  	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },
> 
> -- 
> 2.34.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry
