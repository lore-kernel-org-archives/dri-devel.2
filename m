Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF772C88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F37A10EA89;
	Mon, 14 Sep 2026 00:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="epHc4tgs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TdxrikXI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639DB10EA87
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:12:06 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E063D44020763
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=e8pSLRGNT3rSCZcyNbWseqo/
 tYmMZllBzMLqwr0LFTg=; b=epHc4tgsZj5yGCT4hjzftMjZh0Jl+bg1warXRRhn
 6M3YznL2a/eTFZN9w5gnyszvVXCAcnZIKpe6He0Ua5fIQ1aHjwv3G1UP8BIposuc
 bZh50lMr2ntc0QLLoXuNPEewAPBbHhXPC2CvK22qeHF+zhDpGsXOWAxw9T1r/cLs
 S2tfuPpJ17jCV7IMJXXk06itpT5nhqE2jfkUsw96Y5DghRrie5B/+ehtXEs8yX4z
 9aqLsMguKT1MmWM9OO2FikDp3hGdcE9YxjZv7H0c5uGsdKR4n/lPfBLQokTUzcOd
 7h8/xjhrPZdHu5LdPYJlcmtohFaJQm5KflRQz3yEPxehow==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k0885q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:12:05 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-980a896f53eso2259553241.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789344724; x=1789949524;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e8pSLRGNT3rSCZcyNbWseqo/tYmMZllBzMLqwr0LFTg=;
 b=TdxrikXILdGixClC+GjlsVzWXe68ALWe+jASF6GNKWMthfPVCBT7e7ufhhSCH43Df7
 Cjr6xEWa7jRfk4lpkV07DAs+p17nhQIM2LPBGCFQawllSc+3Ic2KmWpyTisFO+lu9GiC
 aNQH/hIioPnR2D1T9xKIeYZvAjg+Xc1v5Qo17yk28NiLVRkNm2sGu9WB3LqNdOpI/Q1o
 g1nHTd+6YGTaWQ7QxvPhPf+OD4+PmdLFcS9VHk76H2d2fTVSZ7BWMzQSDYJU+I5X82rO
 BV3KRb7E3X/q4Psuv6fddzN5mEi7V8qmacJRJ2fhckDrwfnuI5IqPgAnAkPONI7GTJ2e
 40VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344724; x=1789949524;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e8pSLRGNT3rSCZcyNbWseqo/tYmMZllBzMLqwr0LFTg=;
 b=VxEyCHLU3A3rUC7PKiJGgke5XlRH/W/HnQtItnTWdUpE3b8eiABzpfq89R2Z7eDfwr
 pU/1fGVebQjGn0twdAR75zWeaRs+8ZxWTjGM8Fr0G2iauhd4otjuK8SNyxQBe4fWRiEd
 pn/msyfOF2lopzzzMAk0DFklhdSshRC26eb4AjMxI0AFZcxpus4zSXLNFmfwGxgqo2NZ
 c57MA0uVg/n5BuytbavMXIoDdy8knAqzfZYyxX3wts8tDTWNLU6cgo+jgMPfm4SQWkSp
 MsRWYCpTFZY2CFtyHU2cEvNTUlLHDGPZJV8s4IBq4x4CO04zI4ok2ukwsXGJIodK+OSe
 JBFg==
X-Forwarded-Encrypted: i=1;
 AKwUvByJgZkUfsCHSwIHxbZopkIM4QgOobniu1qWg2/k6ReTtJC0GosQbReWf1dJQcP9J/ERWKWcI70uBAc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nDxMd/jimvom7hQMgR0FXsshHn3HGfWqQkpg8sA2E/Zu4LPCrC
 Anpjig1Wi8OIMwIoBU8SLBBkrffaY1oT3WcXs5mmyGB6BYGFyOob+J7yNDMz6LRgqpYYIxpPLLh
 n3zAlLVVF1KaOCgl9qTg/g/2XuCUe61WRjHujO/sQVrmcodk9shzlfaZMo48yzALudl0uzH0=
X-Gm-Gg: AYBFou2Q7vI9aMj8X6FUPs5KEUwehDrKpzxfBTAi0uGk/0Ir2l/lB4IDfo938kaewhm
 /kHWzOiTQcFxru9helI6iTRivdk3q0iZchR/NFHNhIc3+Qg4tpGxQh2V0IsovnOjTMrUB3lGlq7
 SJzdLL7ytwZlr4rDKjl5ToNfmPXP10dKUA1/IKOPTFn7TLdeHPdMA+8Nu52LLXqkw6PkEGBKUPV
 PSk2aMR12ewbhb6U5jgpRRKzRPBeuAKzMBuTqlLXPYr51dY98fpiRjwL3JwPRcYj0dlKuHU6qh+
 vt/jHoYmpx1hHTJFMYiDRjmnQlIflrNAbAp3+IIx8aPChEZUTdtcz0ER8GD3OlO5wXDXx3MTKvv
 ZJEQejYw3Trhq8exfDMpo3rJh/rcY/wmHb5BBnklKalX5HCe6dTM6b5I/txBwXCXIXpXiEZW943
 YfRtYSIUH9NhPW
X-Received: by 2002:a05:6102:4492:b0:779:c38e:de53 with SMTP id
 ada2fe7eead31-79b5b28fe7cmr67038137.10.1789344724391; 
 Sun, 13 Sep 2026 17:12:04 -0700 (PDT)
X-Received: by 2002:a05:6102:4492:b0:779:c38e:de53 with SMTP id
 ada2fe7eead31-79b5b28fe7cmr67008137.10.1789344723990; 
 Sun, 13 Sep 2026 17:12:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0456bbesm1989247e87.22.2026.09.13.17.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:12:02 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:12:00 +0300
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
Subject: Re: [PATCH 14/17] phy: qcom: edp: Add Nord PLL configuration callback
Message-ID: <nv5ij423d4rbwpnhexj6yv2qgasrb7k3wzoo7o6vx5kg3vc3n7@6u4rln5ltbsv>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-14-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-14-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwMSBTYWx0ZWRfX4jpI2tHm4t06
 0VRUHIJTfVmUq0WjQovPbBZqPf9jQOxPpZURf2f0O8comxTiNPNFCJME8SWDex9RiCO2+8Gi10E
 WEJIXo/CJCXrlvIfhEf4swZd0Tjt2+0=
X-Proofpoint-GUID: caoDrrawiZ2JKu_HOxK_LhIO_dNzRuEu
X-Proofpoint-ORIG-GUID: caoDrrawiZ2JKu_HOxK_LhIO_dNzRuEu
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa73bd5 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=G5yU_OXk3sxSGaYP5ugA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwMSBTYWx0ZWRfX/wolDR/elKIw
 YDNJBw/EEk1yyo06gqq1hYSSbFgYpLxWswydA8cp+YkQ4Og52+GLNqQa+FzmD2oir4rdQrNc/vQ
 ru0Ku5WJwQFbhmfy1QkWaBsaCGkutY5sHj4E83ccm/qwDNa7iMPVmgJ76whs6vc4gQ8Rky2X6UA
 trrRgp2FRAtiZNbQUPsSk6r+KhqWLNLKAr26ILHOM3PEbgDTyKF/pRhCkKGesjybV9difjpu0pc
 3X0e5xlWkGQUgPVQM22jrZt14trA5Vl7hMVLGqE3owJKUjfIPKCySyelYYv5U68gBlhKX6umLqV
 uLkhavQLarSAqZfYp7iZvnqkBNQ9+yRwRWGJJX1A3jOkfwr6cobPqcp8loimbIjdOfXHxR7Sfg1
 MGT7K7fO5+edTq92n1qDq34Y0BTs1useXDgDUr8VdvMh98W1mWD+EA40JnaGOVjI2NutUDf3tme
 msEd6aaW+SRNxfYjDMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
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

On Fri, Sep 11, 2026 at 09:06:45PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord uses a 38.4 MHz CXO reference with a different QSERDES v8 COM
> register layout and PLL coefficients.  Add
> qcom_edp_com_configure_pll_nord() which programs all QSERDES COM PLL
> registers with link-rate-dependent values for RBR, HBR, HBR2 and
> HBR3, per HPG Table 2-1-d.
> 
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 112 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index a0f4b12e561e..4d1b2c81d956 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1688,6 +1688,118 @@ static int qcom_edp_com_configure_ssc_nord(const struct qcom_edp *edp)
>  }
>  
>  
> +/*
> + * Nord PLL configuration per HPG Table 2-1-d, CXO = 38.4 MHz.
> + * Supported link rates: 1.62 Gbps (RBR), 2.7 Gbps (HBR),
> + * 5.4 Gbps (HBR2), 8.1 Gbps (HBR3).
> + */
> +static int qcom_edp_com_configure_pll_nord(const struct qcom_edp *edp)
> +{
> +	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
> +	u32 div_frac_start1_mode0;
> +	u32 div_frac_start2_mode0;
> +	u32 div_frac_start3_mode0;
> +	u32 dec_start_mode0;
> +	u32 lock_cmp1_mode0;
> +	u32 lock_cmp2_mode0;
> +	u32 lock_cmp_en;
> +	u32 hsclk_sel;
> +	u32 code1_mode0;
> +	u32 code2_mode0;
> +	u32 core_clk_div_mode0 = 0x14;
> +
> +	switch (dp_opts->link_rate) {
> +	case 1620:
> +		hsclk_sel		= 0x0c;
> +		dec_start_mode0		= 0x54;
> +		div_frac_start1_mode0	= 0x00;
> +		div_frac_start2_mode0	= 0x00;
> +		div_frac_start3_mode0	= 0x06;
> +		lock_cmp1_mode0		= 0x37;
> +		lock_cmp2_mode0		= 0x04;
> +		lock_cmp_en		= 0x04;
> +		code1_mode0		= 0x8d;
> +		code2_mode0		= 0x27;

No extra alignment, please.

> +		break;
> +
> +	case 2700:
> +		hsclk_sel		= 0x04;
> +		dec_start_mode0		= 0x46;
> +		div_frac_start1_mode0	= 0x00;
> +		div_frac_start2_mode0	= 0x00;
> +		div_frac_start3_mode0	= 0x05;
> +		lock_cmp1_mode0		= 0x07;
> +		lock_cmp2_mode0		= 0x07;
> +		lock_cmp_en		= 0x08;
> +		code1_mode0		= 0xf6;
> +		code2_mode0		= 0x20;
> +		break;
> +
> +	case 5400:
> +		hsclk_sel		= 0x01;
> +		dec_start_mode0		= 0x46;
> +		div_frac_start1_mode0	= 0x00;
> +		div_frac_start2_mode0	= 0x00;
> +		div_frac_start3_mode0	= 0x05;
> +		lock_cmp1_mode0		= 0x0f;
> +		lock_cmp2_mode0		= 0x0e;
> +		lock_cmp_en		= 0x08;
> +		code1_mode0		= 0xf6;
> +		code2_mode0		= 0x20;
> +		break;
> +
> +	case 8100:
> +		hsclk_sel		= 0x03;
> +		dec_start_mode0		= 0x4f;
> +		div_frac_start1_mode0	= 0x00;
> +		div_frac_start2_mode0	= 0xa0;
> +		div_frac_start3_mode0	= 0x01;
> +		lock_cmp1_mode0		= 0x17;
> +		lock_cmp2_mode0		= 0x15;
> +		lock_cmp_en		= 0x08;
> +		code1_mode0		= 0x14;
> +		code2_mode0		= 0x25;
> +		core_clk_div_mode0	= 0x0a;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	writel(0x01, edp->pll + DP_QSERDES_V8_COM_SVS_MODE_CLK_SEL_NORD);
> +	writel(0x0b, edp->pll + DP_QSERDES_V8_COM_SYSCLK_EN_SEL);
> +	writel(0x02, edp->pll + DP_QSERDES_V8_COM_SYS_CLK_CTRL);
> +	writel(0x0c, edp->pll + DP_QSERDES_V8_COM_CLK_ENABLE1);
> +	writel(0x06, edp->pll + DP_QSERDES_V8_COM_SYSCLK_BUF_ENABLE);
> +	writel(0x30, edp->pll + DP_QSERDES_V8_COM_CLK_SELECT);
> +	writel(hsclk_sel, edp->pll + DP_QSERDES_V8_COM_HSCLK_SEL_1);
> +	writel(0x07, edp->pll + DP_QSERDES_V8_COM_PLL_IVCO);
> +	writel(lock_cmp_en, edp->pll + DP_QSERDES_V8_COM_LOCK_CMP_EN);
> +	writel(0x36, edp->pll + DP_QSERDES_V8_COM_PLL_CCTRL_MODE0);
> +	writel(0x16, edp->pll + DP_QSERDES_V8_COM_PLL_RCTRL_MODE0);
> +	writel(0x06, edp->pll + DP_QSERDES_V8_COM_CP_CTRL_MODE0);
> +	writel(dec_start_mode0, edp->pll + DP_QSERDES_V8_COM_DEC_START_MODE0);
> +	writel(div_frac_start1_mode0, edp->pll + DP_QSERDES_V8_COM_DIV_FRAC_START1_MODE0);

Always 0x00

> +	writel(div_frac_start2_mode0, edp->pll + DP_QSERDES_V8_COM_DIV_FRAC_START2_MODE0);
> +	writel(div_frac_start3_mode0, edp->pll + DP_QSERDES_V8_COM_DIV_FRAC_START3_MODE0);
> +	writel(0x12, edp->pll + DP_QSERDES_V8_COM_CMN_CONFIG_1);
> +	writel(0x3f, edp->pll + DP_QSERDES_V8_COM_INTEGLOOP_GAIN0_MODE0);
> +	writel(0x00, edp->pll + DP_QSERDES_V8_COM_INTEGLOOP_GAIN1_MODE0);
> +	writel(0x00, edp->pll + DP_QSERDES_V8_COM_VCO_TUNE_MAP);
> +	writel(lock_cmp1_mode0, edp->pll + DP_QSERDES_V8_COM_LOCK_CMP1_MODE0);
> +	writel(lock_cmp2_mode0, edp->pll + DP_QSERDES_V8_COM_LOCK_CMP2_MODE0);
> +	writel(0x0a, edp->pll + DP_QSERDES_V8_COM_BG_TIMER);
> +	writel(core_clk_div_mode0, edp->pll + DP_QSERDES_V8_COM_CORECLK_DIV_MODE0);
> +	writel(0x00, edp->pll + DP_QSERDES_V8_COM_VCO_TUNE_CTRL);
> +	writel(0x1d, edp->pll + DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN);

Not 0x1f?

> +	writel(0x0f, edp->pll + DP_QSERDES_V8_COM_CORE_CLK_EN);

No DP_QSERDES_V8_COM_VCO_TUNE1_MODE0 /
DP_QSERDES_V8_COM_VCO_TUNE2_MODE0?

> +	writel(code1_mode0, edp->pll + DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE0);
> +	writel(code2_mode0, edp->pll + DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE0);
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

-- 
With best wishes
Dmitry
