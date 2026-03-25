Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13CAFEA82E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42EA810E810;
	Wed, 25 Mar 2026 08:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="mETG2AHd";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E83C10E810
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774426235;
 bh=KqzQ/1l+FYaoV5TARic/+6XJ8T3hoF17xR/I3PeeL7I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mETG2AHdFIvivwgwiJb8/BiEN4CEgAZlPxDZJ8E4h4Q+EY2GpbvcHXqs30E5TU4TW
 dPK0RPKvnSkH19fRM9oeem8/JrNtaq7odo/yd9WGNw5pgqF9tXL5Wz+6Lm5SUbQyU1
 AuR2E8h5/DyjZ1LbFtr5WfibT5ivlkPYeTtf4NcxuCFGLEx0tGDEFqW9LwoSlYG1sC
 /5uIZwLjAAyLaYp3+44a58SQIL9NKYJ/VAtXOU78ti3Ihyx2xlqNLxvMXQVjE5oGbS
 HNB4iQ6JbUXQKqzjxPZEfjiT8O0RTwGvGGx1vGFEhT5OGUofdd8FifwEckWk+RzWFE
 yOSILLoT7dDow==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2886117E5092;
 Wed, 25 Mar 2026 09:10:35 +0100 (CET)
Date: Wed, 25 Mar 2026 09:10:31 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, Konrad Dybcio
 <konradybcio@kernel.org>, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Dmitry
 Osipenko <dmitry.osipenko@collabora.com>, Chris Diamand
 <chris.diamand@arm.com>, Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>,
 Chia-I Wu <olvaffe@gmail.com>, kernel@collabora.com
Subject: Re: [PATCH v5 9/9] drm/panthor: Add a GEM shrinker
Message-ID: <20260325091031.36ea296c@fedora>
In-Reply-To: <acMkjZ0MkKLCnLvi@sobremesa>
References: <20260309151119.290217-1-boris.brezillon@collabora.com>
 <20260309151119.290217-10-boris.brezillon@collabora.com>
 <acMkjZ0MkKLCnLvi@sobremesa>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Wed, 25 Mar 2026 00:14:46 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> > +static bool is_gpu_mapped(struct panthor_gem_object *bo,
> > +			  enum panthor_gem_reclaim_state *state)
> > +{
> > +	struct drm_gpuvm *vm =3D NULL;
> > +	struct drm_gpuvm_bo *vm_bo;
> > +
> > +	drm_gem_for_each_gpuvm_bo(vm_bo, &bo->base) {
> > +		/* Skip evicted GPU mappings. */
> > +		if (vm_bo->evicted)
> > +			continue;
> > +
> > +		if (!vm) {
> > +			*state =3D PANTHOR_GEM_GPU_MAPPED_PRIVATE;
> > +			vm =3D vm_bo->vm;
> > +		} else if (vm !=3D vm_bo->vm) { =20
>=20
> I might be wrong to think that no two VM_BO's for a given BO can have the=
 same
> VM, but if that were the case, then the above check could be omitted and =
left
> as an 'else'.

No you're correct. I'll go for:

static bool is_gpu_mapped(struct panthor_gem_object *bo,
                          enum panthor_gem_reclaim_state *state)
{
        struct drm_gpuvm_bo *vm_bo;
        u32 vm_count =3D 0;

        drm_gem_for_each_gpuvm_bo(vm_bo, &bo->base) {
                /* Skip evicted GPU mappings. */
                if (vm_bo->evicted)
                        continue;

                if (vm_count++) {
                        *state =3D PANTHOR_GEM_GPU_MAPPED_MULTI_VM;
                        break;
                }

                *state =3D PANTHOR_GEM_GPU_MAPPED_SINGLE_VM;
        }

        return vm_count > 0;=20
}

in v6.

>=20
> > +			*state =3D PANTHOR_GEM_GPU_MAPPED_SHARED;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return !!vm;
> > +}
> > +

[...]

> > +int panthor_gem_swapin_locked(struct panthor_gem_object *bo)
> > +{
> > +	struct sg_table *sgt;
> > +	int ret;
> > +
> > +	dma_resv_assert_held(bo->base.resv);
> > +
> > +	if (drm_WARN_ON_ONCE(bo->base.dev, drm_gem_is_imported(&bo->base)))
> > +		return -EINVAL;
> > + =20
>=20
> Following call is redundant because it's already being done in panthor_ge=
m_dev_map_get_sgt_locked().

Indeed, I'll drop this panthor_gem_backing_get_pages_locked().

>=20
> > +	ret =3D panthor_gem_backing_get_pages_locked(bo);
> > +	if (ret)
> > +		return ret;
> > +
> > +	sgt =3D panthor_gem_dev_map_get_sgt_locked(bo);
> > +	if (IS_ERR(sgt))
> > +		return PTR_ERR(sgt);
> > +
> > +	return 0;
> > +}
