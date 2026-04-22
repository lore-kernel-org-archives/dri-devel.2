Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017DEF9B60D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C8810E9A9;
	Wed, 22 Apr 2026 10:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UGJ9ffXv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iepx5AV1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BF810E9A9
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 10:32:50 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M98wUL1081113
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 10:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b1+18xNRgn9+Ez7xGrXINoqw7Xt1WZlAbcZjb5rCtck=; b=UGJ9ffXvVT/DFqeV
 4aDNynOAHN6FYTD++h3e5vgtbJL1wHnSX9U6rYlTeH4Pn234jUWGj7eefDCNfXQD
 rFTLUa5JFnXduvm+B4Jcr0SjcT3NwWIQurbj8zsWVNRIlvWTbvqbswwgQ9wSBm3T
 njScmfMte5VDiNrP7IsdFpOM4NZI/kX8qY1a79djZXBR1Vq2jXMu9nbW0dLxoTqr
 9Xjm7VqgloIIIruKa3vZR7u/mR+O/X1OmhU0mOmYyfGKEwyJdZH22E18Jn3uRDEU
 REUzg9VsPM8kW+Vqa9lvRhh+2FK7yYe69jPvrVUfF9r2LARvr84r5K06gJR1RDcX
 TLttYA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng30tk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 10:32:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b45cd0bb96so54097695ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776853967; x=1777458767;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b1+18xNRgn9+Ez7xGrXINoqw7Xt1WZlAbcZjb5rCtck=;
 b=Iepx5AV1tDicroTkzJ52Bc/WhTb6EOEsfNtOS5VHLEtU+jmZSdSV8guRl/g3zdBnUg
 gk1sLscOnFASMRx/jBmvK5ypcZLMFMWL/2Bcmpe5Wr96jVlHoC2Si+k847ZEA/NI/chp
 RPwVBHP8V8NRk83eFS3Y1kmN26+cq8GSo4znTJ4aL1RmKTS6STfyxCgNiD1oyB0A6ZwJ
 hxizgPmdQzTzWI64nqiZok3/LkJw0b+2Vs22+bKlrXUcvx+I8d2014cMFJfF1/4H6DfF
 eUxo55ncJppwcd7eTSCSFNPuIrNv++ST4q8WRJFCkDBGv1eWRmeaH/kiG9kmjE/sjfws
 rzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853967; x=1777458767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b1+18xNRgn9+Ez7xGrXINoqw7Xt1WZlAbcZjb5rCtck=;
 b=CEOu7C6s4uq81pRIR+S0q3I6bVPx5Uo+19R7nHi/yhEwCxPLoa/Dq15zgyiqw+EFWl
 3t/0LRHHVSMYLd4wYZ7C5dE4THZ7hpz4neJIslvw/pg6vp0agjuqUXzwpXuFs7qD6WwG
 J3R+2iyVdcGIMDkyAiUvC9SuXo6zwt8UNaUplmjLLorEWp4H0uBz/EstYkLVMJsCdmsf
 S4acspyKyvI9M4iwfIJtw70R+HucSo1d5a5zCl6eN5jSMo4tlj1Vq4bXLftd92gTCG9S
 XZ3bNwO3MIjW1Ce7RK90XqxskGB03eX47m1ssWCpU30VVZlxbdWQsRAI3ZjIOWFBkWIf
 QEJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ94Y/Pyg09j3ObMxpIrZoUfER2QKEk7V7TLZvQ59qiJ4EU0IjK/o/HBUAHviR9nM9xbAoB4oKWZj2E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxO0K8mO+oZaz+yTThTmlWKO4KqpBrcemoS1G/hBiCYoC1SorDL
 3Rx0xZ0r34RI96Qd7dbsO0NdeTEs/WZKFVHhOQmcNxH4hzSUvGF76hGn9R3ZszHmVB/+taanPKq
 5xdJmo/o50TJpKyeC06TaOpYkNDrkaLp8J+DYOGjtdm1OICYMrehY79nIB1CIudr6BrjZ08s=
X-Gm-Gg: AeBDiev+kGCknDXD0Ut11bINJ+wovTH8ZcGECrkzyMQ89HkS1bnLO0HzoQmZ8V8gMzR
 1qBYPL1DanhMoRmg9S/3wqOZqHHUQoVUSkd6O5DqDMaFigAI+iNoYNi4/LJCq8My9su5Piel7dm
 cUvO8UdiTiyIn8P7Cm6lGITvKXTyFPBMXBBFnkgUi1jXMbNSqXkP/FAt9P/uWzOwZVMDctzfo1g
 9fyMZkwtdl1twEkO9t2x7VwoH1Mol06Cb3z1Pk7+Wa8W5jQ+64p/82waOrfOozgRqhCQrYsukRF
 JxRXPcen94TSvL00g9iH5Rogeb0VXqqy98XeIb/aQDJTjNz2Oy3l3qcUympxwKEYJIWh40cEfTv
 H3x0FyVdpDeofUX7Jr1UJxVx7aL5GaCYoVA5jWZyyx/Wqh5SbS6dhW2Un
X-Received: by 2002:a17:902:f550:b0:2b2:4611:5dca with SMTP id
 d9443c01a7336-2b5f9f1c1edmr226337465ad.24.1776853966976; 
 Wed, 22 Apr 2026 03:32:46 -0700 (PDT)
X-Received: by 2002:a17:902:f550:b0:2b2:4611:5dca with SMTP id
 d9443c01a7336-2b5f9f1c1edmr226337085ad.24.1776853966401; 
 Wed, 22 Apr 2026 03:32:46 -0700 (PDT)
Received: from [10.206.98.126] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa16e72sm161353545ad.19.2026.04.22.03.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 03:32:46 -0700 (PDT)
Message-ID: <6e60a636-2693-4456-a63d-dd4165ec38ee@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 16:02:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] misc: fastrpc: Add reference counting for fastrpc_user
 structure
To: Srinivas Kandagatla <srini@kernel.org>, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
References: <20260226151121.818852-1-anandu.e@oss.qualcomm.com>
 <c0506a61-c5fb-4962-8bf1-6715178860b2@kernel.org>
Content-Language: en-US
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
In-Reply-To: <c0506a61-c5fb-4962-8bf1-6715178860b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CNUamxrD c=1 sm=1 tr=0 ts=69e8a3d0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e1tWFlzL7xBfjK-YGPgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: hVZa4fqVO55CDs28XegiGE4KOIPo7nvW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEwMCBTYWx0ZWRfX6YBj/5atssAZ
 Lioq5cTHc4mPcJ0K8HHfqWSXzeCaJnPj8zz1V0VTz8k5/FtHsBG/5coLCozNUGUd+pJOhGpKbXu
 shr2ik+wVZfIDuOwHoDHIbiUwqBmQ19OEQRwimtAdN23B/bRCdwa15RemzBc6WaQ2uIfEBdyQoI
 tQHxSpCxi53Ga8mHX2JPHvhtUlVvRBaDWgxI+pLCoezDXQ3lxuEWjmGpgWdRkhW40a0gy8r2jKP
 LYQ+1rDQrgLrtKI70YhzmsBxZ60cQUB2O7DC2ihenMK/887jYSwqp0CfH8yEnKZuyJ1SXIMoHRK
 Y1bODtRaKZodhfj/BNtSTtuVUrD1gCK2rW1f1vuzkFgZLx8JzDtpX38zWBFxgLYcsu7wgTGwZST
 L9V0DrqJ1nW7WgO2K3OuFNbBoHCN/RbiJHhflzYPcWEH6fsXNtsR2mqqog5370gT8/Vz+FfHF6h
 wD+QNrq5FBfdpp3Qiew==
X-Proofpoint-ORIG-GUID: hVZa4fqVO55CDs28XegiGE4KOIPo7nvW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220100
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


On 13-04-2026 06:39 pm, Srinivas Kandagatla wrote:
>
> On 2/26/26 3:11 PM, Anandu Krishnan E wrote:
>> Add reference counting using kref to the fastrpc_user structure to
>> prevent use-after-free issues when contexts are freed from workqueue
>> after device release.
>>
>> The issue occurs when fastrpc_device_release() frees the user structure
>> while invoke contexts are still pending in the workqueue. When the
>> workqueue later calls fastrpc_context_free(), it attempts to access
>> buf->fl->cctx in fastrpc_buf_free(), leading to a use-after-free:
> I guess these are some of the pending invoke requests that are still
> processing and receive callback after user closes the device.
>
>>    pc : fastrpc_buf_free+0x38/0x80 [fastrpc]
>>    lr : fastrpc_context_free+0xa8/0x1b0 [fastrpc]
>>    ...
>>    fastrpc_context_free+0xa8/0x1b0 [fastrpc]
>>    fastrpc_context_put_wq+0x78/0xa0 [fastrpc]
>>    process_one_work+0x180/0x450
>>    worker_thread+0x26c/0x388
>>
>> Implement proper reference counting to fix this:
>> - Initialize kref in fastrpc_device_open()
>> - Take a reference in fastrpc_context_alloc() for each context
>> - Release the reference in fastrpc_context_free() when context is freed
>> - Release the initial reference in fastrpc_device_release()
>>
>> This ensures the user structure remains valid as long as there are
>> contexts holding references to it, preventing the race condition.
>>
>> Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
>> Cc: stable@kernel.org
>> Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 35 +++++++++++++++++++++++++++++++----
>>   1 file changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 47356a5d5804..3ababcf327d7 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -310,6 +310,8 @@ struct fastrpc_user {
>>   	spinlock_t lock;
>>   	/* lock for allocations */
>>   	struct mutex mutex;
>> +	/* Reference count */
>> +	struct kref refcount;
>>   };
>>   
>>   /* Extract SMMU PA from consolidated IOVA */
>> @@ -497,15 +499,36 @@ static void fastrpc_channel_ctx_put(struct fastrpc_channel_ctx *cctx)
>>   	kref_put(&cctx->refcount, fastrpc_channel_ctx_free);
>>   }
>>   
>> +static void fastrpc_user_free(struct kref *ref)
>> +{
>> +	struct fastrpc_user *fl = container_of(ref, struct fastrpc_user, refcount);
>> +
>> +	fastrpc_channel_ctx_put(fl->cctx);
>> +	mutex_destroy(&fl->mutex);
>> +	kfree(fl);
>> +}
>> +
>> +static void fastrpc_user_get(struct fastrpc_user *fl)
>> +{
>> +	kref_get(&fl->refcount);
>> +}
>> +
>> +static void fastrpc_user_put(struct fastrpc_user *fl)
>> +{
>> +	kref_put(&fl->refcount, fastrpc_user_free);
>> +}
>> +
>>   static void fastrpc_context_free(struct kref *ref)
>>   {
>>   	struct fastrpc_invoke_ctx *ctx;
>>   	struct fastrpc_channel_ctx *cctx;
>> +	struct fastrpc_user *fl;
>>   	unsigned long flags;
>>   	int i;
>>   
>>   	ctx = container_of(ref, struct fastrpc_invoke_ctx, refcount);
>>   	cctx = ctx->cctx;
>> +	fl = ctx->fl;
>>   
>>   	for (i = 0; i < ctx->nbufs; i++)
>>   		fastrpc_map_put(ctx->maps[i]);
>> @@ -521,6 +544,8 @@ static void fastrpc_context_free(struct kref *ref)
>>   	kfree(ctx->olaps);
>>   	kfree(ctx);
>>   
>> +	/* Release the reference taken in fastrpc_context_alloc() */
>> +	fastrpc_user_put(fl);
>>   	fastrpc_channel_ctx_put(cctx);
>>   }
>>   
>> @@ -628,6 +653,8 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>>   
>>   	/* Released in fastrpc_context_put() */
>>   	fastrpc_channel_ctx_get(cctx);
>> +	/* Take a reference to user, released in fastrpc_context_free() */
>> +	fastrpc_user_get(user);
>>   
>>   	ctx->sc = sc;
>>   	ctx->retval = -1;
>> @@ -658,6 +685,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>>   	spin_lock(&user->lock);
>>   	list_del(&ctx->node);
>>   	spin_unlock(&user->lock);
>> +	fastrpc_user_put(user);
>>   	fastrpc_channel_ctx_put(cctx);
>>   	kfree(ctx->maps);
>>   	kfree(ctx->olaps);
>> @@ -1606,11 +1634,9 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
>>   	}
>>   
>>   	fastrpc_session_free(cctx, fl->sctx);
>> -	fastrpc_channel_ctx_put(cctx);
>> -
>> -	mutex_destroy(&fl->mutex);
>> -	kfree(fl);
>>   	file->private_data = NULL;
>> +	/* Release the reference taken in fastrpc_device_open */
>> +	fastrpc_user_put(fl);
> Now that we are trying to handle(wait) for the cases where wq will get
> callbacks after the fd is closed, how are we making sure that memory
> associated with these invoke, init memory and mmaps are not released?

I will move the cleanups to fastrpc_user_free so that cleanup wont happen until

all user references are released

>
>
> Also now that we have a refcount for the fastrpc_user, is it possible to
>   remove the refcount on the context, as this seems redundant now, we
> could just use the user refcount instead. May be other patch..

I will check on this and if possible to remove, i will share a separate patch

-Anandu

>
>
> --srini
>>   
>>   	return 0;
>>   }
>> @@ -1654,6 +1680,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
>>   	spin_lock_irqsave(&cctx->lock, flags);
>>   	list_add_tail(&fl->user, &cctx->users);
>>   	spin_unlock_irqrestore(&cctx->lock, flags);
>> +	kref_init(&fl->refcount);
>>   
>>   	return 0;
>>   }
