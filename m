Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D76CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE11010F2DE;
	Thu, 28 May 2026 15:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TS8eTRpx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YWxfOB0O";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE1A10F2D7
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:19:40 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vUu83203255
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=vCxScaH7vVBydHnsplFqoTaQ
 mq8QgCG9GksIv/PZHWA=; b=TS8eTRpxleVe9AmxfNH6/Jns/ap2yeNhPGqCI5Yq
 McTrDt4+5oDezgWbnMEv9Z+lUCdahnAyOSa33yCyfinAvYSmGY8bhQ9lRke8BrVI
 4c/I11P5amjBeIVjfwIDRni3Lq9aUlS6KW3jpKvAju/eEt378ITUNWYl3q2ShFHr
 A49xSoZHe7gfKCT2800UB/sJJliCUZCDNgmbuTJZPUeF+RIpO4PXAYbzgP1AjBG5
 yRXdI9qV3bHSSrHM89htJZEJLKE/B6uVD4cwLZrZJcEHmQ30cqPu89aw0wKGCZL5
 lQuay9BPSoa+vKEhR+wa2H1pLsNWLNexweL41C4n228bPw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynkb6w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:19:40 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-575b418ccdaso4579501e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779981579; x=1780586379;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vCxScaH7vVBydHnsplFqoTaQmq8QgCG9GksIv/PZHWA=;
 b=YWxfOB0O8Z+RcqnOYLpMYwORZx4QdmYYAFrvIN8Jo1Fll6y/7nPWdwh6zieR++79x9
 sHVrnnFfc0xejRsu29cN6Qk6apXZLgbQZq9HhHI1QRGtiOl9Yriu/Jva2fSIyZaEBLkb
 vKq0/UW7Rrak0H9wsKNAGMG3fyM8Ewi1iiw8UGaK8kvFajRWtM+MTrP2dXOFL+5TudKa
 R7Ndk5mw1qAlCjNNzz9Y8HxwnaAOVO79v7YUv1liWShkzyePEvCsoyiCclU9ymbNpGAb
 SQuJrKsF8/KdTI7sK9pFsAg+lRoJhrEfc45peD2qqnNxtvpSuQJHKCXdywPnxrB737d+
 8R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779981579; x=1780586379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCxScaH7vVBydHnsplFqoTaQmq8QgCG9GksIv/PZHWA=;
 b=IZZcqV1KFPP7r1Ka0nLH/0BR0Q9KgZ/aGFashOKzq5qDEtaAOewSuB3khvJkuHTGn2
 TVmKARvpWTwxj8a07aL+kdTp84iljmPIMTWiGoYBW+sCDnR/FAntuNhWnxjFqgZCN0hn
 YC+GtqI19yeBh3kKLkQiT165N3H59SaxBqIKyd09uJcqGTsW1KGWorbcbxfvMFR0IKUQ
 WvpG06wXsgtlcjeOLNAVGVd53sPxhMx+bi+Q+cXSRQcG293tqAXXDRjHWApBElmYpCKC
 zsx7lceOQ3KGcNccwFuVY1kzuPdOvwFxqMQcE1q44elJJSbC6DPvQ1ol3BRPAWCUpM0e
 mVXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3uSh9dfh9TrZJjbCEZLY1+GSo9+0zHiMJgeVaQSLkeuNnLq8pRyjPb4VXbfKoy8lJIcM7hJTHQT8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyW2V1nDisgQYdaqOGG9ynkVVNOakXc2YvNGWnguXJKZxJM1YIh
 ZHJeR9KeKEdlvLIa7vg6lo5xfx31AN/mZvDfiBIk786VfOSazAM6IpyFQ2i+IROIJFlFcjIVTUu
 mKumfCjPS7ApGKiEsqK3D2Pdf5B5ckRZsUlPijl3pv2XNJvnlj/JzgVZTVcatLAeXtxslvjo=
X-Gm-Gg: Acq92OGvZAYZ6iWDUyyQzhVae5gSe0VJz1vGDX7e7p9uLkQaRv1hpGts3rkptqIeo+a
 K21VPriju/f+2FytvsoOfLvg3KPhNu94Jmjr1XoEIKVa3rYJ0zhpWJq7l8yXpuVdFG8kawMREDq
 Vjrz6/AfDMOgbV01hhOnJwEpHxjVxl8UFju4khGkzvyjyvRdXHTWwURXVDod8zcqSFqb54cMJ53
 RIn9wz9ygs13KqRaR/z12e2hiz4/WubZ8L5NwSu4D3fvvbt/t0Hc2L8eBJWgYbDS2qIj6YRCVhp
 LgA7eHsaIUYI0RH3l+X10J+qtGeOZQUdT/D6y8+ymaK0afUceWYkfxNxFyxwICJuVWPnsTKQbjQ
 kGnqIN3RhYEKT/0QMpezqV+i2rST0qKgmDDhz53dHDQw3RLoog/QtIsU4t2jFVYAIKLYGi0IuZi
 9ZgaqurL6myMWx/9CmNhGiCz7zBSEYXgrZ4D5BzmoSKNYB+w==
X-Received: by 2002:a05:6122:208c:b0:575:33d4:d100 with SMTP id
 71dfb90a1353d-58664039eabmr14844415e0c.13.1779981579084; 
 Thu, 28 May 2026 08:19:39 -0700 (PDT)
X-Received: by 2002:a05:6122:208c:b0:575:33d4:d100 with SMTP id
 71dfb90a1353d-58664039eabmr14844370e0c.13.1779981578688; 
 Thu, 28 May 2026 08:19:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa509fcf46sm528548e87.58.2026.05.28.08.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:19:37 -0700 (PDT)
Date: Thu, 28 May 2026 18:19:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/15] drm/msm/dp: remove cached drm_edid from panel
Message-ID: <xuxabbaabm64mm5vpfbcdg4m2qhqecbnrubpruw5mlp6bwtgeu@nqyynv6uzlau>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
 <20260528-dp_mstclean-v5-1-a9221c1f1f3b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-dp_mstclean-v5-1-a9221c1f1f3b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1NCBTYWx0ZWRfX7wQvQWe755J5
 uHCNZ7ih4oeUlJkbCtiXQ/VvX4nIzmGRW7A5/BpN6TF8n3Tg3Pebaa3aUcCX4ux0ECjdUJwq+Al
 08eTlsTqwCss3Fk25NG7yi58jmaqvUFPr0o1m9Q0bwufq0AUbA4/+LHtQBjy/zx1EEr/3J0ePtK
 16V9KqNK7lchrlx2r8EoOcNP9MepRaWvPF+ePdk2mRvgk0YbOdpSM9m1fGZYyb1bTZI8q8TpLmy
 djl5X/6o7C8b6kRSiDuH77CV5S5Pr0udEIK3diQAgurhrekJJSKbav0LoAVh55+1X8yBkBIk5DY
 SHppAXWy88eEzc4nI5ZkX1FMmwJkpAOEOQfLl5prH+jorENmWPh+NunXcvmaDBBQFv6boCrRkBp
 fAZUk6lgXzTmwihR0ic8yWP0tZFcmrxkydbMeW0+SznqhHtan0NnjnwFAKBrojQ5PZnN8fsEiTV
 AuE6oscEGea7m8firWA==
X-Proofpoint-ORIG-GUID: lSvbVLHSv0iSBKPLaDyXiIyq3S8gEof6
X-Proofpoint-GUID: lSvbVLHSv0iSBKPLaDyXiIyq3S8gEof6
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a185d0c cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=8NV6GxjMThyPRtXr1SQA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280154
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

On Thu, May 28, 2026 at 06:40:22PM +0800, Yongxing Mou wrote:
> The cached drm_edid seems unnecessary here. Use the drm_edid pointer
> directly in the plug stage instead of caching it. Remove the cached
> drm_edid and the corresponding oneliner to simplify the code.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 28 +++++++++++-------
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 57 ++++---------------------------------
>  drivers/gpu/drm/msm/dp/dp_panel.h   | 13 +++------
>  3 files changed, 27 insertions(+), 71 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
