Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059FFD58CB0
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 00:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618C710E1C6;
	Mon, 23 Mar 2026 00:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BGPzw/yt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2151510E1C6
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 00:16:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4338F60103
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 00:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9D2C2BCB4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 00:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774224968;
 bh=Vz6hlss71wCpMQTFpOI1UCwil8q0Rwfj9v3C/adr88w=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=BGPzw/ytcPefLYARAiZnP0yGdMdSXfN7aqYFzQElofJWIN+X0Cf3NSmxZdqccF7R1
 HhhPrsMuBdhfNR4huC7O7v1T3nQpR82J1JMV7mdEgnQXmh4zmu/5fv2TUhjERii5Rk
 piKO2/FSW//MRfgFMsm281vK/0fv+7IBau6Kn1vu2Co7vE7+B9KI3liR07PjJe2PZM
 OUwx/AbwbBH2GdHEEk4d7PZysQh//tdYmUuizDfHgXCz0XAo7uRZLOVYaXQRvtbl/o
 0R2T2hh0fvjqLL944afhGbhPN8mcA718ulP9jvnBz9TzRhKdwMRrH9P//SJO/+CCAf
 lUsD10T+TOvsw==
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-38be5e86918so32450511fa.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 17:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXHWTSnSeZemuqmgztDd1W+UB6dec0KlwGm2FPS60ozj12MaUTdrofibLg1WbZNDAwZI/98LMkCib8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzzmlye5sGPFZgGOAsxzcwjK/eP8v377NzGgzU4p+uSQHQMjWBr
 ifp/y/Nuzrl4eaMlTMX+xUcoew+A4fQtCbmrAkmJZ6g/ntVXfN4BjV805BijGpwM6GigLN8fuWg
 U13yLdwl8QORD9b6qQCMF72djev9iEfM=
X-Received: by 2002:a05:651c:1313:b0:38b:df0c:979f with SMTP id
 38308e7fff4ca-38bf9741c1bmr26363211fa.37.1774224965758; Sun, 22 Mar 2026
 17:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
In-Reply-To: <20260319121653.2975748-5-gary@kernel.org>
From: Tamir Duberstein <tamird@kernel.org>
Date: Sun, 22 Mar 2026 20:15:29 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9k+aTosVrC+e5SAm7Hso60sGw=YiBRjwwx5ruRNgSRepA@mail.gmail.com>
X-Gm-Features: AQROBzDn4PtiEdBNjn48YaossWLeRtmfaQJy0WX92eUX_bEnBMYsO2ItiMTXlbM
Message-ID: <CAJ-ks9k+aTosVrC+e5SAm7Hso60sGw=YiBRjwwx5ruRNgSRepA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Yury Norov <yury.norov@gmail.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, 
 Waiman Long <longman@redhat.com>, Yury Norov <ynorov@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 19, 2026 at 8:17=E2=80=AFAM Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> Given the macro scoping rules, all macros are rendered 3 times, in the
> module, in the top-level of kernel crate, and in the prelude.
>
> Add `#[doc(no_inline)]` to the prelude so it just shows up as re-export.
> Add `#[doc(hidden)]` to the macro definition and `#[doc(inline)]` to the
> re-export inside `build_assert` module so the top-level items are hidden.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/nova-core/bitfield.rs    |  4 ++--
>  drivers/gpu/nova-core/num.rs         |  2 +-
>  rust/kernel/build_assert.rs          | 19 ++++++++++++-------
>  rust/kernel/dma.rs                   |  5 +++--
>  rust/kernel/io/register.rs           | 19 ++++++++++++-------
>  rust/kernel/io/resource.rs           |  2 +-
>  rust/kernel/ioctl.rs                 |  2 +-
>  rust/kernel/net/phy/reg.rs           |  8 +++++---
>  rust/kernel/num/bounded.rs           |  2 +-
>  rust/kernel/prelude.rs               |  3 ++-
>  rust/kernel/sync/atomic/internal.rs  |  9 ++++++---
>  rust/kernel/sync/atomic/predefine.rs |  2 +-
>  rust/kernel/sync/locked_by.rs        |  2 +-
>  rust/kernel/sync/refcount.rs         |  8 +++++---
>  rust/kernel/xarray.rs                | 10 ++++++++--

Acked-by: Tamir Duberstein <tamird@kernel.org>
