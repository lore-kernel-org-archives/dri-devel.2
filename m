Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16F3CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B2310E20F;
	Mon, 15 Jun 2026 07:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cfc6tNOr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6975410E20F
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 07:02:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 42B7544157;
 Mon, 15 Jun 2026 07:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E115A1F00A3A;
 Mon, 15 Jun 2026 07:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781506951;
 bh=ROhl+H8CKmwP05tul4I5SAinWh6QnIH18Sd7+LacEz0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cfc6tNOrpqQq3jgkHsTHoXKc+pqxYdm5uas/QATVGjnJjMexN1TXRKvFcPdL2YqzX
 dXiTK7e0mzSYpE5t30NDuMBSz+ZcUpZLDwd1HdCwGjxH/f8OLxcmCl7BQ4VTmol2OC
 ZgUFPvOPtRaa/Bp6CSj+y/BzCaOzPoqnZVJyr4DcVYG2mwTnDXcTBSFcCT6zCoRXd/
 /iaDJJtyp41Y+xGXutxR70GA/4xxLgRj7ZhYwv8oC/RI7R1wWP4DVWCjiaFaDLZgFC
 wmW1x171CjGUAbqYxZuf5FV5/tHxILZp6npiZjaJDeBGMOjw1je0feISfo7AxP34TP
 s1R8ueQjTlX7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] drm/verisilicon: introduce per-variant hardware
 ops table
To: "Joey Lu" <a0987203069@gmail.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260615065003.76661-4-a0987203069@gmail.com>
References: <20260615065003.76661-4-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 07:02:30 +0000
Message-Id: <20260615070230.E115A1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The newly introduced `crtc_disable` hardware hook is invoked after=
 disabling the pixel clock, which will cause unclocked hardware accesses an=
d potential bus hangs.
- [High] The disable sequence for the display panel incorrectly swaps the o=
rder of clearing PANEL_START and PANEL_CONFIG, violating the required rever=
se-enable hardware sequence.

Pre-existing issues:
- [High] Sleepable clock control functions (`clk_prepare_enable` and `clk_d=
isable_unprepare`) are called inside DRM atomic commit callbacks where slee=
ping is strictly forbidden.
- [High] The primary plane disable logic incorrectly sets the `VSDC_FB_CONF=
IG_EX_FB_EN` bit instead of clearing it, failing to actually disable the pl=
ane.
- [High] Calling `regmap_read` in a hardirq handler uses a standard spinloc=
k which maps to a sleeping `rt_mutex` on PREEMPT_RT.
- [High] Primary plane update programs hardware registers with unclipped de=
stination coordinates (`state->crtc_x` / `state->crtc_y`) which can be nega=
tive.
--

commit 7db852133467fb896e651ada4802a06233540439
Author: Joey Lu <a0987203069@gmail.com>
drm/verisilicon: introduce per-variant hardware ops table

This commit introduces a hardware operations table for different variants
of the Verisilicon display controller. It extracts DC8200-specific ops
into a new file and updates the bridge, CRTC, and plane code to use the
new vtable instead of direct register access.

> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/veri=
silicon/vs_crtc.c
> index 0b8a35d09cd2e..679d6541ba1b9 100644
> --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c

[ ... ]

> @@ -26,10 +49,16 @@ static void vs_crtc_atomic_disable(struct drm_crtc *c=
rtc,
>  	struct vs_dc *dc =3D vcrtc->dc;
>  	unsigned int output =3D vcrtc->id;
> =20
>  	drm_crtc_vblank_off(crtc);
> =20
>  	clk_disable_unprepare(dc->pix_clk[output]);

[Severity: High]
This is a pre-existing issue, but does calling clk_disable_unprepare() here
and clk_prepare_enable() in vs_crtc_atomic_enable() cause a sleep in atomic
context?

Since atomic_enable and atomic_disable callbacks execute in an atomic
context during non-blocking commits, calling sleepable clock control
functions could lead to deadlocks or kernel panics.

> +
> +	if (dc->funcs->crtc_disable)
> +		dc->funcs->crtc_disable(dc, output);
>  }

[Severity: High]
Does this sequence write to hardware registers while the pixel clock is
disabled?

Calling dc->funcs->crtc_disable(dc, output) after clk_disable_unprepare()
means we are performing register accesses without a running clock, which
could lead to bus hangs or failed writes.

Should the order be reversed to match the symmetric enable sequence?

[ ... ]

> diff --git a/drivers/gpu/drm/verisilicon/vs_dc8200.c b/drivers/gpu/drm/ve=
risilicon/vs_dc8200.c
> new file mode 100644
> index 0000000000000..800df9279e9b6
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_dc8200.c

[ ... ]

> +static void vs_dc8200_panel_disable_ex(struct vs_dc *dc, unsigned int ou=
tput)
> +{
> +	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_CONFIG(output),
> +			  VSDC_DISP_PANEL_CONFIG_RUNNING);
> +	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> +			  VSDC_DISP_PANEL_START_MULTI_DISP_SYNC |
> +			  VSDC_DISP_PANEL_START_RUNNING(output));
> +
> +	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(output),
> +			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> +}

[Severity: High]
Does this swap the order of clearing the panel registers compared to the
original vs_bridge_atomic_disable() code?

The original code correctly cleared VSDC_DISP_PANEL_START before
VSDC_DISP_PANEL_CONFIG.

Clearing CONFIG while the display pipeline is still actively running could
cause an unprotected hardware state transition, leading to pipeline
underflows or hardware hangs.

[ ... ]

> +static void vs_dc8200_primary_plane_disable_ex(struct vs_dc *dc, unsigne=
d int output)
> +{
> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +			VSDC_FB_CONFIG_EX_FB_EN);
> +
> +	vs_dc8200_plane_commit(dc, output);
> +}

[Severity: High]
This is a pre-existing issue, but does this function actually disable the
plane?

It looks like regmap_set_bits() is used on VSDC_FB_CONFIG_EX_FB_EN, which
would keep the plane enabled in hardware.

Should this use regmap_clear_bits() instead to properly clear the bit and
disable the plane?

> +static void vs_dc8200_primary_plane_update_ex(struct vs_dc *dc, unsigned=
 int output,
> +				       struct drm_plane_state *state)
> +{
> +	regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
> +		     VSDC_MAKE_PLANE_POS(state->crtc_x, state->crtc_y));
> +	regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
> +		     VSDC_MAKE_PLANE_POS(state->crtc_x + state->crtc_w,
> +					 state->crtc_y + state->crtc_h));

[Severity: High]
This is a pre-existing issue, but what happens if the user provides negative
coordinates when a plane is partially off-screen?

Because state->crtc_x and state->crtc_y are unclipped, a negative value
passed to VSDC_MAKE_PLANE_POS() might be bitwise ANDed with 0x7fff,
producing a massive positive value (for example, -10 becomes 32758).

Should clipped coordinates be used here instead to avoid incorrect display
output?

[ ... ]

> +static u32 vs_dc8200_irq_ack(struct vs_dc *dc)
> +{
> +	u32 irqs;
> +
> +	regmap_read(dc->regs, VSDC_TOP_IRQ_ACK, &irqs);
> +	return irqs;
> +}

[Severity: High]
This is a pre-existing issue, but could this regmap_read() cause a
sleep-in-atomic panic on PREEMPT_RT systems?

Since this is invoked from vs_dc_irq_handler() in hardirq context, and the
regmap configuration does not seem to set use_raw_spinlock =3D true, the
regmap infrastructure uses a standard spinlock.

On PREEMPT_RT, this maps to a sleepable rt_mutex.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615065003.7666=
1-1-a0987203069@gmail.com?part=3D3
