Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BDBCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 11:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B98089153;
	Wed, 13 May 2026 11:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WuThW60V";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FllSs8M7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D668985A
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:46:52 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAX5C2978130
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8DwTPFs9voIwT/jOGMPeySdY
 1JU5Emdb4FIX0GL4csw=; b=WuThW60VGt6t3oeUr0jBXXq8b1+Og1QOUgdfluiA
 4MV56mTSZW3tIuZwfMXIybyR2h2z4Taxabg2Eq2U62fv1Zq2BLfIZ0uxvpPDhEnF
 eE8xkgbPE+hpxXAfJWgAiSiy5NVarIxW4wSbx7linN4SjMXMAATaVSh6Q3s0ZETM
 21Dl1QdRqTfDyLWm1IVyJE5wgWxHI+8eRh51eRwvlWozSgzk28xpkQqhc2vsTSmz
 uMcZ/RggrDTLXyMF4Yx1Wq7pcuCKXyZ37LZlTMwwK3p5I72QtNxqqdgR231R16P6
 nYhJ0sFmlcWhSO+eUrpz1rrmYt4u6ido6vCuRHJ+rcnPwQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e46s9v328-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:46:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-514d2b22e7fso42191851cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778672811; x=1779277611;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8DwTPFs9voIwT/jOGMPeySdY1JU5Emdb4FIX0GL4csw=;
 b=FllSs8M7sxG5q4rhpIJljjXCp9sIzJQsp0smCczx5BSvyX0KqATepHI92IUAa7V0WF
 hmMk6nfmGo5wIllrrMijOQ26KKPr+Otd7rxxmOssVXo4YC1Et6VtSdWZCfhw6TGf9OEm
 w8FftqRc8xLXgL0Dfeyi3FETUb0nWj2uzTdMS6bFSNsHClc72jW7/KyqGsYLFPLakLMg
 q4lXwWuZBOwRIP+8wiDgLOp0WEFS/e5lyc4N+FbnjXEFYTFTbGWLrt9NtCDy4awsDiD1
 Pdl3OjQDdQeA5wuu3nSewd1jIqh7mI9SrfdvSB04/9fzMfmBG7ri3EJCmyum6cNfBJoE
 Pc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778672811; x=1779277611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DwTPFs9voIwT/jOGMPeySdY1JU5Emdb4FIX0GL4csw=;
 b=DMD3ZbPvlFYzaJhfZ9arxcAsejcLmxNtvrg7fe/b5NsfgLfv5ms9IebT6iPHEZbXbm
 4uzPGTp+R9v04oOqs8jN08qeYBzKeDVNCIudiSSYskYhJjNdjKVx7EaclGLd/kVrhiNf
 fw8bsJeF6EcX03PwI17qDajAzIg7CGRBbNyz34eIr5Lb2DM3GIPFYTnFMoq9XIMP1EpT
 4pB+CS6lITyeHOlRWO3opPrHM66GYKY29/NmYqHeHSIcev2HtvhN3r9ps+Gyes9Ynz2D
 yzaxmJ2JhMTd4qnFy6SE4DyxoIBrB49NSzPtDAtlEQorwxSZ9nAZK/Re4NHJLi4SzRU/
 7yEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NAxb2cJdaDQClu7Fv/RdE9P4YYrpjGmwy5+qB6dxllNlPgyGTeLM2XuWGwn2QyoX1JLNY4JUR9wk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPmNuLtQWdZWsm8DWdgjDDyk1LotYpdn/GyanwQ+2FdrgT+0Gz
 4MzO2LNaFVqqGHyVYb3CY/3mlji1OnadhDY1Db4KjmJ3/MnpOFm9TS0n0JG/dpQtLHrcXwoytPd
 guTPj+6J2AqQ5ahG+GgGQZV50Wx8Olo0tooUkoYz15KlLnYGNQbu5U0LtZ4ZIUFmiylQXqM0=
X-Gm-Gg: Acq92OFS62kVo8cYN7+Kh0EpyF0jpHK6Z2NodY9tpqFQ/pSmjnHpRHPdEKjMQmgxoYw
 8wo9mbRhg594tpOCiIqoU9kBM3SZeYHJVnX/WFT/Jvw5mRELtgE2bhjjySkwYTk3E1l5pzzkmmF
 t+lmsS7sKDCSxnxB2es8KbXf30HmSAi/fF8wqZCFQUjq/PGwjnnrhnB5GMunyMpRxiM4gonZbvr
 LGREC6hlJ/XAXbLND/ILC+bb1iQhQLAkyX+MVPYpiU97CHLXusB49VfSmFAmaE56BmextnQLdKi
 1QUFxwEA9cQ51TtwNxQXz8BbMp7Rv6aR6jn4MNPDyNRp2PTRwznz4H2ICkxeUvrTAnbMgJrZUVP
 fYRVdSNghQLVCaFhaboX3BK+YCQ+xsAGkrCemRTv5ewApjguCWHxgEzsOMYQKgJBRNGJOrmxuTc
 dp4+3v9p9iEO1SjNumLpqEaChsYkyLlKZNiPI=
X-Received: by 2002:ac8:7fc1:0:b0:50e:5acc:e795 with SMTP id
 d75a77b69052e-5162f44054emr37928091cf.9.1778672811229; 
 Wed, 13 May 2026 04:46:51 -0700 (PDT)
X-Received: by 2002:ac8:7fc1:0:b0:50e:5acc:e795 with SMTP id
 d75a77b69052e-5162f44054emr37927541cf.9.1778672810669; 
 Wed, 13 May 2026 04:46:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f62693f8sm40592541fa.38.2026.05.13.04.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 04:46:49 -0700 (PDT)
Date: Wed, 13 May 2026 14:46:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT 5/5] drm/msm: Attach a driver to the GMU
Message-ID: <a2xdoumdiwoau6f5hsjiuueiemisbj5cpunyodnj2gcfyvjocz@zajjyoxkm2to>
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
 <20260513-gmu-sync-state-fix-v1-5-6e33e6aa9b4f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-gmu-sync-state-fix-v1-5-6e33e6aa9b4f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEyMyBTYWx0ZWRfX9Eu2OQhhKjLR
 I0v6i7lyyNv+Ns/vOrb1sdCy/uwFGFtJzxE51Zk0jjAJS2jF5VFtd9vDIx/eWUchsMLIsjPoCBF
 doSQIiTdhep6ROeTlG7E44eatTJ4NxX/RNkLslLaNH5S3ml2IE7ZOVzwo8R9uQjmy+xDTDGUSS4
 QGX1Ebem4UR+puXxYZAnGoQ2FvgDKfZpwgjI5nVYeSqh69+EgRsHtVMmsNF2CCBbfsov9KTzHzB
 5oyTGf7O0yIt4rEZrSshcr9Od8ELBLGv0SsWY3+Bi1JCejXwYFIWkHerpgrfE7izp9Soply3QsS
 7CFt5hezYro/mYAO/Nuzb4OKbusjziMW9Dc8Sts1GvMVvBrTqh5sXfQS3K6Y+hwbBhuRv0QRoVU
 zHBZMSskifUDvuDpRFnbG9r7l0YHv+hA/tKE9xirExxFKPO0M/AMQZg2xUV31afYMCX8DOCVRGb
 kXex8kB9jAO0PQQmkWg==
X-Proofpoint-GUID: N5cG6S86K5n1175b91TFUIlX88z8MPKK
X-Authority-Analysis: v=2.4 cv=L68theT8 c=1 sm=1 tr=0 ts=6a0464ab cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=jYtgZKLYjWWl_Wr8lb0A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: N5cG6S86K5n1175b91TFUIlX88z8MPKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130123
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

On Wed, May 13, 2026 at 02:23:00AM +0530, Akhil P Oommen wrote:
> With the introduction of sync_state in the genpd framework, any consumer
> device of GCC and GPUCC which is not bound to a driver will result in
> bootup warnings like below:
> 
> [   24.362666] gcc-kaanapali 100000.clock-controller: sync_state() pending due to 3d37000.gmu
> [   24.371210] gxclkctl-kaanapali 3d64000.clock-controller: sync_state() pending due to 3d37000.gmu
> [   24.380268] gpucc-kaanapali 3d90000.clock-controller: sync_state() pending due to 3d37000.gmu
> 
> To silence these warnings and also to have a proper state in driver core,
> attach a driver to the GMU and set it up as a component device for the drm
> master device.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 70 ++++++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 30 +++++--------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |  3 --
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  3 +-
>  drivers/gpu/drm/msm/msm_drv.c              | 17 ++++----
>  6 files changed, 92 insertions(+), 33 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
