Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A1606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMGPCKhV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D8210E99B;
	Thu, 26 Nov 2026 11:43:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D097B10E998
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:43:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BF2D416B3;
 Thu, 26 Nov 2026 11:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0003C1F000D1;
 Thu, 26 Nov 2026 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693398;
 bh=pDeNeBtTRN9nEuCAOdHratXdk8A0VleedB+TSL7QP28=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dMGPCKhVapLK0Q4/kLC4vWTRKM4Vn/osw2TaVUHOZ4RCkIzfMJ6N81R2oXqvOw7yM
 zdmlOgaEupsfY7EMcwmv1fhNzx1gFcgmrx2nAuVfv3yzSlw4+J87LyUOuqIJkczAF4
 lSshtU6tdpTac1DnZ3p6NVzSm1tSjq9Rgl+YHvSsO85KMkUKzHaFGN1e4wK5Vt2/5f
 5ZRcy4SFEfB5MkcYDUUu4vQ816GY8WDY35f8TNRKJ5AHuGg6AJndsxB6snzL/eaMKl
 vJlRec7/fD25ccsAzoNXTccMazfT9xGOxFyFHw182o87utkZI1NezINCfMpY1ukksB
 nqGlg/LWv0Mog==
Message-ID: <sashiko-outbox-235407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 22/43] drm/vkms: Introduce configfs for plane color
 encoding
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-22-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-22-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:43:16 +0000
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
- [Low] drm/vkms: inaccurate COLOR_ENCODING values and attribute name in
  docs
--

commit 5dbc58af236a05830b6c4e654122d665fcbe00b2
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for plane color encoding

This commit adds supported_color_encodings and default_color_encoding
configfs attributes to configure the available and default color encodings
for VKMS planes, along with ABI and driver documentation.

> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 6103054837168..7206cd2b231a0 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -87,7 +87,7 @@ Start by creating one or more planes::
> =20
>    sudo mkdir /config/vkms/my-vkms/planes/plane0
> =20
> -Planes have 3 configurable attributes:
> +Planes have 5 configurable attributes:
> =20
>  - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
>    exposed by the "type" property of a plane)
> @@ -96,6 +96,12 @@ Planes have 3 configurable attributes:
>    (same values as those exposed by the "rotation" property of a plane)
>  - default_rotation: Default rotation presented to the userspace, same va=
lues as
>    supported_rotations.
> +- supported_color_encodings: Available encodings for a plane, as a bitma=
sk:
> +  0x01 YCBCR_BT601, 0x02 YCBCR_BT709, 0x04 YCBCR_BT2020 (same values as =
those exposed
> +  by the COLOR_ENCODING property of a plane). If set, supported_color_ra=
nge
> +  must be set too.
> +- default_color_encoding: Default color encoding presented to the usersp=
ace, same
> +  values as supported_color_encodings

[Severity: Low]
Are the bitmask values 0x01, 0x02, and 0x04 the same values as those
exposed by the plane's COLOR_ENCODING property?

Unlike the rotation property (created with drm_property_create_bitmask()),
drm_plane_create_color_properties() creates COLOR_ENCODING with
drm_property_create_enum(), exposing enum drm_color_encoding values 0, 1,
and 2 rather than bitmasks 0x01, 0x02, and 0x04.

Also, the commit message refers to the attribute as
supported_color_encoding (singular), whereas CONFIGFS_ATTR(plane_,
supported_color_encodings) and the documentation define it as
supported_color_encodings (plural). (Note that the forward reference to
supported_color_range here is updated to supported_color_ranges in the
follow-up commit "drm/vkms: Introduce configfs for plane color range" later
in this series.)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D22
