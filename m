Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4067CC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 22:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4515010E679;
	Sun, 28 Jun 2026 22:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pvl7WW3d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="edBNwsXi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562A910E679
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:53:08 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SMBvkU966727
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=08I0qAKNeZ3YtOQJRXgtfOdK
 vyOV10uVclmPREP6adU=; b=Pvl7WW3dnynCredS2uHbctPhs2ZIcn/foX1a5uxN
 zcZHYX+eSKnoreYOzg6p2aFMO0S//CDSm32s8rFWce47yEUHLRJlb+hAsq9D93Kf
 +iNcyG+eJSdIkCnoINhR4J17Es4oWxM8grbCLY9tfO552TGnref0Zd2lUub7vdYP
 /8GQAH3IMA0TKPyW7Ks700CYqm5t9Dz0haO6q8w1eNm1W+vZMCV5PdU9h/UR5NKZ
 ukWrE9kBz4x9OoEDpulG2AjHkNm6NLwPi3xYMphAvhBW56U6PyDj2EXAb+9lfZrY
 0LFQDrk7FlUHB1sMDphSHYUg3lP/0DveF6UR97jSvzug7Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27333rv8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:53:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8dd6a429cb6so30743846d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782687187; x=1783291987;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=08I0qAKNeZ3YtOQJRXgtfOdKvyOV10uVclmPREP6adU=;
 b=edBNwsXiK0cMe/5RS0Q6Yv/EB+31Ymn/+bkEniyJdVn5D4ANd5hLilffjhifcxMR9i
 xgjBQHLj4mOdAmyHOlsHgXp+Jw4ZOgtwjJ7++MnNyxLPU9ryCLMOEqPjH6Hl2zoyUZjT
 a2RfsjG/H3h6yn0BKMu+ZcTRERN+6RAjxuNJUTK86fyUo1dnP0DxGahAa+sEXUBvPJPK
 etZuV3Yz/SkCBXSEU8bezN/DzStAergzpBl8MQpkVpAfzo4MoJirSQGUFrfZBIwsuOav
 ttKbMmi9R/F1mt0S7XLBjozaRpnzUQLZrPpCa42SqCcNrUaR7xK/pw8aLUiDPDXzGE28
 +SHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782687187; x=1783291987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08I0qAKNeZ3YtOQJRXgtfOdKvyOV10uVclmPREP6adU=;
 b=VjzMw5rYeDlumlbRF/z4IorNcGlPeR8vsOmUyApZ8UjRA9q9jjp29u+OG9s010zOwL
 osmfu1UFW8bfO/W3qA+zcU2hEpTT/bior1JTfLcFBWbfd/JdeVnJ5DMycDiuKvXfz0cu
 +SVgAjIeyvAstz2SywoSa5aJ6mRl/HVM1M17eiqlwZkzlJHE7ItnEeExThKR+5m2iIgC
 r1jj8Jl32H3LqvRWjtTVrc9g6X4Sw4D3mGKzoluNcE2kCVRRAb/XJ1oH4nC6GJUAEY4C
 1SAnvT+SQmkT3BbGD4fVibN1ptJIIc/fofH8jL4pLViuJsmuAJFR4cMymk0+MADXm3Di
 9goQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pdPXSLcZXXLG76YZxkW0iQUn9TPTnLQQoIKtnopeCzOGmYr14w0pUEt4ZZXjCCdmdLGtg9mlgRPY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxScn5xB7YO5aivPI1mW2LeZyanjaA3btd0jkyhPbd1wLppIf7Y
 2srW5SkjA3cdb0UWsEDA5vQKdR+fSvXKEwEEeLxRD4V2TIPDGcIfYMq0FprEqe0OI9UL7znMIu4
 2Q4JkVLvxe0HQqeNvpJlZR82b4EXjsVlsXeZ8K9E6Us0zl+dRg42NJc9J5pvclhgxHD5dXkw=
X-Gm-Gg: AfdE7cmmYifMmRIC0vRr754G80khOa1gTV1DMIE3l7fVIiJlSegV8N+l2rH1uoT4fvL
 4wYAN9AB5IDfAxVCvb/DloHZbxoI1QDra8TZXl58OkvFkFDbFPMwJ/cY+nMeBXCjIw9udtqs2HV
 FCRHeOlJABByLCKPihrPQ3VtOqztn/4QmFlR+xdgaxyLvR5GGfcwtWpBB3Pn+mlAigRPzJA9r2I
 j3Dt+S52pwfKFRVuzZ58ypzlNrHboIvFRWSqO4MfCdcGHn/6DRqNHizqfZer9VslYG4VXMUGQ/M
 sGg4spW0XpOKjxu/6XejryHyNQfhyZ/EIOBsGnPCaBwtJ0/Sgx3pxmjUx/yT9jdC4/RL7qQ5ORi
 EbcCtf5fk13RqtLRWIS7k6F6qvuAYnnUi+Jy41iRUEX+aMz7ImdjJKzDm6mou+Wd/TgXSmVw4s+
 jiEoyuQRyTNJaUiGvhoQs99Boa
X-Received: by 2002:a05:620a:8399:b0:926:e8e6:36b2 with SMTP id
 af79cd13be357-9293d5b1deamr2010755485a.32.1782687186694; 
 Sun, 28 Jun 2026 15:53:06 -0700 (PDT)
X-Received: by 2002:a05:620a:8399:b0:926:e8e6:36b2 with SMTP id
 af79cd13be357-9293d5b1deamr2010751585a.32.1782687186041; 
 Sun, 28 Jun 2026 15:53:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999b18370fsm68823601fa.36.2026.06.28.15.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 15:53:03 -0700 (PDT)
Date: Mon, 29 Jun 2026 01:53:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>
Subject: Re: [PATCH v3 6/8] arm64: dts: qcom: shikra-cqm-evk: Enable A704 GPU
Message-ID: <ga2yyuoob5jcseb5xeeumbnlvsxdhmnrioymbd2bgskpuy5min@miczr3mmgyay>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-6-9b28a3b167e1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-shikra-gpu-v3-6-9b28a3b167e1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a41a5d3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: PhiVoBIRP5UYM-BjNNqNaDrQka2Iws6f
X-Proofpoint-ORIG-GUID: PhiVoBIRP5UYM-BjNNqNaDrQka2Iws6f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfX3oncMyUMgv5f
 AwtP2vciT4iVcpYrpqD1OXuZWwv2tiznrmAaWABd0y5VNzaX2i/hCUtvmk5/mE+M5jnc8EekCzf
 zLTcOezYi6/6m0tMhBX/2fFiG6psr5gOGZXdfNtP7zY7o7IQaMQwy53+K1mIdQlxDybQdGG0+9D
 QEUcwydCtE8SAerU4tpXN5q7pHuCHuVQ+QymrM+C4mBWvsmNYQYdX/rFfOzntp/cebVK0i2eJ2f
 fnFD7TQ39A04dhd+MqJgbXtnT7H0bHgj1m0ID+QIByDRTsyvtXzRPJnn8Bpv64W6IJRa9tBm4gS
 C1Xopjk+lxZD8H0Xd50vFmdlFwXna7VzA+5C9Kgh6FZd7TdawvrzrD3pohXUO2mITlaVdSohYw/
 SF1eswMl9nxUs1hhCwkklDC0na6GeWMcTt4E4gZlIqJzQHl2xzeh3svH/9yImgVn9QRHpAAkcMn
 5Io7KRwrHcjNdJOutZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfX2AdjPLKNcaOx
 OV2rP83KZgbAy81irOZmzy+rXD/qvlBDiOv0q2albgxQmz/Bxceik6tMj1wdi4eHg036suKu7bX
 QcnJvAJ+Rz5Fo6hmue/BW1r8wJlk5nk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280207
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

On Sun, Jun 28, 2026 at 11:53:59PM +0530, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Enable the A704 GPU and configure its zap-shader firmware on the
> Shikra CQM EVK board.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
