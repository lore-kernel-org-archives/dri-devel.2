Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07580C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5E510F2B0;
	Fri, 28 Aug 2026 07:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YwT+QEdM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD23610F2B0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:46:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73BED407C6;
 Fri, 28 Aug 2026 07:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D691F000E9;
 Fri, 28 Aug 2026 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787903181;
 bh=L61cnVMZa7e5iRYyYqsI8v4DD3guDHOkaFSPGpNeKT8=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=YwT+QEdM35t48qvMClHJpp1753TRXDqcp2yEACGe50009LJBTcBzRi9/MKQFGLaZ6
 /pjIC5tR0zq7lf4IAyDVO0r0mq9mHAwjPBPldB1wxruHb/LxP50Bga5vlruAuqGg26
 3Ar1z6wjMgJnNTW3IrKPWTHUdTN4fOQk+SJWOjurEYt4KKPGS5px8GxCN15MlYAtKC
 fqOnTX+sW/qBQC9WfXWy4NAt7YNIPjr0xKQ4bd30A/Tv21KatxSelbgQFHwP/qLq+s
 kCEmhjAeg3ffKAQGYPAgA5JEoOvGX8GYihwoqE+2JRE6fCdgcjxKA29+u7VAREncVr
 UFsJ3IPsrzKWQ==
Message-ID: <f8b941a8-a468-4243-836e-aa6cebf6f3b3@kernel.org>
Date: Fri, 28 Aug 2026 09:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dma-buf: add dma_fence_was_initialized function v2
From: Jiri Slaby <jirislaby@kernel.org>
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, tursulin@ursulin.net,
 matthew.brost@intel.com, sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20260120105655.7134-1-christian.koenig@amd.com>
 <20260120105655.7134-2-christian.koenig@amd.com>
 <0d40243b-0929-46d2-be85-e3248d4bd09c@kernel.org>
 <aee97ce4aad6bcf63ce9e7066e20a4ff6f082669.camel@mailbox.org>
 <9edeaa17aebc284f1f171b1dd4d9ffee4721b750.camel@mailbox.org>
 <4b5b6dda-43a4-4488-9dbd-b0f92fcead61@kernel.org>
 <0b84716fa6bec4e38d811dc76926dd81e31e0c81.camel@mailbox.org>
 <5dd4248bccb446ef390e7149649632657db4aaae.camel@mailbox.org>
 <0df59c80-ae58-47d3-a96b-e878a17766a7@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <0df59c80-ae58-47d3-a96b-e878a17766a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 28. 08. 26, 9:29, Jiri Slaby wrote:
> On 19. 08. 26, 14:51, Philipp Stanner wrote:
>> On Wed, 2026-08-19 at 14:33 +0200, Philipp Stanner wrote:
>>
>>
>> […]
>>
>>>
>>> Regardless, looking at the code again, I would say that this might be a
>>> race, but I don't know enough about QXL to say for sure.
>>>
>>> dma_fence_init() is (of course) not ordered:
>>>
>>>
>>> static void
>>> __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops 
>>> *ops,
>>>              spinlock_t *lock, u64 context, u64 seqno, unsigned long 
>>> flags)
>>> {
>>>     BUG_ON(!ops || !ops->get_driver_name || !ops->get_timeline_name);
>>>
>>>     kref_init(&fence->refcount);
>>>     /*
>>>      * While it is counter intuitive to protect a constant function 
>>> pointer
>>>      * table by RCU it allows modules to wait for an RCU grace period
>>>      * before they unload, to make sure that nobody is executing their
>>>      * functions any more.
>>>      */
>>>     RCU_INIT_POINTER(fence->ops, ops);
>>>     INIT_LIST_HEAD(&fence->cb_list);
>>>     fence->context = context;
>>>     fence->seqno = seqno;
>>>     fence->flags = flags | BIT(DMA_FENCE_FLAG_INITIALIZED_BIT);
>>>
>>> (Should this maybe be set_bit() btw?)
>>>
>>>
>>> The fact that QXL could run into qxl_release_free() with an
>>> uninitialized fence hints at the fact that this might race, so
>>> DMA_FENCE_FLAG_INITIALIZED_BIT could be set / read before kref_init()
>>> ran.
>>>
>>>
>>> Maybe one way to verify / debug that would be to move
>>> spin_unlock(&qdev->release_idr_lock) downwards so it also guards
>>> dma_fence_was_initialized(), and also lock the initialization of the
>>> fence (in qxl_release_fence_buffer_objects() ?) with said lock.
>>>
>>> If that's possible. Just brainstorming a bit for ways how to debug.
>>>
>>> QXL does a few tricky things with the release->base.ops pointer.
>>> qxl_release_alloc() sets it to NULL, and only
>>> qxl_release_fence_buffer_objects() then actually sets it. So this could
>>> be the race? Setting of the ops pointer got replaced by setting of the
>>> fence-flag.
>>>
>>>
>>> P.
>>
>> Could you test something like this? (not even compile-tested, just an 
>> idea)
> 
> It makes the system dead during early boot :P.
> 
>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>> index 87797bea91cb..df1aa48b2809 100644
>> --- a/drivers/dma-buf/dma-fence.c
>> +++ b/drivers/dma-buf/dma-fence.c
>> @@ -1075,7 +1075,6 @@ __dma_fence_init(struct dma_fence *fence, const 
>> struct dma_fence_ops *ops,
>>          INIT_LIST_HEAD(&fence->cb_list);
>>          fence->context = context;
>>          fence->seqno = seqno;
>> -       fence->flags = flags | BIT(DMA_FENCE_FLAG_INITIALIZED_BIT);
>>          if (lock) {
>>                  fence->extern_lock = lock;
>>          } else {
>> @@ -1084,6 +1083,8 @@ __dma_fence_init(struct dma_fence *fence, const 
>> struct dma_fence_ops *ops,
> 
> This missing piece was here:
> -               fence->flags |= BIT(DMA_FENCE_FLAG_INLINE_LOCK_BIT);
> +               flags |= BIT(DMA_FENCE_FLAG_INLINE_LOCK_BIT);
> 
> 
>>          }
>>          fence->error = 0;
>> +       smp_mb();
>> +       fence->flags = flags | BIT(DMA_FENCE_FLAG_INITIALIZED_BIT);
>>          trace_dma_fence_init(fence);
>>   }
> 
> But it does not help either...

What helps is indeed the revert back to:

--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -147,7 +147,7 @@ qxl_release_free(struct qxl_device *qdev,
         idr_remove(&qdev->release_idr, release->id);
         spin_unlock(&qdev->release_idr_lock);

-       if (dma_fence_was_initialized(&release->base)) {
+       if (release->base.ops) {
                 WARN_ON(list_empty(&release->bos));
                 qxl_release_free_list(release);



Or the bool flag appears to help too:

--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -144,6 +144,7 @@ enum {
  #define QXL_MAX_RES 96
  struct qxl_release {
         struct dma_fence base;
+       bool uses_fence;

         int id;
         int type;
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -97,6 +97,7 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
                 return -ENOMEM;
         }
         release->base.ops = NULL;
+       release->uses_fence = false;
         release->type = type;
         release->release_offset = 0;
         release->surface_release_id = 0;
@@ -147,7 +148,7 @@ qxl_release_free(struct qxl_device *qdev,
         idr_remove(&qdev->release_idr, release->id);
         spin_unlock(&qdev->release_idr_lock);

-       if (dma_fence_was_initialized(&release->base)) {
+       if (release->uses_fence) {
                 WARN_ON(list_empty(&release->bos));
                 qxl_release_free_list(release);

@@ -431,6 +432,7 @@ void qxl_release_fence_buffer_objects(struct 
qxl_release *release)
          */
         dma_fence_init(&release->base, &qxl_fence_ops, &qdev->release_lock,
                        release->id | 0xf0000000, release->base.seqno);
+       release->uses_fence = true;
         trace_dma_fence_emit(&release->base);

         list_for_each_entry(entry, &release->bos, list) {


thanks,
-- 
js
suse labs

