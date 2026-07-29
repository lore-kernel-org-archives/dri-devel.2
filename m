Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CFFC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888EB10ECDF;
	Wed, 29 Jul 2026 16:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a3+5S4kT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DAD410ECDF
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:11:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8AE46001D;
 Wed, 29 Jul 2026 16:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1331F00A3A;
 Wed, 29 Jul 2026 16:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785341481;
 bh=e9nFRkkbo/Sn/w5jhobnVsjutbFJLfRgGc3PpCoGCc4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a3+5S4kT4/Ec1co809n3Zkqy5rQCVHbcb0F5xt0ZmbFpw/T9n5QJmjHDMUE7ftI4+
 H1FKq1NQHPnb2oAO+Ft4Y9oagdKK1hGju20jORgTsF76PsGLAIEnwGtr7n3Y5zR29O
 CpC3FmZxq96A++zcsdfZ2/yiETFRWIawtAvXjidmI2FDV1UIJQDuFwL5ztjbiXDO10
 iT/LH1+9DCaemQUbP2Edt/i61soeuR/Cbt4eP0dhoPduefHPndYeJfXbdYKhDdR7nZ
 XXiVuJtMNNDR8VHwIVxJJsYKmK0rSqAdFKHl2VqlZacO2T/8Qr7hI4CJySbvW6gB/F
 Y067YCes/cIIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/17] drm/msm/gem: Remove useless locking in GEM import
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-11-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-11-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:11:21 +0000
Message-Id: <20260729161121.6C1331F00A3A@smtp.kernel.org>
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
- [High] Concurrent access to imported GEM objects via debugfs causes a loc=
k imbalance, leading to system crash or permanent resource lock.
--

--- Patch [10]: [PATCH v7 10/17] drm/msm/gem: Remove useless locking in GEM=
 import ---
commit 1dfbce02f7920b37d011abac3bc5352c1cadab22
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Remove useless locking in GEM import
   =20
The locking has changed a few times over the years, and this extra
locking was the mistake of evolution.  Harmless but useless.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 74c3728f45bd0..cc45392691e50 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
[ ... ]
> @@ -1310,22 +1310,17 @@ struct drm_gem_object *msm_gem_import(struct drm_=
device *dev,
[ ... ]
>  	drm_gem_lru_move_tail(&priv->lru.pinned, obj);
> =20
>  	mutex_lock(&priv->obj_lock);

[Severity: High]
This is a pre-existing issue, but can publishing the object to the global
list here lead to a lock imbalance if debugfs is accessed concurrently?

Once the object is added to the priv->objects list, it becomes visible to
concurrent debugfs iteration before the import process has finished.

According to drm_prime.c, drm_gem_prime_import_dev() overwrites obj->resv
after msm_gem_import() has already published it:

	obj->import_attach =3D attach;
	obj->resv =3D dma_buf->resv;

If msm_gem_describe() in debugfs iterates the list concurrently during this
window, it locks the original obj->resv via msm_gem_trylock(obj). If the
resv pointer is then overwritten mid-flight, the subsequent
msm_gem_unlock(obj) call will unlock a completely different lock:

	if (!msm_gem_trylock(obj))
		return;
	...
	dma_resv_describe(robj, m);
	msm_gem_unlock(obj);

Could this lead to a kernel oops due to a bad unlock balance, or leave the
initial reservation object permanently locked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D10
