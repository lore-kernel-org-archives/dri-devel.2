Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3D1C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EEA810E1FE;
	Tue, 15 Sep 2026 19:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RRKyl7qZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C78A810E1FE
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 19:03:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 754BA43DDE;
 Tue, 15 Sep 2026 19:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607831F000FF;
 Tue, 15 Sep 2026 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789499018;
 bh=/yBT0uXyvbq6/6U7mSSPIWn437Wj9gvhuwkgLpGyM+Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RRKyl7qZk06RNwTRElLj3hoLtqqO6h5oPi/JgziEbdETcrHyLYT6gM53ZpXIcotax
 keostlWVVIoW0PU8sAO7LdhE/UCxtI0eajO928dpx+B8ZYiqfiiXY78IBgsPF9VE1F
 MjOmcClIXzQD/MlcuWfhuWpgz0z1ArnLLkQdDuETdllHjvxom5bl6dl1L1hXht1lEG
 aQhnRVVKnUZCFzDt42nPEKvzXuBp6ZfJ7UnRe93n3/QGwNXkYBNxqyDLiEMY6rU1zS
 a01h0vVtzP1TlWcSG309O55AK2W76GEzu2lctJE257z/xa2+BuyP56jL/uoKSTJoNq
 M+N2FDBEsPKiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260916-lt9611c-v7-v16-2-c65042fcd245@oss.qualcomm.com>
References: <20260916-lt9611c-v7-v16-0-c65042fcd245@oss.qualcomm.com>
 <20260916-lt9611c-v7-v16-2-c65042fcd245@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 19:03:36 +0000
Message-Id: <20260915190337.607831F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/bridge: premature bridge registration causes UAF on probe fail=
ure
- [High] drm/bridge: missing HDMI formats and max_bpc initialization causes=
 display failure
--

commit 845a14001f40c5c49616eeff3efbd5f04313cc72
Author: Sunyun Yang <syyang@lontium.com>

drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

This commit introduces the DRM bridge driver for the Lontium
LT9611C(EX/UXD) MIPI DSI to HDMI converter chips. It supports single or
dual MIPI DSI and I2S signals to HDMI output.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/b=
ridge/lontium-lt9611c.c
> new file mode 100644
> index 0000000000000..54ae535339f74
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
[ ... ]
> @@ -1160,20 +1160,20 @@
[ ... ]
> +	lt9611c->bridge.of_node =3D client->dev.of_node;
> +	lt9611c->bridge.ops =3D DRM_BRIDGE_OP_DETECT |
> +			DRM_BRIDGE_OP_EDID |
> +			DRM_BRIDGE_OP_HPD |
> +			DRM_BRIDGE_OP_HDMI |
> +			DRM_BRIDGE_OP_HDMI_AUDIO;

[Severity: High]
Will setting the DRM_BRIDGE_OP_HDMI flag here cause connector initialization
to fail?

It looks like the bridge.supported_formats and bridge.max_bpc fields are not
initialized before this is set. When drm_bridge_connector_init() calls the
core helper drm_connector_hdmi_init(), it strictly validates these paramete=
rs.
Because they are implicitly zero-initialized, drm_connector_hdmi_init() will
return -EINVAL, which would deterministically fail the connector creation a=
nd
render the display driver non-functional.

Should these HDMI capabilities be explicitly set before enabling the HDMI o=
ps
flag?

> +	lt9611c->bridge.type =3D DRM_MODE_CONNECTOR_HDMIA;
> +
> +	lt9611c->bridge.vendor =3D "Lontium";
> +	lt9611c->bridge.product =3D "LT9611C";
> +
> +	lt9611c->bridge.hdmi_audio_dev =3D dev;
> +	lt9611c->bridge.hdmi_audio_max_i2s_playback_channels =3D 8;
> +	lt9611c->bridge.hdmi_audio_dai_port =3D 2;
> +
> +	drm_bridge_add(&lt9611c->bridge);
> +
> +	/* Attach primary DSI */
> +	dsi =3D lt9611c_attach_dsi(lt9611c, dsi0_node);
> +	if (IS_ERR(dsi)) {
> +		ret =3D PTR_ERR(dsi);
> +		goto err_remove_bridge;
> +	}

[Severity: High]
Can this sequence lead to a use-after-free if the DSI attachment fails?

Because drm_bridge_add() makes the bridge globally visible on the bridge_li=
st,
another KMS driver could concurrently discover and attach to it during this
window. If the subsequent lt9611c_attach_dsi() call fails (for example,
returning -EPROBE_DEFER), the driver calls drm_bridge_remove() and returns =
an
error, which triggers devres to free the memory backing the bridge.

Could the concurrent KMS driver be left holding a dangling pointer to
devres-freed memory? Should drm_bridge_add() be deferred until all resources
are successfully acquired?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-lt9611c-v7=
-v16-0-c65042fcd245@oss.qualcomm.com?part=3D2
