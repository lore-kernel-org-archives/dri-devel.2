Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC918FED9E0
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0996A10E10F;
	Tue, 17 Mar 2026 15:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qxEe2DnE";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42DB10E10F
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773760913;
 bh=HVmafZgBoeoiVvY3lnwIWzn8T+6u5QCQd/KhDZqlFc0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qxEe2DnEgxCi3CBkQtZYeU2pGCZxRFfj3zQJJoZzQIgQDmQlCG8SHKTcv/38oRNFy
 5S4ymAJQPCLoOMkeOZbXboBx3248t9c7m0Kq1wnAaPUh6OxNx5Zb9OPyfxCDS36P+Y
 RfWS2DyaWtYs6wHOW8fIEG327QV/5vC1khxF7F11SapbsrAvhILXxMRvaLd6WYakXR
 u8/nhlEzTMY4EBQBghsHJvg9g19ibjj2W8KzJKdWUtiVjwWmL91KMzeBCcBQOJF71v
 5M3eutiaGixEeGsmW1O0Z6dSSgRLdO6RG4pKETcBbX9bJcwAHTlZe11kWxBJbAryO5
 lEMUgXbRBl1TQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D4FF717E12AA;
 Tue, 17 Mar 2026 16:21:52 +0100 (CET)
Date: Tue, 17 Mar 2026 16:21:47 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Christian =?UTF-8?B?S8O2bmln?=" <ckoenig.leichtzumerken@gmail.com>
Cc: phasta@mailbox.org, aliceryhl@google.com, gary@garyguo.net,
 lossin@kernel.org, daniel.almeida@collabora.com, joelagnelf@nvidia.com,
 sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] dma-buf/dma_fence: be more defensive in dma_fence_release
Message-ID: <20260317162147.4a7f03ff@fedora>
In-Reply-To: <20260317144825.2318-1-christian.koenig@amd.com>
References: <20260317144825.2318-1-christian.koenig@amd.com>
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

On Tue, 17 Mar 2026 15:48:25 +0100
"Christian K=C3=B6nig" <ckoenig.leichtzumerken@gmail.com> wrote:

> In case of a refcounting bug dma_fence_release() can be called before the
> fence was even signaled.
>=20
> Previously the dma_fence framework then force signaled the fence to make
> sure to unblock waiters, but that can potentially lead to random memory
> corruption when the DMA operation continues. So be more defensive here and
> pick the lesser evil.
>=20
> Instead of force signaling the fence set an error code on the fence,
> re-initialize the refcount to something large and taint the kernel.
>=20
> This will leak memory and eventually can cause a deadlock when the fence
> is never signaled, but at least we won't run into an use after free or
> random memory corruption.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/dma-buf/dma-fence.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 1826ba73094c..8bf07685a053 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -593,14 +593,24 @@ void dma_fence_release(struct kref *kref)
>  		/*
>  		 * Failed to signal before release, likely a refcounting issue.
>  		 *
> -		 * This should never happen, but if it does make sure that we
> -		 * don't leave chains dangling. We set the error flag first
> -		 * so that the callbacks know this signal is due to an error.
> +		 * This should never happen, but if try to be defensive and take
> +		 * the lesser evil. Initialize the refcount to something large,
> +		 * but not so large that it can overflow.
> +		 *
> +		 * That will leak memory and could deadlock if the fence never
> +		 * signals, but at least it doesn't cause an use after free or
> +		 * random memory corruption.
> +		 *
> +		 * Also taint the kernel to note that it is rather unreliable to
> +		 * continue.
>  		 */
>  		dma_fence_lock_irqsave(fence, flags);
>  		fence->error =3D -EDEADLK;
> -		dma_fence_signal_locked(fence);
> +		refcount_set(&fence->refcount.refcount, INT_MAX);

I'm not convinced this is useful. If we leak the object, no one should
have a ref to release anyway. This does raise a question though. The
case we're trying to protect against is fence_callback being registered
to this fence and waiting for an event to signal another proxy fence.
How can the refcnt drop to zero in that case? Isn't the proxy supposed
to own a ref on the fence. Before we go further, I'd like to understand
what we're trying to do.

The original discussion that led you to write this patch was about
detecting when a fence emitter/producer would leave unsignalled fences
behind, and the problem we have is when such unsignalled fences have
observers waiting for a "signalled" event. If the refcnt drops to zero
and the fence is released, we're already passed that point,
unfortunately. It can be that:

- the fence was never exposed -> this is fine
- the fence was exposed but never observed -> this is broken, because if
  it had been observed it would have led to a deadlock
- the fence was exposed, observed for some time, but the observer got
  bored, stopped waiting and:
  * decided to go and execute its stuff anyway -> use-before-ready
    situation
  * gave up -> kinda okay, but we should still consider the fence
    emitter broken
- the fence observer registered a callback but didn't take a ref on the
  object -> this is potential UAF on the dma_fence, which can also lead
  to a VRAM/system-mem UAF if the emitter drops the dma_fence without
  signalling, because of the auto-signal you're getting rid of in this
  patch.  But the latter is just a side effect of the dma_fence UAF,
  which I'm not convinced we should try to protect against.

>  		dma_fence_unlock_irqrestore(fence, flags);
> +		rcu_read_unlock();
> +		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
> +		return;
>  	}
> =20
>  	ops =3D rcu_dereference(fence->ops);

