Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F452C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6B9610F447;
	Thu,  2 Jul 2026 15:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CYFZru8P";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02BBC10F447
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:13:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99A05418B6;
 Thu,  2 Jul 2026 15:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4EC1F000E9;
 Thu,  2 Jul 2026 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783005226;
 bh=gp9pXNoxQzvo0zpbPliIgFuIXZmIcJOvJ1x2DtugghU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CYFZru8PZV91KOm35CbOWlpYUgYOeADUJ9HDHFYhMk4MpfYguHM3+w9aRt2eM5GqL
 N2aLLlNQhgRaOsz2w1sVkSVfhk3rZ7xlUQI2MD5IzMTE9qJu5ee9wPuVVv+3Zlc8Ag
 tIVcgbX26PIWgZdjrO6H77P0zZ6mR1tHIZ2qHHYFGRmy1lYjdpc4ZiBoCdzAusO++0
 Dz03LJ2BjZ/sYZMnP4UMof4qS3acGzbt/iqk7A/fWLQRuSCgOoF8GlEaDdMmPtUfg/
 BKzfhKpzIstZnuNuswIJSUhrhyGDlQ60BFccY1P1V5sCcE2LpRh4rgCZCSxs7fGafw
 es5/Is4Uiadtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 26/39] drm/rockchip: dw_hdmi_qp: Implement
 .{enable|disable}_hpd() PHY ops
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-26-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-26-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:13:45 +0000
Message-Id: <20260702151346.5A4EC1F000E9@smtp.kernel.org>
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

New issues:
- [Medium] Threaded IRQ handler unconditionally re-enables the HPD interrup=
t, racing with DRM core state.

Pre-existing issues:
- [High] Hardirq handlers check an unmasked global status register, causing=
 spurious wakeups and potentially missing unplug events.
- [High] Missing IRQ disable before cancel_delayed_work_sync() in unbind ca=
uses a use-after-free.
--

Note: Due to system recitation constraints, I cannot include the quoted dif=
f=20
hunks in this review. The feedback below uses a free-form summary of the=20
locations instead of inline diff comments.

commit d6251e05f12f1c50b3e31b91e1dfea22e19df9e0
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: drm/rockchip: dw_hdmi_qp: Implement .{enable|disable}_hpd() PHY ops

This commit implements the enable_hpd() and disable_hpd() phy operations
for the RK3576 and RK3588 SoCs. It also consolidates the interrupt
clear-and-unmask sequences to replace open-coded register writes.

[Severity: Medium]
In drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c, specifically within the
threaded IRQ handlers dw_hdmi_qp_rk3588_irq() (around line 409) and
dw_hdmi_qp_rk3576_irq() (around line 382), does the unconditional call to
enable_hpd() race with the DRM core?

With the introduction of the .enable_hpd and .disable_hpd PHY operations,
the DRM core expects to dynamically control HPD activation (for instance,
masking it during suspend). If an HPD event triggers just before the core
disables HPD, the hardirq handler schedules the threaded handler. Since the
threaded handler finishes by unconditionally unmasking the interrupt via
enable_hpd(), won't this override the DRM core's explicit request to keep
the interrupt disabled? This seems like it could leave the interrupt armed
unexpectedly and potentially cause spurious wakeups.

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be an issue
in the hardirq handlers dw_hdmi_qp_rk3588_hardirq() (around line 394) and
dw_hdmi_qp_rk3576_hardirq() (around line 367).

These functions read the shared status registers (RK3588_GRF_SOC_STATUS1 or
RK3576_IOC_HDMI_HPD_STATUS) and check if the value is non-zero without
applying a port-specific mask. Because no mask is applied, could any set bit
in these shared registers trigger a spurious thread wakeup?

Additionally, if these registers reflect the physical level (as used in
read_hpd), an unplug event would result in a level of 0. If no other bits
are set, the handler evaluates "if (intr_stat)" as false and returns
IRQ_NONE. Does this mean the driver will fail to wake the thread and
completely miss the disconnect event?

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
in the unbind path involving dw_hdmi_qp_rockchip_unbind() and the IRQ
handlers.

In the unbind path, cancel_delayed_work_sync() is called to stop the HPD
debounce work, but the hardware interrupt isn't explicitly disabled first.
If an HPD interrupt fires during or just after the cancellation, the hardirq
will wake the threaded handler (e.g., dw_hdmi_qp_rk3588_irq() at line 409),
which then calls mod_delayed_work() to re-arm the timer.

When the module unloads or the workqueue is destroyed, won't this pending
timer fire and execute unmapped memory, resulting in a kernel panic? Should
the IRQ be explicitly disabled before cancelling the delayed work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D26
