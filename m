Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFFF606A205
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJN1eucK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42BC10E30D;
	Tue, 10 Nov 2026 16:30:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BDD10E30D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:30:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1ADCE63A70;
 Tue, 10 Nov 2026 16:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87AD1F008BC;
 Tue, 10 Nov 2026 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794328219;
 bh=fKRoeHopfh1UW8XpO4YH9uQaY8Taf59vZuXGzqoMAy4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=dJN1eucKMtPIIGPIDG1wfWzqMWuvGLL2OrXLlA23OGVnf2oLg/76zwuPX7yBFaev8
 7pW124Ys14cFCaR6yYU4bNb1aLgMzdvVeaH5+hJxTpr/tsgWSE0AU/HahE0tAgc9zf
 F6Lf5OwNcUjCxNzemfis/BE6JMfHCC6TvM5pnLLei6a7wJ/4tF+ychZA+QO4WOp7yp
 xYoPCQyLSsyAHktFTAHkqMXROYS3w/cBzftRcLCzX/AUcSXlTW9ncYffhJeUuzfVAk
 rD1Q/h5oMriBpWqHIDm5Kcoyy6J3MDw5GdQ58vwv3AgIf73R7ejQ0VJEvXX0KWkoLL
 pZc/LKWITrhgQ==
Message-ID: <sashiko-outbox-207383@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/28] drm/panthor: Tolerate access-window loss
 during HW waits
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-27-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-27-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:30:19 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/panthor: false success in panthor_fw_start() and
  panthor_fw_mcu_halted()
- [High] drm/panthor: panthor_sched_report_fw_events() drops FW events
  on access loss
- [Medium] drm/panthor: unguarded PWR_STATUS checks fail on access loss
  in panthor_pwr.c
- [Medium] drm/panthor: unawakened waits stall on access loss in flush,
  reset, and FW
- [Low] drm/panthor: missing early return on access loss in
  panthor_pwr_l2_power_off()
--

commit d06b3bf7778829600d32bed288afa3f04bcf72dd
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Tolerate access-window loss during HW waits

This commit adds panthor_aw_has_gpu_access() and updates firmware, GPU cache
flush, power control, and scheduler paths to stop waiting or suppress timeo=
ut
errors when the access window closes.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 1449d9a66302e..8643e7bbfc108 100644
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
> @@ -1180,6 +1181,9 @@ static bool panthor_fw_mcu_halted(struct panthor_de=
vice *ptdev)
>  	struct panthor_fw_global_iface *glb_iface =3D panthor_fw_get_glb_iface(=
ptdev);
>  	bool halted;
> =20
> +	if (!panthor_aw_has_gpu_access(ptdev))
> +		return true;
> +
>  	halted =3D gpu_read(ptdev->fw->iomem, MCU_STATUS) =3D=3D MCU_STATUS_HAL=
T;

[Severity: High]
Can returning 0 from panthor_fw_start() and true from panthor_fw_mcu_halted=
()
on access loss cause callers to treat an unbooted MCU as booted and corrupt
ptdev->reset.fast?

If the access window closes in panthor_fw_start() before JOB_INT_GLOBAL_IF
sets ptdev->fw->booted, panthor_fw_start() returns 0 while ptdev->fw->booted
is still false.  In panthor_fw_init(), execution continues into
panthor_fw_init_ifaces() before the MCU has populated the shared control
interface.  In panthor_aw_resume() -> panthor_device_resume_hw_components()=
 ->
panthor_fw_post_reset(), an interrupted slow reset (where ptdev->reset.fast
was false and firmware sections were freshly reloaded) succeeds and is
immediately followed by panthor_device_suspend_hw_components() ->
panthor_fw_pre_reset().  Because panthor_fw_mcu_halted() unconditionally
returns true when !panthor_aw_has_gpu_access(ptdev), panthor_fw_pre_reset()
sets ptdev->reset.fast =3D true even though the MCU never finished booting,=
 so
the next resume skips panthor_reload_fw_sections() and attempts a fast reset
on unbooted firmware memory.

> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/pant=
hor/panthor_gpu.c
> index 2e1b00e86cdea..d5666264c1fe6 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -377,7 +378,8 @@ int panthor_gpu_flush_caches(struct panthor_device *p=
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

[Severity: Medium]
Does panthor_gpu_flush_caches() still block for the full 100ms timeout per
active VM whenever the access window closes?

When panthor_aw_handle_window_closed() sets aw->state to
PANTHOR_AW_STATE_SUSPEND_PENDING and schedules panthor_aw_post_yield_work(),
panthor_device_suspend_hw_components() -> panthor_mmu_suspend() ->
panthor_mmu_as_disable() calls panthor_gpu_flush_caches() for each bound MMU
address space slot while holding ptdev->mmu->as.slots_lock and
ptdev->pm.hw_component_lock.  Because panthor_gpu_flush_caches() only checks
panthor_aw_has_gpu_access(ptdev) after wait_event_timeout() expires (and
ptdev->gpu->reqs_acked is not woken on access-window close), every yield
sleeps for 100ms per active VM.  Similarly, panthor_pwr_reset() and
panthor_fw_wait_acks() do not include !panthor_aw_has_gpu_access(ptdev) in
their wait_event_timeout() conditions, so in-flight waits there also sleep
until their full timeout expires when access is lost.

> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/pant=
hor/panthor_pwr.c
> index 1cfd4b658c81b..66a2c54b070dc 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c

[ ... ]

> @@ -400,9 +411,13 @@ static int delegate_domain(struct panthor_device *pt=
dev, u32 domain)
>  	 * allow-flag will be cleared with delegated-flag being set.
>  	 */
>  	ret =3D gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
> -				      ((delegated_mask | allow_mask) & val) =3D=3D delegated_mask,
> +				      (((delegated_mask | allow_mask) & val) =3D=3D delegated_mask ||
> +				       !panthor_aw_has_gpu_access(ptdev)),
>  				      10, PWR_TRANSITION_TIMEOUT_US);
>  	if (ret) {
> +		if (!panthor_aw_has_gpu_access(ptdev))
> +			return 0;
> +
>  		drm_err(&ptdev->base, "Delegating %s domain timeout, cmd(0x%x)",
>  			get_domain_name(domain), pwr_cmd);
>  		return ret;

[Severity: Medium]
What happens in panthor_pwr_l2_power_on() when panthor_pwr_domain_transitio=
n()
or delegate_domain() returns 0 after losing GPU access?

panthor_pwr_l2_power_on() powers on the L2 domain and then calls
panthor_pwr_delegate_domains(), which runs delegate_domain() for the neural,
shader, and tiler domains in sequence.  Once the access window closes, MMIO
reads from PWR_STATUS return 0, so the next delegate_domain() call hits the
unguarded !(pwr_status & allow_mask) check at the start of the function, lo=
gs
a warning, and fails with -EPERM.  The initial PWR_STATUS checks in
panthor_pwr_l2_power_on() and panthor_pwr_reset_soft() have the same issue =
and
fail with -EPERM and -EOPNOTSUPP when entered after access loss.

> @@ -542,7 +557,7 @@ void panthor_pwr_l2_power_off(struct panthor_device *=
ptdev)
>  	const bool has_neural =3D panthor_hw_has_neural(ptdev);
> =20
>  	/* Abort if L2 power off constraints are not satisfied */
> -	if (!(pwr_status & l2_allow_mask)) {
> +	if (!(pwr_status & l2_allow_mask) && panthor_aw_has_gpu_access(ptdev)) {
>  		drm_warn(&ptdev->base, "Power off L2 domain not allowed");
>  		return;
>  	}

[Severity: Low]
Should panthor_pwr_l2_power_off() still return early when GPU access is los=
t,
while only gating drm_warn() on panthor_aw_has_gpu_access(ptdev)?

With the condition written this way, calling panthor_pwr_l2_power_off() when
!panthor_aw_has_gpu_access(ptdev) (such as during panthor_aw_post_yield_wor=
k()
-> panthor_device_suspend_hw_components() -> panthor_gpu_suspend()) bypasses
the return and falls through to panthor_pwr_domain_force_off() and
panthor_pwr_domain_power_off() across all domains on a closed access window.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 729eeb339fa40..addc5986554df 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1887,6 +1887,9 @@ void panthor_sched_report_fw_events(struct panthor_=
device *ptdev, u32 events)
> =20
>  	guard(spinlock)(&ptdev->scheduler->events_lock);
> =20
> +	if (!panthor_aw_has_gpu_access(ptdev))
> +		return;
> +
>  	if (events & JOB_INT_GLOBAL_IF) {
>  		sched_process_global_irq_locked(ptdev);
>  		events &=3D ~JOB_INT_GLOBAL_IF;

[Severity: High]
Can returning early here drop job completions and CSG events when the MCU
raises a job IRQ just before yielding the access window?

kthread (job irq)                 <hardirq> (aw irq)
panthor_job_irq_handler()
  status =3D gpu_read(INT_RAWSTAT)
  gpu_write(INT_CLEAR, status)
                                  panthor_aw_irq_raw_hander()
                                    panthor_aw_handle_window_closed()
                                      aw->state =3D
                                        PANTHOR_AW_STATE_SUSPEND_PENDING
  panthor_sched_report_fw_events()
    if (!panthor_aw_has_gpu_access(ptdev))
      return;  <-- drops status events

With YIELD_IDLE enabled, the MCU updates group sync objects and CSG output
structures in host DRAM, raises the job interrupt, and immediately yields t=
he
access window.  Because panthor_job_irq_handler() has already cleared the
interrupt before calling panthor_sched_report_fw_events(), bailing out when
!panthor_aw_has_gpu_access(ptdev) discards those events (such as
CSG_SYNC_UPDATE and CS_FAULT) even though the global and CSG interfaces live
in shared DRAM, leaving completed jobs' dma_fences unsignaled across fast
resets.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D26
