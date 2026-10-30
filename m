Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F0606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbsckWdA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF1010E86A;
	Fri, 30 Oct 2026 09:10:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D693D10E86A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:09:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F03B431F8;
 Fri, 30 Oct 2026 09:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385F71F000C1;
 Fri, 30 Oct 2026 09:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793351398;
 bh=ztl2n7/r1n4ZTU+a0Ghr96HWYCrIstg5ehBee4wGBos=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WbsckWdA2EyydKNGU1ih0ALr2+Ch9d+9udVYVF1gRNJfvX9t76FV5vbOTkQj+bc1I
 xjp/RsJz2Wi+w66iwcEQLhQ/qk+nuyWtYaUetDVcOYZJW9Mh6xFlA5kWGTPpqjd8iU
 U1MbkTCrEsSdMWF9UyuARaKzSrhIhWod/7iS8km2hxQfe3Ha0t6aZldPcL7HOPkRD8
 fj9FJFxaufv62pdrKarnxaYzx848NFbK3PbOpV+iJH//lF0i8Brs327uZI0mINJnbn
 zj3SDfuemrpv7Gs7bQJwlplD9VhX2/9KXoN6/4E99laF2P/2z8FSlnMk2/FSbLgA+r
 eO5PsVCY042WQ==
Message-ID: <sashiko-outbox-190739@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] drm/tiny: Add RAiO RA8875 display controller driver
To: "Adam Azuddin" <azuddinadam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261030083737.47188-3-azuddinadam@gmail.com>
References: <20261030083737.47188-1-azuddinadam@gmail.com>
 <20261030083737.47188-3-azuddinadam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 09:09:57 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] drm/tiny: ra8875: heap overflow in ra8875_clear_screen() via u=
nvalidated mode
- [High] drm/tiny: ra8875: plane updates run before CRTC enable and screen =
clear
- [High] drm/tiny: ra8875: miscalculation of HNDR and VNDR back porch in ra=
8875_hw_init()
- [High] drm/tiny: ra8875: missing drm_dev_enter() guard in ra8875_crtc_ato=
mic_enable()
- [Medium] drm/tiny: ra8875: missing vdd-supply regulator acquisition and e=
nable
- [Medium] drm/tiny: ra8875: missing drm_gem_fb_begin_cpu_access() in ra887=
5_fb_dirty()
- [Medium] drm/tiny/ra8875: unaligned u16 stores in ra8875_fb_dirty() via d=
rm_fb_swab()
- [Low] drm/tiny: ra8875: missing MMU dependency in Kconfig for DRM_RA8875
--

commit 7ff969ff52235eb3411700feffd794a3e46ceb5a
Author: Adam Azuddin <azuddinadam@gmail.com>

drm/tiny: Add RAiO RA8875 display controller driver

This commit adds a DRM tiny driver for the RAiO RA8875 SPI-connected TFT
display controller supporting resolutions up to 800x480 with GEM shmem
buffer management.

> diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
> index f0e72d4b6a470..2f1c49e31dd60 100644
> --- a/drivers/gpu/drm/tiny/Kconfig
> +++ b/drivers/gpu/drm/tiny/Kconfig
> @@ -98,6 +98,19 @@ config DRM_PIXPAPER
> =20
>  	  If M is selected, the module will be built as pixpaper.ko.
> =20
> +config DRM_RA8875
> +	tristate "DRM support for RA8875 display panels"
> +	depends on DRM && SPI && OF
> +	select DRM_CLIENT_SELECTION
> +	select DRM_KMS_HELPER
> +	select DRM_GEM_SHMEM_HELPER
> +	select VIDEOMODE_HELPERS

[Severity: Low]
In drivers/gpu/drm/tiny/Kconfig, DRM_RA8875 selects DRM_GEM_SHMEM_HELPER,
which depends on MMU in drivers/gpu/drm/Kconfig.

Without a dependency on MMU, enabling DRM_RA8875 on a !CONFIG_MMU target
triggers an unmet direct dependency warning and fails to build in
drm_gem_shmem_helper.c.

Should DRM_RA8875 depend on MMU as well, matching the other shmem-based
drivers in drivers/gpu/drm/tiny/Kconfig?

[ ... ]

> diff --git a/drivers/gpu/drm/tiny/ra8875.c b/drivers/gpu/drm/tiny/ra8875.c
> new file mode 100644
> index 0000000000000..937bb7fdbd910
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/ra8875.c
[ ... ]
> +static int ra8875_hw_init(struct ra8875_device *ra8875,
> +			  struct drm_display_mode *mode)
> +{
[ ... ]
> +	/* Horizontal timing */
> +	hdwr =3D (mode->hdisplay / 8) - 1;
> +	hndr =3D ((mode->htotal - mode->hdisplay) / 8) - 1;
> +	hstr =3D ((mode->hsync_start - mode->hdisplay) / 8) - 1;
> +	hpwr =3D ((mode->hsync_end - mode->hsync_start) / 8) - 1;
> +
> +	ret =3D ra8875_write_reg(ra8875, RA8875_HDWR, hdwr);
> +	if (ret)
> +		return ret;
> +	ret =3D ra8875_write_reg(ra8875, RA8875_HNDFTR, RA8875_HNDFTR_HNDFT(0));
> +	if (ret)
> +		return ret;
> +	ret =3D ra8875_write_reg(ra8875, RA8875_HNDR, hndr);
> +	if (ret)
> +		return ret;
> +	ret =3D ra8875_write_reg(ra8875, RA8875_HSTR, hstr);
> +	if (ret)
> +		return ret;
> +	ret =3D ra8875_write_reg(ra8875, RA8875_HPWR, hpwr);
> +	if (ret)
> +		return ret;
> +
> +	/* Vertical timing */
> +	vdhr =3D mode->vdisplay - 1;
> +	vndr =3D mode->vtotal - mode->vdisplay - 1;
> +	vstr =3D mode->vsync_start - mode->vdisplay - 1;
> +	vpwr =3D mode->vsync_end - mode->vsync_start - 1;

[Severity: High]
In drivers/gpu/drm/tiny/ra8875.c, are hndr and vndr in ra8875_hw_init()
being computed from the total blanking interval rather than the back porch?

In drm_display_mode_from_videomode():

    dmode->hsync_start =3D dmode->hdisplay + vm->hfront_porch;
    dmode->hsync_end =3D dmode->hsync_start + vm->hsync_len;
    dmode->htotal =3D dmode->hsync_end + vm->hback_porch;

Since HSTR (and VSTR0/VSTR1) already program the front porch and HPWR (and
VPWR) program the sync pulse width, RA8875_HNDR and RA8875_VNDR0/RA8875_VND=
R1
program the horizontal and vertical non-display (back porch) periods.

Using mode->htotal - mode->hdisplay and mode->vtotal - mode->vdisplay counts
the front porch and sync pulse width a second time. Should these be computed
from mode->htotal - mode->hsync_end and mode->vtotal - mode->vsync_end
instead?

[ ... ]

> +static int ra8875_clear_screen(struct ra8875_device *ra8875,
> +			       struct drm_display_mode *mode)
> +{
[ ... ]
> +	memset(txbuf, 0, 1 + rows_per_chunk * width * 2);
> +	txbuf[0] =3D RA8875_DATAWRITE;
> +
> +	for (y =3D 0; y < height; y +=3D rows) {
> +		rows =3D min(rows_per_chunk, height - y);
> +		ret =3D ra8875_write_pixels(ra8875, 1 + rows * width * 2);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ra8875_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_=
atomic_commit *state)
> +{
> +	struct ra8875_device *ra8875 =3D
> +		container_of(crtc->dev, struct ra8875_device, drm);
> +	struct drm_crtc_state *crtc_state =3D
> +		drm_atomic_get_new_crtc_state(state, crtc);
> +	struct drm_display_mode *mode =3D &crtc_state->mode;
> +	int ret;
> +
> +	ret =3D ra8875_hw_init(ra8875, mode);
> +	if (ret) {
> +		drm_err(&ra8875->drm, "Failed to initialize hardware\n");
> +		return;
> +	}
> +
> +	ret =3D ra8875_clear_screen(ra8875, mode);
> +	if (ret) {
> +		drm_err(&ra8875->drm, "Failed to clear screen\n");
> +		return;
> +	}
> +}

[Severity: High]
In drivers/gpu/drm/tiny/ra8875.c, doesn't the atomic commit order cause
ra8875_crtc_atomic_enable() to wipe out the initial plane update on every
modeset?

In ra8875_probe(), ra8875->rst_gpio is requested with GPIOD_OUT_HIGH and
drm->mode_config.helper_private is left unset. When drm_atomic_helper_commi=
t()
runs a modeset (including the initial fbdev modeset from drm_client_setup()=
),
it uses the default drm_atomic_helper_commit_tail(), which executes:

    drm_atomic_helper_commit_tail()
      drm_atomic_helper_commit_planes(dev, state, 0)
        ra8875_plane_atomic_update()
          ra8875_fb_dirty()
      drm_atomic_helper_commit_modeset_enables(dev, state)
        ra8875_crtc_atomic_enable()
          ra8875_hw_init()
          ra8875_clear_screen()

As a result, ra8875_plane_atomic_update() writes the framebuffer while the
chip is still held in reset, and then ra8875_crtc_atomic_enable() resets the
hardware and zeroes the entire display memory in ra8875_clear_screen().

In addition, ra8875_plane_atomic_check() passes can_update_disabled =3D tru=
e to
drm_atomic_helper_check_plane_state(), and ra8875_plane_atomic_update() does
not check whether the CRTC is active.

Should drm->mode_config.helper_private be configured with
.atomic_commit_tail =3D drm_atomic_helper_commit_tail_rpm (so CRTC enable r=
uns
before plane updates, and plane updates are skipped when the CRTC is
inactive), and can_update_disabled be set to false in
ra8875_plane_atomic_check()?

[Severity: High]
Also in ra8875_crtc_atomic_enable() in drivers/gpu/drm/tiny/ra8875.c, can a
modeset racing with device removal in ra8875_remove() cause a use-after-free
on ra8875->txbuf and ra8875->rst_gpio?

In ra8875_probe(), ra8875->txbuf and ra8875->rst_gpio are allocated with
devm_kzalloc(&spi->dev, ...) and devm_gpiod_get_optional(&spi->dev, ...), so
devres frees them as soon as ra8875_remove() returns, even if a DRM file
descriptor remains open.

Unlike ra8875_plane_atomic_update(), ra8875_crtc_atomic_enable() does not
guard its hardware and buffer accesses with drm_dev_enter() and
drm_dev_exit(). If an atomic commit enters ra8875_crtc_atomic_enable()
concurrently with or after drm_dev_unplug() in ra8875_remove(),
drm_dev_unplug() will not synchronize with it and ra8875_clear_screen() can
memset() and SPI-transfer from the freed ra8875->txbuf buffer.

Should ra8875_crtc_atomic_enable() (and ra8875_crtc_atomic_disable()) be
guarded with drm_dev_enter() and drm_dev_exit()?

[ ... ]

> +static void ra8875_fb_dirty(struct ra8875_device *ra8875, struct iosys_m=
ap *src,
> +			    struct drm_framebuffer *fb, struct drm_rect *rect)
> +{
[ ... ]
> +	for (int y =3D rect->y1; y < rect->y2; y +=3D rows) {
> +		struct drm_rect chunk;
> +
> +		rows =3D min(RA8875_TXBUF_ROWS, rect->y2 - y);
> +		chunk =3D DRM_RECT_INIT(rect->x1, y, width, rows);
> +
> +		iosys_map_set_vaddr(&dst, ra8875->txbuf + 1);
> +		drm_fb_swab(&dst, NULL, src, fb, &chunk, false, &fmtcnv_state);
> +
> +		if (ra8875_write_pixels(ra8875, 1 + rows * width * 2))
> +			goto err;
> +	}

[Severity: Medium]
In ra8875_fb_dirty() in drivers/gpu/drm/tiny/ra8875.c, drm_fb_swab() reads
from the shadow-mapped framebuffer with the CPU, but
drm_gem_begin_shadow_fb_access() only vmaps the buffer without calling
dma_buf_begin_cpu_access().

When displaying an imported PRIME DMA-BUF on a non-cache-coherent system, c=
an
omitting drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE) and
drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE) around the CPU read result in
stale cache reads and display corruption?

[Severity: Medium]
Also in ra8875_fb_dirty() in drivers/gpu/drm/tiny/ra8875.c, doesn't passing
ra8875->txbuf + 1 as the destination buffer to drm_fb_swab() perform
unaligned 16-bit stores on every pixel?

In ra8875_probe(), ra8875->txbuf is allocated with devm_kzalloc(), which is
even-aligned, making ra8875->txbuf + 1 an odd address. For DRM_FORMAT_RGB56=
5,
drm_fb_swab() calls drm_fb_swab16_line(), which casts the destination point=
er
directly to u16 * and writes *dbuf16++ =3D swab16(*sbuf16++) without
put_unaligned().

Can this trigger alignment faults on architectures requiring natural
alignment as well as UBSAN alignment warnings?

[ ... ]

> +static enum drm_mode_status ra8875_mode_valid(struct drm_crtc *crtc,
> +					      const struct drm_display_mode *mode)
> +{
> +	if (mode->hdisplay % 8 !=3D 0 || mode->hsync_start % 8 !=3D 0 ||
> +	    mode->hsync_end % 8 !=3D 0 || mode->htotal % 8 !=3D 0) {
> +		drm_dbg_kms(crtc->dev,
> +		   "mode timings must be 8-pixel aligned (hdisplay=3D%d hsync_start=3D=
%d hsync_end=3D%d htotal=3D%d)\n",
> +			    mode->hdisplay, mode->hsync_start, mode->hsync_end, mode->htotal);
> +		return MODE_H_ILLEGAL;
> +	}
> +	return MODE_OK;
> +}

[Severity: Critical]
As reported by Sashiko on v4 [1], can a userspace-supplied display mode
overflow ra8875->txbuf in ra8875_clear_screen()?

In ra8875_probe() in drivers/gpu/drm/tiny/ra8875.c, ra8875->txbuf is
allocated for a fixed maximum width of RA8875_MAX_WIDTH (800):

    buf_size =3D 1 + RA8875_TXBUF_ROWS * RA8875_MAX_WIDTH * 2;
    ra8875->txbuf =3D devm_kzalloc(&spi->dev, buf_size, GFP_KERNEL);

While drm->mode_config.max_width restricts framebuffer sizes, a userspace
DRM master can submit a custom CRTC mode via KMS (for example with the
primary plane disabled). Because ra8875_mode_valid() only checks that the
horizontal timings are multiples of 8 and does not call
drm_crtc_helper_mode_valid_fixed(crtc, mode, &ra8875->mode) or bound
mode->hdisplay to RA8875_MAX_WIDTH, committing a mode with mode->hdisplay >
800 causes ra8875_crtc_atomic_enable() -> ra8875_clear_screen() to memset()
and SPI-write 1 + 16 * mode->hdisplay * 2 bytes past the end of
ra8875->txbuf.

Additionally, neither ra8875_probe() nor ra8875_mode_valid() verifies that
the horizontal and vertical front porch, sync pulse, and back porch lengths
are strictly positive, so a zero-length porch or sync pulse will underflow
when subtracting 1 in ra8875_hw_init().

Should ra8875_mode_valid() validate the mode with
drm_crtc_helper_mode_valid_fixed() and verify that all porch and sync pulse
intervals are non-zero?

[ ... ]

> +static int ra8875_probe(struct spi_device *spi)
> +{
[ ... ]
> +	ra8875->rst_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HI=
GH);
> +	if (IS_ERR(ra8875->rst_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ra8875->rst_gpio),
> +			     "failed to get reset GPIO\n");

[Severity: Medium]
In ra8875_probe() in drivers/gpu/drm/tiny/ra8875.c, the driver requests the
optional reset GPIO, but never acquires or enables the vdd-supply regulator
that is marked as required in
Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml.

If vdd-supply is backed by a switchable regulator that is disabled at boot =
or
turned off by the regulator core as unused, won't the RA8875 remain unpower=
ed
when ra8875_hw_init() attempts SPI transfers? Should ra8875_probe() enable
the vdd supply (for example via devm_regulator_get_enable(dev, "vdd"))?

[1] https://lore.kernel.org/r/20261012064518.3497285-3-azuddinadam@gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030083737.4718=
8-1-azuddinadam@gmail.com?part=3D2
