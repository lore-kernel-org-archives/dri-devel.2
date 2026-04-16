Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C859F8DFCB
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0BE10E93C;
	Thu, 16 Apr 2026 21:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QBhDuywR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3462B10E93C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 21:51:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1560D6012A
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 21:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8531C2BCAF
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776376258;
 bh=aG0vDFPQ35XSz8NFTuZVdur3QC6+5/Wwqk+iYQ3iORE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QBhDuywR3lGxmonIUEt9bFyXI6A+p9PtbVP0m1Y74IL0TME6SbB0BHxPFqPHbzePO
 L914Z5ZXFSDGTRVuIRt4Zj+kZofxHADlnAOIXuB0pqaQnL+LXmoLnGvTxL3YS+Y9Ov
 PPAKRatwriRBySdtw21/IWwCmSJFzMfy0lwru8BEv6jg4Ju8y8rF6+o0ArbT83w1q+
 YfyDoXM2cF6sNntKMS/TE7W0jMK7hZVHOJRdHTMOktAXnNFiJ4qbCS9u5a5IrG/zNQ
 UnJ1CFofjYncpMSFoi+hX50yynKhBrqC+aLhYZDG48ksYG1R2ooQTOpcc/cQvaXkut
 gcrbF3SM7hiZg==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id B7556F4007D;
 Thu, 16 Apr 2026 17:50:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 17:50:57 -0400
X-ME-Sender: <xms:wVnhab4Dg1V4SvYlP0zcwNc9cHOaXhkxtE7tYIecxelmVnzRhWgw4g>
 <xme:wVnhaQeLa_PtYuifqr27E7oSrLrqr-qMgUUuMHapfB54lzARfOSKyWliCpNr1WJ4G
 of9D_eUlrQOUYVaB1mRLCY8QfjioKT1q7jHwwDV0SAvXcPKHH6RTcY>
X-ME-Received: <xmr:wVnhaWwPomKMk1yPh2xpOt3nY_RMDUK34RWXPXtKJaxxX7uCoAs8x4sX2IZu492neqYcDl8bnBbEhh4Dj8Pu1Bf0KCjJyNY5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegkedufecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeortd
 dttddunecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdr
 ohhrgheqnecuggftrfgrthhtvghrnhepgeefkeefleevgfejveejtdeludevgfekffdutd
 dtffehffeiieevledtjedvhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
 pehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
 hthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrhhnvghl
 rdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudegpdhmohguvgepsh
 hmthhpohhuthdprhgtphhtthhopeifohhrkhesohhnuhhrohiikhgrnhdruggvvhdprhgt
 phhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhi
 hhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdgrlhhmvghiuggr
 segtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesghhmrghilh
 drtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohep
 ughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtph
 htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
 phhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wVnhaeoYTLnJZqCLLDZy6KVX8JrAY6u_KLwb_2DMrUz4w0brJORF5g>
 <xmx:wVnhacxoPGoXg9LMl8FX7W_zZoLyNmWTzNSMarqBCTmNG-mx9AYfww>
 <xmx:wVnhaar7JI3Lv6THMpPwZkVny2rBRyUgH9Mf4OBa8vlvx67A7sr--Q>
 <xmx:wVnhaUeDWGx2qcBiHSQbR_7HHEHckVsg6-lZ-HOOq8gocbwEmQN3Qg>
 <xmx:wVnhaVrTfFotw65ZhuAJsUC6cLAx5S0TFqArRXpqem-0gI1vwnCLJExX>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 17:50:57 -0400 (EDT)
Date: Thu, 16 Apr 2026 14:50:56 -0700
From: Boqun Feng <boqun@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
 rostedt@goodmis.org
Subject: Re: [PATCH v2 1/4] rust: add SRCU abstraction
Message-ID: <aeFZwCsuhSrQATRM@tardis.local>
References: <20260416171838.206128-1-work@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416171838.206128-1-work@onurozkan.dev>
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

On Thu, Apr 16, 2026 at 08:18:37PM +0300, Onur Özkan wrote:
> Add a Rust abstraction for sleepable RCU (SRCU), backed by
> srcu_struct. Provide FFI helpers and a safe wrapper with a
> guard-based API for read-side critical sections.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/helpers/helpers.c   |   1 +
>  rust/helpers/srcu.c      |  18 +++++++
>  rust/kernel/sync.rs      |   2 +
>  rust/kernel/sync/srcu.rs | 109 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 130 insertions(+)
>  create mode 100644 rust/helpers/srcu.c
>  create mode 100644 rust/kernel/sync/srcu.rs
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 875a9788ad40..052fef89d5f0 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -60,6 +60,7 @@
>  #include "signal.c"
>  #include "slab.c"
>  #include "spinlock.c"
> +#include "srcu.c"
>  #include "sync.c"
>  #include "task.c"
>  #include "time.c"
> diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
> new file mode 100644
> index 000000000000..b372b733eb89
> --- /dev/null
> +++ b/rust/helpers/srcu.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/srcu.h>
> +
> +__rust_helper int rust_helper_init_srcu_struct(struct srcu_struct *ssp)
> +{
> +	return init_srcu_struct(ssp);

init_srcu_struct() is defined as a macro when LOCKDEP=y so that each
srcu_struct has a own lock_class_key. Using a binding helper like this
will make all srcu_struct share the same key. You can refer to how
rust_helper___spin_lock_init() does (including how new_spinlock!()
works).

> +}
> +
> +__rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)
> +{
> +	return srcu_read_lock(ssp);
> +}
> +
> +__rust_helper void rust_helper_srcu_read_unlock(struct srcu_struct *ssp, int idx)
> +{
> +	srcu_read_unlock(ssp, idx);
> +}
> \ No newline at end of file
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 993dbf2caa0e..0d6a5f1300c3 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -21,6 +21,7 @@
>  pub mod rcu;
>  mod refcount;
>  mod set_once;
> +pub mod srcu;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use completion::Completion;
> @@ -31,6 +32,7 @@
>  pub use locked_by::LockedBy;
>  pub use refcount::Refcount;
>  pub use set_once::SetOnce;
> +pub use srcu::Srcu;
>  
>  /// Represents a lockdep class.
>  ///
> diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs
> new file mode 100644
> index 000000000000..cf0c16248ea3
> --- /dev/null
> +++ b/rust/kernel/sync/srcu.rs
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Sleepable read-copy update (SRCU) abstraction.
> +//!
> +//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu.h)
> +
> +use crate::{
> +    bindings,
> +    error::to_result,
> +    prelude::*,
> +    types::{
> +        NotThreadSafe,
> +        Opaque, //
> +    },
> +};
> +
> +use pin_init::pin_data;
> +
> +/// Creates an [`Srcu`] initialiser.
> +#[macro_export]
> +macro_rules! new_srcu {
> +    () => {
> +        $crate::sync::Srcu::new()
> +    };
> +}
> +
> +/// Sleepable read-copy update primitive.
> +///
> +/// SRCU readers may sleep while holding the read-side guard.
> +#[repr(transparent)]
> +#[pin_data(PinnedDrop)]
> +pub struct Srcu {
> +    #[pin]
> +    inner: Opaque<bindings::srcu_struct>,
> +}
> +
> +impl Srcu {
> +    /// Creates a new SRCU instance.
> +    pub fn new() -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu_struct| {
> +                // SAFETY: `ptr` points to valid uninitialised memory for a `srcu_struct`.
> +                to_result(unsafe { bindings::init_srcu_struct(ptr) })
> +            }),
> +        })
> +    }
> +
> +    /// Enters an SRCU read-side critical section.
> +    pub fn read_lock(&self) -> Guard<'_> {
> +        // SAFETY: By the type invariants, `self.inner.get()` is a valid initialized `srcu_struct`.
> +        let idx = unsafe { bindings::srcu_read_lock(self.inner.get()) };
> +
> +        Guard {
> +            srcu: self,
> +            idx,
> +            _nts: NotThreadSafe,
> +        }
> +    }
> +
> +    /// Waits until all pre-existing SRCU readers have completed.
> +    pub fn synchronize(&self) {
> +        // SAFETY: By the type invariants, `self.inner.get()` is a valid initialized `srcu_struct`.
> +        unsafe { bindings::synchronize_srcu(self.inner.get()) };
> +    }
> +
> +    /// Waits until all pre-existing SRCU readers have completed, expedited.
> +    ///
> +    /// This requests a lower-latency grace period than [`Srcu::synchronize`] typically
> +    /// at the cost of higher system-wide overhead. Prefer [`Srcu::synchronize`] by default
> +    /// and use this variant only when reducing reset or teardown latency is more important
> +    /// than the extra cost.
> +    pub fn synchronize_expedited(&self) {
> +        // SAFETY: By the type invariants, `self.inner.get()` is a valid initialized `srcu_struct`.
> +        unsafe { bindings::synchronize_srcu_expedited(self.inner.get()) };
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for Srcu {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: `self` is pinned and `inner` contains a valid initialized `srcu_struct`.

I think we need srcu_barrier() here to ensure all SRCU callbacks have
finished. Otherwise if there is a pending callback, one of the "leak it"
branch will be taken, and we cannot free the srcu_struct since other
thread may still access it. (It's impossible for the current API to
allow this happen since call_srcu() is not supported yet, but that's a
natural extension after the initial support).

Please do double-check whether other "leak it" conditions can happen or
not in cleanup_srcu_struct().

> +        unsafe { bindings::cleanup_srcu_struct(self.as_ref().get_ref().inner.get()) };
> +    }
> +}
> +
> +// SAFETY: `srcu_struct` may be shared and used across threads.
> +unsafe impl Send for Srcu {}
> +// SAFETY: `srcu_struct` may be shared and used concurrently.
> +unsafe impl Sync for Srcu {}
> +
> +/// Guard for an active SRCU read-side critical section on a particular [`Srcu`].
> +pub struct Guard<'a> {
> +    srcu: &'a Srcu,
> +    idx: core::ffi::c_int,
> +    _nts: NotThreadSafe,

Just want to bring this up for completeness, if we use
srcu_{up,down}_read() then the Guard is Send. Not sure there is a need
for this at the moment, just make a note in case that anyone might need
it.

Regards,
Boqun

> +}
> +
> +impl Guard<'_> {
> +    /// Explicitly exits the SRCU read-side critical section.
> +    pub fn unlock(self) {}
> +}
> +
> +impl Drop for Guard<'_> {
> +    fn drop(&mut self) {
> +        // SAFETY: `Guard` is only constructible through `Srcu::read_lock()`,
> +        // which returns a valid index for the SRCU instance.
> +        unsafe { bindings::srcu_read_unlock(self.srcu.inner.get(), self.idx) };
> +    }
> +}
> -- 
> 2.51.2
> 
> 
