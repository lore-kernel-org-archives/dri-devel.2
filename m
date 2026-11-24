Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947F606A32D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxUlcLaH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392B310E281;
	Tue, 24 Nov 2026 19:39:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3CAE10E270
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 19:39:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33AF441A35;
 Tue, 24 Nov 2026 19:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC731F000C0;
 Tue, 24 Nov 2026 19:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795549153;
 bh=rNDM8c9PoF7vdxbxPy4VFHaRlC320YkECGNtf/5fyYg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PxUlcLaHD8De9f2K7PhjuAYhY/VZea6gidgnWKJCfsuVG3gWHMqsngKCqzhGkdhhX
 JJ114rp4Yknsf2Ziub9S95qZbWand2xAnnu52o6BkSLY7ncgnW8SQ1pySxQOUZwQax
 x56pXenwgtEY2o0XN9yeZpLik7h06G90jZ2k+935+UxzngCxKkSwdxKwV0RvGCnOS9
 zR6jZposZeIkdU0PoLM8ezamYZYqEeHk0OwY+KSM7bxF3We5HD5jqD0i1vq4AwLWzP
 Rxq+0ECgQLidvzxPXwcf60X+7fDYq+qPw3Hn9tvXlSK92gnXEunQxWSbqDj1qQ6cdr
 m++wBAmWRnLrA==
Message-ID: <sashiko-outbox-231900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: Add Lontium LT9721 HDMI to eDP bridge
 driver
To: "Gianfranco Mariotti" <gianfranco.mariotti94@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124191803.283266-3-gianfranco.mariotti94@gmail.com>
References: <20261124191803.283266-1-gianfranco.mariotti94@gmail.com>
 <20261124191803.283266-3-gianfranco.mariotti94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:39:13 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/bridge: lt9721: refcount underflow on next_bridge in
  lt9721_link_panel()
- [Medium] drm/bridge: lt9721: off-by-one partial write count in
  lt9721_aux_transfer_i2c()
- [Low] drm/bridge: lt9721: missing DRM_BRIDGE_OP_DETECT for panels in
  lt9721_link_panel()
- [Low] drm/bridge: lt9721: positional initializer in lt9721_i2c_ids[]
--

commit aa23cf54f8347a08ccdc8bd2c65d1c07c8f8ba0d
Author: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>

drm/bridge: Add Lontium LT9721 HDMI to eDP bridge driver

This commit adds a DRM bridge driver for the Lontium LT9721 HDMI 1.4 to
1/2/4-lane eDP 1.4 bridge chip.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9721.c b/drivers/gpu/drm/br=
idge/lontium-lt9721.c
> new file mode 100644
> index 0000000000000..582e9e59dfb4d
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9721.c
[ ... ]
> +static ssize_t lt9721_aux_transfer_i2c(struct lt9721 *lt9721,
> +				       struct drm_dp_aux_msg *msg)
> +{
[ ... ]
> +	if (is_read) {
> +		data_len =3D min_t(size_t, msg->size, rx_cnt - 1);
> +		for (i =3D 0; i < data_len; i++) {
> +			ret =3D regmap_read(lt9721->regmap,
> +					  LT9721_REG_AUX_SOFT_FIFO, &val);
> +			if (ret)
> +				goto out_drain;
> +			buf[i] =3D val;
> +		}
> +		ret =3D data_len;
> +	} else if (rx_cnt > 1) {
> +		/* Partial write: sink returned count M (M + 1 bytes written) */
> +		ret =3D regmap_read(lt9721->regmap, LT9721_REG_AUX_SOFT_FIFO,
> +				  &val);
> +		if (ret =3D=3D 0)
> +			ret =3D min_t(size_t, msg->size, val + 1);
> +	} else {
> +		ret =3D msg->size;
> +	}

[Severity: Medium]
Does this over-report partial I2C-over-AUX writes by one byte?

Unlike the 4-bit length field in the AUX request header, the reply data
byte M returned by a DisplayPort sink on a short I2C write is already the
exact number of bytes written (0 < M < msg->size).  Returning val + 1
causes drm_dp_i2c_drain_msg() to advance msg.buffer by one unwritten byte
on each partial write.

[ ... ]

> +static enum drm_connector_status
> +lt9721_bridge_detect(struct drm_bridge *bridge,
> +		     struct drm_connector *connector)
> +{
> +	struct lt9721 *lt9721 =3D bridge_to_lt9721(bridge);
> +	unsigned int val =3D 0;
> +
> +	if (lt9721->is_panel)
> +		return connector_status_connected;
> +
> +	if (regmap_read(lt9721->regmap, LT9721_REG_HPD_STATUS, &val))
> +		return connector_status_unknown;
> +
> +	return (val & LT9721_EDP_HPD_STATUS) ?
> +		connector_status_connected : connector_status_disconnected;
> +}
[ ... ]
> +static int lt9721_link_panel(struct drm_dp_aux *aux)
> +{
> +	struct lt9721 *lt9721 =3D aux_to_lt9721(aux);
> +	struct device *dev =3D lt9721->dev;
> +	struct drm_bridge *next_bridge;
> +
> +	next_bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
> +	if (IS_ERR(next_bridge))
> +		return PTR_ERR(next_bridge);
> +
> +	if (drm_bridge_is_panel(next_bridge))
> +		lt9721->is_panel =3D true;
> +	else
> +		lt9721->bridge.ops =3D DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;

[Severity: Low]
Should DRM_BRIDGE_OP_DETECT also be set when drm_bridge_is_panel() is
true?  Without it, drm_bridge_connector_init() and drm_bridge_detect()
never invoke lt9721_bridge_detect() for panels, leaving the
lt9721->is_panel check unreachable and failing to override an upstream
HDMI bridge's DRM_BRIDGE_OP_DETECT.

> +
> +	lt9721->bridge.next_bridge =3D next_bridge;
> +
> +	return devm_drm_bridge_add(dev, &lt9721->bridge);
> +}

[Severity: High]
Does assigning devm_drm_of_get_bridge() to lt9721->bridge.next_bridge
underflow next_bridge->refcount when lt9721->bridge is freed?

__drm_bridge_free() unconditionally calls
drm_bridge_put(bridge->next_bridge), so bridge.next_bridge requires an
owned reference.  devm_drm_of_get_bridge() does not return a reference for
bridge.next_bridge to consume: for a panel, devm_drm_panel_bridge_add()
already registers devm_drm_panel_bridge_release() to drop its reference on
unbind, and for a non-panel bridge, drm_of_find_panel_or_bridge() returns
an unreferenced pointer from of_drm_find_bridge().  On driver unbind or
probe unwind, __drm_bridge_free() drops an extra reference and frees the
downstream bridge prematurely.

Using of_drm_get_bridge_by_endpoint() (or taking a reference with
drm_bridge_get()) would provide the reference that bridge.next_bridge
expects.

[ ... ]

> +static const struct i2c_device_id lt9721_i2c_ids[] =3D {
> +	{ "lt9721" },
> +	{ }
> +};

[Severity: Low]
This isn't a bug, but new struct i2c_device_id entries should use named
initializers ({ .name =3D "lt9721" }).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124191803.2832=
66-1-gianfranco.mariotti94@gmail.com?part=3D2
