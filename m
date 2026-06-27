Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56790C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB18210F776;
	Sat, 27 Jun 2026 03:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XTVN8ATF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD76C10F776
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:48:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A391D43A70;
 Sat, 27 Jun 2026 03:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E851F000E9;
 Sat, 27 Jun 2026 03:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532097;
 bh=+I4tpfAj1xhRfUVc/s1JOgz4tsoFKvuBGhDrJZvWRQI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XTVN8ATFpfcqRuAKoxmvVS/ckystmnh/uW3JCAjExQ538Z/QakmRqvIdXIgpLPPOI
 3bpgCoLq8xXKbu1vNVWRttS9tbkJYvkUZ2/1FAsZGNybx3w/M6IQKJo8Qrgmm5yPvu
 FeKNxcjwi8dQSjqkXBgL1dtCpWgoY+Jvt4YVQRmAYHQI3wk1GzDEsLF5FOgupcL++d
 k+zAI30sllUhzjF0eltKTxLpRSd2ls/eB90/vTuzSb4WYYsUoYAueJsu1AmbSOZqfs
 VuQngb0AQS1GMYT5lSTQJe/2XTHpvd/STNSmNKZgdVXxk9mDGBklTB5kcCZae9GA6n
 GT35e0Ea13UXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 34/38] drm/vkms: Store the enabled/disabled status
 for connector
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-34-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-34-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:48:16 +0000
Message-Id: <20260627034817.56E851F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The iterator macros vkms_config_for_each_connector_static and vk=
ms_config_for_each_connector_dynamic introduce a dangling else vulnerabilit=
y.
- [Low] Kernel-doc comments for the new connector configuration functions c=
ontain copy-paste errors, and vkms_config_connector_is_dynamic lacks a cons=
t qualifier.
- [Low] The connector's enabled status is printed without a key in `vkms_co=
nfig_show`, breaking the `key=3Dvalue` format used for other properties.
--

commit 5e65d90ba630f2831298af2bffa8fd17ac0163ce
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Store the enabled/disabled status for connector
   =20
In order to prepare for dynamic connector configuration, we need to store
if a connector is dynamic and if it is enabled.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index 1a110b8aa114d..98e40c6a2c5b6 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -597,6 +597,8 @@ static int vkms_config_show(struct seq_file *m, void =
*data)
> =20
>  	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
>  		seq_puts(m, "connector:\n");
> +		seq_printf(m, "\t%s\n",
> +			   str_enabled_disabled(vkms_config_connector_is_enabled(connector_cf=
g)));

[Severity: Low]
Does this break the key=3Dvalue format used for other properties in debugfs?

Surrounding lines output a key, like "\tstatus=3D%s" or "\ttype=3D%s", but =
this
prints the status on a line by itself. Should this be "\tenabled=3D%s\n" to
maintain consistent formatting for programmatic parsing?

>  		seq_printf(m, "\tstatus=3D%s\n",
>  			   drm_get_connector_status_name(vkms_config_connector_get_status(con=
nector_cfg)));
[ ... ]
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vk=
ms_config.h
> index 7e361b6e45b0e..071887a65380a 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
[ ... ]
> @@ -194,6 +198,24 @@ struct vkms_config_connector {
>  #define vkms_config_for_each_connector(config, connector_cfg) \
>  	list_for_each_entry((connector_cfg), &(config)->connectors, link)
> =20
> +/**
> + * vkms_config_for_each_connector_static - Iterate over the static vkms_=
config connectors
> + * @config: &struct vkms_config pointer
> + * @connector_cfg: &struct vkms_config_connector pointer used as cursor
> + */
> +#define vkms_config_for_each_connector_static(config, connector_cfg) \
> +	vkms_config_for_each_connector((config), (connector_cfg)) \
> +		if (!(connector_cfg)->dynamic)

[Severity: Medium]
Could this macro definition lead to a dangling else vulnerability?

Because the trailing if statement is unbraced, any caller wrapping this
macro in an unbraced if/else block could have their else branch unexpectedly
hijacked by this macro's internal if condition.

> +
> +/**
> + * vkms_config_for_each_connector_dynamic - Iterate over the dynamic vkm=
s_config connectors
> + * @config: &struct vkms_config pointer
> + * @connector_cfg: &struct vkms_config_connector pointer used as cursor
> + */
> +#define vkms_config_for_each_connector_dynamic(config, connector_cfg) \
> +	vkms_config_for_each_connector((config), (connector_cfg)) \
> +		if ((connector_cfg)->dynamic)

[Severity: Medium]
Similarly, this macro also ends in an unbraced if statement. Could this cau=
se
the same latent control flow issue if used in an unbraced conditional block?

[ ... ]
> @@ -472,6 +494,50 @@ vkms_config_connector_set_type(struct vkms_config_co=
nnector *connector_cfg,
>  	connector_cfg->type =3D type;
>  }
> =20
> +/**
> + * vkms_config_connector_set_enabled() - If the connector is part of the=
 device
> + * @crtc_cfg: Target connector
> + * @enabled: Add or remove the connector
> + */

[Severity: Low]
This isn't a bug, but there's a typo in the parameter name. Should @crtc_cfg
be @connector_cfg to match the function signature?

> +static inline void
> +vkms_config_connector_set_enabled(struct vkms_config_connector *connecto=
r_cfg,
> +				  bool enabled)
> +{
> +	connector_cfg->enabled =3D enabled;
> +}
[ ... ]
> +/**
> + * vkms_config_connector_set_dynamic() - If the connector is dynamic
> + * @crtc_cfg: Target connector
> + * @enabled: Enable or disable the dynamic status
> + */

[Severity: Low]
Are these parameter names correct? It looks like @crtc_cfg should be
@connector_cfg, and @enabled should be @dynamic.

> +static inline void
> +vkms_config_connector_set_dynamic(struct vkms_config_connector *connecto=
r_cfg,
> +				  bool dynamic)
> +{
> +	connector_cfg->dynamic =3D dynamic;
> +}
> +
> +/**
> + * vkms_config_connector_is_enabled() - If the connector is dynamic
> + * @connector_cfg: The connector
> + */

[Severity: Low]
There's a typo in the function name documented here. Should it be
vkms_config_connector_is_dynamic()?

> +static inline bool
> +vkms_config_connector_is_dynamic(struct vkms_config_connector *connector=
_cfg)

[Severity: Low]
Is there a reason connector_cfg isn't const here, unlike in the similar
vkms_config_connector_is_enabled() function?

> +{
> +	return connector_cfg->dynamic;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D34
