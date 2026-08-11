Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C2EC5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDF810EDB1;
	Tue, 11 Aug 2026 21:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ascs+PHZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A795C10EDB1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:54:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2698F600AE;
 Tue, 11 Aug 2026 21:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C8D1F000E9;
 Tue, 11 Aug 2026 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786485294;
 bh=w4MnU/pceGjFPye73veFUBilJhOGQNmscFZVIHurb7E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ascs+PHZnuH6CVGEeuDXgreFjZQ46jafOme+X1l+2sZ1zbZSbWZ5MkrD1T5riQif3
 ZWl5uqkZzRYW33mg5iS+tvShzXTKjTlt0plDv6w/Mi2RVWoHoKFUzlKF1pZOg7mGVB
 1ZjHxqDE4S89Z4H1Ue8X7T54qyQudvf6mjAKMBZRF/so8MyQqQt/UjSvj8HZylv34H
 RvVgGcFqlMznDriy+XvjB1Ioc7pzT2hiaqYDDM6n7k6PbEl8llFX3sgFOqYyWpHs0h
 AonpE+JgFBLC8w8HtokYrmjREMgV0j/9LDNN1QMt9cMNGY+gyh/kt7e7Xo7XCcv+54
 tbJqspFwnfgBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/11] drm/panfrost: Explicitly enable MMU interrupts
 at device init
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811-claude-fixes-v5-6-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-6-3d692c9e98c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 21:54:54 +0000
Message-Id: <20260811215454.A1C8D1F000E9@smtp.kernel.org>
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
- [High] Missing `synchronize_irq()` in `panfrost_mmu_fini()` allows the MM=
U IRQ handler thread to execute concurrently with downstream teardown steps=
, potentially causing a kernel panic.
- [High] Writing to `MMU_INT_MASK` before clearing `as_faulty_mask` leaves =
the Address Space (AS) interrupt masked.
--

--- Patch [6]: [PATCH v5 06/11] drm/panfrost: Explicitly enable MMU interru=
pts at device init ---
commit d0741154918a6f24b94515670ed05d32bd8b695a
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Explicitly enable MMU interrupts at device init

This commit explicitly enables MMU interrupts at device initialization.
Because the device must be in a position to accept jobs between the time
drm_dev_register() is called and autosuspend first kicks in, there's a very
narrow window where jobs could time out since the device's PM status is
active but no MMU interrupts were enabled.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 3fe37dd123609..a8ce5d65825c9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c

[ ... ]

> @@ -336,6 +336,12 @@ void panfrost_mmu_as_put(struct panfrost_device *pfd=
ev, struct panfrost_mmu *mmu
>  	WARN_ON(atomic_read(&mmu->as_count) < 0);
>  }
> =20
> +static void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev)
> +{
> +	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
> +	mmu_write(pfdev, MMU_INT_MASK, ~0);

[Severity: High]
This isn't a bug introduced by this patch, but is there an issue with how
MMU_INT_MASK is programmed when re-acquiring a faulty address space?

Looking at panfrost_mmu_as_get() in the same file:

panfrost_mmu_as_get() {
	...
	mmu_write(pfdev, MMU_INT_MASK, ~pfdev->as_faulty_mask);
	pfdev->as_faulty_mask &=3D ~mask;
	...
}

Because the inverted faulty mask is written to hardware before the bit is
cleared from pfdev->as_faulty_mask in software, does this program the
hardware with a 0 (masked) for that address space?

If a workload causes a page fault (making the address space faulty) and then
attempts to reuse it, will the required interrupt remain masked, causing jo=
bs
to time out and hang indefinitely?

> +}
> +

[ ... ]

> @@ -970,6 +975,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
>  		return err;
>  	}
> =20
> +	panfrost_mmu_enable_interrupts(pfdev);

[Severity: High]
This is a pre-existing issue, but does enabling the interrupts earlier in
probe expand a race condition during teardown?

If panfrost_device_init() fails after panfrost_mmu_init() (or during
driver unbind), panfrost_mmu_fini() is called:

panfrost_mmu_fini() {
	mmu_write(pfdev, MMU_INT_MASK, 0);
}

This masks the interrupt but doesn't call synchronize_irq().

Subsequently, the downstream teardown disables the clocks:

panfrost_device_fini() {
	panfrost_mmu_fini(pfdev);
	panfrost_gpu_fini(pfdev);
	panfrost_devfreq_fini(pfdev);
	panfrost_regulator_fini(pfdev);
	panfrost_clk_fini(pfdev);
}

If panfrost_mmu_irq_handler_thread() is still running concurrently after
the clocks are disabled, could this lead to a synchronous external abort
or kernel panic when accessing memory-mapped GPU registers?

> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-claude-fix=
es-v5-0-3d692c9e98c2@collabora.com?part=3D6
