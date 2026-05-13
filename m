Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0E7CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 05:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B7810E5BE;
	Wed, 13 May 2026 05:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K2TgNgQI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M1sgUN1v";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBD910E5CE
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 05:39:42 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64D4p9Ae2331407
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 05:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=z1eg0rADF+MRr4TC+Z0EGVjM
 pmf50WH81VVlXV7fjUw=; b=K2TgNgQICan5Q9VR1dlUpy635ll0XMMLKJuu2qNZ
 SgO2whdYqcs9j1BdZpxkn03E2pTD+sFFoECzAMOvSm/sgkkBunePCiFo44XFGyLR
 5S0Iex0Bngn7HpDQNRUW/WgSapps6NoAjoSfF8OREesKzOy2VIBBTSDzcG5ZW0ht
 bi1IXVwZZZP4b6sw7IuQjitv/wsP8EMg/R5Q9WRgO4hHuKC+A0PlWusefaeu4pNR
 wrtJ7ohDH7jrHQRP7EjUFmUAhyi6nL2EgMN7qkwrfNHwmGs31l+rtS7bosUDaKZT
 exj8CdK/2TMAK99hqzK4K5JoWhRnHQmhXErvMG/DYGBv9w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43ypbgw9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 05:39:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51009190feeso125131301cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 22:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778650781; x=1779255581;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z1eg0rADF+MRr4TC+Z0EGVjMpmf50WH81VVlXV7fjUw=;
 b=M1sgUN1vLtITqHGjd4hWQZ1J4H/kAIQw2DvVp38pKS/S8z4KzXfUQuNLz6xNwLVpvA
 Je+uGhw8KWOnPejhT2FN2f9FdoqczR7kp4rPNRzlIUO31BmhTO2MyWIlCAaO2bHA5kvn
 RS1IBpLyjCc+AN0MYb0FeYB99CnBDCqaYvPvFlytDmFnRMJm3VitbqJdn8fjEKDpu9+J
 b5BKYFmlEznhBDKwxu9CsBgquO/etbLf+5JAcGUtrYeVbow7Uj0pZ7FZrJnODbh8Rn7V
 +KXE2+ac/u58a95PSepuoat4449XnDMHZexktsi+Mjup+Epla823WsEOTGsdFHr0VjIS
 SHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778650781; x=1779255581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z1eg0rADF+MRr4TC+Z0EGVjMpmf50WH81VVlXV7fjUw=;
 b=dXwODDQ+xXjNk4Nrod/64fcxfS+NfaH+p4Ur/NgA1jkIs5i81uUBCjlg3gYwBZN24c
 bXg4diriNTSg63I7YTwK9MWqoK6fFhb176afuDVqbmiwnTNdILUR+bUMqHc7c4jhp5s5
 BgT76Kar48sL6dkMaUuO0iLXZh6pfvGpgKzXsnK4gKTmJ/PCwNGOqYsOTejQ1sbRvL4n
 sn/zIM9uMNZAfXlGlp0zS7JZyOCTsxND4JS1q15UDOuHG4edXtdgjpfZfcgW/dqsRP9b
 WStzPcl29efKvG/8d0PQj7qNKBY9Ep4rO0v98eaNKjnjJXFcBlgBhifQHFgvFvPINVKP
 ggvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4PFweZdPaX40S5AXugXvnGI328baNiodQFnF6lzg546fn7fU5nMCJ38zXSwOpkxE1rrZY3KQ2egE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsHsJYUSQ6NeM8DGofqUTlinyIbHHifFMZTLQEev3fDn4J84WS
 2Drac9coevsuo9OMLCy+IfaJnisqXlF+c0VDEptkQUf6SjpT63iq/6yjAg46z8Uzq71wGS4adqh
 n08pWVdId6jXmuWU1LGDLBWTvhQU1Ms5JIXV4lVHekeTYunaBHyb6d9QSWkjBZ8crYlHipuc=
X-Gm-Gg: Acq92OE1H9mtJhLkd1PQY9qZyz3wfq2gPuea2JeLb6wI/8qBRJUg8r/9tZ/2Gabe1S0
 04Nti3UQbZ6AneKtoA3SgAtysYts/d7rQ3tIjEwvad9hWS/D7CftXbsFkWI8wZVYnqyS0JMqbeZ
 6HKWnieBNjcPRWTIV8sNROogiUnTQ5Blv7gFkg76SCoG7+NkGbkzqiq9Nzk19LC6VB2FJEnF00J
 XLsKPOh3vSd8Xe1CxR71qtW+YO8LM6RR7l1r0Db001N5jx9mIaFz2Jf59jl2CoPD56lgbYyVQOX
 G3ewLCGbn28UZigbgiZhGC0AoYV2m1VC9X4r+Rw5VG4Axupfki9v675pNZxyHgZ+HDJejvaMqDV
 VxsyNZAjHoPRUMV2INNVkrWGBTfEzaN6dfWdqzmepRH0aUKN4tbWVYJbnFvMKQ/vQ3E89DKnMtB
 X6nGOuzZV2XTGhsmS7wGRA3PgWev+VT9K05VE=
X-Received: by 2002:a05:622a:1f8f:b0:50d:62d1:c3fa with SMTP id
 d75a77b69052e-5162f422543mr24814031cf.2.1778650780766; 
 Tue, 12 May 2026 22:39:40 -0700 (PDT)
X-Received: by 2002:a05:622a:1f8f:b0:50d:62d1:c3fa with SMTP id
 d75a77b69052e-5162f422543mr24813811cf.2.1778650780289; 
 Tue, 12 May 2026 22:39:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a955e3dasm3772290e87.42.2026.05.12.22.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 22:39:37 -0700 (PDT)
Date: Wed, 13 May 2026 08:39:36 +0300
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
Subject: Re: [PATCH RFT 3/5] drm/msm/adreno: Fix invalid drvdata typecast in
 adreno_remove()
Message-ID: <fazwegi2tylfxwhndtjyhlrqldhcm47ydszci6qghgxeul7ffh@d5wgtrlx2ymo>
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
 <20260513-gmu-sync-state-fix-v1-3-6e33e6aa9b4f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-gmu-sync-state-fix-v1-3-6e33e6aa9b4f@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: H24j8-KE-e-q5fEiJZqSDwMZziMYd48U
X-Authority-Analysis: v=2.4 cv=R5kz39RX c=1 sm=1 tr=0 ts=6a040e9d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=xr6eH78PXR7NwqaAx1IA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA1NCBTYWx0ZWRfXyKtw6c4zF201
 Vi4A138+97XViEZJWkrKK0VGu4ThRYbR3Q2ZwcM9+9YXA4lKRAR3iwLOYEh4TO64zjSgpNzqEP7
 p7sVYqg9oFMMIiiPpc0g5EYR2oJ8FttFD+psiUQJ10H/iUiks7RNRMLXp9pPBk3a9v8BU5z/e7f
 PC/9o8klvVAuhZGb4A8J0AQ3nUUw2qSOG41ZqGJJAzBjXg0qHgyOggtH06OSpupTq+Ygpp6i0WW
 g3Wg/TJSqKKpC2zqtJTBseWc4hMcFAWZH8esAtXoHemX3BRf9WhXNIhrL8W1RN4/LZG0YMUy2is
 Ntny4/jda0X6W6uTYBa7JMGOPlXkAcjUMcuVCbPJTCZPeD/Tn/zM5tLYdaok77rla9Cwx9SLuoq
 RY0QGag+pQ6UF+wE5GeZ2fw6RMHvvSITpqe1UnJuM/S7UL8a6R+Ck141ZzwaObHNawMplpzZufT
 tq+jxl6Dmk61d5vMPuw==
X-Proofpoint-GUID: H24j8-KE-e-q5fEiJZqSDwMZziMYd48U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130054
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

On Wed, May 13, 2026 at 02:22:58AM +0530, Akhil P Oommen wrote:
> adreno_remove() decides between component_del() and msm_gpu_remove()
> based on platform_get_drvdata(pdev), interpreted as a struct
> msm_drm_private *. That dereference is wrong because msm_gpu_init()
> overwrites the GPU pdev's drvdata with adreno_smmu_priv pointer.
> 
> Fix this by using msm_gpu_use_separate_drm_dev() instead of relying on
> drvdata.
> 
> Fixes: 643515a9cd09 ("drm/msm: rework binding of Imageon GPUs")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
