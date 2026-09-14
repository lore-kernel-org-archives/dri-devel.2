Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD25C88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0474710E1E7;
	Mon, 14 Sep 2026 00:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a2sP1jSc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PbZtkT3I";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 530DA10E07D
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:07:06 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E06KcK2422266
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mB2tXTYElK9wlaDpsNW/VGIQ
 GRoWVlamEFnm6tcQN2A=; b=a2sP1jSc+J8gb/HzYw5SU4wOvQdqSxXUqCXrRPH2
 qnS85EY12kfioFFdLIj2ySXvcdZUx3jyETjnqDmZ21YwAFPE8ffKMxQhcQS/TcQf
 qDYKU1qR4zkaCWNyS7tRZdXe9iTaMCf9u7rrYTdpp9wNjZWr7Usjaivtg2RQ/TmV
 OPUSgsK4fus+rapk4i4ithO0ySwxxooISnAli+ScWpUcIMO4I5A16CqcD3d/GXev
 5Ff9CgGsSfea8yV3mVttfSEJSjeScwH1XkyK+mNqFf1G+VplsQN60ga1Qy4oc0M9
 iIszyybic4wIrgx47s05tgONvXRfa6rjky8prJ82NHHAFA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gn018m8st-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:07:05 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9806535f8ffso3135033241.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789344425; x=1789949225;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mB2tXTYElK9wlaDpsNW/VGIQGRoWVlamEFnm6tcQN2A=;
 b=PbZtkT3IiSbgiaQoRO8CPl3MyWrXm+mt69TKQe/b+zzAm1mRwwNWnWECzquVyChsO2
 KXS+r6g0HC2WbUX6sqREPTkTCW/95j65PParnEU6lA8wkP09oYBLr9vTDca2+E6R7q57
 BIjUMyWpDl/VPnPjSmYMMWWbrA5Bft95SlAQejCgEJUoEkwQdkN8OtAol7nmaJEn7U4N
 XqGqJoBtKwe0jjxQJyZiYE2A6FGd64QDsrGLACR76FaZx7xciwX2h7Vq14JWDXagx64j
 6WcOmgJ7S0Gnjb9r88GAR8naKU0FITfGu0e46aoKfKR4+/tNY4/yVVeCPJvYs7D5C8ye
 nkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344425; x=1789949225;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mB2tXTYElK9wlaDpsNW/VGIQGRoWVlamEFnm6tcQN2A=;
 b=Oc+d5ydqhcQ3/FLgIekM400CTeP8UBzhUlsn9iaOO4p1tyNkSKoAiaDINQ4H3WF1zU
 h5CfovF+z3jbXDf1E/ts+Y5sug3bQiGgLXlcB+SIFXO8gqdRJVtKP03nkDM4sA1gwSaP
 eK/8DzORUwJcqkR0wIOLUrI3Z7VstNCbRPiqOPfQOXY2k71mKdrjd7JnTN4tHeqk6a9n
 qkgPE9U0UBuYekTxjKVGE3V8Ib7pk9aFnEhLcgsGgmvjxffJC298gkl1q9ScySIVNk3S
 phFT2JhSbQxdeqTaVXFkekqUNDAsq0IMGWQixdbpzPV5KEjeE9syogp7iM6YcyRGUG8K
 YVDw==
X-Forwarded-Encrypted: i=1;
 AKwUvByiBTiMV0JHYpEyiB6i9E4cvOH+N2EjUdslShFgTNYZDYg4NF79MNqZzJuCeeBnotmLm5LsP5olHFc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kuED48jHVuZYvWrE/En4x/H26vp1F7HTShPAeHgPpP1em9Bs3M
 GLY3RYbKk5Hze4g5/TypnTNl8+/hhB0klzKscWJ5qePg6RFBBHF0Jm5WbVoWMR0y9hRtnfnHg53
 PvpI9vZMlph9qsiwYensbT+JXnY0VBUqvxVTUDr3IsMgVbJBf+Wv5Omycssp9nZl624uMf+s=
X-Gm-Gg: AYBFou3N+u6tMh6qi/gd0z+CeiCfv24iluGrOxs2EZtsZjx+Vxh+FpjdoWTuJWofnVK
 CVHN/WxoPW3bKBR1OhJG6Z0OYtnz2kcttcML8hXL8pbUXpeI7GEtFG0mb1PJI/tcHBC+EF5NdjM
 w/I0yEHx94JP2P6HViasujDpbnT9QGdnXSO3+/ezpD/DOqVwz6gTCGnALbnP2j6Ai/pkc+yPO8A
 9jlIW9B2QYnWMGRdJNskMvSj3k5D9sKCfw//m5j1BmoUJAU107jw9nZQFDJd+Al9pyQQ9Gl6coQ
 ac3/Ir5CuPB0dfGMH3l+lDMr2rfIPBHLDEnAtr3h4plZ1BRAe/E96nLbQPraRrKcuHbTeqIYdZN
 3h3hcl6wx3kdX9QGDhhWIdB6vzD+nTNWoYBAuhLFGp8+cHI3WQYo1G5WiyhGwWwtKUAqxG1BfXE
 q7o5wEDboJr0YE
X-Received: by 2002:a05:6102:638a:10b0:780:c9c:bfcd with SMTP id
 ada2fe7eead31-79894637907mr734623137.17.1789344424883; 
 Sun, 13 Sep 2026 17:07:04 -0700 (PDT)
X-Received: by 2002:a05:6102:638a:10b0:780:c9c:bfcd with SMTP id
 ada2fe7eead31-79894637907mr734605137.17.1789344424487; 
 Sun, 13 Sep 2026 17:07:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a045726fsm2036893e87.20.2026.09.13.17.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:07:03 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:07:00 +0300
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
Subject: Re: [PATCH 11/17] phy: qcom: edp: Add Nord PHY power-on and reset
 state-machine callbacks
Message-ID: <53h45tzuwxcpa3dgto5jcpc74hpeifzuhdjwvwlgsbvkxaxlcg@p2p5rciv3e2g>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-11-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-11-e25c073cf1b6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=c4g+0h9l c=1 sm=1 tr=0 ts=6aa73aa9 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=2o1v5Kz8aWF9ZuGQiYsA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwMCBTYWx0ZWRfXznsNBPkJS6Gj
 VdjNpMSWsuM9SALvIMJ1VKkgiWxdTQ4DLIw2Os9yQ9S1JxIY3USjUhZb2HRdGGK3gbIvArEMfpr
 7xP7ojQsOpd0CKBvXz9ZzkgK72PCutA=
X-Proofpoint-GUID: WsGDvp1f2-5QVsLpFxke-008cz953AWD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwMCBTYWx0ZWRfX5w3QXehB/gek
 Z3PkHmPYYmNIPJs3jyFMU4645PPbsbvuEmARCAlbnhk7xR2KriGM1n7imJ2m7pPmXpGKaYmNN6/
 zxvTiO8JLpTpgxQPTnoNJ5bFIxx68RrQLKqRpWkUV+S02+1wy+wlBuVA5aGf67EbQfgKPA6jDFA
 UqwitC32ihLrPnY/rGF/Wuimu47EX6Qt+4u7VGFAzYM6MFhxy/WxD95mHTOEywKINEUyml4r0wN
 eLIgGqks4YGAU3EVmbM5d1inYSs7bCr4nCk4Rz1bbMsEDgVWTtuiPzx5yjgKzP5J+tSq1eI0HSx
 WsizWkzDVsTDu0yP99qyd+7vuGD1obvEtl+40bnBBSZZzyvuYF1K4Q3xRTg5/APhfsYHV4GISJt
 OCzOmpiMXm75M31geTzApn6quc6afyI96mn0XZLHZklJMlq91onQRv3UnTQII5Kk44MHAAvGXTP
 mY7OpWzqCuAodgJ9K3A==
X-Proofpoint-ORIG-GUID: WsGDvp1f2-5QVsLpFxke-008cz953AWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140000
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

On Fri, Sep 11, 2026 at 09:06:42PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord relocates the QSERDES COM CMN_STATUS and C_READY_STATUS registers
> so the generic sequences cannot be reused.  Add
> qcom_edp_phy_power_on_nord() which powers down all lanes and polls
> CMN_STATUS_NORD (0x1d0), and qcom_edp_phy_com_resetsm_cntrl_nord()
> which triggers the reset SM and polls C_READY_STATUS_NORD (0x1f8).

If the only difference is the register address, please use register maps
instead.

> 
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index 64878398f43c..6cac4b55b66f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1612,6 +1612,31 @@ static const struct qcom_edp_swing_pre_emph_cfg nord_dp_swing_pre_emph_cfg = {
>  };
>  
>  
> +static int qcom_edp_phy_power_on_nord(const struct qcom_edp *edp)
> +{
> +	u32 val;
> +
> +	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
> +	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
> +	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
> +	       edp->edp + DP_PHY_PD_CTL);
> +	writel(0xfc, edp->edp + DP_PHY_MODE);
> +
> +	return readl_poll_timeout(edp->pll + DP_QSERDES_V8_COM_CMN_STATUS_NORD,
> +				 val, val & BIT(7), 5, 200);
> +}
> +
> +static int qcom_edp_phy_com_resetsm_cntrl_nord(const struct qcom_edp *edp)
> +{
> +	u32 val;
> +
> +	writel(0x20, edp->pll + DP_QSERDES_V8_COM_RESETSM_CNTRL);
> +
> +	return readl_poll_timeout(edp->pll + DP_QSERDES_V8_COM_C_READY_STATUS_NORD,
> +				 val, val & BIT(0), 500, 10000);
> +}
> +
> +
>  static const struct of_device_id qcom_edp_phy_match_table[] = {
>  	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
>  	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
