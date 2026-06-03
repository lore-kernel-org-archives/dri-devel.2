Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C19CD6E56
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 11:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8831A10FC29;
	Wed,  3 Jun 2026 11:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BPBVxQ2V";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E16EF10FC29
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 11:14:09 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gVlSt62QVz9tyP;
 Wed,  3 Jun 2026 13:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780485246; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfx1tvNRErDF1HTfIALai0SM6G/2WCKioBj6QNPwX3A=;
 b=BPBVxQ2VOQAmNjCBS/CsdXEc93Uxz5hNgeSYzCzuxZ4ngIWUoTZNfdBP5vIjzMQj0kBM+P
 Kdl6ilr9GRoN2ML5piHR18evBZ4FgrFuw0cshQbkRPARaCNVGLWx63IQienE4wVNFKZr9E
 EFhOtnhzMO1P/jWnKEzI14hcZ5pPvU1vaA0Wu5L//63pm+Lg575BehyMPZfko2WTQ8kzfT
 Y2z6I6kmx02CeMtQD803CG1O1WrzXFq/xzzzIvpSNWqdL6pfKJD4vmgibezueqg+UnFKGs
 zh3E1IQay3huth/SSctwXfEigcz3iajI4+bMjYS5xcKmXd3bxpB3NE1atKSRiQ==
Message-ID: <c6ecda00eb1aa6a88c17354e26d4dd7dc58ae582.camel@mailbox.org>
Subject: Re: [PATCH] Documentation: drm: Add entry for removing spsc_queue
 to TODO list
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, avid Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>,  Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann	
 <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan	
 <skhan@linuxfoundation.org>, dakr@kernel.org, Tvrtko Ursulin	
 <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 03 Jun 2026 13:14:01 +0200
In-Reply-To: <aceb688b-4f65-4539-a4f1-fc5455b60a5f@amd.com>
References: <20260529215207.115513-2-phasta@kernel.org>
 <aceb688b-4f65-4539-a4f1-fc5455b60a5f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: bihjw5wo6xpk91679khq9hpsnwrfqzps
X-MBO-RS-ID: 4831e0c02127252da33
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

On Mon, 2026-06-01 at 10:30 +0200, Christian K=C3=B6nig wrote:
>=20
>=20
> On 5/29/26 23:52, Philipp Stanner wrote:
> > drm_sched contains a lockless queue (spsc_queue) that seems to be
> > useless and potentially unsound.
> >=20
> > Add a TODO list entry for replacing spsc_queue with a locked list.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Pushed to drm-misc-next

Thx
P.

>=20
> > ---
> > =C2=A0Documentation/gpu/todo.rst | 41 +++++++++++++++++++++++++++++++++=
+++++
> > =C2=A01 file changed, 41 insertions(+)
> >=20
> > diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> > index cdddf8db35f5..87e082b0eb48 100644
> > --- a/Documentation/gpu/todo.rst
> > +++ b/Documentation/gpu/todo.rst
> > @@ -948,6 +948,47 @@ Contact: Philipp Stanner <phasta@kernel.org>
> > =C2=A0
> > =C2=A0Level: Intermediate
> > =C2=A0
> > +Replace the lockless queue with a locked list
> > +---------------------------------------------
> > +
> > +drm_sched is the only user in the entire kernel of a special lockless =
queue, the
> > +spsc_queue. This queue utilizes:
> > +
> > +- preempt_disable()
> > +- atomic instructions
> > +- memory barriers
> > +- ACCESS_ONCE()
> > +
> > +whereas a conventional spinlock utilizes:
> > +
> > +- preempt_disable()
> > +- 1 atomic instruction for taking / releasing the lock
> > +- memory barriers
> > +
> > +Moreover, drm_sched_entity_push_job(), the only user of spsc_queue_pus=
h(), has
> > +to take a lock in some situations anyways and calls to it are often se=
rialized
> > +with a driver lock.
> > +
> > +It is, thus, highly questionable whether the lockless queue grants any=
 advantage
> > +at all. Considering that its internals are not well documented and its=
 correctness
> > +is not formally proven, it seems desirable to replace the queue with a=
 mere list
> > +or hlist that is protected by a spinlock.
> > +
> > +Tasks:
> > +
> > +- Replace the spsc_queue in drm/sched (and those who might access the =
scheduler's
> > +=C2=A0 internal queue) with a spinlock + (h)list.
> > +- Ideally, check with some micro benchmarks and real world tests (pref=
erably
> > +=C2=A0 with amdgpu) for relevant performance regressions.
> > +- Remove the spsc_queue from the kernel altogether.
> > +
> > +Contact:
> > +
> > +- Philipp Stanner <phasta@kernel.org>
> > +- Christian K=C3=B6nig <christian.koenig@amd.com>
> > +
> > +Level: Beginner
> > +
> > =C2=A0Outside DRM
> > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
