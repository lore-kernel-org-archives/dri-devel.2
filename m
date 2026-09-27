Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D31C98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39FD10E690;
	Sun, 27 Sep 2026 18:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WMxVMleX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6176E10E690
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:42:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E97F601F7;
 Sun, 27 Sep 2026 18:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC881F000FF;
 Sun, 27 Sep 2026 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790534572;
 bh=1Q2T8Qg8KcEGI8SZ9BtAgCZ1juKZIYN8YiUBvn6LlJ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WMxVMleX1XZSeK7pUzjhmsG7pWQUEZ8RAv9D0CgRqEc/jCkW6DNEyYqjKJ5hd8RqJ
 0RN7MsS/5xWAtyqEsz8M3sbsN+lyX4J36JT+eNNoZuHT0G9SnKw+OBj5woEM9LycPK
 3rbMZzREHDMAuAjFCbnpWlUhk89Leb/v4WM4ZBLiw6ab0RI6aQ3eAbmSJXXPcnVog/
 Rz/c70a63r69SR9ztzboEBkjC02uXWS3+mXBLSLNKumvqOZIe2z3spOcm1zHcmNUS9
 ziWIWQQMolHk4PdymYJYX5IM4b/nNaXGzps9MVO1xwsBgMXwYvvcd4ydZqeBSm5Dr0
 ef/mfb15Ri2ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/14] drm/solomon: Add DRM driver for Solomon
 SSD16xx e-paper display controllers
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260927182329.4193961-5-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
 <20260927182329.4193961-5-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:42:52 +0000
Message-Id: <20260927184252.7FC881F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] drm/solomon: critical heap buffer overflow in format conversion
- [High] drm/solomon: sleeping in atomic context during plane and crtc upda=
tes
- [High] drm/solomon: redundant hardware reset and full redraw on every ato=
mic commit
- [High] drm/solomon: mapping local stack variables for SPI DMA transfers
- [High] drm/solomon: illegal direct dereference of iosys_map vaddr
- [High] drm/solomon: use-after-free of last_fb during crtc_atomic_flush
- [Medium] drm/solomon: ssd16xx_convert_fb_to_3color ignores orientation ca=
using scrambled output
- [Medium] drm/solomon: DRM_SSD16XX selects DRM_GEM_SHMEM_HELPER without MM=
U dependency
- [Medium] drm/solomon: scrambled image on reverse rotations due to missing=
 intra-byte bit reversal
- [Medium] drm/solomon: missing drm_dev_enter protection in plane_atomic_up=
date
- [Medium] drm/solomon: data race on device->init_refresh_pending flag
- [Medium] drm/solomon: incorrect endianness conversion reading XRGB8888 pi=
xels
--

commit c0d6d51051f544c36f758eda4ee2441c54d494b8
Author: Devarsh Thakkar <devarsht@ti.com>

drm/solomon: Add DRM driver for Solomon SSD16xx e-paper display controllers

This commit introduces a new DRM driver for the Solomon Systech SSD16xx
family of e-paper display controllers. It supports panels like the
Gooddisplay GDEY042T81 and implements hardware features such as deep sleep
modes, 4-way rotation, and single primary plane updates.

> diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kc=
onfig
> --- a/drivers/gpu/drm/solomon/Kconfig
> +++ b/drivers/gpu/drm/solomon/Kconfig
[ ... ]
> @@ -30,3 +30,16 @@ config DRM_SSD130X_SPI
> +config DRM_SSD16XX
> +	tristate "DRM support for Solomon SSD16xx e-ink display controllers"
> +	depends on DRM && SPI
> +	select DRM_CLIENT_SELECTION
> +	select DRM_KMS_HELPER
> +	select DRM_GEM_SHMEM_HELPER

[Severity: Medium]
Does selecting DRM_GEM_SHMEM_HELPER here without inheriting its required
depends on MMU dependency cause Kconfig unmet direct dependency warnings and
potential build failures on MMU-less architectures?

> diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/=
ssd16xx.c
> --- /dev/null
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c
[ ... ]
> +static void ssd16xx_wait_for_device(struct ssd16xx_device *device,
> +				    int *err)
> +{
[ ... ]
> +	while (gpiod_get_value_cansleep(device->busy) =3D=3D 1) {
> +		if (time_after(jiffies, timeout_jiffies)) {
> +			drm_err(&device->drm, "Busy wait timed out after %lums\n",
> +				jiffies_to_msecs(jiffies) - start_ms);
> +			*err =3D -ETIMEDOUT;
> +			return;
> +		}
> +		usleep_range(1000, 2000);

[Severity: High]
Can this sleep inside an atomic context? The DRM subsystem guidelines stric=
tly
dictate that plane_atomic_update and crtc_atomic_flush are atomic context
paths where sleeping is forbidden.

This driver calls usleep_range, spi_sync, and drm_gem_vmap (which takes a
sleeping ww_mutex) from within these callbacks. Violating this invariant
causes system instability, kernel warnings, and potential deadlocks when th=
ese
functions run in non-preemptible contexts.

[ ... ]
> +static void ssd16xx_send_cmd(struct ssd16xx_device *device, u8 cmd,
> +			     int *err)
> +{
> +	u16 word;
> +	struct spi_transfer xfer =3D {};
> +	struct spi_message msg;
> +
> +	if (*err)
> +		return;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	if (device->dc) {
> +		/* 4-wire SPI: D/C# GPIO low selects command mode */
> +		xfer.tx_buf =3D &cmd;

[Severity: High]
Is it safe to assign pointers to local stack variables (like &cmd, &word, a=
nd
&data) to the tx_buf of an spi_transfer?=20

The SPI subsystem maps these buffers for DMA via spi_sync. Passing stack
memory to the DMA API is explicitly forbidden; on architectures without
coherent DMA caches, this causes cache-line sharing corruption and triggers
DMA API debug panics.

[ ... ]
> +static u8 ssd16xx_pixel_luma(struct iosys_map *src,
> +			     struct drm_framebuffer *fb,
> +			     unsigned int x, unsigned int y)
> +{
> +	u32 *line =3D (u32 *)(src->vaddr + y * fb->pitches[0]);
> +	u32 px =3D line[x];

[Severity: High]
Does this directly dereference an iosys_map structure bypassing the required
abstraction API? iosys_map is explicitly designed to abstract memory that m=
ay
reside in I/O space. Direct CPU dereference of an IOMEM pointer without
iosys_map_rd or similar helpers will trigger exceptions and kernel panics on
architectures that require specialized I/O accessors.

[Severity: Medium]
Will this native-endian u32 memory dereference convert endianness correctly=
 on
big-endian hardware?=20

DRM formats like XRGB8888 are strictly little-endian byte arrays in memory.=
 On
big-endian CPUs, this native memory load will reverse the byte sequence,
causing the subsequent bitwise shifts to extract incorrect colors.

[ ... ]
> +static void ssd16xx_convert_fb_to_3color(u8 *bw_dst, u8 *red_dst,
> +					 struct iosys_map *src,
> +					 struct drm_framebuffer *fb,
> +					 struct drm_rect *rect)
> +{
> +	unsigned int x, y;
> +	u8 bw_byte =3D 0, red_byte =3D 0;
> +	unsigned int bit_pos =3D 0;
> +	unsigned int dst_idx =3D 0;
[ ... ]
> +	/* XRGB8888 */
> +	for (y =3D rect->y1; y < rect->y2; y++) {
> +		for (x =3D rect->x1; x < rect->x2; x++) {

[Severity: Medium]
Does this hardcoded row-major traversal ignore the device orientation?=20

While the 1bpp monochrome conversion correctly alters pixel packing geometry
based on display orientation, this function seems to ignore it completely. =
This
can result in the RED RAM being populated in an incompatible geometric layo=
ut,
rendering scrambled red ink for non-native orientations.

[ ... ]
> +static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
> +				       struct drm_framebuffer *fb,
> +				       struct drm_rect *rect,
> +				       unsigned int orientation)
> +{
[ ... ]
> +		for (x =3D rect->x2 - 1; x >=3D (int)rect->x1; x--) {
> +			for (y =3D rect->y1; y < rect->y2; y++) {
> +				if (ssd16xx_pixel_is_white(src, fb, x, y))
> +					byte |=3D (1 << (7 - bit_pos));

[Severity: Medium]
Does this bit packing logic properly handle reverse rotations?=20

To implement 90 and 180 degree rotations, the hardware is configured to
decrement RAM addresses (XDEC_YDEC), but the hardware does not internally
reverse the pixel-to-bit assignment within each 8-pixel byte. Packing pixels
in a strictly forward bit sequence here means the first pixel from the reve=
rsed
iteration ends up in bit 7 instead of bit 0, resulting in the 8 pixels of e=
very
byte being displayed in reverse order.

[ ... ]
> +static int ssd16xx_fb_dirty(struct drm_framebuffer *fb, struct drm_rect =
*rect,
> +			    struct ssd16xx_device *device,
> +			    const struct iosys_map *src_map)
> +{
> +	const u8 *ctrl2_tbl =3D device->controller_cfg->ctrl2_refresh;
> +	struct iosys_map map =3D *src_map;
> +	int err =3D 0;
> +	unsigned int data_size =3D (device->width * device->height) / 8;
> +	u8 *mono_buffer =3D NULL;
> +	u8 *red_buffer =3D NULL;
> +	u16 ram_x_start, ram_x_end, ram_y_start, ram_y_end;
> +
> +	/*
> +	 * Process full display area.  The rect for convert_fb_to_1bpp uses
> +	 * the framebuffer (logical) dimensions - the pixel iteration walks
> +	 * the source fb coordinate space. RAM window registers below use
> +	 * the physical panel dimensions (device->width/height).
> +	 */
> +	rect->x1 =3D 0;
> +	rect->y1 =3D 0;
> +	rect->x2 =3D fb->width;
> +	rect->y2 =3D fb->height;

[Severity: Critical]
Can this cause a heap buffer overflow in the format conversion?=20

The TX buffers are statically allocated to exactly fit the physical panel
dimensions in ssd16xx_alloc_tx_bufs. By overriding the provided CRTC plane
boundaries with the full, unconstrained framebuffer dimensions here, if
userspace supplies a framebuffer larger than the CRTC, the conversion loop
will write out of bounds.=20

Additionally, at native resolutions using portrait orientations (like 300x4=
00),
the 37.5-byte rows are padded to 38 bytes per row (400 * 38 =3D 15,200 byte=
s),
which overflows the 15,000 byte allocation.

[ ... ]
> +static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
> +					struct drm_atomic_commit *state)
> +{
[ ... ]
> +	saved_mode =3D device->refresh_mode;
> +	saved_border_waveform_idx =3D device->border_waveform_update_idx;
> +	if (device->init_refresh_pending) {
> +		device->refresh_mode =3D device->refresh_mode_init;
> +		device->border_waveform_update_idx =3D device->border_waveform_init_id=
x;
> +	}

[Severity: Medium]
Is there a data race on the device->init_refresh_pending flag?=20

The boolean flag is modified in ssd16xx_drm_master_set and
ssd16xx_drm_master_drop under the protection of the DRM core's master_mutex.
Simultaneously, it is read and modified here under the DRM modeset locks. S=
ince
these are separate lock classes, a concurrent atomic commit and SET_MASTER
ioctl could trigger a data race.

[ ... ]
> +	if (device->fast_lut_pending) {
> +		ret =3D ssd16xx_preload_fast_lut(device);
> +		if (ret) {
> +			drm_err(&device->drm,
> +				"plane_atomic_update: fast LUT preload failed: %d\n", ret);
> +		}
> +
> +		device->fast_lut_pending =3D false;
> +	}
> +
> +	ret =3D ssd16xx_fb_dirty(fb, &rect, device, &shadow_state->data[0]);

[Severity: Medium]
Is this missing drm_dev_enter protection?=20

Initiating hardware interactions (such as SPI writes and GPIO polls) without
drm_dev_enter validation can lead to race conditions during teardown from t=
he
commit workqueue. If the SPI device is unbound, devres frees hardware
resources, and omitting drm_dev_enter here could trigger a use-after-free on
the SPI device or GPIOs.

> +	if (ret)
> +		drm_err(&device->drm, "plane_atomic_update: display update failed: %d\=
n", ret);
> +	else
> +		device->last_fb =3D fb;

[Severity: High]
Does storing a raw pointer to the framebuffer without incrementing its
reference count risk a use-after-free?=20

When the plane is later disabled by userspace, last_fb can become a dangling
pointer if the framebuffer is cleaned up by the core. A subsequent atomic
commit on the CRTC will trigger ssd16xx_crtc_atomic_flush, which falls back
to this dangling last_fb pointer.

[ ... ]
> +static void ssd16xx_crtc_atomic_flush(struct drm_crtc *crtc,
> +				      struct drm_atomic_commit *state)
> +{
> +	struct ssd16xx_device *device =3D crtc_to_ssd16xx_device(crtc);
> +	struct drm_framebuffer *fb;
> +	struct drm_rect full;
> +	int ret, idx;
> +
> +	if (!device->initialized)
> +		return;
> +
> +	if (!drm_dev_enter(&device->drm, &idx))
> +		return;
> +
> +	drm_dbg(&device->drm, "atomic_flush: reinit, orientation=3D%u=C2=B0\n",
> +		device->orientation);
> +
> +	ret =3D ssd16xx_hw_init(device);

[Severity: High]
Does this perform a redundant hardware reset and full redraw on every atomic
commit?=20

Because this is called by the DRM core on every atomic commit that affects =
the
CRTC, its unconditional execution of ssd16xx_hw_init and ssd16xx_fb_dirty is
highly destructive. plane_atomic_update already transmits the damaged regio=
ns;
triggering a full hardware reset and complete framebuffer re-transmission h=
ere
completely breaks damage tracking, causes display flicker, and doubles the
transmission latency.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182329.4193=
961-1-devarsht@ti.com?part=3D4
