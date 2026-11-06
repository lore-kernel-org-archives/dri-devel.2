Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDD606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkjuU6dL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2369810E19E;
	Fri,  6 Nov 2026 08:42:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B3E10E19E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 08:42:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E58C740B5B;
 Fri,  6 Nov 2026 08:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B111F0089F;
 Fri,  6 Nov 2026 08:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793954548;
 bh=H/eHTPOzEkZLLg3BwwxI5b5F0YG2J+rrTwxnytXIxj8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YkjuU6dLb3uLOFL1cIxthbZoNIYphwNCfZN8gSupsC9xHJkD8F7E3txvWAx3362SJ
 8VY8o08UcGxjLkv6p6OYcQJtcq3EXnVhMiHXeQ8opBoEmpVrV8poaaFVhFvJ/EqVd1
 wvhBjA0DbLbLe9vjs3duSsNRnpka+TSTKG7Vv08T8HdVCLtLqHYY6NetxiZ+wL9RL+
 H6j5odl27MwAkuMH197n66pFr+KYzCBOciNCLIM4GGe4cHKbA0/Uv2YeHUCNZxoRY8
 T7Mb9MwLoLc7Cqism/NutYn0qmIIeOG1s+DdZhkoR/2/OykGBtZ9T0k1zf3aJFdDTA
 5l0btlRTW2o2Q==
Message-ID: <sashiko-outbox-201084@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v10 4/4] drm/virtio: wire blob ioctl creation to
 userptr objects
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261106082625.812860-5-honghuan@amd.com>
References: <20261106082625.812860-1-honghuan@amd.com>
 <20261106082625.812860-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:42:28 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/virtio: unnotified ctrlq strands blob on handle creation
  failure
--

commit f8b823e6be2332eb525d4e0d0576cd0869cd03e1
Author: Honglei Huang <honghuan@amd.com>

drm/virtio: wire blob ioctl creation to userptr objects

This commit integrates userptr creation and read-only blob support into
the blob resource creation and getparam ioctls, and switches the error
paths in virtio_gpu_resource_create_blob_ioctl() from
drm_gem_object_release() to drm_gem_object_put().

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index 3d8e4ccdb7c1f..e57750588df01 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
[ ... ]
> @@ -557,14 +586,14 @@ static int virtio_gpu_resource_create_blob_ioctl(st=
ruct drm_device *dev,
>  	if (params.blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
>  		ret =3D virtio_gpu_resource_assign_uuid(vgdev, bo);
>  		if (ret) {
> -			drm_gem_object_release(obj);
> +			drm_gem_object_put(obj);
>  			return ret;
>  		}
>  	}
> =20
>  	ret =3D drm_gem_handle_create(file, obj, &handle);
>  	if (ret) {
> -		drm_gem_object_release(obj);
> +		drm_gem_object_put(obj);
>  		return ret;
>  	}

[Severity: Medium]
Can this leave obj stranded in vgdev->ctrlq when drm_gem_handle_create()
fails after virtio_gpu_resource_assign_uuid() succeeds?

Neither the blob creation helpers nor virtio_gpu_resource_assign_uuid()
call virtio_gpu_notify(vgdev); notification normally happens at the end
of virtio_gpu_gem_object_open() inside drm_gem_handle_create().  However,
virtio_gpu_resource_assign_uuid() takes an extra reference on obj via
virtio_gpu_array_add_obj() for the queued command buffer:

drivers/gpu/drm/virtio/virtgpu_prime.c:virtio_gpu_resource_assign_uuid() {
	objs =3D virtio_gpu_array_alloc(1);
	if (!objs)
		return -ENOMEM;

	virtio_gpu_array_add_obj(objs, &bo->base.base);

	return virtio_gpu_cmd_resource_assign_uuid(vgdev, objs);
}

If drm_gem_handle_create() fails before virtio_gpu_gem_object_open()
reaches virtio_gpu_notify(vgdev), drm_gem_object_put(obj) only drops
obj->refcount from 2 to 1.  Because the refcount does not reach 0,
obj->funcs->free() is not called, leaving the queued commands un-kicked
and keeping userptr pages pinned and charged to mm->pinned_vm until an
unrelated command notifies ctrlq.  Calling virtio_gpu_notify(vgdev) on
the drm_gem_handle_create() failure path would ensure the queued command
completes and drops its reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106082625.8128=
60-1-honghuan@amd.com?part=3D4
