Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD5CCD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 22:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 460F610E1A4;
	Wed,  6 May 2026 22:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="okgXWAw7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F45010E1A4
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 22:14:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E38142B9E;
 Wed,  6 May 2026 22:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D64C2BCB0;
 Wed,  6 May 2026 22:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778105682;
 bh=axvNPgDrWLZKKnsf+q30PofwYb4GXr/st7pQxXGLpm4=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=okgXWAw7Ej1oFp5s1UT6ehxBJP9cqnvEQCej3k8ZNsUpsrZZX/kbq/22g83H84JhN
 QRH/nZ4KOhsr+oUuLPi50k49++/KBTaZD23yO9U/5qh9CSG8HOOcR9VpItYOO1rJ9l
 bcgUgTS5q2+zklR4ksWF8xMnQLzIQe+HEnV6wd5ruyuR7Cp9sGNU1gSWfoN1wKPyDn
 NkhMEbVPI6FWK31lPctLEadIZqqFw57ywZ3PTSdbvrE8ooRKsT/H0Qxk4MDJkadzY1
 kuP0Vb4uMgYWL3l5QMuvbW2Nd/Pwu81vpCV3CXYsMzR7/YbeKUwiHUVxUecL9DZmA3
 RDko0GXRT38og==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 May 2026 00:14:35 +0200
Message-Id: <DIBXUUL0JN6B.2H1X89OCUB6D0@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 02/25] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
 <20260506215113.851360-3-dakr@kernel.org>
In-Reply-To: <20260506215113.851360-3-dakr@kernel.org>
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

On Wed May 6, 2026 at 11:50 PM CEST, Danilo Krummrich wrote:
> From: Gary Guo <gary@garyguo.net>
>
> There are a few cases, e.g. when dealing with data referencing each other=
,
> one might want to write code that are generic over lifetimes. For example=
,
> if you want take a function that takes `&'a Foo` and gives `Bar<'a>`, you
> can write:
>
>     f: impl for<'a> FnOnce(&'a Foo) -> Bar<'a>,
>
> However, it becomes tricky when you want that function to not have a fixe=
d
> `Bar`, but have it be generic again. In this case, one needs something th=
at
> is generic over types that are themselves generic over lifetimes.
>
> `ForLt` provides such support. It provides a trait `ForLt` which describe=
s
> a type generic over lifetime. One may use `ForLt::Of<'a>` to get an
> instance of a type for a specific lifetime.
>
> For the case of cross referencing, one would almost always want the
> lifetime to be covariant. Therefore this is also made a requirement for t=
he
> `ForLt` trait, so functions with `ForLt` trait bound can assume covarianc=
e.
>
> A macro `ForLt!()` is provided to be able to obtain a type that implement=
s
> `ForLt`. For example, `ForLt!(for<'a> Bar<'a>)` would yield a type that
> `<TheType as ForLt>::Of<'a>` is `Bar<'a>`. This also works with lifetime
> elision, e.g. `ForLt!(Bar<'_>)` or for types without lifetime at all, e.g=
.
> `ForLt!(u32)`.
>
> The API design draws inspiration from the higher-kinded-types [1] crate,
> however different design decision has been taken (e.g. covariance
> requirement) and the implementation is independent.
>
> License headers use "Apache-2.0 OR MIT" because I anticipate this to be
> used in pin-init crate too which is licensed as such.
>
> Link: https://docs.rs/higher-kinded-types/ [1]
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
