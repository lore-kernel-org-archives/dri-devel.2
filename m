Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F411BC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FAB010E71B;
	Mon,  6 Jul 2026 02:54:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kPJCO6Sr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D13B910E71B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 02:54:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5033640C16;
 Mon,  6 Jul 2026 02:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6D81F000E9;
 Mon,  6 Jul 2026 02:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783306442;
 bh=vMgSbHa1ylETPJCL+L28n9EOBOvi/dcTGwZaqZyGVG8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kPJCO6SrNFis12x+o4lXN/6zMN4hTZHmzHuV4QiFJ+AV2zvAR2jNIs53mTav2SK4t
 GQDNmxIU3AXB+Q6f5QgWbe1zZyzmfsP//6DnnczcMA0vY3q9ZRBOFJI74dTwpDZ33X
 x2w0rxjTh582SrRJkZhJgbKgRBGj30jIKF88fAWnS7I5UjzLIZVmnbEA4oSeVMAWbc
 oRqLsMIPmmQjBS5w6+s+CzGsIIXHbq8I97E2E/TLno2mH3PAqJ1X6r/yzZsnJ3ipEw
 jdDI21klwBcM18kqmyD3WBUUuJ2LzOLFAIcRXv5IaT7UCr4DDYh19xNeYfZr2wKfN2
 MT/u001tPnw1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] ttm: add objcg pointer to bo and tt (v2)
To: "Dave Airlie" <airlied@gmail.com>
Cc: mkoutny@suse.com, dri-devel@lists.freedesktop.org, hannes@cmpxchg.org,
 tj@kernel.org
In-Reply-To: <20260706024122.853329-5-airlied@gmail.com>
References: <20260706024122.853329-1-airlied@gmail.com>
 <20260706024122.853329-5-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:53:59 +0000
Message-Id: <20260706025400.8F6D81F000E9@smtp.kernel.org>
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
- [High] Refcount underflow and use-after-free of obj_cgroup due to shallow=
 copy in ghost objects.
--

commit 0958e13ef29f184401c5e0dda949311750032e9b
Author: Dave Airlie <airlied@redhat.com>

ttm: add objcg pointer to bo and tt (v2)

This commit adds the obj cgroup pointer to the bo and tt structs, and sets
it between them.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index cf4ab2b5521a0..8e38c6c5c82ef 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -315,6 +316,7 @@ static void ttm_bo_release(struct kref *kref)
>  		dma_resv_unlock(bo->base.resv);
>  	}
> =20
> +	obj_cgroup_put(bo->objcg);

[Severity: High]
Does this introduce a double-put and refcount underflow for the objcg
during buffer migrations?

Looking at ttm_buffer_object_transfer() in
drivers/gpu/drm/ttm/ttm_bo_util.c, it performs a shallow copy to create a
ghost object:

drivers/gpu/drm/ttm/ttm_bo_util.c:ttm_buffer_object_transfer() {
    ...
    fbo =3D kmalloc(sizeof(*fbo), GFP_KERNEL);
    ...
    fbo->base =3D *bo;
    ...
}

Because fbo->base =3D *bo directly copies the bo->objcg pointer without
acquiring an additional reference via obj_cgroup_get(), both the original
buffer object and the new ghost object will hold the exact same objcg
pointer.

When these objects are eventually destroyed, both will execute
ttm_bo_release() and call obj_cgroup_put(bo->objcg) on the same cgroup,
resulting in an unbalanced put and a potential use-after-free.

>  	atomic_dec(&ttm_glob.bo_count);
>  	bo->destroy(bo);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706024122.8533=
29-1-airlied@gmail.com?part=3D4
