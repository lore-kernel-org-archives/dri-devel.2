Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52930C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E9F10E26F;
	Fri, 11 Sep 2026 15:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nIxyRhZe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kg16MN/F";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E66F10E26F
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:47:27 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEmEeT3780628
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tAP4G/5H0Hyu01kOmdgc+EaLrKXNW6ITWSH6r5rO1zQ=; b=nIxyRhZehWMkVrXR
 2GaPdMAHZP7A+k0lBwJrtHhG5VfwXwjxPDe3WJ2RtymndrVQSgeaQ/djVThV4h0A
 DEvBMiNqn7x9jY6lTt8G+u/kvyA/U1zG/X2J8kyGjf1f+wOVflZYvh2BPcKC0SGm
 9HMaXNYZURecS5Z0PXMHnGPQkiWbyHwmsNZ/QZ31Kw0GHBMzphG+fZMJnFcmWmTg
 rN4m96B6FO/fZ/5jAzxOms9UJ32YnzCYYW8WxUNuPL8BAOhYT2gZ4Lx70SrNuXkx
 rlz8hE1HWYftk6GDuKOnUY5FAOMwn6P1ZXhnMBAutEcPCQrrIlTMQYyouNRHLRM+
 jQ0qVg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmcgfj8xt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:47:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93102454272so19443085a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141645; x=1789746445;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tAP4G/5H0Hyu01kOmdgc+EaLrKXNW6ITWSH6r5rO1zQ=;
 b=kg16MN/FXbyuD9IGgJ28LuKIb+sTAnFe5j1QkSpp3Rc8wwNYrwqa85g6j6GWqp3IVU
 1ZTh1Z5Le2q6ewQkRvHgLcrsaYOEIZyTDiRE7/Pn8J39q6/BIl4fcJ7p6662kjUtSnfL
 kLY1PoBhUVmASNNXMRJDvcynOlnlWZ8bsoECIdFWCyQC+8uvRvsNW4KDUEbkovIlRdCA
 KrIm7Qez9TYfH0Ilx01xTuG5YCvXhd5CjiEHqSq2eZi6788EztKjDKw4w7fSoXuJkNnS
 GKVNCeHcxqBN7kibu/Qu7y8Uv2k5MzUaoZXtICSaQWkjJ8FqUQkSDgCPDDAXMVU+Etn5
 Jn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141645; x=1789746445;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tAP4G/5H0Hyu01kOmdgc+EaLrKXNW6ITWSH6r5rO1zQ=;
 b=SCGX/fH9Gymqr431gcq43Qxbwmzs22IEa55yjRjoAvho1BHY6si3JM9OlHvLTXqD42
 AZ9vHonrHEnUTryur2AVmln7oadAyMhU+SOygMc5IPTU9xjOiUmNSIruuqacloMljhFV
 g7PNzhlNB7MtZSvDtRa2hrGUrtOlo14wyMg5FsnX1XI1+WS1GhvHC7GsPyL3xCcarc0D
 gpIXaTosuBi9586dZiWr6HTl4mMhdlOU0ncu+zZXxHo7TPsRD14n7jjnOWI3ZKEgZKLD
 ri4UqxjkAokDRfFyvWPBMGzq9UTW7gcLX9idYZ20p+2yrjAcxXvGPOn353YPoL7eFtBr
 O4WA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/E+n88sMUe5DdWtvp19PAfYkZCRmSvG/hGFzG+F2fFb4ouNuaAjCw4brb1F0Y2n2R5v4Dq9PydGQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lf4z9GMOMDGcJWXwBTEZQJf2P24//LT1Kr2VQKMRQsQYZ5p5vq
 yU0U5Dc/9UKPMAZfdTftp2yyOa+l+lqRkbH/0YnP/kWEg6GML7PDSSCSHfz6aDixtfgqrF8KExP
 qPASf+HT1B3bILlN/FRQ1DOfaHW2PHEZ4fXNRQ2L7u7qI585+ETgZLQSv9kfFZyVIPOY5aWA=
X-Gm-Gg: AYBFou3Sv8qxQZBIYmlgfgrXTwMlDb9n9KGz0fozm22NEvf6D1HaIH0lxQUhVSxIyb/
 JMSpXlU99a83k9naD2xHxF/AlDPZpfruS0Lh6shG8rTGHBECHBcSFM9IU4xsIerWHezcEeyLQpv
 yL/uZJSObIKyKsfRPqpHRogj5HmDWKp1TwZGGKkW4jCb+FGwYRB84oKV/rCrWtW9k9bUB9brX5O
 jqzoPwIHby8j2jZR1t7ZWeQRrZKttnpkaSm1+1v/f1tHOxghQBCrtkgJpN0pM06RGWyC+940Djx
 qIuBtAtXQDK89TEkspWFd4xL9HHiqdcXae6PPP5s9P+l9Zd2IIc/oKVT1U+fGfqidvh9+CmjmI/
 oUbEoDZoYbUag430+hBJ5Mg==
X-Received: by 2002:a05:620a:260f:b0:939:7e96:d296 with SMTP id
 af79cd13be357-939e9e707abmr563651685a.1.1789141645447; 
 Fri, 11 Sep 2026 08:47:25 -0700 (PDT)
X-Received: by 2002:a05:620a:260f:b0:939:7e96:d296 with SMTP id
 af79cd13be357-939e9e707abmr563647685a.1.1789141644963; 
 Fri, 11 Sep 2026 08:47:24 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b5912644sm984557a12.11.2026.09.11.08.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 08:47:24 -0700 (PDT)
Message-ID: <fa4c12eb-2b46-427d-bc47-a55e10e963c1@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX9/OT3ticNEbh
 8o+JL/fkyZu0GIlVvgvDwtNYPpNdubExt7S1Szar9qlgiGjiikHnwQo3jtLnJ9rRhuo4EMJwPCO
 1i22q6Ffw9BeUiTGR5sZBz9sH2tSdIcDYbdXhJxyIBWJ8OmNT7Iky4yqzqgJRZXCnefUgKMPSj7
 dd7pYetPuh60BiKHmdc3y+c6q8IO03w486WLgKammqWMr2avcDyWZqFiRRCUapneoBv41lNs6j8
 /YXtUzRv2bPHssEsLya13/Ggb6R2ZvSDWMcramfHU7BF4WlPbnvFgQE8i0HbCfEkjcovrmFlk6H
 +owA3ukbghk0aubqVbauaeIYmwJu+BXhtjlMFEmwUeF4C7ELIvHkGv2NvbYGshIVAbLWu4vNgFi
 3B0vU7ogy7xgaDM25ChcceCOrAp+iOUs8+FDhv5Sv0ln/bE4NwoO2/VleQnTHXMpBiTlcBwcau1
 F/IeACTwbst/RWgFrPA==
X-Proofpoint-GUID: Sex_mTem0Yb6j-AJeEkWZay5gfMdHe8F
X-Proofpoint-ORIG-GUID: Sex_mTem0Yb6j-AJeEkWZay5gfMdHe8F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX0OreDnuRo0Jv
 OLH6gkHt1cPSDYhbF3uxupmBt3hTyV3hsjV+DGnPSaUaiEj+Pcnqhai9wQPvCGIYjqz6Dnex3I9
 TLqNbQ9Bpzl/zrIxIrs1Kv5/PHAOy1I=
X-Authority-Analysis: v=2.4 cv=ULtIjyfy c=1 sm=1 tr=0 ts=6aa4228d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5N7f0bWkOQp0pCbeU4sA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110220
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

On 9/11/26 12:29 PM, Krzysztof Kozlowski wrote:
> If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
> it should reverse the state of things already changed.
> msm_hdmi_phy_resource_enable() is used also in probe path, thus such
> failure, which could be simple deferred probe, would leave these
> resources permanently enabled for the rest of the runtime.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
