Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C0AE9DE5F
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 07:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CC510E756;
	Thu,  9 Apr 2026 07:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XIy9PRhf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XMFKO9Xl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B7110E756
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 07:54:54 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6395CUFq3535075
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 07:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UZX5/TVRE8MhjSwrsl7Tfx6LDaNNM+dZtYnyCvbKY88=; b=XIy9PRhfknf2/7ie
 UfoKtaC1DODflqpObMIJKDh88TADi1aCwk6fyi7odDY+7KYPGTRzrKWngwBYgpf7
 JZ/xrYW5V40KZyedGAcHwiGvZWL3XFBhtD54uQX57JUzLhjVzN/jiCHO/chP9exd
 UAQ/BB+OhImdrCs1Y92+EXdjYvOZxRtqcb6qdYStKy2JwRQEhcmoGqqNzSBpvGQp
 k3J8IYoROyT5nxvpratk9bB63OjZB8DCmy7s6eeoiY3/N9vUM/R69CBtTOl+9Hvy
 QEjV4MgCdZrY+SH/QT1OKbjwjsUpOnuHkrVbJiW6S+Y0wO0l6YIe35NH74pSOmwD
 JFl79w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddw9mt5d8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 07:54:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c76b6db8bb2so731173a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 00:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775721293; x=1776326093;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UZX5/TVRE8MhjSwrsl7Tfx6LDaNNM+dZtYnyCvbKY88=;
 b=XMFKO9XlZpjDPE/moZWVauABitRRBYyxsl0Y4sUOMh0yHC/xwBxT28OGUqJRwEtuhQ
 1q+PcFtNZo6aeFqlyLHsyM2q6mpBP8j93Fci7Puspd8CYGFjQaunfnWoa/vwQ6Pvlcwz
 3Zy547btNjS8SswTXjm8vFkuSsCqKyUFaI4elNaor3Nllq6YhJCbB061MrZOt58pO3mO
 OS8Xs452tU1Hh5ZxoXfi2FRiasmdb9h7GpKNdznWCBDBFs/q06NNF5Hfw4mZ0H9L0eeP
 +8WKeVV0zgkOQ03vPksUKq7FpDGEkOTZKuCnxuulOKdijS5vcxQidwsLPM+X13WUKoGe
 m3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775721293; x=1776326093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZX5/TVRE8MhjSwrsl7Tfx6LDaNNM+dZtYnyCvbKY88=;
 b=Li/3V5SFbl6Hr62znz9Rjzznjd3dcOVPB1c7W2RdQMWNzdH/liA6N83QQfb7W3zboY
 EF0uSAK2UjlM3WWku5HTbPctV+8Jy5komvh1LKOOoiQKTo0qelQ+QpcrCytrCQRW+qjd
 5WrhYjIfZQDWZHOBP1SwC9MhFviwgTqDFNAa3jV0mWMjbeQwOItadAP9aEENY5xZtjzz
 coZ6AnRupbKYdhQFqJqV6G+b8A4szsKR1YhvrkfW2lUuXHBPMkunoDN29d4ZjqjbN+AE
 UC/aZ4Y1Ks/E2/SFdlYWw8qn0rhx/iVuVI6bnYYv/75cLfkNOc9GjiqGUOM5p4dnhlg3
 5eXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsgL+Me5SX1qfKvqh5PqfNescbSlZz9f98ryAbw3WMuMy6lqW7xodG6gLugZkJtwM7VAqeWK6fBqw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTOtSBj3yf6F2H8yjYDl85lXbxC7UpkW/ENuuk7KFOJLrTc8ff
 o1qQkXReEq8MFHflj2AVRoz5kMfOB6kls9ee83TP6llHJCV14wR6Rsyou0LXI0IQHqhMM9q0weK
 2hjnzDAptTk+W5c9iNRruuWHpNPwDxI4M4hub4Vxclg9URFVbHTXhEQcMzL37KGS2ubq6jbw=
X-Gm-Gg: AeBDiet4VMwIyYvEXl67Xro4moihDqh50QN+0T1PdC+uJ/gep6Qc4uqd/gFH7TIFXmL
 QRjAC5DR6fQX2YqdoUwIC0zjCwkiNZKvBQQq8ZkkZhI+UNDXY/ufHaZF6RizelYL0vTZo+dqqtR
 0kDbQEz13ju5q8vaJupNlcXhtqWAWwHsYxZLGLL8qSzu4TsLfyxQ41Dk/BLofmzZcV4bTG6VzKU
 4ESJqeXX8xNkuI0e21Z7QFA+8Ol65wNkqmbHlMEgEm7fNIYe/eKX58r54JGVu3BlWMXbqY74xGL
 p2alqvWi0yfDYll2IHn4Y8Om+M8DdiYNS/AQVrYIbD43kloQZy8WAdUjowJr14/SIvk7fFQOaZU
 4/gL5WMTU6NnF8YlHdOmX99I8t5RniwQgAvhloQKD6Fjm3F4ZZw==
X-Received: by 2002:a05:6a00:414b:b0:829:b55e:1b27 with SMTP id
 d2e1a72fcca58-82d0dbcfa64mr24256993b3a.53.1775721293320; 
 Thu, 09 Apr 2026 00:54:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:414b:b0:829:b55e:1b27 with SMTP id
 d2e1a72fcca58-82d0dbcfa64mr24256973b3a.53.1775721292801; 
 Thu, 09 Apr 2026 00:54:52 -0700 (PDT)
Received: from [10.204.79.79] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9ca1f28sm24147067b3a.57.2026.04.09.00.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 00:54:52 -0700 (PDT)
Message-ID: <2de300c8-02fc-4373-b56d-f6fa336bb84a@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 13:24:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Jianping Li <jianping.li@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
References: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
 <20260409062617.1182-4-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260409062617.1182-4-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cfPiaHDM c=1 sm=1 tr=0 ts=69d75b4e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=5ITuIF2ajUGMKyiTjJ0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: rMlbLNYI4fMgcZcA2sXRqDI5Kcfwxcrl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA2OCBTYWx0ZWRfX0s2JtHjkb5mv
 Ed77s6bD9Etrzj+am1HAUCokc9cfoSbz4hJFbK8akjhNNPeAqGAay5NBs9NWjPhAAeBX0Sj4wAc
 NHIolP6zb/teXF0GV8GGiBxxd+ak74jRzxnCZw2M1aRSfgsCx/2TBEdBhSF1x7TF6eTGqT04x4a
 84TdxmPXpRuJSrdpo0Oje4jmikgJrI+bcPb2kSRVeB69vU7K4P4ExlhyQA5K5MwO5dcVI0AoxNc
 Q/jWdCjacg5J+IGN1PmIfAtgvPff97Te9QmerOG27DQXdEkqOFRWiZ3swS1DMSzKnmnV+rJMyZl
 9DEEuYp+BGfI5nk4nSDfe2mYzOrnurhQTXuGWR3Y3xYG4nKpVS4cHIwAWhM38nL1LcBxUhAowdt
 SyYCMWCm7qx2g3mjeKLDcrTmd1vC+A/t01OASMlvWFbUW7SJXyappjYS5NsjNvW65zQZv8OlN+0
 6Hd29RZn4sL9WxroVfQ==
X-Proofpoint-GUID: rMlbLNYI4fMgcZcA2sXRqDI5Kcfwxcrl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090068
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 09-04-2026 11:56, Jianping Li wrote:
> Allocating and freeing Audio PD memory from userspace is unsafe because
> the kernel cannot reliably determine when the DSP has finished using the
> memory. Userspace may free buffers while they are still in use by the DSP,
> and remote free requests cannot be safely trusted.
> 
> Allocate the entire Audio PD reserved-memory region upfront during rpmsg
> probe and tie its lifetime to the rpmsg channel. This avoids userspace-
> controlled alloc/free and ensures memory is reclaimed only when the DSP
> shuts down.
> 
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 104 +++++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 148085c3b61a..a67ae991c0b0 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -276,6 +276,8 @@ struct fastrpc_channel_ctx {
>  	struct kref refcount;
>  	/* Flag if dsp attributes are cached */
>  	bool valid_attributes;
> +	/* Flag if audio PD init mem was allocated */
> +	bool audio_init_mem;
>  	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>  	struct fastrpc_device *secure_fdevice;
>  	struct fastrpc_device *fdevice;
> @@ -1295,15 +1297,16 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	struct fastrpc_init_create_static init;
>  	struct fastrpc_invoke_args *args;
>  	struct fastrpc_phy_page pages[1];
> +	struct fastrpc_channel_ctx *cctx = fl->cctx;
>  	char *name;
>  	int err;
> -	bool scm_done = false;
>  	struct {
>  		int client_id;
>  		u32 namelen;
>  		u32 pageslen;
>  	} inbuf;
>  	u32 sc;
> +	unsigned long flags;
>  
>  	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>  	if (!args)
> @@ -1327,31 +1330,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	inbuf.client_id = fl->client_id;
>  	inbuf.namelen = init.namelen;
>  	inbuf.pageslen = 0;
> -	if (!fl->cctx->remote_heap) {
> -		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
> -						&fl->cctx->remote_heap);
> -		if (err)
> -			goto err_name;
> -
> -		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
> -		if (fl->cctx->vmcount) {
> -			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
> -
> -			err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
> -							(u64)fl->cctx->remote_heap->size,
> -							&src_perms,
> -							fl->cctx->vmperms, fl->cctx->vmcount);
> -			if (err) {
> -				dev_err(fl->sctx->dev,
> -					"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
> -					&fl->cctx->remote_heap->dma_addr,
> -					fl->cctx->remote_heap->size, err);
> -				goto err_map;
> -			}
> -			scm_done = true;
> -			inbuf.pageslen = 1;
> -		}
> -	}
>  
>  	fl->pd = USER_PD;
>  
> @@ -1363,8 +1341,25 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	args[1].length = inbuf.namelen;
>  	args[1].fd = -1;
>  
> -	pages[0].addr = fl->cctx->remote_heap->dma_addr;
> -	pages[0].size = fl->cctx->remote_heap->size;
> +	spin_lock_irqsave(&cctx->lock, flags);
> +	if (!fl->cctx->audio_init_mem) {
> +		if (!fl->cctx->remote_heap ||
> +		    !fl->cctx->remote_heap->dma_addr ||
> +		    !fl->cctx->remote_heap->size) {
> +			spin_unlock_irqrestore(&cctx->lock, flags);
> +			err = -ENOMEM;
> +			goto err;
> +		}
> +
> +		pages[0].addr = fl->cctx->remote_heap->dma_addr;
> +		pages[0].size = fl->cctx->remote_heap->size;
> +		fl->cctx->audio_init_mem = true;
> +		inbuf.pageslen = 1;
> +	} else {
> +		pages[0].addr = 0;
> +		pages[0].size = 0;
> +	}
> +	spin_unlock_irqrestore(&cctx->lock, flags);
>  
>  	args[2].ptr = (u64)(uintptr_t) pages;
>  	args[2].length = sizeof(*pages);
> @@ -1382,26 +1377,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  
>  	return 0;
>  err_invoke:
> -	if (fl->cctx->vmcount && scm_done) {
> -		u64 src_perms = 0;
> -		struct qcom_scm_vmperm dst_perms;
> -		u32 i;
> -
> -		for (i = 0; i < fl->cctx->vmcount; i++)
> -			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
> -
> -		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
> -		dst_perms.perm = QCOM_SCM_PERM_RWX;
> -		err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
> -						(u64)fl->cctx->remote_heap->size,
> -						&src_perms, &dst_perms, 1);
> -		if (err)
> -			dev_err(fl->sctx->dev, "Failed to assign memory dma_addr %pad size 0x%llx err %d\n",
> -				&fl->cctx->remote_heap->dma_addr, fl->cctx->remote_heap->size, err);
> -	}
> -err_map:
> -	fastrpc_buf_free(fl->cctx->remote_heap);
> -err_name:
> +	fl->cctx->audio_init_mem = false;
>  	kfree(name);
>  err:
>  	kfree(args);
> @@ -2390,7 +2366,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		}
>  	}
>  
> -	if (domain_id == SDSP_DOMAIN_ID) {
> +	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
>  		struct resource res;
>  		u64 src_perms;
>  
> @@ -2402,6 +2378,15 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  				    data->vmperms, data->vmcount);
>  		}
>  
> +		if (domain_id == ADSP_DOMAIN_ID) {
> +			data->remote_heap =
> +				kzalloc_obj(*data->remote_heap, GFP_KERNEL);
> +			if (!data->remote_heap)
> +				return -ENOMEM;
> +
> +			data->remote_heap->dma_addr = res.start;
> +			data->remote_heap->size = resource_size(&res);
> +		}
>  	}
>  
>  	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
> @@ -2482,6 +2467,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  	struct fastrpc_buf *buf, *b;
>  	struct fastrpc_user *user;
>  	unsigned long flags;
> +	int err;
>  
>  	/* No invocations past this point */
>  	spin_lock_irqsave(&cctx->lock, flags);
> @@ -2499,8 +2485,24 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>  		list_del(&buf->node);
>  
> -	if (cctx->remote_heap)
> -		fastrpc_buf_free(cctx->remote_heap);
> +	if (cctx->remote_heap && cctx->vmcount) {
> +		if (cctx->vmcount) {
this if check is not needed
> +			u64 src_perms = 0;
> +			struct qcom_scm_vmperm dst_perms;
> +
> +			for (u32 i = 0; i < cctx->vmcount; i++)
> +				src_perms |= BIT(cctx->vmperms[i].vmid);
> +
> +			dst_perms.vmid = QCOM_SCM_VMID_HLOS;
> +			dst_perms.perm = QCOM_SCM_PERM_RWX;
> +
> +			err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
> +						  cctx->remote_heap->size,
> +						  &src_perms, &dst_perms, 1);
> +			if (!err)
> +				fastrpc_buf_free(cctx->remote_heap);
> +		}
> +	}
>  
>  	of_platform_depopulate(&rpdev->dev);
>  

