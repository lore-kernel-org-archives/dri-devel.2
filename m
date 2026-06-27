Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5029FC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB0010F76F;
	Sat, 27 Jun 2026 03:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cPYzfWRh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3919B10F76F
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:45:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8ED6A600AA;
 Sat, 27 Jun 2026 03:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFE41F000E9;
 Sat, 27 Jun 2026 03:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531924;
 bh=MSbg9PoW7kljp6vrz9K1/VuvTwQddXYwxXuVPmFr+VU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cPYzfWRhCxbJt7gJhhZCZia5TnbEmjeMpopHPfI+1HUUdQWA0cQz3j579zRXv7b3C
 gGAL8xf5I6NyfkrfdoJnplVQpfig8ds4pvnqtPuwEUcf73X2ITOoUadC06XTSlMRBA
 ptCUJVk/URoSVHLmzC/78InoFqdXCi4SqdHZvocjIZwPddleETpeBZ1lQ3o52uhVgI
 WCe9rJ8HiCakILQR6kmWRDyNiFl4cwvzlqip8puMS9Kc+m1NJwPMgi7fJ/EvwYY408
 Y0R3Oj8IDNyL2N1+qZoBNqJE75GNKFfCUHlCAV+N5yDWdgqqFw75zCL36VeeewBg+P
 QzpIT4nvLoeZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 27/38] drm/vkms: Introduce config for connector type
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-27-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-27-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:45:23 +0000
Message-Id: <20260627034524.1DFE41F000E9@smtp.kernel.org>
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
- [Low] Missing parameter documentation for @connector_cfg in vkms_connecto=
r_init().
--

commit 7b78b90cde59a7b9192c3c5358636914942ee62e
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for connector type

This commit introduces a connector type configuration for VKMS to emulate
connector-specific behavior. It adds the configuration structure, updates
the connector initialization to use the specified type, and provides tests
for the new functionality.

> diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms=
/vkms_connector.h
> index ed312f4eff3a7..33253d29b1ccd 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.h
> +++ b/drivers/gpu/drm/vkms/vkms_connector.h

[ ... ]

> @@ -24,7 +25,8 @@ struct vkms_connector {
>   * Returns:
>   * The connector or an error on failure.
>   */
> -struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev);
> +struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
> +					   struct vkms_config_connector *connector_cfg);

[Severity: Low]
This isn't a bug, but the kernel-doc comment above vkms_connector_init() in
drivers/gpu/drm/vkms/vkms_connector.h is missing the description for the ne=
wly
added connector_cfg parameter.

It appears this remains undocumented even in the subsequent patch that
renames the function to vkms_connector_init_static().

Should an @connector_cfg: entry be added to the kernel-doc to prevent build
warnings when compiling with W=3D1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D27
