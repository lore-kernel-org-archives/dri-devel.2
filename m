Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9B0FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C4E10E35D;
	Tue, 28 Apr 2026 16:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dZycoP5E";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GwIA5fK3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8342310EB78
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 16:40:09 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsIFa3713150
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 16:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jSwLJ8qoJ4k0g3ywERijbSEuPMU7O1XadiH6FINTJ3o=; b=dZycoP5EZv6A2AA0
 VQ8Adz/TjFW+tgpAWctWG0d+1Su/2mqSOk9NmtaMfCd7slusLFt04ZOkYqGRs3qc
 nEpucIDhrx2mJHnNjfK9kF8Yr5+0TmPeDY2ucB/jj5qraMieBg1xYUQWy3lSpY7Y
 Xe+wgUKYnF5oHnHmXD6nvfvBsJcV1zmN9w9zwEGc/T7BZ1kY2FXDNTt1/hpLdMJj
 oRoIDgzKAC7U+GLLFCaXkoPE0B35gGjjxb/ilAP6gL018njd9IMurlJBQveEHM2z
 5nPAfwZPUgZt9g5lEpEe10B38Qq8+9ivNEib58ZpfUAZ+2nDOzfegRBWwz54U4Bl
 YqCTBA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtxb50p6w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 16:40:08 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82fa2165c3eso7365521b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777394408; x=1777999208;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jSwLJ8qoJ4k0g3ywERijbSEuPMU7O1XadiH6FINTJ3o=;
 b=GwIA5fK39hNryPllSMHqAPtWvrq+Lv+WRw9K5LfE3/WAIgqNsP7CAoX1L+7uLu9knQ
 ThX/NeJ7ZmqxZ9QulbzbMt3nt+CYrMmsfwiDrSlO2nG8I/2n98UxBHW4jekjZMVZogy9
 VlMJATYsevKBeBG3gBPzaGBXHWiqU0zRP0fXhaOkq+iIF509wUoe554eKS7o9jV7F0Ni
 RvYRqiGaPT6YEKSXxcQ35Cay8Pj+8EM1iyXLbCTHUDP/ujn6M7oG/hqXbCvfk7pykxuK
 Y/erGzx28IuSJVmt0Fj2Y5AWvLn01WrJPTMujf6pI+cV48NG7Z5qQ45sMYYMr6CI+e5O
 wkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777394408; x=1777999208;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jSwLJ8qoJ4k0g3ywERijbSEuPMU7O1XadiH6FINTJ3o=;
 b=Cw11RWW05Rermpyn60bAqrXr/kZKogdPTQeAzG9qg+0ReTQed+JnOcKEqwWeUmcOTV
 5OuNnKfx2sJ5lN5HUPHFl4pnEq6Y17/rqEi9Nvd3TzP2VVvjgi21iW27/CVmcZkkdpKA
 iuR3JkO7+k/1Y0JUL2AhPeXhaZ1ENovjtmNnOczwmeps0nASxArbMGAEucMPjrWhnMgY
 kXRVWfCnRrex4RgFmtaq94LYyFKWqM6VG8JiQjax4BOCgB1x3QWqFDmnxUrt7lAzW/vf
 Vgt6wdTXQUEPwuUPDlDMMSoOlWp0qKdRUEp7FV7U/W5H2f3UK6DuvVGGCf4cVN7jL2IR
 EkGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ToQTBl1z8QMkuSPVZFVb72VDk6MFrFgNkRS+/3d4jH2RlQ1d4XACFj/JRdhicft2iDyYhfeCPtYc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxr4ERFgUvHJ7cnro7ODeHMfiIE8AzC0TGPGwYSMqoKqSYvlZ8x
 3jQq8uFkEwu351cwgR1U3z1CcMbmG7/NmB7LBqbkKZ8DgMPUqD+EBgkDFt/e5vl2z0p59cAXAYl
 YkoOESzIfrZ15Ed7JmI7OQI8hSEKH3K+k75dcX9rRGzgpXTTh5hbPS77dPEr9mfEhL2jzf6Q=
X-Gm-Gg: AeBDiestLQoqFwjbzbADTl4v+QoUlw+NYUprl4dcELH+czRrvOzyRe/dbjWTHw+PCmM
 ONh0f5Fh8oql8wuzsZhVYny5HZ9zsKhdgjeofbk8Iwu8TweOOZ8x6Pgv5L4e+kCkhpvC7VD2IFJ
 moJHynBdaEve9Wk1fH313MvkCGX5kNeF6qlthEslRTGwckQPp2waVetmuqEBcJ2XjyBR87pEY7X
 LeCBhdaBAaAAKWraHMp62xV4Ol7bM3F9XXp0S2Vws5R9JZbOv3cSEvtrfxA5ExY+MV3RIwtAFEO
 Dj8Jo0CTZZI6hDL4/BrAqKfbv9E6/XiSyod+rsGENjP6ndkzMXHNWFnWGHJJxDupyl8FoqfLybD
 BcYOJa2lEcUjm1WPmgj2PK7m9XwxvL2WuLA6I9KDmEUirPiLh7XsKFw==
X-Received: by 2002:a05:6a00:12c1:b0:82c:eb46:acb9 with SMTP id
 d2e1a72fcca58-834ddbec5d7mr3739930b3a.24.1777394408087; 
 Tue, 28 Apr 2026 09:40:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:12c1:b0:82c:eb46:acb9 with SMTP id
 d2e1a72fcca58-834ddbec5d7mr3739883b3a.24.1777394407479; 
 Tue, 28 Apr 2026 09:40:07 -0700 (PDT)
Received: from [10.91.112.28] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834dae00e40sm4009175b3a.12.2026.04.28.09.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 09:40:07 -0700 (PDT)
Message-ID: <59bd0773-5c12-44d1-99b3-9ddfac8b1a4a@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 22:09:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Don't use UTS_RELEASE directly
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260428144553.1103785-2-u.kleine-koenig@baylibre.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428144553.1103785-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE2MCBTYWx0ZWRfX5sDeZCwrKavy
 tRaOUNiLe81YbrVZibNbUqIS4JaqXIWAM8RAfR23xRff+Ikd7v9jyhni0zVXYERhB0A3lg+Jd+f
 IEdgo9S0fM1FaE1TFyTZs/jUNZ4KrUOF98Fe1ItUQB3OX9vSJ49zme7l/qU3RD0ysYZ6eLoJuja
 wZoULsPWsx2MW0gf2DuRpw5Rym+C88kJpvac5ZcBGBD1eW0IYx4j7krQGN69gsw99VfT460kDfB
 rgTvL9C10DMCl9d9ObeGK6zU+EOv8+idioaWxWCiFp2oICJjZwJcq1cSvQW4dPtJC2JSNk6vdjL
 ZPz0ljnqp+rb9OEbQZI26EgUJj5LwCDUyOxoh9TUNYubhwpzYlsSzB8A1J/yJUtLwc3YpBFgjPl
 /iES8XUySRfZkxdyoGqedoWdBdSjw7qwplYbvN8cUcx7BixICDfT5LOE1IbZylqpYf7STeJ+cZg
 1tn0oJUg80MmwBx3coQ==
X-Proofpoint-ORIG-GUID: OiuPqJLIjEKA4stEFMIiIRrRkPV3wGNt
X-Proofpoint-GUID: OiuPqJLIjEKA4stEFMIiIRrRkPV3wGNt
X-Authority-Analysis: v=2.4 cv=A45c+aWG c=1 sm=1 tr=0 ts=69f0e2e8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=7nqr_66b8YCbs3nQVBwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280160
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

On 4/28/2026 8:15 PM, Uwe Kleine-König (The Capable Hub) wrote:
> UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> uncommitted changes in the source tree or new commits). So when checking
> if a patch introduces changes to the resulting binary each usage of
> UTS_RELEASE is source of annoyance.
> 
> Instead of using UTS_RELEASE directly use init_utsname()->release which
> evaluates to the same string but with that a change of UTS_RELEASE
> doesn't affect msm_disp_snapshot_util.o or msm_gpu.o.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil.

> ---
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 4 ++--
>  drivers/gpu/drm/msm/msm_gpu.c                     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> index 427d3ee2b833..c6eda3cf2e62 100644
> --- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> +++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> @@ -5,7 +5,7 @@
>  
>  #define pr_fmt(fmt)	"[drm:%s:%d] " fmt, __func__, __LINE__
>  
> -#include <generated/utsrelease.h>
> +#include <linux/utsname.h>
>  
>  #include "msm_disp_snapshot.h"
>  
> @@ -79,7 +79,7 @@ void msm_disp_state_print(struct msm_disp_state *state, struct drm_printer *p)
>  	}
>  
>  	drm_printf(p, "---\n");
> -	drm_printf(p, "kernel: " UTS_RELEASE "\n");
> +	drm_printf(p, "kernel: %s\n", init_utsname()->release);
>  	drm_printf(p, "module: " KBUILD_MODNAME "\n");
>  	drm_printf(p, "dpu devcoredump\n");
>  	drm_printf(p, "time: %ptSp\n", &state->time);
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 930e54d1b0a7..3f3925b11eea 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -13,11 +13,11 @@
>  #include "msm_gpu_trace.h"
>  //#include "adreno/adreno_gpu.h"
>  
> -#include <generated/utsrelease.h>
>  #include <linux/string_helpers.h>
>  #include <linux/devcoredump.h>
>  #include <linux/sched/task.h>
>  #include <linux/sched/mm.h>
> +#include <linux/utsname.h>
>  
>  /*
>   * Power Management:
> @@ -196,7 +196,7 @@ static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
>  	p = drm_coredump_printer(&iter);
>  
>  	drm_printf(&p, "---\n");
> -	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
> +	drm_printf(&p, "kernel: %s\n", init_utsname()->release);
>  	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>  	drm_printf(&p, "time: %ptSp\n", &state->time);
>  	if (state->comm)
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

