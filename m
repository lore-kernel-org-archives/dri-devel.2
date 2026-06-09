Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25475CD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA7910E244;
	Tue,  9 Jun 2026 10:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HkAG6Ar6";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E4A510E240
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:42:57 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gZQV55D1wz9tsm;
 Tue,  9 Jun 2026 12:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781001773; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JipsspzxTUx0G7vJgab38RjRzDpeou++CYMWHB1CJoQ=;
 b=HkAG6Ar6ltWhejZh36R8dhbGKPGpOd96LZABQcMZs1mqP2sqo4gr0a6AzblRP4V/c+2rr6
 yjom6iqmQ6NeBmM0HMMxG+5o1u3bzQ+yxuuCB5nT67z6PxwMQiMJ3wJnWg8Ia6WLPJJdK7
 QKX5+ITOq2HS4wHceJEgjat2jM/MwbM5lIzy4bQkuDQ6RbXetLVQ+gzP+xbb7ytoZA2mKt
 NrdHpKw4ejcXfAUrlQnz+8fk4hLt/8lC01CdsapKQznpXL967EDc+wPTevn2tT5WKA/Bfx
 Z5p4TecALrpEEDlXEtq/iHJjIdnxvoBKxMKUFQqJ/80RBDaXa2TCQ9oTPk5hzw==
Message-ID: <11d7c83185a18d13760b6e77275e97c110dcddcc.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Boris Brezillon	
 <boris.brezillon@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Daniel
 Almeida <dwlsalmeida@gmail.com>, Gary Guo <gary@garyguo.net>, Tvrtko
 Ursulin	 <tvrtko.ursulin@igalia.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 12:42:49 +0200
In-Reply-To: <66349a9f-d9dd-498b-b118-1c79d3aa3cca@amd.com>
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
 <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
 <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
 <DJ3VYD71HDQ2.3C8GG983Z2YCM@kernel.org>
 <c8564ea0-8ff4-4049-996d-bd978c478372@amd.com>
 <74bd33a06b75c291c3e2eda19e0250fbd280c49b.camel@mailbox.org>
 <66349a9f-d9dd-498b-b118-1c79d3aa3cca@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 3g3cmhkz6dg7r6r5a4qcijaedk8sx3jj
X-MBO-RS-ID: aa0f0b74e0b68467672
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

On Tue, 2026-06-09 at 12:26 +0200, Christian K=C3=B6nig wrote:
> On 6/9/26 07:52, Philipp Stanner wrote:
> ...
> > >=20
> > > In detail calling the callbacks without holding locks allows all impl=
ementations who need it to explicitly take locks in the order they want.
> >=20
> > Didn't you say a few mails above that the implementation should not use
> > the fence lock for its own purposes?
>=20
> The usual use case the drivers have is this here:
>=20
> dma_fence_lock_irqsave(fence, flags);
> was_signaled =3D dma_fence_test_signaled(fence);
> if (!was_signaled)
> 	dma_fence_signal(fence);
> dma_fence_unlock_irqrestore(fence, flags);
>=20
> if (!was_signaled)

If cleanup() touches fence data, this is now exactly the race that I am
concerned with.

With the current design, you'd actually need a synchronize_rcu() here,
which you definitely do not want in a hot path :(

> 	cleanup();
>=20
> This is actually what you and me came up with for the KFD when we
> removed the return code for dma_fence_signal().

Well, what we came up with for that rare case was

was_signaled =3D dma_fence_check_and_signal(fence);
if (!was_signaled)
	cleanup();

It seems that many of the other use cases where the fence lock is taken
by drivers ultimately are rooted in the (IMO) design mistake that
dma_fence_set_error() exists.

There should just be

void
dma_fence_signal(struct dma_fence *f, int err);

which also conveniently forces all signalers to really carefully think
about whether the fence's associated operations succeeded. Correctly
representing the "true fence error state" to all consumers is vital for
sane system behavior, as you continuously have to point out.

>=20
> Taking the lock around the enable_signaling() callback has the exact
> same reason, preventing the fence from signaling between testing and
> calling dma_fence_signal(). The problem with that approach is that
> cleanup() now suddenly runs under the fence lock as well.

That problem does not exist if we re-design dma_fence like that:

// driver
dma_fence_signal(f); // revokes all accesses to our driver through backend_=
ops
// synchronize_rcu() now unnecessary \o/
cleanup(f); // We know that all accessors are gone
dma_fence_put(f);

>=20
> So you are left with few options: Either the fence lock is external,
> which we don't want because that make the fence non-independent, or
> cleanup() defers work to irq_work or work_structs, which creates
> numerous lifetime issues.

Yup, this is uncool and we want to avoid that.

But these seem to be the options

1. Ensure proper synchronization
2. Wait for a grace period in a hot path
3. Defer cleanup() with some delay mechanism

#1 is by far the cleanest approach. I still cannot see any downside,
and quite a few upsides.

https://elixir.bootlin.com/linux/v7.1-rc6/source/drivers/dma-buf/dma-fence.=
c#L1025

^ is already racing with the signaled check.


I'm going through the users right now, and it seems all we need to
ensure to implement this change is to audit all ops->signaled() for
usage of the fence_lock and see if we can port them.

>=20
> When enable_signaling would be independent of the fence lock we could
> avoid all of this and just use a normal spin_lock() for the cleanup.

How's that related to our problem?

P.
