Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19409606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ha5mzg1B;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ONaRlNxr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6435B10E425;
	Thu, 26 Nov 2026 19:34:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDADA10E9A0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:33:58 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQFuIbC2068824
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xPxcQjB0LjvGxiHNauOfLhUJyAYPTtfw6Qd8NpV6aF4=; b=Ha5mzg1BMDFdCR83
 FfE1aMau069UC+HyWZvb3ZSf+j5WT53Nm2UXyI33LuZFY6KEp4xV/QcoX0ORuF8J
 OrkSclq4C3wDJVUtPxHFnCO611yX8EU1X/4yeJUjDJ3Mp32IeI7W3v9obAg9q0hg
 UsaZOvgLgekcY1uJytp/nJ3cKLQZBgj4Fw9IoIxf8dSWe79AHyggQldGeS/4Utr7
 7OvBBep0YJ76bAWPVrVdt6NOEXSiyYb6m0Mow7CgMrRp1TMyFCBwHytf31aC2pcO
 34ZnvQNvNIVD3RCeliSdiaFaRWRyTuTWdkwCMqlbKYSjWncDOwbfdByVcDLKaz3Z
 2300uw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y4btm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:33:58 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b25d977b91so7797061c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795721638; x=1796326438;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xPxcQjB0LjvGxiHNauOfLhUJyAYPTtfw6Qd8NpV6aF4=;
 b=ONaRlNxrZEh07goqEimfbMqbpdKXdb6HIq+FiOHz+TmfSwREl/oxZiF51Fz1iSX2Zd
 RtzfhiiuPJOqgOJbtK5K04iedLm554uwhe1CsooxOsv2dd6kfauOhGiF2UkmO6znmspg
 0OUSdzL+Y0+98zplqh0qpS4KQso44Murc8mENf8p5P5k9lgvCin5iVJpsb4McnrpkS6M
 uprG0/66tIjCLb+v0ki1NnUc2mL9eid4mrrUYxQ1h8wf0gFShlkNDweEhmWCfGwDsP8b
 nuxQ1BrbmETpbmOE0BuK6aDiY0SFmIq/7EgbfHbch0eEyQl6o4cbMXTn2r97IuMAwKRI
 q7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795721638; x=1796326438;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xPxcQjB0LjvGxiHNauOfLhUJyAYPTtfw6Qd8NpV6aF4=;
 b=cdrdShBPv1+tdUNKTQD1C9/hG1tyuEMXltZ6pNHX47+fSFQpsym4CBW8B6RpW9dIi8
 +rTqTLm1JB7nFE1oPlF6sM5xUwV1WXfYzvMZTBjWi3rfW3JIRe4RNztbWB8SzEsraTmR
 sMC4k3ZFSvJ69QoZuJqA4PUElvo5cb6V0nOPCID7v1cbXKU+0mIKBgTGDJEFopvB0slA
 aHEDnB7aGoA6Z8OLDD0x1xMY6///FNVbUb2o5hsbYlKPKETzpbRQ/KqIlROsEPdBjE0u
 kUsI3dTXoRouh7RGHFLbSy2eXjgsGv9x9ZqRrokPPTZqe4G8rQ0BLMqcVLD7j/QEe46g
 5xQg==
X-Forwarded-Encrypted: i=1;
 AL+hErHnAv10eIyKqFMCgP2lHHvRPeQNbefkXEu6p32set1ZpBBalTT4Ew3nJoWqixyKUJmEjRz/SDvwhxg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8GddwaR79sK2oM2VIcC+rwQgnCNgVCW8LMYCmaIlvHtT5mrp6N
 TuMA+From+/8Fvq3FweC+4MMdknws+yVEAYwEYAJ81Mbwv13Lwc3tfEi5zYA3aItThp1qmUoAj1
 dg4CVQtXxw0Iv1y9Oko8eFppf0RbqH7YOhnv0BtAbiDD2vb3vlhb/K64xRMu+yw1hwymjM1w=
X-Gm-Gg: AZFdTZegojB1Ooy1uNDAn3ww9sdMA03JRzHStj/MvCz2uTa6DlN/akxJbHPT8o2dIPL
 0fS6BQIkJo4St4AoBIf13vcH8z/sppFsK+O+0HpohhBM5WVLYhx/My3XgE60piRLfOwFfjoUWws
 tDnMGJG0U9xjEH5zygIbfDPjJfv6EkFPVCkQvL2ppuBSCN0MzXj0g/0ImZTKABHTsHPhN4HpkNU
 BVngeoH4KOIfvBgLy6Ao6UBFOvcXM6RNqRzfBmNGW2xZI6uXaFNG1tQutjy4hb+cfx9rvwFvtNJ
 k59xPgmrhj6H+BT8299G0t5T+XEL2bHRAnXG8zwweiMGovplZSgauRSVlcmzmycRvVXIIR81Cnd
 a3BcI9L62AC6anUueEU+xG19G5m6frY4Ztb6Vx18FBixiB6UmiQppiSLV4PzyM/cuVH/oEEyBLw
 ==
X-Received: by 2002:a05:7023:e41:10b0:1b5:43f6:74ee with SMTP id
 a92af1059eb24-1b5567c1250mr19538088c88.1.1795721637490; 
 Thu, 26 Nov 2026 11:33:57 -0800 (PST)
X-Received: by 2002:a05:7023:e41:10b0:1b5:43f6:74ee with SMTP id
 a92af1059eb24-1b5567c1250mr19538064c88.1.1795721636955; 
 Thu, 26 Nov 2026 11:33:56 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm42214241c88.4.2026.11.26.11.33.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 11:33:56 -0800 (PST)
Message-ID: <4fe3eef4-d5d6-44a0-a7fa-4e9192f536a8@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 01:03:51 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 7/8] drm/msm/a6xx: Add IFPC tables for Adreno 650
 family
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
 <20261030-topic-a6xx_ifpc-v1-7-6992841a9a32@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-7-6992841a9a32@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NiBTYWx0ZWRfX+qH1met5NPVV
 5mjrXdSu0S/pakqsb6rlAcKwkm2argpWDLdxlUXB+oJPhCyeGbNR/AriQJ+Qwazkm88NuSLVd8K
 WSyKweqA1Y944snr0PEgaZob1vRQ1ma4DATZLBg4pJtwq1RuWjhjC9VKePnpNNb+Ye4DIV/DAhY
 4ykr6G7A+g1S734nGcogdOhYd9fBeiAYsKp3Zj/41/9frNFlWOIKXSGOUonITGl7qRnOn++wt2A
 bMvdIzeT3xq3HBgocURrHOQWJ9LJ0XxA8X5dqasRxfEbweeu+9b7v6sSvlPOAqmLiIAGuVllBWt
 2PJxsSp0bI5mGhpBjQy0a28coq6ROYZ5lJlREQXs28GYLBbE7zOOaApHHXeAUMwKFg5DFncibCB
 OxHOe52EJQ9l/nzBdV9QeAYRazTFvLiw9vXFhuupCYpd4oFymZJas9CqTejo6vs360MLGi56/4h
 rzabM1awIpr3pZ2SuFQ==
X-Proofpoint-GUID: mgy4Pr7gcEsRTng5LOW-MiE8nCsjSloF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NiBTYWx0ZWRfX7K6RyfqGYPVI
 OCCKTUAVp/I3JsVGg+aDJdW7D/zSM+s9ZLSVQPpTHf3N5fbMCFLhiQBVfWmJXBVHkxVYbu7Zxqw
 uFGRed8vf73tARU3j2ABkfvWtL+GGTQ=
X-Proofpoint-ORIG-GUID: mgy4Pr7gcEsRTng5LOW-MiE8nCsjSloF
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b0889a6 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pSBQ5sDCE5yABuHJYC4A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
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
> Fill out the register tables to enable IFPC on these SKUs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 122 +++++++++++++++++++++++++++++-
>  1 file changed, 118 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 89829fa8f4f4..2d59f7735c90 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -851,6 +851,108 @@ static const u32 a640_pwrup_reglist_regs[] = {
>  
>  DECLARE_ADRENO_REGLIST_LIST(a640_pwrup_reglist);
>  
> +/* A650-family IFPC state also includes CP_PROTECT registers 32-47. */
> +static const u32 a650_ifpc_reglist_regs[] = {
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
> +	REG_A6XX_CP_PROTECT(32),
> +	REG_A6XX_CP_PROTECT(33),
> +	REG_A6XX_CP_PROTECT(34),
> +	REG_A6XX_CP_PROTECT(35),
> +	REG_A6XX_CP_PROTECT(36),
> +	REG_A6XX_CP_PROTECT(37),
> +	REG_A6XX_CP_PROTECT(38),
> +	REG_A6XX_CP_PROTECT(39),
> +	REG_A6XX_CP_PROTECT(40),
> +	REG_A6XX_CP_PROTECT(41),
> +	REG_A6XX_CP_PROTECT(42),
> +	REG_A6XX_CP_PROTECT(43),
> +	REG_A6XX_CP_PROTECT(44),
> +	REG_A6XX_CP_PROTECT(45),
> +	REG_A6XX_CP_PROTECT(46),
> +	REG_A6XX_CP_PROTECT(47),
> +};
> +
> +DECLARE_ADRENO_REGLIST_LIST(a650_ifpc_reglist);
> +
> +/* A650-family restore state adds bicubic weights and UCHE_CMDQ_CONFIG. */
> +static const u32 a650_pwrup_reglist_regs[] = {
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
> +	REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL,
> +	REG_A6XX_RBBM_PERFCTR_CNTL,
> +	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(0),
> +	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(1),
> +	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(2),
> +	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(3),
> +	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(4),
> +	REG_A6XX_UCHE_CMDQ_CONFIG,
> +};
> +
> +DECLARE_ADRENO_REGLIST_LIST(a650_pwrup_reglist);
> +
>  static const struct adreno_info a6xx_gpus[] = {
>  	{
>  		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
> @@ -1068,7 +1170,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		.gmem = SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			  ADRENO_QUIRK_HAS_HW_APRIV,
> +			  ADRENO_QUIRK_HAS_HW_APRIV |
> +			  ADRENO_QUIRK_IFPC,
>  		.funcs = &a6xx_gpu_funcs,
>  		.zapfw = "a620_zap.mbn",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1077,6 +1180,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.gbif_cx = a640_gbif,
>  			.gmu_cgc_mode = 0x00020200,
>  			.prim_fifo_threshold = 0x00010000,
> +			.ifpc_reglist = &a650_ifpc_reglist,
> +			.pwrup_reglist = &a650_pwrup_reglist,
>  		},
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0, 0 },
> @@ -1180,7 +1285,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		.gmem = SZ_1M + SZ_128K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			ADRENO_QUIRK_HAS_HW_APRIV,
> +			  ADRENO_QUIRK_HAS_HW_APRIV |
> +			  ADRENO_QUIRK_IFPC,
>  		.funcs = &a6xx_gpu_funcs,
>  		.zapfw = "a650_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1189,6 +1295,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.gbif_cx = a640_gbif,
>  			.gmu_cgc_mode = 0x00020202,
>  			.prim_fifo_threshold = 0x00300200,
> +			.ifpc_reglist = &a650_ifpc_reglist,
> +			.pwrup_reglist = &a650_pwrup_reglist,
>  		},
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0, 0 },
> @@ -1207,7 +1315,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		.gmem = SZ_1M + SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			ADRENO_QUIRK_HAS_HW_APRIV,
> +			  ADRENO_QUIRK_HAS_HW_APRIV |
> +			  ADRENO_QUIRK_IFPC,
>  		.funcs = &a6xx_gpu_funcs,
>  		.zapfw = "a660_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1216,6 +1325,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.gbif_cx = a640_gbif,
>  			.gmu_cgc_mode = 0x00020000,
>  			.prim_fifo_threshold = 0x00300200,
> +			.ifpc_reglist = &a650_ifpc_reglist,
> +			.pwrup_reglist = &a650_pwrup_reglist,
>  		},
>  	}, {
>  		.chip_ids = ADRENO_CHIP_IDS(0x06060300),
> @@ -1227,7 +1338,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  		.gmem = SZ_1M + SZ_512K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> -			ADRENO_QUIRK_HAS_HW_APRIV,
> +			  ADRENO_QUIRK_HAS_HW_APRIV |
> +			  ADRENO_QUIRK_IFPC,
>  		.funcs = &a6xx_gpu_funcs,
>  		.a6xx = &(const struct a6xx_info) {
>  			.hwcg = a690_hwcg,
> @@ -1235,6 +1347,8 @@ static const struct adreno_info a6xx_gpus[] = {
>  			.gbif_cx = a640_gbif,
>  			.gmu_cgc_mode = 0x00020200,
>  			.prim_fifo_threshold = 0x00300200,
> +			.ifpc_reglist = &a650_ifpc_reglist,
> +			.pwrup_reglist = &a650_pwrup_reglist,
>  		},
>  		.speedbins = ADRENO_SPEEDBINS(
>  			{ 0,   0 },
> 

