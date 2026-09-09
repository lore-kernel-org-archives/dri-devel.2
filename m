Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32F3C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC45D882AF;
	Wed,  9 Sep 2026 20:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZCGqMgQw";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACEE882AF
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 20:56:29 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4ab201ecso934112d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 13:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788987389; cv=none;
 d=google.com; s=arc-20260327;
 b=EEr4igWwY1U8RhYkwP+adso2+sVpZUzMDMU48qj0c10JK876eUpx22Gz5FvWI1tWC8
 lNkzDXLuB0SoMmKcJOqB+888Bc4tpKBTRS/DEgafMqWGudNLa2LPZeGwlawGRRbNMg/7
 FlqZImsy9rBxAhiOSSzJUZDeBIEjg+CGrvtN2rqGFBesa5CmDz7XJuOZVQ65SqAKGV9w
 fadJsW5JobcvMEWbSMxvnhVl7sPff5M5IUy8ODG81MqP0sGcXJV9SqpuSuMzxTxWQCx6
 I/bRYoUa6aWXZya4JtZJObD16iUAihr/hkzpGpU0brB6h2YyM9xtUJ/KBkkZfAHKGmNa
 vJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aHx4F49Zpu+pEmstw6hBfMqlyRg9LrY6GEInd1anRvI=;
 fh=kAGRFKDN7aRGd6VO33HQbsOy3CoTfL4nr4GTMsDqfhg=;
 b=KK9WOX8De87HzP3pF1Wjv2kVLra5cipsm0BbT3ZOCNRARU3HxDr9b5s2CsIG4G25op
 xmgwxA2UJMtK9djQ9T2h/CkczaEN9BzIwkCWgLBQlhI2/deR5H+cv9nCOLdvclGd3r+P
 +FldhpIajl0t66R2JVaXQK4jg2RC/UKbEkpK6IaeHFE/YH4qXdklbhm8cmqKEz+Hl0Je
 SjTHeNRBgjv6F6Jhxv0zwVgKUBpx3ZmFdXulB3kQ0efwKPewlsPsCr9YUWWGDRBPdRk3
 C5gJ8hZaMlCwI7at0t1GDtD8BilgoaT1JlTMk3P04/Rn0s8METjL24NEYjtdz12RsqI7
 +xWA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788987389; x=1789592189; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aHx4F49Zpu+pEmstw6hBfMqlyRg9LrY6GEInd1anRvI=;
 b=ZCGqMgQwSwZs6FNNNk3kN3GyIMRE9iCdqbJGQ2Wy2mlOxoYmHKO3fE4JPOlUm25jP+
 qulJvFjs2vnRt7Urw9nG/B8EkwEEHTG7is6rT69MU8Ev8PP8X7/DJUlHDiG3RiqXD8o0
 NmvswaF5PCqX02tZoWbDM9p7lzRQhEzIvx/RF3fp+iRCwjBr5zIHFWE+FNf2b9ciZdta
 gDcXTXHzxPDe66KKAOdfZ2xjxc4IhUslrdzHtyYF4IseKdjDqYdI3m+aQ0Zs8XFXrB0u
 2irKYgqB+phbz9FZZBLp2t4MWXhc5fiuFf4r0iuVZoeT/Kifa5aK2t6OAXnFACg9yfj3
 BDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788987389; x=1789592189;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aHx4F49Zpu+pEmstw6hBfMqlyRg9LrY6GEInd1anRvI=;
 b=sH9225pbUngTH3GCArpCuHV6X6N2rIU2ynOGmgNeJelxUNvPETxpjE2oiQSbnZv2RZ
 GYUjjiJjPkDKSQtYSf9WpMO8Kbh8WuLFvtCWXylGfDrALkcDsp/w+1ZSQxTuLMRoQSWL
 vtC83lWcy7fJD5ioRorHwYTgnBj/UnOVIvdZG9fCTteNvrMlG1lKdO1gSucsWhJNRzEZ
 nKqLQixnaAkxgZt+Yr8CZo+tFW8+A+zRIXvgKYrolT3flsVL29VKUstJrxIdGnPgM+GU
 /MzPFlEkBP/WUbiAcNfqQW7D5nDqi8f9QbRMalMz4EiW4Cs5se+pXDIZ1F/u8D4r5jIH
 r3pA==
X-Gm-Message-State: AFuF++lUubFPGa7mp6vDm4nWAjSN0lP7vPG4WXN9tn43nM84+dZSceSP
 zDycxFepNbI+3Kks6kBAYrp4YvYO+S7XwCgm4HfyVc9ILPM7ghZZnBaPTDgbvJQVGsk/keWyTjn
 t+Ng6mGhiAjprYMagnZQufu2COGRtR5U=
X-Gm-Gg: AYBFou2f3scgyDP0Cw0NnYDpw9Nn9/IrvdsxPz9Ocia9fUZn+66SRZtRSvoSFb9gBk3
 4zZbKds1BPhleekAsOJznX5yGxAcwhPwei2Utl0NncmE8KQ3SSDXZeZcnNPxuS/uXTSXbvbGaWp
 CbWrrk113NHKqyFIo5QQ/BG2aYaf1zj6aXhXpuo6XHtfi0J3a0oYHeH+H5Bf2eZuBgSoY5yO6qe
 eM89lgvceutkpmHH7YC0cnOJbhigctAJHPtRPOvpc7M+zNiz54hoq9CqEg1KV6jV0nujR47zrYS
 FOIwjDpHp+2oUvzoEdZalrrDtJjOOg1ihQ9dc/M3xUx1DqN9L1lpN7JHfsiz7ydpKtNMbpYoFtU
 yswj/5/5J9X9k+/wty9/oOzVf8HYKdd1+bg==
X-Received: by 2002:a05:690e:43cf:b0:66f:c67f:1a6a with SMTP id
 956f58d0204a3-6710ff14f4fmr1492851d50.44.1788987388660; Wed, 09 Sep 2026
 13:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-24-3a3f621f4a10@gmail.com>
 <20260909011309.543B91F00A3A@smtp.kernel.org>
In-Reply-To: <20260909011309.543B91F00A3A@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Wed, 9 Sep 2026 14:56:00 -0600
X-Gm-Features: AcwNN1V549rxj8x0UclZdPYhK2I8FxFFFwB6mo2fxWYjnCTaNEuPXTVR7O_ixeA
Message-ID: <CAJfuBxy9gvQ3kBRy=9_ik6oUaBdczoC76XwHR71zc4Lxkp-wSw@mail.gmail.com>
Subject: Re: [PATCH v9 24/39] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
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

On Tue, Sep 8, 2026 at 7:13=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Medium] Newly loaded classmap user modules fail to sync disabled class=
es due to a hardcoded `0UL` state assumption.
> - [Medium] TOCTOU race in `ddebug_apply_class_users` when a class paramet=
er is modified via sysfs concurrently with module load.
> - [Low] struct ddebug_class_user defines mod_name as non-const char*, whi=
ch discards qualifiers from string literals.
> --
>
> commit ed72477b68f823658c20da0da2c5754d60e12c69
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
>
> DECLARE_DYNDBG_CLASSMAP had a flaw: multiple invocations across both
> core and driver modules broke the K&R "define once, refer afterwards"
> principle, causing boot-time parameter propagation failures.
>
> Replace it with an explicit client-server model:
> [ ... ]
>
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 144a2a947abcb..6517e0169a803 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> [ ... ]
> > +struct ddebug_class_user {
> > +     char *mod_name;
>
> [Severity: Low]
> Does this code discard qualifiers from string literals?
>
> Using the DYNAMIC_DEBUG_CLASSMAP_USE_ macro assigns the string literal
> DDEBUG_MODNAME to this field, which can trigger compiler warnings and
> compromises type safety. Should this be declared as const char *mod_name
> instead, similar to how it is defined in struct ddebug_class_map?
>
> > +     struct ddebug_class_map *map;
> > +     const int offset;       /* offset from map->base */
> > +} __aligned(8);
>
> [ ... ]
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 2065bfd1687e0..0e25b4d53942b 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > +/* called for class-users only, parse_one does this for definer module=
s */
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
> > +             ddebug_class_param_clamp_input(&val, kp);
> > +             new_bits =3D val;
> > +             v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bit=
s);
> > +             ddebug_apply_class_bitmap(dcp, &new_bits, 0UL, modname);
>
> [Severity: Medium]
> Will this fail to sync disabled classes for newly loaded modules?
>
> By hardcoding 0UL as the old_bits argument, ddebug_apply_class_bitmap()
> assumes the module starts with all debug classes disabled. This means it
> will skip generating disable commands for any cleared bits.
>
> If a module is compiled with -DDEBUG, its callsites are enabled by defaul=
t
> and won't be correctly disabled to match the system-wide classmap paramet=
er


ack.  handled with a macro that yields a classbits full of 1s on DEBUG.

> state.
>
> > +             break;
> > +     case DD_CLASS_TYPE_LEVEL_NUM:
> > +             val =3D READ_ONCE(*dcp->lvl);
> > +             ddebug_class_param_clamp_input(&val, kp);
> > +             new_bits =3D CLASSMAP_BITMASK(val);
> > +             v2pr_info("  %s: lvl:%d bits:0x%x\n", KP_NAME(kp), val, n=
ew_bits);
> > +             ddebug_apply_class_bitmap(dcp, &new_bits, 0UL, modname);
> > +             break;
> > +     default:
> > +             pr_err("bad map type %d\n", dcp->map->map_type);
> > +             return;
> > +     }
> > +}
> [ ... ]
> > @@ -1238,12 +1404,17 @@ static int ddebug_add_module(struct _ddebug_inf=
o *di)
> >        */
> >       dt->info =3D *di;
> >       dd_set_module_subrange(i, cm, &dt->info, maps);
> > +     dd_set_module_subrange(i, cli, &dt->info, users);
> >
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
> Can this introduce a TOCTOU race with concurrent sysfs updates?
>
> Here, the new module is added to ddebug_tables and the ddebug_lock is
> dropped before the module's initial settings are applied by
> ddebug_apply_class_users().
>
> If a concurrent sysfs write to the dyndbg class parameter occurs in this
> lockless window, the sysfs thread will acquire ddebug_lock, apply its new
> parameter value to all modules (including this newly added one), and upda=
te
> the parameter value.
>
> When this load thread then calls ddebug_apply_class_users(), it will read=
 the
> parameter unprotected. If it read the old parameter value before the sysf=
s
> thread overwrote it, it will subsequently acquire the lock deep inside
> ddebug_change() and apply the stale old value, overwriting the sysfs thre=
ad's
> newer changes. This would leave the module permanently out of sync.
>


    There is no race here:

    0. Separate definer vs user modules:
       The locking in ddebug_add_module() adds the module to ddebug_tables =
so
       it is reachable by params and >control queries.
       Classmap definer modules (e.g. drm) EXPORT their classmap records;
       class_user modules (e.g. amdgpu, drm_kms_helper) depend upon them.
       The kernel module loader guarantees strict serialization: the define=
r
       is fully live before any user module can begin loading.

    1. Builtin ordering:
       For builtins, the linker orders drm ahead of dependent drivers and
       helpers in vmlinux, strictly ordering ddebug_add_module() calls duri=
ng
       early_initcall.

    2. Deadlock avoidance:
       ddebug_lock must be dropped before calling ddebug_apply_class_users(=
)
       because the sync path calls ddebug_change(), which acquires ddebug_l=
ock.
       Holding the lock across ddebug_apply_class_users() would self-deadlo=
ck.

    3. Init bits handling:
       Calculate init_bits based on (_DPRINTK_FLAGS_DEFAULT &
       _DPRINTK_FLAGS_ACTIVE) (CLASSMAP_BITMASK(map->length) if DEBUG is
       defined, else 0UL). Pass init_bits as old_bits to
       ddebug_apply_class_bitmap() in ddebug_sync_classbits(), ensuring
       disabled classbits correctly generate "-p" queries for modules built
       with -DDEBUG.
