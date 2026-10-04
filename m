Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D25CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 03:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2846910E19C;
	Sun,  4 Oct 2026 03:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AUYyJhVi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F5GqNt5V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B4310E19C
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 03:20:23 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6941klKU2167378
 for <dri-devel@lists.freedesktop.org>; Sun, 4 Oct 2026 03:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wwzwV9aFuwIXK56SSztcZ1Mu
 EY+VheNe9eTYzrH0MpQ=; b=AUYyJhVi+zBGfbhtUZtKDbKxAJk2XJcl30M1e7vk
 ZcCVey6kO1eadZJzm4dMsMy1mAo6yeu7akHwJNJpjVniKhXvvrHAUBHupzDFLFAG
 2hWtZ79MYBNXPfnow626hmBj7yLiq52IOT4f4ZheB/NHkvPCucu86d4bjA23MFye
 V5D1Do4DlY2aSVNtN5DDUIqUW0BCjQv0CVofNxkf4Lc6jRC8hW1VbwI6shsSyggi
 B32SKd6KicxXUbFqd9ZXdpkUIdmTOnQiZTxdj+o1DiTs0Wen0rs7M0NdvxWWapJg
 Uoc8aKd8ldxWw24816MghA3qBQgcvb4Viufm450hOcJZTg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2spa2af7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 03:20:22 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5dbb583d018so191507e0c.3
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 20:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791084021; x=1791688821;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wwzwV9aFuwIXK56SSztcZ1MuEY+VheNe9eTYzrH0MpQ=;
 b=F5GqNt5V+Jq4K5F6Jh5JRrHGmRRcNkn34RLHt0QVPSm2BomEQD/7V0rC37uNh3ArRo
 FqIBP5BwtLEyImIHrKhT7SHZe0alkX8Npecq8Oux0EbqEJwMY6Zz4PQgrYBrPqVf2Ixv
 P0qdoyXD6DDRX5Ci1PlXEEMzBaP9i0iuSfvAR2rCw/oz6pI1qr8BPJ6/fU6lPhZJu5yU
 nIiAUSNVmy3pYjXvDqLg7/FKW11lTmnrXwsjlFMUjjZAk5kSdkBFcUa/6lM+NYBOoQKf
 oFzqtCXYgmummJZ9+YMuCu/iJN4hMJZcrZlKDt/8Y1bmZEKtnq8wzQZC76YNUop72z6d
 +8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791084021; x=1791688821;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wwzwV9aFuwIXK56SSztcZ1MuEY+VheNe9eTYzrH0MpQ=;
 b=wZnXYkqxlGqwIY5SRQ76g0OLam/v51nuLeEnepPdtlBN9gLINM4srpntk2YkT1bT88
 4c7DVDtFK6yoca03iM4iOQIAZLfVllx6Gner0/GDyHczlbdlE6PfHmxfAFty0j+MawyA
 c+uYSwUJdFBcNGnbFEJMn/LBZx8jdCRtYsHZYwoy8MJLn1YO88w+9rkpFGASgMWtiaHl
 S5ueOSqe1fwq09wYhMEVVROPxgOshMXIrY4kVhqeLnDU0zaryYlwjfol/hMwtmnfocD1
 fGXFgdK/86/C9kbpUnyH9RAbcb7adFGuuCX4zGXT7mPbzldSoVH2CvtJ06nIkFmCknSO
 mPQg==
X-Gm-Message-State: AFq9FYJ1qy+L4/Xek3aY/3tSJWMuCMuNljfZry8yhpAPV9+kRICIFbUj
 kNI8SgMG0UcfEMXJYwulcz/MVzxDcVwDMbb/L2GDV9wn7TXEBbr+359Beq+6L1X3kTxrXyjeqzQ
 Fm5uJyfhfpdA9vnQ5ViVOutDMZNDs2gi7uR9we8OAHQzFeae5Hm/6MoylV8E3FwMVSOk/fRk=
X-Gm-Gg: AYBFou04Nm0EOphka3TmPjZxf9jUmj21bwViKeAcNgrm87xU6ns4OrCtRHHfsSEE8GS
 +Woo0MWAbb66BkTtlJwWSiRJ+SCl8lUAHEifkSFZ8gdb0AK00B6kD7n2MXYUe+XkUeEX65EBapT
 5FLqeitWiFxW+gMasW9eDctUqQyPOnQZ7chvBGMpN3Jy21wz2/y8D8KFMGf3wL6rbgLtNwSya9I
 iV8aT6rLYIozrnHSxe1J76W7S+PxPkNPwIiix18aLz6Jei87pb8q9TZRSgp1SyDqCUT+4/Yh0Ra
 6HhtVSyR4OHuFaFQKLhTvhD4pdc6Qxc2t2HrvZZxU6cvm5FyhphMm8L+QJD5TSFFZTkGn+ndb3v
 wYUhNgTVWLi5nCIkCqxNt5Jll285FAvsxOzWq6DbfbHs+G+O7/WQiGXwI8M/ky5e9ge6CyPX4q5
 FOy8cKRMdm0mSt
X-Received: by 2002:a05:6102:4190:b0:7c3:5218:1dee with SMTP id
 ada2fe7eead31-7c352182ba3mr401424137.19.1791084021164; 
 Sat, 03 Oct 2026 20:20:21 -0700 (PDT)
X-Received: by 2002:a05:6102:4190:b0:7c3:5218:1dee with SMTP id
 ada2fe7eead31-7c352182ba3mr401415137.19.1791084020708; 
 Sat, 03 Oct 2026 20:20:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e2f7e43sm26563241fa.11.2026.10.03.20.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 20:20:19 -0700 (PDT)
Date: Sun, 4 Oct 2026 06:20:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: Sync registers from mesa
Message-ID: <pxzdepjxrwdpboj2bktlbpslj4r7zabnccifnaae7hmteoga7i@dvpsliuxzvok>
References: <20261003223723.400020-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003223723.400020-1-robin.clark@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDAxMiBTYWx0ZWRfX1Tn4/0joa2ja
 DjUmnl7QrWMt3NIV/zRwBum5kKRcuv6YNBEYaavgKxScdL/3IFDgaTOWApdVWySy3+CrQxFGqHz
 o5BdrCfJtToD3RzLjdXx7376ezfUu5qgr6pAqW3Um9sM79bXJNWpkA+XLdRi8X6ZzzMhbTfC2DB
 K3EoeGNefM3k69q7fmKwmR+/IYTwLxbWoS2uFX9MJQ6w4yaaEUCXpHMo9eLbMZNiktyMun/pQhN
 gZSzXXZmuBRyENIS9+G6Us7MWupr7YVL/Rs00MX1dSD3VU/S3lB9tCzqagM9SAsHVUUjAl5/OlP
 XnzcOOg681nYUFOSHKlWzdxB66g1tAxeBUj1r/awmQdNoltqIjKePtfWpXzkGSCP3f4hK5VKJn/
 7fbb29vTlhPvS0qbhZlDIuxzPumuAXj9hJgUsT0p8H00oLig3G/B2dL1DnF2y9QV+9s0AFL8yms
 XX03gFN18+hPnW5yBJw==
X-Authority-Analysis: v=2.4 cv=b7MncdGx c=1 sm=1 tr=0 ts=6ac1c5f6 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=-2mmMjQWwNZ6YRhNbUMA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: XtNPOlfM9WmP-UbbCs4_cSAWydyJC_Xi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDAxMiBTYWx0ZWRfXwfkFKa0psgF1
 hCjFAaY9OffBLIZrVa980ey6jBCzM/7fGvc3sNxsrx12yQl/KsHRgw6EJc/Fh2tgOWl7zxySAij
 NpuiJx+bML9I7sMJURq/D6UMQf3Wwfo=
X-Proofpoint-GUID: XtNPOlfM9WmP-UbbCs4_cSAWydyJC_Xi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_04,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610040012
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

On Sat, Oct 03, 2026 at 03:37:22PM -0700, Rob Clark wrote:
> Sync changes from mesa commit 81fae85847d2 ("freedreno/registers: Sync
> xml changes back from kernel").
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  2 +-
>  drivers/gpu/drm/msm/registers/adreno/a2xx.xml | 25 +++---
>  drivers/gpu/drm/msm/registers/adreno/a5xx.xml | 17 ++++
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 81 +++++++++++++------
>  .../drm/msm/registers/adreno/adreno_pm4.xml   | 41 ++++++----
>  5 files changed, 116 insertions(+), 50 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
