Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7365606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JdIkNUPJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=htrkqgQH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5094D10EA1D;
	Thu, 26 Nov 2026 19:24:44 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3508810E291
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:24:33 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQFuNWx3750286
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RHIdko6UqJLukIVhvr7EZRmIk/JiLrr5A6iBSZS9uqQ=; b=JdIkNUPJc+iv9cFZ
 LtTLbvg1WYIP0DrSyMCectpLuAyUYLTXnn6cZxnVrR1S+ie31X3AcA4Eefkalu94
 2CDNNQa0YhK+hOiGagJGVGMW8Z1b+vk3GcjPKHjm1Ydd3exeG/rk3MHU2/T1ve1l
 iKwS1YSpwfy754mstchdOHHXR+jOH2UhGv4lHjKnuVKfhOZ8jytD7D56Rf0FOWkm
 pne0fwccSdpAPSkSoyeJFwPGkEkAhHDOJLFuuIUSlyCpvFpb9gbbmZ5BJQk9dkHM
 kKhgDm09jA0ooJga0yvrthCUIy4AVDygZbiVNA0B3kHuvPw/xE4/9Cmz+jjnCiyL
 UBB/WQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662scdjt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:24:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so3122517c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795721072; x=1796325872;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RHIdko6UqJLukIVhvr7EZRmIk/JiLrr5A6iBSZS9uqQ=;
 b=htrkqgQH0Wn0N8IhACOAbLfkLABEkdM2YdeAdv+Tdm9ewPNOX2b34VNj8FW7fjerGc
 695zYFCwp5y4EQzyhpcgcQkC+VZ8dAAxfxGD5dWabkFlZ4An61pXQupaNeF+ArusNcms
 bYy4cbRK01+ngnPNMryKxyviVMxMLj/IFQEV+2QLFlMNq/hY5USyZhwE5xFHGdCiFhXN
 8ocNAT4twD3ADoQKZOJlEH0ejBGXLsIHIQuy0yODXSyAyfa4a2+hihFrZNy96EH8bbjR
 C4EoVR+N+JQRPdB7GLX/FqCK19A2o35VUQpA+xVQRYY9mEtHizZ4f+Rq7VeWH29UAZxk
 7hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795721072; x=1796325872;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RHIdko6UqJLukIVhvr7EZRmIk/JiLrr5A6iBSZS9uqQ=;
 b=WXI5KfZAH6AxaqBz9mBJB49yjNqKMZC5jVq3LkZK/WqQJ5gwPpD2U49cBNYLvOdGVh
 l7wHGERAJTZ3evWAuuxE0v989NtWloxKeZ7KNtUDFaqkadqGDjzGX8IaWQJUel/ZCqG6
 NX5mSlqHYg21qwv2fr1W5NXRZdJnjeG0b8meDk7IrLpsl8ap7OrqAvm1/2mQHuQBrzIx
 ysBt3P1nxqrHhbUMa65kQCdUWkz7ZcJefkNVulB/rbytEeUZO0zD81hDDRRV966e6SJ4
 sI/zFL3N1o9gkhE3xklcfe1KDk4sB7VCa9d8cUlzrMa97o0WSPV1ACPFE0n08P2Tgyna
 slLw==
X-Forwarded-Encrypted: i=1;
 AL+hErHO3uYSX/In41YQEW01XmSqUFITWVwdvfl29gMA5C/GZej53jsLV5AwMk4SPmNFjI37N5cBldN/X2M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+T50pFzWRwDsGAG5IaU6w6DpLPSwmZf+Nf4lLIjJUyf/UEq5Yh
 jBbRooJBoQKM7f0imTfvYdYMs6tQQ0CbPfBv1ON3HOOOrRCqWQli1srl5p5CMgahGNFrIq/Cgxs
 i8JrEMF61TDBmxQQCp0GSr+5jnuQ3H1RyUAH3j7twua2qHZhClC7GWPP16jnEt63cdeUWvU8=
X-Gm-Gg: AZFdTZfD4d7BPd8U6xp8ILaBA0I8Wnh0bN6ry/xFHBBIYBMtDx7CpRCULmGbmKPRtFG
 XsyTmht4iBGJ9yXkdN7GciTotDhF5GIYqiwZGDWMlIPFGMtI971fddmlCVrfRxcwxqdOZFlv9S4
 CwWwYyh5mLpfNrTW8QjiGhuq9oTGMrTt+s7BunWtDavXRl76cvS7yWRFeJjZb7PbKHXRf3eP4cm
 9a2El9Si/7sEzFsiubU+DiymnEdS8AA4qI7DDj6hjn1cmjT4bdjru6A0+gv5rpB3LfT6seCQgtY
 ltBauqO+J289/CKWrBWpQmQu5PuXhvlhDUfE32ccfXqonHsj9g7qWAqxXr0gDBCQPX1WNyLq2Em
 ZALRiufSReLJZramWeDs6/poPa9V/Of9WNFOKkhCOwGvNpX9ZVKtqrpqAIHjTtbMx1iMhcv8g0Q
 ==
X-Received: by 2002:a05:7022:92a:b0:143:26eb:18e9 with SMTP id
 a92af1059eb24-1b5568eb4dfmr30545708c88.28.1795721072018; 
 Thu, 26 Nov 2026 11:24:32 -0800 (PST)
X-Received: by 2002:a05:7022:92a:b0:143:26eb:18e9 with SMTP id
 a92af1059eb24-1b5568eb4dfmr30545670c88.28.1795721071532; 
 Thu, 26 Nov 2026 11:24:31 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55684c85fsm77073667c88.14.2026.11.26.11.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 11:24:31 -0800 (PST)
Message-ID: <59e69b2a-2780-49fd-93a2-e4107bbb64aa@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:54:26 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/msm/a6xx: Add IFPC tables for Adreno 630
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
 <20261030-topic-a6xx_ifpc-v1-5-6992841a9a32@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-5-6992841a9a32@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b088770 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=GaZQqOmmu1Wz2YppMPkA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: NaWQVr9GG7l7E3FHo9OyCg9XFg1GSbWx
X-Proofpoint-ORIG-GUID: NaWQVr9GG7l7E3FHo9OyCg9XFg1GSbWx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NiBTYWx0ZWRfX6zMG0to4zUXa
 frVfNhxqkCICwFdI3+FegEXTHG2EUmxFopeBnvnpfEeU8Fn3ST7MX5ZElKv3elozo4y1TRs0tOU
 jSdxYJrTKXoFJGZYMc3TALoDoljMUD0CY3klam+P2a6d9HL48Y2uBoTP9FRyh9I76bs4IxM0Vt5
 qbqoFJQ8VXBDlzaagglPx6wuIlHA8cCrGdWan+daT5QtS1HCcq8lK3SBcWe/PATqRHeoFs6uTCE
 rNDOyvDiEvi1mn7+cOGDROGAetnZ/yHEFb0492ApTrrTk+AVySbPuhcHrFY7mJUG/mWMMFkeUP0
 d9GzBFISoF65R8Naz+W4/BZ3QDrhM+yZtz5f/NB1zvkOwzxQLlY9OdNZymrFt7Qfz4U69Imf7ub
 wZVOQFQx9UP+IAJ+XUp+dqQE8PRIdBQa+CQ32m7Hti13E2YqW3rDfrdFpnbYPyVBWpabjjzTdHM
 EJ3LXIzVAEWwjrSddgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NiBTYWx0ZWRfX1LQcAWaOdzbM
 LNNPOj6KGYyQJMnR2LrOr/MoksumGhrrrQcYCo1qyhUhZISaMbXRpU/T2Di4pxIDo33ENzNRwha
 7QiE8Yv5uUc9LbyszGkYll17hbzDtyI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260076
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
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/2026 3:34 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Fill out the register tables to enable IFPC on this SKU.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 83 ++++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 4ef2bd6e7ad2..5e1d91a73a4e 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -736,6 +736,84 @@ static const struct adreno_reglist a702_hwcg[] = {
>  	{}
>  };
>  
> +static const u32 a630_ifpc_reglist_regs[] = {
> +	REG_A6XX_CP_CHICKEN_DBG,
> +	REG_A6XX_CP_DBG_ECO_CNTL,
> +	REG_A6XX_CP_PROTECT_CNTL,
> +	REG_A6XX_CP_PROTECT(0),
> +	REG_A6XX_CP_PROTECT(1),
> +	REG_A6XX_CP_PROTECT(2),
> +	REG_A6XX_CP_PROTECT(3),
> +	REG_A6XX_CP_PROTECT(4),
> +	REG_A6XX_CP_PROTECT(5),
> +	REG_A6XX_CP_PROTECT(6),
> +	REG_A6XX_CP_PROTECT(7),
> +	REG_A6XX_CP_PROTECT(8),
> +	REG_A6XX_CP_PROTECT(9),
> +	REG_A6XX_CP_PROTECT(10),
> +	REG_A6XX_CP_PROTECT(11),
> +	REG_A6XX_CP_PROTECT(12),
> +	REG_A6XX_CP_PROTECT(13),
> +	REG_A6XX_CP_PROTECT(14),
> +	REG_A6XX_CP_PROTECT(15),
> +	REG_A6XX_CP_PROTECT(16),
> +	REG_A6XX_CP_PROTECT(17),
> +	REG_A6XX_CP_PROTECT(18),
> +	REG_A6XX_CP_PROTECT(19),
> +	REG_A6XX_CP_PROTECT(20),
> +	REG_A6XX_CP_PROTECT(21),
> +	REG_A6XX_CP_PROTECT(22),
> +	REG_A6XX_CP_PROTECT(23),
> +	REG_A6XX_CP_PROTECT(24),
> +	REG_A6XX_CP_PROTECT(25),
> +	REG_A6XX_CP_PROTECT(26),
> +	REG_A6XX_CP_PROTECT(27),
> +	REG_A6XX_CP_PROTECT(28),
> +	REG_A6XX_CP_PROTECT(29),
> +	REG_A6XX_CP_PROTECT(30),
> +	REG_A6XX_CP_PROTECT(31),
> +	REG_A6XX_CP_AHB_CNTL,
> +};
> +
> +DECLARE_ADRENO_REGLIST_LIST(a630_ifpc_reglist);
> +
> +static const u32 a630_pwrup_reglist_regs[] = {
> +	REG_A6XX_VSC_ADDR_MODE_CNTL,
> +	REG_A6XX_GRAS_ADDR_MODE_CNTL,
> +	REG_A6XX_RB_ADDR_MODE_CNTL,
> +	REG_A6XX_PC_ADDR_MODE_CNTL,
> +	REG_A6XX_HLSQ_ADDR_MODE_CNTL,
> +	REG_A6XX_VFD_ADDR_MODE_CNTL,
> +	REG_A6XX_VPC_ADDR_MODE_CNTL,
> +	REG_A6XX_UCHE_ADDR_MODE_CNTL,
> +	REG_A6XX_SP_ADDR_MODE_CNTL,
> +	REG_A6XX_TPL1_ADDR_MODE_CNTL,
> +	REG_A6XX_UCHE_WRITE_RANGE_MAX,
> +	REG_A6XX_UCHE_WRITE_RANGE_MAX + 1,
> +	REG_A6XX_UCHE_TRAP_BASE,
> +	REG_A6XX_UCHE_TRAP_BASE + 1,
> +	REG_A6XX_UCHE_WRITE_THRU_BASE,
> +	REG_A6XX_UCHE_WRITE_THRU_BASE + 1,
> +	REG_A6XX_UCHE_GMEM_RANGE_MIN,
> +	REG_A6XX_UCHE_GMEM_RANGE_MIN + 1,
> +	REG_A6XX_UCHE_GMEM_RANGE_MAX,
> +	REG_A6XX_UCHE_GMEM_RANGE_MAX + 1,
> +	REG_A6XX_UCHE_FILTER_CNTL,
> +	REG_A6XX_UCHE_CACHE_WAYS,
> +	REG_A6XX_UCHE_MODE_CNTL,
> +	REG_A6XX_RB_NC_MODE_CNTL,
> +	REG_A6XX_TPL1_NC_MODE_CNTL,
> +	REG_A6XX_SP_NC_MODE_CNTL,
> +	REG_A6XX_PC_DBG_ECO_CNTL,
> +	REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE,
> +	REG_A6XX_UCHE_GBIF_GX_CONFIG,
> +	REG_A6XX_UCHE_CLIENT_PF,
> +	REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL,
> +	REG_A6XX_RBBM_PERFCTR_CNTL,
> +};
> +
> +DECLARE_ADRENO_REGLIST_LIST(a630_pwrup_reglist);
> +
>  static const struct adreno_info a6xx_gpus[] = {
>  	{
>  		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
> @@ -1014,7 +1092,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = SZ_1M,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_4GB_VA,
> +			  ADRENO_QUIRK_4GB_VA |
> +			  ADRENO_QUIRK_IFPC,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.funcs = &a6xx_gpu_funcs,
>  		.zapfw = "a630_zap.mdt",
> @@ -1023,6 +1102,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.protect = &a630_protect,
>  			.gmu_cgc_mode = 0x00020202,
>  			.prim_fifo_threshold = 0x00180000,
> +			.ifpc_reglist = &a630_ifpc_reglist,
> +			.pwrup_reglist = &a630_pwrup_reglist,
>  		},
>  	}, {
>  		.chip_ids = ADRENO_CHIP_IDS(0x06040001),
> 

