Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70DBCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECDD10EE18;
	Mon,  8 Jun 2026 07:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jpcG/D0X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XJvnZDcU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D66610EE17
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:19:44 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Okq02347139
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 07:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TszHFZ7K4js/ZAFR2FtK66NQ
 PI9cujME4oGOjetByeg=; b=jpcG/D0X2/E/WrFN1uFBDKV/q4WUAZwxEvep5M1J
 j1BiCdduPfaq02JEUHAzRRGLIAwq7CjazfFRjN+HyM+LAM2dyysoT7hDLqIfAvXz
 9Nwg5sfFc+41cIR/o+5tI5fRue7n2BZoRBGGIh5VJLcSrlIjAnd39++ucNtF89fP
 bKfGg8DXlFg8BDDJFMlnFQDFUXh/JXj1VoZYWzUC8f/bcUENSh+7CQoCmrODHd/2
 YiSkB7eeV7/TuLUszkH9X6BWGlPIN4wX9gb26VtOQ97G5a10pPn7UCuS583WphJE
 jp469EdWpssWsVebwH5dn3ZN4TXUWvfxF6wbVymaoP7obQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagres95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 07:19:43 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-963b099b539so6169772241.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780903183; x=1781507983;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TszHFZ7K4js/ZAFR2FtK66NQPI9cujME4oGOjetByeg=;
 b=XJvnZDcUhnT/CrGS7e0LodTTm7H6aYGgjxxOTcSgaH0AEGZMhc2mLL7fYAJAQy3PSC
 KoVU5xm8wzYyLUnKcR4MgMw5q4iGc2kzB7gz+Rc1uqY4ZlOHf5flzvRmwjUumfNRkB/B
 4PCFPWYWA664sbWYB7tTp9KjSYJzWF1cX699cKcNnRfD7Cj3LXQiWme32XTPMu/2k9od
 cuAKstrqFt6ZNUgzUBxuRI9w6VawynrLJC2I8molQljtxqLLLB7Wa5RPBD5QawHzhMnC
 kTywedVs84bHIQt2pPoDA4+80Oxn3b/wwoSvZlnUCd9Phy6NrayZx6652Pgon3MS0qGr
 BcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780903183; x=1781507983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TszHFZ7K4js/ZAFR2FtK66NQPI9cujME4oGOjetByeg=;
 b=ZTqVKmajyTg6gCtbWn22Y+ZbOnvteG8YVIPhKO1oxdqPEYhgk2sa+VXKX1x8zbsfOi
 6OTFL7guGJ/cmb8fa0tWboqzptfpZtBEyb7Qd+no3epuECbbkV0uAX+qicjBNiLTJUIn
 bkRzJjoWPQZJHlKQzzvsw+PxRXTb3R5/itHqc2qNTK+K2xqwU739cTbLsrQeMR5HW8MF
 KPxvFhUpVv711/0QQYwzFwTsKPawrVu/NPa1fsqreS3f58uEtiApy1hfAvXB3ZpEEodw
 P4gPi90Lv0BdDRmsJNXTuFx8LwptOmVDEWX3vyElafZg0RIn5b0h7P1CXTHUR02adNXl
 1jGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nCv1UhKFy740ZzgFF8d4KcNKTyltYWOlGE0HSRpkRUrtAAmoFbNIeqP1J4vLDwgHyM9BRwgPsnxQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8FXUPU5EhdX+f2BxXfbZbqgKDtJ1e+lYU5jdwbQ/SwqfFqCdZ
 jWYOa9SBC6sj5ofV5pukXO2vjpd0K4jrOe11oVgN4MOGDWM/8mR8PHE1ewMhVYTskhGS5maoGPN
 iQTU2TukteT9NdqtSi0TzA5oWpE2HEjp6vDUTPfaWK7jit5+tnk5UbkalQbOCL8pT1aH2uvI=
X-Gm-Gg: Acq92OEfmdJytPfWcZJVjK3XSGja50is9D18ncwwYVOHIPEipy6ZA8BCzDv0c3MtDVl
 8IPX2Zk6tCn+sqGONB2byHHdLaiDuwXwEGLfnJGEwIjc2QpV7O/85K1W5p4MRTRBPZwsDgokePX
 JtlXKCBFYfS9HaFEKCum80jzCN2aOTqnDyRNMxN2YyeUuIpEBTH0DU/x7iHiTePemKlGVkCaYy2
 H53CWttDLrFx+2YCe/4imOrj2LZVjZ5+wdSSMMA1UQRXdKmlAaDMo4oaDgXbyyuYROocLF0iGVL
 ekjQWCunRsIITwYVdm8/8nl5dROcpNkHB+Bo89L6/TgdF0p+Oe+yLRvLEbYtP61g0hrvK00Nbxf
 LG41+groW+I8t5WpL1t9En4/dJqx0ehwT0/Se/A/N9gnk+6JtSBI97xK+dB9upg+0qBG8h0d3W5
 kswmcEMMs0ZPC1TNqEjuTq2jSxORTrDYKi87+i8UKto0/uTw==
X-Received: by 2002:a05:6102:6204:10b0:6cb:b3db:c31c with SMTP id
 ada2fe7eead31-7001b3c61d6mr2919829137.0.1780903182974; 
 Mon, 08 Jun 2026 00:19:42 -0700 (PDT)
X-Received: by 2002:a05:6102:6204:10b0:6cb:b3db:c31c with SMTP id
 ada2fe7eead31-7001b3c61d6mr2919793137.0.1780903182529; 
 Mon, 08 Jun 2026 00:19:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b8fbcc7sm3605566e87.23.2026.06.08.00.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 00:19:41 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:19:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
Message-ID: <dhtuvm4ejg456jy65kwbejdo2amrg2khaljlmurse4vkjok25p@rd6wd7tp4rwd>
References: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
 <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2NiBTYWx0ZWRfXx/UBMO5VDnop
 fhiH0mhgLrawNUVd+lRryTCJodJtuQjPOi3X0EsI4loR/ee5vmkMP3XQGQ2jI7xNJOyEisBB6M4
 QyU7RKzG62itGWRc9mJTw8EjYCYxBoJJouw/dUQy4kBaA4QAR7AwATDbZBV6WTAWhqzW2qexuJ9
 aI29UrdmA4LGcDk0JkmSGeW1O1Nfq2lOZqyZHTwCyyGYttiMHklnmZRS9/MyFGxQlG98zYbJe19
 jy0614bPphoP9HmYl1DweuJfhQyWbDI0zzNahX7zzHr/pPKB/H5OortfuV1ac9zitJBPqSZi2pE
 qDxNXDTfso/kWgyYzuTCa6qe+jr/45lNfqySZtwR+jItpe+By+Dp5F2JhDar3lIqnRxqyroIyLK
 WHG0aF83K2MuKStv7Q1MnrorE2ZVceboNWEqWtQ0JBEdIS8FOjVRoP6FXDlpitYYnZ1MV75FqUR
 ky+VX4Pv1/H8TD2sZBw==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a266d0f cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=h5pAuauRZTFNeIU57NgA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: Tk6OBTVnUmTMtMhOqBx7TMP0OEO3JT12
X-Proofpoint-GUID: Tk6OBTVnUmTMtMhOqBx7TMP0OEO3JT12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080066
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

On Mon, Jun 08, 2026 at 12:31:42PM +0530, Nabige Aala wrote:
> Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
> the existing qcm2290 bindings to cover Shikra by adding fallback
> compatible chains for MDSS, DPU and DSI controller nodes rather
> than introducing a separate binding file.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dsi-controller-main.yaml     |  4 ++++
>  .../bindings/display/msm/qcom,qcm2290-dpu.yaml        |  6 +++++-
>  .../bindings/display/msm/qcom,qcm2290-mdss.yaml       | 19 ++++++++++++-------
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
