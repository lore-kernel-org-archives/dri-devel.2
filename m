Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D8606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmBlXe1n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187E410E1C0;
	Thu,  5 Nov 2026 13:35:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B8710E1C0
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 13:35:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC4596062F;
 Thu,  5 Nov 2026 13:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFF11F00919;
 Thu,  5 Nov 2026 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793885742;
 bh=6TLhmFBVvH82LHbE3vT9rrwU77eRf8gf/+kKgJEW+B0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KmBlXe1n6A+Yjth6ZuVUAVMbRwUvx7tqUP7BYS1maM+PuaIfwN1HZI8liMb3hIc9z
 P4bjLXjMvPr2hyK07ov67+GUHEurHDXHuT6JIo6fCLsGR0BZz4kyKbalaTx1rOmWo2
 zv2/YARstvsp8lzg+AldlCtKlLyjqcfkGdor/KS0zSZsZjiQZa9jYhK6ZSOW2Och+t
 Kt2rzZhd4Afkeqgsq8Or0t64KoOy4vA5m7wjcaqo3YEgaDgvdETwkwQXQ8AoJex3/n
 ToirZesYbEKNQ+mljGZamNLSmg3OIKfIo2lKsptAXQKozqz/jU4masaNCaxQlmV6iH
 7cAPTBXlsU/gQ==
Message-ID: <sashiko-outbox-199163@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: use drm_gem_ttm_dumb_map_offset() for
 dumb_map_offset
To: saad <primecoder8@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-amdgpu-dumb-map-offset-v1-1-7299d94ede11@gmail.com>
References: <20261105-amdgpu-dumb-map-offset-v1-1-7299d94ede11@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:35:41 +0000
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
- [Low] drm/amdgpu: amdgpu_mode_dumb_mmap() left non-static after callback =
removal
--

commit 20dcb7dcf18d16b07933bf4a8650d805f6e17934
Author: saad <primecoder8@gmail.com>

drm/amdgpu: use drm_gem_ttm_dumb_map_offset() for dumb_map_offset

This commit switches amdgpu_kms_driver and amdgpu_partition_driver from the
custom amdgpu_mode_dumb_mmap() callback to the generic TTM helper
drm_gem_ttm_dumb_map_offset() for .dumb_map_offset.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 731fe8f9e9228..134d2fe4beae8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
[ ... ]
> @@ -3177,7 +3178,7 @@ const struct drm_driver amdgpu_partition_driver =3D=
 {
>  	.ioctls =3D amdgpu_ioctls_kms,
>  	.num_ioctls =3D ARRAY_SIZE(amdgpu_ioctls_kms),
>  	.dumb_create =3D amdgpu_mode_dumb_create,
> -	.dumb_map_offset =3D amdgpu_mode_dumb_mmap,
> +	.dumb_map_offset =3D drm_gem_ttm_dumb_map_offset,

[Severity: Low]
This isn't a bug, but now that neither amdgpu_kms_driver nor
amdgpu_partition_driver in drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c uses
amdgpu_mode_dumb_mmap(), it has no callers outside
drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:

drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:
int amdgpu_mode_dumb_mmap(struct drm_file *filp,
			  struct drm_device *dev,
			  uint32_t handle, uint64_t *offset_p)
{
...
}

int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
			  struct drm_file *filp)
{
	union drm_amdgpu_gem_mmap *args =3D data;
	uint32_t handle =3D args->in.handle;

	memset(args, 0, sizeof(*args));
	return amdgpu_mode_dumb_mmap(filp, dev, handle, &args->out.addr_ptr);
}

Since amdgpu_gem_mmap_ioctl() is now the sole caller of
amdgpu_mode_dumb_mmap(), and the unused dev parameter and mode_dumb name on=
ly
existed for the .dumb_map_offset callback signature, should
amdgpu_mode_dumb_mmap() be folded directly into amdgpu_gem_mmap_ioctl() (or=
 at
least made static) and its prototype removed from
drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-amdgpu-dum=
b-map-offset-v1-1-7299d94ede11@gmail.com?part=3D1
