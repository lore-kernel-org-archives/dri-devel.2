Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A71606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUH9bsd4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7A510E48E;
	Tue, 10 Nov 2026 16:15:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7969E10F809
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:15:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A32E633D2;
 Tue, 10 Nov 2026 16:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119751F0089F;
 Tue, 10 Nov 2026 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794327332;
 bh=Hpij1J5z8i+Ya85H6nRzIULrPiQ6sCD0zxbt1BX/ECs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=FUH9bsd4h5XwfX/G9wwktFqVV7a5jb0fGMDjs4BPl+9INleXiIFWNmMaIkufW3eqz
 C9zcNIK9muQpoTbJtA1xdI7WePc25X8Li5+djayT83ToVZOp7ZIyIqO6ilPJeoC38Q
 JfuBbw90S22zJu3KkS6pa4lhAYwoQOyTvgCJMPcldw3kuPJz4kt257s8BT+KJG0tXQ
 6r3mvvqHrsvBhTSc5YRcMSzij+8BAyO1cqMja4Z0sGRU0FcyFv8sRKVEP2HyuQEfu4
 zYNNl5nxVCf8Kiq+vop7dUEGMb/FJURU4AzwDzjsE+q1xjue3/vukzFqVvx58ovZsM
 kThHL2jR/N+8g==
Message-ID: <sashiko-outbox-207348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/28] drm/panthor: Request AW to yield GPU access on
 idle
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-22-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-22-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:15:31 +0000
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
- [Medium] drm/panthor: dropped YIELD_IDLE command in
  arb_sched_next_locked()
- [Medium] drm/panthor: dropped GPU_REQUEST in
  panthor_arbitration_sched_on_request()
--

commit f99f87c6e1d4cdf3c37b5e1e28569f0fc943d72a
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Request AW to yield GPU access on idle

This commit sends a YIELD_IDLE notification to the active access window
when other access windows are waiting in the arbitration scheduler queue
or when a second access window requests GPU access.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sche=
d.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
> index 16bd0fac2514e..f137b73deaa32 100644
> --- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
[ ... ]
> @@ -382,6 +394,10 @@ static int arb_sched_next_locked(struct panthor_arbi=
tration_sched *sched)
> =20
>  	arb_sched_grant_locked(sched);
> =20
> +	if (sched->phase =3D=3D ARB_SCHED_PHASE_GRANTED &&
> +	    !kfifo_is_empty(&sched->queue))
> +		arb_sched_yield_idle_locked(sched);
> +
>  	wake_up_all(&sched->waitqueue);
> =20
>  	return 0;

[Severity: Medium]
Can arb_sched_yield_idle_locked() silently drop the YIELD_IDLE command
when called immediately after arb_sched_grant_locked()?

arb_sched_grant_locked() calls window_open(), which writes
PART_CMD_OPEN_WINDOW to AM_PART_COMMAND and returns 0 without waiting for
AM_PART_STATE to leave PART_STATE_RESET.  When arb_sched_yield_idle_locked()
then calls yield_idle(), AM_PART_STATE can still read as PART_STATE_RESET:

drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c:yield_idle(=
) {
	guard(spinlock_irqsave)(&pc->lock);

	if (partition_state_get(pc) =3D=3D PART_STATE_RESET)
		return 0;

	if (partition_state_get(pc) !=3D PART_STATE_WINDOW_OPEN)
		return -EAGAIN;
    ...
}

Because yield_idle() returns 0 instead of -EAGAIN in PART_STATE_RESET,
arb_sched_yield_idle_locked() does not queue PANTHOR_ARB_WORK_YIELD_IDLE,
and the active access window holds the GPU even while idle until
grant_timer expires.

[ ... ]

> @@ -551,8 +573,18 @@ int panthor_arbitration_sched_on_request(struct pant=
hor_arbitration_sched *sched
>  	 * Grant timer for the current AW has previously expired, request it to
>  	 * yield the GPU.
>  	 */
> -	if (sched->grant_previously_expired)
> +	if (sched->grant_previously_expired) {
>  		arb_sched_request_stop_locked(sched);
> +		return 0;
> +	}
> +
> +	/*
> +	 * GPU was previously granted to a lone requesting AW, YIELD_IDLE was
> +	 * not sent to it. Send YIELD_IDLE to it now that multiple AWs are
> +	 * requesting for the GPU.
> +	 */
> +	if (sched->phase =3D=3D ARB_SCHED_PHASE_GRANTED && kfifo_len(&sched->qu=
eue) =3D=3D 1)
> +		arb_sched_yield_idle_locked(sched);
> =20
>  	return 0;
>  }

[Severity: Medium]
Will panthor_arbitration_sched_on_request() drop a new GPU_REQUEST from an
access window that just yielded due to YIELD_IDLE?

Unlike arb_sched_request_stop_locked(), which sets sched->phase to
ARB_SCHED_PHASE_STOPPING before sending PART_CMD_YIELD_NOW, sending
PART_CMD_YIELD_IDLE leaves sched->phase as ARB_SCHED_PHASE_GRANTED.  When
the active access window yields on idle, it receives
WINDOW_IRQ_WINDOW_CLOSED and can issue a new VM_ARB_GPU_REQUEST before the
partition control IRQ processes PART_RESET_DONE and calls
panthor_arbitration_on_stopped():

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

Because sched->active_aw_id is still aw_id and sched->phase is still
ARB_SCHED_PHASE_GRANTED, panthor_arbitration_sched_on_request() rejects
the request with -EEXIST, leaving the access window to time out in
panthor_aw_request().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D21
