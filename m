Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF12E63FFF
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 23:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E8610E0CB;
	Sat,  4 Apr 2026 23:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E8amIfe6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QL30lf7u";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0416110E0CB
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 23:02:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6342qqgm2199939
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 23:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hIFgpkquzAjeQNC3t8wsfdrd
 AKli3ZjO8/bY/XiA0Qg=; b=E8amIfe6I+w9GvLabkg2HvU8/xKOpvHxLB6ziRtD
 cri3RBPcJ5cFUOidi/JH1OL5+rG2gCC+P5w+K3ls5RyHtzvYiD2WzrifhLRWUD+9
 rNZVo7SvA/s6MzkPDfcM/w+DzoWbWG3ZxnLt+PIOiDHllOKvEvViRIkR5wlQaOwy
 ET3N/8FMEj1zjJSCxnBeOtWnxAc2TzfejBXZM5tNLxkqHdsyE6mQ7GshkqCm644O
 sYT46U/Uq621fFOfNeRDqOrOLFAmNlqb2SMGkN9ttlPn+Zlg/0ubnNB2LVBTDrER
 H5jRG/8DoOm0JBIGFhrPS1Tmdq2gQxmQW/kaGRC/qM7z1Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dat7u9nrx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 23:02:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b323c43fdso64358301cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775343771; x=1775948571;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hIFgpkquzAjeQNC3t8wsfdrdAKli3ZjO8/bY/XiA0Qg=;
 b=QL30lf7u1B5bvd6Fv0bLWmfDZpNSigQp57GrAkb4fjWRr0+9gi0VWgxvjRrnVVd2tJ
 uCMOMhM/Sx25Z3GNPhzIOVumw6352yV0D2JpVSwYSklpfvpZ5yLOwvmVnR7ZXN8k7kIr
 FRhCoIaSYFNUm2A+otU50rC8qkdy1ZrMErxfk8E55z7tkZoug+LBUIA3+FBDiTeOESeW
 lWITC5UhIH4wKPn0IkkjhNCb2uo4fkCrQpajucyTYpk2Us36NifOZgIB620Ey588PTAE
 oC3qwmnSAgxhNyNbipakMaINsLPKqqawS5gPK5RVEZQkmBYH/2lPltPwh1mQs7E19oL/
 jM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775343771; x=1775948571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIFgpkquzAjeQNC3t8wsfdrdAKli3ZjO8/bY/XiA0Qg=;
 b=e1nA3pxJ5x1KdiKIMk1OSE/ssTisoq2E6lF/E/60N0888kNDB9V01d0mOCV/73EHIQ
 i++MTTdyuOURT1POLfboN2CcQQfWe3n0aeZahK/0xdBknrQHwBux59jKg7vVuFDBagj3
 zeJY/YE7fXgi9lT/HCylcC1OY4w4DFXkbPtfaKXFPZE5gbJOT0ywE2uE+OJyNKWl//bj
 D6zMYGT5vTJdgYMKhuXBpycysfvmRfqTStbDquG1+hhupkBon3hxR+UOR6FUCU9ld887
 YEFrrI6aSg/iXdMu59ePMKlr7/qSVIX72XPuCHWQMgXCjibVKvlQ9nnxqBE7o61FSvZR
 U7Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7a7okO3LdMuEDTxu/+hDPajmflabu1h7KvMZwYxkIK08nDR1smiKUPzJP5u0n3gBH+FxmnUOJ60Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYW/JHLgtNE7GfZQwiF7r7eFjx8VolXl8yVy/Zym6tfr9FAzZB
 dnBknaNx+yNMbsSk68ziYo3fq9p4z3QmZ6h9wH9g7xIXByV7XVF7UI8JXwdH+UgCe2BYgi5fAMW
 Ogu6ZuKIRrjsK+4DopAlv0uGr+c4hL6Aj7x62YlsJfm0vy0lb2K+OnkxNYNP3PWeO82hOfjU=
X-Gm-Gg: AeBDievxBob/RK80GaRcIVUaEegZAW3/+FpYhzrpOyoASIZhL2ENy6+4JSHGkTKnp90
 SgLl06JkUPw6GRfMoLF/ofY5munhaQL9pW3Y8xpev1GGFhvRoSilw6BeykkfDYNULtPydciYSej
 4Zp3+T11rRObnn7NlKV5ldDFAZx0MoPrbmIEVhCL6liAEG4ILfkfPLfw1JLmU0Oej5aH9pSwiAn
 nlic7mhaFjQW1HLeCB8P9VOJ/rDqURDCaW7Y0bch5UyP3mmQCo3z/bhIDW84ecJroRpdnB0//s8
 u1Zv7hLgnR+JIIMoQg/JsMknDtI9IIEEOYR8SCkQRHhaPhnU6OOPZ+kg+ogc5lvMR+YjuzAK+k1
 hwvEXd97h/NJGWWJTPmj4TP/V4SJizOYdsutiYKXUpZATgMGNlHpkp/NnxnOi5TCiVJXY4yWzz/
 JCYpuYMrev5VDnb/Gwxo/5DRySP5EjIcf++RI=
X-Received: by 2002:ac8:58cc:0:b0:50d:8699:ecdb with SMTP id
 d75a77b69052e-50d8699f5fcmr13553061cf.48.1775343771237; 
 Sat, 04 Apr 2026 16:02:51 -0700 (PDT)
X-Received: by 2002:ac8:58cc:0:b0:50d:8699:ecdb with SMTP id
 d75a77b69052e-50d8699f5fcmr13552411cf.48.1775343770627; 
 Sat, 04 Apr 2026 16:02:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6ccc8e0sm2417132e87.58.2026.04.04.16.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 16:02:48 -0700 (PDT)
Date: Sun, 5 Apr 2026 02:02:46 +0300
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
Subject: Re: [PATCH 1/7] dt-bindings: display/msm: dp-controller: Correct
 SM8650 IO range
Message-ID: <xujhwsk3ne2nlzs4yefb7eiscdiqa65xllu47skbdk4wgrjw4p@eicdyca5gz3w>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
 <20260402-dts-qcom-display-regs-v1-1-daa54ab448a3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-dts-qcom-display-regs-v1-1-daa54ab448a3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIyMCBTYWx0ZWRfX93Ue/MCEMvBT
 nGEQxdIl4yOsIrfC7354CnxKb1tOog8lMjWzxQpsLI5PzK8ihH80dXyxyGcwHIYj7pP8SNXqtJU
 XoSEtETN9VbcEn/XBc7LGsBAEB7qUW+BhYtaY9g+8oINklI+TscjzwkBHEZPF6izqQkoD8JGg/O
 /ew5vBgYQMT/KLU77kicAYBvRN0miOtUGldAdBDgOqUKbDNJGTkAXzaNzzScciqHd5G0+iFvrcI
 cE8/1c6KEdD3mwOKp4FQGQnqyiGnfbJn7K47NQIleu1q8RvQqL3cC7ZTRryQuuPEHzEtJkOY4Vm
 OQYlIgm0x0MX/jopdtvdsR5UZ/LTkW9SIyx0feUuEZzFskRYaDPKPWqsylDGWObCrDSBqfLfocc
 BtK8zDp9Tg9AQI9VOoabM+Fq+rI0jCRbDzKNxkhHcSNG0qGvN6CsWNXmBaunLlH376qrds/z6iT
 hrY7oQnOvDvYpk33Owg==
X-Proofpoint-GUID: 36kGwnRrGKHPARa1ojK4XSAf5IbVbial
X-Authority-Analysis: v=2.4 cv=RJ2+3oi+ c=1 sm=1 tr=0 ts=69d1989b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=P-L8s1RTvU6d3TPFcGMA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 36kGwnRrGKHPARa1ojK4XSAf5IbVbial
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040220
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

On Thu, Apr 02, 2026 at 01:45:12PM +0200, Krzysztof Kozlowski wrote:
> DP on Qualcomm SM8650 come with nine address ranges, so describe the
> remaining ones as optional to keep ABI backwards compatible.  Driver
> also does not need them to operate correctly.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dp-controller.yaml           | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
