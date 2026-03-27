Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09ED10ED64A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFFB10ED7B;
	Fri, 27 Mar 2026 11:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aiZ3X4Au";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="drrh+8Td";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D26E10ED7A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:14:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6wIr32538768
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uxLxManeS7atN005uiCmL1S0V1YPa5X8e8IyDg216fo=; b=aiZ3X4Au91H7bWdc
 zdHtyRuzh8G9TtTdPwdq8kF5K6y8gC6MS7SZnPTX0jfvdYrUzlcvBPt4eIxRdP+u
 kGUu8MAFBobUa7rDxsljU+aKbIv2KkcwyiiYl07RXQFtsqy6kl3fx8U1JqqWfkhj
 0uz0mlZlnTjwZcs9QtvwwCiZktu30pueRvCvcXRJbdie5jj/W7U6MXfLaAgzG9pY
 ANidTq9Rvn1AMzRiBurlC6mF9YPLm7Qm/c87icCKW1VRf3noMxf+WkOnHbTF9nRC
 W8tjflx5l50fmzTbNmB1CTlgzvLMUP5/ZvlB1VscK0Z8zC872mChBkwBa4r4gprF
 QLUnuw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5883kpwp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:14:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b2d15c360so4984891cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 04:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774610096; x=1775214896;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uxLxManeS7atN005uiCmL1S0V1YPa5X8e8IyDg216fo=;
 b=drrh+8Tdg7BiNSh3ClM5jSNU/u4WV+0C/O3qjD18EMvz1iG3FeY8JBTj7Gx36JqEhE
 hvNxa7WiYDDVKAZKGhKM+vKPEEjLRqe1ajoJACHjpbw4zqfP7/ETZA9Qvf//+qkXn80I
 qngyHB+qIH1dBMayXHxCRCi/imcuw6GfqpLiE/pDClJjgVUU1KduCFQFoF88OI5lImZO
 1OXhxNlNVGIvNiPV/YG79U8+W83xYSivn0w5vvUoOhLbZ8Lm6kq65g/fXdxN6aL+f0vS
 eMF0lRtRB72FCaNb4hMp7Robs6DcYvYuPF+kOymbzkAMV0OXhHhj1x99tf6x5/acZ3fT
 3vRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610096; x=1775214896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uxLxManeS7atN005uiCmL1S0V1YPa5X8e8IyDg216fo=;
 b=FxqaefZRidPuqNhjj1A+1Al2qVvDYuM2+Y2FUzGAMPbuxpdbmm6dz+/glbKbeGL9gV
 JZQs2hComAOKSo0K/lDLnfQui2H/AGwA/KTx08vlYpwHT2HJ6MR446J7Q99gIXow7m5G
 1/zQUOriqWKEwkoAKnRim+KZakUyhprFCLKZYCxgaZ+RDqaqGOTbkMGsBGjX2H3p3+LI
 BrFeWCxb86DsDFxKHcVM0YQEDdQAyGP9mqH3vanHJL7TgYi0Wc7HGuCjCEx2n5mPmaAB
 qslnqvfmGUpE51Kg/vuczl9mAjTr2PDnRqRa2a56Jn+X41PFJM9SugSvOZeaO4hjQmH0
 yeSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm9qZ9nvcJMQDGKZub7pcmooF/9M2dPxRLpbN49URlEXJXW5Z5lz1p10s+2FXVWo6KzPUTfWMIWd8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUaSZP6cwL/h5c0qIf2E+9YgDP8TWcn+y3so7sn7P28j+kdlgn
 TgKICUptEaz1IiCtZcDTwOL0cPWiHu8yxK9gKszbNLJK/JSq82PPsfGSYeZQmQ9YmLrKgxhTXLC
 qsatL9+U6gMtqcUgg7cBdOLOpmnUzhAOl2+LTfB75J9oXseumzPhazrAUQC7UmmU81l8L8NM=
X-Gm-Gg: ATEYQzy/tgC4DHH2PIbho8WNJ9l4PM9XWg20HfxJFtOX9OZptBEUtR9uD5mxF3BKYDc
 Dhw5lxQP52OAVX2frpiWy8cRVX7KIyXs1jNImc/Nx6ppwZW4k26+6Y6Hd+LN6JRg9oPCfHgQ9Di
 k9Sc9mpLbH/m33RR/xteK9QAFQQkmDOH53b9MjUEeKBCX+Ygv/vo2/WjRmawXsCN591+IyjiSq9
 l3/Bp5bKhf+mUk5ZJju2HMhn8hEgduh7S3a1guU4EcBcu9w4Gga3Kf5wFkg5gPHNigYpAqPH5A2
 z2poinHgILGE2vLamGfnlzHt7EV6E7Frcr6/A4NYmp2BFCJWrkC+h53k4WpSb1RVxGXT8CdRXgI
 8bb+xWubPEUiY0HfJin0DyZHUHUoNTeaDkAkljq44Rr+bH6pAfFXRMBEDzWfAjD2BMsnLUebVE7
 QEhH0=
X-Received: by 2002:a05:622a:1b8f:b0:509:39b1:d4be with SMTP id
 d75a77b69052e-50ba3905198mr18470151cf.5.1774610095705; 
 Fri, 27 Mar 2026 04:14:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1b8f:b0:509:39b1:d4be with SMTP id
 d75a77b69052e-50ba3905198mr18469821cf.5.1774610095283; 
 Fri, 27 Mar 2026 04:14:55 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66ad6c568cfsm2144120a12.30.2026.03.27.04.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 04:14:54 -0700 (PDT)
Message-ID: <0c26faa2-f5f8-4d77-a69e-5e18dc5b6e80@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 12:14:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/17] drm/msm/a8xx: Add SKU table for A840
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-11-2b53c38d2101@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-11-2b53c38d2101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZIeJD_yoru37dg56i4UU2Sp8b78EYKl6
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=69c666b0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Kh5seR-78j4Uxd7EPEsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: ZIeJD_yoru37dg56i4UU2Sp8b78EYKl6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3OCBTYWx0ZWRfX5uorjJZIHuDU
 gl7e1nQYxImtyW7m1pBnCnPhPIb7Hgkf4BVxEviefAXM4VFTVF/TWcGmyc2tG1xz1XTgvMOmtF1
 DdHZsJUPzMNoEZwz3miRX5P9zH4AEfvTWt1LlFgXWzn34//jCLuI+A/nV4ClGiHmnLz1BL33WfF
 nYDMmTdtsojVWLDDxbppG7IgD7O0/AYA5LnMgoS8rdFHbOJ4cpduSAV22vzyN5jPpVBMY6WQ5aU
 /j5BU2aO+DW7IS6UMwq+pWWxUymXiw2+DLv2VzwLBSduUe/ilH6cJEnM+xmz3uPi/5OBvy05T/T
 v09R1+38xUG+SqrtzXHwoEAEMiaOcQHlNf5jtOPPPAW1THfIkR8vgNjAoESBORJYvCzz+iTHnEQ
 9iLrOxZnCG/R36+R43Osw957X8vyq9OGf4quKO/NBM56woUE0KY4IwoeFq/UiTOeupcSfaywdLT
 ncHMSa7KxRtF5/R3rhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270078
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

On 3/27/26 1:14 AM, Akhil P Oommen wrote:
> Add the SKU table in the catalog for A840 GPU. This data helps to pick
> the correct bin from the OPP table based on the speed_bin fuse value.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 38561f26837e..f6b9792531a6 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1954,6 +1954,12 @@ static const struct adreno_info a8xx_gpus[] = {
>  			},
>  		},
>  		.preempt_record_size = 19708 * SZ_1K,
> +		.speedbins = ADRENO_SPEEDBINS(
> +			{ 0,   0 },
> +			{ 273, 1 },
> +			{ 252, 2 },
> +			{ 221, 3 },

FWIW downstream maps it like this

221 -> 0
252 -> 1
273 -> 2
default -> 3

although it's of course just between the kernel and the DT

Konrad
