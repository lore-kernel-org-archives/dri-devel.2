Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03230C88E7F
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A1C710E2BD;
	Wed, 16 Sep 2026 18:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n45l1esz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0499210E2BD
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 18:14:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36E71600CB;
 Wed, 16 Sep 2026 18:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECF61F000FF;
 Wed, 16 Sep 2026 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789582495;
 bh=VSSrXxG3KStg6s0TokvhYJlBpfk93XdEvob9qc4mrkU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n45l1eszSfzMxtCFccbi/rGmBzL+M05v91s5Z28r/+Qb/umVcRmwJ+c8yRcGbfsRI
 dPVZKPWbGZDb0gz0q/8w5PjgZKhhqp8zxMkQ/uXA/Lne5axHxDe5uYnoT8Qhz7r3H0
 PMDNbS1NvrEL3acEZOMdVjrebFz/2gJUd+CICEGNzRiqdi4wO6nR0iREPRtnR+jKgh
 iaAtHMbJNW3t2FBttKBS3Pl2vIGd7SME1RPiSRDagqPuSFCCYqFzQJxz+GajvYRgAY
 ifAOKhcIvAb0EA4B5uScW8/F3dRqDU8BcaEvdBxFlRUJgcHVLoBPy9CSoA1WudJ4nb
 prx7rIpJx8nrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/tiny: Add RAiO RA8875 display controller driver
To: "Adam Azuddin" <azuddinadam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260916180410.3188922-1-azuddinadam@gmail.com>
References: <20260916175942.3186804-1-azuddinadam@gmail.com>
 <20260916180410.3188922-1-azuddinadam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:14:55 +0000
Message-Id: <20260916181455.9ECF61F000FF@smtp.kernel.org>
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
- [High] drm/tiny: ra8875: sleep in atomic context in display update/enable=
 paths
- [High] drm/tiny: ra8875: unaligned memory access in ra8875_pipe_update()
- [High] drm/tiny: ra8875: heap buffer overflow in txbuf due to unvalidated=
 device tree videomode
- [High] drm/tiny: ra8875: DMA on stack memory via local SPI transfer buffe=
rs
- [High] drm/tiny: ra8875: Use-After-Free of txbuf due to missing drm_dev_u=
nplug()
- [Medium] drm/tiny: ra8875: failure to chunk large SPI transfers in displa=
y update
- [Medium] drm/tiny: ra8875: silent mode validation failure inside .enable =
callback
--

commit d7d5e9662b2beb4a2ef49392bd30bcd603e994b4
Author: Adam Azuddin <azuddinadam@gmail.com>

drm/tiny: Add RAiO RA8875 display controller driver

Add a DRM tiny driver for the RAiO RA8875 SPI-connected TFT display
controller. The driver supports display resolutions up to 800x480
and uses the GEM shmem helper for buffer management.

> diff --git a/drivers/gpu/drm/tiny/ra8875.c b/drivers/gpu/drm/tiny/ra8875.c
> new file mode 100644
> index 0000000000000..3ed4617ee761d
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/ra8875.c
[ ... ]
> +static int ra8875_write_reg(struct ra8875_device *ra8875, u8 reg, u8 val)
> +{
> +	int ret;
> +	u8 cmd[2] =3D { 0x80, reg };
> +	u8 data[2] =3D { 0x00, val };
> +
> +	struct spi_transfer t_cmd =3D {
> +		.tx_buf =3D cmd,
> +		.len =3D 2,
> +		.speed_hz =3D 1000000,
> +		.cs_change =3D 1, /* pull CS high after this transfer */
> +	};

[Severity: High]
Is it safe to use stack-allocated buffers for SPI transfers here?=20

The SPI subsystem often maps these buffers for DMA, and passing stack memor=
y=20
is forbidden in the kernel (especially with CONFIG_VMAP_STACK) because the=
=20
memory might not be physically contiguous or cache-coherent. This pattern=20
appears to repeat with the rx/tx buffers in ra8875_read_reg() and=20
ra8875_pipe_update().

[ ... ]
> +static int ra8875_hw_init(struct ra8875_device *ra8875,
> +			  struct drm_display_mode *mode)
> +{
> +	u8 hdwr, hndr, hstr, hpwr, vpwr;
> +	u16 vdhr, vndr, vstr;
> +	u8 readback;
> +	int ret;
> +
> +	/* Soft Reset Sequence */
> +	ret =3D ra8875_write_reg(ra8875, RA8875_PWRR, RA8875_PWRR_SOFTRST);
> +	if (ret) {
> +		dev_err(ra8875->drm.dev, "Soft Reset failed\n");
> +		return ret;
> +	}
> +	usleep_range(1000, 2000);

[Severity: High]
Can this sleep in atomic context?=20

This initialization function is called from ra8875_pipe_enable(), which is=
=20
invoked by the DRM core during an atomic commit. The display subsystem=20
guidelines state that CRTC enable callbacks run in atomic context where=20
sleeping functions like usleep_range() are forbidden and can cause system=20
hangs or deadlocks.

[ ... ]
> +static void ra8875_pipe_enable(struct drm_simple_display_pipe *pipe,
> +			       struct drm_crtc_state *crtc_state,
> +			       struct drm_plane_state *plane_state)
> +{
> +	struct ra8875_device *ra8875 =3D
> +		container_of(pipe->crtc.dev, struct ra8875_device, drm);
> +	struct drm_display_mode *mode =3D &crtc_state->mode;
> +	int ret;
> +
> +	if (mode->hdisplay % 8 !=3D 0 || mode->hsync_start % 8 !=3D 0 ||
> +	    mode->hsync_end % 8 !=3D 0 || mode->htotal % 8 !=3D 0) {
> +		drm_err(&ra8875->drm,
> +			"mode timings must be 8-pixel aligned (hdisplay=3D%d hsync_start=3D%d=
 hsync_end=3D%d htotal=3D%d)\n",
> +			mode->hdisplay, mode->hsync_start, mode->hsync_end,
> +			mode->htotal);
> +		return;
> +	}

[Severity: Medium]
Does checking the mode validity here leave the pipeline in an inconsistent=
=20
state if it fails?=20

Since this returns void from the .enable callback, the DRM core cannot catc=
h=20
the error and will assume the CRTC is successfully enabled. Should this=20
validation be moved to the .atomic_check callback instead, so invalid modes=
=20
are gracefully rejected before the commit?

[ ... ]
> +static void ra8875_pipe_update(struct drm_simple_display_pipe *pipe,
> +			       struct drm_plane_state *old_plane_state)
> +{
[ ... ]
> +		if (ra8875_write_reg(ra8875, RA8875_CURV1,
> +				     (damage.y1 >> 8) & 0x01))
> +			goto exit;
> +
> +		/* MRWC command and pixel data are sent as separate SPI messages;*/
> +		if (spi_write(ra8875->spi, cmd, 2))
> +			goto exit;

[Severity: High]
Does this spi_write() sleep in atomic context?=20

Similar to the hardware initialization path, the plane update callback exec=
utes
in atomic context where sleeping is forbidden. Using synchronous SPI calls=
=20
here could lead to kernel warnings.

> +
> +		offset =3D
> +			drm_fb_clip_offset(fb->pitches[0], fb->format, &damage);
> +
> +		txbuf[0] =3D RA8875_DATAWRITE;
> +		for (r =3D 0; r < height; r++) {
> +			src_row =3D (u16 *)(map->vaddr + offset +
> +					  r * fb->pitches[0]);
> +			dst_row =3D (u16 *)(txbuf + 1 + r * width * 2);
> +			for (p =3D 0; p < width; p++)
> +				dst_row[p] =3D swab16(src_row[p]);
> +		}

[Severity: High]
Will this cause an alignment fault on strict-alignment architectures?=20

The expression (txbuf + 1 + r * width * 2) adds an odd offset (1) to the ev=
en=20
base address, yielding an odd byte address. Casting this to a u16 pointer a=
nd=20
performing a 16-bit store via dst_row[p] =3D swab16(...) violates C alignme=
nt=20
rules and will likely crash platforms without hardware unaligned access sup=
port.

> +
> +		memset(&t_data, 0, sizeof(t_data));
> +		t_data.tx_buf =3D txbuf;
> +		t_data.len =3D 1 + height * width * 2;
> +		t_data.speed_hz =3D ra8875->spi->max_speed_hz;
> +
> +		spi_message_init(&m);
> +		spi_message_add_tail(&t_data, &m);
> +		if (spi_sync(ra8875->spi, &m))
> +			goto exit;
> +	}

[Severity: Medium]
Can this single transfer exceed the SPI controller's maximum transfer size?=
=20

This sends the entire damage region in one SPI message, which could be quit=
e=20
large. Many SPI controllers enforce much smaller limits (like 4096 or 65535=
=20
bytes) and spi_sync() could fail with -EINVAL. Should this be chunked=20
similarly to the logic in ra8875_clear_screen()?

[ ... ]
> +static int ra8875_probe(struct spi_device *spi)
> +{
[ ... ]
> +	bufSize =3D 1 + RA8875_MAX_HEIGHT * RA8875_MAX_WIDTH * 2;
> +	ra8875->txbuf =3D devm_kzalloc(&spi->dev, bufSize, GFP_KERNEL);
> +	if (!ra8875->txbuf)
> +		return -ENOMEM;
> +
> +	ret =3D of_get_videomode(dev->of_node, &vm, OF_USE_NATIVE_MODE);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get videomode\n");
> +	drm_display_mode_from_videomode(&vm, &ra8875->mode);
> +
> +	ra8875->mode.type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +
> +	drm_mode_set_name(&ra8875->mode);
> +	ret =3D drmm_mode_config_init(drm);
> +	if (ret)
> +		return ret;
> +
> +	drm->mode_config.min_width =3D ra8875->mode.hdisplay;
> +	drm->mode_config.max_width =3D ra8875->mode.hdisplay;
> +	drm->mode_config.min_height =3D ra8875->mode.vdisplay;
> +	drm->mode_config.max_height =3D ra8875->mode.vdisplay;

[Severity: High]
Could this result in an out-of-bounds write to txbuf if the device tree=20
specifies a large resolution?=20

The txbuf array is allocated with a fixed size based on RA8875_MAX_WIDTH an=
d=20
RA8875_MAX_HEIGHT. However, the display dimensions read from the device tre=
e=20
are not validated against these maximums. If a larger resolution is provide=
d,=20
the DRM core will accept larger damage clips, and ra8875_pipe_update() will=
=20
overflow the txbuf allocation when writing the pixels.

[ ... ]
> +static void ra8875_remove(struct spi_device *spi)
> +{
> +	struct drm_device *drm =3D spi_get_drvdata(spi);
> +	struct ra8875_device *ra8875 =3D
> +		container_of(drm, struct ra8875_device, drm);
> +
> +	drm_dev_unregister(drm);
> +	ra8875_display_off(ra8875);
> +}

[Severity: High]
Does this leave the device vulnerable to a use-after-free on unbind?=20

Calling drm_dev_unregister() leaves dev->unplugged set to false. If the=20
device is unbound via sysfs while userspace has the DRM file open, a=20
subsequent display update ioctl will pass the drm_dev_enter() check in=20
ra8875_pipe_update() and attempt to use txbuf after devres has already=20
freed it. Should this use drm_dev_unplug() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916175942.3186=
804-1-azuddinadam@gmail.com?part=3D2
