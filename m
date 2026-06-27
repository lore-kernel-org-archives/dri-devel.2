Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E405C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC03C10E2DB;
	Sat, 27 Jun 2026 13:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aEuj47Vk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2549010E2DB
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:51:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCAD0406B8;
 Sat, 27 Jun 2026 13:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D076D1F000E9;
 Sat, 27 Jun 2026 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782568289;
 bh=sZ7kMHOM/UusQZj89sqfP5ZckFAGYTvVqUakUPkV1uQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=aEuj47VkimWwfxAw2ZHAEfGEMZKtEMZ6WNWLDw+s3570SNvTizAl0ILVOI17i2A7L
 AYudOp4K9ZVQti0oj3sp0GHOY0v4wg9twuayqUoC0Jz8/xQZJVi+PWbRe1rcVUcme0
 23YyTXp4+62dyWzGDNBhKH2kKEDhJpJ9iOPCebxN+YhIKYhKB+vSuhClJuLo0ZnDcP
 r1yz3J+EducA4gN7IrvtGppM1/3YMfsdh7g816Lb13ia+OwEkpPtg4uviqtif2YGp2
 jYR49KtLMnGOr/62DXdveI87ZGy85POyH0eHlU74bdr0niz5rL0MFYESyY7yLZ7OX6
 2Vh7Ryq7ce8VA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Jun 2026 15:51:23 +0200
Message-Id: <DJJVPW8H183T.1927SIBS40Z40@kernel.org>
Subject: Re: [PATCH v4 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <acourbot@nvidia.com>, <ecourtney@nvidia.com>,
 <m.wilczynski@samsung.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <daniel.almeida@collabora.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
 <20260626183630.2585057-3-dakr@kernel.org>
 <CANiq72=0OOgc6NtbpF0Ysdk3ytRWCGGbWg00u0Le2AzQmKGKxg@mail.gmail.com>
In-Reply-To: <CANiq72=0OOgc6NtbpF0Ysdk3ytRWCGGbWg00u0Le2AzQmKGKxg@mail.gmail.com>
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

On Sat Jun 27, 2026 at 2:26 PM CEST, Miguel Ojeda wrote:
> If this goes in at the same time as the move (as I assume), then am I
> understanding it right that if someone else was using `ForLt`
> (trait/macro) things would either break at compile-time (which is OK)
> or, in the covariant type case with no `cast_ref()`, it would build,
> but someone could in principle have relied on `ForLt` providing the
> covariance guarantee in unsafe code?

If someone would have unsafely asserted covariance for ForLt it would break=
 at
compile-time like this:

	error[E0199]: implementing the trait `types::for_lt::ForLt` is not unsafe
	   --> rust/kernel/pci/io.rs:158:1
	    |
	158 | unsafe impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
	    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	    |
	help: remove `unsafe` from this trait implementation
	    |
	158 - unsafe impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
	158 + impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
	    |
=09
	error: aborting due to 1 previous error

The only way this could silently break would be to use ForLt!(), but then d=
on't
use the explicitly provided safe cast_ref() method, and instead open-code i=
t
with an unsafe transmute() assuming covariance from ForLt!().

Even though very unlikely, I do however have an eye on whether another user=
 of
this API appears.

(The whole series also goes into a topic branch based on -rc1 anyway, so I =
can
also always provide a signed tag with just patch 1 and 2 based on -rc1 shou=
ld
the need arise.)

> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

> We could take the chance to add some missing intra-doc links, but I
> can add a good first issue.

I can add them on apply, or we leave them as good first issue, as you prefe=
r.

Thanks,
Danilo
