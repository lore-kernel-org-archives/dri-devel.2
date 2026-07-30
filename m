Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47DFC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE30F10E104;
	Thu, 30 Jul 2026 03:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JfzhnEly";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3467D10E0D6
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:38:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F56B600AA;
 Thu, 30 Jul 2026 03:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1DC1F000E9;
 Thu, 30 Jul 2026 03:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785382734;
 bh=YGs4mWmdEraeAL7XILm5j/zC6IKpWQd8Uhrmgav7Y1w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JfzhnElyul7+xm5zN65fCw1h+yjLs9aD7MR+eM3+Z6YI06zcv9vf4AZ/AVKpm1cM5
 /bJl3lHHXCXjaMdHfOTkGGk6HBJYO4ud+OJ/TuAbR236KoHPgZHupUEOveIeJ1kAi7
 NV8P1q6diEvmSgRouilo6pgeQGmnUH7b1wgy81vQP5vfGy/XJKx28tU72zJK00cnfm
 YPb718HwqHD+/XiB8qxZYaBY6xP4By7jpjnY+r7GdU3OZBek/TDWg9IxtGyLKqnBj1
 W7j3RpMCEsz241arJ8CY0xbasBhAGeIERHkkNxjBeXZcT0v1e6KPdKCJRpuA5J4rXo
 Gz8j+cYCerJGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/7] drm/bridge: analogix_dp: Extend
 clear_hotplug_interrupts to accept IRQ bitmask
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260730032744.381566-5-damon.ding@rock-chips.com>
References: <20260730032744.381566-1-damon.ding@rock-chips.com>
 <20260730032744.381566-5-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:38:53 +0000
Message-Id: <20260730033854.7D1DC1F000E9@smtp.kernel.org>
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

New issues:
- [High] Data Race in Interrupt Mask Registers During RMW

Pre-existing issues:
- [High] Lost Hardware Hotplug Events Due to Late Status Clearing
--

--- Patch [4]: [PATCH v1 4/7] drm/bridge: analogix_dp: Extend clear_hotplug=
_interrupts to accept IRQ bitmask ---
commit f4ba8e259db1706905ae7d04afdea18e9d5a28d6
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Extend clear_hotplug_interrupts to accept IRQ bitm=
ask

Update analogix_dp_clear_hotplug_interrupts() to take an irq_type
bitmask argument. Instead of clearing all hotplug interrupt bits
unconditionally, only clear the interrupt flags corresponding to the
triggered events.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -733,7 +733,7 @@ static irqreturn_t analogix_dp_irq_thread(int irq, vo=
id *arg)
>  	}
> =20
>  	if (irq_type) {
> -		analogix_dp_clear_hotplug_interrupts(dp);
> +		analogix_dp_clear_hotplug_interrupts(dp, irq_type);

[Severity: High]
This is a pre-existing issue, but can this late clearing cause hardware
hotplug events to be silently lost?

Because the hardware interrupt status is cleared at the end of the threaded
handler, it executes after the time-consuming drm_helper_hpd_irq_event()
completes:

analogix_dp_irq_thread()
    if (hpd_detected) {
        ...
        drm_helper_hpd_irq_event(dp->drm_dev);
    }

If a fast unplug/plug cable bounce occurs exactly while
drm_helper_hpd_irq_event() is executing, the hardware sets the status bit
again. Clearing the write-1-to-clear (W1C) register after this will clear
the new event without triggering a new interrupt.

Should the W1C status registers be cleared immediately after reading their
state, before executing the event handling logic?

>  		analogix_dp_unmute_hpd_interrupt(dp, irq_type);

[Severity: High]
Does this code need a spinlock to protect the interrupt mask registers?

Since the IRQ is requested without IRQF_ONESHOT, the hardirq handler can
preempt the threaded handler. If analogix_dp_unmute_hpd_interrupt() reads
ANALOGIX_DP_COMMON_INT_MASK_4 and gets preempted by a new hardirq that
masks a new event, the resuming threaded handler might overwrite the
register with its stale read value.

Could this cause a hotplug interrupt type to become permanently masked
if the hardirq overwrites the threaded handler's unmute operation?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730032744.3815=
66-1-damon.ding@rock-chips.com?part=3D4
