Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC5EC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9425B10E3F5;
	Fri, 11 Sep 2026 23:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jvidXft1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9100C10E5E2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:43:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 625FE43AF2;
 Fri, 11 Sep 2026 23:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C671F000FF;
 Fri, 11 Sep 2026 23:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789170197;
 bh=r8serDmvyMyAV8SYuEWyGqCuN99TjzpFO3eqhqDM5vE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jvidXft17W9ABBjS8uvnHL5ghPT1MC2e2PQ3JJrLIqtQD7xPB+5JYxrnzoGQhpkBQ
 ciFYdIOuien8UTin2YxVcc+vpTpy82naCRF1ZwZ/g0Q3Qo066mv8Wfk4/xzKGSbwwE
 GcyTxAKti0noj+GhhFUwVZsDk3nMDhpsy5IPodaAAsUPqg4ps31ulWEwmR0MWRPUXp
 cOqd2/XQwEw90te9+on8FCxPNQjoG5QoRC7CGGeCCzxQAijmkOo00e3WsY7UDntxZA
 HZfwepV3U9DCblmCOhZsxYMZApKyY3aBwAu8E6DWyvux9bfwMQKtE8D5R6D3DGR1L8
 fmaBmMRZs7rRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/16] drm/panfrost: Explicitly enable MMU interrupts
 at device init
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-claude-fixes-v9-7-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-7-e588feaa61ef@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:43:16 +0000
Message-Id: <20260911234317.24C671F000FF@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but the GPU reset se=
quence (`panfrost_reset`) synchronizes the Job Management (JM) IRQ but fail=
s to mask or synchronize the MMU IRQ, leading to a TOCTOU data race that ca=
n corrupt the driver state for newly submitted jobs.
- [High] This problem wasn't introduced by this patch, but during driver un=
bind (`panfrost_remove`) or probe failure, clocks and power domains are dis=
abled while shared IRQ handlers remain active, which can lead to kernel cra=
shes if the shared IRQ line is asserted.
--

commit 8161749d65dccd8c767c11da6233beaf16346d71
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Explicitly enable MMU interrupts at device init

Because the device must be in a position to accept jobs between the time
drm_dev_register() is called and autosuspend first kicks in, this commit
enables MMU interrupts at device initialisation time. This avoids a narrow
window where jobs targeting the tiler buffer object could time out.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 5c393ed6e3101..faa62643caf1d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
[ ... ]
> @@ -355,8 +361,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
> =20
>  	spin_unlock(&pfdev->as_lock);
> =20
> -	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
> -	mmu_write(pfdev, MMU_INT_MASK, ~0);
> +	panfrost_mmu_enable_interrupts(pfdev);

[Severity: High]
This isn't a bug introduced by this patch, but does the GPU reset sequence
have a data race here?

When panfrost_reset() in drivers/gpu/drm/panfrost/panfrost_job.c triggers
a reset, it synchronizes the JM IRQ but fails to mask or synchronize the
MMU IRQ:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_reset() {
	...
	job_write(pfdev, JOB_INT_MASK, 0);
	synchronize_irq(pfdev->js->irq);
	...
}

Because the MMU IRQ isn't synchronized, panfrost_mmu_irq_handler_thread()
can execute concurrently with panfrost_device_reset() and
panfrost_mmu_reset().

Since panfrost_mmu_enable_interrupts() modifies the MMU_INT_MASK hardware
register outside of pfdev->as_lock, could this race cause pfdev->as_faulty_=
mask
and the hardware register to become inconsistent if a fault occurs exactly
during reset, leading to timeouts for newly submitted jobs?

>  }
> =20
[ ... ]
> @@ -973,6 +978,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
>  		return err;
>  	}
> =20
> +	panfrost_mmu_enable_interrupts(pfdev);
> +

[Severity: High]
This is a pre-existing issue, but could enabling interrupts here cause a bus
error if the probe fails or during driver unbind?

If probe fails later in panfrost_device_init() in=20
drivers/gpu/drm/panfrost/panfrost_device.c, or during module unload in
panfrost_remove() in drivers/gpu/drm/panfrost/panfrost_drv.c,
panfrost_mmu_fini() is called to clear the mask:

drivers/gpu/drm/panfrost/panfrost_mmu.c:panfrost_mmu_fini() {
	mmu_write(pfdev, MMU_INT_MASK, 0);
}

However, this doesn't set PANFROST_COMP_BIT_MMU in pfdev->is_suspended or
call synchronize_irq(). The clocks and power domains are then disabled, but
the devm-managed shared IRQ remains registered until the probe or remove
function fully returns.

If the shared IRQ line is asserted during this teardown window, won't
panfrost_mmu_irq_handler() bypass the is_suspended check and read
MMU_INT_STAT without active clocks, resulting in a synchronous external abo=
rt?

>  	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-claude-fix=
es-v9-0-e588feaa61ef@collabora.com?part=3D7
