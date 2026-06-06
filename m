Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7353CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 12:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10DEA10E65C;
	Sat,  6 Jun 2026 12:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MlN41s9K";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VrF3X62k";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C093E10E65C
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 12:04:20 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BEIoo1280398
 for <dri-devel@lists.freedesktop.org>; Sat, 6 Jun 2026 12:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=LgC2ILMkGYF/Iy0bZh6M4/Rm
 05l5mA+X3cLtGebpi+A=; b=MlN41s9KJW3HgOfVbGVxyUN8E8pzs00TpoNSSBzD
 +fi0PXUS4XxHJuvjII8pe9wdO2CpJH/3CuxWPRsh6MKWRtxoGNnwt1hjfmqGpOYb
 vbyyoheyBgokITw/ydDU45PAwHe1daYzzISUAVkUDPVvXkHBK7QTJjb1gAGGUH8o
 ZZtYF7KfJojwAlqEGR6h/J6XsMnmn47K57Kebg2G7Q8nGza7eaq3gmc1DWEU6EaT
 Tgf7Z32uQs2R8LA/tzUhoW5Y9aNy+bYtVinSuRmUBuM1xNdkZtxjx5kvg7NwYMqL
 73mzkXlSbls2fJwhkdKQls9FkOHm5n1RpU9t8si/vucw7w==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagr99dt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:04:19 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-963eeb6f2baso3055655241.0
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 05:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780747459; x=1781352259;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LgC2ILMkGYF/Iy0bZh6M4/Rm05l5mA+X3cLtGebpi+A=;
 b=VrF3X62kra8srcXf3qsPVcOc4G4rlmc/CZT/cKNTaflrMS9tBcwb4yVjiGJc4M2xrX
 3CyAT/EBoF7J4KqQAc6ka0OwvGros8GFSgMoRg12X+hp0xLn2qHyNzYQoedWB0MsSUV8
 M3cF+w+Z3fVC64tIxTAI4Jfqk2GlwaaYlmWuB6rxDKUEaKDJeyez71/CjY6kPnltW0UR
 Bou9MMH5eorOkFdjebbwVFN20B5NgUbGDGNM3D7s3xri2ATM72bpRpCX6OHUl0SxNmmK
 izLmTgdtFEO6WzVHeVvb/bNH15EgZDIR63ZgNG0oubRBOBMWKoAe2J5PQr/EBCg42nJt
 FH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780747459; x=1781352259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgC2ILMkGYF/Iy0bZh6M4/Rm05l5mA+X3cLtGebpi+A=;
 b=VvGpqGFsPVfruw6iSY5pi+bIk7hbP+i1UlweGB6mBofawpqz8zxkF498nO1if9Ag9F
 efx7ZwyC8YcCA03ux16oulcI1orJsBRLHSOcpydcDQijo07sL/HqOpWwJD3hOG5Bevwo
 sqyx5G+i8jK+DW0fK7Z6kZuvQ7/upiZVrhiESwP1UnLyMB5xLDmPu1RSdXgzZGuHvYM7
 1YmRutAg1aPZGAcgc1vdNQ0qOjcdaV1iP0j4EXwz7kSikhuU+lJyDpV8ODc3EFObNEiP
 pSeUWWY/yKT0q7HZl/U4AM2WFD2F10KiPR6iDALSmTvqVhgqsn7JOPZs4msDeZj3pxGX
 2gPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/N7M0DkGnsaq3JnXO4XYzeKmVt/c61SxP5v2WxDhLHZ5OSoLUuHeOcIyBUucP5GVOidGEvxfWdhDM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/IUduBAsehr+hEdOuIMEQeCNjvSRxd+PfminuC/GEN0LN5Xwt
 HJjHfLBKoSa+WpkR3eiTbNQjpX4z2mNVSL24fZtydMzub0kWzu68tCCDh3veodqum8b+4rw0gvv
 GboNizTyD7hMs+ICVS1/4WprnnME5Y3pUmRjtGIjDZpXnLVdZs8AOlvSZJlR07VCCk4XYimg=
X-Gm-Gg: Acq92OEwkrCuhnwvg3+65I87D2/fyw4ZgK/HI9bJRQbb7fDNPtlQWLwai2eqLM3sqzf
 /VeqdR0c555wUNLSlMwr08+9DhdnL/hjomuWNgaSzfi0bsCq+Lr97VgCm7h8ZCtKF/KEDmcDTL6
 r7OopXzQ1Vtt/iZ8fRIKwad17B5OVIetY5t3dzW0iR04wr++wKbiDd45zWof1MDWPm/yhbWEHNj
 X9QfwKLklL8e63K9HnsQgv7ZPQrg/QqelUu0JQNIPmyMv5lE7Aqd3MoU3t94j8DaHKzRIRT2PGt
 +3s3ThyLGL3OmOpTwA4eMV0V6H3phS46wBWIfpZJRC0APvO9mfWEBMMkhMQkZKOdov8D1fQvjXA
 SsYwUKLqS2mQv4QOfkz0qXpHD3vGi/jRymEJ0ckPmOGmu8Qh/F/7A0r8PsoHIfSd4Wb8yEu1Hcx
 6dLvtTYKZdOM3atVHQ8DNOUCVghBmnowXY5A2inMn5vZoCmg==
X-Received: by 2002:a05:6102:148f:b0:632:a084:c0f7 with SMTP id
 ada2fe7eead31-6ff084a6d6cmr2724903137.17.1780747458841; 
 Sat, 06 Jun 2026 05:04:18 -0700 (PDT)
X-Received: by 2002:a05:6102:148f:b0:632:a084:c0f7 with SMTP id
 ada2fe7eead31-6ff084a6d6cmr2724887137.17.1780747458451; 
 Sat, 06 Jun 2026 05:04:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2be04esm32468731fa.25.2026.06.06.05.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 05:04:17 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:04:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shivam Rawat <shivrawa@qti.qualcomm.com>
Subject: Re: [PATCH 1/6] drm/msm/a6xx: Fix stale rpmh votes after suspend
Message-ID: <vsgz7zf6zenvkgsrvclnsn666aviayecrxrcfnlqpf3tha7ecw@d5hacce4qc5v>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
 <20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyMCBTYWx0ZWRfX8Kv8gAYWKHFO
 TLVRk6LTNxcQqobmKYwfNiJwS4O1ihQDJqmZwfaL/pz6Reh/Uj4SX1sVULRfoyYu1sVpUJwVhov
 bYz0ZUdBS3cHLMFgteSOzYQWgSfM8FerpdpIoyxrZSpBiEirVnZGuic49lOIfT4pJO42/DMohue
 djmgxI6f+w8eAHRxVSyV3cn1xswGNtTCZkYJFsVDiyTXJ1/YJMQGYp653SNXXprIH8W1Ed4s8aG
 5UxCSvT7ot2d8OiWsmSCg/HIVO8TQWNYTnPDWbFM8/8LP90itALy2pg6JRq7xDZhzP5RkMXWhl2
 UJcQmOEtoGFILLwzvdcMb+r1xIQOeeAMuzW8T/1DsrU2p1Y8P3F3c3fudBjdcp21bnrMUIiBJb/
 qsQ+R9+VEPA3RmIObRi6luuFac29GqQQS0YD1UaASX2ML5sUcmK0mNe+51rI8i/+nOTStD4znBU
 kFw/MMO6agnD4pKIlvA==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a240cc3 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=npCoGp_I_a_DEMxlm3EA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: CR75z-DoyhGiktZq3O7uBWr6hES94b_P
X-Proofpoint-GUID: CR75z-DoyhGiktZq3O7uBWr6hES94b_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060120
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

On Fri, Jun 05, 2026 at 01:38:17AM +0530, Akhil P Oommen wrote:
> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
> 
> There are stale RPMH votes (BCM votes) observed after GMU suspend. This
> is because the rpmh stop sequences are skipped during gmu suspend. Fix
> this and also move GMU to reset state to avoid any further activity.
> 
> Fixes: f248d5d5159a ("drm/msm/a6xx: Fix PDC sleep sequence")
> Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
