Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51441606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ivfm1BHV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KJzavnmW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E6110FBFA;
	Wed, 25 Nov 2026 12:01:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7C410FBFD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:01:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mMAM2356506
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A52KNemyd1lh3piMmkcLWrwLaiXp9XsA8b/MHTMptd4=; b=Ivfm1BHVPxURJ6yV
 Orc5orEenCkxgRcTQcovJR3CPHAujhR+fg5bRYSrk5NgPFw+fhoUN+ZHlSiaGUeV
 PbGqgQG9CacghHgQ3AY2HAx4jS2sFs/o3/NRnn8AU4+l8bx99T0O9l+yYvE8Ltka
 c3k7Nun3bxfcCbP4lq8Ycly/Yd86R6L++NcYjphAfZG+eXUTKPQAvHirrAw2WktJ
 ByKG5ViYXYzxp3j4h6bVSQ8VQDjUXiikOCGyf07M+a1LfRGcdYFu24K8l9WYy4jJ
 OfIc2cYsS1WRLCKW2dzt1DBFTZBDp9gUrnEcT6bFObMUXr17ss9oP9gB0pT45h0S
 8vxELA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5nu6adje-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:01:14 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b4bb8bf464so82549157b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795608074; x=1796212874;
 darn=lists.freedesktop.org; 
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A52KNemyd1lh3piMmkcLWrwLaiXp9XsA8b/MHTMptd4=;
 b=KJzavnmWLM28Rle0HvjYWJWZEmpISCK9R+mOXgUkY1H0uylmf7WR2loo0tgV7WSxar
 W9n+EhpbUZ1XjHDs/x6iiFcPPkRO1Lye6Xh+QFvFVUoE8yelcBp8ky9K5CgL0mcDjRNF
 FjG2olDagZfRAzmQKJwophYfl8KfOt8LFmEyf+RhtSQ7c7uMG9/LPeuL5xIXuHs9kNdX
 PPyy8W6TVdFxZqvtuvcabWRDey6xNqIV6TlxPk+QR75CuQlA7mQwI3t6nqXOV/JcISCI
 mPyGnGSZUV2MUr+2XQlP2qTWcZhLn6knEPe48k6PqNqARvQ0AbNE2zKjOfOZIc+BCxFM
 mJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795608074; x=1796212874;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A52KNemyd1lh3piMmkcLWrwLaiXp9XsA8b/MHTMptd4=;
 b=p6/RvBatxi9DVJEMgZfWZlgZdZn3bk1aU7NRweynhxmg5oBg88WefOPsXODrFUhnEt
 XMRmDqfM1rhnVIwSSV8xFGPZfNWwUu8Hkm5rZXRccx6ITksXYeBkYrVVOqBDZb/93JB4
 zUX07Aw040z3Fl86+KxNm8x+X/SEXc21gPyImvIz9xifrURUT9jThXnegZj12nBSvJaJ
 2XQy8Zscv71SnUvYM6z5vXEZjs/k3ONjhaEC5yaHUT+4gglnSrlD1LO5ScAPQOxw2ywu
 kqP+/6YCSsAxcoddiUUWOy0h3FYVWRlKYTjOKbkKMV/j/4uEL2d9J3c5pOs5xkZQhr+a
 PTXg==
X-Forwarded-Encrypted: i=1;
 AL+hErES3rOZ6B+NYI9usuODc/gP9raQjanDweJC49Jzkk2ahLLuHrLP5a7wKYIkMGI4If+CweA+Ol+NaU0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/7OWSmSYy99WZ7D0ATsCbnofrHV9rqFeq11fVXvV3vXHXl4cLF
 pSFUNayrjoeQWCEiSdMJLEILWc6kctPfYlGqOs0vpTdftXjA4LcaIdvFshMtcp9dYX4Z4I8Th+3
 NGmuW2FtAggrgMJv4lh4mBu3zxJqQzZH8WUYGSLOJv03S6MpcWQw4NanRyi15492Ij1KMuRA=
X-Gm-Gg: AZFdTZd48m6KWc1ZViDUHmv2ZODBH2YlCI0MFhQOCYesdE5xFtpbrX/RwKDMnFfxHEA
 CQ9ykzOGXiRBF52l585SJchzbfO0KR+UoabCmGInM7lSL2AEe/UZ/2oM2x3WY8Ex+RCim8QsZBb
 Yfodf2C4SWtUoFqocg4Aw3phNQlug1Ye3h3c3f7XNMh46cRL9adE2BYpPMYZXHZxdbdjtQ7zfcM
 nLm0R6ESQE1jg080PbbqTM85+w100LLNLws8obG5JgfaZtB45XcuVGv6d54R7TU7yzst6A5v2Mi
 vgxp6iRbjnNUgnVOKL6BrgFBqIhGIJ53bvDTUtbnvSzbxkE2rXncnEGEBRBuFzz1GiK+jtSg4vb
 3H7fXhbowxxipYtDI7NU4AJ8Z1MSpeDDw5WzQLy83RcSUy422Syu99zKW0cAPX6D+xgDUf3C0JT
 KkAuuQfA3Ydg==
X-Received: by 2002:a05:690c:4d02:b0:8b0:97f5:a858 with SMTP id
 00721157ae682-8b520500410mr60654357b3.59.1795608073440; 
 Wed, 25 Nov 2026 04:01:13 -0800 (PST)
X-Received: by 2002:a05:690c:4d02:b0:8b0:97f5:a858 with SMTP id
 00721157ae682-8b520500410mr60653907b3.59.1795608072387; 
 Wed, 25 Nov 2026 04:01:12 -0800 (PST)
Received: from localhost ([120.244.9.31]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b52030df7bsm72480227b3.31.2026.11.25.04.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 04:01:12 -0800 (PST)
Date: Wed, 25 Nov 2026 07:01:06 -0500
Message-ID: <0daf9fd673e2e4e148a8205c752763c0.guodong.xu@oss.qualcomm.com>
From: Guodong Xu <guodong.xu@oss.qualcomm.com>
To: Ian Rogers <irogers@google.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>
Subject: Re: [PATCH] drm/msm/dp: Return MODE_BAD instead of -EINVAL from
 mode_valid callbacks
In-Reply-To: <20261119171046.1536673-1-irogers@google.com>
References: <20261119171046.1536673-1-irogers@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: aklHnjxADMwnLQC22B-BRVhdqoHrdAHz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NyBTYWx0ZWRfX8xYypUqSwrrm
 2XOBi9aIr3SRN+eR0jJFKxBi9C2NhHFTIo7SUDSubWXsK7Ifdgd4FHY9uZJJt9oeNeJtuwash0D
 ipDID5w87klfvYJ2B1zHQrVdfUhPf7g=
X-Proofpoint-GUID: aklHnjxADMwnLQC22B-BRVhdqoHrdAHz
X-Authority-Analysis: v=2.4 cv=Vra2kO2n c=1 sm=1 tr=0 ts=6b06ce0b cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=r1R2P697X4eI0gH+iewh9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=1XWaLZrsAAAA:8 a=Grc5UNRC2ANbGX2BYm4A:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NyBTYWx0ZWRfX2u1oIRPUkHHH
 qAkH16ftOmOxQOUftU3CZpiVPpI/PUJCSZpxOGQhy+xWX8zyVrJa811jMq7TS9QYT5U7/exJC+D
 1a1hbIxvkU32AMoUKdw+VSf2r/SrPm4Lc2X1Uu5LCMNtd12uTl6HhfJ5viFNV9IFZxe//EioQKe
 jRIlw1e/DGbXuDunaU73+E177k7EgQERuSr/aakulSCyfvj2sM8dqy+qj2NqxQ+b3VieXiqiJ4a
 H+C29BvvV9Y81cMuLt/Gma6nsfFLL4H/YmQgI5GuSl/Y3tohvwGCaywHbMIe8CmtoBx3Y6Z6ITo
 35d8HVMcJ6ikBoDXJNf1j0FT8JG8z82tgNsp2uR3zPGe9buP/Eajrosb8mjQAANHrZGMwsp9Sjb
 LRgxmaRlaSSojR7ajgekosbAgVKBafQmSDo1D7xP82e4qgXnSb8FvvijLEUMh+ZD/0laNF8QtDf
 DRed2msydmLvv6mKjdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1011 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250047
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ian,

On Thu, 19 Nov 2026 09:10:46 -0800, Ian Rogers wrote:
> msm_dp_display_mode_valid() and msm_edp_bridge_mode_valid() have
> return type enum drm_mode_status, but return -EINVAL (-22) when dp,
> dp->connector, or mode->clock is zero/NULL. If a mode with zero pixel
> clock is validated and pruned, passing -22 to
> drm_get_mode_status_name() computes a negative array index and fires
> WARN_ON().

Thanks for the patch. At this moment, both checks are dead code:
drm_mode_validate_basic() rejects clock == 0 before any bridge
.mode_valid() runs, and dp and dp->connector are set up before a
mode can be validated.

>
> Return MODE_BAD instead of -EINVAL in both callbacks.
>
> Found via Clang -Wassign-enum on an x86_64 allyesconfig build.
> Verified by building drivers/gpu/drm/msm/dp/dp_display.o and dp_drm.o
> with LLVM=1 W=1 (-Werror) and -Wassign-enum; not runtime-tested on
> Qualcomm Snapdragon DP/eDP hardware.
>
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Fixes: 05d001352733 ("drm/msm/dp: use the eDP bridge ops to validate eDP modes")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c0c150e2c575..51649b584573 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -759,7 +759,7 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
>
>  	if (!dp || !mode_pclk_khz || !dp->connector) {

msm_dp_display_mode_valid() is a helper shared across files. None of
the three conditions can be true today, but it may get more callers
in the future, so keeping the check there looks fine to me.

>  		DRM_ERROR("invalid params\n");
> -		return -EINVAL;
> +		return MODE_BAD;

Why not MODE_ERROR? It matches "invalid params" better.

>  	}
>
>  	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index c1e4147bfef1..dd4e8426cfe0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -251,7 +251,7 @@ static enum drm_mode_status msm_edp_bridge_mode_valid(struct drm_bridge *bridge,

This one is a static bridge callback.

>
>  	if (!dp || !mode_pclk_khz || !dp->connector) {

As explained above, none of the three conditions can be true here.
It is dead code.

>  		DRM_ERROR("invalid params\n");
> -		return -EINVAL;
> +		return MODE_BAD;
>  	}

My suggestion is to drop the entire if() check block.

BR,
Guodong

>
>  	if (msm_dp_wide_bus_available(dp))
> -- 
> 2.56.1.708.g77570a6a1d-goog
