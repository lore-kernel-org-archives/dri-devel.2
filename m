Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E65DF94CDB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2BEA10E8BD;
	Wed, 22 Apr 2026 07:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Gsw/+RVX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEEA010E8BD
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776843804;
 bh=om8dKKz+wqVSPeuqRvDV+A/LUJH2lWI7oRIGMZZgXXY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Gsw/+RVXdQdCwetJpQZwB16ZBEShSyJh5Vf9wdfUk0s7e+WdXQ+V+2dqLvbEvlsLV
 2fFT1O9qEryQ1ixe+oZWjWIggQ93VZMGozXN1aaJRXYI5Q3uscQOFcUb4aUYysJRXp
 Y3KkZ4A2uP6mXtf++gK2DN/4rBwazfVceCQsakIXS40SaewBiLrXq3+frWzAYRUDD4
 YtT2igNzEajEIax5/5Vy4GtjMielnHJ/0pBPZ3vwrrnVjzCyEPFMx3TamkfGKxP+g3
 LuZKBHKxO7QZT75HBfqsKMOvo1dYUU/PTgJE4mOMxKHrUK467t7dVgNxWdUZcqJcQY
 8YK9hvb2wQDSw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D6FC817E10F4;
 Wed, 22 Apr 2026 09:43:23 +0200 (CEST)
Date: Wed, 22 Apr 2026 09:43:19 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v8 5/6] drm/panthor: Support sparse mappings
Message-ID: <20260422094319.1fbd13b9@fedora>
In-Reply-To: <aefukxIMh7UtG-2x@sobremesa>
References: <20260416214453.112332-1-adrian.larumbe@collabora.com>
 <20260416214453.112332-6-adrian.larumbe@collabora.com>
 <20260417104023.19d5e83e@fedora> <aefukxIMh7UtG-2x@sobremesa>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 21 Apr 2026 22:44:18 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> >
> > Also, how about we do a
> >
> > 			gem =3D drm_gem_object_get(&vm->dummy->base) =20
>=20
> I'm afraid drm_gem_object_get() doesn't return a pointer to the same obje=
ct. Other drivers work around this
> by defining their own refcnt macro like:
>=20
> static inline struct xe_bo *xe_bo_get(struct xe_bo *bo)
> {
> 	if (bo)
> 		drm_gem_object_get(&bo->ttm.base);
>=20
> 	return bo;
> }
>=20
> However, this is meant to operate on the driver-specific bo rather than a=
 generic DRM one. We could also do this:
>=20
> if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE))
>         gem =3D drm_gem_object_lookup(file, op->bo_handle);
> else
>         drm_gem_object_get(gem =3D &vm->dummy->base);

If it's just this single instance, let's go for:

	if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {
		gem =3D drm_gem_object_lookup(file, op->bo_handle);
	} else {
		gem =3D &vm->dummy->base;
		drm_gem_object_get(gem);
	}

If there are multiple places where we want to acquire a
panthor_gem_object ref, it might make sense to add those
panthor_bo_{get,put}() helpers.
