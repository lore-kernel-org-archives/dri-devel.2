Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178EC606A32C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iozWVIMu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5E810E249;
	Wed,  4 Nov 2026 15:51:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA3E10E249
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 15:51:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BE1C60609;
 Wed,  4 Nov 2026 15:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB6C1F000C1;
 Wed,  4 Nov 2026 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793807505;
 bh=oyvMhBLfXg5Ue0o+0oute8ySKM0GVPS4DedBUWscso0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=iozWVIMufA9Huw/ciNia/UoTmRHz9LpP9+iZW+m0QC+i37Be1scfRzz+i5Lhc7Ytl
 0mPdLipFcbp5wDPXQng1icsZEHg4jkfoVXOIvxq2GR6qniWxof1Kk5Z6xbzWJFmuR6
 suDXklGLNzvb17Bg/w+GjE7Sjvrn6HTZVx+OM7XcjKgl5x+N6eTClwuBgqN547qBmI
 Z6GVNWeveicXC0JY04VvbSt5ggpzD+IT92UvTiZ9fG1ozMjCun/IRFvvI9Ej5Ia8rK
 pHb8xcEAggwWrYr7KoYpySKRdFiQuyq08K8HawBjZi/XE/j10E+1l3cybxXfX+mtGh
 Feqdz/KcFNSDw==
Message-ID: <sashiko-outbox-197546@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/ms91xx: Add register access and connector
 support
To: "Ho Jie Feng" <hjf3108@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261104151652.59135-3-hjf3108@gmail.com>
References: <20261104151652.59135-1-hjf3108@gmail.com>
 <20261104151652.59135-3-hjf3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:51:44 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm/ms91xx: unbounded EDID block offset and u16 wrap in ms91xx_r=
ead_edid()
- [Medium] drm/ms91xx: multiple preferred modes set in ms91xx_connector_get=
_modes()
- [Medium] drm/ms91xx: unplug -ENODEV treated as unknown status in ms91xx_d=
etect()
--

commit 32cd5aee0f634799386d1af3debfec7f0d6318ac
Author: Ho Jie Feng <hjf3108@gmail.com>

drm/ms91xx: Add register access and connector support

This commit adds HID register and flash access helpers, custom timing
record decoding, and DRM connector mode enumeration and detection for
MacroSilicon MS912x and MS913x USB display adapters.

> diff --git a/drivers/gpu/drm/ms91xx/ms91xx_connector.c b/drivers/gpu/drm/=
ms91xx/ms91xx_connector.c
> new file mode 100644
> index 0000000000000..08371d121091f
> --- /dev/null
> +++ b/drivers/gpu/drm/ms91xx/ms91xx_connector.c
> @@ -0,0 +1,267 @@

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
Can ms91xx_read_edid() in drivers/gpu/drm/ms91xx/ms91xx_connector.c read
past the EDID register window and wrap address around u16 when a sink
reports EDID extension blocks?

When ms91xx_connector_get_modes() calls drm_edid_read_custom(),
_drm_do_get_edid() can request up to 255 extension blocks. Because
MS91XX_REG_EDID_BASE is 0xc000 in drivers/gpu/drm/ms91xx/ms91xx.h, higher
block indices read across unrelated registers such as
MS91XX_REG_MODE_SEQUENCE_2 (0xc620), MS912X_REG_CHIP_ID (0xf000),
MS913X_CUSTOM_TIMING_BASE (0xfc50), and MS913X_REG_CHIP_ID (0xff00).

Once block reaches 128 (offset >=3D 0x4000), MS91XX_REG_EDID_BASE + offset =
+ i
overflows u16 and wraps into 0x0000..0x3fff, reading low control and status
registers such as MS91XX_REG_MODE_SEQUENCE_0 (0x0030) through
MS91XX_REG_MODE_SEQUENCE_1 (0x0033). Should ms91xx_read_edid() bound-check
block and offset + len against the hardware EDID buffer size before reading?

> +
> +static int ms91xx_add_cea_modes(struct drm_connector *connector,
> +				const u8 *vics, size_t num_vics)
> +{
> +	struct drm_display_mode *mode;
> +	unsigned int i;
> +	int count =3D 0;
> +
> +	drm_edid_connector_update(connector, NULL);
> +
> +	for (i =3D 0; i < num_vics; i++) {
> +		mode =3D drm_display_mode_from_cea_vic(connector->dev, vics[i]);
> +		if (!mode)
> +			continue;
> +
> +		if (!count)
> +			mode->type |=3D DRM_MODE_TYPE_PREFERRED;
> +		drm_mode_probed_add(connector, mode);
> +		count++;
> +	}
> +
> +	return count;
> +}

[ ... ]

> +static int
> +ms91xx_add_default_hdmi_vga_modes(struct drm_connector *connector)
> +{
> +	struct drm_mode_config *mode_config =3D &connector->dev->mode_config;
> +	int count;
> +
> +	drm_edid_connector_update(connector, NULL);
> +	count =3D drm_add_modes_noedid(connector, mode_config->max_width,
> +				     mode_config->max_height);
> +	if (count)
> +		drm_set_preferred_mode(connector, 1024, 768);
> +
> +	return count;
> +}
> +
> +static int ms91xx_add_custom_mode(struct drm_connector *connector)
> +{
> +	struct ms91xx_device *ms91xx =3D to_ms91xx(connector->dev);
> +	struct drm_display_mode *mode;
> +	unsigned int i;
> +	int count =3D 0;
> +
> +	for (i =3D 0; i < ms91xx->num_custom_modes; i++) {
> +		mode =3D drm_mode_duplicate(
> +			connector->dev,
> +			&ms91xx->custom_modes[i].display_mode);
> +		if (!mode)
> +			continue;
> +
> +		drm_mode_probed_add(connector, mode);
> +		count++;
> +	}
> +
> +	return count;
> +}
> +
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

[Severity: Medium]
When custom timings are present in flash, does ms91xx_connector_get_modes()
in drivers/gpu/drm/ms91xx/ms91xx_connector.c end up marking multiple modes
on the connector with DRM_MODE_TYPE_PREFERRED?

In drivers/gpu/drm/ms91xx/ms91xx_registers.c, ms91xx_read_custom_timing()
marks the first custom mode as preferred:

    if (ms91xx->num_custom_modes)
            ms91xx->custom_modes[0].display_mode.type |=3D DRM_MODE_TYPE_PR=
EFERRED;

During connector probing, ms91xx_connector_get_modes() calls
ms91xx_add_custom_mode(), which duplicates custom_modes[0].display_mode onto
connector->probed_modes with DRM_MODE_TYPE_PREFERRED set. It then proceeds =
to
call ms91xx_add_cvbs_svideo_modes(), ms91xx_add_ypbpr_modes(),
ms91xx_add_default_hdmi_vga_modes(), or drm_edid_connector_add_modes(), each
of which also sets DRM_MODE_TYPE_PREFERRED on another mode.

When drm_helper_probe_single_connector_modes() calls drm_mode_sort(), ties
between modes with DRM_MODE_TYPE_PREFERRED are broken by hdisplay * vdispla=
y,
causing any fallback, CEA, or EDID preferred mode with a larger resolution
to sort ahead of custom_modes[0]. Should only one mode be marked preferred?

> +
> +static enum drm_connector_status ms91xx_detect(struct drm_connector *con=
nector,
> +					       bool force)
> +{
> +	struct ms91xx_device *ms91xx =3D to_ms91xx(connector->dev);
> +	int status =3D ms91xx_read_byte(ms91xx, MS91XX_REG_DISPLAY_STATUS);
> +
> +	if (status < 0)
> +		return connector_status_unknown;
> +
> +	return status =3D=3D 1 ? connector_status_connected :
> +			     connector_status_disconnected;
> +}

[Severity: Medium]
When the USB device is unplugged, ms91xx_read_byte() in
drivers/gpu/drm/ms91xx/ms91xx_registers.c returns -ENODEV (either when
drm_dev_enter() fails or when usb_control_msg_send() fails on disconnect).

In drivers/gpu/drm/ms91xx/ms91xx_connector.c, ms91xx_detect() maps all
status < 0 values to connector_status_unknown instead of
connector_status_disconnected. In drm_helper_probe_single_connector_modes(),
connector_status_unknown continues to call ms91xx_connector_get_modes(),
which then fails drm_edid_read_custom() and populates fallback modes via
ms91xx_add_default_hdmi_vga_modes() (or CEA/custom modes) on the unplugged
device rather than pruning modes.

Should ms91xx_detect() return connector_status_disconnected when status is
-ENODEV (or when !drm_dev_enter())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104151652.5913=
5-1-hjf3108@gmail.com?part=3D2
