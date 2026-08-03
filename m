Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9169C55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03ABD10E04F;
	Mon,  3 Aug 2026 13:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fA76GzpW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987FA10E04F
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:43:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A74D360A78;
 Mon,  3 Aug 2026 13:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC021F000E9;
 Mon,  3 Aug 2026 13:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785764633;
 bh=Pmw46fuBrkd835Nkvd/3yXFm6nE3mirI6hdA5ShQNGY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fA76GzpWhXaj3lTC3fbhHo/3FVdD9IcFQBpnKcaAMNfKqUS29QG5IUvGCRWwq6WcH
 2BfKs/SZQiBtdusRoCYRHCC5ihZ7XtcJp4fpZXMrAurcsL/CqkhAKrMyNJ50izR8Kn
 lK8dAGBPJWuMchExPQ709HY8V86P2yCuBAV0fZuGMOpxr9NZkdX8rUW0I43mMoxrUn
 dXqg/qSsHKZSE/oJcHS01oAcWFJmxaT1YdWcw3g1eAGZnclqELMuPApq3qyogWxZep
 ooLg5msHjpYb7BmPLwgwhgpkUefGaefPiTmxodFJRwcyzh7bucUWRueEgmV6EhITqj
 n2y9ckM0w3NLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/tyr: add Job IRQ handling
To: "Laura Nao" <laura.nao@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260728-tyr-irq-v2-v3-1-9c9bc5c029c5@collabora.com>
References: <20260728-tyr-irq-v2-v3-1-9c9bc5c029c5@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:43:52 +0000
Message-Id: <20260803134353.3FC021F000E9@smtp.kernel.org>
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
- [High] Hardware interrupt is eagerly unmasked before the OS-level IRQ han=
dler is registered, creating a race condition that can lead to an unhandled=
 interrupt storm.
- [High] The threaded IRQ handler clears the interrupt status after handlin=
g it, causing a race condition where newly arrived interrupts for the same =
status bits are lost.
--

--- Patch [1]: [PATCH v3] drm/tyr: add Job IRQ handling ---
commit b6b7c4ae779f404042159506914510a46f953463
Author: Laura Nao <laura.nao@collabora.com>

drm/tyr: add Job IRQ handling

This commit adds a threaded IRQ wrapper for Tyr interrupt sources and
implements handling for the firmware Job IRQ. It sets up a wait queue to
signal firmware readiness when the global interface request bit is set.

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 8348c6cd39295..224ee7f2eb3fd 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs

[ ... ]

> +    fn handle_threaded(&self) -> IrqReturn {
> +        let mut ret =3D IrqReturn::None;
> +
> +        loop {
> +            let raw_status =3D self.irq.read_raw_status() & self.irq.mas=
k();
> +            if raw_status =3D=3D 0 {
> +                break;
> +            }
> +            self.irq.handle(raw_status);
> +            self.irq.clear_status(raw_status);

[Severity: High]
Is it possible to lose hardware events here?

By calling handle() before clear_status(), if the hardware re-asserts
the same interrupt bit while handle() is executing, the subsequent
clear_status() will write the original raw_status bits to the
Write-1-to-Clear register.

This could inadvertently wipe out the newly arrived event, causing the
next iteration of the loop to read 0 and the new event to never be
handled. Should clear_status() be called before handle() to avoid this race?

> +            ret =3D IrqReturn::Handled;
> +        }
> +
> +        self.irq.reenable_mask();
> +        ret
> +    }
> +}

> diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.rs
> new file mode 100644
> index 0000000000000..6eeb1399a7b30
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw/irq.rs

[ ... ]

> +pub(crate) unsafe fn job_irq_init<'a>(
> +    pdev: &'a platform::Device<Bound>,
> +    iomem: Arc<IoMem<'a>>,
> +    fw_ready: Arc<AtomicBool>,
> +    job_irq_wait: Arc<WaitQueue>,
> +) -> Result<impl PinInit<ThreadedRegistration<'a, TyrIrq<JobIrq<'a>>>, E=
rror> + 'a> {
> +    iomem.write_reg(JOB_IRQ_MASK::zeroed().with_glb(true));

[Severity: High]
Could this cause an unhandled interrupt storm?

This writes to JOB_IRQ_MASK to enable the interrupt on the hardware
immediately, but returns a deferred PinInit descriptor for the OS-level
handler registration.

Because the actual OS-level handler registration is deferred until the
caller pins and executes this descriptor, there is a window where the
hardware can assert an interrupt that the OS has no handler for.

If the interrupt line is shared, could this cause the kernel to permanently
disable the IRQ line? Should the hardware mask be enabled only after
the handler is fully registered?

> +    let job_irq =3D JobIrq {
> +        iomem: iomem.clone(),
> +        fw_ready,
> +        job_irq_wait,
> +    };
> +    // SAFETY: The caller guarantees the resulting registration will not=
 be leaked.
> +    unsafe { TyrIrq::request(pdev, c_str!("job"), job_irq) }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-tyr-irq-v2=
-v3-1-9c9bc5c029c5@collabora.com?part=3D1
