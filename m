Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2446DC55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7910F10EFEB;
	Wed,  5 Aug 2026 20:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IEQKVUUG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D67710EFEB
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 20:39:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46A04433A6;
 Wed,  5 Aug 2026 20:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF291F000E9;
 Wed,  5 Aug 2026 20:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785962396;
 bh=HDyA1AHqV1GG5znDjIJMQn0uh8/N2gKM1KJPkKkMP1Q=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=IEQKVUUGYgAOPLuRXTcVmhOdc3PtY0k7BSdBbqZleZxR7mgiIDaPDpbHzCRItbKqQ
 TiJc6rIaVvez4uxezNfnhwJkPpoAyA+2mpryh56weiQVj04QbK3i2GK/g3SobPoTKX
 8tmXIXXr8lQm1aNZ12uRPDThZUrKMGHOnVAPCBW+5HpGeCavZIe1tIBcLARa/Sa4pF
 fJ7DIEQWOwQyMGwtY4A/e676AmDgeJB0XFWdws1lYJf6rU6DLHlCL01sgSQ0JFPFHn
 rcCR4Ws1ki3c8Vqd7zBeGFuUdEmpclOJ8p9nS790tmxoIFRZ/C1LTLwyh8ll+SV3AE
 HxITaHbeouFxQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 22:39:50 +0200
Message-Id: <DKHATVF1WAE7.NGVXJQD12XQ@kernel.org>
Subject: Re: [PATCH v2 2/3] rust: dma: rename dma_handle to dma_address
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>
To: "Robin Murphy" <robin.murphy@arm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
 <20260805-falcon-dma-projections-v2-2-4cc9f3f13ee9@nvidia.com>
 <3a87960b-8a20-4947-a8b5-d5197174317c@arm.com>
In-Reply-To: <3a87960b-8a20-4947-a8b5-d5197174317c@arm.com>
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

On Wed Aug 5, 2026 at 1:32 PM CEST, Robin Murphy wrote:
> To be fair, that is sort of the intent in the C API as well, to be clear=
=20
> that DMA addresses must not simply be treated as physical addresses, and=
=20
> aren't necessarily address-like in general e.g. comparing two=20
> dma_handles is pretty meaningless, since they could have different=20
> values but still refer to the same underlying memory, or vice-versa.=20
> Adding or subtracting offsets within the bounds of the original=20
> allocation/mapping size is pretty much the only arithmetic that _is_ vali=
d.

Yes, I did suggest a dma::Range type [1] for this purpose, such that only t=
his
kind arithmetic is possible to do.

The dma::Range type should have a method returning its embedded raw value w=
hich
then can be used to program registers etc.

This patch is only an intermediate step, that clarifies that intent of the
current usage of dma_handle() (or now dma_address()), which is not to serve=
 as a
handle.

[1] https://github.com/Rust-for-Linux/linux/issues/1248

> However at the Rust level, the abstraction itself can convey (and even=20
> enforce!) most of that, so for the sake of clarity here, particularly if=
=20
> Rust programmers are likely to have their own expectations of what=20
> "address" and "handle" mean, then I'm inclined to agree.

Yeah, as mentioned in the link below, the handle that represents the alloca=
tion
are the DMA container types (such as dma::Coherent) themselves.

>> Link: https://lore.kernel.org/all/DK75LUA4NLGI.3P29AIZQE20V2@kernel.org/
