Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECB1CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DDB810E959;
	Tue, 23 Jun 2026 13:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jzyhj9vL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB2410EB3C
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:04:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7CED60052;
 Tue, 23 Jun 2026 13:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390121F00A3F;
 Tue, 23 Jun 2026 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782219847;
 bh=k1WnDtd59Ay5eOWsKjxu9G8YFy8ns5DicebJB6WfqJ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jzyhj9vLEscrlfGFygV5cFi9r/IaIoVVvohJmsZTIPaFZnyrQnp5fEc7/ufuRFczV
 /rH1VxkYBBhaUnYKzMmxT6ZFX4F5bzJXYQ3CAsvW1t8NjpNA4DH5A5U5mCm+BpdG8d
 9BNmySYG06CPxmFT/jm+vsVMqpx4bu198ehidVGiohPFgjOnK7qoeRfe5CjVDWkLfS
 y1vxP+Mh2W36m3VAciiWrsqpODLGwEmTITv1M6GYShSoo3uDorcno6jfd4e+8MU4ih
 2WPXVo8TnAHBn0cm+R6SZS8xh7e1kJLrgEp9V4kJ+zAdXge8zgRjQT+A7u53SEKKRZ
 q4+lS5ZoBnBCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] drm/panthor: Automate CSG IRQ processing at
 group unbind time
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623-panthor-signal-from-irq-v3-7-2ece396f8ee0@collabora.com>
References: <20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com>
 <20260623-panthor-signal-from-irq-v3-7-2ece396f8ee0@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 13:04:06 +0000
Message-Id: <20260623130407.390121F00A3F@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Leaking `panthor_group` reference count when `tiler_oom_work` is s=
uccessfully cancelled during group unbind.
- [High] Ignored return value from `group_bind_locked()` in `tick_ctx_apply=
()` can lead to firmware state corruption and hardware hangs.
--

commit 3008df4d374d0ccc21ff32d8af0ae14af924b9fd
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Automate CSG IRQ processing at group unbind time

This commit moves the sched_process_csg_irq_locked() call into
group_unbind_locked() to automate CSG IRQ processing at group unbind time.
This eliminates the need to manually call it in tick_ctx_apply() and
panthor_sched_suspend(). The patch also relocates group_bind_locked() and
group_unbind_locked() to avoid forward declarations.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index c8818718d1353..124999297aec9 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c

[ ... ]

> @@ -1972,6 +1892,88 @@ void panthor_sched_report_fw_events(struct panthor=
_device *ptdev, u32 events)
>  	}
>  }
> =20
> +/**
> + * group_bind_locked() - Bind a group to a group slot
> + * @group: Group.
> + * @csg_id: Slot.
> + *
> + * Return: 0 on success, a negative error code otherwise.
> + */
> +static int
> +group_bind_locked(struct panthor_group *group, u32 csg_id)

[Severity: High]
This isn't a bug introduced by this patch, but could ignoring the return
value of group_bind_locked() in tick_ctx_apply() lead to firmware state
corruption?

If group_bind_locked() fails (e.g., panthor_vm_active() encounters an MMU
timeout), the error is ignored and csg_slot->group remains NULL.=20

This causes csg_slot_prog_locked() to return immediately without configuring
the hardware. However, tick_ctx_apply() then unconditionally queues a
CSG_STATE_START or CSG_STATE_RESUME command to the firmware for this slot,
despite it being unprogrammed.=20

Can this trigger firmware faults or hardware hangs?

> +{
> +	struct panthor_device *ptdev =3D group->ptdev;
> +	int ret;
> +

[ ... ]

> +static int
> +group_unbind_locked(struct panthor_group *group)
> +{
> +	struct panthor_device *ptdev =3D group->ptdev;
> +

[ ... ]

> +	panthor_vm_idle(group->vm);
> +
> +	/* Tiler OOM events will be re-issued next time the group is scheduled.=
 */
> +	atomic_set(&group->tiler_oom, 0);
> +	cancel_work(&group->tiler_oom_work);

[Severity: High]
This is a pre-existing issue, but does this leak the group reference if
cancel_work() returns true?=20

When a tiler out-of-memory (OOM) event occurs,=20
cs_slot_process_tiler_oom_event_locked() acquires a reference to the group
and queues tiler_oom_work.=20

If the group is unbound before the work executes, group_unbind_locked()
calls cancel_work(&group->tiler_oom_work). Because cancel_work() removes
the pending work from the queue without executing the work function, the
delegated group_put() is skipped.=20

Should we check the return value of cancel_work() and call group_put(group)
if it returns true?

> +
> +	for (u32 i =3D 0; i < group->queue_count; i++)
> +		group->queues[i]->doorbell_id =3D -1;
> +
> +	group_put(group);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623-panthor-si=
gnal-from-irq-v3-0-2ece396f8ee0@collabora.com?part=3D7
