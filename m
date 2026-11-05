Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A933606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o1zEJvrx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I7IOaH6y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D9210E99D;
	Thu,  5 Nov 2026 22:00:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E4110E99D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 22:00:32 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L6IDH1947953
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 22:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wJNjolyzsnHuSD33r/49z8gm5UN8Kafker5qeL2G2gE=; b=o1zEJvrxo8+XDtIJ
 SKR8dJMwThbORfM7FgEsXENMjHoWqWDpZdT06TU146orNq9f93qbPxognVIxT1JA
 KWEeXRYtn+AIDnVfxhS+/BfaOSLSXFKPJVvShpTlhCpnvnRQQf6KrTOy5rLj0DMe
 w0yzznj3jfwZbCU5HxvNBcfZEjArwRuqec0B8OTB55rel54ZfmRuHhEy1l3CJZLv
 Yr45Xcp1+LZvvbcaMz35Hxa3dQIKKyujWIBikv3dkWNxWfy76JJGsCff0LXDT+E3
 SpA8cQmKjaNMJJka1+Rh62hgLYN1PyXzH6ygmlgCoenmjYI9VV5DcHyGZyWz+4YR
 ToZBBw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaakgtw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 22:00:31 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc4ac5feaa4so1732935a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 14:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793916031; x=1794520831;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wJNjolyzsnHuSD33r/49z8gm5UN8Kafker5qeL2G2gE=;
 b=I7IOaH6ycstHwxaSvelebolvjtfji1VzDid4cE2oraKAQZ1ofGsgXWQnJ2ir0qWiQP
 Fgoue95ZZuYk3vmPqHiNFDP3u1zr3NSeefknob4Jae69GfKti6CsVOSpPt9nskFZcxNX
 q5F+O+Dn5Z4zOvKbgHk3fBp5sXktWrMXNP2u4ksh0O1p7o6oro7UApF18kY8xaIHy9qx
 yzU4DhdWzo0/WdzwkoHu3M/rPitutGnBPX6szPfesfT1tcIiYS/F5HJlXJcIsAzCBI7a
 iBliVTBiOa4pYLdSbTFlCqSfqYmNJUeUBJWyJSGH+isRfBjkg6fjJaMGUJUrpJzTRDxX
 ewmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793916031; x=1794520831;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wJNjolyzsnHuSD33r/49z8gm5UN8Kafker5qeL2G2gE=;
 b=uUwBo+Q7A+0p+Nwy8ihDNJENnUnzapzkZ7fQp+vcbo0Ocrp9qwCDsHD5u9Ky8rtZKS
 obKwcVvvNEiSHy6Im56XieSGaAGT+FZ5cZ1wvDJaQa7rXfUr/Bugk7KiH4WhRrVRPXug
 SEZ6folRYnwJiuzhhgHaAIc/+08bDtCMawDEF3JubFbwBAf6lFTvSEY1kcqJTzaqLNeD
 PmcRR7hRC62ZQ8FM2tt5uVtVXOu1ggGeYvzon9Lfu+EwqtKQCjjKV9gs7pucV3aU7hWx
 h+eOYm7NcuYA0m402613RpigRU91kbMz4FhRkTUFLZoioZTsTH0Bg1xwRlZnZeSpdtrL
 iaJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd11g5NoStANxdCfkTppIYIGbDujI9UJVGbbnympPcQLCG57F9hBgUQQFNk5x4n3K1vfhRRnfNMNg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9nFFwBlL+grUKV/XvrrVVBTMVGNJ6UDQY0tT6iHi3EbarbSIVw
 L0751vBIGUihLrfLFOGEdZ7otVdTB6v9uhbPj2PRZaiG7h4WlXlcQba84uOgAAEBz5uwFyAL2ml
 /wbdcEvvbZ8xDkSWvK5zQ0hHwBnV/sJQGy0Fg65BBEQ0VKPfq9L83S+7YAtpHPYpyqVaYA9Q=
X-Gm-Gg: AYBFou2KqQnAUa3vUzQM16D2lmXa8xRYTl9QYiVnZ62OuMgUtx+HN5hpwhRiiQEQ7D4
 kgYnQIekzwZC6ozuMfhku5JHTrqz7MyQALsKBbrwa4r2D14Y9a+u/yFYg1EXP8nqRvVDBPYShCT
 0ka6/jw6mMRfSBwnVQMpRlASuFZcMkfshLPUInge7Rhmv2xvb2eVzG9pYlD1aYEKfggTwcDCnwM
 o44wbNAKD7wCcXWVMKJUpV+NhrzkKmuu/6RwsrBnw/m5i1Y1WATRcXzDIYXtJsClsBbmFu7PjSh
 9+0iScQMt7c8AomRw/nzfnKUyXaRpobz/OBAlmjnijbWJvX07wiu+VkQFLtT2aoBGd++TfQ8Nw5
 7SsZ2NCRaPwpfTSnUP7nDzUqR6b9cqAaVOIoF3tA9hKfdBQoW1vChO+VIjZ40zuID5R0D4nw=
X-Received: by 2002:a17:90a:f945:b0:3a8:c0cd:57f3 with SMTP id
 98e67ed59e1d1-3b0db6d7d8fmr311998a91.18.1793916030598; 
 Thu, 05 Nov 2026 14:00:30 -0800 (PST)
X-Received: by 2002:a17:90a:f945:b0:3a8:c0cd:57f3 with SMTP id
 98e67ed59e1d1-3b0db6d7d8fmr311958a91.18.1793916030062; 
 Thu, 05 Nov 2026 14:00:30 -0800 (PST)
Received: from [192.168.1.9] ([106.222.231.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0d7c8a3d9sm888376a91.10.2026.11.05.14.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 14:00:29 -0800 (PST)
Message-ID: <7767e37e-ccfb-490d-b0d4-6fb5c6275618@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 03:30:20 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/15] drm/msm/adreno: Fix PROTECT span length
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
 <20261105203057.66520-9-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261105203057.66520-9-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NyBTYWx0ZWRfX4lGLMRTdAogk
 f/kFZT9QJD8UjE/19ruVutEL8NZ5hbVHqWyAbz9knKqOm9YgbYZBQd0By2e/iWpQ0PySUoPLjS2
 sfYyO1TwpZlLhgDaGnY2EMUFfuazrfdpIo+CjDvyM1BMbSvAuaZPiBNrMfpCh3tiAjAf44w0gS+
 4auU9D50QBGx/3MW8ommdpsr44+Se9y+LOaAtD2Diw9hUoOvYgBu1jm+veC3HI99xz7uFeqQR4G
 dcqU+v+WxAf0t5aC3/bfEEXGWamhvBN6FSA+NZI6YI4m2yp5aVvEPwIGdKgGWct1HID7eFkgNv9
 tNliYI+EZtMcwiHv/uVNkY7M1VSaQ5bBsDukAVe35rej9zsp99Th6bUIJ0ieWqNrpZ+fLqi9FG2
 RRnhjWVN0eNLM9S7yBEOW/vTahdABY6LnzOqI5HjGDQ0W/DzKCLnqkOEIu98LTvKkjBNG5RWr/B
 f3FXlyETziKeu72OxQA==
X-Proofpoint-GUID: GrMOKXZCn6ZmgURLLmIbRSBxDc1kagOC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NyBTYWx0ZWRfX2ez+BXlkKx/A
 X9OFgNLPxEWUnd04to5AW7JR7VSidQkPkt7/Y7yi4XZ1ai2fr+xnvbxxviEcBObUV4UW3H+6woz
 MFmLkbu9p1CK89TqrE2jsUaHbQ3oQNY=
X-Proofpoint-ORIG-GUID: GrMOKXZCn6ZmgURLLmIbRSBxDc1kagOC
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aecfc7f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Hj0ah+TxS5FywmoD0uLh0Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=YCRwkS1-XJqieDW-VhcA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050087
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
> Don't let the length bleed into b31.
> 
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index 4a3898e58aee..cfe7a3ed44c4 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -244,7 +244,7 @@ struct a7xx_cp_smmu_info {
>   */
>  #define A6XX_PROTECT_NORDWR(_reg, _len) \
>  	((1 << 31) | \
> -	(((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
> +	(((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
>  
>  /*
>   * Same as above, but allow reads over the range. For areas of mixed use (such
> @@ -252,7 +252,7 @@ struct a7xx_cp_smmu_info {
>   * single register
>   */
>  #define A6XX_PROTECT_RDONLY(_reg, _len) \
> -	((((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
> +	((((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
>  
>  extern const struct adreno_gpu_funcs a6xx_gpu_funcs;
>  extern const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs;

