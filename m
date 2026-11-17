Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63986606A8B3
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=viAmOPoL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74CA10E698;
	Tue, 17 Nov 2026 08:24:29 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35D010E698
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 08:24:23 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jTHnw6RQrz8vZ0;
 Tue, 17 Nov 2026 09:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794903860; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6sFeeE2v8KqdFq9cTEUeg70JLLH5Ub+A5TKvYvbkqk=;
 b=viAmOPoLWB08TuLkaRTRWKL6GyzdUBMkIZGZKpWCg514qs4PCgGVwTqmLELQKYiqolqJux
 1syhU90LBtUOMuJxDDFMfpT9/yn1kSRfPGz4KASVfgnpO/llrM4bxjafkYy6LYmIpjpS5r
 3F1jOHaiCRP4Sx/43hXl3wXSL67x0OFlZPtybtdcMzIsqKyPQyvW8/IbiWC1F6rLKgZVDA
 /agbHLLcXTcRopPmiQ7E0m8FhcG3p76i5l4q1Wj6ha5k5FOMd4Q/f/3RD89CZm30Fzq4wA
 Q4bhBTPzdMQxkvH4pUi80XrjBBqedsIlNteTrQK1Odt1ZSxdQJXeYsKrZk2s9g==
Message-ID: <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Danilo
 Krummrich	 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel
 Ojeda	 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Daniel
 Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Nov 2026 09:24:15 +0100
In-Reply-To: <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 46dd5544d1dd3ff66d6
X-MBO-RS-META: 7sk9otwyp8ik8zrdho6idfnnx6ekyr8w
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

On Thu, 2026-11-12 at 11:29 +0100, Christian K=C3=B6nig wrote:
> On 11/12/26 11:10, Philipp Stanner wrote:
> > DriverFence::drop() contains a pr_warn!() for when the fence drops
> > unsignaled. This warning gets into the way of canonical teardown in
> > Rust: when you drop a lock, it unlocks itself, when you drop a KBox, it
> > frees itself etc. Congruently, users should be able to tear down fences
> > they don't care about anymore with ECANCELED, which is already the
> > default error code.
>=20
> Well a dma_fence should never automatically signal when the last
> reference drops.
>=20
> Leaving it unsignaled is the most defensive path we can go. That can
> lead to deadlocks but it can at least not lead to memory corruption.

True, you choose between the Unholy Trinity of DRM: deadlocks, UAF and
memory corruption :]

In this particular case, however, Rust does not allow for preventing
the user from signaling "forgotten" fences anyways, no matter how we
write the fence core:

struct DriverFoo {
	f: DriverFence<()>,
}

impl Drop for Driver Foo {
	pub fn drop(&mut self) {
		// Signals fence implicitly & automatically.
		self.f.signal(ECANCELED);
	}
}


So we decided to die this death because this way we get rid of the two
of the three problems that *can* be solved in the API.


But it will please you to hear that all users of drm::JobQueue do not
have access to fences directly anyways, they can only signal them
through JobQueue. Thus, they can also not forget them (signaled or
unsignaled), because they would have to forget / leak the entire
JobQueue as a whole, so effectively forgetting also their GPU ring. If
that would happen, the driver would be broken beyond repair anyways.

Regards
P.
