Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AC4F45A1F
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 05:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 858FE10E18C;
	Sat, 11 Apr 2026 05:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="lQ3Zxgpm";
	dkim-atps=neutral
X-Greylist: delayed 151844 seconds by postgrey-1.36 at gabe;
 Sat, 11 Apr 2026 05:52:24 UTC
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch
 [109.224.244.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADD410E18C
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1775886741; x=1776145941;
 bh=4nF7wx6+wZp37eA7nITsuZG1Pt0XUvUid7Ushvb6sHg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=lQ3Zxgpm6P3h//qaqfZJ9thSb75Dj6f9zlMQRd7KTCw8UI/ogRomYw97I107XXR4o
 tJnNaWqXHVWwgcdhbVV/M/juC7bkXaw/baN8vaDlyA16UritiKLmrJkApx0UQ+ohq/
 CKPjna1y4B3D7fvZBsIX73uqyvuuHLA0Gx0ObtgGRPg7wHn0fJDCfK+9uXPgyJHSC+
 V1zpM8JiVLzww8SvaQ1d9DDYUQjfQHJKoXDGmoZRDMV9EdyLwNz5wAnqc0T+FQsIVa
 VeWgDyaZHSVjFAAOTbnXEv2YBXY9FXus7WkCj1pSBF6+ZwjnjOE4K4YTf05pOnl+9a
 crAy1a93tfUmg==
X-Pm-Submission-Id: 4ft2r26JYDz1DF5P
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, dakr@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: Re: [PATCH v1 RESEND 4/4] drm/tyr: add GPU reset handling
Date: Sat, 11 Apr 2026 08:52:15 +0300
Message-ID: <20260411055215.120719-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aditNn-iQc3QXRfK@google.com>
References: <20260313091646.16938-1-work@onurozkan.dev>
 <20260313091646.16938-5-work@onurozkan.dev> <20260319120828.52736966@fedora>
 <9876893D-F3B4-4CA4-8858-473B6FB8E7EB@collabora.com>
 <20260409114133.43134-1-work@onurozkan.dev>
 <395ED15F-3BC1-48C0-BE36-AF3A951E464D@collabora.com>
 <aditNn-iQc3QXRfK@google.com>
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

On Fri, 10 Apr 2026 07:56:38 +0000=0D
Alice Ryhl <aliceryhl@google.com> wrote:=0D
=0D
> On Thu, Apr 09, 2026 at 10:44:24AM -0300, Daniel Almeida wrote:=0D
> > Hi Onur,=0D
> > =0D
> > > On 9 Apr 2026, at 08:41, Onur =C3=96zkan <work@onurozkan.dev> wrote:=
=0D
> > > =0D
> > > On Fri, 03 Apr 2026 12:01:09 -0300=0D
> > > Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
> > > =0D
> > >> =0D
> > >> =0D
> > >>> On 19 Mar 2026, at 08:08, Boris Brezillon <boris.brezillon@collabor=
a.com> wrote:=0D
> > >>> =0D
> > >>> On Fri, 13 Mar 2026 12:16:44 +0300=0D
> > >>> Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
> > >>> =0D
> > >>>> +impl Controller {=0D
> > >>>> +    /// Creates a [`Controller`] instance.=0D
> > >>>> +    fn new(pdev: ARef<platform::Device>, iomem: Arc<Devres<IoMem>=
>) -> Result<Arc<Self>> {=0D
> > >>>> +        let wq =3D workqueue::OrderedQueue::new(c"tyr-reset-wq", =
0)?;=0D
> > >>>> +=0D
> > >>>> +        Arc::pin_init(=0D
> > >>>> +            try_pin_init!(Self {=0D
> > >>>> +                pdev,=0D
> > >>>> +                iomem,=0D
> > >>>> +                pending: Atomic::new(false),=0D
> > >>>> +                wq,=0D
> > >>>> +                work <- kernel::new_work!("tyr::reset"),=0D
> > >>>> +            }),=0D
> > >>>> +            GFP_KERNEL,=0D
> > >>>> +        )=0D
> > >>>> +    }=0D
> > >>>> +=0D
> > >>>> +    /// Processes one scheduled reset request.=0D
> > >>>> +    ///=0D
> > >>>> +    /// Panthor reference:=0D
> > >>>> +    /// - drivers/gpu/drm/panthor/panthor_device.c::panthor_devic=
e_reset_work()=0D
> > >>>> +    fn reset_work(self: &Arc<Self>) {=0D
> > >>>> +        dev_info!(self.pdev.as_ref(), "GPU reset work is started.=
\n");=0D
> > >>>> +=0D
> > >>>> +        // SAFETY: `Controller` is part of driver-private data an=
d only exists=0D
> > >>>> +        // while the platform device is bound.=0D
> > >>>> +        let pdev =3D unsafe { self.pdev.as_ref().as_bound() };=0D
> > >>>> +        if let Err(e) =3D run_reset(pdev, &self.iomem) {=0D
> > >>>> +            dev_err!(self.pdev.as_ref(), "GPU reset failed: {:?}\=
n", e);=0D
> > >>>> +        } else {=0D
> > >>>> +            dev_info!(self.pdev.as_ref(), "GPU reset work is done=
.\n");=0D
> > >>>> +        }=0D
> > >>> =0D
> > >>> Unfortunately, the reset operation is not as simple as instructing =
the=0D
> > >>> GPU to reset, it's a complex synchronization process where you need=
 to=0D
> > >>> try to gracefully put various components on hold before you reset, =
and=0D
> > >>> then resume those after the reset is effective. Of course, with wha=
t we=0D
> > >>> currently have in-tree, there's not much to suspend/resume, but I t=
hink=0D
> > >>> I'd prefer to design the thing so we can progressively add more=0D
> > >>> components without changing the reset logic too much.=0D
> > >>> =0D
> > >>> I would probably start with a Resettable trait that has the=0D
> > >>> {pre,post}_reset() methods that exist in Panthor.=0D
> > >>> =0D
> > >>> The other thing we need is a way for those components to know when =
a=0D
> > >>> reset is about to happen so they can postpone some actions they wer=
e=0D
> > >>> planning in order to not further delay the reset, or end up with=0D
> > >>> actions that fail because the HW is already unusable. Not too sure =
how=0D
> > >>> we want to handle that though. Panthor is currently sprinkled with=
=0D
> > >>> panthor_device_reset_is_pending() calls in key places, but that's s=
till=0D
> > >>> very manual, maybe we can automate that a bit more in Tyr, dunno.=0D
> > >>> =0D
> > >> =0D
> > >> =0D
> > >> We could have an enum where one of the variants is Resetting, and th=
e other one=0D
> > >> gives access to whatever state is not accessible while resets are in=
 progress.=0D
> > >> =0D
> > >> Something like=0D
> > >> =0D
> > >> pub enum TyrData {=0D
> > >>  Active(ActiveTyrData),=0D
> > >>  ResetInProgress(ActiveTyrData)=0D
> > >> }=0D
> > >> =0D
> > >> fn access() -> Option<&ActiveTyrData> {=0D
> > >>  =E2=80=A6 // if the =E2=80=9CResetInProgress=E2=80=9D variant is ac=
tive, return None=0D
> > >> }=0D
> > >> =0D
> > > =0D
> > > That's an interesting approach, but if it's all about `fn access` fun=
ction, we=0D
> > > can already do that with a simple atomic state e.g.,:=0D
> > > =0D
> > > // The state flag in reset::Controller=0D
> > > state: Atomic<ResetState>=0D
> > > =0D
> > > fn access(&self) -> Option<&Arc<Devres<IoMem>>> {=0D
> > > match self.state.load(Relaxed) {=0D
> > > ResetState::Idle =3D> Some(&self.iomem),=0D
> > > _ =3D> None,=0D
> > > }=0D
> > > }=0D
> > > =0D
> > > What do you think? Would this be sufficient?=0D
> > > =0D
> > > Btw, a sample code snippet from the caller side would be very helpful=
 for=0D
> > > designing this further. That part is kind a blurry for me.=0D
> > > =0D
> > > Thanks,=0D
> > > Onur=0D
> > > =0D
> > >> =0D
> > >>>> +=0D
> > >>>> +        self.pending.store(false, Release);=0D
> > >>>> +    }=0D
> > >>>> +}=0D
> > =0D
> > I think that there are two things we're trying to implement correctly:=
=0D
> > =0D
> > 1) Deny access to a subset of the state while a reset is in progress=0D
> > 2) Wait for anyone accessing 1) to finish before starting a reset=0D
> > =0D
> > IIUC, using Atomic<T> can solve 1 by bailing if the "reset in progress"=
=0D
> > flag/variant is set, but I don't think it implements 2? One would have =
to=0D
> > implement more logic to block until the state is not being actively use=
d.=0D
> > =0D
> > Now, there are probably easier ways to solve this, but I propose that w=
e do the=0D
> > extra legwork to make this explicit and enforceable by the type system.=
=0D
> > =0D
> > How about introducing a r/w semaphore abstraction? It seems to correctl=
y encode=0D
> > the logic we want:=0D
> > =0D
> > a) multiple users can access the state if no reset is pending ("read" s=
ide)=0D
> > b) the reset code can block until the state is no longer being accessed=
 (the "write" side)=0D
> > =0D
> > In Tyr, this would roughly map to something like:=0D
> > =0D
> > struct TyrData {=0D
> >   reset_gate: RwSem<ActiveHwState>=0D
> >   // other, always accessible members=0D
> > }=0D
> > =0D
> > impl TyrData {=0D
> >   fn try_access(&self) -> Option<ReadGuard<'_, ActiveHwState>> {...}=0D
> > }=0D
> > =0D
> > Where ActiveHwState contains the fw/mmu/sched blocks (these are not ups=
tream=0D
> > yet, Deborah has a series that will introduce the fw block that should =
land=0D
> > soon) and perhaps more.=0D
> > =0D
> > Now, the reset logic would be roughly:=0D
> > =0D
> > fn reset_work(tdev: Arc<TyrDevice>) {=0D
> >   // Block until nobody else is accessing the hw, prevent others from=0D
> >   // initiating new accesses too..=0D
> >   let _guard =3D tdev.reset_gate.write();=0D
> >    =0D
> >   // pre_reset() all Resettable implementors=0D
> > =0D
> >   ... reset=0D
> > =0D
> >   // post_Reset all Resettable implementors=0D
> > }=0D
> > =0D
> > Now, for every block that might touch a resource that would be unavaila=
ble=0D
> > during a reset, we enforce a try_access() via the type system, and ensu=
re that=0D
> > the reset cannot start while the guard is alive. In particular, ioctls =
would=0D
> > look like:=0D
> > =0D
> > fn ioctl_foo(...) {=0D
> >   let hw =3D tdev.reset_gate.try_access()?;=0D
> >   // resets are blocked while the guard is alive, no other way to acces=
s that state otherwise=0D
> > }=0D
> > =0D
> > The code will not compile otherwise, so long as we keep the state in Ac=
tiveHwState, i.e.: =0D
> > protected by the r/w sem.=0D
> > =0D
> > This looks like an improvement over Panthor, since Panthor relies on ma=
nually=0D
> > canceling work that access hw state via cancel_work_sync(), and gating =
new work=0D
> > submissions on the "reset_in_progress" flag, i.e.:=0D
> > =0D
> > /**=0D
> >  * sched_queue_work() - Queue a scheduler work.=0D
> >  * @sched: Scheduler object.=0D
> >  * @wname: Work name.=0D
> >  *=0D
> >  * Conditionally queues a scheduler work if no reset is pending/in-prog=
ress.=0D
> >  */=0D
> > #define sched_queue_work(sched, wname) \=0D
> > do { \=0D
> > if (!atomic_read(&(sched)->reset.in_progress) && \=0D
> >     !panthor_device_reset_is_pending((sched)->ptdev)) \=0D
> > queue_work((sched)->wq, &(sched)->wname ## _work); \=0D
> > } while (0)=0D
> > =0D
> > =0D
> > Thoughts?=0D
> =0D
> I don't think a semaphore is the right answer. I think SRCU plus a=0D
> counter makes more sense. (With a sentinal value reserved for "currently=
=0D
> resetting".)=0D
> =0D
> When you begin using the hardware, you start an srcu critical region and=
=0D
> read the counter. If the counter has the sentinel value, you know the=0D
> hardware is resetting and you fail. Otherwise you record the couter and=0D
> proceed.=0D
> =0D
> If at any point you release the srcu critical region and want to=0D
> re-acquire it to continue the same ongoing work, then you must ensure=0D
> that the counter still has the same value. This ensures that if the GPU=0D
> is reset, then even if the reset has finished by the time you come back,=
=0D
> you still fail because the counter has changed.=0D
> =0D
> =0D
> Another option could be to rely on the existing Device unbind logic.=0D
> Entirely remove the class device and run the full unbind procedure,=0D
> cleaning up all devm work etc. Then once that has finished, probe the=0D
> device again and start from scratch. After all, GPU reset does not have=0D
> to be a cheap operation.=0D
> =0D
> Alice=0D
=0D
Anybody working on the SRCU support or do we need to write one?=0D
=0D
Ignoring the sync primitive for a moment (since there is no clear consensus=
=0D
yet), I was trying to figure out the HW access API around a closure.=0D
=0D
I wonder if something like this (roughly, haven't implemented or compiled i=
t=0D
yet) would make sense:=0D
=0D
	struct HwGate {=0D
		// srcu, I guess?=0D
	}=0D
=0D
	struct HwGuard<'a> {=0D
		gate: &'a HwGate,=0D
		hw: &'a ActiveHw,=0D
	}=0D
=0D
	struct ActiveHw {=0D
		// mmu, fw, ...=0D
	}=0D
=0D
	struct Controller {=0D
		...=0D
		hw: ActiveHw,=0D
	}=0D
=0D
	impl Controller {=0D
		fn with_hw<R>(&self, f: impl FnOnce(&HwGuard<'_>) -> Result<R>) -> Result=
<R> {=0D
			let guard =3D self.gate.lock(&self.hw)?;=0D
			f(&guard)=0D
		}=0D
	}=0D
=0D
and TyrDrmDeviceData would hava a helper wrapper:=0D
=0D
	impl TyrDrmDeviceData {=0D
		fn with_hw<R>(&self, f: impl FnOnce(&ActiveHwState) -> Result<R>) -> Resu=
lt<R> {=0D
			self.reset.with_hw(f) // maybe find a better name for "reset"=0D
		}=0D
	}=0D
=0D
Then the user can use it like this:=0D
=0D
	let driver: TyrDrmDeviceData =3D ...;=0D
=0D
	driver.with_hw(|hw| {=0D
		let mmu =3D hw.mmu;=0D
		...=0D
	})=0D
=0D
Any thoughts?=0D
=0D
- Onur=0D
