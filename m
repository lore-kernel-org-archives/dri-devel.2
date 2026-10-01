Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B12FCA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CD710E345;
	Thu,  1 Oct 2026 22:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JdnZGYFZ";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA2410EC00
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 22:16:06 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4ab201ecso6717553d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 15:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790892966; cv=none;
 d=google.com; s=arc-20260327;
 b=BNiAtIRxkcz9eWWfKjynVau54tGlMs12NTuUYgmFIgpl0+uBxydv8UR+hN28ZASenf
 0euC1VHJG0zFb15c8e6/yBDosuMGc8dqPopHaLmjXai5+mTcGfpnLVV49vpGrzmpp+Hu
 ifRKm4y3q0H1TAB9BMIHQIumonwkDL9gl0a9VcgP6kk9fwUjgVepxwc0LTIfMnujkGA7
 T1LyVa5k7i/jKqX51wZZq7lwcmNIIqgBNlu609KRu2Ic03cOlwsPaV/ldcrTZlHKkD2M
 64V8snTXg8rmIA7dY3Vt9vDg/SNWpNnHZZ/DGTik+2tWtTYry+qmVcxHCO9mQf/zn+P5
 DSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fFp9K5kNxLern9IX4I7rgGeq/2vHkCE/7tXvywJUIjY=;
 fh=kAGRFKDN7aRGd6VO33HQbsOy3CoTfL4nr4GTMsDqfhg=;
 b=sjtwcaUc0C5RZI+sze/iR7nkncndfmNfvIuMO/pILXfzyefttfuIf0tOYUOpLPjp2o
 8AgNM1XsiL5gvQJ/u/TtB5UKylFtxPMgKcGRv5FeP4bBgU4Udcm0cdqB4M3WPBrRWfhG
 aG+irIVCDy0B45ALxhmAlkbKHv9y/+/RPmMSwGJ2V0x6urQb694vPC4XBw9e9y6lb09a
 Xa3vN7Mn50xFgEzcl9GbGBBTs/1qtONefSsPtI4ljFSyYugFHr5MSckcVwtqewE8zvUO
 WC0KaEdGIfk95vFdfM7QjhGSboYbNgiJK5FDhAZ6oT28WeamqvlvWuX7xazitZadekLt
 mfoA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790892966; x=1791497766; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fFp9K5kNxLern9IX4I7rgGeq/2vHkCE/7tXvywJUIjY=;
 b=JdnZGYFZELqBmqFAIuuOWhqPO9FNGshaOuoNIH1+NdxPHgHY5zg39YNhvLxruHTI2A
 I8vDidvHibixEst4IGt+K4Owrwd/o8KHdWyhNMPSZIZdakRD3PZL2MGg8xvGsMCwCELZ
 7pQmb6PpIeI2jh0fhFN9XN0++jaAai3rnCAqbQUG7lbEkpG/QTSxDAENa+rl3d6lqygZ
 6c1ddCNnLj/M8EBxRFYQc6yvO0MNJE2/R82Wcipt9rRNUCUXYWDghhKbg1Z7gf1CRKql
 binaA9xCl414WwqHnMXaWAatGrdAszjon2p2NOYchrlRB6uT9ltnluPjuyDorB6cydqV
 okog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892966; x=1791497766;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fFp9K5kNxLern9IX4I7rgGeq/2vHkCE/7tXvywJUIjY=;
 b=kkApCABv06aW8rN676mYRkAzMZeDhEKHA7gY8BbCWAP60h3akVYoztFj903CLTPF2g
 dmqdx7+TlXg1c1NJ6iBM8MTXvyxVfsjtAwJCdBFJBrAg/kweVMDz0MeYJADXr/Q6DCik
 qq0Uw+QR0RjcuIbmR4PA501gPbaH8f8gUImf7PsiLh4HBk4UZswvNlnxNoP03LIID9NU
 Gti8Mu6nwL3/BX2r1mzjnZmRy1082CnsAUfElpOu50few90YeTBUs3K4E3SgZYsh3X+J
 eEHxJnsiyxVwr1e+JcrUT0Ugg9mh5MZFdDTMMlnUKjRYHlZe3zvhQMArr96DTT8nSPhJ
 ueBA==
X-Gm-Message-State: AFq9FYIxCcAuza5HhvfHENatr8+tgIVADkUZxmtVc86c7W72NKOCHz7S
 1y5HNW+XjENz9Biln/lT3yQ8OYHTadskZ52RxZgHDhCLmSMgSs7RTdFVAMt5Xci70wQU0pofQjc
 S4hjnyNRrLblOp2vO3GPbkUyJkOgL8m0=
X-Gm-Gg: AYBFou3iQ4rU3ZQdWteP1tgkGOoF9hLu+thr2a05LReBBHAafaii0LssSWxSws+OfO4
 hnVIV2VqdX9WPKdWkUzcfdL5WTlyBt0gKl/CfvrhQVQdQ5bLhjOEqi3wBqmhsTfXzE+DC3zHPti
 v/G1xZyU5a60/f9uWBnfY3DnjRCMVrlQdvFy7L/dlXuSdq3lEPlwTmutyLjCnC+12yB9EZ4vDvp
 Zq65tcQmMhlqi2Wm+gdUV3JoCLwy4TvCd6dtsMHhH7jkdkzCSmfwL620EMcHxgw1q+Z915Q9wgl
 zjvG7+u2sl8kGc0xZbhMNq1NJ9UPMT0egeaJP7REVvwukXV9GxWPyu/omYkGRTl6TtQCVdCWpxy
 0Xqg59w9185UJ/5KKeNVXAJz+ojx2rB+tsw==
X-Received: by 2002:a05:690e:4885:20b0:674:f33:3a38 with SMTP id
 956f58d0204a3-677ac148763mr250188d50.125.1790892965727; Thu, 01 Oct 2026
 15:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-14-9b6c217fdf2f@gmail.com>
 <20260923224509.4DE3F1F000FF@smtp.kernel.org>
In-Reply-To: <20260923224509.4DE3F1F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 16:15:39 -0600
X-Gm-Features: AclHuK-GHAcqAEG9-PO9HaBTq4Efz44Tmpp9mn4Tt1hmvZxExK0du5Qqqyez3YY
Message-ID: <CAJfuBxzvL1ATWv96GeEgUHY0m3G-sm0=0KRSOqVjaXQ7e61spg@mail.gmail.com>
Subject: Re: [PATCH v11 14/38] dyndbg: Bind callsites and classmaps to
 DDEBUG_MODNAME
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

On Wed, Sep 23, 2026 at 4:45=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] dyndbg: classmaps for loadable modules are dropped if DDEBUG_M=
ODNAME is overridden
> --
>
> commit 5e35c3cb693ea4379aa99e08e89d78671956f5c5
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: Bind callsites and classmaps to DDEBUG_MODNAME
>
> Currently, dyndbg binds KBUILD_MODNAME directly into callsite and
> classmap declarator macros.
>
> For built-ins, KBUILD_MODNAME defaults to the basename of the source
> file. For many subsystems, this fragments what should be a single
> module into separate file basenames: kernel/power/ produces "main",
> "suspend", "hibernate", "snapshot", and "swap" when all should be
> "power". Conversely, multiple unrelated built-in files across the tree
> (init/main.c, kernel/power/main.c) all collide under "main".
>
> [ ... ]
>
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index baf5c0853f459..85863e24ad134 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> [ ... ]
> > @@ -121,7 +129,7 @@ struct ddebug_class_param {
> >       static struct ddebug_class_map __aligned(8) __used              \
> >               __section("__dyndbg_classes") _var =3D {                 =
 \
> >               .mod =3D THIS_MODULE,                                    =
 \
> > -             .mod_name =3D KBUILD_MODNAME,                            =
 \
> > +             .mod_name =3D DDEBUG_MODNAME,                            =
 \
> >               .base =3D _base,                                         =
 \
> >               .map_type =3D _maptype,                                  =
 \
> >               .class_names =3D _var##_classnames,                      =
 \
>
> [Severity: Medium]
> Will this drop classmaps for loadable modules if a maintainer overrides
> DDEBUG_MODNAME?
>
> When a loadable module is loaded, ddebug_module_notify() calls
> ddebug_add_module() using the module's actual load name (mod->name) to
> initialize the ddebug_table's module name.
>
> During initialization, ddebug_attach_module_classes() attempts to match t=
he
> classmap to the module by comparing strings:
>
> lib/dynamic_debug.c:ddebug_attach_module_classes() {
>     ...
>     if (!strcmp(cm->mod_name, dt->mod_name)) {
>     ...
> }
>
> If a maintainer uses the opt-in hook (e.g., ccflags-y +=3D -DDDEBUG_MODNA=
ME=3D'"power"')
> on a loadable module whose load name is "suspend", cm->mod_name will be "=
power"
> while dt->mod_name is "suspend".
>
> Since the string comparison fails, will all classmaps for the loadable mo=
dule
> be silently dropped, causing class'd pr_debug calls to lose their functio=
nality
> and trigger pr_warn spam on load due to unknown class IDs?
>

I have dropped the DDEBUG_MODNAME indirection,
am keeping the existing KBUILD_MODNAME.

While it has the effect of breaking up what might be considered a single mo=
dule,
like "power", into ~6 separate ones, with names like "core" and "main",
we can debate that separately, perhaps as an RFC,
since it touches so many builtin module names.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D14
