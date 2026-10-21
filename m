Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074D606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeIc/PWc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1946B10FD33;
	Wed, 21 Oct 2026 10:05:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC77410FD33
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:05:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73E2642B20;
 Wed, 21 Oct 2026 10:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ADD1F000CA;
 Wed, 21 Oct 2026 10:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792577116;
 bh=A1BISaUl9wWDfw7k+gq2pMQJekKPJMnfZN8WAqVyfIU=;
 h=Date:To:Cc:Subject:From:References:In-Reply-To;
 b=oeIc/PWc5+vSy3/esocJX63Z0ImiyfwGlQ4/npg8hmtub/K3MBDrQGMIoqk0Pm+Io
 mObbyx8SQz+8wn6lqUIPJtlGZMyNHF0wglza7VH03SoA7ku9IPX2Chad70T+No8bCp
 R3k9zgcNqRra300oz23otd8hKFsRd0Rhc965yGuzTq8ohHs/oei2iOv+6N9w2pkm+1
 meJWYDaPBQ6GOA/fPbYsO+CcI9JoOewFMvcYLf1FJ/9yetdCz5z9UPqkMJ9O8kMXc4
 tbNmp1tGKqDzgdSsl5hslbuowjjusKRUxV1882+VRsnSEwTqFNFfDYt62Osdet34E0
 Z5OwaUaGbXRkw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 11:05:09 +0100
Message-Id: <DMAFJVM431FZ.R5XWZBIAR0UE@kernel.org>
To: "Gary Guo" <gary@garyguo.net>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 5/7] rust: io: let I/O locations carry an access mode
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.21.0
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-5-93611b84b5e3@collabora.com>
 <DM9NV8ICWRKK.2Q6FSBE476G5M@garyguo.net>
In-Reply-To: <DM9NV8ICWRKK.2Q6FSBE476G5M@garyguo.net>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 20, 2026 at 1:23 PM BST, Gary Guo wrote:
> On Thu Oct 15, 2026 at 1:39 PM BST, Daniel Almeida wrote:
>> `Io::read`, `Io::write`, `Io::update` and their fallible variants
>> project the view to the given `IoLoc` and access it there. A location
>> has no say in which accesses are allowed, so a register cannot be
>> declared read-only or write-only.
>>
>> Add the `io::access` module with the `Mode` trait and the `ReadWrite`,
>> `ReadOnly` and `WriteOnly` modes, and add an `Access` associated type to
>> `IoLoc`. Projecting through a location applies its mode: `ReadWrite`
>> leaves the view as it is, while `ReadOnly` and `WriteOnly` wrap it in th=
e
>> `ReadOnly` and `WriteOnly` views. The bounds of the generic accessors no=
w
>> apply to the backend of the restricted view, so a write to a read-only
>> location, or a read from a write-only one, does not compile.
>>
>> Raw offsets are `ReadWrite`. `OffsetLoc` takes the mode as a type
>> parameter that defaults to `ReadWrite`, and `RegisterArray` gets an
>> `Access` type, which `register!` sets to `ReadWrite` for now.
>>
>> No existing location changes its mode, so there is no functional change.
>> A following patch lets `register!` declare read-only and write-only
>> registers.
>
> So far, without considering access modes, we have a clean mapping after t=
he
> register projection series that a `register!()` macro just generates a cu=
stom
> projection. However, this commit makes it special again and this isn't po=
ssible
> with struct definitions, so it breaks feature composibility. It is also s=
omewhat
> surprising in the sense that it changes the base view type.
>
> What about making RO/WO wrapper types on actual data? Something like
>
>     Mmio<'_, ReadOnly<T>>
>
> and
>
>     Mmio<'_, WriteOnly<T>>
>
> Then we can implement
>
>     impl<T, B> IoRead<ReadOnly<T>> for B where B: IoRead<T> {}
>
> and
>
>     impl<T, B> IoWrite<WriteOnly<T>> for B where B: IoWrite<T> {}
>
> ReadOnly will not implement FromBytes, and WriteOnly will not implement
> IntoBytes, to avoid people using them with `copy_read`/`copy_write` API.
>
> This way, the design works for struct too. One issue of this, though, is =
that
> you cannot project from `Mmio<'_, ReadOnly<Struct>>` to `Mmio<'_,
> ReadOnly<Field>>` currently. However, I believe this is solved with the "=
place
> wrapper" concept in field projection.

indeed. if you implement `PlaceWrapper` for `ReadOnly` correctly, then
you can do that projection "as if the wrapper wasn't there".

> Regardless, before we proceed with any design, I'd like to hear opinions =
from
> Benno on how this interacts with the field projection design as language
> feature.

not sure what interaction you are referring to. I read Daniel's patch,
but I can't infer what you mean by "this" :)

best,
Benno
