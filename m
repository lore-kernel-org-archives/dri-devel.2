Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA17606A32F
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhA7VG6h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9470E10E02C;
	Thu,  5 Nov 2026 16:27:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739DA10E02C
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:27:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3003143FE3;
 Thu,  5 Nov 2026 16:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF6F1F00A1F;
 Thu,  5 Nov 2026 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793896044;
 bh=I7NBtS9r46SOKn6+EzRsBNLlX7kr140lxLmzIEE/jio=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NhA7VG6h/JGhFX2CBcEbinTD182gzCdA599R2m9ou1/BpM6+tv941K5Jxg+vygT5S
 y2sB0po1ucD8gRcj8oQcXHRxPsnjM50KCQFP+sn8RBYb6eb6+B9bjpuJjm+XchogFG
 GJyXI2niQK7Uz/lB9djNa8OW7I7tnLQQ5eVvEvaoUl0jgYyjsF/Nwiso3s+Ldv0ebI
 jm3CZ/hWExELx47QlAvj7dwC5AVJETfHW5CG3knLDWNCM99JqUsTSxhrGqcaLV82kX
 cKKWcA5xJj3yCwMokFbNWloXgdfdT4panDJvradzQZG5Jcbp7UpjuCh0KJPu+iOBI5
 YjBeMWQOqqE1g==
Message-ID: <sashiko-outbox-199492@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/27] drm/connector: add vrr_display_mode connector
 property
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-2-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-2-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:27:23 +0000
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
- [Low] drm/connector: missing kernel-doc header on enum vrr_display_mode
--

commit da4673cb9da04a6d510c119f2c09b6e0b6e956b2
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/connector: add vrr_display_mode connector property

This commit introduces the vrr_display_mode connector enum property and its
associated connector state field so userspace can explicitly control whether
a VRR-capable display operates in Game or Off mode regardless of CRTC state.

> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 2ee7c59329aae..8699f35cafcba 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -809,6 +809,15 @@ enum drm_bus_flags {
>  	DRM_BUS_FLAG_SHARP_SIGNALS =3D BIT(8),
>  };
> =20
> +enum vrr_display_mode {
> +	/** @VRR_DISPLAY_MODE_GAME: Set the display to VRR "Game" mode */
> +	VRR_DISPLAY_MODE_GAME =3D 0,
> +	/** @VRR_DISPLAY_MODE_OFF: Turn off VRR on the display */
> +	VRR_DISPLAY_MODE_OFF,
> +	/** @VRR_DISPLAY_MODE_COUNT: Sentinel, not a valid mode, keep last */
> +	VRR_DISPLAY_MODE_COUNT
> +};

[Severity: Low]
enum vrr_display_mode documents its enumerators with inline kernel-doc
comments and is cross-referenced as &enum vrr_display_mode from
struct drm_connector_state and struct drm_connector, but it does not have an
opening kernel-doc comment block above the enum declaration.

Because kernel-doc only enters declaration parsing after encountering a
standalone /** header line, scripts/kernel-doc skips enum vrr_display_mode
and its inline member descriptions when processing include/drm/drm_connecto=
r.h.

Should a /** enum vrr_display_mode - ... */ kernel-doc header block be added
above enum vrr_display_mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D2
