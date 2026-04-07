Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08808FEEF25
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 11:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DABE10E360;
	Tue,  7 Apr 2026 11:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hKkWQ6sS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2246E10E360
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775561640;
 bh=D8ka4Lz2F3kFrY5Ld0l5o2hG0FQe3kY8fqN4fXLLx9Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hKkWQ6sSxbYFtjFW1B07Q2CGi9+10NkW/pxlepgTakjBoQGQK1YWl54AEqtSw9ZSk
 juQQ36V/QtI6hWXuMQX4S074Amy+hmTFI+si2scRN0AmQd0GtZO94KMUmkivBg2OxC
 NlFn0pDN40uS+DMuKxrWYuXbxnDvzqYSKlrCXG6QzMImyRpt+fOp1lcyshQoU0QaOo
 hSO50SGwG3ZYQXE/SgtuKc+4Rrr0o2s68e6G6NsL+eDgjb/mSPA2nuQLN2KXjn78XU
 uvgQKO1z3n3g4KTUVrX0uDyoqFZruL7oIEpvSC+w+i/tPC8dkX/tyX2Y0AVuoouEPk
 qOSIWtUlho1Xw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E68817E0A2D;
 Tue,  7 Apr 2026 13:34:00 +0200 (CEST)
Date: Tue, 7 Apr 2026 13:33:54 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven Price
 <steven.price@arm.com>, kernel@collabora.com, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 1/2] drm/panthor: Extend VM locked region for remap case
 to be a superset
Message-ID: <20260407133354.0aaf882b@fedora>
In-Reply-To: <adTlbwHZsbCFhU-f@e142607>
References: <20260403172116.3424075-1-adrian.larumbe@collabora.com>
 <adTbdH653uY4CxWh@e142607> <20260407124353.0364f536@fedora>
 <adTlbwHZsbCFhU-f@e142607>
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

On Tue, 7 Apr 2026 12:07:27 +0100
Liviu Dudau <liviu.dudau@arm.com> wrote:

> On Tue, Apr 07, 2026 at 12:43:53PM +0200, Boris Brezillon wrote:
> > On Tue, 7 Apr 2026 11:24:52 +0100
> > Liviu Dudau <liviu.dudau@arm.com> wrote:
> >  =20
> > > On Fri, Apr 03, 2026 at 06:21:11PM +0100, Adri=C3=A1n Larumbe wrote: =
=20
> > > > In the event of an sm_step_remap() that leads to a partial unmap of=
 a
> > > > transparent huge page, the new locked region required by an extende=
d unmap
> > > > might not be a superset of the original one. Then, if it leaves a p=
ortion
> > > > of the initially requested one out, the ensuing map will trigger a =
warning.
> > > >=20
> > > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > > > Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge p=
ages")
> > > > ---
> > > >  drivers/gpu/drm/panthor/panthor_mmu.c | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/dr=
m/panthor/panthor_mmu.c
> > > > index fa8b31df85c9..2b96359d3b94 100644
> > > > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > > > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > > > @@ -1709,6 +1709,19 @@ static int panthor_vm_lock_region(struct pan=
thor_vm *vm, u64 start, u64 size)
> > > >  	    start + size <=3D vm->locked_region.start + vm->locked_region=
.size)
> > > >  		return 0;
> > > > =20
> > > > +	/* sm_step_remap() may need a locked region that isn't a strict s=
uperset
> > > > +	 * of the original one because of having to extend unmap boundari=
es beyond
> > > > +	 * it to deal with partial unmaps of transparent huge pages. What=
 we want
> > > > +	 * in those cases is to lock the union of both regions.
> > > > +	 */
> > > > +	if (vm->locked_region.size) {   =20
> > >=20
> > > Why is this check needed? We're updating the vm->locked_region.size l=
ater anyway, and I think
> > > we can cope with a locked region being of zero size when we are calle=
d, unless we consider that
> > > to be a bug and we should check earlier for a zero value. =20
> >=20
> > It's here to detect if this is the initial lock (=3D=3D0), or the one
> > that's done in sm_step_remap() (!=3D0). If we drop this conditional, the
> > adjusted start will always be zero on the initial lock, because both
> > vm->locked_region.start and vm->locked_region.size are zero in that
> > case (see panthor_vm_unlock_region()). =20
>=20
> It makes sense to test the vm->locked_region.start being zero, not the vm=
->locked_region.size.
>=20
> In your suggested update of the math, I would go:
>=20
> 	if (vm->locked_region.start)
> 		start =3D min(start, vm->locked_region.start);

Well, you'd still need the vm->locked_region.size > 0 check for the
size update, because vm->locked_region.size > 0 and
vm->locked_region.start =3D=3D 0 is allowed. In practice it won't
happen because we reserve the first 32M of the VA space in
mesa(panvk,gallium), but that's not enforced by the kernel, so I still
believe the check should be vm->locked_region.size > 0 rather than
vm->locked_region.start > 0.

>=20
> >  =20
> > >  =20
> > > > +		u64 end =3D start + size;   =20
> > >=20
> > > Like Boris pointed out, the calculations can be optimized so that we =
don't need this line.
> > >  =20
> > > > +
> > > > +		start =3D min(start, vm->locked_region.start);
> > > > +		size =3D max(vm->locked_region.start +
> > > > +			   vm->locked_region.size, end) - start;   =20
> > >=20
> > > If we have something like:
> > >=20
> > >  ..... [start .. start+size] ...... [vm->locked_region.start .. vm->l=
ocked_region.start + vm->locked_region.size] .... =20
> >=20
> > First off, that's not supposed to happen. =20
>=20
> Yeah, I was thinking from a defensive coding perspective where this funct=
ion gets attacked.

Fair enough. Let's add a WARN_ON_ONCE() and a comment explaining why the
overlap between old and new locked region is expected.
