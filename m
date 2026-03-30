Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2734FB3CF7
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D0710E485;
	Mon, 30 Mar 2026 10:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCLMA0RL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jYIvE/IE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C06010E485
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:13:17 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U5ZhnQ2137081
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vLyumwZwV4Unes5NjG6rEnqvjaR0Ya3IUw6Dv70byeE=; b=YCLMA0RLZlVx7mKR
 X94PH9bIj8t1eptqra1e4Xa2os0Z9iCMnQp+e0CbZLI38CkHfpkU+wEXu2pGHBAT
 Pf5Zyq1g2gunxxk8oSXmhbBf20KXnwW+naU0L5+1mz3wsPLOhsXdV/fS85cFqBnO
 DnYlYSPC7D/06IBoBdsH4behyXhUQPPoMKGmjqiURiVr42ksqXkEtKZZqQb0kacU
 QOvjkJujG2n7C5YPfWmwxM/1t1NaH2j2HEi4SnXa/ueft8I6ZyEnZ1LXAIBqnGI0
 hqyD11SRgc6ZrmF+cnHMI8hyHqS6pS6yrz0JFMVLs5GBsg5dD2qaQl9t5oufY6cW
 SuSLog==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6ufmkrda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:13:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c70f19f0f37so2606300a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774865596; x=1775470396;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vLyumwZwV4Unes5NjG6rEnqvjaR0Ya3IUw6Dv70byeE=;
 b=jYIvE/IE2zh5JXwT738ZBfKk1lrnQhjTXukZ612kgEg2UXNi8qozuflxDszThUGETK
 7j78iiwYO6hmNxr9KW+xsPMuUaQC16WSLTHhiU7nTbmxBZB/8Tr4F2zmDROxdNK1ECNh
 J20KCrVoZtervwaAX2UNviZtK+9WJTq9GJ44pPykHwLLNPLndw1wz8VLEVYW/oRXPXVY
 LS7bM+2gFcFLdHNXYn5+91rNjCvGDBmmT0yhDiJgdzsDox4if2WxTwCPmbjYDNvrWWK3
 lou8xiblvCElZMjT0NOwlnsdE8DeT0Ll9Oxo+beIhE5+fggEg0atmMbGfo/i4H6g3ub+
 UATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774865596; x=1775470396;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vLyumwZwV4Unes5NjG6rEnqvjaR0Ya3IUw6Dv70byeE=;
 b=kZvIc2NBA40WfQoVgJ2xGPXXpr90Xs5aOy0x79a6USPGZrBPPb/k7sePtnODqFREmF
 eeAorT9gISxiuEo4t4KpIhoEVO7fk4Apf+8D5DJ1WwHIWRZXY+XJKGLOnl7vWwpFepfp
 hE2EqL5Tq57URmxWgHEt8b3WYnyIN4GY0iPQN7E/pTWU9h8PKiMLd7YH3zwVk3fsu59k
 XYOQnzkt1sDtUsYV2sBKfqNAVDn9y9ZT9EB4YvRnD7yEmLIGlDZK4VBl5AfNyxuAkS9s
 xmlIuzWwiAmtWjBuJMB1whhOFGGbpcR9mmS2/200fUtCqEcSLxL8K02xVl47IaxWd6Nj
 5Adg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZcXk7ADJ9bMKg66FU6TP2yxwi9DjBPWKvsn8PCgvk8miVNEC3c9HCLNAsQTIqoOBUrHsyfoW4Ut0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJfD2Fv3x/Jq++oPjWVUtuswTK7LQvZrZFVNZbIhzs3MHqxbF0
 IOs19lnaBCgbP42pmpqd5Xj6vRNYPMbCf/sDldu1xPOwQ772shGQmMuFPHX2tlfbGMD1ArVJQc8
 M5/G1cD3RmC9Vhdst9puFWxQZIRcUUMMOqiYItvVf80ArwdREF2/UjMHmbylOM96NGswTdfs=
X-Gm-Gg: ATEYQzxypHhGUjkdhVTooWByR71u2BZ7BrmsdSjpeIsSwV1df1X5/8cr8cFjfNo/x6o
 vxUodCDYvfudPME69qSWARKCFUyVtJe/k8Q3y8UA0oidm5hcU7QbHuBFb4tmkODXkDSMMYR6gRc
 MD0Pech9lJjTCgAH21qdsx1U3Olz12kw5Kb5R2s+uzHQ8l2XeuAuVlBGV8KwJfgbJa/q/VlP9sZ
 EsByajnbK3S2AvROY9Ms17Axc6lZcSHJkTb6cUTnd1g8VgImfkfuzmEMwC5hdo6Z4j3fCIjYuWO
 PCvPSj+X5NFm/hMjFR4+LzoS5o5aNQNOBr4U95sLcelV0eZY/+aIbezlZym7l4pKpAVKj/Xs2/3
 V8S7d4XoIRdtev42k3vzVh3E3u4HHZdjm7OJN5e6/z3lPIbk=
X-Received: by 2002:a05:6a00:99c:b0:7e8:3fcb:9b06 with SMTP id
 d2e1a72fcca58-82c86a1d3ffmr12451217b3a.28.1774865596075; 
 Mon, 30 Mar 2026 03:13:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:99c:b0:7e8:3fcb:9b06 with SMTP id
 d2e1a72fcca58-82c86a1d3ffmr12451184b3a.28.1774865595498; 
 Mon, 30 Mar 2026 03:13:15 -0700 (PDT)
Received: from [10.206.105.210] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8436f19sm6911855b3a.9.2026.03.30.03.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 03:13:14 -0700 (PDT)
Message-ID: <7cbc7fd2-3cd8-4a7d-8897-94de373e9f81@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 15:43:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] misc: fastrpc: Add reference counting for fastrpc_user
 structure
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
References: <20260226151121.818852-1-anandu.e@oss.qualcomm.com>
 <r4b67y3zbhclkdskbyobtypkrz5pszykvt2hitntvdimanuwe5@34uqxkc34ub7>
 <07d585fe-dfd1-41c9-9c58-b2f9893e572e@oss.qualcomm.com>
 <qoknqyxewirettcqlymmvnrrn5mft4ugf6zthvgmpeoapotct6@dundgjyvtjj2>
 <bb8a6e27-1b9b-4db6-b668-314a84b79b80@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <bb8a6e27-1b9b-4db6-b668-314a84b79b80@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4MCBTYWx0ZWRfXyJh2t2j8ovsb
 M4hUNbCQ3nn1XG/iSa3vg7sH8UfL07NNtPrBNVwMtmbKAz/4bOqRJaA08i1eEvKuqWFt5dc1s/X
 Q1t2ODb/zYoXEQ/kwDs+AvgvziwpOjjtq2QpXnoJ90n9hHZd8EAxN3/UqSMIYVt24u6jxrG1t6u
 8SabVJ9DxSs0IDtQPOncPOc2Rmk1Vnoq12kspSzRM6ZA3kNej5aOyDD5xq1FN/PxQ8QJm1qqV+R
 SZi5gaUkgRgyJuzhkU/hf4z0FutoGNhxXkQIxNLVOlAL8Z3Ybgwn7N9RjYkU/8A+gXZ+tE7N8pi
 PqvUAYmZKiiWhRaz9aP5EYM/mAer+mBNq9xSkv9mAWMMNqt1KBpijFzzCytOqDZ4OdkUoLEA92n
 NoKGsPyLd+XCcG2I/G02Rwz51aAAX3tHEbDSrui/+QV/wYUAjuoWpBdzwSDUyvDH/w4dL0FwVst
 LsAbkWaSF54hjiYRR/w==
X-Authority-Analysis: v=2.4 cv=aOT9aL9m c=1 sm=1 tr=0 ts=69ca4cbc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=eNZlvu6GDwxFnSIoZcoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: cPEJAa-ZvWZDVs0HPTw_2yMHhbOwt-Pt
X-Proofpoint-GUID: cPEJAa-ZvWZDVs0HPTw_2yMHhbOwt-Pt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300080
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



On 3/4/2026 8:05 PM, Anandu Krishnan E wrote:
>
>
> On 2/28/2026 12:44 AM, Bjorn Andersson wrote:
>> On Fri, Feb 27, 2026 at 07:52:00PM +0530, Anandu Krishnan E wrote:
>>>
>>> On 2/26/2026 11:20 PM, Bjorn Andersson wrote:
>>>> On Thu, Feb 26, 2026 at 08:41:21PM +0530, Anandu Krishnan E wrote:
>>>>> Add reference counting using kref to the fastrpc_user structure to
>>>>> prevent use-after-free issues when contexts are freed from workqueue
>>>>> after device release.
>>>> Please follow
>>>> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes 
>>>>
>>>> and start your commit message by clearly establishing the problem, 
>>>> once
>>>> that's done you can describe the technical solution.
>>> sure,  will update the commit message and send as patch v2.
>>>>> The issue occurs when fastrpc_device_release() frees the user 
>>>>> structure
>>>>> while invoke contexts are still pending in the workqueue. When the
>>>>> workqueue later calls fastrpc_context_free(), it attempts to access
>>>>> buf->fl->cctx in fastrpc_buf_free(), leading to a use-after-free:
>>>> But why does it do that?
>>>>
>>>> The reason why we need buf->fl->cctx in this context is because we 
>>>> need
>>>> to mask out the DMA address from the buf->dma_addr (remove the SID 
>>>> bits).
>>>>
>>>> If we instead split "dma_addr" into two separate members of struct
>>>> fastrpc_buf, one dma_addr_t dma_addr and one u64 iova_with_sid (?), 
>>>> then
>>>> it would be clear throughout the driver which address space we're
>>>> talking about (is it the SID-adjusted iova space or the dma_addr_t in
>>>> the particular DMA context).
>>>>
>>>> In addition to making this aspect of the driver easier to follow, 
>>>> you no
>>>> longer need to call fastrpc_ipa_to_dma_addr() in fastrpc_buf_free() 
>>>> (or
>>>> anywhere else for that matter).
>>>>
>>>> You can just pass buf->dma_addr directly to dma_free_coherent().
>>>>
>>>> You're isolating the fact that the firmware needs to see "SID |
>>>> dma_addr" to just two places in the driver.
>>> I agree with the refactoring direction you’re suggesting, and
>>> separating the address spaces does make the driver easier
>>> to reason about.
>>>
>>> That said, the UAF isn’t limited to the buffer
>>> free path. fastrpc_context_free() also calls fastrpc_map_put(),
>>> which reaches fastrpc_free_map() and still dereferences fl, so
>>> addressing only the buffer side doesn’t fully resolve the lifetime 
>>> issue.
>>> So the reference counting is still needed. I will update the 
>>> scenario in
>>> commit message as well.
>>>
>> I presume you're referring to the "vmid" we need to rebuild the
>> src_perms for use in fastrpc_free_map()?
>>
>> I think the relevant question to ask there is if it's really a property
>> of the "fastrpc file context". It seems to me that we could solve that
>> by storing the src_perms in the fastrpc_map once we've done the
>> qcom_scm_assign_mem() call in fastrpc_map_attach() - so that we can free
>> that object without having to reach out to objects of other lifetimes.
>>
>>> If you think it makes sense, I can take the address‑space refactoring
>>> as a separate follow‑up patch and keep this change focused on fixing
>>> the lifetime issue.
>> The chance of you fixing one lifetime issue by introducing one or more
>> worries me, I'm only familiar with the driver, so I wouldn't be able to
>> say with confidence without investing more time fully understand the
>> various lifetimes. So if we're going that path, I'd like someone else to
>> step up and tell me that it's good.
>>
>> On the other hand, the two changes I presented above are logically
>> simple to make, follow, and review - and they don't complicate the
>> driver further. So that would still be _my_ preferred choice.
> I understand your concerns about the ref count approach.
> But with the two above changes also UAF issue will still persist.
> In fastrpc_free_map() :
>
> if (map->fl) {
>     spin_lock(&map->fl->lock);
>     list_del(&map->node);
>     spin_unlock(&map->fl->lock);
>     map->fl = NULL;
> }
>
> we are using above logic to remove map node from the list.
> Here also we are using fl->lock to manage the map list and
> this map is part of fl->maps list as well.
>
>
> I suggested ref count change because it was handling all the
> scenarios we discussed above. I am open to any alternative
> suggestions as well.
>
> Regards,
> Anandu

Just a quick follow-up on my earlier reply.

My concern was that even with the two changes you suggested,
we still end up dereferencing fl->lock in fastrpc_free_map()
when removing the map from fl->maps, which could still
result in a UAF.

Since the reference-count approach addressed all the scenarios
we discussed, I wanted to check whether you’re okay with
proceeding in that direction. If you have an alternative
suggestion, I’d be happy to take that up. Alternatively,
if there are specific issues you see with the refcount
approach, I can review and address them from my side.

- Anandu

>
>>
>> [..]
>>>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>>>> index 47356a5d5804..3ababcf327d7 100644
>>>>> --- a/drivers/misc/fastrpc.c
>>>>> +++ b/drivers/misc/fastrpc.c
>>>>> @@ -310,6 +310,8 @@ struct fastrpc_user {
>>>>>        spinlock_t lock;
>>>>>        /* lock for allocations */
>>>>>        struct mutex mutex;
>>>>> +    /* Reference count */
>>>>> +    struct kref refcount;
>>>>>    };
>>>>>    /* Extract SMMU PA from consolidated IOVA */
>>>>> @@ -497,15 +499,36 @@ static void fastrpc_channel_ctx_put(struct 
>>>>> fastrpc_channel_ctx *cctx)
>>>>>        kref_put(&cctx->refcount, fastrpc_channel_ctx_free);
>>>>>    }
>>>>> +static void fastrpc_user_free(struct kref *ref)
>>>>> +{
>>>>> +    struct fastrpc_user *fl = container_of(ref, struct 
>>>>> fastrpc_user, refcount);
>>>> Unrelated question, what does the "fl" abbreviation actually mean? I
>>>> presume 'f' is for "fastrpc", but what is 'l'?
>>> fl is short for fastrpc file.
>>>
>> Hmm, okay. Thank you for clarifying.
>>
>> Regards,
>> Bjorn
>>
>>> Regards,
>>> Anandu
>>>> Regards,
>>>> Bjorn
>>>>> +
>>>>> +    fastrpc_channel_ctx_put(fl->cctx);
>>>>> +    mutex_destroy(&fl->mutex);
>>>>> +    kfree(fl);
>>>>> +}
>>>>> +
>>>>> +static void fastrpc_user_get(struct fastrpc_user *fl)
>>>>> +{
>>>>> +    kref_get(&fl->refcount);
>>>>> +}
>>>>> +
>>>>> +static void fastrpc_user_put(struct fastrpc_user *fl)
>>>>> +{
>>>>> +    kref_put(&fl->refcount, fastrpc_user_free);
>>>>> +}
>>>>> +
>>>>>    static void fastrpc_context_free(struct kref *ref)
>>>>>    {
>>>>>        struct fastrpc_invoke_ctx *ctx;
>>>>>        struct fastrpc_channel_ctx *cctx;
>>>>> +    struct fastrpc_user *fl;
>>>>>        unsigned long flags;
>>>>>        int i;
>>>>>        ctx = container_of(ref, struct fastrpc_invoke_ctx, refcount);
>>>>>        cctx = ctx->cctx;
>>>>> +    fl = ctx->fl;
>>>>>        for (i = 0; i < ctx->nbufs; i++)
>>>>>            fastrpc_map_put(ctx->maps[i]);
>>>>> @@ -521,6 +544,8 @@ static void fastrpc_context_free(struct kref 
>>>>> *ref)
>>>>>        kfree(ctx->olaps);
>>>>>        kfree(ctx);
>>>>> +    /* Release the reference taken in fastrpc_context_alloc() */
>>>>> +    fastrpc_user_put(fl);
>>>>>        fastrpc_channel_ctx_put(cctx);
>>>>>    }
>>>>> @@ -628,6 +653,8 @@ static struct fastrpc_invoke_ctx 
>>>>> *fastrpc_context_alloc(
>>>>>        /* Released in fastrpc_context_put() */
>>>>>        fastrpc_channel_ctx_get(cctx);
>>>>> +    /* Take a reference to user, released in 
>>>>> fastrpc_context_free() */
>>>>> +    fastrpc_user_get(user);
>>>>>        ctx->sc = sc;
>>>>>        ctx->retval = -1;
>>>>> @@ -658,6 +685,7 @@ static struct fastrpc_invoke_ctx 
>>>>> *fastrpc_context_alloc(
>>>>>        spin_lock(&user->lock);
>>>>>        list_del(&ctx->node);
>>>>>        spin_unlock(&user->lock);
>>>>> +    fastrpc_user_put(user);
>>>>>        fastrpc_channel_ctx_put(cctx);
>>>>>        kfree(ctx->maps);
>>>>>        kfree(ctx->olaps);
>>>>> @@ -1606,11 +1634,9 @@ static int fastrpc_device_release(struct 
>>>>> inode *inode, struct file *file)
>>>>>        }
>>>>>        fastrpc_session_free(cctx, fl->sctx);
>>>>> -    fastrpc_channel_ctx_put(cctx);
>>>>> -
>>>>> -    mutex_destroy(&fl->mutex);
>>>>> -    kfree(fl);
>>>>>        file->private_data = NULL;
>>>>> +    /* Release the reference taken in fastrpc_device_open */
>>>>> +    fastrpc_user_put(fl);
>>>>>        return 0;
>>>>>    }
>>>>> @@ -1654,6 +1680,7 @@ static int fastrpc_device_open(struct inode 
>>>>> *inode, struct file *filp)
>>>>>        spin_lock_irqsave(&cctx->lock, flags);
>>>>>        list_add_tail(&fl->user, &cctx->users);
>>>>>        spin_unlock_irqrestore(&cctx->lock, flags);
>>>>> +    kref_init(&fl->refcount);
>>>>>        return 0;
>>>>>    }
>>>>> -- 
>>>>> 2.34.1
>>>>>
>>>>>
>

