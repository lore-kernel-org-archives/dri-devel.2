Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA68EC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D30810F9D0;
	Fri, 25 Sep 2026 09:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ow9vXphI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XSugoVKr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E385D10F9BA
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:50:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4YiXV039781
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yLHiwXQklmHg3BGQyexI717l
 yCNVJaLgg3xbK9n9cXo=; b=ow9vXphIS5Bk04s1Zxdr6kq+e9JGe+G3x+64k4qi
 I6G0Oz8rNoY3DpX62YJJ/pmMolcohoXmEn3stTOX8paKBZfxkkBUgOhdG58a61oe
 fxFdFrDUXGRSlklcYVqhpFGZY8tGEW9zRIa0NE4UyfdjYI/eeIBERLk/udv2nSe6
 7b5qeZr8YlpS+q0QTrK81b6QKQ31z4gI8iKgiAclXlFBbuM2gZIlMO0K906avSsk
 kAJ2Vrw9X1vuqgrvmP2giMl6VQyWxa61uGemmZj33yR7t7r5vLMZQogXdWVBx0dF
 EXOu8SNSFGJFDZEo3u2EfQ8cUU3XTjWO3ZaUbPhBTW5JYg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw46545aw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:50:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so163755285a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 02:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790329820; x=1790934620;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yLHiwXQklmHg3BGQyexI717lyCNVJaLgg3xbK9n9cXo=;
 b=XSugoVKrPhxYVNp/yOIog2DPYOn6GifiomWu2HbzpgiBXzb+FhlXjtk0aSxdOw0VKe
 gqdN8+dCJntjRsi/2TGKvBgvixx9l8BJ4Z1dFIVjj+gJDKqpTh2t+5zqimQAXkko5MWD
 B8ABJH6Yzgs9AKn1g2JsZcetkYcwn9cxaVCbrbO59pTC6KonsUpNAntfxpE6ONMFOui6
 2dLfP6JzHFSNtSH057n7IuxC8uGXixWuXqOWKgXkctAx26DylHoX/PnxaWe4PNBAZkOp
 waFybt2iqqz8YffxsqqMWZvfWVg1rUnEJfW5vAbL66vc8C8PZv6hEJTmyG61eGmxgKMy
 WLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790329820; x=1790934620;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yLHiwXQklmHg3BGQyexI717lyCNVJaLgg3xbK9n9cXo=;
 b=ikd67DZnTyaF2oXYP06mHCnyvVoXyVs9WrUb2VXwu0jfZIZXibyxNx3LeE0lf3foFo
 pYCvOuueRMTPNEg2gUcr1hDx+gb3MyMOs2proVmLjBk7MzeteXkZwucen/NAQbGvzDeT
 I9K/4zvLLqBtpby/mmBLKxtua69XNouSSmfPcqChWClJ2T8bi9Eoob3ne/nsNGKro8eF
 DGctJ0VN0O5jbMYevuH6TXOOschIcTxxQTXgfJUWib5QaSrzgjuYUAu9u5QKnOWrxlg6
 EN0NbNpxE0TEpb/LVKmiw+5jDO69+HleXHojCg5wMCcQ5HvQ66spPlvRNn8qZxmk9Nao
 uGbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQ7m44rMSgXdXzkssNt9mXCtyO/RTHlaOItK1GgXAqwrCdvAp5+LhNYsxiUMNYlsHrntC8rZdZ6qA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lY0b5PQp4ITWDH6uqG21mg1QW6SKT/87T29/DCa1qffqU/r3pE
 nqCT9rQ9m/TuAsed35Ef4GLjy1VQ46vOtpUCDrXJifBFuMPDgaxK1BvyJ3eCM8udj6iHlrgAJXq
 3ssGjNAH6og8rBZDbxlyYp/jN1GwM3FJoQBaw6OR96DSkdiPKUPvzt/+6gKua9MgeZkMqnQQ=
X-Gm-Gg: AYBFou1ydF27LYkD0FEpbw9nSVxqJAf7TZO3vuMxzUBknJjAEPkzU5gSvqSFfRenBeQ
 q3LS50+MIbTG8J5I8ooDmrVEwwKf/yDPJaNXFEL4NAFx5iO6KeL7Rs0681iWO2+OeYIE/GDqC5x
 GesvY+gHTuv1KGiztjzSL7GoTdPCfxodvOFBgY4Shim8vMkDk4RBaVc6+8ZP/qC5qwcnEqdY0Kv
 D93T61jZ/xmTvp/dWnC8HsMWWu6yOcQo63VmqL0tG0W1xo3HH4B7jUPpVZzTre8iwFvKVkh0f+6
 rmNi+deYD4xmzDluW46G8OQk5QplnTibWLOBKLKyZHvXMpbwu/VD1D7gniSDePEcSe0IDMzqIaa
 Ce1W/91Ol5OZLNQo=
X-Received: by 2002:a05:620a:8808:b0:93b:c45f:9024 with SMTP id
 af79cd13be357-93c43cc2c98mr342981585a.7.1790329819862; 
 Fri, 25 Sep 2026 02:50:19 -0700 (PDT)
X-Received: by 2002:a05:620a:8808:b0:93b:c45f:9024 with SMTP id
 af79cd13be357-93c43cc2c98mr342976785a.7.1790329819260; 
 Fri, 25 Sep 2026 02:50:19 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a355826sm5830535f8f.18.2026.09.25.02.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 02:50:17 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:50:14 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: glymur: fix Adreno X2-90 GMU
 compatible
Message-ID: <ahdrlb7wvcr6aczgrhiwuyy7ahi4ahvvv26aweucfb54hmwszm@f5spdkm35xab>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-2-0fa0bfd8d315@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-mahua-gpu-v1-2-0fa0bfd8d315@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab643dc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Le0wDFEDRhIWofPBaA0A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Ck_Y1q5UvCDVtDY-LcHUkYBgs2OrAbz-
X-Proofpoint-GUID: Ck_Y1q5UvCDVtDY-LcHUkYBgs2OrAbz-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX9/F1PnM8yGxU
 53qg3tKmgIGn7R0ac6rUxfDeRtsUaJQhx96rIYLnSuAZr/+HTeIqEHzaLRCQR01BWD22N1gWxC5
 JEchLQyaH6dRfwdcX2HbgdU2qlfslreEZ7dXBY/8crllZ88AjWu3Xiab6cPxCleGsh//EVernl1
 IITbGdRDdWgIPFpjVesKlt3y5OH9kWcsAo+uxnHeZr1B48YcmRRPW1KdEuQr0iJ/b09KbQ2Jw7y
 RmjAylQcFlZY2GHVxuscL39z7h05JEcav8N1E12a066vQw9SeVIRQ88dwdlyTA2gmST8nyUojs7
 FonYyOA3X7syic8N1jVqgeTPl6LOPVTc2KYRXhIA+9pLuMr5zPMLCgHrB7KfFwnQrxo9F2X/wJb
 qG+aHAAtqqr5TqgH4NxpYjgwr0DvMfBFyEtqY/kJrRO8CY6rXKPoShrbui6qJGt1IGiC57M21Sl
 IOW84RJhCooXHaQEycA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX21ZPjmxvkxrU
 5T1tjJoDR/3LbBc8uRYneAaPbESsXphzdn3yBpuTMxiF8D53ALG+QWLX5ARB+qmL4ekDfdA4yRQ
 zUblCL978u6tXCaNB0AGRhG1kYYTcI4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250039
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

On 26-09-25 02:44:33, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> The Glymur's GMU compatible was set to the wrong string
> qcom,adreno-gmu-x285.1. Correct it to qcom,adreno-gmu-x290.1.
> 
> Fixes: b6ff8cec8aaa ("arm64: dts: qcom: Add GPU support for Glymur")
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
