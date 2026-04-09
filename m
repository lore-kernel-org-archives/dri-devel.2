Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281C2EA3C4E
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F89010E81D;
	Thu,  9 Apr 2026 13:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ad0X5hQS";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 225BD10E811
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 13:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775742283; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C1va+UXI3n2r6Qu87DnMyq3OJk3RSJBsWwzyCqbbwU2Wccc0uaqKlHBQnkrnGiSsSiRiSZS/EkPkaatESl/ZUErKX1uKz/vODHQh1iPrVoaaLqhjchN5aLHTrC/i81wtVIiZcmZ02wvdwLi2ImSEvpiFHkvgTt9CwZNb8s//MBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775742283;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IACELWoMgQVNQe/brpupc3LeXkJWLMq8v9SHNUec+LA=; 
 b=FJVxiR6lXrUTXpjzrKmf2uLfJzz7isivVPQyCLLVjvHLOjaZqCUm1nXa78zqMz3w7+LqoXrAAG+x5BmrxfUzXeajX2AvH9NANY95nNAbU8O0p49X3WrcOOl5slns/+beUap2uNpCt60znOeOIhHzwf0XbUAXkYKlG0JtIvW5fIo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775742283; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=IACELWoMgQVNQe/brpupc3LeXkJWLMq8v9SHNUec+LA=;
 b=Ad0X5hQSTcbiNCzPR3emY1mw/f72uWfL76G85UyOn6N/G+cua2EPxe7+7p0nNagz
 mf5LJKYoRmWfmZV/dHs/pNUDN+jKjKoOnZ7bK573qHdm4vLYoZQOGJnH9dzgqpyvaAx
 fw7Nf0WYh0YMyLGhAadCZlfXWpbK0n4bMIiAiIZY=
Received: by mx.zohomail.com with SMTPS id 1775742281657359.5534164318499;
 Thu, 9 Apr 2026 06:44:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1 RESEND 4/4] drm/tyr: add GPU reset handling
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260409114133.43134-1-work@onurozkan.dev>
Date: Thu, 9 Apr 2026 10:44:24 -0300
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <395ED15F-3BC1-48C0-BE36-AF3A951E464D@collabora.com>
References: <20260313091646.16938-1-work@onurozkan.dev>
 <20260313091646.16938-5-work@onurozkan.dev> <20260319120828.52736966@fedora>
 <9876893D-F3B4-4CA4-8858-473B6FB8E7EB@collabora.com>
 <20260409114133.43134-1-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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

Hi Onur,

> On 9 Apr 2026, at 08:41, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> On Fri, 03 Apr 2026 12:01:09 -0300
> Daniel Almeida <daniel.almeida@collabora.com> wrote:
>=20
>>=20
>>=20
>>> On 19 Mar 2026, at 08:08, Boris Brezillon =
<boris.brezillon@collabora.com> wrote:
>>>=20
>>> On Fri, 13 Mar 2026 12:16:44 +0300
>>> Onur =C3=96zkan <work@onurozkan.dev> wrote:
>>>=20
>>>> +impl Controller {
>>>> +    /// Creates a [`Controller`] instance.
>>>> +    fn new(pdev: ARef<platform::Device>, iomem: =
Arc<Devres<IoMem>>) -> Result<Arc<Self>> {
>>>> +        let wq =3D workqueue::OrderedQueue::new(c"tyr-reset-wq", =
0)?;
>>>> +
>>>> +        Arc::pin_init(
>>>> +            try_pin_init!(Self {
>>>> +                pdev,
>>>> +                iomem,
>>>> +                pending: Atomic::new(false),
>>>> +                wq,
>>>> +                work <- kernel::new_work!("tyr::reset"),
>>>> +            }),
>>>> +            GFP_KERNEL,
>>>> +        )
>>>> +    }
>>>> +
>>>> +    /// Processes one scheduled reset request.
>>>> +    ///
>>>> +    /// Panthor reference:
>>>> +    /// - =
drivers/gpu/drm/panthor/panthor_device.c::panthor_device_reset_work()
>>>> +    fn reset_work(self: &Arc<Self>) {
>>>> +        dev_info!(self.pdev.as_ref(), "GPU reset work is =
started.\n");
>>>> +
>>>> +        // SAFETY: `Controller` is part of driver-private data and =
only exists
>>>> +        // while the platform device is bound.
>>>> +        let pdev =3D unsafe { self.pdev.as_ref().as_bound() };
>>>> +        if let Err(e) =3D run_reset(pdev, &self.iomem) {
>>>> +            dev_err!(self.pdev.as_ref(), "GPU reset failed: =
{:?}\n", e);
>>>> +        } else {
>>>> +            dev_info!(self.pdev.as_ref(), "GPU reset work is =
done.\n");
>>>> +        }
>>>=20
>>> Unfortunately, the reset operation is not as simple as instructing =
the
>>> GPU to reset, it's a complex synchronization process where you need =
to
>>> try to gracefully put various components on hold before you reset, =
and
>>> then resume those after the reset is effective. Of course, with what =
we
>>> currently have in-tree, there's not much to suspend/resume, but I =
think
>>> I'd prefer to design the thing so we can progressively add more
>>> components without changing the reset logic too much.
>>>=20
>>> I would probably start with a Resettable trait that has the
>>> {pre,post}_reset() methods that exist in Panthor.
>>>=20
>>> The other thing we need is a way for those components to know when a
>>> reset is about to happen so they can postpone some actions they were
>>> planning in order to not further delay the reset, or end up with
>>> actions that fail because the HW is already unusable. Not too sure =
how
>>> we want to handle that though. Panthor is currently sprinkled with
>>> panthor_device_reset_is_pending() calls in key places, but that's =
still
>>> very manual, maybe we can automate that a bit more in Tyr, dunno.
>>>=20
>>=20
>>=20
>> We could have an enum where one of the variants is Resetting, and the =
other one
>> gives access to whatever state is not accessible while resets are in =
progress.
>>=20
>> Something like
>>=20
>> pub enum TyrData {
>>  Active(ActiveTyrData),
>>  ResetInProgress(ActiveTyrData)
>> }
>>=20
>> fn access() -> Option<&ActiveTyrData> {
>>  =E2=80=A6 // if the =E2=80=9CResetInProgress=E2=80=9D variant is =
active, return None
>> }
>>=20
>=20
> That's an interesting approach, but if it's all about `fn access` =
function, we
> can already do that with a simple atomic state e.g.,:
>=20
> // The state flag in reset::Controller
> state: Atomic<ResetState>
>=20
> fn access(&self) -> Option<&Arc<Devres<IoMem>>> {
> match self.state.load(Relaxed) {
> ResetState::Idle =3D> Some(&self.iomem),
> _ =3D> None,
> }
> }
>=20
> What do you think? Would this be sufficient?
>=20
> Btw, a sample code snippet from the caller side would be very helpful =
for
> designing this further. That part is kind a blurry for me.
>=20
> Thanks,
> Onur
>=20
>>=20
>>>> +
>>>> +        self.pending.store(false, Release);
>>>> +    }
>>>> +}

I think that there are two things we're trying to implement correctly:

1) Deny access to a subset of the state while a reset is in progress
2) Wait for anyone accessing 1) to finish before starting a reset

IIUC, using Atomic<T> can solve 1 by bailing if the "reset in progress"
flag/variant is set, but I don't think it implements 2? One would have =
to
implement more logic to block until the state is not being actively =
used.

Now, there are probably easier ways to solve this, but I propose that we =
do the
extra legwork to make this explicit and enforceable by the type system.

How about introducing a r/w semaphore abstraction? It seems to correctly =
encode
the logic we want:

a) multiple users can access the state if no reset is pending ("read" =
side)
b) the reset code can block until the state is no longer being accessed =
(the "write" side)

In Tyr, this would roughly map to something like:

struct TyrData {
  reset_gate: RwSem<ActiveHwState>
  // other, always accessible members
}

impl TyrData {
  fn try_access(&self) -> Option<ReadGuard<'_, ActiveHwState>> {...}
}

Where ActiveHwState contains the fw/mmu/sched blocks (these are not =
upstream
yet, Deborah has a series that will introduce the fw block that should =
land
soon) and perhaps more.

Now, the reset logic would be roughly:

fn reset_work(tdev: Arc<TyrDevice>) {
  // Block until nobody else is accessing the hw, prevent others from
  // initiating new accesses too..
  let _guard =3D tdev.reset_gate.write();
  =20
  // pre_reset() all Resettable implementors

  ... reset

  // post_Reset all Resettable implementors
}

Now, for every block that might touch a resource that would be =
unavailable
during a reset, we enforce a try_access() via the type system, and =
ensure that
the reset cannot start while the guard is alive. In particular, ioctls =
would
look like:

fn ioctl_foo(...) {
  let hw =3D tdev.reset_gate.try_access()?;
  // resets are blocked while the guard is alive, no other way to access =
that state otherwise
}

The code will not compile otherwise, so long as we keep the state in =
ActiveHwState, i.e.:=20
protected by the r/w sem.

This looks like an improvement over Panthor, since Panthor relies on =
manually
canceling work that access hw state via cancel_work_sync(), and gating =
new work
submissions on the "reset_in_progress" flag, i.e.:

/**
 * sched_queue_work() - Queue a scheduler work.
 * @sched: Scheduler object.
 * @wname: Work name.
 *
 * Conditionally queues a scheduler work if no reset is =
pending/in-progress.
 */
#define sched_queue_work(sched, wname) \
do { \
if (!atomic_read(&(sched)->reset.in_progress) && \
    !panthor_device_reset_is_pending((sched)->ptdev)) \
queue_work((sched)->wq, &(sched)->wname ## _work); \
} while (0)


Thoughts?

=E2=80=94 Daniel


