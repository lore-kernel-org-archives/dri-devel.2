Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3096ECD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 936E510EE0B;
	Wed,  6 May 2026 15:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dP9g+Djk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB7910EDED
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 15:46:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5290643C71;
 Wed,  6 May 2026 15:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066ADC2BCB0;
 Wed,  6 May 2026 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778082408;
 bh=UrrPk+6g39IIpATE+r/ALmveb23Z8oczij81iLseye8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dP9g+Djkm5vgq+XT5gHxbQN9nK+hgjOeB+2ttOxoZvfgDnuM7F+2kAMCpZZbaJfw3
 1jYe7w/7c2RwHsLe4iWkucX0PdFn0oaxw1aSbg6rPOgvjdxpjZRs8UrDkT5f5w9gqX
 vvuH5q1CElQxuQDDpWikYzU6vpx7vXGIBsNlYQ9jEIMpzgGgaSCys0Ku7DMC7CFa8r
 NjvkjnoimqjIiVeUH0Ov5qg/36dMLogEPEe7o7Z8CvWuSZB8ZG6q5esUNQ7k13e2gI
 Pi1HDY363kky4+RKDCwSHg/qVJlThuzJs/RmeZnwhv35/N8Rj8X4xmmwDmevBzGAla
 6eN+yC27w4Cyg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfauth.phl.internal (Postfix) with ESMTP id 4C5E3F40070;
 Wed,  6 May 2026 11:46:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 06 May 2026 11:46:46 -0400
X-ME-Sender: <xms:ZmL7aaCrplXZbMwKqZf_wHgZFma-18SVObNyRy5ZN7bZ2kJwgcvY_A>
 <xme:ZmL7aRrpHTg6rCA5tAy-BxDj4E9I1Amzk6Euw29pV8iRPs6fpIgC2b2J94_S64ApG
 mcSgB6BQBksYTCEmbA1QqrZSxG11sbj9Tc1SmLpcr-5m0P9PrNI3Ak>
X-ME-Received: <xmr:ZmL7aeCDktInw5GHk2hJefv-_5IKudZcO1oWIYoAYtgSUg_0PS6Vhuaax1-TligsqpaKVPknC0d2fXWr9hYBLeLrcdwjX4-x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdegleelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
 hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
 euffdvtdegvdektdetgfevvdehgeevhfdtheeuieeijeeitdeutdefgefhjeduleenucff
 ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhtrhgvvgdrmhgrnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
 thhhphgvrhhsohhnrghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsoh
 hquhhnpeepkhgvrhhnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthht
 ohepfeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohgvlhgrghhnvghlfh
 esnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
 rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorh
 hgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghj
 ohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsih
 hnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhn
 vghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpd
 hrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:ZmL7aZznNrlAxu4xTV4SLy9awAFbGk7hhvvyT_pHYRPfCouCbi81NA>
 <xmx:ZmL7aW6A5knDjHx_YgUPuSwoGItGjGRcxth0obiCn_feDX-32qdT_Q>
 <xmx:ZmL7aasUKCdE4FH2yr6CLWQiTup9SRqEkqVzsjVNMyMSXzHPnX1ZJQ>
 <xmx:ZmL7aTs7bthjmx0M_GRr-hQkuDAAkcR4w43kNtjNWY7c7gJ4NtEakg>
 <xmx:ZmL7aSvycf7zHrodrEPpch9XLB8S7iUQRtFzQiB_DHYDkT2o0DiJlu4T>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 May 2026 11:46:45 -0400 (EDT)
Date: Wed, 6 May 2026 08:46:44 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,	Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>,	Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>,	Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] rust: maple_tree: implement Send and Sync for MapleTree
Message-ID: <aftiZGt3HQe0Bf_x@tardis.local>
References: <20260506135122.GA1432412@joelbox2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506135122.GA1432412@joelbox2>
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

On Wed, May 06, 2026 at 09:51:22AM -0400, Joel Fernandes wrote:
> The C maple_tree struct contains a *mut c_void, which prevents Rust from
> auto-deriving Send/Sync. Following is an example error message when using
> MapleTree in nova-core's Vmm.
> 
> This propagates up through MapleTreeAlloc to Vmm, BarUser, Gpu, and NovaCore,
> causing NovaCore to fail the Send bound required by pci::Driver:
> 
>   error[E0277]: `*mut c_void` cannot be sent between threads safely
>       --> drivers/gpu/nova-core/driver.rs:77:22
>        |
>   77   | impl pci::Driver for NovaCore {
>        |                      ^^^^^^^^ `*mut c_void` cannot be sent between threads safely
>        |
>        = help: within `MapleTreeAlloc<()>`, the trait `Send` is not implemented for `*mut c_void`
>   note: required because it appears within the type `kernel::bindings::maple_tree`
>   note: required because it appears within the type `Opaque<kernel::bindings::maple_tree>`
>   note: required because it appears within the type `MapleTree<()>`
>   note: required because it appears within the type `MapleTreeAlloc<()>`
>        = note: required for `Box<MapleTreeAlloc<()>, Kmalloc>` to implement `Send`
>   note: required because it appears within the type `core::pin::Pin<Box<MapleTreeAlloc<()>, Kmalloc>>`
>   note: required because it appears within the type `Vmm`
>   note: required because it appears within the type `BarUser`
>   note: required because it appears within the type `Gpu`
>   note: required because it appears within the type `NovaCore`
>   note: required by a bound in `kernel::pci::Driver`
>       --> rust/kernel/pci.rs:294:19
> 
> Implement Send and Sync for MapleTree. The tree contains no thread-local
> state, and all shared access goes through the internal ma_lock spinlock.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
> RFC->v2: Just adjusted a few comments as suggested by Gary.
> 
> Sending this separately as discussed in the nova mm patch series that needs it:
> https://lore.kernel.org/all/252a4eef-f4f4-4edf-8154-06cae4ad8518@nvidia.com/
> 
>  rust/kernel/maple_tree.rs | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index 265d6396a78a..2400c905270d 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs
> @@ -16,7 +16,11 @@
>      alloc::Flags,
>      error::to_result,
>      prelude::*,
> -    types::{ForeignOwnable, Opaque},
> +    types::{
> +        ForeignOwnable,
> +        NotThreadSafe,
> +        Opaque, //
> +    },
>  };
>  
>  /// A maple tree optimized for storing non-overlapping ranges.
> @@ -240,7 +244,10 @@ pub fn lock(&self) -> MapleGuard<'_, T> {
>          unsafe { bindings::spin_lock(self.ma_lock()) };
>  
>          // INVARIANT: We just took the spinlock.
> -        MapleGuard(self)
> +        MapleGuard {
> +            tree: self,
> +            _not_send: NotThreadSafe,
> +        }
>      }
>  
>      #[inline]
> @@ -302,19 +309,29 @@ fn drop(mut self: Pin<&mut Self>) {
>      }
>  }
>  
> +// SAFETY: `MapleTree<T>` is `Send` if `T` is `Send` because `MapleTree` owns its elements.
> +unsafe impl<T: ForeignOwnable + Send> Send for MapleTree<T> {}
> +// SAFETY: `&MapleTree<T>` never hands out `&T`; all entry access is serialized
> +// by `ma_lock` or `&mut Guard`, so `T: Send` suffices (`T: Sync` not required).
> +unsafe impl<T: ForeignOwnable + Send> Sync for MapleTree<T> {}

I think you missed this:

	https://lore.kernel.org/rust-for-linux/aepRx2jgIKmoRp-r@tardis.local/

;-)

But on a second thought, should that (we have methods of `&MapleTree<T>`
-> `&T`) happen, we could always guard those methods with T: Sync. Maybe
it's worth to keep a note on that but, anyway

Reviewed-by: Boqun Feng <boqun@kernel.org>

Regards,
Boqun

> +
>  /// A reference to a [`MapleTree`] that owns the inner lock.
>  ///
>  /// # Invariants
>  ///
>  /// This guard owns the inner spinlock.
>  #[must_use = "if unused, the lock will be immediately unlocked"]
> -pub struct MapleGuard<'tree, T: ForeignOwnable>(&'tree MapleTree<T>);
> +pub struct MapleGuard<'tree, T: ForeignOwnable> {
> +    tree: &'tree MapleTree<T>,
> +    // A held spinlock must be released on the same CPU that acquired it.
> +    _not_send: NotThreadSafe,
> +}
>  
>  impl<'tree, T: ForeignOwnable> Drop for MapleGuard<'tree, T> {
>      #[inline]
>      fn drop(&mut self) {
>          // SAFETY: By the type invariants, we hold this spinlock.
> -        unsafe { bindings::spin_unlock(self.0.ma_lock()) };
> +        unsafe { bindings::spin_unlock(self.tree.ma_lock()) };
>      }
>  }
>  
> @@ -323,7 +340,7 @@ impl<'tree, T: ForeignOwnable> MapleGuard<'tree, T> {
>      pub fn ma_state(&mut self, first: usize, end: usize) -> MaState<'_, T> {
>          // SAFETY: The `MaState` borrows this `MapleGuard`, so it can also borrow the `MapleGuard`s
>          // read/write permissions to the maple tree.
> -        unsafe { MaState::new_raw(self.0, first, end) }
> +        unsafe { MaState::new_raw(self.tree, first, end) }
>      }
>  
>      /// Load the value at the given index.
> @@ -375,7 +392,7 @@ pub fn ma_state(&mut self, first: usize, end: usize) -> MaState<'_, T> {
>      #[inline]
>      pub fn load(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
>          // SAFETY: `self.tree` contains a valid maple tree.
> -        let ret = unsafe { bindings::mtree_load(self.0.tree.get(), index) };
> +        let ret = unsafe { bindings::mtree_load(self.tree.tree.get(), index) };
>          if ret.is_null() {
>              return None;
>          }
> -- 
> 2.34.1
> 
