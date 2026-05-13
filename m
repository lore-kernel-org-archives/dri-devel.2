Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D74CD343F
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 00:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FBB10E093;
	Wed, 13 May 2026 00:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I0Ze3l0w";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="epWxB/Qq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B5A10E093
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 00:56:28 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64D091Xn1727131
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 00:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mzNLFy7qn99ru8thZNqnPLo+
 PSOhBVDWPxQDFQ9+vKU=; b=I0Ze3l0wSevWWO/1g+bC0dDKuh4CtIkeYpHbBK+0
 TJLb61Wamee5UZnh4ea4QNnP1HJfFD/4qVLLDEPPfhKHsEKjJFiRjLP887UCYu9l
 5xkpy1JhFSXOOegG0G7B6FUGHAidHoZzX1twipl732y3LgPCsltRBfu3aKAaHTfC
 iYVzlwKKkmGeu7TO2MPk0g6C152aPUI4RMM3BY3DDsZ+ZeKF+sVbxLAsG1SQbQzv
 THCmsnrYswlHVZt71bvmekPLPsYFqclBxSXPvEUBh1NlJ5kit1P8S/vQXSBgBYho
 1NJNH5ScYVpCIBriSwfGjel9moyJAFjgVgN9ypx7I/s4NQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vx90uj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 00:56:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-514b673c8f1so25134211cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 17:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778633787; x=1779238587;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mzNLFy7qn99ru8thZNqnPLo+PSOhBVDWPxQDFQ9+vKU=;
 b=epWxB/Qq+6Yu97mgSasFg571GEr+tmGL43+5PwdJPlf0bQ/cDuZ3i4OcYlVjsw2UgV
 tG9VLf0PZZfOZyh2QEx3qOFb8CoSv/10nTpQxSKY/74WOxLbWibjnWRSkYVlqVPNVSnZ
 dJsgTS/ls7AFOZT2RsjqKq/FjvxVzZFjlZL03egG0fhh5p/5VddMwmcgs8+oUbUQXxjs
 z+gpREPFhns/ReedO4xy51/Z+trRZzwDKyae4e4YoS6Id9UDp7DyzTwYt1Vu0XrqqKWW
 /Nb8JOQSY7TCWPeuArVP4+U58hIJGZCYZ3US12CN5i6B/V8tLGfBLHgdgAW314GHJZMR
 4aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778633787; x=1779238587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzNLFy7qn99ru8thZNqnPLo+PSOhBVDWPxQDFQ9+vKU=;
 b=Nws2iHET5txVX4ZLIAAIK3quwswVqdHx6f1kaeEfi//3z+t5OFuEyBMm6blhQ4RQlY
 h/MCmyuNAPPnT6ewcK1A2g0aWyZFm3I63jeBDSyZUESfdEeHjXJKhLjfgFEupED1i67E
 J5U5hZvHIJVvAo9fDo3QTjT5dl/l53RdTu6ShhEet3CH6mMynIddTXarj67EnHyb4BhO
 rYNFV1MhXkPp1o89WU2e+azNcULXf1VPJftDQtkQCskUnPQcG2XUdpOTM7GI/KFdQoum
 wji8QtKv5zgx538iuSONGPcNmeQfXobi6UKr3Penfj8XH9NKbcGkMKSGftrE0Tpdbtx2
 TU6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oGxHkeRwgb9p5NGzJL42UGDB9wnl5BBJzUjmRDSydorMkx+cFrkpucCdvq1A6ZYZe1hdTMfk79eQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXkcHFLG1qdP5aD+Z6GJtUTfSlcV5ZiW9BR4VaUVnAsUBdX6ki
 NpvpLCmPo/sM8ELB9ZlwPl24uKRRiCy5qE0o1NCndNEJbYzwivsuuWR9x8ZhSRO68VajbaUv1uZ
 LysfLQNHsZ2RnM57a5v7+PIySyucXBtX4WLIH8AFLMqkC2mSs2Aczz66c0jhzrC6Xh2FX8OI=
X-Gm-Gg: Acq92OEqWaSbUz3r8Stfl7/ekW8rvXyLSLFRHpBh13D/uDfTpUE0p98xiyTreNjpTOe
 GgwwO4iboxlbk3ZQh1HkbOgc0tDHwpCasm0hPs5ZRM52jV1AYd4XrejohWuTkC8MudGs/147kK5
 G4YwD3jpu8K17A19HpK0/RciTjhoQip/fs8QOH0CBM/sWa2RT5Kf2gOvi6k3cXlaemTJJoqDOn6
 MwQXfMbKeF0v3zNHbF+3/JanfZko5y5qW4Fd2SS3vO2HmiJHK6qKdkORGonfU0VjGl1l1f8fUi1
 fUQv4MgEMM0eg3FoCSQ01Id6KsZ1FC3rljdF1iZDlpMNAYqOpjRTEtd+rKs2klccC9YZmXSfxqP
 jC06bFrLLiHaWdXobY3VImJU8AXu2SKB9SHlfJKhe4t3b6Kk3TNpXsCHiq0WkiXNP+b+GI/Tost
 MePSrJfWJtgpbIVIdcBMwctWiRb/dz/JFyrFo=
X-Received: by 2002:a05:622a:148e:b0:50f:c245:85fd with SMTP id
 d75a77b69052e-5162f58fd61mr15613781cf.31.1778633787207; 
 Tue, 12 May 2026 17:56:27 -0700 (PDT)
X-Received: by 2002:a05:622a:148e:b0:50f:c245:85fd with SMTP id
 d75a77b69052e-5162f58fd61mr15613551cf.31.1778633786784; 
 Tue, 12 May 2026 17:56:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f60db673sm36801131fa.23.2026.05.12.17.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:56:25 -0700 (PDT)
Date: Wed, 13 May 2026 03:56:22 +0300
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
Subject: Re: [PATCH RFT 1/5] drm/msm/adreno/a6xx: Mark cxpd device_link as
 stateless
Message-ID: <7s5lewbwd2lukd7o6djvc77vo2xdt6fbsthrjptlmgfqvwfm3q@t5zjnqcz4uar>
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
 <20260513-gmu-sync-state-fix-v1-1-6e33e6aa9b4f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-gmu-sync-state-fix-v1-1-6e33e6aa9b4f@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: wyB2KQRzyFk0ZlFloXgD2HqjEgqtadyC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDAwNSBTYWx0ZWRfX5XtpZsAsVWZE
 PPQO8IBVm1jCCHVw9Xlo/VZO55Qgj7PH9asp0hpUGskJmmekgfG0XLRdt5HaXbTuJ5kxFu6zUcd
 QryBaVCGGhUbF4R7zmklX2NXtirlfOd/FTUlGev3rZuLhqix3aYE3Rj3Y6+8wmbvESHSJ5UBnTb
 MsYYp6sUNVRBIkqBXpFBIxK7OXUkBI8qKnf//KOXNDvq7EsrNybN1Xp4ilqyquMGAhYAf5ETfeU
 rlODD8VKwLIMnnZlsrS9ngKq0YhuIX8IgU6gH3DFsSexd63QCGJU6nreuDu8PViWFyOAiJgoqAW
 6ihNluXqP9umFenBY9mbfdtF4Mp2GqNI+rs047uUeEhZqanG0wUTkm/AmLBP9ik3LwEWUgqZVER
 Tze0H1BQQI3OjEtG1ps7ukoAXg5a0w6zdXI/YLQZZsRYC7o4YyVhnPOmJHCESPniKwOGslssfsR
 wcRFLLSg1AwjBErzYUQ==
X-Proofpoint-GUID: wyB2KQRzyFk0ZlFloXgD2HqjEgqtadyC
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a03cc3b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=PZmcn8Ua7GWYR-nH1kIA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130005
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

On Wed, May 13, 2026 at 02:22:56AM +0530, Akhil P Oommen wrote:
> Since the cxpd virtual device is a driverless device, it has no real
> struct device_driver bound it the way a normal platform device does. So,
> the managed lifecycle doesn't map cleanly onto it. Since the lifecycle of
> this device_link is managed by the msm driver, pass DL_FLAG_STATELESS
> together with the existing DL_FLAG_PM_RUNTIME flag.
> 
> This fix is required to avoid the below splat when a driver is attached to
> the GMU:
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
