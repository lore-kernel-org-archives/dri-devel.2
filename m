Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE7EC88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4431710EA79;
	Mon, 14 Sep 2026 00:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="csTbHLDm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jd6G7Q0l";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1255310E1E7
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:00:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DNa04L3958913
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fU+lghccay3l1YWQR2/TeQBg
 Cl7YEhDXjCfG/4VrNcI=; b=csTbHLDmRcWjzPz7H2hA8nEsq5UI96VBpJnRgJnf
 nXjIfexOeAwW5G86SoKx5p8ESVoAHQJHy96cbGQ7DEO2+hschSsiyZpnd4aZ0WB5
 Dg5L5fTjbVWBWynlhDMnrRpE9wZfqncsCl4mG57V1qN3P1WoS6YJYyLFrPy1HYTv
 M19EjO44YwpE8y7D0+fiIiR200LT/TlTj+9llC6dBHK7Zzt95HzuLhCsbXbL325r
 JkYkyWAyX9YrNUv0yMlGlZoq/SBAd0jP57NVZC+tETczp9JQ8XSQnlely7cFT3Qx
 oD+iYJTBJC0AJ+hAtGiaxO2z5+1MT2IXWihruGGVhDjPaw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k087h8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:00:54 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5c83007a11cso703476e0c.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789344054; x=1789948854;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fU+lghccay3l1YWQR2/TeQBgCl7YEhDXjCfG/4VrNcI=;
 b=Jd6G7Q0lNx44xdmq5pgivM2ItdjyuVAm8CMvUrXFOdK08Mp+mtWyYPAFxTaMcFDbcu
 cno01NQU7zmPIGiVSehBestn7ZiGDFagxwmU4P8mtTQomKf8MFxnLu4bipOBGolUamVx
 FUPsBdFx5ouN9fA5XDjJMXFs3E1EFcMxPgBRPqHWDLCjN9I8xV1xsguiZ3/prh8h4Lu3
 waYPbqDRkNJIfAyzHMKavvumLcxnriynepXTfR3Dp5SP2j1X8ISlvShQ9HDNQdpM6dDX
 cGkeuwdsJZfgHoSnmAUvl7R7I6wvstWkYHIsbKwavEWmS2vp9Oe9u6pXBHsL80rqtjHC
 8Z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344054; x=1789948854;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fU+lghccay3l1YWQR2/TeQBgCl7YEhDXjCfG/4VrNcI=;
 b=elyqM5GtEuvgPS5MuQhrZRQU/N/OT7QYL3UNoLtMDvpLDWrv7oBBjNYJ9kfNAmaDdm
 hk7alXWprUywTokIiHAJ1foumWVoWHyAvGmi7M4U4TxymOACNQopKo7sEcnvMJ903Bda
 nGzvhTY7pZM71Y/jq71vzlotJr1dnv+F5GGd2Jqe9SBRT7UcSbbQn4l9ZHm3Nx0nyZH/
 knzqsV+CTL9A1lD+1byL+Ae3BT7z/ytzxFKIc5DFv5+LPOENE+YTbreZiyHxO5Yzrdzd
 mdwa7YJxqU3ymIZxGSNf1E2aXNhocbGzLOLg6JP+3d8E9qGUcs6pW++smhtn2wRoWAQk
 3zOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBynrqrMALplL1zkWG0AG4Cs0tmJ80sdTsFUXJteYwXtD/6iWxuJjHtz0ZEPjiUTX2VCkaoUVBs7dIo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++njy9wl5zrbOFExr4YUKx2sC8rG8fSD+ZXy/O9YU5Lp4WnijRQz
 ZVVn5LrkTUjzx/hJJ8BN2TroulLElha6mLp9RCZYg0b+t10UeuLTimu1sqDgWsPZco7r5Zpd4Fs
 p3jFBUnK4nLTgzlJOMbeBa9QpljyOPoUJyGH6CKXeFlXl7/9tMM3lzseMRHE3wRlsjXU/blQ=
X-Gm-Gg: AYBFou1942FNlyfcAzsTbQUhu7pYT0+pFfcAQ5tWrT4GXj+X4GPfuce7JcMiqssHHFa
 LBBr01JZQMbB54Bup2X8sQ0a9ABCIVQncfFaVf6qgd0uopNj5avKTbC4ekjhA6aLOZte8MS6Scj
 gP8vIZL4eDYYAJtPs8pcSI6l7xKjfzx1gNx4j3rfy8wQHj3zJhY2UQZr/1xYKU4lcHVp6eVzeK8
 V5DYaXs/L7bZcFo3jPnZVN9vpQWb5zmxpQZSgyZYR57jsT7vUc+e4PmQGHF7ftjuBudVybWAP32
 Hxh5kf3fvVmolwx4ZGszeuU9onfjvRzNeAQWQTNswL1OYrPI2w1MobexgSbq+tlD66INPzPc0Gw
 zwwKZgLBeU0TTroH9imzT56fxwyZMR+5nLJaBQgQdvecJkVgXVmHDfaUM9OPm4WBAhGb9NBghwp
 +Hac14Rn4IusqZ
X-Received: by 2002:a05:6102:f13:b0:79a:21f6:20fc with SMTP id
 ada2fe7eead31-79b5abbb41fmr37346137.10.1789344053617; 
 Sun, 13 Sep 2026 17:00:53 -0700 (PDT)
X-Received: by 2002:a05:6102:f13:b0:79a:21f6:20fc with SMTP id
 ada2fe7eead31-79b5abbb41fmr37319137.10.1789344053173; 
 Sun, 13 Sep 2026 17:00:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0464430sm2051683e87.42.2026.09.13.17.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:00:50 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:00:49 +0300
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
Subject: Re: [PATCH 08/17] phy: qcom: edp: Generalize power-on path to
 support per-SoC overrides
Message-ID: <mpkoztwm2ts4pb3m4t6347wfes4yeua5a5uxrn66dgmn6b6gpq@syu2fxzfmvp7>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-8-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-8-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDM0NCBTYWx0ZWRfX6gFhpSYBB/a/
 hkoRc3vQGyoZuSuw6S3EGz0lsfMPVo3EElJjcocEMUDsBvzXCS9bfvai0fzY23Tj+ZdGRYnEuFd
 bshucduymH3apubyz1C3bPVH8rVewKQ=
X-Proofpoint-GUID: 4WvAJhvPPR_WQcNYeFgIVQ9HV_tDMqzJ
X-Proofpoint-ORIG-GUID: 4WvAJhvPPR_WQcNYeFgIVQ9HV_tDMqzJ
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa73936 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=tuu3QHpEyBHuk3RROvYA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDM0NCBTYWx0ZWRfX8/rBq0AiZTpx
 pFvwqwMKvb61QQEEtM0ucW/jDoYrZQYxFKygtn29ThIRwyNQxpEaAm5L/YWfn9BJfXdcPrroBuU
 i4FnKDNq3hja2MT971mcrRLZEYtzHnX1PdgU11lzp+LYMe8vaYr8bJQxbeuyzj2PlqGgebYN5MP
 i2rvEx4irVSPOxkpivkDMJTWkyrLnMXnwE9osziC4BGgqs3ODwsvstDtsgqO1GSKWU/uHM/fst7
 utEsKNsnFjGtcw5wN/1m0uwTPb3jTwweu/9hlMpx5doz8EEdjpfadksq3++b1STFREBmznlsTcy
 oPPQnIrbV6bkURPwbzZXo+FdbTA/lhHQaVety58iMZ178QDRlCMvpDxlKSvCDevjvDuDvUCo8VI
 2d1reITHOjIzX6QTUMZwlrfvkfXL6MKd4oqrKrd0kHNgoyibdgDhk8MLMvSREY892fg9GElKZuB
 JyHAZNe2V7YczUn6c9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130344
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

On Fri, Sep 11, 2026 at 09:06:39PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord has a different register layout and power-on sequence that the
> existing hard-coded paths cannot accommodate.  Make com_clk_fwd_cfg
> optional,

Why?

> add phy_tx_lane_cfg and phy_tx_res_cfg callbacks to
> phy_ver_ops, and add phy_status_reg and bias1_en_2lane fields to
> qcom_edp_phy_cfg so each SoC can override the defaults.  No
> functional change for existing SoCs; new fields default to zero/NULL.
> 
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 43 ++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index bf8a17336c7e..373f13b3d6d5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -92,6 +92,8 @@ struct phy_ver_ops {
>  	int (*com_configure_pll)(const struct qcom_edp *edp);
>  	int (*com_configure_ssc)(const struct qcom_edp *edp);
>  	int (*com_ldo_config)(const struct qcom_edp *edp);
> +	int (*phy_tx_lane_cfg)(const struct qcom_edp *edp);
> +	int (*phy_tx_res_cfg)(const struct qcom_edp *edp);
>  };
>  
>  struct qcom_edp_phy_cfg {
> @@ -101,6 +103,8 @@ struct qcom_edp_phy_cfg {
>  	const struct qcom_edp_swing_pre_emph_cfg *dp_swing_pre_emph_cfg;
>  	const struct qcom_edp_swing_pre_emph_cfg *edp_swing_pre_emph_cfg;
>  	const struct phy_ver_ops *ver_ops;
> +	u32 phy_status_reg;
> +	u8 bias1_en_2lane;
>  };
>  
>  struct qcom_edp {
> @@ -316,9 +320,11 @@ static int qcom_edp_phy_init(struct phy *phy)
>  
>  	memcpy(aux_cfg, edp->cfg->aux_cfg, sizeof(aux_cfg));
>  
> -	ret = edp->cfg->ver_ops->com_clk_fwd_cfg(edp);
> -	if (ret)
> -		return ret;
> +	if (edp->cfg->ver_ops->com_clk_fwd_cfg) {

Why?

> +		ret = edp->cfg->ver_ops->com_clk_fwd_cfg(edp);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
>  	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
> @@ -1131,7 +1137,13 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>  
>  	/* TX Lane configuration */
>  	writel(0x05, edp->edp + DP_PHY_TX0_TX1_LANE_CTL);
> -	writel(0x05, edp->edp + DP_PHY_TX2_TX3_LANE_CTL);
> +	if (edp->cfg->ver_ops->phy_tx_lane_cfg) {
> +		ret = edp->cfg->ver_ops->phy_tx_lane_cfg(edp);
> +		if (ret)
> +			return ret;
> +	} else {
> +		writel(0x05, edp->edp + DP_PHY_TX2_TX3_LANE_CTL);

if it's about a single register, add a register to the map instead.

> +	}
>  
>  	/* TX-0 register configuration */
>  	writel(0x03, edp->tx0 + TXn_TRANSCEIVER_BIAS_EN);
> @@ -1169,13 +1181,18 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>  	writel(0x00, edp->tx1 + TXn_TX_POL_INV);
>  	writel(0x10, edp->tx0 + TXn_TX_DRV_LVL_OFFSET);
>  	writel(0x10, edp->tx1 + TXn_TX_DRV_LVL_OFFSET);
> -	writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX0);
> -	writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX1);
> -	writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX0);
> -	writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX1);
> -
> -	writel(0x10, edp->tx0 + TXn_TX_EMP_POST1_LVL);
> -	writel(0x10, edp->tx1 + TXn_TX_EMP_POST1_LVL);
> +	if (edp->cfg->ver_ops->phy_tx_res_cfg) {
> +		ret = edp->cfg->ver_ops->phy_tx_res_cfg(edp);
> +		if (ret)
> +			return ret;
> +	} else {
> +		writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX0);
> +		writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX1);
> +		writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX0);
> +		writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX1);
> +		writel(0x10, edp->tx0 + TXn_TX_EMP_POST1_LVL);
> +		writel(0x10, edp->tx1 + TXn_TX_EMP_POST1_LVL);

Either use a register map or move defaults to the callback too. My
preference is towards the former option.

> +	}
>  	writel(0x1f, edp->tx0 + TXn_TX_DRV_LVL);
>  	writel(0x1f, edp->tx1 + TXn_TX_DRV_LVL);
>  
> @@ -1187,7 +1204,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>  		cfg1 = 0x1;
>  	} else if (edp->dp_opts.lanes == 2) {
>  		bias0_en = 0x03;
> -		bias1_en = 0x00;
> +		bias1_en = edp->cfg->bias1_en_2lane;
>  		drvr0_en = 0x04;
>  		drvr1_en = 0x07;
>  		cfg1 = 0x3;
> @@ -1210,7 +1227,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>  
>  	writel(0x19, edp->edp + DP_PHY_CFG);
>  
> -	ret = readl_poll_timeout(edp->edp + DP_PHY_STATUS,
> +	ret = readl_poll_timeout(edp->edp + (edp->cfg->phy_status_reg ?: DP_PHY_STATUS),

No hidden defaults, thank you.

>  				 val, val & BIT(1), 500, 10000);
>  	if (ret)
>  		return ret;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
