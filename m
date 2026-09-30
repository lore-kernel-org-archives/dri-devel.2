Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5D1CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C32C310F3C5;
	Wed, 30 Sep 2026 13:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f75smee+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mm++AGst";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2621F10F3C5
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:26:06 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB7bKJ3135730
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rTFZ+94GSRBJuyoD+wrNMMpG
 yUNudG4vyWgC2Rkm6Ck=; b=f75smee+50t5q3IKcnQ/mg+gxjlx4ShMRjry0WZu
 u8SHcOF8sna2xcAlgWACllk4qaXzy4K1QAxvOzYDA8uu81buftR67xrmzpMz1RNf
 NPfjdsTb3ZRBiHpw/1EX0tHEh+zGk87WdFMlPBliKzcksYoKG/gjAOEdcZ2JpHWs
 quOMf3jTiAZvD5EwOOL1kD20D51fD6cR4NoFCcoST6Lk3RuHLH+bEVz8g2p+TXaf
 tTNaIZJln9b6PhHN30KbqfcN9yVKthMYNQLWYpQCowq4uMCZgm2uLU2k8R/xViby
 l0Khcg52yyyI7O9KzIFrLx3YLdwTyhUITquQz9Or7LpCMw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x27hkng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:26:04 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-980c3b71002so4157003241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790774764; x=1791379564;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rTFZ+94GSRBJuyoD+wrNMMpGyUNudG4vyWgC2Rkm6Ck=;
 b=Mm++AGstMi5uxJz5h5VgpsmVPcwDR6PClOqTUEJJWAfuyQfOeZdVZnGvhWz0hiQ/jn
 KZLPLImKZjrHuSuuyOwx7YboXiJUPxkZSBmugPgcisSrDeQBoHqQSAjrRLENpBfuMHK8
 9qPyBfO7feXl+5iRFkaNi6D+b1SXtSO0QpLGJzXA814mEdCJ/JlkXnZK8rVAY8V9lnKZ
 nhTSOXo+Gxmd/8L3mT+7geSnslhe9MfvgSjvrDEa2HT2iNaagSAi1O9NUPBCtjGhzuVO
 j1sxHatVrFwmntZraVZBdcEHOfBtrZ/0tLrnm8S1jSmU5+MG9gKgeVmky5xVshkW8xyM
 5+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790774764; x=1791379564;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rTFZ+94GSRBJuyoD+wrNMMpGyUNudG4vyWgC2Rkm6Ck=;
 b=N4rfASrNIx2MQpZGOgWncJ1YTKU2sDSdaix/v5FCXLSeXWJ4YffZpOxbvASUCsR54r
 hXQ4ZrLtmbT4OEYS3/zproW/yJVO8ftXiGIETYl7sX/8iu3FNBH6dxKaziVYKC5new1q
 jKuXJy2/7aAwz0r4SrcdHSj6wmeZmO0wHj5MAVedQEizkCLOQAkUcej7xskno/Dx5h5K
 VQ20VqiFWEvBDfw8ARY+53fSsGyMkRLoDJkDuyT/qSq4TnRzVMrdV7ufyx6vRZpPp/FH
 Mos2s5aAiWBanMYYRWSHjbyKmSZD512DsqtQB1Hft93iNxMpU99cuB20E+v+LryEh0R1
 fJXg==
X-Forwarded-Encrypted: i=1;
 AKwUvByEiNDQXirFO6zLLvAxGDqjQ+/c28NmZDakvB6OIQOC/tXXzFKITz5+O27aiIWsooDyhLZzUbJhR/o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJVPogoR8DJsERXRJI7EFEKoDrCb3rkZrzGBY8MqOEHPdoFtHhS
 pVZxfskLxAvdo++qATFOyAu08edRFZZByGS6CVYN56bmuTp1RmA17a/XwXsP+/8HYbYLFMAp+xM
 eEphrRIkXrObCFORMyyzl3DMYlzeVB+SLcyZksBKlKWhknloOLV+EMQZEXQJK8MWN3gsxE0E=
X-Gm-Gg: AYBFou3IH4SeVUb+Pq/rTy2LQJmWvjUlzZ81oc3C1FOxeElSgL50uYN5ydwPPOZlo1/
 AWhJkieYODWkN/soG8faI/IkE9qer4Uje2SGYVDu6LYXXtoE/WSPOK0mk3rA7g15LsU6H3/bN+A
 mt8kgUSyGFWTueKZjX0/ukQ4fUXXUJZw5rNNRM53PQVTw1zDMKH+RH9qih7s0qqk/kyz8iqu1jB
 qJbjZGsSOrztoUdPi+yjC4Aks8GkoWNlNpGJcaMMObrZJQvJu53aUddkBx7PlThCUA4TKePgvb3
 mBcn+rUHVyX7mNPLNhCkMcqqtWtRycB3kD98fxFeCVeTIGa1X9c1wyjcpBue1ZIohQqkk2+AQHP
 k6dx3oTQxV/Ren3n+PnraRoVs9aepIHRW/n8F2vNhLQfqGRsHTPNojzxb0dGvoVXSJZIeGULhPf
 p6aA0XTP2h6Rd+
X-Received: by 2002:a05:6102:4426:b0:7a1:f7d2:e82a with SMTP id
 ada2fe7eead31-7be7408460fmr369585137.35.1790774764256; 
 Wed, 30 Sep 2026 06:26:04 -0700 (PDT)
X-Received: by 2002:a05:6102:4426:b0:7a1:f7d2:e82a with SMTP id
 ada2fe7eead31-7be7408460fmr369576137.35.1790774763763; 
 Wed, 30 Sep 2026 06:26:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba3fbf2045sm340399e87.35.2026.09.30.06.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:26:02 -0700 (PDT)
Date: Wed, 30 Sep 2026 16:26:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
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
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 01/13] drm/atomic: Handle max bpc properties before
 connector state allocation
Message-ID: <quiwrspvimu5piokdswwqmaovv7arkr5swndnwjxhsgmipp6zc@itciwqnrilc4>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-1-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-msm-dp-hdr10-v1-1-dbbf8b2b42bc@radxa.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1MyBTYWx0ZWRfX9po8xH7b1gh+
 DnrMUIk0f7hujVI+PzCynSc7AocYx39VYwiQGvapeACxN2FzTg5+2B74tMq0B37vH3KlWsk22OK
 QCVJy7p7Mq+uyopJ/hqa82cLHXVQTV8=
X-Proofpoint-GUID: QyQUx_BRcAUOafPLn9RL_t-f56vcoPxu
X-Authority-Analysis: v=2.4 cv=W9GtxhWk c=1 sm=1 tr=0 ts=6abd0dec cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=ksxQWNrZAAAA:8
 a=A3JNbwhL2pmTzrpOqxEA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1MyBTYWx0ZWRfX/BrOrhgqruKJ
 FquFYEGDIdS/MPA6j37QprN2+LnA7XgitRCw6vIzUUxgCgi4LlT1S1QHVVgLehjCMNTNFGEpQ23
 KXphgu+xLKP8VmyfrJedfu7cqppcfq+gdwKl8tjU+infM8My6sMbptu/aTX6GbI4kKvLFMmVDrF
 DnPrRKVSuByzNr+wvG9zpO2yjwGT90bRKS7x1OGVjAr7n/KPHQ2SqWZtl88/cVG23i5rlLEXMzW
 qNahhomzZ1VniNU8A9A3A3VG/05pgmYqJp+ZF+kR3gTnM7xUFovv6jGveybovjDc2YiKFepAn1u
 OQSp9ctcLTHaIz5HSRArvQ62Vh58VrnGXzswPmANdvgO4GG5K3c8aeHasfmioVFdb2oNMJqT6fY
 13ggCxBk7WOVOr8qff9qGnT/Ll+KwIwJH6yYUPrsDHAmZXDxFxTfncPI1DUiKWfRpBPXkUBaSb1
 VSFHvVQYgRXxLVjUgAA==
X-Proofpoint-ORIG-GUID: QyQUx_BRcAUOafPLn9RL_t-f56vcoPxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300053
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

On Wed, Sep 30, 2026 at 08:41:45PM +0800, Xilin Wu wrote:
> Bridge connectors can attach the max bpc property before their atomic
> state is allocated by drm_mode_config_reset(). Unconditionally updating
> connector->state in drm_connector_attach_max_bpc_property() dereferences
> a NULL pointer in this case. Adding max bpc support to MSM DP and eDP
> exposes this during display initialization, before a framebuffer console
> is available.
> 
> Only update an existing state when attaching the property. Initialize
> max_requested_bpc and max_bpc from the property range when creating a
> connector state so that deferred allocation and subsequent resets both
> restore the default. Avoid leaving the bit depth at zero after reset,
> which would otherwise cause valid display configurations to be rejected.
> 
> With MSM DP max bpc support applied, this also restores boot on the Lenovo
> Yoga Slim 7x.

Hmm?

> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Can we rather update drm_bridge_connector_init() to register this
property in non-HDMI cases if max_bpc is more than 8?

> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 5 +++++
>  drivers/gpu/drm/drm_connector.c           | 6 ++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 

-- 
With best wishes
Dmitry
