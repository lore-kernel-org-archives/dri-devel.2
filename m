Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881B7107BCF2
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F108310E76E;
	Wed, 18 Mar 2026 10:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+31vjTN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvGshqr2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD99E10E76E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:33:21 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I6ZQWf2878341
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fWLzgEvejqGVEZGku9WVSoRg
 A2RFcsMHbrkalg+j/Dg=; b=T+31vjTNEvnXwl8KgH4SaE18eAGRW02ns+Di28GQ
 kai4hsO0X/AoLIClJDd+AgDUbTUUPD+eNDX8Q81EDakIQikklY7Vix56fh2VFGu9
 6Jj8LALCPXI8PCBxdnbQSRli/lvSKtJOlzgbLdCVLtsyMbWXqY6UhQO2FNoyEHE9
 8fi+qC95sUMVb71L2/hn+vwDozERreKUY4k9+vyQqi2GDcwoQR8muZKwrbII6t0z
 Cv4HtNNSnQYthhWnaLNuJMnkEZJPEJYnp+zrDUbXZSIdByCQ3wC+qKqrUNnAXnEf
 jZJcXS2kfqAUaXGY8tagSzxymWEJXiVoWuYukvy4TxYzcQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cypwr120m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:33:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50939597b85so30452651cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 03:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773830000; x=1774434800;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fWLzgEvejqGVEZGku9WVSoRgA2RFcsMHbrkalg+j/Dg=;
 b=gvGshqr2sFeg6y9s8y9L7AgA5aj2GgCeY6s+xjvUagvMM8ofyrDb2L+x+3eNW3Y+R5
 J46fKA+oA6QlcrcmotYNKvoWBu6YLpqOXNU0AhF4ZIrwfY9iH4v8ZiHtXx2ykAzBNcXo
 m0I1fye4mgURdh11c2vTApAO1RN1Y4aMKuj6JqjIbYTvywLcE4w6QpPLxexPAhsUf3na
 IT5c+dsvjWdW4DcWk6422TQCmX1paU0yqHVvUB1A4vAiuPNkAYQqmQtgF0ZGeYoUwqjG
 I6TYf3On3WDN7d8Xcyq0Bwfbe+hR6w7zZukRU7rMOwr7etHjwOJZOQRoavzh1wykO9wV
 HfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773830000; x=1774434800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWLzgEvejqGVEZGku9WVSoRgA2RFcsMHbrkalg+j/Dg=;
 b=oDciWzlwk/eK+sfUj1MTYFPVo4+TP+4UobexVuyJ6CNJB/nlpYRqJgpIUgLuD1K8/T
 vQC/lXUyrZ7XjWasSymX1tG2FsCG7cRdS+y507tLEtCF50ZLvLPIlf8qtmIYGVNqVggI
 toH+FqLb7xBgTEGyU5vfDpADtRKPDO2FIS5Sk6gfqXjcjHST4EN67om55soYHn2psFBZ
 zY/MCcArWMZqeVIZXNraqKIrWJqBbnsvgaYQWhNWUYB+qWWRO5MPJ3dNYmSVeXSX4Lvv
 NFn+ZpDPRiJcgggchDtddq6rjWhfLxSv2KWXV1iFClitX0udpzdOshZfEhaLtSyhtakx
 dkNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEKxYXPro/W39641tNpwzIeOBK5q5671dPcqZgp5F7eoeacei4DL1L6W0qVtXwT7J9TUgdU/8y9PE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5KSuNDMyC6VTNkBQuENGUpE3UA8FYVFsEskSfMrWQcFKWwmFe
 ohcUl3JsBAxDVrK/5YwOv+rrfwrsjgKk65HD4ty7QD7B7Ldh4nCpo0s3CdZq5BVUCCcBN6UPg46
 8UoRxE1tkeYFwBaYvrNRi8Gp8aixV8uR+bO3pHL5owrilOMu8r7apL0fX1O5OOq9H58BQirI=
X-Gm-Gg: ATEYQzydHSsITwS9CzZpPjgNKoPJ+HmX+1WH0EjHYLl3iE9KBc7fHtCHAbk+PtuFdML
 u/I6LD+oefwvXZj2zUt3qoB0bWaZiXK8/w+v+mTa7g8bITRgksWAw97NQXG0EgKRolrbmlb9bcx
 sUF85KQiLergAmuLeLXCiYktw64jUEZelKz5o0qXw7aw18kN/dNkPZ8RUuL6jYyodRuLw9JOxaD
 nselX/Jk1cX9/SAGYWmY+JOV/MV5Dew0V1GkRfbAn4hlnH3UjpBfXe4POZugjkT7oqK1ymxo43E
 VP9ozT5jRs2ce7w7wmhSLAykwMNcPZk4Np/luA7ka4cDi50o9nE5CnI9qtgpaX8JbLaQfYiirQQ
 Xq7UZ5xGBBkmwdklrI0GgIenbGuf2CyPwHg/ZekxijwodwZnQe++b7Iucp5yB2wjt3TivoFcLca
 n3ugBcDC2QW6EEZimft4ohPl6Zess0XypImo0=
X-Received: by 2002:ac8:5e47:0:b0:509:13f7:6534 with SMTP id
 d75a77b69052e-50b1497327dmr33543171cf.61.1773830000346; 
 Wed, 18 Mar 2026 03:33:20 -0700 (PDT)
X-Received: by 2002:ac8:5e47:0:b0:509:13f7:6534 with SMTP id
 d75a77b69052e-50b1497327dmr33542711cf.61.1773829999901; 
 Wed, 18 Mar 2026 03:33:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd54d538bsm5512451fa.35.2026.03.18.03.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 03:33:18 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:33:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v2 2/2] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
Message-ID: <rsmy3hiw7acx6jkz5tlqxwv7cnugmdcly2eti4mnzlr456aldf@axdmfqz4ix5p>
References: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v2-2-0a1b316f8250@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-dsi-dsc-slice-per-pkt-v2-2-0a1b316f8250@pm.me>
X-Authority-Analysis: v=2.4 cv=bIcb4f+Z c=1 sm=1 tr=0 ts=69ba7f71 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=RAbU-raeAAAA:8
 a=EUspDBNiAAAA:8 a=a9twGay6vry5l8bUFcMA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=JiizpSU_mAIq9zsZDqn2:22
X-Proofpoint-ORIG-GUID: _OH3sNVjFLdDK6DFe2AbfFvMkrHEyCCD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA4OSBTYWx0ZWRfX5yirwHsj2Xtf
 wNfGxVbwVdShA1skID1XhaeIt77Q0dJuJGvDjyNTOQRRwnyudejctJUjgswUnztdOdSOZuzG5/8
 uqPB1Co+bXRzw1DaV/XZeIDXmMPeWs98oQOXJDtPHVc2c7bTOhSLVIGYMx9YMqxV4QMaK1UpHNF
 eeNzG8dkI6rNSHfYcFBLLU+eP80/I9+eIwTb9G2kWTbKF3SMsZaTprslSW5UJq2bWQKSpgkRAgP
 lY7FalEYrLEFRtx2c1aog0hDO59NLGh4CZ7VntzuKK3cA9OEdN9WKdz7dcRU05zicwOF9l+EdPV
 UpYCV0fTbQWbwMk+yAYL2mXpsngkX+dCGiOdylgqFKm7Sh4zT9FNfIDAcn68Jfucm6oI+O6tksw
 3s4oJWJyawBubafo8PnXg64P30GIUXGNcLCleW7ecuBuI4v1h1UdkEuqAeOtr6P31p3mGhuhqLB
 dyU+Nt33k5Wz2AGxIag==
X-Proofpoint-GUID: _OH3sNVjFLdDK6DFe2AbfFvMkrHEyCCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180089
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

On Wed, Mar 18, 2026 at 09:54:08AM +0000, Alexander Koskovich wrote:
> From: Jonathan Marek <jonathan@marek.ca>
> 
> Some panels support multiple slice to be sent in a single DSC packet and
> this feature is a must for specific panels, such as the JDI LPM026M648C.
> 
> Use the MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag to derive slice_per_pkt
> from slice_count, note that most panels are expected to just work with
> just one slice per packet.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
