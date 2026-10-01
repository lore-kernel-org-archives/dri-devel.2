Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D688DCA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1430710E05F;
	Thu,  1 Oct 2026 22:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oETHXS2y";
	dkim-atps=neutral
Received: from mail-yx2-f16.google.com (mail-yx2-f16.google.com
 [74.125.224.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC3D10E05F
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 22:53:52 +0000 (UTC)
Received: by mail-yx2-f16.google.com with SMTP id
 956f58d0204a3-6756f62025aso3882286d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 15:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790895232; cv=none;
 d=google.com; s=arc-20260327;
 b=LoWrry/SMgvt0OwL4354HX8hEkW4mSJIXLqPKjj+qXZsApvXy86+auEI/VIY4jV5y7
 Q72wijde9MjMzespuv8qmk5uuvE6UXr7dRV0ZHER5/NRJ4yItlywc5vBU0s5vDe+brLs
 6fCVIFbouVBGIgglx4Fh1Lt9on1LcxVHss0U7S/c70ttLLIyo5xRB08RgOjj7KqP1jXg
 T0BXOWYvv7eRIsJEcH9/oXEB4/8fQyB9cw0xTkZhMWxRWaaKMxKTNeGMPr+slV/1r83j
 aryP5cCuAjiyr/pvZi3avzmOUWyReSRzjoGHpjPA/HtKZLFiCn9VA78cU5jlqjCte9BS
 aSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TBYFdlPzVVihY84Cq15ZaQjohkF0LhdMTg9utDLtVGs=;
 fh=kAGRFKDN7aRGd6VO33HQbsOy3CoTfL4nr4GTMsDqfhg=;
 b=i6pb3SWD0y3iQPg+YmOQPslh/yjYaOrJc75O1lM27I8H/hC1Tqbd5uKAwM1aO4fcby
 NUoCYTtaJzEyfcI+gaFCdzPUxDgoOQe8lScHsoczMpUPq2O2Jpz6CbYSgFWRFPxAgd2b
 36sqj3sMwUOp6/XGZX5d919Y6ZywqTRlzAV22EgvN/SG9Tex8a0sxfuXW54rs7e2crAW
 RRgFk0poGxwMvFGrTuNdjz8xjznbaSbUvyTG5K4+TQj/a1jXpBsQfeaGO5VOKshmd0Wu
 OH7dy2aQVnvweiVVu1bQBLMv7MjOWrWQNfEQMk6xRnmJLRsp5XF6y3rzitCN2VSRnumk
 MtjA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790895232; x=1791500032; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TBYFdlPzVVihY84Cq15ZaQjohkF0LhdMTg9utDLtVGs=;
 b=oETHXS2yyll86WWOGQ2E1aiX4mSPOj6zDopzc0pIr8m829Skr7TVrES0GaTtZAZ4Ya
 rU2QMxVakj0Q7SuS1Dsm/smTeg2wzFYmk896H1JmIL6+WaqvB1dkNUEv/BNwrMgwmrbB
 jTJqrz/BHNUN6A42kXHUck72K8LSg2ZihqPce1JQTu+eCbofm5qjWNzB+9f0mphQwk2m
 rKb5WexoD7b8c+eI8wsXMmwHQhEcqlvlnAORouHTiWTCRjMPH+ZAlYc+qYFa9m4HmnC3
 EPL6J5Tfo+RdpICy3MdoSLJF2gTf3AJHEkqYfLtPh2wHLCzrmochBwTVxxRXmJmeLv7i
 1GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790895232; x=1791500032;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TBYFdlPzVVihY84Cq15ZaQjohkF0LhdMTg9utDLtVGs=;
 b=IwGLl467IcBwKIhV9Nyrn6Qw8vdbxjMI2OsIPLWfNTSfFBwQSnFIueptefU+ya4ebO
 p7WM8rMGkpjWbWA1OX0viyK+0YRe0a2LTPSx7nUIFKYBlfr/RK+/W/5yQHNkwLkwuF6j
 zpzqok7ll+jeSlkNnEuOLQh3u2WFBxkJI5pz7jgEFPvKcYZDAsAQG4FLUN+//v0NkLyA
 a52bAejYNgICIE0SXA+1tX1MKbrXnFb0HFqTmyPKM3hxrjQYhbsuqnccWr3QzUx4OXiu
 WBfkvKKNl6h3OQTUVCqeKW2GQyx+HLx71gFCae+mAWM2rwT92C02WAZE5d5LnEpyO67n
 mM8Q==
X-Gm-Message-State: AFq9FYIzct9mcKtW3xB5vHCCKVVQXF4NqinKgn7th0E6DdbavU/mwOQ4
 A1TYedgKdsaG3Ah9oG3DUIypskB4nw0UoFFTEaYmY/Jrb/AA/ZdHyyE+ZZvAlY7m4vIrFWxBfpG
 cU6OaFXZFdazuY/R01t4NnKpUX9Tliuc=
X-Gm-Gg: AYBFou08lmCY5gsB9/DnKz7e8YIjIUGAwSVsZ+a/JA+28afm/sMOj4I5Y8I9iTkqEDO
 tayWnAusD1gWNlo0FByfAQVaRqczI1YcuDPr6kGGFqyRf1Z3HVjGh4O8baiEr6iipg0ETLPQfi2
 i3k0rVKpeY6oXCS06J+3kAhL944N/seXVJscBIa2l8c5GhfAvFRcoAtQQekZtEiCj9wnKzh5MAf
 DpLvElwN8nUfAC1+CHTAZwp/02tfe44vjHMZfAEot+0hY2bpJs9BZ8MH+LkXHfE1El70UDpEr3C
 WYjjX8A/3vve8/Ca0RxO3G674rXcdwXsu6CetH/fErtrxyWPmH3Cu4jHlF7gej90nofn3IArWdA
 CzdyP/7MwUSBbWA2P6n4kjvIP8LbjswxY+0XB7D9q7j6N
X-Received: by 2002:a05:690e:1c08:b0:676:87c6:4f71 with SMTP id
 956f58d0204a3-677ac165db5mr389082d50.99.1790895231491; Thu, 01 Oct 2026
 15:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-23-9b6c217fdf2f@gmail.com>
 <20260923224940.ABEB51F00893@smtp.kernel.org>
In-Reply-To: <20260923224940.ABEB51F00893@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 16:53:25 -0600
X-Gm-Features: AclHuK89upHDiixXSE95YCeG6kGs9RvurvEycW_YR863IjXCz2W8iVCgqdQxxeI
Message-ID: <CAJfuBxzPMjqAsnqGqEESjZCfz=nmFGiOj6vFZby0kpAdFnNEFg@mail.gmail.com>
Subject: Re: [PATCH v11 23/38] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
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

On Wed, Sep 23, 2026 at 4:49=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] dyndbg: TOCTOU race in ddebug_sync_classbits allows stale modu=
le settings
> - [Low] dyndbg: incompatible pointer type in module section load
> --
>
> commit 0e12bed35baa8c038def6b06ffc95416176ee997
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
>
> This commit replaces DECLARE_DYNDBG_CLASSMAP with an explicit client-serv=
er
> model using DEFINE and USE macros. It resolves boot-time parameter
> propagation failures by establishing a robust reference linkage. At modul=
e
> load time, dyndbg now scans and resolves parent classmap references.
>
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> [ ... ]
> > @@ -2791,6 +2791,9 @@ static int find_module_sections(struct module *mo=
d, struct load_info *info)
> >       mod->dyndbg_info.maps.start =3D section_objs(info, "__dyndbg_clas=
s_maps",
> >                                                  sizeof(*mod->dyndbg_in=
fo.maps.start),
> >                                                  &mod->dyndbg_info.maps=
.len);
> > +     mod->dyndbg_info.users.start =3D section_objs(info, "__dyndbg_cla=
ss_users",
> > +                                                sizeof(*mod->dyndbg_in=
fo.users.start),
> > +                                                &mod->dyndbg_info.user=
s.len);
>
> [Severity: Low]
> The len field in struct _ddebug_class_users is declared as a signed int, =
but
> section_objs() expects an unsigned int pointer for its num parameter. Cou=
ld
> passing &mod->dyndbg_info.users.len here trigger an incompatible pointer
> type compiler warning and result in a build error under standard
> configurations?
>

fixed for v12




> [ ... ]
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > +static void ddebug_sync_classbits(const struct kernel_param *kp, const=
 char *modname)
> > +{
> > +     const struct ddebug_class_param *dcp =3D kp->arg;
> > +     u32 val, new_bits;
> > +
> > +     if (!dcp || !dcp->map)
> > +             return;
> > +
> > +     switch (dcp->map->map_type) {
> > +     case DD_CLASS_TYPE_DISJOINT_BITS:
> > +             val =3D READ_ONCE(*dcp->bits);
> > +             new_bits =3D val;
> > +             v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bit=
s);
> > +             ddebug_apply_class_bitmap(dcp, &new_bits, 0, modname);
>
> [Severity: Medium]
> Because dcp->bits is read locklessly via READ_ONCE() before
> ddebug_apply_class_bitmap() takes ddebug_lock, is there a race condition
> here?
>
> If a user concurrently writes to the corresponding sysfs parameter, the s=
ysfs
> thread will update existing modules under the lock, release it, and then
> update the parameter value.
>
> If a concurrent module load thread executing ddebug_sync_classbits() read=
s
> the old parameter value right before the sysfs thread writes the new valu=
e,
> and then acquires the lock to apply the settings:
>
> sysfs thread:
> param_set_dyndbg_module_classes()
>     mutex_lock(&ddebug_lock);
>     // updates existing modules
>     mutex_unlock(&ddebug_lock);
>
> Module load thread in ddebug_sync_classbits():
>     val =3D READ_ONCE(*dcp->bits); // reads old stale value
>
> sysfs thread:
>     *dcp->bits =3D new_value;
>
> Module load thread in ddebug_sync_classbits():
>     ddebug_apply_class_bitmap(...)
>         mutex_lock(&ddebug_lock);
>         // applies stale value
>
> Would the newly loading module miss the concurrent sysfs update and
> initialize with stale debug class settings?
>

Holding ddebug_lock during the READ_ONCE() in ddebug_sync_classbits()
would deadlock against ddebug_change(), which acquires ddebug_lock to
iterate ddebug_tables and toggle descriptor flags.

ddebug_add_module() publishes dt to ddebug_tables under ddebug_lock
before calling ddebug_sync_classbits(). Because ddebug_change()
acquires ddebug_lock while walking ddebug_tables, any concurrent sysfs
write either completes before publication (so ddebug_sync_classbits()
reads the new value) or executes after publication (so ddebug_change()
finds and updates the new module directly).



> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D23
