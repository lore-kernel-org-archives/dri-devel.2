Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9191CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3235F10E5DC;
	Thu, 15 Oct 2026 17:13:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB56110E5DC
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 17:13:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 75E1D42EB5
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 17:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A741F000C4;
 Thu, 15 Oct 2026 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792084399;
 bh=zQJL1mYgJLSCxXVg07O3jIaxaXq+Z6ljLmvqQAhnciA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=br0TiYJXh37GoZAyz2kI118pKReiwwB91b4w+Lq5E87WSpAgJLdvis1VtBv6wf6mn
 byWLAIJehvS8iwKTQZB5fHWjZlxZoJ8XR3m/Nn/dkEdjBFXHYXfbKwetiuz0d4VRSP
 WuzR8g0ysus83iiGGaVuJKbgJEQqxPGh7YhmhtFjbTXihJb546Lj9F8Wsy2gp4S3v+
 N3XXMJToNOEuDnhg1yELbZLQgsjRE3F4pA2ryCjWa6wWpYAob+cX7XIyFpXHxs1K+c
 +vGXpRWhKkBTQCC/FOYSVcs2ufWE9NW25/fqF2DSY1MAsyV31ATudJ5YdI8dxKVKge
 jIHWK0uzNN4Xw==
Message-ID: <sashiko-outbox-173243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 26/28] drm/tidss: Implement readout support
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-26-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-26-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 17:13:18 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm/tidss: uninitialized stack memory info leak in crtc readout
- [High] drm/tidss: integer overflow in calc_pixel_clock_hz() on 32-bit arc=
hs
- [High] drm/tidss: unhandled clock enable failure causes external abort cr=
ash
- [Medium] drm/tidss: memory leak of readout framebuffer on multi-crtc hard=
ware
- [Medium] drm/tidss: permanent clock reference leak via double-enable in r=
eadout
- [Medium] drm/tidss: plane readout fails unconditionally on multi-crtc har=
dware
- [Medium] drm/tidss: clock enable count leak and underflow in CRTC readout=
/install
--

commit 5f7c5b078a348c064d70aaabd04294cf1916f772
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: Implement readout support

With the hardware readout infrastructure now in place in the KMS
framework, we can provide it for the tidss driver.

> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/t=
idss_crtc.c
> index 3da49f77fa080..666b950278ee4 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
[ ... ]
> @@ -370,6 +374,93 @@ static struct drm_crtc_state *tidss_crtc_create_stat=
e(struct drm_crtc *crtc)
>  	return &tstate->base;
>  }
> =20
> +static int tidss_crtc_readout_state(struct drm_crtc *crtc,
> +				    struct drm_atomic_sro_state *state,
> +				    struct drm_crtc_state *crtc_state)
> +{
[ ... ]
> +	struct drm_display_mode mode;
> +	int ret;
> +

[Severity: High]
Can this uninitialized stack memory be leaked to userspace?

This struct is allocated on the stack without zero-initialization. When it =
is
passed to dispc_vp_readout_mode(), only some fields are populated, and the
flags field is modified using a bitwise OR, preserving the stack garbage. T=
he
struct is then copied to the CRTC state via drm_atomic_set_mode_for_crtc(),
which can expose the uninitialized kernel stack memory directly to userspac=
e.

> +	tidss_runtime_get(tidss);
> +
> +	if (!dispc_vp_is_enabled(dispc, tcrtc->hw_videoport))
> +		goto out;
> +
> +	/*
> +	 * The display is active, we need to enable our clock to have
> +	 * proper reference count.
> +	 */
> +	WARN_ON(dispc_vp_enable_clk(tidss->dispc, tcrtc->hw_videoport));

[Severity: High]
Does this unhandled clock enable failure cause a kernel panic on ARM platfo=
rms?

If dispc_vp_enable_clk() fails here, the code logs a warning but proceeds to
access the display controller's MMIO registers in dispc_vp_readout_mode(). =
On
ARM architectures, reading from an unclocked peripheral triggers a bus error
and an immediate external abort crash.

[Severity: Medium]
Can this clock enable cause an underflow in the reference count on error?

If this initial dispc_vp_enable_clk() fails, tidss_crtc_atomic_disable() wi=
ll
later unconditionally call dispc_vp_disable_clk(), underflowing the clock
enable count. Additionally, if the clock enables successfully but a subsequ=
ent
error occurs during readout, there is no error cleanup to disable the clock.

> +
> +	tstate->base.active =3D 1;
> +	tstate->base.enable =3D 1;
[ ... ]
> +static void tidss_crtc_install_state(struct drm_crtc *crtc,
> +				     struct drm_crtc_state *crtc_state)
> +{
> +	struct tidss_crtc *tcrtc =3D to_tidss_crtc(crtc);
> +	struct drm_device *ddev =3D crtc->dev;
> +	struct tidss_device *tidss =3D to_tidss(ddev);
> +	int ret;
> +
> +	tidss_runtime_get(tidss);
> +
> +	ret =3D dispc_vp_enable_clk(tidss->dispc, tcrtc->hw_videoport);
> +	if (ret !=3D 0)
> +		return;

[Severity: Medium]
Does this second clock enable cause a permanent reference count leak?

The video port clock was already enabled during tidss_crtc_readout_state().
Enabling it a second time here double-increments the reference count. Since
tidss_crtc_atomic_disable() only disables the clock once, this leaves a
permanent clock reference leak on the success path, preventing the hardware
from entering low-power states.

> +
> +	/* Turn vertical blanking interrupt reporting on. */
> +	drm_crtc_vblank_on(crtc);
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index fdd3b166c1181..50e6d9fb92083 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
[ ... ]
> +static unsigned long calc_pixel_clock_hz(unsigned int htotal,
> +					 unsigned int vtotal,
> +					 unsigned int refresh,
> +					 unsigned int freq_div)
> +{
> +	unsigned long rate =3D (unsigned long)htotal * vtotal * refresh;
> +
> +	return (rate * 1000) / freq_div;
> +}

[Severity: High]
Does this multiplication overflow on 32-bit architectures?

On 32-bit platforms (such as the ARM32 K2G SoCs supported by this driver),
rate uses 32-bit unsigned arithmetic. For a standard 1080p60 display, rate =
is
roughly 148,500,000. Multiplying this by 1000 yields 148,500,000,000, which
drastically exceeds the 32-bit maximum. This overflow results in a corrupted
clock frequency and breaks refresh rate calculations.

[ ... ]
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/=
tidss_plane.c
> index b0d5d6959b885..32b80a3f8f7d3 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
[ ... ]
> +static struct drm_crtc *tidss_plane_readout_crtc(struct drm_plane *plane)
> +{
> +	struct drm_device *dev =3D plane->dev;
> +
> +	if (dev->num_crtcs !=3D 1)
> +		return ERR_PTR(-EINVAL);

[Severity: Medium]
Will this intentionally break plane state readout on devices with multiple
video ports?

The hardware natively supports multiple CRTCs (e.g., AM65x has two video
ports), but this hardcoded check causes plane readout to fail unconditional=
ly
on any multi-CRTC configuration. Hardware routing registers likely need to =
be
read to dynamically determine which CRTC the plane is connected to.

> +
> +	return list_first_entry(&dev->mode_config.crtc_list, struct drm_crtc, h=
ead);
> +}
> +
> +static int tidss_plane_atomic_readout_state(struct drm_plane *plane,
> +					    struct drm_atomic_sro_state *state,
> +					    struct drm_plane_state *plane_state)
> +{
[ ... ]
> +	fb =3D tidss_plane_readout_fb(plane);
> +	if (IS_ERR(fb)) {
> +		ret =3D PTR_ERR(fb);
> +		goto err_runtime_pm;
> +	}
> +
> +	crtc =3D tidss_plane_readout_crtc(plane);
> +	if (IS_ERR(crtc)) {
> +		ret =3D PTR_ERR(crtc);
> +		goto err_runtime_pm;
> +	}

[Severity: Medium]
Does this error path leak the dummy framebuffer?

tidss_plane_readout_fb() allocates and initializes fb with a reference count
of 1. If tidss_plane_readout_crtc() fails (which it does unconditionally on
multi-CRTC hardware), the code jumps to err_runtime_pm, bypassing the
assignment to plane_state->fb. Since drm_framebuffer_put() is never called,
the framebuffer memory and its IDR entry are permanently leaked.

> +
> +	plane_state->fb =3D fb;
> +	plane_state->crtc =3D crtc;
> +	plane_state->visible =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D26
