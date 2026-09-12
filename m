Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40BCC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 22:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38DE10E6DC;
	Sat, 12 Sep 2026 22:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EO/qaLNE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB4E10E6DC
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 22:39:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9D5860008;
 Sat, 12 Sep 2026 22:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3307E1F000FF;
 Sat, 12 Sep 2026 22:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789252739;
 bh=oDE0DhyHeZQzzJR26HWke5PaQC52gVOSjB1TqvZ1axE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EO/qaLNETg9Zl9Sr5GpKRmrjjySh7VS4peS6J1BbjkdMh8Tdzyz1/G5+keLq8kiI+
 DWuZJVnA5WTvAMWawi90hmoqQSEgZBHanS4zUekcfGBRBL5nYnivE/A8dRo2FxAodJ
 XKD5oxRq97H3GJKUqh01OOHmTmIibqZ8fnaePMX4rTlatA97+rpaeFFVy95yu03yoU
 2LxlNDBsOXelEyc9hS53B1KWP0uU11O1DXfudtkzD5M0UYjgDZedwYTnimnf7pl83v
 gdm8Zeyqi+cieLbxzHvyy1iV5voB3enIbbW5Vi5F5Wjg/mCDdc5+1cmGVUi3DMIDil
 iAoFR6kHoWxpw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6] arm64: allwinner: add TrimUI Smart Pro (A133)
 board support
To: leow149 <leow149@lucidmail.xyz>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260912222429.107809-1-leow149@lucidmail.xyz>
References: <20260912214317.106150-1-leow149@lucidmail.xyz>
 <20260912222429.107809-1-leow149@lucidmail.xyz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 22:38:58 +0000
Message-Id: <20260912223859.3307E1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Sleeping functions called from atomic context in DRM encoder callb=
acks.
- [High] State Confusion / Overlapping Transfers due to uncleared pending i=
nterrupts on IRQ re-enable.
- [High] Incorrect Horizontal Display Timings (Front and Back Porch Swap).
- [Medium] CPU Hog: The DSI retrigger timer will never stop.

Pre-existing issues:
- [High] TOCTOU Race Condition on Write-0-to-Clear Interrupt Acknowledge.
--

commit 2a1faaf3f9e395a5ec4a2a530f311f244c0a15e3
Author: leow149 <leow149@lucidmail.xyz>
Subject: arm64: allwinner: add TrimUI Smart Pro (A133) board support

This patch brings up board support for the TrimUI Smart Pro handheld.
It introduces new DTS configuration, panel timings for OTM1289A, a
new PWM driver, and modifies TCON/DSI files for CPU/8080 interface
bring-up.

> diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm1289a.c b/drivers/g=
pu/drm/panel/panel-orisetech-otm1289a.c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-orisetech-otm1289a.c
[ ... ]
> +static const struct drm_display_mode otm1289a_mode =3D {
> +	.clock =3D 69000,
> +	.hdisplay =3D OTM1289A_HDISPLAY,
> +	.hsync_start =3D OTM1289A_HDISPLAY + 88,
> +	.hsync_end =3D OTM1289A_HDISPLAY + 88 + 4,

[Severity: High]
Is it possible these horizontal porch values are swapped?

The DRM front porch is calculated as htotal - hdisplay - hbp=20
(880 - 720 - 88 =3D 72). However, in otm1289a_mode, hsync_start is set to=20
OTM1289A_HDISPLAY + 88, which uses the vendor's back porch value instead of=
=20
the computed front porch offset of 72.

Could this cause incorrect display output shifting when the hardware is=20
configured?

[ ... ]
> +static int otm1289a_prepare(struct drm_panel *panel)
> +{
[ ... ]
> +	if (ctx->reset_gpio) {
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		msleep(20);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +		msleep(100);
> +	}

[Severity: High]
Is it safe to call sleeping functions from this atomic context?

The DRM subsystem architectural guidelines specify that encoder atomic enab=
le=20
and disable callbacks execute in an atomic context where sleeping is strict=
ly=20
forbidden.

The panel's prepare and disable hooks (which are invoked from the encoder=20
enable/disable paths) use msleep().

Could this lead to kernel warnings, system instability, or deadlocks during=
=20
display modesets?

[ ... ]
> diff --git a/drivers/pwm/pwm-sun50i-a133.c b/drivers/pwm/pwm-sun50i-a133.c
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun50i-a133.c
[ ... ]
> +static int pwm_a133_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  const struct pwm_state *state)
> +{
[ ... ]
> +	/*
> +	 * PWM_A133_PCCR01_REG/PCCR23_REG (shared by a channel pair) and
> +	 * PWM_A133_PCGR_REG/PWM_A133_PER_REG (shared by all 16 channels) are
> +	 * each read-modify-written below; the PWM core doesn't serialize
[ ... ]
> +	mutex_lock(&pc->lock);

[Severity: High]
Does taking this mutex pose a sleep-in-atomic hazard?

This PWM apply hook is reachable from the panel enable hook via a backlight=
=20
update. Since the panel enable hook runs from the encoder atomic enable=20
context where sleeping is prohibited, acquiring a sleeping mutex here viola=
tes=20
subsystem constraints.

[ ... ]
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
[ ... ]
> +void sun4i_tcon_dsi_stop_retrigger(struct sun4i_tcon *tcon)
> +{
> +	hrtimer_cancel(&tcon->dsi_retrigger_timer);
> +	/*
> +	 * disable_irq() (which might_sleep()s internally) is safe here:
> +	 * both call sites run in normal process/workqueue context, not a
> +	 * genuinely atomic section -- see the comment on
> +	 * sun4i_tcon_set_status()'s disable_irq() call for why (this
> +	 * function is called from there too, unchanged reasoning).
> +	 */
> +	if (tcon->irq_enabled) {
> +		disable_irq(tcon->irq);
> +		tcon->irq_enabled =3D false;
> +	}
> +}

[Severity: High]
Does this disable_irq() call violate the DRM atomic context rules?

The function is called directly by sun6i_dsi_encoder_disable(), which is an=
=20
encoder atomic callback. Although the comment states it runs in process=20
context, the DRM guidelines classify encoder atomic callbacks as atomic=20
contexts where sleeping functions are forbidden.

[ ... ]
> @@ -1117,14 +1117,76 @@ static irqreturn_t sun4i_tcon_handler(int irq, vo=
id *private)
[ ... ]
> +	/*
> +	 * Acknowledge the interrupt. TRI_COUNTER_INT is included even though
> +	 * nothing here acts on it: in DSI/CPU mode every firing is treated as
> +	 * handled unconditionally (see the comment above), so if this bit
> +	 * were ever the one actually driving the level line and went
> +	 * unacknowledged, the GIC would keep re-presenting it forever with
> +	 * nothing in this function able to break out -- a genuine hard
> +	 * lockup, not just wasted CPU time. Never observed asserting in any
> +	 * testing so far, but clearing it here is free and closes the gap.
> +	 */
> +	regmap_update_bits(tcon->regs, SUN4I_TCON_GINT0_REG,
> +			   SUN4I_TCON_GINT0_VBLANK_INT(0) |
> +			   SUN4I_TCON_GINT0_VBLANK_INT(1) |
> +			   SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT |
> +			   SUN4I_TCON_GINT0_TCON0_TRI_COUNTER_INT |
> +			   SUN4I_TCON_GINT0_TCON0_FSYNC_INT,
> +			   0);

[Severity: High]
This is a pre-existing issue, but could this write-0-to-clear sequence=20
drop hardware interrupts?

SUN4I_TCON_GINT0_REG is a write-0-to-clear register. The regmap_update_bits=
()=20
call reads the register and unconditionally writes 0 to the specified mask.

If an interrupt such as TRI_FINISH_INT asserts after the initial regmap_rea=
d()=20
but before the regmap_update_bits() write, the unconditional 0-write clears=
=20
it. Since it was not in the original status snapshot, the handler will not=
=20
process it, resulting in a lost interrupt.

With the high frequency of FSYNC_INT events described in the commit, could=
=20
this TOCTOU race window lead to a permanent display freeze when TRI_FINISH_=
INT=20
is lost?

[ ... ]
> +static enum hrtimer_restart sun4i_tcon_dsi_retrigger_timer_fn(struct hrt=
imer *timer)
> +{
[ ... ]
> +	regmap_read(tcon->regs, SUN4I_TCON0_CPU_IF_REG, &cpu_if_before);
> +	busy =3D cpu_if_before & SUN4I_TCON0_CPU_IF_TRI_START;
> +
> +	if (tick && !busy) {
> +		/* TRIGGER_START self-cleared; the IRQ path takes over from here. */
> +		return HRTIMER_NORESTART;
> +	}

[Severity: Medium]
Will this retrigger timer ever actually stop?

The timer polls every 2ms and expects to stop when=20
SUN4I_TCON0_CPU_IF_TRI_START is cleared (!busy).

However, when the hardware clears TRI_START at the end of a frame, it=20
immediately asserts TRI_FINISH_INT. The hardirq handler runs and immediatel=
y=20
re-asserts TRI_START to 1.=20

Because the timer runs in a softirq context, it executes after the hardirq.=
=20
Thus, the timer will almost always sample TRI_START as 1, miss the window=20
where it was 0, and continue running continuously as a permanent CPU hog.

[ ... ]
> +	if (tick =3D=3D 0 && tcon->irq && !tcon->irq_enabled) {
> +		enable_irq(tcon->irq);
> +		tcon->irq_enabled =3D true;
> +	}
> +
> +	/*
> +	 * The vendor per-frame retrigger is LINE-edge-triggered and
> +	 * busy-gated, never blindly re-asserting TRIGGER_START -- matching
> +	 * the documented precondition on this bit ("software must write 1
> +	 * only when this flag is 0"). Only the initial kick is fired from
> +	 * software here; TCON0's AUTO bit (set in mode_set_cpu()) is
> +	 * expected to handle Vsync-driven retriggering afterward, the same
> +	 * way mainline's other DSI/CPU-interface boards need no per-frame
> +	 * software retrigger at all.
> +	 */
> +	if (tick =3D=3D 0 && !busy) {
> +		sun6i_dsi_tri_start(tcon->dsi);
> +		regmap_update_bits(tcon->regs, SUN4I_TCON0_CPU_IF_REG,
> +				   SUN4I_TCON0_CPU_IF_TRI_START,
> +				   SUN4I_TCON0_CPU_IF_TRI_START);
> +	}

[Severity: High]
Could enabling the IRQ here without first clearing pending device-level=20
interrupts cause overlapping transfers?

When the display is re-enabled during a DPMS unblank cycle, this function=20
calls enable_irq() at tick =3D=3D 0. If TRI_FINISH_INT or FSYNC_INT is pend=
ing=20
from a previous session, the hardirq handler will run immediately, preempti=
ng=20
the timer (or running concurrently), and issue a transfer via=20
sun6i_dsi_tri_start().

When enable_irq() returns, the timer proceeds, observes busy =3D=3D false, =
and=20
also issues a transfer. Could this result in two concurrent transfer comman=
ds=20
while a transfer is already in flight, confusing the DSI engine state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912222429.1078=
09-1-leow149@lucidmail.xyz?part=3D1
