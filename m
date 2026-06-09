Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1480ECD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D0B10E5B8;
	Tue,  9 Jun 2026 18:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fcr0YDON";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1463910E5B8
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 18:15:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A8FA60258;
 Tue,  9 Jun 2026 18:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10FE1F00893;
 Tue,  9 Jun 2026 18:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781028957;
 bh=lq2wOe5YaVsnXk1gVRrq0vh6aTybgk4er2UTgsc+CP0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fcr0YDON+ApI81bLbGMGW50SdA6OTC2PWs7UsQ4Ya4olbEQp3fhlviUlVKwoUrHI/
 8Vq4gaBuWsZyRPZgBYo60/D858KM8i30YW3txl9ma+MNhoPPKbrDvksjDZDePRIUhE
 ZsB2eR6dQlXqnt359F1fAkAP711gYUnLYJ5dk1azs5Lu9B2uziZ4diSKL4GKRyMBf0
 m9LIz6LU3D+UHZgv9b6A7OZQCE0EU1uhrFz9jx60SQ9ucGnb+DbHeBp8MEFyQjDYOk
 DW+zOdZp75559Cl6gUKbCn4n4iibSQD4XNeyl0mjQOL1aAaFmIkQ2SGUXpm3w0jyS7
 acQxADENteMcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: Use common error handling code in two
 functions
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <b7440806-e9e8-4027-afe1-f6fe9297d8b2@web.de>
References: <b7440806-e9e8-4027-afe1-f6fe9297d8b2@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:15:56 +0000
Message-Id: <20260609181556.F10FE1F00893@smtp.kernel.org>
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

New issues:
- [Low] The `goto` label `free_sgt` is placed deep inside a nested loop and=
 `if` block, resulting in extremely fragile coding style.

Pre-existing issues:
- [High] The error path in `virtio_gpu_vram_create()` frees the `vram` stru=
cture without cleaning up the initialized GEM object and its VMA mmap offse=
t node, leading to a Use-After-Free vulnerability.
--

commit d55fcccd5068c0cdf30a34bda57a95d944db1027
Author: Markus Elfring <elfring@users.sourceforge.net>

drm/virtio: Use common error handling code in two functions

Use additional labels so that a bit of exception handling can be better
reused at the end of two function implementations.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -318,15 +318,14 @@ static struct sg_table *vmalloc_to_sgt(char *data, =
uint32_t size, int *sg_ents)
> =20
>  	*sg_ents =3D DIV_ROUND_UP(size, PAGE_SIZE);
>  	ret =3D sg_alloc_table(sgt, *sg_ents, GFP_KERNEL);
> -	if (ret) {
> -		kfree(sgt);
> -		return NULL;
> -	}
> +	if (ret)
> +		goto free_sgt;
> =20
>  	for_each_sgtable_sg(sgt, sg, i) {
>  		pg =3D vmalloc_to_page(data);
>  		if (!pg) {
>  			sg_free_table(sgt);
> +free_sgt:

[Severity: Low]
Is it safe to jump into the middle of a loop and an if block like this?

Jumping from the outer function scope directly into an inner loop and
conditional block violates structured programming principles. Would it be
better to avoid placing this label here, as it seems extremely fragile for
future modifications?

[ ... ]

> diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virt=
io/virtgpu_vram.c
> --- a/drivers/gpu/drm/virtio/virtgpu_vram.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
> @@ -212,16 +212,12 @@ int virtio_gpu_vram_create(struct virtio_gpu_device=
 *vgdev,
> =20
>  	/* Create fake offset */
>  	ret =3D drm_gem_create_mmap_offset(obj);
> -	if (ret) {
> -		kfree(vram);
> -		return ret;
> -	}
> +	if (ret)
> +		goto free_vram;
> =20
>  	ret =3D virtio_gpu_resource_id_get(vgdev, &vram->base.hw_res_handle);
> -	if (ret) {
> -		kfree(vram);
> -		return ret;
> -	}
> +	if (ret)
> +		goto free_vram;

[ ... ]

> @@ -237,6 +233,10 @@ int virtio_gpu_vram_create(struct virtio_gpu_device =
*vgdev,
> =20
>  	*bo_ptr =3D &vram->base;
>  	return 0;
> +
> +free_vram:
> +	kfree(vram);
> +	return ret;

[Severity: High]
This is a pre-existing issue, but does this error path leave the vma_node in
the interval tree and cause a use-after-free?

If drm_gem_create_mmap_offset() succeeds, it inserts the object's embedded
vma_node into the DRM device's vma_offset_manager interval tree.

If virtio_gpu_resource_id_get() then fails, we jump to free_vram and execute
kfree(vram). Because we skip calling drm_gem_object_release() or
drm_gem_free_mmap_offset(), the freed vma_node is left linked in the drm_mm
interval tree.

When the offset manager is next accessed, won't it traverse the tree and
access the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/b7440806-e9e8-4027-=
afe1-f6fe9297d8b2@web.de?part=3D1
