Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F161AF3ED66
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 21:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1301E10E02C;
	Sat, 11 Apr 2026 21:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OwdNXjpd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ht0y2+OD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6108F10E02C
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 21:18:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4UcqM3681136
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 21:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /BnhmHdOVt1XlDe6LmZ91H7GDDfYKRMBNLn8WZ95x1Q=; b=OwdNXjpdfdrQUNKm
 w/8r9jhTu6fAltxnxyfcBuq+FZ4CbybOzNbb3CyUjsJg9UXMm1mKqUZZ+sf5L7yt
 vIbKRJ6y1+NadUHWNT8S8jfQT/cBmt/gwI4/guxxbXdVmhlxrPRVs421RZ2snR73
 pSpH2UKElvZWxTMnvxsGPsqHczLPbgpZSvdAmf6IEZFzCxjNnjSQ1aK2FqPsBKUi
 sD2zLg0ExiQzNdrhltTFf7yBUhK6JjBYiJDFbhZpJMCbu2A4VsqnnaN57/THpyD1
 nG/8joKOya+7WQVcKxpmb0MZnE8KCsuJI+0tgc+yND6fwp+2DIPD7qzyO8D/7lHj
 jnZM+A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dffb0hbqd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 21:18:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35dacc40f92so3274523a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775942337; x=1776547137;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/BnhmHdOVt1XlDe6LmZ91H7GDDfYKRMBNLn8WZ95x1Q=;
 b=ht0y2+ODqWvrmgFIPXOlU5vN0o1NyNJ8gsk1JPBIEPlt+c1Ujn15qU/FmP62VHVNHA
 OMTPlw/80RK8FD4FGW36CqVJIVSoJ5+vQkyAI5bNH1tBtlB5vL6sTOXiKfHEQe8LjC0E
 W0WHtJAJP/9DcDPu5kWRnghgvDjQl20z3hU31ewSXd3/tgqa2uEnvyW7eWLaHU+alrBg
 Pv2GETOSd5hA7XK3WNTvZJH+ZKLqgy3Misgz8HD+vv/xFUxkiEStCGz4vB/gq8/T9k+y
 0gG6M/WGvqhsL6si/HGwiBAqtkdAwpMFUpN+H3YvbDiYYJThIIFu5dL3ZGsfGXHXzDvN
 i4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775942337; x=1776547137;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/BnhmHdOVt1XlDe6LmZ91H7GDDfYKRMBNLn8WZ95x1Q=;
 b=TaalbJGNb40eRPgClRM67Ei21i/eO6yv4wqrT27y2oyMdSsv7f7WEZXSzSD9I4FkQX
 z3eyEjjOHAh2lRYPBT5NxBnrfX5a7RWYCTCrj5gRJBs6SEXpcVsZVjSI3C6vLK1+TUct
 AxpVUWdrWcXKWXIMxb4soDtg0pNZhIxbK+MNfRiNr1KkeYo54fmp+Sw5zEs5VGmdwmiQ
 ZislRWRxv1bsb3U1CusqBLFM+CMTN8JphIJJAxMTQ/55hcygOvmW8olhpop0VhTjs1T4
 Jvx46oB3PwoRhRRimb1d0uNSK/PYtUnkxYXqmHdIbkDPslqQXGoxqFcKyvWLmC1MchYC
 meMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIskO7jqDyjRKzAvgQrPbd3KKOkuhP7i5YESUaOyfCS3DpygQ5aGxuZ+agrLZCRXhEKspWr9CuU8c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVmxbgOSW7u5MTHbzKJdTGNSQnDqZmW5mU+OzzpTUg1zj87tGz
 3CSb/NWUtsJP9PbdPIkWVZCPtXKq+JOTvnVxboujrfBxyN7yZ9hkhXBIWhj0KGUqYX1KGpiBV5y
 Iik54UU2awm5j6yS9yrjK6BZj705PN2TCndp0HtY0oPzfIIMckeOGnrcMjQpEmb+uRn56PJE=
X-Gm-Gg: AeBDievyyKa+0jS/n6O4QsysUUDZ9Ije038RfI57c0X3JKZwC2V0CJAtJwLK17FICpl
 s69llZcoOMZApsU7u06pgFWSirHe40wHIr4FSws0ZdYhhbIncq5EPG4m3pjIqXb3Tlk2iLZ+/Lr
 y41x0PmtcFJf0paYB+RF5+5PP4VhnjA2JBdWZRn6w+Kwi6sEIcUZyoJpx7nAtH4wyO6jzIYfiii
 VmnvyrAK5jtuEHwHkqQlaZ2DQtKhCr0qAmXIpYHCjxgbsCz6ftiNS72xgkPlLd4PVvQ0iEoWB2X
 aO4T+VITPTCoY5auwSfw0Yu+51NegNo5JU7QadJMkHv5sZ3R3nmNZ6vqOA6wZeyi9OzeuAmFSIr
 JsYNe9rOPvW4Ydmyb+KKCRXISiYTlS8TLuImMqvToXgv8
X-Received: by 2002:a05:6a20:9155:b0:398:a76e:4ad4 with SMTP id
 adf61e73a8af0-39fe3d1f6c0mr8379544637.21.1775942337045; 
 Sat, 11 Apr 2026 14:18:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:9155:b0:398:a76e:4ad4 with SMTP id
 adf61e73a8af0-39fe3d1f6c0mr8379521637.21.1775942336586; 
 Sat, 11 Apr 2026 14:18:56 -0700 (PDT)
Received: from [192.168.1.7] ([106.222.228.99])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7921a1ef00sm5719024a12.28.2026.04.11.14.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 14:18:56 -0700 (PDT)
Message-ID: <8c84b6df-ad0a-4d7b-83f7-e87e9b2934a0@oss.qualcomm.com>
Date: Sun, 12 Apr 2026 02:48:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: Restore sysprof_active
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20260411150312.257937-1-robin.clark@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260411150312.257937-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfmNIQRf c=1 sm=1 tr=0 ts=69dabac1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=rTHjoFeudlETzLztVtW01Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=aK1OVFfb90g1xg_bP4wA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE5MiBTYWx0ZWRfX5LYB3DiuT50t
 bP+v1dT66ojPEnsPsX0oD5WKKV39EvI4NE1TF5+shwRky5/cc9nyY392iMEIZChXAbj37hrtBUo
 Zyqcv/sT75oMuHtLYePIlyiNriyWunfyNfVhu5Fz4varlXjn+AFrbrSAXtxLVi1TGVbSoWsYcTy
 hVum0yUJ3uCgdogeTQhqx5W3mpx3LKK/qsU6AG/umLyoLdIHrMJC3H5odPoigiX3Vxk4k6VHR5Z
 IPgeSLq2KAoSpxBrFZFQgI58XgujUlL9bfRapu8utpdhktY7RmaYD6Xm8aWUlJpxVFPgtRd0GA4
 CcgIZDrb50CmTRw+JauD5wudo2wMDR4AOyKPxvyHLzcEQiz3rQ0ROXmBhWTsoax59tXfsFxJ9f2
 hRDHe9GC3gcFHo4hSnvNjQdcP9z0EfFdvfl4VOOSviGPXCPAvxLGOnSse0SwnvxDSZOINce9Kq8
 rQHumYJ2tvEX47O8phQ==
X-Proofpoint-ORIG-GUID: gH9WXP07V9tlQD_-u-I7oLC728Jt0lnp
X-Proofpoint-GUID: gH9WXP07V9tlQD_-u-I7oLC728Jt0lnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_06,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110192
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

On 4/11/2026 8:33 PM, Rob Clark wrote:
> This got lost in the shuffle somehow when moving the vfunc table to
> catalogue.  Fixes inhibiting IFPC when userspace is collecting perfcntr
> data.
> 
> Fixes: 491fadb2b818 ("drm/msm/adreno: Move adreno_gpu_func to catalogue")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Looks like this got messed up during a merge conflict resolution. :(

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil.

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 85607706779b..14b4f4921991 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2751,6 +2751,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
>  		.create_private_vm = a6xx_create_private_vm,
>  		.get_rptr = a6xx_get_rptr,
>  		.progress = a6xx_progress,
> +		.sysprof_setup = a6xx_gmu_sysprof_setup,
>  	},
>  	.init = a6xx_gpu_init,
>  	.get_timestamp = a6xx_gmu_get_timestamp,
> @@ -2819,6 +2820,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
>  		.create_private_vm = a6xx_create_private_vm,
>  		.get_rptr = a6xx_get_rptr,
>  		.progress = a6xx_progress,
> +		.sysprof_setup = a6xx_gmu_sysprof_setup,
>  	},
>  	.init = a6xx_gpu_init,
>  	.get_timestamp = a6xx_gmu_get_timestamp,

