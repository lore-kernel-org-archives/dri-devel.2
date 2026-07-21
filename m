Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B99C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BF010E343;
	Tue, 21 Jul 2026 19:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JH5OMLJE";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D253910E343
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 19:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784662576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/286SfFVtklWrNhnFjYDOULAbVTpOfzHSe6bg9Wsafg=;
 b=JH5OMLJEa+p1ykX6BQO6U/sMlAEHucqc3j2QUdDlTdKb5NstVUMvpyIajGfskd7Wg3+pk+
 bdLT5XDfriFdr+mlb/KVVy5YBWhHejTU+O9bGxrxbJvxFOTFQWTREgCbftCzqjT+3aO0bE
 Uf+gly//dM6qmEfBg3R3+FIxWlERKBk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-N2OpvMAGPB-FCKQuZidxhQ-1; Tue, 21 Jul 2026 15:36:14 -0400
X-MC-Unique: N2OpvMAGPB-FCKQuZidxhQ-1
X-Mimecast-MFC-AGG-ID: N2OpvMAGPB-FCKQuZidxhQ_1784662573
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4629f312a67so11005462f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784662573; x=1785267373;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/286SfFVtklWrNhnFjYDOULAbVTpOfzHSe6bg9Wsafg=;
 b=Vmb2m7YclGA8AseniehL95NcW8uFWb4jocfcrzt2Ul7n3TmDH6MVIONZi74EIDympo
 NdThe6lA86iEdmoGZDZvCERddOHlu8zRe/w2Tr43EEqa0m5gD2nFpJf4fYHBTT/fUI7A
 DPd4veau8ymA4nQtl7kP5l5tAhtll2E/C2OdFo+TJDweKraKcuaymBEHVaNNFDKguFL2
 yrWU+DvudQdaVFv7x2wyv1fX5GSY8JOh/p3fU2yaINW09eqsPfPdWM7kB9wbX5VxhisH
 LipxJ+sVKITu1RyxMyEuvezMH1dsmxhopCUdQz5qwdrfKGkNS6a/Rf3D7ASIj6/OpiH7
 qnhQ==
X-Gm-Message-State: AOJu0YxhQrwHsLR1UUakqPD8jSXDU4do/3iwEjZFl/A3GK7asavYm4+K
 KQL8I5uOSJQBk7MhOFEvBtYOD+PfSoSNxRvPGhlgzRvreCksQG9Vy0oc6ysgTS/YAAzDrfr2e4S
 rGsSXqmbCSB9D+baaTHDK2mf8lf85zIX9xf9w/LrOWA+qZDQpq19chgbE4Ur8NpkRSeuqnvoYWk
 BwgwxZRmZLcWQi5v9lruC9ClqOwKkZYe0IijdHCzDR9T9U
X-Gm-Gg: AR+sD12dDD4Eidno9dSnMiY21B7OD6u8+YIYjoiEeftsNt5QXaT8BEqWodn99GfOBEa
 Rf8XcaJ6kN4D29575762VA3aSsA/r53EGk9mPiaIlCH8AVpMAupFApjnHaWS3JZZmdmAif5f6Ds
 2R02YJrmgeAy97ffdkVQsk4W5OoAz9rdAtiL28q1JvBac4ONdDEh8MzOIn
X-Received: by 2002:a05:6000:26c2:b0:47f:83fb:fc11 with SMTP id
 ffacd0b85a97d-47f83fbfcb8mr1469102f8f.21.1784662573201; 
 Tue, 21 Jul 2026 12:36:13 -0700 (PDT)
X-Received: by 2002:a05:6000:26c2:b0:47f:83fb:fc11 with SMTP id
 ffacd0b85a97d-47f83fbfcb8mr1469083f8f.21.1784662572756; Tue, 21 Jul 2026
 12:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <202607201914.LpAGsbXs-lkp@intel.com>
 <84a35e16f72330d6e7b2d6e969040f36959e2dad.1784630290.git.jstancek@redhat.com>
 <al/EgTw/D2mC42pT@gsse-cloud1.jf.intel.com>
 <al/FUZ78S7efgAp5@gsse-cloud1.jf.intel.com>
In-Reply-To: <al/FUZ78S7efgAp5@gsse-cloud1.jf.intel.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 21 Jul 2026 21:35:56 +0200
X-Gm-Features: AUfX_mzXBBHFS3r0RnlbVOi0ZATVs_ZY_4_xJWgm3zMd9-0C943AZ3W7B9hOlh4
Message-ID: <CAASaF6xm6ALX5gfoyUVyBAnf-CHf3Q6vrgug-qEas=ZSWP4Q2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/pagemap: Guard HPAGE_PMD_ORDER use with
 CONFIG_ARCH_ENABLE_THP_MIGRATION
To: Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rtb1YgHP5LUbDPUojTaZdJHjkXFHmIR4TRWKqchgGVw_1784662573
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jul 21, 2026 at 9:15=E2=80=AFPM Matthew Brost <matthew.brost@intel.=
com> wrote:
>
> On Tue, Jul 21, 2026 at 12:12:01PM -0700, Matthew Brost wrote:
> > On Tue, Jul 21, 2026 at 12:40:38PM +0200, Jan Stancek wrote:
> > > HPAGE_PMD_SHIFT expands to BUILD_BUG() when CONFIG_PGTABLE_HAS_HUGE_L=
EAVES
> > > is not set, causing a compile error when both CONFIG_TRANSPARENT_HUGE=
PAGE
> > > and CONFIG_HUGETLB_PAGE are disabled:
> > >
> > >  drivers/gpu/drm/drm_pagemap.c:480:12: error: call to '__compiletime_=
assert_458'
> > >  declared with 'error' attribute: BUILD_BUG failed
> > >    480 |                         order =3D HPAGE_PMD_ORDER;
> > >        |                                 ^
> > >  include/linux/huge_mm.h:117:26: note: expanded from macro 'HPAGE_PMD=
_ORDER'
> > >    117 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
> > >        |                          ^
> > >  include/linux/huge_mm.h:113:28: note: expanded from macro 'HPAGE_PMD=
_SHIFT'
> > >    113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> > >
> > > Guard the two HPAGE_PMD_ORDER uses with CONFIG_ARCH_ENABLE_THP_MIGRAT=
ION,
> > > matching the pattern used in migrate_device.c.
> > >
> > > Fixes: 139ab31aea8a ("drm/pagemap: Correct cpages calculation for mig=
rate_vma_setup")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/r/202607201914.LpAGsbXs-lkp@intel.com=
/
> > > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > > ---
> > >  drivers/gpu/drm/drm_pagemap.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_page=
map.c
> > > index 15c78eca180b..53a78752c8be 100644
> > > --- a/drivers/gpu/drm/drm_pagemap.c
> > > +++ b/drivers/gpu/drm/drm_pagemap.c
> > > @@ -578,10 +578,13 @@ static int drm_pagemap_cpages(unsigned long *mi=
grate_pfn, unsigned long npages)
> > >                     folio =3D page_folio(page);
> > >                     order =3D folio_order(folio);
> > >                     cpages +=3D NR_PAGES(order);
> > > -           } else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
> > > +           }
> > > +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> > > +           else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
> > >                     order =3D HPAGE_PMD_ORDER;
> >
> > Would it be do something like this at the top of the file...
> >
> > #ifdef HPAGE_PMD_ORDER
> > #define DRM_PAGEMAP_PMD_ORDER HPAGE_PMD_ORDER
> > #else
> > #define DRM_PAGEMAP_PMD_ORDER (-1)
> > #endif
> >
>
> Opps screwed my snippet up - HPAGE_PMD_ORDER seems to be always defined..=
.
>
> So actually...
>
> #if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)
> #define DRM_PAGEMAP_PMD_ORDER   HPAGE_PMD_ORDER
> #else
> define DRM_PAGEMAP_PMD_ORDER    (-1)
> #endif

Works for me.

Feel free to add:
Tested-by: Jan Stancek <jstancek@redhat.com>
if you'll be posting your version.

Thanks,
Jan

>
> Matt
>
> > Then in common code s/HPAGE_PMD_ORDER/DRM_PAGEMAP_PMD_ORDER/
> >
> > I think this works as we can never get to the MIGRATE_PFN_COMPOUND code
> > paths without CONFIG_ARCH_ENABLE_THP_MIGRATION enabled (see
> > mm/migrate_device.c).
> >
> > Also btw fixing the unrelated bug Sashiko flagged in this patch.
> >
> > Matt
> >
> > >                     cpages +=3D NR_PAGES(order);
> > >             }
> > > +#endif
> > >
> > >             i +=3D NR_PAGES(order);
> > >     }
> > > @@ -733,7 +736,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_page=
map_devmem *devmem_allocation,
> > >     own_pages =3D 0;
> > >
> > >     for (i =3D 0; i < npages;) {
> > > -           unsigned long j;
> > >             struct page *page =3D pfn_to_page(migrate.dst[i]);
> > >             struct page *src_page =3D migrate_pfn_to_page(migrate.src=
[i]);
> > >             unsigned int order =3D 0;
> > > @@ -763,7 +765,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pag=
emap_devmem *devmem_allocation,
> > >             }
> > >             migrate.dst[i] =3D migrate_pfn(migrate.dst[i]);
> > >
> > > +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> > >             if (migrate.src[i] & MIGRATE_PFN_COMPOUND) {
> > > +                   unsigned long j;
> > > +
> > >                     drm_WARN_ONCE(dpagemap->drm, src_page &&
> > >                                   folio_order(page_folio(src_page)) !=
=3D HPAGE_PMD_ORDER,
> > >                                   "Unexpected folio order\n");
> > > @@ -774,6 +779,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_page=
map_devmem *devmem_allocation,
> > >                     for (j =3D 1; j < NR_PAGES(order) && i + j < npag=
es; j++)
> > >                             migrate.dst[i + j] =3D 0;
> > >             }
> > > +#endif
> > >
> > >             drm_pagemap_get_devmem_page(page, order, zdd);
> > >
> > > --
> > > 2.52.0
> > >
>

