Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BAACD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 17:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D66310E8F8;
	Mon, 18 May 2026 17:00:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=erik.faye-lund@collabora.com header.b="JnSvoJ9C";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8943510E8F8
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779123638; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nwIEEcNnvCqHRG7Zlberq4b49iMUB98UsNXc64+G2SRYdv9KPzMS/1fh0Cvf5iZaSSPbhXaO6ROOLMz5m5eqZOqehKaCaSjozgyUgoGYBTiRx2KC8mjCpygrhHEFjtrUB3GlD+aSLUppJap2FPjbuNizhax97W1pPCyIksmgR6E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779123638;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MUJVgD3wt3rpZgnMuB9GohXhZVF7pJOBTMiioHH6KnQ=; 
 b=axvh9q3xohGjm9oH+ZWx7yT1WFrpMGTunJqK/nDYadIJDp77VPNddAyYe5HTFHPuzXsRDv1zmjiUSt0uxqS8fu8/YYSb8jMbga1A/dg0psY0CHX8b/mSdC1MAsiAxBuYs6KnZfALvu2Fl4uf/LqOjTEt3+fc8L554FCk3RB52OM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=erik.faye-lund@collabora.com;
 dmarc=pass header.from=<erik.faye-lund@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779123638; 
 s=zohomail; d=collabora.com; i=erik.faye-lund@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=MUJVgD3wt3rpZgnMuB9GohXhZVF7pJOBTMiioHH6KnQ=;
 b=JnSvoJ9CUU9mlld2hgXDNMUSsNQjvPZIaYM1fGjHSgzRwT66x89/xiDM3G4SG5y1
 hme7+mIA7ALzc+6Z7VdYw1+pN0jpmY69ekgHYxnLcHfsybFJ1JPOq1dp1DADWt5u6gE
 ON09UXQn/I9jlNV9v+/77POOqXmz9A4/Jksjwukc=
Received: by mx.zohomail.com with SMTPS id 1779123634159351.91532934355405;
 Mon, 18 May 2026 10:00:34 -0700 (PDT)
Message-ID: <707cb1b4d1b1957951d50c27eaa920f2da849750.camel@collabora.com>
Subject: Re: [PATCH v6 7/7] drm/panthor: Expose the panthor perf ioctls
From: Erik Faye-Lund <erik.faye-lund@collabora.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>, Boris Brezillon	
 <boris.brezillon@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>,
 =?ISO-8859-1?Q?Adri=E1n?= Larumbe	 <adrian.larumbe@collabora.com>
Cc: nd@arm.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,  Mihail Atanassov <mihail.atanassov@arm.com>
Date: Mon, 18 May 2026 19:00:28 +0200
In-Reply-To: <20251215171453.2506348-8-lukas.zapolskas@arm.com>
References: <20251215171453.2506348-1-lukas.zapolskas@arm.com>
 <20251215171453.2506348-8-lukas.zapolskas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
MIME-Version: 1.0
X-ZohoMailClient: External
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, 2025-12-15 at 17:14 +0000, Lukas Zapolskas wrote:
> This patch implements the PANTHOR_PERF_CONTROL ioctl series, and
> a PANTHOR_GET_UOBJ wrapper to deal with the backwards and forwards
> compatibility of the uAPI.
>=20
> The minor version is bumped to indicate that the feature is now
> supported.
>=20
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
> Reviewed-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
> =C2=A0drivers/gpu/drm/panthor/panthor_drv.c | 141
> +++++++++++++++++++++++++-
> =C2=A01 file changed, 139 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c
> b/drivers/gpu/drm/panthor/panthor_drv.c
> index f9e01c42d237..276c87985422 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -33,6 +33,7 @@
> =C2=A0#include "panthor_gpu.h"
> =C2=A0#include "panthor_heap.h"
> =C2=A0#include "panthor_mmu.h"
> +#include "panthor_perf.h"
> =C2=A0#include "panthor_regs.h"
> =C2=A0#include "panthor_sched.h"
> =C2=A0
> @@ -75,6 +76,39 @@ panthor_set_uobj(u64 usr_ptr, u32 usr_size, u32
> min_size, u32 kern_size, const v
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * panthor_get_uobj() - Copy user object to kernel object.
> + * @usr_ptr: Users pointer.
> + * @usr_size: Size of the user object.
> + * @min_size: Minimum size for this object.
> + *
> + * Helper automating user -> kernel object copies.
> + *
> + * Don't use this function directly, use PANTHOR_UOBJ_GET() instead.
> + *
> + * Return: valid pointer on success, an encoded error code
> otherwise.
> + */
> +static void*
> +panthor_get_uobj(u64 usr_ptr, u32 usr_size, u32 min_size, u32
> kern_size)
> +{
> +	int ret;
> +	void *out_alloc __free(kvfree) =3D NULL;
> +
> +	/* User size shouldn't be smaller than the minimal object
> size. */
> +	if (usr_size < min_size)
> +		return ERR_PTR(-EINVAL);
> +
> +	out_alloc =3D kvmalloc(min_size, GFP_KERNEL);
> +	if (!out_alloc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D copy_struct_from_user(out_alloc, min_size,
> u64_to_user_ptr(usr_ptr), usr_size);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return_ptr(out_alloc);
> +}
> +
> =C2=A0/**
> =C2=A0 * panthor_get_uobj_array() - Copy a user object array into a kerne=
l
> accessible object array.
> =C2=A0 * @in: The object array to copy.
> @@ -179,7 +213,11 @@ panthor_get_uobj_array(const struct
> drm_panthor_obj_array *in, u32 min_stride,
> =C2=A0		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create,
> ringbuf_size), \
> =C2=A0		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op,
> syncs), \
> =C2=A0		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op,
> size), \
> -		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info,
> shader_blocks))
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info,
> shader_blocks), \
> +		 PANTHOR_UOBJ_DECL(struct
> drm_panthor_perf_cmd_setup, shader_enable_mask), \
> +		 PANTHOR_UOBJ_DECL(struct
> drm_panthor_perf_cmd_start, user_data), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_cmd_stop,
> user_data), \
> +		 PANTHOR_UOBJ_DECL(struct
> drm_panthor_perf_cmd_sample, user_data))
> =C2=A0
> =C2=A0/**
> =C2=A0 * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
> @@ -194,6 +232,25 @@ panthor_get_uobj_array(const struct
> drm_panthor_obj_array *in, u32 min_stride,
> =C2=A0			 PANTHOR_UOBJ_MIN_SIZE(_src_obj), \
> =C2=A0			 sizeof(_src_obj), &(_src_obj))
> =C2=A0
> +/**
> + * PANTHOR_UOBJ_GET() - Copies a user object from _usr_ptr to a
> kernel accessible _dest_ptr.
> + * @_dest_ptr: Local variable
> + * @_usr_size: Size of the user object.
> + * @_usr_ptr: The pointer of the object in userspace.
> + *
> + * Return: Error code. See panthor_get_uobj().
> + */
> +#define PANTHOR_UOBJ_GET(_dest_ptr, _usr_size, _usr_ptr) \
> +	({ \
> +		typeof(_dest_ptr) _tmp; \
> +		_tmp =3D panthor_get_uobj(_usr_ptr, _usr_size, \
> +				PANTHOR_UOBJ_MIN_SIZE(_tmp[0]), \
> +				sizeof(_tmp[0])); \
> +		if (!IS_ERR(_tmp)) \
> +			_dest_ptr =3D _tmp; \
> +		PTR_ERR_OR_ZERO(_tmp); \
> +	})
> +
> =C2=A0/**
> =C2=A0 * PANTHOR_UOBJ_GET_ARRAY() - Copy a user object array to a kernel
> accessible
> =C2=A0 * object array.
> @@ -1470,6 +1527,83 @@ static int panthor_ioctl_bo_query_info(struct
> drm_device *ddev, void *data,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +#define perf_cmd(command) \
> +	({ \
> +		struct drm_panthor_perf_cmd_##command
> *command##_args __free(kvfree) =3D NULL; \
> +		int _ret =3D PANTHOR_UOBJ_GET(command##_args, args-
> >size, args->pointer); \
> +		if (_ret) \
> +			return _ret; \
> +		return panthor_perf_session_##command(pfile, ptdev-
> >perf, args->handle, \
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> command##_args->user_data); \
> +	})
> +
> +static int panthor_ioctl_perf_control(struct drm_device *ddev, void
> *data,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_file *file)
> +{
> +	struct panthor_device *ptdev =3D container_of(ddev, struct
> panthor_device, base);
> +	struct panthor_file *pfile =3D file->driver_priv;
> +	struct drm_panthor_perf_control *args =3D data;
> +	int ret;
> +
> +	if (!args->pointer) {
> +		switch (args->cmd) {
> +		case DRM_PANTHOR_PERF_COMMAND_SETUP:
> +			args->size =3D sizeof(struct
> drm_panthor_perf_cmd_setup);
> +			return 0;
> +
> +		case DRM_PANTHOR_PERF_COMMAND_TEARDOWN:
> +			args->size =3D 0;
> +			return 0;
> +
> +		case DRM_PANTHOR_PERF_COMMAND_START:
> +			args->size =3D sizeof(struct
> drm_panthor_perf_cmd_start);
> +			return 0;
> +
> +		case DRM_PANTHOR_PERF_COMMAND_STOP:
> +			args->size =3D sizeof(struct
> drm_panthor_perf_cmd_stop);
> +			return 0;
> +
> +		case DRM_PANTHOR_PERF_COMMAND_SAMPLE:
> +			args->size =3D sizeof(struct
> drm_panthor_perf_cmd_sample);
> +			return 0;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	switch (args->cmd) {
> +	case DRM_PANTHOR_PERF_COMMAND_SETUP:
> +	{
> +		struct drm_panthor_perf_cmd_setup *setup_args
> __free(kvfree) =3D NULL;
> +
> +		ret =3D PANTHOR_UOBJ_GET(setup_args, args->size, args-
> >pointer);
> +		if (ret)
> +			return -EINVAL;
> +
> +		return panthor_perf_session_setup(file, ptdev->perf,
> setup_args);
> +	}
> +	case DRM_PANTHOR_PERF_COMMAND_TEARDOWN:
> +	{
> +		return panthor_perf_session_teardown(pfile, ptdev-
> >perf, args->handle);
> +	}
> +	case DRM_PANTHOR_PERF_COMMAND_START:
> +	{
> +		perf_cmd(start);
> +	}
> +	case DRM_PANTHOR_PERF_COMMAND_STOP:
> +	{
> +		perf_cmd(stop);
> +	}
> +	case DRM_PANTHOR_PERF_COMMAND_SAMPLE:
> +	{
> +		perf_cmd(sample);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

These IOCTLs needs to be privileged to avoid data leaks across
applications, according to the HW docs. So we should probably check for
CAP_PERFMON somehow. This probably means validating using
perfmon_capable() and returning -EACCES if not. That seems to be what
i915 and XE does.


> =C2=A0static int
> =C2=A0panthor_open(struct drm_device *ddev, struct drm_file *file)
> =C2=A0{
> @@ -1546,6 +1680,7 @@ static const struct drm_ioctl_desc
> panthor_drm_driver_ioctls[] =3D {
> =C2=A0	PANTHOR_IOCTL(SET_USER_MMIO_OFFSET, set_user_mmio_offset,
> DRM_RENDER_ALLOW),
> =C2=A0	PANTHOR_IOCTL(BO_SYNC, bo_sync, DRM_RENDER_ALLOW),
> =C2=A0	PANTHOR_IOCTL(BO_QUERY_INFO, bo_query_info,
> DRM_RENDER_ALLOW),
> +	PANTHOR_IOCTL(PERF_CONTROL, perf_control, DRM_RENDER_ALLOW),
> =C2=A0};
> =C2=A0
> =C2=A0static int panthor_mmap(struct file *filp, struct vm_area_struct
> *vma)
> @@ -1686,6 +1821,8 @@ static void panthor_debugfs_init(struct
> drm_minor *minor)
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adds DRM_IOCTL_PANTHOR_BO_=
SYNC ioctl
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adds DRM_IOCTL_PANTHOR_BO_=
QUERY_INFO ioctl
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adds drm_panthor_gpu_info:=
:selected_coherency
> + * - 1.8 - adds DEV_QUERY_PERF_INFO query
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adds PERF_CONTROL ioctl
> =C2=A0 */
> =C2=A0static const struct drm_driver panthor_drm_driver =3D {
> =C2=A0	.driver_features =3D DRIVER_RENDER | DRIVER_GEM |
> DRIVER_SYNCOBJ |
> @@ -1699,7 +1836,7 @@ static const struct drm_driver
> panthor_drm_driver =3D {
> =C2=A0	.name =3D "panthor",
> =C2=A0	.desc =3D "Panthor DRM driver",
> =C2=A0	.major =3D 1,
> -	.minor =3D 7,
> +	.minor =3D 8,
> =C2=A0
> =C2=A0	.gem_create_object =3D panthor_gem_create_object,
> =C2=A0	.gem_prime_import_sg_table =3D
> drm_gem_shmem_prime_import_sg_table,
