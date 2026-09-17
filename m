Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65387C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 19:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AEF210F079;
	Thu, 17 Sep 2026 19:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Rj1GNTKa";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8E110F079
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 19:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789675001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvyG8B+fTniu1RjcrQ+hup/WdRBYqNwBYbowJ0pVU/M=;
 b=Rj1GNTKaG1bYVXhF/FwaXbV2UAUrVXUjjgCh7daD+5NM8aPPEolctXYfG8CV44pf2ByWe0
 MAPfVFU3J7eW1SKQfGfK0ev43aRZch1C9TwYklRse7IO4zP+vXT5H++LFlrIO6GUT1LPp2
 qZ/+GyX8wmacXTZhC5rrmZCBMRDCZD8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-wYesqY1HPIyWy1MW4APKIg-1; Thu, 17 Sep 2026 15:56:39 -0400
X-MC-Unique: wYesqY1HPIyWy1MW4APKIg-1
X-Mimecast-MFC-AGG-ID: wYesqY1HPIyWy1MW4APKIg_1789674999
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93903622880so260444185a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789674999; x=1790279799;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SK8FkV9t4hK7QEUa6h1DUFLUc29+3sFP86iMsPEZQZY=;
 b=UvdYcog2LXRViQ8xXtNLVj9xi8PCGrWOE81aPhXAojnGXMjXpaNS7t1EM2xwy/xw3W
 QlpaOJnfhVi8iPVXCo86+0JJIKvXxkZOo3CqFGQ02zJ9e3FH0S7WLf76OctNeGH5xLif
 UHr0wEWM4e1qnsRzUL0Szo4Xe6jTalb3Gb58iGQBaEtxaAWk8pA6k0xRbPi03b0+KCLc
 DblMeDWm4yxjdIo/L1GY2nWQxAa7gwNERe23/rDtsDcZz7npMUk2ceqMbbgpvKHuf6Xi
 DjzUo8Iqa2I9fQG4IpqDYeL0z0re+HlpWR40Y+h4toGGIaAYmvB6znYfDHqYswODqzk0
 vgaQ==
X-Gm-Message-State: AFuF++lZG5svKHfNyjLw1EJcSd+Nr24WLyHHk5IFPtx8u1/Y04Lx1qq6
 BDl3bO2Q1e5puT8QamO4/6QXRd4Ab3rR/5STD+yhgViJSXk4k4hA9/a7aPdcn4/wjH7ZW0wga2X
 1bOLJ9iOIBJggeFaIc6391To9+KVwrlLV+KVZlnA/V9Hjn/Q0cGoxwPtUopco2iVn31hZvA==
X-Gm-Gg: AYBFou3ugYxqelJRZfMtY7qRFgarxKcZFqjIwu9dMaGObrKoilWs8BqvRrnB9eyKJht
 ObiE5HRcAyb/3wzwbCFxuxAA+4eoiELT9xuN7p5oxU0INisz/4U/B3biekBkZKXC05Eds4r6bFI
 zPdX60j1PneosuuSy7ZfndaFBlwBHubZ0yEMFHullRcGkfr6CtY31sQ9xWkiVFOADdgLpwCRzJL
 CgRR4GCt3MDULXCs1zATmh9AEhhBlZHe3tMBVYcXDyYIvYBfGIAHg1we1tBK9gmJmUKhrltisYP
 0KSDEaY19lH+AGprJd9Hi4trQS/zeNkjSl0ezO8UohtUWeMgUxRFqjQVSptQ94vaPAOdMPkw
X-Received: by 2002:a05:620a:4055:b0:939:a45:8c96 with SMTP id
 af79cd13be357-93bc62c0d2amr633010985a.19.1789674999132; 
 Thu, 17 Sep 2026 12:56:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4055:b0:939:a45:8c96 with SMTP id
 af79cd13be357-93bc62c0d2amr633006785a.19.1789674998638; 
 Thu, 17 Sep 2026 12:56:38 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b7825b6d3sm538457085a.31.2026.09.17.12.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:56:38 -0700 (PDT)
Message-ID: <f21df5ff995cba8272f3bfb30c0129a76e2cf3ed.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm/nouveau/uvmm: reject replace across page sizes
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
Date: Thu, 17 Sep 2026 15:56:37 -0400
In-Reply-To: <20260817-nouveau-fixes-v1-2-f518d0c735f3@outlook.com>
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
 <20260817-nouveau-fixes-v1-2-f518d0c735f3@outlook.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NtgLiQMzi1HhSQSYwyuAVKY2yFLaV2hkCW6OINoSTzs_1789674999
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

Changes down below:

On Mon, 2026-08-17 at 14:50 +0800, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
>=20
> A new mapping takes over the page tables of the mappings it replaces.
> nouveau_uvmm_sm_prepare() only acquires page tables for the range no
> existing mapping covers, and the map path frees the replaced mappings
> without putting their references. That is only valid while all of
> them
> use the same page size, which select_page_shift() no longer
> guarantees.
>=20
> Rebinding a GART BO over a 2MiB VRAM BO therefore leaves the new
> mapping
> owning page tables built for a different page size, and it then maps
> at a
> size that was never referenced over that range. Since raw map does
> not
> allocate, nvkm_vmm_iter() can walk down to a NULL leaf and
> dereference
> it. The remainders of a split have the same problem: op_map_prepare()
> recomputes a page size with select_page_shift() while the remainder
> keeps
> the parent's page tables, so a parent that was itself downgraded can
> leave
> a remainder that re-aligns to a larger size. This happens on the
> unmap
> path too.
>=20
> Reject the bind, and make split remainders inherit the page size of
> the
> mapping they are split from.
>=20
> Fixes: c488a94e7e14 ("drm/nouveau/uvmm: Allow larger pages")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_uvmm.c | 33
> ++++++++++++++++++++++++++++++++-
> =C2=A01 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index f5e4756b4de4..6404c54d097c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -85,6 +85,8 @@ struct uvmm_map_args {
> =C2=A0=09u64 addr;
> =C2=A0=09u64 range;
> =C2=A0=09u8 kind;
> +=09/* Page size to give the new mapping, or 0 to derive it from
> the op. */
> +=09u8 page_shift;
> =C2=A0};
> =C2=A0
> =C2=A0static int
> @@ -655,7 +657,8 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
> =C2=A0
> =C2=A0=09uvma->region =3D args->region;
> =C2=A0=09uvma->kind =3D args->kind;
> -=09uvma->page_shift =3D select_page_shift(uvmm, op);
> +=09uvma->page_shift =3D args->page_shift ? args->page_shift :
> +=09=09=09=C2=A0=C2=A0 select_page_shift(uvmm, op);

This can just be:

   args->page_shift ?: select_page_shift(uvmm, op);

> =C2=A0
> =C2=A0=09drm_gpuva_map(&uvmm->base, &uvma->va, op);
> =C2=A0
> @@ -684,8 +687,20 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm
> *uvmm,
> =C2=A0=09struct drm_gpuva_op *op;
> =C2=A0=09u64 vmm_get_start =3D args ? args->addr : 0;
> =C2=A0=09u64 vmm_get_end =3D args ? args->addr + args->range : 0;
> +=09u8 map_page_shift =3D 0;
> =C2=A0=09int ret;
> =C2=A0
> +=09/* A new mapping takes over the page tables of the mappings
> it replaces,
> +=09 * so every one of them has to be using its page size. The
> new mapping
> +=09 * is the last op drm_gpuvm_sm_map_ops_create() emits.
> +=09 */
> +=09if (args) {
> +=09=09struct drm_gpuva_op *last =3D drm_gpuva_last_op(ops);
> +
> +=09=09if (last->op =3D=3D DRM_GPUVA_OP_MAP)
> +=09=09=09map_page_shift =3D select_page_shift(uvmm,
> &last->map);
> +=09}
> +
> =C2=A0=09drm_gpuva_for_each_op(op, ops) {
> =C2=A0=09=09switch (op->op) {
> =C2=A0=09=09case DRM_GPUVA_OP_MAP: {
> @@ -713,11 +728,22 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm
> *uvmm,
> =C2=A0=09=09=09struct uvmm_map_args remap_args =3D {
> =C2=A0=09=09=09=09.kind =3D uvma_from_va(va)->kind,
> =C2=A0=09=09=09=09.region =3D uvma_from_va(va)->region,
> +=09=09=09=09/* The remainders of the split keep
> the page
> +=09=09=09=09 * tables of the mapping they are
> split from,
> +=09=09=09=09 * so they must keep its page size
> too.
> +=09=09=09=09 */
> +=09=09=09=09.page_shift =3D uvma_from_va(va)-
> >page_shift,
> =C2=A0=09=09=09};
> =C2=A0=09=09=09u64 ustart =3D va->va.addr;
> =C2=A0=09=09=09u64 urange =3D va->va.range;
> =C2=A0=09=09=09u64 uend =3D ustart + urange;
> =C2=A0
> +=09=09=09if (map_page_shift &&
> +=09=09=09=C2=A0=C2=A0=C2=A0 uvma_from_va(va)->page_shift !=3D
> map_page_shift) {

Let's just take this value from remap_args instead of doing
uvma_from_va(va), it makes it a bit easier for people to understand
what's happening here.

With those nitpicks fixed:

Reviewed-by: Lyude Paul <lyude@redhat.com>

> +=09=09=09=09ret =3D -EINVAL;
> +=09=09=09=09goto unwind;
> +=09=09=09}
> +
> =C2=A0=09=09=09op_unmap_prepare(r->unmap);
> =C2=A0
> =C2=A0=09=09=09if (r->prev) {
> @@ -756,6 +782,11 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm
> *uvmm,
> =C2=A0=09=09=09u64 uend =3D ustart + urange;
> =C2=A0=09=09=09u8 page_shift =3D uvma_from_va(va)-
> >page_shift;
> =C2=A0
> +=09=09=09if (map_page_shift && page_shift !=3D
> map_page_shift) {
> +=09=09=09=09ret =3D -EINVAL;
> +=09=09=09=09goto unwind;
> +=09=09=09}
> +
> =C2=A0=09=09=09op_unmap_prepare(u);
> =C2=A0
> =C2=A0=09=09=09if (!args)

