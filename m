Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73516CD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA6DA10E4C5;
	Fri,  5 Jun 2026 14:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="k5tPdqTD";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92DB810E4C5
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:54:20 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso1445531f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 07:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780671259; cv=none;
 d=google.com; s=arc-20240605;
 b=XDqFHRDXX9X8rldUrEesqNZ7TvmaCwrIU1loEDGe3X/OWg5O7IW67myCWccHjGHNFH
 NCUobhiXCPRtQBpzX8u6TiI/gzZm3hzcCmN6SQ1ePaNE3Dfvf6P0DlK56X77Ngg+qdKI
 DupIyCSO4qf4oAbgx/8qQHcTRQpemtb8w/nq76DVgSu7NQpnI4xh0S/30qq3rwqeYdNv
 QqA15U0Shjz0XzAzb9MU0BfLHdP1d4SfiYgJ0y5fv3tMCsLwBZemE2REb66Yr7MNXdr3
 qp2IJNx1jROgUchFCmxqQq7zZ10PnJ5Gv5CLTexf0crwLi/8oK5cfw8OiNv0l5Y9v5/B
 hoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iMx/nHWOMEwtym34VZ261ncrvtjhMvq2oZ5WpIEUnq0=;
 fh=hAxZguKpea2tfEUPKx50yLWji3qdEDkB9OasO3KTRYM=;
 b=QrUM728eRiIER0kmuFXhBAfmOqyd9d4RnGlOgqhqiEjIEo0GGcUR86NsxQGJ7tKT/1
 eXPD6X4YepAuVSmJ7S1HNglvMtF6+qNdgGOZZ/FFidKa+bD0h1Z1whVCkvZ/1IRKuYKA
 Oi9B1ePAIqVH3BhZjEh8Q0kyKQpJDfa+hCI/4N6/XNVMaaMXCabbkJmaemgRHQh2L7Oy
 tmM6nS2mnbmqSeCh+QJDgvKDSChPccSpgchn1AQOIUAHSB9zU4QKugVBcqr4nVXHlopQ
 ZkVMZ+3Zqbr8H2z6IEjEPdRcGczOTK5rhuevfg/xuM9dSfdiRzJpOWlTFdKe503eQUMU
 nPvQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780671259; x=1781276059;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMx/nHWOMEwtym34VZ261ncrvtjhMvq2oZ5WpIEUnq0=;
 b=k5tPdqTDTctGuastzaROB+kaxX/4oQPx2VHjfqZTj3vWhrqEC8UOICsiTWZiLas8o5
 jyvohFlisUWNgqPJ0ZW4tWN5LM1TE9zhs+nK1npXqbeFZ1BPIa+uopVLMsJfCAEmbtX2
 j9+KL+r7vCHaQ9BdkhvnlTGUHE0OYXqet4pTTy1KnVlAAX/tdJAvcn7tGpIGmRjFpbtd
 OTqucoJ2BMLZaeotFRB/eQGg5ckQu0cbHYOH5hPj321f6V3HLdbk2QFg+T2CrwXOdo5M
 y03QHAWVDRrhXAt6mrGrcMdPN3UWSvvHxcVxwSkVBVsv6rjvQsEbSJ6MVrgU87TEbG9W
 NXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780671259; x=1781276059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iMx/nHWOMEwtym34VZ261ncrvtjhMvq2oZ5WpIEUnq0=;
 b=R0/c6x1/lPs/6zShscaI2MNfJTMqVYlGRDvRzvVu/MsahHYpqJtWYW9HgPkfC8vHgO
 wYjiSjADQEgK+K0Trj3ayEQVZEP+e1I1W2JXvrOv06lmwhRJvnCmgRy5gzAqES7Rfswi
 hVJApVJtWlUoTlsjtfNbPqI+fM9acjvMfsTawgjVgFmxkujk0+rc0JqEIRYYfQzzkHDn
 FxsDqohFZf24pYnt8zSFWR6KwK9AT1Tfi+3+SSBnuqEWkQ0TCHxazsnE585m+1BICb8t
 yUd3czhAKEp5C1FhoIAUeCT+YRZ2OWBNZKhYuYGgvwdyaM7vc+oSgsmX3hd3FZp6dw3p
 BI3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mvHEapD8CK0aUX8H0G//sQDhOaqsyAvl4bNKb1h7PBoqGqOLVnqawKiCljjj9Ge4DSlckQwaejwE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjLLNUIJk06F2zTEIB08J9iHOkMATC5bCt2tQu7K8e4fZwuIcC
 UTTt4rpEXUof5oA5dsdAB6OI1hyJQyEo0eprrK/KmfNedTLdXrZ5dyQ21MKw3SvMOzwBbktiMBf
 izQW71MaPKuCbbSfVnUyfUGpTY03L4qlZKvvOYCot
X-Gm-Gg: Acq92OHibJ87QLAabMe3+phGhDiGl1n1vqITPICfHrySLu1TwoG+siY67e4p6Tf7EzD
 gxg3p2qlinf36QS+TasLHC8slxdqKeI2AYBUH3hdTj0cwClYReBBs3MXMbBhfqW4Cxm6sf/xPOL
 v6mkvumGaIeWQVdywSH5SRnFgx4jZffHMAkpX8sq+KRiX21Imo/s628S595sLphgGFx4rKQBpzD
 r5cQ3bIr3akMAMjZ4RZLS/KHbPH63tFXHT1aW+kcs6DvvtrIJDkr2TCbi5fV4aTaagOJcNiD3ZX
 jYu7Y8vABk/0W9nx6cgI59NihLgadMBAtZ3Bvq0qXxseMyCkqHCo4F0fscA=
X-Received: by 2002:a5d:5747:0:b0:45e:73b4:85cc with SMTP id
 ffacd0b85a97d-46030762e2dmr4902991f8f.35.1780671258380; Fri, 05 Jun 2026
 07:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260605133541.22569-1-boqun@kernel.org>
 <20260605133541.22569-6-boqun@kernel.org>
 <aiLXWHg22P6OTb7O@google.com> <aiLbOd9BkRrrzauk@tardis-2.local>
In-Reply-To: <aiLbOd9BkRrrzauk@tardis-2.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 5 Jun 2026 16:54:05 +0200
X-Gm-Features: AVVi8Cdg9vKBauMx2gFlTcbSb2NA7zDY8I7EUodYwLM12r5vWqTj6E3w8SCGnp8
Message-ID: <CAH5fLgiBayr6S5ijfEdXNgZqaZvFbKWqLvVEsVePmrBybqDZzg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] rust: rcu: Introduce RcuFreeBox
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 rcu@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 maple-tree@lists.infradead.org, linux-mm@kvack.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
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

On Fri, Jun 5, 2026 at 4:20=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote:
>
> On Fri, Jun 05, 2026 at 02:04:08PM +0000, Alice Ryhl wrote:
> > On Fri, Jun 05, 2026 at 06:35:41AM -0700, Boqun Feng wrote:
> > > The current RcuBox will call the `drop()` function after a grace peri=
od
> > > inside an RCU callback. This suffices for maintaining a RCU-protected
> > > object:
> > >
> > >   RcuBox::drop():
> > >     call_rcu(
> > >       |..| { // <- call back after one grace period.
> > >         T::drop(); // <- call the destructor of the inner object.
> > >       }
> > >     )
> > >
> > > However, to support a different RCU usage pattern as below we need to
> > > extend RcuBox:
> > >
> > > 1. clean up the object, and unshare it from future RCU readers.
> > > 2. wait for an RCU grace period.
> > > 3. no other RCU readers, we can free the memory.
> > >
> > > An `RcuFreeBox<T: RcuFreeSafe>` is introduced to provide support for
> > > this:
> > >
> > >   RcuFreeBox::drop():
> > >     T::drop_before_gp(); // clean up and ushare.
> > >     kfree_call_rcu(..);  // free it after one grace period.
> > >
> > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > > ---
> > >  rust/kernel/sync/rcu.rs         | 31 +++++++++++++++
> > >  rust/kernel/sync/rcu/rcu_box.rs | 68 +++++++++++++++++++++++++++++++=
--
> > >  2 files changed, 95 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> > > index 7da6b8d22277..7c26591bb318 100644
> > > --- a/rust/kernel/sync/rcu.rs
> > > +++ b/rust/kernel/sync/rcu.rs
> > > @@ -4,6 +4,8 @@
> > >  //!
> > >  //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcu=
pdate.h)
> > >
> > > +use core::pin::Pin;
> > > +
> > >  use crate::{
> > >      bindings,
> > >      types::{
> > > @@ -82,3 +84,32 @@ pub trait ForeignOwnableRcu: ForeignOwnable {
> > >      /// [`from_foreign`]: ForeignOwnable::from_foreign
> > >      unsafe fn rcu_borrow<'a>(ptr: *mut ffi::c_void) -> Self::RcuBorr=
owed<'a>;
> > >  }
> > > +
> > > +/// Declares a struct is safe to free after a grace period if all re=
aders are guarded by RCU.
> > > +///
> > > +/// # Safety
> > > +///
> > > +/// Implementation must guarantee `drop_before_gp()` makes sure no f=
uture RCU reader will access
> > > +/// any part of [`Self`], as a result, after `drop_before_gp()` retu=
rn + one grace period, no RCU
> > > +/// reader will be on the object, and it's safe to free it.
> > > +///
> > > +/// Notes for implementators: implementing this trait in general req=
uires `Self` being a
> > > +/// [`UnsafePinned`], i.e. a `&mut Self` is not a noalias reference =
if `Self` has non-trivial
> > > +/// `drop()` function.
> > > +pub unsafe trait RcuFreeSafe {
> > > +    fn drop_before_gp(self: Pin<&mut Self>);
> > > +}
> >
> > Should this have an associated type for the rcu-safe view?
> >
> > pub unsafe trait RcuFreeSafe {
> >     type RcuView<'a>;
> >
> >     /// Access this value in a manner that is safe after
> >     /// `drop_before_gp` for one grace period.
> >     fn rcu_view<'a>(self: Pin<&'a Self>, _rcu: &'a RcuGuard) -> Self::R=
cuView<'a>;
> >
> >     /// Drop this value in a manner where it may still be accessed via
> >     /// `rcu_view` for one grace period.
> >     ///
> >     /// # Safety
> >     ///
> >     /// All other accesses to this value must happen before the call to=
 this
> >     /// method, except for accesses using `rcu_view`.
> >     fn drop_before_gp(self: Pin<&mut Self>);
> > }
> >
> > The idea being that once you call `drop_before_gp()`, the value
> > immediately becomes unusable as the type itself, but you can still use
> > it via `rcu_view`. The `RcuView` type can then be a type that has a
> > subset of the type's methods that is safe to use for one grace period
> > after `drop_before_gp`.
> >
> > If you define the trait like this, then PollCondVar becomes RcuFreeSafe=
.
> > It can't be RcuFreeSafe today because you must not create new waiters a=
fter
> > `drop_before_gp()` is called. With this modified trait, it can simply
> > not provide methods for registering new waiters from the RcuView type.
> >
>
> Good point! But I guess I could keep RcuFreeSafe as it is but remove the
> `RcuFreeSafe::with_rcu()`, and this should be sufficient for
> PollCondVar. I do want to wait for a meaningful usage of `rcu_view()` to
> add that, but I think your idea of that is great. Or maybe you have a
> potential usage in mind?

For the dma fence, the fence context would let you access the name c
string via the rcu view.

Alice
