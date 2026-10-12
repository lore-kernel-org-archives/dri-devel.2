Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2599CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A4910E3E1;
	Mon, 12 Oct 2026 08:18:16 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 330C410E3E1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:18:09 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j39MJ4NJ3zKpDj;
 Mon, 12 Oct 2026 10:18:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1791793084; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AorKVAymubQ0em8KS7yftkf1mZWNaB5OzkWMcun9Dsk=;
 b=b0/65HIdkmGeeRlNauoUzK9EsuMqwLdNZ+YnkFvrpO1RcvO7vmhcILZugMIspOUrWdWRB6
 2boupsKeI5QieNxavknH6QpntGV9SPsi3OsHNPfUCWW+KLNQy3omRuJOiKh9/MPlmYBxpO
 /q9Xw/aN3F13tXodL3vsFCYV8wB0zD8UnvsBncgvIvaiyBBxhhV6JyRayagFo6C54+7up8
 8/PENomwXjcYCnvwIWYKdE+lqmptRdJApbSEGcHl7SC/DJkKWiymxixPEjZNywn0k+CC3K
 ABiwTvQVZnrDAAr1MC7xnEqTCQKIGGQPqtFDlwcQXgKJWLfi0+NXlNW/sVrRrg==
Message-ID: <48e62f95f7c3bd5515d0b0d83971346056837403.camel@mailbox.org>
Subject: Re: [RFC PATCH v5 0/6] rust: Add drm::JobQueue
From: Philipp Stanner <phasta@mailbox.org>
To: Daniel Almeida <daniel.almeida@collabora.com>, Philipp Stanner
 <phasta@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron	 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Tamir Duberstein	 <tamird@kernel.org>, Alexandre
 Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>, David Airlie <airlied@gmail.com>, Simona Vetter	
 <simona@ffwll.ch>, Boris Brezillon <boris.brezillon@collabora.com>, 
 John.harrison@igalia.com, da.gomez@kernel.org,
 linux-kernel@vger.kernel.org, 	linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	rust-for-linux@vger.kernel.org, Janne
 Grunau <j@jannau.net>
Date: Mon, 12 Oct 2026 10:17:57 +0200
In-Reply-To: <F09C7397-AF97-4947-89D5-759498BCF7B0@collabora.com>
References: <20261009191124.1022902-2-phasta@kernel.org>
 <F09C7397-AF97-4947-89D5-759498BCF7B0@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-MBO-RS-META: qbp939n4yhzmrx5bq3xkb6exkanmqfnw
X-MBO-RS-ID: 15191c5d53db699b10a
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

+Cc Janne

On Sat, 2026-10-10 at 21:22 -0300, Daniel Almeida wrote:
> Hi Philipp,
>=20
> > On 9 Oct 2026, at 16:11, Philipp Stanner <phasta@kernel.org> wrote:
> >=20
> > Changes in v5:
> > =C2=A0- Add back the Revocable<JobQueueInner=E2=80=A6> from my earliest=
 RFCs. Reason
> > =C2=A0=C2=A0 is still the same: JQ dropping while dependency fences sig=
nal could
> > =C2=A0=C2=A0 deadlock. Similarly, this solves a dependency kicking of t=
he work
> > =C2=A0=C2=A0 item again while drop() is running.
>=20
> Can you expand a bit on this? IIUC the problem is introduced by trying to=
 take
> the jq lock on signal? If so, this could be avoided by queuing the worker=
 from
> that path instead?

That's a good point, but I'm not entirely sure if it would result in
well-defined behavior in Rust. Let's say we design it like this:

struct JobQueue {
  inner: Lock<JobQueueInner<=E2=80=A6>>, // <- contains job lists with dep =
wakers who want to start 'work'
  work: ScopedWork, // <- tries to access 'inner'
}

Now:

JQ drops -> jq.inner drops -> takes lock -> iterates over jobs,
deregistering all dep fences

Simultaneously, a job that the iteration has not yet reached gets
ready, schedules 'work'. The Workqueue backend runs 'work' right away,
it starts spinning on Lock<JobQueueInner>

Dropping of jq.inner releases the Lock around inner. Thus, now the work
item can take the lock, right when 'work' is about to drop and, thus,
before it could be canceled.

So this would be UAF, wouldn't it? Correct me if I'm wrong.

I still use the system_wq (will be changed, TODO). Could we solve the
problem with the right drop order if we have a distinct wq?

>=20
> > =C2=A0- Do not call run_job() with a lock held, since run_job() might s=
leep.
> > =C2=A0=C2=A0 AFAICS, this also makes the proposed XArray solution impos=
sible and
> > =C2=A0=C2=A0 demands that we use a list.
>=20
> Can you expand on this a bit?

That run_job() might sleep was AFAIK proposed in our workshop at LPC. I
think it can't allocate because of the fence critical section path,
though.

Anyways, we have to borrow a job to the driver in run_job(), but
simultaneously we cannot / should not hold the lock of the data
structure (no matter whether XArray or list or ringbuf) in which the
job resides.

So what you effectively have to do is take $DATA_STRUCTURE's lock, pull
out the job, release the lock, call run_job() to borrow the job, and
after running take the lock again to update the data structure.

AFAIU this issue was what you were describing in our workshop when you
were trying to protect xarray's tip-job with a distinct lock?


Note in my last patch that this opens up a race path with
jq.complete_jobs() which we want to address, but that is solvable.

>=20
> > =C2=A0- Re-add the earlier credit-count-system, so that run_job() is
> > =C2=A0=C2=A0 infallible. Simplifies the design quite a bit. (Danilo)
>=20
> What is AGX=E2=80=99s position on this? IIRC, this credit system could no=
t represent
> their submission model exactly, like it can for others.

Let's ask them :)
@Janne, WDYT?

[=E2=80=A6]

> > 1.
> > I believe that callers of jq.new_job() and jq.submit_job() do not need
> > an outer serialization mutex. Reason is that JQ serializes with its
> > internal lock. Sequence numbers cannot take over older seqnos because i=
t
> > is submit_job() who sets the seqno.
>=20
> I guess this makes sense, so long as submit_job() doesn=E2=80=99t take &m=
ut self?

It can be &self now. Earlier we wanted `&mut self` to enforce locking
by the driver, but as I said I don't see a reason for that anymore.

> >=20

[=E2=80=A6]

> > 2.
> > I, furthermore, believe that a driver will not need to hold a
> > driver-lock while calling jq.complete_jobs_up_to_seqno().
>=20
> In tyr, we hold _no_ locks.
>=20

Huh? I understood that very differently at LPC. My understanding was
that you had to work hard to get around locking issues between driver-
lock and JQ-lock.


>  The driver signals the fences, and this will
> enqueue the worker thread.

That is not our intended design anymore, because we want the Job to
hold the DriverFence, the JobQueue to hold the FenceContext, and the
JobQueue to hold the jobs.

Thereby, the DriverFence's data: T is also the Job's data: T, which IMO
is the only thing that makes sense, because the job's data is what will
be relevant for the fence backend_ops, and, therefore, is what needs to
be protected by the RCU grace period (see above).

The consequence is that jobs are to be completed with sth like

JobQueue::complete_jobs_up_to(seqno: u64, state: Result)


>=20

Thanks for your input, appreciated!

Philipp
