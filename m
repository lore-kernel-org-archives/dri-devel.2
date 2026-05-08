Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616C3CD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B286310F44F;
	Fri,  8 May 2026 11:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ihQ3tHab";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iSesG4+L";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF0510F44F
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:25:18 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6486GbZ71174218
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 11:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=anKM1JfvibSn5rk4PhrX9Oaj
 9NxgOSekZqCV80cWonA=; b=ihQ3tHabgvFAcviy+hT4fQbDWshYsKA2XeUpbz0y
 N74FrKbQVZcZasnni8sBpWL2lyytwPlgo/WkuL5C6JgKfRCSd6wTq0iJPQFq9iZk
 kkVh9307SfM7+oyjeMLH4TsqQ1Di20AGw8gsf30CS04gurj2DI51HO15XSGLRQGQ
 AaGSlRzbJvfcCl83PMj7EPRIslM6Mwbv6YZYtZI/hrgythiEiK6tp2TYFCwZ7L2p
 3jshbtXQ3UWQpiOy7eUb6+F79zImW5XRYOwfQd0rrQamKkvvn6EaJkqXunOB6NXv
 zV2sR21efkNzmVA3enF5HEQN9R6tyXDxJvt8IJozvH+f7A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e132hanb8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 11:25:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50da529ff48so41458331cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778239517; x=1778844317;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=anKM1JfvibSn5rk4PhrX9Oaj9NxgOSekZqCV80cWonA=;
 b=iSesG4+LjmKkmt6bWZrSWyZFG8e/qjBVWKDxct94iawKiVXICGTq2i8g4bWMx1if4B
 yPkOGveJpHsURIcHLCre2vyPr0yov55zi5YR/e7/niQ+iQ9i+1omFiwlNnjouvfKD6of
 6ca8ZU511DY4dwrXPYeEtP87EXsjZhxhLzV6nkT+abGfjPuL+nia4ztWvNXii8FkGrFO
 HAauFErNQu0C+oPFoYr8IbqGN0ZrkF3tAbtQX5aDbfAncsNiOLCAu9d0lpXEBS7CD5lS
 WKBetykT6EA6faZwDxgl+XJdmBYVMbrp+zS7R7yvzHetXi9hIiTpaUAj9n97+PF36n48
 QiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778239517; x=1778844317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anKM1JfvibSn5rk4PhrX9Oaj9NxgOSekZqCV80cWonA=;
 b=pKQ31Tjcg1UOj8Bt79RcEo87GnYUtbqCIkwydYmkK+W2yYWQNWmezP03Y8oYx+/oDs
 GlrqS+eCN+sH0hGXRK91hDT67tJNNzXkp0o0bQNjIQz5aFs8zOr757ySAByomvNTpd4l
 oyA0KjKFOAFAukEBdbr+GfhdtSAlgJphVy0DsQTdGhSWciiU6iFZAhy4gST1J63RAhJf
 7tZyrnsEqyVaKLxXrFj2bcmmBbI9/5GTiVFXGOSD6vKq9ym3qBLf4WEQnoGI6xkn16/h
 +rLOxJ/Di4YqXLbfwt120sbT82jN9e+GzG9nyLjxGK2BbzVskjnkdNpuF8+rrV5l6SYV
 D1mw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wqvU5rdNScHTsgbV6ulIcT+8JVlhImdFQx4ypIfotf5fS7+O2gR/kwSJBg+RntK4eeK9IKkx75mw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzURpP4eaAEvJirkVwLjWi0pRJSyseps+H2Z1pmv51n8a3zqi3A
 Zch3sgXVla9LI0uDJOSYh17trHFDU7uEwu1gbHCqiqDgDQldjfuLuPCssZTHbyG7JkQybqnHhQL
 YdSH7bXUDmGm8B+DB8nRp0XuEyLgyAWNhiiFKGII2S5gwnJ+XdquAArziHppvtvegkozlZaI=
X-Gm-Gg: AeBDievWycxwgD7PyF6kCXpHlx5aF/dZ66O16+2jjodTNztgioldP0i40fdBouGFuEZ
 uEOsJr82GznDFqD6Wyc6z8EJLgej8N0AYwSNvwCl409xLVldZCy2IMO908ZLC4al69Mhnas2iq3
 Wcd8RwIHQ0DFQ7P8J4JEB03uosgpPXqxR/G4ueP07U0Mwzonbq0gXH9uMk32MnYncwPGetT2sqq
 EU2NMdajwh9t0TIAXdpicKuMnPYb5FcNczF1sJVt4EVbntHlA0RZzbQnlQowxqOgTJ9xSd3JIKU
 9rR+54krY4EvsmT7QNMhAaSBlYC1ah9F3psOX6igy6hLFP0aFi3VPCVX7crhlVI8B4//BH+dOZC
 LaJZihWDZiQjjpg2IAu+fLAo8ATuFr+6ITCj+WvnRoVY+etyVIMojDJPnit/J46pCJsG3/2po39
 cxCm5nah91cu4FcKDT4PYNAkb4F5aHncq9n+E=
X-Received: by 2002:a05:622a:1e87:b0:512:e813:7ce8 with SMTP id
 d75a77b69052e-514621c7db1mr173264981cf.54.1778239516919; 
 Fri, 08 May 2026 04:25:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1e87:b0:512:e813:7ce8 with SMTP id
 d75a77b69052e-514621c7db1mr173264301cf.54.1778239516297; 
 Fri, 08 May 2026 04:25:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a951d2cfsm447818e87.25.2026.05.08.04.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 04:25:15 -0700 (PDT)
Date: Fri, 8 May 2026 14:25:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 26/29] soc: qcom: ubwc: drop macrotile_mode from the
 database
Message-ID: <hrt5j3qjh4jyghnosjmhp7d277npx2oe2pqbqqogeene7mo2qf@jdsrkryutvjj>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-26-c19593d20c1d@oss.qualcomm.com>
 <2c43e6e3-979a-4413-9026-e6ef28acd3a7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c43e6e3-979a-4413-9026-e6ef28acd3a7@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDExOCBTYWx0ZWRfX17H1FDWgQ/uI
 5ow6m5kvCgpmJds/usYiRCV7VxnMHyKtc9vC/xMQKeMJMnK+N7bHrX7sTR8wl6qj/SRhoXQrlPX
 RR3xufTpVPGRl2FkJyVBP8UFGbDbyEXMIpD+Le67BPBWw/nYX3aC0T3CaSsfYdwaZzBILWoj1iy
 9lUk34WQNdCR00sFusQmV+Fg33WP0myBnMT6VxCiBKQEGoYAKZ17HmAfkb1vUJXxNZcPmDrIq8G
 nhI8OSYkbvyqJJ3Wtn47fSXTks6DeMOVuviGe8GrR7Jj9THcl19H5oPouUINkTiJgUKI3Bh6W/C
 4YUwuA8AXEhsvpgfjLLrsMwAhp7iSkYVNvSTVMbLP3GiBbEOuyDobH5ii+5aePilazk6MA2w//r
 pwnNBvDXu5/zZDS4YELG30jyBxmNRoCEH7a45ScxIeGdtTbzzRNmGT2E631he9503ViNxXTC54M
 m3LJNX2c9ejx+u4ki9A==
X-Proofpoint-ORIG-GUID: wznC7dFZJEH-Y_vXSqpwtBZOttAt8EnR
X-Proofpoint-GUID: wznC7dFZJEH-Y_vXSqpwtBZOttAt8EnR
X-Authority-Analysis: v=2.4 cv=McxcfZ/f c=1 sm=1 tr=0 ts=69fdc81d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=8HL270eFVbbVbu2OkTsA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080118
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

On Fri, May 08, 2026 at 12:01:12PM +0200, Konrad Dybcio wrote:
> On 5/7/26 3:03 PM, Dmitry Baryshkov wrote:
> > All the users have been migrated to using qcom_ubwc_macrotile_mode()
> > instead of reading the raw value from the config structure. Drop the
> > field from struct qcom_ubwc_cfg_data and replace it with the calculated
> > value. Split single UBWC_3_0 into UBWC_3_0 (no macrotile mode) and
> > UBWC_3_1 (with macrotile mode).
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> >  static const struct qcom_ubwc_cfg_data sc8180x_data = {
> > @@ -89,7 +84,6 @@ static const struct qcom_ubwc_cfg_data sc8180x_data = {
> >  	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
> >  			UBWC_SWIZZLE_ENABLE_LVL3,
> >  	.highest_bank_bit = 16,
> > -	.macrotile_mode = true,
> 
> 8180 should also be 3.1

Indeed.

> 
> with that:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

-- 
With best wishes
Dmitry
