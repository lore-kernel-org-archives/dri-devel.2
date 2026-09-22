Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9AAC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35BFA10EE80;
	Tue, 22 Sep 2026 21:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FTH6taDp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBAC10EE80
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:07:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83EEF601FA;
 Tue, 22 Sep 2026 21:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E901F000FF;
 Tue, 22 Sep 2026 21:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790111266;
 bh=rCv+R6mnJbGOunFBHISCPcf9/Fs7kALfLW0t+PZckV4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FTH6taDprK2DQ+gSvPpH87Et0D+DXODGtAI3C0OfRJXNkmApnitgbIL70ShgTREin
 HXRJRAa/ImFMu7D2ijmI9v1bRHqE7BUVDak3STArMma3Ff23RHasTxmF2JG8erkItd
 flX6WgCcOA1dHZa+gcqomjrntiyfYF8XTbiRGOicHg721eEAiC1AzZPVAnwR8RaJ2b
 7KVOA28SMSV5SrP3/9j2eFHYb3RSMwef/cfG55LGADPZiqX8Sw8JDqUkYAerrFuRgM
 mzwDcDjf0D0PgU4iYt+uLKACE0SeGySjxMEGD8COCSChAfyr/lyYlGMpz4k8cgnoQy
 MrtvRqHOXgTWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 21/27] drm/panthor: Request AW to yield GPU access on
 idle
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-22-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-22-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:07:45 +0000
Message-Id: <20260922210746.10E901F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] gpu: back-to-back command writes and untracked YIELD_IDLE cause sp=
urious resets
--

commit fadb8e77c6f0f320ae209ccd68ac1719dfdd7041
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Request AW to yield GPU access on idle
   =20
v15 GPU introduces a YIELD_IDLE command/interrupt to signal an access
window to relinquish GPU access as soon as it is idle. With FW v2, the
GPU is immediately yielded when it detects the GPU is idle and the
YIELD_IDLE interrupt is raised.

For latency and CPU scheduling reasons, we want to avoid constantly
yielding the GPU the moment it goes idle when there is only a singular
access window requesting access. As such, we only send YIELD_IDLE when:

- The GPU is granted to an access window and there are other access
  windows requesting GPU access.
- A new GPU_REQUEST was received and the currently active access window
  was the singular requesting AW.

[ ... ]

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sche=
d.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
> index df0785a80442c..df58fcc56e375 100644
> --- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
> @@ -347,6 +347,10 @@ static int arb_sched_next_locked(struct panthor_arbi=
tration_sched *sched)
> =20
>  	arb_sched_grant_locked(sched);
> =20
> +	if (sched->phase =3D=3D ARB_SCHED_PHASE_GRANTED &&
> +	    !kfifo_is_empty(&sched->queue))
> +		panthor_arbitration_notify_yield_idle(to_adev(sched), aw_id);

[Severity: High]
Does this sequence cause back-to-back command writes that can trigger spuri=
ous
resets?

When multiple AWs are queued, arb_sched_next_locked() grants the GPU to one
AW, which writes the PART_CMD_OPEN_WINDOW command to the hardware register =
via
arb_sched_grant_locked(), and then immediately issues PART_CMD_YIELD_IDLE h=
ere
without waiting for the hardware to process the window state.

The immediate write to the same register can physically overwrite the
PART_CMD_OPEN_WINDOW command before the hardware processes it. If the hardw=
are
instead rejects PART_CMD_YIELD_IDLE (for example, because it's still in the
PART_STATE_WINDOW_OPENING state), it raises PART_INVALID_COMMAND.

Because panthor_arbitration_notify_yield_idle() eventually calls yield_idle=
(),
which uses an untracked command write:

drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c:yield_idle(=
) {
	...
	partition_command_write_untracked(
		pc, AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE));
	...
}

The pc->last_cmd remains set to the previously tracked command
(PART_CMD_OPEN_WINDOW). The IRQ handler partition_handle_invalid_cmd() then
mistakenly believes the PART_CMD_OPEN_WINDOW command failed, sees the state=
 is
not PART_STATE_RESET or fully open, and resets the scheduler.

Can we wait for the hardware to process PART_CMD_OPEN_WINDOW or for the win=
dow
state to settle before sending PART_CMD_YIELD_IDLE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D21
