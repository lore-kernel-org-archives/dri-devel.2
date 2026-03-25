Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB868FEA82D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8200310E7E9;
	Wed, 25 Mar 2026 07:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eTJ7x9sQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Byyr7Abr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6186610E7B7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:47:15 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P4eO7s2807988
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jbmWobzZxEkWqGh44BpBynlL
 LpPaqHanh5XtZddkKA8=; b=eTJ7x9sQFm/PvYzoR84aHo2WzU2a3JA5/VU2PwGp
 dKHXrfYznOlhvX6P77J1TfW8rw233jn8A5RiqJQKn7N0syjZSGosGWrTLQ7Uwedb
 l4MVwo3NNpzAwez1Bd/RnwdrTWIZKv2TFK7uth0w5slkRnSzOfO4XypeJ+WZVNE5
 9Fq8F+yl39ATHEiHngXMfeD6wfMrC+iH5mg4vP0hXPHrMRWi9GRQX2UxgElYVmpF
 JYEbjd7o9gkiqD6zOExvjGmQsvBkBs/tEI3XKj3zY5bRnC3MVPbdUsRqzGtm+JXl
 8tqBZM8nXFMuagOqpbjCjNyAZ0djxs8YEbjkQEtiUcyGYg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3t9eky9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:47:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5090bc4823cso22739511cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 00:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774424833; x=1775029633;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jbmWobzZxEkWqGh44BpBynlLLpPaqHanh5XtZddkKA8=;
 b=Byyr7AbrXBmj36WnoKtnmz0e7tCBbIa63hKQxBv7rBw+5Cxy4agp6SyxWIomcX8WTo
 qRim7XNozOiONHxUsWG+UiJuAk1RRPPU65Upr3xe5YIpp0hWArvDfVLWhGB+hqgESBXp
 eWcklDJHqy7XRMDCM2xOxKve+qLh2xpmXphzaVCIzNDA/0axOB+2X+cZ8SGri6xpjX4z
 Wymdt+t2OsHpO2utjwrZeIa/2sOXB1feTMjCf3EaxyJ1+R+auoCnT8OiJr83uJjo69xo
 JXxtZyFL30zZyVsW3T45lX9Jwc36ph7IUQWSS8G55IH/jZ8lkDneuktBW9CKVQazPnTj
 3vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774424833; x=1775029633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbmWobzZxEkWqGh44BpBynlLLpPaqHanh5XtZddkKA8=;
 b=YW2/mq6x0XQWKvjmNhCXz4SPxArE/x8CEcZ83pemsB9Ru2AaSsJReb3LUTar+bm918
 u8Us0XDNU8cgTymK0pXz/gGZVyHXxPjCtvL1mYk6T6sBQKfgwYGmEnwVreeq7USE+dtq
 BMBjA729wg+WTyNes7wYCh+1X8UYcReV/u8FmiQqAsKQW0Z8HaOZ4DPrqTs/mx7oEPI3
 13z9Wj9oHGONAPlsyVi34vDYEDelt1ufgLndzvYjj33bVMS+eI04KnAwYXD0abe9o/ve
 BrjmwFOo6iMr9NBDBzGO6GjYtlfJrhnPWEqRFfwichcqK/6oX64qGbGhR/oN2XYDg24i
 c0mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWveIvPE63f8HfdEtSyM6/ObAh0C/HjQA+3qwhAYgY4wM4svB0ssTmYDjXO7MZ57BvmIph8PiyWi9I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwllaqnuD+m0zIjx7PJN3IhQA9Hs5P0SH6sfXBdoEfrvT8SwyzU
 pmeehvTKLHpUU+bg+zdHnfm5eU0pvFNR83g4kbkfXRzLO2E7h4O1QbNJnNcoG3jdd1xZlADrg+z
 HNhwLAmucvZssivcgzRPzTsPJm6HOpR56eahS5L30rcdBS7iZGffVQm07v6CdyXVKyC/Yv0qQSu
 nUz7A=
X-Gm-Gg: ATEYQzwguF2XdVbmnKTuqrqiba+/YlAm44rGgfsfuXIilBEkFO3MM4gMbHH3JRpmYUr
 7WMjtLa8r8s6peQzJJwbxcWoxvZ4sfkXENKL3d3kUsD58/3DiL62MY8hHgAG3B34AMFDXqwnDie
 p48OKGObX1cDtv+XsqokTdPFdp0MJSqazUqGSEFDiTYU85ms1LAlxg6YMBcHVPfq5S4nWkpmD30
 Azz6tkQrHmUghq1sTUQJv8+zrDkMSS4XlGB+EXulrabkLeY1NpWjLI6Q2SngCMGjxBz6eFE198f
 NF9NJK8tWz0u7iPNgPhiU5H5BYxFGxJTrZJJg2hdZ24NmkClVm3eeLnSEhmjzL6JBj5hq9DtqV6
 lBcH3EOOy8K/TUQmc0vEHHMCRBkbx9ddbbBqFyp0j+ML+Bksf+1/9QlQbzlVKUWbi9AGEc0hBQM
 G8Q9xCUfki1WwXP5It4UGAL7B70mqE4GUZdF4=
X-Received: by 2002:a05:622a:5b95:b0:509:2448:41a with SMTP id
 d75a77b69052e-50b80de0052mr34310121cf.42.1774424833617; 
 Wed, 25 Mar 2026 00:47:13 -0700 (PDT)
X-Received: by 2002:a05:622a:5b95:b0:509:2448:41a with SMTP id
 d75a77b69052e-50b80de0052mr34309991cf.42.1774424833214; 
 Wed, 25 Mar 2026 00:47:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285206f73sm3623553e87.54.2026.03.25.00.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 00:47:11 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:47:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v19 4/4] drm/msm/dpu: Enable quad-pipe for DSC and
 dual-DSI case
Message-ID: <o43ppkmsdrg4c3tz4zhg2y2mszuryjxxyaowaw7l6ldhzjyzn4@omf7wa5yboy7>
References: <20260312-msm-next-quad-pipe-split-v19-0-4ffa2b06c996@linaro.org>
 <20260312-msm-next-quad-pipe-split-v19-4-4ffa2b06c996@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312-msm-next-quad-pipe-split-v19-4-4ffa2b06c996@linaro.org>
X-Proofpoint-ORIG-GUID: BrlCP8PIBSncUb50OlXs0iyVjE2cBMTN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA1NCBTYWx0ZWRfX0838/T22/H1h
 lcUMqsfvNOXW8SoXHOw6W2ILyg7s+PC1Wbfq15mEN6ngxl1/35SkgrhmpaYPKlDfoK7fIu+320w
 Rq9j9BaoEiIHRxvraVF6oTYJFd1XKr/N0gwvCbjv02rzccMHJfN3meBSgMW7HmyNVwKC9Hf8V3S
 8sZlcQY43oKn3wHMRWXobole/5e8Ey4B+wjmBLmGcZqVEQXwnbqmm4CiA7cirJ73jQGdlZrjKlm
 IynfH9i825nRckcP01RTwt5qF1WDfqelp5t6NgS7lYrLJZZDqcuIyzN+ysV9nORdjItwhTL8PR2
 LOEufbnsIt6N0u/xEskpBHgIOOZp/wn1ZoDhNbDDSBMA2lvD3LnnJOCQYad79BCJMzegXzSFEbQ
 7tIt2rv64H84giTia69VMmCN8KS/F5avYQKzRr5Ks7q/OT04flWt79MXLzlZ2fiD94hXZxSxjIM
 7qWocZJIc/Y3bgFcecg==
X-Authority-Analysis: v=2.4 cv=DdAaa/tW c=1 sm=1 tr=0 ts=69c39302 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=qWzgL6TmHCyCF3KwFOUA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BrlCP8PIBSncUb50OlXs0iyVjE2cBMTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250054
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

On Thu, Mar 12, 2026 at 04:28:13PM +0800, Jun Nie wrote:
> To support high-resolution cases that exceed the width constrain
> or scenarios that surpass the maximum MDP clock rate, additional
> pipes are necessary to enable parallel data processing within
> the width constraints and MDP clock rate.
> 
> Expand pipe array size to 4. Request 4 mixers and 4 DSCs for
> high-resolution cases where dual interfaces are enabled for virtual
> plane case. More use cases can be incorporated later if quad-pipe
> capabilities are required.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> Patchwork: https://patchwork.freedesktop.org/patch/675418/
> Link: https://lore.kernel.org/r/20250918-v6-16-rc2-quad-pipe-upstream-4-v16-10-ff6232e3472f@linaro.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c         | 48 ++++++++++++++++--------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h         |  6 +--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 29 +++++---------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h   |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h      |  2 +-
>  6 files changed, 47 insertions(+), 42 deletions(-)
> 

This patch can no longer be applied due to the conflict. I will try
picking up other three patches from the series.

-- 
With best wishes
Dmitry
