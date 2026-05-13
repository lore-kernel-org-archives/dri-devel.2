Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F234BCD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626C110EFE9;
	Wed, 13 May 2026 18:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fDpH1Urq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e4UbnDbx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22FD910EFE9
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:55:23 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DG1iOo3008285
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TY3hRC6xWGaXeiOL/4+fJ0R8
 wTbjlVnLAhpgz+1/EcU=; b=fDpH1UrqxCcOyXo+UM8jVH0fDcoUOBhZNwa2eUgK
 NVOtX75KaieBfDLmtmlOeUI1Vgx3hfrddRaSUvJ9vXuYPuqKPQZAZ+vD16rcA0OO
 bylAgDcLYh7BVmizW0XS6K3i5VY/Qs2+WUm5lQm2vIkrR80/eZoScmtXmjmDzcEt
 bdmAMykGRyQwmbY76/P9foqEWZDadogQ5JUcE7uaQP1CzwhxOok+1AgmYMRLZ4is
 z5N34qSlYgTER9AHqpmyCqBdKtGyIrosxjRqvYrbURfR3DF82v9ADsXTeexVmEQG
 KZn8LOvozZsMB3RUXj70+CNX+6Jkelai6jrPum85bdIY1w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4py0j635-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:55:22 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-63136f3c5d6so7810032137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778698521; x=1779303321;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TY3hRC6xWGaXeiOL/4+fJ0R8wTbjlVnLAhpgz+1/EcU=;
 b=e4UbnDbxK42tfxiKmqxQG86QMRPq4+HvqmqIxoym4JWlNdjQUox/WUHKcVjG9Gf/Ib
 MPd13+UExEhqWeWCFmw9xRB2YJTnrJCHBHmrSsZjgR8cPTy0TTzkymorjtX9XlZ11fNo
 KITusUaVxMeQkm7fkyE5bnK6a/CdLMsSE/bUIK/famia6Ty79UX0YbHBHwtWmnto3KLR
 8x0HOIuzKO25nxVy8LXdUk6Ky0u5BCvwQBC7hbLzIa0Tz9Zy6GtKx8nAlzgt23XMQZYH
 2i+uqthwjsfw9D7fyy0Kdmc2ElLEB+bGFPnkrhNbtss0L9pbmOJHglgNxDWX56vAptlG
 x8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778698521; x=1779303321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TY3hRC6xWGaXeiOL/4+fJ0R8wTbjlVnLAhpgz+1/EcU=;
 b=SukjvcYY9KU2i0yKYhj/HnSZhzKt9GR+2hvOBFJ4PJ6GLhEJEvSV7Cb3xIB9m3x8E1
 R0Z0Q89JbdjJnl0jz7qn43/jeTX1CIoIp//P+TsIPw0mBSiP0C/9UKzVIFVzQF5ofF9A
 nbO7dFbOsWJbyJqc9rV5wkfaan3/WFFb2y2yHhtL2VLmIcMpoEPWM9oTpwis2IBtaieM
 iGSmMb6EYd7xqOderQBNPJ8ShQsMm7A/y8iyKPKFxJAEviKhpp/zaSwE6moQRNJhbQ8X
 nX48Qg//TycDuRz54puYasXwTZaY9y0VuEvqiHFIgwbL14Dw+r0ZSr8LbZnUuw2D9cdL
 OPPQ==
X-Gm-Message-State: AOJu0YzwhBIfaqSe2NznmyLwQ0NqeYnhD+2KbmFoo1iihJ5hlNAAPLQH
 ihNiiITjW01JdI1EP7A9ekyJ/uCjtRjtgeJ9W92IgxF5Ws5TNA+ozsWwL4tYqu7P2X4tiULM1fm
 rKmBiwBJhqnNxOF5A17q2ZEvD3T/WRPHrWyVBDOOyNw9ocox+rvEfMzB7h0ZjPHa5CeC3Q/g=
X-Gm-Gg: Acq92OFh4kxT3xw+awyinqGgVbp+IQtVJovwHUHzoyb2FQTIEWd1o4pBgua5oUn4SOR
 FTv2cZMuTdxSp+o1o/4jVnnaea+PJKruyCoD9M5moZGofOyT9VGGzcEtIcuw9tuQ9iO1DfINC8E
 BKRfzLFN9D2mfeUyfMT0SWuLC48ZOE5ke8L5pts15uwrzwFO1uwAz0hGmTflrcZVIBbPtd2BKgz
 zEbKEc+tokgGEvVJa9w9ouKNdAFIJAXWvtisH1oB2bcOJdIxpUv2VRxYerhcX/BwTL+ScbpC5lz
 Xg+fVaKWuH0q+OFMB+nw5/uts95P7VmxhNDZkDJWKFEzMTk1uZ422THy2U6nF87l/+HtVZQI4iW
 NI6cdreDYoD8/rhLNDijC/Mz8q1XAsoyZFq2/QGAGl8bYd6jt76EQunx10mreZiyjOaa/JzCxSX
 e/FzfMe9I29BydKCwuVDSHWflIwJilQIjcaWI=
X-Received: by 2002:a05:6102:1512:b0:61a:c2e2:932e with SMTP id
 ada2fe7eead31-637aaa57d2bmr2368666137.22.1778698521584; 
 Wed, 13 May 2026 11:55:21 -0700 (PDT)
X-Received: by 2002:a05:6102:1512:b0:61a:c2e2:932e with SMTP id
 ada2fe7eead31-637aaa57d2bmr2368637137.22.1778698521073; 
 Wed, 13 May 2026 11:55:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a955df99sm4329747e87.45.2026.05.13.11.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:55:19 -0700 (PDT)
Date: Wed, 13 May 2026 21:55:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 06/16] drm/msm: Add a6xx+ perfcntr tables
Message-ID: <irbg5jjlwq6imiiwf6yfgvwg4wvdfwdkvimh52hnnmm3s7dbf6@ikcemlfpkel2>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
 <20260511130017.96867-7-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511130017.96867-7-robin.clark@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NiBTYWx0ZWRfX+KBj/ZPuNB9N
 UJBJM6+oCV8xyPKSTfnDaiu6f/H8r13rCZrPQ534DLFnz08Zq09snOFSH99DoBiNQ1O6+eWmVkU
 yNEfraCxLYWTfFD35c6TKRSFllINlo/JuTHB5vlE+PuZr53OiVQpEnXIWUHSZLfHagn62r4ydNL
 cBwhwZbkDGVaVVyx0PRCwEuZKQeGsAii3FAjAzbP7Z1/3UFB4DyTOHKCTuOxA7ihN1gZFpjZkiW
 rP0BKd9zqwg7SoKYqxaCouuGzP70d55hl3bfnEFLd9zRa1wL3c45UPG1jX5lm3ao9e+sTT4mpJT
 RsCJzLnN7c93isuUSLfcd6o5llewNi7IYTpnj9f2rUKmKVCdYz5NOZRwxHl5YQn3b3b9vw+9W41
 CcNXBMKcVmIz/VbhOPqHi8Li7n/ohzVRRLVLADRg1eX0W+nUwkpBKiFD4ewz2ZUrCxnXHP/+EMc
 OSB4E8YAOiThoWMSndA==
X-Authority-Analysis: v=2.4 cv=XqXK/1F9 c=1 sm=1 tr=0 ts=6a04c91a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=-2mmMjQWwNZ6YRhNbUMA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: r4AD7JAkfOdWxMfx8pY7ulI5RbQn2Val
X-Proofpoint-GUID: r4AD7JAkfOdWxMfx8pY7ulI5RbQn2Val
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130186
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

On Mon, May 11, 2026 at 05:59:19AM -0700, Rob Clark wrote:
> Wire up the generated perfcntr tables for a6xx+.  The PERFCNTR_CONFIG
> ioctl will use this information to assign counters.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 15 +++++++++++++++
>  drivers/gpu/drm/msm/msm_gpu.h         |  4 ++++
>  drivers/gpu/drm/msm/msm_perfcntr.h    |  9 +++++++++
>  3 files changed, 28 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
