Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21A5C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E083310FB54;
	Tue, 15 Sep 2026 10:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MD529qBQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B656B10FB54
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:59:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A03B602C4;
 Tue, 15 Sep 2026 10:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DAA1F00893;
 Tue, 15 Sep 2026 10:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789469955;
 bh=MxEe2Lo7w/D52n9l2TGx+I1QZn4Kk7wjxsiWWPNYUgI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MD529qBQMSnrB16ur7srg3DJqJVLlmQ0rjnRgV5MhTU2u6Unqx/hyE3wKMaj9BIdr
 OOalVvzUb9IY5mlEJthEo9nH+F/1G8TGyXB1BNgfQe4HRutYAyNpKz2V0kRBSJFA55
 5KQdN5u6uvNg5CuerB7q87/kD9Kr8F/8iwSCoHf1RGPqTCfk3JYXq/pQW4kbprbgEN
 M626LEM9zAibe8BTYNbP7KB2UBEQ//JwWOUsYhHDXYNgg/s6ayZG+gajz8iriZZOSz
 /rfSn8sGJZ1kZnEYPAqfAh05FBEtb0dx1DUSu9shq78RkLnDmaCMvhdaW6KakGNLAC
 ERT/fd/tE5ALQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/14] accel/rocket: wait for a running IRQ handler
 before resetting a core
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260915104328.45901-4-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-4-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 10:59:15 +0000
Message-Id: <20260915105915.96DAA1F00893@smtp.kernel.org>
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
- [High] rocket: interrupt masking bypassed when PM is disabled or suspendi=
ng
--

commit 514c825015ef4be7a517e9ee1eca6f94eae37e6d
Author: Jiaxing Hu <gahing@gahingwoo.com>
Subject: accel/rocket: wait for a running IRQ handler before resetting a co=
re

This commit introduces a mechanism to wait for a threaded IRQ handler that
might already be running when rocket_reset() is called. It masks the
interrupt block, clears the raw status, and calls synchronize_irq() to
prevent a concurrent handler from running. It uses
pm_runtime_get_if_active() to avoid writing to registers while the power
domain is down, preventing an SError.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.c=
om/
Link: https://lore.kernel.org/all/CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8=
HoMtHD5U1g@mail.gmail.com/
Link: https://lore.kernel.org/all/20260912113717.6819-1-royalnet026@gmail.c=
om/

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 575945015ca3b..dfe9135d86af5 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -377,9 +377,68 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
hed_job *bad)
[ ... ]
> +	 * pm_runtime_get_if_active() does not invoke a callback -- it only
> +	 * takes a reference on an already-active device -- and
> +	 * pm_runtime_put_autosuspend() is asynchronous, so neither can re-enter
> +	 * this driver's runtime PM callbacks while the lock is held.
> +	 */
> +	scoped_guard(mutex, &core->job_lock) {
> +		if (pm_runtime_get_if_active(core->dev) > 0) {
> +			rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
> +			rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> +			pm_runtime_put_autosuspend(core->dev);
> +		}
> +	}
> +
> +	/*
> +	 * drm_sched_stop() returns without waiting for a threaded handler that
> +	 * is already running, so wait for one here. This has to stay outside
> +	 * job_lock: the handler takes that lock, so waiting for it while
> +	 * holding it would deadlock instead of fencing anything.
> +	 */
> +	synchronize_irq(core->irq);

[Severity: High]
Does this logic bypass interrupt masking when PM is disabled or during syst=
em
suspend?

If CONFIG_PM is disabled, pm_runtime_get_if_active() unconditionally returns
-EINVAL, which evaluates to <=3D 0.

Additionally, during system suspend, the driver uses
pm_runtime_force_suspend(). This increments the PM disable_depth before
invoking the runtime suspend callback to turn off the clocks. Because
disable_depth is non-zero, pm_runtime_get_if_active() returns -EINVAL even
though the device is still fully active at that point.

In both of these scenarios, the condition evaluates to false and the crucial
interrupt masking is skipped.

Since the hardware remains active and the interrupt is unmasked, can the
handler fire concurrently with or immediately after synchronize_irq(),
recreating the exact race condition this code aims to close?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915104328.4590=
1-1-gahing@gahingwoo.com?part=3D3
