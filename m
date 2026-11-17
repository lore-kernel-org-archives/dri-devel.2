Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E38606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=IHsf19vV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017FC10E395;
	Tue, 17 Nov 2026 10:54:25 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE3710E395
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 10:54:18 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jTM6v51ZFzKn83;
 Tue, 17 Nov 2026 11:54:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794912855; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAWEsctWy9OQpEjem1+XN21g7NWWHbm0GcJRZLH8b4Q=;
 b=IHsf19vVA+64iwhz2z3appSHfEG3PeqVweLbhPmuQeWF05sVXfG7RXhEkhsGcOkEaVY8gk
 4hq3tFoGpjGKY4YIQcztVAZcWxcl7/VnJzJ6Vlp7wK/c4DWp60ka4paPimUe9ADkg5jaxu
 OTPRfodsYI3fLMYTkwGy57CTFB4fyUJ+uwm4kZN1S3o1RR2DaID+QH9NgTwAbdxdAtScb8
 Q4TxVMYGRoxtjfdSelh5ltFF8yZjtqX5bo95dQfOQH4NdnE29ekyOfAeAIerThu3l/YO9x
 bTtC+Odrx8/SeHfIulhU5bNMG5cbQsHDjp1aj5R2W9gSem6XMDp/9PBTAygC0A==
Message-ID: <ab99758408df682c68a3792cc3014b77d6e1c8ab.camel@mailbox.org>
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda	
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Daniel
 Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Nov 2026 11:54:12 +0100
In-Reply-To: <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
 <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
 <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 3fc69f010e82e9128db
X-MBO-RS-META: 1jz3zz7cp1nntsqnyo4n5fdt6zbaxuir
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

On Tue, 2026-11-17 at 10:51 +0100, Christian K=C3=B6nig wrote:
> On 11/17/26 09:24, Philipp Stanner wrote:
> > struct DriverFoo {
> > 	f: DriverFence<()>,
> > }
> >=20
> > impl Drop for Driver Foo {
> > 	pub fn drop(&mut self) {
> > 		// Signals fence implicitly & automatically.
> > 		self.f.signal(ECANCELED);
> > 	}
> > }
>=20
> Yeah, exactly that is still a bad idea :) See the HW eventually
> doesn't necessarily stop doing DMA if you unload the driver.

I know.

> So just signaling all fences with ECANCELED is not enough.


Yes. What I was trying to tell you as that you have no way to enforce
this in Rust or C.

dma_fence_signal(f);
free_driver_resources();
// Driver forgets to stop the hardware. Memory corruption occurs.

You see? Neither your BUG_ON() or WARN_ON() saves you if the driver
does it like that, no matter the programming language. You cannot
prevent it.

The only one who understands how the hardware works is the driver. The
only one who can stop it is the driver.

In Rust, the place where a driver drops its JobQueue is the same place
where it has to halt its GPU ring correctly. Enforcing this cannot be
done by dma_fence code.


P.
