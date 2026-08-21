Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CB5C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC9B10E303;
	Fri, 21 Aug 2026 14:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TPlJAt9A";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A7E10E303
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:52:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59C2941E77;
 Fri, 21 Aug 2026 14:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17051F000E9;
 Fri, 21 Aug 2026 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323951;
 bh=/MjDohHyujtDq42Hz5EJEtrF2cungh+3TApdWY4aqmQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TPlJAt9A9oSLiPOdarFiXH17/lv7WxvSQr3P9bhuf1a53JJ31Ko9Q+EbtywYbZ+Yd
 okNL4LLrJYa18E2T86ggNdm3aFx1kRWUTfMrwEyJBRpPubG+bBxfnDDRhs7kDIxzN4
 Q2mRY/zD9O1p6/WkIUD7WEDGlzLMYvYZOFhNyHzDIU63Exz/p4qqnJrAphMngwTLu9
 RBRc68VHlh8yzOGLSqAWA1FS6Psy9+nK9ja90/sGQOQrTGbb6Spbc7NqCRy+MboBku
 C2DfhX3DL7V5v8m95mjJBEhK1l0rbnU/5j4JHJJZDKRphGHcWulajrmLtvV4TIsdno
 q+YMdBF+4D8Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/ch1115: add support for Chipwealth CH1115
 OLED controller
To: =?utf-8?b?Tmljb2zDoXMgQW50aW5vcmk=?= <nico.antinori.7@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <362d7027fc2b558e4b35a154e7d12489bd88dbeb.1787321297.git.nico.antinori.7@gmail.com>
References: <cover.1787321297.git.nico.antinori.7@gmail.com>
 <362d7027fc2b558e4b35a154e7d12489bd88dbeb.1787321297.git.nico.antinori.7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:52:30 +0000
Message-Id: <20260821145230.B17051F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] The driver performs I2C transfers, which are sleeping functions, i=
nside DRM atomic context callbacks.
- [High] The `hwbuf` allocation size calculation fails to account for row p=
itch alignment, leading to heap buffer overflows.
- [High] Missing format conversion state reservation in `atomic_check` caus=
es a `GFP_KERNEL` allocation in the atomic update path.
- [High] Missing zero validation for display dimensions can lead to ZERO_SI=
ZE_PTR dereference.
- [High] Missing `drm_dev_unplug()` causes `drm_dev_enter()` to fail to pro=
tect against Use-After-Free of devm-managed resources.
- [High] Missing `drm_dev_enter()`/`drm_dev_exit()` protection in encoder c=
allbacks.
- [High] Improper handling of plane source coordinates causes Out-Of-Bounds=
 memory accesses.
- [Medium] Hardware shutdown commands are sent before unregistering the DRM=
 device, exposing the powered-off device to userspace commits.
- [Medium] Damage clip X coordinates are not rounded to byte boundaries, ca=
using the monochrome conversion helper to corrupt the destination buffer.
- [Medium] `CH1115_CMD_OFFSET` is programmed with a value of 64, which exce=
eds the valid hardware limit.
--

--- Patch [2]: [PATCH v2 2/3] drm/ch1115: add support for Chipwealth CH1115=
 OLED controller ---
commit b8a12cbafccb463172c071e5d13f894de430373b
Author: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>

drm/ch1115: add support for Chipwealth CH1115 OLED controller

Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.
Add DRM support for this chip using i2c bus.

> diff --git a/drivers/gpu/drm/chipwealth/ch1115-i2c.c b/drivers/gpu/drm/ch=
ipwealth/ch1115-i2c.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/chipwealth/ch1115-i2c.c
[ ... ]
> +static int ch1115_oled_init(struct ch1115_device *ch1115)
> +{
[ ... ]
> +		CH1115_CMD_OFFSET,
> +		ch1115->flip_vertical
> +			? ch1115->y_start_offset
> +			: 64 - ch1115->y_start_offset,

[Severity: Medium]
Is this offset calculation correct for when flip_vertical is false? If
y_start_offset is 0, this evaluates to 64. Display offset values for this
controller type are 6-bit and must be strictly between 0 and 63. Sending 64
might be out of bounds and could corrupt the internal display state machine.

[ ... ]
> +static void ch1115_prepare_buffer(struct ch1115_device *ch1115,
> +				  const struct iosys_map *vmap,
> +				  struct drm_framebuffer *fb,
> +				  struct drm_rect *rect,
> +				  struct drm_format_conv_state *fmtcnv_state)
> +{
> +	unsigned int dst_pitch;
> +	struct iosys_map dst;
> +
> +	dst_pitch =3D DIV_ROUND_UP(ch1115->width, 8);
> +	rect->y1 =3D round_down(rect->y1, CH1115_PAGE_HEIGHT);
> +	rect->y2 =3D min_t(unsigned int, round_up(rect->y2, CH1115_PAGE_HEIGHT)=
, ch1115->height);
> +
> +	iosys_map_set_vaddr(&dst, ch1115->hwbuf + rect->y1 * dst_pitch + rect->=
x1 / 8);

[Severity: High]
Could this calculation result in an out-of-bounds heap memory access? The
damage rectangles returned by drm_atomic_helper_damage_iter_next are in
plane source coordinates. If a user sets a non-zero plane source offset or a
framebuffer larger than the panel, rect->x1 and rect->y1 can exceed the
panel dimensions, causing the absolute offsets to point outside the hwbuf
allocation. These coordinates should be translated to the plane's destinati=
on
coordinates first.

[Severity: Medium]
Are we guaranteed that rect->x1 and rect->x2 are aligned to byte boundaries?
The monochrome conversion helper drm_fb_xrgb8888_to_mono assumes the start
pixel maps to bit 0. If rect->x1 is not a multiple of 8, converted pixels
will be shifted improperly in the destination byte, corrupting the image and
overwriting adjacent pre-existing pixels outside the clip boundary.

> +	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
> +}
[ ... ]
> +static int ch1115_fb_update_rect(struct drm_framebuffer *fb, struct drm_=
rect *rect)
> +{
> +	struct ch1115_device *ch1115 =3D drm_to_ch1115(fb->dev);
> +	char *row =3D ch1115->row;
> +	int ret;
> +
> +	rect->y1 =3D round_down(rect->y1, CH1115_PAGE_HEIGHT);
> +	rect->y2 =3D min_t(unsigned int, round_up(rect->y2, CH1115_PAGE_HEIGHT)=
, ch1115->height);
> +
> +	for (int y =3D rect->y1; y < rect->y2; y +=3D CH1115_PAGE_HEIGHT) {
> +		for (int x =3D rect->x1; x < rect->x2; x++)
> +			row[x] =3D ch1115_transform_xy(ch1115->hwbuf, x, y, ch1115->bytes_per=
_row);

[Severity: High]
Can this index exceed the bounds of the row array? Similar to the hwbuf off=
set
above, rect->x1 and rect->x2 can exceed the panel width if the plane source
coordinates are larger than the display, writing out of bounds into the hea=
p.

[ ... ]
> +static int ch1115_primary_plane_helper_atomic_check(struct drm_plane *pl=
ane,
> +						    struct drm_atomic_commit *state)
> +{
[ ... ]
> +	return drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_st=
ate,
> +						   DRM_PLANE_NO_SCALING,
> +						   DRM_PLANE_NO_SCALING,
> +						   false, false);
> +}

[Severity: High]
Should we call drm_format_conv_state_reserve here? Because the driver uses
drm_fb_xrgb8888_to_mono during the atomic update phase, failing to reserve
the format conversion state here (where sleeping is allowed) forces a
GFP_KERNEL allocation inside the non-failable atomic update path.

[ ... ]
> +static void ch1115_primary_plane_helper_atomic_update(struct drm_plane *=
plane,
> +						      struct drm_atomic_commit *state)
> +{
[ ... ]
> +	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
> +	drm_atomic_for_each_plane_damage(&iter, &damage) {
> +		ch1115_prepare_buffer(ch1115,
> +				      &shadow_plane_state->data[0],
> +				      fb, &damage,
> +				      &shadow_plane_state->fmtcnv_state);

[Severity: High]
Does this sequence allocate memory in atomic context? Since
drm_format_conv_state_reserve is not called in atomic_check, the
drm_fb_xrgb8888_to_mono helper (invoked by ch1115_prepare_buffer) will atte=
mpt
a GFP_KERNEL allocation. This causes a scheduling while atomic panic.

> +
> +		ch1115_fb_update_rect(fb, &damage);

[Severity: High]
Can this trigger a sleep while in atomic context? The ch1115_fb_update_rect
function issues I2C commands. The DRM subsystem strictly forbids sleeping in
plane atomic update callbacks, but i2c_transfer acquires a mutex and will
trigger a scheduling while atomic kernel panic.

> +	}
> +
> +	drm_dev_exit(idx);
[ ... ]
> +static void ch1115_encoder_atomic_enable(struct drm_encoder *encoder,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct drm_device *drm =3D encoder->dev;
> +	struct ch1115_device *ch1115 =3D drm_to_ch1115(drm);
> +
> +	ch1115_oled_init(ch1115);
> +
> +	u8 command =3D CH1115_CMD_ON;
> +
> +	ch1115_send_command_list(ch1115, &command, 1);

[Severity: High]
Is it safe to issue I2C commands directly in the encoder enable callback? T=
his
path executes in atomic context where sleeping is prohibited, but
ch1115_send_command_list triggers an i2c_transfer which can sleep.

[Severity: High]
Does this hardware access need drm_dev_enter and drm_dev_exit protection?
Unlike the plane update functions, the encoder enable callback accesses the
regmap directly without verifying if the device is still plugged in. If an
atomic commit races with device unplug, this attempts a use-after-free on
the devm-managed regmap.

> +}
> +
> +static void ch1115_encoder_atomic_disable(struct drm_encoder *encoder,
> +					  struct drm_atomic_commit *state)
> +{
> +	struct drm_device *drm =3D encoder->dev;
> +	struct ch1115_device *ch1115 =3D drm_to_ch1115(drm);
> +
> +	u8 command =3D CH1115_CMD_OFF;
> +
> +	ch1115_send_command_list(ch1115, &command, 1);

[Severity: High]
Does this sleeping function also violate the atomic context constraints? Ju=
st
like the enable callback, atomic_disable executes in atomic context and can=
not
use i2c_transfer.

[Severity: High]
Is the regmap access protected here? Similar to the enable callback, this
requires drm_dev_enter and drm_dev_exit to avoid a use-after-free on device
unplug.

> +}
[ ... ]
> +static int ch1115_parse_dt(struct ch1115_device *ch1115)
> +{
[ ... ]
> +	if (dt.hactive.typ > CH1115_MAX_WIDTH) {
> +		dev_err(dev, "width=3D%d must be less than %d\n", dt.hactive.typ, CH11=
15_MAX_WIDTH);
> +		return -EINVAL;
> +	}
> +	if (dt.vactive.typ > CH1115_MAX_HEIGHT) {
> +		dev_err(dev, "height=3D%d must be less than %d\n", dt.vactive.typ, CH1=
115_MAX_HEIGHT);
> +		return -EINVAL;
> +	}

[Severity: High]
What happens if the device tree provides 0 for either of these dimensions?
The parsing validates the upper bounds but missing a check against zero
would cause the hwbuf and row allocations to request 0 bytes. This returns
the ZERO_SIZE_PTR (0x10), leading to a kernel panic upon dereference.

[ ... ]
> +static int ch1115_probe(struct i2c_client *client)
> +{
[ ... ]
> +	ch1115->hwbuf =3D devm_kzalloc(&client->dev,
> +				     (ch1115->width * ch1115->height) / 8,
> +				     GFP_KERNEL);

[Severity: High]
Can this allocation be smaller than the required buffer size? The size is
calculated without padding, but ch1115_prepare_buffer converts formats
using a pitch of DIV_ROUND_UP(width, 8). If width is not a multiple of 8,
drm_fb_xrgb8888_to_mono will write past the end of the allocation.

[ ... ]
> +static void ch1115_remove(struct i2c_client *client)
> +{
[ ... ]
> +	ret =3D ch1115_send_command_list(ch1115, cmd_list, ARRAY_SIZE(cmd_list)=
);
> +	if (ret < 0)
> +		dev_err(&client->dev, "There was an error executing the shutdown comma=
nds");
> +
> +	drm_dev_unregister(&ch1115->dev);
> +	drm_atomic_helper_shutdown(&ch1115->dev);
> +}

[Severity: Medium]
Should drm_dev_unregister be called before turning off the hardware? By
shutting down the panel while it is still registered, there is a window
where userspace can perform atomic commits on a powered-off display, which
could leave the hardware in an inconsistent state.

[Severity: High]
Will using drm_dev_unregister here instead of drm_dev_unplug cause problems
for devm allocations? Calling drm_dev_unregister leaves the dev->unplugged
flag unset. This allows drm_dev_enter to succeed even after the device is
unbound. Delayed atomic commits could then bypass drm_dev_enter and access
the freed devm-managed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787321297.gi=
t.nico.antinori.7@gmail.com?part=3D2
