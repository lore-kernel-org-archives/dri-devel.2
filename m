Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77030CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A556C10E12F;
	Thu,  1 Oct 2026 21:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Onvfailm";
	dkim-atps=neutral
Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com
 [74.125.224.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A4110E12F
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 21:48:49 +0000 (UTC)
Received: by mail-yx2-f40.google.com with SMTP id
 956f58d0204a3-67567ff2e77so3309349d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 14:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790891328; cv=none;
 d=google.com; s=arc-20260327;
 b=beHNLpS+AbRxzms8HYWVUlArs1HYfJXatF6RzQnKsO6IzXUmr+6uBPvfZMaS8gRF0B
 2X+Us9lZsefEvRz/mesdjLUj/OMfRrw9uDADSw38sL81L/J4mmTndTQhMofjMJpXUFDu
 O9tuWkVkwVbZWBcs0F9S8037alLTPFyeAo8iOi/l76nSYLQZ97IRlepYy/CW3vwFKf+D
 pcv+1GMfloBP0XOPHJXnp2IyPagbmYxLOf9tYKFiImbmpeiKKowVTi//X1EOyjSIY4oF
 YC/WfVNRRhAbfxT54VttLVk6AdkBWI766XEFx1aDH7iTEXpqSdl4tqMXvpOKbz+k/Wg3
 AWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FxEBbkBDr98zgUdqxxzSaXIdqAeCMXlZGMeNUHK5+N8=;
 fh=kAGRFKDN7aRGd6VO33HQbsOy3CoTfL4nr4GTMsDqfhg=;
 b=liKebB3VDogDs3abuStbLJI6ifZDERqjtRKsYFAJ3waMEXGg7pmxsIasBkrEEWBVfV
 +Thz1RLHFGVOI/ii16z9IkO6uIE2P2LQjFXDjE4wKNX/GSB+SVVhxFMsOp1WqGl0GgMF
 +U+Kvwizj1QvXZNmU6ULzqgPhFgQpiikEjVpLTpmc083TA+BC/AMBxz49MiwGfJhbd9t
 WiobnSiilKUehWmRT4uWgUayAR/pe/fWB4pwko78IOteNewe6yiddXl+YJDwlGbDoqlP
 78kB6lfwKP5bb9ov2nGyNnFJOQcENfT0pJuj2H1hM8OXLTPl8LwvGM6JNEgGMKgM+yjb
 vYtw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790891328; x=1791496128; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FxEBbkBDr98zgUdqxxzSaXIdqAeCMXlZGMeNUHK5+N8=;
 b=Onvfailm8hnQjZ8kI8Le1ZMgwsIaWMcmWMJN4j+HiRhcdM4YyGXxKzTQ6ez73nPDsg
 M0zbfpCGP4UJonMt5u7SjdnHAoCO4IZHPEiC01HmJq5FQ8dq32rgO6WamLX9qcXA88wp
 QEJ9nvd4iI5MbyFJAhYz4jlEw3/FhUOMdgGnr0hvOK82pnK4p67b6IL3hQD9WJn5KN2s
 OEhSaykuFK5doKw9oYclH7DYuvbfIZIzB0kl+CUqimt9zHC6nfe0uv7VuzaX9aQX1qyx
 cgqw5svNo0d0Kj/Hg9Tc8YDVI1ZmzgHswVUtuQC6sOEACkr+WQbx2fOCeKP0lHUBcE8w
 EVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790891328; x=1791496128;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FxEBbkBDr98zgUdqxxzSaXIdqAeCMXlZGMeNUHK5+N8=;
 b=xzuhz/bEcDYDVhcWdBlvX1wxKOjxyfuy3MPBBvxlIP7WO74MPlDkL4aULZzKti/dYf
 uIzmS9fGQW0nJErovFdQnIsruDFOAubxkBe7+O1aBkVQRjgp2gobyKZIvbKibzWTdaYq
 XYuSPPY169zmq/4Feh34HG9a3J4lA6KCvYf65MAa16y2VKd68cDrT/CxbEbIwtSB/Np8
 I908JZ1BCOY4FgnZEawcC9TLk070cMM7CW3x6PmW5fd/B5M45FUL2jAG238rnrwmiETO
 ZHDmDWAbykHrlOOgPzgIzvUWQUOewRsb8xSh6NUw5vA3mbAPKskSIt/uOOJX4t3UOh46
 A0qw==
X-Gm-Message-State: AFq9FYJ3ALKP2DUIDm/HhZT7SJfssmPo55cSShBX2WrBrerD0gmD+4Mt
 iv1WaVIVNyYdwwo5f0RtfA+kgrevrYxGC/cOhCQoSkZK6WqX+HAUaDjfWw+774AnVIUkO1tIdT1
 ypRf67sLG4lrCLGFJ9CDPDrCkXNe9bns=
X-Gm-Gg: AYBFou0a4jzz9HHQ+z1lgzhXbHban0FdDdPQeMfIPaX9LuJAJFm8pxO2x388Kt4scVc
 wRKHB+G1i9PWHy1rC7tFb0qqAklVw/HGuQz5UDrqTlO5dFd0X0L8SBAHQ9DA+n/yNlQl/TJ3tkS
 y6oorTnI+oljkJ56RP57AUqRNMv301AnD7Yy6UynRsKgtatjZgBQrg5Gr/38ce74H11j2rkQAqp
 G/WdZhZVyFJyv0J8nVRGdSRraTD1iO9tpee9xyJCEpzNnY/RkuFB37qLxDykR63yw9CTsqfV26c
 pS8rGA9mJtBAKVWFNlzmpykGrsdOxUBDtnh+txj4GO/pndavLFx3me1xW22Eg5mN7tU/3vgOf2s
 VlHeiIFlF6iq7MxF9d/YL9sgOJwDJJKuXHg==
X-Received: by 2002:a05:690e:168e:b0:673:1df3:86b2 with SMTP id
 956f58d0204a3-677ac0a5637mr405865d50.66.1790891328358; Thu, 01 Oct 2026
 14:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-32-9b6c217fdf2f@gmail.com>
 <20260923225318.68FA81F000FF@smtp.kernel.org>
In-Reply-To: <20260923225318.68FA81F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 15:48:21 -0600
X-Gm-Features: AclHuK89WETVF5kBKceq7LGgHNh99DFnvQVhaT61KjOm5bX44GqQ2b5VPPdB404
Message-ID: <CAJfuBxw6=rmCZ-YXyDjxUVZCKpXf+5oLUgGqDnmeXu=PfrLJ4Q@mail.gmail.com>
Subject: Re: [PATCH v11 32/38] dyndbg: resolve "protection" of class'd pr_debug
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

On Wed, Sep 23, 2026 at 4:53=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] dyndbg: race during module load bypasses ABI protection perman=
ently
> --
>
> commit c8a052c030fff7b63aa2d9e4c2dc3aa455948704
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: resolve "protection" of class'd pr_debug
>
> This patch implements an ABI protection mechanism for dynamically debugge=
d
> classes by binding a controlling sysfs parameter to classmaps. If a modul=
e
> parameter is configured, it protects class'd callsites from being
> accidentally modified by un-classed wildcard queries.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 636a88994a774..d300d44c1a82e 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
>
> [ ... ]
>
> > @@ -252,7 +294,28 @@ static bool ddebug_match_desc(const struct ddebug_=
query *query,
> >           dp->lineno > query->last_lineno)
> >               return false;
> >
> > -     return true;
> > +     /*
> > +      * above are all satisfied, so we can make final decisions:
> > +      * 1- class FOO or implied class __DEFAULT__
> > +      * 2- site.is_classed or not
> > +      */
> > +     if (query->class_string) {
> > +             /* class FOO given, exact match required */
> > +             return (dp->class_id =3D=3D selected_class);
> > +     }
> > +     /* query class __DEFAULT__ by omission. */
> > +     if (dp->class_id =3D=3D _DPRINTK_CLASS_DFLT) {
> > +             /* un-classed site */
> > +             return true;
> > +     }
> > +     /* site is class'd */
> > +     site_map =3D ddebug_find_map_by_class_id(di, dp->class_id);
> > +     if (!site_map) {
> > +             WARN_ONCE(1, "unknown class_id %d, check %s's CLASSMAP de=
finitions", dp->class_id, di->mod_name);
> > +             return false;
> > +     }
> > +     /* module(-param) decides protection */
> > +     return !ddebug_class_wants_protection(site_map);
> >  }
>
> [Severity: Medium]
> Does this code expose a race condition when a module is loading?
>
> Looking at ddebug_add_module(), the module is added to ddebug_tables and =
the
> ddebug_lock is dropped before map->controlling_param is initialized:
>
> lib/dynamic_debug.c:ddebug_add_module() {
>         ...
>         mutex_lock(&ddebug_lock);
>         list_add_tail(&dt->link, &ddebug_tables);
>         mutex_unlock(&ddebug_lock);
>
>         if (dt->info.maps.len)
>                 ddebug_apply_class_maps(&dt->info);
>         ...
> }
>
> If a concurrent wildcard query (like echo -p > /proc/dynamic_debug/contro=
l)
> is processed while the lock is dropped but before ddebug_apply_class_maps=
()
> finishes binding the parameter, site_map->controlling_param will be NULL.
>
> This causes ddebug_class_wants_protection() to return false, bypassing th=
e
> protection and erroneously enabling the callsites.
>

yes, theres a narrow window where a module w classd pr-debugs
is changeable with "+p" flags, before the controlling-param is set up.

Once the protection is in place, "-p" will not be able to undo the "+p".
Only toggling the param itself will undo those "+p"s

v12 addresses this by setting the controlling-param before the module
is added to the ddebug-tables list, and not in the class-map-attach




> [ ... ]
>
> > @@ -772,11 +833,14 @@ static int param_set_dyndbg_module_classes(const =
char *instr,
> >                                          const struct kernel_param *kp,
> >                                          const char *mod_name)
> >  {
> > -     const struct ddebug_class_param *dcp =3D kp->arg;
> > -     const struct ddebug_class_map *map =3D dcp->map;
> > +     struct ddebug_class_param *dcp =3D kp->arg;
> > +     struct ddebug_class_map *map =3D dcp->map;
> >       u32 inrep, new_bits, old_bits, old_val;
> >       int rc, totct =3D 0;
> >
> > +     if (map && !map->controlling_param)
> > +             map->controlling_param =3D dcp;
>
> [Severity: Medium]
> Is it safe to assign map->controlling_param here without holding
> ddebug_lock or using WRITE_ONCE()?
>
> Since this shared state is accessed by concurrent queries, could this
> cause a data race?
>
> [ ... ]
>
> > @@ -1332,25 +1395,40 @@ static void ddebug_sync_classbits(const struct =
kernel_param *kp, const char *mod
> >       }
> >  }
> >
> > -static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> > -                                   const struct ddebug_class_map *map,
> > -                                   const char *mod_name)
> > +static struct ddebug_class_param *
> > +ddebug_get_classmap_kparam(const struct kernel_param *kp,
> > +                        const struct ddebug_class_map *map)
> > +{
> > +     struct ddebug_class_param *dcp;
> > +
> > +     if (kp->ops !=3D &param_ops_dyndbg_classes)
> > +             return NULL;
> > +
> > +     dcp =3D (struct ddebug_class_param *)kp->arg;
> > +     return (map =3D=3D dcp->map)
> > +             ? dcp : (struct ddebug_class_param *)NULL;
> > +}
> > +
> > +static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> > +                                   struct ddebug_class_map *map,
> > +                                   const char *mod_name)
> >  {
> > +     struct ddebug_class_param *dcp =3D ddebug_get_classmap_kparam(kp,=
 map);
> >
> >       if (dcp && dcp->map =3D=3D map) {
> > +             /*
> > +              * Bind controlling_param to activate ABI protection in
> > +              * ddebug_match_desc(), shielding callsites from non-clas=
s
> > +              * wildcard (>control) queries.
> > +              */
> > +             map->controlling_param =3D dcp;
> >               v2pr_info(" kp:%s.%s =3D0x%x", mod_name, kp->name, *dcp->=
bits);
> >               vpr_cm_info(map, " %s maps ", mod_name);
> >               ddebug_sync_classbits(kp, mod_name);
> >       }
> >  }
>
> [Severity: Medium]
> Can the delayed assignment of map->controlling_param combined with
> ddebug_sync_classbits() result in permanent desynchronization?
>
> During the race window in ddebug_add_module() mentioned above, callsites
> can be erroneously enabled by a concurrent query. Once the module loading
> thread resumes, it binds map->controlling_param here and calls
> ddebug_sync_classbits().
>
> However, ddebug_sync_classbits() passes 0 for old_bits:
>
> lib/dynamic_debug.c:ddebug_sync_classbits() {
>         ...
>         case DD_CLASS_TYPE_DISJOINT_BITS:
>                 val =3D READ_ONCE(*dcp->bits);
>                 new_bits =3D val;
>                 v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bit=
s);
>                 ddebug_apply_class_bitmap(dcp, &new_bits, 0, modname);
>         ...
> }
>
> Because old_bits is 0, the function skips resetting any class bits that a=
re
> supposed to be off (since it sees new_bits (0) =3D=3D old_bits (0)). Does=
n't this
> prevent the synchronizer from noticing and clearing the erroneously enabl=
ed
> callsites?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D32
