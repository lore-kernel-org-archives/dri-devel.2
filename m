Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3CC1075290
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F18010E12B;
	Thu, 19 Mar 2026 09:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MAb0Pokh";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725C310E12B;
 Thu, 19 Mar 2026 09:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773914255;
 bh=3E6m3JLDGq7pI0/YN8BMLhMyA/rV1x4Q/HB/7RE+BsI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MAb0PokhiZ0KqEWx0zyIrF99MkUuiGiqVECIk4t7ODsRq8RP1WtFjXQMML4jiatyj
 n0vfMa0pf4/ShKWdroKft3KQHLekRDEJ9jwA7AiIuJfkYS0C36RYVbQDVed92VkH49
 TYPbeW8/sgddXfh7O5nJ9FWDKRdOtYE4cAu5cdUdn/qpdnu93YSqWkwQKgjD1vN94Q
 LkxaZWj5S7lIIcSb9eugaziXzsyGHZXC4Cx+E90Ax363SxcmLUnOACkdJBcDILJsTv
 EkrZLl20N3/zLkPEJeCyPh3QOIwpmyeWucdciYROfRuIBDNuOkFd3XpkgqVqxQDhZ/
 cQgkye5SJVApw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id ADEF017E1005;
 Thu, 19 Mar 2026 10:57:34 +0100 (CET)
Date: Thu, 19 Mar 2026 10:57:29 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "Danilo Krummrich" <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Simona Vetter <simona@ffwll.ch>, Sumit
 Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Jeffrey Vander Stoep <jeffv@google.com>, "Alice Ryhl"
 <aliceryhl@google.com>, Daniel Stone <daniels@collabora.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 <shashanks@nvidia.com>, <jajones@nvidia.com>, Eliot Courtney
 <ecourtney@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <20260319105729.2c20116d@fedora>
In-Reply-To: <absp4z1Op0BrXReP@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <abmaDElHmbQkYy57@lstrano-desk.jf.intel.com>
 <20260317214320.74e6c130@fedora>
 <absp4z1Op0BrXReP@lstrano-desk.jf.intel.com>
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

On Wed, 18 Mar 2026 15:40:35 -0700
Matthew Brost <matthew.brost@intel.com> wrote:

> > >=20
> > > So I don=E2=80=99t think Rust natively solves these types of problems=
, although
> > > I=E2=80=99ll concede that it does make refcounting a bit more sane. =
=20
> >=20
> > Rust won't magically defer the cleanup, nor will it dictate how you want
> > to do the queue teardown, those are things you need to implement. But it
> > should give visibility about object lifetimes, and guarantee that an
> > object that's still visible to some owners is usable (the notion of
> > usable is highly dependent on the object implementation).
> >=20
> > Just a purely theoretical example of a multi-step queue teardown that
> > might be possible to encode in rust:
> >=20
> > - MyJobQueue<Usable>: The job queue is currently exposed and usable.
> >   There's a ::destroy() method consuming 'self' and returning a
> >   MyJobQueue<Destroyed> object
> > - MyJobQueue<Destroyed>: The user asked for the workqueue to be
> >   destroyed. No new job can be pushed. Existing jobs that didn't make
> >   it to the FW queue are cancelled, jobs that are in-flight are
> >   cancelled if they can, or are just waited upon if they can't. When
> >   the whole destruction step is done, ::destroyed() is called, it
> >   consumes 'self' and returns a MyJobQueue<Inactive> object.
> > - MyJobQueue<Inactive>: The queue is no longer active (HW doesn't have
> >   any resources on this queue). It's ready to be cleaned up.
> >   ::cleanup() (or just ::drop()) defers the cleanup of some inner
> >   object that has been passed around between the various
> >   MyJobQueue<State> wrappers.
> >=20
> > Each of the state transition can happen asynchronously. A state
> > transition consumes the object in one state, and returns a new object
> > in its new state. None of the transition involves dropping a refcnt,
> > ownership is just transferred. The final MyJobQueue<Inactive> object is
> > the object we'll defer cleanup on.
> >=20
> > It's a very high-level view of one way this can be implemented (I'm
> > sure there are others, probably better than my suggestion) in order to
> > make sure the object doesn't go away without the compiler enforcing
> > proper state transitions.
> >  =20
>=20
> I'm sure Rust can implement this. My point about Rust is it doesn't
> magically solve hard software arch probles, but I will admit the
> ownership model, way it can enforce locking at compile time is pretty
> cool.

It's not quite about rust directly solving those problems for you, it's
about rust forcing you to think about those problems in the first
place. So no, rust won't magically solve your multi-step teardown with
crazy CPU <-> Device synchronization etc, but it allows you to clearly
identify those steps, and think about how you want to represent them
without abusing other concepts, like object refcounting/ownership.
Everything I described, you can code it in C BTW, it's just that C is so
lax that you can also abuse other stuff to get to your ends, which might
or might not be safe, but more importantly, will very likely obfuscate
the code (even with good docs).

>=20
> > > > > > +/**
> > > > > > + * DOC: DRM dependency fence
> > > > > > + *
> > > > > > + * Each struct drm_dep_job has an associated struct drm_dep_fe=
nce that
> > > > > > + * provides a single dma_fence (@finished) signalled when the =
hardware
> > > > > > + * completes the job.
> > > > > > + *
> > > > > > + * The hardware fence returned by &drm_dep_queue_ops.run_job i=
s stored as
> > > > > > + * @parent. @finished is chained to @parent via drm_dep_job_do=
ne_cb() and
> > > > > > + * is signalled once @parent signals (or immediately if run_jo=
b() returns
> > > > > > + * NULL or an error).   =20
> > > > >=20
> > > > > I thought this fence proxy mechanism was going away due to recent=
 work being
> > > > > carried out by Christian?
> > > > >    =20
> > >=20
> > > Consider the case where a driver=E2=80=99s hardware fence is implemen=
ted as a
> > > dma-fence-array or dma-fence-chain. You cannot install these types of
> > > fences into a dma-resv or into syncobjs, so a proxy fence is useful
> > > here. =20
> >=20
> > Hm, so that's a driver returning a dma_fence_array/chain through
> > ::run_job()? Why would we not want to have them directly exposed and
> > split up into singular fence objects at resv insertion time (I don't
> > think syncobjs care, but I might be wrong). I mean, one of the point =20
>=20
> You can stick dma-fence-arrays in syncobjs, but not chains.

Yeah, kinda makes sense, since timeline syncobjs use chains, and if the
chain reject inner chains, it won't work.

>=20
> Neither dma-fence-arrays/chain can go into dma-resv.

They can't go directly in it, but those can be split into individual
fences and be inserted, which would achieve the same goal.

>=20
> Hence why disconnecting a job's finished fence from hardware fence IMO
> is good idea to keep so gives drivers flexiblity on the hardware fences.

The thing is, I'm not sure drivers were ever meant to expose containers
through ::run_job().

> e.g., If this design didn't have a job's finished fence, I'd have to
> open code one Xe side.

There might be other reasons we'd like to keep the
drm_sched_fence-like proxy that I'm missing. But if it's the only one,
and the fence-combining pattern you're describing is common to multiple
drivers, we can provide a container implementation that's not a
fence_array, so you can use it to insert driver fences into other
containers. This way we wouldn't force the proxy model to all drivers,
but we would keep the code generic/re-usable.

>=20
> > behind the container extraction is so fences coming from the same
> > context/timeline can be detected and merged. If you insert the
> > container through a proxy, you're defeating the whole fence merging
> > optimization. =20
>=20
> Right. Finished fences have single timeline too...

Aren't you faking a single timeline though if you combine fences from
different engines running at their own pace into a container?

>=20
> >=20
> > The second thing is that I'm not sure drivers were ever supposed to
> > return fence containers in the first place, because the whole idea
> > behind a fence context is that fences are emitted/signalled in
> > seqno-order, and if the fence is encoding the state of multiple
> > timelines that progress at their own pace, it becomes tricky to control
> > that. I guess if it's always the same set of timelines that are
> > combined, that would work. =20
>=20
> Xe does this is definitely works. We submit to multiple rings, when all
> rings signal a seqno, a chain or array signals -> finished fence
> signals. The queues used in this manor can only submit multiple ring
> jobs so the finished fence timeline stays intact. If you could a
> multiple rings followed by a single ring submission on the same queue,
> yes this could break.

Okay, I had the same understanding, thanks for confirming.

>=20
> >  =20
> > > One example is when a single job submits work to multiple rings
> > > that are flipped in hardware at the same time. =20
> >=20
> > We do have that in Panthor, but that's all explicit: in a single
> > SUBMIT, you can have multiple jobs targeting different queues, each of
> > them having their own set of deps/signal ops. The combination of all the
> > signal ops into a container is left to the UMD. It could be automated
> > kernel side, but that would be a flag on the SIGNAL op leading to the
> > creation of a fence_array containing fences from multiple submitted
> > jobs, rather than the driver combining stuff in the fence it returns in
> > ::run_job(). =20
>=20
> See above. We have a dedicated queue type for these type of submissions
> and single job that submits to the all rings. We had multiple queue /
> jobs in the i915 to implemented this but it turns out it is much cleaner
> with a single queue / singler job / multiple rings model.

Hm, okay. It didn't turn into a mess in Panthor, but Xe is likely an
order of magnitude more complicated that Mali, so I'll refrain from
judging this design decision.

>=20
> >  =20
> > >=20
> > > Another case is late arming of hardware fences in run_job (which many
> > > drivers do). The proxy fence is immediately available at arm time and
> > > can be installed into dma-resv or syncobjs even though the actual
> > > hardware fence is not yet available. I think most drivers could be
> > > refactored to make the hardware fence immediately available at run_jo=
b,
> > > though. =20
> >=20
> > Yep, I also think we can arm the driver fence early in the case of
> > JobQueue. The reason it couldn't be done before is because the
> > scheduler was in the middle, deciding which entity to pull the next job
> > from, which was changing the seqno a job driver-fence would be assigned
> > (you can't guess that at queue time in that case).
> >  =20
>=20
> Xe doesn't need to late arming, but it look like multiple drivers to
> implement the late arming which may be required (?).

As I said, it's mostly a problem when you have a
single-HW-queue:multiple-contexts model, which is exactly what
drm_sched was designed for. I suspect early arming is not an issue for
any of the HW supporting FW-based scheduling (PVR, Mali, NVidia,
...). If you want to use drm_dep for all drivers currently using
drm_sched (I'm still not convinced this is a good idea to do that
just yet, because then you're going to pull a lot of the complexity
we're trying to get rid of), then you need late arming of driver fences.

>=20
> > [...]
> >  =20
> > > > > > + * **Reference counting**
> > > > > > + *
> > > > > > + * Jobs and queues are both reference counted.
> > > > > > + *
> > > > > > + * A job holds a reference to its queue from drm_dep_job_init(=
) until
> > > > > > + * drm_dep_job_put() drops the job's last reference and its re=
lease callback
> > > > > > + * runs. This ensures the queue remains valid for the entire l=
ifetime of any
> > > > > > + * job that was submitted to it.
> > > > > > + *
> > > > > > + * The queue holds its own reference to a job for as long as t=
he job is
> > > > > > + * internally tracked: from the moment the job is added to the=
 pending list
> > > > > > + * in drm_dep_queue_run_job() until drm_dep_job_done() kicks t=
he put_job
> > > > > > + * worker, which calls drm_dep_job_put() to release that refer=
ence.   =20
> > > > >=20
> > > > > Why not simply keep track that the job was completed, instead of =
relinquishing
> > > > > the reference? We can then release the reference once the job is =
cleaned up
> > > > > (by the queue, using a worker) in process context.   =20
> > >=20
> > > I think that=E2=80=99s what I=E2=80=99m doing, while also allowing an=
 opt-in path to
> > > drop the job reference when it signals (in IRQ context) =20
> >=20
> > Did you mean in !IRQ (or !atomic) context here? Feels weird to not
> > defer the cleanup when you're in an IRQ/atomic context, but defer it
> > when you're in a thread context.
> >  =20
>=20
> The put of a job in this design can be from an IRQ context (opt-in)
> feature. xa_destroy blows up if it is called from an IRQ context,
> although maybe that could be workaround.

Making it so _put() in IRQ context is safe is fine, what I'm saying is
that instead of doing a partial immediate cleanup, and the rest in a
worker, we can just defer everything: that is, have some
_deref_release() function called by kref_put() that would queue a work
item from which the actual release is done.

>=20
> > > so we avoid
> > > switching to a work item just to drop a ref. That seems like a
> > > significant win in terms of CPU cycles. =20
> >=20
> > Well, the cleanup path is probably not where latency matters the most. =
=20
>=20
> Agree. But I do think avoiding a CPU context switch (work item) for a
> very lightweight job cleanup (usually just drop refs) will save of CPU
> cycles, thus also things like power, etc...

That's the sort of statements I'd like to be backed by actual
numbers/scenarios proving that it actually makes a difference. The
mixed model where things are partially freed immediately/partially
deferred, and sometimes even with conditionals for whether the deferral
happens or not, it just makes building a mental model of this thing a
nightmare, which in turn usually leads to subtle bugs.

>=20
> > It's adding scheduling overhead, sure, but given all the stuff we defer
> > already, I'm not too sure we're at saving a few cycles to get the
> > cleanup done immediately. What's important to have is a way to signal
> > fences in an atomic context, because this has an impact on latency.
> >  =20
>=20
> Yes. The signaling happens first then drm_dep_job_put if IRQ opt-in.
>=20
> > [...]
> >  =20
> > > > > > + /*
> > > > > > + * Drop all input dependency fences now, in process context, b=
efore the
> > > > > > + * final job put. Once the job is on the pending list its last=
 reference
> > > > > > + * may be dropped from a dma_fence callback (IRQ context), whe=
re calling
> > > > > > + * xa_destroy() would be unsafe.
> > > > > > + */   =20
> > > > >=20
> > > > > I assume that =E2=80=9Cpending=E2=80=9D is the list of jobs that =
have been handed to the driver
> > > > > via ops->run_job()?
> > > > >=20
> > > > > Can=E2=80=99t this problem be solved by not doing anything inside=
 a dma_fence callback
> > > > > other than scheduling the queue worker?
> > > > >    =20
> > >=20
> > > Yes, this code is required to support dropping job refs directly in t=
he
> > > dma-fence callback (an opt-in feature). Again, this seems like a
> > > significant win in terms of CPU cycles, although I haven=E2=80=99t co=
llected
> > > data yet. =20
> >=20
> > If it significantly hurts the perf, I'd like to understand why, because
> > to me it looks like pure-cleanup (no signaling involved), and thus no
> > other process waiting for us to do the cleanup. The only thing that
> > might have an impact is how fast you release the resources, and given
> > it's only a partial cleanup (xa_destroy() still has to be deferred), I'd
> > like to understand which part of the immediate cleanup is causing a
> > contention (basically which kind of resources the system is starving of)
> >  =20
>=20
> It was more of once we moved to a ref counted model, it is pretty
> trivial allow drm_dep_job_put when the fence is signaling. It doesn't
> really add any complexity either, thus why I added it is.

It's not the refcount model I'm complaining about, it's the "part of it
is always freed immediately, part of it is deferred, but not always ..."
that happens in drm_dep_job_release() I'm questioning. I'd really
prefer something like:

static void drm_dep_job_release()
{
	// do it all unconditionally
}

static void drm_dep_job_defer_release()
{
	queue_work(&job->cleanup_work);
}

static void drm_dep_job_put()
{
	kref_put(job, drm_dep_job_defer_release);
}
