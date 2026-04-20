Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED5EF5A8CE
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 23:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43E710E761;
	Mon, 20 Apr 2026 23:49:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b+F4Qf9o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gYpn4gEq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 467B710E0BA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:49:32 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KJNvbP1011924
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zHnZexhHnQeNIKB6YK7141fC
 RTRiqEvP2iL5Zdf5row=; b=b+F4Qf9oFOFzD6Fp4mfwV07FxDKISP8xLeAmlVMY
 P5RS1qzqgd61/2CUnPPmB/q7MTKitaaUqg8441mGVHvSagDSxBQq3FrTBN4QMNvJ
 mjvK/FD2ywlfZwOIelJOhIvNFMJRJbCkRoSGAss9i/k0rsMAiuYxPVtNClbHqdsP
 +y4aHTaKAOVVIXeN9HjygCwZ1H/BwyTAkFSwkTHQjo3q7yAf+wz6eFibw3hFV5QD
 2aTr8Q/c7fjNHQqXJ/rPPe+AHRltcI7NIUEpaWG1CTzwMuMA4jNr2jw813vJSoNq
 6mJAkXNLVhO5FrkV2InVUFJUMg8mHuxGRp3FPAJ+64Cg+w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnt900n41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:49:31 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8aca4660827so105244936d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776728971; x=1777333771;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zHnZexhHnQeNIKB6YK7141fCRTRiqEvP2iL5Zdf5row=;
 b=gYpn4gEqOvMBHTmcRgwTF5nyM7rban/bDxA9GGh4C8ilnNkSPRFRh267rhka6MVGOO
 Vpm2i3froEFfwLZp4IZVjs2F2UPYIqWmZzjnV7/DvK+xGKW1q2Sj7S2r+tg31e7TJ+3h
 tZOSsvAKc0Qf7DgQbORgLpZj2hu81KTsd5KBJ7X/Uxuzi6/gKgVVOdLYNf1Afajwii7d
 cqCprePga9kN+97mYPrV9fZj4R4rJUOHFAy4z5w0Il3mHDM2V5o01K5cytLe7DU4Cl0z
 6qbSpThmnZJJEFWVLJKiFUH1+0GZYbfYGum0sm/8k+EbLh7cGVr7z1r5xZJ7HEddl2Jt
 hkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776728971; x=1777333771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHnZexhHnQeNIKB6YK7141fCRTRiqEvP2iL5Zdf5row=;
 b=DdEl/40RPXCjQEhePMRtm2tHZci/t/HSRPhgTRpVxMBC6kQKZfdbe1AIe7VCUN/ej9
 aqwykYPxToP3SiJzL9pNMc3WKPO8q96xOjwKS1dINV3jokn/yGBD6Uk3MHDh5YhgAXMf
 kS83JgPdsiaU78g0p07It+zMzbk3k+OtyyMY2GxSxnzByDpYiJSxUB8eRnm+XmZMroD0
 J4C9KickMVu54XcylQ6eeGd/sZkGjdXiY7FguUyTT4c1YAFj3yGySqvH3a4F3vdA0uve
 ifRz8Zui2DbRMIxxg/nFVZa4GM0KZUeCa8opd2GL650sQiwWF9elbYx7Kfjmn6FAAv0J
 QToA==
X-Gm-Message-State: AOJu0YxRP1+qbONf4iCJCmyCnoHYT9StbHHzUKLhLxwSlHByLHfpxoM2
 QMRUdUZx4HhiXzPJ6tQz63CAkSgCPxfwqodlakr0GTLgjyprqXezHFe2yekfOtDASwbuUlPGF32
 lPekA1Qrgcj7gvp2vc+CsTA5bH2TH7cDLhxbc3yhSpWFxKCEiiEyeriltHjzI4vEgqPnrdt8=
X-Gm-Gg: AeBDieuiAGGL3KR3vraKwHkyRoMKEDYSe6PG+f0DX0fD9GNxWi+as/nzIBdjR4kTR8D
 vrksu84xyOi+43aJqxZlFvSjiEVNkJ0+rkHGf9EwYhZC6yGI6cfuUwNX3QIMJKcyiBy1XhHvyX8
 zfCxvnzosM+QLpOh7fh2Nl28fPlg9T9jW+C5lrJSiDPJPr9sbuf69DyPJs8AucEzM5dJaSa3Oxj
 LVvrMfy6bGVL6ziV/4NJ1vn5VUHvn3p7m4PMbFzagrI+8HiBIT3O77modoO9PqcPkafnIBTLSbO
 AEZ5lvBdYyHImTAPsC3f47s4gRTLzpEDUcvUTmv+Nl5ES2f/+XBiG85rFuRPjASLs4FDiSa7ogT
 pSfyOcDl8tZigCvpMdqryQEnYL5M6itb/ikcqEghFIME3hWDDRJY10xBTDUy+MrYXbGYeWLZoV1
 92CA6B1kmbh79SylA1AWGAPYkwf6U1FgxMZySRc+88k26YaQ==
X-Received: by 2002:a05:6214:29e9:b0:8ac:a611:740e with SMTP id
 6a1803df08f44-8b0280ee523mr251407816d6.28.1776728970764; 
 Mon, 20 Apr 2026 16:49:30 -0700 (PDT)
X-Received: by 2002:a05:6214:29e9:b0:8ac:a611:740e with SMTP id
 6a1803df08f44-8b0280ee523mr251407446d6.28.1776728970288; 
 Mon, 20 Apr 2026 16:49:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc297sm3247435e87.18.2026.04.20.16.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 16:49:28 -0700 (PDT)
Date: Tue, 21 Apr 2026 02:49:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/13] drm/msm: Remove obsolete perf infrastructure
Message-ID: <sidcsgvqxddatwwflohsd6gjzm5ehbs4alwaejh3pnjnlhj7vm@nqxhdtxxxizs>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-2-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420222621.417276-2-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KfbidwYD c=1 sm=1 tr=0 ts=69e6bb8b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Xavkbbgx95yDZ5mQW4sA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: Bqo6nsv6jA4uenZgkoQ_rPysDmhM0Uki
X-Proofpoint-GUID: Bqo6nsv6jA4uenZgkoQ_rPysDmhM0Uki
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIzMyBTYWx0ZWRfX0BQFA8jzrUyM
 cQForXcWk5ue+n28fcaH5JFbphRoYk2JMfToLcwHs/U4HkMXMMMW+9yKsnShmeyqcoNprGQYdot
 OSwiC/2Ikmm5qeiBUhFNpJfQZVj0RtyQMD6ONqcm+9xe6c2aYuyVuG74bgGpdbvKBTFJFomBaoe
 yMjJDsCN94EPiBftvIc7LaI+fvu2EXJD8v77XSV4FLfgg8yEe0WohRbPd1x7IHuKfdNn8C2JDC2
 nIxp5SKZGdWOnf8xvqp89ejseGC0Owx2Hs6WmjrhChBL3iOQqbFs6FReg45TLKyraDiHPJ17gvf
 FWSfEvjjyNvB1V7BNlrLHP6JkFpGc9ijcaINAAFbgrCst3z+9+t4/2e7HPa8vwkIOOsEeA1QXTb
 l9EZ4YnEm5W3i3n2d8wmIhXf65zHFY28Isl7Bgoxvb5ZLgeJ/bQVkDTp1/W45r3/lkYTRglAZ+n
 QlOpumMB3et52f1VkIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200233
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

On Mon, Apr 20, 2026 at 03:25:23PM -0700, Rob Clark wrote:
> Outside of a3xx, this was never really used.  And it low-key gets in the
> way of the new perfcntr support (or at least it is confusing to have two
> things called "perf").  So lets remove it.
> 
> This drops the "perf" debugfs file.  But these days, nvtop is a better
> option.  (Plus perfetto for newer gens.)

Would it be possible to resurrect "perf" later? It was really useful.

Other than that,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Makefile          |   1 -
>  drivers/gpu/drm/msm/adreno/a2xx_gpu.c |   7 -
>  drivers/gpu/drm/msm/adreno/a3xx_gpu.c |  16 --
>  drivers/gpu/drm/msm/adreno/a4xx_gpu.c |   3 -
>  drivers/gpu/drm/msm/msm_debugfs.c     |   6 -
>  drivers/gpu/drm/msm/msm_drv.c         |   1 -
>  drivers/gpu/drm/msm/msm_drv.h         |   5 -
>  drivers/gpu/drm/msm/msm_gpu.c         | 107 ------------
>  drivers/gpu/drm/msm/msm_gpu.h         |  31 ----
>  drivers/gpu/drm/msm/msm_perf.c        | 235 --------------------------
>  10 files changed, 412 deletions(-)
>  delete mode 100644 drivers/gpu/drm/msm/msm_perf.c
> 

-- 
With best wishes
Dmitry
