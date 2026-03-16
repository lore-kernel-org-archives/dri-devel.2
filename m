Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B87F46437
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEA210E0E2;
	Mon, 16 Mar 2026 09:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZqfE+Xr0";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9DA10E0E2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773653785;
 bh=b6yw9/4PD62KvEkjXC+VuOM1Xiu3UE6oxg4mQOWuyyA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZqfE+Xr0seBjKzJ8F/GeZgHtrYib2K35hJUB+Lc7YPKHX0x/I4OyS5iyI54kKHNyV
 4fI71r2LukOT7UstwBHdb5acjgQP7kmP3LR5M3C3PGAHLMaCYb6lr38T0BXtKzTD98
 V9dcyx3rbkvXVN7IrU8VVYckXSUgf+kAmi1JDGy3AcrKit3kG5j3YgW+JDipiy2K/6
 cK3Q21vuWCHYdntPr6OU5i1wVhoAmbvjuJZWEcuOoptWlWHdNfwJcN5ylzRK/l+oCL
 0qDICIm6zWndtsJglZ17MGpQ9fGSJ1g2BPUbef9+OxWacRO6bqYqEI90WJohSPbyJU
 dEqE6qyhlgztA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 39AE317E1330;
 Mon, 16 Mar 2026 10:36:25 +0100 (CET)
Date: Mon, 16 Mar 2026 10:36:21 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Tommaso Merciai
 <tommaso.merciai.xr@bp.renesas.com>, "loic.molinari@collabora.com"
 <loic.molinari@collabora.com>, "willy@infradead.org" <willy@infradead.org>,
 "frank.binns@imgtec.com" <frank.binns@imgtec.com>, "matt.coster@imgtec.com"
 <matt.coster@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
Message-ID: <20260316103621.6ed48b68@fedora>
In-Reply-To: <53f11658-5466-49a3-816a-ff6fd2e1da6f@suse.de>
References: <20260227114509.165572-1-tzimmermann@suse.de>
 <20260227114509.165572-6-tzimmermann@suse.de>
 <abL5rcYIaFFO3GW2@tom-desktop>
 <TY3PR01MB113460CA616D3576DA0C3FC698644A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113461ACB668738E1952EC8898645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260313111851.4c1f89f3@fedora>
 <f3384342-cdc5-4260-b670-4ffde76a2802@suse.de>
 <20260313125644.65131b27@fedora>
 <TY3PR01MB1134662A395AA0A048CEE152E8645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260313131835.52c5c935@fedora> <20260313134328.3166c4d0@fedora>
 <20260313135521.07823792@fedora> <20260313184549.08656eed@fedora>
 <53f11658-5466-49a3-816a-ff6fd2e1da6f@suse.de>
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

On Mon, 16 Mar 2026 09:45:49 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Hi Boris,
>=20
> thanks for investigating this problem.
>=20
> Am 13.03.26 um 18:45 schrieb Boris Brezillon:
> > On Fri, 13 Mar 2026 13:55:21 +0100
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > =20
> >> On Fri, 13 Mar 2026 13:43:28 +0100
> >> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >> =20
> >>> On Fri, 13 Mar 2026 13:18:35 +0100
> >>> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >>>     =20
> >>>> On Fri, 13 Mar 2026 12:04:25 +0000
> >>>> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >>>>       =20
> >>>>>> -----Original Message-----
> >>>>>> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behal=
f Of Boris Brezillon
> >>>>>> Sent: 13 March 2026 11:57
> >>>>>> Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/di=
rty status in mmap
> >>>>>>
> >>>>>> On Fri, 13 Mar 2026 11:29:47 +0100
> >>>>>> Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>>>>>           =20
> >>>>>>> Hi
> >>>>>>>
> >>>>>>> Am 13.03.26 um 11:18 schrieb Boris Brezillon:
> >>>>>>> [...] =20
> >>>>>>>>>>>> +	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >=
=3D num_pages))
> >>>>>>>>>>>> +		return VM_FAULT_SIGBUS;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +	file_update_time(vma->vm_file);
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +	folio_mark_dirty(page_folio(shmem->pages[page_offset])); =
=20
> >>>>>>>> Do we need a folio_mark_dirty_lock() here? =20
> >>>>>>> There is a helper for that with some documentation. [1] =20
> >>>>>> This [1] seems to solve the problem for me. Still unsure about the=
 folio_mark_dirty_lock vs
> >>>>>> folio_mark_dirty though.
> >>>>>>
> >>>>>> [1]https://yhbt.net/lore/dri-devel/20260312155027.1682606-1-pedrod=
emargomes@gmail.com/ =20
> >>>>> FYI, I used folio_mark_dirty_lock() still it does not solve the iss=
ue with weston hang. =20
> >>>> The patch I pointed to has nothing to do with folio_mark_dirty_lock(=
),
> >>>> It's a bug caused by huge page mapping changes. =20
> >>> Scratch that. I had a bunch of other changes on top, and it hangs aga=
in
> >>> now that I dropped those. =20
> >> Seems like it's the combination of huge pages and mkwrite that's
> >> causing issues, if I disable huge pages, it doesn't hang... =20
> > I managed to have it working with the following diff. I still need to
> > check why the "map-RO-split+RW-on-demand" approach doesn't work (races
> > between huge_fault and pfn_mkwrite?), but I think it's okay to map the
> > real thing writable on the first attempt anyway (we're not trying to do
> > CoW here, since we're always pointing to the same page, it's just the
> > permissions that change). Note that there's still the race fixed by
> > https://yhbt.net/lore/dri-devel/20260312155027.1682606-1-pedrodemargome=
s@gmail.com/
> > in this diff, I just tried to keep the diffstat minimal.
> > =20
> > --->8--- =20
> > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/d=
rm_gem_shmem_helper.c
> > index 4500deef4127..4efdce5a60f0 100644
> > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > @@ -561,9 +561,8 @@ static vm_fault_t drm_gem_shmem_try_insert_pfn_pmd(=
struct vm_fault *vmf, unsigne
> >          bool aligned =3D (vmf->address & ~PMD_MASK) =3D=3D (paddr & ~P=
MD_MASK);
> >  =20
> >          if (aligned && pmd_none(*vmf->pmd)) {
> > -               /* Read-only mapping; split upon write fault */
> >                  pfn &=3D PMD_MASK >> PAGE_SHIFT;
> > -               return vmf_insert_pfn_pmd(vmf, pfn, false);
> > +               return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_=
FLAG_WRITE);
> >          }
> >   #endif
> >  =20
> > @@ -597,8 +596,12 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fa=
ult *vmf)
> >  =20
> >          pfn =3D page_to_pfn(page);
> >  =20
> > -       if (folio_test_pmd_mappable(folio))
> > +       if (folio_test_pmd_mappable(folio)) {
> >                  ret =3D drm_gem_shmem_try_insert_pfn_pmd(vmf, pfn);
> > +               if (ret =3D=3D VM_FAULT_NOPAGE && vmf->flags & FAULT_FL=
AG_WRITE)
> > +                       folio_mark_dirty(folio);
> > +       }
> > +
> >          if (ret !=3D VM_FAULT_NOPAGE)
> >                  ret =3D vmf_insert_pfn(vma, vmf->address, pfn); =20
>=20
> All these branches with NOPAGE seem confusing. Can we change the overall=
=20
> logic here? Something like:
>=20
> if (folio_test_pmd_mappable()) {
>  =C2=A0 =C2=A0 ret =3D try_insert_pfn_pmd()
>  =C2=A0 =C2=A0 if (ret =3D=3D VM_FAULT_NOPAGE) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 folio_mark_accessed()
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags & FLAG_WRITE)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 folio_mark_dirty()
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>  =C2=A0 =C2=A0 }
> }
>=20
> ret =3D vmf_insert_pfn()
> if (ret =3D=3D NOPAGE)
>  =C2=A0 =C2=A0 folio_mark_accesed()
>=20
> out:
>  =C2=A0 ...
>=20
>=20
> This would keep the huge-page code within the first branch. And if it=20
> fails, it still does the regular page fault.

Well, in practice that's not what we want anyway (see the other fix for
the huge_fault vs regular fault race), so I'd still be inclined to have
the folio_mark_accessed() handled in the common path and have the pmd
vs regular pfn insertion in some if/else branches. Something like that:

	if (pmd_insert)
		ret =3D drm_gem_shmem_try_insert_pfn_pmd(vmf, pfn);
	else
		ret =3D vmf_insert_pfn(vma, vmf->address, pfn);

	if (ret =3D=3D VM_FAULT_NOPAGE) {
		folio_mark_accesed(folio);

		/* Normal pages are mapped RO, and remapped RW afterwards. */
		if (pmd_insert && vmf->flags & FAULT_FLAG_WRITE)
			folio_mark_dirty(folio);
	}
