Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7804AF3ED6B
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE3710E26F;
	Sun, 12 Apr 2026 00:17:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UyTQ8j0h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VVGBjMJ9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 531E910E26B
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:17:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BMQrxe3428492
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WXjCqbuN9pqs5WEJmNSYlwbp
 Q0RPyvt53och6jW+MFk=; b=UyTQ8j0hiM7Sjpao7kOU6JU+rka09dgk/Fc9zQQ2
 D0iYsjhX5EkxyZRxLrJnYDS7lmxZvak7kMMa9yfY/0YK6hYGGnw5euVZOUI9zCD7
 rRk0NZOZi3l6i/BK71e9u1u8ZpF9ppXA29NEnl+Wx4eODspwTRHxPrLVgMKOzqn0
 WOQDh3avPBGBllJA4ViZHjlyk0+X1jLwYKrfWlwbYT4HG6uAVoFpMtlWbQIWGhq2
 x9jQBc/7X/sGePi/AYd7dVqDjza4B2IRUOwfLxFu6158JaUT+wHvPllq3T1tGUZT
 NQT5p1XTazPqy+huu8GqCiXcVNhxtHcmEXKfJJ3711IdOg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff0jshp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:17:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d8e4c29caso81841411cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775953026; x=1776557826;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WXjCqbuN9pqs5WEJmNSYlwbpQ0RPyvt53och6jW+MFk=;
 b=VVGBjMJ9BBRcDXsu9oPCcvVhYEmjQMnXJYMw+xw1Qbr6Av8q/Evw8+yBMSM1q28TAH
 CrXXaI0bRdQcGNobLHj/nZxCqu/utIQzQ0aBKWz0dCdL0yJCwLKFgOqRm4V8preo89T3
 JPT8oEhTsEIGCCJHQpOQiGzOoysv8j2dt+rfxUCrIZlFHA0djHosjE19A7tcCiTZYF7k
 7YsW0OUn79kmJSQ5JXiF8HmFX7WMyTpwthpoXsliUTZdm4WgKmU7WNPjmYdEZDNfm6Cs
 xy8h9K+Q0Q1MRUPOzm8nfGMJAZWaYEu99djfZUv8fZoVrvtxAmCo7mzpl7lV/0cW943Q
 7aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775953026; x=1776557826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXjCqbuN9pqs5WEJmNSYlwbpQ0RPyvt53och6jW+MFk=;
 b=LoCoVOGsFDQhs0b6XZ1sqVgJfKLKwOu8QzHwHd8t9bSSP+DHp+y51N6N6r30D6+IYV
 BPRNJDydDLweQEAIsb3y1sZIQqXdSg/DwprKsvfDUDksG6AYgaIHT3pIzONHGN4I7Duz
 GG1w8y2WQE2ZINkZmwqyunJxrJDmtYvG6UQqZpASN0x+IEZOVcWV+p3PuDOID0IsJ6G/
 OWVstYeIh3QIEZE6lNh9JbhDBBqTFDzCga+re4NnJZ0UvCi5fWu5q9HKNhdBTfx0jzwj
 Wk1GIA35Mwym4nIkW1LvoqR793xC5ZVDz6dZMl/cemMVct5lZx9idrO1umYa6iL+2PKO
 Z16w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt1OlLentKLIC84BsV+HH1yG/E40EjUVb5B/+Oy2RZIlNbhQyTuNUSIhE/tVRYK4FlthQG4TS4afM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHTRaz0hWTj6axYZndDrjk4VH0AJQqQbeObwLBAu3Ub8KiAqDg
 HmaZLSg4pKMFmX9TPgJ57PS8sVGakaWcPmJeKeP1PQk3WYdkUj/UYpltou1A+zJuE81RQv4BP6F
 7GPhhBoy1kj7W/2ZkBSPXTkIZnmyglV7SHcTiHhRZSZMti7HXJH64vJH4o9ArUXgT4AqVWMA=
X-Gm-Gg: AeBDieuNi/MmfQEUCVNv1AZSAHVFAhNWUrw/QI/ZvQ5SMhl/2S/7q+1EmfmXOv5hl5Z
 XcQ+AFLMwwu+wzCebXkmPHLsfhRhXmAVehWEmF88bi/0Ur9B9gxlwGDs4zlaXi2XNOxoIVUY2Aq
 mVI8xJIDleEm+OmSNX+41mgs/vfagH5dpoSBrXnLoU3XvAqS8LuiHsOgQmzc0qxR8Ko4IX7xfFw
 HO4C1w7FEqBGH7z3g06jBTwrSHffBMPFgT/muvyoQ2Rgyc9vcGcm31j5FcBkavUBfoWsCSpm62g
 x2AbWM2FkIlPd88RZCMPjJRdRkM7ciogL+a0pasQKutkvDrRBO7ezHYb6vXfvCh6gZt9SueU9P6
 jCmNoYk2buzCIOTArm+1k/Ll97oNDOVZFbzaJGv3oAwyiYXRsRea/gfj1YqDxt3nJHtVwP5WuqY
 FdSOTHdvuo55dFoPyOLmqk1A1V6fZDhK1fUA4=
X-Received: by 2002:ac8:588a:0:b0:50d:9c1f:bbe3 with SMTP id
 d75a77b69052e-50dd5b673f6mr123412981cf.16.1775953025719; 
 Sat, 11 Apr 2026 17:17:05 -0700 (PDT)
X-Received: by 2002:ac8:588a:0:b0:50d:9c1f:bbe3 with SMTP id
 d75a77b69052e-50dd5b673f6mr123412621cf.16.1775953025299; 
 Sat, 11 Apr 2026 17:17:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e4957eb1esm14855951fa.35.2026.04.11.17.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 17:17:02 -0700 (PDT)
Date: Sun, 12 Apr 2026 03:17:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 30/39] drm/msm/dp: add dp_display_get_panel() to
 initialize DP panel
Message-ID: <ukfrn22w6y5z77c4cirreyotzvuhmt554ebz2cfgtqav4yqbqj@e6rquwbabdtz>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-30-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-30-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDAwMCBTYWx0ZWRfXykursnLGVZiS
 5e26ksoYtUBS4olFzT5ag5eXAEwuNcUbENjM3G9MvtsI95c0Z8nGynJNXvKBqNll6nw5FnEMY0a
 61eVJNy/Fb48lQaCcvvMZuf/y/nh+faYOk647+i5giy+xYfM9SwWI93dPGpbM1sGa4s8W9E2KY0
 3ttO5Ri32Swdft+OxaMID26sRzO24jIy4hhiU2b+2nFcPMnAfDtbXDdYcsRvWGczHKPXOY5ECSy
 WFUr+Z29SHb1FVz3CVYaVIrzeBctTQD35MD9m/1/G5TzPsHltKnV4Oxdvl93xDLDK0N5DydWl+n
 rHgX+wzeZM0owH6yRwqcV7OvWcCbV5e5cScZhrdWiLEK4ZfC/+NDG3bCQv25EBn08UdPZbB9cys
 Ue5TUjV9jeoeZfpA3NrhErbew9vlytoeapHeh24k3JXEf7mHTC0V8PHzbfXqQkdHqV71Yyehry3
 JP4P2+VHjFw0xKb9ttA==
X-Proofpoint-ORIG-GUID: F6be3NRJd4UBqhBmsUlVzEVLkt20bmje
X-Proofpoint-GUID: F6be3NRJd4UBqhBmsUlVzEVLkt20bmje
X-Authority-Analysis: v=2.4 cv=d/LFDxjE c=1 sm=1 tr=0 ts=69dae482 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=lPuuIjzOXlNeMCy1gH4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120000
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

On Fri, Apr 10, 2026 at 05:34:05PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add an API dp_display_get_panel() to initialize and return a DP

The commit message wasn't updated.

> panel to be used by DP MST module. Since some of the fields of
> DP panel are private, dp_display module needs to initialize these
> parts and return the panel back.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  2 files changed, 25 insertions(+)
> 

-- 
With best wishes
Dmitry
