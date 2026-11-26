Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC351606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPdwGhPm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C9910E99D;
	Thu, 26 Nov 2026 11:48:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FDF112380
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:48:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 25952618BE;
 Thu, 26 Nov 2026 11:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CBE1F000C6;
 Thu, 26 Nov 2026 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693728;
 bh=yleFajiKvV5Rg0bKjkaDqfdVeIyuRE1xYG4dpz492Vs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oPdwGhPm1a5lD2Fl6hoGRy/2UrIRScqv45drnRykQL3bGtYoI4vd22Uw7svLTvMr8
 78VbZL4N3sg+48wP3DxrnZMDbbGCo0SZ3IMQlv5FhQFXnJtazJ2iyQGo3BjR5jYPSY
 6r73H+ObtKj8ma8B8158uW3bZcPwW5xKhRfoEZSFtMeopVB98wYP2g0lmpyroMmZyq
 vjJY9XQC2X3g4l13LFKyRzDZs7bo8gmpnT7W+Y8SyOIJbh6yacHKo3sISyTsoMIh2E
 Qy+OtTV1aMsYfpGF5GDIv9tfUuh9khXgtZnpnj7fp8ZcbLj0tqB4MbhXVXZV8E5xAv
 bPXM/TCtmlvdA==
Message-ID: <sashiko-outbox-235422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 21/43] drm/vkms: Introduce config for plane color
 encoding
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-21-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-21-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:48:48 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/vkms: __nocfi indirect call to CFI function in
  show_bitfield()
- [Low] drm/vkms: shift-out-of-bounds in show_bitfield() loop condition
--

commit d7f3545cf9bb01180602070fd069bfa2db6fb425
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for plane color encoding

This commit adds configuration helpers, validation, debugfs reporting, and
KUnit tests to configure supported and default color encodings per VKMS
plane.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index d4f15f1c53b06..90cc28f3d3860 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -402,6 +424,22 @@ bool vkms_config_is_valid(const struct vkms_config *=
config)
>  }
>  EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
> =20
> +static __nocfi void show_bitfield(struct seq_file *m, uint32_t value, co=
nst char *callback(unsigned int))
> +{
> +	u32 offset =3D 0;
> +	bool first =3D true;
> +
> +	while (value >=3D BIT(offset) && offset < 32) {

[Severity: Low]
Does this loop condition evaluate BIT(offset) before checking offset < 32?
On 32-bit architectures, if bit 31 is set in value, offset reaches 32 and
BIT(32) shifts out of bounds; on 64-bit architectures, BIT(32) exceeds
any uint32_t value, making offset < 32 dead code.

> +		if (value & BIT(offset)) {
> +			if (!first)
> +				seq_puts(m, ",");
> +			seq_printf(m, "%s", callback(offset));
> +			first =3D false;
> +		}
> +		offset +=3D 1;
> +	}
> +}
> +
>  static int vkms_config_show(struct seq_file *m, void *data)
>  {
[ ... ]
> @@ -436,6 +474,12 @@ static int vkms_config_show(struct seq_file *m, void=
 *data)
>  				   DRM_ROTATION_FMT_ARGS(vkms_config_plane_get_supported_rotations(p=
lane_cfg)));
>  			seq_printf(m, "\tdefault rotation=3D" DRM_ROTATION_FMT "\n",
>  				   DRM_ROTATION_FMT_ARGS(vkms_config_plane_get_default_rotation(plan=
e_cfg)));
> +			seq_puts(m, "\tsupported color encoding=3D");
> +			show_bitfield(m, vkms_config_plane_get_supported_color_encodings(plan=
e_cfg),
> +				      drm_get_color_encoding_name);

[Severity: Medium]
Can calling drm_get_color_encoding_name() indirectly from the __nocfi
show_bitfield() helper fault under FineIBT?

drm_get_color_encoding_name() takes enum drm_color_encoding rather than
unsigned int, and marking show_bitfield() __nocfi suppresses the kCFI type
hash check on callback(offset).  On x86_64 with CONFIG_CFI_CLANG=3Dy, this
triggers an objtool "no-cfi indirect call!" warning at build time, and
under FineIBT at runtime cfi_rewrite_endbr() poisons the endbr64 at
drm_get_color_encoding_name+0 while skipping the uninstrumented __nocfi
call site, causing a #CP (Missing ENDBR) kernel fault when reading the
vkms_config debugfs file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D21
