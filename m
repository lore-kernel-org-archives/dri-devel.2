Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A752C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868A610E32A;
	Thu, 23 Jul 2026 18:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rBjzherY";
	dkim-atps=neutral
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 013BA10E117
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 18:44:54 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-81ea0b7d137so6186587b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784832293; cv=none;
 d=google.com; s=arc-20260327;
 b=Gy/7o4s8qTBq2l+IS5PDYDXegXvmewn16EpDtXhkFDsGMt/sdXrYKaxQdHq7ywtpjt
 IpBcphRrhnR63zyA2nidCYb5E1qiPNU7LC0ymxUI1ENjA89jINthvsnlNk4K3rfd4Pb+
 +0BgIbJW1jTlrX1u6L+ujB7vWYOauS0dd6zI5tyYq7BhzdaRB2fZK/52tWQQ/FIZpyb3
 ZHFPeD3t6E3yK8dfOK4ISyuo1JHjjE/4BAlxhPK7WeEgi+Tf+clhhYXgvriX8CewQ2Yx
 5b7tFjQqCr2SMoEk2Sts2UVdCF+cgwpapssDSmg5XXxOxWSSmgh0HLn5uCyLs+LxPDTV
 35oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nWE1XQk5hMIg4yF/U3X0RJddhBOGdBRI/GnQd18cQ84=;
 fh=kAGRFKDN7aRGd6VO33HQbsOy3CoTfL4nr4GTMsDqfhg=;
 b=c6LHP/WX38rw85E3lTubG4WaCUOrlyEVQ6r15XUBwUyREEl/tobfdr0GsrTw/nOhAY
 A18dhGf7LYuhWjBGhgm2LmPrmsuFPmXn/DnaBehxlpSR54/1wJm9BLDRoIZiNxxC7gqA
 4pCi/71EhP4li+NCcpaSxpE/2ZI9JnBKFKw9cqLy0fAC+vTqtjsPahGXwG1G6dOIFeoA
 JIO1EDE0E6TJtpSOSjCQQPnf7aYaLkfaCPLYp6nkQ1eYnfCZD9WWVVKGKkTwjxTIky5p
 34AmhBHZnB6DjClLLObQcW8l7Hg1ORJiC1uiarKZ1l8rHjBH46vB1UNc6ld+yW8e1wLK
 KD9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784832293; x=1785437093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nWE1XQk5hMIg4yF/U3X0RJddhBOGdBRI/GnQd18cQ84=;
 b=rBjzherYOz24Ixj7sOQsijIwqPH8ZoZYpRGopixQKVs2G8yjZgrqZThU6shegHvKiq
 2syaY1lccfCUwAk2ylRePV3EOWrdGt6+xkZ7lRAjcdAGNgcbGbq13yd9vV4jgXZIW/Nn
 XGASQVy2g11yparbqtYfVich4k96GoDNhNQiq09JjBFsSWeldYhqFFCUTFG9oMEJnDgb
 XgH4ynZiZdXute3Zr9Adq8MzaLppGIlIS2YjTl4wI0mx+JmOoVcDbQ1H67Lt8+2kwDH2
 M3ivM8cvi+dfySZJ02FSQuDo9PMXQysfJKRmVZ0WWOD3X9vOGzJv++NAqhdIF3MBqbq7
 y6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784832293; x=1785437093;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nWE1XQk5hMIg4yF/U3X0RJddhBOGdBRI/GnQd18cQ84=;
 b=PkmAQlU8OEU3++WEvZXUSliK79Wj9VywmXj5t6vF3flgzY+4HRvKqr06f7XHAvFID4
 u0ET5Yl1U3actdQAjAgrDIgiOKi9w9enIIJnNc7Ph8dB71nCQ9yQKzApMNPEK1mv5gXG
 u+o3L2BFI+pIT/ORu0a8X1sZa5d2zbiGFDfERTuETaSAcLo5xqXsj4Qtq4ns8J2OOyZC
 sSYjCQyDy+0z+OT3qTYXXmgggosyTT+cpvIIb5P773c5g6GTSGCQpVoWe/wYCWN6adJL
 Uhw3RZlJHs0Fptbn1F3cli/KoUqx3lBQjkV1VdVhgTi/KbztC6mzr3yGlKkeSVeA5TSM
 Aysg==
X-Gm-Message-State: AOJu0Yzlg45U0fOTChLR105phjrClCL0BrvnU2uZZTPOEuRd3BXJZRW6
 97Ue+kg9ZrdPrt2/tutY5Kbk5UhyYWqNxuhfaTsR1YiQM9nIUETWKZjKzxPzop1lVi0ZdHDcHbB
 BevWvXJIpoCBzrEri8OcQe6UZUhNtDtw=
X-Gm-Gg: AR+sD11dxavJmR98RYPvU6/gdExovxZ7xBR4NMPuQahJzv1+M7OcILKcswwGkjt+wzw
 LO9OELh4ZKjLN45jdydkhZvPAfvYPajUa4LSjPiiAzorEUcfN7NiJmTIt17AzpPUn1Dp/SBZkmo
 q+qp/l/fGJS0JVb98R5QfxbjojuMLyMfYeq8UZdWnlLC1wPWzk4EMLvpVGISlUJdSRfXeKf1NVC
 CNwmYpTNRBSifYlqqH/iHnBXyck9jSKVvddyTxSCnQusmmyK+ykn2bdPSa+dtSaReyFdZHXjIl0
 521+jF4hfJhCyOHNfCj4GjkbRgdDriQb8/rDvOvm
X-Received: by 2002:a05:690c:6181:b0:81e:76a6:4fa4 with SMTP id
 00721157ae682-81f4c3641b3mr13865687b3.51.1784832293409; Thu, 23 Jul 2026
 11:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-20-010fbe73b311@gmail.com>
 <20260721211144.5FF051F00A3A@smtp.kernel.org>
In-Reply-To: <20260721211144.5FF051F00A3A@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 23 Jul 2026 12:44:27 -0600
X-Gm-Features: AUfX_myewH6u9zWxn6egOOnD6NQMr2PYuX2LLJqaFPr4esqlMtuMqkOK2XVFRr4
Message-ID: <CAJfuBxzqPPui3TRsyncnbS_CLyyh6pU2=1mkO=JsPEVwa_v9Rg@mail.gmail.com>
Subject: Re: [PATCH v7 20/29] dyndbg: refactor param_set_dyndbg_classes and
 below
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

On Tue, Jul 21, 2026 at 3:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The refactored `param_set_dyndbg_module_classes` is structural=
ly incapable of correctly applying existing global classmap settings to new=
ly loaded modules, and it corrupts the global state.
> --
>
> --- Patch [20]: [PATCH v7 20/29] dyndbg: refactor param_set_dyndbg_classe=
s and below ---
> commit fd7e6888285afde6b911cef67e7e2452e7180dba
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: refactor param_set_dyndbg_classes and below
>
> This commit refactors the param_set_dyndbg_classes callchain to support
> module-specific classmap updates, primarily intended for modprobe handlin=
g.
> It splits the function into upper and lower parts, threading a modname
> parameter through to ddebug_exec_queries. It also adds a check in
> ddebug_apply_class_bitmap to skip printing if bits haven't changed.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index f66e5373e61e2..a619cefd801f7 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > @@ -625,7 +626,9 @@ static int ddebug_apply_class_bitmap(const struct d=
debug_class_param *dcp,
> >       int matches =3D 0;
> >       int bi, ct;
> >
> > -     v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
> > +     if (*new_bits !=3D *old_bits)
> > +             v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_=
bits,
> > +                       *old_bits, query_modname ?: "'*'");
> >
> >       for (bi =3D 0; bi < map->length; bi++) {
> >               if (test_bit(bi, new_bits) =3D=3D test_bit(bi, old_bits))
> >                       continue;
>
> [Severity: Medium]
> When applying the current global state to a newly probed module, will thi=
s
> continue statement incorrectly skip all configuration queries?

this is a param callback. the modprobe has finished, and the modprobe
args setting classmaps
are already done.  the param-callback only handles param updates


> Since old_bits represents the global state, test_bit() will evaluate to t=
rue
> when applying the same global configuration to a new module, silently
> skipping required query updates.



>
> >               snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_n=
ames[bi],
> >                        test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
> >
> [ ... ]
> > @@ -683,8 +693,8 @@ int param_set_dyndbg_classes(const char *instr, con=
st struct kernel_param *kp)
> >                               KP_NAME(kp), inrep, CLASSMAP_BITMASK(map-=
>length));
> >                       inrep &=3D CLASSMAP_BITMASK(map->length);
> >               }
> > -             v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
> > -             totct +=3D ddebug_apply_class_bitmap(dcp, &inrep, dcp->bi=
ts);
> > +             v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*",=
 KP_NAME(kp));
> > +             totct +=3D ddebug_apply_class_bitmap(dcp, &inrep, dcp->bi=
ts, mod_name);
> >               *dcp->bits =3D inrep;
>
> [Severity: Medium]
> Does this code inadvertently corrupt the global state if a module-specifi=
c
> override is applied?

the param belongs to a module, its not "global".
and I dont know what override means here.
the callback MUST update the internal state, or error out.




> It appears that *dcp->bits (the global parameter state) is unconditionall=
y
> overwritten with inrep, even when a mod_name is provided.

the param belongs to a module. so does the param state.

> Should the state update be conditional on mod_name being NULL, to prevent
> modprobe handling from modifying the global state?
>
> >               break;
> >       case DD_CLASS_TYPE_LEVEL_NUM:
> > @@ -697,7 +707,7 @@ int param_set_dyndbg_classes(const char *instr, con=
st struct kernel_param *kp)
> >               old_bits =3D CLASSMAP_BITMASK(*dcp->lvl);
> >               new_bits =3D CLASSMAP_BITMASK(inrep);
> >               v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, K=
P_NAME(kp));
> > -             totct +=3D ddebug_apply_class_bitmap(dcp, &new_bits, &old=
_bits);
> > +             totct +=3D ddebug_apply_class_bitmap(dcp, &new_bits, &old=
_bits, mod_name);
> >               *dcp->lvl =3D inrep;
>
> [Severity: Medium]
> Similarly, is the global *dcp->lvl state unconditionally overwritten here
> when a module-specific override is applied for LEVEL_NUM map types?

the state belongs to the module.

>
> >               break;
> >       default:
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint=
-2-v7-0-010fbe73b311@gmail.com?part=3D20
