Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5270FC5DF9D
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A474D10E3BA;
	Thu, 27 Aug 2026 08:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ESS16Hmn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFC510E3BA
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:14:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4C91600D2;
 Thu, 27 Aug 2026 08:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443EE1F000E9;
 Thu, 27 Aug 2026 08:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787818456;
 bh=t20+6dzRGs+dHZ39xsofIQsFVsiBILWyQWFfwdY21Gc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ESS16HmnRGexIGHl9MQQCI2/WUV1NT1QHopqjGIoGN65puz77E6sJTJ+OH7MfQVb2
 LEKCVuXDdRqtZXufH59IJn73w5ftRWpVeuVz4y3DK1kTMxVpLssqu8v6zCEegkoDQY
 Z3dUjvaTPF+odfQOu6Kfa/UXkw8H8VmZGezPZW+hg5jnLejCOQ4hbzAjfdZ/1x6tkK
 kjS2UR2j3l6F2t6GS4wF6LM2x2DfXc3warLWEc3ya/XaLZjoiiBUxH7iDa7awL4QD8
 lD/pUpmVmGGOdjA9Ap5hResTBqDmLKye/nkPa+PtW0sZ6PbUySE5DGHWv5nTdtfnRH
 G6e+GeT/Ojy1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] drm/tyr: add Job IRQ handling
To: "Laura Nao" <laura.nao@collabora.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-tyr-irq-v2-v6-2-15c90baed949@collabora.com>
References: <20260728-tyr-irq-v2-v6-0-15c90baed949@collabora.com>
 <20260728-tyr-irq-v2-v6-2-15c90baed949@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 08:14:15 +0000
Message-Id: <20260827081416.443EE1F000E9@smtp.kernel.org>
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
- [High] JobIrqEvents::wait_ready discards the timeout result from wait_eve=
nt_timeout, improperly returning success even if the wait times out.
- [High] Race condition during IRQ teardown between JobIrqMaskGuard and the=
 threaded IRQ handler leaves the hardware interrupt incorrectly unmasked.
--

commit 56688d4ee1c985c61ffa39c42b540903cfd3dca8
Author: Laura Nao <laura.nao@collabora.com>

drm/tyr: add Job IRQ handling

This commit adds Job IRQ handling to report requests from the CSF firmware,
including global interface requests to check firmware readiness. It adds
JobIrqEvents to signal readiness and JobIrqMaskGuard to ensure the Job IRQ
is masked before registration is freed.

> diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.rs
> new file mode 100644
> index 0000000000000..7dd894de18cb2
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw/irq.rs

[ ... ]

> +    /// Waits until the firmware signals readiness via the GLB IRQ bit, =
or the timeout expires.
> +    pub(crate) fn wait_ready(&self, timeout_ms: Msecs) -> Result {
> +        self.wait.wait_event_timeout(
> +            || self.ready.load(ordering::Acquire),
> +            msecs_to_jiffies(timeout_ms),
> +        )?;
> +
> +        Ok(())
> +    }

[Severity: High]
Does this code accidentally discard the timeout result from
wait_event_timeout()?=20

The ? operator will only unwrap wait queue errors, but the actual return
value indicating whether the wait timed out or completed is discarded by
the semicolon, resulting in an unconditional Ok(()) return.=20

Could this cause the driver to proceed as if the firmware successfully
signaled readiness even when the initialization timed out, leading to=20
invalid hardware interactions or driver hangs?

[ ... ]

> +pub(crate) struct JobIrqMaskGuard<'a>(Arc<IoMem<'a>>);
> +
> +impl Drop for JobIrqMaskGuard<'_> {
> +    fn drop(&mut self) {
> +        self.0.write_reg(JOB_IRQ_MASK::zeroed());
> +    }
> +}

[Severity: High]
Can this mask guard race with the threaded IRQ handler during teardown?

During driver teardown, this Drop implementation zeroes the hardware IRQ
mask before the ThreadedRegistration is dropped. However, if the
threaded handler handle_threaded() is running concurrently on another CPU,
it finishes its execution by unconditionally calling
self.irq.reenable_mask().

If the handler's reenable_mask() executes after this Drop but before
free_irq() completes, it would leave the hardware interrupt incorrectly
unmasked. Since the handler is being unregistered, could this lead to an
unhandled interrupt storm on the shared IRQ line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-tyr-irq-v2=
-v6-0-15c90baed949@collabora.com?part=3D2
