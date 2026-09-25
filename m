Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBDCC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E3310FA5D;
	Fri, 25 Sep 2026 13:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PC94QTS8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJ4WD74w";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0710610FA5D
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:16:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P5IkT2600050
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YgTkQRn9Jl78hxcy8EjhxfN7
 hIYcFJc0FMzXtgfR1Ok=; b=PC94QTS8MLGJJcGpAeJDGmSZ7L38HLKgyvREdhLy
 K0jDy8DigbalKUVUPNmoeg7DDFpxsrvRCZeNMLOE9+wlatE5JccvdRNsXPrILZmp
 8uhuV4wP5Zj5aM7rkLOqIsUWzZT6VVu+SRriDw/P4bCnsHuzWh1iSH1jylgpXU0h
 xR05qnFnPuVi+6SWgaYVONwDDmroSchzyLZNehQZeFU4Q2UCjqqALq3pVYSSjYAv
 StH89nFhEtW9DqLS/HJRSG28r342YFTp+wBuR9jApkxrIt45FhamFkNCiJfz7amA
 xVW/IHrNVzHKF6HEe7p63qD6LRBrOv6acwR2REeiJ5v0qA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjpvsefa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:16:58 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7a04805f8f1so735173137.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790342218; x=1790947018;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YgTkQRn9Jl78hxcy8EjhxfN7hIYcFJc0FMzXtgfR1Ok=;
 b=RJ4WD74woG5bHAzDEXSlAVPxAfdW2PwahbypDxn/wCdCoQpE0iszRfAoswPdpphXvM
 REiF84xz6AGFcKoDufuDXMFP5bJXf5H2PcNvSQ9Y6bkJk4CNZSgaJVpu74SXV4wBzWJr
 RRzNilQHChlfBZ3a6G+QSxm+4EDQODHwlwbDAvLo1UBLiMUhcxKz5d8Y9dJK3GnvDxW5
 e8yLHZVSzkyJ+oJxpFYnxW5FO3MTTfx8aR83dL4j1zP4LtCeGZK6NNZo3NJ8MfKeb9l1
 2CW8ZbsdnxmiuTpejHKkjezdJWhCoNyQdvjPQsgbAmAT3un4aA0dMTdejgB4PNdt640S
 4Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790342218; x=1790947018;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YgTkQRn9Jl78hxcy8EjhxfN7hIYcFJc0FMzXtgfR1Ok=;
 b=pKvpPTXnJM3Jgd5rn3GkqfJU6meYdCqSs/JFQ0Fmdc3ARuDs/oQdJYTlHEXc1c0N9i
 +QqSC2Vk/A0XnwYKgEG6rtIzRt4SLhcbTb4zg5EvCnpLUVG8zxIK9me/f7+C2AVCByQU
 cMwbEB3Of1HKzUz8jlT751Ayo6H9dIahDbfnM4dUjZxlOftSVgGCmcjuAHRXlUeqLZ7L
 D/ep0NEOWZOSQSu1Tjj8M20nXy2brbXS3OvuZIu5kN1zBqV+5a1o8wV3+NiSFZl+fs0q
 BLDw/lV/8C60gKurePfxeUhFkUcwutfaZucUh7w14DzQjNBluPIPUKDFIhihi4Uupf0x
 /rkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHnRo8Z7IjjAGZfWwg1HLxZrOBaSGPeZL2ldLFCeMjGpjLPqhio601Encxks09nYS9+jHO1toCKOM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ni4xKLb1FPVpOmydar5+FtlIjV9R8s4JQmIWvMgsiMGvrvq2fV
 VG+D0yJUxupg53axZXFgMHMnR4Kv8nBoK9s8h7Do04FE0znZPmtMKYydzKAff+dUHzePxUmfPDI
 aR4+oC8qVsNndfJlLr5sTzWxQI4LANneLuKSo4ua/biN4KHy7vRgHzFG59V5XKCydvrOqB4Mgsq
 oCx7A=
X-Gm-Gg: AYBFou0aEWXd5pI8JdxjRQr/PtC/GgHsVVqjHAUWl6dlTWNOhGzwmZWFdcD1oVAqnuy
 FtL5r3LMVEZxsm8ZckAWdrln+FSVJGWRlSXaVoidkZuAMutr6xBkIIrr9uvgNsC+Thc+1aAZ+fX
 RgfqrkDP6FYxJYy+gQY2h4Lq1eA1yOXe1myXFvLXEGsdFSxdzX954kSiXXh3M5RzKb/veUAdadc
 X/0SYEwofI2naIMchq9UFAh4ZaMhrE+yj1v2XwMEO45W1ozkSjOSvF1soSCCC4SFtV3Cp1EmSo7
 bb94rJvn3oziQ7HnTvM5HwAkR0R8WVO4BpngFjiDSy2B/4x4njAkIkvRxI72amcVGARYzunYJSF
 wEm0j0Iqu3Vq47MPSFylL7r4AjTaCblXh+ccq8vFClNThEb/csC9VXV1zy1r5IDIELUQ3zzlWkQ
 5Zmg9PDO6K9hzc
X-Received: by 2002:a05:6102:8092:b0:7a1:3d97:fa91 with SMTP id
 ada2fe7eead31-7af1b96bb69mr2644364137.4.1790342218131; 
 Fri, 25 Sep 2026 06:16:58 -0700 (PDT)
X-Received: by 2002:a05:6102:8092:b0:7a1:3d97:fa91 with SMTP id
 ada2fe7eead31-7af1b96bb69mr2644341137.4.1790342217568; 
 Fri, 25 Sep 2026 06:16:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8e6af1318sm546173e87.35.2026.09.25.06.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:16:56 -0700 (PDT)
Date: Fri, 25 Sep 2026 16:16:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Oleg Keri <okerixx@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: don't report link training success after a
 reinit
Message-ID: <abnzr3ksgpndanmbra57px2daapzztxuqnar6jfvdhmgf5ff6s@jrvxv3gnz7o3>
References: <20260925125314.16563-1-okerixx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925125314.16563-1-okerixx@gmail.com>
X-Proofpoint-GUID: 6gTKKwMQquImNCPLT4GjN0Ld9aHh-Q1G
X-Proofpoint-ORIG-GUID: 6gTKKwMQquImNCPLT4GjN0Ld9aHh-Q1G
X-Authority-Analysis: v=2.4 cv=aLBlOr9m c=1 sm=1 tr=0 ts=6ab6744a cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=m9j_GCGoi3mryc8sS7EA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MiBTYWx0ZWRfX0Tyq8560nPRq
 bwzdKDqRBiUH8uHdJ+/+42tysmaR9I0yqNSiMgO/X2jy3Yo07fXq1zBZQUXkjZrV1FhDi47QHy0
 jCArhAFqwgAgw1zRYABz/A+8YncwZUg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MiBTYWx0ZWRfX6iPoO7u4TaNs
 kzK8Tpb3Uq+EP7jx0ACYeTPta2UompmZ/o8RccoDcElrzOmepNhXJcMe/FrRSWYjNbLTyARQN+d
 3AKcFHYs2/KcnBUAf3wTn+ZOwGlk/lvOztHo5MTk3m/U11HD5vPdP8kB7fZvJzv/oRZ7LmQZuCl
 obuZh1C57IASe79n3saM7D3RspkHDtS4Uz9/SWF9nkhOtgwntP9FJoGA7QOYwz+6Bpom5SfV0pu
 tZaYZEYNsmu2Edi/z+zjFsThPcuk04lu+jBgQyXwxgPiDV8ufFvtGC5juu7vGnGFuFvSfCDIW6E
 J3RYk5A3XCW+6YWZNzeoNV3yAGp37D95FD/e5dS8NYJdVmlxgnu4Lse92uK03u8gzxc31nNzLqI
 MeSBOVmS5cJ+wJGb4mOx/sNXtPjIFJP3YPCmn73pDKAKLnIcfQkFoOlZoZkv45hRtbZNcF+OBmN
 Zyq+hu4RDHZlS3go9+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250052
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

On Fri, Sep 25, 2026 at 02:53:14PM +0200, Oleg Keri wrote:
> When every training attempt fails, the retry loop in
> msm_dp_ctrl_on_link() ends on a successful
> msm_dp_ctrl_reinitialize_mainlink(), leaving rc at 0. The caller then
> enables the stream on an untrained link and the display stays dark.
> 
> The retry counter only reaches zero in that case, so treat it as a
> training failure.
> 
> Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Signed-off-by: Oleg Keri <okerixx@gmail.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
