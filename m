Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E147606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jofX2PlH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IESA1V8L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EBA1127EC;
	Fri, 30 Oct 2026 13:09:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0F81127F1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:09:04 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBG4wS3142134
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y4P301YqaFnb7KKDE2QgQixMk0k7HBc05iLOcpHCCho=; b=jofX2PlH9sK44rY1
 hTJwH/V8S1h2Ehj/NWXUdY64MVX3m+B7He4PrRq6Yb9Iekg2dQxrn0HvtZI28zJ9
 RRcY15pL9JIX/ZRIW1lSCPl2zi8c+svbt1KdqyBn7OuE618BEsyNZA/awYfXJfHZ
 x394lXmUJwAi5oWW7Y3mnrQb4mhpf5ALmAZkfuOBe1PS6soxP30XEchqhEVQXb8S
 6wfxhs5I3ebouclMOJoynZoJ8Lm7FMseFxIg3Aa7qkHnSU7I8HOiGB0jkDZ1sMbu
 mKCDKfioiruMwPg2jwuK8B5KLaUXuIWmy2seuAdgtrA912gg7ClcJYCBdXlsoH4r
 r9G6wA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk4cq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:09:03 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-988b7a28291so18771241.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 06:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793365742; x=1793970542;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y4P301YqaFnb7KKDE2QgQixMk0k7HBc05iLOcpHCCho=;
 b=IESA1V8LDpMc0/0DaFuxz7WE40B4Xlaq+H6rOQxit/VEdKplQLCcQXLcazTaWP4IWQ
 XSjdvl5D9Abe+9gsNQi6sGr3WvZa/Rc5s4ARsNxNJ3rqhWQq8A/hH00Kn7a17ZAsAhPM
 GmYtv0JPY/zA3TFRVyF4Dg+2JiyWqbYJPDt5WEMOXhiUhk/N/Tn9weCJCQrNSAteok7o
 GdkrspV1hU3YtU79zYMzMIR1dxvT3/wG0YdqVM1gOZQJzmFU5smHyQe+s2kmMgNLKvKi
 dc54N98QNzJSGUPg05f+gBmJCwuNKfLUxJKynubdGo76TM+zgOKK69KjWZLROBtQve2F
 fqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793365742; x=1793970542;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y4P301YqaFnb7KKDE2QgQixMk0k7HBc05iLOcpHCCho=;
 b=JBlKoRiu5nDHuTO3ZfHRQPajJnfoGinXE1oVHW6Z4Ftq+iRke1dZmjqu26r4SSLsSS
 inUe3wOtI+vhmMZ+YjCiIf8QzZ4DwyD/m1WODoAsjs1aI58vopo0k84Gjx0ywNEi4ed1
 BrAtkeDJMH0CctaQ8v54O0w12GxaCBdktFyoX6Wh8E9snk0KIaUQYNpNLTmJauExjVqm
 FVfxudvk7jaiXeLYWf3f7U4ISi4cvPG4szrd92kg/a2bE9X2TFM2g8XH4Lr1ulVDkgRz
 Z/diSoLEd7VrEqkH+NZjSE7eUYbcJNucPv49wcBpE39cAS0ZtgPioPsOUcfBL+6EchXM
 5rDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwi5/QK+bSXIWqabZR/b8BuyZLZnwaxoXRKXGFK/zMULubIFxgpDwMhIUt+peVt4938Q1UbPSjUMQo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLh9k8iS+D3lZLjsImbdc4+VQERXHboxC+pzouKYqLa7A3I9Qfl
 LX6rjQmWvfvX2vXEArULO2cV8wxgb3IpLfjSVfxLlN/aNjtBu4lZgCPVKCXJYC4mHGm+KRF1bt2
 Ef7CV+Fot0NEMalLsrMYXEZGCASO/eEODDr+N903kstqO1eTWLs+14psz4Qk/H0HMvc+dO+U=
X-Gm-Gg: AYBFou2DoeWj4TRrmT4HxNmJOgRBC9Svy6aF+PxpL2eCrkP5oKeRV6PlhJmVduybakc
 Kta2f5JZv9NpCc7Zth6dpbTPrk21C4aGnA74XxHqHyW38PsRqrfvJdPtD6d1H8YOCjs39pSokCr
 ys8ZIr6A3XhnmX1MAXdmor3X2+8y3BMc319QhaLoWC+jBsLBEm1RbAmKYtSIntLO3ukFRgJngF1
 SSjCkB4i7bpoR51hXqH6JdWehSCe+5VA00dIFhxs8v0VM9VK2YETwNBKK+QENHrPwZeuTG83Kdr
 opPmykU/ydeqg0CZPe6fknivTNvOxx3pbcHk+Px6wYvPRnK31//+hbaj4ZNNffE5uF1Tt7toS3w
 0PBfavpClEDgh1pIR5tHxDX0cSd/N/X4TTmffWj7TT0E0hv8zCV+6RMkINs7LtF7/XK8APkM=
X-Received: by 2002:a05:6102:868f:20b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7d0727a54dbmr802571137.1.1793365741994; 
 Fri, 30 Oct 2026 06:09:01 -0700 (PDT)
X-Received: by 2002:a05:6102:868f:20b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7d0727a54dbmr802519137.1.1793365741491; 
 Fri, 30 Oct 2026 06:09:01 -0700 (PDT)
Received: from [10.169.205.110] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4d7b01b5esm605327a12.20.2026.10.30.06.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 06:08:59 -0700 (PDT)
Message-ID: <3f11cf8c-db2a-4243-b1f6-7f2cb9a7a87e@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:08:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/14] firmware: qcom: scm: Configure LPAC aperture
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-5-a21a5c850961@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-5-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GHf9700mn-WSDAozkKBdnH9fCe6XetHy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfX6HKmrwoNh4Xl
 NRs2z8Sm8550rwmNRDOQd/BclgWKTNqT/7Hhdj1jsQ/f8Bg9lq4d9ma5Fqkxramt4iOCLV1RwwC
 99jLW2+jQdtKoCCdv3RBWEkYXiPjrrU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfX4hZVXRFvJuSs
 TMervIpzjt+F42rjtc+axrKCb9sfI44ix+LYsHVm0ofaump7ES+k6R74Np1RUUvmdxx6YHW04K0
 AWj7NKOJtQrahRSeZK8lquPrwF2xbOItmudTmS9PMO46fZ1GOxnruvyao2U5ZBuEIL9At+NFTj0
 42arK99s/MOsGZPDZ1Cu+ZWuHwYODj/VCGEZKgPvKaWVso/TUHFRDVwAU4r6IvZyjAQBOIrukRt
 dnKeqndgQO3BIhrxajTS982hx6g+qPvUffeDWwxk6faqNvlOSyFfusVqZ8jZOfDwMY2J77MinRi
 ONkLkjm1150YoJnpCsTE4q4C/+1LCVlHSRP5M+sGn9ynDusN/PX0TcvbEpSkNR6UzaM5x/8d9Z/
 ZyydI/Vy/fzqqnDAAGftrnLNgeFHXqfRPxeYY039grGViKgMOCVnT6sL4zNULrh64YVnSch+h3O
 fBRgyJwJSFsfTEompkg==
X-Proofpoint-ORIG-GUID: GHf9700mn-WSDAozkKBdnH9fCe6XetHy
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae496ef cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=HiRCik2jR1DMqHai1FgA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300052
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 2:52 PM, Anna Maniscalco wrote:
> In order to be able to update the SMMU registers from CP for page table
> updates we need to configure the LPAC aperture to include the context
> bank that will be associated with SID 1.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c        | 18 ++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  6 ++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
>  include/linux/firmware/qcom/qcom_scm.h  |  1 +
>  4 files changed, 26 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 9b06a69d3a6d..92093399f20d 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1204,6 +1204,7 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
>  EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg);
>  
>  #define QCOM_SCM_CP_APERTURE_CONTEXT_MASK	GENMASK(7, 0)
> +#define QCOM_SCM_LPAC_APERTURE_CONTEXT_MASK	GENMASK(7, 1)
>  
>  bool qcom_scm_set_gpu_smmu_aperture_is_available(void)
>  {
> @@ -1229,6 +1230,23 @@ int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank)
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_aperture);
>  
> +int qcom_scm_set_gpu_smmu_lpac_aperture(unsigned int context_bank)
> +{

Please make qcom_scm_set_gpu_smmu_aperture() take a parameter instead
- bit 8=0 is QCOM_SCM_CP_APERTURE_REG, bit 8 =1 is
QCOM_SCM_CP_LPAC_APERTURE_REG

Konrad
