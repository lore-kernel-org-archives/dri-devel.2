Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939AE606AB3B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CjYxi8nj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OBx1WVJg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E0710FC7E;
	Wed, 21 Oct 2026 08:40:36 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D37E10FC7E
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:40:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5ixJe164999
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kpoys/1kxKqn4AHu1v2G/H664oi65sLNEFT40K6LcKU=; b=CjYxi8njMzWuUsIf
 P+qmKKyvQPvo53I6G4lnQMuJrJejY9WR1VnV/XrTOkezdFaYPo40gv0TPZuz2fHb
 cMOk5aWqZ7gqroeQLLKOEQ/2unqAFyRXeWZh+llp4XpN+Ql3/mTkj3t5nvRxdSzS
 4y4KVJWSQGhx3a3cxbl7isSSVRTa71ehkW4BORaAwqB7FFqTsnMvAiElIP3k0JZ3
 0Xt6bk2M0NGBv0GJ8vCH36mAadljju2MIOSncloxTuMM7tTtqFLGbC8tywg4gPHO
 OSO9UNunCrBlqR6k7ceL7TWYgHUI9XOAQHYjibSzBPI7m1rkVhq9S6D3WO4rptYD
 cYyIww==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs025m1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:40:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1440e081so13030185a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 01:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792572023; x=1793176823;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kpoys/1kxKqn4AHu1v2G/H664oi65sLNEFT40K6LcKU=;
 b=OBx1WVJgGHom+nahhkJeiesnpYO01JXc5bDvuDpmC0sggFHcbw/PfNqAv/OOoZZ6wS
 lNQi8vnzUUyAgwq99mgf8qpVtiRgw6l62kr25qte/jjg2x3TExTGwSHEaDtzYvfzYZuK
 IMCeDCegq2bsJUEZHFt4BkDw67Hd1fs8tYzHI6P6oHU5bqMbpzITPJIDSo2DtHjd1FYM
 ipB1Vim4SwZcvW0Hh5NALcxVcuzxt9pO+/qJNNBZfaLpxoXtj3Lcfd5n1SIRajv0vlnl
 QcU2BbZKJaM34U9lqCNFU6LhpkwKkVXrTZOJXXACix1bYiqqNHLVwPs5TxzuIqIp3RIs
 9EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792572023; x=1793176823;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kpoys/1kxKqn4AHu1v2G/H664oi65sLNEFT40K6LcKU=;
 b=tWN8uKAgXPr9gpKGqk3r4mpYHpfGtnvzCSXVET+FO1y0MO7+nPML1CG3fyliLbEgqF
 ZtmvS7h2Mi7f0ujzpm/Re17A5O0lGOiRI9XD0v3rVBoavWSLtLP6gbK/V8MdnYa7USr2
 g9XJH7jjsFNncwbwNsPhoNVO0WNHXwC9uKh7S33DM3w+peGPd+6IKKWQlSh6JUgi4QQC
 1mLNmivCye7uhkUlJJe2VEjAMb54eDGlh6BhZQWq/BP2x8WaykhbZ5Uz79WhrwWDm2vs
 D2HunrWVnLOmN5sQ6VHlfjOjo8QERyUrN+2is4Cgqul+M4cmWr//qIMtm+3+5GpceR/l
 vDMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwA92q8AWgJl7+J4Cr3KKKYAJAAC3SjLuaCWbHR/tLOLHEqhAOh/uLFXyjDuV1FscUrVcpCbVV12P0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKczRgGhD9OgFs+HZMuTssxR6+jGYM8TmPeC6mRwKpLiTRENQsV
 AhjxZDwm8IQUjoscW0gzGGR7vHJIoDeYp4XzPXGOAUHT3rSRiayPAbPUHb8oowuGHyOL35wAsGP
 j4XLqzRD7JhjAml1kGb/H87UiQ3ZgryyR+wCuedq7x3lApSDpeXfIvo+1FelT16bWKnG6XMg=
X-Gm-Gg: AYBFou1CORgKjlcDaQFddO6SQ2a2p17ZWQinJj4prdLt/c536mFh0qYvv3r7oh6UfQQ
 LV+SMu+DdB6lJF/ISNRCIV21gvqyYH4XG2+y2uH9w+tmVLE+RHhrh8EqZKdLSzU1mSNABeUqVqw
 PxGVVrYhDPyr2Ub3WIwBX1TjV9/YOgwPI5i0s0m5XSc0I6smj/2VzA0LiBSKPrjTy0Qe9+1muox
 1iqneJ/cMoYSQcPn5eq8Eue2DCrRc/ZP3qyfzxIDV7K8XuK4KDogZpsMHKa6lSRuwsbdr/YVPnZ
 +wgBlcRqmcaWesFaqmSVLspiT7opALYaF5HhPLKwOsonTUhT/Cq1gy6pJE5IAJ2yI3RfzyKgq+S
 klWUfYNsoIrdEGBE6nxogNg==
X-Received: by 2002:a05:620a:4511:b0:93f:977:5d9 with SMTP id
 af79cd13be357-93f57dbe348mr356220585a.0.1792572023217; 
 Wed, 21 Oct 2026 01:40:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4511:b0:93f:977:5d9 with SMTP id
 af79cd13be357-93f57dbe348mr356217185a.0.1792572022767; 
 Wed, 21 Oct 2026 01:40:22 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b403130691sm613327a12.23.2026.10.21.01.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 01:40:21 -0700 (PDT)
Message-ID: <daed5a07-7d4c-4597-bec9-7a537d0af4a9@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:40:18 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] drm/msm/adreno: Fix PROTECT span length
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
 <20261020204728.28844-7-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261020204728.28844-7-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad87a77 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=swWRwoZvoC88mqOtqHgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX55kyN7bo1FGg
 ku+SQzwdLH9BpwwS7BqMxTjD2E6TGJ/i97o2IvzOjhvMMj86htEVQ751d07KmoBC7spQ0xjC11h
 OF0JQ+jKuq6LNVJBbOwmL6uVJ+4IYRqq8mT8bnV73/RE82WSLf1a3zSkhqQB0/LUWn6JMSAYbNP
 W61w6onDle1TgzfO4CBX9woo/+AVm5li/OlM8RfuM8EZ9K5CE68wutzlJD+EUR0c2N3pPbz1Uql
 HjeASomTE70QjAtVZmLC0ezc3+BYYzMvjl4lR33ib5ux9z/8FIc6Y/uLs5lhQdDKHX38QcfcRre
 S+w2SnEFfXOHbsp3Q+hdZf6UA4N4qlB66fIU9StkS76oEVi2bSR0gmyn6u6TmghX3hM0Z0uNkHb
 ifyzyb8JHP9tTLLpmvPFe4JOscUx5dmmSPUAMlbGgV7dYKcRFjlOcJp/WYbRAcn/omau3YT3etW
 ggl+ByM4ql0twAbdncA==
X-Proofpoint-ORIG-GUID: x88xhs3qqK0Zwaux9-vRaKWXc9pvxqx-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX3EB9asXd3uVi
 EHuZ37uVEq1lJONxwwcMm3dbmDoU+mI5zJHk+T6gkpE6kohqTFaBP2Enk7nCnCR7bLSK0bc5jKm
 S3lxKrqc/9LZAkr9R+IB1/6YjHYQOkk=
X-Proofpoint-GUID: x88xhs3qqK0Zwaux9-vRaKWXc9pvxqx-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210034
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

On 10/20/26 10:46 PM, Rob Clark wrote:
> Don't let the length bleed into b31.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index d60cbfaa0d8e..5e1f35c83d63 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -244,7 +244,7 @@ struct a7xx_cp_smmu_info {
>   */
>  #define A6XX_PROTECT_NORDWR(_reg, _len) \
>  	((1 << 31) | \
> -	(((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
> +	(((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))

Time for FIELD_PREP()?

Konrad

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
