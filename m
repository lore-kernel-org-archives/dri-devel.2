Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD9606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Ad8rZ1sX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599E010EA1D;
	Tue, 20 Oct 2026 14:41:29 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF3110EA1D;
 Tue, 20 Oct 2026 14:41:23 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j8FTq6gPDzMlpm;
 Tue, 20 Oct 2026 16:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1792507279; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsyyGWxhNBOvel5G5C2yuF7bzkrNytpvfSZfEsf6afo=;
 b=Ad8rZ1sXZAjqL0R25aIKLX8FW58VDQ1i78ist/YmNQAbhtQf+Q/FKy8g47hTqo28Ya9pYW
 JF6ObwLvGTTO1yfoeYnnFVu4wgTK2Al+u/eAHJsD6z9ESP+c/TufRO+8eW80xINo+5hY1m
 +Cx7F16V8NYWahH86YAdb4Lca42qNIvNTSD6NRhz46TuiJTM9kfqWdIpvVZOUgnFKfIyu7
 IWR7B+u+M6120Po1MnIQcdxXY7gKy/SYc/w2jgkMXcG9peJll2fDtWV6lB2pfjLCMXzNJ+
 gxwLJj2ydZl0r/AA7lve4bGAOVMfuDiKfdaKTqDDpTyHEvNBulzhK8K4n/rAjw==
Message-ID: <ca78cdb7c24a9be9b640db782168cdcc5fe30b60.camel@mailbox.org>
Subject: Re: [RFC PATCH v2 0/3] Solve dma_fence's problems by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Jani
 Nikula	 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>,  Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Daniel Almeida	
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=
 <work@onurozkan.dev>, Boris Brezillon	 <boris.brezillon@collabora.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Tue, 20 Oct 2026 16:41:12 +0200
In-Reply-To: <3e8bc11d-6f90-47a4-ae63-cf2ff37f1ff6@amd.com>
References: <20261020100034.759183-2-phasta@kernel.org>
 <3e8bc11d-6f90-47a4-ae63-cf2ff37f1ff6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: b9048a7d9fe97d9beaf
X-MBO-RS-META: qigaa9aksrimhrpqmxh7stqras399i54
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

On Tue, 2026-10-20 at 14:02 +0200, Christian K=C3=B6nig wrote:
> On 10/20/26 12:00, Philipp Stanner wrote:
> > In our Rust code bases, I'm currently experiencing what we also
> > experience in C at many places: that the dma_fence contract's RCU
> > requirements make the API more fragile and put an unnecessary burden on
> > the API user. Most notably, in C the API behaving correctly now depends
> > on the API *user* waiting before free()s, waiting before unloads =E2=80=
=93 all
> > because dma_fence is not properly synchronized.
> >=20
> > The patches commit messages give more details about where I want to go
> > with this particular RFC.
> >=20
> > My rough "vision" for dma_fence, where I think it should develop to, ca=
n
> > be described like this:
> >=20
> > 1. All users should use inline-lock.
> > 2. The fence-signaled state should be our decoupling point.
> > 3. The fence state must be consistently locked.
>=20
>=20
> > 4. This means all callbacks are only invoked for unsignaled fences, and
> > =C2=A0=C2=A0 the fence cannot signal while a callback runs.
>=20
> First of all that prevents concurrent execution of the callbacks
> which for a lot of use cases is a must have.

Currently only set_deadline() can execute in parallel.

IIUC in our past discussions, your wish has been that the driver can
take its own locks with free locking-order in the callbacks.

Thus, the callback is invoked under lock in any case, just a few
instructions earlier or later. Thus, no callback ever truly executes
concurrently.

>=20
> Then as I pointed out before the second problem is that this again
> makes the existing lock inversion between the signaling by polling
> and signaling by interrupts even worse than it already is.

We asked for examples in our last discussions, and the only one ever
presented was the list-access requiring the fctx-lock in
nouveau_fence_no_signaling(). Nouveau is often not a good example.

Can you provide examples in the kernel where deadlock would occur?

Note that I pointed out that all callbacks are already invoked with the
lock taken, which proofs that it's doable. Future users with inline-
lock could employ various techniques for dealing with the lock-order.

Only exception currently is set_deadline(). The only user, MSM,
acquires the lock manually and then nevertheless triggers work on a
kthread, examplifying just one technique.

>=20
> What we could use is an SRCU, but a spinlock or any kind of lock is
> clearly the wrong approach.
>=20
> So as far as I can see that is a big no-go and we should really just
> use RCU for everything and remove leaking the fence look into the
> callbacks like I outlined before.

Look at patch 3. We might want to add some legacy support for shared-
lock, but it is evident how much more simple the code gets.

Also:

> >=20
> > Point =E2=84=966 means that this:
> >=20
> > dma_fence_lock_irqsave(=E2=80=A6);

I even forgot that you also need a

if (!dma_fence_is_signaled_locked(=E2=80=A6))

here

> > dma_fence_set_error(f, err);
> > dma_fence_signal_locked(f);
> > dma_fence_unlock_irqrestore(=E2=80=A6);
> > synchronize_rcu();
> > kfree(driver_foo);
> >=20
> > should simply become this:
> >=20
> > dma_fence_signal(f, err);
> > kfree(driver_foo);


:)
