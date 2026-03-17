Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D8AFF6E7D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 20:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B2110E67D;
	Tue, 17 Mar 2026 20:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EIO7mwrV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA97A10E362;
 Tue, 17 Mar 2026 20:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773780213;
 bh=s8wHOKxEu/f0ugUhVWf/KplhmpeCQHsCD28fPopS/Kw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EIO7mwrV79dXQtMPxq/uCAzgBffIw2LHnt5TVKHyB2qCoecGVyOEQJLxXbGhAdkib
 2hyBPhW5QRmvHzgrWYLV+a1sOAoqadQUqlC3UIRR8uNNEwcrHUCfkD/+wO0ucGdgae
 rp3KWcF/3D5aiFaRXnVDw9kxmQ8bBb3iqVz8RlMf6iz9NisdLbbZf93xhmgEitfTDv
 l1pZbIaSdv8vsfDuHjqtjWTsiRNlhnUQBXUIhbCD383rDsS+1p6Cpyc0u2o+tz02lC
 9wYu8iSvAYnIAg86zdUJ7jfHUKEolHa5ipEdEZHlazL2jSVTnRlB9zlwDaznG7Z4q6
 9kNYFPAWIH2YQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8305717E04DC;
 Tue, 17 Mar 2026 21:43:32 +0100 (CET)
Date: Tue, 17 Mar 2026 21:43:20 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Alice
 Ryhl <aliceryhl@google.com>, Daniel Stone <daniels@collabora.com>,
 Alexandre Courbot <acourbot@nvidia.com>, John Hubbard
 <jhubbard@nvidia.com>, <shashanks@nvidia.com>, <jajones@nvidia.com>, Eliot
 Courtney <ecourtney@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <20260317214320.74e6c130@fedora>
In-Reply-To: <abmaDElHmbQkYy57@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <abmaDElHmbQkYy57@lstrano-desk.jf.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

Hi Matthew,

Just a few drive-by comments.

On Tue, 17 Mar 2026 11:14:36 -0700
Matthew Brost <matthew.brost@intel.com> wrote:

> > > > Timeout Detection and Recovery (TDR): a per-queue delayed work item
> > > > fires when the head pending job exceeds q->job.timeout jiffies, cal=
ling
> > > > ops->timedout_job(). drm_dep_queue_trigger_timeout() forces immedia=
te
> > > > expiry for device teardown.
> > > >=20
> > > > IRQ-safe completion: queues flagged DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ=
_SAFE
> > > > allow drm_dep_job_done() to be called from hardirq context (e.g. a
> > > > dma_fence callback). Dependency cleanup is deferred to process cont=
ext
> > > > after ops->run_job() returns to avoid calling xa_destroy() from IRQ.
> > > >=20
> > > > Zombie-state guard: workers use kref_get_unless_zero() on entry and
> > > > bail immediately if the queue refcount has already reached zero and
> > > > async teardown is in flight, preventing use-after-free. =20
> > >=20
> > > In rust, when you queue work, you have to pass a reference-counted po=
inter
> > > (Arc<T>). We simply never have this problem in a Rust design. If ther=
e is work
> > > queued, the queue is alive.
> > >=20
> > > By the way, why can=E2=80=99t we simply require synchronous teardowns=
? =20
>=20
> Consider the case where the DRM dep queue=E2=80=99s refcount drops to zer=
o, but
> the device firmware still holds references to the associated queue.
> These are resources that must be torn down asynchronously. In Xe, I need
> to send two asynchronous firmware commands before I can safely remove
> the memory associated with the queue (faulting on this kind of global
> memory will take down the device) and recycle the firmware ID tied to
> the queue. These async commands are issued on the driver side, on the
> DRM dep queue=E2=80=99s workqueue as well.

Asynchronous teardown is okay, but I'm not too sure using the refcnt to
know that the queue is no longer usable is the way to go. To me the
refcnt is what determines when the SW object is no longer referenced by
any other item in the code, and a work item acting on the queue counts
as one owner of this queue. If you want to cancel the work in order to
speed up the destruction of the queue, you can call
{cancel,disable}_work[_sync](), and have the ref dropped if the
cancel/disable was effective. Multi-step teardown is also an option,
but again, the state of the queue shouldn't be determined from its
refcnt IMHO.

>=20
> Now consider a scenario where something goes wrong and those firmware
> commands never complete, and a device reset is required to recover. The
> driver=E2=80=99s per-queue tracking logic stops all queues (including zom=
bie
> ones), determines which commands were lost, cleans up the side effects
> of that lost state, and then restarts all queues. That is how we would
> end up in this work item with a zombie queue. The restart logic could
> probably be made smart enough to avoid queueing work for zombie queues,
> but in my opinion it=E2=80=99s safe enough to use kref_get_unless_zero() =
in the
> work items.

Well, that only works for single-step teardown, or when you enter the
last step. At which point, I'm not too sure it's significantly better
than encoding the state of the queue through a separate field, and have
the job queue logic reject new jobs if the queue is no longer usable
(shouldn't even be exposed to userland at this point though).

>=20
> It should also be clear that a DRM dep queue is primarily intended to be
> embedded inside the driver=E2=80=99s own queue object, even though it is =
valid
> to use it as a standalone object. The async teardown flows are also
> optional features.
>=20
> Let=E2=80=99s also consider a case where you do not need the async firmwa=
re
> flows described above, but the DRM dep queue is still embedded in a
> driver-side object that owns memory via dma-resv. The final queue put
> may occur in IRQ context (DRM dep avoids kicking a worker just to drop a
> refi as opt in), or in the reclaim path (any scheduler workqueue is the
> reclaim path). In either case, you cannot free memory there taking a
> dma-resv lock, which is why all DRM dep queues ultimately free their
> resources in a work item outside of reclaim. Many drivers already follow
> this pattern, but in DRM dep this behavior is built-in.

I agree deferred cleanup is the way to go.

>=20
> So I don=E2=80=99t think Rust natively solves these types of problems, al=
though
> I=E2=80=99ll concede that it does make refcounting a bit more sane.

Rust won't magically defer the cleanup, nor will it dictate how you want
to do the queue teardown, those are things you need to implement. But it
should give visibility about object lifetimes, and guarantee that an
object that's still visible to some owners is usable (the notion of
usable is highly dependent on the object implementation).

Just a purely theoretical example of a multi-step queue teardown that
might be possible to encode in rust:

- MyJobQueue<Usable>: The job queue is currently exposed and usable.
  There's a ::destroy() method consuming 'self' and returning a
  MyJobQueue<Destroyed> object
- MyJobQueue<Destroyed>: The user asked for the workqueue to be
  destroyed. No new job can be pushed. Existing jobs that didn't make
  it to the FW queue are cancelled, jobs that are in-flight are
  cancelled if they can, or are just waited upon if they can't. When
  the whole destruction step is done, ::destroyed() is called, it
  consumes 'self' and returns a MyJobQueue<Inactive> object.
- MyJobQueue<Inactive>: The queue is no longer active (HW doesn't have
  any resources on this queue). It's ready to be cleaned up.
  ::cleanup() (or just ::drop()) defers the cleanup of some inner
  object that has been passed around between the various
  MyJobQueue<State> wrappers.

Each of the state transition can happen asynchronously. A state
transition consumes the object in one state, and returns a new object
in its new state. None of the transition involves dropping a refcnt,
ownership is just transferred. The final MyJobQueue<Inactive> object is
the object we'll defer cleanup on.

It's a very high-level view of one way this can be implemented (I'm
sure there are others, probably better than my suggestion) in order to
make sure the object doesn't go away without the compiler enforcing
proper state transitions.

> > > > +/**
> > > > + * DOC: DRM dependency fence
> > > > + *
> > > > + * Each struct drm_dep_job has an associated struct drm_dep_fence =
that
> > > > + * provides a single dma_fence (@finished) signalled when the hard=
ware
> > > > + * completes the job.
> > > > + *
> > > > + * The hardware fence returned by &drm_dep_queue_ops.run_job is st=
ored as
> > > > + * @parent. @finished is chained to @parent via drm_dep_job_done_c=
b() and
> > > > + * is signalled once @parent signals (or immediately if run_job() =
returns
> > > > + * NULL or an error). =20
> > >=20
> > > I thought this fence proxy mechanism was going away due to recent wor=
k being
> > > carried out by Christian?
> > >  =20
>=20
> Consider the case where a driver=E2=80=99s hardware fence is implemented =
as a
> dma-fence-array or dma-fence-chain. You cannot install these types of
> fences into a dma-resv or into syncobjs, so a proxy fence is useful
> here.

Hm, so that's a driver returning a dma_fence_array/chain through
::run_job()? Why would we not want to have them directly exposed and
split up into singular fence objects at resv insertion time (I don't
think syncobjs care, but I might be wrong). I mean, one of the point
behind the container extraction is so fences coming from the same
context/timeline can be detected and merged. If you insert the
container through a proxy, you're defeating the whole fence merging
optimization.

The second thing is that I'm not sure drivers were ever supposed to
return fence containers in the first place, because the whole idea
behind a fence context is that fences are emitted/signalled in
seqno-order, and if the fence is encoding the state of multiple
timelines that progress at their own pace, it becomes tricky to control
that. I guess if it's always the same set of timelines that are
combined, that would work.

> One example is when a single job submits work to multiple rings
> that are flipped in hardware at the same time.

We do have that in Panthor, but that's all explicit: in a single
SUBMIT, you can have multiple jobs targeting different queues, each of
them having their own set of deps/signal ops. The combination of all the
signal ops into a container is left to the UMD. It could be automated
kernel side, but that would be a flag on the SIGNAL op leading to the
creation of a fence_array containing fences from multiple submitted
jobs, rather than the driver combining stuff in the fence it returns in
::run_job().

>=20
> Another case is late arming of hardware fences in run_job (which many
> drivers do). The proxy fence is immediately available at arm time and
> can be installed into dma-resv or syncobjs even though the actual
> hardware fence is not yet available. I think most drivers could be
> refactored to make the hardware fence immediately available at run_job,
> though.

Yep, I also think we can arm the driver fence early in the case of
JobQueue. The reason it couldn't be done before is because the
scheduler was in the middle, deciding which entity to pull the next job
from, which was changing the seqno a job driver-fence would be assigned
(you can't guess that at queue time in that case).

[...]

> > > > + * **Reference counting**
> > > > + *
> > > > + * Jobs and queues are both reference counted.
> > > > + *
> > > > + * A job holds a reference to its queue from drm_dep_job_init() un=
til
> > > > + * drm_dep_job_put() drops the job's last reference and its releas=
e callback
> > > > + * runs. This ensures the queue remains valid for the entire lifet=
ime of any
> > > > + * job that was submitted to it.
> > > > + *
> > > > + * The queue holds its own reference to a job for as long as the j=
ob is
> > > > + * internally tracked: from the moment the job is added to the pen=
ding list
> > > > + * in drm_dep_queue_run_job() until drm_dep_job_done() kicks the p=
ut_job
> > > > + * worker, which calls drm_dep_job_put() to release that reference=
. =20
> > >=20
> > > Why not simply keep track that the job was completed, instead of reli=
nquishing
> > > the reference? We can then release the reference once the job is clea=
ned up
> > > (by the queue, using a worker) in process context. =20
>=20
> I think that=E2=80=99s what I=E2=80=99m doing, while also allowing an opt=
-in path to
> drop the job reference when it signals (in IRQ context)

Did you mean in !IRQ (or !atomic) context here? Feels weird to not
defer the cleanup when you're in an IRQ/atomic context, but defer it
when you're in a thread context.

> so we avoid
> switching to a work item just to drop a ref. That seems like a
> significant win in terms of CPU cycles.

Well, the cleanup path is probably not where latency matters the most.
It's adding scheduling overhead, sure, but given all the stuff we defer
already, I'm not too sure we're at saving a few cycles to get the
cleanup done immediately. What's important to have is a way to signal
fences in an atomic context, because this has an impact on latency.

[...]

> > > > + /*
> > > > + * Drop all input dependency fences now, in process context, befor=
e the
> > > > + * final job put. Once the job is on the pending list its last ref=
erence
> > > > + * may be dropped from a dma_fence callback (IRQ context), where c=
alling
> > > > + * xa_destroy() would be unsafe.
> > > > + */ =20
> > >=20
> > > I assume that =E2=80=9Cpending=E2=80=9D is the list of jobs that have=
 been handed to the driver
> > > via ops->run_job()?
> > >=20
> > > Can=E2=80=99t this problem be solved by not doing anything inside a d=
ma_fence callback
> > > other than scheduling the queue worker?
> > >  =20
>=20
> Yes, this code is required to support dropping job refs directly in the
> dma-fence callback (an opt-in feature). Again, this seems like a
> significant win in terms of CPU cycles, although I haven=E2=80=99t collec=
ted
> data yet.

If it significantly hurts the perf, I'd like to understand why, because
to me it looks like pure-cleanup (no signaling involved), and thus no
other process waiting for us to do the cleanup. The only thing that
might have an impact is how fast you release the resources, and given
it's only a partial cleanup (xa_destroy() still has to be deferred), I'd
like to understand which part of the immediate cleanup is causing a
contention (basically which kind of resources the system is starving of)

Regards,

Boris
