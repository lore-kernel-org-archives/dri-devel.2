Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71135C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 23:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BCF10EA6E;
	Sun, 13 Sep 2026 23:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KjAgGAPg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Afkh7wmq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B688010E0E7
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:45:41 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DNYGEr2357976
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uIppl4N+WY/n0iZ5p2U3JRnXKjA+shABwFxLcxaGkwU=; b=KjAgGAPgJi7FdI5q
 zV6N+B45qD/7OXwGt9z25VG2mJnd/R7JOWIPMyXqWy3jy6M5OWpRVcpuGgxfSR4X
 rEw2WLHVFtXS038NM+dfDYFZnnpXiHQNNwXz0cLO1zFKt1jyGR5ExR8vWI4ETZV7
 d5t759RW1ZTGzPuPfFsox9LZHopxsXV/BnWrAGliICLDSbmtmv026YA8meEFoHhu
 mebAjiS5d6L0mqJyk2tRAUgjzIji2XnIPyYWX0PhmlOVNpQy97YO06rOTwCiU7dK
 a7nBFuRbte/LkpwLgdxU8qCgJh+Tl8sBsHz2wAu3OgkvHB1sRny0mOg7Ku+/zRR9
 Q7p72A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gn018m7q3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:45:41 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-78580a6b2fbso895763137.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 16:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789343140; x=1789947940;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uIppl4N+WY/n0iZ5p2U3JRnXKjA+shABwFxLcxaGkwU=;
 b=Afkh7wmqMfwAfcsLwB2ZP0zYgTIvjZXPU+2iuxl6RyPFBhqPTQ7h1uX7KT5o4ZWW22
 ytde2xlpVwOi7BUdRrGYp9L2Gk2ZGu956Mv8bQPvosKzlAcusFt9ozF5Cm3zmsH5lk5w
 gm2vPw9DFsbZBU0PiSLr+nHt/85Ej3bIA2oMPEJgzxhO0KUBUhe8vQStxWFm0aJEVxqn
 fS7fWAZHdNJ3mpNgMb1lkp774v9MgdnBmKgDzWvr6iDAjZ61Eoe+q0WTRSBS4UUanMo5
 GykL8x8Y1NkJ/Ceqvxc9bmnxwVMZeCQJt1LVQWIUvLdxaQ8Y1aI4hVnsCGDZpPkRjiXC
 y1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789343140; x=1789947940;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uIppl4N+WY/n0iZ5p2U3JRnXKjA+shABwFxLcxaGkwU=;
 b=Rslv9KKBEVAzCN2MZNp2JL1Oo2SbZqIDSbzL8oV4h5diY73/m1Iz6OIn6ByqWNET/O
 H7lj0Oq09dfJNgs/ReuZCVGVhmzE5u8gQRQO773NMgvRfxWmo7ufaMt1fU6NKq/Xw0XJ
 OvVd+dZrpkGXis0hMIItQZ/AN6Ww437/VKCgKg95G/u4fp077nDXd92FCVr+/qS5QDmt
 xz5JroznVgM6nIYjnRZSt4NuKmQMyG3VDqV7IOmzFYFjd+Togt8E64v3CqBjomNpsR1Y
 Dex9DYPimaYIYoN4nolSKr73z8w/oMNXa9ECEKcc/8TBTDbLoBb4vmhD8A4bMrZh94XY
 Pz9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNzqrD+ISDfG9g2YOelnU9q8nOMzq0iNxigbUCOx+vU3ECcRL6eobXNu+8EplcwmopRkRJjnauzgU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mM+OzxswPHdepdCrItoKJtkt1NgNO39llqtfFWVUGam7tyfRr4
 RlWr6cr76jZI5LdCsoCyGNyPyzLxmDfJ/83rZr9gAiJ41XqVG0UVkYjGbZg6nGDlwOvbxnsPd2j
 01YONhNPcEdeJeAiTu2T2igUop9c9roRN69nS/pWVnHLv1odP2jLTJ7UbpTjTyESYB1LDmHk=
X-Gm-Gg: AYBFou0W3o9QjVVW0+mplOk7e66m30QukRl5ON1MS4mQs5sgkE+0LDzD9CE6R3Vs9CL
 QP9OYe1ckFhHqSSI38tHUK1tm/u8vCyUeT7cvnVehbkPQ9AJ+ZRb5Xln/sb1HqvmCpWZOhCj+8n
 jnkaZxGicQ0QJEpTR18Js/lD+avw3ny1PTs4y8l9SwW8uqSONVEaU1QSyL698PmTYB9Sgmemc4E
 PAzmiaPJObG0X1irgJSH1I0XhRqA/sTkScF1Fs5tNw+NJMNa5GKSiuFtAO1zeTeYYnkLZq6nhNO
 k7ObyrHj/+taaRkEaiMNKf6VajGl6qTdZFyJYjiupZ4/fS/9/s/H+2JUjlSLay8/BfvwpcA5RZP
 YaCD0TQpcYU2bfFCbK1l1jVnFOuV0+PPg90JuY/Jn6iXM+nr4Xdk7G/FrAfv2VuTF4UWFJ4VeuO
 2bH+SCIdxX3rRB
X-Received: by 2002:a05:6102:5607:b0:790:c7bb:43fd with SMTP id
 ada2fe7eead31-79b5bf316f7mr9008137.8.1789343139700; 
 Sun, 13 Sep 2026 16:45:39 -0700 (PDT)
X-Received: by 2002:a05:6102:5607:b0:790:c7bb:43fd with SMTP id
 ada2fe7eead31-79b5bf316f7mr8976137.8.1789343139111; 
 Sun, 13 Sep 2026 16:45:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a04568f2sm2075707e87.19.2026.09.13.16.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 16:45:37 -0700 (PDT)
Date: Mon, 14 Sep 2026 02:45:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 04/17] drm/msm/dpu: Add support for DPU 12.1 on Nord
Message-ID: <bqoezyuyrjiawudbwxybvjpdun5f3fmhhzukdeg2holuc2mykq@oa5mhoylopz7>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-4-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-nord-drv-dt-v1-4-e25c073cf1b6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=c4g+0h9l c=1 sm=1 tr=0 ts=6aa735a5 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=99Y8_FLkFjoiQTscg30A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDM0MSBTYWx0ZWRfX7fQ3v/yTAkRh
 5oqvWPqxaVxX78gZR1WR56cTzR+f5odskhhI1D1bsbOvM/mY8pEgW3QW+G4iznsrYpWHBjGjie5
 sDzRJ0bzimFTQcjxftOEsKdMJ3oB6GU=
X-Proofpoint-GUID: SX1KJlJl55wNNUtJusrNHjoSaHtHdOua
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDM0MSBTYWx0ZWRfX6LG8og5aSYN3
 CM62Ni779kkjN8BcSDAS8V0xFlss6s6Qc249cZ1rIZnIkNnyrMUJrpUZy0qM5CBiMw2Rp/SQGMC
 rW51yLsUfODGG3CSgrM20x8YKb5XObD59xaC+xBnmK+NfTUL6c4GvuAF1ZDV0tIHgbXGKkbrXwV
 Mv5w4b3V1lwvFDP04hpaGyYhn4nEJ3PXXQdo7T1zGzyOZV7lag5d8qQvRHrJBQQYgS/VRm9Vqk/
 AYzs2uM2HmR+CdGDSf2yl84kP9TjsbpXicXRLidH8mxI0tJ29TEXiPdKlp69x6E2XOuO3u9qjQB
 7qQfenLnRrsd1q9cD1j3I76WEIwmcY5/883gVk8sMzJZrmeJgUi+16IK02gqln5j1PHojrAk42w
 j1F1xEg+zUVUqH2G4S6WWV7iHV0FFQEupX+UUzDb4qsI7zMvGx2yrUVZjLH0qY1Wc8Yq+/GYSHs
 Oz5jt6UowKoHZSIwuPQ==
X-Proofpoint-ORIG-GUID: SX1KJlJl55wNNUtJusrNHjoSaHtHdOua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130341
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

On Fri, Sep 11, 2026 at 09:06:35PM +0530, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add the DPU catalog entry for the Qualcomm Nord SoC (MDSS 12.1, DPU
> 1499A). Nord is DP-only with no DSI, and provides 8 DSPP blocks, 2
> writeback blocks, 8 interfaces and 2 DP controllers.
> 
> Extend enum dpu_intf with INTF_9 and INTF_10, which Nord is the first
> platform to use.
> 
> Note: register addresses and xin_id values in the catalog are borrowed
> from sm8750 and precedent platforms and are marked with FIXME(REG_ADDR)
> and FIXME(XIU_MAP); they need verification against a real Nord register
> map before production use.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h  | 588 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  5 files changed, 593 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h
> new file mode 100644
> index 000000000000..8eb18752f3c4
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h
> @@ -0,0 +1,588 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.

Follow the guidelines please.

> + * Copyright (c) 2015-2018, 2020 The Linux Foundation. All rights reserved.

Oh, really?

> + */
> +
> +#ifndef _DPU_12_1_NORD_H
> +#define _DPU_12_1_NORD_H
> +
> +/*
> + * NORD DPU 12.1 catalog header. Generated from hardware summary YAML for
> + * MDSS 12.1 - DPU 1499A (Nordschleife). This is a DP-only chip with no DSI.

You already said that in the commit message.

> + *
> + * All register addresses and xin_id values below are borrowed from the
> + * reference chip (sm8750, MDSS 12.0) and precedent chips (Lemans, Glymur).
> + * Nord's YAML provides only block counts and feature statements, not addresses.
> + * See FIXME(REG_ADDR) markers throughout for borrowed values requiring
> + * verification against a real Nord register map before production use.

What? You work at Qualcomm and you can't verify this against the memory
map? Please cross-check it and also the number of blocks, hardware
capabilities, etc.

> + *
> + * Key differences vs sm8750:
> + * - 8 DSPP blocks (4 full + 4 lite) vs sm8750's 4
> + * - 2 writeback blocks (WB1, WB2) vs sm8750's 1 (WB2)
> + * - 8 interfaces (INTF_0,3,4,6,7,8,9,10) vs sm8750's 4 (INTF_0,1,2,3)
> + * - 2 DP controllers (DP0, DP1) vs sm8750's 1 (DP0 only)
> + * - No DSI (removed entirely)

No need to. If you want, put it into the commit message.

> + */
> +
> +
> +static const struct dpu_lm_cfg nord_lm[] = {
> +	{
> +		.name = "lm_0", .id = LM_0,
> +		.base = 0x44000, .len = 0x400,
> +		.features = MIXER_MSM8998_MASK,
> +		.sblk = &sm8750_lm_sblk,
> +		.lm_pair = LM_1,
> +		.pingpong = PINGPONG_0,
> +		.dspp = DSPP_0,
> +	}, {
> +		.name = "lm_1", .id = LM_1,
> +		.base = 0x45000, .len = 0x400,
> +		.features = MIXER_MSM8998_MASK,
> +		.sblk = &sm8750_lm_sblk,
> +		.lm_pair = LM_0,
> +		.pingpong = PINGPONG_1,
> +		.dspp = DSPP_1,
> +	}, {
> +		.name = "lm_2", .id = LM_2,
> +		.base = 0x46000, .len = 0x400,
> +		.features = MIXER_MSM8998_MASK,
> +		.sblk = &sm8750_lm_sblk,
> +		.lm_pair = LM_3,
> +		.pingpong = PINGPONG_2,
> +		.dspp = DSPP_2,
> +	}, {
> +		.name = "lm_3", .id = LM_3,
> +		.base = 0x47000, .len = 0x400,
> +		.features = MIXER_MSM8998_MASK,
> +		.sblk = &sm8750_lm_sblk,
> +		.lm_pair = LM_2,
> +		.pingpong = PINGPONG_3,
> +		.dspp = DSPP_3,
> +	}, {
> +		.name = "lm_4", .id = LM_4,
> +		.base = 0x48000, .len = 0x400,
> +		.features = MIXER_MSM8998_MASK,
> +		.sblk = &sm8750_lm_sblk,
> +		.lm_pair = LM_5,
> +		.pingpong = PINGPONG_4,

No DSPP's?

> +	}, {
> +		.name = "lm_5", .id = LM_5,
> +		.base = 0x49000, .len = 0x400,
> +		.features = MIXER_MSM8998_MASK,
> +		.sblk = &sm8750_lm_sblk,
> +		.lm_pair = LM_4,
> +		.pingpong = PINGPONG_5,
> +	}, {
> +		.name = "lm_6", .id = LM_6,
> +		.base = 0x4a000, .len = 0x400,
> +		.features = MIXER_MSM8998_MASK,
> +		.sblk = &sm8750_lm_sblk,
> +		.lm_pair = LM_7,
> +		.pingpong = PINGPONG_6,
> +	}, {
> +		.name = "lm_7", .id = LM_7,
> +		.base = 0x4b000, .len = 0x400,
> +		.features = MIXER_MSM8998_MASK,
> +		.sblk = &sm8750_lm_sblk,
> +		.lm_pair = LM_6,
> +		.pingpong = PINGPONG_7,
> +	},
> +};
> +
> +/*
> + * Nord has 8 DSPP blocks: 4 full-featured (DSPP0-3) and 4 lite variants
> + * (DSPP4-7). The driver has no separate lite-DSPP struct, so all 8 are
> + * modeled with the same dpu_dspp_cfg/dpu_dspp_sblk structure. Lite variants
> + * have reduced features, but this is handled at runtime via feature flags,
> + * not via separate catalog entries.

Is it really handled? I don't see it.

> + * FIXME(REG_ADDR): DSPP4-7 base addresses extended via 0x2000 stride from
> + * sm8750's DSPP3 base (0x5a000). Verify against real Nord register map.

ROFL. Who is going to verify those?

> + */
> +static const struct dpu_dspp_cfg nord_dspp[] = {
> +	{
> +		.name = "dspp_0", .id = DSPP_0,
> +		.base = 0x54000, .len = 0x1800,
> +		.sblk = &sm8750_dspp_sblk,
> +	}, {
> +		.name = "dspp_1", .id = DSPP_1,
> +		.base = 0x56000, .len = 0x1800,
> +		.sblk = &sm8750_dspp_sblk,
> +	}, {
> +		.name = "dspp_2", .id = DSPP_2,
> +		.base = 0x58000, .len = 0x1800,
> +		.sblk = &sm8750_dspp_sblk,
> +	}, {
> +		.name = "dspp_3", .id = DSPP_3,
> +		.base = 0x5a000, .len = 0x1800,
> +		.sblk = &sm8750_dspp_sblk,
> +	}, {
> +		.name = "dspp_4", .id = DSPP_4,
> +		.base = 0x5c000, .len = 0x1800, /* FIXME(REG_ADDR): lite variant */
> +		.sblk = &sm8750_dspp_sblk,
> +	}, {
> +		.name = "dspp_5", .id = DSPP_5,
> +		.base = 0x5e000, .len = 0x1800, /* FIXME(REG_ADDR): lite variant */
> +		.sblk = &sm8750_dspp_sblk,
> +	}, {
> +		.name = "dspp_6", .id = DSPP_6,
> +		.base = 0x60000, .len = 0x1800, /* FIXME(REG_ADDR): lite variant */
> +		.sblk = &sm8750_dspp_sblk,
> +	}, {
> +		.name = "dspp_7", .id = DSPP_7,
> +		.base = 0x62000, .len = 0x1800, /* FIXME(REG_ADDR): lite variant */
> +		.sblk = &sm8750_dspp_sblk,
> +	},
> +};
> +

[...]

> +
> +/*
> + * NOTE: Each display compression engine (DCE) contains dual hard
> + * slice DSC encoders so both share same base address but with
> + * its own different sub block address. Nord retains sm8750's
> + * topology of 8 DSC instances (2 per DCE × 4).

Tell your AI to stop adding useless comments.

> + */
> +static const struct dpu_dsc_cfg nord_dsc[] = {
> +	{
> +		.name = "dce_0_0", .id = DSC_0,
> +		.base = 0x80000, .len = 0x8,
> +		.features = BIT(DPU_DSC_NATIVE_42x_EN),
> +		.sblk = &sm8750_dsc_sblk_0,
> +	}, {
> +		.name = "dce_0_1", .id = DSC_1,
> +		.base = 0x80000, .len = 0x8,
> +		.features = BIT(DPU_DSC_NATIVE_42x_EN),
> +		.sblk = &sm8750_dsc_sblk_1,
> +	}, {
> +		.name = "dce_1_0", .id = DSC_2,
> +		.base = 0x81000, .len = 0x8,
> +		.features = BIT(DPU_DSC_NATIVE_42x_EN),
> +		.sblk = &sm8750_dsc_sblk_0,
> +	}, {
> +		.name = "dce_1_1", .id = DSC_3,
> +		.base = 0x81000, .len = 0x8,
> +		.features = BIT(DPU_DSC_NATIVE_42x_EN),
> +		.sblk = &sm8750_dsc_sblk_1,
> +	}, {
> +		.name = "dce_2_0", .id = DSC_4,
> +		.base = 0x82000, .len = 0x8,
> +		.features = BIT(DPU_DSC_NATIVE_42x_EN),
> +		.sblk = &sm8750_dsc_sblk_0,
> +	}, {
> +		.name = "dce_2_1", .id = DSC_5,
> +		.base = 0x82000, .len = 0x8,
> +		.features = BIT(DPU_DSC_NATIVE_42x_EN),
> +		.sblk = &sm8750_dsc_sblk_1,
> +	}, {
> +		.name = "dce_3_0", .id = DSC_6,
> +		.base = 0x83000, .len = 0x8,
> +		.features = BIT(DPU_DSC_NATIVE_42x_EN),
> +		.sblk = &sm8750_dsc_sblk_0,
> +	}, {
> +		.name = "dce_3_1", .id = DSC_7,
> +		.base = 0x83000, .len = 0x8,
> +		.features = BIT(DPU_DSC_NATIVE_42x_EN),
> +		.sblk = &sm8750_dsc_sblk_1,
> +	},
> +};
> +
> +/*
> + * Nord has 2 writeback blocks: WB2 (matches sm8750) and WB1 (new).
> + * WB1 base and xin_id are inferred via stride from existing WB pattern.
> + * FIXME(REG_ADDR): WB1 base address inferred as 0x65000 - 0x2c8 stride.
> + * FIXME(XIU_MAP): WB1 xin_id set to 7; verify against real hardware map.

ROFL

> + */
> +static const struct dpu_wb_cfg nord_wb[] = {
> +	{
> +		.name = "wb_1", .id = WB_1,
> +		.base = 0x64800, .len = 0x2c8, /* FIXME(REG_ADDR): inferred */
> +		.features = WB_SDM845_MASK,
> +		.format_list = wb2_formats_rgb_yuv,
> +		.num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
> +		.xin_id = 7, /* FIXME(XIU_MAP): inferred */
> +		.maxlinewidth = 4096,
> +		.intr_wb_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 3),
> +	}, {
> +		.name = "wb_2", .id = WB_2,
> +		.base = 0x65000, .len = 0x2c8,
> +		.features = WB_SDM845_MASK,
> +		.format_list = wb2_formats_rgb_yuv,
> +		.num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
> +		.xin_id = 6,
> +		.maxlinewidth = 4096,
> +		.intr_wb_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 4),
> +	},
> +};
> +
> +/*
> + * Nord has 8 active interfaces (INTF_0,3,4,6,7,8,9,10) with no DSI.
> + * DP0 connects to INTF_0, INTF_3, INTF_6, INTF_7 (4 ports for MST).
> + * DP1 connects to INTF_4, INTF_8, INTF_9, INTF_10 (4 ports for MST).
> + * Interfaces 1, 2, 5 are skipped (removed from sm8750).
> + * All interface base addresses extend the stride from sm8750.
> + * FIXME(REG_ADDR): INTF_4,6,7,8,9,10 addresses inferred via 0x1000 stride.

Same ROFL. No. Do your job, please.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index 0e65bf5ddc4a..7eccb4d2c65e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -226,6 +226,8 @@ enum dpu_intf {
>  	INTF_6,
>  	INTF_7,
>  	INTF_8,
> +	INTF_9,
> +	INTF_10,

This just broke DSI tearing support. See enum dpu_hw_intr_reg

>  	INTF_MAX
>  };
>  

-- 
With best wishes
Dmitry
