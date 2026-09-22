Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1935EC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF8910EE81;
	Tue, 22 Sep 2026 21:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nBIH9SaQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E7110EE81
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:14:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08171600D4;
 Tue, 22 Sep 2026 21:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB381F000FF;
 Tue, 22 Sep 2026 21:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790111670;
 bh=qSWI5o7r4QNxL9k/y1jrIX7uqaymnVef0J/nkEozhI4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nBIH9SaQ7UaZC4E5sEguPhDTmJjxUQ/fHSchRH6OA17xlHoBJAHA+5/U098/snthK
 8P2/KhOeoOVJS1jJT4olbaBGvPAxLxjTPJ4S1nTSvc7J04D3bGftpl4Tq7tFxPUBa3
 MJpEC4msEHBPK3VO5bVcU8fymNpdzSHTIB+fJt6CfRISF3lGBTKQZOp9N6kw2YVQ3E
 OxkjdAM0vvH0IuiBJYqOt5vIAVodIyvpSfsIjhVFnue8SvnGjzHWhtFV53eLmW3nze
 kwzEqG1iogUcRixa7ZxtLyO4LpIri/JnZiG8doC6FuP6eZCczw2mqhKAc48OSWz54T
 w5yS86xqnNyCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 25/27] drm/panthor: Tolerate access-window loss
 during HW waits
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-26-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-26-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:14:30 +0000
Message-Id: <20260922211430.9FB381F000FF@smtp.kernel.org>
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
- [High] panthor: false success returned when hardware waits are interrupte=
d by AW loss
- [High] panthor: firmware events dropped or IRQ livelock on AW loss
- [High] panthor: threads block for full timeout duration on AW loss due to=
 missing wakeups
--

commit 4e7abd3f16aae357d6bd8c91a0c0d4c8218b1fcc
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Tolerate access-window loss during HW waits

The patch handles access window (AW) loss during hardware waits to prevent
false hardware timeouts or recoveries. It uses panthor_aw_has_gpu_access
to suppress timeout handling once access is revoked.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 1449d9a66302e..b4c234f3d3ea4 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1140,9 +1140,10 @@ static int panthor_fw_start(struct panthor_device =
*ptdev)
>  	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
> =20
>  	if (!wait_event_timeout(ptdev->fw->req_waitqueue,
> -				ptdev->fw->booted,
> +				(ptdev->fw->booted ||
> +				 !panthor_aw_has_gpu_access(ptdev)),
>  				msecs_to_jiffies(1000))) {
> -		if (!ptdev->fw->booted &&
> +		if (!ptdev->fw->booted && panthor_aw_has_gpu_access(ptdev) &&
>  		    !(gpu_read(fw->irq.iomem, INT_STAT) & JOB_INT_GLOBAL_IF))
>  			timedout =3D true;
>  	}

[Severity: High]
Does this code silently fail to boot but return success? If the AW is lost
during the wait, panthor_aw_has_gpu_access() returns false, preventing
timedout from being set to true. As a result, panthor_fw_start() returns
success even though the firmware is not actually booted.

Additionally, because there is no wakeup mechanism triggered upon AW loss,
will this thread stall in wait_event_timeout() for the full 1000ms duration
when AW access is revoked?

[ ... ]

> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/pant=
hor/panthor_gpu.c
> index e6e970e9b59d3..25fe7c77f8763 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -376,7 +377,8 @@ int panthor_gpu_flush_caches(struct panthor_device *p=
tdev,
>  				msecs_to_jiffies(100))) {
>  		scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
>  			if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) !=3D =
0 &&
> -			    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_CO=
MPLETED))
> +			    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) &
> +			      GPU_IRQ_CLEAN_CACHES_COMPLETED) && panthor_aw_has_gpu_access(pt=
dev))
>  				ret =3D -ETIMEDOUT;
>  			else
>  				ptdev->gpu->pending_reqs &=3D ~GPU_IRQ_CLEAN_CACHES_COMPLETED;

[Severity: High]
Can this deceive callers into assuming caches were successfully flushed?
If AW is lost, the timeout error is suppressed and the pending request flag
is cleared, causing panthor_gpu_flush_caches() to return 0. This could cause
divergence if callers proceed assuming the flush completed in the hardware.

Also, wait_event_timeout() lacks an AW check in the condition and has no
associated wakeup on AW loss, which will cause a 100ms stall.

[ ... ]

> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/pant=
hor/panthor_pwr.c
> index cc2e01595f23b..2a0feb0b39ece 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -122,7 +123,8 @@ static int panthor_pwr_reset(struct panthor_device *p=
tdev, u32 reset_cmd)
>  				msecs_to_jiffies(PWR_RESET_TIMEOUT_MS))) {
>  		guard(spinlock_irqsave)(&ptdev->pwr->reqs_lock);
> =20
> -		if (reset_pending(ptdev) && !reset_irq_raised(ptdev)) {
> +		if (reset_pending(ptdev) && !reset_irq_raised(ptdev) &&
> +		    panthor_aw_has_gpu_access(ptdev)) {
>  			drm_err(&ptdev->base, "RESET timed out (0x%x)", reset_cmd);
>  			return -ETIMEDOUT;
>  		}

[Severity: High]
Is the thread blocked for the full PWR_RESET_TIMEOUT_MS when AW is lost?
The wait_event_timeout() lacks an AW check in its condition, and without a
corresponding wakeup mechanism for AW loss, it appears this will stall
the thread unnecessarily in panthor_pwr_reset().

[ ... ]

> @@ -266,9 +268,14 @@ static int panthor_pwr_domain_transition(struct pant=
hor_device *ptdev, u32 cmd,
> =20
>  	panthor_pwr_write_command(ptdev, pwr_cmd, mask);
> =20
> -	ret =3D gpu_read64_poll_timeout(pwr->iomem, ready_reg, val, (mask & val=
) =3D=3D expected_val,
> +	ret =3D gpu_read64_poll_timeout(pwr->iomem, ready_reg, val,
> +				      ((mask & val) =3D=3D expected_val ||
> +				       !panthor_aw_has_gpu_access(ptdev)),
>  				      100, timeout_us);
>  	if (ret) {
> +		if (!panthor_aw_has_gpu_access(ptdev))
> +			return 0;
> +

[Severity: High]
Does returning success here break the power domain transition sequence?
If the AW arbiter revokes access before the transition finishes, this will
return 0 even though the hardware power domain transition failed to complet=
e.

[ ... ]

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 60b2417deb81b..e13553ec97ec9 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1886,6 +1886,9 @@ void panthor_sched_report_fw_events(struct panthor_=
device *ptdev, u32 events)
> =20
>  	guard(spinlock)(&ptdev->scheduler->events_lock);
> =20
> +	if (!panthor_aw_has_gpu_access(ptdev))
> +		return;
> +

[Severity: High]
Could this early return cause an IRQ livelock or dropped firmware events?

If a hardware interrupt occurs and panthor_job_irq_handler() successfully
clears the interrupt from the hardware, but then AW access is lost, this
returns early. The cleared events would be permanently dropped.

If AW access is lost before the hardware is cleared in the IRQ handler,
the interrupt remains asserted but this function ignores it, which may cause
the threaded IRQ handler to enter an infinite loop.

[ ... ]

> @@ -2059,6 +2062,8 @@ static int csgs_upd_ctx_apply_locked(struct panthor=
_device *ptdev,
>  		csg_iface =3D panthor_fw_get_csg_iface(ptdev, csg_id);
> =20
>  		ret =3D panthor_fw_csg_wait_acks(ptdev, csg_id, req_mask, &acked, 100);
> +		if (ret && !panthor_aw_has_gpu_access(ptdev))
> +			ret =3D 0;
> =20

[Severity: High]
Does this override the timeout error with success, causing the scheduler to
erroneously assume the firmware processed the CSG state change?

Also, panthor_fw_csg_wait_acks() relies on panthor_fw_wait_acks() which uses
wait_event_timeout(). Since this is called in a loop while holding the
scheduler lock, will the lack of AW wakeups cause compounded delays
(N * 100ms) that block the entire scheduler?

[ ... ]

Regarding panthor_job_irq_handler() in drivers/gpu/drm/panthor/panthor_fw.c:

static void panthor_job_irq_handler(struct panthor_irq *pirq, u32 status)
{
    ...
	if (!ptdev->fw->booted && (status & JOB_INT_GLOBAL_IF))
		ptdev->fw->booted =3D true;
    ...
}

[Severity: Medium]
This is a pre-existing issue, but does this logic spuriously set the firmwa=
re
state to booted on an AW loss? When AW access is lost, the MMIO read for the
interrupt status will return 0xFFFFFFFF, which has JOB_INT_GLOBAL_IF set.
This would incorrectly flag the firmware as booted during early execution.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D25
