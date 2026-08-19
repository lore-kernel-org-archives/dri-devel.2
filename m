Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F5EC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C050610EE7F;
	Wed, 19 Aug 2026 18:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="le0+TpKW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 303F110EE7F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 18:59:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20DC560AAA;
 Wed, 19 Aug 2026 18:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0CA1F000E9;
 Wed, 19 Aug 2026 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787165994;
 bh=xlf0k7UvPh5SQZZCy8DxBAo/+dbt1EPzI1dcAJ7/Pmg=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=le0+TpKWUK+cUmt+SDybCSey3/D3ij6vKjNZKTkxVIr4sprZwiXXOKYV43rkqABHC
 S3zWjMmZkmHanXEfm9Vo2h4RzFu4VoBiw6ee7aXLDoMH5tD1lQDqD/co4WIKaqN31B
 A8b+9DD+vjZIdw7xKEn0yQBNVKdIe+EVqLrOhKU/PLEaXnF0YYjZFFhDaTyp4C9feP
 N8kI59rfmyN6XJFgWjYeSJoEAi+D7P7zwNyIVEOqUDisi5xL5hIqIewFr2D8oudEUP
 6gjNv7TjgU6wV3eQ5NLo9DcEZVEDhI2Dp6fYyedq0idVEFHbssymv18zJjd+vw533C
 D6TAFNiKt3GJA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 20:59:48 +0200
Message-Id: <DKT5GWU3ARFG.25B1BCY0A3RS1@kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 5/6] gpu: nova-core: add NVKV typed decoding
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
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-5-b84db5e84b67@nvidia.com>
In-Reply-To: <20260817-b4-nvkv-v1-5-b84db5e84b67@nvidia.com>
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
> +/// A fixed capacity vector that holds at most `N` elements.
> +#[derive(Debug, Copy, Clone, PartialEq, Eq, Zeroable)]
> +pub(crate) struct ArrayVec<T, const N: usize> {
> +    data: [T; N],

This should be [MaybeUninit<T>; N].

> +    len: usize,
> +}

Let's move this into the alloc module.

> +impl<T: Default + Copy, const N: usize> Default for ArrayVec<T, N> {
> +    fn default() -> Self {
> +        Self {
> +            data: [T::default(); N],
> +            len: 0,
> +        }
> +    }
> +}

For anything that actually constructs an ArrayVec we should probably consid=
er to
restrict its size with a const_assert!()?

For an initializer approach that'd be not an issue of course.

	fn init_with<E>(f: impl FnOnce(&mut Self) -> Result<(), E>) -> impl Init<S=
elf, E>
