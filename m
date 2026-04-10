Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1CBE99052
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB86A10E14B;
	Fri, 10 Apr 2026 07:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="nNeQkVIw";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C601910E14B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 07:56:41 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so14924975e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1775807800; x=1776412600;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=FsHj3E8jz1hZ1VgM4Mdh7Fmm+/7se/VFa1BUujcYfm4=;
 b=nNeQkVIwOLOglehAEBiJTUnmdBhc5gm5f9QM/HbVqA1do3kgIsbFFnRROjp1kD4v8u
 U2X2ZwPyb9ATnD8JsqMYVpi61NbpaRWYGcIXHe6E+3GIOhZxlHednGtZATYalpZiTxPO
 2rkHdgARDrCTIXR9kLeEfVcbRk4Mqfc3e6untegNH0PYde/OwkYGMglo83jkPHS9Q7LI
 GDl7DYV26lNWV5yQLVOCbW0LXP4IMItExtlUsqc+O1CM/cSyjn0yordNodp9eG+NPEl1
 SqgB1p6lTw7xukVG8LB7K3E8+S2qJznF1K2i3xe+RBkPy2TtzBmINczHzr1k6j7llQzY
 Yc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775807800; x=1776412600;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FsHj3E8jz1hZ1VgM4Mdh7Fmm+/7se/VFa1BUujcYfm4=;
 b=To9k8wK7J9FcQVrGftJKB2oGV7gRnS6v4nrcnUKW/OqHfVV4oz91uJ8tD0crdPWROx
 kJGiyV2d7Wg2X6CzzNOVfTcQEVrwDjpp9PxuI3pnEYt/RKeRxs5to6z4jbyIAPqpvrrQ
 +5reuCtA2gZGJ4pjmsPjJmiwP6Y7fOhCDLmmUbqv0D+5+08WuaPKMGjdmZVqNDMiT2A4
 vSIRihcnkv5qZItftajVITo5rNS6TzWWlM0tb5eDVOpPo6XcAEnIG3FrrATCL0IIDlKj
 jH/QrdX/pBCCUMnUH1k+nvLZd+vLCfD1CzQBtEJGZVBaPL04AbZbnelfkpWIvU8bSpSK
 /NPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfWRvi+Sk1dtjLHuConNDdL77UdFL2p+VK1Z7iB4PwNWQmFVDVkbqp+/obStA9NATshV5QIdNYnXI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7ZJPJ8ki+oBHRjWpiPZWNgP/O5umeJxbJRNnyT6gSQm4I/fGP
 CrCL+j1Mgz0Dql+k4ZrdGPTP9CT4/I99VfH6RUBPW9+0G8yYsvUOGLihyyB+aP/dZbJ1xS9biFI
 seBWub+l6PnZ7wJ/X5A==
X-Received: from wmbb8.prod.google.com ([2002:a05:600c:5888:b0:488:7d2f:2468])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a105:b0:485:fbd2:f72 with SMTP id
 5b1f17b1804b1-488d681701fmr15710665e9.1.1775807799874; 
 Fri, 10 Apr 2026 00:56:39 -0700 (PDT)
Date: Fri, 10 Apr 2026 07:56:38 +0000
In-Reply-To: <395ED15F-3BC1-48C0-BE36-AF3A951E464D@collabora.com>
Mime-Version: 1.0
References: <20260313091646.16938-1-work@onurozkan.dev>
 <20260313091646.16938-5-work@onurozkan.dev>
 <20260319120828.52736966@fedora>
 <9876893D-F3B4-4CA4-8858-473B6FB8E7EB@collabora.com>
 <20260409114133.43134-1-work@onurozkan.dev>
 <395ED15F-3BC1-48C0-BE36-AF3A951E464D@collabora.com>
Message-ID: <aditNn-iQc3QXRfK@google.com>
Subject: Re: [PATCH v1 RESEND 4/4] drm/tyr: add GPU reset handling
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 linux-kernel@vger.kernel.org, dakr@kernel.org, airlied@gmail.com, 
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
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

On Thu, Apr 09, 2026 at 10:44:24AM -0300, Daniel Almeida wrote:
> Hi Onur,
>=20
> > On 9 Apr 2026, at 08:41, Onur =C3=96zkan <work@onurozkan.dev> wrote:
> >=20
> > On Fri, 03 Apr 2026 12:01:09 -0300
> > Daniel Almeida <daniel.almeida@collabora.com> wrote:
> >=20
> >>=20
> >>=20
> >>> On 19 Mar 2026, at 08:08, Boris Brezillon <boris.brezillon@collabora.=
com> wrote:
> >>>=20
> >>> On Fri, 13 Mar 2026 12:16:44 +0300
> >>> Onur =C3=96zkan <work@onurozkan.dev> wrote:
> >>>=20
> >>>> +impl Controller {
> >>>> +    /// Creates a [`Controller`] instance.
> >>>> +    fn new(pdev: ARef<platform::Device>, iomem: Arc<Devres<IoMem>>)=
 -> Result<Arc<Self>> {
> >>>> +        let wq =3D workqueue::OrderedQueue::new(c"tyr-reset-wq", 0)=
?;
> >>>> +
> >>>> +        Arc::pin_init(
> >>>> +            try_pin_init!(Self {
> >>>> +                pdev,
> >>>> +                iomem,
> >>>> +                pending: Atomic::new(false),
> >>>> +                wq,
> >>>> +                work <- kernel::new_work!("tyr::reset"),
> >>>> +            }),
> >>>> +            GFP_KERNEL,
> >>>> +        )
> >>>> +    }
> >>>> +
> >>>> +    /// Processes one scheduled reset request.
> >>>> +    ///
> >>>> +    /// Panthor reference:
> >>>> +    /// - drivers/gpu/drm/panthor/panthor_device.c::panthor_device_=
reset_work()
> >>>> +    fn reset_work(self: &Arc<Self>) {
> >>>> +        dev_info!(self.pdev.as_ref(), "GPU reset work is started.\n=
");
> >>>> +
> >>>> +        // SAFETY: `Controller` is part of driver-private data and =
only exists
> >>>> +        // while the platform device is bound.
> >>>> +        let pdev =3D unsafe { self.pdev.as_ref().as_bound() };
> >>>> +        if let Err(e) =3D run_reset(pdev, &self.iomem) {
> >>>> +            dev_err!(self.pdev.as_ref(), "GPU reset failed: {:?}\n"=
, e);
> >>>> +        } else {
> >>>> +            dev_info!(self.pdev.as_ref(), "GPU reset work is done.\=
n");
> >>>> +        }
> >>>=20
> >>> Unfortunately, the reset operation is not as simple as instructing th=
e
> >>> GPU to reset, it's a complex synchronization process where you need t=
o
> >>> try to gracefully put various components on hold before you reset, an=
d
> >>> then resume those after the reset is effective. Of course, with what =
we
> >>> currently have in-tree, there's not much to suspend/resume, but I thi=
nk
> >>> I'd prefer to design the thing so we can progressively add more
> >>> components without changing the reset logic too much.
> >>>=20
> >>> I would probably start with a Resettable trait that has the
> >>> {pre,post}_reset() methods that exist in Panthor.
> >>>=20
> >>> The other thing we need is a way for those components to know when a
> >>> reset is about to happen so they can postpone some actions they were
> >>> planning in order to not further delay the reset, or end up with
> >>> actions that fail because the HW is already unusable. Not too sure ho=
w
> >>> we want to handle that though. Panthor is currently sprinkled with
> >>> panthor_device_reset_is_pending() calls in key places, but that's sti=
ll
> >>> very manual, maybe we can automate that a bit more in Tyr, dunno.
> >>>=20
> >>=20
> >>=20
> >> We could have an enum where one of the variants is Resetting, and the =
other one
> >> gives access to whatever state is not accessible while resets are in p=
rogress.
> >>=20
> >> Something like
> >>=20
> >> pub enum TyrData {
> >>  Active(ActiveTyrData),
> >>  ResetInProgress(ActiveTyrData)
> >> }
> >>=20
> >> fn access() -> Option<&ActiveTyrData> {
> >>  =E2=80=A6 // if the =E2=80=9CResetInProgress=E2=80=9D variant is acti=
ve, return None
> >> }
> >>=20
> >=20
> > That's an interesting approach, but if it's all about `fn access` funct=
ion, we
> > can already do that with a simple atomic state e.g.,:
> >=20
> > // The state flag in reset::Controller
> > state: Atomic<ResetState>
> >=20
> > fn access(&self) -> Option<&Arc<Devres<IoMem>>> {
> > match self.state.load(Relaxed) {
> > ResetState::Idle =3D> Some(&self.iomem),
> > _ =3D> None,
> > }
> > }
> >=20
> > What do you think? Would this be sufficient?
> >=20
> > Btw, a sample code snippet from the caller side would be very helpful f=
or
> > designing this further. That part is kind a blurry for me.
> >=20
> > Thanks,
> > Onur
> >=20
> >>=20
> >>>> +
> >>>> +        self.pending.store(false, Release);
> >>>> +    }
> >>>> +}
>=20
> I think that there are two things we're trying to implement correctly:
>=20
> 1) Deny access to a subset of the state while a reset is in progress
> 2) Wait for anyone accessing 1) to finish before starting a reset
>=20
> IIUC, using Atomic<T> can solve 1 by bailing if the "reset in progress"
> flag/variant is set, but I don't think it implements 2? One would have to
> implement more logic to block until the state is not being actively used.
>=20
> Now, there are probably easier ways to solve this, but I propose that we =
do the
> extra legwork to make this explicit and enforceable by the type system.
>=20
> How about introducing a r/w semaphore abstraction? It seems to correctly =
encode
> the logic we want:
>=20
> a) multiple users can access the state if no reset is pending ("read" sid=
e)
> b) the reset code can block until the state is no longer being accessed (=
the "write" side)
>=20
> In Tyr, this would roughly map to something like:
>=20
> struct TyrData {
>   reset_gate: RwSem<ActiveHwState>
>   // other, always accessible members
> }
>=20
> impl TyrData {
>   fn try_access(&self) -> Option<ReadGuard<'_, ActiveHwState>> {...}
> }
>=20
> Where ActiveHwState contains the fw/mmu/sched blocks (these are not upstr=
eam
> yet, Deborah has a series that will introduce the fw block that should la=
nd
> soon) and perhaps more.
>=20
> Now, the reset logic would be roughly:
>=20
> fn reset_work(tdev: Arc<TyrDevice>) {
>   // Block until nobody else is accessing the hw, prevent others from
>   // initiating new accesses too..
>   let _guard =3D tdev.reset_gate.write();
>   =20
>   // pre_reset() all Resettable implementors
>=20
>   ... reset
>=20
>   // post_Reset all Resettable implementors
> }
>=20
> Now, for every block that might touch a resource that would be unavailabl=
e
> during a reset, we enforce a try_access() via the type system, and ensure=
 that
> the reset cannot start while the guard is alive. In particular, ioctls wo=
uld
> look like:
>=20
> fn ioctl_foo(...) {
>   let hw =3D tdev.reset_gate.try_access()?;
>   // resets are blocked while the guard is alive, no other way to access =
that state otherwise
> }
>=20
> The code will not compile otherwise, so long as we keep the state in Acti=
veHwState, i.e.:=20
> protected by the r/w sem.
>=20
> This looks like an improvement over Panthor, since Panthor relies on manu=
ally
> canceling work that access hw state via cancel_work_sync(), and gating ne=
w work
> submissions on the "reset_in_progress" flag, i.e.:
>=20
> /**
>  * sched_queue_work() - Queue a scheduler work.
>  * @sched: Scheduler object.
>  * @wname: Work name.
>  *
>  * Conditionally queues a scheduler work if no reset is pending/in-progre=
ss.
>  */
> #define sched_queue_work(sched, wname) \
> do { \
> if (!atomic_read(&(sched)->reset.in_progress) && \
>     !panthor_device_reset_is_pending((sched)->ptdev)) \
> queue_work((sched)->wq, &(sched)->wname ## _work); \
> } while (0)
>=20
>=20
> Thoughts?

I don't think a semaphore is the right answer. I think SRCU plus a
counter makes more sense. (With a sentinal value reserved for "currently
resetting".)

When you begin using the hardware, you start an srcu critical region and
read the counter. If the counter has the sentinel value, you know the
hardware is resetting and you fail. Otherwise you record the couter and
proceed.

If at any point you release the srcu critical region and want to
re-acquire it to continue the same ongoing work, then you must ensure
that the counter still has the same value. This ensures that if the GPU
is reset, then even if the reset has finished by the time you come back,
you still fail because the counter has changed.


Another option could be to rely on the existing Device unbind logic.
Entirely remove the class device and run the full unbind procedure,
cleaning up all devm work etc. Then once that has finished, probe the
device again and start from scratch. After all, GPU reset does not have
to be a cheap operation.

Alice
