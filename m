Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503F1C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7496F10EC83;
	Thu, 17 Sep 2026 08:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K16aZhmh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E442010EC83
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:51:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9595F439F5;
 Thu, 17 Sep 2026 08:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4585C1F000FF;
 Thu, 17 Sep 2026 08:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789635064;
 bh=ZhuQHomawxLk9rQqvM39AmBak2r/Ub1GZwtl/wLVXyk=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=K16aZhmhKthNV915bJgiNIphPE26uyCyZSe3Qniutu0IGBLXxBYinl9yY8x/sFM0l
 sbu7oVMWCQFB41/9l9uhSh3vrkWYMRpZBzvVDdhOUrnA27NAyleyMFrFRTUoVgU60X
 KZ0AKyxDko99+ePCJy1tHIAhAyEzouaAKJ5TMXxBTQXzDodnoZMTvFCAjCw9qHIMeT
 QWPPNV4KLsY0+193h9mmXAEUxHbPDYqR8BlxoIPqFwiCENDmNnbtQiD28Saexi9X+A
 w3rK2aVyegcU6pbnUPv+IExie1oO9qBLzuKtCmMMkq3ssYqnuvxZXC79QaWPbZhca3
 yf1qIN0nnc84g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 10:50:58 +0200
Message-Id: <DLHGOK4T4SCX.37QOVMLFTYFFQ@kernel.org>
Subject: Re: [PATCH v4 1/2] rust: num: add cv! macro to create values from
 constant expressions
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
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
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260917-cv-v4-0-547ef5727451@nvidia.com>
 <20260917-cv-v4-1-547ef5727451@nvidia.com>
In-Reply-To: <20260917-cv-v4-1-547ef5727451@nvidia.com>
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

On Thu Sep 17, 2026 at 10:34 AM CEST, Eliot Courtney wrote:
> Currently, using NonZero/Bounded constants is quite verbose. It's
> unfortunate because it disincentivizes using it in interface boundaries.
> Introduce a macro to make it nicer to use. The macro `cv!` (for constant
> value) takes a const integer expression and widens it to i128 (at build
> time only) before passing it as a const generic value to a new trait
> `FromConst`. The value is then converted and appears in the
> associated constant `FromConst::VALUE`. The trait is implemented by
> NonZero, Bounded, and Alignment and lets values of each be constructed
> from constants without a verbose turbofish syntax.
> For example, `const { NonZero::new(1).unwrap() }` can be written as
> `cv!(1)`.
>
> Add the `cv!` macro to the prelude so it doesn't need to be imported
> explicitly to use it.
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

> +/// use core::num::NonZero;
> +/// use kernel::num::Bounded;
> +/// use kernel::ptr::Alignment;

NIT: Let's use the kernel's import style.
