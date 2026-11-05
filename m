Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F5606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ksW5kuTU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SA5WMea7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1781910E382;
	Thu,  5 Nov 2026 21:58:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3C010E3AB
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:58:14 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L6ZDW2555663
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 21:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 la31nE+r5Wjkc5I+4kvYjaUy2Ab5etDtNmr/mKr9EWo=; b=ksW5kuTUtdme20pL
 Q4rm5o9B+T3Gq9tLowI20h6thiSKw2uAPDiIHNDyyn/+/KCYtuwj3cVZo0e91rxN
 KVAB57ma03rSDSU8RrA1muxaelrZFB69qP5riUKkNkzk5+IieBhxvq1BT7Hi96br
 jThd0cNAXIYbASnaEI+txk9Dy4PyZJp/l23J0uBIZxXK7dUghgyFsc9+4+MQCXKr
 w/9t6SKIDOA/yalWiWOj8U2mWEEmdgEwXusjYFo2sQqY2KskO12THKv/MXV+AUSK
 KWgXItncDQOH0l7xfcqQNcbSLAJZ22ALKvBimumAeWkzNmPj7w11Er9nrJoOU5Zf
 bKuAGA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq9fb549-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 21:58:13 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b20a4b5f2bso64353c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 13:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793915893; x=1794520693;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=la31nE+r5Wjkc5I+4kvYjaUy2Ab5etDtNmr/mKr9EWo=;
 b=SA5WMea7VGMZQ7QGC5fBfrIh0zIuc+qnSBfxqwRLT1dnzHM7EYtVUhjdNBwulPO2i1
 sYkTUMnDkz/H9WHDjZsMDOgVlWX0XWymlhvCnosUG9fbb79Kc/BOjs+zeq5QEl4+fhBW
 ibhFIwxV9hRw4rszD9gbb2KxBGuDhGyPkVNiOSOnhTvInjEgmt3LNuV+3MIFnEpaPBrB
 O8JY6LA7W4njqjtOXpbz08I6Nh4lIbrDeLeUWIimuL+PF9WMqvvBc2oHskJXdgOaX6Nd
 T/e6SWEbgxvv7gRrNyUmLdoSJ7GyAwYeGGy5hm3CytAxq/Qbvu5Xt9uPU1HXURSrOWjC
 rAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793915893; x=1794520693;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=la31nE+r5Wjkc5I+4kvYjaUy2Ab5etDtNmr/mKr9EWo=;
 b=DYF+Evg4P7Q+q2aObjWYedLmn4xlcnM9JFkKvm5yOpt9Dz2bS6WlaQtyagDOYqj/Tr
 pU7/ygo/foLxs3v8pK/AIX/Ebbp8q2BrjycwKSv/KGVGjC4HjQqAiiC9HjSmiGoLF3gv
 4zec/Xc0HLO0wBkPtUhJeIGpNuNxu0+lCaouf0fSbeq3t5Gje9ABXkZUGQon/F6AhnbM
 9L43SzhnITSJQ6sAjy2Ufe/dA7G6bRhtXZwceT8Kyu1l/HB7/iOU/8sS6JjDZRZfJnqR
 O7tkF2ra0XL7hoGi0RdeKpvlJFDKjJY2HzTy9uDRE9rmkEB7cLN3bvmp1LMmJB3hHQ4y
 Q82Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBya+SOC5hsTjXppIl0cF279XvrPv28YiWPMSlDyjdtxSjqg0Rc5Ved1SyHsNny302XKOUjL30GDlcw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8+wrSII0XKF8dk5C4N8MUo9oBtTM7lTHm8VaQ0lp8lmDwr0jYf
 g9ylSpz0bLjMDJ73OBDUK0scexUj+FtUePnGLKd+fyobm+eOhsDmyg7IbXbmItkAJyngqQhPefV
 0ocp5POAKm7PJs+gIdlJ1S0+CdxL4KAGXcXxRvFAvDlcsn4jOlRs/4GxByR5YptJsqTzGq3Q=
X-Gm-Gg: AYBFou0BByMPTAbdGr2LhqBgvsrnYqrLkrqkG7lGcXgBs0r+B0kGk2ZGbSFKktWBmZT
 9GZHDcuEswIndWMJvONRmuUmbEMbSg+ItTr9noO0ZrDStLKVi4iF+u8RumnEoPmpc9BHYUyos+q
 2/I1ZHkBmNt4toJekS5weSq7KRimFJy9iE1mtZohui7K4ibpL53pCrIAyZXEk0hIhZS2aDRLw45
 xZ6RvbSbYyOxRYV70xt4IwF5/ENc0JYKWwDjkq4sMsrqof0qaJk2SpynYwFz+KfNNzeL1h37Uey
 5j3d6cfDXv26L8PzejeXLKx+gxVsH2EUdQpF70PbFv4+vIB51LZlEnL5VRJHO9vKUculGxxOGyv
 cbtb9I8oy4S8yVCBMxLkY5R46mXvIgXdoZveWohRpCUqFF/o5ucP9dUGG9tLYXy9nTBHNsm8=
X-Received: by 2002:a05:701b:4281:20b0:165:90af:a25f with SMTP id
 a92af1059eb24-1b25d36e618mr419917c88.41.1793915892370; 
 Thu, 05 Nov 2026 13:58:12 -0800 (PST)
X-Received: by 2002:a05:701b:4281:20b0:165:90af:a25f with SMTP id
 a92af1059eb24-1b25d36e618mr419857c88.41.1793915891501; 
 Thu, 05 Nov 2026 13:58:11 -0800 (PST)
Received: from [192.168.1.9] ([106.222.231.155])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245b8822fsm23076429c88.2.2026.11.05.13.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 13:58:11 -0800 (PST)
Message-ID: <0d7cf70f-cc16-4d9f-a53c-7f2f9e3e509d@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 03:28:04 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/15] drm/msm/a8xx: Stop getting GMEM_PROTECT from
 nonctx list
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
 <20261105203057.66520-8-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261105203057.66520-8-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NyBTYWx0ZWRfX97kDh+TXngOa
 h/+HgWQPbx3p0vVBCIjJAh4UtMMYD8VF4QIpr2tR0XkyW5uWBQ19THsMpGD2mb8u3F/jLd03stl
 /G29L0dC1dBIXTL7mhTSFXePB5Q2JcHRdvvP52vZeBjHSVWlHl9P0k/rCtfA3z2Qgd2fbrDECQo
 +zmGjAQbL0PLCLh+Ecs8lTVIJFpVZiE4ITkkLZZC2KQZ/BNZOmHjVfDWSqqT+pBQjoNsfSTLmm+
 yMHLLCErFarCX6nNVPhTsf+G2el0Yq+o8bdrHW4FHWQoKivY6JRbkMcE55EPPQdBs1lV9j5YWDc
 iqTgI0z0H0n17NaviPdPqevxlBF6LLzqBNQaj7f7kdH0Zr7As8gfGvYmglJC3lP+57QLd2gAhNg
 rF7SULO43u6ZPL06dLMVsb0E6DpjIri+YDpl+Z2iLLYTndL9CWJqEeTN2AaEWMX9RNLcyZIFLMG
 Nn5LvXKsJ5aeAAZ1HVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NyBTYWx0ZWRfX8XQWeZJ+RmRS
 dYDWTnUfOMco+b5T8k7p87+4dliPr1QCpkGH+5xfbH+x06/KGaSDRvi/LNZLUBRzazJ6oEBifuZ
 FZWO7v0Ikaiofb7PCwCpux5AZ4jKvaE=
X-Authority-Analysis: v=2.4 cv=Vdhir1p9 c=1 sm=1 tr=0 ts=6aecfbf5 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Hj0ah+TxS5FywmoD0uLh0Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=QD3LnjK7qLuM3IoIZgoA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: zdjvHw2uMDaF7YRis0DfdefngByaUv42
X-Proofpoint-GUID: zdjvHw2uMDaF7YRis0DfdefngByaUv42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050087
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
> We can just simplify things and calculate the value, instead of manually
> adding it to the nonctx list.
> 
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a8xx_catalog.c |  6 ------
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 12 ++++--------
>  2 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> index dd1a5ca91812..6c5ee227243a 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> @@ -27,7 +27,6 @@ static const struct adreno_reglist_pipe a830_nonctxt_regs[] = {
>  	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
>  	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
>  	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
> -	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x0c000000, BIT(PIPE_BR) },
>  	/* Configure number of outstanding transactions to 32 */
>  	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
>  	/* Configure UCHE request time out to 16 cycles for CCU/UCHE arbitration */
> @@ -309,7 +308,6 @@ static const struct adreno_reglist_pipe x285_nonctxt_regs[] = {
>  	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BV) | BIT(PIPE_BR) },
>  	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00500000, BIT(PIPE_BV) | BIT(PIPE_BR) },
>  	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
> -	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x15000000, BIT(PIPE_BR) },
>  	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
>  	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
>  	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
> @@ -483,7 +481,6 @@ static const struct adreno_reglist_pipe a810_nonctxt_regs[] = {
>  	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BV) | BIT(PIPE_BR) },
>  	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00100020, BIT(PIPE_BV) | BIT(PIPE_BR) },
>  	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
> -	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x00900000, BIT(PIPE_BR) },
>  	{ },
>  };
>  
> @@ -709,7 +706,6 @@ static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
>  	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
>  	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
>  	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
> -	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x12000000, BIT(PIPE_BR) },
>  	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
>  	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
>  	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
> @@ -1102,7 +1098,6 @@ static const struct adreno_reglist_pipe a845_nonctxt_regs[] = {
>  	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
>  	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, BIT(10) | BIT(9), BIT(PIPE_BR) },
>  	{ REG_A6XX_RB_DBG_ECO_CNTL, BIT(17), BIT(PIPE_BV) | BIT(PIPE_BR) },
> -	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x0C000000, BIT(PIPE_BR) },
>  	{ REG_A6XX_RB_RBP_CNTL, BIT(5) | BIT(6), BIT(PIPE_BV) | BIT(PIPE_BR) },
>  	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
>  	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
> @@ -1161,7 +1156,6 @@ static const struct adreno_reglist_pipe a850_nonctxt_regs[] = {
>  	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
>  	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, BIT(10) | BIT(9), BIT(PIPE_BR) },
>  	{ REG_A6XX_RB_DBG_ECO_CNTL, BIT(17), BIT(PIPE_BV) | BIT(PIPE_BR) },
> -	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x12000000, BIT(PIPE_BR) },
>  	{ REG_A6XX_RB_RBP_CNTL, BIT(5) | BIT(6), BIT(PIPE_BV) | BIT(PIPE_BR) },
>  	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
>  	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 59898b49a201..f65bf82e5c21 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -370,7 +370,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  		  hbb_lo << 1 | ubwc_mode);
>  }
>  
> -static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
> +static void a8xx_nonctxt_config(struct msm_gpu *gpu)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>  	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
> @@ -390,9 +390,6 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
>  			if (!(BIT(pipe_id) & regs[i].pipe))
>  				continue;
>  
> -			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
> -				*gmem_protect = regs[i].value;
> -
>  			if ((regs[i].offset << 2) >= gmu->mmio_offset) {
>  				gmu_write(gmu, regs[i].offset, regs[i].value);
>  			} else {
> @@ -638,7 +635,6 @@ static int hw_init(struct msm_gpu *gpu)
>  	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>  	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>  	unsigned int pipe_id, i;
> -	u32 gmem_protect = 0;
>  	u64 gmem_range_min;
>  	int ret;
>  
> @@ -719,7 +715,7 @@ static int hw_init(struct msm_gpu *gpu)
>  
>  	gpu_write(gpu, REG_A8XX_UCHE_CLIENT_PF, BIT(7) | 0x1);
>  
> -	a8xx_nonctxt_config(gpu, &gmem_protect);
> +	a8xx_nonctxt_config(gpu);
>  
>  	/* Enable fault detection */
>  	gpu_write(gpu, REG_A8XX_RBBM_INTERFACE_HANG_INT_CNTL, BIT(30) | 0xcfffff);
> @@ -838,8 +834,8 @@ static int hw_init(struct msm_gpu *gpu)
>  	 * GMEM_PROTECT register should be programmed after GPU is transitioned to
>  	 * non-secure mode
>  	 */
> -	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_RB_GC_GMEM_PROTECT, gmem_protect);
> -	WARN_ON(!gmem_protect);
> +	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_RB_GC_GMEM_PROTECT,
> +		        (adreno_gpu->info->gmem / SZ_4K) << 16);
>  	a8xx_aperture_clear(gpu);
>  
>  	if (!a6xx_gpu->pwrup_reglist_emitted) {

