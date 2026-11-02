Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5EA606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3ihBCSW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06BE210ECBB;
	Mon,  2 Nov 2026 10:29:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9A610ECB0;
 Mon,  2 Nov 2026 10:29:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A99F402DE;
 Mon,  2 Nov 2026 10:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36F31F000C1;
 Mon,  2 Nov 2026 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793615363;
 bh=L4XzLe+lfUxoKU7lTbmFR0JxOGLXCO2Cdx82oUei9sY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D3ihBCSWqWwP1rkXOWT//Hx9yxRmAu3hj7bDD6AKgOi8biNGFeYfSw2z2L08hnITp
 r9kSQteKPzFl12PMQUwo5+lsksva9rLZfjGPmf9/8sp0HBhvKIJat2zeS6VTDsZHOo
 /mBdcXeE/J73R0abCY5ZbAel8DRRafjbxK0wW63UN2KDWA58MUVjQphjBgyM5VJ/qf
 W+x1bmpAhRkk/ZNyvloYUEHeuCN0mHbMOcXP8q542rCqwidbe7m6wtdF6Eu4muG6r2
 F/kSYcTnQFCTkgKEcek4roBHx5vYGtOjDsdYCtKLeDkcGdWVebHAzYyqwtA0nBC+yY
 blxjQt9u1VL/g==
Message-ID: <sashiko-outbox-193260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 7/7] drm/xe/uapi: Wire up GEM_CREATE NUMA node placement
 handler
To: "Himal Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261102101803.455921-16-himal.prasad.ghimiray@intel.com>
References: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
 <20261102101803.455921-16-himal.prasad.ghimiray@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 10:29:23 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/xe: UAPI mismatch for VRAM-only BOs in gem_create_parse_numa=
_node()
- [Low] drm/xe: missing numa_node kernel-doc in xe_bo_init_locked()
--

commit 4dfdcc93fc9d778a45958834231a36c288d379fc
Author: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

drm/xe/uapi: Wire up GEM_CREATE NUMA node placement handler

This commit parses the DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE user
extension prior to BO creation in xe_gem_create_ioctl() and passes the
requested NUMA node ID down through the BO creation helpers to store on
the xe_bo.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index fc9bfb436b8e7..bbbc337372641 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -2480,7 +2480,7 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *x=
e, struct xe_bo *bo,
>  				struct ttm_lru_bulk_move *bulk, size_t size,
>  				u16 cpu_caching, enum ttm_bo_type type,
>  				u32 flags, struct dma_buf *dma_buf,
> -				struct drm_exec *exec)
> +				int numa_node, struct drm_exec *exec)
>  {

[ ... ]

> @@ -2966,7 +2967,8 @@ static void xe_bo_debug_mixed_mode_cur_index_advanc=
e(struct xe_device *xe,
>  struct xe_bo *xe_bo_create_user(struct xe_device *xe,
>  				struct xe_vm *vm, size_t size,
>  				u16 cpu_caching,
> -				u32 flags, struct drm_exec *exec)
> +				u32 flags, int numa_node,
> +				struct drm_exec *exec)
>  {

[Severity: Low]
This isn't a bug, but both xe_bo_init_locked() and xe_bo_create_user() have
kernel-doc comment blocks immediately above their definitions. Should
@numa_node be added to both kernel-doc blocks to avoid W=3D1 kernel-doc
warnings for undescribed function parameters?

[ ... ]

> @@ -3658,6 +3666,56 @@ static int gem_create_user_extensions(struct xe_de=
vice *xe, struct xe_bo *bo,
>  	return 0;
>  }
> =20
> +/*
> + * Parse a host NUMA node request from the extension chain. The node mus=
t be
> + * known before the BO is created, because the backing pages are allocat=
ed
> + * during creation. Returns the requested node in @numa_node (NUMA_NO_NO=
DE if
> + * none or a negative value is given) or a negative errno on an invalid =
request.
> + */
> +static int gem_create_parse_numa_node(struct xe_device *xe, u64 extensio=
ns,
> +				      u32 bo_flags, int *numa_node)
> +{
> +	struct drm_xe_user_extension base;
> +	struct drm_xe_ext_set_property ext;
> +	unsigned int i =3D 0;
> +
> +	*numa_node =3D NUMA_NO_NODE;
> +
> +	while (extensions && i++ < MAX_USER_EXTENSIONS) {
> +		u64 __user *address =3D u64_to_user_ptr(extensions);
> +		s64 nid;
> +
> +		if (XE_IOCTL_DBG(xe, copy_from_user(&base, address, sizeof(base))))
> +			return -EFAULT;
> +
> +		if (base.name !=3D DRM_XE_GEM_CREATE_EXTENSION_SET_PROPERTY)
> +			goto next;
> +
> +		if (XE_IOCTL_DBG(xe, copy_from_user(&ext, address, sizeof(ext))))
> +			return -EFAULT;
> +
> +		if (ext.property !=3D DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE)
> +			goto next;
> +
> +		nid =3D (s64)ext.value;
> +		*numa_node =3D NUMA_NO_NODE;
> +		if (nid < 0)
> +			goto next;
> +
> +		if (XE_IOCTL_DBG(xe, nid >=3D MAX_NUMNODES || !node_online(nid)))
> +			return -EINVAL;
> +
> +		if (XE_IOCTL_DBG(xe, !(bo_flags & XE_BO_FLAG_SYSTEM)))
> +			return -EINVAL;
> +
> +		*numa_node =3D nid;
> +next:
> +		extensions =3D base.next_extension;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Does rejecting !(bo_flags & XE_BO_FLAG_SYSTEM) with -EINVAL in
xe_gem_create_ioctl() -> gem_create_parse_numa_node() match the UAPI
contract in include/uapi/drm/xe_drm.h?

In struct drm_xe_gem_create, the comment for
DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE states:

	/*
	 * Host NUMA node (as a signed value) to allocate system-memory
	 * backing pages from. Only honored for objects with a system-memory
	 * placement; ignored for VRAM-only objects. Use a value < 0 to keep
	 * the default device-local placement.
	 */
#define   DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE	1

However, gem_create_parse_numa_node() returns -EINVAL when nid >=3D 0 and
!(bo_flags & XE_BO_FLAG_SYSTEM) instead of ignoring the property on
VRAM-only objects.

In addition, because nid < 0 jumps to next before reaching the
!(bo_flags & XE_BO_FLAG_SYSTEM) check, a VRAM-only BO with nid < 0 is
accepted while nid >=3D 0 fails with -EINVAL, and an extension chain on a
VRAM-only BO that sets nid >=3D 0 followed by a later extension resetting
nid =3D -1 will fail on the first extension.

Should the UAPI comment and gem_create_parse_numa_node() be aligned on
whether VRAM-only BOs ignore DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE or
reject it with -EINVAL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102101803.4559=
21-9-himal.prasad.ghimiray@intel.com?part=3D7
