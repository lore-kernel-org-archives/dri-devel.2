Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B432FF588CA
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108C010E665;
	Mon, 20 Apr 2026 14:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="vvnIT76R";
	dkim-atps=neutral
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D8310E665
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1776694011; x=1776953211;
 bh=d4VKW/+sEadXQ5vElnOmIFUXTR7HrXlIDe4CarsC4ag=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=vvnIT76RgTvfnL9qwtjeqhR1lWpKVCWTDYkJ+tHJ/A2KhrrZxaH52YsdC/SEoMM6f
 2cLpmxy6IDOxgsf4xLjRm7sIu93zq96zyaz42T/Fj4YmyDs001vdspRx0OTSGGuGHe
 dAJz3KxS5xZzeMIvbpokGMqPePBuCHCk2UZUScBwGPmHa2s/oKLnqfYsuN7mdFKec/
 JBL17B6v2CAYmEocbBeHzNs5aZFdm4s4v+7TzPF4AMVV6Rcw0Jnb0nN2gHas7URafc
 hoLjC1khDWMrqUc9Vm8p41gUI4CbqJeSgk65vgO/RwGKHiZgkZMpCAQbNYNN+U8WRV
 qGDXYDtCx0yhg==
X-Pm-Submission-Id: 4fznNT11RSz1DDWg
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Boqun Feng <boqun@kernel.org>
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
 rostedt@goodmis.org
Subject: Re: [PATCH v2 1/4] rust: add SRCU abstraction
Date: Mon, 20 Apr 2026 17:06:46 +0300
Message-ID: <20260420140646.42103-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aeFZwCsuhSrQATRM@tardis.local>
References: <20260416171838.206128-1-work@onurozkan.dev>
 <aeFZwCsuhSrQATRM@tardis.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 16 Apr 2026 14:50:56 -0700=0D
Boqun Feng <boqun@kernel.org> wrote:=0D
=0D
> On Thu, Apr 16, 2026 at 08:18:37PM +0300, Onur =C3=96zkan wrote:=0D
> > Add a Rust abstraction for sleepable RCU (SRCU), backed by=0D
> > srcu_struct. Provide FFI helpers and a safe wrapper with a=0D
> > guard-based API for read-side critical sections.=0D
> > =0D
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> > ---=0D
> >  rust/helpers/helpers.c   |   1 +=0D
> >  rust/helpers/srcu.c      |  18 +++++++=0D
> >  rust/kernel/sync.rs      |   2 +=0D
> >  rust/kernel/sync/srcu.rs | 109 +++++++++++++++++++++++++++++++++++++++=
=0D
> >  4 files changed, 130 insertions(+)=0D
> >  create mode 100644 rust/helpers/srcu.c=0D
> >  create mode 100644 rust/kernel/sync/srcu.rs=0D
> > =0D
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c=0D
> > index 875a9788ad40..052fef89d5f0 100644=0D
> > --- a/rust/helpers/helpers.c=0D
> > +++ b/rust/helpers/helpers.c=0D
> > @@ -60,6 +60,7 @@=0D
> >  #include "signal.c"=0D
> >  #include "slab.c"=0D
> >  #include "spinlock.c"=0D
> > +#include "srcu.c"=0D
> >  #include "sync.c"=0D
> >  #include "task.c"=0D
> >  #include "time.c"=0D
> > diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c=0D
> > new file mode 100644=0D
> > index 000000000000..b372b733eb89=0D
> > --- /dev/null=0D
> > +++ b/rust/helpers/srcu.c=0D
> > @@ -0,0 +1,18 @@=0D
> > +// SPDX-License-Identifier: GPL-2.0=0D
> > +=0D
> > +#include <linux/srcu.h>=0D
> > +=0D
> > +__rust_helper int rust_helper_init_srcu_struct(struct srcu_struct *ssp=
)=0D
> > +{=0D
> > +	return init_srcu_struct(ssp);=0D
> =0D
> init_srcu_struct() is defined as a macro when LOCKDEP=3Dy so that each=0D
> srcu_struct has a own lock_class_key. Using a binding helper like this=0D
> will make all srcu_struct share the same key. You can refer to how=0D
> rust_helper___spin_lock_init() does (including how new_spinlock!()=0D
> works).=0D
=0D
I see, will do that. Thanks!=0D
=0D
> =0D
> > +}=0D
> > +=0D
> > +__rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)=
=0D
> > +{=0D
> > +	return srcu_read_lock(ssp);=0D
> > +}=0D
> > +=0D
> > +__rust_helper void rust_helper_srcu_read_unlock(struct srcu_struct *ss=
p, int idx)=0D
> > +{=0D
> > +	srcu_read_unlock(ssp, idx);=0D
> > +}=0D
> > \ No newline at end of file=0D
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs=0D
> > index 993dbf2caa0e..0d6a5f1300c3 100644=0D
> > --- a/rust/kernel/sync.rs=0D
> > +++ b/rust/kernel/sync.rs=0D
> > @@ -21,6 +21,7 @@=0D
> >  pub mod rcu;=0D
> >  mod refcount;=0D
> >  mod set_once;=0D
> > +pub mod srcu;=0D
> >  =0D
> >  pub use arc::{Arc, ArcBorrow, UniqueArc};=0D
> >  pub use completion::Completion;=0D
> > @@ -31,6 +32,7 @@=0D
> >  pub use locked_by::LockedBy;=0D
> >  pub use refcount::Refcount;=0D
> >  pub use set_once::SetOnce;=0D
> > +pub use srcu::Srcu;=0D
> >  =0D
> >  /// Represents a lockdep class.=0D
> >  ///=0D
> > diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs=0D
> > new file mode 100644=0D
> > index 000000000000..cf0c16248ea3=0D
> > --- /dev/null=0D
> > +++ b/rust/kernel/sync/srcu.rs=0D
> > @@ -0,0 +1,109 @@=0D
> > +// SPDX-License-Identifier: GPL-2.0=0D
> > +=0D
> > +//! Sleepable read-copy update (SRCU) abstraction.=0D
> > +//!=0D
> > +//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu.h)=0D
> > +=0D
> > +use crate::{=0D
> > +    bindings,=0D
> > +    error::to_result,=0D
> > +    prelude::*,=0D
> > +    types::{=0D
> > +        NotThreadSafe,=0D
> > +        Opaque, //=0D
> > +    },=0D
> > +};=0D
> > +=0D
> > +use pin_init::pin_data;=0D
> > +=0D
> > +/// Creates an [`Srcu`] initialiser.=0D
> > +#[macro_export]=0D
> > +macro_rules! new_srcu {=0D
> > +    () =3D> {=0D
> > +        $crate::sync::Srcu::new()=0D
> > +    };=0D
> > +}=0D
> > +=0D
> > +/// Sleepable read-copy update primitive.=0D
> > +///=0D
> > +/// SRCU readers may sleep while holding the read-side guard.=0D
> > +#[repr(transparent)]=0D
> > +#[pin_data(PinnedDrop)]=0D
> > +pub struct Srcu {=0D
> > +    #[pin]=0D
> > +    inner: Opaque<bindings::srcu_struct>,=0D
> > +}=0D
> > +=0D
> > +impl Srcu {=0D
> > +    /// Creates a new SRCU instance.=0D
> > +    pub fn new() -> impl PinInit<Self, Error> {=0D
> > +        try_pin_init!(Self {=0D
> > +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu_st=
ruct| {=0D
> > +                // SAFETY: `ptr` points to valid uninitialised memory =
for a `srcu_struct`.=0D
> > +                to_result(unsafe { bindings::init_srcu_struct(ptr) })=
=0D
> > +            }),=0D
> > +        })=0D
> > +    }=0D
> > +=0D
> > +    /// Enters an SRCU read-side critical section.=0D
> > +    pub fn read_lock(&self) -> Guard<'_> {=0D
> > +        // SAFETY: By the type invariants, `self.inner.get()` is a val=
id initialized `srcu_struct`.=0D
> > +        let idx =3D unsafe { bindings::srcu_read_lock(self.inner.get()=
) };=0D
> > +=0D
> > +        Guard {=0D
> > +            srcu: self,=0D
> > +            idx,=0D
> > +            _nts: NotThreadSafe,=0D
> > +        }=0D
> > +    }=0D
> > +=0D
> > +    /// Waits until all pre-existing SRCU readers have completed.=0D
> > +    pub fn synchronize(&self) {=0D
> > +        // SAFETY: By the type invariants, `self.inner.get()` is a val=
id initialized `srcu_struct`.=0D
> > +        unsafe { bindings::synchronize_srcu(self.inner.get()) };=0D
> > +    }=0D
> > +=0D
> > +    /// Waits until all pre-existing SRCU readers have completed, expe=
dited.=0D
> > +    ///=0D
> > +    /// This requests a lower-latency grace period than [`Srcu::synchr=
onize`] typically=0D
> > +    /// at the cost of higher system-wide overhead. Prefer [`Srcu::syn=
chronize`] by default=0D
> > +    /// and use this variant only when reducing reset or teardown late=
ncy is more important=0D
> > +    /// than the extra cost.=0D
> > +    pub fn synchronize_expedited(&self) {=0D
> > +        // SAFETY: By the type invariants, `self.inner.get()` is a val=
id initialized `srcu_struct`.=0D
> > +        unsafe { bindings::synchronize_srcu_expedited(self.inner.get()=
) };=0D
> > +    }=0D
> > +}=0D
> > +=0D
> > +#[pinned_drop]=0D
> > +impl PinnedDrop for Srcu {=0D
> > +    fn drop(self: Pin<&mut Self>) {=0D
> > +        // SAFETY: `self` is pinned and `inner` contains a valid initi=
alized `srcu_struct`.=0D
> =0D
> I think we need srcu_barrier() here to ensure all SRCU callbacks have=0D
> finished. Otherwise if there is a pending callback, one of the "leak it"=
=0D
> branch will be taken, and we cannot free the srcu_struct since other=0D
> thread may still access it. (It's impossible for the current API to=0D
> allow this happen since call_srcu() is not supported yet, but that's a=0D
> natural extension after the initial support).=0D
> =0D
> Please do double-check whether other "leak it" conditions can happen or=0D
> not in cleanup_srcu_struct().=0D
> =0D
=0D
I checked it and it cannot happen with the current API. But adding the barr=
ier=0D
still seems reasonable to make the API future-proof. Good point, thanks.=0D
=0D
> > +        unsafe { bindings::cleanup_srcu_struct(self.as_ref().get_ref()=
.inner.get()) };=0D
> > +    }=0D
> > +}=0D
> > +=0D
> > +// SAFETY: `srcu_struct` may be shared and used across threads.=0D
> > +unsafe impl Send for Srcu {}=0D
> > +// SAFETY: `srcu_struct` may be shared and used concurrently.=0D
> > +unsafe impl Sync for Srcu {}=0D
> > +=0D
> > +/// Guard for an active SRCU read-side critical section on a particula=
r [`Srcu`].=0D
> > +pub struct Guard<'a> {=0D
> > +    srcu: &'a Srcu,=0D
> > +    idx: core::ffi::c_int,=0D
> > +    _nts: NotThreadSafe,=0D
> =0D
> Just want to bring this up for completeness, if we use=0D
> srcu_{up,down}_read() then the Guard is Send. Not sure there is a need=0D
> for this at the moment, just make a note in case that anyone might need=0D
> it.=0D
=0D
I think we should have different Guard for that extension and I don't want =
to=0D
add a note like "This guard should be not used with srcu_{up,down}_read()" =
as we=0D
don't provide that yet. Maybe there is a better way to express that, but I =
am=0D
not sure if that's worth it, what do you think?=0D
=0D
> =0D
> Regards,=0D
> Boqun=0D
> =0D
> > +}=0D
> > +=0D
> > +impl Guard<'_> {=0D
> > +    /// Explicitly exits the SRCU read-side critical section.=0D
> > +    pub fn unlock(self) {}=0D
> > +}=0D
> > +=0D
> > +impl Drop for Guard<'_> {=0D
> > +    fn drop(&mut self) {=0D
> > +        // SAFETY: `Guard` is only constructible through `Srcu::read_l=
ock()`,=0D
> > +        // which returns a valid index for the SRCU instance.=0D
> > +        unsafe { bindings::srcu_read_unlock(self.srcu.inner.get(), sel=
f.idx) };=0D
> > +    }=0D
> > +}=0D
> > -- =0D
> > 2.51.2=0D
> > =0D
> > =0D
