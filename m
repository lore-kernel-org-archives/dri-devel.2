Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D99C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4BA10E9FE;
	Tue, 25 Aug 2026 12:15:50 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBD410E9FE
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:15:48 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-73a442f7cd3so2454014137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 05:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660147; x=1788264947;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CEQlDORbsq7fZcBmgPspHpPEQcLsNmOGZMeC3aM3Zuc=;
 b=JX2XL0mRD3+KPqy2C4o2PtXsgi70vZGJSF9x7Vigu4AI7lLHbbIAiCVtftWy3Itgm9
 kddOE9Uf4pjaZfrDcBlt6XDJ7PBM8qcd7tqclqaTY8Uk1LwG79VoyV/bemCyFt+QCaYT
 kv4a63n2XcoIc0eVlGSC9R2r2ypkrIc0ODdBNkNcgSpGRbB9gwBe3SsHmfMgVEgJzAfW
 261Jlvd+QNnKwg7bTG7/i4lT5B62rjaFWFNiMTZgIyiGQphvMC4OEvso475mlcKfbXWe
 +gS8aqReSNRwteLUX1EKJtb1/6j39GpABPPDABs0BPZaO+D4kriCwJWYp5F+p0bQnFBk
 9a/A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6WNmedq5WLgs2ExzcmuL0q8vwLDTunDL51s1bBM0tOeMsASRsL1H335a0k0rcQo+dlag5C3K33pc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nsS+jIei1OakSG87mmGw0WkwfQsVU5+iOT+zDdVccIOf38yLMW
 w8FiW46iS/J7GLpyKuAuT1l7rXSMtULIr2ZU/W6VxdjnkyWX1AjsRF3fcBesK8+cHHc=
X-Gm-Gg: AR+sD11xLsJ9NL36i+Yoonnrwpjc8eZWup6P7QE1csXdfjRN692zIa7CAn14U2VPmio
 YU3B6IjUDJ0Cv40eJNA4ebmhCBpcazyL3s7OpB+ZO5an7NFFs8FBnm5+6NJDf5AFwLvBUcRaUkU
 mCiUCjC9LTIibdWfN35/vZCYvA0Dphf9/4xk4wwv58iGh3NLMNMNs4RTK/TCfmgzSxXHSqUykCx
 8iA413vuGCRQ+e04gHENzU/EV62vQ/x5I1f/iYC32AWVUwyCWbgpQHzfM5kqe+QLAwFuY8yGCEJ
 vWIi9al18KbfdKHtO4+fVcUn0yP7JtGMU1cf7KwGWu5NYAoaNaExzj/Fa8p9v6fdB7K1syqLUPS
 8d35EQq6WfggCXtefHtYFd2JseidKw4XfwyIXEjTLiLcaroveCCpQw0ofrK/6lAd08twfJuf/7T
 ZAllxgTY+8Pr3XXe9+B9yrTUxiz1B/FTZPaWAD+mnIVKr6dMGSiTyPOUMJx3mKhWnqKewSM43gb
 iUg/8E+ducwS9ADbBYJkop8Gw==
X-Received: by 2002:a05:6102:6883:b0:778:86f2:9f26 with SMTP id
 ada2fe7eead31-77fe9c1a4a7mr2377499137.9.1787660147066; 
 Tue, 25 Aug 2026 05:15:47 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com.
 [209.85.217.52]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-77d8357ccf6sm5320638137.4.2026.08.25.05.15.46
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 05:15:46 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-74a9ac9cda6so2593717137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 05:15:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpgJneIQzambMXmDDxls+0eVQkESAQN7mlMO78WiLSDhlRTm5VHkJlXC7+0VqwIiNUiKxxDRfb2XvU=@lists.freedesktop.org
X-Received: by 2002:a05:6102:a48:b0:77a:ce37:9884 with SMTP id
 ada2fe7eead31-77feac33b60mr2347080137.14.1787660146138; Tue, 25 Aug 2026
 05:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <1e519fb24aa5521788d69cc7980665ccbc227b14.1787584184.git.geert@linux-m68k.org>
 <ao1hIejAdBPKUHFW@kniemiec-mobl1>
In-Reply-To: <ao1hIejAdBPKUHFW@kniemiec-mobl1>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 14:15:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWuG_s3Rm-gLc2KNw9Z0bptQjdDDGH+9YawEMEsFZZ6Nw@mail.gmail.com>
X-Gm-Features: AcwNN1UDGSe-NYvdVfySLOjOIV0hwEpIGT0yDB-s9yaAhlTbK7bvzY05-aj9Td4
Message-ID: <CAMuHMdWuG_s3Rm-gLc2KNw9Z0bptQjdDDGH+9YawEMEsFZZ6Nw@mail.gmail.com>
Subject: Re: [PATCH] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Karas <krzysztof.karas@intel.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Maarten Lankhorst <dev@lankhorst.se>, 
 Andi Shyti <andi.shyti@linux.intel.com>, dri-devel@lists.freedesktop.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Krzysztof,

On Tue, 25 Aug 2026 at 13:39, Krzysztof Niemiec
<krzysztof.niemiec@intel.com> wrote:
> On 2026-08-24 at 17:12:30 +0200, Geert Uytterhoeven wrote:
> > Enabling a (modular) test should not silently enable additional kernel
> > functionality, as that may increase the attack vector for a product.
>
> What vector? What product, exactly? As far as I know buddy allocator code is

Any product that uses DRM and has CONFIG_KUNIT_ALL_TESTS=m, so
developers can easily run any relevant test when the need arises.

> currently loaded when a) loading a drm driver (which would need that code

Not just "a drm driver": very few DRM drivers use it.
Hence one can have a product with DRM that does not need the buddy
allocator.

> to function anyway) and/or b) loading the kunit test for the buddy allocator,
> which would need that code to function anyway. And AFAIK neither are
> built unconditionally into the kernel. So the amount of potential vuln
> surface is not exposed beyond what is reasonably required for the system to
> function as intended.
>
> If you've found a concrete bug/exploit/"attack vector" utilizing buddy code,
> then please address that directly.

So let's include all available code in the kernel image anyway, unless
you can point at a concrete bug/exploit/"attack vector"???

> > Fix this by reverting the select to a dependency.
>
> The way drm kunit tests do it is by select-ing the appropriate
> functionality out of the available ones, with "broad" depends-ons for
> DRM and such (say "depends on DRM\n\n select DRM_BUDDY"). DRM_BUDDY,
> for example, is not directly selectable in .config, as it's meant to be
> selected automatically if a module uses it.

In general, test code must not select the code to be tested, but depend
on it, to avoid that enabling CONFIG_KUNIT_ALL_TESTS pulls in lots of
unneeded code.

> This is also the case for drivers, with Xe having depends on DRM and
> then like 40 lines of selects for specific functionality, same for i915,
> amdgpu, so on.

For drivers, it is different: if you want the driver, you obviously
need the helper or library code.

> > Make sure the GPU
> > buddy allocator can be tested without enabling another driver that uses
> > DRM_BUDDY by making GPU_BUDDY visible if KUNIT is enabled.
>
> This was the case even without your patch, and was the entire point of
> 8fe3fc37564920ae mentioned in Fixes. The kunit test kernel can be built with

Yes, that was the intent of commit 8fe3fc37564920ae, but it used the
wrong method.

It is customary to make library code that is only selected by its
users, and cannot be enabled explicitly, visible for testing.
See e.g. commit bf2d44d07de726b0 ("ASoC: wm_adsp: Add kunit test for
firmware file search")

> a rather minimal .kunitconfig (included in the gpu/tests directory). So
> it only loads whatever kunit_tool would load, plus CONFIG_KUNIT, plus
> CONFIG_GPU_BUDDY_KUNIT_TEST, plus (implicitly, which I discussed above)
> CONFIG_GPU_BUDDY. It doesn't load DRM_BUDDY at all (which was the bug
> being fixed in that commit, you used to be forced to load it, now you
> aren't)
>
> > The page based buddy allocator for GPU memory is only used by DRM.
> > Hence add a dependency on DRM to GPU_BUDDY, to prevent asking the user
> > about this code when configuring a kernel without DRM support.
>
> It seems to be *technically* true, however, the entire point of moving the
> buddy allocator outside the DRM directory is to expose it to other non-DRM
> drivers, so the lack of dependency is kind of by design.
>
> The change was rather anticipatory, but it was clearly well reviewed and
> sent by a Joel, a nova-core dev, I assume it's gonna be needed at least
> by them at one point or another.
>
> If, say, nova decides to use the "communal" buddy allocator (if it
> doesn't do it already, I only briefly skimmed it looking for kernel::gpu)
> then the DRM dependency from this patch would have to be reverted (yet
> again). Maybe moving the buddy allocator up from DRM should have been done
> along with the first non-DRM user and only then, but it just didn't go that
> way.
>
> If the issue is that this option is too annoying during make or in
> menuconfig, then I don't think this is the way to address it.

Once the symbol is visible, it needs a proper dependency, to avoid
asking the user irrelevant questions.

> > Fixes: 8fe3fc37564920ae ("gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> > --- a/drivers/gpu/Kconfig
> > +++ b/drivers/gpu/Kconfig
> > @@ -1,14 +1,15 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  config GPU_BUDDY
> > -       bool
> > +       bool "Page based buddy allocator for GPU memory" if KUNIT
> > +       depends on DRM || COMPILE_TEST
>
> What's the justification for COMPILE_TEST here? It might be needed but
> you didn't explain why or mention it in the patch description at all.

It is customary to add "|| COMPILE_TEST" when adding dependencies that
are not strictly needed for a successful build.

> >         help
> >           A page based buddy allocator for GPU memory.
> >
> >  config GPU_BUDDY_KUNIT_TEST
> >         tristate "KUnit tests for GPU buddy allocator" if !KUNIT_ALL_TESTS
> >         depends on KUNIT
> > -       select GPU_BUDDY
> > +       depends on GPU_BUDDY
> >         default KUNIT_ALL_TESTS
> >         help
> >           KUnit tests for the GPU buddy allocator.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
