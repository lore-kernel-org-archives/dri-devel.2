Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7108C10854BE
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDCB10E109;
	Wed, 18 Mar 2026 09:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="G6l3fAYo";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF5310E109
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773825531;
 bh=G6exftMKtWNb4rf9ACEopeWwfAQ+/po/vPq9sMt0x6Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=G6l3fAYoEjZDM5ho9WQoARQvudC1p9JbgfNyoKOKyrNhKqD7KmAx+v3cQ6Vo/Bskc
 FWIA+bLbUVpfNP/kuHH79HyFF2SqFuFBQtR+GTAF5MUzQb5miavQx7vz9sawXZaSgk
 Y9lWpqFVLjPR+QHcY4d55CxlzelCrfMCXetS515N0uxYAaFo2BTz3uKAKLjcuo/FII
 ZrQcWEycJaYw/h4ezlgS+31ijfJ1HUky0ZyiCnQYQShIT5Xv5h7JRRrESqoYj1zo/U
 W+P4cw//0F5+g2lUq/Kr6TpXvJmb/vzX7e3B/fRWDzrpaensAFOtHsDDb5QM23Vh/7
 b6nyPaMuYE+kQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CA47617E026C;
 Wed, 18 Mar 2026 10:18:50 +0100 (CET)
Date: Wed, 18 Mar 2026 10:18:46 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: phasta@mailbox.org, aliceryhl@google.com, gary@garyguo.net,
 lossin@kernel.org, daniel.almeida@collabora.com, joelagnelf@nvidia.com,
 sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] dma-buf/dma_fence: be more defensive in dma_fence_release
Message-ID: <20260318101846.4747c9e5@fedora>
In-Reply-To: <3e7ce7bb-75ab-4f73-8a5d-dabd5d56cd61@amd.com>
References: <20260317144825.2318-1-christian.koenig@amd.com>
 <20260317162147.4a7f03ff@fedora>
 <3e7ce7bb-75ab-4f73-8a5d-dabd5d56cd61@amd.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Hi Christian,

On Wed, 18 Mar 2026 09:21:34 +0100
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> On 3/17/26 16:21, Boris Brezillon wrote:
> > On Tue, 17 Mar 2026 15:48:25 +0100
> > "Christian K=C3=B6nig" <ckoenig.leichtzumerken@gmail.com> wrote:
> >  =20
> >> In case of a refcounting bug dma_fence_release() can be called
> >> before the fence was even signaled.
> >>
> >> Previously the dma_fence framework then force signaled the fence
> >> to make sure to unblock waiters, but that can potentially lead to
> >> random memory corruption when the DMA operation continues. So be
> >> more defensive here and pick the lesser evil.
> >>
> >> Instead of force signaling the fence set an error code on the
> >> fence, re-initialize the refcount to something large and taint the
> >> kernel.
> >>
> >> This will leak memory and eventually can cause a deadlock when the
> >> fence is never signaled, but at least we won't run into an use
> >> after free or random memory corruption.
> >>
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> ---
> >>  drivers/dma-buf/dma-fence.c | 18 ++++++++++++++----
> >>  1 file changed, 14 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/dma-buf/dma-fence.c
> >> b/drivers/dma-buf/dma-fence.c index 1826ba73094c..8bf07685a053
> >> 100644 --- a/drivers/dma-buf/dma-fence.c
> >> +++ b/drivers/dma-buf/dma-fence.c
> >> @@ -593,14 +593,24 @@ void dma_fence_release(struct kref *kref)
> >>  		/*
> >>  		 * Failed to signal before release, likely a
> >> refcounting issue. *
> >> -		 * This should never happen, but if it does make
> >> sure that we
> >> -		 * don't leave chains dangling. We set the error
> >> flag first
> >> -		 * so that the callbacks know this signal is due
> >> to an error.
> >> +		 * This should never happen, but if try to be
> >> defensive and take
> >> +		 * the lesser evil. Initialize the refcount to
> >> something large,
> >> +		 * but not so large that it can overflow.
> >> +		 *
> >> +		 * That will leak memory and could deadlock if
> >> the fence never
> >> +		 * signals, but at least it doesn't cause an use
> >> after free or
> >> +		 * random memory corruption.
> >> +		 *
> >> +		 * Also taint the kernel to note that it is
> >> rather unreliable to
> >> +		 * continue.
> >>  		 */
> >>  		dma_fence_lock_irqsave(fence, flags);
> >>  		fence->error =3D -EDEADLK;
> >> -		dma_fence_signal_locked(fence);
> >> +		refcount_set(&fence->refcount.refcount, INT_MAX);
> >> =20
> >=20
> > I'm not convinced this is useful. If we leak the object, no one
> > should have a ref to release anyway. This does raise a question
> > though. The case we're trying to protect against is fence_callback
> > being registered to this fence and waiting for an event to signal
> > another proxy fence. =20
>=20
> Not quite. The real problematic case is that it is necessary to wait
> for a fence to signal with tons of memory management locks held.
>=20
> So it can be that a simple memory allocation cycles back and depends
> on the fence to signal.
>=20
> > How can the refcnt drop to zero in that case? Isn't the proxy
> > supposed to own a ref on the fence. Before we go further, I'd like
> > to understand what we're trying to do. =20
>=20
> Well we are in C here, so its simply coding errors. An unecessary
> dma_fence_put() in an error path is enough to trigger this.
>=20
> > The original discussion that led you to write this patch was about
> > detecting when a fence emitter/producer would leave unsignalled
> > fences behind, and the problem we have is when such unsignalled
> > fences have observers waiting for a "signalled" event. If the
> > refcnt drops to zero and the fence is released, we're already
> > passed that point, unfortunately. =20
>=20
> Well that is not quite correct.
>=20
> The most common problem is that we have unbalanced
> dma_fence_get()/dma_fence_put() and we end up in dma_fence_release()
> before the issuer of the dma_fence has a chance to signal it.

Okay, so that's clearly not solving the problem we were discussing on
[1], I thought it was related. Also, I'm still skeptical that we should
try and harden security for a situation that's already covered by
refcount overflow detection. I get why you want to do that, but it
feels like the wrong tool to me. I mean, we wouldn't even see it as
an unbalanced dma_fence_get/put() now that you manually set the refcount
to INT_MAX, which is the bug you're trying to cover for in the first
place.

>=20
> See the main purpose of DMA fences is to prevent releasing memory
> back into the core memory management before the DMA operation is
> completed.

That's a UAF, just a differnt kind (device UAF instead of CPU UAF).
Anyway, my point remains, the root of the issue you're covering for is
a dma_fence UAF (more put()s than get()s, and the CPU still has a ref
on a released dma_fence object). The outcome of this might be device
UAF because of the auto-signalling, but that's still just another
symptom of the dma_fence UAF (with wider consequences, admittedly).

>=20
> So when a DMA fence signals to early it means that the HW is still
> writing to that memory but we already potentially re-using the memory
> ending in random memory corruption.

Yep, I'm well aware of that.

>=20
> UAF issues are harmless compared to that.

That's not what I'm arguing against. What I'm saying is that you just
paper over an issue by messing up with the refcount, and now it's hard
to tell what the root cause is.=20

Regards,

Boris

[1]https://yhbt.net/lore/all/8bac1559-e139-4a74-a6e8-c2846093db72@amd.com/
