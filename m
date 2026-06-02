Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C5DCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58939113986;
	Tue,  2 Jun 2026 09:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aZbzSY+J";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fkzkczfY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44720113986
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:41:08 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6526Movl2767712
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oESplOGIONykfrvVga1RyEzgCLfort4w6L2n3L3CGBs=; b=aZbzSY+Je2M1WrLi
 kvRRVcmtzeV4Xv7janPqqotTd6cYY9pVwCmDrTk9GvNHE1TgUVepZyEomVu/++Br
 dMVcjqrV6dlAwxF0Fext7rWKdSESy98j8sjXnVEGOwZZ6h4J1PscJ7ZRZlBsmeNM
 lNBf0Z6KO3ACyYWuZf9cGexmpJoq8wyWC2tNC9tqAbRPb85JDGSD1kZON35/NQdL
 K1ingTcOtVEtjz/Fx7tKqNEqE1zC/bj7ceH5TWGZ8Ht3xphVmlAUlcvFSelc0ldY
 pFUEFd4lnBcYJyOmD60Qtiu5oG8zgCwKGeG8q2j9h3S2A8aD7JMCt54iA94WHnQb
 sMfozw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsus0tcv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:41:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf0b7425bbso93979525ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780393267; x=1780998067;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oESplOGIONykfrvVga1RyEzgCLfort4w6L2n3L3CGBs=;
 b=fkzkczfYc7Lg+ga33YINChsj4wZ9w52ZXkt07KSIxK2nGGHkj8x4HeSgp+RbO+CbSY
 WlxFotvQRVFyliRggdjBKnbvo6QoSTfTIrE0vHB6RiSYXYpbcQOwAUma99sXAHMdXy59
 sTCP4MiDyq+WyBHxlpszjItXL/kVuBN5j4KUIuS2Zl9Y5a3Y+uyHI+NQvW4zxYYvk487
 9AhIkqUueq1hFma5yj4L5nW8tNhWTTtUb6ECQUp0s8v8WjIp7Rco5Zu/Bp+TJ3f2PCMN
 GzQ+JLnsgWfwzWfneZjTkejiZAEU7hVjauKMe0nTa1DpMe2KMHf63UPULKbeKeywDKAH
 JOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780393267; x=1780998067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oESplOGIONykfrvVga1RyEzgCLfort4w6L2n3L3CGBs=;
 b=jKd9FO5+cwxEOTXI3M1k1aXjvxUPos/W4o9Uy1FG9qGZ/En+mwJU+OsX+mH1jE1V+V
 +M3QPT5HlETkS/I/x9vsCC2gRKxn952R6fxcjrFf0nM6EjbFGGDBZt0NsCMfCjtWWGR4
 K787TKSlH3qUp0y5UHoPLLlI0XNbZKTl1O5EcANaf+Vids6/FedPBMWIRJop0n+PqafC
 4KKIAnIF56a8nM8SqnHyye+jh0vsiLs78qvY5KnI+Jrla7eZvqWkrNOwra8ljRfgCVQp
 5jZOgT98SO50dPQxQUMGy5eCpTzqRnmJSEBBhEZ2BL38s9q8DkKA29X1ny6K5t4buPdR
 YB2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9O8UBs5U6Ntw5pqV+I8zeOlT1CkEGGKzUUqyHPMNHm4/V2+HV0r9IL+Cy+iLi8vzq9GWdXRbHEXPM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEZhxMmZBLgjkObblV/Fx/LCbR5sq8PUhn/LNjqsxr1O0QcETa
 uCBnUU21TrUMZudm7v7xNMJ0w0V7oN7cxZVzA/CGSJROplwJWlQlH5VMR6LpFiml/gGGbjWq4PR
 iXKOAcl6P8UAttnike7F9Nn0cLBgdB7P8gWUq6EWeKD0EO/NHVurK0Yg8gaEht0xfmYkUyCU=
X-Gm-Gg: Acq92OEJmx8O2wLUozntuEsh0FEbY9oKavifBTTlbhX+nU59jekE45KI68MBlavYiJ+
 JrwOev4S03SnvnblWJMUsjMLtSyZoXhHalApDjn3k7iwocHB1M0uKl16XPTOF09BlPAt4YlH6R4
 /ziZfC0/Rab0Du9v/GKVtN8aWABG4ghEsE3NmlGJ3pimOof7FD1B23b/593xaUAGtsgmxggpHvh
 JYgu5z5SEq0Os3YDN1fJ81sEUOQQIxbTP1yQmaItxU4CXNUDq30eFaQjipHtZFNDLnWz3Nb8RQr
 yeqfx0zunFYG9uoX7nokFnt+ojRRw6T56seZZt+Mj4iTUrUUk02d5f04eWQm2u2IE8csBEI8r6O
 RMHR9XLwQoFiRHfNfzpvyWSQd2BJuyLf+sg64yli3MBxx5dSebUKhQxiCV8lmsECmOAYnqf5G+o
 ajW6P/SsYpjztWl6P+eV6ctA==
X-Received: by 2002:a17:903:2389:b0:2b4:656b:aeb0 with SMTP id
 d9443c01a7336-2bf3685af15mr182356345ad.35.1780393266960; 
 Tue, 02 Jun 2026 02:41:06 -0700 (PDT)
X-Received: by 2002:a17:903:2389:b0:2b4:656b:aeb0 with SMTP id
 d9443c01a7336-2bf3685af15mr182355955ad.35.1780393266399; 
 Tue, 02 Jun 2026 02:41:06 -0700 (PDT)
Received: from [10.133.33.123] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239fd8cdsm124904775ad.22.2026.06.02.02.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 02:41:05 -0700 (PDT)
Message-ID: <e0efec0d-b99c-4b71-bac4-4c04f243c4f6@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 17:41:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Jianping Li <jianping.li@oss.qualcomm.com>, srini@kernel.org,
 amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 abelvesa@kernel.org, jorge.ramirez@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com, stable@kernel.org
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
 <20260602071750.526-5-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260602071750.526-5-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: twH0H7IYeDAc6Pdw3r45i9esz-2b5AxE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA5MCBTYWx0ZWRfXxBiTg3cyr0yD
 KXHYheh9NsLc8r6bGDO4zZ1ppJAMTRnFDaq+kRlV3kjgJ9F6nlkrmtvLOCK2ZyAaQtFZ4XyWJ9f
 dh4OgBAgqEuo0QqclzfbXi4sLjjk6odX0HrQCbKWtMv3Hq+EtYHIpFb/MlFOZ1Y/sMNR0NBa+2R
 JO8sUlPTL9/uCEjgVn/KWbJ45Tkf/97NUoc9hX8Ly75dOx18VMLKV15ee72b0V2J/wkPaG8onGr
 +4MhRx8tCz8laijWcEyV87cwQveFjLLvQIqPY0t4USIxqa++VZnyb9cQOoOGuQHWjTi5Vymdho0
 cnDfPsr0nX/E9+f7Xx8VRjgykEMtSv0UNmt+oKWAe9XybDw2ZSNSDEvGevKcRcqayWoy30W8fsA
 rS/3NJie/YD7ZANDvDnK3YPpXNZqj7+qcgow+RF//flmd3d77PtMoJaexeD0RWYI2k8C0obIZtv
 4ETUEVfhAtmE6ojz1VA==
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a1ea533 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Hk-PcD55WIolp562rqUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: twH0H7IYeDAc6Pdw3r45i9esz-2b5AxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020090
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



On 6/2/2026 3:17 PM, Jianping Li wrote:
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
> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>   drivers/misc/fastrpc.c | 96 +++++++++++++++++++-----------------------
>   1 file changed, 43 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f46a8f53970d..33be8bed6a0b 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -276,6 +276,8 @@ struct fastrpc_channel_ctx {
>   	struct kref refcount;
>   	/* Flag if dsp attributes are cached */
>   	bool valid_attributes;
> +	/* Flag if audio PD init mem was allocated */
> +	bool audio_init_mem;
>   	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>   	struct fastrpc_device *secure_fdevice;
>   	struct fastrpc_device *fdevice;
> @@ -1344,15 +1346,16 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   	struct fastrpc_init_create_static init;
>   	struct fastrpc_invoke_args *args;
>   	struct fastrpc_phy_page pages[1];
> +	struct fastrpc_channel_ctx *cctx = fl->cctx;
>   	char *name;
>   	int err;
> -	bool scm_done = false;
>   	struct {
>   		int client_id;
>   		u32 namelen;
>   		u32 pageslen;
>   	} inbuf;
>   	u32 sc;
> +	unsigned long flags;
>   
>   	if (!fl->cctx->remote_heap ||
>   	    !fl->cctx->remote_heap->dma_addr ||
> @@ -1383,31 +1386,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   	inbuf.client_id = fl->client_id;
>   	inbuf.namelen = init.namelen;
>   	inbuf.pageslen = 0;
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
>   	fl->pd = USER_PD;
>   
> @@ -1419,8 +1397,17 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   	args[1].length = inbuf.namelen;
>   	args[1].fd = -1;
>   
> -	pages[0].addr = fl->cctx->remote_heap->dma_addr;
> -	pages[0].size = fl->cctx->remote_heap->size;
> +	spin_lock_irqsave(&cctx->lock, flags);
> +	if (!fl->cctx->audio_init_mem) {
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
>   	args[2].ptr = (u64)(uintptr_t) pages;
>   	args[2].length = sizeof(*pages);
> @@ -1438,27 +1425,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   
>   	return 0;
>   err_invoke:
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
> +	fl->cctx->audio_init_mem = false;
>   	kfree(name);
>   err:
>   	kfree(args);
> @@ -2425,12 +2392,21 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   		}
>   	}
>   
> -	if (domain_id == SDSP_DOMAIN_ID) {
> +	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
>   		struct resource res;
>   		u64 src_perms;
>   
>   		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
>   		if (!err) {
> +			if (domain_id == ADSP_DOMAIN_ID) {
> +				data->remote_heap =
> +					kzalloc_obj(*data->remote_heap, GFP_KERNEL);
> +				if (!data->remote_heap)
> +					return -ENOMEM;

allocated data never free with directly return.

goto err_free_data;

Beside, we also need free data->remote_heap in err_free_data path as you 
added new memory allocation.

> +
> +				data->remote_heap->dma_addr = res.start;
> +				data->remote_heap->size = resource_size(&res);
> +			}
>   			src_perms = BIT(QCOM_SCM_VMID_HLOS);
>   
>   			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
> @@ -2438,7 +2414,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   			if (err)
>   				goto err_free_data;
>   		}
> -
>   	}
>   
>   	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
> @@ -2519,6 +2494,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   	struct fastrpc_buf *buf, *b;
>   	struct fastrpc_user *user;
>   	unsigned long flags;
> +	int err;
>   
>   	/* No invocations past this point */
>   	spin_lock_irqsave(&cctx->lock, flags);
> @@ -2536,8 +2512,22 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>   		list_del(&buf->node);
>   
> -	if (cctx->remote_heap)
> -		fastrpc_buf_free(cctx->remote_heap);

after removed the code, the cctx->remote_heap is not freed:
1. cctx->vmcount == 0
2. if (!err) is false

we should free the cctx->remote_heap unconditionally if it exists.

Thanks,
Jie

> +	if (cctx->remote_heap && cctx->vmcount) {
> +		u64 src_perms = 0;
> +		struct qcom_scm_vmperm dst_perms;
> +
> +		for (u32 i = 0; i < cctx->vmcount; i++)
> +			src_perms |= BIT(cctx->vmperms[i].vmid);
> +
> +		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
> +		dst_perms.perm = QCOM_SCM_PERM_RWX;
> +
> +		err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
> +					  cctx->remote_heap->size, &src_perms,
> +					  &dst_perms, 1);
> +		if (!err)
> +			kfree(cctx->remote_heap);
> +	}
>   
>   	of_platform_depopulate(&rpdev->dev);
>   

