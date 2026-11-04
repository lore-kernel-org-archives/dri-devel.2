Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F65606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/eSXrM3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543FE10F98B;
	Wed,  4 Nov 2026 03:06:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA8610F98C
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 03:06:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FDA9436C6;
 Wed,  4 Nov 2026 03:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15F01F000C1;
 Wed,  4 Nov 2026 03:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793761602;
 bh=k8XE7i2vDEG6s5EBfCMs4XeuN9QkZk9DzJnWZi1nu50=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c/eSXrM3Wvxoe5toT7qCe/DsgLXUpqQEq5U+g4zne/cQxEP/gNB91GgKpLonPsWAz
 1QDrAtJUzDsY9gjaWWhU/OEIQ9/lcQ9zITWF9ZmFZ5nRe2j0tMmBWkB/pRFo9RS7nl
 s0vCbzxIj8LiBJ6ch+3cYxTTxy6iFZor3zoukNigC5p6b4SwOxbJ7fcHBSlxn6NxEE
 Xd2mrgxswZkqChDHzaSZGHiCgnz0DJNLoSrSkCa2PPwgavZ2CPWjfui+pV0aO8uH9B
 2UsvCPHdYSc/1gpVIvuodRLFn3XAX/77JyZxn6zgVHKq7sd+WrPODD6rGR0Xeoe6Ih
 p63jcA/9u/e0Q==
Message-ID: <sashiko-outbox-196583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/rockchip: rgb: fix panel bridge reference leak on
 setup error
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261104024058.1508856-1-vulab@iscas.ac.cn>
References: <20261104024058.1508856-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:06:41 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/rockchip: rgb: unguarded drm_panel_bridge_remove() in rockch=
ip_rgb_init()
--

commit 236134a70cc9d3d8c07b195274e3306b33801a49
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/rockchip: rgb: fix panel bridge reference leak on setup error

This commit adds a call to drm_panel_bridge_remove() in the error path of
rockchip_rgb_init() to release the panel bridge reference when
drm_bridge_attach() or drm_bridge_connector_init() fails.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/ro=
ckchip/rockchip_rgb.c
> index 0e1830bc40eec..10219638c0a24 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> @@ -172,6 +172,7 @@ struct rockchip_rgb *rockchip_rgb_init(struct device =
*dev,
>  	return rgb;
> =20
>  err_free_encoder:
> +	drm_panel_bridge_remove(rgb->bridge);
>  	drm_encoder_cleanup(encoder);

[Severity: Medium]
Can calling drm_panel_bridge_remove(rgb->bridge) unconditionally here trigg=
er
a warning on non-panel bridges and reverse the teardown order?

In rockchip_rgb_init(), drm_of_find_panel_or_bridge() can find either a
drm_panel or a standalone non-panel drm_bridge, and
drm_panel_bridge_add_typed() is only called when panel is non-NULL:

drivers/gpu/drm/rockchip/rockchip_rgb.c:rockchip_rgb_init() {
	...
		ret =3D drm_of_find_panel_or_bridge(dev->of_node, video_port,
						  endpoint_id, &panel, &bridge);
	...
	if (panel) {
		bridge =3D drm_panel_bridge_add_typed(panel,
						    DRM_MODE_CONNECTOR_LVDS);
		drm_panel_put(panel);
		if (IS_ERR(bridge))
			return ERR_CAST(bridge);
	}

	rgb->bridge =3D bridge;
}

When panel is NULL and rgb->bridge is an external non-panel bridge, if
drm_bridge_attach() or drm_bridge_connector_init() fails, jumping to
err_free_encoder calls drm_panel_bridge_remove(rgb->bridge), which hits the
non-panel warning in drm_panel_bridge_remove():

drivers/gpu/drm/drm_panel.c:drm_panel_bridge_remove() {
	if (!bridge)
		return;

	if (!drm_bridge_is_panel(bridge)) {
		drm_warn(bridge->dev, "%s: called on non-panel bridge!\n", __func__);
		return;
	}

	drm_bridge_put(bridge);
}

Also, when drm_bridge_attach() succeeds and drm_bridge_connector_init()
subsequently fails, rgb->bridge is already attached to encoder->bridge_chai=
n.
Should drm_panel_bridge_remove(rgb->bridge) be guarded by if (panel) and
called after drm_encoder_cleanup(encoder) detaches the bridge?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104024058.1508=
856-1-vulab@iscas.ac.cn?part=3D1
