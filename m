Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A641CD6E60
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 23:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC74112496;
	Wed,  3 Jun 2026 23:12:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AKO0kRCc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c9iqiruI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D1A112496
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 23:12:47 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653Hw54Q3234783
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 23:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=m/Ok5eZP2WT5DjxR3Pgcz9Pv
 ezqkWw2q1gsOHrEJ7Lw=; b=AKO0kRCc4FDL0Exl+w9EmkRmbCgOCv8JV7dF5sf4
 Xzk6TaJzPOo2cmh6tnW6DzwFGBFmYwhKOZ1i2RbCBHE3PmpCueZa2uBNjAdt1M/M
 uUsP17oebLptspUQmUra8ebiwLAr3hLP0ixLkCk8WQD7c0t9DZ5Q66KduzYXG04/
 zSLCshI8fbZVbNFTjuXbBN32KGDnDMGk5D6NZkwJ+tE+pkasYogjvtHeRNQmzJMv
 SXJi0xul8oDXT5Lvdu2Sm3mmo3oWZXWoSZW1XkYefTtY4OFWNMoj109gmU9SHehb
 uhdY+JZpifSrRvdm+leYkLjqNHWy8La89tMIaZLGmyRbZg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs4s13dv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 23:12:46 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6e907a982f5so1717734137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 16:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780528366; x=1781133166;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m/Ok5eZP2WT5DjxR3Pgcz9PvezqkWw2q1gsOHrEJ7Lw=;
 b=c9iqiruIo4Z8fWY1+LOCXLRd5/Nq5wK98+5iHxyhUt7vzF7ohT+WmqSp80DJJV2D1s
 D+uziJIgpYnLQz0X5DXvaLgPkQcf3kg18THCdaBF/4w+uoHsLlDTSC9VEDT4bZk1hyga
 qCdHfCGHl7w0SID9wCjfvy/Ttc9mhwPRqlTTUvnBxrDtNu8OjMyl3ff2MrkXLM2EqNoX
 G0qAdQnGQ2OKDJyP24B9kt4HAPl6bpbxpnSPYUuG578kLMLHYVctn3Lrsmk9GhfULpAa
 67SegM1nu22+XfqPaq2VUDvpuNLZ0xgH4R7nIdNAU5dWv5D5ghqnqBtPa1UIe5KJ/fEa
 qZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780528366; x=1781133166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/Ok5eZP2WT5DjxR3Pgcz9PvezqkWw2q1gsOHrEJ7Lw=;
 b=jO+XACyERk9p/EpVH2KsFIdwnqBZMI3iul6pFimgCcNWAKJJRFaSWyE65O+sM/mW8B
 k/p3tdUl9ZkVQwR9euSV0eE9twaFvmlRatzURK4W7OMDJnO8Ain/edHyKmxp97WjktsE
 vvmX6/9uD9H37mfHchK/WQ26m8+QsWTjnwumpXyNF534BLjgJPUN5LA80AnPzosXBtbK
 Ye+aNM7jmjX13GInkjR40/lE3Yj8Q75RvWvEfHZuzcvUKJ8961TVzW0UiADcPbHbu3EN
 d/LUPdTKgJbAC7jRgaL3UREaGC/D5qaybwiOI+B2jrz5Nb8U5yApK43oIKutBamIh2wn
 XbQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hI+G6oqwdUX6760TJkTaDtuLVwe83oKArE/YRpBopnsGEui83CrFZGkGH+QuMFASyGT9Jjjh9GUY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/WTiypS4ParIiM62eXaY29H3p67tscZQH/tmGY1MLnlXJc899
 SY2tmXKuASIa/it+Dxg3KojAh/aEKeW+knpuVIvvOc93dTMe2dt59S5tWd+kV+QRaOEnlDb6iNp
 HTfixAjhvGDgsfvgvTHz8Cp83FyO66lK7EHPCFoHOiNJJtdB6xJ+nPf/uNNn2qu+IMfZOH3E=
X-Gm-Gg: Acq92OHPyk/mzW4OsaHBI5Jn6y2vCbxZlMNU8/93fcICWBBzhgXc+ggjdSLIm6j7rdK
 T1Sp3AdtPNQQFKEKfFSKuepVunuGDnck+91lE4gyIasSPhylvm7TQi56vj1CrO/QS7K2YjQTf/X
 h6MDRbgtJNmxv8aPOR2q1ar+AOR9Tynt0XQfhjErF5OAikv3BcLS5Sf/6AcemPffTZbd/GK1xfD
 tvJ6uRyjXU9SHlU33ZlHFd/nnlBshexLLUtyYYM08YJ7HPRpRqHMqkHmkjrFN8rmuK0W46Jp7ye
 nJBUmRNFK72nQph4v8oPFGFmfBTwL29MBlIk3PdCNfMqo6lHV3/B+GrRUltUNZLB+4+y+u9Co5z
 F/qA/fvht5hUQCnlHVeIslKKDhHeohuMG2WanF5ymWekZ8Bz4eRj+S/BNJQ9pWfbVRDyyx/7jmX
 7q1hQd+lOV5QuX3cu6v+GRCdiJiRourQ1/yOn+zsJULyw+cg==
X-Received: by 2002:a67:fd88:0:b0:6c8:c356:16c9 with SMTP id
 ada2fe7eead31-6f552a06f87mr522636137.20.1780528366041; 
 Wed, 03 Jun 2026 16:12:46 -0700 (PDT)
X-Received: by 2002:a67:fd88:0:b0:6c8:c356:16c9 with SMTP id
 ada2fe7eead31-6f552a06f87mr522622137.20.1780528365620; 
 Wed, 03 Jun 2026 16:12:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b90421dsm870868e87.30.2026.06.03.16.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 16:12:44 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:12:41 +0300
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
Subject: Re: [PATCH 4/5] soc: qcom: ubwc: Add Shikra UBWC config
Message-ID: <2idag2lmgvmsqjixrjr4y32jfaa673h7jrei6pjjn7gm7ybppj@n5zycvdpmw24>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
 <20260603-shikra-display-v1-4-aeac1b94faa7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-shikra-display-v1-4-aeac1b94faa7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: nsFe_ClFoEE0qrZDzCrZchr-nObKFLLG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfX2j3q9PA8uocX
 ubCf8Fk/vC1qDnBONIwjhnIY97WoJMIw5B4GSMBj4GrgURiNEnBdiJj1iciDAUuEwHkjrZ2u0hc
 lDrxU4Aho/HtbLgokglP71pgctTUNedA8pCuVkOQ7CDCJWvHQsLOSSvb/9UQRby2NafBf8QL5+B
 MQuK5NEa1NU2DLjLNtH5eNMk0F82wQWwOJCNZa5xReG3i7lQ11ilzJfffE+uphATBQ9T3PAywyk
 3ssr/2OiKhhF2Uqs6799y2Aob0PSkvaXn/5RrnBqW0z0QWUJwAOHYzq/CMS6rmADJOnA1dgveen
 xrreMbfJCN35LUjLFI8MnYe+7wynRA7QPBJkmqNcWaXtYVujsFI5Thk51CWvaXJkPxsN7mPtIYL
 8seubGvMCEn6gEA+KBWsdHabMSTcSFeSioa3YT/oj1XA1WuzXM62W6Lj7XCwuzR9aIDXxcMreok
 /7Ay47jMoQJ7iPCq4gg==
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a20b4ee cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Y4AeZ4K9FrMMlEv3RhwA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: nsFe_ClFoEE0qrZDzCrZchr-nObKFLLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
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

On Wed, Jun 03, 2026 at 08:29:29PM +0530, Nabige Aala wrote:
> Add UBWC configuration for the Shikra platform. Shikra has no UBWC
> support and no highest_bank_bit setting, so use no_ubwc_data.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/ubwc_config.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
> index 3fe47d8f0f63..01dca97e2671 100644
> --- a/drivers/soc/qcom/ubwc_config.c
> +++ b/drivers/soc/qcom/ubwc_config.c
> @@ -278,6 +278,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
>  	{ .compatible = "qcom,sdm660", .data = &msm8937_data },
>  	{ .compatible = "qcom,sdm670", .data = &sdm670_data, },
>  	{ .compatible = "qcom,sdm845", .data = &sdm845_data, },
> +	{ .compatible = "qcom,shikra", .data = &no_ubwc_data, },

qcm2290_data

>  	{ .compatible = "qcom,sm4250", .data = &sm6115_data, },
>  	{ .compatible = "qcom,sm6115", .data = &sm6115_data, },
>  	{ .compatible = "qcom,sm6125", .data = &sm6125_data, },
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
