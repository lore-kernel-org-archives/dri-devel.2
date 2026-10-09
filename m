Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8393CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF7AE1122C4;
	Fri,  9 Oct 2026 22:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aOmYC3dZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCD11122C4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791584593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZhswLSZpKcNuqso9AUUCoP5Qyu4krUXD3dNinpXBKU=;
 b=aOmYC3dZ60nvIVLlQdVEuMjjVBiBDWoAu8qaRhlKm6zeXV0rOt9ysUddAIxUn+x191gOuF
 IxoVyxi8qrR9V0KEBL6yEcO6R18AHf7bMpS5ErGZjDUxqw/2t9JESYAES3Wf+RYqnRhHiv
 Awh4z6wl6V5gQZiBVqlHoS7M/V66h5k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-0U_uglncNLOoKLQ9fPUmtw-1; Fri, 9 Oct 2026 22:23:12 +0000
X-MC-Unique: 0U_uglncNLOoKLQ9fPUmtw-1
X-Mimecast-MFC-AGG-ID: 0U_uglncNLOoKLQ9fPUmtw_1791584592
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917a3c27c9bso5911936d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 15:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791584591; x=1792189391;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1kJjybFGSYZCppzp0ILAQK86Y2LNrWWZ0v/kRNoEipQ=;
 b=pohZVi5JOn7xII+4ZsintNN7WVaMVx4pHI7I/ORmLfSKXjxnV61SETrXLDvpyYUwvR
 onfJ6kjT6gwUIUEUTdHscf+e2Wy5VGp6pxicgTN0DRzXVw6mN7JSVqe1VDbXVXM96SNw
 mLaKthKO1cBzEagtH5hezCGV4lGp0O8jhSGWtPYJCDkNizOsNuhBWeDMetGoS/on0MEH
 eibkWmNdYLqADcKrHPIL23Bv+J8iI1+f9qOtpxcNBWOqBNdZQEBx2RvZBdR+rqitKHfq
 PA1OPpqXy4p5tmyOiYSvvYp5Vp6gljbLJNljfqF+b1rDjGomVYUoJZLW5FpMnN12Gabn
 qtrw==
X-Gm-Message-State: AFq9FYKBN1P6FvRHPeqPZ3nRnk6jYN5F5wc5QOrmv1QRgoBmShONm3iy
 F4bIywZyoJ9v4DNECPeaja2I7IMJE6RNKKDDTckkJqcMPStrV9rsy16O1uGDLySNm9OkWHQ+w5X
 f3LTgqoIf760GFo1IPF+/1zFwXBA5KT5CiuWu0sGLPIIlPgevf0abKzRGPGsBwm0igiGsrg==
X-Gm-Gg: AYBFou2t3ZPEAHTLec8rPaN6bUC4FKOcPDza+YqTavfxp2yKpUsGvMdyc5qkmDpx8HF
 N6Tu6u778muCJEQsmZFbCPaKUYW1NnlbONzctDk2V0lBRi73sYE5GbWAgZ2DwYoJ85+Bg4EQnof
 d33NFow1+3pCaMaWD+A5j3qFS4IrVwDTNc8qId2qZMzPX2d1bRksfJgBObgN4lxEOPMA2pXNxi5
 8SOBL0+giRFYd9Df8Gd9/tFYl8cEMoIW0aZ8dBZ9zKSVQ2cvmWcN272q6JUMFgwfpeZWeDDGLIo
 s/x79lEatrY9IUtJlZvWbC9scEzIIgta4aRa3gaSCddzqMDQncTr2RUJ86pzWlhT2p8pIRA=
X-Received: by 2002:a05:6214:769:b0:912:54f7:aea3 with SMTP id
 6a1803df08f44-91b5534d151mr61194206d6.1.1791584591466; 
 Fri, 09 Oct 2026 15:23:11 -0700 (PDT)
X-Received: by 2002:a05:6214:769:b0:912:54f7:aea3 with SMTP id
 6a1803df08f44-91b5534d151mr61193756d6.1.1791584590983; 
 Fri, 09 Oct 2026 15:23:10 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b55017565sm29165376d6.15.2026.10.09.15.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:23:10 -0700 (PDT)
Message-ID: <f3576e4263b19d183e343eac9c56d4fc8385b431.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau/uvmm: reject replace across page sizes
From: lyude@redhat.com
To: moonafterrain@outlook.com, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>, Balbir Singh	 <balbirs@nvidia.com>, Mary
 Guillemard <mary@mary.zone>, Mohamed Ahmed	
 <mohamedahmedegypt2001@gmail.com>, James Jones <jajones@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
Date: Fri, 09 Oct 2026 18:23:09 -0400
In-Reply-To: <9041ce7f5d6ae30213aa1ab895a4225fb33246ed.camel@redhat.com>
References: <20261009-nouveau-fixes-v2-1-a0b71bf8df1b@outlook.com>
 <9041ce7f5d6ae30213aa1ab895a4225fb33246ed.camel@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dIPDc5eXbBpu3XeEVT12hq0tPSLxKPyTgsCUpIkf5tM_1791584592
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

Wait-nope, hold on. Was double checking this to make sure there wasn't
anything I missed, and the sashiko comment I'm seeing looks quite
legitimate. Mind dropping my R-b and addressing that if it looks
legitimate?

On Fri, 2026-10-09 at 18:19 -0400, lyude@redhat.com wrote:
> Looks good to me, will push to drm-misc-fixes in a moment.
>=20
> On Fri, 2026-10-09 at 16:52 +0800, Junrui Luo via B4 Relay wrote:
> > From: Junrui Luo <moonafterrain@outlook.com>
> >=20
> > A new mapping takes over the page tables of the mappings it
> > replaces.
> > nouveau_uvmm_sm_prepare() only acquires page tables for the range
> > no
> > existing mapping covers, and the map path frees the replaced
> > mappings
> > without putting their references. That is only valid while all of
> > them
> > use the same page size, which select_page_shift() no longer
> > guarantees.
> >=20
> > Rebinding a GART BO over a 2MiB VRAM BO therefore leaves the new
> > mapping
> > owning page tables built for a different page size, and it then
> > maps
> > at a
> > size that was never referenced over that range. Since raw map does
> > not
> > allocate, nvkm_vmm_iter() can walk down to a NULL leaf and
> > dereference
> > it. The remainders of a split have the same problem:
> > op_map_prepare()
> > recomputes a page size with select_page_shift() while the remainder
> > keeps
> > the parent's page tables, so a parent that was itself downgraded
> > can
> > leave
> > a remainder that re-aligns to a larger size. This happens on the
> > unmap
> > path too.
> >=20
> > Reject the bind, and make split remainders inherit the page size of
> > the
> > mapping they are split from.
> >=20
> > Fixes: c488a94e7e14 ("drm/nouveau/uvmm: Allow larger pages")
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Assisted-by: LLM
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > ---
> > Changes in v2:
> > - Drop patch 1, which has been merged.
> > - Use the abbreviated conditional operator for page_shift (Lyude
> > Paul).
> > - Compare against remap_args.page_shift (Lyude Paul).
> > - Use Assisted-by: LLM (Balbir Singh).
> > - Add Lyude's Reviewed-by.
> > - Link to v1:
> > https://lore.kernel.org/r/20260817-nouveau-fixes-v1-0-f518d0c735f3@outl=
ook.com
> > ---
> > =C2=A0drivers/gpu/drm/nouveau/nouveau_uvmm.c | 32
> > +++++++++++++++++++++++++++++++-
> > =C2=A01 file changed, 31 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > index f5e4756b4de4..aa5b93808f41 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > @@ -85,6 +85,8 @@ struct uvmm_map_args {
> > =C2=A0=09u64 addr;
> > =C2=A0=09u64 range;
> > =C2=A0=09u8 kind;
> > +=09/* Page size to give the new mapping, or 0 to derive it
> > from
> > the op. */
> > +=09u8 page_shift;
> > =C2=A0};
> > =C2=A0
> > =C2=A0static int
> > @@ -655,7 +657,7 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
> > =C2=A0
> > =C2=A0=09uvma->region =3D args->region;
> > =C2=A0=09uvma->kind =3D args->kind;
> > -=09uvma->page_shift =3D select_page_shift(uvmm, op);
> > +=09uvma->page_shift =3D args->page_shift ?:
> > select_page_shift(uvmm, op);
> > =C2=A0
> > =C2=A0=09drm_gpuva_map(&uvmm->base, &uvma->va, op);
> > =C2=A0
> > @@ -684,8 +686,20 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm
> > *uvmm,
> > =C2=A0=09struct drm_gpuva_op *op;
> > =C2=A0=09u64 vmm_get_start =3D args ? args->addr : 0;
> > =C2=A0=09u64 vmm_get_end =3D args ? args->addr + args->range : 0;
> > +=09u8 map_page_shift =3D 0;
> > =C2=A0=09int ret;
> > =C2=A0
> > +=09/* A new mapping takes over the page tables of the
> > mappings
> > it replaces,
> > +=09 * so every one of them has to be using its page size. The
> > new mapping
> > +=09 * is the last op drm_gpuvm_sm_map_ops_create() emits.
> > +=09 */
> > +=09if (args) {
> > +=09=09struct drm_gpuva_op *last =3D
> > drm_gpuva_last_op(ops);
> > +
> > +=09=09if (last->op =3D=3D DRM_GPUVA_OP_MAP)
> > +=09=09=09map_page_shift =3D select_page_shift(uvmm,
> > &last->map);
> > +=09}
> > +
> > =C2=A0=09drm_gpuva_for_each_op(op, ops) {
> > =C2=A0=09=09switch (op->op) {
> > =C2=A0=09=09case DRM_GPUVA_OP_MAP: {
> > @@ -713,11 +727,22 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm
> > *uvmm,
> > =C2=A0=09=09=09struct uvmm_map_args remap_args =3D {
> > =C2=A0=09=09=09=09.kind =3D uvma_from_va(va)->kind,
> > =C2=A0=09=09=09=09.region =3D uvma_from_va(va)-
> > >region,
> > +=09=09=09=09/* The remainders of the split
> > keep
> > the page
> > +=09=09=09=09 * tables of the mapping they are
> > split from,
> > +=09=09=09=09 * so they must keep its page size
> > too.
> > +=09=09=09=09 */
> > +=09=09=09=09.page_shift =3D uvma_from_va(va)-
> > > page_shift,
> > =C2=A0=09=09=09};
> > =C2=A0=09=09=09u64 ustart =3D va->va.addr;
> > =C2=A0=09=09=09u64 urange =3D va->va.range;
> > =C2=A0=09=09=09u64 uend =3D ustart + urange;
> > =C2=A0
> > +=09=09=09if (map_page_shift &&
> > +=09=09=09=C2=A0=C2=A0=C2=A0 remap_args.page_shift !=3D
> > map_page_shift)
> > {
> > +=09=09=09=09ret =3D -EINVAL;
> > +=09=09=09=09goto unwind;
> > +=09=09=09}
> > +
> > =C2=A0=09=09=09op_unmap_prepare(r->unmap);
> > =C2=A0
> > =C2=A0=09=09=09if (r->prev) {
> > @@ -756,6 +781,11 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm
> > *uvmm,
> > =C2=A0=09=09=09u64 uend =3D ustart + urange;
> > =C2=A0=09=09=09u8 page_shift =3D uvma_from_va(va)-
> > > page_shift;
> > =C2=A0
> > +=09=09=09if (map_page_shift && page_shift !=3D
> > map_page_shift) {
> > +=09=09=09=09ret =3D -EINVAL;
> > +=09=09=09=09goto unwind;
> > +=09=09=09}
> > +
> > =C2=A0=09=09=09op_unmap_prepare(u);
> > =C2=A0
> > =C2=A0=09=09=09if (!args)
> >=20
> > ---
> > base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
> > change-id: 20260817-nouveau-fixes-23877845c3ab
> >=20
> > Best regards,

