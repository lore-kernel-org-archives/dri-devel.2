Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2254BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C3F10E675;
	Wed,  8 Jul 2026 20:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kzSUZsLd";
	dkim-atps=neutral
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E43210E675
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:48:53 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-6651bc57458so947055d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 13:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783543732; cv=none;
 d=google.com; s=arc-20260327;
 b=g7WSZ4nCest7UuH6owvJbq2Wozut3itZofyhX72chX1+kY11hHmMMIqSjQP/BXsr+m
 TTqfvUYhIYomAALguL+SinFjajxSmw8k6pTGADaFxCHS2OIza7OHV2EY8PWat9KgZc/v
 12vdqHqsoHylMogz0mwX/Im9VWYscOIve1EI/BqjVwmVEasJEel34/MQxveQRgxGgvAW
 adlLAaldTkToFENQifq5SlEaTEXAIKyF3lTVTxAIlH0n95hOTfYQmkRRM3qqYpPpS0rP
 OJTkiX3j4AcvGOTtrf8J8qjP2q+YKRem5AfL0nC9V+1N+08ggugROQxxNrEG+hvtJmeI
 yi/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0Su5iC7GyWFqasMSbo6foK0Ud8wXMN0xjdKWMhHqwlc=;
 fh=zz51zJeFPYjm6pRQ9au9FXSkCb5f+jQKbkWbdb3Zkfw=;
 b=Q5ZDB/Gnt38XNNC8hC2jNP+48qOcVbgbcpHuG6BpiSBU+VdDz33Dtu63BkFtpIHLYC
 C3zx4DTKkwmaPxmRV6jEtiHr8oqvV5HU/FglzT91rgBFVl1/OZ0wZpWA/cKYKZSf2Jz/
 QCBnsIhyV7Hkje/TdPqJ29yMYniM1sM3CeRsy8I57ml4ItDgE5voRDpMra5XZghVqXj8
 KpLn8TstM0pD8clCxtupWjXdCszbuUd1Y/4bgYlip5tHOM6uZIJwy8YxJsK8U1QwpDLQ
 YoBjTnjKu6ZMoS377gYeeqD2folFBk2gYfnqJLBJWU1JNyRUc4pXuJJIdpS6TU9qxDF1
 JJfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783543732; x=1784148532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0Su5iC7GyWFqasMSbo6foK0Ud8wXMN0xjdKWMhHqwlc=;
 b=kzSUZsLdSPzl7lA9Y2Bzs7dd6dtJd+g1jW1TRwqZiq/TNQJH/owAGFYJ83RFS7dxD/
 DOidV3ftBfiq9/uHbhnqdhxOP0r7P0vPJ20Y9fPt0aiyJQA8fvh6H9ZDn/2Xi7mPYl7+
 z/wYoaieVoasFq8nk59eIWOlf5kyjojU9BUFTztCopOSUDAqPbuG8ij6AfQaXX6EXzpQ
 xv/PDEErDzxez/mY0Zvvo4tOCA+7JwJiSE3+0qBVSBHQ4hFO5vj9WwEUroVrW+7uVCb9
 fDuSB5mxYHC3RXw7zZn644CMRJl4Nl+bwSGdnNDmvt80Jf5DkTbFZ9ywpqQjCBpLxkJb
 FXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783543732; x=1784148532;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Su5iC7GyWFqasMSbo6foK0Ud8wXMN0xjdKWMhHqwlc=;
 b=n6U7U5Ilsk999dFs6BiKVM/iHKt+N9kqLmXDqTYBI4RJ+UbIYB3QIVU5PHtP5W/TMl
 UFfE9otxkbhOfkDiobw5uK6tKUAxe+gRXdOsUNCgLLc8WvWlN054X6XRFGMO90Jx7Q1D
 NfeCg3Tf3Rb5KgdW20F8SbgmrRqcpokzuSM9j3YEEQTx6pDuZNz4ZpuiCryfRElGVH+c
 QOd90X1It+ktWaiFHfTBk2zlf2nVh4aw845rebtAtKaf/CKuid01Bkn3w9UxXlN6PkC0
 Hg2/OQN0rMerDeAKCzbu7Mi/dIiHHHlaYj46Z6OnKB8J5OupfOEEjvcjV8ucxflBWBts
 q+uA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOtF+z24OiCWMfldrTlEbkY5zrbteljveYmVu1Kwv2zmu6OiBbaI98EnRzIqXfhNnHBxK6Leyybks=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7R8YigWX3plTzNTnR/pqURsmzX1naPrGf0fBSMpZeaL0up3rs
 KNdPNiLpJ6W7ietDeEX0vPCnBlsUQd/nJVuQ50gSGZ40Zokc5cdpp6s3BkF3uTZKxv/WrSvjoYY
 GsjLmTtE7c4thfUoA88YfV8CDGzVDx5Y=
X-Gm-Gg: AfdE7cmmLVFPNshy2FKLcNpA+6j4T6d6paZ4w5p6GLxCNnEcfRHn6KrATbl4TUHvIbr
 jlWpPjId2h3o7aW5xJb6cCfIzBHlSsDQf9VBaC+vPVsUkDd1Qe33No+WVplvvBBInBEQyFqZr8B
 2kOW30jOS/gAyRrvaDR7NE1BuOc4/pGtghLxN/LSQUmYC7gw6QPynLk3x5TpyKQhVe1Vo75PMya
 3e86Wq8nSlaK3r2QdelhiB5LLMAbdxMJzlC3XqT+c1JLt1vlSkdyrDEVMF6lEU1z+GmyXA4pDGG
 /Dzl
X-Received: by 2002:a05:690e:1348:b0:667:b08e:2a2 with SMTP id
 956f58d0204a3-667b08e0ae6mr1729856d50.27.1783543732085; Wed, 08 Jul 2026
 13:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-19-381f3edb0045@gmail.com>
 <20260708023725.52B9E1F000E9@smtp.kernel.org>
In-Reply-To: <20260708023725.52B9E1F000E9@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Wed, 8 Jul 2026 14:48:24 -0600
X-Gm-Features: AVVi8Cef1o43P0BcIrbKibkv5LgOWcV8WhWKRwgZJ3xzNcwlJwrD7Ugwb6QN5b0
Message-ID: <CAJfuBxx+5i4z77hC5BEDkyegE0FWjGRfBfWM6M_nkk94btfO0w@mail.gmail.com>
Subject: Re: [PATCH v6 19/24] dyndbg: pin class param storage to u32
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Tue, Jul 7, 2026 at 8:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Support for classmaps with more than 32 classes is broken, cau=
sing undefined behavior on 32-bit architectures and silent truncation on 64=
-bit architectures.
> --
>
> --- Patch [19]: [PATCH v6 19/24] dyndbg: pin class param storage to u32 -=
--
> commit df6ebc9b56fab43581ec7860d30aab6f33272ee2
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: pin class param storage to u32
>
> This commit changes the storage of dyndbg class parameters from unsigned =
long
> to u32 for consistency across architectures. It also shrinks __drm_debug =
back
> to u32.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index d99c69b9ad12f..af05f4ae3b55e 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > @@ -643,24 +643,27 @@ static int ddebug_apply_class_bitmap(const struct=
 ddebug_class_param *dcp,
> >       int bi, ct;
> >
> >       if (*new_bits !=3D old_bits)
> > -             v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_=
bits,
> > +             v2pr_info("apply bitmap: 0x%x to: 0x%x for %s\n", *new_bi=
ts,
> >                         old_bits, query_modname ?: "'*'");
> >
> >       for (bi =3D 0; bi < map->length; bi++) {
> > -             if (test_bit(bi, new_bits) =3D=3D test_bit(bi, &old_bits)=
)
> > +             bool new_b =3D !!(*new_bits & BIT(bi));
> > +             bool old_b =3D !!(old_bits & BIT(bi));
>
> [Severity: Medium]
> Since classmaps can theoretically contain up to 63 classes (as mentioned =
in
> the commit message), is there a risk of an out-of-bounds shift on 32-bit
> architectures?
>

A macro in a later patch (not in this series) limits a classmap to 32 class=
es,
which is a practical limit for usability of classmap params.
As a case in point, drm.debug has only ~10 DRM_UT_* values.

64 is a per-module class-id space, allowing modules to have several classma=
ps.
a classmap's base/offset lets it map its 0..31 range into upper class-ids,
which is how a module can have multiple, non-overlapping mappings.


#define __DYNAMIC_DEBUG_CLASSMAP_CHECK(_clnames, _base, _mapty)         \
        static_assert(((_base) >=3D 0 && (_base) < _DPRINTK_CLASS_DFLT),  \
                      "_base must be in 0..62");                        \
        static_assert(__DDEBUG_ARRAY_SIZE(_clnames) > 0,
                 \
                      "classnames array size must be > 0");             \
        static_assert(__DDEBUG_ARRAY_SIZE(_clnames) <=3D 32,
         \
                      "classnames array size must be <=3D 32");           \
        static_assert((__DDEBUG_ARRAY_SIZE(_clnames) + (_base)) <
_DPRINTK_CLASS_DFLT, \
                      "_base + classnames.length must be <=3D 62");       \
        static_assert(((_mapty) >=3D DD_CLASS_TYPE_DISJOINT_BITS) &&      \
                      ((_mapty) <=3D DD_CLASS_TYPE_LEVEL_NUM),            \
                      "unknown class_map_type")

So while its currently possible to define a problematic classmap,
that will not be possible soon.


> BIT(bi) expands to 1UL << bi, so if map->length is greater than 32, this
> shift would exceed the capacity of an unsigned long on 32-bit systems.
>
> On 64-bit systems, *new_bits is now a u32. When it is combined with BIT(b=
i)
> using a bitwise AND, the u32 is zero-extended. Will this cause new_b and
> old_b to always evaluate to 0 for classes >=3D 32, silently ignoring the
> requested state?
>
> [ ... ]
> > @@ -704,24 +707,24 @@ static int param_set_dyndbg_module_classes(const =
char *instr,
> [ ... ]
> >       case DD_CLASS_TYPE_LEVEL_NUM:
> >               /* input is bitpos, of highest verbosity to be enabled */
> >               if (inrep > map->length) {
> > -                     pr_warn("%s: level:%ld exceeds max:%d, clamping\n=
",
> > +                     pr_warn("%s: level:%u exceeds max:%d, clamping\n"=
,
> >                               KP_NAME(kp), inrep, map->length);
> >                       inrep =3D map->length;
> >               }
> >               old_bits =3D CLASSMAP_BITMASK(*dcp->lvl);
> >               new_bits =3D CLASSMAP_BITMASK(inrep);
>
> [Severity: Medium]
> Will this silently prevent enablement of classes >=3D 32?
>
> CLASSMAP_BITMASK was changed to limit the generated mask to 32 bits, but
> map->length is not restricted to 32.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint=
-2-v6-0-381f3edb0045@gmail.com?part=3D19
