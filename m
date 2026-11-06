Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDC606A31B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQgTBY9Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CE110E308;
	Fri,  6 Nov 2026 03:11:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7343F10E308
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 03:11:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B95A8601D5;
 Fri,  6 Nov 2026 03:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FEA1F0089F;
 Fri,  6 Nov 2026 03:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793934665;
 bh=0mIZ/J96vX3sIK2IiGE5K0U0fLjy58DJu5O+7dO6JHQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eQgTBY9Q8941zWPMdDY5NMnfqrf6ZfUCpQ0kDl2xyQzXycdiAwAp46Po3T62lRfed
 +GFpV4WClrbjg142a5U1R2g+xzYAgfuxD1M0bDRuSaUTFI2Z/FZPeqJwRImoz5ED8o
 ZYRacGqguUtxj71kBw91767+YZcvKxcZFI0F6n4M0msj4eyUR9RbAXAa+fsLDlHOft
 ybhEVtel4Ebv9ixcZLD2jefENshJIcgKKorVmpqOxt5BAC+Pcdo5MpLOt/Ks1T3vkk
 jrabSB0lLea0AW4QtcCMagxRvxyTEyTIfynQlZKyTqp/ykLl2WlhojcIyBkubgenvD
 0JjqjHc4WfpbQ==
Message-ID: <sashiko-outbox-200627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/4] drm/fl2000: Add KMS display pipeline
To: "Angel Gabriel Crispin Valdivia" <angelcrispinvaldivia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-fl2000-upstream-v1-4-bb163ecb2309@gmail.com>
References: <20261105-fl2000-upstream-v1-0-bb163ecb2309@gmail.com>
 <20261105-fl2000-upstream-v1-4-bb163ecb2309@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 03:11:04 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 13 potential issue=
(s) to consider:
- [Critical] drm/fl2000: missing mode size check causes buffer overflow in =
stream setup
- [Critical] drm/fl2000: OOB shadow write after fl2000_stream_mode_set() al=
loc failure
- [High] drm/fl2000: use-after-free of stream on unplug in cursor and CRTC =
callbacks
- [High] drm/fl2000: false VGA detection in fl2000_vga_sense() on HDMI unpl=
ug
- [High] drm/fl2000: usb_device devres outlives driver unbind and blocks re=
bind
- [High] drm/fl2000: active_if corruption and error handling bugs in fl2000=
_probe()
- [Medium] drm/fl2000: frame updates dropped in fl2000_plane_atomic_update(=
) on larger fb
- [Medium] drm/fl2000: IT66121 bridge not detached on unbind when DRM fd st=
ays open
- [Medium] drm/fl2000: missing fl2000_enable_interrupts() and racy status e=
vent reads
- [Medium] drm/fl2000: alpha formats exposed without blend mode in fl2000_d=
rm_bind()
- [Medium] drm/fl2000: unsynchronized chip reset and I2C access vs it66121_=
intr_work()
- [Medium] drm/fl2000: corrupted URB interval, endpoint, and events in fl20=
00_intr
- [Medium] drm/fl2000: broken devs->suspended tracking on fl2000_suspend() =
error
--

commit db62c82606de6ffbad39e1ab2d4b34dcf543976b
Author: Angel Gabriel Crispin Valdivia <angelcrispinvaldivia@gmail.com>

drm/fl2000: Add KMS display pipeline

This commit adds the KMS display pipeline for the Fresco Logic FL2000 USB
display driver, including primary and cursor planes, CRTC mode validation
and programming, HDMI bridge and analog VGA connectors, and USB interrupt
handling.

> diff --git a/drivers/gpu/drm/fl2000/fl2000_drm.c b/drivers/gpu/drm/fl2000=
/fl2000_drm.c
> new file mode 100644
> index 0000000000000..2c0c878549869
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_drm.c

[ ... ]

> +static enum drm_mode_status fl2000_crtc_mode_valid(struct drm_crtc *crtc,
> +						   const struct drm_display_mode *mode)
> +{
> +	struct fl2000_drm_if *drm_if =3D to_fl2000_drm_if(crtc->dev);
> +	struct drm_display_mode adjusted_mode;
> +	struct fl2000_pll pll;
> +
> +	/* Get PLL configuration and check if mode adjustments are needed */
> +	if (fl2000_mode_calc(mode, &adjusted_mode, &pll, FL2000_PPM_ERR_MAX_VGA=
))
> +		return MODE_BAD;
> +
> +	if (fl2000_get_bytes_pix(drm_if->usb_dev->speed, &adjusted_mode) =3D=3D=
 0)
> +		return MODE_CLOCK_HIGH;
> +
> +	return MODE_OK;
> +}

[Severity: Critical]
Can a user-supplied display mode bypass FL2000_MAX_WIDTH and
FL2000_MAX_HEIGHT here and in fl2000_crtc_atomic_check(), overflowing the
32-bit buffer size calculation in fl2000_stream_mode_set()?

While fl2000_drm_bind() sets mode_config->max_width and
mode_config->max_height to 4000, the DRM core only enforces those limits
when creating framebuffers and validating connector-probed modes. A DRM
master submitting a custom mode with large hdisplay and vdisplay (for
example hdisplay =3D 43691, vdisplay =3D 32768, clock =3D 25000 kHz) and on=
ly the
cursor plane enabled passes fl2000_crtc_mode_valid() and
fl2000_crtc_atomic_check().

When fl2000_crtc_mode_set_nofb() then calls fl2000_stream_mode_set():

drivers/gpu/drm/fl2000/fl2000_streaming.c:fl2000_stream_mode_set() {
	...
	/* Round buffer size up to multiple of 8 to meet HW expectations */
	size =3D ALIGN(width * height * bytes_pix, 8);
	...
}

the 32-bit unsigned int multiplication width * height * bytes_pix wraps
around, allocating small stream->shadow and transfer buffers while setting
stream->width and stream->height to the unvalidated dimensions and causing
out-of-bounds reads and writes during cursor blending and frame updates.

[ ... ]

> +static int fl2000_plane_atomic_check(struct drm_plane *plane, struct drm=
_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_plane_state =3D drm_atomic_get_new_plane_st=
ate(state, plane);
> +	struct drm_crtc_state *new_crtc_state =3D NULL;
> +	bool is_cursor =3D plane->type =3D=3D DRM_PLANE_TYPE_CURSOR;
> +
> +	/* Clipping a larger sprite would put a truncated pointer on screen */
> +	if (is_cursor && new_plane_state->fb &&
> +	    (new_plane_state->fb->width > FL2000_CURSOR_MAX ||
> +	     new_plane_state->fb->height > FL2000_CURSOR_MAX))
> +		return -EINVAL;
> +
> +	if (new_plane_state->crtc)
> +		new_crtc_state =3D drm_atomic_get_new_crtc_state(state, new_plane_stat=
e->crtc);
> +
> +	/* The cursor may be placed anywhere; the primary plane is the frame */
> +	return drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_st=
ate,
> +						   DRM_PLANE_NO_SCALING, DRM_PLANE_NO_SCALING,
> +						   is_cursor, false);
> +}
> +
> +/*
> + * Only the damaged rectangle is converted, into the stream's shadow fra=
me,
> + * which is the one persistent copy every outgoing buffer is built from.
> + */
> +static void fl2000_plane_atomic_update(struct drm_plane *plane, struct d=
rm_atomic_commit *state)
> +{
> +	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_st=
ate(state, plane);
> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
state, plane);
> +	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(plane_state);
> +	struct fl2000_drm_if *drm_if =3D to_fl2000_drm_if(plane->dev);
> +	struct drm_framebuffer *fb =3D plane_state->fb;
> +	struct drm_rect damage;
> +	ktime_t start;
> +	int idx;
> +
> +	if (!fb)
> +		return; /* plane is disabled */
> +
> +	if (!drm_atomic_helper_damage_merged(old_plane_state, plane_state, &dam=
age))
> +		return;
> +
> +	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
> +		return;
> +
> +	if (drm_dev_enter(plane->dev, &idx)) {
> +		start =3D ktime_get();
> +		fl2000_stream_compress(drm_if->stream, &shadow_plane_state->data[0],
> +				       drm_gem_is_imported(fb->obj[0]), fb->format->format,
> +				       fb->width, fb->height, fb->pitches[0], &damage);

[Severity: Medium]
What happens in fl2000_plane_atomic_update() when the attached framebuffer
is larger than the active CRTC mode (for example after fbdev switches from
1920x1080 to a smaller mode while reusing its initial framebuffer, or in a
multi-monitor Xorg layout with a non-zero source offset)?

In fl2000_plane_atomic_check(), drm_atomic_helper_check_plane_state()
allows any framebuffer whose dimensions are at least as large as the CRTC
mode. However, fl2000_crtc_mode_set_nofb() sets stream->width and
stream->height to mode->hdisplay and mode->vdisplay, whereas
fl2000_plane_atomic_update() passes fb->width, fb->height, and untranslated
damage coordinates to fl2000_stream_compress():

drivers/gpu/drm/fl2000/fl2000_streaming.c:fl2000_stream_compress() {
	...
	if (!stream->shadow || width !=3D stream->width || height !=3D stream->hei=
ght)
		return;
	...
}

Doesn't fl2000_stream_compress() silently drop every frame update whenever
fb->width !=3D mode->hdisplay or fb->height !=3D mode->vdisplay?

> +		fl2000_stream_note_render(drm_if->stream,
> +					  (unsigned int)ktime_us_delta(ktime_get(), start),
> +					  drm_rect_width(&damage) * drm_rect_height(&damage));
> +		drm_dev_exit(idx);
> +	}
> +
> +	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> +}
> +
> +/*
> + * Hand the cursor sprite to the stream, which blends it into every outg=
oing
> + * frame. Moving the pointer keeps the same framebuffer and skips the co=
py.
> + */
> +static void fl2000_cursor_atomic_update(struct drm_plane *plane, struct =
drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_st=
ate(state, plane);
> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
state, plane);
> +	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(plane_state);
> +	struct fl2000_drm_if *drm_if =3D to_fl2000_drm_if(plane->dev);
> +	struct drm_framebuffer *fb =3D plane_state->fb;
> +	unsigned int w, h;
> +	u32 *sprite;
> +	int idx;
> +
> +	if (!fb || !plane_state->visible) {
> +		fl2000_stream_set_cursor(drm_if->stream, NULL, 0, 0, 0, 0);
> +		return;
> +	}
> +
> +	if (fb =3D=3D old_plane_state->fb && old_plane_state->visible) {
> +		fl2000_stream_move_cursor(drm_if->stream, plane_state->crtc_x, plane_s=
tate->crtc_y);
> +		return;
> +	}

[Severity: High]
Can these early cursor branches, as well as fl2000_crtc_mode_set_nofb(),
fl2000_crtc_atomic_enable(), and fl2000_crtc_atomic_disable() below, cause
a use-after-free of drm_if->stream if a USB disconnect races with an
in-flight atomic commit?

In fl2000_drm_if_release(), drm_dev_unplug() and
drm_atomic_helper_shutdown() are followed immediately by
fl2000_stream_destroy(usb_dev), which frees drm_if->stream while drm_if
remains allocated until the last open DRM file descriptor is closed. An
ioctl or non-blocking commit that entered before drm_dev_unplug() and was
waiting on modeset locks will proceed once drm_atomic_helper_shutdown()
releases those locks.

Unlike the sprite upload branch below (which checks drm_dev_enter()), the
cursor hide and move paths here, along with fl2000_crtc_mode_set_nofb(),
fl2000_crtc_atomic_enable(), and fl2000_crtc_atomic_disable(), dereference
drm_if->stream and drm_if->usb_dev without a drm_dev_enter() guard.

[ ... ]

> +	/* Enable interrupts */
> +	fl2000_enable_interrupts(usb_dev);
> +
> +	fl2000_afe_magic(usb_dev);
> +
> +	fl2000_stream_mode_set(drm_if->stream, mode->hdisplay, mode->vdisplay, =
bytes_pix);
> +}

[Severity: Critical]
What happens if fl2000_stream_mode_set() fails to allocate buffers when
switching from a smaller resolution to a larger one?

In fl2000_crtc_mode_set_nofb(), the return value of
fl2000_stream_mode_set() is ignored. Inside fl2000_stream_mode_set():

drivers/gpu/drm/fl2000/fl2000_streaming.c:fl2000_stream_mode_set() {
	...
	stream->bytes_pix =3D bytes_pix;
	stream->width =3D width;
	stream->height =3D height;
	...
	ret =3D fl2000_stream_get_buffers(stream, size);
	if (ret) {
		fl2000_stream_put_buffers(stream);
		stream->buf_size =3D 0;
		return ret;
	}

	shadow =3D vzalloc(size);
	if (!shadow) {
		fl2000_stream_put_buffers(stream);
		stream->buf_size =3D 0;
		return -ENOMEM;
	}
	...
}

stream->width, stream->height, and stream->bytes_pix are updated to the new
dimensions before allocation, while stream->shadow still points to the old
smaller buffer on failure. When fl2000_plane_atomic_update() subsequently
calls fl2000_stream_compress(), the dimension check passes against the new
stream->width and stream->height, writing past the end of the old smaller
stream->shadow buffer.

[ ... ]

> +static void fl2000_drm_if_release(struct device *dev, void *res)
> +{
> +	struct fl2000_drm_if *drm_if =3D *(struct fl2000_drm_if **)res;
> +	struct drm_device *drm =3D &drm_if->drm;
> +	struct usb_device *usb_dev =3D drm_if->usb_dev;
> +
> +	dev_dbg(dev, "Unbinding FL2000 master\n");
> +
> +	/* No hotplug events for a node that is about to disappear */
> +	fl2000_intr_quiesce(drm_if->intr);
> +	drm_kms_helper_poll_fini(drm);
> +
> +	/*
> +	 * Block userspace access and shut down the display pipeline while all
> +	 * the components are still bound.
> +	 */
> +	drm_dev_unplug(drm);
> +	drm_atomic_helper_shutdown(drm);
> +
> +	/*
> +	 * Detach bridge component. This release function runs with the global
> +	 * component mutex held (component_master_del() -> master unbind ->
> +	 * devres_release()), so it must never call component_del() - that would
> +	 * self-deadlock. The IT66121 is destroyed by a usb_device devres inste=
ad.
> +	 */
> +	component_unbind_all(dev, drm);
> +
> +	/* Stop streaming interface */
> +	fl2000_stream_destroy(usb_dev);
> +
> +	/* Stop interrupts interface */
> +	fl2000_intr_destroy(usb_dev);
> +
> +	/*
> +	 * Drop the driver's reference. The DRM device is freed when the last
> +	 * userspace file is closed; it only pins the USB device, never the I2C
> +	 * adapter, so the disconnect does not wait for userspace.
> +	 */
> +	drm_dev_put(drm);
> +}

[Severity: Medium]
If the interfaces unbind and rebind (for example across usb_reset_device())
while userspace still holds an open file descriptor to the DRM device, does
the IT66121 bridge remain attached to the old encoder?

In fl2000_drm_bind(), drm_if->encoder is initialized with
drmm_encoder_init(), so drm_encoder_cleanup() -> drm_bridge_detach() only
runs when the final reference to struct drm_device is dropped. Because
it66121_unbind() is a no-op:

drivers/gpu/drm/fl2000/fl2000_it66121.c:it66121_unbind() {
	/* The bridge is detached by the DRM core when the encoder is cleaned up */
	dev_dbg(comp, "Unbinding IT66121 component\n");
}

calling component_unbind_all() and drm_dev_put() here while userspace holds
an open DRM fd leaves bridge->dev pointing to the old drm_device and leaves
priv->work running. When fl2000_drm_bind() runs on rebind, won't
it66121_bind() -> drm_bridge_attach() fail with -EBUSY?

[ ... ]

> +int fl2000_drm_resume(struct device *master)
> +{
> +	struct fl2000_drm_if *drm_if =3D fl2000_drm_if_of(master);
> +	struct usb_device *usb_dev;
> +	struct drm_bridge *bridge;
> +	int ret;
> +
> +	if (!drm_if)
> +		return 0;
> +	usb_dev =3D drm_if->usb_dev;
> +
> +	/* First, as the IT66121 is reached through the FL2000 I2C engine */
> +	fl2000_regmap_drop_cache(usb_dev);
> +
> +	bridge =3D drm_bridge_chain_get_first_bridge(&drm_if->encoder);
> +	if (bridge) {
> +		it66121_resume(bridge);
> +		drm_bridge_put(bridge);
> +	}
> +
> +	/* The same order as in fl2000_drm_bind() */
> +	fl2000_reset(usb_dev);
> +	fl2000_usb_magic(usb_dev);

[Severity: Medium]
Can fl2000_reset() and fl2000_usb_magic() race with it66121_intr_work()
here, in fl2000_drm_bind(), and in fl2000_crtc_mode_set_nofb()?

Calling it66121_resume() (or component_bind_all() in fl2000_drm_bind())
starts the periodic it66121_intr_work() task, which polls IT66121 registers
over the FL2000 I2C controller every 100 ms. Immediately afterwards,
fl2000_reset() issues a software reset and fl2000_usb_magic() modifies
FL2000_VGA_I2C_SC_REG without holding the I2C bus lock. If an I2C read in
it66121_intr_work() coincides with the reset or register write and fails,
it66121_intr_work() returns early without re-queueing priv->work,
permanently stopping IT66121 interrupt polling.

[ ... ]

> +	ret =3D drm_universal_plane_init(drm, &drm_if->plane, 0, &fl2000_plane_=
funcs,
> +				       fl2000_pixel_formats, ARRAY_SIZE(fl2000_pixel_formats),
> +				       fl2000_plane_format_modifiers, DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret) {
> +		drm_err(drm, "Cannot initialize plane (%d)\n", ret);
> +		goto err_free_holder;
> +	}
> +	drm_plane_helper_add(&drm_if->plane, &fl2000_plane_helper_funcs);
> +
> +	/*
> +	 * Enable the damage-clips property the update path relies on
> +	 * (drm_atomic_helper_damage_merged()).
> +	 */
> +	drm_plane_enable_fb_damage_clips(&drm_if->plane);
> +
> +	ret =3D drm_universal_plane_init(drm, &drm_if->cursor, 0, &fl2000_plane=
_funcs,
> +				       fl2000_cursor_formats, ARRAY_SIZE(fl2000_cursor_formats),
> +				       fl2000_plane_format_modifiers, DRM_PLANE_TYPE_CURSOR, NULL);

[Severity: Medium]
Should fl2000_drm_bind() attach a blend mode property via
drm_plane_create_blend_mode_property() to drm_if->plane and drm_if->cursor?

Both fl2000_pixel_formats (DRM_FORMAT_ARGB2101010) and
fl2000_cursor_formats (DRM_FORMAT_ARGB8888) expose formats with an alpha
channel. Without a blend mode property on those planes,
drm_dev_register() -> drm_mode_config_validate() logs a drm_warn() for each
plane on every bind, and userspace cannot tell that the primary plane
ignores alpha (DRM_MODE_BLEND_PIXEL_NONE) while the cursor plane blends
with coverage alpha (DRM_MODE_BLEND_COVERAGE).

[ ... ]

> +	ret =3D drm_vblank_init(drm, drm->mode_config.num_crtc);
> +	if (ret) {
> +		drm_err(drm, "Failed to initialize %d VBLANK(s) (%d)\n",
> +			drm->mode_config.num_crtc, ret);
> +		goto err_unbind;
> +	}
> +
> +	fl2000_reset(usb_dev);
> +	fl2000_usb_magic(usb_dev);

[Severity: Medium]
Should fl2000_enable_interrupts(usb_dev) also be called after
fl2000_usb_magic(usb_dev) in fl2000_drm_bind() and fl2000_drm_resume()?

Currently fl2000_enable_interrupts() is only called in
fl2000_crtc_mode_set_nofb(), so FL2000_VGA_CTRL_ACLK_EDID_MON_INT_EN and
FL2000_VGA_CTRL2_ACLK_HDMI_INT_EN remain disabled after bind and after
system resume whenever no modeset is active.

In addition, when fl2000_vga_detect_ctx() reads the self-clearing
FL2000_VGA_STATUS_REG via fl2000_intr_monitor_connected() ->
fl2000_intr_read_status(), any pending FL2000_VGA_STATUS_MONITOR_EVENT or
FL2000_VGA_STATUS_EDID_EVENT bits are cleared from hardware and ORed into
intr->events, but fl2000_vga_detect_ctx() does not set vga->edid_stale when
status is connector_status_connected, so fl2000_vga_get_modes() can reuse a
stale EDID on that probe while a later fl2000_intr_work() run marks the
newly read EDID stale.

[ ... ]

> diff --git a/drivers/gpu/drm/fl2000/fl2000_drv.c b/drivers/gpu/drm/fl2000=
/fl2000_drv.c
> index 107eba92c18d3..2e71f0aec7961 100644
> --- a/drivers/gpu/drm/fl2000/fl2000_drv.c
> +++ b/drivers/gpu/drm/fl2000/fl2000_drv.c

[ ... ]

> @@ -49,6 +84,8 @@ static struct fl2000_devs *fl2000_get_devices(struct us=
b_device *usb_dev)
>  		return ERR_CAST(devs->adapter);
>  	}
> =20
> +	component_match_add(&devs->adapter->dev, &devs->match, fl2000_compare, =
devs->adapter);
> +
>  	dev_set_drvdata(&usb_dev->dev, devs);
> =20
>  	return devs;
> @@ -138,6 +175,16 @@ static int fl2000_probe(struct usb_interface *interf=
ace, const struct usb_device
>  		break;
>  	}
> =20
> +	/* When all interfaces are up - proceed with registration */
> +	if (devs->active_if =3D=3D FL2000_ALL_IFS) {
> +		ret =3D component_master_add_with_match(&devs->adapter->dev, &fl2000_m=
aster_ops,
> +						      devs->match);
> +		if (ret) {
> +			dev_err(&usb_dev->dev, "Cannot register component master (%d)\n", ret=
);
> +			return ret;
> +		}
> +	}
> +
>  	return ret;
>  }

[Severity: High]
Are there a few error-handling regressions here in fl2000_get_devices() and
fl2000_probe()?

First, if component_match_add() fails to allocate in fl2000_get_devices(),
it sets devs->match to ERR_PTR(-ENOMEM), which is not checked before
component_master_add_with_match() dereferences match->num in
component_match_realloc().

Second, in fl2000_probe(), BIT(iface_num) is set in devs->active_if before
calling component_master_add_with_match(). If
component_master_add_with_match() fails, fl2000_probe() returns ret without
clearing BIT(iface_num), and the driver core will not call
fl2000_disconnect() for the interface that failed to probe, leaving
devs->active_if permanently corrupted.

Third, in the default branch of switch (iface_num), fl2000_probe() sets
ret =3D -ENODEV and breaks instead of returning early; if devs->active_if is
already FL2000_ALL_IFS, execution falls through and calls
component_master_add_with_match() a second time.

> @@ -151,11 +198,18 @@ static void fl2000_disconnect(struct usb_interface =
*interface)
>  		return;
> =20
>  	/*
> -	 * The IT66121 bridge is intentionally NOT destroyed here: disconnect
> -	 * also runs for the transient unbind/rebind cycles of
> -	 * usb_reset_device(), where the usb_device survives. Its destruction is
> -	 * a devres of the usb_device, see fl2000_bridge_create().
> +	 * The IT66121 bridge component is intentionally NOT destroyed here.
> +	 * Disconnect also runs for the transient unbind/rebind cycles of
> +	 * usb_reset_device(), where the usb_device (and the I2C adapter and
> +	 * aggregate match data) survive: the component must persist across
> +	 * those. Its destruction is a devres of the usb_device, see
> +	 * fl2000_bridge_create(). Destroying it from the master unbind path is
> +	 * also forbidden - component_del() would self-deadlock on the global
> +	 * component mutex held across the unbind callback.
>  	 */
> +	if (devs->active_if =3D=3D FL2000_ALL_IFS)
> +		component_master_del(&devs->adapter->dev, &fl2000_master_ops);

[Severity: High]
What happens if the fl2000 module is unloaded (or the interfaces are
unbound via sysfs) while the USB device remains plugged in?

Because fl2000_get_devices() and fl2000_bridge_create() attach devs,
regmap, the I2C adapter, the component match callback fl2000_compare(), and
the IT66121 bridge component as devres on &usb_dev->dev and
&devs->adapter->dev, and &usb_dev->dev stays bound to usb_generic_driver
when the usb_interface devices unbind, fl2000_disconnect() leaves those
resources, workqueues, and callbacks registered on usb_device after all
interfaces have disconnected. Unloading the module while the adapter is
plugged in will leave devres release callbacks and function pointers on
usb_device pointing into unmapped module memory.

[ ... ]

> +static int fl2000_suspend(struct usb_interface *interface, pm_message_t =
message)
> +{
> +	struct usb_device *usb_dev =3D interface_to_usbdev(interface);
> +	struct fl2000_devs *devs =3D dev_get_drvdata(&usb_dev->dev);
> +	int ret;
> =20
> -	/*
> -	 * Nothing to save yet. Providing the callback keeps the USB core from
> -	 * unbinding the driver across system sleep.
> -	 */
> -	dev_dbg(&usb_dev->dev, "suspend\n");
> +	if (!devs || devs->suspended)
> +		return 0;
> +
> +	ret =3D fl2000_drm_suspend(&devs->adapter->dev);
> +	if (ret)
> +		return ret;
> +
> +	devs->suspended =3D true;
> =20
>  	return 0;
>  }

[Severity: Medium]
If fl2000_drm_suspend() returns an error during system sleep, won't the USB
device still suspend with devs->suspended left false?

During system sleep (!PMSG_IS_AUTO(message)), usb_suspend_both() in the USB
core ignores errors returned by usb_suspend_interface() and proceeds to
suspend the device anyway. If drm_mode_config_helper_suspend() fails inside
fl2000_drm_suspend(), fl2000_drm_suspend() restarts the interrupt URB and
skips it66121_suspend(), and fl2000_suspend() leaves devs->suspended false,
causing fl2000_resume() on wake or reset-resume to return early without
calling fl2000_drm_resume().

[ ... ]

> diff --git a/drivers/gpu/drm/fl2000/fl2000_interrupt.c b/drivers/gpu/drm/=
fl2000/fl2000_interrupt.c
> new file mode 100644
> index 0000000000000..6ad0f1dd0e51e
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_interrupt.c

[ ... ]

> +static void fl2000_intr_completion(struct urb *urb)
> +{
> +	int ret;
> +	struct usb_device *usb_dev =3D urb->dev;
> +	struct fl2000_intr *intr =3D urb->context;
> +
> +	ret =3D fl2000_urb_status(usb_dev, urb->status);
> +	if (ret) {
> +		/* Killed on purpose (suspend, unplug) is no reason to complain */
> +		if (ret !=3D -ENOENT && ret !=3D -ECONNRESET)
> +			dev_err(&usb_dev->dev, "Stopping interrupts\n");
> +		return;
> +	}
> +
> +	/* Processing reads registers over USB, which sleeps: defer it to a wor=
k item */
> +	queue_work(intr->work_queue, &intr->work);
> +
> +	/*
> +	 * For interrupt URBs, as part of successful URB submission urb->interv=
al is modified to
> +	 * reflect the actual transfer period used, so we need to restore it.
> +	 */
> +	urb->interval =3D intr->poll_interval;
> +	urb->start_frame =3D -1;
> +
> +	/* Restart urb */
> +	ret =3D usb_submit_urb(urb, GFP_ATOMIC);
> +	if (ret)
> +		dev_err(&usb_dev->dev, "URB submission failed (%d)\n", ret);
> +}

[Severity: Medium]
Doesn't setting urb->interval =3D intr->poll_interval here corrupt the
High-Speed / SuperSpeed polling interval on every resubmission?

In fl2000_intr_create(), intr->poll_interval stores the raw logarithmic
desc->bInterval exponent, and usb_fill_int_urb() converts that exponent
into microframes (1 << (bInterval - 1)) in urb->interval. Overwriting
urb->interval with the raw intr->poll_interval before usb_submit_urb()
passes the exponent as a microframe count.

Also in fl2000_intr_create(), usb_find_int_in_endpoint() locates desc, but
usb_fill_int_urb() hardcodes endpoint 3 via usb_rcvintpipe(usb_dev, 3)
instead of using usb_endpoint_num(desc); and in fl2000_intr_work(),
atomic_xchg(&intr->events, 0) consumes pending events before
fl2000_drm_hotplug() checks drm_if->registered, so any sink or EDID event
arriving before registration is dropped without calling
fl2000_vga_sink_event(&drm_if->vga).

[ ... ]

> diff --git a/drivers/gpu/drm/fl2000/fl2000_vga.c b/drivers/gpu/drm/fl2000=
/fl2000_vga.c
> new file mode 100644
> index 0000000000000..322cd8b165553
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_vga.c

[ ... ]

> +static enum drm_connector_status fl2000_vga_sense(struct fl2000_vga *vga)
> +{
> +	int ret =3D fl2000_intr_monitor_connected(vga->intr);
> +
> +	if (ret < 0)
> +		return connector_status_unknown;
> +	if (!ret)
> +		return connector_status_disconnected;
> +
> +	if (vga->hdmi_bridge) {
> +		/*
> +		 * Not knowing whether there is an HDMI sink is not the same as there =
being none:
> +		 * two connected outputs on the one CRTC can leave a compositor with n=
either.
> +		 */
> +		ret =3D it66121_hpd_connected(vga->hdmi_bridge);
> +		if (ret < 0)
> +			return connector_status_unknown;
> +		if (ret)
> +			return connector_status_disconnected;
> +	}
> +
> +	return connector_status_connected;
> +}

[Severity: High]
Won't fl2000_vga_sense() falsely report a connected VGA monitor whenever an
active HDMI monitor is unplugged?

While the CRTC is driving the HDMI encoder, fl2000_crtc_force_connect()
keeps FL2000_VGA_CTRL_ACLK_FORCE_VGA_CONNECT set, which forces the chip's
shared FL2000_VGA_STATUS_MONITOR_STATUS bit to 1 until
fl2000_crtc_atomic_disable() clears it. When the HDMI cable is unplugged,
connector detection runs before the CRTC is disabled:
it66121_hpd_connected(vga->hdmi_bridge) returns 0, while
fl2000_intr_monitor_connected(vga->intr) still returns 1 because monitor
sense is forced, causing fl2000_vga_sense() to report
connector_status_connected on the empty VGA connector with fallback modes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-fl2000-ups=
tream-v1-0-bb163ecb2309@gmail.com?part=3D4
