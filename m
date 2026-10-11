Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC14CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 03:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D1210E143;
	Sun, 11 Oct 2026 03:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KysF0DNb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TItdSFqp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE45810E143
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 03:30:44 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B1q3H43329685
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 03:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H9svzMgESlMxQ2/eamTykJGeU+wpVc5L1Ni2Wur0Meg=; b=KysF0DNbKXWuLhgL
 vj3p1/+J0Ejl9Sm+6+jKRiOU/lqYZ+GNPhD5QoPfLqRgQgnHtXVcUwpjroowGWKm
 CGITP+wi3/G5VPy3z0LgbxE/kOz/2BZQM44IhQ+vF68JP/D6YqOfthu0hSctN3++
 Xy8ujyufEAmjJRUrbgag4kE+TEO8Xdh6TFuPptMO/CZX+7kvXip8CphBSWD8fbrw
 EKil1SVaasue3w5sDrM5zqOZXjPKBzjojtrOEJyjyuamoFhtbJ1kcjGAe6D6qXts
 wHzqsRnbxI4ppNnJumzR5Dp03RDBRTJLiVw2YWZ9sypOwGZDzxKM/tUhvvnr2gas
 7nuk0g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7b2famcd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 03:30:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3580c07911eso1930384eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791689444; x=1792294244;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H9svzMgESlMxQ2/eamTykJGeU+wpVc5L1Ni2Wur0Meg=;
 b=TItdSFqpa3QWtfKKofFbtvLHH8hRUDiDZHIEHSsVXvaJ3a/dBp1bzigiQWRa9ggZH9
 fwiKTvFpJr9/JEpMnaafBkhCKlIby5VRIPo7BSdw2F2G+Z2SSSlEGy21mvds7uKX2Tba
 437EIE13nvW/LreyYz3stD6VEiSDN4Xxn8v0amPTBUjgZT7rJNG3yPgr3tYGBLolR6Af
 v6sr+qXU5lkk5zCajkD3uWtCrBJ2JEjAAvxqpIkKEcdd7upr2RkRqt+mADfaWcNLlkj/
 3YGdLUKOqm84nAI2SVes6Bn+su5sG3o2JOtKCz9x+PvoDadaACRbjJF3bVohHgZjLDab
 iSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791689444; x=1792294244;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H9svzMgESlMxQ2/eamTykJGeU+wpVc5L1Ni2Wur0Meg=;
 b=t8h5JwZQLizT7kXQBUC+qLN2pB69q+/tXdKiC6Hovkmp5FsejtyUkaq3HaCLrYv79s
 dbcgTcF5B3CQ5YQA2wfnaWggyIbP3G9kh9PyatRwJ6m7edpixn0Bffqn0nJJ71NKC7KH
 vbq+BHhOPqC18MzEAldBTGHcvxlut7FJ9uPxTOXx95ilxzy1KpTOVBC9QbevJZEwzTSp
 QUc40pwZCNpo5i6xzyNIMsFKApX2NFsjf3olEGR0W9SGkfqsVF/fCqoaDoxJ6gtexBMo
 pHWLhDjMp6vMQOUwBtkIGa9z85mG/dIojTCcXJ/9f4KvZTtzQhdWDmEJc1XUbsR6MIzJ
 ilRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfl2qop2QxvcmJvh5fxBgjTKDIzbu2vbwhG7WXPdAUUaYw7bmkGSWqrDWdfc9Z16L10xI7Jf22TKA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKF7GqLCS5++pBPmjXOCOdC7BcBlMo9CsgJ8Hj/xaZpFgNDh8oA
 OUQdUj8wQ2B23dleqLqPM11co6FoolROXo8mHLx69v4tm0plfKH9S0Jo1uBE0NpvW5qV+C/kJuZ
 tD8YrInD2DfPIhzXOmZVgOrEmB/OCWAadpj59XiAMoO1IdliZ2vzEq/9t9arzGleE8b8STX8=
X-Gm-Gg: AYBFou1jZNUQTLjbFOn9YbogmPCJIOMrPEYLN6PSKGOesQnpzK0XII1MwTf141xU2NM
 0IOsagUoumH5YGTjNUZyFB2MDcc4xisfr5EgYNyL2dtFNhKUJfhrZ4jRqZczZf8NcC21jcqtwll
 mBnbW3B7xu1NmMZLB3V3zuQceLUDSC8WOUP8nUp5oZrSKBC7mnNZy8R5AXBz7NQ5K77rFQRDsKK
 5xESu5f8qsWA+rwsIxd7Ny9ivZIVpn/HyElAHomfqXZs+pSRqJD4HsvA17kNNkKV3idNRrEAx4v
 EGoMWWtSwazzrHfF3RVsgodaN3uR3+qZGaegv0MkE8EcFJkvV22lm5FyWzWIWxWTqgzrA3neYhI
 L+LoAU2K5ULTr1pmJ6ccA+uGUbzFr6Asn4dfMy5Txbg==
X-Received: by 2002:a05:7300:1343:b0:351:727d:b9c2 with SMTP id
 5a478bee46e88-3537e05bd1bmr11778411eec.17.1791689443494; 
 Sat, 10 Oct 2026 20:30:43 -0700 (PDT)
X-Received: by 2002:a05:7300:1343:b0:351:727d:b9c2 with SMTP id
 5a478bee46e88-3537e05bd1bmr11778338eec.17.1791689442629; 
 Sat, 10 Oct 2026 20:30:42 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm19172887eec.13.2026.10.10.20.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 20:30:42 -0700 (PDT)
Date: Sun, 11 Oct 2026 11:30:34 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: [PATCH 4/5] arm64: dts: qcom: nord: Add GPU cooling
Message-ID: <assC2v74wpr3AzI6@QCOM-aGQu4IUr3Y>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
 <20261009-nord-gpu1-v1-4-a06a6c57bde7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009-nord-gpu1-v1-4-a06a6c57bde7@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDAxMyBTYWx0ZWRfX5VPxpq0JYCKt
 8Z6dbN4m/MeYGCMsHrob0Nj9nusgbknhqLbv49n7tEmPy3ZaT8yNaO45jMKtSxBts6kvGlZ6CAs
 0B+/MrOQ5wOOS1w01ERo32FwfsYwTH8=
X-Proofpoint-GUID: rBKDdo5UxfWAQuyUtwW3P9y_w6m2MJnp
X-Authority-Analysis: v=2.4 cv=NddzRGD4 c=1 sm=1 tr=0 ts=6acb02e4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=eBu_aoQerpSAkrlkAZQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDAxMyBTYWx0ZWRfX4hy3dDLtgsHJ
 ZC4q+3gzhMhH9oCOwELYDs3nw/Tpaelt7/SwwXnxQcYRYSCrTDWM1OQwxTwmcG9j8QJuDaamNdJ
 F+JkaxgaEhz8thN0EnNBzQYNzLRIXmQVN+Lw+ZqvTfE39n0GdEYUfLdtWoo5xsxM+O7rXsfZNoo
 tn/3Slqfy9+W4VD35CF6NuUsWNcsZceXcE0fAg1iPOaksr8tR0RqH6nkMg4jnlsJvi3Ml7TQDu7
 BeFbsmow+Hf1RmUMjXbjYINVcKMouKdB+GSuJX0qOBu4e6qnS/kGfB84PXUpmsR4EP6NGTwXbXj
 uimjBeVYc6EJZoaisamIkoKbiZ9x2L5cAC1cYvZF8Lm4kys2YbeXjPRanBbUgtCA7IXDYoZyLb7
 KGO3sGFJoyb1BX16LNwED7tnoHDKUfoAIsTxqIHlHYhWqdAvIJZcMA37wlmWvJLqR0mv8km5IQ/
 DU+oDpXRdLBzu6/AWWQ==
X-Proofpoint-ORIG-GUID: rBKDdo5UxfWAQuyUtwW3P9y_w6m2MJnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110013
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

On Fri, Oct 09, 2026 at 02:36:38AM +0530, Akhil P Oommen wrote:
> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when
> it reaches high temperatures.
> 
> Set up GPU cooling on Nord by throttling the Adreno 753 GPU when it
> reaches 105°C. Label the GPU thermal zones and their passive trip
> points, map them to the GPU as a cooling device, and add a passive
> polling delay so the thermal framework can monitor the zones while
> throttling.
> 
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/nord-embedded.dtsi | 177 ++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/nord.dtsi          |  80 ++++++-------
>  2 files changed, 217 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> index 4379092b7bf8..23370007c974 100644
> --- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> +++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> @@ -17,6 +17,7 @@
>  #include <dt-bindings/interconnect/qcom,nord-rpmh.h>
>  #include <dt-bindings/power/qcom,rpmhpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  #include "nord.dtsi"
>  
> @@ -2042,3 +2043,179 @@ opp-403000000 {
>  		};
>  	};
>  };
> +
> +&gpu_0_0_0_thermal {
> +	polling-delay-passive = <10>;
> +
> +	cooling-maps {
> +		map0 {
> +			trip = <&gpu_0_0_0_alert0>;
> +			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};

I'm not sure why this is Embedded variant specific. Can we not just
update nord.dtsi as needed? Would that break GearVM variant in any way?

Shawn
