Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01F606A32D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DG5/bwH5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LiOMeGEQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D7110E9A5;
	Thu,  5 Nov 2026 21:45:04 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA2B1124BC
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:44:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L6OWA1382459
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 21:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 06Pz+rhblk8xXsEimpEKAfKFnRQy16Fd//EzbdlZBxM=; b=DG5/bwH5XPJqkHgX
 DiYs0CYIam5V5Z6h6SQmff+AYwRnLjBxJhsrdhf9AVLr81NJbPd4laOvYk4f3oCH
 vpeVgv+Ayv4tELOxypZJyuwUsmeIRBOkHPvSmRBkEFtaatFHae/xrl+DQrbFTgAV
 XJE4PLDnPUuXkezUIKaDanxrhSolXB2Ss/7cXZKysk/KvDDq6+tPoPFq1MY9jf4o
 i/u47CF8oZ3/CsZrHn8TADr1AvT4MZL/NoiiPlYGIO+c6bHyn1mqxjnveCyqYXos
 xckrQggFTg6bYi+VplWPnU32mHOVWV+hskacBNeLkH93PFp4YIQ0VkUi80CkxgER
 uTVMeA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhku10d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 21:44:51 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1a2af4c8cbaso33379c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 13:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793915091; x=1794519891;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=06Pz+rhblk8xXsEimpEKAfKFnRQy16Fd//EzbdlZBxM=;
 b=LiOMeGEQtR2SkEy/molOcx/xxZ6pqxaiaEcGt2Cvyf9f55kD59dF0svmDxtNFE/RPJ
 9eYCH/5rnC0VApenDYUQ/SfnwVpadLC3xgx8I+zjGDwPdJmhw9abYmLQ51Qn9xl9I4gD
 pzUqgy31dqJeDsIGWw+Z6EeweHGOiCPKx/z2q28VCINHfB7IikbB/5dzEulkxCENMS1U
 V2jkaLCXu0Nhf3MJ7WxCI4u18xMw6ezGojXLhRr55wrcjDXG1MN8maW2L+/+fil13Zfa
 XYRy9i697+WbmEioglfGCoud0cSxUYqMQxVCDmCzSVpGkq8IDG6mV36XtKjBh0ih35lr
 c8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793915091; x=1794519891;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=06Pz+rhblk8xXsEimpEKAfKFnRQy16Fd//EzbdlZBxM=;
 b=bqZmRLo+CCix/McH2z628xmWOAq+GtwlhboGvfE3BqNchkBQADp2qPZAI4AG19nn0t
 artAhh0jBGCCVPuCotYBURcvJMzEhhavunSh+shJl4b4S03amPcm9QmWsAiaNHU269pk
 Jzm3NJBGOPh6aYKeOLvhaTrnjTmqRJBbMWfHNhYKEivm7dRhJyU9S/W2u2Db/s03Wr61
 DAIdLxYl/Az4YSuXhZCfkmSUEcfiyUe03AumaWqIAwVnK84L+Wa/lM52VItRNKyEno8/
 vhra1ZV0EOBWqKoRzCsb/N+XdBYvEECFgZAxvg44AvuxgNA3x2/VCH+n/65oJ76r3sDF
 6Wrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuQXcnU8/fz2XT28zb4TnDmTvUB8YIUMDcKHUK8Fim8LSY6y5m1PgKMpcqjsFpUv0oGk4U6zXOOf8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+bUCK+nqP2hkjFBkq68Hr/BaAgUgrcLu6k7EHjNCMl0M2hBj8e
 5wVkOIMNXOdGfBJO9jWDK91ByiQqYN8unuMJMz8h0b3iztHDu5TivW6MdyKK30tWqVKGAS967YS
 eX/Tn/EFA3vlnohUUZFyxS0p8F2V920n4boVpqiBwZIMrW5DKl3yjilrVAnhNspGkPiMCM7w=
X-Gm-Gg: AYBFou2I5HKG+XSUeGKhBFQseHkoChyxWXSHNLS/BgzYNmPUjl4u7vhGjiIAqFF6/6T
 KPYr02iRWYVxNwnvkq/4Chd4yM9AAf2rx5iiMlkW2uobrVHm7s1cNTWTz4s8tGfWrDATW+/k1WU
 7+situbCSfUUEDo9XN35dnM1NW5ipCFaAxccwzykmsMncm9Pp9reuhN1byi+9TAMWl6c8TbRWMG
 b2Ke8MAwrQiQSLkJwV12LDx40dIB/Zor1rwbgUmBPOW0u064s8dGWN+ImbDjqnM94rCQwQOx989
 kDMJjfx/PhSek7Eo9c/iW887nrvUKv/Mpflbd2BOSDcf9HgGBd/edHk6/7TkmX2hSvyMZpUa+Bz
 ERyCCWKQXzfhE3dsStIpvzKHz9jk/iQVo/sKEd3LoAgmIpLPzp+jk09o7oT1Lk0/C/d0ZlEY=
X-Received: by 2002:a05:7022:1007:b0:1b1:251f:d732 with SMTP id
 a92af1059eb24-1b25d31dcfbmr434117c88.31.1793915091153; 
 Thu, 05 Nov 2026 13:44:51 -0800 (PST)
X-Received: by 2002:a05:7022:1007:b0:1b1:251f:d732 with SMTP id
 a92af1059eb24-1b25d31dcfbmr434065c88.31.1793915090303; 
 Thu, 05 Nov 2026 13:44:50 -0800 (PST)
Received: from [192.168.1.9] ([106.222.231.155])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c2de58sm17925920c88.12.2026.11.05.13.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 13:44:49 -0800 (PST)
Message-ID: <f7757478-1d34-4fc8-8798-6b5863b4351f@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 03:14:42 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/15] drm/msm/a8xx: Allow nonctx reglist to include
 GMU regs
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
 <20261105203057.66520-7-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261105203057.66520-7-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NiBTYWx0ZWRfX8XB04l7Dq2Z8
 A5sgE3iaDqKAassIC6ILVVwfI2XnQdgMqbi7hizR4n8kY+g6NP22cIB5h9iEgCNK6ODBNwmBwVo
 bYzzwvfzeqxpB3H+2h17/ZPP4QvuHIBMfiXnnig/75HSSUtPuaV803T7gAIzTZWdkts1Ygf4jY1
 1hF+ul3hJHGpg/KIUQl4FZ3mZeT1PGvyqFpbB0glvEpibaq7JnYl8e051GhAEJ4kX9vtXc5E/x4
 PoxbKgz0wSD8XLDamlD4qxvn+8FZoqXedsIgT6r+inhzJKHtgZgqF6dmHiYWvTjPXAEMhS0j03D
 ZKtvyP+7JnNGapHyZ/tB5OvIWykDPNJb27ihvtsuO5+Kwy9y7vlxdh9VJuT7mIMsil5AOge8Iup
 0n2eYAu6DjfVcHcSd5QfvSeFgDr4gvUXUr/8khNYSuucSf17uU0N4K2NvTNqMLrBXCkJossEqIx
 T6KKoO7irTgtGeCziaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NiBTYWx0ZWRfX2nZ2/9iYodGn
 bLQg9RKzE3RzxK4u+SSheBdR6yj/gWKCj8TLQzgryQvU9N4lKpD+iG+EwWKUezwqqLGZgs4DAiH
 Rycj61ufryCyOCHaPkIOgb4P8HUICOQ=
X-Proofpoint-ORIG-GUID: DtN2SPLTVmXoYr820ZVumKR_kbVdpSEm
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aecf8d3 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Hj0ah+TxS5FywmoD0uLh0Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=2Kw845l3AHk4TKGYuZwA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: DtN2SPLTVmXoYr820ZVumKR_kbVdpSEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050086
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
> From hw PoV, it's all part of the GPU.  But from dt perspective it is
> it's own device with a separate io space.  So we need to detect this and
> direct writes to the correct place.
> 
> Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index a29f8149493c..59898b49a201 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -373,6 +373,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
>  	const struct a6xx_info *info = adreno_gpu->info->a6xx;
>  	const struct adreno_reglist_pipe *regs = info->nonctxt_reglist;
>  	unsigned int pipe_id, i;
> @@ -392,7 +393,11 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
>  			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
>  				*gmem_protect = regs[i].value;
>  
> -			gpu_write(gpu, regs[i].offset, regs[i].value);
> +			if ((regs[i].offset << 2) >= gmu->mmio_offset) {
> +				gmu_write(gmu, regs[i].offset, regs[i].value);
> +			} else {
> +				gpu_write(gpu, regs[i].offset, regs[i].value);
> +			}

Any thoughts on a common IO accessor that can handle both gpu and gmu registers?

We had issues in the past where GMU offset was used with gpu_write(). We can avoid
those confusions with a unified routine for both GPU and GMU registers.

Anyway, for this patch:

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

>  		}
>  
>  		a8xx_aperture_release(gpu, flags);

