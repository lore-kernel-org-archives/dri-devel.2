Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4BF606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AISAqeJ8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D6EB10E40C;
	Fri, 13 Nov 2026 08:44:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF7DD10E40C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:44:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 900E940681;
 Fri, 13 Nov 2026 08:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536341F000C4;
 Fri, 13 Nov 2026 08:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794559454;
 bh=DFNsBjEDAjxXjflPufvcpO3sdPQlLxLUIWRG1Lg9wSI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AISAqeJ8av2OlzZzQY1Z12vs8JdN6PieHgZTGUHTOHNtQqr0kp4Al29/Pu79nCloL
 xKW5nGegQH9OGz0QX0UmvFK8lNcj+lRkmP+VxdTcrL4b033amYw+Ip+C9o8Eml853s
 l2cL5kTL7ZGdEKmqc0EZFfEl+K+ztZ1Cjd7jpMN416FKBAud5Vldp0vsVtDz3jFmlO
 FGRqUVKAvAr+a3rX9zqIuIWNhhm5pYifZzQ00SwhJ9kVHQQPrIi9+pAh4PlSJ+XeVc
 vC4DJUi7lduDFNc79Tnpo0AorJxBA0oEjYOBEaFARQ/zvI/hjGdzLp+GYLSQsFLIXt
 qD5z6H68oAE5A==
Message-ID: <sashiko-outbox-212451@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/18] drm/bridge: analogix_dp: Declare
 DRM_BRIDGE_OP_HPD for hotplug reporting
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261113082305.541652-17-damon.ding@rock-chips.com>
References: <20261113082305.541652-1-damon.ding@rock-chips.com>
 <20261113082305.541652-17-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 08:44:13 +0000
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
- [Medium] drm/bridge: analogix_dp: HPD op set before
  force_connected_mode init
--

commit ad70afa663b2bf96d50d8e1fd67e15c99b7409dc
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Declare DRM_BRIDGE_OP_HPD for hotplug reporting

This commit declares DRM_BRIDGE_OP_HPD on the analogix_dp bridge when
hotplug detection is supported, implements empty hpd_enable/hpd_disable
callbacks, and replaces drm_helper_hpd_irq_event() with
drm_bridge_hpd_notify().

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index d72b66be6874d..9f50163aecf9f 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c

[ ... ]

> @@ -1634,6 +1647,8 @@ int analogix_dp_bind(struct analogix_dp_device *dp,=
 struct drm_device *drm_dev)
>  	}
> =20
>  	bridge->ops =3D DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
> +	if (analogix_dp_supports_hpd(dp))
> +		bridge->ops |=3D DRM_BRIDGE_OP_HPD;
>  	bridge->of_node =3D dp->dev->of_node;
>  	bridge->type =3D DRM_MODE_CONNECTOR_eDP;
>  	ret =3D devm_drm_bridge_add(dp->dev, &dp->bridge);

[Severity: Medium]
Does calling analogix_dp_supports_hpd() here set DRM_BRIDGE_OP_HPD before
dp->force_connected_mode is initialized?

analogix_dp_supports_hpd() checks dp->force_connected_mode to exclude fixed
panels, but dp->force_connected_mode is only populated later in
analogix_dp_bind() when drm_bridge_attach() invokes
analogix_dp_bridge_attach().  On RK3576/RK3588 or boards with hpd_gpiod
connected to a fixed panel, bridge->ops gets DRM_BRIDGE_OP_HPD while the
subsequent analogix_dp_supports_hpd() check after drm_bridge_attach() skips
enable_irq(dp->irq), leaving the connector configured for HPD interrupts
that are never enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113082305.5416=
52-1-damon.ding@rock-chips.com?part=3D16
