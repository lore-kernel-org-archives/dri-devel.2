Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA97EC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A2410E4E2;
	Mon, 28 Sep 2026 07:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="w3iHo66f";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629D010E4E2;
 Mon, 28 Sep 2026 07:49:55 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4htYPC5mnxz8vYJ;
 Mon, 28 Sep 2026 09:49:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790581791; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwLrqBaX4aJRrtH+q2H5It1KegUZ24HKRxI7RL2t1Hc=;
 b=w3iHo66fHMt5SZhAwf//dKVo3+gmT4kXJzlclg9W/dTvtYReUI+UEonCcDyBWwshRh1Y70
 IbVgOdcPIyWMFP6Qm7Ju7P02htjkxKOWpEXtGuXTpFLI3ODFyuKgDYyB+Frpl4u1e9tMZp
 Nn10mKDU9TZjDzc6Qo1WPaHzF5lO5YiJz8ZUDrg5cDD3J21XD7W1E3S19YmiMbfUU2btxf
 I+WDwdWLiWbrPOHnnZvwuqFu4FspZ7S3yXjHiZwEh1DasZ16d/FcR3jp57EM5+Ldtr02d8
 9i9qDHdhXPzIsq9MBZQiIYl/ljsBYfW9pxtPKR9Ri0d/z0mZI91K4b5drm1DTw==
Message-ID: <138ead6cd35ee60645206c17b35069551de103f0.camel@mailbox.org>
Subject: Re: [PATCH 1/2] drm/sched: keep the current runqueue when no
 scheduler is ready
From: Philipp Stanner <phasta@mailbox.org>
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Matthew Brost
 <matthew.brost@intel.com>, Danilo Krummrich	 <dakr@kernel.org>, Philipp
 Stanner <phasta@kernel.org>
Date: Mon, 28 Sep 2026 09:49:47 +0200
In-Reply-To: <20260928020018.120503-1-vitaly.prosyak@amd.com>
References: <20260928020018.120503-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 3urdfth9bpgw6g4wt583ts8a56staepa
X-MBO-RS-ID: 3bc95865c4ac5480736
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

On Sun, 2026-09-27 at 21:59 -0400, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>=20
> The IGT amd_dispatch test exposed a NULL pointer dereference in the
> AMDGPU CS submission path when the GPU schedulers were not ready.
>=20
> drm_sched_pick_best() returns NULL when every scheduler in an entity's
> list is marked not ready. drm_sched_entity_select_rq() then replaces
> the entity's existing runqueue with NULL.
>=20
> A subsequent drm_sched_job_arm() retains that invalid runqueue.
> When AMDGPU CS submission calls drm_sched_entity_push_job(), the
> scheduler pointer derived from entity->rq is invalid and the access
> to sched->score faults. The reported oops shows the sequence:
>=20
> =C2=A0=C2=A0=C2=A0 [drm] scheduler comp_1.1.0 is not ready, skipping
> =C2=A0=C2=A0=C2=A0 [drm] scheduler comp_1.2.0 is not ready, skipping
> =C2=A0=C2=A0=C2=A0 BUG: kernel NULL pointer dereference, address: 0000000=
000000268
> =C2=A0=C2=A0=C2=A0 RIP: drm_sched_entity_push_job+0x4f/0x2b0 [gpu_sched]

That seems to be the issue that the LLM was hinting at a few weeks ago:

https://lore.kernel.org/dri-devel/20260625121102.3AB3A1F000E9@smtp.kernel.o=
rg/



> =C2=A0=C2=A0=C2=A0 Call Trace:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_cs_ioctl+0x1e9e/0x2530 [amdgpu]
>=20
> Keep the previously selected runqueue when no ready replacement is
> found. This prevents scheduler selection from turning a valid entity
> runqueue into NULL; it does not make a stopped scheduler ready or
> guarantee that the submitted job will execute.
>=20
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Philipp Stanner <phasta@kernel.org>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 4ebb513255ed..b11e1dddabd0 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -584,8 +584,8 @@ void drm_sched_entity_select_rq(struct drm_sched_enti=
ty *entity)
> =C2=A0
> =C2=A0	spin_lock(&entity->lock);
> =C2=A0	sched =3D drm_sched_pick_best(entity->sched_list, entity->num_sche=
d_list);
> -	rq =3D sched ? &sched->rq : NULL;
> -	if (rq !=3D entity->rq) {
> +	if (sched && &sched->rq !=3D entity->rq) {
> +		rq =3D &sched->rq;


I'm not sure if either explicit or implicit "fix" within drm_sched
would solve the issue at hand, because the entire "ready" state
tracking is actually a responsibility of the driver =E2=80=93 AFAIK its
existence has to do with AMD GPUs' ring resetting? I had a conversation
with Christian about that a while ago; I think we agree that that flag
should be carried by the driver in its own data structure.

Does amdgpu still modify sched->ready without going through a drm_sched
API? A first grep hints at about ~135 places where this might be the
case.

What I'm especially wondering about is whether different threads
participate in handling that state; dealing with the flag is in no way
synchronized in drm_sched_init() and drm_sched_fini(). If yes, the
proposed fix would likely still be UB.


So since this patch seems to stem from a broken test, not an actual bug
at a customer, my hope would be that we have some time to fix it and
that AMD, thus, can help with reducing drm_sched's tech debt by
removing that flag and have amdgpu invoke the scheduler API in the
correct order.


Thx
P.
