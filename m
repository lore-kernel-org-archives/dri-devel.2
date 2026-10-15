Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774E1CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A972211223B;
	Thu, 15 Oct 2026 09:14:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0919111223B
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:14:40 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F6u0lk2121439
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G8kOE3ZIjhCz0Hl/N8eiEpRWdz6o88GEXiYS++yU+cU=; b=aoFaPHI54vkSpmpD
 a1Y6KPj5BeUeWY3unHT9VmZYPKV11uJlgoWgamUUQ1lCJg46kSfwkeL5kl74rFkE
 6B2wn/JhQdtGHCJUCeBAls0cFWaYnbvG/ar5Sqya+D88iCtKtAtOEKZLkI47WpwU
 9lMtlwBPzPp3YvBEy50OQ1xqScyFM/wVEqaPrukX6XfH2efEArOL83M7/CZY7Acu
 zG7LpGcQw6+UWQpbQ6pgPf+is/sStmsOo0Moo8JlLqAJWdxaBZL26Y0Yy5YH1yzf
 aKNvxikL30E4J8jBFTi37uRNToib/G0k5cCVa06LFP3Fxuew8qgSSNeJjNGx5n/B
 jsiQqA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn1xh3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:14:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5338d5d0509so11031521cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792055679; x=1792660479;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G8kOE3ZIjhCz0Hl/N8eiEpRWdz6o88GEXiYS++yU+cU=;
 b=IIOI37KDIV5epKaKoPbxJK1F998DxjhomPGJsPSojef3rYA6MEsvep6XK50m9sNFT9
 uRf6xR3hRE5+WBZlCTUhYFpHpADXWMKgpFx8biVoOjnRP5bt33TqfZ1fH3++gewCl0Nz
 WFESO2egGXSjNorhmUIW4oLicajELFuwGw46f9Mb5Nx75kdxsVAI7BdS1hbmMGJEvFuS
 3uWBSfyHiDkJIsZOgHPua/YdDzDMwRPZ2kzmyKjRxDY0qUi6zw1WFkbIpwz3t9+TCxFl
 lXjv/jv4JMys81CoU+5KETw0f8KgQv354fYdqy/8CBHwziAeZxoKjA06RafG7k3td4FT
 hAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792055679; x=1792660479;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G8kOE3ZIjhCz0Hl/N8eiEpRWdz6o88GEXiYS++yU+cU=;
 b=ulDgp5eMBAHz2a4WAGiDdy1fpEpXDhpmh9YtJ+8Yw1yuwXyUgCXRiJbA3nIET4AHyC
 ZG9LdKHdMVnMH6h41UvBc72WcHaQT6h9zuB/r+PTY+Q+3gddNCupzi/TEp77R4VENA0i
 n5XZk4an1xmownZrGHXUMrEtA0Jo/iJPvSwKpHfWCerr6Fn4Q4CKSaKNkE4y3DsFjSHz
 URCil0WNWSi6jyQj03qbDsKyJtKdW2rQXYlduUE8CgxNrh6H7QE3oR+FB/apeqMUNX1h
 TaDQDnqHCbamjoiPTh6J43ZULYsC/lL55YuPowmMZPK6wi6rLDHZaHGesKqyUmeOocBU
 nVXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxHuq3CdI3X1xISKUovVfI1PFteYQdQ0y4SS8ymJ4S+TnZjb7yPyovH+F9+Hwp4b0BLvjMseNKu6E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYILvjyLMGvGUhwRQpTuUjp1WrEcAd5pZfp8BS9HNY6DiUqUOyFY
 pB48/B+GPThKUGr0T/xmah2i1tQ79mKQ3SBfd/d19bFwvFqntL6f3IMU6udAhwh0zqamZQv8a1b
 I38coFcUC0t8xmI1K5uZhCP5ofrF4mtlTV+1NDWLBgV4aPO8JH074DiIfKIMu8DnAWt0PMK0=
X-Gm-Gg: AYBFou2sUlF1ViszY7EmGi4FCPhI/PBlzTsc9LueyO4S76dbI/D/1KhAbuHqlrlwHYX
 m+Dy/1xoHjonjQKiAjG2Uj/uu3yYbDUfqfyFZM/as1MC9dS60qubIdMkWCzJaQilJ2E4qPK1Sv9
 eY2pguJ58svIP/MLdBK1TV+gQHvGqB88Pz3I190xnQ3CMEP3ZJOJaN/ELejGfzw8zuyObSDJPMM
 Ey5a/lPglUfQ1x3igqXw5m5BwacdFfwMZeFpfiKYUxRuFnXZ6/srLSApuv56nDdRLhkAbOJXg0G
 OWpaRKfX45oBrVpV/IVhLVw7U/k4uI+nySeNfrIZW4EhzES3KDGzIZzZSwz5ElXKorCB9c79ocQ
 mu4M3WFtLcsyOcxO2KNU1qQ==
X-Received: by 2002:a05:620a:27d6:b0:92e:6485:f640 with SMTP id
 af79cd13be357-93ebd224118mr3283603885a.4.1792055679468; 
 Thu, 15 Oct 2026 02:14:39 -0700 (PDT)
X-Received: by 2002:a05:620a:27d6:b0:92e:6485:f640 with SMTP id
 af79cd13be357-93ebd224118mr3283601285a.4.1792055678894; 
 Thu, 15 Oct 2026 02:14:38 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3edab11d7bsm101640266b.83.2026.10.15.02.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 02:14:37 -0700 (PDT)
Message-ID: <8c375f13-ecd2-4ceb-8bc8-949a90f971fc@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: regulator: add Qualcomm LCDB regulator
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-3-5c14928cef29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-3-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfXxBXmoC5iYXvC
 V/EazsoXGBXe2Z+WIuLIP0Vb+3bH5E12sQfVNI3E4NXwxq+hR05Mt8Mek8ki/Wva1zTEA6NNi5y
 h7l/jZQfpSgl9l7tdf8pCWT7BUuS05+f/GVyhAIz5FNo6cLVZSWHfWR7oRdyMeX1Oukb91L6+Fk
 /pgUAT8S1JTB+SB3FZe2oCPzEcRxmJWVdIelJYYAORzc4k8YS6gNUwgVcmF2971XiyOvj3zxck/
 Sfi0QDFFZog3NrVrapy9U5xGCIioMfcpenPv6UKx7XHOR5uk8Qk5kNyaT0mh4UJpGy4D9qwAQTH
 yqwoSJnyDpnq5i8ns8sza9+f+9al1b159C/VSMZlGRAjVdzopGQ1G3gIHOJOrBubwC1R7l+tbj6
 yd+uuBqIHDkUXLcc6xKBFuq7weZt9RUgBaD9aMWFbaNAJw3+gR/d8Q3mfLioHs5ZPydK8FNJ9mM
 KEk15ZLHbsYLjdlE+fA==
X-Proofpoint-GUID: kjLNHLWK94_i84yCpXpVy9-5VFkf1Amw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX+NoP+1xiThSp
 kV4MRf/iHXAykf2BLadb2X+W+G9C0lbLFb1KfFErb/j0qZ807R/DmScX7UXM57G3dXd+Xwvp352
 9354zCOxJRg6KQVFHnH7cD+3CYNoO+E=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad09980 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=OJYj8EsONSIZtexx7k8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: kjLNHLWK94_i84yCpXpVy9-5VFkf1Amw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150036
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

On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> Several Qualcomm PMICs have an LCDB block providing the positive and
> negative bias rails for LCD panels. It is not supported by Linux, so
> boards using it either model the rails as dummy fixed regulators and
> depend on the state left by the bootloader.
> 
> Describe the LCDB regulator present on the PM8150L. Use it as a fallback
> compatible for LCDB blocks on PMI632 and PM6150L. PM660L has a different
> version of LCDB block, so it's not being covered.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> +        lcdb@ec00 {
> +            compatible = "qcom,pm8150l-lcdb";
> +            reg = <0xec00>;
> +            interrupts = <0x5 0xec 0x1 IRQ_TYPE_EDGE_RISING>;
> +
> +            ldo {
> +                regulator-min-microvolt = <4000000>;
> +                regulator-max-microvolt = <6000000>;
> +            };
> +
> +            ncp {
> +                regulator-min-microvolt = <4000000>;
> +                regulator-max-microvolt = <6000000>;
> +            };

Let's tighten up the example to some specific voltage to reduce
room for poor copypastas

Konrad
