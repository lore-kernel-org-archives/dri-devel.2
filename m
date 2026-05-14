Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1296DCD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 22:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB1B10E3F2;
	Thu, 14 May 2026 22:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Zpu10FYE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5237D10E3F2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q/1w/pAVW95WK9YzKUDjOYOarf1ClcHbhkmttHS7cpI=; b=Zpu10FYEqHcf5dK5mAXU7fBhK7
 em6Ejvzaoyy8BTFnqAZIe0SI0dBEUhv4zrzj2VodLouEMeSd00khUXNEMPmi8NgUka83jpK6tSnSk
 wmsJN1XR94bx32Pvk2iO48yv+1G9WzwnrHU1VDsjCAnCGnjqn36M9zRDM/Ps28DYlUMfhQNP6uUck
 GMB4YDpGa7tv4bRmDrOhVrtDqg8qtGFl7ATRwo9N0ShIBkgy7iOlsE+Voz5B0oCbRbQZV6LrSJ0t/
 JFStnW0/Q7SrcF1vjt75mYYxwI0VXvjb0PHzMu02y3cVZmm6jbhZWR9KAD3OZu5iqp2fgKYm8STUt
 3gyNqxvg==;
Received: from [187.43.221.194] (helo=[172.20.10.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wNei7-000GaP-BI; Fri, 15 May 2026 00:39:19 +0200
Message-ID: <3c616d25-381e-43a7-af71-73bf0b9ee063@igalia.com>
Date: Thu, 14 May 2026 19:39:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kernel-dev@igalia.com
References: <20260419134943.54833-2-mcanal@igalia.com>
 <6389c57fd1453b545709c15c5fa74aa76a3d9afa.camel@mailbox.org>
 <d4267251-e113-42ae-b756-ea1ab63f9f7e@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <d4267251-e113-42ae-b756-ea1ab63f9f7e@igalia.com>
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

+cc Christian's AMD e-mail

On 5/4/26 11:47, Maíra Canal wrote:
> Hi Christian,
> 
> When possible, could you take a look at this patch? If you are okay with
> it, I can apply it to drm-misc-next.

Gentle ping.

Best regards,
- Maíra

> 
> Best regards,
> - Maíra
> 
> On 20/04/26 06:18, Philipp Stanner wrote:
>> On Sun, 2026-04-19 at 10:48 -0300, Maíra Canal wrote:
>>> The kerneldoc comment on dma_fence_init() and dma_fence_init64() 
>>> describe
>>> the legacy reason to pass an external lock as a need to prevent multiple
>>> fences "from signaling out of order". However, this wording is a bit
>>> misleading: a shared spinlock does not (and cannot) prevent the signaler
>>> from signaling out of order. Signaling order is the driver's 
>>> responsibility
>>> regardless of whether the lock is shared or per-fence.
>>>
>>> What a shared lock actually provides is serialization of signaling and
>>> observation across fences in a given context, so that observers never
>>> see a later fence signaled while an earlier one is not.
>>>
>>> Reword both comments to describe this more accurately.
>>>
>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>
>> Reviewed-by: Philipp Stanner <phasta@kernel.org>
>>
>>>
>>> ---
>>>
>>> v1 -> v2: https://lore.kernel.org/dri-devel/20260411185756.1887119-4- 
>>> mcanal@igalia.com/
>>>
>>> - Be more explicit about not allowing new users to use an external lock.
>>> - De-duplicate the explanation in dma_fence_init64() by pointing to the
>>>    dma_fence_init() documentation.
>>> ---
>>>   drivers/dma-buf/dma-fence.c | 13 +++++++------
>>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>>> index 1c1eaecaf1b0..63b349ba9a34 100644
>>> --- a/drivers/dma-buf/dma-fence.c
>>> +++ b/drivers/dma-buf/dma-fence.c
>>> @@ -1102,9 +1102,11 @@ __dma_fence_init(struct dma_fence *fence, 
>>> const struct dma_fence_ops *ops,
>>>    * context and seqno are used for easy comparison between fences, 
>>> allowing
>>>    * to check which fence is later by simply using dma_fence_later().
>>>    *
>>> - * It is strongly discouraged to provide an external lock because 
>>> this couples
>>> - * lock and fence life time. This is only allowed for legacy use 
>>> cases when
>>> - * multiple fences need to be prevented from signaling out of order.
>>> + * External locks are a relic from legacy use cases that needed a 
>>> shared lock
>>> + * to serialize signaling and observation of fences within a 
>>> context, so that
>>> + * observers never see a later fence signaled while an earlier one 
>>> isn't. New
>>> + * users MUST NOT use external locks, as they force the issuer to 
>>> outlive all
>>> + * fences that reference the lock.
>>>    */
>>>   void
>>>   dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops 
>>> *ops,
>>> @@ -1129,9 +1131,8 @@ EXPORT_SYMBOL(dma_fence_init);
>>>    * Context and seqno are used for easy comparison between fences, 
>>> allowing
>>>    * to check which fence is later by simply using dma_fence_later().
>>>    *
>>> - * It is strongly discouraged to provide an external lock because 
>>> this couples
>>> - * lock and fence life time. This is only allowed for legacy use 
>>> cases when
>>> - * multiple fences need to be prevented from signaling out of order.
>>> + * New users MUST NOT use external locks. Check the documentation in
>>> + * dma_fence_init() to understand the motives behind the legacy use 
>>> cases.
>>>    */
>>>   void
>>>   dma_fence_init64(struct dma_fence *fence, const struct 
>>> dma_fence_ops *ops,
>>
> 

