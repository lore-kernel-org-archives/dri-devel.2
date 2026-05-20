Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B8FCD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 17:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22FC210E0C9;
	Wed, 20 May 2026 17:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y+/3D0lw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nkw4oKuQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A16610E0C9
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 17:41:03 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDXb8I1797936
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 17:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=LkDwhjRfxWJPLR8+hbCIDbOf
 AQBV6HIAU4DHZ3gBD8k=; b=Y+/3D0lwa10eWIev1kQU0iZiOL+cZlfcwvbeJtqO
 f5IEOeMiJ8UGDO69hJxdjnNTQTWWibJleV07IvsnDHEENehSC/elCmOSoIbh+mVZ
 oQU6WHLQYx5SHbY/WQtCA9PrCNisFWiqGfShGZTHWVikPFevzmGCuGUz5gOGsYvL
 2rDjnCQfpAOyE5VnQsc/pu4WlyuzbJPbcidBaVcWAAkyx4Au+QChOOfvN1Ezmttr
 zJx+3OVYNHaUf6Oaa29uURXQ47F1nTy+raQ/RHDfLAcsRcfE9g2OU/Ct6k2KbcRT
 feQ8rGa1hqu8HCapAjydQwkpHhAGDsH6VGGuilfSEZF/sw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu1390-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 17:41:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so11783151cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779298861; x=1779903661;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LkDwhjRfxWJPLR8+hbCIDbOfAQBV6HIAU4DHZ3gBD8k=;
 b=Nkw4oKuQBkd9IgPebTtskbd0aol3MxWjIeLv3kAPmMzkqhLLD9lVcucw0Ev7+FUjTw
 bM8UcRBzpRTXrWU0udcvvX9upIkWYV0GHxwUDIFGFGZvZXZ4FodkYch7nLLRXEcYh7m6
 wjTlRM0lH5Dx/z6xFOcgDOQf3dM2pOIJpsMIrb1qODq3u6ZdLNKcAStLe/4H9MAOO0DT
 aM/layo/EotuTyDbxOKNIWi10PVE7zEKJHd+Zd0RvnUnqX6SN40/HfgJhzoX0J5C9abi
 RiNIgHIMplY68balH/lNRGQShzvcwZDNRDWbEBKR9JzudchMlaTsxLy4o0o6uvF6GZJh
 z8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779298861; x=1779903661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkDwhjRfxWJPLR8+hbCIDbOfAQBV6HIAU4DHZ3gBD8k=;
 b=QyrM8hd3mVCEpdiYa5k7buO6ZRU5I7u1Ki/oO2DUxibxu0MiMAczcT4Bn/Vh1lmN4F
 XDssfu1mgxed5SjkxFZlhq1+rpFesOufaCi47orKvOTghEQz9zcm/i+b37SaZjCUaKmK
 yBaTdjAPQAPdYW17wnH92IE/hImJL6FbF7CV0l9TosbfXuoOn0trhR8U465GSaI+nm+U
 yCW4JtVUyjwR01g5TtI80IetJGSmQhd27zVlfgPmAecg7xdgF4als+hUx2gKZ9OucUO4
 wqPE4Tdq9VqhmY3MyqFIWkD1X9OnB0Akme86OsvDlo1/DTk92OKvBzGYA9YOGSpQpMpP
 WQIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Hs7atMlNmo8TS4MSd8ynaOPOj8vQmxlAq2S5M0C/lfXItYzfx6pgPVAFJxXhrd7OQYn7bEcwOLt4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvGSZsyYlyfRcYRg9+T43LYZRlNu+DTyaQsgWTTKuRWaOJoQC2
 Zx2rTjW3SO3bwyfKO0eNREl9J93QIZyKzInZO9/EfPRyw6y9W5TY0cNtE9Y9nNuzBNKiMVWgPZI
 lftPkD0r8vv6Xj29bSNXq3s0tqv/qsc/3o06u1c3fZOTzW/vrHY/XmgJ2WgT0Fxiymf8jGik=
X-Gm-Gg: Acq92OGjJYUVe1zglOyiYYphuq40eVVx9U6UYZp1GwnGHeiKqAZ3Kw2i/ZJlycc4PKB
 FRXsxadC5i0xlw6sX54Wl0FfvlLs3TC+YAIVftdP0TTj4QAboqyVlMJFdWezcmAeYcew4fVj1Nf
 XunJbacMZnTWh5xEwgLxTvX47Al8OskF/h53aEYr3KEgduyziKnclHFKw/SVxsV1yruMB2gBBwp
 vyZnIVXPTL72PfPKfxRUoU15Q3f+n0evd2EJNIghdsKPIvR+Hg3R6NRhIUfR8FgIe2PB9xFYCxy
 d1DqPS5sPyxQA2EIfbx3hfKz2FmucxzpakLEljcoDX+2eNlWqJ6uVX5W/A0u6azX8eEOxeSz0z+
 mvYakszVlR+FK7irNzZ9OzKPtK1U2grIPYn6RJprND9L+wTpad/LnfMKDJn28DUhzgX85T1uU3+
 xC7Xz0Rp875vSuEeWBWyZbHnQGiURB7u0DW4Q=
X-Received: by 2002:a05:622a:2606:b0:50d:e1c8:5ed with SMTP id
 d75a77b69052e-5165a23c962mr336465811cf.52.1779298861467; 
 Wed, 20 May 2026 10:41:01 -0700 (PDT)
X-Received: by 2002:a05:622a:2606:b0:50d:e1c8:5ed with SMTP id
 d75a77b69052e-5165a23c962mr336465221cf.52.1779298860965; 
 Wed, 20 May 2026 10:41:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc3fcsm5152568e87.48.2026.05.20.10.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:40:59 -0700 (PDT)
Date: Wed, 20 May 2026 20:40:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jun Nie <jun.nie@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI
 case
Message-ID: <a2gwkgdnbwp2wfunhmdhm5mwqolzm6fgb4ex6khkzy2jh356tp@dcauzez4445x>
References: <20260415-msm-next-quad-pipe-split-v20-1-bc1fdf140b81@linaro.org>
 <177928444226.2567181.13284983255649878415.b4-ty@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177928444226.2567181.13284983255649878415.b4-ty@b4>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3MSBTYWx0ZWRfX944X9fCgYzwW
 co/+1d7fpkueyDqdr3pT7mqW35NM9oN4AF/V9TooOgtWi9sq/6zu72rFMe0gBP0K6I185NzbJoi
 XHTMr5kUvKMrX0Y/RK7BX1rP7hlOf2IFs9q6FuMb5lMkJ2INxg5noxs+69lflE1YmTATbk5W6F4
 lTj1UxgiKP9s6dWsRrr/3Aa9lnu3U36qwf/B+y0VhPENGAqvTCP6qZd+oHAKTJ8sNqn1kQ8nRmR
 48vQnGcuDX+nST5b8j+a8o3PXU7shWLPWnApFr9Z9otH8lWa3tCCyRHwc+rWj32IxQqo2VGbKEx
 tkqsvmbFgNKxe18TIM2Ef4O6dSd77bpYSNnJ5e0ctFtN5egbwucuRqytJcWFyeew9bTmdunW9se
 CUSQLNIYydCjxsrbN6gDUggyI47U60ASv8QSCh+XuKqAPxhQutzU0sqv+YokCntzURKyi/hGCis
 3S+rjKqSLJBI+A9Bj6w==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0df22e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=3dF5T0QglEsbpJvugt0A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: u-rE4MyTQ_9ztILNwaaU_mqThsFnNqMp
X-Proofpoint-ORIG-GUID: u-rE4MyTQ_9ztILNwaaU_mqThsFnNqMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200171
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

On Wed, May 20, 2026 at 04:41:29PM +0300, Dmitry Baryshkov wrote:
> On Wed, 15 Apr 2026 11:15:11 +0800, Jun Nie wrote:
> > To support high-resolution cases that exceed the width constrain
> > or scenarios that surpass the maximum MDP clock rate, additional
> > pipes are necessary to enable parallel data processing within
> > the width constraints and MDP clock rate.
> > 
> > Expand pipe array size to 4. Request 4 mixers and 4 DSCs for
> > high-resolution cases where dual interfaces are enabled for virtual
> > plane case. More use cases can be incorporated later if quad-pipe
> > capabilities are required.
> > 
> > [...]
> 
> Applied to msm-next, thanks!
> 
> [1/1] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI case
>       https://gitlab.freedesktop.org/lumag/msm/-/commit/218eb06a72bf

And I'm going to drop it again.

I tested on the SDM845, it tried enabling QUAD_PIPE for the follwing
mode, which then broke the display.

        mode: "3840x2160": 30 297000 3840 4016 4104 4400 2160 2168 2178 2250 0x40 0x5

-- 
With best wishes
Dmitry
