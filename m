Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2083D606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kmEmWX3C;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RYll5CjG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E0E112247;
	Thu, 12 Nov 2026 17:11:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD74C112247
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:11:26 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZWhv1159665
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6okjxmAoABig3FVx0l9wQb8oMylLxVQ65k4wFbZ5YOo=; b=kmEmWX3CTFSw4zXm
 pzDf2Px3M0dU1mFLa+zvrIF36MuvRx3f5o2EP1zTQHeoz7N3waemRZkZ2j3yLZFb
 Xctwo2Sy8Jt6+UBPNZHasctgJZ32BlK6g8KOPHQ0XrAMJO/3bJQnhgFLVkT23xjy
 u54Mm/EHv4toIxPADDc15bKjQZ01aAcNImdlYc3zite8xq6jn0KTPk0Rf6F5CnhC
 UEv2Hl9jEvqRu08/YZeOCC9lCnZY0er2hFSvOV/gHAp0ftpY9XbE1AZ0VYEUNnKo
 jU4fAPgFSM28pup/r2lyW5LPqqqWsuyofj+9smGeMN4xkkNiGPj2lsgohNXzL4RQ
 LHhOfQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a0a3hd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:11:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36fa5673fccso206112eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794503484; x=1795108284;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6okjxmAoABig3FVx0l9wQb8oMylLxVQ65k4wFbZ5YOo=;
 b=RYll5CjGzw9FWzjWHp7Tn7H6Hx7X/AE3KxKWMKlwpC9XY8moSqs2Tr6b4RdswBVBk6
 ki7cVdrZjkjau0NMeT5YEqSfRVvn3hF7zcp6JZVSr34lABGgeZBhpi/8G2UXDzhJmF7i
 TIHP2nrOidD6zysdVYiHiF4ur6fXIr90xsMjbCBsJI/HDO37gA2TZog1Zn9xujEuxt/+
 4U3VIZjIbdiNyp+y+6yUIqNh+18oA3tNmYFBtmO6F8MagKPpw0+cEF+a41qEVPRv311k
 q9y+f7GoA0yXPS/IHq286rSKwPE9ulZqCK7NNnOZIpvO7dHSFDkidwYWhCLVhTxWxEhP
 xTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503484; x=1795108284;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6okjxmAoABig3FVx0l9wQb8oMylLxVQ65k4wFbZ5YOo=;
 b=ckNZ7hHSbd9FTh33fLd6WApHX6qDP9KxvBNnU3Jf68HydZ0Hr18oa+24XamLqB7Bog
 oqkL7hI0N5cODt/c8nXjBf9msiQHrCgfrOWNxnsOJLVrCpZ53oETXAJpiyupYKTENtdb
 na2jdFQBjtrKeQEeJFVVkUVOuZqmpsQhowaF0XT637lM2D2fW5N/fVoBMO1eLicTYZIw
 NmSZdF2xjUxBwbGAZ20ksYv2JY3KHbv5Hy50apKwvoDTZuMQeq5kQSIXN3wzeWquwmy8
 c1XLtKcWHhXQBoNse8GvTg3i9D4v6qV/KLfPxCtxszF4CHRBORYTDdZ4KFnmUALVXCil
 uw4g==
X-Forwarded-Encrypted: i=1;
 AL+hErEqSRL27lbCy8smgbHvk142jl++P0XcL0GWoYbDyGHD+KzGFbwb0LXduLKn9EE590Uxfg1FTpV4ngg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z81Mhd/16S34PLc5m28c0XyRMo4ZHYp3nA1pdlIaQlnXtpTaaNk
 nID0BsZ0npNRuSGnOMg4oZNvhJhaMpqv0MNNSvzS1kkXttHdGvzpu2LcBGcltWEwi2wed+sByRx
 A4IsLJeDqK+xvQp2qCadXCWNptw1E8IocVFKGrER9c8jReQLK9xjXBG01K7BdZitFQcfaYsI=
X-Gm-Gg: AYBFou29PHgFh32eb/DPKyfQ4OwAfsMKpzIHnKQlPDl1MDq3tLLLY7uu7P3Rw68OnrH
 +hpJ9YoNdUicyZ68mzHL6vhpiiDDPlixw99cOG2E/Ig5eQnktcGp985TI0rhyuk6fS7dXWmUvIS
 gBqx9+BH4KqUMJaFvXio7pOGAacLUlLvCRthhLENgonGTfB7gsueamQsrxLf+nEhhIY+7aDirXS
 qY0woCzY++f49FwoVgVoiLj8VzTAk3Kju1XGJajFQGQUNcNtfgGC6Bxzj2DslFffZ5zirTWiqJF
 X5rHzR3Pk17WBMWViT3UTfZMlZzo81H9igf7DGfZSj4Mc8uPp/FKV2mCmhTw8ZzJedcgiWDxnlJ
 R54dV40kie9OpVurgK2Jv79gu/w8X5O7kvpjQOLT4bxlZ1WjyMaynOuVdftf/R6NYEf13jog=
X-Received: by 2002:a05:701b:2802:b0:1a7:78a3:bda8 with SMTP id
 a92af1059eb24-1b50318d7abmr138530c88.27.1794503484466; 
 Thu, 12 Nov 2026 09:11:24 -0800 (PST)
X-Received: by 2002:a05:701b:2802:b0:1a7:78a3:bda8 with SMTP id
 a92af1059eb24-1b50318d7abmr138502c88.27.1794503483708; 
 Thu, 12 Nov 2026 09:11:23 -0800 (PST)
Received: from [192.168.1.9] ([106.222.229.14])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031468b7sm456200c88.5.2026.11.12.09.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 09:11:23 -0800 (PST)
Message-ID: <4f5ad34a-7e4f-474f-ac82-08098895b884@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 22:41:17 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a8xx: Fixup hw_err_irq messages
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261112160706.387641-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261112160706.387641-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gTOqUgRP7mWH-hr5yM7ScbzLYXghiPGl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2OCBTYWx0ZWRfX3KvilKNrikc4
 LQHeBburpZ+E8HF6Zv0GkhVjX/kBFQhqeYhLtrGF0xXq7c8BrUAJjiqu7SjE0Dv1wodNKVHMs72
 t4nysE8LTRvWkNCp9roFo+8MNAoEPqpLLZHEp8Dt+f+nxaQDQa6+A9Ta257TXy3q0DS6CVH78f+
 43412/y2OujUPpbpYDe9l8UgKTPlDvBex//qXAbtACw5T21lUZQAt7Hv30DrjrgY3DhYixqih76
 zyO1o5ok0sfgvL9Vwa/+sRWli91h4k9RL+SRYjQPvskCLDO4VGFmXQiYlrThBR7D2fVgk2/0qfJ
 FaCGVLOVhx89Ytjm2kd0lUDWtZZ58DhgyOw8Ccw4crKLVdU9mB0CE9Cdx0/Gih1l5Qt3FVoGakj
 XjYTnonJlv3un9oe0xe1Tm8mUIyor0gY6a5+qJv855kSsUeKFto4ZGlLczOoIxiZwOfSI/in+Pk
 dPtTDfXHO7vlU6pszfg==
X-Proofpoint-ORIG-GUID: gTOqUgRP7mWH-hr5yM7ScbzLYXghiPGl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2OCBTYWx0ZWRfXzJaLO0Rm0DYi
 BA544kFgb6+1EbhAfty/5VCFDoB16YHHLfxbjTDSMVSZa++LS5S+0XGsa/im8T6r0rRCze4Pvm9
 QEJGNticUGDYlgiipECNb/HBPSy0GhE=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af5f33d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=LKvw4eQ66EqDTtCUdPbf+g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ARhVbqjvJwDEIoiJcc8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120068
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



On 11/12/2026 9:37 PM, Rob Clark wrote:
> Handle all the pipes, and don't clobber 'status'.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 58 ++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index bbf5ca4fb6fc..a1747990e10e 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -1048,24 +1048,37 @@ int a8xx_fault_handler(void *arg, unsigned long iova, int flags, void *data)
>  
>  static void a8xx_cp_hw_err_irq(struct msm_gpu *gpu)
>  {
> -	u32 status = gpu_read(gpu, REG_A8XX_CP_INTERRUPT_STATUS_GLOBAL);
> -	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> -	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> -	u32 slice = a8xx_get_first_slice(a6xx_gpu);
> -	u32 hw_fault_mask = GENMASK(6, 0);
> -	u32 sw_fault_mask = GENMASK(22, 16);
> +	const u32 status = gpu_read(gpu, REG_A8XX_CP_INTERRUPT_STATUS_GLOBAL);
> +	const u32 slice = a8xx_get_first_slice(to_a6xx_gpu(to_adreno_gpu(gpu)));
> +	const u32 hw_fault_mask = GENMASK(6, 0);
> +	const u32 sw_fault_mask = GENMASK(22, 16);
>  	u32 pipe = 0;
>  
>  	dev_err_ratelimited(&gpu->pdev->dev, "CP Fault Global INT status: 0x%x\n", status);
>  
> -	if (status & (A8XX_CP_GLOBAL_INT_MASK_HWFAULTBR |
> -		      A8XX_CP_GLOBAL_INT_MASK_SWFAULTBR))
> +#define FAULT_MASK(_pipe) (A8XX_CP_GLOBAL_INT_MASK_HWFAULT ## _pipe | A8XX_CP_GLOBAL_INT_MASK_SWFAULT ## _pipe)
> +	if (status & FAULT_MASK(BR))
>  		pipe |= BIT(PIPE_BR);
>  
> -	if (status & (A8XX_CP_GLOBAL_INT_MASK_HWFAULTBV |
> -		      A8XX_CP_GLOBAL_INT_MASK_SWFAULTBV))
> +	if (status & FAULT_MASK(BV))
>  		pipe |= BIT(PIPE_BV);
>  
> +	if (status & FAULT_MASK(LPAC))
> +		pipe |= BIT(PIPE_LPAC);
> +
> +	if (status & FAULT_MASK(AQE0))
> +		pipe |= BIT(PIPE_AQE0);
> +
> +	if (status & FAULT_MASK(AQE1))
> +		pipe |= BIT(PIPE_AQE1);
> +
> +	if (status & FAULT_MASK(DDEBR))
> +		pipe |= BIT(PIPE_DDE_BR);
> +
> +	if (status & FAULT_MASK(DDEBV))
> +		pipe |= BIT(PIPE_DDE_BV);
> +#undef FAULT_MASK
> +
>  	if (!pipe) {
>  		dev_err_ratelimited(&gpu->pdev->dev, "CP Fault Unknown pipe\n");
>  		goto out;
> @@ -1076,31 +1089,36 @@ static void a8xx_cp_hw_err_irq(struct msm_gpu *gpu)
>  			continue;
>  
>  		if (hw_fault_mask & status) {
> -			status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
> +			u32 hw_status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
>  					REG_A8XX_CP_HW_FAULT_STATUS_PIPE);
>  			dev_err_ratelimited(&gpu->pdev->dev,
> -					"CP HW FAULT pipe: %u status: 0x%x\n", pipe_id, status);
> +					"CP HW FAULT pipe: %u status: 0x%x\n", pipe_id, hw_status);
>  		}
>  
>  		if (sw_fault_mask & status) {
> -			status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
> +			u32 sw_status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
>  					REG_A8XX_CP_INTERRUPT_STATUS_PIPE);
>  			dev_err_ratelimited(&gpu->pdev->dev,
> -					"CP SW FAULT pipe: %u status: 0x%x\n", pipe_id, status);
> +					"CP SW FAULT pipe: %u status: 0x%x\n", pipe_id, sw_status);
>  
> -			if (status & BIT(8)) {
> +			if (sw_status & A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_OPCODEERROR) {
>  				a8xx_write_pipe(gpu, pipe_id, REG_A8XX_CP_SQE_STAT_ADDR_PIPE, 1);
> -				status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
> +				u32 opcode = a8xx_read_pipe_slice(gpu, pipe_id, slice,
>  						REG_A8XX_CP_SQE_STAT_DATA_PIPE);
>  				dev_err_ratelimited(&gpu->pdev->dev,
> -						"CP Opcode error, opcode=0x%x\n", status);
> +						"CP Opcode error, opcode=0x%x\n", opcode);
>  			}
>  
> -			if (status & BIT(10)) {
> -				status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
> +			if (sw_status & A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_REGISTERPROTECTIONERROR) {
> +				u32 prot = a8xx_read_pipe_slice(gpu, pipe_id, slice,
>  						REG_A8XX_CP_PROTECT_STATUS_PIPE);
> +				u32 addr = FIELD(prot, A8XX_CP_PROTECT_STATUS_PIPE_ADDR);
> +				const char *mode = (prot & A8XX_CP_PROTECT_STATUS_PIPE_READ) ?
> +					"read" : "write";
> +
>  				dev_err_ratelimited(&gpu->pdev->dev,
> -						"CP REG PROTECT error, status=0x%x\n", status);
> +						"CP REG PROTECT error, %s addr=0x%05x, status=0x%x\n",
> +						mode, addr, prot);
>  			}
>  		}
>  	}

