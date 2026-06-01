Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B38ACD6E4C
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 07:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAD8112F32;
	Mon,  1 Jun 2026 07:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="P6Tgqh7K";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0792112F32
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 07:56:41 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gTR9y1vJSz9tdy;
 Mon,  1 Jun 2026 09:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780300598; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1URQBoGf9nbCa99ErlnRLlBGaMQP3UsUIruVAVDE5TI=;
 b=P6Tgqh7KD/X5qaaXWBeT1qExrw/0YLeYi4ijpGMX/3Cx9TUlsP1fSuQlJfld5WULO4VlVe
 vHJfKvdKSaTuaGI3tyTg3rqegfqVNGMCx5sc+E6bJlKbq4a6oEWcQqyDq1rHIUdlABLCG9
 qJFB3AQ35NiJ5TzERL5/Bkico/0ZYs2q4y2zO6PGXjVc/EC9de8ybG62KoohaWsrePXg5/
 J5x5MMQsIuAT6FCCbEkKxvFIO4JjTv2Ofgaz45TeDaOElXzcnJO9eEZEL9goX16MO2i2Bz
 rh31T5bF8yHbkzj3Tq39au7ShEXjwuCBw39W6CUiDCUc5dsWKWNkKf+5SnFWtA==
Message-ID: <e8b16f3b40d42f3b0a8814180fa9b06f82c9d901.camel@mailbox.org>
Subject: Re: [PATCH 2/4] rust: rcu: add RcuBox type
From: Philipp Stanner <phasta@mailbox.org>
To: Boqun Feng <boqun@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal	
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker	 <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki	 <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers	
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Zqiang <qiang.zhang@linux.dev>, Daniel Almeida
 <daniel.almeida@collabora.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Igor Korotin <igor.korotin@linux.dev>,
 Lorenzo Stoakes	 <ljs@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori	 <fujita.tomonori@gmail.com>, Krishna Ketan Rai
 <prafulrai522@gmail.com>,  Shankari Anand <shankari.ak0208@gmail.com>,
 manos@pitsidianak.is, Boris Brezillon <boris.brezillon@collabora.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Date: Mon, 01 Jun 2026 09:56:23 +0200
In-Reply-To: <ahr9gtzQLSbPeBx_@tardis.local>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-4-phasta@kernel.org> <ahr9gtzQLSbPeBx_@tardis.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: r87bt5ibht9pafpb4h354upmhg9hyr19
X-MBO-RS-ID: 50ca84abab62f69a854
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat, 2026-05-30 at 08:08 -0700, Boqun Feng wrote:
> On Sat, May 30, 2026 at 04:35:10PM +0200, Philipp Stanner wrote:
> > From: Alice Ryhl <aliceryhl@google.com>
> >=20
> > This adds an RcuBox container, which is like KBox except that the value
> > is freed with kfree_rcu.
> >=20
> > To allow containers to rely on the rcu properties of RcuBox, an
> > extension of ForeignOwnable is added.
> >=20
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
>=20
> I have the following on top of Alice's patch. @Alice, @Danilo, thoughts?
>=20
> Then we can have:
>=20
> type RcuKBox<T> =3D RcuBox<T, Kmalloc>;
> type RcuVBox<T> =3D RcuBox<T, Vmalloc>;

No objections by me.

I just think we have to decide how the treat the namespaces, though.
Probably Alice wrote it like that so that it's very apparent that this
is not a normal box. It still breaks the naming convention in my
opinion.

rcu::Box vs rcu::RcuBox

With all other subsystems, naming like that seems not allowed.

dma::Fence vs dma::DmaFence


I probably would allow the user to decide whether he wants to just use
it as `rcu::Box` in all his code.

But no hard feelings.



>=20
> and Philipp can use the `RcuKBox` in this patchset. We also need to impl
> InPlaceInit for RcuBox, but that can be added later.

So shall we merge my series with Alice's patch, and later we add your
patch and other features, or would you prefer to have the additional
boxes from your patch from the get-go?


P.

>=20
> Regards,
> Boqun
>=20
> ------------->8
> Subject: [PATCH] rust: rcu: Make RcuBox generic over Allocator
>=20
> To support RCU-protected vmalloc allocation, we need to make `RcuBox`
> generic over `Allocator`. Currently this works since all `Allocator`s
> are either kmalloc() or vmalloc(), and kvfree_call_rcu() works with both
> allocations.
>=20
> While we are at it, add some basic test cases.
>=20
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---
> =C2=A0rust/kernel/sync/rcu/rcu_box.rs | 96 +++++++++++++++++++++++-------=
---
> =C2=A01 file changed, 67 insertions(+), 29 deletions(-)
>=20
> diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/rcu_b=
ox.rs
> index 2508fdb609ec..5c344d82c0d9 100644
> --- a/rust/kernel/sync/rcu/rcu_box.rs
> +++ b/rust/kernel/sync/rcu/rcu_box.rs
> @@ -4,47 +4,59 @@
> =C2=A0
> =C2=A0//! Provides the `RcuBox` type for Rust allocations that live for a=
 grace period.
> =C2=A0
> -use core::{ops::Deref, ptr::NonNull};
> +use core::{
> +=C2=A0=C2=A0=C2=A0 marker::PhantomData,
> +=C2=A0=C2=A0=C2=A0 ops::Deref,
> +=C2=A0=C2=A0=C2=A0 ptr::NonNull, //
> +};
> =C2=A0
> =C2=A0use kernel::{
> -=C2=A0=C2=A0=C2=A0 alloc::{self, AllocError},
> +=C2=A0=C2=A0=C2=A0 alloc::{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AllocError,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Allocator, //
> +=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 bindings,
> =C2=A0=C2=A0=C2=A0=C2=A0 ffi::c_void,
> =C2=A0=C2=A0=C2=A0=C2=A0 prelude::*,
> -=C2=A0=C2=A0=C2=A0 sync::rcu::{ForeignOwnableRcu, Guard},
> =C2=A0=C2=A0=C2=A0=C2=A0 types::ForeignOwnable,
> =C2=A0};
> =C2=A0
> +use super::{
> +=C2=A0=C2=A0=C2=A0 ForeignOwnableRcu,
> +=C2=A0=C2=A0=C2=A0 Guard, //
> +};
> +
> =C2=A0/// A box that is freed with rcu.
> =C2=A0///
> =C2=A0/// The value must be `Send`, as rcu may drop it on another thread.
> =C2=A0///
> =C2=A0/// # Invariants
> =C2=A0///
> -/// * The pointer is valid and references a pinned `RcuBoxInner<T>` allo=
cated with `kmalloc`.
> +/// * The pointer is valid and references a pinned `RcuBoxInner<T>` allo=
cated with `A`.
> =C2=A0/// * This `RcuBox` holds exclusive permissions to rcu free the all=
ocation.
> -pub struct RcuBox<T: Send>(NonNull<RcuBoxInner<T>>);
> +pub struct RcuBox<T: Send, A: Allocator>(NonNull<RcuBoxInner<T>>, Phanto=
mData<A>);
> =C2=A0
> =C2=A0struct RcuBoxInner<T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 value: T,
> =C2=A0=C2=A0=C2=A0=C2=A0 rcu_head: bindings::callback_head,
> =C2=A0}
> =C2=A0
> -// Note that `T: Sync` is required since when moving an `RcuBox<T>`, the=
 previous owner may still
> -// access `&T` for one grace period.
> +// Note that `T: Sync` is required since when moving an `RcuBox<T, A>`, =
the previous owner may
> +// still access `&T` for one grace period.
> =C2=A0//
> -// SAFETY: Ownership of the `RcuBox<T>` allows for `&T` and dropping the=
 `T`, so `T: Send + Sync`
> -// implies `RcuBox<T>: Send`.
> -unsafe impl<T: Send + Sync> Send for RcuBox<T> {}
> +// SAFETY: Ownership of the `RcuBox<T, A>` allows for `&T` and dropping =
the `T`, so `T: Send +
> +// Sync` implies `RcuBox<T, A>: Send`.
> +unsafe impl<T: Send + Sync, A: Allocator> Send for RcuBox<T, A> {}
> =C2=A0
> -// SAFETY: `&RcuBox<T>` allows for no operations other than those permit=
ted by `&T`, so `T: Sync`
> -// implies `RcuBox<T>: Sync`.
> -unsafe impl<T: Send + Sync> Sync for RcuBox<T> {}
> +// SAFETY: `&RcuBox<T, A>` allows for no operations other than those per=
mitted by `&T`, so `T:
> +// Sync` implies `RcuBox<T, A>: Sync`.
> +unsafe impl<T: Send + Sync, A: Allocator> Sync for RcuBox<T, A> {}
> =C2=A0
> -impl<T: Send> RcuBox<T> {
> +impl<T: Send, A: Allocator> RcuBox<T, A> {
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Create a new `RcuBox`.
> =C2=A0=C2=A0=C2=A0=C2=A0 pub fn new(x: T, flags: alloc::Flags) -> Result<=
Self, AllocError> {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let b =3D KBox::new(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let b =3D Box::<_, A>::new(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
RcuBoxInner {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 value: x,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 rcu_head: Default::default(),
> @@ -53,9 +65,9 @@ pub fn new(x: T, flags: alloc::Flags) -> Result<Self, A=
llocError> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )?;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // * The pointer contains a v=
alid `RcuBoxInner` allocated with `kmalloc`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // * The pointer contains a v=
alid `RcuBoxInner` allocated with `A`.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // * We just allocated i=
t, so we own free permissions.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(RcuBox(NonNull::from(KBox:=
:leak(b))))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(RcuBox(NonNull::from(Box::=
leak(b)), PhantomData))
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Access the value for a grace period.
> @@ -66,7 +78,7 @@ pub fn with_rcu<'rcu>(&self, _read_guard: &'rcu Guard) =
-> &'rcu T {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<T: Send> Deref for RcuBox<T> {
> +impl<T: Send, A: Allocator> Deref for RcuBox<T, A> {
> =C2=A0=C2=A0=C2=A0=C2=A0 type Target =3D T;
> =C2=A0=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &T {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: While the `Rc=
uBox<T>` exists, the value remains valid.
> @@ -75,10 +87,10 @@ fn deref(&self) -> &T {
> =C2=A0}
> =C2=A0
> =C2=A0// SAFETY:
> -// * The `RcuBoxInner<T>` was allocated with `kmalloc`.
> +// * The `RcuBoxInner<T>` was allocated with `A`.
> =C2=A0// * `NonNull::as_ptr` returns a non-null pointer.
> -unsafe impl<T: Send + 'static> ForeignOwnable for RcuBox<T> {
> -=C2=A0=C2=A0=C2=A0 const FOREIGN_ALIGN: usize =3D <KBox<RcuBoxInner<T>> =
as ForeignOwnable>::FOREIGN_ALIGN;
> +unsafe impl<T: Send + 'static, A: Allocator> ForeignOwnable for RcuBox<T=
, A> {
> +=C2=A0=C2=A0=C2=A0 const FOREIGN_ALIGN: usize =3D <Box<RcuBoxInner<T>, A=
> as ForeignOwnable>::FOREIGN_ALIGN;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 type Borrowed<'a> =3D &'a T;
> =C2=A0=C2=A0=C2=A0=C2=A0 type BorrowedMut<'a> =3D &'a T;
> @@ -88,9 +100,9 @@ fn into_foreign(self) -> *mut c_void {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 unsafe fn from_foreign(ptr: *mut c_void) -> Self=
 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT: Pointer returne=
d by `into_foreign` carries same invariants as `RcuBox<T>`.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT: Pointer returne=
d by `into_foreign, A` carries same invariants as `RcuBox<T>`.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `into_foreign=
` never returns a null pointer.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(unsafe { NonNull::new_un=
checked(ptr.cast()) })
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(unsafe { NonNull::new_un=
checked(ptr.cast()) }, PhantomData)
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 unsafe fn borrow<'a>(ptr: *mut c_void) -> &'a T =
{
> @@ -104,7 +116,7 @@ unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a T {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<T: Send + 'static> ForeignOwnableRcu for RcuBox<T> {
> +impl<T: Send + 'static, A: Allocator> ForeignOwnableRcu for RcuBox<T, A>=
 {
> =C2=A0=C2=A0=C2=A0=C2=A0 type RcuBorrowed<'a> =3D &'a T;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 unsafe fn rcu_borrow<'a>(ptr: *mut c_void) -> &'=
a T {
> @@ -114,7 +126,7 @@ unsafe fn rcu_borrow<'a>(ptr: *mut c_void) -> &'a T {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<T: Send> Drop for RcuBox<T> {
> +impl<T: Send, A: Allocator> Drop for RcuBox<T, A> {
> =C2=A0=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The `rcu_head=
` field is in-bounds of a valid allocation.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let rcu_head =3D unsafe =
{ &raw mut (*self.0.as_ptr()).rcu_head };
> @@ -122,9 +134,11 @@ fn drop(&mut self) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
// SAFETY: `rcu_head` is the `rcu_head` field of `RcuBoxInner<T>`. All user=
s will be
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
// gone in an rcu grace period. This is the destructor, so we may pass owne=
rship of the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
// allocation.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsaf=
e { bindings::call_rcu(rcu_head, Some(drop_rcu_box::<T>)) };
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsaf=
e { bindings::call_rcu(rcu_head, Some(drop_rcu_box::<T, A>)) };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
// SAFETY: All users will be gone in an rcu grace period.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // TO=
DO: We are luckily since `kvfree_call_rcu()` works on both kmalloc and vmal=
loc,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // ma=
ybe a new `Allocator` method is needed.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
unsafe { bindings::kvfree_call_rcu(rcu_head, self.0.as_ptr().cast()) };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -135,11 +149,35 @@ fn drop(&mut self) {
> =C2=A0/// # Safety
> =C2=A0///
> =C2=A0/// `head` references the `rcu_head` field of an `RcuBoxInner<T>` t=
hat has no references to it.
> -/// Ownership of the `KBox<RcuBoxInner<T>>` must be passed.
> -unsafe extern "C" fn drop_rcu_box<T>(head: *mut bindings::callback_head)=
 {
> +/// Ownership of the `Box<RcuBoxInner<T>, A>` must be passed.
> +unsafe extern "C" fn drop_rcu_box<T, A: Allocator>(head: *mut bindings::=
callback_head) {
> =C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Caller provides a pointer to the `rcu=
_head` field of a `RcuBoxInner<T>`.
> =C2=A0=C2=A0=C2=A0=C2=A0 let box_inner =3D unsafe { crate::container_of!(=
head, RcuBoxInner<T>, rcu_head) };
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Caller ensures exclusive access and p=
assed ownership.
> -=C2=A0=C2=A0=C2=A0 drop(unsafe { KBox::from_raw(box_inner) });
> +=C2=A0=C2=A0=C2=A0 drop(unsafe { Box::<_, A>::from_raw(box_inner) });
> +}
> +
> +#[kunit_tests(rust_rcu_box)]
> +mod tests {
> +=C2=A0=C2=A0=C2=A0 use super::*;
> +
> +=C2=A0=C2=A0=C2=A0 #[test]
> +=C2=A0=C2=A0=C2=A0 fn rcu_box_basic() -> Result {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let rb =3D RcuBox::<_, alloc:=
:allocator::Kmalloc>::new(42i32, alloc::flags::GFP_KERNEL)?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert_eq!(*rb, 42);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert_eq!(*rb.with_rcu(&Guar=
d::new()), 42);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drop(rb);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let rb =3D RcuBox::<_, alloc:=
:allocator::Vmalloc>::new(42i32, alloc::flags::GFP_KERNEL)?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert_eq!(*rb, 42);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert_eq!(*rb.with_rcu(&Guar=
d::new()), 42);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drop(rb);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(())
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
