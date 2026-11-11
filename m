Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D4606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HkRp8tNl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sj2t9yg+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB32E10EB04;
	Wed, 11 Nov 2026 18:08:41 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F6D10EB04
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:08:30 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHt9LJ2705458
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Mek+GhpJgbAlj6PFKAaMZa1L
 4pkrsPGjFMnbflusKoU=; b=HkRp8tNlH/IHx4K+SnRTdTHTNZmewDVb125mi4ug
 0PNYhPRbnIzlTF9dttHZ2bv7GvVrhlYbAU6zCArXK71VDab/lX8OkmFNzgq10Hs2
 TqRgCFQnVPisJDEHHu1wLnwuDBZIXnfB3zRlmeFTKOkb/y0l/AVKVoOBA1bNDOl/
 AGns92zlCbYMecR8cQpSHf9FXLmGLBOS+D1bJoS2rkeRN6k7ViMmep8m1i8vhG3z
 +t4IyK+O5SlJEiJ6fg3U2Tq9Vg+oprgYeIyXycLOUxvJJFyD7i1EsFxc/gCI4pqA
 JGKB5lDNX5acXmPJg/bu2SE9u/jFTagrp7HxN3070qH0qA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvvw0g4vv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:08:28 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-998a2b06e4eso742945241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794420508; x=1795025308;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mek+GhpJgbAlj6PFKAaMZa1L4pkrsPGjFMnbflusKoU=;
 b=Sj2t9yg++r/lXhuxl/6vs4SwBM114XZl73nQ46j7iUwwh4Equ3ErCJi50YxyYOPpsK
 Ftr428lkTZbaIqDGgpQirLf666xZM/dQarJa4X2XNZ/y4L4XrZyBUblPLsNVnVKw5rid
 tAcllfuEk8n8Er9M/FuTPn5LxBABJbuZ4TOcxAHmfFkLGEsK7t/rkR5JaVeFYSOLLJjZ
 z084p9pyqpMzMAmWCb2CSvrb6iO5ayetuRvpEurD2gFEuzoM/k60ZlY4+d1t2Iu4ixNi
 XAqyK+oAdBGcH02Lv1guW1JrZSdp0g7jAOccIt2J/UCb3b9ga/alfe7I7Gfy3Pw2/Rwq
 1tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794420508; x=1795025308;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mek+GhpJgbAlj6PFKAaMZa1L4pkrsPGjFMnbflusKoU=;
 b=0FFzr2ckgpwQ8lOII2gRMqP5VCzzIm3+3prsiZX8si0r0XBKAma2IjXmGGsICA5W7j
 JWOPH8CGzV7LJyG777JogufYvHuYxio/r9idvJmmC7G1qk8cDJmHwSEIQ4dL2TVBTPVt
 +P2Umr8OCmVMeAeCrihK3yNnKb4Ji1QLuQcU5Eg9cabxt5HXsvGl790+BHWOj6pCjNYJ
 xS+4gDM7PYIW6jIkZm0AKKvw62+evjn79SoKxP2b7K127EYimeAHvi3+xezDqTKavXvc
 4ZalW2tqtahfwKEstInfS+zWwZXYJZsTGCXAToBWi5LkL8z7ztu+FMJx9wlQv5qs1ul8
 lZeA==
X-Forwarded-Encrypted: i=1;
 AL+hErHgpkzxFxEMEnSuVcrSglC3mVp6FVUGDCiYkRep9l9Ez7KRM4txEwX3pddpHylnRgWM1K9GsplwOVg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8a/hk1nJdJuNgT9+u9ncFeiEXW1i4H0uy7oPabZoBDk0uMQQql
 NAWip8ec3Gip5LGHSluaiDKD3HiqqZZQaOzYFqfbQsfIaFwtA75N1MuII29u6je2FQOkYIUC9h3
 tfmIwoe8id5jvvhHcQtmRaTAAzBgnwbwSI+F+UV0mzmNU/fRzVdZcA2I5+PuRRY+XOw+iWpFYDO
 +DNUk=
X-Gm-Gg: AYBFou2q5nI2cnSu8WU4RXC3ue4wbE2VkhaKAa2pn7YLugnXvz85ZDDW9o5+q2J92lk
 TUTZ2LTYII1hTYhpYsdhBVNGKlXW4op/Fgzw6Li5dB8BkUZDuNpJocoFGfwdDuvFdKR3nT42vEf
 syVTOof6HUn96gu89YE9uXmyT/XvO5f/EvP0Bk8tRmnvdW4lrVnAJ1xJ2J320JonA9iqUashTRj
 AffrPE5BrgGCW5JhKtkzCxVI46BAtvITTSIvhYpknVyy0AQHexvzNL6kfhD+eY2OFs7ZWJIBsbJ
 lSFyjHEpYzFnZgoh2GLiBB9u4e6xv3blVuEZcgIlBPl0PUv5gRrHBrxSd+iwdOsAd50v1A9gjs1
 DGp9IjPqlvtg1OjOEb5QzmyF0qBm9mByRR3hj7/qOzWLRTkewNI0kKK46xFzapd29QhXiUdXSNP
 gCb/KKMmI1+P9+khJ7x1a+MQ/+DY7CKK+D0y9ZSOhq/0I32Mds26xE7Rn+I83T0Q==
X-Received: by 2002:a05:6102:334c:b0:7a7:19aa:f0d8 with SMTP id
 ada2fe7eead31-7d50615aa99mr1096417137.37.1794420508180; 
 Wed, 11 Nov 2026 10:08:28 -0800 (PST)
X-Received: by 2002:a05:6102:334c:b0:7a7:19aa:f0d8 with SMTP id
 ada2fe7eead31-7d50615aa99mr1096382137.37.1794420507572; 
 Wed, 11 Nov 2026 10:08:27 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae09224efdsm13131431fa.14.2026.11.11.10.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 10:08:26 -0800 (PST)
Date: Wed, 11 Nov 2026 20:08:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>,
 Richard Acayan <mailingradian@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Robert Foss <rfoss@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: msm8996-oneplus: Disable
 disconnected DSI
Message-ID: <qobhsifyot6ahopugvgsmtzvd3oby43vg3yhjxjf5r72zdohhz@4r4et7fookge>
References: <20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com>
 <20261110-display-msm-of-graph-v1-2-0f3106f817b4@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-display-msm-of-graph-v1-2-0f3106f817b4@oss.qualcomm.com>
X-Proofpoint-GUID: ycN6yPlMu0BtFuUjQIJosUO9Dy3XMwl_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX/xIuU2r+beLv
 VH8QMzaTuWpIJ23a1cXMmc0i/vSo6ain5fb+pdSEp2gXhFx+vkO3/rSrxww+SPwJ4GtqbLz87DB
 QbOjVdoOSPnkiLVOw1ZUGwKldo23YWpPPm8fbzFxexwe0KI47A77cNqGiHEe8/VcpA0hzTLvojH
 XbUqvarqnAN3B6s4uunazZcCD5TtKTxDDhFOshbBkTQVZvClFl1i6FQ1d6vp+36mod7eW16R5Xp
 0ArJ2U79scrHmIuq4FtAomKnvOUiLHr6cHOXHQpDgS0SKtgadn8CXK972J8mNNwElFYWg6VXSgY
 owSrl0s8Unuzpmk0VPYWm8Az3Sc8+XUv/ZcsnM99p42oXHxl0P5KyOjKjjr3oJB1CgNnG1Ia52T
 ISwWWFJ0gRHoB3ifLa2OEi36lOq3nwnj2tFI4M/voz5Ppey5NJub4sFWIlhRgCvtUy0dKWjWGup
 I+rPfDgOm8U67VejGbQ==
X-Proofpoint-ORIG-GUID: ycN6yPlMu0BtFuUjQIJosUO9Dy3XMwl_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX54O1ZM3uHEq8
 bWLir8tKe0uKU9DKLsfVx/pUCC5iRRaGE/CkVV3KfvJHlPJwW4y/ksH87isAhUCPdEYGsI5fZt0
 JddoeKvHBKIC4VDUcqt8Dg8ACtt7zMQ=
X-Authority-Analysis: v=2.4 cv=ct8OAF4i c=1 sm=1 tr=0 ts=6af4af1c cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=udFPpGrmtiWedX3Zxo8A:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110072
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 01:57:43PM +0100, Krzysztof Kozlowski wrote:
> MDSS DSI and DSI PHY is useless, when nothing is attached (no panel
> description in DTS), thus should be disabled in DTS.  Linux MSM DRM
> drivers will also fail the probe.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
