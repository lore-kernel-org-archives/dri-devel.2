Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664EDC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C385E10E7EE;
	Mon, 28 Sep 2026 08:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SKDSW8Y5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WlgNljOa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF7D10E7DB
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:08:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S803iP1872252
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oM81pKyayfK2X8YKDVXwTbFLMrukiJVnnCmewayJBqA=; b=SKDSW8Y5QhLznaQ1
 yzxkud/7TYJOhk6dx/p3qyA8tC7kxFki3tE+Nd56wjxF+b9iJASw0vjxii6TezBT
 ZMdgxRrVQ2HKFKydfWaRhBoF1GZenEMTC9ZAlW7V7JbrI6fP8P5Zye3NyIqA3FnL
 bZR5CJzL4DXRwrnLCl+DzAJSwTuaS9FLvO/Sz22RXBSSG5drpv8iuVkBtm4eQsJG
 dpY7YaSJfuQDnR8mcWdZIemD2SZhPnkbHriD1NzKmc8auOlu68yM325Jq+Uh3j4G
 /z3D6lwBxyFHr4YBKSDVwA3Y/J+s3jJDWavHdfwb3amjUN9uEsX5VHOL68NyDm0u
 n08ytQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubgjgx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:08:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5c205127so274447185a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 01:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790582936; x=1791187736;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oM81pKyayfK2X8YKDVXwTbFLMrukiJVnnCmewayJBqA=;
 b=WlgNljOahwEmISaIFslcilVT5KDOcxZhF1I3rpHBrQPCNGFlzcDA0zWN1XVG9gK6ms
 C44Wrfvq1mgcqKGdTEAIhbjj/CACI1w1tRUB30Jv2g56OVUZBYrinADrGCatamzirRB3
 R2dpUbsSEl5SrE6Lm+TFOzWBOCYUaHGgGHwe3V5TLCqRmEWxxlVCq/hwvdl+Ygo6ItXl
 9chzTcQjNNYoeldoI0Yni8IXot7DI9oJXr8SJC4XusLafT1v5t1XNh0ZtY5v87oHUbbD
 kiba15o+Q+EhslNo2mv+Q+zkFdY3HZKLt0xFcQGS28TRENHYH0IFS0MI+PXL67vVunQZ
 n3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790582936; x=1791187736;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oM81pKyayfK2X8YKDVXwTbFLMrukiJVnnCmewayJBqA=;
 b=pURBrPscmBFcuI3bPfMdpc+cU6+3io9ALOF3PBcsqMZ/b9wHoT+QwcyHCIdqBDWnu0
 uibuoGOwfRQune94PCYWma0Y1ElExUrh36fvc7OEuteMJZJ48kSZsAOhCYEuv4W5ldca
 x1BcczHnnX0mecvrQ3oWsrxpyaLy7P4YG6Xx2MduLgXymG3bLx4cj95pHrH8CaAEzQU8
 S7bPacDoQprmcMSIkSyWQseWaaJ1IJ72O30H4FVPYomYMAfr8C5E+EgLbiL/VUr40u4h
 Gxkf/xxszylie0RaLLldyXa5yDsWUZ0vbexpc+S3z0Fmrx2lp9JebpYVhVSPfyb++DdM
 Pxrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx36GE2gmeqLQwyz8SzRPktUpl2VA1e7eYhW3l+twoVUWeZoQeiIiNYVGvEv7LQZ9Wi4eG5r48N0XM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ntMfoN8HgN/kHSoUvHuKY2psqNjZhW+GvkGW0fea6bLsixDb2b
 sTvDXGQVuyKSGsAp4Tutj37CKq+rvlxK4oWWKsKWl6c6x7EcgfIF8Sq81HEa11nc3XOH6gkjNdo
 poHh86j5MkXqWev/iMLO0fn1dfG8Y9gJuK/UpXz2F/JcGqv+mziYGQX1AcrCUq4ClHH/abAw=
X-Gm-Gg: AYBFou0HanB28Tk3NIrCN1zK73iaRWlnrdEFIt2MPE/wsjF5vFgThzF2+BTmCUCtYjW
 AUYZ6KVXYPSTc8m4IgOzTZp5ePzXh+1jZFNOZfTYxsxvCY3k4DWya89syTk/Om0+C7ImmCi8ygs
 zi0hiWgLz7vSuTfmmKrTZBBj1TDCecJLPydmIPAshf29GzoG5pyYBw5dB1juIk8QpTPfbdNqLTl
 gZG3fMwT/nmrPPz7E4wWqnkLS15zP7niGRrpZ4OH1IrdvqhpQ5pllnyrBvsS40tXKcPQCsGx8p/
 P+qBb1+2RvdasKid49LPfOBHaw1F396CZXMMoK2OK2dXbO7bvHm81/zKJI8XZ6LJBd/wyWh2ZHo
 H15H0CiyQ6VftoXqNm3HUc3KrgQm0
X-Received: by 2002:a05:620a:4150:b0:939:a003:7127 with SMTP id
 af79cd13be357-93c43d15a2dmr1823459785a.52.1790582936325; 
 Mon, 28 Sep 2026 01:08:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4150:b0:939:a003:7127 with SMTP id
 af79cd13be357-93c43d15a2dmr1823452285a.52.1790582935772; 
 Mon, 28 Sep 2026 01:08:55 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349731sm26045947f8f.12.2026.09.28.01.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 01:08:53 -0700 (PDT)
Message-ID: <ccb949ea-5fa9-47e5-be75-af8155328dc8@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 10:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 1/2] dt-bindings: display: Use consistent
 indentation in the example
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Liu Ying <victor.liu@nxp.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
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
 <8499ed1a-df9e-4e5a-b609-3da8499a47b5@oss.qualcomm.com>
 <20260928065837.GA22609@killaraus.ideasonboard.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260928065837.GA22609@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YfCv_HGSNsKoEw3QyGmGZ5DzZbivCgBm
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba2099 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=3sPRIKSABCI_lCAVw8wA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: YfCv_HGSNsKoEw3QyGmGZ5DzZbivCgBm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzMiBTYWx0ZWRfX680vFFXEZtIW
 LOJ7QH7MSuDG0BLAJyYr+/ChzZvcM1Oi/RiId0M4x2y/U0RGB7bG+721CFgw0+bFRUbzf8kaddA
 C+fXR2iaIRQeGCrFEewT1q5PeDwuAKC3X60bAt9AZtwTCPFstqK//Qh8ytvxisJ6jEPtWw4Tbt/
 A0eudhy5FiyyvkRXSwx/S6FiOZdwbHpZKIVTi6q33I/cIPdwehg+2QOiaCF5fRb1RwXEdHjjyPg
 w+SfpEOVnOi6mKTg3WCcaOP8MILsg4kaDQnktsaUn5MQNapCA3O86ByUr1AxJe/QhPrYsNAa4fh
 aKhIixHVyDTRubiwWISisFpUKsftk1l+gfGdSQbpUyX4Qkj+3a1dzCra0oCg9Ip7X5k0NnW8Toi
 RU+ITFLss6zKFJsZAr29FfEhq06R9tn2FNjz9OypBNxT7AhrUQVak6WyD/CGZvIJIPKLC6xBOy+
 UY4+8YxAakKKGjXwlSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzMiBTYWx0ZWRfX/xHQ8xXxb8RX
 ztXkGyKUi0F+nUu1X4EJ/HNAAHBWVGPj3430idMSNf3Qh+l3gH0lozKw6Dm0BTuH7OPue4Xb/Bv
 uAuQidUrHuXCLDbiow1hfnJqRkPk9ow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280032
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

On 28/09/2026 08:58, Laurent Pinchart wrote:
> On Mon, Sep 28, 2026 at 08:03:18AM +0200, Krzysztof Kozlowski wrote:
>> On 28/09/2026 07:33, Luca Ceresoli wrote:
>>> On Sun, 13 Sep 2026 14:33:32 +0200, Krzysztof Kozlowski wrote:
>>>> Correct indentation in the examples to consistent 2- or 4-spaces
>>>> indentation to fix dt-check-style warnings ("example 0
>>>> [indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
>>>> re-indenting entire example just for that is too much churn.
>>>
>>> Applied, thanks!
>>>
>>> [1/2] dt-bindings: display: Use consistent indentation in the example
>>>       commit: 370c5d9004f8b754351981d59fc26851bf943e93
>>
>> Thanks, but I expected no one will pick it up, so I asked Rob to take
>> it, thus it is already queued.
> 
> Please explain your merge plans in the cover letter next time.

The merge plan was this going through drm-misc. It got reviews, no one
applied, even Dmitry for msm only reviewed the msm-bits (second patch),
so I asked Rob to take it. This was not planned, but result of usual
drm-misc inactivity for bindings (many bindings were not taken in the
past or with noticeable delay/pings).

Best regards,
Krzysztof
