Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F813CD8CB9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74E710ECEA;
	Thu, 11 Jun 2026 06:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ddIkvX3t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3341710ECEA
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 06:18:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0EF6640664
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 06:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFD91F00893;
 Thu, 11 Jun 2026 06:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781158685;
 bh=RDAcEPw+bUlWtLZfPw7jqJISQa126CwdjAY4eH20OKI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ddIkvX3tEao8DPS1iRZ/V1C9tHKHhnY+//hfxlc6NMji2d0buUHkXG6gBTXqYJu5B
 yjzAiaQwxWDds0W/HG1LgElDs5YYZTAecRn1JNHDJUzHuJ11+jnnOBd2qLZrU5liER
 KWwJQ49UiPy2RLR7kCUC6/c6z9dEP5H1WFtpmAad8GKngsm4wIVt7vOP5N1M91y83x
 DlMfEPhzqpJogFSAqjdfhY1mcpAUqLSAxAV3B+klGMRi/O0qwQN5imaNCd2d35L3UL
 oViAxrg5bxPLi8ni7m1n+qSLzOFMj9HjTEk2sJjt2XYIfdWxmqZuzN0bN0lU1yJNuv
 C/N5gUV1efrnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/msm/mdp4: keep inherited display clocks enabled
 until modeset
To: "Alexandre MINETTE via B4 Relay" <devnull+contact.alex-min.fr@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-2-22925600e4f2@alex-min.fr>
References: <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-2-22925600e4f2@alex-min.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:18:05 +0000
Message-Id: <20260611061805.BEFD91F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unchecked clk_prepare_enable() return values can lead to synchrono=
us external aborts during MMIO access or unbalanced clock disables.
- [High] The patch explicitly turns off `pclk` and `axi_clk` during probe, =
which can break the inherited display pipeline.
- [High] Inherited display clocks are leaked indefinitely if DRM components=
 fail to bind, if the CRTC is disabled without being enabled first, or if u=
serspace never initiates a modeset.

Pre-existing issues:
- [High] Calling sleeping functions from atomic context in CRTC atomic enab=
le callback.
--

commit deec425702ee01b881e4c0a6e40e6ec4f167024f
Author: Alexandre MINETTE <contact@alex-min.fr>

drm/msm/mdp4: keep inherited display clocks enabled until modeset

This patch detects if the MDP4 display pipeline was already enabled by
firmware and keeps the required display clocks prepared to prevent panel
glitches. It drops the extra clock references on the first DRM CRTC
enable when the driver takes ownership.

> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/=
msm/disp/mdp4/mdp4_crtc.c
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> @@ -297,6 +297,7 @@ static void mdp4_crtc_atomic_enable(struct drm_crtc *=
crtc,
> =20
>  	mdp4_enable(mdp4_kms);
>  	mdp4_crtc_bus_get(mdp4_kms);
> +	mdp4_inherited_display_clocks_put(mdp4_kms);

[Severity: High]
Will the inherited clock references be leaked if the display components
never bind or if userspace never initiates a modeset?

If msm_drv_probe() successfully adds the master component but the required
display components fail to bind, the mdp4_destroy() callback is never
executed. If userspace never initiates a modeset or explicitly disables
the display first, atomic_enable is never reached. In these cases, it
appears the driver holds explicit clk_prepare_enable references that will
bypass the clock framework's late initcalls, leaving the hardware fully
powered on indefinitely.

[Severity: High]
This is a pre-existing issue, but does adding this call here worsen a
violation of atomic context rules?

CRTC atomic enable callbacks run in atomic context during non-blocking
commits, where sleeping is strictly forbidden. The mdp4_crtc_atomic_enable()
function already contained sleeping calls like mdp4_enable(), and this
patch adds mdp4_inherited_display_clocks_put() which acquires a mutex and
calls clk_disable_unprepare(). Both of these operations can sleep. Could
this lead to kernel might_sleep() warnings or deadlocks during non-blocking
commits?

> =20
>  	/* Restore vblank irq handling after power is enabled */
>  	drm_crtc_vblank_on(crtc);

[ ... ]

> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/m=
sm/disp/mdp4/mdp4_kms.c
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
[ ... ]
> +static void mdp4_inherited_display_clocks_get(struct mdp4_kms *mdp4_kms)
> +{
> +	bool inherited_display;
> +
> +	mutex_lock(&mdp4_kms->clock_lock);
> +
> +	clk_prepare_enable(mdp4_kms->clk);
> +	clk_prepare_enable(mdp4_kms->pclk);
> +	clk_prepare_enable(mdp4_kms->lut_clk);
> +	clk_prepare_enable(mdp4_kms->axi_clk);

[Severity: High]
Is it safe to proceed with hardware MMIO reads if any of these clocks fail
to enable?

The return values from clk_prepare_enable() are completely ignored here.
If enabling the core or bus clock fails, the driver will proceed to perform
MMIO reads in mdp4_has_inherited_display_state() on unclocked hardware. On
MSM platforms, accessing unclocked registers typically triggers an unhandled
synchronous external abort, resulting in a kernel panic. Should these
return values be checked and handled?

> +
> +	inherited_display =3D mdp4_has_inherited_display_state(mdp4_kms);
> +
> +	if (inherited_display) {
> +		clk_prepare_enable(mdp4_kms->clk);
> +		clk_prepare_enable(mdp4_kms->lut_clk);
> +		mdp4_kms->inherited_display_clocks_held =3D true;
> +	}
> +
> +	clk_disable_unprepare(mdp4_kms->clk);
> +	clk_disable_unprepare(mdp4_kms->pclk);
> +	clk_disable_unprepare(mdp4_kms->lut_clk);
> +	clk_disable_unprepare(mdp4_kms->axi_clk);

[Severity: High]
Will unconditionally disabling pclk and axi_clk here break the inherited
display pipeline?

The Linux Common Clock Framework initializes clocks left on by the
bootloader with a software usage count of 0. By temporarily enabling and
then disabling them, the usage count goes from 0 to 1 and back to 0. This
triggers the framework to physically turn off the hardware clocks
immediately. Disabling the pixel clock (pclk) and memory bus clock
(axi_clk) while the hardware is actively scanning out a frame will
typically starve the pipeline, causing bus hangs, underflows, or the exact
blank screen this patch aims to prevent. Should the active state of these
clocks be preserved if an inherited display is detected?

> +
> +	mutex_unlock(&mdp4_kms->clock_lock);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-mainline-f=
ix-mdp4-blue-screen-sending-v1-v1-0-22925600e4f2@alex-min.fr?part=3D2
