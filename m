Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A709606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFp1dU2h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60BB110E45E;
	Tue, 24 Nov 2026 07:19:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8616210E45E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:18:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8770560D96;
 Tue, 24 Nov 2026 07:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FED1F000D1;
 Tue, 24 Nov 2026 07:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795504737;
 bh=uJuq+URP+Pa2HY3YIguxjIxpcpLo7z+2t4+vEbQYPXQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=XFp1dU2h8tWVjjkiVe+uoVwCiUTWT6oUdr/sc/H+KkYxtj5yEQSULoGL6W4MVtxN7
 xZgKzC+/eZrKCFfP4/puMQ4cT0QlDzJSDSeHM8b670sjx6dqViP5D5kllkmQt+85bZ
 JJBBpveevd7OmUakoyg9eLTc7HSJ8HN3ZEaKNP0lgaJS+EJP6NPBdHHu/NQadntRsG
 SB+sOc/HZ5OjztZ82pdMz/ua3bWX45Nm8ya8AUmUnSpTc0iE5Rni0lEoOZEXHzgU3M
 HWf/FwRD0/8ot/9U5iW2uL9Qlp76KW6iIfIroA7U5xoNc1viAgT0Az/u23qDRCSSwP
 054heBDF3vfjw==
Message-ID: <sashiko-outbox-230627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/komeda: Use the bridge connector
To: "Luo Liu" <Luo.Liu@cixtech.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124065446.3107248-2-Luo.Liu@cixtech.com>
References: <20261124065446.3107248-1-Luo.Liu@cixtech.com>
 <20261124065446.3107248-2-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:18:57 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/komeda: broken HDMI mode and infoframes with tda998x in
  komeda_attach_bridge()
--

commit 293b61d44e25857ad3d8e0efc9c67e615c5a4933
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/komeda: Use the bridge connector

This commit attaches komeda's downstream bridge with
DRM_BRIDGE_ATTACH_NO_CONNECTOR and initializes a bridge connector using
drm_bridge_connector_init().

> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 0fd069fc3386d..3d5f06e085fac 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
[ ... ]
> @@ -626,12 +628,22 @@ static int komeda_attach_bridge(struct device *dev,
>  		return dev_err_probe(dev, PTR_ERR(bridge), "remote bridge not found fo=
r pipe: %s\n",
>  				     of_node_full_name(pipe->of_node));
> =20
> -	err =3D drm_bridge_attach(encoder, bridge, NULL, 0);
> -	if (err)
> +	err =3D drm_bridge_attach(encoder, bridge, NULL,
> +				DRM_BRIDGE_ATTACH_NO_CONNECTOR);

[Severity: Medium]
Does passing DRM_BRIDGE_ATTACH_NO_CONNECTOR break HDMI output, infoframes
and audio with the nxp,tda998x bridge used on Arm Morello SDP
(arch/arm64/boot/dts/arm/morello-sdp.dts)?

When attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR, tda998x_bridge_attach()
skips tda998x_connector_init() and leaves priv->connector zeroed, while
drm_edid_connector_update() populates display_info on the newly created
drm_bridge_connector instead.  However, tda998x_bridge_mode_set() still
reads display_info from its internal priv->connector:

drivers/gpu/drm/bridge/tda998x_drv.c:tda998x_bridge_mode_set() {
    ...
	priv->supports_infoframes =3D priv->connector.display_info.cea_rev >=3D 3;
    ...
}

Because priv->connector.display_info.cea_rev remains 0,
priv->supports_infoframes is always false, forcing the transmitter into DVI
mode and disabling AVI/VSI infoframes and HDMI audio.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124065446.3107=
248-1-Luo.Liu@cixtech.com?part=3D1
