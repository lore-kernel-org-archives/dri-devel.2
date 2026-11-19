Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6807D606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=DBlKI+Fz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9F81124F2;
	Thu, 19 Nov 2026 14:55:56 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4F01124F8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:55:48 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jVhNd2THPzMlyX;
 Thu, 19 Nov 2026 15:55:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795100145; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ikfEBgKAQ/w72CS+c61ChZxhzTrU5wLEwfcM5Che0D8=;
 b=DBlKI+Fz+EjeHwYBG7o/+qlCzGZ9/6qJhHumvHeEfu/wpegFlr96QVPRCQoUbzbO9OCZ72
 1gkyl9pKkyIXvIr8wcTI7GNEzOKZCIQ6nP8e2aZqqReWcu44RikCS344e25+UJ4ts+H1mx
 9hJrqIwPTj2Lqnw+jGDKB2xpv5NiMrKFQLjghJUVAp1N7fRMUGl00Ww3ffAsJGe251fRTd
 jVXEA7nXlQHwigzaCAiOCvwk1Ln4hkopjgHrPwL51It3TK8iGQKjOv4bi7KfcaM40pxWcg
 anCjgSENQ5CGw+VMyfJkx47TM0pErQzTyWDVa7zl9Rhfx72VpOi4ar2NNqcbbQ==
Message-ID: <972ba9ddea36c9dc84ce649e2edcf6bde71420d1.camel@mailbox.org>
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Alice Ryhl
 <aliceryhl@google.com>,  Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron	 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Nov 2026 15:55:42 +0100
In-Reply-To: <141892f8-180c-4157-8c59-6e69057334f2@amd.com>
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
 <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
 <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
 <ab99758408df682c68a3792cc3014b77d6e1c8ab.camel@mailbox.org>
 <c2dd46ea-94d8-4720-af37-897c91809338@amd.com>
 <DMXJ8TBSZJJ4.3HG0OJDI9URTT@kernel.org>
 <8da4a8c0-1740-450c-9cf1-1a7b21d12997@amd.com>
 <DMXMSIQONGUW.1RRNS7I6LACD6@kernel.org>
 <a7f9e0f3-b299-4d40-9230-106003725dc2@amd.com>
 <202dd0c3d515ddfa77a8ec8751badadd31b8a7b0.camel@mailbox.org>
 <141892f8-180c-4157-8c59-6e69057334f2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 1az8ce8au3wj3syybakktcd5manwyxhs
X-MBO-RS-ID: 7de1ef4fecc2618c8c8
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-19 at 11:47 +0100, Christian K=C3=B6nig wrote:
> On 11/19/26 10:58, Philipp Stanner wrote:

> BTW that is the reason why dma_fences are RCU protected as well. That
> is not because of performance but rather to be able to do a try get
> on a reference to solve reference direction problems.

You mean dma_fence_get_rcu()?

That's simply a workaround for broken refcounting. Either you have a
reference, then you can increment it. Or you don't, because you stole
someone else's reference, and now you need a magic RCU delay so that
the rightful owner of the reference cannot free the memory that you
illegally occupy.


> No it doesn't.
>=20
> What I want to ensure is that drivers don't come up with funky methods to=
 signal fences.

They won't because the only signal mechanisms is our API.

All the driver needs to do right is to associate the fence container
with the object associated with the hardware.

>=20
> The cleanup part you want to have here is clearly good to get that
> defined as well, but to be honest that is peanuts compared to what
> you get when you have the dma_fence signaling wrong.
>=20
> >=20
> > That's how teardown is done in Rust. You drop the lock, it unlocks
> > itself. You drop the memory, it frees itself. You drop the fence, it
> > signals itself.
> >=20
> > That's by design because the object lifetime model falls naturally into
> > place.
> >=20
> > > I think the most defensive way would be as last resort scream loud in
> > > the logs that the driver is somehow buggy and hasn't signaled it's
> > > fence, wait for a certain amount of time (100ms?) as safeguard and
> > > then signal the fence with an error.
> >=20
> > Now that doesn't make any sense at all, either the hardware is stopped
> > or it isn't.
>=20
> There is a huge window of state in between.
>=20
> > Having some random delay is probably even worse because
> > the problem is then more difficult to even encounter and thus fix.
>=20
> Well the whole point of the delay is to at least have some kind of
> save guard that makes follow up problems less likely to encounter in
> production.
>=20
> That the underlying problem is fixed should be triggered by the big
> warning in the system log and not because I notice that my valuable
> data is corrupted because a DMA fence signaled to early and caused
> random corruption.

Again, if the driver, the only one who understands the hardware, really
wants to screw up then your system is done anyway.

Remember my previous example:

// forgets to stop hardware
dma_fence_signal(f);
// still forgets to stop hardware

Your WARN_ON will not trigger. Your sleep/delay would not trigger.

> > > Exactly that is what I disagree on.
> > >=20
> > > Stopping the HW is what makes fences signal and that is what this
> > > tear down process should block for.
> >=20
> > Our point is that dropping stuff stops the hardware, and *then* signals
> > the fences. Exactly what you want! :)
>=20
> No, that is completely backwards.
>=20
> A dma_fence should *NEVER* signal because you waited for something. Inste=
ad the dma_fence is what is waited on.

By whom? And who signals it? It's the party stopping the hardware, no?
So just like with our design.



P.
