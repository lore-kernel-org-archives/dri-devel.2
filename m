Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1FC606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ1FJQd4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC4110E4E3;
	Sun, 25 Oct 2026 09:44:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2135610E4E3
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 09:44:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1669F600CB;
 Sun, 25 Oct 2026 09:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDB91F01828;
 Sun, 25 Oct 2026 09:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792921488;
 bh=3JwxsyCfb55NCobpjZR9jSidMoC2tmsb6VCKlofU2pk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VZ1FJQd4qCNVdhT+MWemv6Ng8GdRPBxzHaY7VI0yCLqBRve3keb3D6j7XvYCamY6j
 DiluvvT4toB0FPF1HomuzJw9DGzTeVTNrT1mzf7wVOgEAsOn6499AR7p5l/GTfFRKO
 sst55MaFYrgulbZsDZSYiGIxgeAZQHq8H18OrfpoQlIYzfB3qCH4tl0XHCkigfpS/4
 9ZS0QL8odZD73GsRA24PLbJDDENn07uQK1zxKhiTNIrFpKRWT6le7fss7pCmguO9DW
 x92gwhX89Ws3sjKYKwoXdKfdjQ+LjCYIms35xLlL8/d+mXTpGEPGT8sZ0y854sOX5z
 JO/Roed9oj1/g==
Message-ID: <sashiko-outbox-184181@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/ingenic: Add a driver for the X1600 LCD controller
To: "Olivier Louvignes" <olivier@mgcrea.io>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261025085816.60405-4-olivier@mgcrea.io>
References: <20261025085816.60405-1-olivier@mgcrea.io>
 <20261025085816.60405-4-olivier@mgcrea.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 09:44:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/ingenic: premature plane cleanup via drm_atomic_helper_wait_fo=
r_vblanks()
- [High] drm/ingenic: missing visibility check in x1600_lcd_plane_atomic_ch=
eck()
- [Medium] drm/ingenic: premature vblank event in x1600_lcd_crtc_atomic_flu=
sh()
- [Medium] drm/ingenic: unclocked MMIO on disable in x1600_lcd_crtc_atomic_=
disable()
--

commit ff594f68d62e2b467c0fa558eebe60679b4a51ba
Author: Olivier Louvignes <olivier@mgcrea.io>

drm/ingenic: Add a driver for the X1600 LCD controller

This commit adds a DRM driver for the Ingenic X1600 LCD controller,
supporting parallel RGB panels on a 24-bit bus with a single full-screen
RGB565 primary plane and descriptor-chain page flipping.

> diff --git a/drivers/gpu/drm/ingenic/ingenic-x1600-drm.c b/drivers/gpu/dr=
m/ingenic/ingenic-x1600-drm.c
> new file mode 100644
> index 0000000000000..34fbfc7de1c4b
> --- /dev/null
> +++ b/drivers/gpu/drm/ingenic/ingenic-x1600-drm.c
[ ... ]
> +static void x1600_lcd_crtc_atomic_enable(struct drm_crtc *crtc,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct x1600_lcd *lcd =3D to_x1600_lcd(crtc->dev);
> +	struct drm_display_mode *mode =3D &crtc->state->adjusted_mode;
> +	unsigned int hde =3D mode->htotal - mode->hsync_start;
> +	unsigned int vde =3D mode->vtotal - mode->vsync_start;
> +	u32 val;
> +	int ret;
> +
> +	ret =3D clk_set_rate(lcd->clk, mode->crtc_clock * 1000);
> +	if (ret)
> +		dev_warn(lcd->drm.dev, "Unable to set the pixel clock: %d\n", ret);
> +	ret =3D clk_prepare_enable(lcd->clk);
> +	if (ret) {
> +		dev_err(lcd->drm.dev, "Unable to start the pixel clock: %d\n", ret);
> +		return;
> +	}
[ ... ]
> +	writel(x1600_lcd_desc_addr(lcd, lcd->cur), lcd->base + X1600_LCD_SRD_CH=
AIN_ADDR);
> +	writel(1, lcd->base + X1600_LCD_SRD_CHAIN_START);
> +	lcd->running =3D true;
> +
> +	drm_crtc_vblank_on(crtc);
> +}
> +
> +static void x1600_lcd_crtc_atomic_disable(struct drm_crtc *crtc,
> +					  struct drm_atomic_commit *state)
> +{
> +	struct x1600_lcd *lcd =3D to_x1600_lcd(crtc->dev);
> +
> +	if (!x1600_lcd_stop(lcd))
> +		dev_warn(lcd->drm.dev, "The controller did not stop\n");
> +	lcd->running =3D false;
> +
> +	spin_lock_irq(&crtc->dev->event_lock);
> +	if (lcd->event) {
> +		drm_crtc_send_vblank_event(crtc, lcd->event);
> +		drm_crtc_vblank_put(crtc);
> +		lcd->event =3D NULL;
> +	}
> +	spin_unlock_irq(&crtc->dev->event_lock);
> +
> +	drm_crtc_vblank_off(crtc);
> +	clk_disable_unprepare(lcd->clk);
> +}

[Severity: Medium]
In drivers/gpu/drm/ingenic/ingenic-x1600-drm.c, if clk_prepare_enable() fai=
ls
in x1600_lcd_crtc_atomic_enable(), the function returns early with lcd->clk
disabled and lcd->running left false, while the atomic state still marks the
crtc as enabled.

When the crtc is later disabled (for example via DPMS off, a subsequent
modeset, or drm_atomic_helper_shutdown() in x1600_lcd_remove()),
x1600_lcd_crtc_atomic_disable() unconditionally calls x1600_lcd_stop(lcd) a=
nd
clk_disable_unprepare(lcd->clk).

Could this access hardware registers in x1600_lcd_stop() while lcd->clk is
gated and underflow the clock prepare/enable counts in
clk_disable_unprepare(lcd->clk) if x1600_lcd_crtc_atomic_disable() does not
check lcd->running first?

[ ... ]
> +static void x1600_lcd_crtc_atomic_flush(struct drm_crtc *crtc,
> +					struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
> +	struct drm_pending_vblank_event *event =3D crtc_state->event;
> +	struct x1600_lcd *lcd =3D to_x1600_lcd(crtc->dev);
> +
> +	if (!event)
> +		return;
> +
> +	crtc_state->event =3D NULL;
> +
> +	/*
> +	 * The controller takes a new descriptor "at appropriate time" (manual,
> +	 * 10.6.4): wait until it reports reading the one just handed over.
> +	 */
> +	spin_lock_irq(&crtc->dev->event_lock);
> +	if (lcd->running && !WARN_ON(lcd->event) && drm_crtc_vblank_get(crtc) =
=3D=3D 0) {
> +		lcd->event =3D event;
> +		lcd->event_desc =3D x1600_lcd_desc_addr(lcd, lcd->cur);
> +	} else {
> +		drm_crtc_send_vblank_event(crtc, event);
> +	}
> +	spin_unlock_irq(&crtc->dev->event_lock);
> +}

[Severity: Medium]
In x1600_lcd_probe(), drm->mode_config.helper_private is left unset, so
atomic commits use the default drm_atomic_helper_commit_tail() ordering:

  drm_atomic_helper_commit_tail()
    drm_atomic_helper_commit_modeset_disables()
    drm_atomic_helper_commit_planes()
      x1600_lcd_plane_atomic_update()
      x1600_lcd_crtc_atomic_flush()
    drm_atomic_helper_commit_modeset_enables()
      x1600_lcd_crtc_atomic_enable()

During any commit that enables or re-enables the crtc,
x1600_lcd_crtc_atomic_flush() runs before x1600_lcd_crtc_atomic_enable() se=
ts
lcd->running =3D true and calls drm_crtc_vblank_on(crtc).

Won't the check in x1600_lcd_crtc_atomic_flush() always take the else branch
during a modeset enable, sending the vblank event and completing flip_done
before the controller and panel bridge have even started?

[ ... ]
> +static irqreturn_t x1600_lcd_irq(int irq, void *data)
> +{
> +	struct x1600_lcd *lcd =3D data;
> +	u32 st =3D readl(lcd->base + X1600_LCD_INT_FLAG);
> +
> +	if (!st)
> +		return IRQ_NONE;
> +
> +	writel(st, lcd->base + X1600_LCD_CLR_ST);
> +	if (st & X1600_LCD_ST_STOP_SRD_ACK)
> +		complete(&lcd->stopped);
> +
> +	if (st & X1600_LCD_ST_DISP_END) {
> +		drm_crtc_handle_vblank(&lcd->crtc);
> +
> +		spin_lock(&lcd->drm.event_lock);
> +		if (lcd->event &&
> +		    readl(lcd->base + X1600_LCD_CHAIN_SITE) =3D=3D lcd->event_desc) {
> +			drm_crtc_send_vblank_event(&lcd->crtc, lcd->event);
> +			drm_crtc_vblank_put(&lcd->crtc);
> +			lcd->event =3D NULL;
> +		}
> +		spin_unlock(&lcd->drm.event_lock);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

[Severity: High]
When a page flip is programmed near the end of a frame and the controller h=
as
not yet switched to the new descriptor in lcd->event_desc when the next
end-of-frame interrupt fires, x1600_lcd_irq() holds back the flip event
because X1600_LCD_CHAIN_SITE does not match lcd->event_desc yet, but it sti=
ll
calls drm_crtc_handle_vblank(&lcd->crtc) unconditionally.

Because drm->mode_config.helper_private is unset in x1600_lcd_probe(), the
default drm_atomic_helper_commit_tail() waits for
drm_atomic_helper_wait_for_vblanks() rather than
drm_atomic_helper_wait_for_flip_done():

  drm_atomic_helper_commit_tail()
    drm_atomic_helper_wait_for_vblanks()
    drm_atomic_helper_cleanup_planes()

Can that first vblank interrupt wake drm_atomic_helper_wait_for_vblanks() a=
nd
allow drm_atomic_helper_cleanup_planes() to release the old framebuffer whi=
le
the controller is still scanning out the previous descriptor for another
frame?

> +
> +static int x1600_lcd_plane_atomic_check(struct drm_plane *plane,
> +					struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
state, plane);
> +	struct drm_crtc_state *crtc_state;
> +
> +	if (!plane_state->crtc)
> +		return 0;
> +
> +	crtc_state =3D drm_atomic_get_new_crtc_state(state, plane_state->crtc);
> +	if (WARN_ON(!crtc_state))
> +		return -EINVAL;
> +
> +	/* The plane covers the whole screen: no scaling, no position. */
> +	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> +						   DRM_PLANE_NO_SCALING,
> +						   DRM_PLANE_NO_SCALING,
> +						   false, true);
> +}
> +
> +static void x1600_lcd_plane_atomic_update(struct drm_plane *plane,
> +					  struct drm_atomic_commit *state)
> +{
> +	struct x1600_lcd *lcd =3D to_x1600_lcd(plane->dev);
> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
state, plane);
> +	struct drm_framebuffer *fb =3D plane_state->fb;
> +	unsigned int next =3D lcd->running ? !lcd->cur : lcd->cur;
> +	struct x1600_lcd_desc *desc =3D &lcd->desc[next];
> +
> +	if (!fb)
> +		return;
> +
> +	desc->next =3D x1600_lcd_desc_addr(lcd, next);
> +	desc->addr =3D drm_fb_dma_get_gem_addr(fb, plane_state, 0);
> +	desc->stride =3D fb->pitches[0] / fb->format->cpp[0];

[Severity: High]
In drm_atomic_helper_check_plane_state(), if userspace places the plane's
destination rectangle completely outside the active crtc dimensions, the
helper sets plane_state->visible =3D false and returns 0 before checking
can_position:

  drm_atomic_helper_check_plane_state()
    plane_state->visible =3D drm_rect_clip_scaled(src, dst, &clip);
    ...
    if (!plane_state->visible)
            return 0;

    if (!can_position && !drm_rect_equals(dst, &clip))
            return -EINVAL;

If userspace submits a small framebuffer positioned off-screen, won't
x1600_lcd_plane_atomic_check() accept the state and
x1600_lcd_plane_atomic_update() program desc->addr to scan out a full frame
past the end of the small buffer unless !plane_state->visible is rejected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025085816.6040=
5-1-olivier@mgcrea.io?part=3D3
