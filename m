Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBB606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mfbOFkqE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XWPB2Hiv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E4810E0D9;
	Wed, 21 Oct 2026 08:43:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779BA10E0D9
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:42:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L63gZm290748
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 egoCefaEWBE1zHp2Q49ZFDFGmYZgTt9yQigi8gi4k1k=; b=mfbOFkqEFPZKslLb
 0cI/K72Sm0bZ5x0mXtPHd1EPwDqDrUHWxRlnp3DGmrpFaI6NCTVJNxQd2RclIx2e
 fYkwvZLeykvYsqEaiE9mJpwJmKafBSLNm+Tt5F+zf+VrbfZUGSKAjlUMQBqcwd9B
 JO5nly5fFAm/VOmj82J74rI1eh8ZLuFX9zaeO9B3Fn13p//YBY0SGqlvveQlB015
 yG2hkPgBUqbMcxokXZcdEgiGYwsEITvddfMY7MqTXuKckoQlYg6FIVWxDkjfNpBS
 TJp+677JlM3a5qRKPdL/pJxEg6gFzlnKhxUWowKm9ysximAVj7uXoucjvtCme6b7
 TLL6vQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajk009-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:42:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cac495d99so9310285a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792572176; x=1793176976;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=egoCefaEWBE1zHp2Q49ZFDFGmYZgTt9yQigi8gi4k1k=;
 b=XWPB2HivaA6t1B7rzbr30WB0MOodj0bcENiEeqEdZr2OCGz4OqIsVcV3LXuSIXozNS
 Sj51U8UkJpqCI2GiqTNSraeoGZYEmp2Isz6t4anstcT4S6Rc7cmYzPnO5zWfTsVzxcHh
 cwFva73rmOvhhYeSHLxaE4vr7E4UuUCgbxoQGI2fv1Dj+IZ+Wb8Y/xLT9Yvcyx82N9xg
 BiNk6YrWM+YS5YnW6Y+OFkbY6av7SRNymNrme7Gf7DG+ifgfEqXpZlMbSE2gVECmy2H9
 BwnkT2YSy7lLuCvpAM8ZaU4tOxW3ujn2qBn7Z6Yxl9873aVPf651hBZutR8JiQiOD1FX
 xQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792572176; x=1793176976;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=egoCefaEWBE1zHp2Q49ZFDFGmYZgTt9yQigi8gi4k1k=;
 b=iHQgDtMLP/P0pgs5sbB3WHng5oJM/Bqi1Cyyo3ab1Uah8eRFZfQlCG1rvtBtuHAfDE
 L1JhRO7DMRzO28Yd/UISXIuV1jgEOnI/6OFkNcmwcIzz2OgA2AYTMgEMMMrHxOX349pV
 TYodJm2wg4nXjLpCImTe18uxLleavrD/58ur6rIoHHBT7DPNjLw9CIbk+myDknlJqrOE
 WR5q7AQo3WchIaKs5ZP+yxvLt+hTsZ7I5LjY8vkQvVtSk7Jdkkrfz1MSqELWCLPejBoU
 H4lvmxmAJX6JjRzee8c3eVVl2BuzR3hNea7ekMoe5wdohtBiaemtwbefMsaOv0X+BAnF
 TqaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgnO/R+JqL/AbpeLxocR1mGZ3KttKMonKf1suJXFtxIf+IiBzxhuj4oFd7EPF7Le24rakhER4Bms8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLpgE3YzrrkhdqRt3zlORSQHzpFG3Jwb+0Wirdt7tAYUWA9Tssl
 RZAL20/06rIsrnWE/jdM8vX59wXNQUBmMTMdF+CSDV2e+merU6C/U5NVmQ7mrYMwfuEu+qvFFK/
 CbyCPdmXtFiwAkR3qrIhwqUWbh593edSFaH+V7715ho8sisHyJqsAaWnx+PK+f+rPd1r9ODE=
X-Gm-Gg: AYBFou2N3Slkml8TxgNrcreORHPsreF/taGbNwFShASuR8ZLtEO8jnnP9WXXBInkYtN
 CsubYVYiQi646KfPB6IoYzQkatLaDDX1oZ4kSQ48XNCtqgysr2qFpVPTpGbIjOqSO/fk6g/0Npk
 HqKgSr79WCFRwSrXVouQI+BDQWJDv8o30bEUqG1d6EXNciWSyLs2mUZGQBTJA/wso1dl58zMXsR
 rnUf8hpXqzQbAjqjeGUEiMbCVXW+Ge+GN40/g22fSI2IUvdrM9F4csxVSf+degbcN052JcB8DFc
 IyLmjmnDWULXyy9aQY5be8bcUUN0LqKz5dc7nc3yZmr7D0jcY7otuGWqgBdHqf8BB3AMbRe3ect
 yVX0IKeFzQo+keUKA08Vt7g==
X-Received: by 2002:a05:620a:4687:b0:93f:1a1a:2974 with SMTP id
 af79cd13be357-93f580066d8mr388314685a.6.1792572175522; 
 Wed, 21 Oct 2026 01:42:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4687:b0:93f:1a1a:2974 with SMTP id
 af79cd13be357-93f580066d8mr388310785a.6.1792572175099; 
 Wed, 21 Oct 2026 01:42:55 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b402f2c2dfsm608020a12.1.2026.10.21.01.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 01:42:54 -0700 (PDT)
Message-ID: <7f3a33a2-8194-4d6a-8459-73371bbf1b16@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:42:51 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] drm/msm/a8xx: devcoredump state capture support
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
 <20261020204728.28844-10-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261020204728.28844-10-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX/nGYv3HY0zLh
 spBm3095DHdwY60X34KkwY1t8HOzWRuSxpmerV7tIWpUq1ogAkEomuois6DxnrvgDB8MZ/DOocP
 K9r0DckDaYVRFU16yf9rvFXQG8xd4WF3EhFyo1ZemEObSEipjvastjSOdVGYUnyXs9z2CuPtnEj
 Gqjza9lnvEKdQsVanFlBbffI3SbghlienBgK5ES4JRlXLCKkI8YF52IgfExqJib1SsXM7jzPQ4F
 aX+i2eLCnUtP8SBgLQRnf2IUUXDYHXRlmcJjttwDSeaY7XnwrjpJEF1dUjDvaz5sJ8Z5icQ2g3K
 tZZd8df27GeixnMpYzuWoZyV6JLq0ZVeiyYDYV3NglQ4/I8Yqdv9yFy/LvJY6z541BaPuLNoZGb
 MxalEpfEIQ06TgE709JiGqqav3+8t7g3ddawKFqUPA+LNmDp8JqBvd9OSChoYTy+chU6PbuzjyF
 uzFonc60UoN6cnHk66g==
X-Proofpoint-GUID: ogm2VMczq-6YgaHizE7ALKtytRm03rfU
X-Proofpoint-ORIG-GUID: ogm2VMczq-6YgaHizE7ALKtytRm03rfU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX15vufgHR28Od
 pEI6I4AsuoEbWDKGBCjNMubYOrr1Owep66r86iRk6dMtDmMk/n8Ck1nW4WJngjX6fUope/cizry
 vCBPBvZr6X/K43MII6QNwAaUDNWQqos=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad87b10 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=2HxrRyV7D69wryGh4VUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 10:46 PM, Rob Clark wrote:
> This attempts to make it easier to compare to kgsl, the downstream
> driver, to make it easier to spot bugs or missing things.  Such as
> re-using function names, etc.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> Co-developed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

[...]

> +#if defined(CONFIG_DRM_MSM_GPU_STATE)
> +		.show = a8xx_show,
> +#endif
>  		.gpu_busy = a8xx_gpu_busy,
>  		.gpu_get_freq = a6xx_gmu_get_freq,
>  		.gpu_set_freq = a6xx_gpu_set_freq,
> +#if defined(CONFIG_DRM_MSM_GPU_STATE)
> +		.gpu_state_get = a8xx_gpu_state_get,
> +		.gpu_state_put = a8xx_gpu_state_put,
> +#endif

It's odd to have 2 identical compile bounds side by side,
I'd just group them

[...]


> +static void gen8_cx_dbgc_debugbus_select(struct msm_gpu *gpu, u32 block_id, u32 index)
> +{
> +	u32 reg;
> +
> +	reg = A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_INDEX(index) |
> +		A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_BLK_SEL(block_id);
> +
> +	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_A, reg);
> +	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_B, reg);
> +	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_C, reg);
> +	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_D, reg);
> +
> +	/* Wait 1 us to make sure the data is flowing */
> +	udelay(1);

Should that be a readback instead?

Konrad
