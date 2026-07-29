Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CFDC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AAD10ECE9;
	Wed, 29 Jul 2026 16:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gKHXR7Xk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15FDC10ECE9
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:25:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E50B600AB;
 Wed, 29 Jul 2026 16:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C757B1F000E9;
 Wed, 29 Jul 2026 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785342314;
 bh=0J8QhZlEocSTr53fiIgAbUaq38TTh+jD/hVt6kslUDA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gKHXR7XkWHaNwvan49cWjyerm/1GlimYlQPJhtIB5ywlIrzTrBD7wedmWamff/41W
 SSU2aQ7ODtDTmF+//XSIqD9DU1Z5DnEsIZp4o8jnpHtAwxPwUns4ZK3/lXNbM68LDw
 k3WwnAW1wEj+Bge5jnhSaiduWVVKvqa5XswvthfGFv8JU/orAfn7Ek4sQAya7ZXpCF
 tyL2qGtcPd7ylFTjDbTQGLmQMvdiEM1szdbSs6eVC9VxNDHrdhfbzIY3VNU1M4pRJ2
 iVKHzS00li8ynvARu9HkXFD4OIRmr+RyqBTXbWSW29s6qiKm3z2+KuBElSeRw+M+aM
 cC9KmsU+Lee4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/17] drm/msm/gem: Set resv before exposing obj
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-13-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-13-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:25:14 +0000
Message-Id: <20260729162514.C757B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check for the return value of `msm_context_vm()` caus=
es a kernel panic when dereferencing the shared resv object.
--

--- Patch [12]: [PATCH v7 12/17] drm/msm/gem: Set resv before exposing obj =
---
commit 1309e8291ed5a0d77adef43c83bb315bbd37c9af
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Set resv before exposing obj

Don't swap the resv object _after_ exposing the newly created obj in LRU
or global objects list, as that creates a race condition where another
thread could lock the object using the original (per-obj) resv, but then
unlock after the resv is replaced.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 3c36b1c4a4d59..535c6e1acb3c1 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
[ ... ]
> @@ -1136,10 +1136,17 @@ int msm_gem_new_handle(struct drm_device *dev, st=
ruct drm_file *file,
>  		size_t size, uint32_t flags, uint32_t *handle,
>  		char *name)
>  {
> -	struct drm_gem_object *obj;
> +	struct drm_gem_object *obj, *r_obj =3D NULL;
>  	int ret;
> =20
> -	obj =3D msm_gem_new(dev, size, flags);
> +	if (flags & MSM_BO_NO_SHARE) {
> +		struct msm_context *ctx =3D file->driver_priv;
> +		struct drm_gpuvm *vm =3D msm_context_vm(dev, ctx);
> +
> +		r_obj =3D drm_gpuvm_resv_obj(vm);

[Severity: High]
This is a pre-existing issue, but does this code need a NULL check for vm
before dereferencing it to access the shared resv object?

If userspace passes the MSM_BO_NO_SHARE flag in a display-only configuration
where no GPU is attached, msm_context_vm() will return NULL. Passing that
NULL pointer into the drm_gpuvm_resv_obj() macro leads to an immediate kern=
el
panic.=20

Before this patch, the code directly dereferenced ctx->vm which would also =
be
NULL on display-only setups, so this problem wasn't introduced here but
remains present.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D12
