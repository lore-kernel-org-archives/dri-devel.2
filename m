Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7777CCA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 01:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA2910E8C6;
	Mon,  5 Oct 2026 01:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oki2Tj26";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K1aTO4Cx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A2310E8C6
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 01:03:05 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695102eG470523
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 01:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=cIN/FPCHWQX2ilgcPPtHpxp8
 Rklr/RFaTYrm5ESNHt8=; b=oki2Tj26wJN1J38t/A+k064edb6R/VljheOsbHek
 TVywuGJ2xhCNWb7l8Nmme7UP4PKbHqjiDBwvAM3KwGYFb2f4JN6tAkUj5FDVG51l
 9b7PHLo77fnDmayjaK7ohR93sSdmvpIkbOpfPm9xMmRqWqdVqn9lM3XZdx3ML+8I
 hn+xP3E3/ylvPIR2EZL81oTRFCpL6PpKsT916uN6DVCggoS+tCBFaxwBBAJsaZca
 6YcoiRt77G3HehrH3VNJwBi27s6d6x3rxSDn5LK5fFHby3/NqyGylHk55iMHsXvj
 gmAAfHGVcsyBULfvEdTSWgL7QfUhhOB63KgH7te4Tmu9ag==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ssuc2vj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 01:03:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939c30aa9a0so124264785a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 18:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791162184; x=1791766984;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cIN/FPCHWQX2ilgcPPtHpxp8Rklr/RFaTYrm5ESNHt8=;
 b=K1aTO4Cx3DinCrArzuL6Tp5G00ytoDl9rVddDnx9HfIj6oT35l+tnsK03JcziURQ0q
 243J/J1EXpby2hMqjOmmeBj+jN052ohRO3q9rPdTX9ZY48EYTejZ3rdvgMZnIzxUtT89
 mnHFCWFOZyhD9VlyNiNi7Rh8My/CWXYa6OPDC+EN30o/kj5LULvkE2cBpYIGsJLuojoL
 qoEy7rOD/c4O7Z/oDR1BxtCnoyKsbO2JxhwswTvEJYnWpFISKIo0U2p0cHxILuldjQ71
 Kt3+Q9HXb9yfNdhsO+awOxLZG7N05omjVD1AzaauuOLjbIz/o4cn2jZBJ0cGFUBDYLVs
 UaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791162184; x=1791766984;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cIN/FPCHWQX2ilgcPPtHpxp8Rklr/RFaTYrm5ESNHt8=;
 b=Co/yWGFdIgksfExvbajuknrHwcwVPlq079r4latALT6VgAWVZgJfLXlzQVrUrqm/1X
 nAK4DeSJtfQQ8q/0g1Mplytdq6HKMKCdufw7p3Ate3n9+Ds54DKecC2TpArZQmP8Hidr
 5zx9umw7VMX9OgmDM3ZqZnrWM24ZbsdmCX//Ihn86pIcN39b1evkz0SlAKjwfK1+e9BY
 ZYtGl58AwO+3oC0lKhgl/vrfc28UWSsEUFTfgHqfrnT3ctj9/KHIE8XMTUIsN7Q4Ra7L
 iDaPrXrHP9/pXV+589nMrKqcVR2ObTpzBmExOfbvGnuYj/8FQpStqR89PQZ6jDTHy10J
 0pww==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmo1O4v78hiHFptnXpSdQSWq98oA7va1jsNj1A0L1T8T49yC5jp9CXsC7Atfgl5dKBeWl2Asp9dyc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mJvnJ1MmItrQ3Rb6gEXEWNG5SqXGX+J1psQViqYPq9uLWrMwRa
 UFqLWhavB57Uw70SGhN0jJ9GLIfVekcki8rN7OfKpqzYg6voLyNHwKIhodIbn8FH/bOp0Dq8/OF
 tJzgmVQvx8oA/5PKHFhTjdkZPjDSeatVg6FMFNEqvudoxSW8TiMI5W5+SMFDzlJI2hSCvTvk=
X-Gm-Gg: AYBFou0XVwiL2mwwJrYetSDU8IG21kgWCsi/H9zxEm8dZWJBhCwCJtg8gfHphBuSVaL
 LFsOOdvIgYagWhkJ3SbkHnBahMVj6yiKAY2uy5QbLyC6rlJwkF4GE6a5QzHK1ybJ7cGVmVP/dB/
 KLi+cxlFm4kT5ZyX07VCjOkjux60AwlKIPhGUDzFt/kFnkaApcfWujfcwST5tyqnyRvX/N7SZy1
 9FSfRdTAvDZl0jqrcVjoZW5p+CUTfNBy6EsKrN/QAEdnlQhmxo1vAeWOz03dD/qQH2a/HCw4GfZ
 j3syYOLBTbKSHTCI7mfKK3TOLRbdenem6d5RilH1suvTCtCxE/FtR9Q3cf8QcboMiClBVyZ03kr
 uXmlVNOaRoXvdYtqRTzxT3cyAfST6waPqvz7pE51gSBQfBu4rgBkzZfp3lCfX4CLJEdUSma6r/J
 NOAdBIJZhKb43J
X-Received: by 2002:a05:620a:4086:b0:93d:f7ac:4706 with SMTP id
 af79cd13be357-93e50e4a9dcmr954045685a.9.1791162184297; 
 Sun, 04 Oct 2026 18:03:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4086:b0:93d:f7ac:4706 with SMTP id
 af79cd13be357-93e50e4a9dcmr954041685a.9.1791162183793; 
 Sun, 04 Oct 2026 18:03:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c79632fsm2749164e87.40.2026.10.04.18.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 18:03:02 -0700 (PDT)
Date: Mon, 5 Oct 2026 04:02:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
Message-ID: <f3qs4wcascfodjufisl4qtpycfb3lunff2fv4u3olybjius5kp@vahhjfjfh6wv>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
 <20260915-msm_gdsc2-v2-1-9157237b8382@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-msm_gdsc2-v2-1-9157237b8382@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAwMyBTYWx0ZWRfXwmrhSe3xnZ7R
 dnfBZIMhVjvdbvdeYpS2DkSc6RCyNJXss+sOcUi1fvCxlodPkWE0xgVmh9CBBxpwf97ksAwwpDY
 xrezVXwc1bkx98gXGdXy2YJV91iCY0A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAwMyBTYWx0ZWRfX8iqPGsBdnE1h
 MXh72SNcD0aV5aik5p2OZ9jhdfyVBF2oEuV2B8pAMZb1z7NsbpiTbmkRmViO8zJ5ldo5Q5Uhi77
 EJ0cBDFwfRLvkG+K+OmQzi147OFFtLbBgoA8WvgBvM+yjgK8JhUPFlAulEMw/K2uGd3yY16JVJr
 TSh47KvG8noI0wBN5lSzflaDh+jg4sfnek8q4g3wOn1DVZlztS/xEF1QzCEgCIgLUqWhm1m7FxS
 v8Xi240WgXjoX099W/vxbmcydq81vDNWirAZud+5buO5i8COGy3DegJQaoBXIZ0++XGETe/R8hW
 q2GBeRPJLLvJenG37PxjFJ+/pqRGxh05uho3bLJi6z/4FAa7Q9bWlDCZnj0gKRKkTSYJ5eJqZ4L
 OdKqm7rdjOEWXIaz4SzZJfPaHhEx/kD0Kr9e6A4irA7opzPAKkO/BojJbueKB89OO/l4cI7EwMw
 z0N2hkJJXCLY88+5cHQ==
X-Proofpoint-GUID: vNFAr7vRugk-CigNUvFogxZJDNF4BLe7
X-Proofpoint-ORIG-GUID: vNFAr7vRugk-CigNUvFogxZJDNF4BLe7
X-Authority-Analysis: v=2.4 cv=FryQbGrq c=1 sm=1 tr=0 ts=6ac2f748 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=6FRr1iax-wq3EJIYYUIA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050003
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

On Tue, Sep 15, 2026 at 05:27:48PM +0800, Yongxing Mou wrote:
> Kaanapali (SM8850) has an additional INT2 GDSC that powers a subset
> of the DPU source pipes (VIG2/VIG3/DMA5), on top of the CORE_GDSC
> that powers the rest of the MDSS hardware.
> 
> Describe INT2 GDSC as an additional power domain of the DPU device
> rather than of the whole MDSS, since it only supplies DPU-local
> source pipes. Restrict the schema change to the Kaanapali DPU
> compatible via an if/then, so other platforms sharing
> qcom,sm8650-dpu.yaml (which don't have an INT2 GDSC) keep the
> existing single power-domain constraint.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dpu-common.yaml           | 19 ++++++++++++++++--
>  .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 23 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> index 3f953aa5e694..19b791a857b5 100644
> --- a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> @@ -25,8 +25,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  power-domains:
> -    maxItems: 1
> +  power-domains: true
>  
>    operating-points-v2: true
>    opp-table:
> @@ -53,4 +52,20 @@ required:
>    - operating-points-v2
>    - ports
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,kaanapali-dpu
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 2
> +          maxItems: 2
> +    else:
> +      properties:
> +        power-domains:
> +          maxItems: 1
> +
>  additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> index aa0cf0ec5b93..88aa71d2b912 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> @@ -61,6 +61,29 @@ required:
>    - clocks
>    - clock-names
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,kaanapali-dpu
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: MMCX power domain
> +            - description: INT2 GDSC power domain
> +
> +        power-domain-names:
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            - const: mmcx
> +            - const: int2

Nit: I'd suggest more generic names here. If the next platform switches
from "mmcx" to some other domain, while keeping the split architecture,
the name becomes unapplicable (in the past we have seen platforms using
CX instead of MMCX). What about using names like "core", "int2"?

> +
> +      required:
> +        - power-domain-names
> +
>  unevaluatedProperties: false
>  
>  examples:
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
