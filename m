Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6DAC9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F0010E687;
	Sun, 27 Sep 2026 18:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eh31OqiU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4062010E687
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:38:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1148540EFA;
 Sun, 27 Sep 2026 18:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F3F1F000FF;
 Sun, 27 Sep 2026 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790534292;
 bh=igjpl5JS+Rp3B4PWdISYE/VXWyn9z7LI++PImaY1xyQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eh31OqiUx/7K4hQBGHz3QYR7ufXYuu16PzOtsWSCViyVOEju3AhMieqcQbZuHeWCC
 +st8sBj9xBlf2SNW5seLi59RYokRxH+pgUnuLH3SiQS8PLx+phhTshIWCDkB3i0ArT
 Xk0Gvjx1PR4+XiBfjNNpY5VCSPsMVPtpoRjNZI4IlXDGUrSlptKNnpNdIBJ0qC/dzV
 kH/TDnhVxnFRrGws5xtnQJP1v4UDQLRIyMjxY2fMe6XRhcfW2lbE4IhoFezqoUEjcW
 aKO+rJube86FSZN90IhqxlRrt2zvmSzLt+Zwa+5dZxYavzhAZVd/NHKuLwjnkbMf2r
 M4O+0E6q6lHfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/14] drm/solomon: ssd16xx: Add
 clear_on_init/close/disable session management
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260927182329.4193961-6-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
 <20260927182329.4193961-6-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:38:12 +0000
Message-Id: <20260927183812.A2F3F1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] drm: sleeping in atomic context during CRTC enable/disable
- [High] drm/solomon: unsynchronized clear in master_drop races with atomic=
 commits
- [High] drm/solomon: clear_display hardcodes RAM address counters to 0x00
- [Medium] drm/solomon: clear_display writes 0xFF to RED RAM causing red sc=
reen
- [Medium] drm/solomon: display_cleared_on_deinit flag is not reset on enab=
le
- [Medium] drm/solomon: clear_on_init bypasses active CRTCs during master h=
andover
--

commit 90ac1ffc13e17b560cc95b731a7e77c4602e7b77
Author: Devarsh Thakkar <devarsht@ti.com>

drm/solomon: ssd16xx: Add clear_on_init/close/disable session management

E-paper displays are bistable: the last rendered image persists indefinitely
across sessions and power cycles. This creates a session management choice
with no LCD/OLED equivalent since unlike volatile displays, content
visibility outlives the rendering process. Add session-lifetime display
clearing with three configurable hooks: clear_on_init, clear_on_close, and
clear_on_disable.

> diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/=
ssd16xx.c
> index d3af055c67398..c478309d08e9f 100644
> --- a/drivers/gpu/drm/solomon/ssd16xx.c
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c
[ ... ]
> @@ -746,6 +766,111 @@ static int ssd16xx_hw_init(struct ssd16xx_device *d=
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
> +	unsigned int data_size =3D (device->width * device->height) / 8;
> +	u8 *white_buffer =3D device->tx_buf;
> +
> +	memset(white_buffer, 0xFF, data_size);

[Severity: High]
Can this unsynchronized memset cause a data race?=20

When a DRM master drops, ssd16xx_drm_master_drop calls
ssd16xx_clear_display_on_exit. If an atomic commit is concurrently executing
in a background worker, both paths will mutate device->tx_buf without locks,
which could interleave SPI commands and corrupt the controller state.

> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER, &err);
> +	ssd16xx_send_x_param(device, 0x00, &err);
> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER, &err);
> +	ssd16xx_send_y_param(device, 0x00, &err);

[Severity: High]
Does hardcoding the RAM X and Y address counters to 0x00 break decrement-mo=
de
writes and omit window setup?=20

In portrait orientation (decrement entry modes), starting at 0x00 might
immediately underflow the counter and write out-of-bounds.=20

Also, if the previous operation was a partial update, could the RAM window
remain restricted, causing the clear operation to wrap around and fail to
clear the full screen?

> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_WRITE_RAM_BW, &err);
> +	ssd16xx_send_data_bulk(device, white_buffer, data_size, &err);
> +
> +	ssd16xx_send_cmd(device, SSD1683_CMD_WRITE_RAM_RED, &err);
> +	ssd16xx_send_data_bulk(device, white_buffer, data_size, &err);

[Severity: Medium]
Does this write 0xFF to the RED RAM unconditionally?=20

On 3-color (BWR) panels where a 1 bit represents red ink, this would clear
the screen to solid red instead of white. On 2-color panels, it sends an
unsupported command (0x26), which could corrupt hardware state.

[ ... ]
> @@ -1356,11 +1481,26 @@ static void ssd16xx_crtc_atomic_disable(struct dr=
m_crtc *crtc,
>  					struct drm_atomic_commit *state)
>  {
>  	struct ssd16xx_device *device =3D crtc_to_ssd16xx_device(crtc);
> -	int idx;
> +	int ret, idx;
> =20
>  	if (!drm_dev_enter(&device->drm, &idx))
>  		return;
> =20
> +	if (device->clear_on_disable < 0 || device->display_cleared_on_deinit)
> +		goto out;
> +
> +	drm_dbg(&device->drm, "clear_on_disable: running, mode=3D%d\n",
> +		device->clear_on_disable);
> +	ret =3D ssd16xx_clear_display(device,
> +				    ssd16xx_refresh_mode_to_ctrl2(device,
> +								  device->clear_on_disable));

[Severity: High]
Can this cause a sleep in atomic context?=20

The CRTC atomic_disable callback executes in atomic context where sleeping =
is
forbidden, but it conditionally calls ssd16xx_clear_display, which relies on
SPI transactions and polling with usleep_range in ssd16xx_wait_for_device.

> +	if (ret) {
> +		drm_err(&device->drm, "atomic_disable: clear failed: %d\n", ret);
> +		goto out;
> +	}
> +
> +	device->display_cleared_on_deinit =3D true;

[Severity: Medium]
Is the display_cleared_on_deinit flag missing a reset on enable?=20

DPMS off sets the flag to true, but since atomic_enable does not reset it,
subsequent DPMS toggles during a single session might silently skip the cle=
ar
operation.

> +out:
>  	drm_dev_exit(idx);
>  }
> =20
> @@ -1383,6 +1523,11 @@ static void ssd16xx_crtc_atomic_enable(struct drm_=
crtc *crtc,
>  	}
>  	device->initialized =3D true;
> =20
> +	/* Clear display on first app launch if configured */
> +	ret =3D ssd16xx_clear_display_on_init(device);

[Severity: High]
Can this cause a sleep in atomic context?=20

Similar to atomic_disable, the CRTC atomic_enable callback executes in atom=
ic
context where sleeping is forbidden, but calling ssd16xx_clear_display_on_i=
nit
leads to ssd16xx_clear_display which eventually polls with usleep_range.

[Severity: Medium]
Does this bypass active CRTCs during master handover?=20

The clear_on_init hook is inside atomic_enable, which is only called on
transitions from disabled to enabled. If a new DRM master takes over without
triggering a full modeset (e.g. the CRTC remains active), the clean-slate
clear might not fire.

> +	if (ret)
> +		drm_err(&device->drm, "crtc_atomic_enable: clear on init failed: %d\n"=
, ret);
> +
>  	/*
>  	 * If refresh_mode_init is set, arm init_refresh_pending so
>  	 * plane_atomic_update uses the specified mode for the first frame

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182329.4193=
961-1-devarsht@ti.com?part=3D5
