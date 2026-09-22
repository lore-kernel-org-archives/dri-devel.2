Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0D3C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5264910EE7A;
	Tue, 22 Sep 2026 21:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DABmffY9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B8D10EE7A
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:04:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 653F8600D4;
 Tue, 22 Sep 2026 21:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61DD1F000FF;
 Tue, 22 Sep 2026 21:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790111086;
 bh=4qjio8t4ZeORSt+TO3DY4G05lf8U5r3H/7SmVm1chyI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DABmffY9sMkTxdpFYUBOBmhdfUcAvrAmsbzWppeb3Ft2dKV8aFcihrM6XXYGxibpk
 /TH694m8ooVisoq28KXl/1/Bf9Jk9syP2TAeS5eIPVdnflMRsoE2suvOr1G6Y+InaZ
 eXbWwpnMMd4MyI0ORzkDeBHUv8l+dAFnZkFeVQOFMdcSlxFSmYLsB6yVi1pcWeFJFC
 s5iF/F6GMl/eQii05lxrLVcyVLjaPW7swEO2xRYXXCTlkwh0GsU0x+uNxkjmMiYWSK
 VFT22kMrelyBaNpZjwDQQTZ0aBqWeCqi3ZA/JtLvupGr9z7yfIzjyO54c/CmF1FkeM
 tuEcF0aN5kVXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 20/27] drm/panthor: Handle partition control
 INVALID_COMMAND interrupt
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-21-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-21-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:04:45 +0000
Message-Id: <20260922210445.E61DD1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/panthor: stale pc->last_cmd state from untracked yield_idle() =
causes spurious command handling
- [High] drm/panthor: synchronous state evaluation in INVALID_COMMAND handl=
er races with hardware transitions
- [High] drm/panthor: lockless state check in window_close() causes permane=
ntly leaked windows
- [High] drm/panthor: overwriting pc->current_aw before CLOSE_WINDOW comple=
tes breaks state machine
--

commit 137cc070e4a25e7d342b37a597b27e601b15068c
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Handle partition control INVALID_COMMAND interrupt

This commit introduces handling for INVALID_COMMAND interrupts when partiti=
on
state requirements are not met. It retries commands when the partition state
permits, or requests scheduler recovery for open-window commands with
inconsistent assignments.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_contro=
l.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
> index 95c26015cb637..446f77fc67891 100644
> --- a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
[ ... ]
> @@ -101,18 +114,45 @@ static int partition_state_wait(struct panthor_part=
ition_control *pc, u32 state)
[ ... ]
>  static int yield_idle(struct panthor_partition_control *pc)
>  {
> -	gpu_write(pc->iomem, AM_PART_COMMAND,
> -		  AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE));
> +	guard(spinlock_irqsave)(&pc->lock);
> +
> +	/*
> +	 * This is a notification to yield the GPU once FW is idle. It is not
> +	 * a command that must succeed. Nothing of note is lost if the command
> +	 * fails apart from some minor scheduling optimisation losses. We can
> +	 * skip tracking this command.
> +	 */
> +	partition_command_write_untracked(
> +		pc, AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE));

[Severity: High]
Does sending PART_CMD_YIELD_IDLE untracked leave stale state in pc->last_cm=
d?

If the scheduler calls yield_idle() and the hardware rejects the command,
raising PART_INVALID_COMMAND, the interrupt handler will read the stale
pc->last_cmd (for instance, from a previous OPEN_WINDOW) and act upon it.
Can this lead to spurious command retries or fatal scheduler resets?

> =20
>  	return 0;
>  }
> @@ -127,8 +167,8 @@ static int window_close(struct panthor_partition_cont=
rol *pc)
> =20

[Severity: High]
Does the lockless hardware state check at the beginning of window_close()
race with pending commands?

If called immediately after window_open(), the hardware state may still be
PART_STATE_RESET because the OPEN_WINDOW command is still in flight.
window_close() assumes the window is already closed and returns early
without sending CLOSE_WINDOW, leaving the window permanently open and
leaking hardware resources.

>  	pc->closing =3D true;
> =20
> -	gpu_write(pc->iomem, AM_PART_COMMAND,
> -		  AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW));
> +	partition_command_write(pc, AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW),
> +				pc->current_aw);
> =20
>  	return 0;
>  }
> @@ -153,8 +193,8 @@ static int window_open(struct panthor_partition_contr=
ol *pc, u8 aw_id)
> =20
>  	guard(spinlock_irqsave)(&pc->lock);
> =20
> -	gpu_write(pc->iomem, AM_PART_COMMAND,
> -		  AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) | AM_PART_SET_WINDOW(aw_id=
));
> +	partition_command_write(pc, (AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) |
> +				     AM_PART_SET_WINDOW(aw_id)), aw_id);
> =20
>  	pc->current_aw =3D aw_id;

[Severity: High]
Does overwriting pc->current_aw before CLOSE_WINDOW completes break the
state machine?

In window_open(), if the window is already open, it calls window_close()
and then immediately overwrites pc->current_aw with the new aw_id. When
the hardware finishes closing and raises PART_RESET_DONE, the handler
consumes the new current_aw, clears it to -1, and sends a spurious stop
notification for the new window. Subsequent INVALID_COMMAND interrupts
for the new window will be ignored.

> =20
> @@ -166,6 +206,8 @@ static void partition_handle_reset_done(struct pantho=
r_partition_control *pc)
[ ... ]
> +static void partition_handle_invalid_cmd(struct panthor_partition_contro=
l *pc)
> +{
[ ... ]
> +		switch (AM_PART_GET_COMMAND(pc->last_cmd.cmd)) {
> +		case PART_CMD_YIELD_NOW:
> +		case PART_CMD_CLOSE_WINDOW:
> +			if (partition_state_get(pc) =3D=3D PART_STATE_WINDOW_OPEN) {
> +				partition_command_write_untracked(pc, pc->last_cmd.cmd);
> +				return;
> +			}
> +			break;
> +		case PART_CMD_OPEN_WINDOW:
> +			if (partition_state_get(pc) =3D=3D PART_STATE_RESET) {
> +				partition_command_write_untracked(pc, pc->last_cmd.cmd);
> +				return;
> +			} else if (partition_aw_get(pc) =3D=3D pc->last_cmd.aw_id) {
> +				return;
> +			}
> +
> +			on_err =3D true;

[Severity: High]
Does this synchronous state evaluation race with hardware transitions?

When OPEN_WINDOW is sent back-to-back after CLOSE_WINDOW, the hardware
rejects it because it hasn't reached PART_STATE_RESET yet. The IRQ fires,
and the handler synchronously reads the hardware state. If the hardware is
still transitioning and hasn't reached RESET, the handler falls through to
setting on_err =3D true, causing a fatal scheduler reset instead of retryin=
g.

> +			aw_id =3D pc->last_cmd.aw_id;
> +
> +			break;
> +		default:
> +			return;
> +		}
> +	}
> +
> +	if (on_err)
> +		panthor_arbitration_notify_err(dev_get_drvdata(pc->dev), aw_id);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D20
