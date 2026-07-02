Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75F1C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D775510E1F6;
	Thu,  2 Jul 2026 04:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YI69gsla";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TVjn6iFL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B96E10E1F6
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:02:54 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KkWh3047252
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 04:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S9W8w7OdjpJqkYQrVpqOTZBE1FMiUuBplaVPcMbciTs=; b=YI69gslaxtjP7WKe
 MRIXn+3RItS/zEL0oysywiVNP9S4K9vgFvrL4NejWbis6Vo4xUgOZU4drUxE+l98
 d+LcunByJk6oK1zUYY+yWVVvA5RYD7w2BbNmHkla/u4f+lOnIxn7tkiOoBnloQPA
 /+LeSCPLNuv3l6V0vxUpEdjDs8BH6HrWPG7c54QrdLYIP1Va7B760LPzjxjCjn4w
 +JDdSRITeBfITMaRcwe3hSXAGQYtyc8ygPhrAxqPwDgcLpNihqoP72fTIP+nzEcd
 Mj4EbMjxQ0SXK/7d7fN48OnA6hYvTWVaVfA7WIbdxG6ynEGWoc6NPDr1lIuPqXSC
 mUyA3g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f58k39pdn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 04:02:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37d4f23eb37so2415389a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 21:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782964972; x=1783569772;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S9W8w7OdjpJqkYQrVpqOTZBE1FMiUuBplaVPcMbciTs=;
 b=TVjn6iFLLEoIWL5nE5TcXSCElqPmT9/Mmtfbsiu4YcY1Y+6uY7DRy08aK0iQb5jF3i
 kxM5JeytuNCQSXuocZtPFa7z5mLiWVb5pyA2HNcC+jsG1MEhrlJvtHZcScyUxVAzNN2f
 pyb40zGHZrOYOKXiyFxeCm5Dilgl32ZiGpciO0ncoE69I+dKOpUJvIwoAXhJwKpkmGIG
 KjZznGWqCTCwVCHGzhlJTSKgDxLK+w32swVLik8c1KYSntBV7Y2JSlBiCT9JRwYwf6Gc
 2BDb0lzVlnO4PQu6ed4VLGOABdl53uQ90cA3ttK6RD8q+DgZ0JMxe6A3qZYB1lyf6VD7
 FEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782964972; x=1783569772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S9W8w7OdjpJqkYQrVpqOTZBE1FMiUuBplaVPcMbciTs=;
 b=Z5wXPp+0tKDkmBceffBZuiSip33vjiYRdsSO0btMyOvby7JwZlGtIzTpTInB/aNWrv
 iEEM18jSyylH25RgyFNGfq+Ny+fuU/jP3yTPODw6krtgG1lCEPA/1O68hWqk4qPMGEFK
 on1QSNF0sqanZF29wDc8UvQEVNeTVTvKd6VtQTW/WQc4+GmMQy6NSmR1wf+iriLVHjt+
 a4+pjT6FWUv7BtStPEJ3yT0kMecvQUVQP72cMYYxWa6YXpvCaFbvCx1t9Q1uMKaucqpJ
 3DEbysg6BqqCwDL8EfmRR6OmRAnbpYW5C99qpU/HFkDl6ymb6ibItMB4T3SdD7sDI+Pp
 hhcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/s7kJm9AiqO1Lv4+OMeH4wXXPTlPw/ll/AlXCfpff+scMdvnSLnSyZjg0QHfhf0KJPF5tTdSmqQWU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFU1meo9Egyg5yESIEEhUAx94qGmtXIOH1ymKR6Wm4bSNm5/NY
 GeQ2gf2RbcRruUQwpUm7nrWt4dFWz8tpkSinDNT7A6AD73plKVT17ivmnaofUZzzohWp9x33NN4
 yvpeNjaK51O25X//nVZBvwWCR884/GYtJfYXalL3YoGtVfxQTuHqKpDbwsIPoe8aRxbYpC+OHpQ
 XEMmk=
X-Gm-Gg: AfdE7cn0SmDAhX9E7RRHPGvaUpb4wCLrqE1r7+f6UnrTksKOP8JZ23i+10mBY5gKAtL
 J71aFXA3gYzMlr9mSZsfzFtF6P8Y7Ag2sHWE1g4kDAE6BEfCSBzR942uvb8in7Nclj7jj9ScPcP
 DsSwuLwpV3SuIXSbxv0G5qPU/8vegSQrt2B2gMVo8Kjau3MSmsXZ68COzvX+1AO4r1tqb9LAnGG
 aqiIvMJz0IBnrvbz68RvpqPBoIcAP+Q2SJHJjkvWZHN24WcNfMxyUWlvUOTtohQBqVQ+NNu8W3h
 pURkM9DiDqUF3FK30FZrCFGe49MiDCz8RSjiY7JH3F6w5cNABzbvyUX0fLpueohjOInuuoFR+RB
 jfGpmL5WczdHS+6j4YSy1F9uAfx1PldHPrdkdYFaZ
X-Received: by 2002:a05:6a21:48d:b0:3bf:9fe1:c27 with SMTP id
 adf61e73a8af0-3bfed5018efmr5032491637.40.1782964971708; 
 Wed, 01 Jul 2026 21:02:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:48d:b0:3bf:9fe1:c27 with SMTP id
 adf61e73a8af0-3bfed5018efmr5032429637.40.1782964971004; 
 Wed, 01 Jul 2026 21:02:51 -0700 (PDT)
Received: from [10.204.78.220] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbdc4eesm4446432eec.24.2026.07.01.21.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 21:02:50 -0700 (PDT)
Message-ID: <a79182b2-2582-4c77-a859-b4d013b700f3@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 09:32:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Srinivas Kandagatla <srini@kernel.org>,
 Jianping Li <jianping.li@oss.qualcomm.com>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
References: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
 <20260609025938.457-4-jianping.li@oss.qualcomm.com>
 <cca276af-3e6a-44d3-a1b6-c2bc401a28cc@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <cca276af-3e6a-44d3-a1b6-c2bc401a28cc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAzNyBTYWx0ZWRfX72HwdJMTyTy3
 pn119oXN7TN6+cj+XueeMaUs7yUYtkcILeSfFT4ETDmjHPmc/LNTFbdDnZfxpXDyRZcOcjLeUrJ
 53LLCKm13L32AakInbeeU9e769eqfC2uIOO/QgUZZvAeSCexMno63veWsdCcF2QXagFe57ubHv6
 y+ZckhlOxh414zeGSX6d4jZeM6JyQ9tyTacLh4DQWwyZ5Dyo+CusgE2RAu736CnzWxnxh0KTuRs
 doJYLidy+60/MzHy/h4YsXYDTIRmoE6DAd1ca5LL+Pz2UTHP2BBHeV5sTovZ2QlGWaayVCpsXoK
 pFr/nTUuk1nayQFuGoJEsITWTlUlnquhpdbQ2Uv3gA+QQKpNejvj/ue+/HVrX1mCiC+OjaTK2/c
 +eFb8oOXR11y/WfX2mxWualKEprJ2aW/XRNVE6NIrm2U9OwUehkc0D+XXrGOpa6m3Gr5bmW1Fob
 iduoeMWev1s8gtDyQVQ==
X-Authority-Analysis: v=2.4 cv=SuGgLvO0 c=1 sm=1 tr=0 ts=6a45e2ec cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EWVka2mvqR4YGq0-U2gA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAzNyBTYWx0ZWRfX4RZ5s0EI7N1F
 kwn9t+0038sb/Tj/sPo1fIyZb1T4BYyqr67seji4h0C/0MVVzcdaER2qEyj2XHic2mKE/jcPleu
 arhiouDa4+CKlc41F15M5XPwQJYlTfg=
X-Proofpoint-ORIG-GUID: ZftnmjgHoZDzjsWLr1jZAX8XjRwUAuww
X-Proofpoint-GUID: ZftnmjgHoZDzjsWLr1jZAX8XjRwUAuww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020037
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

On 02-07-2026 02:07, Srinivas Kandagatla wrote:
> 
> 
> On 6/9/26 3:59 AM, Jianping Li wrote:
>> Allocating and freeing Audio PD memory from userspace is unsafe because
>> the kernel cannot reliably determine when the DSP has finished using the
>> memory. Userspace may free buffers while they are still in use by the DSP,
>> and remote free requests cannot be safely trusted.
>>
>> Additionally, the current implementation allows userspace to repeatedly
>> grow the Audio PD heap, but does not support shrinking it. This can lead
>> to unbounded memory usage over time, effectively causing a memory leak.
>>
>> Fix this by allocating the entire Audio PD reserved-memory region during
>> rpmsg probe and tying its lifetime to the rpmsg channel. This removes
>> userspace-controlled alloc/free and ensures that memory is reclaimed only
>> when the DSP process is torn down.
>>
>> Add explicit validation for remote_heap presence and size before sending
>> the memory to DSP, and fail early if the reserved-memory region is
>> missing or incomplete.
>>
>> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
>> Cc: stable@kernel.org
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>  drivers/misc/fastrpc.c | 112 ++++++++++++++++++++++-------------------
>>  1 file changed, 59 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 517884000331..1942e74535e5 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -276,6 +276,8 @@ struct fastrpc_channel_ctx {
>>  	struct kref refcount;
>>  	/* Flag if dsp attributes are cached */
>>  	bool valid_attributes;
>> +	/* Flag if audio PD init mem was allocated */
>> +	bool audio_init_mem;
>>  	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>>  	struct fastrpc_device *secure_fdevice;
>>  	struct fastrpc_device *fdevice;
>> @@ -1341,15 +1343,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>  	struct fastrpc_init_create_static init;
>>  	struct fastrpc_invoke_args *args;
>>  	struct fastrpc_phy_page pages[1];
>> +	struct fastrpc_channel_ctx *cctx = fl->cctx;
>>  	char *name;
>>  	int err;
>> -	bool scm_done = false;
>>  	struct {
>>  		int client_id;
>>  		u32 namelen;
>>  		u32 pageslen;
>>  	} inbuf;
>>  	u32 sc;
>> +	unsigned long flags;
>> +
>> +	if (!cctx->remote_heap || !cctx->remote_heap->dma_addr ||
>> +	    !cctx->remote_heap->size) {
>> +		err = -ENOMEM;
>> +		dev_err(fl->sctx->dev,
>> +			"remote heap memory region is not added\n");
>> +		return err;
>> +	}
>>  
>>  	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>>  	if (!args)
>> @@ -1373,31 +1384,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>  	inbuf.client_id = fl->client_id;
>>  	inbuf.namelen = init.namelen;
>>  	inbuf.pageslen = 0;
>> -	if (!fl->cctx->remote_heap) {
>> -		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
>> -						&fl->cctx->remote_heap);
>> -		if (err)
>> -			goto err_name;
>> -
>> -		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
>> -		if (fl->cctx->vmcount) {
>> -			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
>> -
>> -			err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
>> -							(u64)fl->cctx->remote_heap->size,
>> -							&src_perms,
>> -							fl->cctx->vmperms, fl->cctx->vmcount);
>> -			if (err) {
>> -				dev_err(fl->sctx->dev,
>> -					"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
>> -					&fl->cctx->remote_heap->dma_addr,
>> -					fl->cctx->remote_heap->size, err);
>> -				goto err_map;
>> -			}
>> -			scm_done = true;
>> -			inbuf.pageslen = 1;
>> -		}
>> -	}
>>  
>>  	fl->pd = USER_PD;
>>  
>> @@ -1409,8 +1395,17 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>  	args[1].length = inbuf.namelen;
>>  	args[1].fd = -1;
>>  
>> -	pages[0].addr = fl->cctx->remote_heap->dma_addr;
>> -	pages[0].size = fl->cctx->remote_heap->size;
>> +	spin_lock_irqsave(&cctx->lock, flags);
>> +	if (!cctx->audio_init_mem) {
>> +		pages[0].addr = cctx->remote_heap->dma_addr;
>> +		pages[0].size = cctx->remote_heap->size;
>> +		cctx->audio_init_mem = true;
>> +		inbuf.pageslen = 1;
>> +	} else {
>> +		pages[0].addr = 0;
>> +		pages[0].size = 0;
> 
> What is the expected behavoiur in this case?
Audio daemon is expected to take the memory information to DSP audio PD
only the first time it goes and attaches there.

This is the case where daemon was killed but audio PD session is still
running. In such cases, daemon is not expected to take any memory
information to audio PD as the earlier shared information is already
there with audio PD which it is using irrespective of daemon state.>
>> +	}
>> +	spin_unlock_irqrestore(&cctx->lock, flags);
>>  
>>  	args[2].ptr = (u64)(uintptr_t) pages;
>>  	args[2].length = sizeof(*pages);
>> @@ -1428,27 +1423,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>  
>>  	return 0;
>>  err_invoke:
>> -	if (fl->cctx->vmcount && scm_done) {
>> -		u64 src_perms = 0;
>> -		struct qcom_scm_vmperm dst_perms;
>> -		u32 i;
>> -
>> -		for (i = 0; i < fl->cctx->vmcount; i++)
>> -			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
>> -
>> -		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>> -		dst_perms.perm = QCOM_SCM_PERM_RWX;
>> -		err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
>> -						(u64)fl->cctx->remote_heap->size,
>> -						&src_perms, &dst_perms, 1);
>> -		if (err)
>> -			dev_err(fl->sctx->dev, "Failed to assign memory dma_addr %pad size 0x%llx err %d\n",
>> -				&fl->cctx->remote_heap->dma_addr, fl->cctx->remote_heap->size, err);
>> -	}
>> -err_map:
>> -	fastrpc_buf_free(fl->cctx->remote_heap);
>> -	fl->cctx->remote_heap = NULL;
>> -err_name:
>> +	cctx->audio_init_mem = false;
> this can race.
> 
>>  	kfree(name);
>>  err:
>>  	kfree(args);
>> @@ -2415,12 +2390,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>  		}
>>  	}
>>  
>> -	if (domain_id == SDSP_DOMAIN_ID) {
>> +	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
>>  		struct resource res;
>>  		u64 src_perms;
>>  
>>  		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
>>  		if (!err) {
>> +			if (domain_id == ADSP_DOMAIN_ID) {
>> +				data->remote_heap =
>> +					kzalloc_obj(*data->remote_heap, GFP_KERNEL);
>> +				if (!data->remote_heap) {
>> +					err = -ENOMEM;
>> +					goto err_free_data;
>> +				}
>> +
>> +				data->remote_heap->dma_addr = res.start;
>> +				data->remote_heap->size = resource_size(&res);
>> +			}
>>  			src_perms = BIT(QCOM_SCM_VMID_HLOS);
>>  
>>  			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
>> @@ -2428,7 +2414,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>  			if (err)
>>  				goto err_free_data;
>>  		}
>> -
>>  	}
>>  
>>  	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
>> @@ -2487,6 +2472,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>  		misc_deregister(&data->secure_fdevice->miscdev);
>>  
>>  err_free_data:
>> +	kfree(data->remote_heap);
>>  	kfree(data);
>>  	return err;
>>  }
>> @@ -2509,6 +2495,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>>  	struct fastrpc_buf *buf, *b;
>>  	struct fastrpc_user *user;
>>  	unsigned long flags;
>> +	int err;
>>  
>>  	/* No invocations past this point */
>>  	spin_lock_irqsave(&cctx->lock, flags);
>> @@ -2526,8 +2513,27 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>>  	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>>  		list_del(&buf->node);
>>  
>> -	if (cctx->remote_heap)
>> -		fastrpc_buf_free(cctx->remote_heap);
>> +	if (cctx->remote_heap && cctx->vmcount) {
>> +		u64 src_perms = 0;
>> +		struct qcom_scm_vmperm dst_perms;
>> +
>> +		for (u32 i = 0; i < cctx->vmcount; i++)
>> +			src_perms |= BIT(cctx->vmperms[i].vmid);
>> +
>> +		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>> +		dst_perms.perm = QCOM_SCM_PERM_RWX;
>> +
>> +		err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
>> +					  cctx->remote_heap->size, &src_perms,
>> +					  &dst_perms, 1);
>> +		if (err)
>> +			dev_err(&rpdev->dev,
>> +				"Failed to assign memory back to HLOS: dma_addr %pad size %#llx err %d\n",
>> +				&cctx->remote_heap->dma_addr, cctx->remote_heap->size, err);
>> +	}
>> +
>> +	kfree(cctx->remote_heap);
>> +	cctx->remote_heap = NULL;
>>  
>>  	of_platform_depopulate(&rpdev->dev);
>>  
> 

