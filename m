Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4B606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QjNyagW2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jQQtzgLS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356DC10E998;
	Thu,  5 Nov 2026 21:39:12 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 423BE10E976
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:39:01 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L6F8H2972349
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 21:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jv1bi07Ci6Wf/YaWMkjal9ROI5Op0rlvb15GSZqGEvQ=; b=QjNyagW2t0YDVsPm
 xuG3mHlKojV9a3jZJ7AqT1B4IgCLZaHpmVhePqzQX3p4UDxjaecymVJCzXene17t
 /XhFUvPvbXanmFDF7hNjJCtitsMz+5ViTFar/DXZRPmox0QlMSsfvZLg7/5aE5bG
 qrME+9vQSqQnnYMF7L7f3EKVUIoEI+cFKIWapqUuNT3ydJPohK0NUMJnAVK95juV
 wbnsVLv5mu3w8HKdJB2mUTey2Sq4sbZN8YLvn0z/VaCeKCYtx07/qexhsgsM8P8i
 R8fWxvKPpW88skcJ1vYpezasRc8qs4vJdz3DDymuiG1P64l02QPvyqRiJPl26948
 qSEydQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrraatu5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 21:39:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso2772750eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 13:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793914740; x=1794519540;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jv1bi07Ci6Wf/YaWMkjal9ROI5Op0rlvb15GSZqGEvQ=;
 b=jQQtzgLS4N2kBpN7AZrzvnxmeSkinnOv0EltBFOhFglmBwDp2nTbkg/y0g1STeSJ0X
 YlPeOrsdspREyivECpGQ1HkwdEo6QZUDPC+gEggXyiGadVJG637gnyIB444uQnrhvhDF
 y9bQ1O5xlXushtouG1guztnCVUEZdli+Szj8GqBTeUjMohfXjQagLLKePKocfR7UnEbY
 B5l/J2UzOQpFzp/J1+q4TXuV5czPnu2LF3nh00Q9k7hKrfMVsorkqI/BSiBu3mVpaH22
 vsjyARg7kk0yzBweGvRnbOjgzYGYR0bo9gHkH6C4RbSz1t+Zv4gAgZT6xXY35EfwGwmn
 /oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793914740; x=1794519540;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jv1bi07Ci6Wf/YaWMkjal9ROI5Op0rlvb15GSZqGEvQ=;
 b=mHZ52lHKWBWg4I0KjGuBQIS07DTebfhmChuV8KGwPZLI+SHlZ7RQbPf5oPBfhCvQRH
 VY2GLVUPorHazQmCrLQUS2Zi+qRTnj4JPIh/t0Nv7RFzEGSbKuTL7rcl3Ksnm9LjBjE5
 fIZp0T899Tl2lIu/+9StHJbHcG02rI7Vd7kVwUAykGVOFF4lo/n9MGO/59t+MLSAOxfi
 8V4/iFWYg3vmgRe0UgpsxPjsuF+JDAJQ5zAyCzWy9mhOhDx2d8cYj4OLGacD2SMBae6W
 xM7GWcBlZ6XVc4FeKhI4s+FRuQirsVwBvXeRuggpBfwfxZT/NNX49xkhqKQsl46eY3O7
 rulA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDyRVuCGHvOysUlJFZFnGjyVAK/77xVI3G2BJj//BCPQ3PwjMzxj3J4nH+5i/TudCS2Le5x3DjlZ8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9s2S/X37723uNGiy6arPdcAUUAjvWmJGZALiZtmrRcGUoGPekz
 JCvQcOmM+V8ic3BywQLdvQ38NlhqiKkrtFFVzsmId86JVZXhXKZ3peJA5YGJBtrzu/Osq8Xe3kU
 sDRaB7O5HGPe/UND14BVfMd7VvaCKt7n8Zf1zq633ai6cZgsPCjkYkoY5yf2xqZVLaD1Xy0o=
X-Gm-Gg: AYBFou18/PZinI9tHq7jpzbrFdelGBhMJSdmQ53WkIojebpDYhQVwVhMOg36Syt3xOL
 KvSZVtT0rh5OvNdtvyb2+0FTWjNflH8z3k65mW1OM1QS/W5vu9eKNGnb+4I3bGkTfbBO+M0TYDM
 RKzPox7lVJah6maFZRiQz/mZDWUx7j61WdZZzm0tPM55MqIPL2i+HDKMDRKBqId8LAw/WvTm7IG
 86VvT1v/uPxFW790XHo36XIAm/oWLRPkdk8o0qmO2d+enATgEELnARSfzDPxXRjj5rVC7fPcXFI
 u39rN6PojJl5cVBikEcLFpKdBEIJ6PauTR9gFsBqVoyKA0ug8Z7OQU01FmwvrYudxepYQcYQ9tD
 Ofls4xOPmmKFYZz0cek9HU7/tBliZfZn0j7lkcwemjaV6fP3LM2jvdkwWG9mkbpC8lIOX54w=
X-Received: by 2002:a05:7301:fd06:b0:36e:16d6:f45 with SMTP id
 5a478bee46e88-36f758318dcmr535694eec.23.1793914739857; 
 Thu, 05 Nov 2026 13:38:59 -0800 (PST)
X-Received: by 2002:a05:7301:fd06:b0:36e:16d6:f45 with SMTP id
 5a478bee46e88-36f758318dcmr535655eec.23.1793914739304; 
 Thu, 05 Nov 2026 13:38:59 -0800 (PST)
Received: from [192.168.1.9] ([106.222.231.155])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f72dc30ebsm1033032eec.13.2026.11.05.13.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 13:38:58 -0800 (PST)
Message-ID: <9d91e39c-e29d-4e1f-804c-779a3aea21ff@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 03:08:52 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/15] drm/msm/a8xx: Export slice helper
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
 <20261105203057.66520-5-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261105203057.66520-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NiBTYWx0ZWRfXzFp0C6WsHf9P
 LEZPxBH2jZdjb0V9BE39lnrZiI+EuYzzNbsHM5JWQiuBsMj3He/Vddb5u+R9qLXHQOm0nG9JMun
 zDikma/nMSHYKgtYoLx6EjxXJ/pgsyg=
X-Proofpoint-ORIG-GUID: pI6D1B5qu3NoTKP0jf6ThLXA2xBkM6pp
X-Authority-Analysis: v=2.4 cv=U54Hnuru c=1 sm=1 tr=0 ts=6aecf774 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Hj0ah+TxS5FywmoD0uLh0Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=QynUOb8fajV056UlVlEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NiBTYWx0ZWRfXzipkNuwlOr2S
 cCNtFptOGeobxfNM1cmj2I5TLNVmVtVvIcRlKFFxayfVIjV5OPg0ltKqlFRYsPhsp7UmFaRAiqk
 PWz38zB66Jkcf4cs3BUpanxV5Azxr1lHHkbq1huNINhPCiS5v1gnFryZvZ9Hptzsq1BzLDzeIzA
 AW/ph36Pgk3HTQqAHcWVx3qNLXCU5LG/n7FdJW1fKkGDUENbRS/x0+PFCwUO7q/JCDkSUzhzDzo
 qJKevF6HgP/p8z2xLr294QzdkLLJHhvwuaCa9QRI1C33HNhRWpChFP8pZRTw+lX0uWWO7tXxD6i
 Yt92Y9Gygb5TcIgtQkI39PEjH6pRbCCGm78m8cMGWGgdcfpfvBIbtPWbXjzPcMbTTzWT090xjik
 3MzMu8ci6opkxracPnV8MsNCoHFdvWVke0kmX90C0ZzybcgIGexdn8KTbGNuCpadq0zafQMPNd8
 kLW01EzLj8JZlf/eapQ==
X-Proofpoint-GUID: pI6D1B5qu3NoTKP0jf6ThLXA2xBkM6pp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050086
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/2026 1:59 AM, Rob Clark wrote:
> Something we'll need from the gpu snapshot code.
> 
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 1 +
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index e6ec85b20fb7..4a3898e58aee 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -357,6 +357,7 @@ u64 a8xx_gmu_get_timestamp(struct msm_gpu *gpu);
>  u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate);
>  int a8xx_gpu_feature_probe(struct msm_gpu *gpu);
>  void a8xx_gpu_get_slice_info(struct msm_gpu *gpu);
> +u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu);
>  int a8xx_hw_init(struct msm_gpu *gpu);
>  irqreturn_t a8xx_irq(struct msm_gpu *gpu);
>  void a8xx_llc_activate(struct a6xx_gpu *a6xx_gpu);
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index be81f141300f..a29f8149493c 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -130,7 +130,7 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
>  	}
>  }
>  
> -static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
> +u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
>  {
>  	return ffs(a6xx_gpu->slice_mask) - 1;
>  }

