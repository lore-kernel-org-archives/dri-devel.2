Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FA3F94CA2
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 00:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF7910EE0D;
	Wed, 22 Apr 2026 00:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YHCbP4zE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dx3xHb42";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F0110EDF1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:13:07 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIZpGp976785
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=t0sFYWqXHX1E0Ve8cIKEtFLv
 EiX0TTBOU1ZPl59+g/Q=; b=YHCbP4zE6GkQHsjwaq0sLINDkF8z99FlRmHKEBFU
 hKiphOc5329Gpn9CXvmL5YnpZO/woBAjnRAMV9I5kgbdChxtAQcL+z/pst+lQ8pk
 UxqFeMIk/ERvbOr7/DacJbWnLdyD2hvIz2rucEcxhUjrGZ3DbP97YHn1UO87f1z9
 bl070M4p9GbVkit/1CmfeuSptDHLfOirVcc4nvgAJwOTUzsSvQ5SMoS37zICSBCL
 0cob5GgWLffP6uBbkBXQu4s5BZbgvJkxJDoSITSogs+FFOA3fTwlPaPxGousXNap
 cS4+gzEuUVD2841RHDGkx36iwJWGrSL1sOFIiak7xka91w==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpene8vv0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:13:06 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-56f694e2ab8so4497283e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776816786; x=1777421586;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t0sFYWqXHX1E0Ve8cIKEtFLvEiX0TTBOU1ZPl59+g/Q=;
 b=dx3xHb42IX7T0UntiabsePYxPhqnm9yIcXEnzP7FOXcFLgksPzxE//ol/I8d2TWqBy
 Qpy6/p/veOuuXshhGLbQH8BZl47n2b5Anw+RWTpxm4DpumuYwFYrlu9Ge4yxIfoCcgk1
 rgZuLcivWKny4PwMgjOQpXbjgHFnIv/Tc826fKOLlq1BYtI7cQCS+BPW10URD+tRy/zh
 GuaH14JWAgcNhHvZHUofSs0Q9yM3gHuhg0WBXpO2swL6rDYMzyfcjsRgAzIGF2PVEQNB
 fNKJGKo41dEQsLqIPKMIiTzPKUL1jLXAz98wYrOE2jrAi46VVh0jcuzxyqZSCa9RDGZR
 l3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816786; x=1777421586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t0sFYWqXHX1E0Ve8cIKEtFLvEiX0TTBOU1ZPl59+g/Q=;
 b=IivQPijsrAyV2YpId5c9M/BnEV8fYOQXvJc6Lps7n7wsIQQOo0UbnRWS1AGNm90NnV
 BOJ8S4QmT56WVIiho3OXqRjwRGr1x2pIevSbJsWg4PDUwMcoUYQ4gnAnWw00NF57ZTyc
 I3KhAuhjbC9HOWdQG/Nh9YtsYzIMYaDIFP9N/Jj5REtLfcM2Kw9Ghdt4lpYpSfAZHTVR
 WkLdjnazln3LzwZtn4Vb3p2SyU+qhCYmIYZ4v9GrZp7sI351p7Kjgf79VEw9WxKo4RJu
 DR7UfMJF/uwAJ6EKLVv/vuin96IktpGXJEhIiCpL/4Ip2Y+XQA0BVOHvXhMmsvssAS40
 gOvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DrogIPWVzOKQwy/JbndfTQIH+IEzLKTZ5rJ5Y/AQMIVayIWq/UK40gyq7NOu/tN0jffTZ3or9tns=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3QxU/W8F+GnGOOxI1UzmojMty5tYrLpDkRAe83AjrDQ4OgPE3
 LyESq97hujkOUEajufHi3ft8OegSlU84fn/sKvoprRC6jJoODoxwV1h8EpP6PIm8sxOlsBgWqEN
 HzMrxsCnugZ+tJ2wtPbeyL/XUmxJUr/7lYiqsXvy8B2qccuGL+CpBfCXYWOU3da3Qc324U40=
X-Gm-Gg: AeBDieuhQ3LApcUuKQ2BhMgKCR4S5OSmm9A+NpPpNsEaxhzodiyVy90weFt6H4ELNQR
 J4B5W7zURgsuqNH2MRYQp4ezGo0sZ2scRDA6dBe7XUlCrMgxe3zq2PCHRQnpQFbYPHs9hNUIIhn
 TPphqc6ccBNOatv78jXCUujKTd5binG2QNwTTrQsS3YMADocCesz8gRPueupaB+2iyLevam1I3p
 R72DAsMB+SdjtOhylWE1XeUDjZQ7IdCexfSXzuw7GCh1Ts382s/+ttgBun6RxhdbNURlwfplxEK
 UE6DStKTuxldl4ik2UFrq84tsngyUFBvVIoluE7AD8TVKp/Wt27E3n8S2YZsArks7EQLxQgeJV3
 zGXSpjPYY/IwY/6o/Wfe/0VGAjoAwePHhQste/EkV6ahmziEqVUhz2Emoo07LIlELK6B5qy/gKa
 inFuPq5O37nYklnT7IJ7VmyQAzHU3sXOQ3YRErfKYTetwmOQ==
X-Received: by 2002:a05:6102:41ab:b0:611:7c7b:4d40 with SMTP id
 ada2fe7eead31-616f91e60e1mr9313017137.30.1776816785722; 
 Tue, 21 Apr 2026 17:13:05 -0700 (PDT)
X-Received: by 2002:a05:6102:41ab:b0:611:7c7b:4d40 with SMTP id
 ada2fe7eead31-616f91e60e1mr9312997137.30.1776816785263; 
 Tue, 21 Apr 2026 17:13:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb73de2esm31656651fa.36.2026.04.21.17.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 17:13:03 -0700 (PDT)
Date: Wed, 22 Apr 2026 03:13:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 5/6] drm/msm: fbdev: Use a DRM client buffer
Message-ID: <2bdnzz7piljtvm7wdldz522tfsq4g5alqqctxja7gazpa4znly@3ircmzhrt43u>
References: <20260421125733.209568-1-tzimmermann@suse.de>
 <20260421125733.209568-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421125733.209568-6-tzimmermann@suse.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAwMCBTYWx0ZWRfX3MLuCbEB79Yu
 jC4aZpSWmoelPg3rIRNnCNFsH4o4kCwtB23RmGZxcwOv5TJODq+vwA6AnCdE3x1i+dYU3/Pa0P1
 /UfRDOOeBSaf0P4gpub8gpcDcfnM0atcxQMKcVzyNDrG7PLXRhXa/jzCZp/CwxAlXqZdLTRA/Q4
 7ZqtE4d/IR072/Pv1ZpWiyKHTkM0fBDlWDB7mn9djSlodHCqaDKM56UJ7vCJ3vWK9G4ReCEst7D
 i+2r5MGXV4GcaceTD+ZRYbb5vbBhpMWaiOB37ZAgM3p2e2aYYQzjooTn+sqg9CqIXIwnhcLFpOe
 r+Q8evPzOGfuBEO1nzimNQ/LCmlz3FBPHcF8+YDaqHrCj58zo7luhCAvLgl2nLn7dOhsSzyAk7w
 fMC/7soonmGNqjd4ivHOeVsldEdrT+gdHyCStOGCiRP83AH9I7SpNFEam8gaakSE5gsx1esYfKY
 l8EgxVdiAc3uoni1pUw==
X-Proofpoint-GUID: cUMMjosCMegqlvErw0nOEN3cCRFExjUN
X-Proofpoint-ORIG-GUID: cUMMjosCMegqlvErw0nOEN3cCRFExjUN
X-Authority-Analysis: v=2.4 cv=RoT16imK c=1 sm=1 tr=0 ts=69e81292 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=98PYG94H7RBuGLCuRjAA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220000
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

On Tue, Apr 21, 2026 at 02:51:18PM +0200, Thomas Zimmermann wrote:
> Replace the internal DRM framebuffer with a DRM client buffer. The
> client buffer allocates the DRM framebuffer on a file and also uses
> GEM object handles via the regular ADDFB2 interfaces.
> 
> Using client-buffer interfaces unifies framebuffer allocation for
> DRM clients in user space and msm's internal fbdev emulation. It
> also simplifies the clean-up side of the fbdev emulation.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/msm/msm_fbdev.c | 55 +++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 23 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
