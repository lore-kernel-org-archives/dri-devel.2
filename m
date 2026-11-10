Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5F606A323
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7NJazhC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E5810E03B;
	Tue, 10 Nov 2026 16:19:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC3310E063
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:19:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 10183636D1;
 Tue, 10 Nov 2026 16:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941331F008A3;
 Tue, 10 Nov 2026 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794327590;
 bh=VtSRyp46rpa6noOezBu2lY6ft+nUoeFffYOoVEJO1CY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=J7NJazhCNYLqM7Awzj7Xr598wek6/e65RJUZU9fzsqpgNtpk+A2BtNArHWk2i4S2j
 5RWGUdwRfeGqEXpumhELs2Pt0yS5/etojmP8ANVYmVffTc1EryeFZ0gR9qx5hRT7Jl
 tQHKLm5w5JmIaARed7mzP9/1fLqv7TWE6AQNXErHtd7yzdPT3ItbeObCHk0Gt6PFjH
 G5R0wxk/36z1K9/RHqs1CgTW+IF9wPjj/oxvK+DWWoF7w79llZUHpTXe88R1iPFyAA
 wnc7DRkW18Xt36Yhj5+4gwTpPxVxsD2+0E1Ty4KftOjom5gr3ZVoIEkdrF4BUQtAME
 jCLw2RL9HEazA==
Message-ID: <sashiko-outbox-207354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/28] drm/panthor: Route arbitration events
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-19-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-19-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:19:50 +0000
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
- [High] drm/panthor: unhandled RESET and current_aw states wedge
  arbitration
- [Medium] drm/panthor: dropped GPU_REQUEST in
  panthor_arbitration_sched_on_request()
--

commit 48a85078af75aa6fff27b7d739d44d8c4f545271
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Route arbitration events

This commit wires arbitration events between resource-group message handlin=
g,
the arbitration scheduler, and partition control.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_contro=
l.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
> index 330d0bf5fd375..d8fdafbf31864 100644
> --- a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
> @@ -198,13 +198,22 @@ static int window_open(struct panthor_partition_con=
trol *pc, u8 aw_id)
> =20
>  static void partition_handle_reset_done(struct panthor_partition_control=
 *pc)
>  {
> +	bool notify_stopped =3D false;
> +	int aw_id;
> +
>  	scoped_guard(spinlock_irqsave, &pc->lock) {
> +		aw_id =3D pc->current_aw;
>  		pc->current_aw =3D AW_UNASSIGNED;
> =20
>  		/* RESET_DONE from CLOSE_WINDOW */
>  		if (pc->closing)
>  			pc->closing =3D false;
> +		if (aw_id >=3D 0)
> +			notify_stopped =3D true;
>  	}
> +
> +	if (notify_stopped)
> +		panthor_arbitration_on_stopped(dev_get_drvdata(pc->dev), aw_id);
>  }

[Severity: High]
Can relying solely on partition_handle_reset_done() with pc->current_aw >=
=3D 0
drop partition commands or wedge the arbitration scheduler in an infinite
close loop?

First, window_open() performs a posted write of PART_CMD_OPEN_WINDOW, sets
pc->current_aw =3D aw_id, and returns 0 before AM_PART_STATE leaves
PART_STATE_RESET. If the scheduler immediately follows up with a stop,
yield, or close command (for example when sched->disabled is set in
arb_sched_grant_locked(), or when another request is queued), yield_now()
and window_close() see partition_state_get(pc) =3D=3D PART_STATE_RESET and
return 0 without issuing a command or returning -EAGAIN:

drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c:window_clos=
e() {
	...
	if (partition_state_get(pc) =3D=3D PART_STATE_RESET)
		return 0;

	if (partition_state_get(pc) !=3D PART_STATE_WINDOW_OPEN)
		return -EAGAIN;
	...
}

Because 0 is returned while pc->current_aw >=3D 0, the command is silently
dropped instead of being retried once the window finishes opening.

Second, if partition_state_get(pc) is already PART_STATE_WINDOW_OPEN on
entry to window_open(), it returns 0 (when cur_aw =3D=3D aw_id) or -EBUSY (=
which
triggers reset_work -> arb_sched_force_close_locked()) before setting
pc->current_aw =3D aw_id. When PART_RESET_DONE later fires, pc->current_aw =
is
still AW_UNASSIGNED, so partition_handle_reset_done() skips
panthor_arbitration_on_stopped().

Third, whenever the hardware partition is already in PART_STATE_RESET while
sched->active_aw_id >=3D 0 (such as after a skipped
panthor_arbitration_on_stopped() notification), arb_sched_close_locked()
calls window_close(), gets 0 back without any PART_CMD_CLOSE_WINDOW or
stopped notification, and starts close_timer. When close_timer expires,
reset_work calls arb_sched_force_close_locked() -> arb_sched_close_locked(),
repeating indefinitely and wedging GPU scheduling across all access windows.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c=
 b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
> index e413cfd9e6d25..26b22461f6d39 100644
> --- a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
> @@ -163,10 +163,10 @@ static void rg_handle_message(struct panthor_resour=
ce_group *rg, u8 aw_id,
> =20
>  	switch (msg_id) {
>  	case VM_ARB_GPU_REQUEST:
> -		/* TODO: on_request */
> +		panthor_arbitration_on_request(dev_get_drvdata(rg->dev), aw_id);
>  		break;
>  	case VM_ARB_GPU_STOPPED:
> -		/* TODO: on_idle */
> +		panthor_arbitration_on_idle(dev_get_drvdata(rg->dev), aw_id);
>  		break;

[Severity: Medium]
Can a VM_ARB_GPU_REQUEST sent right after VM_ARB_GPU_STOPPED be rejected
with -EEXIST and lost while the partition is still closing?

Receiving VM_ARB_GPU_STOPPED calls panthor_arbitration_sched_on_idle(),
which sets sched->phase =3D ARB_SCHED_PHASE_CLOSING and starts an asynchron=
ous
PART_CMD_CLOSE_WINDOW while keeping sched->active_aw_id =3D=3D aw_id until
PART_RESET_DONE fires on the partition control IRQ. Because the access
window receives WINDOW_IRQ_WINDOW_CLOSED as soon as the window closes (prior
to PART_RESET_DONE) and the resource group and partition control use
separate interrupts, the access window can send a new VM_ARB_GPU_REQUEST
while sched->phase is still ARB_SCHED_PHASE_CLOSING.

In panthor_arbitration_sched_on_request(), only ARB_SCHED_PHASE_STOPPING is
exempted when checking whether the active access window may re-queue itself:

drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c:panthor_arb=
itration_sched_on_request() {
	...
	if (test_bit(aw_id, sched->queued_mask) ||
	    (sched->active_aw_id =3D=3D aw_id &&
	     sched->phase !=3D ARB_SCHED_PHASE_STOPPING)) {
		dev_warn(sched->dev, "%s: AW%u already in request queue.",
			 sched->name, aw_id);
		return -EEXIST;
	}
	...
}

The new request is dropped, and once PART_RESET_DONE completes, the
scheduler becomes idle without granting the GPU back to the access window,
stalling it until its request timeout expires. Allowing re-queuing when
sched->phase =3D=3D ARB_SCHED_PHASE_CLOSING as well would avoid dropping the
request.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D18
