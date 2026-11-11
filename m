Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4519606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjDox+y0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DD910E0A2;
	Wed, 11 Nov 2026 02:33:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851FD10E0A2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 02:33:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5532C61D08;
 Wed, 11 Nov 2026 02:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36DD1F0089F;
 Wed, 11 Nov 2026 02:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794364412;
 bh=9Jzt+qpsQ6p8+fNcNyiLmKx0Ob8jhB1rbFphqSrrwhM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SjDox+y0hxUxAE9sklh9d4FYW6vPABnimYlGbxHnswTZ1PGENrPdSHS7hAjkIXH9r
 GjCVVZmkJk6x6HRu5yIS+lK0wFKjYb/KfqZSTcMLdFOl7wyZs/vtYZbx8zDrHCubBy
 Qb0UxEruWq61iaQNuBVjiuox5WlJ/YoDsEzkBG93b6qMaKe0LeJnbwtX/HyspVykvj
 eVFzb+JMJ28kPYqSkl+YU/7DqkjzuORLI0Z0Gk+XeAmeWvs/X9QYBw2gjxVsqBzGy4
 wJhWVXzxYUXc0Y72Z4oDE8w2HEtUqp46iOEorRbC8HFX//eReY6R7AjTw2m4QME7gq
 mGjzLGzcnvYYg==
Message-ID: <sashiko-outbox-208095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: Wait for the firmware's interrupts
 before stopping it
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-rbrue-suez-upstreaming-pvr-fw-irq-handshake-v1-1-8872686d14d0@gmail.com>
References: <20261110-rbrue-suez-upstreaming-pvr-fw-irq-handshake-v1-1-8872686d14d0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:33:31 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/imagination: stale fw_irq_count after pvr_fw_irq_clear()
  in soft reset
- [Low] drm/imagination: inaccurate Fixes trailer in commit message
--

commit dbe0d48bb06b24b93cd3341271e891958e4e6800
Author: Ryan Brue <ryanbrue.dev@gmail.com>

> drm/imagination: Wait for the firmware's interrupts before stopping it
>
> Once the firmware has acknowledged the POW_OFF request, a runtime suspend
> disables the IRQ and stops the firmware straight away, even if the
> firmware has raised an interrupt the host has not taken yet. On an
> MT8173 (GX6250, META firmware), the SIDEKICK_IDLE.GARTEN poll at the end
> of pvr_fw_stop() can then time out. The suspend fails with -ETIMEDOUT,
> runtime PM latches the error, and every later pvr_power_get() returns
> -EINVAL. The recovery reset that follows can fail the same way and lose
> the device.
>
> The firmware counts the interrupts it raises in its OS data. Sample that
> count in the IRQ thread after clearing the interrupt, and before
> disabling the IRQ for a runtime suspend, wait until the host has seen
> every interrupt the firmware counted, as Imagination's DDK does. Clear
> the host's copy when a hard reset clears the firmware's.
>
> Fixes: 727538a4bbff ("drm/imagination: Implement power management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

[Severity: Low]
In 727538a4bbff ("drm/imagination: Implement power management"),
pvr_power_fw_disable() was an unimplemented stub returning -ENODEV and
pvr_power_device_suspend() only disabled clocks.  Should the Fixes: tag
point to cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure
and META FW support"), which introduced pvr_fw_stop() and wired up
pvr_power_fw_disable() in runtime suspend (or 74ef7844dd8c
("drm/imagination: Disable interrupts before suspending the GPU"), which
added the disable_irq() call before pvr_fw_stop())?

> diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/i=
magination/pvr_device.c
> index 992509d95d289..99a3842c27833 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.c
> +++ b/drivers/gpu/drm/imagination/pvr_device.c
> @@ -215,6 +215,12 @@ static irqreturn_t pvr_device_irq_thread_handler(int=
 irq, void *data)
>  		pvr_fw_irq_clear(pvr_dev);
> =20
>  		if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
> +			struct rogue_fwif_osdata *osdata =3D pvr_dev->fw_dev.fwif_osdata;
> +
> +			for (u32 i =3D 0; i < MAX_THREAD_NUM; i++)
> +				WRITE_ONCE(pvr_dev->fw_irq_count[i],
> +					   READ_ONCE(osdata->interrupt_count[i]));
> +
>  			pvr_fwccb_process(pvr_dev);
>  			pvr_kccb_wake_up_waiters(pvr_dev);
>  			pvr_device_process_active_queues(pvr_dev);

[Severity: Medium]
Can pvr_dev->fw_irq_count fall behind osdata->interrupt_count when
pvr_fw_irq_clear() is called outside pvr_device_irq_thread_handler(), such
as during a soft reset in pvr_power_reset()?

drivers/gpu/drm/imagination/pvr_power.c:pvr_power_reset() {
    ...
		err =3D pvr_power_fw_disable(pvr_dev, hard_reset, false);
		if (!err) {
			if (hard_reset) {
    ...
			} else {
				/* Clear the FW faulted flags. */
				pvr_dev->fw_dev.fwif_sysdata->hwr_state_flags &=3D
					~(ROGUE_FWIF_HWR_FW_FAULT |
					  ROGUE_FWIF_HWR_RESTART_REQUESTED);
			}

			pvr_fw_irq_clear(pvr_dev);

			err =3D pvr_power_fw_enable(pvr_dev, false);
		}
    ...
}

On a soft reset (hard_reset =3D=3D false), pvr_fw_hard_reset() is not calle=
d,
so osdata->interrupt_count keeps its non-zero values while
disable_irq_nosync() is in effect.  If the firmware raises another
interrupt after pvr_device_irq_thread_handler() sampled
osdata->interrupt_count (or while pvr_power_fw_disable() sends the idle
and power-off requests), pvr_fw_irq_clear() in pvr_power_reset() clears
the pending hardware interrupt without updating pvr_dev->fw_irq_count.
Because the hardware status bit is cleared, pvr_device_irq_thread_handler()
will not run for that interrupt, and the next runtime suspend will see
osdata->interrupt_count[i] !=3D pvr_dev->fw_irq_count[i] in
pvr_power_wait_for_fw_irqs(), stalling for the full 1-second
POWER_SYNC_TIMEOUT_US and logging a false warning.  The same can happen at
boot when pvr_device_irq_init() calls pvr_fw_irq_clear() after
pvr_device_gpu_init() has already started the firmware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-rbrue-suez=
-upstreaming-pvr-fw-irq-handshake-v1-1-8872686d14d0@gmail.com?part=3D1
