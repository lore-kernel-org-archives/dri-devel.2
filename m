Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD4606A330
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g/9yJ1w6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TDFeK8iw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906B810E3D1;
	Thu,  5 Nov 2026 21:38:44 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B5210E2FD
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:38:32 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L656F2890905
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 21:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GLUyA+JdVk9Y5FHBpmrNpe/SRtKzv7LV1qnsCQhdxLw=; b=g/9yJ1w6xyus8CSG
 6GreSuiJmB/RUoe5sKIVIVElj0KgJ7ld+oQcBgna1Qsvs9zMXvVNtnpT/TUVslzi
 SB6Z7JWI62WSfj825jlQATQ6NN3fViOZXXhAd8ZpGbsGrHhvLl6GlBp1BYa0n65W
 d5Zpu43GzSjkSHDmpzfFbBlSDmWimMecYFt8HsYtqY9Rt72VdhUoCh+x2RjczMkL
 Uzk86BXgBh+gHuDY7vWb1ASZUXYSuIQ03AsToxSt5MawOa4wL95tFLGwRxCJtZvl
 2QevwuGApTsJPN4dKJIH2dYDDLz/RStitsEjQpor7JgKYJ4raGrubZZfa52vOOvF
 PPix7w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs14gg6ku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 21:38:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36f479b9819so537578eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 13:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793914711; x=1794519511;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GLUyA+JdVk9Y5FHBpmrNpe/SRtKzv7LV1qnsCQhdxLw=;
 b=TDFeK8iwExdwmkvODV8bXJMz2Sp7U+xElNy0XREmsHEItgDD0BzFvtS5j2zKSYu518
 oiBLIe3wZFPyFnMW9F8oKF4ijQbpwQFx0qe0WO2WCNiYViVrwTWSgfbBBcdYbJx/McBr
 9+zWenB6R3s4lImf30fdi8/JgsCQx7mKf7ZIoBmkz8zT91JxJR3PB1IhbPYccmWG2QMO
 6sUBV1RYyt3N2kqzOHwmkJZ9M+fj1d5cQ6XpYEO0BEPZqhr9yeDZJnlWK++bOyeeehNC
 /rnxkguMNAWpCQenE2npHaklapI/vvGCMZKZGhnEbwe5m/UvKJAhEE0q+x+oEgbzfDkm
 UbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793914711; x=1794519511;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GLUyA+JdVk9Y5FHBpmrNpe/SRtKzv7LV1qnsCQhdxLw=;
 b=FfKr4GDxJ0csaWJnPZ8fEx/w1Exh7GW8UWIm+RXv523SQil8ZwtlVa2QH+qipOK8VX
 kYF+UjpRJsgAD16KlUkYxx6fLLeD40AnbLd/HLNpF5Zshf265HqbukHOxaAoqqexJu96
 weWFm3OxdMmNoo9wHGh59vM1m2gN/3PsoOPas/gfYEXSrqM06fYd3WblK/XBbuwz8qEW
 rF0ChK6VE/oQlszbS/kSBvWZHX+TysOi8Xv+hOYZLxet9nKuUfr9+0Ql2PApUfWwXUQb
 6qXZu86pLa14SzTK6rAtT4nytDRRDTKVYASuPVA5nrPgH37OsM3G0qb+OEprSVYv98ZW
 dWZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzltY9mMaIh0OWguhQimxcidIoB9QPqPH5CdzBTavhiINg8cSRuEc26pwaFwcBK/MkqiDQbNN5F/40=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+yzkP6pUmpBTO0VoA+WZwYLZr0u4fRx0w3D6IUyOpbpl8B+auU
 hnK3hQND9aLqpsJDnPnBDSMQn/Ysq3nccmXjAPBg75JO94BywjvbwEApzabQ6oHIBhlTMWr4e3d
 VaNTyolrUHSkesniDKa6IdEZ8w4zIMn4nfr7yqhc6t6KWEf9KX9U9MTYf5Sy3bsQsmZ1jFAc=
X-Gm-Gg: AYBFou1X9xUnYiaF/R1IeD4suMyJiL4KsGl9AH3dCh38anBiKhEoQ3TfDbX7lM3J0ky
 tFviBwy1dqb8I4LhwO2HpF5SbNUa0yOJuUcoPULaHtya2ZuZg7YW1Grz6bT/iJ1Rpc4qWadSya6
 uaKkMW02oCeYBKqjPmLulMkc/53Q6O07vNi3yUZ5C0FyhJKQ7QdeT2gOdanPW+sv2CJK4wYUbMx
 peMO+wE3vP3VPp9fO2PFpEvziTkLnBIvPGikRu1oBrw4m8dY4krmh9IOWotwAmvgauTklCKt63W
 LaZyth+4xfiZi+dTeRekh1dHhGPumG65s/HTIkfQYv3yW3GzXhzfPCI4sNCIBWKnqrQUPzESSI0
 KYlyCv/auU3WaQAXUUUBIRDLNcHqGeb3jLJB23B5oxfLlhGtcw0RMh+F8wZyzfDPV46ythvI=
X-Received: by 2002:a05:7300:ae81:b0:36c:a390:8907 with SMTP id
 5a478bee46e88-36f7611e32cmr566794eec.21.1793914711209; 
 Thu, 05 Nov 2026 13:38:31 -0800 (PST)
X-Received: by 2002:a05:7300:ae81:b0:36c:a390:8907 with SMTP id
 5a478bee46e88-36f7611e32cmr566744eec.21.1793914710521; 
 Thu, 05 Nov 2026 13:38:30 -0800 (PST)
Received: from [192.168.1.9] ([106.222.231.155])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f73e79e93sm902327eec.1.2026.11.05.13.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 13:38:29 -0800 (PST)
Message-ID: <76517f11-c6d6-431f-89da-e49c21f8c27f@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 03:08:23 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/15] drm/msm/a8xx: Add a8xx_aperture_acquire_raw()
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
 <20261105203057.66520-4-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261105203057.66520-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NI1AaE6g c=1 sm=1 tr=0 ts=6aecf758 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Hj0ah+TxS5FywmoD0uLh0Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=PMOyc5WQbjzFEtWUSz0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: E27zNAlbZQCI0mQJ-Lc-luc7jPPE7LSg
X-Proofpoint-ORIG-GUID: E27zNAlbZQCI0mQJ-Lc-luc7jPPE7LSg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NiBTYWx0ZWRfX7tLBTPvmgtnh
 voNMr7Xc7DDHqZJ7ylznk8+khEgiu/63LVcp7Ma4lsoYInn1ejmTnLTFsHpuLqEs5KwlXYZ75IR
 eQoTXa0rpskyI+PeyrKwa1XJW5CZERI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NiBTYWx0ZWRfXx+hJhbjXGvhf
 56q+Ow1lUjR3KFpQ9uiy/ErNFaS/E7TvJodx/BFofas8QoCEMGPi/8bM7L62k+N8QIR1N5eybo8
 JIkdXVY503hnQ1UWQhe6Ta8gzbhdh7I21xdkDdKFjmBU7V+/PhJcJRm6b0+ngR3AdgZwFU8PNIm
 3oiJ75j5L28fPds0LdnPWrrhU49LVAn/HKIUIuxt4GXTHvAonrWUkDLyEEZcP2y0Fx++WFV15js
 eMV/b28E6QdaBe+80sv8wmbgaOiKKDNzSgNmIUZ2cCNqwp9ijokwGiCEuVEkahuNbeTHkCtZACc
 xhF1nlHCWpIhb7L3kkQSiRKTKsYt5bLjKyuCjw0zsfEj+V+OwjpED8W+rkoCdYeQ6JePJMvZ0Q3
 KRVqsjUKxar7G/fPf+oHfohR/v18RQhlHJ3ZpP6pWaMmHLYd3xPaQUdf8+E0UnXQTU6hs8xw2bI
 QYfyY8ZHwcqDUXAjbNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
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
> The snapshot code will need more control, setting additional bitfields.
> Rather than add a list of additional args, add a helper to acquire the
> aperture which directly takes a reg value.
> 
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 21 +++++++++++++--------
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index c58a2665e9ab..e6ec85b20fb7 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -346,6 +346,7 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
>  void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
>  int a6xx_zap_shader_init(struct msm_gpu *gpu);
>  
> +void a8xx_aperture_acquire_raw(struct msm_gpu *gpu, u32 val, unsigned long *flags);
>  void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
>  void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
>  void a8xx_aperture_clear(struct msm_gpu *gpu);
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 82cddaa7278f..be81f141300f 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -16,13 +16,10 @@
>  
>  #define GPU_PAS_ID 13
>  
> -static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe, u32 slice)
> +static void a8xx_aperture_slice_set(struct msm_gpu *gpu, u32 val)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>  	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> -	u32 val;
> -
> -	val = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) | A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice);
>  
>  	if (a6xx_gpu->cached_aperture == val)
>  		return;
> @@ -32,14 +29,20 @@ static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
>  	a6xx_gpu->cached_aperture = val;
>  }
>  
> -void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
> +void a8xx_aperture_acquire_raw(struct msm_gpu *gpu, u32 val, unsigned long *flags)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>  	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>  
>  	spin_lock_irqsave(&a6xx_gpu->aperture_lock, *flags);
>  
> -	a8xx_aperture_slice_set(gpu, pipe, 0);
> +	a8xx_aperture_slice_set(gpu, val);
> +
> +}
> +
> +void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
> +{
> +	a8xx_aperture_acquire_raw(gpu, A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe), flags);
>  }
>  
>  void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
> @@ -74,8 +77,10 @@ static u32 a8xx_read_pipe_slice(struct msm_gpu *gpu, enum adreno_pipe pipe, u32
>  	unsigned long flags;
>  	u32 val;
>  
> -	spin_lock_irqsave(&a6xx_gpu->aperture_lock, flags);
> -	a8xx_aperture_slice_set(gpu, pipe, slice);
> +	a8xx_aperture_acquire_raw(gpu,
> +		A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) |
> +		A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice),
> +		&flags);
>  	val = gpu_read(gpu, offset);
>  	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
>  

