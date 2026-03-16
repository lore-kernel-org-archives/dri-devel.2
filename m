Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB45F4644B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FE410E165;
	Mon, 16 Mar 2026 10:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="eFppJ663";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC40510E165
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 10:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773658437;
 bh=3/krYZ6GCvKnFIo/XDaVM+GqnlDdX+4GULBc07rBNEY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=eFppJ663mV+RnAiVhVjBzClTNPryo4e15RGAJX7qWbXVQhQPibU7XIgYyqpbTOxsA
 pCbq6TAz6xn00DcoGfZeJP79fC+kUIaVHhMAYYwtkYY/zG1rHwNjAEaAn7Nt9GJq+u
 l7KqLlOvNUHDO1aCb2KKl9+z7WLT9bgZSuN4waZwCQh7RRRgJmyqi1D6nFBe14/x4A
 x4r8WkjRRd0/aM0hWphIj6b+rcDofoepfTEFcZUeoFyw4NcKtoVF5rCXOjOUGhJfxW
 w2azexyPaYH79DqqH7TAY1oZDQCgrs1BoBcFE9HIqYPKRDO8V8VrOWA34d/rpAFiPe
 orNi/w2JzV6Ug==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 104AB17E0D04;
 Mon, 16 Mar 2026 11:53:57 +0100 (CET)
Date: Mon, 16 Mar 2026 11:53:53 +0100
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
Message-ID: <20260316115353.45fadc81@fedora>
In-Reply-To: <21f56de3-ec1a-4d7b-8abf-c538584e18b2@suse.de>
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
 <20260316103621.6ed48b68@fedora>
 <21f56de3-ec1a-4d7b-8abf-c538584e18b2@suse.de>
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

On Mon, 16 Mar 2026 11:22:49 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Hi
>=20
> Am 16.03.26 um 10:36 schrieb Boris Brezillon:
> [...]
> >> This would keep the huge-page code within the first branch. And if it
> >> fails, it still does the regular page fault. =20
> > Well, in practice that's not what we want anyway (see the other fix for
> > the huge_fault vs regular fault race), so I'd still be inclined to have
> > the folio_mark_accessed() handled in the common path and have the pmd
> > vs regular pfn insertion in some if/else branches. Something like that:
> >
> > 	if (pmd_insert)
> > 		ret =3D drm_gem_shmem_try_insert_pfn_pmd(vmf, pfn);
> > 	else
> > 		ret =3D vmf_insert_pfn(vma, vmf->address, pfn);
> >
> > 	if (ret =3D=3D VM_FAULT_NOPAGE) {
> > 		folio_mark_accesed(folio);
> >
> > 		/* Normal pages are mapped RO, and remapped RW afterwards. */
> > 		if (pmd_insert && vmf->flags & FAULT_FLAG_WRITE) =20
>=20
> This style mixes conditions from different branching depths. The first=20
> outermost branch uses pmd_insert to compute ret.=C2=A0 Any then both have=
=20
> changed places, so that ret is in the outer branch and pmd_insert is in=20
> the inner branch.=C2=A0 This is hard to maintain. It is already confusing=
 now=20
> and will be even more so to anyone locking at that code later on.

I guess that's another occurrence of us disagreeing on what's
easy/uneasy to maintain :P. I find it way easier to group things by
functionality (here that would be folio state tracking) at the cost of
having conditionals repeated (I trust the compiler to do the proper
optimization) than having multiple paths doing exactly the same thing.
The latter easily leads to one path being updated while the other path
is left behind when new features/fixes are proposed.
