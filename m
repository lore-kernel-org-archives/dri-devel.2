Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA37E63FFF
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 23:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BE310E03E;
	Sat,  4 Apr 2026 23:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FNdjwAqv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MWv/9pqO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D3110E03E
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 23:09:56 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6342qqhB2199939
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 23:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=r/VeTwFFRyvu6ZUF2V1QEPhF
 MDfPfnRtBJNKVU2xZmQ=; b=FNdjwAqvN9I+adb7YdHR5/mir4KjVHccFxSJllN+
 te7rSsBDRy98rz44MRj9RjjuW2soTnrAtJtJalAHKGfD6UJsxryCmVObc8Qi6QFo
 t8zh6E0NXjwxHVG8MumDWJldL7Ka9RK+0ITWCjyMv/een+Y8nPlBJPACVP5TYTBF
 V8lxkFZAUDOBKj/3F7GbPLsr2geNBYukINUwHy6fAMrKMmHfdl+/fmNg0tiJzAfP
 TjR1aWVA994e0MYuqAix5IyjG3lR5wSdzJ2DrL2BJRpdkupbC4wo1GEAc3NA7+b0
 MfGIDbfx7zYFLyqQF6CiojfodmOXrLJNtfFzmjk/9T+Vzg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dat7u9p29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 23:09:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4987c698so75970701cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 16:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775344195; x=1775948995;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r/VeTwFFRyvu6ZUF2V1QEPhFMDfPfnRtBJNKVU2xZmQ=;
 b=MWv/9pqObIZUjJVoVo8dtZ42iTOvnT5Zu5PaytB+IFSysuxqu/zS/cejXtVt5y7Nvz
 Y82z5GZRJ87docIgFEe1NDGuuwokLNOuMWoaB8jFrh8Q5ZoHMowRLLnAkJdpG7KU0MW2
 mgbNRGtUXM7Xfp33yRiOKxAfmdCLN+MRV3Q0yyvF114a5AJJFJZEVRIcYFJDUS0loeX6
 a5AtsqIHKdCKjZQvLoqs+XfSX+Q0axZkTDpOz/zwaptDzSoTs5nQwEQGGyyzpWN7rfyw
 tJJppNocFTfKw2Gq8WiMOs2eGoQrJKS+FBw675KS83t8JIxt8VibvDP/Cio2rQ7sStRj
 IOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775344195; x=1775948995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/VeTwFFRyvu6ZUF2V1QEPhFMDfPfnRtBJNKVU2xZmQ=;
 b=kDuRXvjt27fzNVLZ5Yd2ZJmeQw24aXxQCWAUoTobCCJhaz2/X3xCkEtR3S7TcI34iM
 EcGDgHEVpVHxVzbjJU341A8DR4JC7hmNnOuuNIrMtcmliAqVhLHE4xUQ1lMfqLj8qWYX
 fXZKFbbmzDj0qSE6yi9i/2zjrMqs3uCUVIA73PWhoBlVhOmPFO34ga9yQZUesLZF93Xl
 hsYEzyLIa7lrD6K4PtB4TEgIQW1osInis5RrJ7UNlxPrEVMVxiXx+BYjdvTBy1Gg3x0h
 5XJCLQnRBsVbHn6Q5mSqNxZv0oQe4LKL1kr1EV9yLLzuQRnuAE86nzGRDlZ2vXsiklAQ
 T6zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuskqe/G4GFVA6L3yo3uynM/jNHd7mi2vQfvsFmzqIhiYW7T4j2ebB3/UdQqGT1pmVTxPoziyFchY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzbwt0i5FjHOvjpdlboaULs3QWwlFWhKcv2moRCBXSJRtmmxY9j
 pfmXRxoZ+cdbYEgYj1FhTP+ttvdmk/sOsDl++tzAz7ULTzPflYP8I4YiPCZuekSd7PWAmlzYzcM
 bsc4NvI3YieoJHD96/7mO7qCArOgTYmaQ9C9+ujoTk6DiFJfvhMYFL52LvksF4opwVJDMXJU=
X-Gm-Gg: AeBDietygpGYZ/i5fvVe177pFmOmagvFixO/fFQjoIIMnnoM5777jnP+AtecC9N9fa5
 NH/7Pzo+c5A22BrfM8ShsqdnxGoLFQ+bfgdAT6nHJY001QkLOxda7z3g1l91YXDAP4Skl8ehL69
 XNOjMyGMaOgNIged5oF07GE5RqM1mn5kloFwXXq/4CWYj44TxNS1dEukxGOq72zSGD+bL+cnqUf
 gD0PIGO7xo20Uy7NqCIfcmTFJ1ABwjf2nyP8GEOiTWoHioVaa8Dza3qld7F4C0K9TQIUsrOEQah
 UqjyyTytF60mLqnkpDK105asOAWoPQBXO8JhP4Izq+q30587JxE16P9CI/qG2Af+Ylxy2u19Kf+
 rJeDBzH7rAJP/lJ3syflT+ccejMm4bA0OR0qg3sSoeU0AWz+lxA9pkqA+dqzwelWn72YXfxUYtE
 gmcajrC9u8eD8Wpk52EKPS0rB9kOgbREh30Bg=
X-Received: by 2002:a05:622a:7:b0:4ee:1bdb:a547 with SMTP id
 d75a77b69052e-50d4faa4f03mr151112341cf.14.1775344195029; 
 Sat, 04 Apr 2026 16:09:55 -0700 (PDT)
X-Received: by 2002:a05:622a:7:b0:4ee:1bdb:a547 with SMTP id
 d75a77b69052e-50d4faa4f03mr151111861cf.14.1775344194624; 
 Sat, 04 Apr 2026 16:09:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cc60e1sm2321657e87.51.2026.04.04.16.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 16:09:53 -0700 (PDT)
Date: Sun, 5 Apr 2026 02:09:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm8650: Correct and complete DP
 address spaces
Message-ID: <3a5fgah7dpyc2jvcsccnhfwl3oakrd2mkyxrpa2rpg63ew27rm@3xuaz3t2n3am>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
 <20260402-dts-qcom-display-regs-v1-5-daa54ab448a3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-dts-qcom-display-regs-v1-5-daa54ab448a3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIyMCBTYWx0ZWRfX04ky++nSnxon
 uTpYr8I8Xx5eXpy646aon7kwHOggiSqoFGgg+6eLPmF3AiuSDnkr1GlNhwjULVc+yQccJm9of+E
 svDrvvR45DEh8ihVyYRo+VF00Ltk6TgyqS+VCfRMWfcm7AxQ/gVeV7QxSvwI1FylBaN6615uFEZ
 3ulQHJ3Wh3U7DnJCoeKxDySefQvD6aKdB4GP5+QM3qEjnRsgcPEOZ9pVHwmtDne9fyxucpo8A02
 NLOrDq/Dews2usaUY344GC4w32Us6VuO0eiVbJ+v0sDagSq1dPIM+d9w7OxIWzcapnPvZrqHBGO
 2pcLTkwMj7w5zcoSaSm3dDkORjmJBu1OmcUa1fKg1mN+t3cbFiTajRSgq8k35MoFDNnfj0eD4zb
 0I+so8yWA92wj5HxrxsENACQYwDNAo7ySmfegjecjD82NvyHKrrjHuXP5mfKJt5regXyp3BnvOh
 sXFjaFegMN0Pv1LrNnA==
X-Proofpoint-GUID: PiXclogM4r3WuLnjVAXRleOYS_dPgjBc
X-Authority-Analysis: v=2.4 cv=RJ2+3oi+ c=1 sm=1 tr=0 ts=69d19a43 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=EqZgH2Tm9vfPv3d_J88A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: PiXclogM4r3WuLnjVAXRleOYS_dPgjBc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040220
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

On Thu, Apr 02, 2026 at 01:45:16PM +0200, Krzysztof Kozlowski wrote:
> DisplayPort block on Qualcomm SM8650 has few too short address space
> ranges and misses four more spaces.  Complete the hardware description,
> which in the future might be important for full feature support.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> dtbs_check success depends on the binding change (first commit).
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
