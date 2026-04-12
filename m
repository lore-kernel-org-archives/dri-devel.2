Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C778AF3ED6B
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1D610E26B;
	Sun, 12 Apr 2026 00:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SMvI7ZiN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YDTBW/jh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E11D510E270
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:19:23 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B46Vp02625041
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=HG34mRyRdzGkG6Z2EcYGRJjv
 Yjv6kPKsvntW5JOtB/U=; b=SMvI7ZiNOllJZYbCnG3Ur/rSm1+htlFqhMZqUorX
 P5m+n3lAy9/6HqhvptrmYiZdjSvpxV+Cfng3DISrHpEkUsOMvY8BmNq7FldtnRgv
 dX6TZfVanNTPc7yxCTDnWFLHexVvIBKVBNL28lOatAaNvXgbbMqP/M48uHpe8Ws4
 o2zzaw8gY9xJmppn7yLcQPGk1ih0KWRV6wxdh80zZCb9KngLQbYH3Uuh936Lz8m6
 N2VkLNrNf4505tYM0vt465i6BEX6e+wkHhgfXv5mtfDJrmb/cxazEGeu17XOh5/N
 aL9qNbiWz7ggWa9Y4J+sW3mi7P548ApvYQKxpzlAibPjxQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfeyysjgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:19:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4031b86dso86042171cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775953162; x=1776557962;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HG34mRyRdzGkG6Z2EcYGRJjvYjv6kPKsvntW5JOtB/U=;
 b=YDTBW/jh5n9v7qjWUvBkj+ml51TvLI9x4k8fwVtLnariG3FvHIhdOXFf+x2T1MUlB0
 uB4EoKyRBaiy8n/wXU+uRcxseFqZjDRbndA8/iV0NMZnRJTv29Y/6fbtv5R0ggDGQNpM
 j6Ia48spX76ueBCEDCPOGCs4KHKaUrdOBbsuXeJxKHRYIrPhw6KEhNV6RlunhbGhJ8Yu
 cSG8e93P95i0pM3BX5rwE4sMQXbmCBRwJ0AenVnTc7Ctu9FdASCijr5zLY2kakkTvYz9
 ZhGa8rpq8DTI/TvPIlOUigOKLQXnmZ5NzTHxgZc+kVH693G9mCyY5ts6AyTHnFZxlMru
 gkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775953162; x=1776557962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HG34mRyRdzGkG6Z2EcYGRJjvYjv6kPKsvntW5JOtB/U=;
 b=i9CMVhDlkT/z7fKK9q01hOJYaW6OTzVgtLSNPy8wmeBmx7HJS605xe8O9EbNlyYjK6
 EsuTQ/ZeyX0KADI6Q6u1/ldFeQ3tUYG6giQL6RRXDK04DdFzLwF54Dov/MNQMU6H9VUD
 gZFi+TWsn4zc2dBjH/Tq03GfOmUe/kuT01IUQwuetFu0F0wl0pkO88wbO1UZLjfQV353
 KVkhOowbhuLQk9VJusAovzkLAiM5xjygBza6CKh75NZGYW0LZM9wfKpOfEPdRQEFF+ff
 iRzA7O7f41+EOFCUTzREK15/zf0Jwekih8QlzUpwtpsmfbHVDQ8JXOYASz2SKYKC7jpE
 8VXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwM2nB5A6kk1LfL2zd4seocen+Rf6NFwRkA8VzojtszAlnUvCWQWHspM43ay+23n5VTT/XAJBzNPA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8S5cFH+tRKH2KDGPf3XemM1qLFQq34Qh7cmOEnuWMxUZhRiG2
 tYs00ACykiPhtQEMTCQtQy1WSMYDCTEKyATi/ehOjUke63i6dVV+pWVh2L1OKSLt1/U0vmzyH/h
 Ffq9oEnw5Q9ZxstXquHKV9nFXemn1pB2dTNFCdcnCykaK8Tvt8em6Bti//Trj3wd0zoIkf88=
X-Gm-Gg: AeBDiesDnO+7QZuu9xB1dCmy618o+H083Fwkh0a3i3SYqlMwb7LbvX00puCtsje9/ne
 /AI1bqqXsdHFe9oBBc0urwlPQ0C0MsrrnpNRSTZteX/DDcCdoL/BSz1bYldhEAKFjcjUld7nHYB
 WwczRfjpPStPbekeLL7/5Qv4KbJDbYnqdKo1mlye449EXZ/NJjhoKPqpN233Ju1TRcykMyeEMYU
 +3An7NbkQf9nhzUw6Riw4iiuTjMes1cdskN3kHO7DhpVLHX4avcMPa8WYuD7Adlcrdr3JnqauXc
 1hAjsbxALGsdWnHPW1aqtswT47p1HF+x/F/MymgYnfvVjodD7ObKP6FeD8TM/+ASp4o3Iqa7pXq
 +iktu3gVgwySgu2yqTt3rk3TFjcBupVuOr3i/acZ4MQ5+l95zWaDM7aAG/QmF02xokogtXMj5ZK
 Af6KDTewQ5DVYD6Boi0dhJQ7VRg5dSY25jVxY=
X-Received: by 2002:a05:622a:24c:b0:50b:4c64:4730 with SMTP id
 d75a77b69052e-50dd5abce85mr125292561cf.15.1775953162167; 
 Sat, 11 Apr 2026 17:19:22 -0700 (PDT)
X-Received: by 2002:a05:622a:24c:b0:50b:4c64:4730 with SMTP id
 d75a77b69052e-50dd5abce85mr125292181cf.15.1775953161683; 
 Sat, 11 Apr 2026 17:19:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eef07a85sm1679336e87.79.2026.04.11.17.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 17:19:19 -0700 (PDT)
Date: Sun, 12 Apr 2026 03:19:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 31/39] drm/msm/dp: add prepared to manage link-level
 operations
Message-ID: <xwapwx65ra3gwnjd6rcjjreymgrfokovor35zd5mc2tbjmpbor@64x23imgktba>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-31-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-31-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-GUID: cJZ2aUpgNL2SP1Ye-QD-ng4sl4Ntt9ma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDAwMCBTYWx0ZWRfX72bcw2OKNOCM
 9e2Vs8bHSMY++DImdpRoYUrkGokTZx/YuDaNeZYlbHwPQnWUjz2o6JJq9f3SdAONQZSYTDUJ0Mh
 yGYW8rd3uQtfP0xF4kkAW180o80F7LefQM5DpK0xR9GhGnIUy4xlglQJmJ/oT2F6/PIh7I08fQ8
 2ENtCXsVZ8NSYohiLkSmdGGZn+wykbsdKm7e7zB6sac/wwmPzdZlHN4BUdriO7Wc1j8vcowKuLQ
 eJpoKZ+m2KLuMrII8s2jEJC+jcmBBtJZHv3zKHNjQnNW2Q42Qy4emEKWRg63lm3cZ5G/7YMZsbj
 dh6H0N/Pf4THzG7IFfyKJKLoqpsinns0P1ewtuSxsYFKf1yBa0L48qCWoEnQfu4gTGaFEYOKeGR
 MR45YaIvz6bFyzrOnICQVrSJbUBp652FWDH/jWg386/8fCZW7XxTtSw3Snp9LMwcPFCVyrRvhia
 Z5tRBXjDb9YSFfLfc2A==
X-Authority-Analysis: v=2.4 cv=FPQrAeos c=1 sm=1 tr=0 ts=69dae50b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Gm__qMjIzjNoudeQ8KAA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: cJZ2aUpgNL2SP1Ye-QD-ng4sl4Ntt9ma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120000
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

On Fri, Apr 10, 2026 at 05:34:06PM +0800, Yongxing Mou wrote:
> In MST mode, multiple streams share the same DP link. Track a prepared
> state so msm_dp_display_prepare() runs only once per link and repeated
> calls are skipped.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 34 ++++++++++++++++++++++++++--------
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 5f3ef295d710..bda76319c459 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -22,6 +22,7 @@ struct msm_dp {
>  	bool mst_active;
>  	unsigned int connector_type;
>  	bool is_edp;
> +	bool prepared;

link_ready

>  
>  	struct msm_dp_audio *msm_dp_audio;
>  	bool psr_supported;
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
