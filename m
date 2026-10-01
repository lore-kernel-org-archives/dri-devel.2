Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8A4CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 20:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D9A10E008;
	Thu,  1 Oct 2026 20:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bsVHvhxU";
	dkim-atps=neutral
Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com
 [74.125.224.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AAD110E008
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 20:48:49 +0000 (UTC)
Received: by mail-yx2-f41.google.com with SMTP id
 956f58d0204a3-6756d2aff02so3396007d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 13:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790887728; cv=none;
 d=google.com; s=arc-20260327;
 b=jQTxEfPh9W4af4ZRWyJcLUHnzD7D9aSs7h3SadCTqHba08tp4I3zEFw37vxOcJGF01
 W7xoDCkgG7rSb4iFVnNU1CgtKntpi/WGFiDtH+EtzUhSV0bINLT3uCX4PpR9NUsxgMjE
 XVF+WaumO6S9XTiRiwSZ4wjAhuBSsZcTa97bxqRshVayp52UC1OFnOj65khXj3PAfCw4
 /dd+Saf9oUXNjqXKuCj0EyKGUChyuZJX9Ql4uzPRCZaYq1zvRaCRWXyGm7ybaqrTQA01
 lBHWCYExCbm5g1ZJulZAtI51tl4l5eulv/OEISXt8yBdhHrg6tAO0cZvks8TZ6EVnL+n
 2+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hXzdK5QWID3MCeLjE3WVpfx7nvstpzl0h0tds4vVtak=;
 fh=kAGRFKDN7aRGd6VO33HQbsOy3CoTfL4nr4GTMsDqfhg=;
 b=G1jg5OpBbhkqsnjznfjCIPN4opXTZ2hrGj59ln9X6uM2OESeLtQNRjGQtt78A/GKft
 ckxJMuTmyaxdS9m8MqFmVBgNrLgOMbL8+eXuXJ+SMYufs1m8556f0tITP+ktUz35eFc4
 RJhC8lw3weyvNKNuQ9mGazis6fbJ6nIrm82kFAuGndAhGJlUVj/Z2efkJVcddexGWpwB
 GTCA/YQJ7H/HMAtI5F2VjHj+CBrbA5ozMvJcnLwPRsGftSReJM5Dlh06jZ50uaTA4BD3
 HvvjkiAlihux/rEZJMg0MPky2sPNhb51IdJ0l5WdAoVWLwdczWvVEMmWYGnDGD9to33D
 QzLQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790887728; x=1791492528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hXzdK5QWID3MCeLjE3WVpfx7nvstpzl0h0tds4vVtak=;
 b=bsVHvhxUaKgKG+/IgWNiC6wnLR+a4NXxgd/MIXVcjaYuzBQQbpi/wgNdCXUhnbacxx
 7Efv9D2+BSZ+9P8kNU/irDVLxeK6j2FKt+vBwFnBcl0WZSs8jFWLBJgRwUm/6kG1t1TV
 qak9md9hLnfWemOS2WGQKJrprYtDGVZucy892K2ujO0InD1X3fFf73pKs6lOF/fm7lA+
 uIXuJxv8jg/1dB1/1qC+RGuoHO37gwq21FCWwLDM/260OKqslJeQiirf1l+8rzlb2cu0
 S0UlsBz8SPMaCkV0bjNbK+kH3qN9bCkQUaN494eagvHVUcx/8tEmMWM9JXlfrHkjCIUj
 aepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790887728; x=1791492528;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hXzdK5QWID3MCeLjE3WVpfx7nvstpzl0h0tds4vVtak=;
 b=Wd9tS+2ectEmDY057wNt0EqYtV4xsm3aI1esNlVgC9xoO7WjdGqOwkgSTKBsVRW3JJ
 /nDVp1fnO8fgXrRFAQMWn/AzfAKBXLVGyGEHRXI25VYAlhbcsBEeNni3c4BKNEYOXxhR
 IrvTmMsgnLcqyC+jFQg6KWq7olch/xlfNBQ+udBij1b8KuVVaPzkvrDGqD53UXULfEvY
 hCRTSDnoOU6f6E05RgyRZb4x0GLE0Hc/imETG2TRXN85P2HeI/s4RaR9OOhEpuIdO74q
 tEye78pezwM2eXaC2uZp3eQhreOUAmuY9KBR3dAj+apDjMO27j2d4VZRbzG1Pl7LRBBz
 TJkQ==
X-Gm-Message-State: AFq9FYJlMwG4T67OwF9Zg+mP4DMCO4pm9N7NbMuWkUP1/0K7hd8vO/m6
 tGbmFpNZkWv6eDf0fcCRQ/bIfiMGWZ3FY2bjbtuv13NwwPlx1jpAVb2GNv04VhIk37hGApy9Gsj
 U1ur1rf/sXXtpvB+2wezx+S4ADqpai6k=
X-Gm-Gg: AYBFou3+IQ/HS7EKfEAA5/OoApkR0jJ3fMYo3Gqy7oEwXU2Som4q9unjnZkdBT/DhEt
 uxqq6HJoeOv/z5ch/u0w1TMoaaubF5zwcIp5GGAD2DKLAHNmnPkxpKSaCTj4MZaepyWjCJst5GF
 6NlD/2PsGgvRDmOW3gG3JUoZA/T3kRDmbqQRvtv6dhezfDWz53UGNG1v6IHkAc7bwK/muEhMKFs
 7U5W/fYmoMA9sNc9+GhO1zQstb6rr40w49yrNckxnMD0lgDxMV8IivSQY56uYPXY58lvAWSOoqv
 dhOssb90lW0pV5S9AP2ZeIsyeI/FwNFORQdwGyyg0xk9sSaHizww/jhpDJuqUrmScG1mDN4rYrR
 x0cEm/TS2ew8KA80P09W4U84xayd0db9i8HlC8kf3fd/4
X-Received: by 2002:a05:690e:43c2:b0:675:3b2f:149d with SMTP id
 956f58d0204a3-677abdedee8mr177654d50.6.1790887728087; Thu, 01 Oct 2026
 13:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-17-9b6c217fdf2f@gmail.com>
 <20260923224758.ABDB11F000FF@smtp.kernel.org>
In-Reply-To: <20260923224758.ABDB11F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 14:48:22 -0600
X-Gm-Features: AclHuK_fnG9ePBcpefBAaL1OxTkmt0Q1XqH_AAR2O6UruMjbb77-3ueG2XaC4OU
Message-ID: <CAJfuBxzR+rHmMw7HPscwb4eAVn1SsnHpFVLGcYxJOq9icQyQWw@mail.gmail.com>
Subject: Re: [PATCH v11 17/38] dyndbg: replace classmap list with an
 array-slice
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

On Wed, Sep 23, 2026 at 4:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] dyndbg: interleaved classmaps are orphaned due to contiguous s=
lice assumption
> --
>
> commit 8936e7007afda568cebc34aa496a40887ac6a5a1
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: replace classmap list with an array-slice
>
> Classmaps are currently individually list-linked onto dyndbg's per-module
> ddebug_table for operation. This commit replaces the list building operat=
ion
> with an approach that treats packed classmaps as an array-start-address a=
nd
> array-length, reusing the select-by-modname condition to find the bounds.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
>
> [ ... ]
>
> > -static void ddebug_attach_module_classes(struct ddebug_table *dt,
> > -                                      struct ddebug_class_map *classes=
,
> > -                                      int num_classes)
> > +static void ddebug_attach_module_classes(struct ddebug_table *dt, stru=
ct _ddebug_info *di)
> >  {
> >       struct ddebug_class_map *cm;
> > -     int i, j, ct =3D 0;
> > +     int i, nc =3D 0;
> >
> > -     for (cm =3D classes, i =3D 0; i < num_classes; i++, cm++) {
> > +     /*
> > +      * Find this module's classmaps in a subrange/wholerange of
> > +      * the builtin/modular classmap vector/section.  Save the start
> > +      * and length of the subrange at its edges.
> > +      */
> > +     for (cm =3D di->classes, i =3D 0; i < di->num_classes; i++, cm++)=
 {
>
> [Severity: Medium]
> Since the scan in ddebug_attach_module_classes() always restarts at index=
 0,
> could this cause regressions if multiple descriptor tables exist for the
> same interleaved module? When distinct compiled objects share the same
> KBUILD_MODNAME, it seems they might all incorrectly bind to the first blo=
ck
> instead of finding their respective fragments.
>
> >
> >               if (!strcmp(cm->mod_name, dt->mod_name)) {
>
> [ ... ]
>
> > +                     if (!nc) {
> > +                             v2pr_info("start subrange, class[%d]: mod=
ule:%s base:%d len:%d ty:%d\n",
> > +                                       i, cm->mod_name, cm->base, cm->=
length, cm->map_type);
> > +                             dt->classes =3D cm;
> > +                     }
> > +                     nc++;
> > +             } else if (nc) {
> > +                     /* end of matching classmaps */
> > +                     break;
> >               }
> >       }
>
> [Severity: Medium]
> Does this premature break in ddebug_attach_module_classes() enforce an
> assumption that classmaps are strictly contiguous?
>

Yes, it explicitly enforces that assumption, because contiguous packing
is a fundamental invariant of the Kbuild object model and linker script:

0. In Linux, all translation units (.c files) comprising a loadable
   module or composite built-in object are linked together via
   $(LD) -r into a single intermediate object (e.g. foo.o) before final
   vmlinux or .ko generation. All contributions to custom ELF sections
   (__dyndbg_classes, __dyndbg_class_maps) within that object are
   placed contiguously.

1. Built-in module definitions do not interleave across directories or
   link units. Core dyndbg already relies on this exact contiguous
   invariant for callsite descriptors: dynamic_debug_init() scans
   __start___dyndbg_descs sequentially from index 0 and allocates a
   struct ddebug_table whenever strcmp(modname, iter->modname)
   transitions. If Kbuild interleaved objects for the same module
   across arbitrary boundaries, descriptor tables would already break.

2. An array slice (start, len) inherently represents a single contiguous
   memory extent. By definition, a slice cannot represent fragmented,
   disjoint ranges. Replacing struct list_head link with a slice saves
   memory and pointer indirection overhead per classmap, backed by
   standard section layout guarantees.

> If classmaps for a module are interleaved, breaking early means only the
> first contiguous block is bound. Subsequent classmap fragments might be
> permanently orphaned, leaving class'd pr_debug calls in those fragments
> uncontrolled.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D17
