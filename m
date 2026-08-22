Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C492C5DF97
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 08:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D216710E334;
	Sat, 22 Aug 2026 08:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eNrn7+di";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gEwiCKBu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8AF10E334
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:14:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67M7xsTV3666709
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mx4sBpAlVY0obopBKg3ZT/Lp
 ye0sIJNAasEqA2Ugc7o=; b=eNrn7+di4s3qeYerXuAJLd2z1SRpdjjDhlzma7YV
 0EU6+EY53bGjMRFy2P1Aoq58jaoHyVX14ThqbKtzisuCw+7wqYh5JRI4xLmHuGFi
 4pelY3Agx9698p+AglQ5rlaMVZx2nPZ8J+OtjU2SXyubQb2/fIB/FWKopn8DST4N
 sx3Cum3MOQ5HbykL/UCTxLNlt4+1pOGh95Vw8vNaYtG94OAO0G57NrwTiH7mQoyP
 2ABKOV4hMBsttTb93WOM9AjX0c2XXLfxQGrbRK51gHeb99txNcv0zaPMN15splfi
 E+7NrXWZaLbOGQfc6dP+Ui6qhEf63Bx2C4uAtXirYB628g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g744qrj2t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:14:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c01ff996dso20488341cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787386492; x=1787991292;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mx4sBpAlVY0obopBKg3ZT/Lpye0sIJNAasEqA2Ugc7o=;
 b=gEwiCKBu9tl9UtR/8UIx4xlzbOqjgof+iJraW5ImqlSjCnmwDx8BpUTIqm77RbZ5Xm
 pOX7EUsvm9Ibhkz/vlMC8Ke8Y7fXad2lhnix5eWJRP0VTDBn+7OxjtBpavVLyno+Bh6l
 BNjtu6ix72B6q3Q1+9lMmeuSZEwSDlHPysHjjoCWULqY66bFFxgIwkGw+TaMZx8ohbJw
 9rt8szAJtyK1LdEUWUnjydQSgqO+oodwSIo3+9ujdORsrefCVFZABrl7f6ImePCYpW8S
 b2KT7dUOwtY6mB0u0MTrGaVath5Qzk+S1NHHgXAAZblwnictx5C/fuEF4ML9h9p7r3zU
 UelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787386492; x=1787991292;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mx4sBpAlVY0obopBKg3ZT/Lpye0sIJNAasEqA2Ugc7o=;
 b=AUHisZdoD7Nc9GsEFsYEQFRB24u6P5LaK3/pPu5lKA2yCv7gHHFdd7Zx/Ux2xXOGI2
 QaZKD5SxSZVawqvcxcgO/dzgQmZiShF2c/ReoVcMlVHMCUoUyZxnKOc1QJvsmylPnj1V
 uXWuyeUGQSek94E243adOZKCqSsHrdwXZaMJoCV79yL1c4/6OO/xi8J2uJWUp+8kK7Z+
 QrCQCUqkjAhyLqI7sLt++10M5wH5J3Uex8jpbwH94Euk0ykJ6Lkw4InvVmCZcnSa1Vec
 dvI/LHO40Ub6GqZ04315HrWEvYRvrDDmU2WyAetsEO+RONADBwoGiIToY7YRKpaWusXs
 rKbw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1QMB1b1vLNKupHvNk5GFp9b8lBFldVrBuxBCHq1nv74sUWvQoETo7xBe2C1pCzPLEox/uVNrfCPs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lcAGoyuoV1PYJys7Tf67oFvFjPk6isTaPfwe0R3cEyyGqDY1HX
 DZnNulFX7Sw1HxDFlSORIqwwgBPdjaI4yyId8U41+Qj/eNAfugNUZtGUMJoqqgBMvsYsjJiavXS
 dxlGIzkVw+HZ/1fVYoCgsIUPYlDD0Rf2XeP8iKHL+EJnjltpLAQT1W4LAUt3Pd30uhmIGpqE=
X-Gm-Gg: AR+sD13y2jpLKongGT77aXzBeR/F4oYCmT/LAgf/WkjMds7Wkd20TmVmrpnstqLZ0yS
 2lRXxIPqtbuzcOuIZEjDM6hXgPASFW/nLy+UJbrpiwDBgTilL6Uc7x8cpxeVIrzTmaVwwpDi7E4
 69cVv1uZxa0HVmn+IbAwh9+8y3wDoZ6pOivmtVc5hd2o/JazXmXMy3X4raEvWUeN/oW6ai9NeHz
 x9QeI6FVoibHmacuskx9FsIMtiK2rumectchMnAPr9MkD4akLrwakITNOCdTIcpO6X5Z7MvaD+L
 m+TJrptX8GRDX5Jq+nVjt1dgcBjsixmwokX5Fgkd4tApric1vneSZdeNJPbnza3UCTYYlmXXCQ2
 gAnEQlc1WmaGwsZjfQbctgsjErbGZ7/Ru6aAYhhNdqfQmzoFfshF/T0IWT8OQAer4aJ187huK5g
 EgGLKtEgvpxoDe
X-Received: by 2002:ac8:584f:0:b0:52d:92c1:b7c2 with SMTP id
 d75a77b69052e-52df56eff97mr103304691cf.1.1787386492432; 
 Sat, 22 Aug 2026 01:14:52 -0700 (PDT)
X-Received: by 2002:ac8:584f:0:b0:52d:92c1:b7c2 with SMTP id
 d75a77b69052e-52df56eff97mr103304411cf.1.1787386492043; 
 Sat, 22 Aug 2026 01:14:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c2fab2edsm2941241fa.23.2026.08.22.01.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 01:14:50 -0700 (PDT)
Date: Sat, 22 Aug 2026 11:14:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 54/70] drm/msm: dpu1: Convert to atomic_create_state
Message-ID: <n6eroabxsvokjidgu4ujzix7siiwvgvhsfxuuarwxvlr2yrtwf@2uzoraecxzrl>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-54-fb793475c05a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-54-fb793475c05a@kernel.org>
X-Proofpoint-ORIG-GUID: FxyvlWWTu4WSB_b5PqUZM1sqRGb-1VoC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA2NSBTYWx0ZWRfXzg62UPNCjhQc
 4oCKFR0CxmZzV1NpYrH10GEWNav3orh3pXzPTQ1mK1z4bxlMozuJBW9lXnarscFLMJNL6xps492
 vizCFm1LpQUaYQxUkGW0vKzpLWdOpTfKLrZ65fIWXkC9Fzwd7R0paUO/jcXCaYGW6g4obecSunO
 BvGDnKqxOqTA48JtOLzYBXkTBV6R56/axvhfpUsV28v3S5gx7Hg3vxylo75gtKYcThOtoaDgZpr
 jvE+Z1NYCtQII9ZkazOrcg8NMQU9UD1r5/H94HbmYJ/5exXeOoyOIn0tL7zQu6BXKct500+of9K
 IbV5XxFFrbiu+Pqth5MruIXJl73N+eUQ200heY1ZBElzuv67zdZiuZEQjSuGGSaERa+Lo8/SBjR
 NP3nSIoy8alkxGD897EJk3JBKt5nrZJQoE6zWqr0AiGRFEa1IMId+awn9po1XxT8dYNqDzSVpaP
 xZV9Bwwn6fUcE2+Qy9w==
X-Proofpoint-GUID: FxyvlWWTu4WSB_b5PqUZM1sqRGb-1VoC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA2NSBTYWx0ZWRfXzsX+iIcCpTmK
 YQhd60Plyby/k7luzozePdHOVNbe1Ym96mp/AFtvZvswcNK4q2S2VEeuhwC0pXAO34imP9aVMq8
 RSdGfg5/NeYqmByfZgJf8/WUf2XZ7Pg=
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a895a7d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8
 a=JUukOM_wEb1cdPDkkI0A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608220065
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

On Fri, Aug 21, 2026 at 04:39:30PM +0200, Maxime Ripard wrote:
> The dpu1 crtc implementation provides a custom reset hook. However,
> this hook only allocates the state, initializes it with
> __drm_atomic_helper_crtc_reset(), and frees the previous state. It
> does not perform any hardware reset.
> 
> Since this is exactly what the atomic_create_state hook is meant to
> do, minus the old state cleanup which the caller handles, convert the
> implementation to use atomic_create_state with
> __drm_atomic_helper_crtc_state_init() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-arm-msm@vger.kernel.org
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
