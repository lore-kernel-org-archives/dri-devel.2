Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9207FCD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED96A11A09E;
	Thu,  4 Jun 2026 13:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NcgNgSMd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KpLHzIX3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2BA511A09D
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:40:57 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654A869s3233912
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 13:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZMSSOk9m2Wl04LyAsEWMrBFk
 eOKrvo/jDJnE41Px/X4=; b=NcgNgSMdQfeNpPoJuFUiafKc2FZ3uiR6QQyQfcFC
 bQlLrWjGuu4V2bQZpFzZn2QdaTsc70V5U/aerfMlcXNDdj7hWVIoSiZdZNL0Rbgd
 vlbsc47zNt9Ft9VRnYrbsBw+RjT3W89s18xoDvlTPC7i1TxCSF1sztj9jLeNsiD6
 /cEVHA615T7Q9gX/foiuEl0cthNTtmY9FIS7jNadFZ9oP1kfIDqFgxJN5ThEGzf5
 d+bHpHkY8mB3dFgW3wzX+umX5wYPmGhCb0gLhbbtMiMfAWr52zxJ/M5PJohQtthW
 z4RQd/DP4pIQkBYzDya51WyVbrnySGZUpTDrLy14WOO9Ww==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs4s3ypu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 13:40:56 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6c6dc39a6afso377213137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780580456; x=1781185256;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMSSOk9m2Wl04LyAsEWMrBFkeOKrvo/jDJnE41Px/X4=;
 b=KpLHzIX3aag1TezaVm1uwOr1scNZzzf4bOcXbxdu6gt2WhEmWskmiVRdlFAC9pYHwR
 GSWB2c3BSt43cWFJSXaOwMaSZbGkW+ub/6EN4XxpqXK0w/BEAHhZ83uIp40MGXsMRld7
 kF2z4ERboP0onTk8ZYzevzQu8kghKbTThOrlun6auVBqKqwt6eyV2ls9p0UydQXyTuLs
 iKww2paPoA3LbczAYj15k63Q5TgORdZ/E7S4TXckk+YayUtm75q6DEIcHAwc0VaZqTjg
 na5eSxpi2XzbVMEeZPkNp6KMYgQRNs4Pf4b/FivTlRGlTuGFTQZVX4TX3bve2N3RdgFa
 MO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780580456; x=1781185256;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMSSOk9m2Wl04LyAsEWMrBFkeOKrvo/jDJnE41Px/X4=;
 b=HTTbZPrdr92TUGrVj2mVK++0PiC5Dh2V7/GooC9ho2CCpKdhW0nbNXJbfcTk2PcMNf
 TF8N/tCAcNOc9mTBbysEY8e2kfUeBMTZSasmgTzt7OBfETW+YMOlIFS9ZNB8BgW8Dkgk
 idxZJDI10oPmM+Mk6ZCSTDX3Y0zrU6gHxy46eeXnBOv0gAtAyCBxZ+RIIYGWw5OY6dvK
 PLck8luyY3sP0LzDJk19Jyq9WSFThgdq6xJP3iZVDVTWb5zflrkHlYwO+h2VqA1P+udu
 EzV4iTnkyD1qzXPkNMA5yXmmTHBlR335isLALW+bBYKtnMgNwmZ2SntqZQF1+8yDvNq7
 eTRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9H+euCSteDeXppitpYzALF5HLRVH8iZXCDIgmggnd6saj42g2ARpkdrT4rDi2a7qCM7c4F92otS0Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxz5BCrLA/eJwAqugO0i1WMUTBNHXk7kUJVEZgi2BY4kC1NQObG
 SHa7wYfOsPbl88wkhUlDaD/E2RleoLHCGWxAYZX2nQLb7PvG5cFI3qqaD45TqaGn7kHNVu8EKSm
 PgoTZ4/dnRuWks6OvSncnLqJKBKtd53uDKs3EI4zPuufqOVmzsk5WnWatxNcuco7++aAMa3g=
X-Gm-Gg: Acq92OEl0fNuZIUXowSlZKRtOaP5Go7+kfS2nv6WdFcCyikUaIggnVY6x82OtCovciS
 ve4MD9vvuJ9gzLL7P4etvHu4dK7y6V+H05erMupmyTxfWuEKmMCqS47MnI0yevku8eUupPDg5vN
 YUcLrJl+Q3+LBT50KZPR37UEAjQ4qi+IKE/Whczto7E7nUoxkVpspxzF5QUc6YdEpVxjqvIorr2
 ro/oR+yCa9t9JL+RCSD+WPDDUqmhdAiY5+MXKDhuhTzIdHTAAu8t+jJuo81TmPfMAmd9x2nPjdZ
 Az/OTgHSKX73rfmPs5BIJdL+K/rGlIOMpUXWSSAd88KhdeFQDeN1hI5ixukVb4gy/Ch2KTp7Og5
 MK31bZ97mjrrsuAf/VV34+6vCDmbq1uaT4k6RlNCUd+GO4Mo1+6CtpGbpSDY0sDHI9lnZbfD/65
 CXf6q8LxhAJZKgeduf2UJyPEdWSq6wFp1++bp5dAExuarDFg==
X-Received: by 2002:a05:6102:3910:b0:608:94e3:bd89 with SMTP id
 ada2fe7eead31-6ec28b175b3mr4344041137.1.1780580456270; 
 Thu, 04 Jun 2026 06:40:56 -0700 (PDT)
X-Received: by 2002:a05:6102:3910:b0:608:94e3:bd89 with SMTP id
 ada2fe7eead31-6ec28b175b3mr4344009137.1.1780580455735; 
 Thu, 04 Jun 2026 06:40:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b9916b8sm1228864e87.71.2026.06.04.06.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:40:54 -0700 (PDT)
Date: Thu, 4 Jun 2026 16:40:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/4] firmware: qcom: scm: Allow QSEECOM on Yoga Slim 7x
 Gen11
Message-ID: <d2s6nvknjlmwhnfoizhnafbjzgwofnqbg7pcyoeit7hbznes7s@pijbxqls4sc4>
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-4-57c70c23d0d6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-topic-yoga_submission-v1-4-57c70c23d0d6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: DUXwq-J_pIGiN67eCBMo0uEaPmf77Apq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEzMiBTYWx0ZWRfX3xdIj2PoBMiX
 ps5SsA2yTf0pb3C+q0TRtXiLQcK24kMdK+/8hmt30NzdHXK7HwnnKfmGesCFiGC2Ca+ISHGYGkA
 zGjFoQh8hv+PHKkg0Rw0sB7MepntX4F9bur9A9uU6783FPPhZp4DUE3h5i8O0IP3kXVxUePGi9R
 coZfQFnATeodH+x9NKf+8VvN7ynco3ZWnlAbN9e925af8fft7G6ybAG/TdSE7Vi0WzD0l9m7OpK
 87rC65GjmBSKHF82R8rJEzz+rYCxNmVMY1LUMyHf95fDyB8D4k7qLcG1coA/3GDyEaDYc55niVO
 pEzlSIcY9nAUCsX1rzoU+t9uXdvedZU49StJBqN8xZN+7hO2IiWIVj8cUZOxkikEA/H+/GwMjiM
 zIAd/EypYCFjmRAPAtRMoE7KmPIgLj1ZttswBLWvXpRjJHxZSHi1on/YCX0U1Y8mLxmBrH7ypih
 eFWoA8NsRW2jzlPlOgw==
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a218068 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=RNZNEj0NQT9gpfWmR7IA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: DUXwq-J_pIGiN67eCBMo0uEaPmf77Apq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040132
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

On Thu, Jun 04, 2026 at 10:06:57AM +0200, Konrad Dybcio wrote:
> Allow the use of QSEECOM on the Glymur-based Lenovo Yoga Slim 7x Gen11,
> as there seem to be no issues with the firmware that would mandate
> disabling it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
