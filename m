Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52740CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE83710F20C;
	Thu, 25 Jun 2026 10:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M4cpGyXT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE8B10F20C
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:00:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73D76403C5;
 Thu, 25 Jun 2026 10:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62261F000E9;
 Thu, 25 Jun 2026 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782381628;
 bh=s4wi7KUoHwqHPhKC1mQdne57vEZl/ZbVeoy4xyyUpVM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M4cpGyXTX2AshboG22UAPbdMkxbsMbeFeYSHLBlV6gmiLDq0E43aspa8jdp6z5g9M
 p+8MZzs3TDANAzSiSF47nChWZvYZE3srUKheeQWdXjES6T65cJRXlrYuOtH4j3rlWn
 /xKvPR+vb8itkvz7mLbbH+lUIx2i+EBsOxIcuEAZugvImFpyflt3JHFcc+La4mrMQJ
 0mD24KgpfcyPphzjFtO94dvqSGymrivqyP+PvfhqaIaPNro5ag216Lyuoyt2HzFzGp
 ylgwUptGqOIGxabmay0HPik++A3DXQ7fwkQyO/1SWb/pQW3FKTStBUvGSNADBhedmu
 yHWEszI4w46rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/16] drm/panthor: Drop a needless check in
 panthor_fw_unplug()
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-panthor-signal-from-irq-v5-4-8836a74e0ef9@collabora.com>
References: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
 <20260625-panthor-signal-from-irq-v5-4-8836a74e0ef9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:00:27 +0000
Message-Id: <20260625100027.A62261F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The reset work `panthor_device_reset_work` can execute before devi=
ce initialization completes, leading to a NULL pointer dereference.
--

commit b7f6d51a0860da42553b0a2ac207a7c13c51cd47
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Drop a needless check in panthor_fw_unplug()

panthor_fw_unplug() is only called if we at least managed to initialize
the IRQ, so it's safe to drop the "is IRQ initialized" check.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 986151681b246..4fbddb9e18c8b 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1279,9 +1279,7 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
> =20
>  	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev)) {
>  		/* Make sure the IRQ handler cannot be called after that point. */
> -		if (ptdev->fw->irq.irq)
> -			panthor_job_irq_suspend(&ptdev->fw->irq);
> -
> +		panthor_job_irq_suspend(&ptdev->fw->irq);
>  		panthor_fw_stop(ptdev);
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but can the reset work panthor_device_reset_w=
ork
execute before device initialization completes?

During device initialization in panthor_device_init(), panthor_fw_init() is
called, which invokes panthor_vm_active(). This in turn calls
panthor_mmu_as_enable() and as_send_cmd_and_wait().

If the MMU AS_ACTIVE bit gets stuck and times out,
panthor_device_schedule_reset() is called. Because the device PM state has
already been transitioned to ACTIVE earlier via pm_runtime_resume_and_get(),
the reset work is queued and executes asynchronously.

The reset worker unconditionally calls panthor_sched_pre_reset(), which
immediately dereferences ptdev->scheduler:

drivers/gpu/drm/panthor/panthor_sched.c:panthor_sched_pre_reset() {
        struct panthor_scheduler *sched =3D ptdev->scheduler;
        u32 i;

        mutex_lock(&sched->reset.lock);
        ...
}

Since ptdev->scheduler is only allocated later in the probe sequence by
panthor_sched_init(), could this result in a NULL pointer dereference if the
reset happens during the probe window?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-panthor-si=
gnal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=3D4
