Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3B3C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B97510F770;
	Sat, 27 Jun 2026 03:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="du9pY4Hn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B057410F770
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:45:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3537F600AA;
 Sat, 27 Jun 2026 03:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85A31F000E9;
 Sat, 27 Jun 2026 03:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531925;
 bh=81g4sLh6ZBbS+dARHBasocRNKSEgkkZ8Z3DdoXojnTY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=du9pY4HnPWl3UHmasTXf6ttIEtH7o10k6Tlv+JoXJHJyPM57905D6PlVBp/QATadr
 3awULpxjL1kTIaFb6UjZ/bpIwuwF6zcoQdGcYOGKznIZ/4tF0+VI/Mk9B8HKHNyq1p
 IcZQycsGsSnglI5n26kuyaNSAaggv2wACRlLhWyTUwE3S/VhZm3BAqHo8JJQFiEWOP
 VgZJVFw2kXi8c9v47sF/skzUsZDDtEmVgOpLtgL5LmxKSWYQRauejYTcJK/9wW0KQG
 BPWGGnkE0dUELQXlagAs/y29Lgmske4O6xzpfoHr5EPRuaqGtGyHzVNkOkHOcvP0tu
 +LfR6HfqZjjrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 28/38] drm/vkms: Introduce configfs for connector type
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-28-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-28-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:45:24 +0000
Message-Id: <20260627034525.B85A31F000E9@smtp.kernel.org>
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
- [Low] The configfs show method `connector_type_show` does not append a ne=
wline character to its output.
--

commit fa7352c404d21d848225a9615b7a1039d2636d9c
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for connector type

This commit adds a new configfs attribute to allow configuring the connecto=
r=20
type in VKMS. It updates both the configfs interface and the corresponding
documentation.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index 95f4594fb683d..8b414f1950e8e 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
[ ... ]
> @@ -1117,10 +1117,75 @@ static ssize_t connector_status_store(struct conf=
ig_item *item,
>  	return (ssize_t)count;
>  }
> =20
> +static ssize_t connector_type_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_connector *connector;
> +	int type;
> +
> +	connector =3D connector_item_to_vkms_configfs_connector(item);
> +
> +	scoped_guard(mutex, &connector->dev->lock) {
> +		type =3D vkms_config_connector_get_type(connector->config);
> +	}
> +
> +	return sprintf(page, "%u", type);

[Severity: Low]
Does this output need a trailing newline? Configfs attributes typically
include a newline (e.g., "%u\n") to ensure the output is formatted properly
when read from userspace using command-line tools like cat.

> +}
> +
> +static ssize_t connector_type_store(struct config_item *item,
> +				    const char *page, size_t count)
> +{
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D28
