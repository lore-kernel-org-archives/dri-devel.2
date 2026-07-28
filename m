Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D833EC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E994710E345;
	Tue, 28 Jul 2026 13:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VgCnZ1UF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JySPEQi5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34DC10E56F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:55:52 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SDPOJk2898759
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mtoagmi6BdOTkZj+CalCqX6q
 gly/BGfEFFLqULCMY94=; b=VgCnZ1UFOd+Vpln+BIZJre9jovBCUuvDZFHkoO7A
 Yn2Bw9kmZORHexbZqmTG0V/1plV3SDSrhJt7OFst9KwPT3nX0Fk3y9KZWMzvgOqZ
 bBf3X11z7dJyXJitenqGFM1C+3EKMHZefRye1Dd4+ESacetLc5869eT55E3Zhxce
 sSxzsIfeBVyymeSkP8EZLnZd1sVP59btLCMl36oRnx2Rux4LF+RQ5vaBstl4mXAJ
 ro1g7Qo+TG1FDpBuwgX4fenjbMErAk9fgvkfhbIbLI5WPpJiRye8lehvSNKz/zxW
 96eo647D//xns44mj00ZiTtXWIEV/alZlyfSrhnBslByGQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19jbd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:55:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c26012cd0so38371741cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785246951; x=1785851751;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mtoagmi6BdOTkZj+CalCqX6qgly/BGfEFFLqULCMY94=;
 b=JySPEQi5WOYZbFvDVYjObUuQTOQ1YUKCOWQYRV1eKmQ+emNX9cN/LI5Foubpia8jd1
 NUCxKueSZUq5Bs3gdJ7XtbUf7pIXylc3chpCstHSe8EjQK92OukaMP6KSz5tWNgtSRO1
 q8tGmwMnKS7qrlCHlXgWJECeulERtGw4gvdrAF4Hgz6+Q3rLXk20LYMTiWMnxbrppXAM
 9W9bpVoWm0aYAfdr4vrA9C1ztLpQn5wJNfSyXU4IjF5EAc+tWRBCpcNGKCQSydcvKQKZ
 +YoPXik4i6lFlB/hSPPAMg3Yyby/dPL0GVztDpxsYXtXXSHzmIDPYwaNk7rfx6zOElSR
 FUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785246951; x=1785851751;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mtoagmi6BdOTkZj+CalCqX6qgly/BGfEFFLqULCMY94=;
 b=W13ccxYErvHBFZh1IOFmOCQiHAybPnWXmNvmrH2mO5ztXAtjTy74BWJAIKBmfJxzPW
 X/c45tj+g87vL8cfplHNrEvgVSKHVy0wsOxGiEUaydtLpOqsbb5mRtdSK7rF2ckeOPjo
 U1hZa3sa6bB45/xB/2qYfL9JvRU1gSyztVZ7QXBCz0aQvT+K54hkWzdUcBdEuWsbFVNU
 JYNH4xi8B0lGAWEqbqXiC95yfrAnOsF6YXYAhGHwTYUwC2b6aA+1/URU8NX/51ytefJ0
 M1qtRztvIGK+70Gbe4FGds9+3EGOEF/Ui+EBvSjeIOs1iNmijoisqA6XIg3Vij6Z7kHc
 fZdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roqsg7EAjB8uw680zcalcSEqdYAx0mrzAhjom4RIqh+/X+1WplMRPEYVR/KcGSP2BIkrprlbdoot9w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQukoAAt9IZZpjyNoI67I9yF5kqusqMoGQqG9xlOag6nFRkjUJ
 ifCDsKy8jiHMyy/0sqknkW8XBl8eEeluxF7w6NlUPVkQ8QnPnvygd1ZFx7qz62VaRvsGEBiG6r/
 KjQRop+lp9hFes0mP8JCSgsB6cnLxrqAdoL6WUA99LXveTMfdTkFNIXBhuWQTP3PcRC7Xptk=
X-Gm-Gg: AR+sD100nKzFJQamhTYkTJCS4AOy2KAJNUPvRhz+QdBHxiJEQ7mMM9AFwDNvnOinRk4
 DyT5OuiI093SWEi6zp6B57SxGY8LxHRjhZkoTv0KtbwZBli9uGSkR5LaTLP5GtdxIRzPzACR7mi
 xRbjyqn1cS8SctieHQgkPWXfBswqWlKyRRCsOXlCl5SeP40VtVgNm4VhD9O7C32XTggGJ6nN6pd
 qjkZHh08t4Mo7l49oR9CC+t0rRvuoYGcAEWxf9kaUfd3BzVM7CEIGA/DwBwyzcFlk25TNFeBpuU
 jm/kVtfhlXGPMpdCbGkXR0dstIfGy5eqK7VOzoMvmn4BKMBMZS8wvrLBQMGeUMpwbqmVyTDRuPT
 fmXzTFhqP72zwTAszFFgn94+HyGaMKIBM//Vkgs0jFngm9IOQO6M9qkrr5fVYSToYPhvv0ig7fe
 Vzoooo61RdmbSuLg==
X-Received: by 2002:a05:622a:1a99:b0:51c:1408:6c12 with SMTP id
 d75a77b69052e-529d70d6b93mr20832521cf.47.1785246950646; 
 Tue, 28 Jul 2026 06:55:50 -0700 (PDT)
X-Received: by 2002:a05:622a:1a99:b0:51c:1408:6c12 with SMTP id
 d75a77b69052e-529d70d6b93mr20831901cf.47.1785246950086; 
 Tue, 28 Jul 2026 06:55:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2be1d8646sm2123808e87.49.2026.07.28.06.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:55:48 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:55:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 Sravanthi Kollukuduru <skolluku@codeaurora.org>,
 Rajesh Yadav <ryadav@codeaurora.org>,
 Chandan Uddaraju <chandanu@codeaurora.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Vara Reddy <quic_varar@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
 Guenter Roeck <groeck@chromium.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tanmay Shah <tanmay@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] drm/msm/dsi: Drop dev_pm_opp_set_rate(0)
Message-ID: <fd6hciya5s7maf5f4s2kewtnnqb25wpacmlswwbo2t4tpp54sz@vo47q2b4fuwn>
References: <20260728-topic-dpu_power-v1-0-e7783b859a70@oss.qualcomm.com>
 <20260728-topic-dpu_power-v1-3-e7783b859a70@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-topic-dpu_power-v1-3-e7783b859a70@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a68b4e7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ze_z4zfmBB5lhDDjiZgA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEyMyBTYWx0ZWRfXwX5jwhOkOXv8
 td2z2lNYeNy8KscVBMDbdu1FJEEvF3CqkEMx2nq2MqcIf0e8E2wx8kLp3oPprRskD3eQLaoby0r
 O+0Kdd7eYSheivkZPBnVFycX0xkJbcOSKOLZB4hIxsvaj5JAYaDMNoKLhNoyw3RoS0aTj785b9f
 LO4YKCfQ2GOGqutG141uAS6442SV/kEnMpqzyz8msILO27z4nBdi5Qv3Mf8a67MVsIJRtYDKeJo
 f2GcWvs3bAGEk4BhQgDyFEo/dcK8qZOehpP4YGj5ocH4NMnqr4xK6fN3iu0So+AwgPid5KYp3p0
 zeGXLs0DvFCceIuAyR2QhmoJlTNrmwb9iPpzuYCTTqJ8inTjHAPjpSE8qvbqXMkdy87IAvQJKG7
 GIrOmgEX2XEg1t3nou+/LMjAm2WWTxuLRwJ7a33e451TLMM6fUUOBkNddCkBKC++XJgwl1EqzPL
 arLyxYR6Di/V8dAuSng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEyMyBTYWx0ZWRfXye0UFe0Nq3S1
 vbg52pYEYWjRMbdZ6OYR3tJg/Ga2U5O1nqOvmoIyB5I7T9cKcqCV29Z0IzVwgIvHl8yG9Fr0v5B
 MK5GpnaawJmOJ+KZPLSIdAv9YPGe2cU=
X-Proofpoint-GUID: h6VlD2r65LfLZSjpahYO26PNnJYxW9FO
X-Proofpoint-ORIG-GUID: h6VlD2r65LfLZSjpahYO26PNnJYxW9FO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280123
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

On Tue, Jul 28, 2026 at 03:20:47PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> dev_pm_opp_set_rate(0) removes the vote specified in required-opps but
> does not actually park the clock, making it run without the necessary
> power backing. Drop the explicit call to it.
> 
> Every call site of ops->link_clk_disable() is followed by
> pm_runtime_put(), so the power vote will be rescinded if deemed safe.
> 
> Fixes: 32d3e0feccfe ("drm/msm: dsi: Use OPP API to set clk/perf state")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
