Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682E0E9D826
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 01:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8A410E03D;
	Mon,  6 Apr 2026 01:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KUkUmJ0p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eC4JZ0s0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0262210E03D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 01:00:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635K7SiJ2543533
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 01:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=cZxF5REp94u5kL1p8dA+O2An
 Kkpz1KjKI2JPT67f56A=; b=KUkUmJ0p6LzrJN1Tex3g4B+6KhmAgpEes9/Gfedn
 xyqTJmMTh7E5aPVxY02iyLEf++ONsI2w7plI+C2IbojBqMYOCpwxEtBP22IuoOqv
 Y1J71FgGkDGSkRKq6tH/zmBdKBEHmNwDw+yKBlGURkgo/ZKCSAvO6+n89WpppkNe
 xqQM/EDgjQTH17K2bWA0LVmzZhSl5+HXQlVNnxL3MkAbXz3i+y3CxiIJendfGpVC
 Vlpy0wrdQ8d0izFHtwRkBGLGGCpZPAF77rV74w8fiq/RGDHB45LHQZoQGlMzU+kh
 188pGDUxqV5ZLPmCJl/FFq8XwMtJEb2hX4TMqeUf7yJD9g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4datv1be2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 01:00:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8954803bd74so36047366d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 18:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775437216; x=1776042016;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cZxF5REp94u5kL1p8dA+O2AnKkpz1KjKI2JPT67f56A=;
 b=eC4JZ0s0go4zsnYdJfMFBrbVWp6wQQ0Ng12KxzZF0v7QBNLvUW8mXDR92myWtPDvRS
 lVmXVxEzeywGc4IJnwkHiG3fbzFZ6xUCfvhvcAIuXYrCW8VqZd512qvn39Fy96cS/wz1
 Lhshc6rzo0CHFKIILNusCGYxjC6YOAMTfGwNCDqoS0bN2PuC0256sH8xsIhFP3XdbKKE
 iMLqMeOXZQTeKOItqb0OBTZ0a9hC3Avu19PQvB18BanavCtYQ8fB3xOtdFQbyUvg+Rue
 Htvn2nVkOhGijCy7cm8RWVlevVZkIXax9EW9lWxHL9mbN7RENPYxzwIa6QBCXIdJTEwO
 d10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775437216; x=1776042016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZxF5REp94u5kL1p8dA+O2AnKkpz1KjKI2JPT67f56A=;
 b=qfFU7mCZUy9Or2z/2ab2uIE9YRYqsxlAxP3CWhKnNICtjx9OVbHEstMvkyUvHygoNS
 uG42U9eDJRCinTLwH3brFPi9LKqNEDXRxZZxciKLhWh6W+ZSgXre5Pccp5jI0fnUpTFd
 X3bQDVo+vbETAufRXLhqkcAHHmQohReuEyeU0jHh32Rex7WRePPLBm/K/5xWltE7j4SD
 eNRR07vjbo2fW2SIibeoqasyfHZNcBT4gQKIvqNx2Nb8PotSa4dOw2YVE7CFAONQ97UX
 CnfLTub18tqZkhCeiFV9xYJ3FVDSdM7YELiKWJLHj3HylNcry0ySRiP1K/F8+k2u908c
 2aIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3Ll2qJh7oxvNuVqAUq5eWkSJQogJTs31/3zJ8wSx0VY41VbkE/g+tlOGmyTgKdqGBQRtwDVTEuwY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAod7nZcGxEpsPeTOxr7aJl+8wDNFXtmTBFiwsE3edtey9BEEP
 6lgPO3eXmJrR79461VO75vaHvsxZVffRrneOf02/XiIQ1/ODtFrO9aiZWFjmigagUgRvtrh2Cl8
 g/BEJnYpn6GPHxL3MUbU9IgTWpnO7XvQ0UH4jst1VfW9xXIK+9QUy4EUQRNRHDbFp3yCF3og=
X-Gm-Gg: AeBDieuGaG9dm7FPSCHENauIVScMebbiFByrIrBhZ4yBR9ljvRehDGIsSQXsf067SrM
 vOP8RznSX0MKM7ewXLR3WpoB5gmwHurjLapAM7PGNJh0GUIOk9ThnvmWNVGMoFpWapqB6bJh+SB
 u7vqwyvEh+GfjsYUCp4m2U78N2J/dw/cO4FFSpSoI92XPXU1RMafkk+X+JVtAg3c9ABM2Im37A0
 otFYtwBNbBLcUN3Fc8UTeAm2mtmdXbYw3QDpH3hwBkPzR0izrBxoGwOsBidoEYOZY45BfbW1HxM
 y4CGRnvA9MD58Y8VX9L9vK6K8UsKkekCkdhslsmN4fTG3oLM1By7LNi5btTSo1M4SCTAsdsrpaO
 cb6tqD7TpG1HOs4tCNKXOrnEW6oSXaKgAaAE6Hc6hChvz6bIN7D/sURzYBGLp7x1eTXAcNnD3Py
 ya0K5jy19xka+/1rIrsqmWNsX+8gBzehp2bxc=
X-Received: by 2002:a05:622a:14c8:b0:50b:48a6:6ba4 with SMTP id
 d75a77b69052e-50d62b349b4mr159032571cf.48.1775437216409; 
 Sun, 05 Apr 2026 18:00:16 -0700 (PDT)
X-Received: by 2002:a05:622a:14c8:b0:50b:48a6:6ba4 with SMTP id
 d75a77b69052e-50d62b349b4mr159031701cf.48.1775437215710; 
 Sun, 05 Apr 2026 18:00:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cc5fa7sm2983778e87.45.2026.04.05.18.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 18:00:13 -0700 (PDT)
Date: Mon, 6 Apr 2026 04:00:10 +0300
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
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: sm8750: Correct DPU VBIF
 address space size
Message-ID: <qudsx5dveuuwhkdkm6akfe77hkchejjttph5f5r7kyldi7icnr@cnnfs4emy4ii>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
 <20260405-dts-qcom-display-regs-v2-8-34f4024c65dc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-dts-qcom-display-regs-v2-8-34f4024c65dc@oss.qualcomm.com>
X-Proofpoint-GUID: AkfYl0u3y8gOlOglxDYNB5pS_sF_Rl5u
X-Authority-Analysis: v=2.4 cv=GLEF0+NK c=1 sm=1 tr=0 ts=69d305a1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=fzqTxgmSy3qf8bfLeY0A:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: AkfYl0u3y8gOlOglxDYNB5pS_sF_Rl5u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDAwOCBTYWx0ZWRfXxdpERX++PKYa
 xpRWMN8yv5X65FXcOThLvCcLA5czMgxseesDaY2aOQkCiEiHtLaFeWFnRC+VnIPYSP5lsJkIHtX
 fxQeykjGsQhoOmDAhy7n0f9SBWFdccrsW1GWeJOaSV4Ni3wL0xaMChaX61fTyHwZ1zbWEy3ahE0
 0nZtOlzY4KFDZQ7le8m0lqN8GLGjc2LemNkARSW0YTkGWSg5/FzJrE2gZFd3MhIuuj1gKtTo96y
 /uu6anQHswqNLhO8mj+e81MExzwyyja5l4XQFFaodG9h5Z5jlZ2WQ/A2Ze7qmUbQecF+Y9HcfKJ
 H+QtPt8y7OX1BjAhisn8EDD6ZoNvqigzJ8ukuQIQ1/RkWh90ouss4wafbCYTXE7tDOtYZeXTsSr
 Y0lMJDgdpdsGoKW2le/bcrmN4g7fdnCl7bEdu47xM/H9A3fZ7VJt3pYAy4F7dPKefEBkPK8lTjC
 oOQKbSmIQNiQRelaRLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_08,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060008
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

On Sun, Apr 05, 2026 at 04:34:04PM +0200, Krzysztof Kozlowski wrote:
> VBIF register range is 0x3000 long, so correct the code even though
> missing part seems without practical impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
