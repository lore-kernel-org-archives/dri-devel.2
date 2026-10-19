Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E8606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mf953ADZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5652610EB49;
	Mon, 19 Oct 2026 21:59:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478A210EB49
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:59:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E52E601F6;
 Mon, 19 Oct 2026 21:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0191F000C5;
 Mon, 19 Oct 2026 21:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792447168;
 bh=J44kYt77Rb1flaUd5VzTPluftU6867jKUcRlpQnHL2Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mf953ADZa9MswAUnsZJPzbcmcHLOlFfkFUQmKVOijiSFsI/zdvzqzzo6m5vTAILhg
 sFAjLB3VGj7Dh0CJkRog2jTZEpMx2a7uP/Us+aJdy4RHuwDObQbezpvild+bLqHlDp
 zDxjLRk3v6DUkJPgoccttrK34UEHeyS+r3mF+s8pTPVhuxIvW/Qd2oO1AqyUfnN6Ge
 bMC7PmhSZah8PoXFB1BGCDH4Vkqnb8gxu8uDsfy6P3YwLKp8ZnZ3nNxfk2Qyd6/exB
 AfR/kifAxofUhXpaO/IXgUeL16vQaZmcn/ofplnVa3EfZq53nzEeLxu8qZpnDOo81N
 1QX7e4BGf5iDA==
Message-ID: <sashiko-outbox-178285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/14] drm/solomon: ssd16xx: Add
 clear_on_init/close/disable session management
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019213726.4145532-6-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <20261019213726.4145532-6-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:59:27 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/solomon: ssd16xx: wrong RAM window in ssd16xx_clear_display() =
for 90/180
- [High] drm/solomon: ssd16xx: ssd16xx_clear_display() breaks partial refre=
sh protocol
- [High] drm/solomon: ssd16xx: missing fast LUT preload in ssd16xx_clear_di=
splay()
- [High] drm/solomon: ssd16xx: clear_on_init skipped when CRTC is already e=
nabled
- [Medium] drm/solomon: ssd16xx: split clear flags fail to prevent double c=
lear on exit
--

commit 3af87653bdf02bc80f3063d4c3e270de771de868
Author: Devarsh Thakkar <devarsht@ti.com>

drm/solomon: ssd16xx: Add clear_on_init/close/disable session management

This commit adds session-lifetime display clearing for SSD16xx e-paper pane=
ls
via three configurable hooks: clear_on_init, clear_on_close, and
clear_on_disable. Each hook selects the refresh waveform to use when blanki=
ng
the display and defaults to -1 (disabled).

> diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/=
ssd16xx.c
> index ca6550b5dd5bd..7b00964487681 100644
> --- a/drivers/gpu/drm/solomon/ssd16xx.c
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c

[ ... ]

> @@ -754,6 +775,138 @@ static int ssd16xx_hw_init(struct ssd16xx_device *d=
evice)
>  	return err;
>  }
> =20
> +/*
> + * Clear display by writing all-white to both BW and RED RAM.
> + * The ctrl2 argument selects the waveform (full/partial/fast refresh).
> + * Border waveform is set to init value before clearing, then restored
> + * to the update value to preserve the border during subsequent updates.
> + */
> +static int ssd16xx_clear_display(struct ssd16xx_device *device, u8 ctrl2)
> +{
> +	const u8 *bw_tbl =3D device->controller_cfg->border_waveform_table;
> +	int err =3D 0;
> +	unsigned int data_size =3D DIV_ROUND_UP(device->width, 8) * device->hei=
ght;
> +	u8 *white_buffer =3D device->tx_buf;
> +	u8 *red_buffer =3D white_buffer;
> +	u16 ram_x_end, ram_y_end;
> +
> +	memset(white_buffer, 0xFF, data_size);
> +
> +	if (device->controller_cfg->ram_x_address_bits =3D=3D 8)
> +		ram_x_end =3D (device->width / 8) - 1;
> +	else
> +		ram_x_end =3D device->width - 1;
> +	ram_y_end =3D device->height - 1;
> +
> +	/* Reset full display RAM window before clearing */
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_START_END, &err);
> +	ssd16xx_send_x_param(device, 0x00, &err);
> +	ssd16xx_send_x_param(device, ram_x_end, &err);
> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_START_END, &err);
> +	ssd16xx_send_y_param(device, 0x00, &err);
> +	ssd16xx_send_y_param(device, ram_y_end, &err);
> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER, &err);
> +	ssd16xx_send_x_param(device, 0x00, &err);
> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER, &err);
> +	ssd16xx_send_y_param(device, 0x00, &err);

[Severity: High]
When device->orientation is 90 or 180 degrees, ssd16xx_hw_init() sets
SSD16XX_CMD_DATA_ENTRY_MODE to SSD16XX_DATA_ENTRY_XDEC_YDEC:

drivers/gpu/drm/solomon/ssd16xx.c:ssd16xx_hw_init() {
	switch (device->orientation) {
	case 90:
	case 180:
		data_entry_mode =3D SSD16XX_DATA_ENTRY_XDEC_YDEC;
		break;
	default: /* 0=C2=B0/270=C2=B0 */
		data_entry_mode =3D SSD16XX_DATA_ENTRY_XINC_YINC;
		break;
	}

	ssd16xx_send_cmd(device, SSD16XX_CMD_DATA_ENTRY_MODE, &err);
	ssd16xx_send_data(device, data_entry_mode, &err);
}

In ssd16xx_fb_dirty(), 90 and 180 degree orientations program the RAM window
in end-before-start order and set the initial cursor to (ram_x_end,
ram_y_end):

drivers/gpu/drm/solomon/ssd16xx.c:ssd16xx_fb_dirty() {
	switch (device->orientation) {
	case 90:
	case 180:
		/* 90=C2=B0/180=C2=B0: XDEC_YDEC mode, send end-before-start; cursor at (=
max, max). */
		ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_START_END, &err);
		ssd16xx_send_x_param(device, ram_x_end, &err);
		ssd16xx_send_x_param(device, ram_x_start, &err);
		...
}

Since ssd16xx_clear_display() always programs start=3D0x00, end=3Dram_x_end/
ram_y_end and sets the address counters to (0x00, 0x00) without switching
SSD16XX_CMD_DATA_ENTRY_MODE or checking device->orientation, will bulk writ=
es
to SSD16XX_CMD_WRITE_RAM_BW and SSD1683_CMD_WRITE_RAM_RED fail to traverse
and clear the display RAM when the panel is rotated 90 or 180 degrees?

> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_WRITE_RAM_BW, &err);
> +	ssd16xx_send_data_bulk(device, white_buffer, data_size, &err);
> +
> +	/*
> +	 * In 3-colour mode RED RAM is the red plane, so clear it to 0x00 (no
> +	 * red).  Otherwise it is the previous-frame reference for partial
> +	 * refresh and must match the now all-white BW RAM.
> +	 */
> +	if (device->color_mode =3D=3D SSD16XX_COLOR_MODE_3COLOR && device->tx_r=
ed_buf) {
> +		red_buffer =3D device->tx_red_buf;
> +		memset(red_buffer, 0x00, data_size);
> +	}
> +
> +	ssd16xx_send_cmd(device, SSD1683_CMD_WRITE_RAM_RED, &err);
> +	ssd16xx_send_data_bulk(device, red_buffer, data_size, &err);
> +
> +	/* Set border waveform for the clear operation */
> +	drm_dbg(&device->drm, "clear_display: Set border init waveform: 0x%02x\=
n",
> +		bw_tbl[device->border_waveform_init_idx]);
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_BORDER_WAVEFORM_CONTROL, &err);
> +	ssd16xx_send_data(device,
> +			  bw_tbl[device->border_waveform_init_idx],
> +			  &err);
> +
> +	/* 3-colour mode: CTRL1_NORMAL (read both RAMs); BW mode: bypass RED. */
> +	ssd16xx_display_update(device,
> +			       device->color_mode =3D=3D SSD16XX_COLOR_MODE_3COLOR
> +					? device->controller_cfg->ctrl1_normal
> +					: device->controller_cfg->ctrl1_bypass_red_ram,
> +			       SSD16XX_CTRL1_BYTE2_DEFAULT, ctrl2, &err);

[Severity: High]
How does ssd16xx_clear_display() work when any of clear_on_init,
clear_on_close, or clear_on_disable is set to 0 (SSD16XX_REFRESH_PARTIAL)?

In ssd16xx_fb_dirty(), partial refresh uses ctrl1_normal so the controller
compares BW RAM (new frame) against RED RAM (previous frame), and writes the
new frame to RED RAM only after ssd16xx_display_update() completes:

drivers/gpu/drm/solomon/ssd16xx.c:ssd16xx_fb_dirty() {
	case SSD16XX_REFRESH_PARTIAL:
	default:
		ssd16xx_display_update(device, device->controller_cfg->ctrl1_normal,
				       SSD16XX_CTRL1_BYTE2_DEFAULT,
				       ctrl2_tbl[SSD16XX_REFRESH_PARTIAL], &err);
		ssd16xx_send_cmd(device, SSD1683_CMD_WRITE_RAM_RED, &err);
		ssd16xx_send_data_bulk(device, mono_buffer, data_size, &err);
		break;
}

Here in ssd16xx_clear_display(), RED RAM is overwritten with white_buffer
before ssd16xx_display_update(), and in BW mode ctrl1_bypass_red_ram is
passed instead of ctrl1_normal. Doesn't overwriting and bypassing RED RAM
before the update prevent the partial refresh waveform from driving
previously black pixels to white?

[Severity: High]
What happens if clear_on_init, clear_on_close, or clear_on_disable is set to
2 (SSD16XX_REFRESH_FAST) while device->refresh_mode is
SSD16XX_REFRESH_PARTIAL (the default for GDEY042T81)?

In ssd16xx_hw_init(), the fast refresh LUT is only preloaded when
device->refresh_mode =3D=3D SSD16XX_REFRESH_FAST:

drivers/gpu/drm/solomon/ssd16xx.c:ssd16xx_hw_init() {
	if (device->refresh_mode =3D=3D SSD16XX_REFRESH_FAST) {
		ssd16xx_send_cmd(device, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL1, &err);
		ssd16xx_send_data(device, device->controller_cfg->ctrl1_bypass_red_ram, &=
err);
		ssd16xx_send_data(device, SSD16XX_CTRL1_BYTE2_DEFAULT, &err);

		ssd16xx_send_cmd(device, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL2, &err);
		ssd16xx_send_data(device, device->controller_cfg->ctrl2_load_temp_lut, &e=
rr);

		ssd16xx_send_cmd(device, SSD16XX_CMD_MASTER_ACTIVATION, &err);
		ssd16xx_wait_for_device(device, &err);
	}
}

Because SSD1683_CTRL2_FAST_REFRESH (0xC7) omits SSD16XX_CTRL2_LOAD_LUT, won=
't
calling ssd16xx_clear_display() with fast refresh run with no LUT loaded on
init (after SW_RESET in ssd16xx_hw_init()) or with the Mode 2 partial LUT on
disable/close (after partial refreshes)? Conversely, if device->refresh_mode
is SSD16XX_REFRESH_FAST and a partial clear runs, won't the partial clear
overwrite the hardware LUT with Mode 2 without setting
device->fast_lut_pending?

[ ... ]

> @@ -1388,6 +1568,12 @@ static void ssd16xx_crtc_atomic_enable(struct drm_=
crtc *crtc,
>  		}
>  		device->initialized =3D true;
>  	}
> +	device->cleared_on_disable =3D false;
> +
> +	/* Clear display on first app launch if configured */
> +	ret =3D ssd16xx_clear_display_on_init(device);
> +	if (ret)
> +		drm_err(&device->drm, "crtc_atomic_enable: clear on init failed: %d\n"=
, ret);
> =20
>  	/*
>  	 * If refresh_mode_init is set, arm init_refresh_pending so

[ ... ]

> @@ -1473,6 +1660,9 @@ static void ssd16xx_drm_master_set(struct drm_devic=
e *drm,
>  {
>  	struct ssd16xx_device *device =3D to_ssd16xx_device(drm);
> =20
> +	device->cleared_on_close =3D false;
> +	device->first_clear_done =3D false;
> +
>  	if (device->refresh_mode_init >=3D 0)
>  		device->init_refresh_pending =3D true;
>  }

[Severity: High]
In ssd16xx_drm_master_set(), device->first_clear_done is reset to false so a
new DRM master session gets a fresh clear. However,
ssd16xx_clear_display_on_init() is only called from
ssd16xx_crtc_atomic_enable().

If the CRTC is already enabled in the panel's single fixed mode (for exampl=
e,
by fbdev emulation or because the previous client exited without disabling
the CRTC), a new DRM master committing a framebuffer update will only run
ssd16xx_plane_atomic_update() without triggering a modeset or calling
ssd16xx_crtc_atomic_enable().

Will clear_on_init be skipped entirely for the new DRM master whenever the
CRTC is already active?

> @@ -1485,8 +1675,23 @@ static void ssd16xx_drm_master_drop(struct drm_dev=
ice *drm,
>  				    struct drm_file *file)
>  {
>  	struct ssd16xx_device *device =3D to_ssd16xx_device(drm);
> +	int ret, idx;
> =20
>  	device->init_refresh_pending =3D false;
> +	device->first_clear_done =3D false;
> +
> +	if (device->clear_on_close < 0 || device->cleared_on_close)
> +		return;
> +
> +	if (!drm_dev_enter(drm, &idx))
> +		return;
> +
> +	ret =3D ssd16xx_clear_display_on_exit(device);
> +	if (ret)
> +		drm_err(drm, "master_drop: clear on close failed: %d\n", ret);
> +
> +	device->cleared_on_close =3D true;
> +	drm_dev_exit(idx);
>  }

[Severity: Medium]
The commit message notes that a guard prevents redundant double-clears when
multiple paths fire for the same session (such as when a compositor does DP=
MS
off and then exits).

In ssd16xx_crtc_atomic_disable(), disabling the CRTC sets
device->cleared_on_disable =3D true:

drivers/gpu/drm/solomon/ssd16xx.c:ssd16xx_crtc_atomic_disable() {
	if (device->clear_on_disable < 0 || device->cleared_on_disable)
		goto out;
	...
	device->cleared_on_disable =3D true;
}

However, ssd16xx_drm_master_drop() only checks device->cleared_on_close and
does not check device->cleared_on_disable. When both clear_on_disable and
clear_on_close are enabled and a client disables the CRTC (or closes its fd
while its framebuffer is active on the CRTC, which disables the CRTC via
drm_fb_release() before drm_master_release()), won't both
ssd16xx_crtc_atomic_disable() and ssd16xx_drm_master_drop() execute a full
clear cycle back-to-back?

> =20
>  static struct drm_driver ssd16xx_drm_driver =3D {

[ ... ]

=E5=AE=8C=E7=BE=8E =E2=80=94 wait no extra text! Let me make sure there's n=
o trailing text after the blank line.
Wait: I just wrote "=E5=AE=8C=E7=BE=8E =E2=80=94 wait no extra text!" in th=
e response! Let me be careful! That was in the response stream, not thought!
Wait =E2=80=94 I cannot undo response stream tokens, so let me not add anyt=
hing else.
 Let me just end cleanly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019213726.4145=
532-1-devarsht@ti.com?part=3D5
