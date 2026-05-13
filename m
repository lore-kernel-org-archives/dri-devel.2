Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E81CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C7C10E5AE;
	Wed, 13 May 2026 13:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ST+bNA2j";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jZKBCnAo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103AC10E5AE
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:28:26 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAST4x2338913
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=AFxNdVHWMzpghmBXs03WQEOs
 xxoCzZKFXvjRC5q0MAw=; b=ST+bNA2jVi/xhlG0SedFvO+P9Dtw7ut1XfAvGvdD
 r96ild2g809cZchhKiwfolSiEp0TfztWcnD5HRdCLPnhiBGh0wWibjpnt7kfrf2L
 NC+5VoesacJJR02Ll6Syr3BNXYNgvgo19URCyE+l/DR8IfQNrW/S5Xrr42HQGkXw
 ot0dFLWwrG0NGnxaO9xExuBQb6DYQ0y+NPQiqsTUeHxJek/0Y0bjTH+gCTft6uEC
 6BbfSjnBuUHQvuG0NRyMDegwc0SJkCdN3hlzqGXYyf8ZaVIIc8Al1a6pHx8QV2uw
 9iFO2k2a2nqYtxs5efGG7Inx6f0RjdeKhTm8ZhVVziyasA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vxbm5c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:28:26 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9569b029e1cso4350173241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 06:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778678905; x=1779283705;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AFxNdVHWMzpghmBXs03WQEOsxxoCzZKFXvjRC5q0MAw=;
 b=jZKBCnAo3IhAJTajLnqbBRKIVoxOI3YHs6JvgsRtfVMLPEt7Wytyr7s7ihFPRNUYI2
 HT83JbgARN8xeZAX8uiHo8q7mXOreN2E6mSBlyUUHJBzd9oX/KezDJbYk4aKWsHG/DEh
 azl7XoA75+sHsEDHk2E/zMhDxnHEZIozOJd+mSxeEUrl6ZJfgcfHANqDRcY2jl5qcicx
 QPncNMcmLAoYKjgVLPK60EzjWYMcBxbLpt0rheAmzYoDYJ6/kZjGA73hfZWRVQ7Z+3EA
 hU+Ckg9KOvAyH4mztUSckMiwmDHOyC22q1XepaeiUW71YjbYc5vF0nQkfRsNC5LZwmht
 85eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778678905; x=1779283705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFxNdVHWMzpghmBXs03WQEOsxxoCzZKFXvjRC5q0MAw=;
 b=VVVarvBog2lfIJNWRzPOjcrGIehRL6vl2L4AtmzLP/X+dHYsumLI1la188DvQWW0X1
 dGIbN6KhWiHKN+LF2StLT7VdSTvH7ith52nCauB13VRS5Ff6RGrQXiAgEI8lKWkHMQQ0
 Oei+w9IMEg/yTAX7d0z01xC+o4lhwuD6Sm+RHHgEH7anBXddt1irFk3TXdB1+Y7E9GRM
 QvXYY8Q3+s1CVSi2wBt8lzR9i5Z+zqURhRnVOsM9h8NUQV49mJ88IS+h8ui7SfxUFPbB
 se/+0C8HOZn5Jx1GwKvAqjdrkJx+EUu8y8eN0FP6os8l5vpxzlX0ajSLT8hBTfs08SFJ
 Q5vA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iWJAgIJT3IukMsnxfBf1gBfPjlmz8ZVfx5I75v1L6MrQiDwbD/T6hlQHaZPkc42hvrvdz7ukk8ZI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztOUY4bJ+uLIlIK7J7QoX5Tp+REHDOqjXm+jYGT2OOdDkDRlU6
 h81/EN8UkCbeUzTjqF9TMI9lRDwfh6NQAfggILO6f6Nygb9BT21JBiVY1znppMbMBSK2chJM0PQ
 6Tua9BAVhR+Ii3+CZ+8MkRf6wkV3YKjNSVtdjTe0ZT4gbVHrUXyYEb544mdZsFlSHrJ+r8uo=
X-Gm-Gg: Acq92OFGKTRkMeG3jIAtxLorgq2+xyx5oWZYOKuQbr66VS3eeDfFVGNfMMYy5ECIH9M
 L4mVDGU8UvQJaYLFBu16onTleQlXJyKvO1py8aqKOGJ/ozRvsFeqnFJYvDVI+wEP8wY5bUgw0QP
 QfWPJ8Szel3hkHESNqwHA6kIvglVrMTnPmDiJcJbee61y1tHfVEtMv5hNfUuuDt/fve5vMhND1E
 CIcZgJztM4Sg1H5GSslrXxCMulcchOQINOt3P3GA1aFuaca+cn/v7jsa40FA/YLIkDz4tithskE
 cUNl7FJ/E0lyMZuzSyrzzDCiFjhwD9Hg2pZUdpPeoiXvh6f8WJu+HUJye5SHySyrLYYAJDViyzN
 iL0X7j5K6h3ttKOPkPDg+xQE+wuCAzBz5bgwVnYemQ5ScYOTif2sn8ER193lX1t6s6VRnk6fRqQ
 vnOBTYAw3HOr2vnBdZbgKIniUnTiKCsvovZ9I=
X-Received: by 2002:a05:6102:5a95:b0:634:16ce:aa3b with SMTP id
 ada2fe7eead31-637742471fcmr1355824137.15.1778678905460; 
 Wed, 13 May 2026 06:28:25 -0700 (PDT)
X-Received: by 2002:a05:6102:5a95:b0:634:16ce:aa3b with SMTP id
 ada2fe7eead31-637742471fcmr1355799137.15.1778678904955; 
 Wed, 13 May 2026 06:28:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a95661e0sm4037162e87.67.2026.05.13.06.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 06:28:23 -0700 (PDT)
Date: Wed, 13 May 2026 16:28:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>,
 Douglas Anderson <dianders@chromium.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: Skip push_idle in atomic_disable if display
 is not powered on
Message-ID: <mnpara7zwt6ahqkb44mxjtengjodutek35dzax72xuf5i4puzd@tvxhgefvpdqk>
References: <20260511-edp_suspend-v1-1-128555968d7c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-edp_suspend-v1-1-128555968d7c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: leycreqf5kywSraP8CE3IHadzdkKAhq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEzOCBTYWx0ZWRfX8HTgabVEei65
 NIftOMIsuwYylSBfHD9kdUwy/f250cZwsJfJF5jYDBVh18kTaZNR7vA2Pws12wg+orC5PYfLFmb
 k5S15vqjbX7cyrBtS7xXVdRJ2iIXSfU2xpn8+LiqyxlVq/E9AIKDRk7qvTBs9Mzc1UWeJUhFnBf
 XbNhM4ZGoK1qT0j/1mwRUBcmj9aXgsWaALy/tHcR/GmQQuPSDoOAF2i5aPo6cBT/xbO6EIFHz29
 m3+/mm07ND7HIcje0B2MJIoavMlfdkLzoU0BWksyK0J562ouyhAl11IhMHHHsCCFMphoRZQMw1n
 58odPbn2j1h3wHXRZpNBEt8xN2lR6n0dkZ2alOb8qY5sCeS8UKHzzrLwt17iWSMS7UZ2GEtVggp
 3XEwQK1k0ThBkbDHisSxvnEplXZJnWUcUdajtpiwLkTI9AXS6nm16s8KBMDwufZUXOU/pwz0w+N
 mZ5aB6uII/X+SyVH0Aw==
X-Proofpoint-GUID: leycreqf5kywSraP8CE3IHadzdkKAhq4
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a047c7a cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=E4-49owyH1uc_qQ72ZoA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130138
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

On Mon, May 11, 2026 at 04:36:03PM +0800, Yongxing Mou wrote:
> On eDP interfaces with no panel connected, panel-simple-dp-aux fails to
> read DPCD over AUX during probe, leaving hpd_state at ST_DISCONNECTED.
> msm_dp_bridge_atomic_enable() exits early as a result, so

Why is atomic_enable() called for disconnected bridge?

> msm_dp_display_enable() is never called and power_on remains false with
> link clocks never enabled.
> 
> During system suspend, drm_atomic_helper_suspend() still invokes
> atomic_disable() for all registered bridges. The resulting write to
> REG_DP_STATE_CTRL against an unpowered controller triggers a NoC slave
> error, causing a fatal crash.
> 
> Guard push_idle with a power_on check to skip the register access when the
> display was never enabled.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

Fixes?

> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 1b3cbf4016ef..51b60eb9c2df 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1660,6 +1660,13 @@ void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
>  
>  	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>  
> +	/*
> +	 * push_idle accesses link registers which require link clocks to be on.
> +	 * Skip if the display was never powered on (e.g. eDP with no panel).
> +	 */
> +	if (!dp->power_on)
> +		return;
> +
>  	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
>  }
>  
> 
> ---
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> change-id: 20260511-edp_suspend-0e45d0110633
> 
> Best regards,
> -- 
> Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry
