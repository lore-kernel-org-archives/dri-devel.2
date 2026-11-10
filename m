Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44156606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N7UIT39r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A78210F80E;
	Tue, 10 Nov 2026 16:16:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE6A10F812
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:16:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E00861263;
 Tue, 10 Nov 2026 16:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0555B1F008A1;
 Tue, 10 Nov 2026 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794327383;
 bh=3T2kbAUXBwbt29KsBCsxXi3KcjD9bsW53VXLWeDkCjY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=N7UIT39r0+Hn5QxNoZJ/ZLG0AQqA76d4yw04krQ8go+S9qUN/pSVhp6Mrdq0bOmB+
 Q0qdUhM18a9hJ2d7L9PMR0JXjj7n0BA/aPmLva+jYOArMKoUGtJE2366ANu6Kcy2wz
 EbTIMHS/CmG3ui1hRkTgf8iMGOzbyNTiiX6cIu1lvvQaxB3Sj6DyTMmnd7dgYh0XHy
 X8LXkTm+4X6I30a5edI26GvFyYFSt4OLtVcRpnuDnFfUugrVae4rVYVWwfe/LZsVkB
 BqULzN0L0fUFGPg9kbrBe7u+/l/Tv5BKsy7tehzbpBMMTqMTwd3G4chqrBTSaXMzBt
 dXJALLjjn24rQ==
Message-ID: <sashiko-outbox-207350@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/28] drm/panthor: Handle partition control
 INVALID_COMMAND interrupt
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-21-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-21-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:16:22 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/panthor: unassigned current_aw in window_open() breaks
  recovery
- [Medium] drm/panthor: stale last_cmd on PART_STATE_RESET in
  yield/close helpers
--

commit 94f33b60c028012f4fc4c4edbb429977e08e2557
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Handle partition control INVALID_COMMAND interrupt

This commit tracks the last sent partition command and handles
PART_INVALID_COMMAND interrupts by retrying rejected commands or
requesting scheduler recovery when the partition is open for a different
access window.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_contro=
l.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
> index d8fdafbf31864..3b472403f49d1 100644
> --- a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
[ ... ]
> @@ -128,8 +158,8 @@ static int yield_now(struct panthor_partition_control=
 *pc)
>  	if (partition_state_get(pc) !=3D PART_STATE_WINDOW_OPEN)
>  		return -EAGAIN;
> =20
> -	gpu_write(pc->iomem, AM_PART_COMMAND,
> -		  AM_PART_SET_COMMAND(PART_CMD_YIELD_NOW));
> +	partition_command_write(pc, AM_PART_SET_COMMAND(PART_CMD_YIELD_NOW),
> +				pc->current_aw);
> =20
>  	return 0;
>  }
> @@ -144,8 +174,8 @@ static int yield_idle(struct panthor_partition_contro=
l *pc)
>  	if (partition_state_get(pc) !=3D PART_STATE_WINDOW_OPEN)
>  		return -EAGAIN;
> =20
> -	gpu_write(pc->iomem, AM_PART_COMMAND,
> -		  AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE));
> +	partition_command_write(pc, AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE),
> +				pc->current_aw);
> =20
>  	return 0;
>  }
> @@ -162,8 +192,8 @@ static int window_close(struct panthor_partition_cont=
rol *pc)
> =20
>  	pc->closing =3D true;
> =20
> -	gpu_write(pc->iomem, AM_PART_COMMAND,
> -		  AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW));
> +	partition_command_write(pc, AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW),
> +				pc->current_aw);
> =20
>  	return 0;
>  }

[Severity: Medium]
Can a stale PART_CMD_OPEN_WINDOW in pc->last_cmd reopen the partition
after yield_now(), yield_idle(), or window_close() has already returned 0?

window_open() writes PART_CMD_OPEN_WINDOW, stores it in pc->last_cmd, and
returns 0 without waiting for AM_PART_STATE to leave PART_STATE_RESET.  If
PART_CMD_OPEN_WINDOW is rejected while a previous reset is still finishing
(or before the hardware leaves PART_STATE_RESET) and the scheduler then
calls yield_now(), yield_idle(), or window_close(), those helpers see
partition_state_get(pc) =3D=3D PART_STATE_RESET and return 0 without cleari=
ng
pc->last_cmd or scheduling retry_work:

drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c:yield_now()=
 {
	guard(spinlock_irqsave)(&pc->lock);

	if (partition_state_get(pc) =3D=3D PART_STATE_RESET)
		return 0;

When partition_handle_invalid_cmd() later runs for the rejected open
command, pc->last_cmd.cmd is still PART_CMD_OPEN_WINDOW and the partition
is not in PART_STATE_WINDOW_OPEN, so it re-issues PART_CMD_OPEN_WINDOW and
opens the access window after the yield or close already succeeded.

> @@ -188,8 +218,8 @@ static int window_open(struct panthor_partition_contr=
ol *pc, u8 aw_id)
>  		return -EBUSY;
>  	}
> =20
> -	gpu_write(pc->iomem, AM_PART_COMMAND,
> -		  AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) | AM_PART_SET_WINDOW(aw_id=
));
> +	partition_command_write(pc, (AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) |
> +				     AM_PART_SET_WINDOW(aw_id)), aw_id);
> =20
>  	pc->current_aw =3D aw_id;
> =20
> @@ -201,10 +231,16 @@ static void partition_handle_reset_done(struct pant=
hor_partition_control *pc)
>  	bool notify_stopped =3D false;
>  	int aw_id;
> =20
> +	gpu_write(pc->iomem, AM_PART_IRQ_CLEAR, PART_RESET_DONE);
> +
>  	scoped_guard(spinlock_irqsave, &pc->lock) {
>  		aw_id =3D pc->current_aw;
>  		pc->current_aw =3D AW_UNASSIGNED;
> =20
> +		/* invalidate last command */
> +		pc->last_cmd.aw_id =3D AW_UNASSIGNED;
> +		pc->last_cmd.cmd =3D 0;
> +
>  		/* RESET_DONE from CLOSE_WINDOW */
>  		if (pc->closing)
>  			pc->closing =3D false;
> @@ -216,6 +252,55 @@ static void partition_handle_reset_done(struct panth=
or_partition_control *pc)
>  		panthor_arbitration_on_stopped(dev_get_drvdata(pc->dev), aw_id);
>  }
> =20
> +static void partition_handle_invalid_cmd(struct panthor_partition_contro=
l *pc)
> +{
> +	bool on_err =3D false;
> +	int aw_id;
> +
> +	gpu_write(pc->iomem, AM_PART_IRQ_CLEAR, PART_INVALID_COMMAND);
> +
> +	scoped_guard(spinlock_irqsave, &pc->lock) {
> +		if (!pc->last_cmd.cmd)
> +			return;
> +
> +		if (pc->last_cmd.aw_id < 0)
> +			return;

[Severity: Medium]
Does leaving pc->current_aw as AW_UNASSIGNED (-1) when window_open() finds
the partition in PART_STATE_WINDOW_OPEN prevent command retries and
scheduler recovery?

When window_open() sees PART_STATE_WINDOW_OPEN, it returns 0 (if
cur_aw =3D=3D aw_id) or -EBUSY (if cur_aw !=3D aw_id) before setting
pc->current_aw =3D aw_id:

drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c:window_open=
() {
	if (partition_state_get(pc) =3D=3D PART_STATE_WINDOW_OPEN) {
		u8 cur_aw =3D partition_aw_get(pc);

		if (cur_aw =3D=3D aw_id)
			return 0;

		dev_warn(pc->dev,
			 "%s: OPEN_WINDOW(%u): Already opened for aw=3D%u, state=3D%u. Closing..=
.",
			 pc->name, aw_id, cur_aw, partition_state_get(pc));

		return -EBUSY;
	}

On -EBUSY, arb_sched_grant_locked() queues sched->reset_work, which calls
arb_sched_force_close_locked() -> arb_sched_close_locked() ->
window_close().  Because pc->current_aw is still -1, window_close() (as
well as yield_now() and yield_idle() when cur_aw =3D=3D aw_id) records
pc->last_cmd.aw_id =3D -1.  If that command raises PART_INVALID_COMMAND,
partition_handle_invalid_cmd() aborts at pc->last_cmd.aw_id < 0 without
retrying it.  Furthermore, when PART_RESET_DONE later fires,
partition_handle_reset_done() sees aw_id < 0 and skips
panthor_arbitration_on_stopped(), leaving the scheduler stuck in
ARB_SCHED_PHASE_LOST.

In addition, panthor_partition_control_term() calls
partition_irq_suspend() before window_close() and partition_state_wait(),
which masks PART_INVALID_COMMAND so a rejected close command cannot be
retried during teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D20
