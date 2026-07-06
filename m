Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AFFC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD01710E292;
	Mon,  6 Jul 2026 22:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cgSK9Zar";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="enOEa4Zw";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724C110E28E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 22:23:28 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE3bD1478204
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 22:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WaWa4MGfpSWu+L1vhHqpxj3K
 PWIdAgUllBsZqFOfmBc=; b=cgSK9ZaruPNrvWg45rTPSYJSJ8Dc3RHumZCRnjOK
 NWnu9BNkdVFvmhjtJE0lr2KMhV3K3FS2H3UWrrlOes/jZbpTWoVSK+7CQE+ZkEyB
 X9FuO7DgCt79QhhUiDI63AEYK6YH0y3ZIBhByuw8a1S/16ieeFh9DvJ5FmAnBbdX
 8NaX9xNzjALX25XL+rQWFDXRcOTnvPnOW+8h3NymVxY6mDYsgBxJ+8MpdOn1/mzZ
 yP7+iktuSg45691PNUAl7KPBHod6Ija6bHExpwZHYu5AcHFH/vMQBv1NQlXiWO+f
 bNKRCpazyauYqKT5BRdYbUg53iatMT0J1ArsC62QEY1oHw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbk1k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 22:23:27 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9693c0b30cbso3132085241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 15:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783376607; x=1783981407;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WaWa4MGfpSWu+L1vhHqpxj3KPWIdAgUllBsZqFOfmBc=;
 b=enOEa4Zw9rg/Xiv1z2Z1V3SvsMcK6nVb/hohXn/1lLd+Ev5CLW/EBoHoGLrExGmQdw
 E6/On2v1dVpMuiuFKCiB3XX5VB947eO+FoU0zcDeuJT6LpkY0TjTMqdT66Al0gCgq3Au
 VU5UYD/VNmDUucjbvKMyWQiptVL+9Yl0R3pTRorPOKbnyJoAj0Sy42qYu3QORPGK/I2V
 YYTGL/wrtYRysJh6WX2Kl8mEHC17LvR7+U5gL6nrZ/S8LkhxXMZzxVWAVJ+DbdM1QAPE
 C42O+AazzZjWL0Iw0lC2MAylS4cDeHtlvdivZFy2cmng/iuYQVBz803JWltHeG1RCIVz
 LZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783376607; x=1783981407;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WaWa4MGfpSWu+L1vhHqpxj3KPWIdAgUllBsZqFOfmBc=;
 b=PpWPd5Bsqf39YLnPyh2Ft2N9m+D7hELnjr48Ino+JnAuRIkBPF1FAnqt05lxKku3Rb
 vQDrUxwrgmQu3q12s0k0pGBpIC/wykaqRQnjhK8qupwgnFJk2NEHAinehFLzzJvtAhWR
 BAKlPlQk1PKNMWsT8lxIX7keMc1ROIPCZ0DcioOgpdobnqf4b32Bk+im1mbeRiZFHHhg
 OleLUN8jUlH1B/d9QEn9OdmSYbNnXegTAKoEm52H0/R6lmnOH7VyCkbVbeA6ScrN/Wci
 VweCm2ew3eARKnXrlUnx2V/w0XYvqWYx3jp4haAyl0SqpW+9EIvdI7ULhK4xW2jdPrYa
 EJdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RotBwCfjlNXwDmK4Qn8J2sRR0/AxXugoh15WbmSZWPH2srQSraihCdkBDyuPxfLBjdKbomWZrwrnH8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqFpSvejGxRI3XQmwUSsv1myCceK7zu0pSjGW2j8tfG15MxsZI
 cEXDvFTlCktZKCJTMaPghtVQuIBxa12NEeUmVr50PAXcP6elF16NhGAlBCkqYXyoYUwyWSeQ9O8
 pGLuU+DckLkEZ1t8nngt3nRVRo8jSORnY7kZp5c3OroRq3QS277uAEGpgi60Ts7xQDwyFJdE=
X-Gm-Gg: AfdE7cntFzVqmRCNHcQl0EbSggo5GqxI6wJhcYTUTG3xmAeBI3p3wL+yDmc5Alq06Vs
 Uul68E/RrymCQ5w0qcDnYncwUTZEqYZHV3Px0D+vh3F1ClbOWobvHtFSC8u1aaNcM7yCQBZb4d8
 bRctu1oaS1arvI2dwbJLVXqqxn/QRjGX/9lEMWatGNfWLiv/uc+rssK2ih2Iqak92t3Uog18iME
 J2SfvraFaMuXxPDeGpWk3CsO4CzwH2us+dWIsFx6ihWNL+nNONmkWe0tV/a2p8cz78L16h74LuT
 kEaJLjItYmxvg7/wYHZ4zqDRMs5xVkm97Fx/XVYGLYDMlMtSBwncnK5qLqwjij4vVPlZ4DPVi17
 xc2fk56Bp4KTS6u33JW1GnvVnuAkTGUb9eHVqDWBXzyjwiqZnunUz36plg4dPWbJ5L9sS8cmh4t
 9CzLHMc5dXu7rggl6tLYouPNqy
X-Received: by 2002:a05:6102:5091:b0:736:e4c0:cddf with SMTP id
 ada2fe7eead31-744b7b30a40mr1244172137.6.1783376606750; 
 Mon, 06 Jul 2026 15:23:26 -0700 (PDT)
X-Received: by 2002:a05:6102:5091:b0:736:e4c0:cddf with SMTP id
 ada2fe7eead31-744b7b30a40mr1244139137.6.1783376605954; 
 Mon, 06 Jul 2026 15:23:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13839bbsm3177862e87.35.2026.07.06.15.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:23:24 -0700 (PDT)
Date: Tue, 7 Jul 2026 01:23:22 +0300
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH 8/8] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
Message-ID: <clfy5lvz7vm3ogw7pvyyidiujqcjxftx55p67szwgc6ivsq6r6@xrrcbfdkqkjo>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-8-c9f1354dbd29@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-eliza-gpu-v1-8-c9f1354dbd29@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: RvjaTYnBaa4hYrOtydX_a3k1flATPARu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNiBTYWx0ZWRfX5yf5uvkG8Fdi
 lyGMHqWMBQGSxpqGsBiA5qmEMJY9SEAE9DU8vI8v9GL3ugpgmGgpNgFvL0YCKbBXga8bkYr62K0
 BJmdu1kWsLU5LZ+r/TOXrvvjn7wm1WVHDfY8hr16mYiMvxphEAAYPEwfs9ZPMxe3x8i8Wy0ebdS
 N67icBMGAI0IeK1JQnUsAbEmvLPXe0dOz4La4kL+29JdlAxsk/yAde30m/ae92HO/JWbdZ07vfX
 YjoY2nfI+5W48aT2tabfaP9WHcp2kxCCc2rPsbYdvODHoG5XV4yHBW4TjZzH1DqWxgYRd5TuNwP
 RLwUle/AIAAd8AGtcgOA57GVMpqHN6V5wGQpyawnoEnH6whzTOGzpRbtQidI+nhY7hUKYwxVPlT
 iJPzDQEEfWNTWSMEAqFeJVbessnVfBpWxWh2OKkiQbKQRo2yvmoufbpsi5oRJv8co43FmqUVhXF
 JwjdJl4dd/erUXlvGlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNiBTYWx0ZWRfX32SI/zh/BbxA
 WOJpJx2jL7/aT68HgHb9sJSuQ3Rqgyr31lMrGCdSxm1ZXp5tpnNiqxZn8/GAdlLUgW5c5Q+EAsl
 0pn8F+Y3dwe1JhniaIa6XpGmmcQpgFA=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c2adf cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: RvjaTYnBaa4hYrOtydX_a3k1flATPARu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060226
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

On Sun, Jul 05, 2026 at 01:44:23PM +0530, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
> shader firmware path.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/eliza-mtp.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
> index 1374afd9d14e..b280d8e845b1 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
> @@ -417,6 +417,14 @@ vreg_l7k: ldo7 {
>  	};
>  };
>  
> +&gpu {
> +	status = "okay";
> +};
> +
> +&gpu_zap_shader {
> +	firmware-name = "qcom/eliza/gen70e00_zap.mbn";

Should it be gen71700_zap.mbn?

> +};
> +
>  &mdss {
>  	status = "okay";
>  };
> 
> -- 
> 2.54.0
> 

-- 
With best wishes
Dmitry
