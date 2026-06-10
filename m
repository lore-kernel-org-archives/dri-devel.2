Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1E2CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC0710E9A5;
	Wed, 10 Jun 2026 14:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lqp8mx8H";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6984A10E9A5
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:26:06 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gb7P63gr5z9v5N;
 Wed, 10 Jun 2026 16:26:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781101562; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ba7dAEjBvnIdwE/UUkPnazFaH+M4/LlZmd8HMMY9Jgo=;
 b=lqp8mx8HbpRI+/ZQ2xleahO3HmEzVva/87XnAlNFxjTRPkcQe63lLBY6nry05wXbS1On+u
 EdoKp9h9YcyJn/IEcHdo/er2JncjOZkrQcpERfg0DZGf+j9AilJ9fbNWg7BXCJKe29aaIS
 7GKsWnX1L3QngYCu/+6PR2l7+VNbONSP9Y3q4qpEupVyrCAj125yCuObCPhWnH7AYSMppO
 KgZbpzWxTDkfE5JXtvC64YbAXmDNqoWJ/lkhV7Y21zqTcSJEMRnItq/IS8/3kycwtId6C9
 BK7npVZZdJCRgvAKLAV63O7j7rXYVBbl7yOGkl8qGhb4y9Jp2xRBOECXIH5pZg==
Message-ID: <29754897c2b6d0a9560a05fcd1c0a0946577518d.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>, airlied@gmail.com
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Boris Brezillon	
 <boris.brezillon@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Daniel
 Almeida <dwlsalmeida@gmail.com>, Gary Guo <gary@garyguo.net>, Tvrtko
 Ursulin	 <tvrtko.ursulin@igalia.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 10 Jun 2026 16:25:55 +0200
In-Reply-To: <84519e72-e057-45f9-8ace-baf12f095e55@amd.com>
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
 <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
 <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
 <DJ3VYD71HDQ2.3C8GG983Z2YCM@kernel.org>
 <c8564ea0-8ff4-4049-996d-bd978c478372@amd.com>
 <aebe759117cd65004510946e39bd02e4c903e1e3.camel@mailbox.org>
 <84519e72-e057-45f9-8ace-baf12f095e55@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: n4jonhnyip6jyham6jcykuk4opobqkjd
X-MBO-RS-ID: 1f051ba4be6a0a5772c
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, 2026-06-09 at 15:34 +0200, Christian K=C3=B6nig wrote:
> On 6/9/26 15:19, Philipp Stanner wrote:
> > And look what I found:
> >=20
> > static inline bool
> > nouveau_cli_work_ready(struct dma_fence *fence)
> > {
> >  unsigned long flags;
> >  bool ret =3D true;
> >=20
> >  dma_fence_lock_irqsave(fence, flags);
> >  if (!dma_fence_is_signaled_locked(fence))
> >  ret =3D false;
> >  dma_fence_unlock_irqrestore(fence, flags);
> >=20
> >  if (ret =3D=3D true)
> >  dma_fence_put(fence);
> >  return ret;
> > }
> >=20
> >=20
> > That looks weird, doesn't it?
>=20
> No, that is pretty much expected.
>=20
> This issue results because of the lock inversion/cleanup race between
> nouveau_fence_chan->lock and dropping the last reference.
>=20
> That in turn is caused by the fact that enable_signaling is called
> with the fence lock held=C2=A0


Are you referring to this comment from the documentation?

 * Since many implementations can call dma_fence_signal() even when before
 * @enable_signaling has been called there's a race window, where the
 * dma_fence_signal() might result in the final fence reference being
 * released and its memory freed. To avoid this, implementations of this
 * callback should grab their own reference using dma_fence_get(), to be
 * released when the fence is signalled (through e.g. the interrupt
 * handler).
 *
 * This callback is optional. If this callback is not present, then the
 * driver must always have signaling enabled.
 */
 bool (*enable_signaling)(struct dma_fence *fence);

> and delegates the signaling to the caller instead of doing it itself.

Who delegates what to whom?

enable_signaling() is called indirectly by someone who adds a callback.
If enable_signaling() is implemented, then the driver callback's only
job is to activate some sort of interrupt or worker that will signal
that fence at some point.


> This in turn means that you can't do proper cleanup after the
> signaling is done by grabbing driver specific locks.

Sure you can. If everything is properly synchronized.

// driver
dma_fence_signal(f);
// all callbacks can't reach our driver anymore
struct driver_fence =3D container_of(f);
lock(driver_fence->special_lock);
cleanup(f);
unlock(=E2=80=A6);

Where is the deadlock?

I continue to fail to see it. Show me an example of some code that
would deadlock, please. Either fictive or from the kernel.

Nouveau's enable_signaling() callback does not take locks. Its
signaled() does not take locks.

I went through all implementors of signaled() and found that only xe
and nouveau invoke some function pointer that we want to investigate
closer:

User Way signaled() operates
-----------------------------------------------
amdgpu_userq_fence.c lockless
etnaviv lockless
i915 lockless
nouveau lockless?
radeon lockless
vc4 lockless
xe lockless?


Who will be deadlocking and with which locks?


> This is *exactly* the problem I'm trying to prevent here.
>=20
> When the callbacks wouldn't be called with the fence lock held the
> Nouveau nouveau_fence_chan->lock and the fence lock would be
> completely independent.

You seem to circle around the idea that Nouveau's fence list is
protected with the shared lock?

That issue, if it exists, is solvable through the embedded lock.

Anyways, there is no issue. Neither Nouveau nor other drivers will
deadlock if we call ops->signaled() with the fence lock around.

>=20
> This results in much better cleanup paths, fences which are
> independent of their issuers and in general much simpler handling for
> all dma_fence implementation backends because we don't need to worry
> all the time about lock inversions between the fence lock and
> internal driver locks.
>=20
> So as far as I can see what you suggest here is exactly what has
> caused all the problems in the first place.
>=20
> For the cleanup path in Rust you should be trivially able to use
> call_rcu() if the synchronized cleanup path would be causing issues
> (which I clearly agree on).

You can *satisfy the current dma_fence API* with call_rcu(), but as
Danilo states delaying work always has subtleties =E2=80=93 plus I don't re=
ally
want to have an unnecessary call_rcu() call for tens of thousands of
fences per second.

And I would prefer if the dma_fence implementation just wouldn't be
racing. It is clearly desirable that a call to dma_fence_signal()
decouples the callbacks. That's even how you have designed it, just
with an unnecessary graceperiod thereafter.

I also doubt that it's robust that dma_fence_is_signaled() can return
true while the callbacks are not all executed.

And all the RCU dancing is fragile, where people need to guard API
calls with the RCU read lock instead of having the ability to rely on
their reference / refcount. It would be far safer if dma_fence would
guard against everything with the lock.

Summarizing:
 * enable_signaling() uses the lock already.
 * set_deadline() users use the lock around the entire callback.
 * dma_fence_is_signaled_locked() demands that it must always be
   possible to invoke ops->signaled() with a lock, as Danilo pointed
   out.
 * The few implementors of ops->signaled(), see my list above, all do
   atomic operations without any locks at all.
 * The other callbacks are either deprecated or not relevant in this
   regard.

So making dma_fence locking consistent would make all our problems
disappear, could probably even solve the unload-problem if
dma_fence_signal() becomes a hard, synchronous decoupling point, and it
comes at no proven cost.



P.
