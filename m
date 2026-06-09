Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46837CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF1CA10E37E;
	Tue,  9 Jun 2026 13:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g/ofXEZ0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B3F710E37E
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QKvLq8kRz6hhe+0u7myfT7ziiQ0McNf7H3zbSoHITu0=; b=g/ofXEZ0li5JnqABqz55idaJiD
 kulKheE8I+9lZrTzHjVUjn9KKROxijsv4dPQKhcfmAi+coOg4tqbqDyU9584nP4Ph7J86gOkwVVTo
 YscA3es81FlQPbZbHoACJR1xyg8YqVfHrEpofN10Cou8hydcUsCKOCeBU43XpVEXARc/q0iybdfG8
 B8b5ZCtKgdW+TYoMFAt2+UhxM6wEMMISgdfijG+lpcZJd3NFq5YURJ4SW7bPqMkIFpZ6NdzShL0aL
 LKZHQEtnIUgopiLv1Gd9n6nOnjZLjqdw7C7IGbSvo3dIf9eermYQMemj4QfT9pvHTYlxNY0t966IT
 jTXCcXfg==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wWwd9-00Eybf-Jd; Tue, 09 Jun 2026 15:36:35 +0200
Message-ID: <dbda178c-bf02-448b-a88d-5a094adea5c0@igalia.com>
Date: Tue, 9 Jun 2026 14:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 airlied@gmail.com
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <dwlsalmeida@gmail.com>,
 Gary Guo <gary@garyguo.net>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
 <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
 <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
 <DJ3VYD71HDQ2.3C8GG983Z2YCM@kernel.org>
 <c8564ea0-8ff4-4049-996d-bd978c478372@amd.com>
 <aebe759117cd65004510946e39bd02e4c903e1e3.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <aebe759117cd65004510946e39bd02e4c903e1e3.camel@mailbox.org>
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


On 09/06/2026 14:19, Philipp Stanner wrote:
> +Cc Dave
> 
> On Mon, 2026-06-08 at 20:47 +0200, Christian König wrote:
>> On 6/8/26 20:39, Danilo Krummrich wrote:
>>> How did you get to this conclusion considering that you run into what I
>>> mentioned above as well and the fact that we seem to agree that the performance
>>> concern is rather questionable?
>>
>> Quite simple, it's the cleaner approach.
>>
>> Calling callbacks with locks held is rather questionable even putting the performance issue aside.
> 
> 
> I'm right now going through all fence users to see whether we can
> implement my solution.
> 
> And look what I found:
> 
> static inline bool
> nouveau_cli_work_ready(struct dma_fence *fence)
> {
> 	unsigned long flags;
> 	bool ret = true;
> 
> 	dma_fence_lock_irqsave(fence, flags);
> 	if (!dma_fence_is_signaled_locked(fence))
> 		ret = false;
> 	dma_fence_unlock_irqrestore(fence, flags);
> 
> 	if (ret == true)
> 		dma_fence_put(fence);
> 	return ret;
> }
> 
> 
> That looks weird, doesn't it?
> 
> 
> We do some git-blame:
> 
> c8a5d5ea3ba6a18958f8d76430e4cd68eea33943
> 
> and we find that it's Dave who wrote that code, because
> 
> "
>      My analysis: two threads are running, one in the irq signalling the
>      fence, in dma_fence_signal_timestamp_locked, it has done the
>      DMA_FENCE_FLAG_SIGNALLED_BIT setting, but hasn't yet reached the
>      callbacks.
>      
>      The second thread in nouveau_cli_work_ready, where it sees the fence is
>      signalled, so then puts the fence, cleanups the object and frees the
>      work item, which contains the callback.
>      
>      Thread one goes again and tries to call the callback and causes the
>      use-after-free.
> "
> 
> 
> So this is a race, caused by lockless speed optimization.
> 
> And it would further seem that there is one invention in computer
> science that can prevent such races:
> 
> Locks.
> 
> There is no cleaner, safer synchronization strategy in computer science
> than locking.
> 
> This race became possible because the lock does not guard the entirety
> of dma_fence_is_signaled().

One could also argue the problem was caused by sharing the fence 
reference without holding it, anyway, I wanted to ask something else. 
What happened to the idea to remove opportunistic signalling from 
dma_fence_is_signaled?

Regards,

Tvrtko

> 
> Wouldn't you agree that this is a strong indicator for the great
> advantages that consequent and consistent lock-protection grants? IOW,
> by using locks more strictly in dma_fence, we can increase its
> robustness and reliability.
> 
> 
> P.

