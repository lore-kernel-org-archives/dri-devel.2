Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D825DC5CFC1
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 06:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBA910E14C;
	Sat, 15 Aug 2026 06:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kc7bBCGk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09DD010E14C
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 06:26:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B71E440364;
 Sat, 15 Aug 2026 06:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5E61F000E9;
 Sat, 15 Aug 2026 06:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786775218;
 bh=aq6EEPqfTqobGMx1R7VVc70emSkwCFSpVavBeJPjkxE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kc7bBCGkl3p3/dj9vHXiKyltfIuwSWqRYeBnxnoSBvST0IEw9HbgyYvsihg1zN9n8
 Ov2CDlAwwiCAupvYwWNpWBR/Vp2itdLfys9BiXXrE8FXXqPz/oYKiqT5YTWYq1+OSn
 nfcyqxt88Iai8RJKKB7jX5dd4VcO080JEVcQefJ33sIxbalHPHqvS/IKF5YtvcKlab
 gHofLV8FnOfUu19th+SCJoqSAIp/t8+04A6cAN6+OWRwaGH0lUK42rP8HiKrXVqZth
 polDHKFwmuBv6VgRtc/Q5t00IXMJpfcItwzuiNb0tPdk7rxrBU7FAk+g3PKPDIQoLL
 91HsAFfd4fEHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: fix object leak when
 drm_gem_handle_create() fails
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260815-virtgpu-gem-create-leak-v1-1-a4e9fb18caa3@outlook.com>
References: <20260815-virtgpu-gem-create-leak-v1-1-a4e9fb18caa3@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 06:26:57 +0000
Message-Id: <20260815062658.6F5E61F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The patch fixes an object leak when drm_gem_handle_create() fails,=
 but misses identical preexisting leaks in virtio_gpu_resource_create_ioctl=
() and virtio_gpu_resource_create_blob_ioctl().
- [High] Missing cleanup of GEM object internals and fake mmap offset on er=
ror paths in virtio_gpu_vram_create().
--

--- Patch [1]: [PATCH] drm/virtio: fix object leak when drm_gem_handle_crea=
te() fails ---
commit f5c2e8ad38dcc08de3708efd9e20d6ef52e2a1e8
Author: Junrui Luo <moonafterrain@outlook.com>

drm/virtio: fix object leak when drm_gem_handle_create() fails

virtio_gpu_gem_create() owns the reference taken by
virtio_gpu_object_create(). On the drm_gem_handle_create() error path it
calls drm_gem_object_release() instead of dropping that reference.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virti=
o/virtgpu_gem.c
> index 66c3f6f74e9c6..d2f0b8a3f172b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -45,7 +45,7 @@ static int virtio_gpu_gem_create(struct drm_file *file,
> =20
>  	ret =3D drm_gem_handle_create(file, &obj->base.base, &handle);
>  	if (ret) {
> -		drm_gem_object_release(&obj->base.base);
> +		drm_gem_object_put(&obj->base.base);
>  		return ret;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but there are other locations wi=
th
this exact same pattern. Does virtio_gpu_resource_create_ioctl() also leak =
the
object when drm_gem_handle_create() fails?

drivers/gpu/drm/virtio/virtgpu_ioctl.c:virtio_gpu_resource_create_ioctl() {
    ...
    ret =3D drm_gem_handle_create(file_priv, obj, &handle);
    if (ret) {
        drm_gem_object_release(obj);
        return ret;
    }
    ...
}

Similar leaks appear to be present in virtio_gpu_resource_create_blob_ioctl=
()
where drm_gem_object_release() is called instead of drm_gem_object_put() on
multiple error paths. Should those be updated to use drm_gem_object_put()
as well to ensure the free hooks are properly executed?

[Severity: High]
This is a pre-existing issue, but might we be missing cleanup of GEM intern=
als
and the mmap offset on error paths in virtio_gpu_vram_create()?

drivers/gpu/drm/virtio/virtgpu_vram.c:virtio_gpu_vram_create() {
    ...
    ret =3D drm_gem_create_mmap_offset(&vram->base.base.base);
    if (ret) {
        kfree(vram);
        return ret;
    }

    ret =3D virtio_gpu_resource_id_get(vgdev, &vram->base.hw_res_handle);
    if (ret) {
        kfree(vram);
        return ret;
    }
    ...
}

If virtio_gpu_resource_id_get() fails, drm_gem_create_mmap_offset() has
already added the fake offset to the DRM VMA offset manager's interval tree.
Would calling kfree(vram) here leave a dangling pointer in the interval tre=
e,
potentially causing a use-after-free or tree corruption upon subsequent
accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-virtgpu-ge=
m-create-leak-v1-1-a4e9fb18caa3@outlook.com?part=3D1
