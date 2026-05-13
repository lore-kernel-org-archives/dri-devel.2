Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE6CCD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B4010EFC0;
	Wed, 13 May 2026 17:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BSiYKVO2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FBuW/eJr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF09C10EFC0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:58:58 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DEktXV2887813
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1WKKWsy30d8mA0DD+ETWJZ8a
 7Kl1AqNPvhJoq/q794g=; b=BSiYKVO2YMfkIG0fCZORzl+GyoJ1WQGw3vbcbbJX
 8+9rUtHAknD4szJjVD2PyovYSne2u7TPE/ASEOLa4No36Hzvp7uzkDB0Tqf/2P29
 1/ZeazSJ8P7tg6+iaRkoeRsTkSF7w3QNT0bwgoqxRNYB6WkiAvlP/1BHx9FF6oTk
 9heosIJAZ5EMNHfbHUM5gjo59+jT8cVZ0e7YFWAVzlSeRAYzJ5DDtI1tLB8+HZT8
 +cvhs4NMw1bVrZ030VsrKZuVPUGE7cb1nT/ZUubeZRa7GGxW2jTmaSkzZHvG9ZuR
 DwGgp15vFE22t4i6QbCU3wvMdHCRzrSMRJ3bjqJ91CfjNg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p4gj6xp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:58:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50e136aff17so12591531cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778695137; x=1779299937;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1WKKWsy30d8mA0DD+ETWJZ8a7Kl1AqNPvhJoq/q794g=;
 b=FBuW/eJrVS+2SkLn7W0JDu3Ru0YsoXDfYnU0DBnmOB0My/i+veIDuAHBcJn2VKkmYD
 tELddHx+gkI8QE0AAjXMNipAPS0ypg4GEaVWbPPiACTVfHv6VhKI8z2DUwgKs5iUt8Pc
 AFvHExcMFjshE1vpmSmccy4GaUqVyTdJUpdY/7WUdg5qxp2GMLTA/W/S2kXT/59p4phK
 g7Y/yRNLYG+ADbFbE1OFo5tuF4tFNSEv/LHgtrMpFnXBmgvQF9yCZUQgXHPwx/GH9Wc0
 p1HTuCOWLOox0hH2U+20UFfuVxUCb04F6dPDIx80eIGmV2gzjHzwR9I4yTfFJXzA7S/q
 Io+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778695137; x=1779299937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WKKWsy30d8mA0DD+ETWJZ8a7Kl1AqNPvhJoq/q794g=;
 b=eRyzYFJ4cLhtTaKATRXs7IqYBLnXx/26Uk9iS3rUFTWxtwNRLfU3Oruqf+x2GNkpE2
 1SIL1XhTRQ2RQNLwlDGScVWPLpW93nlQegOdq3lIPZ6fIcyWLER/sRSJvlafsVibxb9N
 6rrwi4Zbu1lfb7gDL4bkya/9RQJ6BKN4GWeL0yV5Xdi9pI1zTxd7yFfRMsirVZnaOHbc
 5Pi+fY4OzvG7/O+6VO3T9hxZC7hEP5rb4/5WK6WVEjdk2liZVUki2OO/FkGryvbHtHow
 PCgVIMgc/rcN81x9v5bsWwI3C3RHdCaXCphGqPX1Zl2D9OwZiLEna96PFiJxFEO/W8sl
 vBQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4bMePBMVXzcV8T8vrxokIzDm4Ux0DZcg1Y0NdYmFA01YL4pTae5zI188GR8Rg90LLY00QB8XQAjU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsVNAY18UOfUxx7mfCQhAovYlBeNy61U8MKkADrdeqnA/2qypV
 eHQDEd/XpDe9z3QoB2zwr/Y0xFmqPa3KSJJHLYAb0/GTy/vRx9Vbnl8iuXgJDFiQv/crW5LWJx5
 lygt5a6FePe/mFPZPip1+xz3jJOi+AKs6vuq3KQ3luJ8m8aVtKkU25ZmHAN7PYkC8AiqfS0ZM8H
 sSF8o=
X-Gm-Gg: Acq92OESyxYdVd72to0+tOuxBr0OBObqfUx3vNJLMUGTCfE0ZK6QV/LJnCWypcerve4
 zp421PX2lhdrymRmeWd26vX1A8WVYQdpJYfdPlHOhNCIZesR42YmUYubd59K/42vcbZjGuUcQXa
 Z+6Kj60rAMFIpe9COWfhxp9KDY9N+I00k7+hWVR9yIyxNe6utOtLkuZHLk3OpCjycpQnOZizFzV
 gY9kLnPticHCTvHc0bCJshNbL3/xUqvrBklhRZcangp9XvYhKLvcQD4Lkj7ph8sUujLcXI9lGr3
 UWZR277SWlORRehtp+2BO0F/fw8S0gOj/i9LoF+m6vAp6NpNSJgsucqrws+Zkb+0hf0BkPKkCrG
 SyfWqLE91103YttH/IBueYjiVw4OUGQSQ2NfNb/+CLl1j0TDyuHvWXXVf/eOjBhOYuMf5FaqPhf
 kgUZm2OsRld4jJgAiDPEJBEel9K5ou5IuK8F0=
X-Received: by 2002:a05:622a:1e0f:b0:50f:c5f0:f2fd with SMTP id
 d75a77b69052e-5162ff577efmr52620381cf.47.1778695132253; 
 Wed, 13 May 2026 10:58:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0f:b0:50f:c5f0:f2fd with SMTP id
 d75a77b69052e-5162ff577efmr52620041cf.47.1778695131770; 
 Wed, 13 May 2026 10:58:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a956b2acsm4133502e87.82.2026.05.13.10.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:58:50 -0700 (PDT)
Date: Wed, 13 May 2026 20:58:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 Yifei Zhan <yifei@zhan.science>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: add support for pixel 3a xl
 with the tianma panel
Message-ID: <sxfr24cgzfa7vr5jvgjpnq3vdhqwoasycyjrphydleucsrip25@vtlul22nzqv3>
References: <20260513172549.1345-1-mailingradian@gmail.com>
 <20260513172549.1345-3-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513172549.1345-3-mailingradian@gmail.com>
X-Proofpoint-GUID: Ztu6gl3mvR36p8c7PWfwCeouiZap5YBe
X-Authority-Analysis: v=2.4 cv=DOS/JSNb c=1 sm=1 tr=0 ts=6a04bbe2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=nkUbddICNmq_qF48:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=0n9J7lFBbKc1xmsM6LIA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Ztu6gl3mvR36p8c7PWfwCeouiZap5YBe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3OSBTYWx0ZWRfX73vM3a5edqZh
 TUh73MraUiueVjRHhZ7hllQ3jRZ1TEYLprY53R9JmlJFk2Xiece/w6EOWKYKbRuyRLwbumzRCR+
 3KkxbCSbfEGpkIf8sMUythVvTBltHve4LRbh8CFLXIQzOzRu5y0iufK+xv3MLreHdBBSkOghby9
 FzxOGiHXS2GnAMwOdYX2ZwIWeviGfQOeQa5jIFbdbMZOw8dEh4kdZvNonEcOhtYV7peidI2SJ+p
 Bf/G3PcNOaFXQA24O4xCxeCxJMY3u2CMV/PunHJkIgGk23Fydc3UfnIyh509Vw7Um4Z2no3qu9e
 7nRGWI9ZfP2fI2uvPQUD9cLAZI1wtr8Vud2SFqg1dbVQXR9AW2//M3MW/HBtUvuTn7IoTI2zU5P
 kjjsld/q1PSrJdsWtdUXwIOF73Sx0dzpg4NIZQ4N0B7QcA96Yy5H6dyKqtjm844a0LbkYLMPBWT
 XQOXlfhd6PJ/Yn0JD8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130179
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

On Wed, May 13, 2026 at 01:25:49PM -0400, Richard Acayan wrote:
> The Pixel 3a XL has variants with either a Samsung Display Controller (SDC)
> panel or a Tianma panel. Add the device tree for the variant with the
> Tianma panel.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Assisted-by: "Claude Code Review Bot":claude-opus-4-6
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
>  .../dts/qcom/sdm670-google-bonito-tianma.dts  | 32 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm670-google-bonito-tianma.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 169cc9b9ccd3..d909c527d848 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -303,6 +303,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-motorola-ocean.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm670-google-bonito-tianma.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm670-google-sargo.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
>  

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
