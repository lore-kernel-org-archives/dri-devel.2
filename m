Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D34FCD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 04:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924CE10E0FA;
	Mon,  8 Jun 2026 04:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kd1l+XBT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W58V5JwO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F205910E0FA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 04:35:10 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6580FUtV1515198
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 04:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 foWwa/agnTOaYcmLBNq8rssldmrBJSpuoB845kBOVYU=; b=Kd1l+XBTNEgOvBoz
 F8pvzQAumWjiCDuZ8TWShetvk6qkzt4rFz0o9ZfjKMDZq9aWV9Y/5yAkcUjlq8GQ
 +zAPpplSuQqCwbh1RoiKNFn+vaESda/vj+D+vA+PGjKWgtNKQhUAF1VsorAd+BGC
 2wsviunnxPrGV5vlDVfuf2lQhKgm7OsUxqRMo7VFZoG86hWY5vMAWBQrKfx0+lV2
 BWzR2fMSQm04AqrznaU7EFIhhnNwt4xtVXT6IV/3iJN73DzoBxVPyZwzLGt5zRtw
 A1dEgndXYMYeGCtAPrboquMQdUWKgMtQFWMbQJ90ZZBrSv1uxRXQYO1jyKPT+ECO
 2UlMfA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcadwguf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 04:35:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8620ee0971so1434376a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780893310; x=1781498110;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=foWwa/agnTOaYcmLBNq8rssldmrBJSpuoB845kBOVYU=;
 b=W58V5JwOgVrqXLugi7pXljFd3NJhamGrSOVrECEh+Dhq2Z8W00jna6zMrBzdhm3KEX
 x7XEOgwKd5dbTVM4EC/AuEuTXCde9ujAvRRjDFFuUVOdTgnLjWq72Kbuy2G+Zc23b7PB
 4hIDgneKxKED4T54brNGrdd5FvkSpr9Ogw3HvkSY7jZmY2L04bC6/dR2+FNVJTV3mSUU
 P68oXqaQS8yXML7JB4y2Gd8DWwO4JSvyf71WcaJoWWo5Y4kMHiC8tVuV8TGMhsusM8Ss
 7CVPbC2ZVkLIgnX6Fof5vUZ3cMZ67b+fuOLeE7JiadUta7fSCwHdMaMq/CdslQ188RJa
 H39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780893310; x=1781498110;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=foWwa/agnTOaYcmLBNq8rssldmrBJSpuoB845kBOVYU=;
 b=STn3HmF3LDpSaZNhY0ZyDU1IBmDYmPw2iTaleFh5LCTBnE26r380jvFrM3IsMaBZiS
 DZ+I3DZb53jiMQejz90+9pDSM0GZ0Pkr3DOGwr+WQmiZE8aiu3dW+3j2jmEKmXPEJiiC
 EkXL27wIp+AinoREkmjLUe431UiCbyym0H5t4v9R+6B4cNfr8hx2hRkqCZ6bo7RiLYnu
 Nce477sglmOktZwaY4KiluCBpLw20Zj8QpaaGAClssE1NA7OA2pmNkwIlepRFBtubORP
 dWa3EA7xPvGDmpjMjGXIAZJJRELj3W4eJxANpChes/QPlJZFiNaiA9tb5c100oBsxPjs
 6/fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vRGglGBBW/mQu4e3zd0+C8BRtxTNQ0wgAk071Wdtvxsi5xN6u/xsEvGb9Qr9rzMY/pmRWlBkQXGE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyJQPz1vnqS2uUZdrgso3fXD6zI59iEKktiqDh4upDGVkJ6ZQA
 Cook5sxCYwX4KtHpiagV67+DHzeZXxelSN49Wwmhk+OsrPtp5dKa3CAzIZUlc9rEoTukRMfCzzD
 hx6itt9a8K3NFgarNReMZpxfgIQUJ/ifvuCIuKEkAXLdwu0YJONGsVQIeWeiBqOwa4xllGX0=
X-Gm-Gg: Acq92OHDd5FG8ZaxW4IPDuPjI528J+7/5BPNILs8hCIoCVJcmEn70gZXrJMkwuWotEi
 4rMIjliq1dTCXRVSC7lKK6CdirjagaGKmEvi2wz2yHiuhJSwh7spt+ZzBeysfjGVm5H+h7e4vJd
 4pEX9FUP69PNCsirzWqjjBotJc991Ogzl7C8gEtN7lXO8kkmUpDfl1mKEHHmHiRjUxxucFYNYOz
 P8R8Q+oHtwtUCbF+r91ggGRcyMc/4otp8K6/9RGHgFAzWDzxG22lsgKMHblYAV1iALx8E9/slw1
 3OeArIrLLoXRomTq0UgTLk5uo8uItSjpHBKCq8g1gS8uw5UNPo4cCCBg9gk1sK65hy1A8HMScqV
 3ejkSC9ANXvoxsx0zJZUmw7Sb759QXq6XC7CTWyi1bG/NOOBuCUHlSGaJ1qhGubTrWufAu9eRgJ
 KR3PBlXCAk/0L0IUcAL/N4oE1zPFk=
X-Received: by 2002:a05:6a20:c783:b0:3b4:8f4a:3bc6 with SMTP id
 adf61e73a8af0-3b4ccff305bmr16516198637.32.1780893309545; 
 Sun, 07 Jun 2026 21:35:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:c783:b0:3b4:8f4a:3bc6 with SMTP id
 adf61e73a8af0-3b4ccff305bmr16516165637.32.1780893309084; 
 Sun, 07 Jun 2026 21:35:09 -0700 (PDT)
Received: from [10.133.33.209] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df043ce0sm13914764a12.11.2026.06.07.21.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2026 21:35:08 -0700 (PDT)
Message-ID: <ba8252f0-5ec0-4c33-9969-e1acd1e4112d@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 12:35:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Jie Gan <jie.gan@oss.qualcomm.com>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
 <20260602071750.526-5-jianping.li@oss.qualcomm.com>
 <e0efec0d-b99c-4b71-bac4-4c04f243c4f6@oss.qualcomm.com>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, quic_chennak@quicinc.com,
 stable@kernel.org
In-Reply-To: <e0efec0d-b99c-4b71-bac4-4c04f243c4f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DIa/JSNb c=1 sm=1 tr=0 ts=6a26467e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zGuYPAm9eRiYiYFaMxgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: b8vcrmOUstQPZAN6cxgHLGQvKMib0sW3
X-Proofpoint-ORIG-GUID: b8vcrmOUstQPZAN6cxgHLGQvKMib0sW3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAzOCBTYWx0ZWRfXw+yLemeOFFxd
 yQyLAFsVVYtpSYNYO9uMiptS/7xqGLwFt4L75naa9CpQzlCOuSY2PDDpfGXbEUtsqsE5a81fyyy
 +uru0R/30+aJQ3fUsz+m7GRwHemBdajeHqb0nAbnmNSc/cbt/Q6FRJvcnwzn6VppBBYjF5naDpX
 d7fIo92K4cd8oKwuaPvUf2ThvV6XLQgNn8N8WomOE9VMSTl7iiHlOIVWhIGqJdUpb76Hs6cbUW5
 vhGq27PDAqDWamwgiC4mTjYFduz8pByO+aPbBGAdtgtxBEOyY4xf1wd5PRuAfY6x+G5z+sQ9LQY
 lPbD5buLv40H8Y3EjqtYaCTJxW4L2q6XhLV4//FUiPiZKcPb+V9Y63D0Ova72+USer20SLGLtiD
 CeP99Qsd4wpJi8H4snPKOI2+p9o8ia7VQzB+aVhqzAfjCEUbqzOCIq56Rx3Z3ml6VW1+2Y7Kd95
 khZp0sCvkB03JPXraHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080038
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


On 6/2/2026 5:41 PM, Jie Gan wrote:
>
>
> On 6/2/2026 3:17 PM, Jianping Li wrote:
>> Allocating and freeing Audio PD memory from userspace is unsafe because
>> the kernel cannot reliably determine when the DSP has finished using the
>> memory. Userspace may free buffers while they are still in use by the 
>> DSP,
>> and remote free requests cannot be safely trusted.
>>
>> Additionally, the current implementation allows userspace to repeatedly
>> grow the Audio PD heap, but does not support shrinking it. This can lead
>> to unbounded memory usage over time, effectively causing a memory leak.
>>
>> Fix this by allocating the entire Audio PD reserved-memory region during
>> rpmsg probe and tying its lifetime to the rpmsg channel. This removes
>> userspace-controlled alloc/free and ensures that memory is reclaimed 
>> only
>> when the DSP process is torn down.
>>
>> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
>> Cc: stable@kernel.org
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 96 +++++++++++++++++++-----------------------
>>   1 file changed, 43 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index f46a8f53970d..33be8bed6a0b 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -276,6 +276,8 @@ struct fastrpc_channel_ctx {
>>       struct kref refcount;
>>       /* Flag if dsp attributes are cached */
>>       bool valid_attributes;
>> +    /* Flag if audio PD init mem was allocated */
>> +    bool audio_init_mem;
>>       u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>>       struct fastrpc_device *secure_fdevice;
>>       struct fastrpc_device *fdevice;
>> @@ -1344,15 +1346,16 @@ static int 
>> fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>       struct fastrpc_init_create_static init;
>>       struct fastrpc_invoke_args *args;
>>       struct fastrpc_phy_page pages[1];
>> +    struct fastrpc_channel_ctx *cctx = fl->cctx;
>>       char *name;
>>       int err;
>> -    bool scm_done = false;
>>       struct {
>>           int client_id;
>>           u32 namelen;
>>           u32 pageslen;
>>       } inbuf;
>>       u32 sc;
>> +    unsigned long flags;
>>         if (!fl->cctx->remote_heap ||
>>           !fl->cctx->remote_heap->dma_addr ||
>> @@ -1383,31 +1386,6 @@ static int 
>> fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>       inbuf.client_id = fl->client_id;
>>       inbuf.namelen = init.namelen;
>>       inbuf.pageslen = 0;
>> -    if (!fl->cctx->remote_heap) {
>> -        err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
>> -                        &fl->cctx->remote_heap);
>> -        if (err)
>> -            goto err_name;
>> -
>> -        /* Map if we have any heap VMIDs associated with this ADSP 
>> Static Process. */
>> -        if (fl->cctx->vmcount) {
>> -            u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
>> -
>> -            err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
>> - (u64)fl->cctx->remote_heap->size,
>> -                            &src_perms,
>> -                            fl->cctx->vmperms, fl->cctx->vmcount);
>> -            if (err) {
>> -                dev_err(fl->sctx->dev,
>> -                    "Failed to assign memory with dma_addr %pad size 
>> 0x%llx err %d\n",
>> - &fl->cctx->remote_heap->dma_addr,
>> -                    fl->cctx->remote_heap->size, err);
>> -                goto err_map;
>> -            }
>> -            scm_done = true;
>> -            inbuf.pageslen = 1;
>> -        }
>> -    }
>>         fl->pd = USER_PD;
>>   @@ -1419,8 +1397,17 @@ static int 
>> fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>       args[1].length = inbuf.namelen;
>>       args[1].fd = -1;
>>   -    pages[0].addr = fl->cctx->remote_heap->dma_addr;
>> -    pages[0].size = fl->cctx->remote_heap->size;
>> +    spin_lock_irqsave(&cctx->lock, flags);
>> +    if (!fl->cctx->audio_init_mem) {
>> +        pages[0].addr = fl->cctx->remote_heap->dma_addr;
>> +        pages[0].size = fl->cctx->remote_heap->size;
>> +        fl->cctx->audio_init_mem = true;
>> +        inbuf.pageslen = 1;
>> +    } else {
>> +        pages[0].addr = 0;
>> +        pages[0].size = 0;
>> +    }
>> +    spin_unlock_irqrestore(&cctx->lock, flags);
>>         args[2].ptr = (u64)(uintptr_t) pages;
>>       args[2].length = sizeof(*pages);
>> @@ -1438,27 +1425,7 @@ static int 
>> fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>         return 0;
>>   err_invoke:
>> -    if (fl->cctx->vmcount && scm_done) {
>> -        u64 src_perms = 0;
>> -        struct qcom_scm_vmperm dst_perms;
>> -        u32 i;
>> -
>> -        for (i = 0; i < fl->cctx->vmcount; i++)
>> -            src_perms |= BIT(fl->cctx->vmperms[i].vmid);
>> -
>> -        dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>> -        dst_perms.perm = QCOM_SCM_PERM_RWX;
>> -        err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
>> - (u64)fl->cctx->remote_heap->size,
>> -                        &src_perms, &dst_perms, 1);
>> -        if (err)
>> -            dev_err(fl->sctx->dev, "Failed to assign memory dma_addr 
>> %pad size 0x%llx err %d\n",
>> -                &fl->cctx->remote_heap->dma_addr, 
>> fl->cctx->remote_heap->size, err);
>> -    }
>> -err_map:
>> -    fastrpc_buf_free(fl->cctx->remote_heap);
>> -    fl->cctx->remote_heap = NULL;
>> -err_name:
>> +    fl->cctx->audio_init_mem = false;
>>       kfree(name);
>>   err:
>>       kfree(args);
>> @@ -2425,12 +2392,21 @@ static int fastrpc_rpmsg_probe(struct 
>> rpmsg_device *rpdev)
>>           }
>>       }
>>   -    if (domain_id == SDSP_DOMAIN_ID) {
>> +    if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
>>           struct resource res;
>>           u64 src_perms;
>>             err = of_reserved_mem_region_to_resource(rdev->of_node, 
>> 0, &res);
>>           if (!err) {
>> +            if (domain_id == ADSP_DOMAIN_ID) {
>> +                data->remote_heap =
>> +                    kzalloc_obj(*data->remote_heap, GFP_KERNEL);
>> +                if (!data->remote_heap)
>> +                    return -ENOMEM;
>
> allocated data never free with directly return.
>
> goto err_free_data;
>
> Beside, we also need free data->remote_heap in err_free_data path as 
> you added new memory allocation.

I will adjust goto err_free_data, and add free(data->remote_heap) in 
err_free_data.

err_free_data:
     kfree(data->remote_heap);
     kfree(data);

>
>> +
>> +                data->remote_heap->dma_addr = res.start;
>> +                data->remote_heap->size = resource_size(&res);
>> +            }
>>               src_perms = BIT(QCOM_SCM_VMID_HLOS);
>>                 err = qcom_scm_assign_mem(res.start, 
>> resource_size(&res), &src_perms,
>> @@ -2438,7 +2414,6 @@ static int fastrpc_rpmsg_probe(struct 
>> rpmsg_device *rpdev)
>>               if (err)
>>                   goto err_free_data;
>>           }
>> -
>>       }
>>         secure_dsp = !(of_property_read_bool(rdev->of_node, 
>> "qcom,non-secure-domain"));
>> @@ -2519,6 +2494,7 @@ static void fastrpc_rpmsg_remove(struct 
>> rpmsg_device *rpdev)
>>       struct fastrpc_buf *buf, *b;
>>       struct fastrpc_user *user;
>>       unsigned long flags;
>> +    int err;
>>         /* No invocations past this point */
>>       spin_lock_irqsave(&cctx->lock, flags);
>> @@ -2536,8 +2512,22 @@ static void fastrpc_rpmsg_remove(struct 
>> rpmsg_device *rpdev)
>>       list_for_each_entry_safe(buf, b, 
>> &cctx->invoke_interrupted_mmaps, node)
>>           list_del(&buf->node);
>>   -    if (cctx->remote_heap)
>> -        fastrpc_buf_free(cctx->remote_heap);
>
> after removed the code, the cctx->remote_heap is not freed:
> 1. cctx->vmcount == 0
> 2. if (!err) is false
>
> we should free the cctx->remote_heap unconditionally if it exists.
>
> Thanks,
> Jie

You are right, after changing this to kfree here, the lifecycle should 
not be tied to whether the assignment is successful

so here we should kfree remote_heap every time.

err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
                       cctx->remote_heap->size, &src_perms,
                       &dst_perms, 1);

         if (err)
                 dev_err(&rpdev->dev,
                         "Failed to assign memory back to HLOS: dma_addr 
%pad size %#llx err %d\n",
                         &cctx->remote_heap->dma_addr,
                         cctx->remote_heap->size, err);
         }

         kfree(cctx->remote_heap);
         cctx->remote_heap = NULL;

>
>> +    if (cctx->remote_heap && cctx->vmcount) {
>> +        u64 src_perms = 0;
>> +        struct qcom_scm_vmperm dst_perms;
>> +
>> +        for (u32 i = 0; i < cctx->vmcount; i++)
>> +            src_perms |= BIT(cctx->vmperms[i].vmid);
>> +
>> +        dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>> +        dst_perms.perm = QCOM_SCM_PERM_RWX;
>> +
>> +        err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
>> +                      cctx->remote_heap->size, &src_perms,
>> +                      &dst_perms, 1);
>> +        if (!err)
>> +            kfree(cctx->remote_heap);
>> +    }
>>         of_platform_depopulate(&rpdev->dev);
>
