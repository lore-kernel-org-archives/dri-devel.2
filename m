Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646E3CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B261010E42B;
	Thu,  1 Oct 2026 23:25:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EIjsrCeM";
	dkim-atps=neutral
Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com
 [74.125.224.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3D710E42B
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 23:25:11 +0000 (UTC)
Received: by mail-yx2-f40.google.com with SMTP id
 956f58d0204a3-6756a6320f6so3193870d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 16:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790897110; cv=none;
 d=google.com; s=arc-20260327;
 b=owy6NPMwv2ZOvhb7oRW4uFBpZ7zdiyKDdrhnbGby8yyZMfKIp8YFu065Co7uzy8ZTI
 AiSNGp/wH2YYvvz+nu9RDCKypSHUWin+sNpeDU+a2CDoJ/TYfkaBIeiyOxiygphkxpcT
 108QMuqeAUEwJ46GuFcfRoVzEzDJuaJD+2Ad/YJaZpBN3mpewfq8yuKD0xVzzMrBsQbe
 ta9uS0KTitZcjBqAAX2So48Lg6Z+Z+IPqlwN1DEk0uTIKyh5MGJTdPnxQzqFqzN+5DCq
 ax2KwHrUlRkJUXOsJVLat0Tz7yG+vNCQZNvSh2bsnvGBcMjzmSv5stHvhANfytAlTjG7
 FCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z7GpKJHYk0xmN9tpUhQVKePKwe5CIuT1Vrxc26cesaY=;
 fh=p2luRu5j46srqLmWmL6pKRBPbvsM2+CDZsCeIj+UYAw=;
 b=qRxN8YdTBbfYQCFW1MV+RYaW61gjX5aRkRqx5Xd68B96UVdZlFUDY/6AJ7B4L7p/uK
 AXlw2laQlHE2qqUShqXi7ayJN5NVdPdXcCqbj7ARVpcRBcf1ukzNSTQfiNbbuTgmDXK/
 DRpijBodKxiwU1T+RYcZdgLskQwzqj1qhzw8qNc8hVtPA4SGc67XQH/5QUT/RBnzQmLX
 A5pSjJPim02ntu3BZHuFLb0X8EFpvnluBvu6H91wfXYsIAXZuOfimjCm56xVbuDmjZ81
 o4IfrQVYMP1J5GNtlVMlMhX7eh9pI1M9Ew8AWKnk4VZig37nxWGIHNZDv7T7KnGGgJSH
 I5FA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790897110; x=1791501910; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z7GpKJHYk0xmN9tpUhQVKePKwe5CIuT1Vrxc26cesaY=;
 b=EIjsrCeMMx0St6Od4O2O7f3Y3UL5hGovCh0uPnYxJW9ckQMZ6rHSKSg3xFQ1WorRfD
 M4p8bpd50d+jn25j8ttS2gyIEDjeigEgotxRcoUcev+RjFNTy5j+I/zGL21G1hGhKdeU
 4Us7ubRzh9FCHgP8lcfAGXaMku3Z01rT2KjWltow1pzuCI1nvVXfW+4YLF/pZeIBq0RF
 kf7Oermt+gLLg8ikCky3ZjGVFVk4aJ3pbtaReIB9I3B2AvD+A8XGhaqWZoJkKrjrJSon
 pHxmirEiCyS7VSs8D7VHVUF3msc+DPvENDcZF4hi8JnkuhNnDQo4yIBhbEnWPmmAEW6p
 o0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790897110; x=1791501910;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z7GpKJHYk0xmN9tpUhQVKePKwe5CIuT1Vrxc26cesaY=;
 b=mG5m1nJH0RrAoFRyMH5d4AdlqlYQ0vFP1y7DWw1WWYM70usNQ3kz1ESRPBQLI0bHQU
 M/da0F1XWiibAmNhPEy1VL37w/dPbZeZrLOLU+y72tdwRK0Vs2+RJXCiIfLaf9OlV1cJ
 RQdiuF/iqP7oIlrNPfjR1Yz1pJrt1Aw6PzhQIC4zH+pJbsSeGGJy+vMJwxYb66CQ1fR0
 o3Bvh7+1GXLRm0NHIa3cqJy8MWQ91TptJJeOE5D3jh2IoDPDd94mz66J6Lx1UR0BHXqI
 SAmVbBi9LVDK9tcoZfblmco1bYD6u0A/Dq4ZNbPbFQ2F2j7N27+6AfqoYeIB9/l2dxNe
 Bo+A==
X-Forwarded-Encrypted: i=1;
 AKwUvByh4+sAVeOXWIUv955z0ONXbW7XvxlAUSNckh07VDLc/YDnPrSoZq1prL+vo6i68jf2Jd5Dfku8yas=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIyMS6AXVBY6DsfKHjxzxdzAkSVhSUhsp0GjrnOqBM5A7Epcqjd
 0kIUoeCKLUlc79zPAhHOjPxB8LtsFELdrFhrEKGsNRTbVMm5V2Xl9kiIs/O5VWMm6gUzGU2CXt9
 Odn8RqRzXit1es9MO+qX77hOZum3gWqc=
X-Gm-Gg: AYBFou1MWSFL2YZtakCFacovlQ/iy3cOtIrl0y9X84bwVRm020vy9cEPAMOfb7h/b7H
 GPWQiigr3GJbyZzIxcujqQsf+/eI3DLi/BfzErComtB1xsxbpgNnF6mUhRarph6zVslbN1nMQhC
 EUJLT+xFCppl7kInWFpK7AFKKaekazQvSJjPa0qz+p2upQKYw2Ny45wslV7BwKqxlc5RXLtXvqI
 MKGAo1Iacc1WaO8Z5hE2e5t2DkeAzAK6AXqwJ50XLXFBD0kzNtSpjou2LIgN0rQik5HwdWJvcRK
 aUXv5ABPbWu19fInbVOvCR+ZsumY9kLiCeIimZzxSKj2wRNpDDfuxYiLp/jxm8z8BldWvShxsT9
 /+dFYUSAcGBBNK5VB6TKtyu7CUfojRkMmyA==
X-Received: by 2002:a05:690e:80c:20b0:674:1e39:446 with SMTP id
 956f58d0204a3-677abff80d8mr347805d50.39.1790897110259; Thu, 01 Oct 2026
 16:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-24-9b6c217fdf2f@gmail.com>
 <20260923224520.0FC9A1F000FF@smtp.kernel.org>
In-Reply-To: <20260923224520.0FC9A1F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 17:24:44 -0600
X-Gm-Features: AclHuK8BjtsIPOJOBV_6x7QlYWrq8f66IubOXehmbQGa_J9fPwf-nlNjvUt1OkA
Message-ID: <CAJfuBxyg=oJ59-2o8b9CGKeQvaYbTM6HXj6+C-zd+PmpKBmu8w@mail.gmail.com>
Subject: Re: [PATCH v11 24/38] selftests/dyndbg: Enable FT_classmap_inheritance
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

On Wed, Sep 23, 2026 at 4:45=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] selftests: classmap inheritance hash check excludes submod
> - [Low] selftests: undocumented uncommenting of grammar testcase
> --
>
> commit 7d522a72bd526c1e41ef1a1e604e466e1e729843
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> selftests/dyndbg: Enable FT_classmap_inheritance
>
> Exercise classmap state inheritance between supermod and submod,
> verifying that class settings and controlling parameter states propagate
> from parent classmap definitions to dependent class users upon module
> load and during runtime reconfiguration.
>
> > diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b=
/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > index c279c795867b6..5a805cb30e6cd 100755
> > --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> [ ... ]
> > @@ -189,7 +190,7 @@ function FT_grammar_ok {
> >
> >      # use 4 keywords (max 9 words inc flags)
> >      ddcmd "module foo file bar.c func buz class D2_CORE +_"  # 4 keywo=
rds
> > -    #ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 k=
eywords
> > +    ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 ke=
ywords
>
> [Severity: Low]
> Was this undocumented uncommenting of a grammar testcase intentional?
>
> It modifies the behavior of an existing, separate test in FT_grammar_ok w=
ithout
> documenting it in the commit message.
>
> [ ... ]
> > @@ -291,6 +292,78 @@ function FT_basic_queries {
> >      ddcmd "file $f =3D_" "$f"
> >  }
> >
> > +function FT_classmap_inheritance {
> [ ... ]
> > +    # Real-time mathematical proof that load-time (modprobe) parameter=
 parsing
> > +    # and runtime (sysfs write) parameter configurations are perfectly=
 equivalent!
> > +    local hash_modprobe=3D$(slice_and_hash_ddctrl '\[test_dynamic_debu=
g\]')
> > +
> > +    # Fresh load with default parameters, then configure them dynamica=
lly at runtime
> > +    ifrmmod test_dynamic_debug_submod
> > +    ifrmmod test_dynamic_debug
> > +    my_modprobe test_dynamic_debug
> > +    my_modprobe test_dynamic_debug_submod
> > +    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_b=
its
> > +    echo 5 > /sys/module/test_dynamic_debug/parameters/p_level_num
> > +
> > +    local hash_sysfs=3D$(slice_and_hash_ddctrl '\[test_dynamic_debug\]=
')
>
> [Severity: Medium]
> Does this classmap inheritance hash check exclude the submodule?
>
> Because of the strict regex using escaped brackets, the grep strictly mat=
ches
> the parent module's section and filters out all [test_dynamic_debug_submo=
d]
> lines.
>
> Consequently, the hash equivalence check only proves the parent module re=
sponds
> correctly, ignoring the dependent submodule whose inheritance is supposed=
ly
> being tested in FT_classmap_inheritance.
>

The test does not ignore the submodule; earlier steps in
FT_classmap_inheritance explicitly verify submodule inheritance across
both modules via verify_control_slice 'test_dynamic_debug' against
the golden records database, and step 6 validates runtime logging.

However, broadening the step 5 modprobe-vs-sysfs equivalence check
to verify both modules simultaneously is a good improvement. For v12,
I've updated the pattern to '\[test_dynamic_debug*\]', proving that
both supermod and submod callsites match identically across load-time
and runtime parameter configuration.


> > +    if [ "$hash_modprobe" !=3D "$hash_sysfs" ]; then
> > +        echo -e "${RED}: Load-time vs runtime parameter equivalence ch=
eck failed!${NC}"
> > +        exit $ksft_fail
> > +    else
> > +        v_echo "${GREEN}: Proven: parameter load-time (modprobe) " \
> > +            "and runtime (sysfs write) are equivalent!${NC}"
> > +    fi
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D24
