Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92C2CD4F26
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 03:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B7010E02B;
	Wed, 24 Jun 2026 03:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UiAd/LJb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GD3ldd/Z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF1810ED4A
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 03:16:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O1TEiW1876164
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 03:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +tqp3CJDavdcu8AEXNYxlJgSiG4nSfjn/QhDqR8opbE=; b=UiAd/LJbXcjiGy/L
 fK+aWKXk5IXz6hp8aadcfYlZcHhOfHyj6RanGteyzyZFOWv32vKzL3l6lTQFiUhH
 o8CYfgZXDT48fXWR8Zy4PrYOYKneaO1rhJanbjpXSCexgLHOVSTNkTd0we8w8gnb
 MXgsJDHHi37GNCvxWalRVZD7w3s+8q7Dth4mKb++Dt/P+odV0BHRHD38MSg9KU4w
 2C1NLuw88Rhm7Y6Wuc5tSkh0WFxnH5p2oRZJGlwBvm8+UlrCraPbvxNmZCrmSEHI
 tcC+YJzwsbWyAtjjAyvJvGAvLqBmC3gam3pRVdWy5786D6MLhMhQ3SgwFex40lXg
 bm0abw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eytvh2wd5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 03:16:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-845a29d8c1eso500351b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782271009; x=1782875809;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+tqp3CJDavdcu8AEXNYxlJgSiG4nSfjn/QhDqR8opbE=;
 b=GD3ldd/ZxbJ4ZA4QinsyttFfD57wYelkrMM8vqR5tamOHQcY7ZD9Fhj8NP4X3EMLZL
 kk4OI0iLrpyUnXmXwaAkm1BURdHdhjNYoCozb00MsormGfmNN2uh7r6OKrpb6UTSN1TA
 xZwUmOMQGY+pKA6nYt4/7EQntTmDY4tppMNZfwr8ZYEeJk29gjfwN/9i3MXkI+a/4wDz
 7JHNo/Ny+KvlNnnCQTIibIM44sLReYuzw78WiUXZoUABruQzu2jN5nQ9H2Ny8nIJLtqM
 gZSHzVJSdBhYPRPsrmGbzNgRkV/Fybcm8Hrv5jzdWS7qmVj5XR3bL+j03ChgVekHc9Uv
 Axxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782271009; x=1782875809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+tqp3CJDavdcu8AEXNYxlJgSiG4nSfjn/QhDqR8opbE=;
 b=d7KH0bdHYJMWmDPSBnj4IFazmBSHa3DTd47zD2fLHuh2zfUqw8auBI9c/gt4iSlvjX
 NzG23jethwg3BSBSfMf29heVfOdGF6u//OllZNDc5v3pyjgZZdPZCKwzGcfIGCpLUekh
 eHRH3lwHgx7X/7UNU6b9Gr5Hso6R8rdckUva9A3OFb/Ey8D1kLQ0p8roHsnHPdxzSCKP
 Ze13mp/G21DHw9+0d5mCTNMX1KiQqMaqxxbadkbwLa+NFumwnWHqFyNcVOAh90u3KPZg
 jy5sgD2ABXKkeWyfoQn25FqBd7cxQxcoM06b7p/5A0g1azOprJBZTwkmJ3RLE0Fohra1
 xKUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zWMQ8ndi0KcjELgtKE/7XFVzMxn0RGJwHJzluY4yxvQQfA35wmdlikbeXo1A4PXBiig8oLAGyS00=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyx0AWgSWTEpBr6L5+W5HHN6HAkiiR1lyEtfHWcvBP/vl9oydtS
 K2W1KlEwpHvoZUm6pTnDgXNUys2piZCIkdf3KVXr10z9yXjz7MS08m3CHh8GdedlFxpwpI50lzD
 OkcXBWp2HLQ984Mrz/3GZFJkuI6v5VB8KbxZuXcBUXIEnPwgC0fdPtFHoLCPwaAP3DFp1i4I=
X-Gm-Gg: AfdE7cmAbiaM6gjyH13J8Jqffoj5c/u7jzC5BmDEtkT8IG1VI6cweoCgriVYHKaZju6
 3chVBuNEckIH20BDI1B/krXUa8STbuRU6K8hYKzrQTYCx/DlKHnWjpIVBjd821y0s6MRlAv9cBz
 vUxpUzzpARgdRMg729CjnOV47oIbr2w4ZNfH/kWUR3rpGGCz+LYTPzHcBFlAwsmRBRyoxjzlF17
 DDXbxBO4mquw4h5xmNVwBvk7s00EvKgs4SqfPldyGb1avZj/hMuYCr/fLSVTjrAQI4+hH4D2bqc
 dAnPRNCAA2SaeU9OoQEg1G9+oK2sLjkCCoQM1OCzKKzYldjqW+pM1mSj3A43yfb+gpRugcblX3s
 7llQxYjAUnxLO0OJrS9IAw8LOsEFxePYB4wfB0hbK7u7yvLr2m6oRGEs4tzVm1OabuRBGRbjC1k
 hFMkGfQfI=
X-Received: by 2002:a05:6a00:1ca0:b0:845:259f:8925 with SMTP id
 d2e1a72fcca58-845a26dbae0mr2428067b3a.6.1782271009552; 
 Tue, 23 Jun 2026 20:16:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ca0:b0:845:259f:8925 with SMTP id
 d2e1a72fcca58-845a26dbae0mr2428039b3a.6.1782271009116; 
 Tue, 23 Jun 2026 20:16:49 -0700 (PDT)
Received: from [10.133.33.226] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a3fcc82dsm675711b3a.7.2026.06.23.20.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 20:16:48 -0700 (PDT)
Message-ID: <b05487fa-e282-4236-8f10-016e7ee4dd87@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 11:16:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/15] drm/msm/dp: Prerequisite cleanup for upcoming
 MST support
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDAyNCBTYWx0ZWRfX+ayBUfNLjv3n
 KOp3o0w2ct7bXMIjNbFii03GGv9cLuUvrEk2EYK4/hU6AZdStaft5HweIR5K51OCnQwwY3UJWxE
 Kc0bnzt+mqimqjMH/z++g1tpCSHWUNwE5BxNJipbx6pDJ+dDyLH9ANDmxJpAJefye+65H+SjTQF
 RhbkKtnULdz+4Dy0px+BvZtys+3sPC4uHeMO6o8hSlbb/ZTUB61nXLzfAKGEq8DdPhexA7R5vgp
 ezNwF9agusSGbWH/tioFsLAo/4b0H9cwMny3dl92gh/0K/OFpeETJBS+JnlxfkCL++SAKYos7Kh
 y6mBoEJvgBvDIa9CzEMizJjvro5U6hUZ3A/LH8HI/v4By7atUpKDgEtH3BFCyigB9r6eybLpk+P
 pVoCCihBJ3R60P4C8UKAUfvN0qgK1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDAyNCBTYWx0ZWRfXwIAFsQMiXruL
 +K8viL5KYo76y4C4TNFCuJjKvDa7xqTNSXDnKSnFf5gKbBoFoKrnpZ6MKtyiM5TOkTAnlZ9sc/C
 3LLYuYKblVLrmdBRWsECuvMJQ0qtw+8=
X-Proofpoint-GUID: N0fJIzIueZI_mBfYrCQzCuSzRmeXzkW3
X-Authority-Analysis: v=2.4 cv=AJDhMgPs c=1 sm=1 tr=0 ts=6a3b4c22 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vQr1noI8oyt6EgD3lKgA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: N0fJIzIueZI_mBfYrCQzCuSzRmeXzkW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_01,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240024
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



On 6/9/2026 5:46 PM, Yongxing Mou wrote:
> This series is the SST-only prerequisite portion of the MSM DP MST
> work. It refactors the existing DP code paths so that MST can
> plug in cleanly in a follow-up series, without bundling the cleanup
> with MST functionality in the same submission.
> 
> SST behaviour is preserved end-to-end; no new functionality is added
> here. The intent is to land these refactors first to keep the
> follow-up MST series focused, smaller, and easier to review.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
> Changes in v7:
> - patch 7: Use WARN_ON_ONCE() when pixel clock is already on. [Konrad]
> - Link to v6: https://lore.kernel.org/r/20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com
> 
> Changes in v6:
> - patch 4: fixed the RMW comments. [Dmitry]
> - patch 10: do not rename the existing struct. [Dmitry]
> - Link to v5: https://lore.kernel.org/r/20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com
> 
> Changes in v5:
> - Split out from v4: only the SST prerequisite cleanup (patches 1-15)
>    is sent here; the MST implementation will follow on top.
> - Rebased onto linux-next-20260527; adapted bridge callbacks to the
>    new drm_atomic_commit* API.
> - patch 3: added Suggested-by: Dmitry Baryshkov.
> - patch 4: fixed "splite" typo, reworded body, added RMW comment
>    covering both SST and MST paths. [Dmitry]
> - patch 10: drop cached panel from msm_dp_ctrl_private; pass panel
>    explicitly to all stream-related dp_ctrl APIs. [Dmitry]
> - patch 13/14: introduce bridge wrappers and atomic_prepare with
>    drm_atomic_commit* from the start to preserve bisectability.
> - patch 15: fixed pass panel inside the func. [Dmitry]
> - Link to v4: https://lore.kernel.org/all/20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com/
> 
> ---
> Abhinav Kumar (6):
>        drm/msm/dp: break up dp_display_enable into two parts
>        drm/msm/dp: re-arrange dp_display_disable() into functional parts
>        drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it
>        drm/msm/dp: split dp_ctrl_off() into stream and link parts
>        drm/msm/dp: make bridge helpers use dp_display to allow re-use
>        drm/msm/dp: separate dp_display_prepare() into its own API
> 
> Yongxing Mou (9):
>        drm/msm/dp: remove cached drm_edid from panel
>        drm/msm/dp: drop deprecated .mode_set() and use .atomic_enable
>        drm/msm/dp: move mode setup into msm_dp_panel_init_panel_info()
>        drm/msm/dp: split msm_dp_ctrl_config_ctrl() into link parts and stream parts
>        drm/msm/dp: extract MISC1_MISC0 configuration into a separate function
>        drm/msm/dp: split link setup from source params
>        drm/msm/dp: move the pixel clock control to its own API
>        drm/msm/dp: simplify link and clock disable sequence
>        drm/msm/dp: pass panel to display enable/disable helpers
> 
>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 382 ++++++++++++++++++++----------------
>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  30 ++-
>   drivers/gpu/drm/msm/dp/dp_display.c | 273 +++++++++++++-------------
>   drivers/gpu/drm/msm/dp/dp_display.h |   8 +
>   drivers/gpu/drm/msm/dp/dp_drm.c     |  43 +++-
>   drivers/gpu/drm/msm/dp/dp_drm.h     |  12 --
>   drivers/gpu/drm/msm/dp/dp_panel.c   |  75 ++-----
>   drivers/gpu/drm/msm/dp/dp_panel.h   |  17 +-
>   8 files changed, 451 insertions(+), 389 deletions(-)
> ---
> base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
> change-id: 20260528-dp_mstclean-f094cea8ca24
> 
> Best regards,
Hi Dmitry, will this series be merged next cycle?
