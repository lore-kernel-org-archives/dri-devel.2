Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC01C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 20:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DEC910E17C;
	Sun, 20 Sep 2026 20:26:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MDL7Wp6N";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047E010E17C
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 20:26:44 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4ab20f4bso2241324d50.0
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 13:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789936003; cv=none;
 d=google.com; s=arc-20260327;
 b=BVbdcWt+HZo12vvn8vXBqFhYRJLxM32JmPad9T6bHvvObqmg59Kmp0yDUwl2QAxQPU
 rAHU3K48OdYmwaquHkf+u41dJs5sgjDVxY9xEA1zkZsySuImt7BkPDpGLVnExZZ/Kjh0
 U51BhXgnR+ewDBJvVFmK00ym8d193UkP4UUcrG7DtAFuOl4vOxOTZUC2Io/TbcOSL7ob
 +Qxyr6XlwllgOwOpMd4r+8g4TYSfOIlKKLsLoFP5MexVXcbvqA6RAKeauVpne9oEo+9r
 FkROHs3mpTbcRcKALWVfIS4iH1XpDa8PzY+8r37ylAIMCnFnj1EIHJQMAkH3sumEC4Iy
 fo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M5Inp0dUK9mWGDzU51sPdtRsOeEciT1UFPFVj3DOFnI=;
 fh=kAGRFKDN7aRGd6VO33HQbsOy3CoTfL4nr4GTMsDqfhg=;
 b=aHRoJWRnAcBha8B4Kfeu9FA6Yeh8K1jSXgZVQKiRxb/9Rb+BhjtM4r/ALA30h6ml2J
 NAoJLZO5fkyGawg8rDX/LOkePhaRzt6hweTNWD6DrXGw059wd/i+kSasW/CnhjTVF0RL
 2LGI6yRMDvELUtvD9OnjOJzpztFTWJcCFThqUvfbn10fZkaneD4NV/+QrkYaYvACnd3q
 GtwRwd5XxNwMgV9nJ62ZX0BtuSTWZSDBqxftjx5SYUym/1JfSLFN1YWS5wUE40RJeLzU
 Kj2jpITH1uE+JJO5gWckBxLmI7WY5qnmxMkkbj0CaD3zdkDzYiCz5xr1vFX3fO6j4DH5
 Nslw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789936003; x=1790540803; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M5Inp0dUK9mWGDzU51sPdtRsOeEciT1UFPFVj3DOFnI=;
 b=MDL7Wp6NY4qyxYDjaoGJB5xHLhuygMM+PabLDAHhE3wVxgQ2jBIj3WBGN7HdGHITZb
 HcD5pFNHZ6/+89X/lHNXKgkDQeew1WHnpOpIDGRr0+QUI4d00fdFoID44u10tl4QNxRX
 0jI9tYX1dVq8EG05/6xdhFI+3JTVBxzYHlr0P7RGQpo3kY0cOeoc2dqsI/TIDGopF5/9
 C8Vfj/Qd9EajL3AcBZH8q9C7iqmUK1JEk7R/M4BPKUfMC2QVbSEi9ujG41cxGNia9sc9
 8ivjynOVNb1kJLdWt5imELSNBKq/iEOgvGw6WvVALIuPUPb2M6ps3OsOjCSZBeJ3JDhz
 y7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789936003; x=1790540803;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M5Inp0dUK9mWGDzU51sPdtRsOeEciT1UFPFVj3DOFnI=;
 b=FnFM+61A+i3DOOJnv9rT+Levmlv/WrdH0ri965JOpj5kdno59s9ipNP0gC08mftYTy
 8UO30yzLE91D8UQ9yHWdG2oxMyw6edF0PQhteB1JSB43+EMwB+hYN0/oCxwAQw07CKTw
 LtwSA5NyVZoKf0Lxil/rr4R3ncyDLC0H/qZq76rypvWHq2pmkMj97XNU8ewHcb12t6Bz
 ILOuWlYfosevCoHIImvvrlyeBQGBsB7CjrBT4+4CwqSZVP3jMvKqjngOSZfWHpzpbIz+
 D5dxzYJnG5fcmja4XBpFHrfBjbOgV/h6hVEEQZlDRKdqdpoAQoA4QIE/DfuYF+V3DVhu
 9ceA==
X-Gm-Message-State: AFuF++n/nDcq8mWZwtBOPJskxsZM8+HCo9vVeA4jIDRw0Yg5r77ydEi6
 ug2HER9duiTvLE3dj0wTsz5DglSfpCN698c43fCB0KZZsnJP2rO4osnLOQcpdNVxvibgiBHkjaO
 7lvy2iKFXR5M1q3S51GyEz1bgY38Ym6k=
X-Gm-Gg: AYBFou0nDVxJ5+Dn2W7i+oo7MpghKnZbfu08mQOVDqQnPR/5DDMQumvljb+Fy6+V3/e
 fImJZ+7a7O6OKVe82iwbjEIiYUK3DRXgMm5swtt3jly/MCRRvavXQW4y5BVmhjqZN5VNaqGscR2
 rhbm2YssUTgthwX7r2OEtpsf2D4uv2DUe14znio4GBb4ppTwd0BVb9jOnSWG7sia3AO/d2c58fp
 GKRulQxHY5W7n/mfXvyrLsOpfbBt89fJm3yHG9KyPjIkiAgDbfeskoytCnkp0xj6bOo4vK1E9HY
 iFMSaYUTp5PF/cIekPaJCbHQWje2FVfzlR/tJml5hQD3JoN8IjNyl5zNOwW+nhLTiW1OtFwNQmt
 ApFVW3nlikXE24AElR6uYEKFQxABjn9fVxwSkqt6guCqU
X-Received: by 2002:a05:690e:4807:b0:671:4f24:2126 with SMTP id
 956f58d0204a3-6717fdb0489mr1682517d50.59.1789936002636; Sun, 20 Sep 2026
 13:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-23-af4cf4767707@gmail.com>
 <20260916162814.434551F000FF@smtp.kernel.org>
In-Reply-To: <20260916162814.434551F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Sun, 20 Sep 2026 14:26:16 -0600
X-Gm-Features: AcwNN1V9f_cj4KFvVBI7cRGxNTARDn_RhISbjMBAMFhOdAADIUHjfDsp-6ULVao
Message-ID: <CAJfuBxwqBqTWavDX2t1dNx7BkpwrRj67WGcRp4P9ktXig6t3SQ@mail.gmail.com>
Subject: Re: [PATCH v10 23/38] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
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

On Wed, Sep 16, 2026 at 10:28=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] dyndbg: init_bits relies on _DPRINTK_FLAGS_DEFAULT evaluated in =
wrong translation unit
> - [Medium] dyndbg: TOCTOU race in ddebug_sync_classbits() causes out-of-s=
ync debug state
> --
>
> commit 3b29729057e8a4b4e0401fd7f3a74205f701c129
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
>
> This commit replaces DECLARE_DYNDBG_CLASSMAP with an explicit client-serv=
er
> model using DYNAMIC_DEBUG_CLASSMAP_DEFINE and DYNAMIC_DEBUG_CLASSMAP_USE.
> At module load time, it resolves reference records and automatically appl=
ies
> the initial bitmap to the module.
>
> Cc: linux-doc@vger.kernel.org
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 03dc35af4faa1..566c3860d7bfb 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > +static void ddebug_sync_classbits(const struct kernel_param *kp, const=
 char *modname)
> > +{
> > +     const struct ddebug_class_param *dcp =3D kp->arg;
> > +     u32 val, new_bits, init_bits;
> > +
> > +     if (!dcp || !dcp->map)
> > +             return;
> > +
> > +     init_bits =3D (_DPRINTK_FLAGS_DEFAULT & _DPRINTK_FLAGS_PRINT) ?
> > +             CLASSMAP_BITMASK(dcp->map->length) : 0;
>
> [Severity: High]
> Does this evaluate _DPRINTK_FLAGS_DEFAULT in the context of the dynamic
> debug library rather than the target module's translation unit? Since
> dynamic_debug.c is not compiled with -DDEBUG, init_bits will always be
> evaluated as 0 here. Could this prevent the system from properly disablin=
g
> callsites for modules that are loaded and compiled with -DDEBUG?
>

yes. this code is misleading and has been removed.

what needs to be said ( Im looking for the place to say it once) is:

DEBUG is a local override  (1 file, or even 1 func,line )
to a param, which cannot possibly express its full range of behaviors

when DEBUG is used, it is honored.
In this case, to truly turn off the enabled sites, toggle them on,
then off again.

something like that..


> > +
> > +     switch (dcp->map->map_type) {
> > +     case DD_CLASS_TYPE_DISJOINT_BITS:
> > +             val =3D READ_ONCE(*dcp->bits);
> > +             new_bits =3D val;
> > +             v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bit=
s);
> > +             ddebug_apply_class_bitmap(dcp, &new_bits, init_bits, modn=
ame);
> > +             break;
> [ ... ]
> > @@ -1238,12 +1410,17 @@ static int ddebug_add_module(struct _ddebug_inf=
o *di)
> [ ... ]
> >       mutex_lock(&ddebug_lock);
> >       list_add_tail(&dt->link, &ddebug_tables);
> >       mutex_unlock(&ddebug_lock);
> >
> > -     vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mo=
d_name);
> > +     if (dt->info.users.len)
> > +             ddebug_apply_class_users(&dt->info);
>
> [Severity: Medium]
> Could this introduce a time-of-check to time-of-use (TOCTOU) race conditi=
on
> between module loading and concurrent sysfs updates?
>
> Once ddebug_add_module() adds the module to ddebug_tables and drops the
> ddebug_lock, it proceeds to call ddebug_apply_class_users() (which then
> calls ddebug_sync_classbits()).
>

 In ddebug_add_module(), linking dt to the global ddebug_tables list
  and releasing ddebug_lock before calling ddebug_apply_class_maps() and
  ddebug_apply_class_users() is structurally required.

any changes to be made by apply-class-* only work cuz the module is on
the list scanned by ddebug-change() - which takes the lock, so we cannot.


Publishing dt on ddebug_tables is sufficient for both definers (maps)
  and users (users). The kernel module loader guarantees that definers
  load before users via ELF symbol dependencies on the exported classmap
  struct. Once linked, ddebug_find_valid_class() symmetrically resolves
  class_ids across di->maps and di->users, ddebug_apply_params()
  binds controlling_param and synchronizes initial bits, and the module
  is automatically included in all subsequent runtime sysfs writes and
  ">control" queries without requiring secondary registration.


> In ddebug_sync_classbits(), the parameter value is read via
> READ_ONCE(*dcp->bits) without holding the lock. If a concurrent sysfs wri=
te
> updates the parameter and applies it to all modules in ddebug_tables
> (including this newly added one), could the module load thread subsequent=
ly
> resume and apply the stale value it just read, leaving this module's debu=
g
> state out-of-sync with the global parameter?
>

since the effect of a param change is to call ddebug_change() which
takes the lock.
taking it around the param ingestion also sounds like a bad idea.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-=
part2-clean-v10-0-af4cf4767707@gmail.com?part=3D23
