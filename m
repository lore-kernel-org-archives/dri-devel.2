Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFEF606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ennYUH5R;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VJlsEorp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF7610F24D;
	Mon, 23 Nov 2026 21:39:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022E910F262
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 21:39:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJuNf72349969
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 21:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5eN+uAzBwgDgS7ksun4UE/qn3Qm3xyff5PhqmXd2xcQ=; b=ennYUH5RgxtQLvCC
 9aIQW0JsVuJ9awN6zp/wLVjINNwben8d1a/sNxZk5QarJ33qluJ7hSV7ADJwVAKD
 vtht8YHS68f5kRxOHdZDjGhfsWwf1c7mRE6zoCEDKPhQOW0k6bhAfHwfcfGtlnyR
 kJxbqnpIGkVmiNNB7qTV+odRbYXZTWkBmpSE3gxWTFoBdFgOomuuY3yhpsY1YtG/
 wRv9d2lzZ/mDHAXaE508glP9OTYZjSckvVmhkfSXRYMd4GaXSGaxsD8y/7yExmo4
 Bbw5WhOP9pPJw5vJHwoxS1dql0bTBYQnDKjO6ia7wk73aDSDqUhqWjIQeFMP1EdC
 lqVzPw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g9a3hk0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 21:39:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386a65fca25so2399207eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795469965; x=1796074765;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5eN+uAzBwgDgS7ksun4UE/qn3Qm3xyff5PhqmXd2xcQ=;
 b=VJlsEorp7EdSuPlFyqlHcoIZmgCkrSW5Q3m4ZaXfdNf6NyEdirYiDqAk+w/QVFPsgK
 6LWFqgIBz24RGYZpU04Bn+kSKEspnvKaOpyiWz7b4nxtp7nMssdHowvWA6Spi4SGFsjP
 miAta8dASP3Sm9CYun1Z+vdUMeW8qESqJqi7BGQIlsE5Q7dlVPIQB3K0RlFmHuiB5wOk
 aZ8+did2vIPaenvY7coRzKu0NSPDYqmzXVrZ2BTh3jn4iKytLtvGA4En+JpoC/hWYzF8
 XlBRFqtmtWAyyhhVIwAMBz4IinTktoZDCxWhFGKTyAQl3fqnOPUOQxmkeGG47ECbEs2r
 Prlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795469965; x=1796074765;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5eN+uAzBwgDgS7ksun4UE/qn3Qm3xyff5PhqmXd2xcQ=;
 b=Aq5FTtHhJqzV5+Bnx0XN4DRtw0LROmNQva+k0+YEp/XJz/apjHesEL8eSdlSe0Iw9Y
 pTplKb3K5D89sU6z/ju75MTa/Ilw6u9i5gQg2YF8hY/tCzGFFdih8RS1SqyvwVsLF7qV
 iJvRWfZs8rX8bh1YPPPYvyNCZE0Frjv47HwClXFWB2H4nzCO65j+dUJkbjISMQ9T6V5T
 72O0YT+CDNJGKloimOqDVsxbM2gQOt037hsdBjVpDleYNjqhno9VOR8iERNoqlZnr5+V
 ASHaJY3Ad7TOobeDLVjDIp1V7a0Y+UUAxEODZ6dQz406xpGMZ3qUSllCdBYcjing0Ag5
 SU+A==
X-Forwarded-Encrypted: i=1;
 AL+hErGcKt7pXQjV+eVF0SoeF213o7fpF+4n6mVGkWf8T/IbUkV1ebsq+bIGZ4HqPkYYrYWJCjRc/4ISprY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ujWNSqDrytW/+jbiCV5BvTbVA0toWRgRQpjcy3mhFebKtMIwb
 hBW75MdgiSzogvO4uhfnp6TR8RLShvh0tFrqwJSq/XWxLtmregUN9WeYw0kNdaFhZ193n28Tdch
 IByV1yBjy69MSxN1xgxvMWz+0owMRMVUTZL6+rqY/LlREUkjV0TNRxRwEHESY1OOzZWZu94o=
X-Gm-Gg: AZFdTZeKwUtOVcOMaiobC7NcFFRyMC+gJn5iIgjaZjQDe4x8sabnXyPOaS27oAiWp5N
 h0IQK9pRXHcFMKzCvVaI0Fupc2CeELxVTgpFXs+tFy6JmZrhkqJj9NRQBDlcGkUckqoOdMyd7Rs
 HNmnM0P0m5GkZVH3hMqC+CaQIFEem2x02qlm2KQgjJiCzA7STmy2mKVpPTLtmdpygLnkR13qzO0
 ZjQHjqJJ/9+hJ1H6cEWVnCct2itquxOd7XDGbEPdJPjybcFO6kkg0f/u2tZ2mKqF9w6UNYh9Kgq
 7EmiS7WsnldyFSBLcTwK59EP3zYtmfH2IsnJAX9nk6rGYXdEYyAk7H9QjtJ70mJBlLNSDxqe0Xv
 91RRGmGwMTJzB7807Yj2NfwQmsYH+K5RGcXghrGiavvUnqDYT1vy9XzNFOVumcCZhZ44JHhA=
X-Received: by 2002:a05:693c:68d3:b0:386:912f:c8dc with SMTP id
 5a478bee46e88-386912fe5efmr10344169eec.6.1795469964600; 
 Mon, 23 Nov 2026 13:39:24 -0800 (PST)
X-Received: by 2002:a05:693c:68d3:b0:386:912f:c8dc with SMTP id
 5a478bee46e88-386912fe5efmr10344150eec.6.1795469964115; 
 Mon, 23 Nov 2026 13:39:24 -0800 (PST)
Received: from [192.168.1.9] ([106.222.230.69])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c349csm41004355eec.22.2026.11.23.13.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 13:39:23 -0800 (PST)
Message-ID: <4d06325b-e1e9-4e82-82fa-a81c5e2d6134@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 03:09:18 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/msm/a6xx: Polish up the IFPC counter enable
To: Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
 <20261030-topic-a6xx_ifpc-v1-1-6992841a9a32@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-1-6992841a9a32@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4NiBTYWx0ZWRfX4Jne4gvfK1+0
 55Ux9Dt6B7RQBSM/V00Vdo6bL07HWKcTy5cZU9HPFciKa8D9ycdVMCI24EwQounGzfWjiPJufmM
 PDXe4gv83PWh6+1u6p0cHt/DJeWoBkU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4NiBTYWx0ZWRfX1Vb5Wa/JBpGz
 66qa0XpKg5x7eavJgn9hARmMeY5bLYk7oFQlxpHAJmHWZX3pT1TU1AZ/v14WOJymayDD56r+nVf
 otd8EMp+vlQ6vwfuE+MDk9AKOXPcc58pB8EKA3pwAKRF4f5GtF457AvsRmzkcrONcqw4w6/rjqA
 a2X/KDE+4jA88pJgu9yQ0XTF+0sv/TGSaMtA/kMYtkbfDerA9cMT3yhfLkV3k1UxHIwChzPo3jA
 ezE9Y64MC6FiyyDkHaHr+UOrF4GXoGv1tFHJezPOrEgaeEiiMrb/lD2CB17vUUs4ppflq4O53ae
 kjwKsMIngq5Pkxbc25nxMgyyePmNsD/jA2cWwZ1PmTXsreQLLyU4/ASlXJYb7J2WHBm1xTZt852
 PUethxCZ+4eoQu94Zl1KCAIStMZKuYs7Hfp0LbUbCyFieMP2WXDsc8d6jRBA10zlxeEpsUQZGgF
 6M/spRFuM3ue9uQdzog==
X-Proofpoint-ORIG-GUID: 59W22cHkGql5Z61fKOj58IMzxQTAYXGj
X-Authority-Analysis: v=2.4 cv=cYJHPXDM c=1 sm=1 tr=0 ts=6b04b28d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=6/OokicQZQM7IRI9QMJePA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=t7XnImjxOyE5UpSjZyAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 59W22cHkGql5Z61fKOj58IMzxQTAYXGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230086
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



On 10/30/2026 3:33 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Extend it to all targets with a real GMU and use a rmw instead of a
> full write to preserve other things within that register.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 6 +++---
>  drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 1 +
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 92e8c8abb86d..48d3ee4d55d9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1332,10 +1332,10 @@ static int hw_init(struct msm_gpu *gpu)
>  	/* Turn on performance counters */
>  	gpu_write(gpu, REG_A6XX_RBBM_PERFCTR_CNTL, 0x1);
>  
> -	if (adreno_is_a7xx(adreno_gpu)) {
> +	if (!adreno_has_gmu_wrapper(adreno_gpu)) {
>  		/* Turn on the IFPC counter (countable 4 on XOCLK4) */
> -		gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_SELECT_1,
> -			  FIELD_PREP(GENMASK(7, 0), 0x4));
> +		gmu_rmw(&a6xx_gpu->gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_SELECT_1,
> +			GENMASK(7, 0), 0x4);
>  	}
>  
>  	/* Select CP0 to always count cycles */
> diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> index b3082738c99d..4f934c194f73 100644
> --- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> @@ -83,6 +83,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
>  	<reg32 offset="0x1f84a" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_3_L"/>
>  	<reg32 offset="0x1f84b" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_3_H"/>
>  	<reg32 offset="0x1f84c" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L"/>
> +	<reg32 offset="0x1fca8" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L" variants="A8XX-"/>

nit: this is unused in this commit.

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil
>  	<reg32 offset="0x1f84d" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_4_H"/>
>  	<reg32 offset="0x1f84e" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_5_L"/>
>  	<reg32 offset="0x1f84f" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_5_H"/>
> 

