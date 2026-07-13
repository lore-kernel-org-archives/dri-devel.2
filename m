Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA27C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3297510E87B;
	Mon, 13 Jul 2026 08:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N3NNMC9W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0800E10E5B3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:58:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8864A419DF;
 Mon, 13 Jul 2026 08:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036DC1F00A3A;
 Mon, 13 Jul 2026 08:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783933099;
 bh=pAxpR9NFI9JqViz0jR02B8aYT21eVB9CVzgTB/HUmi0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=N3NNMC9WSVYvF0vTtvzbtTafU1C12Iav1SrwC0EHDSgNyIBN3QsjFcLHNCW0WuoOs
 HOKJk3TUhYJCgmvf+A6m7dKz7tF0TFWRlgGOIhP1zBFhk991wcoUHyemBtQscZaSPF
 grIi3qMtqMn45RAGuDAkEC6/nboWA9bdQvcIKdnVHm6KcvwBBMoWLYHGqXkY9oyJlr
 oFjNtNpk0uY2HsjWXWv5zbfX3/Gg2DBPhVIFf0bTB7ubjntp0SFesmP8h8I0Gt/xSN
 88OJJdFZ5SRjeF4qJaK+pQ618pedRSX36I/wbzJ4WVmBP5i5SKWsA4ipG29xZnTQB2
 Lc4KSxIsFJSJQ==
Message-ID: <0d40243b-0929-46d2-be85-e3248d4bd09c@kernel.org>
Date: Mon, 13 Jul 2026 10:58:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dma-buf: add dma_fence_was_initialized function v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, tursulin@ursulin.net, matthew.brost@intel.com,
 sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20260120105655.7134-1-christian.koenig@amd.com>
 <20260120105655.7134-2-christian.koenig@amd.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <20260120105655.7134-2-christian.koenig@amd.com>
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

Hi,

On 20. 01. 26, 11:54, Christian König wrote:
> Some driver use fence->ops to test if a fence was initialized or not.
> The problem is that this utilizes internal behavior of the dma_fence
> implementation.
> 
> So better abstract that into a function.
> 
> v2: use a flag instead of testing fence->ops, rename the function, move
>      to the beginning of the patch set.
...
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -146,7 +146,7 @@ qxl_release_free(struct qxl_device *qdev,
>   	idr_remove(&qdev->release_idr, release->id);
>   	spin_unlock(&qdev->release_idr_lock);
>   
> -	if (release->base.ops) {
> +	if (dma_fence_was_initialized(&release->base)) {
>   		WARN_ON(list_empty(&release->bos));
>   		qxl_release_free_list(release);
>   

This likely breaks qxl:
https://bugzilla.suse.com/show_bug.cgi?id=1271081

 > refcount_t: underflow; use-after-free.
 > WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90, 
CPU#0: kworker/0:0/1534
 > Modules linked in: af_packet nft_fib_inet ...
 > CPU: 0 UID: 0 PID: 1534 Comm: kworker/0:0 Not tainted 7.1.3-1-default 
#1 PREEMPT(full) openSUSE Tumbleweed 
b041a6527f6e58424f4cd3de0fade8d408b378fd
 > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
 > Workqueue: events qxl_gc_work [qxl]
 > RIP: 0010:refcount_warn_saturate+0x59/0x90
 > Code: 44 48 8d 3d a9 72 b7 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 
a8 72 b7 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d a7 72 b7 01 <67> 48 
0f b9 3a c3 cc cc cc cc 48 8d 3d a6 72 b7 01 67 48 0f b9 3a
 > RSP: 0018:ffffce09019efe00 EFLAGS: 00010246
 > RAX: 0000000000000000 RBX: ffff8b5a56f819c0 RCX: 0000000000000017
 > RDX: 0000000000011696 RSI: 0000000000000003 RDI: ffffffffbc953b70
 > RBP: ffff8b5a4a314000 R08: 0000000000000001 R09: ffffffffc07d488a
 > R10: fffffa6fc4787d80 R11: ffff8b5a40044000 R12: 0000000000000004
 > R13: 0000000000000003 R14: ffffce09003f1434 R15: ffff8b5a410c4640
 > FS:  0000000000000000(0000) GS:ffff8b5afe954000(0000) 
knlGS:0000000000000000
 > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 > CR2: 00007ff463d65000 CR3: 000000012b476004 CR4: 0000000000772ef0
 > PKRU: 55555554
 > Call Trace:
 >  <TASK>
 >  qxl_release_free+0xee/0xf0 [qxl 
d93e9381353e619799d56790f5f8dda6cce491f6]
 >  qxl_garbage_collect+0xd1/0x1b0 [qxl 
d93e9381353e619799d56790f5f8dda6cce491f6]
 >  process_one_work+0x19e/0x3a0
 > ...

The function does now:

 > void
 > qxl_release_free(struct qxl_device *qdev,
 >                  struct qxl_release *release)
 > {
 > ...
 >         if (dma_fence_was_initialized(&release->base)) {
 >                 WARN_ON(list_empty(&release->bos)); 

 >                 qxl_release_free_list(release); 

 > 

 >                 dma_fence_signal(&release->base); 

 >                 dma_fence_put(&release->base); 

  

refcount_dec_and_test() in kref_put() in this ^^ crashes. Apparently, 
the reference count was not increased anywhere. QXL does not call 
dma_fence_get() -- who is supposed to increase the refcount. And why it 
did not fail before?
  

 >         } else { 

 >                 qxl_release_free_list(release); 

 >                 kfree(release); 

 >         } 

 >         atomic_dec(&qdev->release_count); 

 > }

thanks,
-- 
js
suse labs

