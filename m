Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F25C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DEA110F577;
	Fri, 11 Sep 2026 11:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cTcOLGBp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EEC110F577
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:57:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1D516025A;
 Fri, 11 Sep 2026 11:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C8D1F00893;
 Fri, 11 Sep 2026 11:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789127820;
 bh=dapLyV/wy16E+IkudvQvA0jPFtOt9Ql3qPcG4vzgAV0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cTcOLGBpK93fVb6QqMQF42Laz4L8H/SpdKbja883Y2xj8Tar8WEDT88IXqVJYEhnV
 wKND3Ch3j6zOujq1w1jUUW27XCxELlcEF24xN2Ue3AG4Ghy+dX7S7BOFEs2f0cQPHo
 761sHnZuTBCBlYTiJzBSolS4Gv99QcwQweUAg4UEHO/X5YyuKB7lmAi+jFrNMJmqYC
 cxtorV6F8ANIOyR4e4eG2WHpH/NOjZmw1QMrsbOJ4jWADuwiwWiQR7Di9jN8/ACwzU
 DJ6OiML+9iHxDFz62SMXVS7LmlNQL7bzIpN+Q3kmZd+OlnsOjt1cfbmr5Pc9wMY+E4
 Um0Uj5lKbv70Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] drm/panthor: Add support for entering and
 exiting protected mode
To: "Ketil Johnsen" <ketil.johnsen@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911114014.79139-6-ketil.johnsen@arm.com>
References: <20260911114014.79139-1-ketil.johnsen@arm.com>
 <20260911114014.79139-6-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:56:59 +0000
Message-Id: <20260911115700.59C8D1F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Polling for protected mode entry using `wait_event_timeout` withou=
t a wakeup source will unconditionally sleep for the full 500ms timeout.
- [High] Acknowledging a pending protected mode event during a slot reset d=
oes not clear the corresponding software state, causing a permanent malfunc=
tion for the group.
- [High] TOCTOU race in `panthor_gpu_protm_fault_pending` leads to missed f=
aults and an infinite reset loop.
--

commit 134f4af77e10adece5a3a20d7839a25e0c7a720d
Author: Florent Tomasin <florent.tomasin@arm.com>

drm/panthor: Add support for entering and exiting protected mode

This commit modifies the Panthor driver to handle GPU hardware protected mo=
de
enter and exit operations. It introduces the mechanisms needed for entering
and exiting protected mode, handling protected mode IRQs, scheduling
modifications, and GPU fault handling during protected execution.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 5f9f7a92c56a8..96770ce34da84 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
[ ... ]
> @@ -1476,6 +1481,91 @@ static void panthor_fw_ping_work(struct work_struc=
t *work)
>  	}
>  }
> =20
> +static bool wait_protm_enter(struct panthor_device *ptdev,
> +			     long long enter_count)
> +{
> +	return (panthor_gpu_status(ptdev) & GPU_STATUS_PROTM_ACTIVE) ||
> +	       (atomic64_read(&ptdev->protm.protm_exit_count) >=3D enter_count);
> +}
> +
> +int panthor_fw_protm_enter(struct panthor_device *ptdev)
> +{
[ ... ]
> +	/* Poll for the entry of protected mode.
> +	 * It is possible that GPU_STATUS_PROTM_ACTIVE is set and cleared
> +	 * before we check it below, so we must also check for GLB_PROTM_EXIT.
> +	 * GLB_PROTM_EXIT can not be checked directly, because this could also
> +	 * be handled and clear before we check below. We count number of
> +	 * protm enters and exits to safely handle that case.
> +	 */
> +	ret =3D wait_event_timeout(ptdev->fw->req_waitqueue,
> +				 wait_protm_enter(ptdev, enter_count),
> +				 msecs_to_jiffies(500));

[Severity: High]
Since GPU_STATUS_PROTM_ACTIVE is a hardware status bit and does not trigger=
 a=20
new interrupt when it becomes true, wouldn't this wait queue never be woken=
=20
up? If the bit isn't set immediately on the first check in wait_protm_enter=
(),=20
it seems like this will unconditionally sleep for the full 500ms duration=20
before returning success, causing a half-second delay every time the GPU=20
enters protected mode.

> +	if (!ret) {
> +		drm_err(&ptdev->base,
> +			"Wait for GPU protected mode enter timed out");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}

> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/pant=
hor/panthor_gpu.c
> index a383b04f101ed..27617f3a72394 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
[ ... ]
> @@ -123,6 +152,13 @@ static irqreturn_t panthor_gpu_irq_threaded_handler(=
int irq, void *data)
>  	return panthor_irq_default_threaded_handler(data, panthor_gpu_irq_handl=
er);
>  }
> =20
> +bool panthor_gpu_protm_fault_pending(struct panthor_device *ptdev)
> +{
> +	return atomic_read(&ptdev->gpu->protm_fault) ||
> +	       gpu_read(ptdev->gpu->irq.iomem, INT_RAWSTAT) &
> +		       GPU_IRQ_PROTM_FAULT;
> +}

[Severity: High]
Could there be a race condition here due to the short-circuit evaluation?

If CPU 0 evaluates the left side and reads the software flag=20
ptdev->gpu->protm_fault as 0, and is then preempted, CPU 1 could execute th=
e=20
interrupt handler, set the software flag to 1, and clear the hardware=20
register.=20

When CPU 0 resumes to evaluate the right side, it would read the hardware=20
register as 0 and return false. This would cause the fault to be missed=20
entirely (e.g., in sched_process_protm_exit_event_locked()), potentially=20
allowing a faulty protected mode group to restart and trigger an infinite=20
reset loop.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 0c8ea07fc7b9d..1fe77e5c41995 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
[ ... ]
> @@ -1149,12 +1170,14 @@ cs_slot_reset_locked(struct panthor_device *ptdev=
, u32 csg_id, u32 cs_id)
>  	struct panthor_fw_cs_iface *cs_iface =3D panthor_fw_get_cs_iface(ptdev,=
 csg_id, cs_id);
>  	struct panthor_group *group =3D ptdev->scheduler->csg_slots[csg_id].gro=
up;
>  	struct panthor_queue *queue =3D group->queues[cs_id];
> +	u32 val, mask;
> =20
>  	lockdep_assert_held(&ptdev->scheduler->lock);
> =20
> -	panthor_fw_update_reqs(cs_iface, req,
> -			       CS_STATE_STOP,
> -			       CS_STATE_MASK);
> +	val =3D CS_STATE_STOP | (cs_iface->output->ack & CS_PROTM_PENDING);
> +	mask =3D CS_STATE_MASK | CS_PROTM_PENDING;
> +
> +	panthor_fw_update_reqs(cs_iface, req, val, mask);

[Severity: High]
When acknowledging the pending CS_PROTM_PENDING hardware event here during =
a=20
slot reset, the software state group->protm_pending_queues is not cleared.

Later, tick_ctx_handle_protm_group() only clears bits from=20
group->protm_pending_queues if the hardware event is still pending via=20
(ack ^ req) & CS_PROTM_PENDING. Since the hardware event was already cleare=
d=20
here, will the software bit remain permanently set, causing the group to=20
perpetually request entry into protected mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911114014.7913=
9-1-ketil.johnsen@arm.com?part=3D5
