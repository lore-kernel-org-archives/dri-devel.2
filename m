Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07987CD6E60
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 23:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66124112491;
	Wed,  3 Jun 2026 23:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQlAGpWC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="goBRTw3/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32450112491
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 23:11:27 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653Gje7V2262005
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 23:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pbg2lZIT6IEi/rrQPbwo27yLNtC7VorLPG0nWcQWW8E=; b=PQlAGpWCLoN9iNoO
 /tfLoUmkZP92NidY3Epvt1h04Dvf+S+D9/JqS9E+BgigNus5m3iTZRdZQoI9g1X5
 MiIIC6fbQukvuITzn2r774+rb7L0bAxiA5C+0xZIZjrDrLE3KVI/2XIeDjjPu7s3
 CpZ1xetfksToCsKc4BVbm5gOaDxHjaKJeAPDRbIrhvea/seavCzRr/a9KBn8YjAO
 SzfAoM4kyftsO5bKY3C4nkD2QxtEZcLFYvSJQSz38ix+nmJysZimjp0vFyabYdz0
 3CBHYcgCy84ChAu7d9lst28zXiCUEvnHmdoXo0l4FJr3PND+0MdelNMPdIn/T6Us
 YOQHNA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejr2mhdw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 23:11:26 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6c69c788ce7so50608137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780528285; x=1781133085;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pbg2lZIT6IEi/rrQPbwo27yLNtC7VorLPG0nWcQWW8E=;
 b=goBRTw3/RWv5GnRYGNRkTJYSbwrOT6/A94EO6BeIJaDhG79tFyacZEGhNo1QPztPUs
 1vU6KrarmvdX1MYCh3HqixE9fmOrZ/sFyFP8AfvetbfkLwvXjxIZbEv0LKeG6wXWQHSa
 b8FoW6obvWHmvhfJer6kFLDAK5lSMhWjJEel61dXCUKoEx0GFv/2gYIJVRmaoNLarDo3
 gYLfDli8luR5OAdgJ25SE+9IHRPh01FOVbwXqb373qyO7reGUrlPtfCRkWltYGvtNfDq
 kxKlo6oq5yEj2t2qyvtk2va5iknAeDNjfjMRr4LU/izW2WbcLIKw2zkHiQwCxQNsB2K2
 KMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780528285; x=1781133085;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pbg2lZIT6IEi/rrQPbwo27yLNtC7VorLPG0nWcQWW8E=;
 b=R/fBFqRqdzN15Yiqvy1ZsDdqz40q8uh/wM8OKn30wuLvHcIkAoyl+Q+n+yLTc0BJq7
 st3iLKt+iO3ZTzhZXQBo86uDpe9Bel6d/NDpF7+9pw8K6ExPu9FagFiQXq+m1f15V4ML
 KqBc9wJSrBInas3u+/QKkks1FcPAYW4wOTpv37SyPy5jX9KwfK+WK4isXjwwsLfTuDfr
 o95KutbM0Vhh7QN/Mh2w1gqyiGqja/oixIz5neqN1DiuNARmyJQsPjl1TZdWQSn+mj2U
 z5cDBUlk3ETvfFpNiX8UBlAcLSEq/hXoXq7t15/HfSgKri06tLMVBvpicvFLitJMGFH2
 0ePQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LyORTceIJkFSgYoUMIqEcFFIQMOf1tAiasqAy+9/NKogPLW1rfBtBpDyd8Pq4n3rXxHw6ev5kP5o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnqbEE5QW5XqmN7E7cQ0ZbG51mYmo6pmPg1M9HCNbzKqv6IcJJ
 3vfrsPW4zmjz9Pw7xrZtfEdLaB5RhJum0vOKiptd1QdW0WyoNj15fBMwv1FRHKB8abDC4yGC54R
 69FjpAPJVZ4DmuDIhx/um/l94IJ4TN+1HGABTu/TX7/93dGrF0G2ZyHp0wgiaDbisUTqSZ76Epd
 G379QbYQ==
X-Gm-Gg: Acq92OGqFDNek+DuGA8QNikwB3uVtdZLMBe7h4hJM3hTo9/3gDIFltXQiz3WPePw0xt
 edgxr4o3ekMSkrDLqnT3RBpl5qjoAKriaVt0PXdm4kdaR3r9BBOeaHGaMDbwBP/LWSlQgmcgBYg
 V1Oi56FqL6dqMcFTjP2t/IMQK5TKpfgFhhhv6JVb26ErVfDKl+HRygU+JIu83kew8ledkP89D2E
 3nQP+YvPCZY52VObmBz5KmKKhTW3uB0l3vjQvGAPCQ3JjSy0RcoZHEQr5OQO7wRt6urdsTvDh82
 S8kgdK0o1fSzFfzC30XMvShDt0fMSUb9Cu3lY4sDSavowpX9TxhpGNiZLr/WlZPKC2G9x4GFDM/
 VVnqnhBUPeM5Ipo2HdMZMSBpVGckE/x8RT+vNb4vx0dDyFHqTsVLnw7RMH6RghI8GqhZm2Oe18O
 VPq4nejMfjsEmVo/ztGo44FSOBj5x3gv3Pkg0Gh3JXo7hmlw==
X-Received: by 2002:a05:6102:3594:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-6ec490c3d34mr2892886137.24.1780528285608; 
 Wed, 03 Jun 2026 16:11:25 -0700 (PDT)
X-Received: by 2002:a05:6102:3594:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-6ec490c3d34mr2892873137.24.1780528285140; 
 Wed, 03 Jun 2026 16:11:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b97ab61sm888369e87.45.2026.06.03.16.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 16:11:22 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:11:21 +0300
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
Subject: Re: [PATCH 5/5] iommu/arm-smmu: Add qcom,shikra-mdss to Qualcomm
 SMMU client tables
Message-ID: <sfxhpi5tg5x3mm3twxtafwn4v5tkxeyoyackz4g4agjwhlb7yw@752limezj4m4>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
 <20260603-shikra-display-v1-5-aeac1b94faa7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603-shikra-display-v1-5-aeac1b94faa7@oss.qualcomm.com>
X-Proofpoint-GUID: 2XVd192P0cAwqQxAHCERBJY3aWAMxZa0
X-Proofpoint-ORIG-GUID: 2XVd192P0cAwqQxAHCERBJY3aWAMxZa0
X-Authority-Analysis: v=2.4 cv=A91c+aWG c=1 sm=1 tr=0 ts=6a20b49e cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=AKL9z4wCTGGjPT63ffYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfX7ERCgPKHTRgu
 Xx3bkNkjeHZeBjlSHr+A1dCxRBFgaE+XyyhNQROfhDhoFFA7sorNlWg5sN1LHUseiDrstIezshu
 jK0xU3NwfNnsmSRJB49kBrpHzVPKhK8Q3ISAcXCv2Xagvte4sWsaKQZM8q3ng8rYu8lG9wt1hDF
 jB3Npz6Rr5KZcD9Or5omn8yixHpwgrjJjebEuaVUyAZTWC3yHRxYLxqN+RBf/XcTvFVcFDUXnUu
 whmiwNcmJ4gq390GimzH9BLdMEMDI40+iYQkWU3T6KCt99N0HhtBZwij2NgpGYkmZUcavimuasY
 bG8Q5oGYjyhMUT9oCvELzE7UrYwz7aGnEDFRgwpbrhkxfBuFVkBFcL4yM6Difj86MfLpm6BXXBv
 cmizOEiCKvJ5jVFxpEyzJQ6BBiXihaENL/80CRm5WLrNw55dVv46+qMVDniqAlJy1KTw/03lr9e
 lgsx+X7ensoMRC96UTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030226
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

On Wed, Jun 03, 2026 at 08:29:30PM +0530, Nabige Aala wrote:
> Register the Shikra MDSS display subsystem in both the SMMU ACTLR
> client table (for TLB prefetch tuning) and the SMMU client match table.
> 
> Shikra MDSS uses qcom,shikra-mdss as its sole compatible string, so
> explicit entries are required — there is no fallback to qcom,qcm2290-mdss
> to fall back on. The prefetch settings mirror qcm2290-mdss
> (PREFETCH_SHALLOW | CPRE | CMTLB) as Shikra shares the same display
> hardware block.
> 
> No entry is needed in qcom_smmu_impl_of_match: Shikra's apps_smmu
> carries qcom,smmu-500 as a fallback and is covered by the catch-all
> entry there.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

NAK, use qcm2290 as a fallback. You won't need this patch.

-- 
With best wishes
Dmitry
