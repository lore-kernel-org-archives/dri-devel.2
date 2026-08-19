Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F4CC5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C9A10EDFF;
	Wed, 19 Aug 2026 11:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PcBjsKaH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9F310EDFF
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:23:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 55FDA40797;
 Wed, 19 Aug 2026 11:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D2C1F000E9;
 Wed, 19 Aug 2026 11:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138635;
 bh=QgvazMJHmYfZ8Q1rsg6DrrOav9bRml6UL8M0L4LzXNM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=PcBjsKaHg0Gfg6eN15Zexqs8qukqL+KSCvY7Uk72YD7wocrIPqWQXPUEdel8lKduT
 tSbv5XZheBupNwIp+EPPL4BzLCaAMVlcdxiJ4Io3efcWjUyjXNeYiq+q5JTejqcosf
 D2hLfRmXzc0QPHiGXOedg4Nwb9lYxxhV6Xd5eHmVFKrZKRKQSPuGAonx6kAXfUNxs7
 AMEqlNvtFbzA6ULNzRabj+v5XvWqMxZpc8mrlyk0QMLSdAuDTFjI+qRDgc1pI4M32V
 pI2hBdDAvEGExS8v+hP2aiSVAnH9Qc9hlgfnYtLbhZAL2OGuupIBmUl+5Q4BNqnev/
 qKS6qhHIKM2kg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 13:23:49 +0200
Message-Id: <DKSVRS7UAL9U.3RUTW74RVSEHQ@kernel.org>
Subject: Re: [PATCH 1/6] rust: alloc: add Vec::push_init
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-1-b84db5e84b67@nvidia.com>
In-Reply-To: <20260817-b4-nvkv-v1-1-b84db5e84b67@nvidia.com>
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

On Mon Aug 17, 2026 at 2:56 PM CEST, Eliot Courtney wrote:
> +    pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) =
-> Result<(), E>
> +    where
> +        E: From<AllocError>,

This signature rejects impl Init<T, Infallible>, which is the reason why we=
 have
e.g. Box::init() and Box::try_init() with different fallible signatures.

So, if we follow InPlaceInit, it'd be

	pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) -> Res=
ult<(), Error>
	where
	    Error: From<E>;

and

	pub fn try_push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) ->=
 Result<(), E>
	where
	    E: From<AllocError>;

In theory we could also simplify it to

	pub fn push_init(&mut self, init: impl Init<T>, flags: Flags) -> Result<()=
, AllocError>

and

	pub fn try_push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) ->=
 Result<(), E>
	where
	    E: From<AllocError>,

However, InPlaceInit actually achieves more with the init() and try_init()
distinction:

  What init() accepts, but try_init() does not accept:
    - impl Init<T, Infallible>
    - impl Init<T, E> where Error: From<E> but NOT E: From<AllocError>

  What try_init() accepts, but init() does not accept:
    - impl Init<T, E> where E: From<AllocError> but NOT Error: From<E>

So, with the simplification we'd technically lose out on the

	impl Init<T, E> where Error: From<E> but NOT E: From<AllocError>

case.

In any case, init() and try_init() seem a bit mixed up on their purpose
regarding fallibility and error type strategy, but in order to really cover=
 all
cases I think it is necessary.
