Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2630F34C40
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FED610E411;
	Mon, 13 Apr 2026 12:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OZvCdOy5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131C510E415
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=99x8APGcITMgMBZ7TxiCwbxYjL8CC2EzNIEr5FFICxM=; b=OZvCdOy52D+SChBNdxT+Xxeg5P
 coV5N+5BclZ5rwKcUERfb+JNYhk/9uZglRla4gyJsWTCFb2RBaROmohZuGg+xFRT49ftOVGa/cFE8
 gXIGq4OaPXkhmQ3MT9ytr3QJr2gzgzhxdY/SX3le+spninrTqIcjo/CWV55uqnCcTb7hHx2BYMc+9
 VACfjTUUzIiWAys38+n5cS66ughpr7ykFq1v3nUocqr5Die3WFs5+r2YbAPQaeGHZFm05/r/52kd2
 se7xSMGJ+QuSWSY7V24f4UEUP2JFC+lp0P6VIDkauCBfMgIe+GcOqiiCJ0VvdOtI8OCD6ZrTfmqBL
 GTI2+9XA==;
Received: from gwsc.sc.usp.br ([143.107.225.16] helo=[172.24.27.208])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wCFxb-00FO7r-FB; Mon, 13 Apr 2026 14:00:11 +0200
Message-ID: <a873a7ba-7309-4c80-86c1-2f009365266b@igalia.com>
Date: Mon, 13 Apr 2026 09:00:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kernel-dev@igalia.com
References: <20260411185756.1887119-4-mcanal@igalia.com>
 <59759507d4fb89d3726092268f17680998d1b4cf.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
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
In-Reply-To: <59759507d4fb89d3726092268f17680998d1b4cf.camel@mailbox.org>
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

Hi Philipp,

On 4/13/26 03:47, Philipp Stanner wrote:
> On Sat, 2026-04-11 at 15:47 -0300, Maíra Canal wrote:
>> The kerneldoc comment on dma_fence_init() and dma_fence_init64() describe
>> the legacy reason to pass an external lock as a need to prevent multiple
>> fences "from signaling out of order". However, this wording is a bit
>> misleading: a shared spinlock does not (and cannot) prevent the signaler
>> from signaling out of order. Signaling order is the driver's responsibility
>> regardless of whether the lock is shared or per-fence.
>>
>> What a shared lock actually provides is serialization of signaling and
>> observation across fences in a given context, so that observers never
>> see a later fence signaled while an earlier one is not.
>>
>> Reword both comments to describe this more accurately.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>
>> Hi,
>>
>> While reading the documentation, I found this particular paragraph quite
>> hard to understand. As I understand it, locks don't enforce order, only
>> serialization, but the paragraph seems to communicate the other way around.
> 
> Yes, 100%.
> That's one of the reasons why Christian recently moved to using inline-
> locks.
> 
> 
> 
>> Due to that, I had the impression that the current wording can be
>> misleading for driver developers.
>>
>> I'm proposing a new wording to better describe the use case of the
>> external lock based on my understanding, but it would be great to hear
>> the feedback and suggestions from more experienced developers who might
>> have more insight about these legacy use cases.
>>
>> Best regards,
>> - Maíra
>>
>>   drivers/dma-buf/dma-fence.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>> index 1826ba73094c..bdc29d1c1b5c 100644
>> --- a/drivers/dma-buf/dma-fence.c
>> +++ b/drivers/dma-buf/dma-fence.c
>> @@ -1102,8 +1102,10 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>    * to check which fence is later by simply using dma_fence_later().
>>    *
>>    * It is strongly discouraged to provide an external lock because this couples
>> - * lock and fence life time. This is only allowed for legacy use cases when
>> - * multiple fences need to be prevented from signaling out of order.
>> + * lock and fence lifetime. This is only allowed for legacy use cases that need
>> + * a shared lock to serialize signaling and observation of fences within a
>> + * context, so that observers never see a later fence signaled while an earlier
>> + * one isn't.
> 
> I would probably delete the explanation altogether and just state
> "allowed for legacy reasons". The legacy people know why it's allowed,
> and new users don't need to care. Same below of course.

Actually, I ended up in this part of the documentation as I'm thinking
about dropping the external lock in v3d driver. I was reading the docs
exactly to know if v3d is a legacy use case (spoiler: it isn't) and I
got confused by the current wording. So, I think there is value in
documenting the legacy use cases for the external lock.

Maybe, instead of "strongly discouraged", we could add a disclaimer
like: "New drivers MUST NOT use an external lock because...". What do
you think?

Best regards,
- Maíra

> 
> 
> Thx
> P.
> 
>>    */
>>   void
>>   dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>> @@ -1129,8 +1131,10 @@ EXPORT_SYMBOL(dma_fence_init);
>>    * to check which fence is later by simply using dma_fence_later().
>>    *
>>    * It is strongly discouraged to provide an external lock because this couples
>> - * lock and fence life time. This is only allowed for legacy use cases when
>> - * multiple fences need to be prevented from signaling out of order.
>> + * lock and fence lifetime. This is only allowed for legacy use cases that need
>> + * a shared lock to serialize signaling and observation of fences within a
>> + * context, so that observers never see a later fence signaled while an earlier
>> + * one isn't.
>>    */
>>   void
>>   dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
> 

