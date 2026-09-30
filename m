Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD32CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1836A10F4EA;
	Wed, 30 Sep 2026 16:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CSkxcT2e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J3lM07Yb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E5F10F4DF
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:05:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UEvYuh274512
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lVSSkheA67JcJaOOxaTY5iya
 49LPdhkaRKnKJzVkXi0=; b=CSkxcT2e2v3iw0zQDW8ukNDekQ1EQyJ90AyZpxrk
 fJ1EA2EAd/6v6jQErtU70Dv6BAnGdNfKcYb7iZ2bZZSPm749W+a74EqVYlgAGA8X
 WQjhYe5Huy5G0d0AbtBZQxoPRmu8jyLcslGCSDEmQhWVDmPtbi8QZT35TeSCmJ3v
 sCZuayG/N7MLbQkK33Td3lJxb3tc6B+7vTAx68TDwWIpu17SjPeUGsX4aQIVN3MW
 XkBHd5vBMZ9zCymIjxSZwDfBHXTuXuuR3uYp5wNAE/FMJghJOb2L+mSq6PhXA2My
 LnVdFYNKcHczR2WWNvBIbgQHC8mEnuYW8GSue1hdn2d2ag==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n20ay0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:05:51 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-98087b0c5deso4300931241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790784351; x=1791389151;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lVSSkheA67JcJaOOxaTY5iya49LPdhkaRKnKJzVkXi0=;
 b=J3lM07Yb12nkMXHg02G5E/gkRyGexzvfWiW8O6rDf5jJJ49vVknCmv+nC+htHddcHb
 a1X8reMyqbehH2VdwqwhLcLK/zrmo+YD9qy5NKzfu0sosmHbwnQ3wA3VH4XBsEYl9tZr
 OucTXC2UyCoWFzL3VJNm7r0430gpOn+od+i7C2gDQsZjOnbJNgMFHz29QYhXvE/HkAlQ
 JNmFdE3HYu7TpSgbqpsIL9oyfc3nP2vy/LaDzKADj4kCm6koNfBbXlL9dEKVGBFIxfRz
 XWUM7HN4RK545Ibot04fRrzNUxtH6wecyw1EwDDMea6TaMZb/yQybscxYX5a9WOP21pz
 ZYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790784351; x=1791389151;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lVSSkheA67JcJaOOxaTY5iya49LPdhkaRKnKJzVkXi0=;
 b=JX7cAeOuxV4PkScjWcv/MDD70XbZ2Fh7ZSEZazTZIl5vKNuyxVEMqdVsxiR8Am8Zud
 jEjekB/0+6ptnm847Xhmipzwgy47UIMeiow0OIzIbJXsHYroavC9mKPLrpvNiWJsn1gk
 S/J4iRe08av5ROWuHuPQySXxHeJ3RVkouWcOuol5K4fEu/udQc3w4uzEOCtEHI4h56Gs
 90SF9s74Kuvob92Sg2bFxBuFpnyK5Bed8R/Zt+fnVJd0vHzHko1rNTzZ4n223yaNt4Nz
 2jteTT4JBUnMy5imsEUdcxQc9DOyLhjs/ZYX+zWFWcxkQzMZrk61eIPI7aw/jrdrbXau
 QkUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaApXfFGKvrkUsh4ohoMyfh0l57og9kBOV153+ouSJTBAEYiICxWBe8/SSksJEi2yRvGiCNJ+1a4c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIP0P4ehlox2ns+xkCcqYvcQZTMrH8d5pHJas8z6NxiP4TurXmB
 tL/C/lzMZmFZ2y2iRaVULZN0xD6CZEzwhK8ag3NL8HbpN1GMFyKkB/C1+wXhnTK7H6ZymY8jQGo
 kh5T628HodijkqO9GGhAGqlxklV1l3xp32mPf7YJ5DrHTBMAIUPsQd1jiYAl+/ZZxZZCGH3s=
X-Gm-Gg: AYBFou1GhncRWxdeinEue+7K0DZ0Pjy3QZqZQvfwNM12eRlHHDF6db0HPCto8XzGEdV
 YFZEGIQxprpNl5QgenDr/b0MGQpOICsf9t2l2ZB6Ufe8TYql1gqVlJZ+dJiSzhfxQ9vzhQT9wN9
 rAgqo2eiUgJXxRAkbXnBN88KBlZiPSlzEErVhfdAyAL9jYMtBdbRGh4X/LvG6a6PFehoq7hi0Sj
 xV4S5iGY1q3aX648gkhplUGNCr9klS2cRAsQjVxB2AoSZsVj1itJTE9cwenj64cZmQEfQJu8JLb
 rcx0qfy8LYDkn4tIIy9D/cr0sWPqykZ/PWO41Hu59zsqj2Mx4qsAAGR3qXlNsnucQDwLz6DrhT3
 4miUSyMgr9PIQLvnQOxZjCalcW6ZBsuFCu8zz1/W7e6ulWw9rWL6iedm/RMB1zQpQxbogHBsMEI
 12KAOWan8F9gUQ
X-Received: by 2002:a05:6102:2924:b0:7a1:f7c3:3a41 with SMTP id
 ada2fe7eead31-7be72da8338mr544560137.14.1790784351093; 
 Wed, 30 Sep 2026 09:05:51 -0700 (PDT)
X-Received: by 2002:a05:6102:2924:b0:7a1:f7c3:3a41 with SMTP id
 ada2fe7eead31-7be72da8338mr544540137.14.1790784350574; 
 Wed, 30 Sep 2026 09:05:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42f7d653sm89094e87.5.2026.09.30.09.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:05:49 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:05:47 +0300
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
Subject: Re: [PATCH 02/13] drm/msm/dp: Support multiple generic SDP slots
Message-ID: <exo4twskpmrpvuspuka7pstg5psenkeztcj66cmzebhfusjjme@fda4wrt7czzh>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-2-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-msm-dp-hdr10-v1-2-dbbf8b2b42bc@radxa.com>
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abd335f cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=ksxQWNrZAAAA:8
 a=EUspDBNiAAAA:8 a=dRvoGPQ9uURqmwrP_ZcA:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX5omYtGSVR6B0
 3ZROedR4dKh+vH3yDkDpRPnFE+Mtj+vL2Vwo0Uxi/S2GpbXB0e+ymSKjfIXKMipllAPYSxA2fDv
 LRMtjSMFDqKy6eJMJfuUZI4LIsFdhC4=
X-Proofpoint-GUID: LmgEX3xYzDlLlnk0sB3N941U6vZ2A886
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX4gpVRcf/0aVC
 CHJDkQvrYEr/dVgveNasNnljbs6DJWWUCV6esQbNekL08nR9M34iGY09vWLiW5OELjAhL3zwgfr
 He0ESMHT2uXagpKcDYFGwsRS4QDVbSrzCdUhCKBBN7gKro4hodeTQWQRHy/NzoJTCEPLPaZJJXH
 n+VcW05AqWzMsQzLkGfaBxQN95X+EFpO5LZoKGp2yKOg8rYDM4p5G1TuDzhAUKMiZrgAmF4FUjN
 h5H0VZlcf7Ucf4bnakARcLLa4rvErB0+2pAGsuckcS1g7aCwsaBdA15xnzgjr2u5Hro/NBtPohA
 PXWTjzarnJOwRlQiuHfrp+b2TNYm4Fyl2ENhaF76y4rmtCsbvlKqPYpDxTAv+Yc5ui5CpumP4FE
 A5lwyPmVeFP3WC0yxy90tFL9vWzdENSxVUjgZAZvz6Ti6j+eKKxOyqao+Y3qrm0Sh95y/UyK8gX
 QJ9osacB9YDsLVeAbaQ==
X-Proofpoint-ORIG-GUID: LmgEX3xYzDlLlnk0sB3N941U6vZ2A886
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300064
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

On Wed, Sep 30, 2026 at 08:41:46PM +0800, Xilin Wu wrote:
> The SDP writer currently targets Generic0 for VSC packets. Static HDR
> metadata needs a separate slot so that both packets can be sent on the
> same stream.
> 
> Allow the SDP writer to address a generic packet slot, and define the
> Generic2 registers needed for static HDR metadata. Use unaligned
> little-endian loads for the payload words and accept a const SDP header.
> 
> The existing VSC packet continues to use Generic0 without changing its
> layout or enable sequence.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_panel.c | 22 ++++++++++------------
>  drivers/gpu/drm/msm/dp/dp_reg.h   |  4 ++++
>  drivers/gpu/drm/msm/dp/dp_utils.c |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_utils.h |  3 ++-
>  4 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_utils.c b/drivers/gpu/drm/msm/dp/dp_utils.c
> index 4a5ebb0c33b8..226b370ce8fe 100644
> --- a/drivers/gpu/drm/msm/dp/dp_utils.c
> +++ b/drivers/gpu/drm/msm/dp/dp_utils.c
> @@ -74,7 +74,8 @@ u8 msm_dp_utils_calculate_parity(u32 data)
>  	return parity_byte;
>  }
>  
> -void msm_dp_utils_pack_sdp_header(struct dp_sdp_header *sdp_header, u32 header_buff[2])
> +void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
> +				  u32 header_buff[2])

Nit: separate commit for this one, please.

Feel free to use for both of them:



Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



>  {
>  	header_buff[0] = FIELD_PREP(HEADER_0_MASK, sdp_header->HB0) |
>  		FIELD_PREP(PARITY_0_MASK, msm_dp_utils_calculate_parity(sdp_header->HB0)) |
> diff --git a/drivers/gpu/drm/msm/dp/dp_utils.h b/drivers/gpu/drm/msm/dp/dp_utils.h
> index 2e4f98a863c4..2fdb89efc57c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_utils.h
> +++ b/drivers/gpu/drm/msm/dp/dp_utils.h
> @@ -31,6 +31,7 @@
>  u8 msm_dp_utils_get_g0_value(u8 data);
>  u8 msm_dp_utils_get_g1_value(u8 data);
>  u8 msm_dp_utils_calculate_parity(u32 data);
> -void msm_dp_utils_pack_sdp_header(struct dp_sdp_header *sdp_header, u32 header_buff[2]);
> +void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
> +				  u32 header_buff[2]);
>  
>  #endif /* _DP_UTILS_H_ */
> 
> -- 
> 2.55.0
> 

-- 
With best wishes
Dmitry
