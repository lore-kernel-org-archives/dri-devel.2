Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23080CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2885B112233;
	Thu, 15 Oct 2026 09:15:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39489112233
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:15:15 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F77f602121309
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mbz1I+0D7v4YlTuSxVHwUi2rWWEi2PQQC6WAIH4knOY=; b=azbW2syaIxiAklhX
 1zIMGP1og2e4iIi9ZHhc/SANhUraFuOr+/DGkSZWHbqw4LDmzlIxtiCbn/myzXNE
 Mom5KNaGtL2X2o/go7Lrvgp0g5WCf1wRU7ZyWkSwHwdU7BRv/B5NvgaAZJpjygav
 XaOdj+OUU1WD873tYIT/RfH13BFNfdwHuiGF9xmzJlx3GFqfrd6r1xBrIJOgFAQ6
 pD9CtFp7+OYdltJp/tR6hsxrOTnzvCiC3jBVd3yr0PHyz76iURhXVed63SB+9C68
 LuAm+6Zt6ZZ/qn76rPwrvVQm+Q3lMLonpHqTjcLaiqi7yAZR4FZHtxUIuxmpYMX8
 4gV/EQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn1xkw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:15:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9179ef12a03so17140916d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792055713; x=1792660513;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mbz1I+0D7v4YlTuSxVHwUi2rWWEi2PQQC6WAIH4knOY=;
 b=EmjhVKBYXcxpU2N1gKPkQUoB8iU0ijDpIx6jhk6rMqwPxhpgR+v86gT+hUcaPRmmBC
 Kx+t12pmk9fWm1DylXXJU944unBo+WX+myAQQeF6FPEnOHLiaAA5wlHaxPqREsaq+bpe
 ObvfZIKL/+rCLgAytJEB66JKeTpFx6GNAd1hly9k7x1t5URUNfz7e9mOYJS0KZTrGu+k
 iGsyCIUHDSrrXkYwHiDIGpfMk7vu2nY3AhGb6yI3rA9prOkrsW8tC4/Gg6hv05PpmyI2
 rCw0fAoC+Nk7IxwcSJcHeTe1zM1S4Bstx/emJ8YV1fobGYMtGM1Dul6Yj8ZvhLWoaZMo
 imTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792055713; x=1792660513;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mbz1I+0D7v4YlTuSxVHwUi2rWWEi2PQQC6WAIH4knOY=;
 b=W3JYSh6K95ZRBCqOtHPiICCLIZpzlDVRBNLt4Dp+PWVEuCZt1BvQlZVLocHXncfdAF
 9paJwHxN/PLuXQ9BSxUvRLUpRP+bRMo0xx2LwlFSpO8vSc+b5RaDWU5TF2w2tCxpRm/E
 Zyb2gjm5tUIWVGZrl1y6xeYkZJ76OBO20AjJ39gFPRY44QQHx0MzWFx2J1JBt310ZxVh
 Q4onE4M0SVhmvh5/W4g8+UdEuYgGwg3Urj784iVv+WYC9XLSxLcSODaBIVUhr1uoJArs
 v3RaP6XmZRFcYQbuT0NnVVnm+57K77PkT0q0C3h0URvGyuwh+nVW2UpxCZSy2gf4q/FE
 cVmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKyar66gevaSsJdAK3j5G8aDbOScwWaEZG7LzRaCsPN92MfDsO5s44BLB4ZfmNg2sejp2s2yih8hA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKYNbch38kaUptiEnyHQKdhHJsnwM+sOOv1bRhdQRyR2eIBeNuK
 JVHSbM+Nic0Ysyk0auZBb0WJjdQ5anWgC0DFX0F6StehhftfmPPSj/W58aXwm/TIw4VJ75HwEjl
 /uZ6kerez0qCgpOqlTPqGNQHW7ZG08OhPabvBdbMBZBVzggL9lraK1x/RG10jWu72ePK08mo=
X-Gm-Gg: AYBFou21kqG0lecf1ZVmyni+QZ/jNCLwCySxEji5/iOPDBitKJNCX2QwrYnq45rutla
 rjd/Jmg66ECj0rcldTalFFm2cpvfr3LqTtvp6gzLMLp5b8MlI3zCc0QMKxJqwA5w3swdsxuSQKx
 x2ynwTAJ2hYlNMOevCltHCxzIRdFrFKgGNQLi6TYQkf8i4H9F5FpqXuOwOop74Z3DCRKZoNE0C1
 +VAR+J/1ihqotaSGpI0J2MLUwAhbrKOSZlWUgN/KjWEltP6j4Gt+b4Vcae+Ua8N07opXtlTDSCH
 fUzsLssYCLTbaV2YcD42EX9a84jZdBVbl067wm+lvh36wpgv9oLtQUyHMD+fY3JFowSk2U+0zsA
 q99YXq9uWXqRxLxbvmliKfQ==
X-Received: by 2002:a05:620a:4449:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-93ebd27cc8fmr3410265385a.6.1792055713563; 
 Thu, 15 Oct 2026 02:15:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4449:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-93ebd27cc8fmr3410260685a.6.1792055713032; 
 Thu, 15 Oct 2026 02:15:13 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3ed6be6f15sm101465966b.10.2026.10.15.02.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 02:15:11 -0700 (PDT)
Message-ID: <0e456ae9-7286-4c4f-b56b-9bbaf4076732@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:15:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] arm64: dts: qcom: sm8150: add MDSS reset
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
 <20261015-sm8150-display-card-v1-7-5c14928cef29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-7-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfXyAkkzDiRnJro
 LHHxFkoTITl2SMAlllVqyXzbM/jNGykspnWP1ivGZ7eFDhGfGhzvsbByNTfdAOm90sgQGhW3hup
 KSjdDP44Wwd/WyxUxZUWtIg8Tx6syH6Zg1rWxJUjLx0B13Hua0nx5QcGfzHyvXbGqmLdt4IiKai
 d5R30CJsPHxXzbkcUk6ZChuw/+xEBH/8fZ9f2Dm4eN7WrypGJYOsV+VDOJvWhvEnN/mHU11H4vz
 3LTQHe/wkcnEEVh5t9PKYAfCz1bVnlzMY0rnIV0V9lBgwcFG08lRZlqtT4e6IoR5l7kS02GOBj7
 swNS8Z5WiChaggavH9PNAQqnN/q/rKfaH6/MMwHkPHDYHAR6uZO3GGezJHOPXeNaavqn+2LrdPY
 z4iq8/Vgv9OjKnyZXY3Chfh8nLB2LYe4csFbShnKGmWzNnQtn1dhJLc0NAB+M8dX6iHnh6bDced
 PvJCeGcA6urnOikroAA==
X-Proofpoint-GUID: fOGfvh0z71YiAsLe3tXIqdV-bpf9uL_T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfXzg+bwAi12lXf
 h118/g7cEohtk8k5zXFzSRX+BI44XWeBSuXrHhr3mspzsSNUQ1vQAZ+P8YNehEz7eJVQBd4U66p
 47xwXeAnAq/sigiW/1yifEZSlwirhkA=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad099a2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Jhhi1Yo89JosEC0CkA0A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: fOGfvh0z71YiAsLe3tXIqdV-bpf9uL_T
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
> The bootloader can leave the display running, as it does on the SM8150
> HDK with the display card attached. Describe the MDSS reset so that the
> driver can bring the hardware into a known state before using it.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 293fcbacff34..a2d6e6947c4c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3817,6 +3817,7 @@ mdss: display-subsystem@ae00000 {
>  
>  			iommus = <&apps_smmu 0x800 0x420>;
>  
> +			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;

please put it under clocks like in other DTs

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
