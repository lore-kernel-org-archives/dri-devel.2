Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE20F8808C
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674E310E7D4;
	Thu, 16 Apr 2026 07:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NPgQ3dEO";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E99510E7D4
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776323004;
 bh=qq0hjoM+THKl+PMzCFoOnizTUcRyZ3f6FubUQkOjKtg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=NPgQ3dEOQ0NEkmS+H68HBUqe1pazp/7RrMt8hYoXPz94U/u3QyX236AcL0zPMjCc3
 2/XI4ag0glu9B1wEgEB/fppv3LV6e1zf+LDmOc6pAzEb/dEB3d7cTvAfy3Za0rzbSU
 yYAhE6RoRF8sMkacGv5GvgO/jrVGMVwMY80VCr7T7vhhdepo8SrkjXj76Xig3FEwbc
 2jbCpVDQFTzb/3Vvy6hxBl+wuUEM3KS3JMAzGKLcaVpXCt6PQ+8+xKOAsGIUP5h9sz
 hVB/E5gaJOsbzyzhp2L2h2kOaVJS9W5Pff+aKLJkO9+xijwzwxRu9onuJpUmDS7EUZ
 yDqMH5j2rFb4w==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 441B617E0CA9;
 Thu, 16 Apr 2026 09:03:24 +0200 (CEST)
Date: Thu, 16 Apr 2026 09:03:20 +0200
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
Message-ID: <20260416090320.381043c6@fedora>
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

> > > +static int
> > > +panthor_vm_exec_map_op(struct panthor_vm *vm, u32 flags,
> > > +		       const struct drm_gpuva_op_map *op)
> > > +{
> > > +	struct panthor_gem_object *bo =3D to_panthor_bo(op->gem.obj);
> > > +	int prot =3D flags_to_prot(flags);
> > > +
> > > +	if (!op->va.range)
> > > +		return 0; =20
> >
> > Do we really expect a range of zero here? If not, I'd either drop
> > the check, or at the very least, make it a drm_WARN_ON_ONCE(). =20
>=20
> IIRC it can happen when panthor_vm_exec_map_op() is called from panthor_g=
puva_sm_step_remap(),
> and the remap's unmap didn't have to be expanded to account for a THP.

Can't we just replace that by an extra size > 0 check before calling
panthor_vm_exec_map_op() in the remap() path? I mean, we already have
an !evicted check there.

	if (!unmap_vma->evicted && size) {
		ret =3D panthor_vm_exec_map_op()
		...
	}

> Although in that case,
> the check being done inside panthor_vm_map_pages() should be enough.
