Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C0D606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tjf0MioX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61913112387;
	Thu, 26 Nov 2026 11:46:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF48112380
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:46:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C21E46336F;
 Thu, 26 Nov 2026 11:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CCB1F000C4;
 Thu, 26 Nov 2026 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693594;
 bh=hZ0v3gAsIKn9hZvfHGWOjaj0NhjhKZlFd84u15EAS0U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tjf0MioXRRNQ7+3NxQ4v2h7kMoFt4G9SYGajfJNz8b3o2I9zHzchNZa8mvayuFr5v
 yUIOq631ZvKojYZWhZd4B8Bgq/xYNdKWb9H6o79EreMLWpY6JhHBq6TTqjnsZhsMI5
 nqR0eNBR6mCxdi5ZYZwxMrd94zNwdl70l5/qqpk3ie0+WGr/z9cZrWOp76oJdA1hg1
 YmT+Z/rggYAjFVX7SZGoh0VK1lp5qx+Fw2R3YmwCWCk3+57SrwmzC53h/mbdx0Krcg
 5zibNPLw1L6a6nXoU+xOA+lyXkuXRw8J58/8gQjtwmiVwtb6AjGHublSqB5VE2E6Pk
 gUJ93NhR4to3A==
Message-ID: <sashiko-outbox-235417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 19/43] drm/vkms: Introduce config for plane rotation
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-19-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-19-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:46:34 +0000
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
- [Low] drm/vkms: kernel-doc mismatch for supported_rotations in
  vkms_config_plane
--

commit 870fc41a500e6a65ad8b80b4adbcbf45c3cc0ac6
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for plane rotation

This commit adds configuration helpers and validation for per-plane
default and supported rotations in VKMS.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vk=
ms_config.h
> index e428946cb70ea..8587a4a28b199 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -54,6 +54,8 @@ struct vkms_config {
>   * @type: Type of the plane. The creator of configuration needs to ensur=
es that
>   *        at least one primary plane is present.
>   * @possible_crtcs: Array of CRTCs that can be used with this plane
> + * @default_rotation: Default rotation that should be used by this plane
> + * @supported_rotation: Rotation that this plane will support
>   * @plane: Internal usage. This pointer should never be considered as va=
lid.
>   *         It can be used to store a temporary reference to a VKMS plane=
 during
>   *         device creation. This pointer is not managed by the configura=
tion and
> @@ -66,6 +68,8 @@ struct vkms_config_plane {
> =20
>  	const char *name;
>  	enum drm_plane_type type;
> +	unsigned int default_rotation;
> +	unsigned int supported_rotations;

[Severity: Low]
The kernel-doc tag uses @supported_rotation (singular) while the struct
member is named supported_rotations (plural), which causes
scripts/kernel-doc to warn about an excess description and an undescribed
member.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D19
