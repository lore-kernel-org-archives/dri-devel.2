Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31771CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0C110E1B8;
	Thu,  1 Oct 2026 06:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XjB9SPhx";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF5810E1B8
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:00:41 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-67109935888so5909735d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 23:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790834440; cv=none;
 d=google.com; s=arc-20260327;
 b=HAG/lw06w5Z2dG7xoEQTkImjmzx1AQTyEUBTqw3RUJ9qjJ+t00oSDzvik7zZCtbgsE
 CT0xvTru5m79PTA3ovxp4WVqpGKMwaivHunCKSzhV5ToM/JN2ixJl6RNvbCAS0Ku+++v
 h5Cd2xyB6oAvBH/eTlLFoVCNmg4L9xihOPI+gtpXQfTaOD4ZvNSSNjJ80NV4FLh3bEhH
 7yd0zPiXkFTA16TFO2TZSKaSaOtAt2Zta4urToNVtQk+ti2z4YTkqIQepddou0DPuQ9W
 fgTY91vpJU6Ivl1JxIE8+nF/X4UFR5bZV1t+qHOrV33vOJ97GKPtlYfGAU40RTMeGm90
 XYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xN7BcKnsbu8UTgMaoDBZRZB/C6V11nckFkUqzqAfWz0=;
 fh=rAxPypXgwmgYoJlA35lwVTKEftk9Z7yspQN3wWsxjeo=;
 b=AG1FxZ3T49AqxbOIfP5pRzZkOHxskSaTQpymg2gMfUpcQ9U1hssM/kBK0z+xeMCK+g
 PVojhiGJp3YxGqXEQethP3NtBTmH3QvLm6CjIDNIcSTI18RB/1MyWZpK/cjrMJ3vVNej
 D9DpBJoypQ1GtfMnVtxR7uPIKJALwjgHFu3KYSzy3BpYw/Xb+JyYpddceSs2567Q7Qjo
 KL2rCP+zrAay5PWC3roKyXjZaZo8V/yp2lqgnNGjpAwV65aIXNYNqnRIP3RlX7ce1Vxr
 yVGnyR53Led7uMzswmxjJOdh4vJMEXbV3CHT2GG/UOpo7u88D4cOVmzhJUph7RwilcAX
 xl1w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790834440; x=1791439240; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xN7BcKnsbu8UTgMaoDBZRZB/C6V11nckFkUqzqAfWz0=;
 b=XjB9SPhxwpPeVfsOLncxUxJYw4q1kYteZPKg/XE2qVvcSqn4GnPT/PAvShA5F0CMow
 fsH+73Z45juk0cvbUJPl5eX20u7BYmE38vb7Tj1DapnjxhcEPIZHDweTNi9uNUQiA3vN
 6KGgBZrY/BGKQSLWw6CItZnjlaGCRnKyTs7klCU2CeRQlTQNh/psr9Kk8lBB1lz9nXsY
 Fd0X2xEdQ5JA4ZXcGozZWwrBIWpEBuZvNX8zUhUvwsNk/n5jduUVqlUtULHsMqMRa4pM
 B3ydGIEMLKFapTvJ2mxUqxfVHbkUVuHA7cq+biNrX9SgNXD+Sr9nomFPMLcCevtLaJ0l
 WYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790834440; x=1791439240;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xN7BcKnsbu8UTgMaoDBZRZB/C6V11nckFkUqzqAfWz0=;
 b=kHybrn5jKQn2Cpo9t1LL8OeFJdgTafebUrlu6d3xxStKFk2SAsX0V4vPTECGb8Z7fh
 Px6uv7s7UUhk93FEM6s8HXhzpzS9N9q6GZ2yNaVcQ7uKjtced+qWLV6Kb/eCWGodJNpq
 8SW2cP2hd0h8UlVWOyXQOc82w4mgMVqvoN9fO0UTuU52jHiTlmUqJLcXIjIB89o1UfIl
 XIiTmkVCjjOSHDfmdBIE9VXXJ1iRhhkNAKHbE7kzL92aiv81TOY0/EaKs67qkIU48mMC
 T3ogc+WjkdBZY0lp8LsXV8qM9qmXd9PWXqSsd1OvcAPR0fMUjV8pJ6KQt3T0ZRB0Gh6/
 j/fQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByEsMv8QkLuTljNSZ4z2HacjA57P54PGQ+PhB4nuDrWwp8IWvu4ChiDEj6v7Ly2V2QX2xYjq8QBzTM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJzyWChUjzvMSIGjy+TTKtuOO5C5IcVRS2u4drCKhTRzmOS0nW3
 0iEkjkZCeOHx2Vm4dCe5Y4F1GBv5sVvS4Ot0HE8XqUiQL4meLCnVL5PoRgHDE8OhxFqf4biWFuk
 5v8vRlIyv1fB0D54ZbHZ5F8+Yie4JLes=
X-Gm-Gg: AYBFou3G6LtDmcG8GFSeLVxXtE5t1yoye3KG3HW8o3LE6JIAHeoXCAYxvpcBYhBx8GG
 8mXz3sD2DM9KAFekmcTtoMl931h/PsxWp0nDtcUzi+9h/rDuGpP/CN+BPXM4vRu/SEsmoEF/+u/
 cFFgzc7Aaa2DbOQybyHCNjq62jb2jfyUcpwe3oZ7zBVbElbr4BzOewW9YN5SPqNDaRq1CKunwQW
 tx8+Q2ngDbLGoiDLqRHfDxsUAVxLDbSgm0V+04WZ8SH7x3+z4fAAB75q8dqFVdt9DYfGfwKXMlx
 by9FeuF0IxQ6SXd8WlEX81H43SqqS0uAc/0BWEzp4SVKfZ5KxIsjSWUzddFM1QgKAJQ=
X-Received: by 2002:a05:690e:4419:b0:675:5fea:d08d with SMTP id
 956f58d0204a3-67683540c18mr1462188d50.95.1790834439646; Wed, 30 Sep 2026
 23:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
 <20260927-pvr-fixes-a-v1-3-7f5b18ab989a@gmail.com>
 <26a436bd27cc66407d776947c5f91ea7ae518600.camel@imgtec.com>
 <b15cab8d1c5074d702f8acc1924911e06076e25f.camel@imgtec.com>
In-Reply-To: <b15cab8d1c5074d702f8acc1924911e06076e25f.camel@imgtec.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 1 Oct 2026 15:00:28 +0900
X-Gm-Features: AclHuK-fQjrBk_jWbe2V4mvWX0gdKe-JZOGe_2GT2zX42Yv18CEwrrb6vROL82c
Message-ID: <CAKbEznsX8y_KAtEuk2Rp9VrcRbTO7Cn0B373ke5pGKvTq5GQOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/imagination: Size page table preallocation by
 device address
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
Cc: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, 
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, 
 "airlied@gmail.com" <airlied@gmail.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>, 
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
 "mripard@kernel.org" <mripard@kernel.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Sure!

On Thu, Oct 1, 2026 at 1:47=E2=80=AFPM Brajesh Gupta <Brajesh.Gupta@imgtec.=
com> wrote:
>
> On Mon, 2026-09-28 at 09:03 +0000, Brajesh Gupta wrote:
> > On Sun, 2026-09-27 at 17:25 +0900, Gyeyoung Baek wrote:
> Hi Gyeyoung,
> > Hi Gyeyoung,
> > > pvr_mmu_op_context_create() preallocates the page tables a mapping
> > > needs. How many is set by the device-virtual address being mapped, no=
t
> > > by the offset into the object's pages, which it used instead.
> > >
> > > Size the preallocation from the device address instead.
> > >
> > This issue is recently fixed under
> > https://patchwork.freedesktop.org/patch/755274/. Please have a look.
> >
> > Thanks,
> > Brajesh
> > > Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
> > > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> > > ---
> > >  drivers/gpu/drm/imagination/pvr_mmu.c | 27 ++++++++++++++-----------=
--
> > >  drivers/gpu/drm/imagination/pvr_mmu.h |  3 ++-
> > >  drivers/gpu/drm/imagination/pvr_vm.c  |  5 +++--
> > >  3 files changed, 19 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/=
imagination/pvr_mmu.c
> > > index 3e494bfa936..dd5f6d32864 100644
> > > --- a/drivers/gpu/drm/imagination/pvr_mmu.c
> > > +++ b/drivers/gpu/drm/imagination/pvr_mmu.c
> > > @@ -2335,7 +2335,8 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_=
op_context *op_ctx)
> > >   * pvr_mmu_op_context_create() - Create an MMU op context.
> > >   * @ctx: MMU context associated with owning VM context.
> > >   * @sgt: Scatter gather table containing pages pinned for use by thi=
s context.
> > > - * @sgt_offset: Start offset of the requested device-virtual memory =
mapping.
> > > + * @sgt_offset: Offset into @sgt of the start of the requested mappi=
ng.
> > > + * @device_addr: Device-virtual address at the start of the requeste=
d mapping.
> > >   * @size: Size in bytes of the requested device-virtual memory mappi=
ng. For an
> > >   * unmapping, this should be zero so that no page tables are allocat=
ed.
> > >   *
> > > @@ -2346,7 +2347,7 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_=
op_context *op_ctx)
> > >   */
> > >  struct pvr_mmu_op_context *
> > >  pvr_mmu_op_context_create(struct pvr_mmu_context *ctx, struct sg_tab=
le *sgt,
> > > -                     u64 sgt_offset, u64 size)
> > > +                     u64 sgt_offset, u64 device_addr, u64 size)
> > >  {
> > >     int err;
> > >
> > > @@ -2362,18 +2363,18 @@ pvr_mmu_op_context_create(struct pvr_mmu_cont=
ext *ctx, struct sg_table *sgt,
> > >
> > >     if (size) {
> > >             /*
> > > -            * The number of page table objects we need to prealloc i=
s
> > > -            * indicated by the mapping size, start offset and the si=
zes
> > > -            * of the areas mapped per PT or PD. The range calculatio=
n is
> > > -            * identical to that for the index into a table for a dev=
ice
> > > -            * address, so we reuse those functions here.
> > > +            * The page tables needed are set by the device-virtual r=
ange
> > > +            * being mapped: one level 1 table per 1GiB region and on=
e
> > > +            * level 0 table per 2MiB region the range touches. Table=
s that
> > > +            * already exist are not consumed, so this is an upper bo=
und.
> > >              */
> > > -           const u32 l1_start_idx =3D pvr_page_table_l2_idx(sgt_offs=
et);
> > > -           const u32 l1_end_idx =3D pvr_page_table_l2_idx(sgt_offset=
 + size);
> > > -           const u32 l1_count =3D l1_end_idx - l1_start_idx + 1;
> > > -           const u32 l0_start_idx =3D pvr_page_table_l1_idx(sgt_offs=
et);
> > > -           const u32 l0_end_idx =3D pvr_page_table_l1_idx(sgt_offset=
 + size);
> > > -           const u32 l0_count =3D l0_end_idx - l0_start_idx + 1;
> > > +           const u64 last_addr =3D device_addr + size - 1;
> > > +           const u64 l1_count =3D
> > > +                   (last_addr >> ROGUE_MMUCTRL_VADDR_PC_INDEX_SHIFT)=
 -
> > > +                   (device_addr >> ROGUE_MMUCTRL_VADDR_PC_INDEX_SHIF=
T) + 1;
> > > +           const u64 l0_count =3D
> > > +                   (last_addr >> ROGUE_MMUCTRL_VADDR_PD_INDEX_SHIFT)=
 -
> > > +                   (device_addr >> ROGUE_MMUCTRL_VADDR_PD_INDEX_SHIF=
T) + 1;
> > >
> We identified over allocation of page tables due to incorrect calculation=
 of end
> offset. And your change is correctly takes that into account.
> Can you please update your patch on top
> https://patchwork.freedesktop.org/patch/755274?
>
> Also update fixes tag to include https://patchwork.freedesktop.org/patch/=
755274?
>
> Thanks,
> Brajesh
>
> > >             /*
> > >              * Alloc and push page table entries until we have enough=
 of
> > > diff --git a/drivers/gpu/drm/imagination/pvr_mmu.h b/drivers/gpu/drm/=
imagination/pvr_mmu.h
> > > index a8ecd460168..7088f80805e 100644
> > > --- a/drivers/gpu/drm/imagination/pvr_mmu.h
> > > +++ b/drivers/gpu/drm/imagination/pvr_mmu.h
> > > @@ -99,7 +99,8 @@ dma_addr_t pvr_mmu_get_root_table_dma_addr(struct p=
vr_mmu_context *ctx);
> > >  void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx);
> > >  struct pvr_mmu_op_context *
> > >  pvr_mmu_op_context_create(struct pvr_mmu_context *ctx,
> > > -                     struct sg_table *sgt, u64 sgt_offset, u64 size)=
;
> > > +                     struct sg_table *sgt, u64 sgt_offset,
> > > +                     u64 device_addr, u64 size);
> > >
> > >  int pvr_mmu_map(struct pvr_mmu_op_context *op_ctx, u64 size, u64 fla=
gs,
> > >             u64 device_addr);
> > > diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/i=
magination/pvr_vm.c
> > > index c5ae0b79fe6..7bb58ca14e4 100644
> > > --- a/drivers/gpu/drm/imagination/pvr_vm.c
> > > +++ b/drivers/gpu/drm/imagination/pvr_vm.c
> > > @@ -276,7 +276,8 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bi=
nd_op,
> > >             goto err_bind_op_fini;
> > >
> > >     bind_op->mmu_op_ctx =3D
> > > -           pvr_mmu_op_context_create(vm_ctx->mmu_ctx, sgt, offset, s=
ize);
> > > +           pvr_mmu_op_context_create(vm_ctx->mmu_ctx, sgt, offset,
> > > +                                     device_addr, size);
> > >     err =3D PTR_ERR_OR_ZERO(bind_op->mmu_op_ctx);
> > >     if (err) {
> > >             bind_op->mmu_op_ctx =3D NULL;
> > > @@ -318,7 +319,7 @@ pvr_vm_bind_op_unmap_init(struct pvr_vm_bind_op *=
bind_op,
> > >     }
> > >
> > >     bind_op->mmu_op_ctx =3D
> > > -           pvr_mmu_op_context_create(vm_ctx->mmu_ctx, NULL, 0, 0);
> > > +           pvr_mmu_op_context_create(vm_ctx->mmu_ctx, NULL, 0, 0, 0)=
;
> > >     err =3D PTR_ERR_OR_ZERO(bind_op->mmu_op_ctx);
> > >     if (err) {
> > >             bind_op->mmu_op_ctx =3D NULL;
> > >
> >
>


--=20
Thanks,
Gyeyoung
