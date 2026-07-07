Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB502C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 172C610EB63;
	Tue,  7 Jul 2026 07:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K1W4QIh1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cExZwiuY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 162F410E45F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:01:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6676WIer2964409
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Jul 2026 07:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dhLdgviZ/NZ7tpfISDWHNswmJtK4l1TkYgvgi9STN3M=; b=K1W4QIh1QJ02N3WI
 k+wITDmA8kNKXsE0YI9iFvmYjv77kvPPzOPjernwhDpnh/tE3HcYs1wWCuPeCxw0
 LY1pJ7w7z8lt2HpeTXnAX9yCrDaNgoRM4tzm7tk0nC9sY1h1sFSgcU55PckZaWz3
 +Xn8/brgAnHr/k9/u+KwN/iRDmod4AGdC2JsdEjYA8t0nbHh4Tf0Jn12nPtn4CTr
 QG0oN0Lw+qfb7cSVe4A6KnG3nMQB2+QtSv5+NPehw819bwD5pwCxAMqpnp3W51u4
 DPAbIFEtQNmPUYo7mh6ffvpZsvaCEQvxx2XPxEI3S1xMhULyeMwqQsHFlI+ESDKq
 FpTr6g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9a83kd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 07:01:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so47089465ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 00:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783407684; x=1784012484;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dhLdgviZ/NZ7tpfISDWHNswmJtK4l1TkYgvgi9STN3M=;
 b=cExZwiuYI1cybJ8tv5JWOFtF6R58VbLwc77jqn0KT5FoQ8Lb7EjJiQRe30UOj3g6+d
 F3wEAXwNcyo+dcTwRAuIKKI50dlSD1bdHf1rdhVOpQL99XzCPqnyTColnfOMbHWvf/V9
 hPq3gM6FQU6QLqEGllKETEsb6ntaRkwCO2YPz48uwnfCn80D58lC2R2xs49ngf7K2HCC
 6eiFos9/I+KwQJWrZuESpaNDPZU2RBBN9+Lj4mbp1Y4+PW5GC2L6YtZFXtBKMz95ykMn
 0qN9ibHp+wP+yUbJNiUUJ7CEaldZR0vRYwRC3f2KQQR7IEFr+7PY7WfK4HOWL/xdUxL1
 9s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783407684; x=1784012484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dhLdgviZ/NZ7tpfISDWHNswmJtK4l1TkYgvgi9STN3M=;
 b=X/KC4v7N5qiKiW4fzxQHAhSbzuNeOq3N1QPPd8TkpxDqm3tvdw4il8nqcEqZyAx1rs
 +/jxDS2DmpTX/hvJsGJAwPIuAuqvS6WlojraysOI87GSyflkzrr9hz2qZq0EPXVaiSZQ
 GctazyZoaf0kjyOly2UbiX+xu/b1yYuaLPzI4eJOofZugLMhMAHOcsCtSBesHdIW+0aK
 3voSopCLbOXCls+awqLTfegbTPatKT4VZrHst02fNegIVE5yIrJ9WsDMa7+wRB9AdN77
 DwkI0zOCxtaom3iIG5ys/9OWQEt51e21qSzu+Vhw+bwfECcds26lXHj0Z43LgzcXFu5f
 opNg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2AY/P2jQSt1Bfa9ohKbbC6pyLZEwArKFah111eGOQ8eCFyiNuYR1Ycsl4hVFCsBMNITnhPqGkwuc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYJ3rOcyRYhNHs1tvutFTmdjGzSCzRnv1DJWU73V4it+v+YGIg
 Gm45h9SKRUPr4YWJ/+snlcTmUpWo4CSXUIj0MvjM9kqqxpf1KywrP0j3J8bdYofrbZkfdv5N95c
 pbzeirVBY6CbMT5u263YJMJKuiRuPAjkNPF8DiqUK3ZEh2tfJMaMB9Z0I+1SK2I8xHuP2ubukia
 6lvpQ=
X-Gm-Gg: AfdE7clfT1kp35QR3t6/x5b11v3D905wh8pTU8ISpElsBjcet7EX+xZVQNJjwzI57ph
 zp0EFEH1PGBEhiPfQDcOQZ7veL8+cAGzBeAhDp8VCS6pRooy5DKEhsPprsW52oqfgy5Wg1fEsOs
 gs1/hFZqhuetyrY8woT3IpNBwiCNvvhoavMLcw0Ja6LDLTSbhNh+DU5a98Twz6ebQVwVLN2YHg7
 2AwY4CWOxQTmmviGxg3uCQ92z+JWs9mwh5puIuDduC0nd9QaO26zDXKhRbbDelaeEQfazGzYvgw
 b6wxH7ZsWeVxJSfeAmALV3H65hD0X90dE3fc/g+co9y4fsRe7S1+1F1BKDSIulVuN1C9x0EaYxQ
 APVIaS7lmiywUPCO+DuIccgJGFS6Ti7QEPEuyDrt+
X-Received: by 2002:a17:902:fc85:b0:2cc:6817:d9b1 with SMTP id
 d9443c01a7336-2ccbf076fbamr37808415ad.41.1783407683510; 
 Tue, 07 Jul 2026 00:01:23 -0700 (PDT)
X-Received: by 2002:a17:902:fc85:b0:2cc:6817:d9b1 with SMTP id
 d9443c01a7336-2ccbf076fbamr37808145ad.41.1783407682871; 
 Tue, 07 Jul 2026 00:01:22 -0700 (PDT)
Received: from [10.204.78.130] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm6346595ad.57.2026.07.07.00.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 00:01:22 -0700 (PDT)
Message-ID: <1e7d0b9f-380b-41a2-8aba-7ab25c6a8680@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 12:31:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Jianping Li <jianping.li@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, stable@kernel.org
References: <20260707061733.495-1-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260707061733.495-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tmlW9tG6FzyP1ZCcOTIiosrqO0BlOofN
X-Proofpoint-ORIG-GUID: tmlW9tG6FzyP1ZCcOTIiosrqO0BlOofN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2NSBTYWx0ZWRfXwPA0BBEpnwJn
 XaB+rV5LKj/ehfll0l+Q4b4jB5/ycGSoHqJbdTb6staS4seaHtAly1PHJGRK09ibNxnixj2+LSv
 hTSNrPUpsbWBVTr3QrcQdvfV6ffLi0A=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4ca444 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HXEXjcvW3tC2QbQot0wA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2NSBTYWx0ZWRfX7vOEQtraljW1
 +q79UHrgJg/GjmjUN69fiX1Dx717xlc3Nqeo6Xjs2W0/mAr3O1I3OJBKUtZXFYrKlLF4/ev3Jm+
 ay5xWmaVXcwRBygSbwl2ueCpdIYHzJjaRq4HSq07xzoAgt37qHafZL7zAVJVECAWnhl79dThr2B
 DSvbpseL/Jk2+UQDnPE1vtENzB1AZ0t8Ppqa7dAdg2eVxRGKFE22+46NhTgYpFDSgNlCbb/aMSY
 0A4hCL1jasRFv035jGK9ZlJLv5qH0nwA33o+En1skH5ZwJSVWO/O1nRepxKHJUDmr13+y5T6v1k
 +soWJQZsqyen2zl3fHEuzUGxwDlwgJCwtp0OFn89T+CRWDMNAVwt42IKwubdpYZcf72AWk/D/1A
 9CmBrwh9sZc7bG6cOdTBGVBx7XVxG01cqE8C5lHTWo/IE0XQUAFl07+B9dahkjBa8nkC1gH7UDP
 W1xhM9sdE5d+3ZK/0Vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070065
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

On 07-07-2026 11:47, Jianping Li wrote:
> Allocating and freeing Audio PD memory from userspace is unsafe because
> the kernel cannot reliably determine when the DSP has finished using the
> memory. Userspace may free buffers while they are still in use by the DSP,
> and remote free requests cannot be safely trusted.
> 
> Additionally, the current implementation allows userspace to repeatedly
> grow the Audio PD heap, but does not support shrinking it. This can lead
> to unbounded memory usage over time, effectively causing a memory leak.
> 
> Fix this by allocating the entire Audio PD reserved-memory region during
> rpmsg probe and tying its lifetime to the rpmsg channel. This removes
> userspace-controlled alloc/free and ensures that memory is reclaimed only
> when the DSP process is torn down.
> 
> Add explicit validation for remote_heap presence and size before sending
> the memory to DSP, and fail early if the reserved-memory region is
> missing or incomplete.
> 
> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
Changes in vN and lore link to v(N-1) series would help here.>
drivers/misc/fastrpc.c | 119 +++++++++++++++++++++++------------------
>  1 file changed, 66 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d86e79134c68..1ec37e6c68a2 100644
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
> @@ -1344,15 +1346,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
> +
> +	if (!cctx->remote_heap || !cctx->remote_heap->dma_addr ||
> +	    !cctx->remote_heap->size) {
> +		err = -ENOMEM;
> +		dev_err(fl->sctx->dev,
> +			"remote heap memory region is not added\n");
> +		return err;
> +	}
>  
>  	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>  	if (!args)
> @@ -1376,31 +1387,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
> @@ -1412,8 +1398,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	args[1].length = inbuf.namelen;
>  	args[1].fd = -1;
>  
> -	pages[0].addr = fl->cctx->remote_heap->dma_addr;
> -	pages[0].size = fl->cctx->remote_heap->size;
> +	/*
> +	 * Audio PD is a static PD and retains the remote heap
> +	 * information across daemon restarts. Therefore only
> +	 * the first attach should provide heap information to
> +	 * DSP. Subsequent attaches reuse the previously
> +	 * initialized memory pool.
> +	 */
> +	spin_lock_irqsave(&cctx->lock, flags);
> +	if (!cctx->audio_init_mem) {
> +		pages[0].addr = cctx->remote_heap->dma_addr;
> +		pages[0].size = cctx->remote_heap->size;
> +		cctx->audio_init_mem = true;
> +		inbuf.pageslen = 1;
> +	} else {
> +		pages[0].addr = 0;
> +		pages[0].size = 0;
> +	}
> +	spin_unlock_irqrestore(&cctx->lock, flags);
>  
>  	args[2].ptr = (u64)(uintptr_t) pages;
>  	args[2].length = sizeof(*pages);
> @@ -1431,27 +1433,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
> -	fl->cctx->remote_heap = NULL;
> -err_name:
> +	cctx->audio_init_mem = false;
>  	kfree(name);
>  err:
>  	kfree(args);
> @@ -2418,12 +2400,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		}
>  	}
>  
> -	if (domain_id == SDSP_DOMAIN_ID) {
> +	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
>  		struct resource res;
>  		u64 src_perms;
>  
>  		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
>  		if (!err) {
> +			if (domain_id == ADSP_DOMAIN_ID) {
> +				data->remote_heap =
> +					kzalloc_obj(*data->remote_heap, GFP_KERNEL);
drop GFP_KERNEL from kzalloc_obj()> +				if (!data->remote_heap) {
> +					err = -ENOMEM;
> +					goto err_free_data;
> +				}
> +
> +				data->remote_heap->dma_addr = res.start;
> +				data->remote_heap->size = resource_size(&res);
> +			}
>  			src_perms = BIT(QCOM_SCM_VMID_HLOS);
>  
>  			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
> @@ -2431,7 +2424,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  			if (err)
>  				goto err_free_data;
>  		}
> -
>  	}
>  
>  	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
> @@ -2490,6 +2482,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		misc_deregister(&data->secure_fdevice->miscdev);
>  
>  err_free_data:
> +	kfree(data->remote_heap);
>  	kfree(data);
>  	return err;
>  }
> @@ -2512,6 +2505,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  	struct fastrpc_buf *buf, *b;
>  	struct fastrpc_user *user;
>  	unsigned long flags;
> +	int err;
>  
>  	/* No invocations past this point */
>  	spin_lock_irqsave(&cctx->lock, flags);
> @@ -2529,8 +2523,27 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>  		list_del(&buf->node);
>  
> -	if (cctx->remote_heap)
> -		fastrpc_buf_free(cctx->remote_heap);
> +	if (cctx->remote_heap && cctx->vmcount) {
> +		u64 src_perms = 0;
> +		struct qcom_scm_vmperm dst_perms;
> +
> +		for (u32 i = 0; i < cctx->vmcount; i++)
for the iterator use top-of-block declaration style for consistency> +		
src_perms |= BIT(cctx->vmperms[i].vmid);
> +
> +		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
> +		dst_perms.perm = QCOM_SCM_PERM_RWX;
> +
> +		err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
> +					  cctx->remote_heap->size, &src_perms,
> +					  &dst_perms, 1);
> +		if (err)
> +			dev_err(&rpdev->dev,
> +				"Failed to assign memory back to HLOS: dma_addr %pad size %#llx err %d\n",
> +				&cctx->remote_heap->dma_addr, cctx->remote_heap->size, err);
> +	}
> +
> +	kfree(cctx->remote_heap);
> +	cctx->remote_heap = NULL;
>  
>  	of_platform_depopulate(&rpdev->dev);
>  

