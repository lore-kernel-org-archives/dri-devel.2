Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C48BC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 06:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8646210E795;
	Mon, 28 Sep 2026 06:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MwXyitkk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fStPA8Fa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454F710E795
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:03:29 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S4Sbrp2376652
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TfllPCpOYcD0Q0J40ZUWiBiA0eMH8gTidifWVXwZRKM=; b=MwXyitkkxn0o88VW
 l9uaPIO/lY4hQjuEshUjTOfxwQkdFJNbJIC0x2nXV8IPoAATJPp+VfKXE/zzGZUq
 7AxOj80knHjC2avsCthYU1qqiucB8vcecCMW8FTfVZPvqrVtD2iTPnvPG+TZmnKz
 OA4LQ38+62mzKc1gkv6N5ot1OWCQUX1AGVvGbSNXdMTBqiBH6SIw9/EapQtuzpjC
 tpYcvEvzYJupGnDV+Kro/VYrNwrYGwr2Plc0/uKe3+V/wEIVJ2w4ZP9tGBWV4ang
 +l6dk1hIOOc1RBADy/vhUFthXpbi6SCtw647X+H+yFZI0nVr+ioHqSZn4D580mPZ
 SoAkoQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp51bk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:03:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53124d6a362so85398921cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 23:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790575407; x=1791180207;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TfllPCpOYcD0Q0J40ZUWiBiA0eMH8gTidifWVXwZRKM=;
 b=fStPA8FamYafQckzi4fGy5J3vNuW5mozDE1Eg3wyC1A0sTLadh884hRoW+mWSkkIzC
 GGPrU4hqVDSFoAURSnSEotUxllNetfPgTbPpieTtktWu7NIoJJbBoOkuYePlZsGpvJ6m
 up8GUzvk21eLY1rpj8yIj8adwvAFHTkRon+Jx1r4MZRc1vGUGJj+ocEguZL8QC6Lgx7h
 cuVS1PHg0SsAWBJ456gbT+F/1Cm+Y4RtE7dMmkTDgOvSCIM9gVXssKNYMtsupncNsm1/
 0lN6KI4XCVOajoEXFv0/d76YuZ5JwFFPDknVjzALFLZFf+kebDw0IxMuRBuUt2rlA52g
 /aJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790575407; x=1791180207;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TfllPCpOYcD0Q0J40ZUWiBiA0eMH8gTidifWVXwZRKM=;
 b=oUa18Jm/L0oiuBEEYo8Ghn2QnrRFwD4TUEWi52IdZdHhCQQR+gsanJApZt/MI/gEyM
 8f2ci22APpjtnoeo/BkjYyxTTq/LKb//UlvL52E45zIncGHT7vJJ2dKL3U9rYoJkpW9H
 uenPFslkdZAIYV0ooS+MppR4GtvKGlRI6e8x1NqsC+5XbOGHTbr/IEDtPF+SJHfsYshB
 uon9VGOrP8ZfBtsogG7tyJXCzNLrV/xiGIJr8+ahSPojkyiIpFSOw/kpN0B4Y2A/BuwJ
 EaOHAJq2KvI+XeU4xM9f/npSdIlj3PMpn9AjskUqE+/xs1dy3fUhUa1oPGvg89qwZLwD
 D1Hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzK1qVK6jAdY6FwvSsoYQz9Kfj0DhffbQh6O4JBpgWz8Mg3ROLZr5RrvnrQfqLRZxDsPuwvy+ojiyk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k41mYohtIqgqIcf9wPB1TNS4a5145vSTUaV/BBNQs4S86zPjFF
 CVZI6FqjOmaPQMEjj0vVuaZxkRnbH2VFSgct5a/iXIfuUhE2RRePI8tkIH4Q0QC7JBb2T3WRuaK
 NMJxqi4IP3ybGcUwMgV04IzUNnpM/ZKhwTjfSWGTssaD4ZtNE4kYyrMo2WSqIXn8iQs0lPwM=
X-Gm-Gg: AYBFou3eLHfp+suKvQ4VVUj/NqorJgHEeVCCCBpp10pwGxszsC0Z2dvvL82/4mv/QAr
 HdBx7vkRF7IZJ+Be69N7qXAnNtaTfLDRQUsZQUWW44vsrKk7Uvfe8eIY4RdA/tIXFMmAipodtcH
 UjK4FxasdvvlZ5AiYu++YuGq2LMYCvWvjRT2/fJdSLJQKb0kKFgbLQJOBAwhWkRHLRjGRGjeoBg
 LCBqzfOXkugRcqjQHhVcxcJ5V6ROE8xa8wbr5/dIXtBtu2k80tA+4XZUAlEr7KnRe2qIzBneI41
 hB/+bmZywOkX+urqGUfSBzSxiNqfsrTL9A92dwtDVYFGE33Whrl4IAYDCT9SW3yd/QOPLATdLuV
 m9kT9rLjdaSuf+hnVA0Xtp1wENzq5
X-Received: by 2002:a05:622a:580a:b0:530:8853:1be5 with SMTP id
 d75a77b69052e-5330dbe7652mr183346571cf.10.1790575407327; 
 Sun, 27 Sep 2026 23:03:27 -0700 (PDT)
X-Received: by 2002:a05:622a:580a:b0:530:8853:1be5 with SMTP id
 d75a77b69052e-5330dbe7652mr183345631cf.10.1790575406762; 
 Sun, 27 Sep 2026 23:03:26 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm113080805e9.9.2026.09.27.23.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 23:03:24 -0700 (PDT)
Message-ID: <8499ed1a-df9e-4e5a-b609-3da8499a47b5@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 08:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 1/2] dt-bindings: display: Use consistent
 indentation in the example
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Liu Ying <victor.liu@nxp.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Francesco Dolcini
 <francesco@dolcini.it>, Philipp Zabel <p.zabel@pengutronix.de>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Simha BN <simhavcs@gmail.com>,
 CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>, Abel Vesa
 <abelvesa@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com
References: <20260913123331.100293-3-krzysztof.kozlowski@oss.qualcomm.com>
 <179057359762.92994.13773102514654073802.b4-ty@b4>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <179057359762.92994.13773102514654073802.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMyBTYWx0ZWRfX36MQbdwKYtPW
 Cos3w5H4m744a/0D+a6jO+639wTwoILyDmatz3SSAYnH5EIGE6J3hxBtnSFOdgHwJGsXNLHy9e7
 eQgLm5POoBdCij6HS05XVviMT7Krk9FUT20jr4A1FSMytoNGOIjijlNPTPkifiBtKR3qN6Bdsgs
 /1CkTMGFBEzmS3OWTD67THLQCMFHhdA7WKDfiqJyzuJtZQbmDOrcUum5nGJVtPrbF0V9IRxJu3Q
 xggeranFKdl8xxVYmT4hSOjM1lGaMSPlNvbBJu/69bSsnAaq6M6KdkuMxFpPY47e5z6m6fQj7X3
 xeP8yDH0zDAmSkVPF/+0mFhkCEYqXiOn4TY/iJVJZncTOBzfWnpT0zrezgRDMGPOmFW0K0s9G1X
 XwrFlY9NlVpby0iW9xkfD62fNP05SLc1UahGVwNdCjePnwqsyMDCkU3C9tQxXmFm0gYGsD+PQRK
 TpY3RWar/SVwFeNLF8g==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6aba0330 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=chZs0_0Ys9iI7aL1xjgA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: bNFL7XRpWb_esLOuqPUd57XWKJqXs_gn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMyBTYWx0ZWRfX2EcRsBJ9GeMF
 E9htPXlYyrfa87RXQ8jnO4TmD3rHajWoNjJ/u97NVSo3BGVm2y57JyokdD+jOIkGiVXccBmbiZl
 q3P9rM+sunK2CeqzoPDyRfBF0GxgHrc=
X-Proofpoint-ORIG-GUID: bNFL7XRpWb_esLOuqPUd57XWKJqXs_gn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280023
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

On 28/09/2026 07:33, Luca Ceresoli wrote:
> 
> On Sun, 13 Sep 2026 14:33:32 +0200, Krzysztof Kozlowski wrote:
>> Correct indentation in the examples to consistent 2- or 4-spaces
>> indentation to fix dt-check-style warnings ("example 0
>> [indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
>> re-indenting entire example just for that is too much churn.
> 
> Applied, thanks!
> 
> [1/2] dt-bindings: display: Use consistent indentation in the example
>       commit: 370c5d9004f8b754351981d59fc26851bf943e93

Thanks, but I expected no one will pick it up, so I asked Rob to take
it, thus it is already queued.

Best regards,
Krzysztof
