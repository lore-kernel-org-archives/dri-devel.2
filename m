Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71838C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35ED10E3F7;
	Mon, 21 Sep 2026 16:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NH8ba7mj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C004110E3F7
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:20:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7570F429FB;
 Mon, 21 Sep 2026 16:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378C51F000FF;
 Mon, 21 Sep 2026 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007631;
 bh=5eiLh41Cjl+iHm0Exzu26g07ztkeJJf56ctckxQetSY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NH8ba7mjnE1N6oRysnHlnuUqWxzjahI+9yDEmP2AjNVOeGvavtvcTHjmDVWNePyg2
 4Q0+D+r94FI5CmCqvAaICjKICsdc0Irkvc086kmr9YjhA9ww2tB37vOPxCSHv622Y0
 oYLaRi01ucVjvSo9LLM/dji6BhWMeWiuFUNbLA8k7sNCGQGmVc13xPA3V7I9KNF3C2
 s83iO+rkCtuzlTuGecXrz/kDiuQsIcoQkHtLVL85wz7PLET2XEslTuju0rEYH1Iram
 +xFD956Lia2MEw3PZZw2Cm65G4WpPi0YvcDZ1/CcNBwACNghHC1igg8O8NuJnIzNmt
 i3wH2gfB0UmUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 17/25] drm/connector: Add "qms_enabled" drm property
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-17-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-17-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:20:30 +0000
Message-Id: <20260921162031.378C51F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm: qms_enabled property exposed to legacy userspace without DR=
M_MODE_PROP_ATOMIC
--

commit d13e141a83779dcc2e18e7f2092c22b8d25dc870
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/connector: Add "qms_enabled" drm property

This commit introduces a new DRM property "qms_enabled" to allow userspace=
=20
to request the kernel to use Quick Media Switching (QMS) on compatible HDMI=
=20
connectors. It updates the connector state and adds atomic uAPI handlers fo=
r=20
the new property.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 5c07bd221977c..7ea235a58781f 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
[ ... ]
> +int drm_connector_attach_qms_enabled_property(struct drm_connector *conn=
ector)
> +{
> +	connector->qms_enabled_property =3D
> +		drm_property_create_bool(connector->dev, 0, "qms_enabled");

[Severity: Medium]
Does this code inadvertently expose the "qms_enabled" property to legacy
userspace clients?

When creating the property in drm_connector_attach_qms_enabled_property(),
the flag parameter is passed as 0 instead of DRM_MODE_PROP_ATOMIC.

Without the DRM_MODE_PROP_ATOMIC flag, legacy X11/KMS clients can inappropr=
iately
discover this property when iterating over connector properties via=20
drmModeGetConnector().

Since this property is designed strictly for atomic modesetting state, shou=
ld
it be hidden from legacy userspace to avoid ABI pollution?

> +	if (!connector->qms_enabled_property)
> +		return -ENOMEM;
> +
> +	drm_object_attach_property(&connector->base, connector->qms_enabled_pro=
perty, 0);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_connector_attach_qms_enabled_property);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D17
