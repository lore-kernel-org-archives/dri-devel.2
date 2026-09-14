Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C0DC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F2310EA7B;
	Mon, 14 Sep 2026 00:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a4I1IM2R";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BLRcL7aa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AEE810EA7B
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:12:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E065RP1920441
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iBqYeqzlYtNhEASxOYthivbr
 ArLVaXRL5F5mIYJzUbE=; b=a4I1IM2R4U1J5p/cgW5v53ft0l+3aKuGkhoaeN6W
 1V9Gl1Df1TLWWTdLzhdo2d5PdVooU1TZDJya2FsJ2PaP6lAcHGGl6Od/u7hqaLlk
 FX277kySkhVlq8yo7l8ML++ln1b5Pe5+2ErKWm4Ij0cwj8UXKQSHTilzfh3Y3hAt
 8utdbXlR0jMwfFa9ffmkalPODTEXx29fXgs0lfoIvT3xAAqSbgXY5r5s795dSjhq
 bFoaVofgasBu4yN7QU1lPwZkEenBfP4ccUgpHXNn+qE37e+SOk0VDqkNmWD+0F3N
 EeWnjVbYKznK0YpQQx/E9MoktyAu0rGSVZFIagq98Vq9ZQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmywh48xa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:12:34 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-980b637ed69so315953241.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789344753; x=1789949553;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iBqYeqzlYtNhEASxOYthivbrArLVaXRL5F5mIYJzUbE=;
 b=BLRcL7aajMYSNgTCvbxYMluJe7u43VVwFUMRGZaIrPC2QpcrEh2ZQ/0JMnh3PVo9DA
 mlq2gi2SPNY1qO0GRQAYWOYoVxn+9c+JyCnukbrwKTrgkrCWDlMcssvAXnEz9P0yfBrb
 1Uh2Dkf5G3yyjUBgyh4FWyb4QXFTdH23q8+p63lb7+GfggOjG473GZxT06XelJbOZmoJ
 Ua88rdhVv2fNBxm40dLnW1el6fu+yWsPtBFl3u6xcPdCVsl1waYEdoabMcRNfC/63wiv
 26Xlf/fnClKYFax4kwU9+axN2maLkbaI4VGSRoa5xWzF1gO9e8JdLASlC0Su1I7o7+xK
 GNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344753; x=1789949553;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iBqYeqzlYtNhEASxOYthivbrArLVaXRL5F5mIYJzUbE=;
 b=TEKDSUmyHBZE/ambbKUspUZqhgoLz/cvHTeBU2W/MYyrolanRJC56O0EnOMwGeak5K
 VgSoW53vJtxwrqK4xDHhyUvDsmH9vKPxQA3BzJRJsGFVbg9B4Cmd6wC8/an2H9aC1UmH
 5Zdi2AYMnjAOcHMe6Mg7fC6tyj2XF73xP7zasexPkZ7ION1dSqlwzeeuCkJYjCDHLM46
 z98DYA6yVdHjr2BrQWVZZIBsHKcvBu0huvAcDxlmxBivG94ONFYp7FPipVsPZi9LPOJ6
 0Q93Fn/M+vfm8tWJ6VYLdCWbfk7nnZnjUDH4jMkTUnyXBq/1U848x5C6bgB97qUy2NyY
 YAbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzm3VYZvLNTpTJVX9tJGoYd596a2nWYNGScjRzmAOTmaElzubaB7J6f6YBFCRw5tUZQsK0/TZKQ9c0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nRa4CzVyg1V57rhxp7xPTw+7uT4pQfKfmoE48Y4RC8YYhwSedi
 0/1pg9hKcVXGJKwqVZpDSe6dMywtsn0T7LrJhI6QDKjPN6knATe6CuAL02bxw/Ba/6DliMqqK3Y
 3K6z93TkvIgi9r2zDjdiKTJxN2APrOr1SPt3pTIKW5WTK4GP2s8TCYNrPZsdiIIOn/3ic0bg=
X-Gm-Gg: AYBFou1jAoMTdURwCxDP2F4hGf1vCqQtVhoXylXHnDblkX0LaBB2DJZLWzpeEAc2BIR
 Y3plJAmvAB9Inrbtq3LICsntlQ/tv5wZyoGNC2qcrZS3d3CrkzzswyXrVp9fvoYwAgr+KEMvb4N
 pW+nWGeFVP+oyFnHI+3vonq55dfwCJHrVSmWhS4ojJ/cGJb9HgseGqTa4kmJm9kynd3s1RIcg0G
 gNvLGyPQ2VIZ6WLDuGeattvEmXGZNdBj/yGCa4J78PbwLMnSM+vQHAMVvLbHt+FjqFa4qeHoMsc
 dRK53Xm38M9adpRb2wMaOOhdtZ5AeYBfX52wYcmVFsd2DYavwD0eLSgLP8/bHAFVC+bJLHefEF+
 abRjOtKpNybwxbIAdzhZMqnWJ3px2bMTVKz1w7RWnHlGCNwWRWocwZNexiOK+1KqefOPQH2yO0A
 k/2vIfhDWWOy4X
X-Received: by 2002:a05:6102:6886:b0:790:fd7:cf36 with SMTP id
 ada2fe7eead31-79b5b95efa9mr63914137.11.1789344753402; 
 Sun, 13 Sep 2026 17:12:33 -0700 (PDT)
X-Received: by 2002:a05:6102:6886:b0:790:fd7:cf36 with SMTP id
 ada2fe7eead31-79b5b95efa9mr63899137.11.1789344752966; 
 Sun, 13 Sep 2026 17:12:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a047d3cbsm1975589e87.81.2026.09.13.17.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:12:31 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:12:29 +0300
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
Subject: Re: [PATCH 15/17] phy: qcom: edp: Add Nord LDO, TX lane and TX
 resistor calibration callbacks
Message-ID: <ezvhdreygsfihvqsg66cp4s3jvkj5efhzpsoqmjedutn2giuad@fx734ykvkzwp>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-15-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-15-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-GUID: n3vhY4l_9quvYIRTgj7usKRXSmgpk39E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwMSBTYWx0ZWRfX68nBUbr1+MQz
 xqfdgim0wQCzJ7pO5ET9+MaQOie2LbdNAWO4wOUSyjKxWiMShr95Q8FahecRncXNn7v/viBh/+3
 MHXYRO5hfyoDnzyAXEXkSUpBVmz5t1bdvqW3Ezz8zO4D+5jVEYS9wTlTKGf/W6YqvxJyrrHTGYk
 Nb8sHkO3Uqfxs4MmNINEufxvqKQf+RgHhKRexSaNivELzf6R1zeGT3gkw/JejqmJGw1PTuwbME2
 /lYz/hlsSP6vNzu6kl03c7rN06Iq4EDXS0yeautoRJxhQlkXBG2QIR2JNNNBdkv63BLna+aV7bz
 hIZSN1e2kiQxNyp0UemnSLMhQGwdkEH7jZCK72JZBqEYoI75Ps4bPPk7hr2z0HCit3fKdA2KEhz
 0s4vHgLHYRwEukWl6mXwfBv6+c/SAdq5a++xHnmvAkcB4rSl8METKBDYGsjghf3n75iRc3uA0RO
 1Qn5lAoU8R4vRJZ2XLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwMSBTYWx0ZWRfX+IDjaWqd3pcq
 J+S0Ovy3Ulj+lbF2dGSk7kqTG5nOTm1+sa9oXUKfjtk/0EQc3aPoVcOQnb4HhpAA00nXD2D7AtY
 xb6TU7ZBqza2KlHukxbDTpa91KjT0bI=
X-Proofpoint-ORIG-GUID: n3vhY4l_9quvYIRTgj7usKRXSmgpk39E
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6aa73bf2 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=JfrnYn6hAAAA:8
 a=EUspDBNiAAAA:8 a=DE_EJvfAnEflg5IDAsIA:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140001
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

On Fri, Sep 11, 2026 at 09:06:46PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord requires different LDO levels, TX lane control offsets and TX
> resistor calibration codes compared to existing SoCs.  Add
> qcom_edp_ldo_config_nord(), qcom_edp_phy_tx_lane_cfg_nord() and
> qcom_edp_phy_tx_res_cfg_nord() with values per HPG Table 2-1-d.
> 
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 47 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index 4d1b2c81d956..361f4e467351 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1800,6 +1800,53 @@ static int qcom_edp_com_configure_pll_nord(const struct qcom_edp *edp)
>  }
>  
>  
> +/*
> + * nord LDO configuration.
> + * From HPG Table 2-1-d: LDO Configuration section.
> + * eDP mode: 0xD1 for rates <= 8.1 Gbps, 0x00 for UHBR (>8.1 Gbps).
> + * DP mode: always 0x00.
> + * Also programs EDP2_DP_PHY_LDO_CFG: 0x03 for eDP rates <= 8.1G, 0x00 otherwise.
> + */
> +static int qcom_edp_ldo_config_nord(const struct qcom_edp *edp)
> +{
> +	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
> +	u32 ldo_config;
> +	u32 phy_ldo_cfg;
> +
> +	ldo_config = 0xd0;
> +	phy_ldo_cfg = 0x03;

You don't need those variables.

> +
> +	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
> +	writel(dp_opts->lanes > 2 ? ldo_config : 0x00, edp->tx1 + TXn_LDO_CONFIG);
> +	writel(phy_ldo_cfg, edp->edp + DP_PHY_LDO_CFG);
> +
> +	return 0;
> +}
> +
> +static int qcom_edp_phy_tx_lane_cfg_nord(const struct qcom_edp *edp)
> +{
> +	writel(0x05, edp->edp + DP_PHY_TX2_TX3_LANE_CTL_NORD);
> +	writel(0x12, edp->edp + DP_PHY_TX_LN0_DRV_LVL_NORD);
> +	writel(0x12, edp->edp + DP_PHY_TX_LN1_DRV_LVL_NORD);
> +	writel(0x05, edp->tx0 + TXn_TX_BAND_NORD);
> +	writel(0x05, edp->tx1 + TXn_TX_BAND_NORD);
> +
> +	return 0;
> +}
> +
> +static int qcom_edp_phy_tx_res_cfg_nord(const struct qcom_edp *edp)
> +{
> +	writel(0x06, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX0);
> +	writel(0x06, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX1);
> +	writel(0x06, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX0);
> +	writel(0x06, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX1);
> +	writel(0x06, edp->tx0 + TXn_TX_EMP_POST1_LVL);
> +	writel(0x06, edp->tx1 + TXn_TX_EMP_POST1_LVL);
> +
> +	return 0;
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
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry
