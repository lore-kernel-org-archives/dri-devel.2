Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FB8D6AAFC
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E48C710F3C9;
	Fri,  3 Apr 2026 08:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZIzmx2UZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846F810F3C9
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 08:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775204750;
 bh=zfQs8b9jWuHNNoB2IqSRtpJUMEpw89Ypb/CcW4k2Obc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZIzmx2UZyp3BCMBv24XQB2NMSc4MVOdvJsjb1a98choDVXEPoggFm3JuiLc9MY/Gk
 6OUNPWKNpPYOP4sIscQkysLm6JwxHJTanMUJw5Ag9jH4cQr8ueG3NkDU9nfXtP8K6l
 nGZ+JzOxTk5iPNagV7c39dTYda1iv0Y13PxA00I+m+4eo6DKeIIyH7xQKIcAGQnjbN
 3PTcYz9vJOiZlSOHRfztWvfKkHZ9fAUIZ+SnwStzwdXefnf6IQHs2SDkvB5aqWBw+h
 i/tSpJ02h9bV6Dz/7ux9ix31+fXFDvUJSctmnYOfesohJgcJLdVKe+tNaMJOAZ4RFI
 SqP6s8zrL8Yag==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7CC2D17E8622;
 Fri,  3 Apr 2026 10:25:49 +0200 (CEST)
Date: Fri, 3 Apr 2026 10:25:45 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
 kernel@collabora.com, Biju Das <biju.das.jz@bp.renesas.com>, Tommaso
 Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: Re: [PATCH] drm/shmem_helper: Make sure PMD entries get the
 writeable upgrade
Message-ID: <20260403102545.6085b71f@fedora>
In-Reply-To: <1268c6cf-f3d7-4085-baca-796526125f44@collabora.com>
References: <20260320151914.586945-1-boris.brezillon@collabora.com>
 <1268c6cf-f3d7-4085-baca-796526125f44@collabora.com>
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

On Fri, 3 Apr 2026 09:57:53 +0200
Lo=C3=AFc Molinari <loic.molinari@collabora.com> wrote:

> Hi Boris,
>=20
> On 20/03/2026 16:19, Boris Brezillon wrote:
> > Unlike PTEs which are automatically upgraded to writeable entries if
> > .pfn_mkwrite() returns 0, the PMD upgrades go through .huge_fault(),
> > and we currently pretend to have handled the make-writeable request
> > even though we only ever map things read-only. Make sure we pass the
> > proper "write" info to vmf_insert_pfn_pmd() in that case.
> >=20
> > This also means we have to record the mkwrite event in the .huge_fault()
> > path now. Move the dirty tracking logic to a
> > drm_gem_shmem_record_mkwrite() helper so it can also be called from
> > drm_gem_shmem_pfn_mkwrite().
> >=20
> > Note that this wasn't a problem before commit 28e3918179aa
> > ("drm/gem-shmem: Track folio accessed/dirty status in mmap"), because
> > the pgprot were not lowered to read-only before this commit (see the
> > vma_wants_writenotify() in vma_set_page_prot()).
> >=20
> > Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status =
in mmap")
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> >=20
> > This patch is based on drm-tip [2], because that's the only branch
> > that has both [1] and the dirty tracking changes that live in
> > drm-misc-next.
> >=20
> > Also added the THP maintainers in Cc, so I can hopefully get some
> > feedback on the fix. For instance, I'm still unsure
> > drm_gem_shmem_pfn_mkwrite() is race-free (do we need some locking
> > there? should we call folio_mark_dirty_lock()? should we call the
> > fault handler directly from there and have all the dirty tracking
> > in this .[huge_]fault path?).
> >=20
> > [1]https://yhbt.net/lore/dri-devel/20260319015224.46896-1-pedrodemargom=
es@gmail.com/
> > [2]https://gitlab.freedesktop.org/drm/tip
> > ---
> >   drivers/gpu/drm/drm_gem_shmem_helper.c | 46 ++++++++++++++++++--------
> >   1 file changed, 32 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/d=
rm_gem_shmem_helper.c
> > index 2062ca607833..545933c7f712 100644
> > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > @@ -554,6 +554,21 @@ int drm_gem_shmem_dumb_create(struct drm_file *fil=
e, struct drm_device *dev,
> >   }
> >   EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
> >  =20
> > +static void drm_gem_shmem_record_mkwrite(struct vm_fault *vmf)
> > +{
> > +	struct vm_area_struct *vma =3D vmf->vma;
> > +	struct drm_gem_object *obj =3D vma->vm_private_data;
> > +	struct drm_gem_shmem_object *shmem =3D to_drm_gem_shmem_obj(obj);
> > +	loff_t num_pages =3D obj->size >> PAGE_SHIFT;
> > +	pgoff_t page_offset =3D vmf->pgoff - vma->vm_pgoff; /* page offset wi=
thin VMA */
> > +
> > +	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >=3D num_pages=
))
> > +		return;

For full transparency, I'd like to mention the review bot complained [1]
about us not propagating the error to .pfn_mkwrite() as was done before
this patch. In practice, I don't think it matters much: if the pages are
gone and .pfn_mkwrite() is called, we're in trouble anyway, because a
read-only PTE pointing to this missing page exists already, and it
won't be removed if we return an error, it just won't be updated to
read-write.

> > +
> > +	file_update_time(vma->vm_file);
> > +	folio_mark_dirty(page_folio(shmem->pages[page_offset])); =20
>=20
> Unless we're sure the folio can't be truncated by another CPU, maybe we=20
> should use folio_mark_dirty_lock() here.

In practice, we control when the file is truncated
(drm_gem_shmem_purge_locked()), and before we do that, we make sure to
kill all the CPU mappings (drm_vma_node_unmap() called before
shmem_truncate_range()). So I'd say we're good WRT this particular race.

> This is what's done for pages=20
> (not PFNs) in mm/memory.c. Let's wait and see how it goes without=20
> locking for now.

I agree, let's see how it goes and revisit later if needed.

>=20
> Reviewed-by: Lo=C3=AFc Molinari <loic.molinari@collabora.com>

Thanks for the review. The patch has been queued to drm-misc-next-fixes.

Regards,

Boris

[1]https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-patch1-2026032=
0151914.586945-1-boris.brezillon@collabora.com/
