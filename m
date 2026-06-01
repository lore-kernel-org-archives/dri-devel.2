Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6598CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10FF11132DC;
	Mon,  1 Jun 2026 12:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="T1YovOrH";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B68811132DC
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:39:04 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-45efa12a788so1122338f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780317543; x=1780922343;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=REyupswLVPxRUsPQqPYR9DfP0rB+Rx88jhSSpFYtNlE=;
 b=T1YovOrHhlJRpVphcuiO/Kq95QWdxVyooGQ5hz4Lo9KwLyWbyKXh8IZ55eF5xViCiZ
 kA9OYK5DF80wJQ/ThWrBvvR5lxntt18C+HKm0zPoDd1cRp6YAIfnNoo3NyhzZdAZt3gy
 4s9Rs+K/2xECHClRiYmxpTj8WoDqQHJ3s5B/lncZkPRNhQBYLhKO6QKus6gEMT03NtKQ
 Tium+vhw3M0z3AyvYhpTjdGt/g5DywbAmEZScbJt8oNdz5arZxHiAiw46KpgamFtjdaA
 e8jpfPhKA0HxlB3sw0lsFo/DZRraNpgOO3s9H/t9ek22C2VMSWrzUUBRbajHR6QCMz/3
 TsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780317543; x=1780922343;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=REyupswLVPxRUsPQqPYR9DfP0rB+Rx88jhSSpFYtNlE=;
 b=PXXPfB3q4LbNwPjQ8kRlUOsJazipmShuZ9Pobcnm9YIJ86l0IUrnDupy8/C9wrMugo
 Rr12A07e1HEE2+ibDdoOFTtO2ov/wQ0cSiE3Rq09SjkmM/asI6626HHlvXgSPn8qh3gH
 Ys92t0oj2TEdsoVzm5Qb2+a4kT+fZ+bWFfxL93rObDBWsnA7WJQOxQWXDGAv/ct9a5+h
 x/H2bFPO6XDOUlC1UsepRwLeNWrf3lWFbAoDLP41WbApBQvceG9lgBClirFj9wu2crdh
 PJm/7YXgqmQKbKmOjPQ5Sw3q1YLancV88FDT2ws7kCEuLTAQwGDidVPXTKAFf6JOohJl
 6r4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cZUDMLcx8lcTpRGeY5ggOeOn/my0wcFi1Bhj/U0vSxC+aV870n/qpZ05CGpXCnfnIxjqQpYO1g2o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzI2HJy39EWSFUtnqp9ikb5SUxLs9edmbp6w+JuKDaw5zlPb5UE
 r0qhutkWDSX7hD/12+bTQrN9V15l3teg9O+rfetEeWC5oIUNypOQJlTvGWoj85KZDHbfG8/Yesd
 c6vSLm/a0RdX7xoV33g==
X-Received: from wmbjr6.prod.google.com ([2002:a05:600c:5606:b0:490:25ec:da5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f87:b0:490:abd7:fd9 with SMTP id
 5b1f17b1804b1-490abd71214mr50150365e9.10.1780317542692; 
 Mon, 01 Jun 2026 05:39:02 -0700 (PDT)
Date: Mon, 1 Jun 2026 12:39:01 +0000
In-Reply-To: <0ea6b6fdd1e3f1e07445f17c0bf672524938dc85.camel@mailbox.org>
Mime-Version: 1.0
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <ah1glmXDM-OAKa5h@google.com>
 <0ea6b6fdd1e3f1e07445f17c0bf672524938dc85.camel@mailbox.org>
Message-ID: <ah19ZVkr7b3m7V_u@google.com>
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
From: Alice Ryhl <aliceryhl@google.com>
To: phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 Zqiang <qiang.zhang@linux.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, 
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is, 
 Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 rcu@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Mon, Jun 01, 2026 at 02:26:17PM +0200, Philipp Stanner wrote:
> On Mon, 2026-06-01 at 10:36 +0000, Alice Ryhl wrote:
> > On Sat, May 30, 2026 at 04:35:11PM +0200, Philipp Stanner wrote:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
indings::dma_fence_remove_callback(self.fence.as_raw(), self.cb.get());
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > Formatting nit: Usually the ; goes outside the unsafe block.
>=20
> I could have sworn that it was rustfmt who did that? Maybe because the
> ; was inside to begin with.

Indeed, rustfmt will not change whether the ; is inside or outside the
unsafe block.

> > > +/// A trait to enforce that all data in a [`DriverFence`] either doe=
s not need
> > > +/// drop, or lives in a [`RcuBox`].
> > > +pub trait DriverFenceAllowedData: private::Sealed {}
> > > +
> > > +mod private {
> > > +=C2=A0=C2=A0=C2=A0 pub trait Sealed {}
> > > +}
> > > +
> > > +impl<F: Copy> DriverFenceAllowedData for F {}
> > > +impl<F: Send> DriverFenceAllowedData for RcuBox<F> {}
> > > +
> > > +impl<F: Copy> private::Sealed for F {}
> > > +impl<F: Send> private::Sealed for RcuBox<F> {}
> >=20
> > Why sealed? Just make the trait unsafe and require the things you
> > require from the user.
>=20
> This is far better. We definitely only allow the user to pass A or B,
> and only then it compiles.

What if I have another type that I want to use here? For example, maybe
I have a struct containing a copy field and an RcuBox. Or maybe I have
an ARef<_> of some C type that uses rcu for cleanup. Then I must edit
this file to add support for it?

> The unsafe implementation could be messed up.
>=20
> I thought that's what Sealed is for. Or isn't it?

Sealed is for making 100% sure that downstream crates/drivers cannot
provide their own implementations. But I don't see why you need that.
All you require is that the value remains valid for one grace period
after cleanup begins. As long as the type satisfies that, you are happy.
An unsafe trait can require that sort of requirement from the user.

I think what you want is expressed well by `RcuFreeSafe` from this
thread:
https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library/topic/C=
onsolidate.20.60PollCondVarBox.60.20into.20.60Rcu.2ABox.60/near/598726724

> > > +/// A synchronization primitive mainly for GPU drivers.
> > > +///
> > > +/// Fences are always reference counted. The typical use case is tha=
t one side registers
> > > +/// callbacks on the fence which will perform a certain action (such=
 as queueing work) once the
> > > +/// other side signals the fence.
> > > +///
> > > +/// # Examples
> > > +///
> > > +/// ```
> > > +/// use kernel::dma_buf::{DriverFence, FenceCtx, FenceCb, FenceCbReg=
istration};
> > > +/// use kernel::str::CString;
> > > +/// use kernel::sync::{
> > > +///=C2=A0=C2=A0=C2=A0=C2=A0 aref::ARef,
> > > +///=C2=A0=C2=A0=C2=A0=C2=A0 rcu::RcuBox, //
> > > +/// };
> > > +/// use core::ops::Deref;
> > > +/// use core::fmt::Display;
> >=20
> > Use fmt traits from kernel instead. (Actually, I don't think you use
> > Display at all here?)
>=20
> I tried, see a few lines below:
>=20
> >=20
> > > +/// struct CallbackData { }
> > > +///
> > > +/// impl FenceCb for CallbackData {
> > > +///=C2=A0=C2=A0=C2=A0=C2=A0 fn called(&mut self) {
> > > +///=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info!("DmaFen=
ce callback executed.\n");
> > > +///=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +/// }
> > > +///
> > > +/// let driver_name =3D CString::try_from_fmt(fmt!("dummy_driver"))?=
;
> > > +/// let timeline_name =3D CString::try_from_fmt(fmt!("dummy_timeline=
"))?;
> > > +///
> > > +/// let fctx =3D FenceCtx::new(driver_name, timeline_name, ())?;
> > > +///
> > > +/// let fence_data =3D CString::try_from_fmt(fmt!("dummy_data"))?;
> > > +/// // DriverFence::data must either not need drop, or live in an Rc=
uBox.
> > > +/// let fence_data =3D RcuBox::new(fence_data, GFP_KERNEL)?;
> > > +///
> > > +/// let fence_alloc =3D fctx.as_arc_borrow().new_fence_allocation(fe=
nce_data)?;
> > > +/// let mut fence =3D fctx.new_fence(fence_alloc);
> > > +///
> > > +/// let cb_data =3D CallbackData { };
> > > +/// let waiting_fence =3D ARef::from(fence.as_fence());
> > > +/// let cb_reg =3D FenceCbRegistration::new(&waiting_fence, cb_data)=
;
> > > +/// let cb_reg =3D KBox::pin_init(cb_reg, GFP_KERNEL)?;
> > > +///
> > > +/// // DriverFence implements Deref.
> > > +/// // FIXME: unit test claims that CString does not implement Displ=
ay. Why?
> > > +/// // pr_info!("Fence's inner data is: {}", fence.deref().deref());
>=20
> Lazily, I was hoping that someone here will tell me how that is
> supposed to be done correctly 8-)

This specific code could be written cleaner as &**fence, but it looks
like CString should implement fmt::Display like CStr does.

> > > +// SAFETY: The Rust dma_fence abstractions are already designed arou=
nd the inner
> > > +// C `dma_fence`, which can serve safely as the identification point=
 when being
> > > +// owned by C. Moreover, safety is ensured by not dropping `DriverFe=
nce` and by
> > > +// only allowing operations without side effects on the Borrowed typ=
e.
> > > +unsafe impl<F: Send + Sync + 'static, C: Send + Sync + 'static> Fore=
ignOwnable
> > > +=C2=A0=C2=A0=C2=A0 for DriverFence<F, C>
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 // `DriverFence` is merely a wrapper around a raw=
 pointer. Thus, we can just
> > > +=C2=A0=C2=A0=C2=A0 // use it directly.
> > > +=C2=A0=C2=A0=C2=A0 type Borrowed<'a> =3D DriverFenceBorrow<F, C>;
> > > +=C2=A0=C2=A0=C2=A0 type BorrowedMut<'a> =3D DriverFenceBorrow<F, C>;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 const FOREIGN_ALIGN: usize =3D core::mem::align_o=
f::<bindings::dma_fence>();
> > > +
> > > +=C2=A0=C2=A0=C2=A0 fn into_foreign(self) -> *mut c_void {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let fence =3D self;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ptr =3D fence.as_raw(=
);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // DriverFence must not d=
rop.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core::mem::forget(fence);
> >=20
> > Nit: Modern Rust uses ManuallyDrop instead of forget().
>=20
> You mean still take `self` here, then stuff it into ManuallyDrop and
> let it go out of scope, aye?

I mean this:

let fence =3D ManuallyDrop::new(self);
let ptr =3D fence.as_raw();

This avoids moving `fence` after calling `as_raw()`.

Alice
