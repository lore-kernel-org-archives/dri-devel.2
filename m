Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28838F8806B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 06:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C2B810E0A9;
	Thu, 16 Apr 2026 06:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WkQgc3/A";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62FBF10E0A9
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 06:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776322542;
 bh=iVXocKTZmYJGC0WoAS800VksTIgZCs1qZSpnUGiK1qk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WkQgc3/AsBYe2F5Zc4Ha1DJOxsuoT/z3IIuecVxLrvjB8GvDA/RzIAlgu6IAvti7e
 2NrnTAEJ8ewhS8f/yzuc2ySWYukShS1I56gOaRVS/C2yrKg08U1fT8EDYeLebS2gKb
 vEEMDrdfbbz0cY13LrF08UcS2noAs9O/3UW3U7Pfrr7y+vqbhnecMeNOVSWjvKL7gq
 UJnVHBTPycqHLuvL3+zkyN7zxElHiXhjVct4qbOhSdzJ97cHo/Z0m07XzsoDC0wu8W
 BRqu8OOs6IwF4CoPJztpTqHHdQDozSkjH/MZuGtccXALP+ndbu/f9rT2SEPxF26wW0
 tBwkZ+A0o3x7A==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9119F17E11F5;
 Thu, 16 Apr 2026 08:55:41 +0200 (CEST)
Date: Thu, 16 Apr 2026 08:55:37 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v7 5/6] drm/panthor: Support sparse mappings
Message-ID: <20260416085537.6af9e2c8@fedora>
In-Reply-To: <aeAMgA7XCHXc3Hch@sobremesa>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-6-adrian.larumbe@collabora.com>
 <20260415171247.3701e116@fedora> <aeAMgA7XCHXc3Hch@sobremesa>
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

On Wed, 15 Apr 2026 23:09:17 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> > > @@ -2251,14 +2383,17 @@ static int panthor_gpuva_sm_step_remap(struct=
 drm_gpuva_op *op,
> > >  	}
> > >
> > >  	if (op->remap.prev) {
> > > -		struct panthor_gem_object *bo =3D to_panthor_bo(op->remap.prev->ge=
m.obj);
> > > -		u64 offset =3D op->remap.prev->gem.offset + unmap_start - op->rema=
p.prev->va.addr;
> > > -		u64 size =3D op->remap.prev->va.addr + op->remap.prev->va.range - =
unmap_start;
> > > +		const struct drm_gpuva_op_map map_op =3D {
> > > +			.va.addr =3D unmap_start,
> > > +			.va.range =3D
> > > +			op->remap.prev->va.addr + op->remap.prev->va.range - unmap_start,
> > > +			.gem.obj =3D op->remap.prev->gem.obj,
> > > +			.gem.offset =3D
> > > +			op->remap.prev->gem.offset + unmap_start - op->remap.prev->va.add=
r, =20
> >
> > I believe it should be forced to zero if this is a sparse
> > mapping, no? This makes me think we probably want this to be
> > NULL, in the case of a sparse mapping. It shouldn't prevent
> > reclaim from happening on the dummy BO, because the drm_gpuva
> > has a separate vm_bo field. Yes it forces us to add bunch of
> > is_sparse checks in a few other places, but I find it cleaner
> > than pretending this is a regular BO. =20
>=20
> The .gem.offset field is assigned here unconditionally, but discarded in =
cases it's a sparse mapping
> when calling panthor_vm_map_sparse() (which takes no offset argument). I =
assume what you mean is that
> in panthor_vm_exec_op(), I should abstain from assining .map.gem.obj and =
.map.gem.offset. However,
> if I do that, the 'va->vm_bo =3D drm_gpuvm_bo_get(vm_bo);' will never hap=
pen inside drm_gpuva_link().

Ah, crap! I thought drm_gpuva_link() was only considering vm_bo. Okay,
let's keep it the way you did it then, and just add a comment
explaining unmap_op.keep can't be trusted when the mapping is sparse.
