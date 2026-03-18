Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6661B10854D9
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB91A10E773;
	Wed, 18 Mar 2026 09:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gl3b/WZr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WIame4kZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0582C10E732
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:22:13 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I8lv113281113
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 15hK/7+IQg9d3rM1JPvTgxhytjFXh5CP/ZU9fW/iQ+g=; b=gl3b/WZrIIqNNONS
 i8sSEFpcBVkDOy6SpPfcvTrdYt+gINMsSAz+05T9sr4ykrE97g7DbiybuZ0n+OVq
 jQJArG66+IMrokCHORBhHx3adjgHMXVa/HcT1bACgr9KLyfAXOa/p42BZXa+FEtv
 zIcy9MYF7gZ2nhLkryC3Tc/9PLcZvCSR13X9UpTOemKezVzEfrvOiEs1RV+tLcST
 mn1OAQaDjTZz4U+KSBOKQNiwPteWCtgcwjt0whU/LFMCFZ4pBOxqrDZkUI61kQRU
 08uBskVmhQ2f0deKWXyXeAdacJqVjCH1Vw/eJcxAl+PO+zZUeONOuiEWP9YAeX+y
 Jj8ZxQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cya62uru5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:22:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50910ca6ccaso86740941cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773825732; x=1774430532;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=15hK/7+IQg9d3rM1JPvTgxhytjFXh5CP/ZU9fW/iQ+g=;
 b=WIame4kZcJtUzqAcixg8XbkvevBycO1ullMeg3uyAq877Hp1jvc9x9bTNbAhiGOu1s
 XFYn/Ua0+Tq/6E/qZKXAs4xUArBbmCA+IQratnA5yDTNKxZQkj1pUupsk819NVfYrm4N
 cVArZq5HlJzqnhkM35k5K2+J5LQ7Vxv2zlJpXa4iOcsWS6PrzYHDp/zDfrqy6/K14fk6
 5WSgiLsAk2mx5PATsvwcAvLmHBZ+1A83TkNsbJATZYvZVP6R890fr9MrEUB49nzQxMo0
 Rei/n2CHL8ntaco/ve3YxMKY+If419Ax1O4SFglK6UE/myaEiX4VT17MD3dBNaIwhyzG
 j1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773825732; x=1774430532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=15hK/7+IQg9d3rM1JPvTgxhytjFXh5CP/ZU9fW/iQ+g=;
 b=jxllEelmBiP8M0fvmtFtLo9RMRrO6T9NdFUCoHEJtsCnlgu7EgWT1+Dfj9cZ1LSvZF
 zf9FnGTbGVB3LUy2Tx3QzNyKLnfxPHe2ukUQq5qvfQZpXpRFLoi0+aDI/63ZPfmhq02Q
 57BZLE8dZBqKTUSAqXAOI13kmOzGS3NDqEimjaKiXFhmdh0hxN0QHRZ+jvKKjHvAGx1m
 qBuSSqzjTPn7cVRCj76xw3BU3qP+7Evy/9/PoANeRdHS2q0DH0Yi72YyynLG+79QK0Ny
 ktxXWu5eszxFtpvRKjEOnaach6FS+JikUoJ1PNnOrxW8DZVD11xY9NULEB0VHmal89AL
 Eg/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ5SqST276G5Px1gHOQ+eNHSOpiaTGcJkEkhD58Y+Qw8osX5sI5Po/xPtK8+Nmk3m5YbfnFVp3e6I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwaNPnE3eErwzuN84zAlw4PUcDzc+pf5Yyc6HRol/l2Ev3j/wt
 hz504LdIOpDm6corqzgM2wqd0SY8JRmuV6edYYmKMvuGlSvt9UIVD9+iAp5uIkyGhE+1sEom3iY
 5oUkvIzylrk8DSQPAcwr4jhrzyVykhaK+9b/w7m1E/i1rTdQf+SRCE2FUF2iNpVmwLuA44xE=
X-Gm-Gg: ATEYQzwXnrxtzazNAMlPW989RxUHl4HC9gBFqqqdY6OIWqK3m+XWrVzZy8nfj0nltT6
 H90zpQ2E0ysKlK15C+nB1FABCzRKXpQtJERFWBQ5rx0qtoPizUPyqlleNrukmjfZeiYLTeQACm1
 atK+9nHxH1n/izy0cbLOAzwOLnon/Cog/8MyUmfZt9nvlKwvE4lawucOWmoM7CFTyOI6B6tPh4x
 sljg75F+uGGVPkAFztCy6pXv7uX0RqBE5mMh7pq4B7TE2uEzAsqdRXC5aAUwjWgqdlWytj2MzrQ
 PqX0YfKAQWiJINkNc9yd7g1eJPM1Oi662dBjWEuUpCT6Ea/c8napjPMJkYGjlr90TtXyMnZOoOm
 fimubovzlr+Mrt9Y3qsTSW7CXMGEBURnh0Vx5kQDG4U4D2y4rqBMMkMlTSZLOqb3lkjTd515JGl
 4lxGE=
X-Received: by 2002:ac8:7d4c:0:b0:509:24e8:ec48 with SMTP id
 d75a77b69052e-50b148afafcmr21250341cf.6.1773825732306; 
 Wed, 18 Mar 2026 02:22:12 -0700 (PDT)
X-Received: by 2002:ac8:7d4c:0:b0:509:24e8:ec48 with SMTP id
 d75a77b69052e-50b148afafcmr21250121cf.6.1773825731860; 
 Wed, 18 Mar 2026 02:22:11 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f1689d2dsm161386366b.35.2026.03.18.02.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 02:22:11 -0700 (PDT)
Message-ID: <5a464fca-7be5-44a6-b124-7b80ea859a9e@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 10:22:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] phy: qualcomm: add MSM8974 HDMI PHY support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20260314-fd-hdmi-phy-v5-0-58122ae96d3b@oss.qualcomm.com>
 <20260314-fd-hdmi-phy-v5-4-58122ae96d3b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-fd-hdmi-phy-v5-4-58122ae96d3b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ns3cssdJ c=1 sm=1 tr=0 ts=69ba6ec4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Z2itlUKkCiT7gnwI7HQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1hhJtw1ybii8S_iol2WIdj-KcJC5x7q0
X-Proofpoint-GUID: 1hhJtw1ybii8S_iol2WIdj-KcJC5x7q0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA3OSBTYWx0ZWRfXyd8sh6lB3cTK
 xN3Bc3cyuCEntYy1FLFYFYg15ypzkMsLtHe+KNS9ShdzwQhcnShTDbKeF2u+F4KOHGIlqfXfTcB
 kXbh4chUTTs5ykmiRy8uFYBMz884X1ZcXYGxE9AjhMQl349J4R07H2IUCAbhJXsKozchVfEQPVU
 lmvqMiqIxgthJS313uzvJW+wUWa+J062eNuctDL9Etk9GxJjxF74Q6HfuJQeC/yhZTdGsuaIuMp
 63kHrfQ9sPbcNkb5643vDS+prXLMrGEQTFfMR/JxpvREZgVZbjW6P5bUptgHV3PkG3J1vfBsyg6
 X2MCurGtCQAW0QtYVmcNivhOcaUPDocEsEQoCdaP3olGlTetLR6fVNOW0v+J7HsGCAWo2TiUqY9
 0COiXomRjDCX4JjQptY6lUPxZblRe3pJp/bpJthk81PFir2U+Bvf9OyO7A7Fj3sbAy/XLytm53B
 14NHOYdJJSggOy6FXrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180079
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

On 3/14/26 6:06 AM, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Add support for HDMI PHY on Qualcomm MSM8974 / APQ8074 platforms.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> +	sdm_freq_seed = mult_frac(remain, 0x10000, int_ref_freq);
> +
> +	val = (ref_freq_mult_2 ? BIT(0) : 0) |
> +		((refclk_div - 1) << 2);
> +	writel(val, base + UNIPHY_PLL_REFCLK_CFG);
> +
> +	writel(sdm_mode ? 0 : 0x40 + dc_offset, base + UNIPHY_PLL_SDM_CFG0);
> +
> +	writel(dither ? 0x40 + dc_offset : 0, base + UNIPHY_PLL_SDM_CFG1);
> +
> +	writel(sdm_freq_seed & 0xff, base + UNIPHY_PLL_SDM_CFG2);

Some beautification (BIT(), FIELD_..(), defined magic values) would be
really nice to see.. although I'm not sure how much you can do with the
PLL registers..

[...]

> +	ref_freq = ref_freq * 5 / 1000;

mult_frac()

[...]

> +	rate = (dc_offset + 1) * parent_rate;
> +	rate += mult_frac(fraq_n, parent_rate, 0x10000);
> +
> +	rate *= (refclk_cfg >> 2) * 0x3 + 1;

Really strange calculation, but in the end this is (n * 0.75)+1 -
mult_frac()?

> +
> +	return rate;
> +}
> +
> +static const unsigned int qcom_hdmi_8974_divs[] = {1, 2, 4, 6};
> +
> +static unsigned long qcom_hdmi_8974_pll_recalc_rate(struct clk_hw *hw,
> +						    unsigned long parent_rate)
> +{
> +	struct qcom_hdmi_preqmp_phy *hdmi_phy = hw_clk_to_phy(hw);
> +	u32 div_idx = hdmi_pll_read(hdmi_phy, UNIPHY_PLL_POSTDIV1_CFG);
> +	unsigned long rate = qcom_uniphy_recalc(hdmi_phy->pll_reg, parent_rate);
> +
> +	return  rate / HDMI_8974_COMMON_DIV / qcom_hdmi_8974_divs[div_idx & 0x3];

nit: double space


> +}
> +
> +static int qcom_hdmi_8974_pll_determine_rate(struct clk_hw *hw,
> +					     struct clk_rate_request *req)
> +{
> +	req->rate = clamp(req->rate,
> +			  HDMI_8974_VCO_MIN_FREQ / HDMI_8974_COMMON_DIV / 6,
> +			  HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV / 1);

I don't know if it's a good direction, but maybe:

const unsigned long max_rate = HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV;

clamp(req->rate, max_rate / 6, max_rate)

?

[...]

> +static int qcom_hdmi_msm8974_phy_find_div(unsigned long long pixclk)
> +{
> +	int i;
> +	unsigned long long min_freq = HDMI_8974_VCO_MIN_FREQ / HDMI_8974_COMMON_DIV;

reverse-Christmas-tree?

> +
> +	if (pixclk > HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV)
> +		return -E2BIG;

include/uapi/asm-generic/errno-base.h
11:#define      E2BIG            7      /* Argument list too long */

-EINVAL?

Konrad
