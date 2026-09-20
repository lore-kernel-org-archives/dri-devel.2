Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4E7C982E1
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 12:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34DE10E5A0;
	Sun, 20 Sep 2026 12:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hbrKBqD0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C927710E5A0
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 12:38:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C9D86601FF;
 Sun, 20 Sep 2026 12:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289931F00898;
 Sun, 20 Sep 2026 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789907895;
 bh=F9irZJ9iiXbkD2B+ufb3Czj8bFKUPpXkRK8Y2Rf+XKE=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=hbrKBqD0FhxIZQE/81wfWKKswIsiTJiNLjz343PELPZNqOAucEk3T4u+zqA0G34gg
 9NINa1MukOV238d0vd77TbKhJ6t/jPEbBWNaEU5KDtHAlryk8UZ5nms4nQKkdzB90+
 FtfhlPIm7x2OFLOxhB2QmTFHIIlDE+3P3rLZNbZLtU5Pgq0/B/ckJDdvlqlrqBeyq/
 +8iOKPGB6V9vnYAUxzQZPoptEeg3YIcBNgmirfRVV8aSue+G4Mq8iGI9hFucVZm0Ow
 Xcakz0ulk6EhWeh2bz+VEOwIxZAHTxU6ZlXtNZ9BFHbnpXbIRgjzkeW/ij0shBKq/r
 XR83fl/13SxwQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 14:38:09 +0200
Message-Id: <DLK5E4VWQNU7.1K3YYYCZO2WRY@kernel.org>
Subject: Re: [PATCH v3 1/3] rust: num: add cv! macro to create values from
 constant expressions
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
 <20260902-cv-v3-1-0f90659e711d@nvidia.com>
 <DLFPWSS3LZSN.12G96EM0FI18C@nvidia.com>
 <DLHGQN9VQ3TE.JYI851RVF7VD@garyguo.net>
 <DLIN1ZH244ZA.3JVCE0YKWAQ6B@nvidia.com>
 <DLK50D524P11.3CZN924YW8HHQ@garyguo.net>
In-Reply-To: <DLK50D524P11.3CZN924YW8HHQ@garyguo.net>
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

On Sun Sep 20, 2026 at 2:20 PM CEST, Gary Guo wrote:
> On Fri Sep 18, 2026 at 7:03 PM BST, Alexandre Courbot wrote:
>> On Thu Sep 17, 2026 at 9:53 AM BST, Gary Guo wrote:
>>> On Tue Sep 15, 2026 at 8:39 AM BST, Alexandre Courbot wrote:
>>>> On Wed Sep 2, 2026 at 6:16 PM JST, Eliot Courtney wrote:
>>>>> Currently, using NonZero/Bounded constants is quite verbose. It's
>>>>> unfortunate because it disincentivizes using it in interface boundari=
es.
>>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for const=
ant
>>>>> value) takes a const integer expression and widens it to i128 (at bui=
ld
>>>>> time only) before passing it as a const generic value to a new trait
>>>>> `FromConst`. The value is then converted and appears in the
>>>>> associated constant `FromConst::VALUE`. The trait is implemented by
>>>>> NonZero, Bounded, and Alignment and lets values of each be constructe=
d
>>>>> from constants without a verbose turbofish syntax.
>>>>> For example, `const { NonZero::new(1).unwrap() }` can be written as
>>>>> `cv!(1)`.
>>>>>
>>>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>>
>>>> I don't think we have any user but nova-core at the moment, and it
>>>> benefits from this in several series (patch 3 here, but also ID pool a=
nd
>>>> later r000). Miguel, is this ok if we take it (i.e. the next revision)
>>>> through drm-rust-next?
>>>
>>> How about a topic tag shared between Rust and drm-rust-next? We could a=
lso
>>> remove the old num casts API as part of topic tag and fix all existing =
users as
>>> part of merge.
>>
>> Not opposed to the idea but IIRC there was already some pushback to the
>> idea. There doesn't seem to be an urgency to remove the old num casts
>> API that justifies doing it now with a more complicated merge path.=20
>
> Sorry, what pushbacks? I thought that `cv!` is what everyone agrees on. I=
 see no
> downside of this compared to the turbofish const conversion APIs.
>
> I am not opposed to delaying removal for the next cycle, but IMO the `cv!=
` macro
> should be present on Rust tree so it's visible and improvements can be ma=
de from
> there, so I think we should do a topic tag regardless whether the old API
> removal happens or not.

I think Alex refers to this thread [1]; there's was some more context to th=
is
though.

[1] https://lore.kernel.org/all/DL0KDAXUZOXD.I8FBZZ51EIIF@kernel.org/
