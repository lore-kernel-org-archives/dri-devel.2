Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DFECD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF5B112164;
	Wed,  3 Jun 2026 17:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TfteH+Qo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E25FD112164
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 17:07:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D8C8434C8;
 Wed,  3 Jun 2026 17:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178941F00899;
 Wed,  3 Jun 2026 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780506465;
 bh=SUUl90bBxGO1B6lX433etgqNanyhS7+oA+suoDDsSXQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TfteH+Qoi2UJLhzosqfIIf8mQyokOx+B8Df6uoEQj5ZZIk6zmhrL3qeq7M1pQW4ed
 RWhqwiZTinfwLqDbDa1CzHhZUKrpaF7MJjFBWmtjfc/Q2aXYMDhwYIipNjCtGlo3lR
 EukoiPXnVwFzvDcVqd8vgIj1HGSO5prweDlFuMXcZU8BKPym4/gTWElsXRuZSQe2Ii
 Hhn9v7R2wlM3pwkjaWwFRz+iDIi3Y3sW8xPimYi5z3JTuTZQvEONwqYU/L+Lq7TMEa
 Vj62kj/kmRDbd0+BSV1CtTV0WLoKJ/2cB8iSQjPnsELiZQHoqTG1wqgXDVomZ3uZMN
 yHczZCfpUoC8g==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfauth.phl.internal (Postfix) with ESMTP id 5A4D3F4006B;
 Wed,  3 Jun 2026 13:07:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 13:07:43 -0400
X-ME-Sender: <xms:X18gasfGP5WcJmRki7zFq4so53It1xccZCfFWaT6Hq0XZ34UEyTeMQ>
 <xme:X18gaq-Wl0hSECTaITk6GuiIZbduhh51691-7DSbdeHhFvd6Zdn-mRNl2j24Lebpb
 9dkKH0SKrAW0qvnbdi53a9kuk-pB2n8lR57AiuiYRyfK9L7aqFUBg>
X-ME-Received: <xmr:X18gatEsYo1r8PORpvF8kmnRVvAJFelUrbFYvXTODfyPckwQxL6CAWlnPro>
X-ME-Proxy-Cause: dmFkZTEmLONpDl4bNrf+o6zh7xRwbhEQE5eD6c9jTYvZefMuZUkAi41AL8/OImTsC5i9Mv
 FCCYs9wuRgz0cwFVweEieedbLvtPWT2IVkFzHB8M2gC2apblN7NZFhdha5TasqrGtLE0qy
 uIFSFmNz9Lwt+qCdl/hUIX47wQGCUJhI/PqG3lSm+S3E8T/HrzvKYpzCKB5a5bEtK9KZcE
 CMnNtMh8kbiM+DSZG5zwYSR8lQ1de20HcPwXFuxABzYpPX+w4AEioZfxRDq1QUiV6eAz25
 vHt34XXB4KaYPV9tPS+WT9MlsKuCFZ8Tp5uyQHVL4WDmpYCj9OUyEoAu750SBIL33RqdVI
 sGjIp7TDKYLDYzMPP87uaKBHVSrVdlm6LSToUW8e8AVbRZpj3y+rIe931HDmtONaaVHNPF
 zTTnO0fWMvmfjPAgFCd/f5aGuNUVrt5pBf3AhH4whkLI9eRP8qA8n4Ru4N62/JUgZMMYny
 zKViaMAMl/LmRM77fir82u82yv30qb0yXfSxdhtv/TukBnU6HY6ocUrPvw8GbvH/VmOjs4
 11wKcORvSUIGO9DJ8pePVF0iEM1hwLzIq2gh+FIDAaGMg+BCNI8fFB2ROY+gZDGUL9T5V5
 IH7JT93x17OaMC4zb7LSu/152uWJE89gBIskOFls7Blfaf9fadIdVj3GlhUw
X-ME-Proxy: <xmx:X18gaqk1IckXChj5H7pyCrpWGmMYXi6l9in6aRoJhVAUPQ-IVthOcA>
 <xmx:X18gas8RkAZTqd-KhhEdJVsrJlLE_83qQCncY9M_wUolG19Dnvb0dg>
 <xmx:X18gaoDTBH01zwmcDY87i6AY1xqFm5jTBn2C5urzdrN0C96Y5_PGlw>
 <xmx:X18gat37pIGsmg_BM76LACgIPSu_9Jn-z63Wk_HEhhqd_rXmnJWMbw>
 <xmx:X18gavp0e1F0JueB3GAC1kMjwesAjWRRJwfxQz-_ruRYPzj-DJCcDKAa>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 13:07:42 -0400 (EDT)
Date: Wed, 3 Jun 2026 10:07:41 -0700
From: Boqun Feng <boqun@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>,	Lorenzo Stoakes <ljs@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: rcu: add RcuBox type
Message-ID: <aiBfXXnD0MA-7p2F@tardis-2.local>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-4-phasta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530143541.229628-4-phasta@kernel.org>
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

On Sat, May 30, 2026 at 04:35:10PM +0200, Philipp Stanner wrote:
> From: Alice Ryhl <aliceryhl@google.com>
> 

A few minor things below:

[...]
> diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/rcu_box.rs
> new file mode 100644
> index 000000000000..2508fdb609ec
> --- /dev/null
> +++ b/rust/kernel/sync/rcu/rcu_box.rs
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2026 Google LLC.
> +
> +//! Provides the `RcuBox` type for Rust allocations that live for a grace period.
> +
> +use core::{ops::Deref, ptr::NonNull};
> +
> +use kernel::{

Let's use `crate::` here since RcuBox is part of the kernel crate.

> +    alloc::{self, AllocError},
> +    bindings,
> +    ffi::c_void,
> +    prelude::*,
> +    sync::rcu::{ForeignOwnableRcu, Guard},
> +    types::ForeignOwnable,
> +};
> +
> +/// A box that is freed with rcu.
> +///
> +/// The value must be `Send`, as rcu may drop it on another thread.
> +///
> +/// # Invariants
> +///
> +/// * The pointer is valid and references a pinned `RcuBoxInner<T>` allocated with `kmalloc`.
> +/// * This `RcuBox` holds exclusive permissions to rcu free the allocation.
> +pub struct RcuBox<T: Send>(NonNull<RcuBoxInner<T>>);
> +
> +struct RcuBoxInner<T> {
> +    value: T,
> +    rcu_head: bindings::callback_head,

Probably should reorder these fields.

> +}
> +
> +// Note that `T: Sync` is required since when moving an `RcuBox<T>`, the previous owner may still
> +// access `&T` for one grace period.
> +//
> +// SAFETY: Ownership of the `RcuBox<T>` allows for `&T` and dropping the `T`, so `T: Send + Sync`
> +// implies `RcuBox<T>: Send`.
> +unsafe impl<T: Send + Sync> Send for RcuBox<T> {}
> +
> +// SAFETY: `&RcuBox<T>` allows for no operations other than those permitted by `&T`, so `T: Sync`
> +// implies `RcuBox<T>: Sync`.
> +unsafe impl<T: Send + Sync> Sync for RcuBox<T> {}

@Alice, we have `T: Send` mostly because `RcuBox` itself has the `T:
Send` bound? I.e. the to be `Sync` we actually don't need `T` being
`Send`, right?

Regards,
Boqun

[...]
