Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628B8C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC89010F791;
	Sat, 27 Jun 2026 03:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kB9ZCEwO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A81E10F791
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:58:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EA16600AA;
 Sat, 27 Jun 2026 03:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1051F000E9;
 Sat, 27 Jun 2026 03:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532708;
 bh=mJTHJqTRLHvBlP837qf2Eql19F6S3+rMcsD71Kd23Fs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kB9ZCEwOky/AWbk7FakHGmN8a5WmIFHZBaOrLyyupHo5FfMrtOnjU4IIB76ilAfmC
 T2LQSU8g2VkoYLAYIRRfQKYC9rQMDrETu8XfhOKaT/ajrzBi8QCUuN2GeoNPZK94k5
 vIlU9pBi54r0UNxspLoEw2w2V8b5dM8AaC0hpBylrJGPjBsWktTnsaMyxlwUthQXQi
 ms/FZayg0xJofiGIGFAQu4qb6tOARUSMTtnjPM547xvzh9L9Xv3erHcl9UA0rpkC8o
 VLYhBcddMHtE1smoXX4EVt5kaCw4XaPfo2phYNmROSQymTJZxxSw+v+crADJcqDqUd
 QH/SYAoHVAiaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 30/38] drm/vkms: Introduce config for connector
 supported colorspace
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-30-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-30-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:58:27 +0000
Message-Id: <20260627035827.DA1051F000E9@smtp.kernel.org>
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

New issues:
- [Medium] Missing support for DRM_MODE_CONNECTOR_HDMIB in VKMS connector i=
nitialization.

Pre-existing issues:
- [High] Lockless iteration over configuration lists in debugfs allows conc=
urrent Use-After-Free if configfs items are removed.
--

commit adab925d90477ebe9d202328861dc983f52ebccf
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for connector supported colorspace

This commit introduces the ability to configure supported colorspaces
for HDMI, eDP, and DP connectors in VKMS to emulate HDR features.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index c407aea0bc6a9..ea9bc5d06be67 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c

[ ... ]

> @@ -600,6 +600,10 @@ static int vkms_config_show(struct seq_file *m, void=
 *data)
>  			   drm_get_connector_status_name(vkms_config_connector_get_status(con=
nector_cfg)));
>  		seq_printf(m, "\ttype=3D%s\n",
>  			   drm_get_connector_type_name(vkms_config_connector_get_type(connect=
or_cfg)));
> +		seq_puts(m, "\tsupported colorspaces=3D");
> +		show_bitfield(m, vkms_config_connector_get_supported_colorspaces(conne=
ctor_cfg),
> +			      drm_get_colorspace_name);

[Severity: High]
This is a pre-existing issue, but does this lockless iteration over the
connectors list in vkms_config_show() expose us to a use-after-free?

If userspace removes a connector via configfs concurrently,
vkms_config_destroy_connector() will free the connector_cfg without any loc=
ks
synchronizing with this debugfs read path. This patch adds additional reads
of the connector_cfg during this iteration.

> +		seq_puts(m, "\n");
>  	}
> =20
>  	return 0;

[ ... ]

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms=
/vkms_connector.c
> index 5b29dcade7e19..a1f08167def1d 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c

[ ... ]

> +static int __must_check vkms_connector_init(struct vkms_connector *conne=
ctor,
> +					    struct vkms_config_connector *connector_cfg)
> +{
> +	int ret =3D 0;
> +
> +	if (vkms_config_connector_get_supported_colorspaces(connector_cfg)) {
> +		if (connector_cfg->type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
> +			ret =3D drm_mode_create_hdmi_colorspace_property(&connector->base,
> +								       vkms_config_connector_get_supported_colorspaces(connector=
_cfg));

[Severity: Medium]
Does this logic inadvertently omit DRM_MODE_CONNECTOR_HDMIB?=20

If a user configures a connector as HDMIB with supported colorspaces via
configfs, it looks like the colorspace property will not be created or
attached since only HDMIA is checked during this initialization.

> +			if (ret)
> +				return ret;
> +		} else if (connector_cfg->type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
> +			   connector_cfg->type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> +			ret =3D drm_mode_create_dp_colorspace_property(&connector->base,
> +								     vkms_config_connector_get_supported_colorspaces(connector_c=
fg));
> +			if (ret)
> +				return ret;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D30
