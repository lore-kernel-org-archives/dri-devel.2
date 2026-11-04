Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30969606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+3dZGxZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EBF010E578;
	Wed,  4 Nov 2026 08:13:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A89CA10E578
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 08:13:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE864602D3;
 Wed,  4 Nov 2026 08:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C831F000C1;
 Wed,  4 Nov 2026 08:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793780012;
 bh=VqVsVFEBqggH/o3NeIkDI7WtIeW6YziOCnj+qR2Bets=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d+3dZGxZm/4+QuULnwsySGq5TAnYHuIQhDyWXfftOKfW39XNtgFcILo8lD+N61SwU
 5tAwZ2C7iMfFSR9xoJZV/tq4J2uFcjsqs/39N7ILyPFYEzbupG9GSkH0tL0vLMX8h2
 rnEisk6nsYm/fnUnqT5GtuP5uN+5Grg7ZAeO8cabEmxkdNcNm0QEtyz4QpVRmtOu/7
 fVsuY/aG0eXvJyGaI3JvjPT/3YbJJJrqp08XphXrbr7zSjNAobwu1Guad065lVpsOF
 hFyllkHZ6rkW1optSyjN8HIrJJWeRBomkH7u1pKMSCz0KldmsDvS03QeLQWOrhYvDU
 k2XSqGyuzEA1Q==
Message-ID: <sashiko-outbox-196864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/panthor: Report the CS fatal errors through
 GROUP_GET_STATE
To: "Christian Gmeiner" <christian.gmeiner@gmail.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261104-panthor-fault-info-v2-v2-2-673b31f3840c@igalia.com>
References: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
 <20261104-panthor-fault-info-v2-v2-2-673b31f3840c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 08:13:31 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/panthor: race reading fatal_queues in panthor_group_get_stat=
e()
--

commit 8ad04a984a0eee7e92a001d9035eba4354298f3e
Author: Christian Gmeiner <cgmeiner@igalia.com>

drm/panthor: Report the CS fatal errors through GROUP_GET_STATE

This commit stores the raw CS_FATAL and CS_FATAL_INFO values in the
panthor_queue that hit a fatal error and exposes them to userspace via
an array in DRM_IOCTL_PANTHOR_GROUP_GET_STATE.

Link: https://lore.kernel.org/r/20251215115457.2137485-3-lukas.zapolskas@ar=
m.com
Link: https://lore.kernel.org/r/20251215115457.2137485-6-lukas.zapolskas@ar=
m.com

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index a343c5180e01e..40400b2e45518 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c

[ ... ]

> @@ -1412,10 +1421,20 @@ cs_slot_process_fatal_event_locked(struct panthor=
_device *ptdev,
>  	info =3D cs_iface->output->fatal_info;
> =20
>  	if (group) {
> +		struct panthor_queue *queue =3D cs_id < group->queue_count ?
> +					      group->queues[cs_id] : NULL;
> +
>  		drm_warn(&ptdev->base, "CS_FATAL: pid=3D%d, comm=3D%s\n",
>  			 group->task_info.pid, group->task_info.comm);
> =20
>  		atomic_or(BIT(cs_id), &group->fatal_queues);
> +
> +		if (queue) {
> +			queue->fatal =3D (struct drm_panthor_queue_fatal){
> +				.exception =3D fatal,
> +				.exception_info =3D info,
> +			};
> +		}
>  	}

[ ... ]

> @@ -3844,6 +3869,11 @@ int panthor_group_get_state(struct panthor_file *p=
file,
> =20
>  	if (group->innocent)
>  		get_state->state |=3D DRM_PANTHOR_GROUP_STATE_INNOCENT;
> +
> +	scoped_guard(spinlock, &sched->events_lock) {
> +		for (u32 i =3D 0; i < *fatal_count; i++)
> +			fatals[i] =3D group->queues[i]->fatal;
> +	}
>  	mutex_unlock(&sched->lock);

[Severity: Medium]
Can panthor_group_get_state() return an inconsistent snapshot to userspace
when racing with a CS_FATAL interrupt?

In the threaded interrupt path, panthor_job_irq_threaded_handler() ->
panthor_job_irq_handler() -> panthor_sched_report_fw_events() ->
sched_process_csg_irq_locked() -> cs_slot_process_fatal_event_locked() runs
under sched->events_lock without holding sched->lock, updating both
group->fatal_queues and queue->fatal.

Meanwhile, panthor_group_get_state() reads group->fatal_queues before taking
sched->events_lock:

drivers/gpu/drm/panthor/panthor_sched.c:panthor_group_get_state() {
	...
	mutex_lock(&sched->lock);
	if (atomic_read(&group->timedout))
		get_state->state |=3D DRM_PANTHOR_GROUP_STATE_TIMEDOUT;

	get_state->fatal_queues =3D atomic_read(&group->fatal_queues);
	if (get_state->fatal_queues)
		get_state->state |=3D DRM_PANTHOR_GROUP_STATE_FATAL_FAULT;

	if (group->innocent)
		get_state->state |=3D DRM_PANTHOR_GROUP_STATE_INNOCENT;

	scoped_guard(spinlock, &sched->events_lock) {
		for (u32 i =3D 0; i < *fatal_count; i++)
			fatals[i] =3D group->queues[i]->fatal;
	}
	...
}

If cs_slot_process_fatal_event_locked() runs on another CPU after
atomic_read(&group->fatal_queues) but before sched->events_lock is acquired,
get_state->fatal_queues and DRM_PANTHOR_GROUP_STATE_FATAL_FAULT will remain
unset while fatals[cs_id].exception contains a non-zero CS_FATAL value.

Should group->fatal_queues be read inside the sched->events_lock critical
section alongside group->queues[i]->fatal so that fatal_queues, state, and
fatals[] are consistent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-panthor-fa=
ult-info-v2-v2-0-673b31f3840c@igalia.com?part=3D2
