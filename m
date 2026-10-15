Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB19CC6B30
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9C41122BA;
	Thu, 15 Oct 2026 10:47:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9592D1122C4
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:47:26 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jT1U2809312
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 80/kA9beZNU0ILkYW4k6rBi5XEHbzEFFell3QuipJow=; b=iYS7XCkRNFlgvj81
 3oom2Lg7Wt/XoDNjXFjWoBMBVzK0aBw/0zLWP8q6zqGXh/Qzpg80VuaqvxzAuXWp
 vT0Ff3CQbtLzDcvsMYKk9ei6BrsuFDEka26R33RcBApWN4b+Y0GL5fgF5ElEYuOf
 LbgMAORUWIPzwln5m0U/Lg4ahQhTNdcoazYgmzmd8oJPOERt0W42lkz3hw8sWWGg
 zrNA2NprUL5eEbeekzK1ZeXzkmcTZa8k0sPTB4uagFtV+r0YkltrcqE4eWb6FTxE
 Gz93HEdtE+89fID0JY1UjXLvYNPHnby5OKa+wCJf+u278z1jJoKI2/FbkPfHUGhB
 LpzYBg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54t5bs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:47:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91782d0a163so11932706d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792061245; x=1792666045;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=80/kA9beZNU0ILkYW4k6rBi5XEHbzEFFell3QuipJow=;
 b=aRuN6T7PzDLrxaAJ98CaXQceMCSySuKXQPTR/nQFwUcSVLNm8btT0gYg9sl7bQd20U
 TUUipWwSUqSGJuDlxJpeTZvi+Cd2fk1mea2nRYQ427YQuTWcZwtJ+8vIPfLE6UM9nnma
 UE04q7FlCQTi6JUkf5/Ci8XA2jpR4QVpW9X4V0ysQB9wKNScYQ7yNB5BcC1oWyReJdt2
 kBk1VFRHslzSv8rGXUwS9z/GbLJF62ioLBrn7+3D0lRjmX1He5iaeYMMiavN89Uap8FB
 4+lW7Zj7G4+ZKggcahMhTVKMvSg5b14YGiB8eCJ2p1t+lFwIMutVvZ1ecunZiuz/zlR4
 sZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061245; x=1792666045;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=80/kA9beZNU0ILkYW4k6rBi5XEHbzEFFell3QuipJow=;
 b=eQAFzItyelhy3f5KQqmCPLgdTjRxVePYT3nspJSIjsmgHJazkP9v686HW9xKmUEbgQ
 Exb86qmjQlbxEBFadBw5jVPIxSJ7N0tcjEAmV1GU7e9iloRZrVragWYYwtXWsC+Vfd18
 d8+fp5DEQKdctL2JQXDVtaCjWaYwwNuk8FMrP4LPQuL92N/iQwqs3LOr0IIIQJOTgNHD
 +BKXpP0fOyP1hu8Wsmy28L9wlqdX31O0bPT1NY+0xMLJOytl+vOEEkaOfaChPqiy+D4Y
 ZEWh51632zuOCQ9dNRpyF9uO4YCrkeK4qnRq0rz6Teh/GeSmIVdPxp25EPP8UTmiPDVe
 KPBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz46jImpNQTSKH65KHvTm22Dhuqtwn1X5MflFxY7VXAeO5azDa/l1aa0lLI8aTVD0G0mO2XxuioEmo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJYD0lpxMKFV5fNb+oNtf6qbKcfzUsnL/b2tq1D1Ur7uWuW32Y5
 4QwLHLwqT8A5T8vj3hruP/P51oBdDk/+DfieYMBZXQjB1uZB73RFGgsYdd1P+cuIJAyY0FW+H+3
 UROe7FEXJx1eWtkVGsylpMNrw6COrO17FEr6KKLV+6Y6AEYzggnV9YduG4fb1ArdibWVgfsI=
X-Gm-Gg: AYBFou0B+jXTRzilBjZuHrAq/4+DaQRs9jp+8+MpHocxupBqWq88XLK3eABe0bgZ9sQ
 2KVBD4HY+r9dN8nVlVtcJ3WMfFkMiKCXhMIl7n8VAqWpIbauZCAaxN9TfdQKSiM1+tpsBCvgMXs
 QVKZy8xMuswg2z7JraVrZZVMTxMzSxO33CZuoUR9z57yPAB1hwegLWbpUbtExfGOISV1IpHyPw5
 KE6pkZZRDx9ZNlKivCt+XD6G7aN88F6/K3OTZWIVKg+fmOKfKhbAHS1PE8B1X8FMfQrVD/NNWj2
 hlgW7BpPMZXZ2k3WmNCctdEwgc2PjzE0891gtDskY/ULeCfW97uXZAJ0RgSOtVyYB0811RaYgKX
 k9iVhCZC5W+bLteGxJdsKag==
X-Received: by 2002:a05:620a:2b86:b0:93d:9dbe:5bec with SMTP id
 af79cd13be357-93ebd10b418mr3142480285a.2.1792061244832; 
 Thu, 15 Oct 2026 03:47:24 -0700 (PDT)
X-Received: by 2002:a05:620a:2b86:b0:93d:9dbe:5bec with SMTP id
 af79cd13be357-93ebd10b418mr3142476385a.2.1792061244306; 
 Thu, 15 Oct 2026 03:47:24 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3ed9b3f0c3sm107970166b.44.2026.10.15.03.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 03:47:22 -0700 (PDT)
Message-ID: <94172269-ba5b-46af-b31d-35a314bc0a68@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] arm64: dts: qcom: sm6350-lena: Add qcom, rmtfs-mem
 node
To: erebion <erebion@erebion.eu>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-2-b4612e3eb536@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-pdx213-upstream-3-v2-2-b4612e3eb536@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad0af3d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=JgZe5hknAAAA:8 a=jVuTDJxxa8O3WlNxpk0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX4sPzylrGtpsy
 lhEcv/Y4GS+ESkGOE/6zfT9kAE0Gcygo/myTlZX0149B3JHSg0RvaAH8Ybk5oAkE4zlOSbdfET4
 ntRcp/wIS5UMqx4dB6zIdGdd7y/AvyER5+OX5KY6Si31OVIo1AohZfRxiky38HaJvcrNqrS364z
 iwMjehsI2RyWoF5LgtOffiM3NFTnCUYkPktIZTplmuBQLaKroHb1Dp/m1nDfIPL6JG4LK6MX2lw
 aaT5bNAcP34yrF3vFgieOQj9RP81clVa0dobXG0Z7m6J0sM0NH4XvudUUFrWGIw0iKOwo/2AiL7
 addBh0dA2Zu0Qyrk0H9RCawt5Q7IFXDGfakphZLbRsPOXrC9OOlu2XeUZPPP/5CZofKzRaoaj4f
 /WC13ZOjy3mZxEG1twFSP5ezsEu5JV867zGUanD6qWBCItmzYsp1PofJ8xlAR681Lj+U0j8naxJ
 Hf7pqGxUt6q+ZpxCjOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX674t3YrCSyKp
 jDLocaLypiCfJL99JpmDfHlGA0lZoXEFlZxD8eDItoU05LvFTMozo4KE3aFFqOfb7zziI/HeD5u
 12hGuEbGmGEDvX3DXAzAGThMGP/jS2g=
X-Proofpoint-GUID: rj4ljGomNfEm8X56yBkkKP0YaQ0XXXKs
X-Proofpoint-ORIG-GUID: rj4ljGomNfEm8X56yBkkKP0YaQ0XXXKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150042
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

On 9/26/26 4:00 PM, erebion wrote:
> Adds the qcom,rmtfs-mem node required for the modem
> 
> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 79aa2521aed40..0ef3e9e239786 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -4,6 +4,7 @@
>   */
>  /dts-v1/;
>  
> +#include <dt-bindings/firmware/qcom,scm.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> @@ -54,6 +55,22 @@ touch_en_vreg: touch-en-regulator {
>  
>  		vin-supply = <&pm6350_l6>;
>  	};
> +
> +	reserved-memory {
> +		/*
> +		 * The rmtfs memory region in downstream is 'dynamically allocated'
> +		 * but given the same address every time. Hard code it as this address is
> +		 * where the modem firmware expects it to be.
> +		 */

This is the case on all Qualcomm devices, you can drop this comment

Konrad
