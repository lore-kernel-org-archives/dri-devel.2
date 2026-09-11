Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD53C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0848C10E012;
	Fri, 11 Sep 2026 08:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PzwR2YEm";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1789310E012;
 Fri, 11 Sep 2026 08:56:33 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hh7gx3TmjzMlKK;
 Fri, 11 Sep 2026 10:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789116989; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALcg9Vd2npenlt0/QL85p1BH7ueYmsjnSxLgqn+ltps=;
 b=PzwR2YEmy86J27En3HvOQRYRRuqhQq4R4lMZ/rk4CoTTFxyZ163J2dIdgHgvBeHci6e6Wc
 7PZw2Rym2+n0H8gGVrm0Kz52ppShzDKo3v1tj3oXVD0PePAHvLNkRczz4GTbHYMWps2jqL
 j+LWmcnyS7dZASoQVdbNk5FReahby9dfCmoBLaF2hdyKM1c1JH48zCMH5P/Df6zbpjwCnv
 0ajDXD3wS8Dq4Lsp8YKJ02M5xyaj+7tZ1Rox0K/yRXhLwuSU7Cg0Yr8OIRhxFoe99VnJWO
 o7/36ZIEuRpl+lj/pSTGU0r9Yws0wFF4iHrsN+tedzA6RtoA7J/s7vlBsJ2rKg==
Message-ID: <ad1382b98d5c6cb258658e8e85156a0ccd8dd7cf.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Do not restore unsaved virtual runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luke.Wildhardt@proton.me, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner	 <phasta@kernel.org>, Pierre-Eric
 Pelloux-Prayer	 <pierre-eric.pelloux-prayer@amd.com>, Matthew Brost
 <matthew.brost@intel.com>,  Vitaly Prosyak <vitaly.prosyak@amd.com>,
 stable@vger.kernel.org
Date: Fri, 11 Sep 2026 10:56:23 +0200
In-Reply-To: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
References: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: z9t3txr6jjnc7f1rorymfnawnrafryo9
X-MBO-RS-ID: af8d3356cabcd556fd9
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

On Mon, 2026-09-07 at 14:05 +0100, Tvrtko Ursulin wrote:
> Prevent pushing a new job to an entity seeing it being the first in the
> queue, and hence entering the drm_sched_rq_add_entity() path, if the pop
> side in drm_sched_entity_pop_job() has de-queued the job but not yet
> updated the saved virtual time.

I think I don't fully get the bug from that message. The bug (is it
even one?) you address is the performance bottleneck for CFS under high
load, right?

Anyways, I think I got a better idea:

>=20
> We do this by pulling the locked sections out to encompass both the queue
> push/pop and corresponding rbtree management.

So basically you move for locking the spsc-queue, the lockless queue
which is usually used with the locks next to it anyways. That's cool
stuff. I've suggested this for a while already

https://docs.kernel.org/gpu/todo.html#replace-the-lockless-queue-with-a-loc=
ked-list

So from a maintainability perspective, it would be far cooler if you go
down this road one step further and kill the spsc_queue for good,
replacing it with a fully locked list. AFAIR Christian and Danilo also
have agreed to this.


[=E2=80=A6]

> @@ -343,16 +340,17 @@ drm_sched_rq_next_rr_ts(struct drm_sched_rq *rq,
> =C2=A0 */
> =C2=A0void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
> =C2=A0{
> +	struct drm_sched_rq *rq =3D entity->rq;
> =C2=A0	struct drm_sched_job *next_job;
> -	struct drm_sched_rq *rq;
> +
> +	lockdep_assert_held(&entity->lock);

btw. I think it *reads* a bit safer if the rq initalization happens
below the lockdep assertion. Also might make the diff nicer.


P.
