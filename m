Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9301DC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA1110E5AD;
	Fri,  3 Jul 2026 08:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EHWdI6O7";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0831810E5BE
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:52:17 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gs6vL1VFHz9tZg;
 Fri,  3 Jul 2026 10:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1783068734; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G46k++2TpMP0L1g6m/LI4FzD9fQHPUr5GJhkRr1ZlLo=;
 b=EHWdI6O7ybGZ0SgoRhLV/k+40EzIhTO0L97FAK7e4MBO4iK+DTJHk4GQBam/GYWQXBCJ2r
 vp+ceoR7XyYwT/D8uU1ctRviBmGnhOoSTrVPi6q8WoVtSVDPES/opDT/BWaVfQ9pNLLix2
 w43sEGOMLq0+30biZJyxwximEb+EPus6poSftFFJPVsXmufOPeamsMwO68dScKfc2F3Gu4
 z5WuvDVx4ALmu8aGbDBTtqJHUrUeZt5QPmmUpirtoC7orsceCikdCjt2Wm4QsajJr8HTUo
 ykcgoXXcxu6hpAzhsMG3tS4xxjIXBLuQbjIiYD7ybHd/D4SmgBDE8PPWD29Vdg==
Message-ID: <4eb23476ff56bee108578adfe131be38e8fc1476.camel@mailbox.org>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu
 <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
 kernel-dev@igalia.com, Tejun Heo <tj@kernel.org>
Date: Fri, 03 Jul 2026 10:52:09 +0200
In-Reply-To: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: eg45w7cyicaxu5w993znentrz5oifb5e
X-MBO-RS-ID: 87edc1ae66317e8fed1
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

+Cc Tejun

On Thu, 2026-07-02 at 15:37 +0100, Tvrtko Ursulin wrote:
>=20

[=E2=80=A6]

> DRM scheduler was originally using kthreads but was converted workqueues =
due
> desire by xe to create thousands of schedulers. This series also question=
s
> whether that was needed, given how the submission is serialized by a devi=
ce
> global lock (per GT, so almost device global). Panthor has a similar situ=
ation;
> hence the series contains two patches to move those two to a setup which =
matches
> the design of those drivers.
>=20
> Other drivers, like for example amdgpu, v3d, etnaviv etc, which use the
> scheduler as a hardware scheduler, where number of instances follow the n=
umber
> of hardware blocks instead the number of userspace contexts, are complete=
ly
> fine.
>=20
> There are use cases however which do currently track the number of usersp=
ace
> contexts and which do allow for more parallelism. For those a straight
> kthread_work conversion would be a problem due an explosion in number of
> threads.
>=20
> The most direct example is panthor VM bind queue which creates a schedule=
r per
> userspace context and relies on work queue concurrency management to keep=
 the
> number of threads in check.
>=20
> This creates a challenge for the kthread_work conversion. To solve which =
I for
> now opted to create a trivial round-robin thread pool. For the RFC this i=
s
> limited to four CPU threads and is something which will need to be discus=
sed.
> Ie. how much parallelsim those really need. The true answer is somewhere =
between
> "at most the number of active userspace contexts and the number of CPU co=
res".
> Or it could be less than that, since after all, VM BIND parallelism is
> eventually going to choke on a narrower gate of actual GPU execution. We =
could
> also allow drivers to pick their number.

Anyone remember whether that was discussed back in the day of
converting to workqueue?

What makes this idea suspicious in my mind is that the workqueue
implementation exists to solve precisely this issue: decide how many
kthreads really need to be spawned. AFAIK it can spawn additional
threads dynamically if necessary.

So the first question I would like to see considered is whether
workqueue could be improved in any way to address said latency issues.

Have you already considered that, Tvrtko?

IOW, is it the nature of workqueue or our way of using them in
drm_sched which causes this performance difference in the submit path?

It would seem that it's the desire for more fine-grained scheduling
characteristic control that you get with a kthread.

>=20
>=20
>=20

[=E2=80=A6]

> Tvrtko Ursulin (8):
> =C2=A0 drm/panthor: Remove redundant drm_sched_job_cleanup() from the
> =C2=A0=C2=A0=C2=A0 .free_job callback
> =C2=A0 drm/panthor: Use separate workqueue for DRM scheduler
> =C2=A0 drm/sched: Use generic naming for workqueue helpers

This should be a separate patch :)


P.
