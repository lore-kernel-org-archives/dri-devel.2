Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742E0C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 17:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7091A10E094;
	Sun, 20 Sep 2026 17:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D+olj9h7";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7277910E094
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 17:14:44 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-66e4ab1ef11so1862352d50.0
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 10:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789924483; cv=none;
 d=google.com; s=arc-20260327;
 b=UyaYvFzqgKMsBYrn2n2Ytld39exy0gxC2ZcGrtqyqon7SoP7CvRHDWtkwQ1wayU5kx
 Sjrw6YM60nqCAw9CSNlhJvH73luX4BAVDsZ4woN+7hLXvWi05iyxRY9tgXa26XHFNsMT
 ZY7oA6fCKbF4yXC5bjdAu4Pjt/uIbiFBASxuqPHfChOevzOsB/meHyRaaeNNJd3uYxYo
 OoJmDb/YK4K6xdTthKwH0b848hE7t7BVi0daWj5TtyweKJx+NnBPjkQfXVyMzEINDHKw
 /1qIRXFENpb2JjvIcECOyl5p1roiDPUj6BnBO1HGmUzIM6WTRcuhXMNV83vNnohtjvdi
 Pt0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3qKK92CUvs5k4rsIehGf9KlAqh1JVMknTOYV/ZCR990=;
 fh=QHLF2KgKjDW+9txFJXWJLUhMCyTioQXKAcqvl0/vlj4=;
 b=I24EH+6U/+IicVA6TTzFBTg2Gjq+JKOQ2yG5/DmN39gFqADk8uYmKMgpZxaayKUJeK
 W9cHq1bEnuod+JRYOXc7B/p4wdoKJfQtvR+axsR2lZdIwBDrbt1XXTgUdGmv0fJa3T58
 fnmUbS4hk1gogMW+B3z63gxnexaR248bxh1RcWG+Z652cDFfdrioPFtM6NY7xnA9QfSZ
 HSo3yWim14C7jdINqXgudmUClykL142+lYVgszq4BFObjmGDGSMCh81Vf/SZbdJCq5N7
 Zl6q+iZtcrK0cR3fI7om24Fzil8cWPv2a8q4j1PwIT/bSPF9o0No8KrhnnhLQ4CbXV8Q
 B2Eg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789924483; x=1790529283; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3qKK92CUvs5k4rsIehGf9KlAqh1JVMknTOYV/ZCR990=;
 b=D+olj9h7jil8ftf+58emyrk9TAwi6taYH09YsnxxqYRNd0jeXsii/PUU3B54XHCCvX
 vh5hIekbfNE4Ht4Dv3TtpT6xZ75HnEYd3twz9IOrPpDO7d7DZwjaVnFL7brsdNdjNUEN
 lOcJT2xi+EgoflgTZu7FpE01hQcglyjdUNQe/mx31TpI7WlhcIJFHNvopmLEaqcoXg3m
 ejff5h6R/MeWRVD4WwFsXjgrDMIFhdYNDtO92W+PWabwZUpmrvlj5TkLh7+br6GDJ20j
 PMhoICAgnvdnWDP8x9ypZMdnlmAyPNwPvdfo6wA8skcRl2lNrrhXmdeN6OsO85WelTyw
 g4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789924483; x=1790529283;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3qKK92CUvs5k4rsIehGf9KlAqh1JVMknTOYV/ZCR990=;
 b=ZofecvC7S2nIRzsvIQVS+aVbkLea/YfMtqu6rv3klFF3HC3dXfxqSMYxGprGcFp4Y5
 BcAyLPhBSQOb5uiHsCxyPUqG+O7EJ7yyhWZMN24G2ltMZxu4rhhNhRD/Ws/+GefctFm2
 KzaN1bZ3oEDh2grkQiQZj2T9MxbHw4wBVnxfXEHAB1Ns9AB8HsPqUb3Cw2/Y6qyxkruf
 vTPjr73/PNsu5y4QnCFD3MJ4P6K74UNQCa8K7WT93CNIkzGVkq1eAdW0WFp2g3y9yR+v
 1DDOsE7i8WDn0bIqT6DhOu1aM0XVGb5u1KaxxK2JTq6jnS5342UzUhBQg4NuVSlO/Zf5
 5j5w==
X-Forwarded-Encrypted: i=1;
 AKwUvByCGkVOcn7SfD4IT5XorjyYSgi2eqExnAQY2rAFbt6pnRtoI7MmJZsNfzfJOWbmeVi1aUfdxuBzDfo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+GYL/LdhE7sLPHGaCnc9L7xwTTHYCySmeuHrprai4e2ZTcUS/
 E44fGJK7Ojt9eumxGZ2igmo2V5MypaduFRLLM1awNeabLYb8K83jCbKl77JH8eGJgJcVEeWMt2T
 nFLWGpKFlXDAIyVh02zX3Aq2M86QkuWU=
X-Gm-Gg: AYBFou1O6Ewh5JltHVxxjQzF2uQdnpMhpXexVYQy8JJSbwY9Zzuy/SJkXXNaZRivbgB
 w/gIBg9b4+AKopFCMqszZKEqnXSsnJUMe231aYZm/uOqfGEJ74h2PnT+80vtdHJf0JG3SuNaYQf
 dnUjhyNd6Ysc1fqc16D/PrjLuOiBtxHORb6rHqfksNjY/cGl0ZHkXYuFBCQZtsRAfwQCPZhkpFb
 IVVHSF6LbXR4erLoN+4nRuhNNsSD3aj5EVi6tll3AkLecgd/NFTUnu/cVtGj7MvxcOiwKzlPU+L
 vsC0G3x+gcrORbmugVxAR+WcgPx644wfRpZM3YRFvD1vWvilmNoAcjIWWqSW0yU38kUCqqCyeRE
 cPiwZ49PmP96LMBTr7e5gAdVLtjLvD8RpoAY=
X-Received: by 2002:a05:690e:118a:b0:66f:c1bc:c075 with SMTP id
 956f58d0204a3-6717fda7a0bmr2556364d50.61.1789924483024; Sun, 20 Sep 2026
 10:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-24-af4cf4767707@gmail.com>
 <20260916162426.BF6241F000FF@smtp.kernel.org>
In-Reply-To: <20260916162426.BF6241F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Sun, 20 Sep 2026 11:14:16 -0600
X-Gm-Features: AcwNN1X7q451ICBpdOyt-TJstfqmKKPu0eSm2HgX-tFRud22c30bZ8jGRsZuUs0
Message-ID: <CAJfuBxxekVDsLb2e40qx8VAPTjTohGHBQGup0UxPPixpOGy4UQ@mail.gmail.com>
Subject: Re: [PATCH v10 24/38] selftests/dyndbg: Enable FT_classmap_inheritance
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000fc4aef065bed44fc"
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

--000000000000fc4aef065bed44fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 10:24=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:
> - [Medium] selftests: dyndbg: load-time parameters truncated due to shell
quoting bug
> --
>
> commit f2f3cad7addd566a67a218932463053f35d4d782
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> selftests/dyndbg: Enable FT_classmap_inheritance
>
> Exercise classmap state inheritance between supermod and submod,
> verifying that class settings and controlling parameter states propagate
> from parent classmap definitions to dependent class users upon module
> load and during runtime reconfiguration.
>
> > diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > index 09a8dbf239dcf..51338ebc74bf8 100755
> > --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> [ ... ]
> > @@ -298,6 +299,78 @@ function FT_basic_queries {
> >      ddcmd "file $f =3D_" "$f"
> >  }
> >
> > +function FT_classmap_inheritance {
> > +    v_echo "${GREEN}# TEST_MOD_SUBMOD ${NC}"
> > +
> > +    ifrmmod test_dynamic_debug_submod
> > +    ifrmmod test_dynamic_debug
> > +
> > +    # modprobe with plain-old +p & 3 class enablements
> > +    my_modprobe test_dynamic_debug \
> > +     "dyndbg=3D+p;class D2_CORE +pf;class D2_KMS +pt;class D2_ATOMIC +=
pm"
>
> [Severity: Medium]
> Are these load-time parameters truncated during module load due to how th=
e
> shell handles quotes?
>

yes it does.  thats the reason a subsequent patch adds the comma as
token-terminator.
Ive folded this problem out in next rev.

> When bash evaluates and strips the double quotes before executing
modprobe,
> modprobe constructs the kernel options string without adding quotes aroun=
d
> the parameters. The kernel's parse_args() function (using next_arg() in
> lib/cmdline.c) splits module parameters at unquoted spaces.
>
> This means it treats D2_CORE and +pf as separate unknown parameters. The
> dyndbg parsing logic executes +p but fails on the truncated class command=
,
> completely ignoring the actual class configurations.
>
> Does this defeat the test's intent to verify load-time classmap
inheritance,
> allowing it to pass only because the golden hash recorded the incorrectly
> applied +p state?
>
> It appears this space-splitting flaw persists through the end of the patc=
h
> series, and the newly added FT_test_classes also replicates it.
>
> > +    verify_control_slice '\[test_dynamic_debug\]'
> > +
> > +    set_param 5 /sys/module/test_dynamic_debug/parameters/p_level_num
> > +    verify_control_slice '\[test_dynamic_debug\]'
> > +
> > +    my_modprobe test_dynamic_debug_submod
> > +    verify_control_slice 'test_dynamic_debug_submod'
> > +
> > +    # fresh start, to clear all above flags (test-fn limits)
> > +    ifrmmod test_dynamic_debug_submod
> > +    ifrmmod test_dynamic_debug
> > +
> > +    # load submod, which loads supermod
> > +    my_modprobe test_dynamic_debug_submod \
> > +     "dyndbg=3D+p;class D2_CORE +pfs;class D2_KMS +pts;class D2_ATOMIC
+pmf"
>
> [Severity: Medium]
> Does this submod load suffer from the same space-splitting issue?
>
> > +    verify_control_slice 'test_dynamic_debug'
> > +
>
> --
> Sashiko AI review =C2=B7
https://sashiko.dev/#/patchset/20260916-dd-cmap-part2-clean-v10-0-af4cf4767=
707@gmail.com?part=3D24

--000000000000fc4aef065bed44fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Sep 16, 2026 at 10:24=E2=80=AFAM &lt;<a hr=
ef=3D"mailto:sashiko-bot@kernel.org">sashiko-bot@kernel.org</a>&gt; wrote:<=
br>&gt;<br>&gt; Thank you for your contribution! Sashiko AI review found 1 =
potential issue(s) to consider:<br>&gt; - [Medium] selftests: dyndbg: load-=
time parameters truncated due to shell quoting bug<br>&gt; --<br>&gt;<br>&g=
t; commit f2f3cad7addd566a67a218932463053f35d4d782<br>&gt; Author: Jim Crom=
ie &lt;<a href=3D"mailto:jim.cromie@gmail.com">jim.cromie@gmail.com</a>&gt;=
<br>&gt;<br>&gt; selftests/dyndbg: Enable FT_classmap_inheritance<br>&gt;<b=
r>&gt; Exercise classmap state inheritance between supermod and submod,<br>=
&gt; verifying that class settings and controlling parameter states propaga=
te<br>&gt; from parent classmap definitions to dependent class users upon m=
odule<br>&gt; load and during runtime reconfiguration.<br>&gt;<br>&gt; &gt;=
 diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/to=
ols/testing/selftests/dynamic_debug/dyndbg_selftest.sh<br>&gt; &gt; index 0=
9a8dbf239dcf..51338ebc74bf8 100755<br>&gt; &gt; --- a/tools/testing/selftes=
ts/dynamic_debug/dyndbg_selftest.sh<br>&gt; &gt; +++ b/tools/testing/selfte=
sts/dynamic_debug/dyndbg_selftest.sh<br>&gt; [ ... ]<br>&gt; &gt; @@ -298,6=
 +299,78 @@ function FT_basic_queries {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0dd=
cmd &quot;file $f =3D_&quot; &quot;$f&quot;<br>&gt; &gt; =C2=A0}<br>&gt; &g=
t; <br>&gt; &gt; +function FT_classmap_inheritance {<br>&gt; &gt; + =C2=A0 =
=C2=A0v_echo &quot;${GREEN}# TEST_MOD_SUBMOD ${NC}&quot;<br>&gt; &gt; +<br>=
&gt; &gt; + =C2=A0 =C2=A0ifrmmod test_dynamic_debug_submod<br>&gt; &gt; + =
=C2=A0 =C2=A0ifrmmod test_dynamic_debug<br>&gt; &gt; +<br>&gt; &gt; + =C2=
=A0 =C2=A0# modprobe with plain-old +p &amp; 3 class enablements<br>&gt; &g=
t; + =C2=A0 =C2=A0my_modprobe test_dynamic_debug \<br>&gt; &gt; + =C2=A0 =
=C2=A0 &quot;dyndbg=3D+p;class D2_CORE +pf;class D2_KMS +pt;class D2_ATOMIC=
 +pm&quot;<br>&gt;<br>&gt; [Severity: Medium]<br>&gt; Are these load-time p=
arameters truncated during module load due to how the<br>&gt; shell handles=
 quotes?<br>&gt;<br><br>yes it does.=C2=A0 thats the reason a subsequent pa=
tch adds the comma as token-terminator.<div>Ive folded this problem out in =
next rev.<br><div><br></div><div>&gt; When bash evaluates and strips the do=
uble quotes before executing modprobe,<br>&gt; modprobe constructs the kern=
el options string without adding quotes around<br>&gt; the parameters. The =
kernel&#39;s parse_args() function (using next_arg() in<br>&gt; lib/cmdline=
.c) splits module parameters at unquoted spaces.<br>&gt;<br>&gt; This means=
 it treats D2_CORE and +pf as separate unknown parameters. The<br>&gt; dynd=
bg parsing logic executes +p but fails on the truncated class command,<br>&=
gt; completely ignoring the actual class configurations.<br>&gt;<br>&gt; Do=
es this defeat the test&#39;s intent to verify load-time classmap inheritan=
ce,<br>&gt; allowing it to pass only because the golden hash recorded the i=
ncorrectly<br>&gt; applied +p state?<br>&gt;<br>&gt; It appears this space-=
splitting flaw persists through the end of the patch<br>&gt; series, and th=
e newly added FT_test_classes also replicates it.<br>&gt;<br>&gt; &gt; + =
=C2=A0 =C2=A0verify_control_slice &#39;\[test_dynamic_debug\]&#39;<br>&gt; =
&gt; +<br>&gt; &gt; + =C2=A0 =C2=A0set_param 5 /sys/module/test_dynamic_deb=
ug/parameters/p_level_num<br>&gt; &gt; + =C2=A0 =C2=A0verify_control_slice =
&#39;\[test_dynamic_debug\]&#39;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=
=A0my_modprobe test_dynamic_debug_submod<br>&gt; &gt; + =C2=A0 =C2=A0verify=
_control_slice &#39;test_dynamic_debug_submod&#39;<br>&gt; &gt; +<br>&gt; &=
gt; + =C2=A0 =C2=A0# fresh start, to clear all above flags (test-fn limits)=
<br>&gt; &gt; + =C2=A0 =C2=A0ifrmmod test_dynamic_debug_submod<br>&gt; &gt;=
 + =C2=A0 =C2=A0ifrmmod test_dynamic_debug<br>&gt; &gt; +<br>&gt; &gt; + =
=C2=A0 =C2=A0# load submod, which loads supermod<br>&gt; &gt; + =C2=A0 =C2=
=A0my_modprobe test_dynamic_debug_submod \<br>&gt; &gt; + =C2=A0 =C2=A0 &qu=
ot;dyndbg=3D+p;class D2_CORE +pfs;class D2_KMS +pts;class D2_ATOMIC +pmf&qu=
ot;<br>&gt;<br>&gt; [Severity: Medium]<br>&gt; Does this submod load suffer=
 from the same space-splitting issue?<br>&gt;<br>&gt; &gt; + =C2=A0 =C2=A0v=
erify_control_slice &#39;test_dynamic_debug&#39;<br>&gt; &gt; +<br>&gt;<br>=
&gt; --<br>&gt; Sashiko AI review =C2=B7 <a href=3D"https://sashiko.dev/#/p=
atchset/20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com?part=3D24=
">https://sashiko.dev/#/patchset/20260916-dd-cmap-part2-clean-v10-0-af4cf47=
67707@gmail.com?part=3D24</a></div></div></div>

--000000000000fc4aef065bed44fc--
