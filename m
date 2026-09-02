Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D473C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B601F10E4A3;
	Wed,  2 Sep 2026 10:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fZLwp5TZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62CA10E4A3
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:47:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4072600D0;
 Wed,  2 Sep 2026 10:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3077A1F000E9;
 Wed,  2 Sep 2026 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788346025;
 bh=NMPfVN5CbaC96HtvVa8DpidRZa0TUnpKn2VRTVdV5ec=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fZLwp5TZrTiJ6QaK1nT8Uvuxd7F/m4iNUe4BaGRVzrqqkV/AEe2h29PAydWpqzWQs
 lFdlIjUmcRuF6eg6qGCTnjq0pBx/I5QgwP4oxJqqS/l87HMIt9FAhh14jpeNgBzazS
 ClOrKUJFgNFXnSE2ZUSysf5HwJ4OqShQWrBLgorw6WNEVVBzXxsEh4OL/pPGfxVavp
 i7Uii98uCb7VI3GLSNoxqsBLnMjAyvEOErZ+EHgoQ4pm+FfGwSlIeqgSepYMLfTK3R
 XZBEAByyFzXf5Nrp19c67P+hhLP0wFJnGfU5XPbLwUy8HgG3DqUQRNzBhowj2cN1pi
 4uBYg4WeK+3sA==
Message-ID: <275a55e8-543e-466d-a6a1-84776e763024@kernel.org>
Date: Wed, 2 Sep 2026 12:47:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dma-buf: add dma_fence_was_initialized function v2
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
 <f8b941a8-a468-4243-836e-aa6cebf6f3b3@kernel.org>
 <f923a6f6-8fef-43c8-8ac6-82c070e9b7b8@kernel.org>
 <ddab642c497354d2800e6139f7b0c073fd3981f1.camel@mailbox.org>
 <5be2d5f9-579f-4c5c-8463-a2505a6f0c74@kernel.org>
 <307d764629d7c5d2704b7897c8c0c32c1ef4ce33.camel@mailbox.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <307d764629d7c5d2704b7897c8c0c32c1ef4ce33.camel@mailbox.org>
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

On 02. 09. 26, 9:03, Philipp Stanner wrote:
> On Wed, 2026-09-02 at 08:56 +0200, Jiri Slaby wrote:
>> On 02. 09. 26, 8:52, Philipp Stanner wrote:
>>> On Fri, 2026-08-28 at 10:32 +0200, Jiri Slaby wrote:
>>>> On 28. 08. 26, 9:46, Jiri Slaby wrote:
>>>>> What helps is indeed the revert back to:
>>>>>
>>>>> --- a/drivers/gpu/drm/qxl/qxl_release.c
>>>>> +++ b/drivers/gpu/drm/qxl/qxl_release.c
>>>>> @@ -147,7 +147,7 @@ qxl_release_free(struct qxl_device *qdev,
>>>>>            idr_remove(&qdev->release_idr, release->id);
>>>>>            spin_unlock(&qdev->release_idr_lock);
>>>>>
>>>>> -       if (dma_fence_was_initialized(&release->base)) {
>>>>> +       if (release->base.ops) {
>>>>
>>>> Crap, the flags simple got garbage from previous freed buffer, so:
>>>> -       release = kmalloc(size, GFP_KERNEL);
>>>> +       release = kzalloc(size, GFP_KERNEL);
>>>>
>>>> fixes this of course. Patch coming.
>>>>
>>>> Now, the ops and initialized are either both set or unset:
>>>> qxl_release_free 1: release->base.ops=0x0 initialized=0 id=6 type=2
>>>> qxl_release_free 1: release->base.ops=qxl_fence_ops initialized=1 id=2
>>>> type=0
>>>>
>>>> Unlike before.
>>>>
>>>> FTR release->base.ops were NULLed after that kmalloc. Unlike
>>>> release->base.flags.
>>>
>>> You're saying that QXL is re-using that fence if it were uninitialized?
>>
>> Sort of. The fence was dropped and freed. Then a new memory was
>> allocated. And garbage from that allocation was used -- it might be the
>> old (freed) fence. Or anything else freed previously. Simply garbage.
> 
> 
> Maybe even dma_fence_init() should zero out the memory for maximum
> robustness.

That would not help as dma_fence_init() is called too late or not at all 
here...

dma_fence_init() is called late as the driver wants to call 
dma_fence_was_initialized() to distinguish the cases when the init was 
called and when not.

> We do that in drm_sched at a few places.
> 
> Opinions? @Christian?

-- 
js
suse labs
