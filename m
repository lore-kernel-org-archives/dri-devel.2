Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4144BC4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 06:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A884410E538;
	Sat, 18 Jul 2026 06:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MXfADJtX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B0810E538
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 06:00:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5F22433D7;
 Sat, 18 Jul 2026 06:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545631F000E9;
 Sat, 18 Jul 2026 06:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784354422;
 bh=Fi3mB6314gmGwmTOUwOcuLHMY2UGgoza6zEQ8FZJlfc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MXfADJtXdPlb4vN1FgjhtIcDGURjsPr44MXMKE1r33s2jfgoJ1dW5+z3ajcqcfQEp
 YVI0zuqsDJc4y6TZILv7O+HqzKTgofnm45cU2aYelEHerUi6bOl2Q3wWCXftPzkO5W
 kGL51vBUO7353nAkA1xmovga6zqX0TVHFpciDAeVKuveePPlC8nZeXh8OKyKw5YH2r
 Kgh/ETlPsQbJ8weXdp7PTJHVIdHQKxxKmTpZ6KefwUcQrCZXVYc6IJJLhhfPkAQQei
 e7J12fgpoVhx4QJFyHuhejjpUc9cdpuTRctN5nExexHoNZwfz+90uegbKynSxyzC8S
 Qcbq/eU+PlROw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/4] rust: maple_tree: Add load_rcu()
To: "Boqun Feng" <boqun@kernel.org>
Cc: ojeda@kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260718053247.25154-3-boqun@kernel.org>
References: <20260718053247.25154-1-boqun@kernel.org>
 <20260718053247.25154-3-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 06:00:21 +0000
Message-Id: <20260718060022.545631F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Lockless `load_rcu()` leads to use-after-free on maple tree in=
ternal nodes because the tree is not initialized with `MT_FLAGS_USE_RCU`.
- [High] The `ForeignOwnableRcu` trait is missing the `unsafe` keyword, all=
owing safe code to violate RCU memory safety guarantees.
- [High] `RcuBox`'s `Drop` implementation bypasses the custom `Allocator` p=
arameter when dropping types that do not require drop logic.
--

--- Patch [2]: [RFC PATCH v2 2/4] rust: maple_tree: Add load_rcu() ---
commit fcc71907e345f6a007c4675e0956efaca9ebf22c
Author: Alice Ryhl <aliceryhl@google.com>

rust: maple_tree: Add load_rcu()

This patch introduces a lockless load_rcu() method to the MapleTree,
assuming RCU-safe containers are used. The patch series also adds an
RcuBox type and a ForeignOwnableRcu trait to support RCU-based freeing
of box contents.

> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index 265d6396a78a1..1499191b8935a 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs
[ ... ]
> @@ -233,6 +237,54 @@ pub fn erase(&self, index: usize) -> Option<T> {
>          unsafe { T::try_from_foreign(ret) }
>      }
> =20
> +    /// Load the value at the given index with rcu.
[ ... ]
> +    #[inline]
> +    pub fn load_rcu<'rcu>(
> +        &self,
> +        index: usize,
> +        _rcu: &'rcu rcu::Guard,
> +    ) -> Option<T::RcuBorrowed<'rcu>>
> +    where
> +        T: ForeignOwnableRcu,
> +    {
> +        // SAFETY: `self.tree` contains a valid maple tree.
> +        let ret =3D unsafe { bindings::mtree_load(self.tree.get(), index=
) };

[Severity: Critical]
Does this code cause a use-after-free on maple tree internal nodes?

Because load_rcu() executes bindings::mtree_load() without acquiring the
tree's spinlock, the tree must be initialized with bindings::MT_FLAGS_USE_R=
CU
to be safe against concurrent writers.

However, MapleTree::new() initializes the tree without this flag:

rust/kernel/maple_tree.rs:MapleTree::new() {
    ...
    tree <- Opaque::ffi_init(|slot| unsafe { bindings::mt_init_flags(slot, =
0) }),
    ...
}

Because the tree is in non-RCU mode, writers will synchronously free intern=
al
nodes via kfree(), causing load_rcu() to dereference freed memory during its
lockless traversal.

> +        if ret.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: If the pointer is not null, then it references a vali=
d instance of `T`. It is
> +        // safe to borrow the instance for 'rcu because the signature of=
 this function enforces that
> +        // the borrow does not outlive an rcu grace period.
> +        Some(unsafe { T::rcu_borrow(ret) })
> +    }
> +
>      /// Lock the internal spinlock.
>      #[inline]
>      pub fn lock(&self) -> MapleGuard<'_, T> {
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index 2bae76d229f09..42f6bbc83f71f 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
[ ... ]
> @@ -66,3 +78,25 @@ pub fn synchronize_rcu() {
>      // SAFETY: `synchronize_rcu()` is always safe to be called from proc=
ess context.
>      unsafe { bindings::synchronize_rcu() };
>  }
> +
> +/// Declares that a pointer type is rcu safe.
> +pub trait ForeignOwnableRcu: ForeignOwnable {

[Severity: High]
Should this trait be marked unsafe to enforce the RCU deferral contract?

The ForeignOwnableRcu trait promises that removing the node will not
invalidate the object until an RCU grace period elapses, allowing load_rcu()
to safely borrow it.

Because ForeignOwnableRcu is a safe trait, developers can implement it for
types that drop synchronously (like Box<T>, which already implements the
unsafe trait ForeignOwnable).

Doing so violates the safety assumptions of load_rcu(), causing a
use-after-free without any unsafe block in the user's code.

> +    /// Type used to immutably borrow an rcu-safe value that is currentl=
y foreign-owned.
> +    type RcuBorrowed<'a>
> +    where
> +        Self: 'a;
> +
[ ... ]
> diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/rcu_b=
ox.rs
> new file mode 100644
> index 0000000000000..cb1fd422480a8
> --- /dev/null
> +++ b/rust/kernel/sync/rcu/rcu_box.rs
[ ... ]
> +impl<T: Send, A: Allocator> Drop for RcuBox<T, A> {
> +    fn drop(&mut self) {
> +        // SAFETY: The `rcu_head` field is in-bounds of a valid allocati=
on.
> +        let rcu_head =3D unsafe { &raw mut (*self.0.as_ptr()).rcu_head };
> +        if core::mem::needs_drop::<T>() {
> +            // SAFETY: `rcu_head` is the `rcu_head` field of `RcuBoxInne=
r<T>`. All users will be
> +            // gone in an rcu grace period. This is the destructor, so w=
e may pass ownership of the
> +            // allocation.
> +            unsafe { bindings::call_rcu(rcu_head, Some(drop_rcu_box::<T,=
 A>)) };
> +        } else {
> +            // SAFETY: All users will be gone in an rcu grace period.
> +            // TODO: We are luckily since `kvfree_call_rcu()` works on b=
oth kmalloc and vmalloc,
> +            // maybe a new `Allocator` method is needed.
> +            unsafe { bindings::kvfree_call_rcu(rcu_head, self.0.as_ptr()=
.cast()) };

[Severity: High]
Does this bypass the custom Allocator parameter when dropping types that do
not require drop logic?

If an RcuBox<T, A> is created with a custom allocator A (e.g., a DMA or
memory pool allocator) where T does not implement Drop, the code directly
branches to kvfree_call_rcu().

This hardcodes the assumption that the memory belongs to kmalloc or vmalloc.
When the RcuBox is freed, kvfree_call_rcu() will attempt to free memory it
does not own, resulting in allocator corruption.

> +        }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718053247.2515=
4-1-boqun@kernel.org?part=3D2
