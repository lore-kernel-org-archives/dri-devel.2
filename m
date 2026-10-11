Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A07CCA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 05:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704E610E0CC;
	Sun, 11 Oct 2026 05:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dfk2EvTT";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7E510E0CC
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 05:31:12 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-67921b515a6so520073d50.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 22:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791696671; cv=none;
 d=google.com; s=arc-20260327;
 b=HZEdMxZ4ZC2LVgIma3RpURqo8sZI+g7/fcdfopBlfzHfm+efodGn8MwTMQy89JM8YX
 xl5gVEL+kteWuwutU8BGWQa/npG5Xv6jZiN6vt3p0b5zga318GCiCgRCj7MOgyawn6rf
 Dckpx6MmBha0aQc4GzZxACkDDh7qpMVqvTW6EdgfNFIgR1AbAjeSlzG+g6dm9gXlumwg
 L1APysyTDCCOE5+t7cqPrj45FAC0RxDaIvlGtCBmk409biaXbAIDIQ64W8slBceqRGIP
 LJhahjml9vOVAC/+AkEzP9zQ8kdBO8OBD2GzrQH7USkUCnc6Ah2blz891J2YKESgFDJP
 Eu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d64AKkfex8ucpkLV8OFICHb4YHT2ZbkVzlb3XcqNv34=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=LW75u7rk1nH0DbSqTerN78q9P+kmKYXtq/l7s3wo8rLdWU2DsgwB8rrO/WeG+J+FIn
 6FkiW1pAcj3Mh0vqvRtmdMES+hXUwAO5qOZxrll1GKB3d+fuX6+T3l3884Tnsq/SyJAL
 dPKA0Da+rqYeejit5qXCY4WWGBeFidCfoQfYla8R6gmCbFoGxFlh2fmQBr5qidwg8cHA
 ffQUkKlc5/asGRHKNqsGLcxxei0+sydms1T0ILTX3MzmCQM5x3io2Sz6nNuzt3x5afIo
 vbwmA14PEAmOv4n4XXQOVla7yDNKxnT5wfezOKhK1IXF2oXIQD7aObWW3QvDTulwiTmT
 W34w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791696671; x=1792301471; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d64AKkfex8ucpkLV8OFICHb4YHT2ZbkVzlb3XcqNv34=;
 b=dfk2EvTTOZ7032u0YkbGdH083X0DqRBJgvErvzOw3aMozJt7s3RdOMzsDnss5z5TyK
 59/Xizyug7/3/khp0XoZoqGt7KLVKqpkOb9Bgb+BV6Y3I5k4STUUbxJLF7W7lUibpmQf
 88W5I9+Xnp6LTZcn389FoormSlakxjhPq3BElgGTfWIPQHFl0THQCduljqcFw14qj8KO
 8yI1Ll+tR/5U/YoBjkb9AciE7zi/ZxHefoZLH6JgQ1wt/z0L1DSWSWi1KYiTh1AeCh+6
 LJQhhEHVnttlbZNkW9PzE1WwFk1yvY5sHqgkdJZcUOP79q3Y44HBDiPIqyczoa570vTu
 eVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791696671; x=1792301471;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d64AKkfex8ucpkLV8OFICHb4YHT2ZbkVzlb3XcqNv34=;
 b=ugyQK4ULV+ysS1nm+whZDwYMIy/OGOMY61gTgWIh+deZhHMzJboLtsFMgmV9ym87Dh
 lclaNbz7PO2yU2D3NA6mEsMZqASfqQMqZkthhmvW4Pml/dEs7jYNWpMMtigRj5bVXjqm
 +pnIA+zBWhtDR6Y9g5zrsy7clTdqYqaaYeaPZ+W+LL19V6gnRC/YluiRGKO4wNAhcHXA
 uUk4SDgDerIwMGrGEYytwjb/+2p1OWT/mVeAZKu7w/2cZkyB33XZsG3psjd6T06wENsg
 ptZt2iAc+Dn3qoBxBl+mbjEnpnUW/PzufJM9+/EFNqr6WM0IwFLuRIk0431k/DJW0k/C
 cuUA==
X-Gm-Message-State: AFq9FYLAXqy/2mxYgNkHOS5PXDFXfs4ZMIjoiXMovCGVgmk/D2BF92Zm
 2rvDuBVK3gdcHM5QXYIVjNofAmq7iljfSctsuxWstNhFeHBapdkvxphuGp67QzF7DogGgG2vXgD
 bpYNeLaqjDQgyAUpe1ZxjnS5zEIqJNnRA9mV7
X-Gm-Gg: AYBFou2hsu5O9w+Xk8h8VjVbKV4tC2e3YS+fF6Jv8UaVSlxTCCKtL90AOHv1+zROSnb
 tF5Krn8BjuntJUNob40wWxfu25skrEbs8kfKYw2ZPqoirs7j0x8hx/erMRpH0oL1MnWkBaA0lwy
 oe0XpV9pyt6lnRR162jhlmRLf5jWfhAWHTV8LVD/qsKsCb+0E9YkGdOwMPAWKesgArjtSQOY6/L
 D0iX9TTV1EtH+v2mQ4ihxgnFy03hmTkb1er7AWm4F/6f0QPiBVp/Qzk9pU7MbZJItq/M6ouyH8z
 TVFMR3sZitM2RTK63HB33F+lIB482qUCGdr0TE673+sJLM70Ra1z9sOmuQ==
X-Received: by 2002:a05:690e:43cf:b0:671:631:785c with SMTP id
 956f58d0204a3-679360662eamr1175525d50.57.1791696671153; Sat, 10 Oct 2026
 22:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20261011-pvr-gpuvm-immediate-v1-0-5b298dfce4f8@gmail.com>
 <20261011-pvr-gpuvm-immediate-v1-1-5b298dfce4f8@gmail.com>
 <sashiko-outbox-166779@kernel.org>
In-Reply-To: <sashiko-outbox-166779@kernel.org>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 11 Oct 2026 14:31:00 +0900
X-Gm-Features: AclHuK9QQ8KesEV6lMvt0nL062BjAb2OUVABa0bqENkID0SS_98dJe0_iHpjEpY
Message-ID: <CAKbEznt5oahmTAuY4XOuRYOb3GWxe8iPd+jRcQL0gNZ3rT8R2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/imagination: Switch the GPUVM to immediate mode
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
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

Not an issue with the switch itself: map_init()'s error path misses
draining the deferred vm_bo. Will fix in v2.

On Sun, Oct 11, 2026 at 2:36=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] drm/imagination: memory leak of gpuvm_bo on pvr_vm_map error pat=
h
> --
>
> commit 191fc7b0dba1141708c7edc0b3aeac368ef8588f
> Author: Gyeyoung Baek <gye976@gmail.com>
>
> drm/imagination: Switch the GPUVM to immediate mode
>
> This commit switches the GPUVM to immediate mode so that each GEM's GPUVA=
 list
> is protected by its gpuva.lock. It introduces deferred operations such as
> drm_gpuvm_bo_put_deferred() and cleanup via drm_gpuvm_bo_deferred_cleanup=
().
>
> > diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/ima=
gination/pvr_vm.c
> > --- a/drivers/gpu/drm/imagination/pvr_vm.c
> > +++ b/drivers/gpu/drm/imagination/pvr_vm.c
> [ ... ]
> > @@ -214,7 +214,7 @@ static int pvr_vm_bind_op_exec(struct pvr_vm_bind_o=
p *bind_op)
> >
> >  static void pvr_vm_bind_op_fini(struct pvr_vm_bind_op *bind_op)
> >  {
> > -     drm_gpuvm_bo_put(bind_op->gpuvm_bo);
> > +     drm_gpuvm_bo_put_deferred(bind_op->gpuvm_bo);
> >
> >       kfree(bind_op->new_va);
> >       kfree(bind_op->prev_va);
> [ ... ]
> > @@ -758,7 +769,9 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pv=
r_gem_object *pvr_obj,
> >
> >  err_cleanup:
> >       mutex_unlock(&vm_ctx->lock);
> > +
> >       pvr_vm_bind_op_fini(&bind_op);
> > +     drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> >
> >       return err;
> >  }
>
> [Severity: High]
> Does this code leak the gpuvm_bo and the referenced drm_gem_object on the
> early error path of pvr_vm_map()?
>
> If pvr_vm_bind_op_map_init() fails internally (for example, if memory is
> exhausted when calling pvr_gem_object_get_pages_sgt()), it takes its own
> error path:
>
> pvr_vm_bind_op_map_init() {
>         ...
> err_bind_op_fini:
>         pvr_vm_bind_op_fini(bind_op);
>
>         return err;
> }
>
> This calls the newly modified pvr_vm_bind_op_fini(), which places the BO =
onto
> the gpuvm_mgr bo_defer list via drm_gpuvm_bo_put_deferred().
>
> However, back in pvr_vm_map(), the early return bypasses the newly added
> cleanup call:
>
> pvr_vm_map() {
>         ...
>         int err =3D pvr_vm_bind_op_map_init(&bind_op, vm_ctx, pvr_obj,
>                                           pvr_obj_offset, device_addr,
>                                           size);
>
>         if (err)
>                 return err;
>         ...
> }
>
> Because drm_gpuvm_bo_deferred_cleanup() is bypassed here, would this caus=
e an
> unbounded accumulation of leaked BOs on the bo_defer list? Can this be fi=
xed
> by ensuring the cleanup function is also called on this early return path=
?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-pvr-gpuv=
m-immediate-v1-0-5b298dfce4f8@gmail.com?part=3D1



--=20
Thanks,
Gyeyoung
