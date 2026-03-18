Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC05310775EA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE4910E0FB;
	Wed, 18 Mar 2026 17:15:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YG2I1ajV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E0wce60J";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB9210E0FB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 17:15:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62IH17Ss3413951
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 17:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aHulX3nyPqMmPFo5kVxaIEHe
 3GwIwupRJyCV10Oa3Ks=; b=YG2I1ajVLLiWB9n0/gLbtrC3ddPRBfmrfzSrdpgK
 ZPc/P89NNX6DVvexswTql0Nnog3JhHg2WnAaWidQif5/0you2WhjF1NrvuoWEMc5
 ZOWJUSeFM+t1udYIN4MeYioZv8N47A2IkWYszHiFoudBBsEf8D0EZMM3nQbzJPYQ
 QpUWt00MGwNZa2yDSaQ0LszBOVl4Q6mC4HsaPRZHAse8xlSzvLqdl6aWRnb3T3+v
 qhekGaa7S1e91Fos1dTs/ECj7o0gaMlrtPNxL8kOcomlNF7FuMo1QIfVpBLZpSPg
 KGbjde6gltFYvnL1EmieG9r0V7sIx/w1tGpPKIVHgv/UAA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0032g2fg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 17:15:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5093b92f327so1694781cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773854133; x=1774458933;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aHulX3nyPqMmPFo5kVxaIEHe3GwIwupRJyCV10Oa3Ks=;
 b=E0wce60J/DV5Jf24pKtiAGQtW4QEmiQAzlR0Dg/BgGXzn5lP1J4W3lMJHfDx4vdgdd
 wOF/mkoE5MElSkElW4/bf7Om9IIcx2Ens4ArPOYoZnvSI576kWQqaLla4O/qjM6tKJ26
 MxRGwBAr8D/Iw0faSyvoywyrgk1LLtiVxyyMzi8MJ/6QqIe7ewFZSD31vHRLWyFD1Zlw
 qCYRqzlz7rB20a1aGsDKx1Uwbcb2yxj85F0laGvd3skR25cX0Y6ZfSCJSkFIGUS4c8fI
 xZLdq82CLJsGyW7iPv4STbhOosJ0RdEYD8/boFUN8rwzA50dKvd82/TlYvrgeVjR6Bvk
 Vmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773854133; x=1774458933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aHulX3nyPqMmPFo5kVxaIEHe3GwIwupRJyCV10Oa3Ks=;
 b=MrSxUKBo8EBmPyco568E0pne/2KW9b/nm6269EUUAWWmFUSNrjq/E/MqQGmeNl7bbG
 H6zKnflqFCl5HHmn1TSfvtHLR45RarlVV4XkrYZzhFC/heyVOxTaTATTaQUrVggMaJY4
 fIwiRMnCQylLg2ClBeNNn97n9RREoKdy25Q32WKqzvifnMloUUTA53SkY4khQ9Ldv4sA
 +dssDwYJJsW7p9EWcXKgsnYlGYT9MD+gYjAntuHT0DogMhnphYFH9Mhsy1xEQP/oP/a5
 p2xbGLniSXChSLWvJM405RNWzA0FudGPBc3AwrhVnS6apCRsU9TxPaimDBnEiI2Mjlft
 AImg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyAQ1d3oQDqsdkUcilV/T5nS1gF+XtYrf2QtP+uNKBXfi1DsozbLhEHeRCaukpvs3utbF6O+UdmCE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjwKhdaOAYF1MwRspKXAbfiDp7ZZHQNgrc8hECfCmqsZOkbMtZ
 FRKX347NQxtmKmg3SHDt0Y5az1s0LQWb/A0C/qvExL01jsBv/0VpAXPkhXPsHZLwAObtc3fZv7A
 p6qMnLtVq2NzrS9cuD8D/L7NUU2C5cV4yB/SZDXTgTTpOMt1qUM9ZtMsndpN/W8DlIGPpu28=
X-Gm-Gg: ATEYQzyqoOYgofUtshKMTOfj/ri77gJ01kYfVsRGHhbwDxH6imwHnSonp1LzO4iEC9J
 XpbiI3PVVb2tU/6N8pJqHkUGzgBtX3vddXYJdnJAFwB++5e4I8jEbHMuCeOJF7lncmE15Owg3Zp
 2WsY79fhfNJw0RRSTNqGiCfdH2NkbBzrkmqyvN14aZzwTG8qAzSUOLceXIRiQwBWE6npgV6IcDt
 OZseHZaJpzVJmvHCu1mfgmBl/XjEc+xiJ32QoyErcLiX32Pv6mUh1+pJvpzp8qTdOvOw/B55N6O
 8gv88fYGMH2RvA1PizO65JJlDtUynNDlQcLIIDep9HYKTgEDAnw36b5zhj2JUIB82/FArcV34eI
 i2su+1tBo1oCXcvR+PjCYAdUKuhC+SLQwm8K3fbS8AjFHDypF7ZIlUPRRpG1/b/tXQNM9j7IIF5
 aIEJeJg7hjNZW84TWOrK12CrDLejaHXtzDkkc=
X-Received: by 2002:a05:622a:15ca:b0:509:1cf9:ea09 with SMTP id
 d75a77b69052e-50b14900351mr54257891cf.67.1773854132521; 
 Wed, 18 Mar 2026 10:15:32 -0700 (PDT)
X-Received: by 2002:a05:622a:15ca:b0:509:1cf9:ea09 with SMTP id
 d75a77b69052e-50b14900351mr54256641cf.67.1773854131670; 
 Wed, 18 Mar 2026 10:15:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a279c6e28bsm677462e87.52.2026.03.18.10.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:15:30 -0700 (PDT)
Date: Wed, 18 Mar 2026 19:15:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v5 4/4] phy: qualcomm: add MSM8974 HDMI PHY support
Message-ID: <dpzq6o4qdttbmgtpgit2atjghu2kwrcj36ko3rnvwaehbkvjrk@lr4ms7mi6aiz>
References: <20260314-fd-hdmi-phy-v5-0-58122ae96d3b@oss.qualcomm.com>
 <20260314-fd-hdmi-phy-v5-4-58122ae96d3b@oss.qualcomm.com>
 <5a464fca-7be5-44a6-b124-7b80ea859a9e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a464fca-7be5-44a6-b124-7b80ea859a9e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: dpF4dQntUFS2BK5wKbpNHbdGOSBqLklV
X-Proofpoint-GUID: dpF4dQntUFS2BK5wKbpNHbdGOSBqLklV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE0NyBTYWx0ZWRfX4+obuTxnmcSK
 Ds+KGU+tVIsSKbCHSYHI336JcAQvakocsEbVULQdfa6AELfi2Eu0hy8DkcrXaBMrmuZm5OWLIB6
 oYPm1SJd3bP5Wj31AOFloZtLLXO/IWRZHJDmccp1MVNB7sdxc11EO7dsbTQAKz54jTerj2ZStYG
 DelLY05LhH3jM4RghJgs00QFLAYbpBemePD6V72kY9tZzud6wZ5fljHyCq3MPXXOGyAwuxu/fZI
 hj5mimxjvSn2kyipIUeFefshxMGiNb1EdKsGYt/qDXNovjnFy3osyFO7aQYyJeysm+P7o3DFR8I
 OlcicrXem0TwxtxEgb0uVHyEv9r3VdFGabYE523YFhvboyVMoQWtwNoC9MOPnT/QL+msRwl2L6H
 vrHfr0c7F/cmsK/LvGqorXAshhy+wJPNfZ6ZObJNDG+kZH8E5PPgwbNRvdlKX6bLO2Xj8m5to8d
 TWVmg9FNYUdDUNnoT4g==
X-Authority-Analysis: v=2.4 cv=WO9yn3sR c=1 sm=1 tr=0 ts=69baddb5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=5ezwpRT3i1EXliiOuAgA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180147
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

On Wed, Mar 18, 2026 at 10:22:08AM +0100, Konrad Dybcio wrote:
> On 3/14/26 6:06 AM, Dmitry Baryshkov wrote:
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > Add support for HDMI PHY on Qualcomm MSM8974 / APQ8074 platforms.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > +	sdm_freq_seed = mult_frac(remain, 0x10000, int_ref_freq);
> > +
> > +	val = (ref_freq_mult_2 ? BIT(0) : 0) |
> > +		((refclk_div - 1) << 2);
> > +	writel(val, base + UNIPHY_PLL_REFCLK_CFG);
> > +
> > +	writel(sdm_mode ? 0 : 0x40 + dc_offset, base + UNIPHY_PLL_SDM_CFG0);
> > +
> > +	writel(dither ? 0x40 + dc_offset : 0, base + UNIPHY_PLL_SDM_CFG1);
> > +
> > +	writel(sdm_freq_seed & 0xff, base + UNIPHY_PLL_SDM_CFG2);
> 
> Some beautification (BIT(), FIELD_..(), defined magic values) would be
> really nice to see.. although I'm not sure how much you can do with the
> PLL registers..

I can try doing a bit of it, but not that much. The HDMI PHY is mostly
unspecified for that platform. The code here is mostly based on the
study of the existing values in downstream and corresponding DSI PHY
(which uses the same UNIPHY core).

> 
> [...]
> 
> > +	ref_freq = ref_freq * 5 / 1000;
> 
> mult_frac()

ack

> 
> [...]
> 
> > +	rate = (dc_offset + 1) * parent_rate;
> > +	rate += mult_frac(fraq_n, parent_rate, 0x10000);
> > +
> > +	rate *= (refclk_cfg >> 2) * 0x3 + 1;
> 
> Really strange calculation, but in the end this is (n * 0.75)+1 -
> mult_frac()?

It might be based on some other dividers which I didn't recognize.
Anyway, yes, mult_frac() would work.

> 
> > +
> > +	return rate;
> > +}
> > +
> > +static const unsigned int qcom_hdmi_8974_divs[] = {1, 2, 4, 6};
> > +
> > +static unsigned long qcom_hdmi_8974_pll_recalc_rate(struct clk_hw *hw,
> > +						    unsigned long parent_rate)
> > +{
> > +	struct qcom_hdmi_preqmp_phy *hdmi_phy = hw_clk_to_phy(hw);
> > +	u32 div_idx = hdmi_pll_read(hdmi_phy, UNIPHY_PLL_POSTDIV1_CFG);
> > +	unsigned long rate = qcom_uniphy_recalc(hdmi_phy->pll_reg, parent_rate);
> > +
> > +	return  rate / HDMI_8974_COMMON_DIV / qcom_hdmi_8974_divs[div_idx & 0x3];
> 
> nit: double space
> 
> 
> > +}
> > +
> > +static int qcom_hdmi_8974_pll_determine_rate(struct clk_hw *hw,
> > +					     struct clk_rate_request *req)
> > +{
> > +	req->rate = clamp(req->rate,
> > +			  HDMI_8974_VCO_MIN_FREQ / HDMI_8974_COMMON_DIV / 6,
> > +			  HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV / 1);
> 
> I don't know if it's a good direction, but maybe:
> 
> const unsigned long max_rate = HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV;
> 
> clamp(req->rate, max_rate / 6, max_rate)

Note, it is clamp (min_rate / 6, max_rate)

> 
> ?
> 
> [...]
> 
> > +static int qcom_hdmi_msm8974_phy_find_div(unsigned long long pixclk)
> > +{
> > +	int i;
> > +	unsigned long long min_freq = HDMI_8974_VCO_MIN_FREQ / HDMI_8974_COMMON_DIV;
> 
> reverse-Christmas-tree?
> 
> > +
> > +	if (pixclk > HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV)
> > +		return -E2BIG;
> 
> include/uapi/asm-generic/errno-base.h
> 11:#define      E2BIG            7      /* Argument list too long */
> 
> -EINVAL?

Ok

> 
> Konrad

-- 
With best wishes
Dmitry
