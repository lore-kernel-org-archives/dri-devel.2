Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0850606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLcNHZLR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B82210EFD2;
	Tue, 24 Nov 2026 07:53:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8ED810EFEE
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:53:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5EA961122;
 Tue, 24 Nov 2026 07:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482051F000CF;
 Tue, 24 Nov 2026 07:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795506798;
 bh=uWYyyoiE9UEESB46HzIJ4ENyPiMktw2XHyLrZbBkdQs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=CLcNHZLRVY6hjqbFQz0CfWQ8gbDZhQklrWok+u6z0R8uwYWIjg7vZggyTJr+sw8g9
 lDJkfyKjj3v6Hu/tB1AoiOVgrJkUI61JlU1HIG9BiayzncLyZJvidPf1Zg9WzCf+ow
 tKLHpQQpIfylk30rBsYuLfZKzuvz70YaQf9MKimQXiiHoQjUt7fXF2bcA1+3K8XcaB
 mv8/+NhFOtpjGuVyHKtw+8g/Z1MdsOLmwWodBzNGOQAuzww0QEepqNxYwal0UZX0or
 m8GON0bjWQXkE3ErhM1KBXXAHhmY8SBlYoDPtItlKir+vA0EpvEB0f1kudSzNm3gRm
 LPXoZ/shAxqtw==
Message-ID: <sashiko-outbox-230685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] drm/komeda: Use the bridge connector
To: "Luo Liu" <Luo.Liu@cixtech.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124073600.3124817-2-Luo.Liu@cixtech.com>
References: <20261124073600.3124817-1-Luo.Liu@cixtech.com>
 <20261124073600.3124817-2-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:53:17 +0000
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

commit bdbabac7105a78a4323f2290c9df8999b1ab4fac
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/komeda: Use the bridge connector

This commit updates komeda to attach bridges with
DRM_BRIDGE_ATTACH_NO_CONNECTOR and creates the connector via
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
> +	if (err) {
>  		drm_err(drm, "bridge_attach() failed for pipe: %s\n",
>  			of_node_full_name(pipe->of_node));
> +		return err;
> +	}
> =20
> -	return err;
> +	connector =3D drm_bridge_connector_init(drm, encoder);
> +	if (IS_ERR(connector)) {
> +		drm_err(drm, "bridge connector init failed for pipe: %s\n",
> +			of_node_full_name(pipe->of_node));
> +		return PTR_ERR(connector);
> +	}

[Severity: Medium]
Does attaching with DRM_BRIDGE_ATTACH_NO_CONNECTOR break HDMI output,
infoframes, audio and hotplug notifications on Arm Morello SDP
(arch/arm64/boot/dts/arm/morello-sdp.dts)?

Morello SDP is the only mainline board using komeda, and it connects its
pipeline output to an nxp,tda998x bridge.  When attached with
DRM_BRIDGE_ATTACH_NO_CONNECTOR, tda998x_bridge_attach() skips
tda998x_connector_init(), so EDID reads via the new drm_bridge_connector
populate display_info on the bridge connector while leaving the driver's
internal priv->connector zeroed.

During modeset, tda998x_bridge_mode_set() still reads display_info from
priv->connector:

drivers/gpu/drm/bridge/tda998x_drv.c:tda998x_bridge_mode_set() {
    ...
	if (priv->connector.display_info.rgb_quant_range_selectable)
    ...
	priv->supports_infoframes =3D priv->connector.display_info.cea_rev >=3D 3;
    ...
}

Because priv->connector.display_info.cea_rev remains 0,
priv->supports_infoframes is always false, leaving the transmitter in DVI
mode without AVI/VSI infoframes or HDMI audio.  In addition,
tda998x_detect_work() checks priv->connector.dev before reporting hotplug
events and never calls drm_bridge_hpd_notify(), so HPD interrupts are no
longer reported either.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124073600.3124=
817-1-Luo.Liu@cixtech.com?part=3D1
