Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B37CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF13B10F0FA;
	Mon, 12 Oct 2026 13:15:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB7FC10F0F5
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:15:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E76560229;
 Mon, 12 Oct 2026 13:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E711F0089B;
 Mon, 12 Oct 2026 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810949;
 bh=yTzr4poJBam+aNGKWH/hESAGvMrMQ86ZNTXEPtIxop4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cePH/a+AI1QxuQJNpVjWQLPPeH9UqWZTalnu/HmAsqqi5dpKzjV3gjMqsY5r8m/tB
 ix8AvRsF+/XhcuLar8JyCl8AlD3JM+Uh2iYyt9MlHRdXuGjf3sL5MCeHX2K/sr+i0+
 IFhLSO/VftQhBeoFfQz7xNirxD+3m/85USJLgJCtyaiBYeiKPLB0afW5uswINq/vrF
 EJPiZ19NtpKfbJbjFndn8oUhJl1W0j0Hz7YmINBXTsId8Q1+eGB1aQAwdpZ3MlLHav
 sTQ8l3wlMkbPQlhJkV+MoiM6iVs6KVyiCLM+4shUcEgHOQnhjyex5DXiStBBDhv6Zt
 uKveNdHBDbFNQ==
Message-ID: <sashiko-outbox-168155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/12] drm/panthor: Protm support for groups
To: "Ketil Johnsen" <ketil.johnsen@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012125940.3291951-12-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-12-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:15:49 +0000
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
- [High] drm/panthor: missing validation of protected memory for PROTM susp=
end buffers
- [Low] drm: dead macro GROUP_CREATE_FLAGS referencing undefined identifier
--

commit a26512a2f35a2a18c407c42a57bf8210da106e39
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Protm support for groups

This commit extends struct drm_panthor_group_create to allow a user-provided
protm suspend buffer. It imports the user-supplied suspend buffer and allows
the PROT_REGION instruction for groups that provide it. It also stores the
suspend buffer sizes provided by the FW.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 13c12a24e2f45..bfdabd7ee7beb 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c

[ ... ]

> @@ -4074,6 +4079,7 @@ static void add_group_kbo_sizes(struct panthor_devi=
ce *ptdev,
>  }
> =20
>  #define MAX_GROUPS_PER_POOL		128
> +#define GROUP_CREATE_FLAGS DRM_PANTHOR_GROUP_CREATE_PROTECTED

[Severity: Low]
Is this macro needed? The identifier DRM_PANTHOR_GROUP_CREATE_PROTECTED is =
not
defined anywhere in the codebase, and GROUP_CREATE_FLAGS is never used.=20

While it has no runtime effect, it is a compilation hazard if the macro is =
ever
evaluated and constitutes dead code.

> =20
>  int panthor_group_create(struct drm_file *file,
>  			 const struct drm_panthor_group_create *group_args,

[ ... ]

> @@ -4136,14 +4138,51 @@ int panthor_group_create(struct drm_file *file,
>  		goto err_put_group;
>  	}
> =20
> -	suspend_size =3D csg_iface->control->suspend_size;
> -	group->suspend_buf =3D panthor_fw_alloc_suspend_buf_mem(ptdev, suspend_=
size);
> +	group->suspend_buf =3D panthor_fw_alloc_suspend_buf_mem(
> +		ptdev, panthor_fw_suspend_size(ptdev));
>  	if (IS_ERR(group->suspend_buf)) {
>  		ret =3D PTR_ERR(group->suspend_buf);
>  		group->suspend_buf =3D NULL;
>  		goto err_put_group;
>  	}
> =20
> +	if (group_args->protected_suspend_bo_handle) {
> +		struct drm_gem_object *obj;
> +
> +		/* Read a correct snapshot of the state */
> +		if (!(smp_load_acquire(&ptdev->protm.info.state) &
> +		      DRM_PANTHOR_PROTM_INITIALIZED)) {
> +			ret =3D -EINVAL;
> +			goto err_put_group;
> +		}
> +
> +		obj =3D drm_gem_object_lookup(
> +			file, group_args->protected_suspend_bo_handle);
> +		if (!obj) {
> +			ret =3D -ENOENT;
> +			goto err_put_group;
> +		}
> +
> +		if (obj->size <
> +		    ptdev->protm.info.group_protected_suspend_buf_size) {
> +			drm_gem_object_put(obj);
> +			ret =3D -EINVAL;
> +			goto err_put_group;
> +		}
> +
> +		group->protm_suspend_buf =3D panthor_kernel_bo_create_from_gem(
> +			ptdev, panthor_fw_vm(ptdev), to_panthor_bo(obj),
> +			DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
> +			PANTHOR_VM_KERNEL_AUTO_VA,
> +			panthor_fw_protm_suspend_size(ptdev));

[Severity: High]
Does this code map the user-provided BO into the firmware VM without valida=
ting
that it actually corresponds to a protected DMA-BUF heap?

The uAPI comments state this BO must be allocated from a protected DMA-BUF
heap, but there doesn't appear to be any verification of its security prope=
rties
or whether it's actually backed by protected memory.

If the Mali firmware writes protected state into this suspend buffer during
context switches, could a malicious userspace application supply a standard
shmem-backed BO to read the protected state from normal RAM?

Even if the GPU hardware traps non-secure accesses to secure physical addre=
sses,
should the kernel verify the user-provided memory handle is actually secure
before using it for firmware structures?

(Note that a similar missing validation seems to exist for the firmware
protected sections initialization in panthor_fw_protm_init(), though that p=
ath
is protected by CAP_SYS_MODULE).

> +		drm_gem_object_put(obj);
> +		if (IS_ERR(group->protm_suspend_buf)) {
> +			ret =3D PTR_ERR(group->protm_suspend_buf);
> +			group->protm_suspend_buf =3D NULL;
> +			goto err_put_group;
> +		}
> +	}
> +
>  	group->syncobjs =3D panthor_kernel_bo_create(ptdev, group->vm,
>  						   group_args->queues.count *
>  						   sizeof(struct panthor_syncobj_64b),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012125940.3291=
951-1-ketil.johnsen@arm.com?part=3D11
