Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B41E63FF9
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 22:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3584110E147;
	Sat,  4 Apr 2026 22:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ghbameVe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OMOJx0LU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB1110E147
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 22:05:29 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634L6Jop4113678
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 22:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ho+efGTCBcefvlOHxlNZpncU
 78YecnuQWH4t/w2YXXk=; b=ghbameVeekWiDtlLQCrNk7VEAh/QIbYXysFUki/4
 QLHXeO8x78ubTqaX0OdBgoTGfJNjPoTXLYbtQWxC82gW4wuUUlsd1KcnERQj92ng
 LdPs/l91Xi1fo//YO+M7YEznTUWYNxdh8ZVOrTuWu3bqbrlnyuAQO9l6kKcwp2Um
 Ws8EV7hpdrHWPFf3IytJmtB+Y4QD05iZa08VyDiGljFdDKYRQkbb8InpCHGorhE5
 EbHn58nRth3ia47qOf+KRuEsJtDvrZd5TngBbSvQeP3EYUshkYKLJMLBLRfhYQeO
 nK6v7iDLEAWnWaZWx2INZ4iZ9JOu8Sf7tsKhq1UIOWkCgQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dasn5sp74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 22:05:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5090e08dcfcso9265611cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775340328; x=1775945128;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ho+efGTCBcefvlOHxlNZpncU78YecnuQWH4t/w2YXXk=;
 b=OMOJx0LUpyj8ruVkQODYzFF3lXJDRI+4KCzMXBH0W7I+uNrNbazOLwQZGZn3pbC5Xm
 ecVm8SHIi/Tbb04bYHzuHm7NoWnGqQxLld4wWABmEdpfS7kiBHsLQ3/eD3eLEARljnJE
 LbNqAeyP/+xoMNCb7nl9Ue31jInr5XFhVB+30bS4hHdsjSgqs4c3kVCH2bHmTrpX1w5C
 +w6Gt2bcgecNkXbFIPKLeJLLy/QQP8u+S4cWHkEwvU2XlerbDJlZc02/A5EXHcxkGUFo
 Dx+AVB81arwW48XkQnCnclHzttxp5eK3ViQOyMGEIdaYE4bizhVaZA0KIvh8zpPwdmJy
 PJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775340328; x=1775945128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ho+efGTCBcefvlOHxlNZpncU78YecnuQWH4t/w2YXXk=;
 b=gYVCalz2MOVT11yVido+t1cSS6Kw7Vcm5OotNuLrdwrxBJUHvas8XBRFqeb1Z7wTEx
 2IpIDDBtGR8rV5TtOwmtxV8m0lk4Xsr16QDvpG27HHFs+ZvSXaE3jqogjlQCQR14mtEA
 uxZEq+0PvHaBknQdlHUf7HzWAWnluyX2GNq5rmatnqBZTPJP1kuz1CEVlfSNaJEqAR7g
 G6v8ZPEV7kksk0MT8IHUn8KSebtpGqeZzsh4Uy8h5K2TmMu4UwW80nVdUfgv3Auduzmu
 YuPtKV2D6kRjYJd9dLhsWVX/XBXPgd8gD451ZnYw+Ge93pDY4JnpsG/0t2M7gyoE6L13
 m7Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzdDf3NGK7kEg7xNEdtPqFqS6rLU3TLAQuLS/9vcfbP19X9zJhh6dnNJOEcJLHSG5VhRxlnpg3oT8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+pS8MPyi9uBAB8HL/EuQxJ1PXpJqERitXli/E8HkvfLgLGkH9
 wjlRofh7+rdXhkvWv2ZtjR4SrzydmrvFVPLOkUGunMaAokoA2WCl0XcgvpjVyzlFq3lQdkNABG8
 vypdWcnXyBCp6+0EpXL4L1Xad6efUgblaW+b2FZEAn8XfATuBWi7FWoqM6jqJfFKvgs0Lvq8=
X-Gm-Gg: AeBDievKCCMwsF0R1Y/9g8mqUi5++5QeTcEuSGkBKW749nrFlAsUdA2+zcdNITNxEFM
 2YYVzkTJr0lh+LVFR2Lz07DCgLqIdLad/m0pFbdviILszMdgjk89+LZr//sZndTm/pf+G890/tn
 rfsLi1fxNLgIZlKOfK4W8AWauJCo3iMVPrTDLTMr2KQ/OGi7jLIyn9XsPCoLpfNRuNdcF/a+Wy3
 HwJXG3CtoQ6pcZcH9hZ+4lN3fDGhneIoTq+2QcCMbPKo3fw7ZM4oM1Jw9EiZ/ngPLjp6usSWMD/
 l1xOUxQSwWTOb9wz8uiip3wU3tG1qxChpzS6dRm8jY7cMIO2jSRNR7/2QeYVAoFTrNa0z6JDn/P
 wSKuDcMRuFaPSVkMdNxyFXWmF71qokLxmiZex/8phcutfnW9KjT1RDl8raje8/pDocV5V5y21YY
 W8r/Xk8vYl/Krg+QbcFUgsOyoVbi8oYI6ThrQ=
X-Received: by 2002:ac8:5a47:0:b0:50b:6e5a:27b4 with SMTP id
 d75a77b69052e-50d62d1ad07mr123389981cf.53.1775340327643; 
 Sat, 04 Apr 2026 15:05:27 -0700 (PDT)
X-Received: by 2002:ac8:5a47:0:b0:50b:6e5a:27b4 with SMTP id
 d75a77b69052e-50d62d1ad07mr123389461cf.53.1775340327206; 
 Sat, 04 Apr 2026 15:05:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd212d248sm21487491fa.34.2026.04.04.15.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 15:05:25 -0700 (PDT)
Date: Sun, 5 Apr 2026 01:05:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: display/msm: qcom,sm8750-mdss: Correct
 DPU and DP ranges in example
Message-ID: <w2om3ztsdcvehsqquynmqkpenfj2zyiz6mmqf7ptfyawgzx6cs@3qkix7ae3rxk>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
 <20260402-dts-qcom-display-regs-v1-4-daa54ab448a3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-dts-qcom-display-regs-v1-4-daa54ab448a3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIxMCBTYWx0ZWRfX0Nik7EIRXHF1
 zR2S0x/MgfFbPVS4SyUMApC+zmC4ngDxk9/8rrLshgNIAhwtCeJ+DOqwD7oxLsiRWFvxQTn/HPn
 v9XRxtZoQ5BVLS0Nl2penCN7VWAGAbp1rMh84lTPc3QJHecDuuoXII64YGUi/ItVVelm2WE3X8K
 oIxb7+WScEOuzHRUW5hmiZMfibxuDdh7TSkEWfrzJa7W21gYMLGmMkmQ6sGV60oyCOzn0VooIfa
 oHrJY02nropy9opqLSjeou10v/CYz2LyDAnPp24oIc8vgiWYCg4VpGIUAsYpAfHcleuo1HNgiRc
 eMyNse0+PHfOC8dg/JZXwZp6Yts/v0WmEpQnez0g/cUmLx1mMgQU8oihodbKkiTrx35NWCdiytw
 5Vm7I2VYt/SVdbaQmINXB5nrXbbqEd40FmSWCqFuV1cNdQgCBH5VP7wwiO3Lu6BR+MuOiXvm+8N
 PRmTr9Txktq0D2ePW8Q==
X-Proofpoint-ORIG-GUID: bp5yOohVYS36UItvwZDU6GTnYpp4LKym
X-Authority-Analysis: v=2.4 cv=K9wv3iWI c=1 sm=1 tr=0 ts=69d18b28 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=bHnmLuETDjlIWUPFTNkA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: bp5yOohVYS36UItvwZDU6GTnYpp4LKym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040210
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

On Thu, Apr 02, 2026 at 01:45:15PM +0200, Krzysztof Kozlowski wrote:
> VBIF register range is 0x3000 long. DisplayPort block has few too short
> ranges and misses four more address spaces.
> 
> No practical impact, except when existing code is being re-used in new
> contributions.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/qcom,sm8750-mdss.yaml           | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 

Nit: the subject differs in the style from the previous commit. With
that small issue fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
