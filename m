Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C2606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMSxwWWu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7CAC10F0CF;
	Mon, 19 Oct 2026 16:19:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E87010F0E1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:19:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC8E94040D;
 Mon, 19 Oct 2026 16:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE931F000C4;
 Mon, 19 Oct 2026 16:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792426740;
 bh=oVPQfMGxJFInTOMiR/kFD5FwY/E/bZPWNTxgp3Zr6xs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=TMSxwWWufWErxCQw/Q7VmTMXjr0/8Lvs1Q8HeRGB07W54gV0i7jV1YhCfnuXO4yGp
 ZtZpcrqoBdTCB05Ah07Vzmcn6Qojlo/jmEA3BbXWPnziV+J6Vzo0d3m5zpx/l1+ufY
 v4gGOoME7WGJ7MswEIcP+Bc4toMYJxdnt4TtlQZn8aVrP7I2HzBb4bhMYEf0J2W38z
 mgkI11a1Sm0S+EPgko8m5UZJ4/SblxwSJoSUe3QyNZAD9MS6BpDZeZyvFg7NEmCh6h
 /ItidqTjBI+tYFCqEEudvssQ1GFSbHv7kG5Qj0uVB9BXZvyi4jKotguH9KQkGfBP+o
 h7RdW0NiuD8Rg==
Message-ID: <sashiko-outbox-177861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] drm/ms91xx: Add register access and connector
 support
To: "Ho Jie Feng" <hjf3108@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261019154820.68659-3-hjf3108@gmail.com>
References: <20261019154820.68659-1-hjf3108@gmail.com>
 <20261019154820.68659-3-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:19:00 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] drm/ms91xx: mismatched interlace handling in ms91xx_decode_custo=
m_timing()
- [Medium] drm/ms91xx: unchecked block index and u16 overflow in ms91xx_rea=
d_edid()
- [Medium] drm/ms91xx: odd hactive in ms91xx_decode_custom_timing() leaks u=
ninit memory
- [Low] drm/ms91xx: multiple modes marked DRM_MODE_TYPE_PREFERRED on connec=
tor
--

commit 557c9cb985634091a4b0753b2e8063cde49e88a5
Author: Ho Jie Feng <hjf3108@gmail.com>

drm/ms91xx: Add register access and connector support

This commit adds USB control message helpers for reading registers and flash
memory, display power and mode programming sequences, custom flash timing
decoding, and DRM connector and EDID probing for the ms91xx driver.

> diff --git a/drivers/gpu/drm/ms91xx/ms91xx_connector.c b/drivers/gpu/drm/=
ms91xx/ms91xx_connector.c
> new file mode 100644
> index 0000000000000..d04f818fa09f2
> --- /dev/null
> +++ b/drivers/gpu/drm/ms91xx/ms91xx_connector.c
> @@ -0,0 +1,263 @@

[ ... ]

> +static int ms91xx_read_edid(void *data, u8 *buf, unsigned int block, siz=
e_t len)
> +{
> +	struct ms91xx_device *ms91xx =3D data;
> +	int offset =3D block * EDID_LENGTH;
> +	unsigned int i;
> +	int ret;
> +
> +	for (i =3D 0; i < len; i++) {
> +		u16 address =3D MS91XX_REG_EDID_BASE + offset + i;
> +
> +		ret =3D ms91xx_read_byte(ms91xx, address);
> +		if (ret < 0)
> +			return ret;
> +		buf[i] =3D ret;
> +	}
> +	return 0;
> +}

[Severity: Medium]
Should ms91xx_read_edid() check the bounds of block before computing the
register address?

In ms91xx_connector_get_modes(), drm_edid_read_custom() calls
_drm_do_get_edid(), which reads block 0 and then requests extension blocks =
up
to the count advertised by the sink (up to 255 extensions).

Because ms91xx_read_edid() does not limit block, any block >=3D 2 advances
address past the EDID region at MS91XX_REG_EDID_BASE (0xc000) into device
registers in 0xc100..0xffff, such as MS91XX_REG_MODE_SEQUENCE_2 (0xc620),
MS912X_REG_CHIP_ID (0xf000), and MS913X_REG_CHIP_ID (0xff00).

When block >=3D 128 (offset >=3D 0x4000), MS91XX_REG_EDID_BASE + offset + i
overflows the 16-bit address variable and wraps around to 0x0000..0x3fff,
reading low registers including MS91XX_REG_MODE_SEQUENCE_0 (0x0030) and
MS91XX_REG_MODE_SEQUENCE_1 (0x0033).

In addition, edid_block_read() retries each invalid block 4 times when
ms91xx_read_edid() returns 0, and each ms91xx_read_byte() performs two
synchronous USB control transfers, so an EDID advertising 255 extensions can
trigger up to 261,120 USB control transfers while holding mode_config.mutex.

[ ... ]

> +static int ms91xx_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct ms91xx_device *ms91xx =3D to_ms91xx(connector->dev);
> +	const struct drm_edid *edid;
> +	int ret =3D ms91xx_add_custom_mode(connector);
> +
> +	if (ms91xx->port_type =3D=3D MS91XX_VIDEO_PORT_CVBS ||
> +	    ms91xx->port_type =3D=3D MS91XX_VIDEO_PORT_CVBS_SVIDEO ||
> +	    ms91xx->port_type =3D=3D MS91XX_VIDEO_PORT_UNKNOWN)
> +		return ret + ms91xx_add_cvbs_svideo_modes(connector);
> +
> +	if (ms91xx->port_type =3D=3D MS91XX_VIDEO_PORT_YPBPR)
> +		return ret + ms91xx_add_ypbpr_modes(connector);
> +
> +	edid =3D drm_edid_read_custom(connector, ms91xx_read_edid, ms91xx);
> +	if (!edid)
> +		return ret + ms91xx_add_default_hdmi_vga_modes(connector);
> +
> +	if (drm_edid_connector_update(connector, edid) >=3D 0)
> +		ret +=3D drm_edid_connector_add_modes(connector);
> +	drm_edid_free(edid);
> +	return ret;
> +}

[Severity: Low]
Can ms91xx_connector_get_modes() end up marking multiple modes on the same
connector with DRM_MODE_TYPE_PREFERRED?

In ms91xx_decode_custom_timing(), every decoded custom mode (up to two modes
when the "modify2" flash marker is present) is unconditionally assigned:

	display_mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;

When ms91xx_connector_get_modes() runs, ms91xx_add_custom_mode() adds all
decoded custom modes with DRM_MODE_TYPE_PREFERRED set, and then
ms91xx_connector_get_modes() unconditionally calls
ms91xx_add_cvbs_svideo_modes(), ms91xx_add_ypbpr_modes(),
ms91xx_add_default_hdmi_vga_modes(), or drm_edid_connector_add_modes(), each
of which also sets DRM_MODE_TYPE_PREFERRED on another mode.

Per struct drm_display_mode in include/drm/drm_modes.h, there should only be
one preferred mode per connector at any given time, and having multiple
preferred modes causes drm_mode_sort() to tie-break among them by resolution
(hdisplay * vdisplay).

[ ... ]

> diff --git a/drivers/gpu/drm/ms91xx/ms91xx_registers.c b/drivers/gpu/drm/=
ms91xx/ms91xx_registers.c
> new file mode 100644
> index 0000000000000..84cbdc78002b1
> --- /dev/null
> +++ b/drivers/gpu/drm/ms91xx/ms91xx_registers.c
> @@ -0,0 +1,386 @@

[ ... ]

> +static int
> +ms91xx_decode_custom_timing(struct ms91xx_custom_mode *custom_mode,
> +			    const struct ms91xx_custom_timing_record *record)
> +{
> +	struct drm_display_mode *display_mode =3D &custom_mode->display_mode;
> +	u16 hsyncwidth =3D le16_to_cpu(record->hsyncwidth);
> +	u16 vsyncwidth =3D le16_to_cpu(record->vsyncwidth);
> +	u16 hoffset =3D le16_to_cpu(record->hoffset);
> +	u16 voffset =3D le16_to_cpu(record->voffset);
> +	u16 hactive =3D le16_to_cpu(record->hactive);
> +	u16 vactive =3D le16_to_cpu(record->vactive);
> +	u16 htotal =3D le16_to_cpu(record->htotal);
> +	u16 vtotal =3D le16_to_cpu(record->vtotal);
> +	u16 pixclk =3D le16_to_cpu(record->pixclk);
> +	u16 vfreq =3D le16_to_cpu(record->vfreq);
> +	unsigned int hblank, vblank;
> +	int refresh;
> +
> +	if (!hactive || hactive > MS91XX_MAX_WIDTH ||
> +	    !vactive || vactive > MS91XX_MAX_HEIGHT ||
> +	    htotal <=3D hactive || vtotal <=3D vactive || !pixclk || !vfreq)
> +		return -EINVAL;

[Severity: Medium]
Should ms91xx_decode_custom_timing() reject odd hactive values (hactive % 2=
 !=3D 0)?

In ms91xx_set_resolution(), the hardware is configured exclusively for pack=
ed
4:2:2 UYVY (MS91XX_PIXFMT_UYVY), which encodes horizontal pixels in pairs.

If a custom timing record in flash has an odd hactive and is selected with
fb->width =3D=3D hactive, ms91xx_fb_send_rect() (added in the following pat=
ch)
computes:

	x =3D ALIGN_DOWN(rect->x1, 2);
	width =3D min_t(int, ALIGN(rect->x2, 2), fb->width) - x;

When rect->x2 =3D=3D fb->width, min_t() clamps to the odd fb->width, produc=
ing an
odd width. ms91xx_fb_xrgb8888_to_yuv422() then calls
drm_fb_xrgb8888_to_uyvy(), which advances the destination buffer by width *=
 2
bytes per line while drm_fb_xrgb8888_to_uyvy_line() only writes
round_down(width, 2) * 2 bytes per line, leaving 2 trailing bytes of
uninitialized vmalloc_32() memory per scanline in transfer_buffer to be sent
over USB.

> +
> +	hblank =3D htotal - hactive;
> +	vblank =3D vtotal - vactive;
> +	if (!hsyncwidth || hsyncwidth > hoffset || hoffset > hblank ||
> +	    !vsyncwidth || vsyncwidth > voffset || voffset > vblank)
> +		return -EINVAL;
> +
> +	memset(display_mode, 0, sizeof(*display_mode));
> +	display_mode->clock =3D pixclk * 10;
> +	display_mode->hdisplay =3D hactive;
> +	display_mode->hsync_start =3D htotal - hoffset;
> +	display_mode->hsync_end =3D display_mode->hsync_start + hsyncwidth;
> +	display_mode->htotal =3D htotal;
> +	display_mode->vdisplay =3D vactive;
> +	display_mode->vsync_start =3D vtotal - voffset;
> +	display_mode->vsync_end =3D display_mode->vsync_start + vsyncwidth;
> +	display_mode->vtotal =3D vtotal;
> +	display_mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	display_mode->flags =3D
> +		record->polarity & MS91XX_TIMING_POSITIVE_HSYNC ?
> +			DRM_MODE_FLAG_PHSYNC : DRM_MODE_FLAG_NHSYNC;
> +	display_mode->flags |=3D
> +		record->polarity & MS91XX_TIMING_POSITIVE_VSYNC ?
> +			DRM_MODE_FLAG_PVSYNC : DRM_MODE_FLAG_NVSYNC;
> +	if (!(record->polarity & MS91XX_TIMING_PROGRESSIVE))
> +		display_mode->flags |=3D DRM_MODE_FLAG_INTERLACE;

[Severity: Medium]
How are interlaced custom timings intended to be handled between
ms91xx_decode_custom_timing() and ms91xx_connector_init()?

When !(record->polarity & MS91XX_TIMING_PROGRESSIVE),
ms91xx_decode_custom_timing() sets DRM_MODE_FLAG_INTERLACE on display_mode =
and
stores the entry in ms91xx->custom_modes[].

However, ms91xx_connector_init() does not set
ms91xx->connector.interlace_allowed =3D true. When
drm_helper_probe_single_connector_modes() validates the modes added by
ms91xx_add_custom_mode(), drm_mode_validate_flag() marks any
DRM_MODE_FLAG_INTERLACE mode as MODE_NO_INTERLACE and drm_mode_prune_invali=
d()
deletes it from the connector mode list.

Meanwhile, the decoded entry remains in ms91xx->custom_modes[] and struct
ms91xx_mode only records width, height, hz, and mode without tracking
interlacing:

	custom_mode->mode.width =3D hactive;
	custom_mode->mode.height =3D vactive;
	custom_mode->mode.hz =3D refresh;
	custom_mode->mode.mode =3D record->vic;

As a result, when a progressive mode with the same width, height, and refre=
sh
rate is later validated or enabled in ms91xx_get_mode(), it will match the
pruned interlaced entry in ms91xx->custom_modes[].

> +
> +	refresh =3D DIV_ROUND_CLOSEST(vfreq, 100);
> +	if (!refresh || drm_mode_vrefresh(display_mode) !=3D refresh)
> +		return -EINVAL;
> +
> +	drm_mode_set_name(display_mode);
> +	custom_mode->mode.width =3D hactive;
> +	custom_mode->mode.height =3D vactive;
> +	custom_mode->mode.hz =3D refresh;
> +	custom_mode->mode.mode =3D record->vic;
> +
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019154820.6865=
9-1-hjf3108@gmail.com?part=3D2
