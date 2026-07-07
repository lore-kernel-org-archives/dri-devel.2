Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5282C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F7C10EBF0;
	Tue,  7 Jul 2026 08:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dJCvceik";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yr4x1o2O";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2816E10EBF0
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 08:32:20 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678Dq7p3209269
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Jul 2026 08:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VouvbjaFsGUNSHVW3vymOiR/LkD//UOCZ6vwO722dTs=; b=dJCvceikkcklwupq
 yysajrwCw09QkMYAqfjPwPvmTjESX+6o61GsWcqW8LEwsmGVzSEjNozALmEDeKGp
 BgWncEG9+iT/xQ4Ye8HxJZ8kQ+kUTHQ4G0MKMahzGBIbz5Vb1J7AyOPVa1mccrVn
 XAJWalclwj0SDYoF8SIJVWQDF6MaEg/vUNU9hyjQ1WOvhsjtuoSpqMq9RG4/wlwD
 DmvjesWOgdL8Ua6sPR66vBukvcLAVSm1kWLFuPHMnj6jYnD7wMRocP81afcOF45C
 ysGLCYlDeHzWQclA3x0BUQEEtevCYS0PB+ydh+wqg6yQkz5E8ukchd4HJqNKAF9y
 /oce+g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdj8ed3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:32:18 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88d7a75507so6559528a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 01:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783413138; x=1784017938;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VouvbjaFsGUNSHVW3vymOiR/LkD//UOCZ6vwO722dTs=;
 b=Yr4x1o2O9xJIhH6tzRK5phpIkF5YhXZk+LeSf7RQb5a7/Kv9CGCgbFY2Qf4jqEQwSj
 ncToCrnecogMafFwjJLtEZfZV2sZ/xCCALgM70eUmMktoey56t5Y0Pi5rPLLLzin4B58
 nqh8vWX0jCqf3ZYKZ/7yCJqTrz3tpf8HoKRjuLDHAg0vxyaV8sYzjSQfhJ3cp0R/XEpY
 QIvv8R7Gk2t6tm6cupMCyH/ww1VAAadyvVzntzvgMBnecI5PDJYx3ITM4XMAj5DJUgen
 fjheg4JTYyzWa3yxDb/ZcDKG0UW6FzSzDWW3yIfgyYvaN596zKM8NME171eHibEAaqML
 O2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413138; x=1784017938;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VouvbjaFsGUNSHVW3vymOiR/LkD//UOCZ6vwO722dTs=;
 b=E9wmaL9Yc14T4XphiQdn/IQyboq99BzXpG9PXjsOr+3aWUq4pTf8M0deTJkaJTBelJ
 QKYoTOtoITqARkd5BqHlUTPkhDOHqO5gqK76EDFc9yR+zeFzULjNV44s+5pheXujZcz6
 TVDAp7aJwYU+eJzhLAzpxB1iVITLEJY1JBsAxaT9iS0EJGhAvzFRKMopi74AgiXCaX2x
 KPS99rTAiiNB6h878xqS0VwUZf3er+8MGSm4+FYZOwmZYuvaxengHq40FdypxstZFYaH
 RBZL0Rc1XvCQD79N2s4k+s51/6qa2/qIT/e2+eDBCwEOJVHH80rwH/7FEO69KP7gCkAl
 ck0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoRZT9vTxIVwayOlsOBndcJjPEYwrA5U2aU3FXA9t0Sab+SqvMofcnxyvWAlYhRdmkv17wLX0TMcE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwNcL63IfVTwQ6M8lbwYln+4Qf5JFJv4cTQwm0fczlji9uaWSR
 ODLEhVAvWhDrIPkphS75jj5xkVA1/fHWxFwMx4W2Ow6Xi+FEXgsJ2A/WkCAv2VrxLbCPaE4MpVp
 xHh4AiVB9VzuRG+C28gjM5j/PJaGSbh+zjqNPoEljHjDul2KQBelggtGQl1MsGLGpQLe5WeQ=
X-Gm-Gg: AfdE7cn15ZOqU77gv00dyqcHf5ysqV39I8iFj2l6cGAtCQfVUiIAfsUuXJaC14ZCJw/
 RnmJXnNKU2zlqG7mKjkAqIVB1kfr+feMwcUAU/Pj7ZSYrt6KqLTxqqRKABz/66X9u6WoKXDHfKK
 xovM31B+RyGu6YvhoGqFstRmhZdjbwfnWbFaFDSmhykCOcLXHBu6U9YM0bEcWeHFJXMo/3F4Pi4
 Ccgbihn5ek1H/V/CeZAw3aoILup/D5fFy63Ek772CzcKiFmZdGn92yh/wkIF4r4a6wl857+TWgc
 a4LxhBcCIKVIDZF3bG4JvuSVs1KkV/Z/YWiPJ6WQ+TuVvdmaUCQwB1Otr3RV/ByieviklekTuWe
 JRXbnUYt2BU71jJ4PqoW6FSBqWFtCHEwsBMLbITh16zzhfhDsVX84n/f098sXoZLIFdbcuekI/S
 skLmFpvA==
X-Received: by 2002:a17:90a:e704:b0:381:e73:3c2e with SMTP id
 98e67ed59e1d1-38758a364e3mr4428492a91.24.1783413136952; 
 Tue, 07 Jul 2026 01:32:16 -0700 (PDT)
X-Received: by 2002:a17:90a:e704:b0:381:e73:3c2e with SMTP id
 98e67ed59e1d1-38758a364e3mr4428451a91.24.1783413136394; 
 Tue, 07 Jul 2026 01:32:16 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d3a65609sm683410a91.14.2026.07.07.01.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 01:32:15 -0700 (PDT)
Message-ID: <2467f7a8-d7c7-41be-aae9-04a5dcadd15c@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 16:32:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
References: <20260707061733.495-1-jianping.li@oss.qualcomm.com>
 <1e7d0b9f-380b-41a2-8aba-7ab25c6a8680@oss.qualcomm.com>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <1e7d0b9f-380b-41a2-8aba-7ab25c6a8680@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4cb993 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Yk0qE0SaCswAtkPT5K8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: aS07ENT1U-07ca1zf6lvFKwyEeEtKJhj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4MSBTYWx0ZWRfX5mfLdY00zWOX
 o4WDQj7qFPDYL6mye+8Xp9jDcJErZLfWoejwufnjVT7bt7JcEtca9WQIWgab6bhf3LZ13sZewSm
 EpzaYy9Sq+5T2eiEB9W4IQrwi2mXTA8FD4kaxgHMe3i4sF0qhvqoAOVnWgpY7eKIdYOd82U1Kp4
 3tgHu0L5P4tp7DngDfhqw94UB+QlBQ20yS9GERc0sr3TIb2+euG0zUK1r/sVUC5NybyweuokJAB
 jOx+L0duFhiELThR3ecZmH6lMtG5tKrc2m4Bqwd2FbrbleQf9RJ6IKCd/a8OgDgvoRhf+F8YzDc
 dc0kFLmWOmz5IgB1SlmguQsyFiZH1RaCxoznXqM45D+V6a97VTHlC3uldQ95LFKFcdivhx0JFoB
 WvwoxHrCw+re3XdmlpzwLcIQ3tnnHZjyoX4/yhBjxQ0HM6CQt7WNM72z326h+DKGNVv8oAqYhDm
 ZU93uSLcIVyl9CsHEfw==
X-Proofpoint-ORIG-GUID: aS07ENT1U-07ca1zf6lvFKwyEeEtKJhj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4MSBTYWx0ZWRfX3ABdPoha3y2l
 84cOjwCD9TqsCLpB1MNpRJNLYQLUtYO/OMBRntVNui2DQODpGMoJMhaiDiC4JGf6ItBBuoSv3sN
 msbKRBeN/d7xVgM+bggehm3F6lXWHog=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070081
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


On 7/7/2026 3:01 PM, Ekansh Gupta wrote:
> On 07-07-2026 11:47, Jianping Li wrote:
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
> Changes in vN and lore link to v(N-1) series would help here.>
> drivers/misc/fastrpc.c | 119 +++++++++++++++++++++++------------------

Will add changelog and lore link in next version.

>>   1 file changed, 66 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index d86e79134c68..1ec37e6c68a2 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -276,6 +276,8 @@ struct fastrpc_channel_ctx {
>>   	struct kref refcount;
>>   	/* Flag if dsp attributes are cached */
>>   	bool valid_attributes;
>> +	/* Flag if audio PD init mem was allocated */
>> +	bool audio_init_mem;
>>   	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>>   	struct fastrpc_device *secure_fdevice;
>>   	struct fastrpc_device *fdevice;
>> @@ -1344,15 +1346,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   	struct fastrpc_init_create_static init;
>>   	struct fastrpc_invoke_args *args;
>>   	struct fastrpc_phy_page pages[1];
>> +	struct fastrpc_channel_ctx *cctx = fl->cctx;
>>   	char *name;
>>   	int err;
>> -	bool scm_done = false;
>>   	struct {
>>   		int client_id;
>>   		u32 namelen;
>>   		u32 pageslen;
>>   	} inbuf;
>>   	u32 sc;
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
>>   	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>>   	if (!args)
>> @@ -1376,31 +1387,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   	inbuf.client_id = fl->client_id;
>>   	inbuf.namelen = init.namelen;
>>   	inbuf.pageslen = 0;
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
>>   	fl->pd = USER_PD;
>>   
>> @@ -1412,8 +1398,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   	args[1].length = inbuf.namelen;
>>   	args[1].fd = -1;
>>   
>> -	pages[0].addr = fl->cctx->remote_heap->dma_addr;
>> -	pages[0].size = fl->cctx->remote_heap->size;
>> +	/*
>> +	 * Audio PD is a static PD and retains the remote heap
>> +	 * information across daemon restarts. Therefore only
>> +	 * the first attach should provide heap information to
>> +	 * DSP. Subsequent attaches reuse the previously
>> +	 * initialized memory pool.
>> +	 */
>> +	spin_lock_irqsave(&cctx->lock, flags);
>> +	if (!cctx->audio_init_mem) {
>> +		pages[0].addr = cctx->remote_heap->dma_addr;
>> +		pages[0].size = cctx->remote_heap->size;
>> +		cctx->audio_init_mem = true;
>> +		inbuf.pageslen = 1;
>> +	} else {
>> +		pages[0].addr = 0;
>> +		pages[0].size = 0;
>> +	}
>> +	spin_unlock_irqrestore(&cctx->lock, flags);
>>   
>>   	args[2].ptr = (u64)(uintptr_t) pages;
>>   	args[2].length = sizeof(*pages);
>> @@ -1431,27 +1433,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   
>>   	return 0;
>>   err_invoke:
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
>>   	kfree(name);
>>   err:
>>   	kfree(args);
>> @@ -2418,12 +2400,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   		}
>>   	}
>>   
>> -	if (domain_id == SDSP_DOMAIN_ID) {
>> +	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
>>   		struct resource res;
>>   		u64 src_perms;
>>   
>>   		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
>>   		if (!err) {
>> +			if (domain_id == ADSP_DOMAIN_ID) {
>> +				data->remote_heap =
>> +					kzalloc_obj(*data->remote_heap, GFP_KERNEL);
> drop GFP_KERNEL from kzalloc_obj()> +				if (!data->remote_heap) {

ACK,I'll drop GFP_KERNEL.

>> +					err = -ENOMEM;
>> +					goto err_free_data;
>> +				}
>> +
>> +				data->remote_heap->dma_addr = res.start;
>> +				data->remote_heap->size = resource_size(&res);
>> +			}
>>   			src_perms = BIT(QCOM_SCM_VMID_HLOS);
>>   
>>   			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
>> @@ -2431,7 +2424,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   			if (err)
>>   				goto err_free_data;
>>   		}
>> -
>>   	}
>>   
>>   	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
>> @@ -2490,6 +2482,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   		misc_deregister(&data->secure_fdevice->miscdev);
>>   
>>   err_free_data:
>> +	kfree(data->remote_heap);
>>   	kfree(data);
>>   	return err;
>>   }
>> @@ -2512,6 +2505,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>>   	struct fastrpc_buf *buf, *b;
>>   	struct fastrpc_user *user;
>>   	unsigned long flags;
>> +	int err;
>>   
>>   	/* No invocations past this point */
>>   	spin_lock_irqsave(&cctx->lock, flags);
>> @@ -2529,8 +2523,27 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>>   	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>>   		list_del(&buf->node);
>>   
>> -	if (cctx->remote_heap)
>> -		fastrpc_buf_free(cctx->remote_heap);
>> +	if (cctx->remote_heap && cctx->vmcount) {
>> +		u64 src_perms = 0;
>> +		struct qcom_scm_vmperm dst_perms;
>> +
>> +		for (u32 i = 0; i < cctx->vmcount; i++)
> for the iterator use top-of-block declaration style for consistency> +		
> src_perms |= BIT(cctx->vmperms[i].vmid);

Will fix.

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
>>   	of_platform_depopulate(&rpdev->dev);
>>   
