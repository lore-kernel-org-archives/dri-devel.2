Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A7ACA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0560610E02C;
	Thu,  1 Oct 2026 12:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gpjDlQ2p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97AC410E02C
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:48:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C2CB60A55;
 Thu,  1 Oct 2026 12:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2345E1F000FF;
 Thu,  1 Oct 2026 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790858936;
 bh=sl6TR850Fo0xRCMRojc9x6eqxqa/0pVRptThyRAvxPk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gpjDlQ2pc+kU/Y6A1BMMvL9DnwwJmfuWsNJVv2Q86M2pHOZE3cpfz/htu612ckddE
 c3k4+onuC64J/F/Y3AuFU0YNiEGUAcz0dQT3ZKdE1lrRQZhZjPfCvp70Abk2llnZWf
 aYKZ8WTzTnWwew3piTB/fP44hsEVZpfCuqqln364dsxHfjDXZZo+BAqrBX2vOJ/MoO
 uDCIQ2TrQzKDKIChU/nwjP/SGdRYYvW0jXE0iCnu2jHkis5Nb0r6XkP1Q8GcPXPKGI
 X5ax9NvBW/+0ezuRD+Dr61GQtNs41SYueWvEO/b36aD9Mf5d5vtJqMlB6MDs5KsXIG
 5wBUTGpxCGXcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 02/24] drm/connector: add
 drm_connector_hdmi_dynamic_init()
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261001-drm-bridge-hotplug-v2-2-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-2-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:48:55 +0000
Message-Id: <20261001124856.2345E1F000FF@smtp.kernel.org>
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
- [Medium] drm/connector: resource leak on dynamic HDMI init failure due to=
 dead code
- [Low] drm/connector: incorrect kernel-doc function name for drm_connector=
_hdmi_dynamic_init
--

commit 7682dffb42f83d7a2155ddd8d9ec5ae0bcb7425d
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/connector: add drm_connector_hdmi_dynamic_init()

In preparation for adding hotpluggable bridges into the
drm_bridge_connector, we need connectors to be created dynamically, both
regular connectors and HDMI ones. drm_connector_init() already has a
dynamic variant, add one for HDMI connectors too.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index f5bd08640d251..f264cab0d184e 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -708,6 +708,48 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drmm_connector_hdmi_init);
> =20
> +/**
> + * drmm_connector_hdmi_init - Init a preallocated dynamic HDMI connector

[Severity: Low]
This isn't a bug, but the kernel-doc header lists the function name as
drmm_connector_hdmi_init instead of drm_connector_hdmi_dynamic_init. Could
this cause kernel-doc validation warnings?

> + * @dev: DRM device
> + * @connector: A pointer to the HDMI connector to init

[ ... ]

> +int drm_connector_hdmi_dynamic_init(struct drm_device *dev,
> +				    struct drm_connector *connector,
> +				    const struct drm_connector_funcs *funcs,
> +				    const struct drm_connector_hdmi_funcs *hdmi_funcs,
> +				    int connector_type,
> +				    struct i2c_adapter *ddc)
> +{
> +	int ret;
> +
> +	ret =3D drm_connector_hdmi_sanity_checks(dev, connector, hdmi_funcs, co=
nnector_type);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D drm_connector_dynamic_init(dev, connector, funcs, connector_typ=
e, ddc);
> +	if (ret)
> +		return ret;
> +
> +	if (ret)
> +		drm_connector_cleanup(connector);

[Severity: Medium]
Is this second if (ret) check dead code?

Since ret would have caused an early return in the previous check, this
drm_connector_cleanup(connector) will never run.=20

Does this leak resources (like the IDA allocation and connector name) if
drm_connector_hdmi_initialize() fails on the next line? Should the cleanup
instead happen on the return path if drm_connector_hdmi_initialize()=20
encounters a failure?

> +
> +	return drm_connector_hdmi_initialize(dev, connector, hdmi_funcs);
> +}
> +EXPORT_SYMBOL(drm_connector_hdmi_dynamic_init);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D2
