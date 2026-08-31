Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571E4C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0DA10E9EB;
	Mon, 31 Aug 2026 16:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oeLKCJX2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KTfo7nF2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF0C10E9EB
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:37:15 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFqCmJ4079232
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LkOzXmv1woFoeQJtIpxPXxYwsR0W1dreX8GPkYWvKdU=; b=oeLKCJX2IWEAz85m
 uG1dKtptaCjTthoJ04PWVxyhFfstlQhOqXXSQ2qnsXmp9lUiI9Mlp2K77Rh/z0UH
 VnnAV5VTw6xw3Mv2TvhLQsNjAs5y6IvG/LONYJO9IdJw21hiP6sBB1fi+xPuu5fK
 OgmomtYR9ppQQB+x6ZHf/aeyWpQ4LGjItVST8h/N8mPAprzVj8VpBR8KCU6p8Kii
 EeJAneoi0Ux2pqfcC7u40feK3V6Q2kHljRvQX5Zs0dPSXxZCLDVEh/SGBfRe9kU0
 ULBWZ90U0c+BNnp2qfG1JKTPSXB32llp/yXRm5wy8lxTWglAJz/MrIKaoXTC+MSa
 ETs9iQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6rb9x6v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:37:14 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5bfc08e95ebso87464e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788194234; x=1788799034;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LkOzXmv1woFoeQJtIpxPXxYwsR0W1dreX8GPkYWvKdU=;
 b=KTfo7nF2VMyotMB4NjD2zwsr1W8H6zBRolHni2+ZtZ9a9T9MrsFIQQf5FP46EzecJh
 N5go4NvjSb+XsKuHwEiYQD6N2ZyikfxkfMSEaUjS1JPoz+MVTa9FOeKlmJF8VTKkDpas
 2dfGKVxnbLCvbuK0wfZDfr8EHrstgb+8Ovpia+3Qf4qe1odRL759goZj5hhNeBqHrSu0
 brw7+xDDJpJ1vYjG1EPFVWDDZO59QGHcEBX7YGyTnYLm5hRTYuwxiAhHT3tn98+7EHRX
 JQEq5prMQDF8b2nE+ahoHs6sU8Nj4MKg+Sm4xF2asiYobfEBpcxPetOqa4kGpPrVCs7i
 UShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194234; x=1788799034;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LkOzXmv1woFoeQJtIpxPXxYwsR0W1dreX8GPkYWvKdU=;
 b=Tu6oCc96VGivFo6jTOFQBkck4Vf2mhsCtBhe9fxYupnmZG9mlPU6OCWzS7P5vztz8l
 mwbn7bjJl8g8zZFxAPbTg7QWtRSvDpNjJ5TjYSkfH6XkIt721SVW7RA5DSV+KdpP2/1N
 bfDVzNUYC2KxgvfEppgahTVxFvRYCWV2jg/bkt4N9JN30S1S87XBkIq3Td95wbn3/w1E
 PyAAmLw7bmJXVuVp3hzI6oX430ih4l97wxU+omO8yewbv8+6GugmVJbmh5jz3GI6LVoI
 /lMwG9C8LjsfhSJAqlT073VHF1QLFU+EG10NO09/VAse9sIjYv2vjraWCj0qdlqpCL1m
 SDPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqL5wjlbB49w0PAwm0wzpii0pdRkN02ShGUx7iXtGyOLVQKrNW0H9xKz75fF0p2R48O1LVS/xeyljc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nOfcc2knlAQ3AQiQh3n+71agaPA26lOM1DKm/3KjqtDAoHNi8+
 CcvO/yqM0Vvn03eUen+KjkNQoarWRRHKmqKFOEkNAGOmeYBVBk2alLzDU3GOUYFrrd4nEXJR8DU
 /ZrtmDZR0ZBxB4LP4Bg8JBpqJdid1JwNnqeMaAEwfVjLvspcRHHEX/XPRwMyof0ZrXKSJCKU=
X-Gm-Gg: AR+sD13gZmTjL2VOASPVnD9f3e/jVtqT4rmdGxC1+od60apzKraZJBAA4GaFpvd8+Ee
 Ep4ZrCX7z/eG9LrADfuMP/l8FEIVg4DbmVsa+Uq9pqktMTp84MB0P9K24HmSMKjulWmwhc3vWz3
 IwoUd5PXiD2nz/tjzwC/ACUjXFc3peAztPN4R728YY2YpXWQbCCw6kqxNh/hEW49b8eB18J9MJn
 fvEP9bSt4Pa6+xPLm3iU1REodI52xHvjioqGAGVQPaho0HqhCJpjAtbyGgUmqmTC5mlK0f/Kzau
 F/KlfiyNGQCix64uh6uGwkYf5DxEjxmizGp2KBAMOaTEftprltppGc5jyJZJ2Ns96xfOqBqzd5H
 a71i8P8qmfO1nZ6TCMexy1Q==
X-Received: by 2002:a05:6122:6b0f:b0:5bd:9cbc:93c6 with SMTP id
 71dfb90a1353d-5c68096658emr4135476e0c.0.1788194233606; 
 Mon, 31 Aug 2026 09:37:13 -0700 (PDT)
X-Received: by 2002:a05:6122:6b0f:b0:5bd:9cbc:93c6 with SMTP id
 71dfb90a1353d-5c68096658emr4135459e0c.0.1788194233165; 
 Mon, 31 Aug 2026 09:37:13 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b5e8a0ce53sm2391683e87.59.2026.08.31.09.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 09:37:12 -0700 (PDT)
Message-ID: <4741e7a7-b6c3-4e5f-af03-d0121dc228a1@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 18:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 04/12] dt-bindings: display/msm: hdmi:
 Correct name of disallowed supplies
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-phy@lists.infradead.org
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-4-67843277de17@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-4-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: B8Al0MVwORKxzEITwBxnJqNvKKHn9dqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfX2Z9Yp4tIaOMp
 lkKXGcCasjK58xUttdcEnZdw//3A3HTKhWKncfCtSFbqk85orna/FXvg4W5QwPUlTQcRCh+4/Pl
 S24htQ/+WbjVSIEdbiNcMyXgXUvq6FjPplGMTYo9C8uUcWGaQtCnxRwQo7LT7JQ38HSm7cGWe91
 fijiqvBAxqHdf8A1dOqhPaeaq0ZnciU7w7qvMDOutaqLXtxH3JZaAmXB1k7dXEulCZbtg5K5HMt
 a+hW1y5ncVO4GgYsewHxAz3VgF9yiN4XCMd3H6lCuik7+LKi1mkRZJIcawmPKkyF08z3dmtPzHC
 54W4qCBIvbG5sUo6tg4GCZn1jWVgOcXJypPjE8yeiHFULVhtzFu0AZzA6GINZ8sCTsiT1Iih3RM
 jfAOYbR81ayRt+47xvin086bvK+MglyXp5AfRBgm3FXeNR9Dlafqx+VNRoKc/ueA+UR5nANycY3
 R5KfS/CJD/a9sN4Emaw==
X-Proofpoint-GUID: B8Al0MVwORKxzEITwBxnJqNvKKHn9dqY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfXzuKFJEqBD0ov
 X+H1arQiQ6U0tvPxPeeQLULVd6eloHwtAXBGRtkIAAucFeDtHga1kXm/sgamt/9MLAZHQeaf5ls
 VznB/jLiWrISUcQgf/DvtweK7cyEJVg=
X-Authority-Analysis: v=2.4 cv=d/fFDxjE c=1 sm=1 tr=0 ts=6a95adba cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=JLRh7K5kIuGMceoZOjoA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310143
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

On 8/28/26 4:05 PM, Krzysztof Kozlowski wrote:
> There are no properties in DTS or Linux drivers called
> "core-vcc-supplies" or "hdmi-mux-supplies", so the binding probably
> wanted "-supply" properties instead.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

FWIW downstream only seems to have the PHY/PLL supplies for 8998
(or VDDIO and VCCA for 96). I don't know if the TX block needs any
power other than the on-SoC power domains

Konrad
