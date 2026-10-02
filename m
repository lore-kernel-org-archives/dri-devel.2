Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D217CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E539310E52B;
	Fri,  2 Oct 2026 09:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Az27+C14";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD77A10E579;
 Fri,  2 Oct 2026 09:14:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A14260A70;
 Fri,  2 Oct 2026 09:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABE31F00893;
 Fri,  2 Oct 2026 09:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790932464;
 bh=bOCsSpDsbRqW1FZraevF9iUzX3ugv2JxJo8iotLiqAM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Az27+C14GEeolAWhXyU1hUJpJ3umOHdwvE533qtEvuqXkuW2/UPXWNqStqLacxXjO
 y79YevFdRqofcyWDGugUe/QSxL6VDi4lS9y+hsx4SFa4nFY/nDbBP73fgmetSe46wZ
 MJyIE71YL2zBBTPWZ0sG6tfdAnuyZt8o3J2VONoGLwSOHw9FIaltYZO16GvErN0vu+
 WFPKmj7E9w8gcv4qPeSaYp7WOa1YhrbheAb046Pl9Izbw0zvJ/eywteFSvq/UgMdEM
 NWWZjlijPWZe241jOiIJom/ppFth3MK+yK8n6sEi/y8YeaSTXWAob72N4q6vZIh7WL
 R8QImWBzKeshA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/exec: track the first few locked objects inline
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261002003816.3233277-1-matthew.brost@intel.com>
References: <20261002003816.3233277-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:23 +0000
Message-Id: <20261002091424.BABE31F00893@smtp.kernel.org>
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
- [Medium] drm: memory waste in drm_exec due to unaligned kvmalloc size
--

commit c9e9f41b6b460bbc9dee72fd6820d00dc1915559
Author: Matthew Brost <matthew.brost@intel.com>

drm/exec: track the first few locked objects inline

This commit adds tracking for the first few locked objects inline within
the drm_exec structure. This avoids early allocations and prevents
-ENOMEM failures on paths that only need to lock a few objects.

Link: https://sashiko.dev/#/patchset/20261001220632.3190896-1-matthew.brost=
%40intel.com

> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
> --- a/drivers/gpu/drm/drm_exec.c
> +++ b/drivers/gpu/drm/drm_exec.c
[ ... ]
> @@ -140,9 +148,16 @@ static int drm_exec_obj_locked(struct drm_exec *exec,
>  {
>  	if (unlikely(exec->num_objects =3D=3D exec->max_objects)) {
>  		size_t size =3D exec->max_objects * sizeof(void *);
> -		void *tmp;
> -
> -		tmp =3D kvrealloc(exec->objects, size + PAGE_SIZE, GFP_KERNEL);
> +		struct drm_gem_object **tmp;
> +
> +		if (exec->objects =3D=3D exec->inline_objects) {
> +			tmp =3D kvmalloc(size + PAGE_SIZE, GFP_KERNEL);

[Severity: Medium]
When falling back from the inline storage, size is 64 bytes (8 pointers).
The code requests kvmalloc(64 + 4096), which is 4160 bytes. Does this
cause the slab allocator to round up to the kmalloc-8k cache, wasting
nearly half the allocation?

> +			if (tmp)
> +				memcpy(tmp, exec->objects, size);
> +		} else {
> +			tmp =3D kvrealloc(exec->objects, size + PAGE_SIZE,
> +					GFP_KERNEL);
> +		}
>  		if (!tmp)
>  			return -ENOMEM;
> =20
>  		exec->objects =3D tmp;
>  		exec->max_objects +=3D PAGE_SIZE / sizeof(void *);

[Severity: Medium]
Since max_objects started at 8, adding PAGE_SIZE / sizeof(void *) makes
max_objects 520. When the array grows again, size will be 4160 and
kvrealloc will request 8256 bytes, forcing kmalloc-16k. Does this continue
to waste memory at every growth step because the total object count remains
unaligned to the page size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002003816.3233=
277-1-matthew.brost@intel.com?part=3D1
