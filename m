Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32083CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 08:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D0B010E23A;
	Mon,  5 Oct 2026 08:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="g/YxJoUS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BBE10E23A
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 08:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791189539;
 bh=0y8xOcu4Rdu0IG8YCBVtdnYuhm3D3y7YXgnCEBf5n6Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=g/YxJoUSuJt75+jdI86Xhw4lz6ilcqXOj0i/57VTnExuIm38Xza5MxC+89T8p6epS
 E01emjODx2Xv4ynmV9z5AhAzG171j2TLIQt+GLe9wn1T5yCQptV/OB8te/q1u0/cZ+
 rWcz2rkB+zXH8RyoFFDRf1NR5U8ohkAGSY6HGo2E41orAyQwD3gdyr3zSZdQCEIv9g
 uEXVhdtgZuyYYRZDGS/aERVhbcsJ/w6Anaa2owIh0WFx0dxPMCNVwNCEIw2cbMUJyj
 jMKv1qALg+4Ut/g90YxqPm4QrunmCe+pewLYMjyc+vB6F532j21AUp/3pKMBWl6xCS
 puTRPaR6R/YpA==
Received: from fedora-61.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C11CF17E006F;
 Mon, 05 Oct 2026 10:38:58 +0200 (CEST)
Date: Mon, 5 Oct 2026 10:38:55 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>, Rob
 Herring <robh@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Robin Murphy <robin.murphy@arm.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v12 12/15] drm/panfrost: Skip cache flush/invalidate
 when enabling perfcnt
Message-ID: <20261005103855.655f8199@fedora-61.home>
In-Reply-To: <95174a67-0eee-4bf7-b883-9f1138c74a6f@arm.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-12-62beb08de207@collabora.com>
 <95174a67-0eee-4bf7-b883-9f1138c74a6f@arm.com>
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

On Fri, 2 Oct 2026 16:14:38 +0100
Steven Price <steven.price@arm.com> wrote:

> On 29/09/2026 04:44, Adri=C3=A1n Larumbe wrote:
> > The GPU cache flush/invalidate operation is unnecessary. First off, the
> > GPU doesn't read off the perfcnt sample buffer, only writes into it, so=
 =20
>=20
> I don't think this is entirely true. The GPU performance counter unit
> only writes the counters that are enabled, counters that share a cache
> line but are not enabled are not written by the performance counter
> unit, but if the L2 contains that cache line then the write can hit in
> the L2 and dirty the entire line including stale data where the
> unwritten cache line is.

I don't think this can happen though, because _enable_locked() is
creating a BO (and its GPU mapping) just before enabling the perfcnt
block, meaning the buffer is known to have no dirty cacheline pointing
to it until the first dump happens. And we do flush and invalidate GPU
caches after each dump, so again, we should be covered.

>=20
> The upshot is that if the CPU has cleared a block of memory which the
> GPU happens to have cached, then the "unused" counters may end up
> showing the old data before the CPU cleared it (if they share a cache
> line with an active counter).

I agree, but that's not a case we can hit in the enable path. I think I
mentioned the commit message was misleading, and that we should instead
talk about the fact the GPU is not supposed to have cached anything up
until the first SAMPLE following a the ENABLE step.

>=20
> I have to admit it's probably somewhat academic given that Panfrost
> doesn't expose the ability to control which counters are enabled...
>=20
> Is there a good reason for this patch (i.e. have you seen a performance
> problem with doing the invalidate)? Otherwise I'd prefer we keep to the
> safe route rather than trying to over optimise cache maintenance.

I think I was the one suggesting dropping this flush so that
panfrost_perfcnt_hw_enable() (in the last patch) has one less fallible
operation. Besides, I find it confusing to have a cache flush+inval in
a path where the GPU is not supposed to have accessed the buffer yet
(or later on, when we re-enable after a RESET, in a path where the GPU
has been reset and the caches are known to be empty).

>=20
> Obviously in the fully coherent case the invalidate could be skipped (as
> in the next patch).
>=20
> Thanks,
> Steve
>=20
> > an invalidate doesn't make a difference. Then flushing GPU caches after
> > each sample has been written is enough for the CPU to see updated value=
s.
> >=20
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/=
drm/panfrost/panfrost_perfcnt.c
> > index f71534e741b6..ffc77121070e 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > @@ -124,21 +124,10 @@ static int panfrost_perfcnt_enable_locked(struct =
panfrost_device *pfdev,
> >  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> > =20
> >  	/*
> > -	 * Invalidate the cache and clear the counters to start from a fresh
> > -	 * state.
> > +	 * Clear the counters to start from a fresh state.
> >  	 */
> > -	reinit_completion(&pfdev->perfcnt->dump_comp);
> > -	gpu_write(pfdev, GPU_INT_CLEAR,
> > -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > +	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> >  	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> > -	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
> > -	ret =3D wait_for_completion_timeout(&pfdev->perfcnt->dump_comp,
> > -					  msecs_to_jiffies(1000));
> > -	if (!ret) {
> > -		ret =3D -ETIMEDOUT;
> > -		goto err_vunmap;
> > -	}
> > =20
> >  	ret =3D panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> >  	if (ret < 0)
> >  =20
>=20

