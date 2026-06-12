Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DECCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7519510E283;
	Fri, 12 Jun 2026 12:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cj7yS2PP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B2310E283
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 12:18:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B884E60008;
 Fri, 12 Jun 2026 12:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226781F00A3A;
 Fri, 12 Jun 2026 12:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781266701;
 bh=hEPSysnu3BtUjudGXNksTHjJ4FRqtTwcysb49YgThoo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cj7yS2PPamWKySGwvDtcy64J7bn1eun53cGt0G7M8Hb/H+Z1sgImwr4nQLJSlSU3H
 r++c3nN7MNk3AxC7f89NY9KOSxfGbDUfKTmZsyxpZefhdIFCL4WVAg5nVueamw9lpC
 YwVYAcjZ7wtfxkQpRHL+8IQw+882nSi3mA/nn3KPBw14FCFIgYwqwJp8El33HBkefS
 pHFmxM0NjIYvoP4CkMDt4F7UQ8HZYbFlyEQm3PTZz7FeDoVeAN6OrFLI3Qzg47RdEK
 aL561VAtcxQvazu5TW884k1Empqc59s+NrudUHJKiqZd4WuEUveDb7ElFYSh9aNuGh
 JjE9C3CYyAO1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/9] drm/imx: Add support for i.MX94 DCIF
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>
Cc: robh@kernel.org, conor+dt@kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org
In-Reply-To: <20260612-dcif-upstreaming-v9-5-8d0ff89aa3c5@oss.nxp.com>
References: <20260612-dcif-upstreaming-v9-5-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 12:18:20 +0000
Message-Id: <20260612121821.226781F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 15 potential issue=
(s) to consider:
- [High] Read-modify-write (RMW) operations on Write-1-to-Clear (W1C) inter=
rupt status registers cause lost interrupts.
- [High] Module reference count underflow and use-after-free caused by unba=
lanced `drm_bridge_put`.
- [High] CRTC `bus_format` and `bus_flags` state is corrupted and permanent=
ly lost during plane-only atomic updates.
- [High] Unprotected hardware register accesses in the IRQ handler risk bus=
 errors on runtime suspended devices.
- [High] System resume fails to enable the display because `pm_runtime_resu=
me_and_get` is called while PM transitions are disabled.
- [High] An unhandled pending vblank event in `dcif->event` during CRTC dis=
able causes userspace to hang indefinitely and memory to leak.
- [High] Unlocked access to `crtc->state` in `dcif_crc_source_parse` causes=
 a data race and potential use-after-free.
- [High] Failure of `pm_runtime_resume_and_get` causes the atomic commit to=
 hang permanently.
- [High] Use of sleeping functions and inappropriate lock guards in atomic =
context paths.
- [High] Ignoring the return value of `drm_crtc_vblank_get()` causes vblank=
 reference count underflow on failure.
- [High] Disabling Layer 0 without triggering `SHADOW_LOAD_EN` causes an ab=
rupt hardware stop and AXI bus lockup risks.
- [High] `drm_crtc_vblank_on()` is called before software reset, permanentl=
y breaking vblank interrupts.
- [Medium] Dynamic plane color encoding and color range updates are silentl=
y ignored.
- [Medium] Transitions between active CRC sources (e.g., updating ROI coord=
inates) are ignored.
- [Medium] Data race (TOCTOU) on `dcif->crc_is_enabled` causes garbage CRC =
reads.
--

commit 4328341d625e1f0fbf8be8ca733a73ea0e76115e
Author: Sandor Yu <sandor.yu@nxp.com>

drm/imx: Add support for i.MX94 DCIF

This commit introduces DRM support for the i.MX94 Display Control
Interface (DCIF). It includes core CRTC, plane, and KMS integration,
along with CRC generation support.

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-crc.h b/drivers/gpu/drm/imx/dc=
if/dcif-crc.h
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-crc.h
[ ... ]
> +static inline bool enable_dcif_crc_needed(struct dcif_crtc_state *new_dc=
state,
> +					  struct dcif_crtc_state *old_dcstate)
> +{
> +	return old_dcstate->crc.source =3D=3D DCIF_CRC_SRC_NONE &&
> +	       new_dcstate->crc.source !=3D DCIF_CRC_SRC_NONE;
> +}

[Severity: Medium]
Does this prevent updates when transitioning directly between two active
CRC configurations? If userspace modifies the ROI region while keeping the
source active, both helpers will return false, meaning the hardware might
continue capturing the old ROI coordinates.

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-crc.c b/drivers/gpu/drm/imx/dc=
if/dcif-crc.c
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-crc.c
[ ... ]
> +void dcif_crc_source_disable(struct dcif_dev *dcif, int ncrc)
> +{
[ ... ]
> +	regmap_clear_bits(dcif->regmap, DCIF_CRC_CTRL, DCIF_CRC_CTRL_CRC_EN(ncr=
c));
> +
> +	dcif->crc_is_enabled =3D false;
> +}

[Severity: Medium]
Is there a data race on the crc_is_enabled flag here? This flag is modified
without holding the event_lock, while the IRQ handler evaluates it with the
lock held. This could allow the module to power off while the IRQ handler
attempts to read the disabled register, generating spurious payload data.

[ ... ]
> +static int dcif_crc_source_parse(struct drm_crtc *crtc, const char *sour=
ce_name,
> +				 enum dcif_crc_source *s, struct drm_rect *roi)
> +{
> +	static const char roi_prefix[] =3D "roi:";
> +
> +	if (!source_name) {
> +		*s =3D DCIF_CRC_SRC_NONE;
> +	} else if (!strcmp(source_name, "auto")) {
> +		struct drm_display_mode *mode =3D &crtc->state->adjusted_mode;

[Severity: High]
Can this unlocked access to the atomic state lead to a use-after-free? This
parser is called before acquiring any connection locks. A concurrent atomic
commit could swap and free the atomic state while this thread is referencing
the adjusted_mode.

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-crtc.c b/drivers/gpu/drm/imx/d=
cif/dcif-crtc.c
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-crtc.c
[ ... ]
> +static void dcif_disable_controller(struct dcif_dev *dcif)
> +{
> +	u32 reg;
> +	int ret;
> +
> +	/* Disable layer 0 */
> +	regmap_clear_bits(dcif->regmap, DCIF_CTRLDESC0(0), DCIF_CTRLDESC0_EN);

[Severity: High]
Does clearing the enable bit without also triggering the shadow load bit
leave the layer hardware active? The hardware typically ignores the register
change without the shadow load bit, meaning it will continue fetching data
via DMA. Severing the display controller abruptly while DMA is active could
risk AXI bus lockups.

[ ... ]
> +static void dcif_crtc_queue_state_event(struct drm_crtc *crtc)
> +{
> +	struct dcif_dev *dcif =3D crtc_to_dcif_dev(crtc);
> +
> +	scoped_guard(spinlock_irq, &crtc->dev->event_lock) {
> +		if (crtc->state->event) {
> +			WARN_ON(drm_crtc_vblank_get(crtc));
> +			WARN_ON(dcif->event);
> +			dcif->event =3D crtc->state->event;

[Severity: High]
What happens if drm_crtc_vblank_get returns an error? The code continues to
queue the event without having incremented the vblank reference count. When
the interrupt handler later processes the event and calls the corresponding
put function, it would cause a reference count underflow.

[ ... ]
> +static void dcif_crtc_query_output_bus_format(struct drm_crtc *crtc,
> +					      struct drm_crtc_state *crtc_state)
> +{
> +	struct dcif_crtc_state *dcif_state =3D to_dcif_crtc_state(crtc_state);
> +	struct drm_bridge *bridge __free(drm_bridge_put) =3D NULL;

[Severity: High]
Will the cleanup attribute here cause a use-after-free? The bridge is
obtained via drm_bridge_chain_get_first_bridge, which does not increment
the module reference count. When the function returns, drm_bridge_put will
decrement a reference that was never acquired, potentially allowing the
bridge module to unload prematurely.

> +	struct drm_bridge_state *bridge_state;
> +
> +	dcif_state->bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
> +	dcif_state->bus_flags =3D 0;
> +
> +	bridge =3D dcif_crtc_get_bridge(crtc, crtc_state);
> +	if (!bridge)
> +		return;

[Severity: High]
Could this overwrite destroy the existing bus_format and bus_flags during
a plane-only update? In a plane update, the bridge is not part of the atomic
commit state, causing the bridge state query below to return NULL. Returning
early leaves the state permanently overwritten with default values.

[ ... ]
> +static void dcif_crtc_atomic_enable(struct drm_crtc *crtc,
> +				    struct drm_atomic_commit *state)
> +{
[ ... ]
> +	/* enable power when we start to set mode for CRTC */
> +	ret =3D pm_runtime_resume_and_get(drm->dev);
> +	if (ret < 0) {
> +		drm_err(drm, "failed to resume DCIF, ret =3D %d\n", ret);
> +		return;
> +	}

[Severity: High]
Is pm_runtime_resume_and_get safe to call here? This is an atomic context
path during non-blocking commits, and this PM function can sleep.

Additionally, if this path executes during system resume, runtime PM
transitions are disabled and it will return an error, leaving the display
blanked.

If it does return early, the pending event in crtc->state->event is never
consumed. The DRM core expects the driver to consume the event, and
abandoning it here will cause the atomic commit to hang indefinitely
waiting for a flip completion.

> +	dcif->crtc_pm_enabled =3D true;
> +
> +	drm_crtc_vblank_on(crtc);
> +
> +	dcif_crtc_mode_set_nofb(crtc_state, plane_state);

[Severity: High]
Will the software reset performed inside dcif_crtc_mode_set_nofb destroy the
vblank interrupt enablement? Since drm_crtc_vblank_on is called right before
the reset, the hardware state and interrupt enable bits will be cleared,
permanently breaking vblanks.

[ ... ]
> +static void dcif_crtc_atomic_disable(struct drm_crtc *crtc,
> +				     struct drm_atomic_commit *state)
> +{
[ ... ]
> +	if (dcif->crtc_pm_enabled) {
> +		dcif->crtc_pm_enabled =3D false;
> +		pm_runtime_put_sync(drm->dev);
> +	}
> +
> +	scoped_guard(spinlock_irq, &crtc->dev->event_lock) {
> +		if (crtc->state->event && !crtc->state->active) {
> +			drm_crtc_send_vblank_event(crtc, crtc->state->event);
> +			crtc->state->event =3D NULL;
> +		}
> +	}
> +}

[Severity: High]
Similar to the enable path, pm_runtime_put_sync is a sleeping function
called in an atomic context.

Also, does the use of the spinlock_irq scoped guard here cause problems?
When exiting the scoped guard, it unconditionally re-enables hardware
interrupts, which breaks the caller's atomic execution context.

Finally, if a non-blocking commit queued an event into dcif->event, it
seems to be ignored here. If the hardware interrupts are turned off, the
pending event in dcif->event is stranded and never signaled, leaving
userspace blocked.

[ ... ]
> +static int dcif_crtc_enable_vblank(struct drm_crtc *crtc)
> +{
> +	struct dcif_dev *dcif =3D crtc_to_dcif_dev(crtc);
> +	int domain =3D dcif->cpu_domain;
> +
> +	/* Clear and enable VS_BLANK IRQ */
> +	regmap_set_bits(dcif->regmap, DCIF_IS0(domain), DCIF_INT0_VS_BLANK);
> +	regmap_set_bits(dcif->regmap, DCIF_IE0(domain), DCIF_INT0_VS_BLANK);

[Severity: High]
Does using a read-modify-write helper on a Write-1-to-Clear register cause
lost interrupts? regmap_set_bits will read the register, OR the new bit, and
write it back, which inadvertently clears any already pending interrupts
before the handler can process them. W1C registers usually need to be
written directly.

[ ... ]
> +static void dcif_crtc_disable_vblank(struct drm_crtc *crtc)
> +{
> +	struct dcif_dev *dcif =3D crtc_to_dcif_dev(crtc);
> +	int domain =3D dcif->cpu_domain;
> +
> +	/* Disable and clear VS_BLANK IRQ */
> +	regmap_clear_bits(dcif->regmap, DCIF_IE0(domain), DCIF_INT0_VS_BLANK);
> +	regmap_clear_bits(dcif->regmap, DCIF_IS0(domain), DCIF_INT0_VS_BLANK);
> +}

[Severity: High]
The same applies here. regmap_clear_bits will write a 1 to all pending
interrupts while writing a 0 to the target bit, improperly clearing unrelat=
ed
interrupts and failing to clear the target bit.

[ ... ]
> +irqreturn_t dcif_irq_handler(int irq, void *data)
> +{
> +	struct drm_device *drm =3D data;
> +	struct dcif_dev *dcif =3D to_dcif_dev(drm);
> +	int domain =3D dcif->cpu_domain;
> +	u32 stat0, stat1, crc;
> +
> +	regmap_read(dcif->regmap, DCIF_IS0(domain), &stat0);

[Severity: High]
Is it safe to read hardware registers here without verifying the power
management active state? If the device is in runtime suspend and its clocks
are turned off, a spurious interrupt could trigger this handler, and
accessing unclocked registers can cause bus faults or system lockups. Should
this be protected with pm_runtime_get_if_active?

> diff --git a/drivers/gpu/drm/imx/dcif/dcif-plane.c b/drivers/gpu/drm/imx/=
dcif/dcif-plane.c
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcif/dcif-plane.c
[ ... ]
> +static int dcif_plane_atomic_check(struct drm_plane *plane, struct drm_a=
tomic_commit *state)
> +{
[ ... ]
> +	/*
> +	 * Force CRTC mode change if framebuffer stride or pixel format have ch=
anged.
> +	 */
> +	if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY && old_fb &&
> +	    (fb->pitches[0] !=3D old_fb->pitches[0] || fb->format->format !=3D =
old_fb->format->format))
> +		crtc_state->mode_changed =3D true;

[Severity: Medium]
Will dynamic updates to plane color encoding or color ranges be silently
ignored? The hardware CSC coefficients are programmed during a full modeset,
but this check does not flag a mode change if only the color properties are
modified.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-dcif-upstr=
eaming-v9-0-8d0ff89aa3c5@oss.nxp.com?part=3D5
