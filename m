Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AB4C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240D210EEDA;
	Thu, 27 Aug 2026 07:44:53 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E5210EEDA
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:44:51 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-96723c7151eso695468241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 00:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816690; x=1788421490;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TAq2mnIxXFzO957tO9XR1Q6W7W89hYvIMjgxkFCKtOc=;
 b=cpPQUSx2rbUVkK51XbpL5MC6mkrYAaMI9iRbsxzzgHxuuaRNwODM1QtsVG/K8wzYGu
 d0c8sE+MkWEspks+O5+lB8/KmCW1RshWJbWBlw8CmSw6R2Ttc5Siq9jMU3Ti0zSNtLmV
 q2ZzhAdtIeNuSf9bPxudtEmOvCpOhO3VEGNFJuSkBe0GAOU5VGa6ShD3iedyUrpStyET
 5s60rzyMMcILJgLorR48QO/Y0AXGsdhxF/gteojzTq3IYRcaSCWKD+MioaIA+8AwDXEH
 ZWHLq3ZZfUc7kt1W9YDA2ySbw4IYUnbFQa2QNXmLAHHyd6HaXsfV5H+q1FT2NEoKk0wV
 kTag==
X-Forwarded-Encrypted: i=1;
 AHgh+RrsVNPIaU1MW4KUlcK7KWwPk+ZzuDeLjYnc2Bk2QGOruMbikCaQM3RHMmO9lMqw8TpIneYCWqibQd4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l6Cd0cLoZXrI3F4ha7BrNQI7t4K1q0hi0WyyX0W0HkBISlADiB
 WVxtrNqNg1ls6sV5iGQnMf++f0pyJ6ob3SYnrma4sHyFCTAmg3TG1Wti5LWKGvjC
X-Gm-Gg: AR+sD11fgsSQzESP/s7GbvSg2Xo4I3THheYKhAgUhtp4e7iyuAS9HcH2qwhLG6DoxwC
 xpF776cL0KatVgjV+wXweBCgCtWHZTJf2L9YkSU7AhNQZjMkQ615HGnG+KFsqzRT1NZ7TsMEteV
 uHIzHEoHWZJGZNX/RoGArYGTdjo0PMsrDH/NhfSH3ziLqKMfL6uVpi+tR7EhYpoQOi+IQdl/YNF
 zCAfgBkukJ7q+cD5V6MjVUoxDOqXwRLHta2TI90x7wjpS1BCDCRyYmzevAPNq/QlvUuw0dcQZ3m
 R7q4wc4+uYwVDvLSyZIuBOBvspR7Nxb22WtK+qVeKuPeZTcgSc2x9N07LD+lisBjibUPXBTzp4/
 NuKR42sZs2HJvAcNDgP1RshGh1IIm0NTDuI4i4TbH29bHLZIzuGSOrkSKvQ0GY1VPdk/AR9Enf1
 q1DNWHMrpUJXdur/Det7d5NdP5FU7GYZO5hkMSqoSbxQy/TpgE0xcrhTdNpLhxygBM384MnmWn0
 mkJOoJLVNitZlPNUwi49kLFOQ==
X-Received: by 2002:a05:6102:5492:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-782bc93e551mr3743270137.0.1787816690416; 
 Thu, 27 Aug 2026 00:44:50 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com.
 [209.85.217.54]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97ccbc9bb64sm2248086241.6.2026.08.27.00.44.50
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 00:44:50 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-75e2905c09aso401199137.2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 00:44:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Ro71mSHqosR7Dpx82C+xmu1SD4ZRGtGqTkLpR721EAqcvV+W076hNBlIlh+7Y2VJprcaJKRTWyGiY0=@lists.freedesktop.org
X-Received: by 2002:a05:6102:50a9:b0:778:9e3c:5760 with SMTP id
 ada2fe7eead31-782c1a00971mr4010623137.11.1787816690046; Thu, 27 Aug 2026
 00:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <1e519fb24aa5521788d69cc7980665ccbc227b14.1787584184.git.geert@linux-m68k.org>
 <ao1hIejAdBPKUHFW@kniemiec-mobl1>
 <CAMuHMdWuG_s3Rm-gLc2KNw9Z0bptQjdDDGH+9YawEMEsFZZ6Nw@mail.gmail.com>
 <ao8Fc8DWbsxMtSRu@kniemiec-mobl1>
In-Reply-To: <ao8Fc8DWbsxMtSRu@kniemiec-mobl1>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2026 09:44:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCF0=P4XGYuM1c1+KZckJYw9KuaoUZOF8-EOOqtqsWyQ@mail.gmail.com>
X-Gm-Features: AcwNN1XzEY3I1YHBaPGvpKk8MVWoRxkSmhwGS1lNUFejWW4kN8mjsnYoKG8va7I
Message-ID: <CAMuHMdWCF0=P4XGYuM1c1+KZckJYw9KuaoUZOF8-EOOqtqsWyQ@mail.gmail.com>
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

On Wed, 26 Aug 2026 at 18:39, Krzysztof Niemiec
<krzysztof.niemiec@intel.com> wrote:
> I got unnecessarily annoyed/angry in my previous reply, I'm sorry for that.
> It clouded my judgement a bit then but I still have some comments now
>
> On 2026-08-25 at 14:15:34 +0200, Geert Uytterhoeven wrote:
> > On Tue, 25 Aug 2026 at 13:39, Krzysztof Niemiec
> > <krzysztof.niemiec@intel.com> wrote:
> > > On 2026-08-24 at 17:12:30 +0200, Geert Uytterhoeven wrote:
> > > > Enabling a (modular) test should not silently enable additional kernel
> > > > functionality, as that may increase the attack vector for a product.
> > >
> > > What vector? What product, exactly? As far as I know buddy allocator code is
> >
> > Any product that uses DRM and has CONFIG_KUNIT_ALL_TESTS=m, so
> > developers can easily run any relevant test when the need arises.
> >
> > > currently loaded when a) loading a drm driver (which would need that code
> >
> > Not just "a drm driver": very few DRM drivers use it.
> > Hence one can have a product with DRM that does not need the buddy
> > allocator.
>
> And the buddy allocator was moved out of DRM in anticipation of a
> possible non-DRM driver that wants the buddy allocator. So there's no
> implication between DRM and buddy in either way anymore.
>
> Currently it's only DRM drivers that actually use it, but there's already
> scaffolding in rust for it that does not depend on DRM, and once
> there's a non-DRM driver that wants to use the allocator it would have
> to undo the dependency added in this patch anyway.

Then the dependency can be lifted.  There are hundreds (thousands?)
of Kconfig symbols that will need to get heir dependencies updated
one day.
However, missing dependencies means more questions for all users
configuring kernels.

> > > > --- a/drivers/gpu/Kconfig
> > > > +++ b/drivers/gpu/Kconfig
> > > > @@ -1,14 +1,15 @@
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >
> > > >  config GPU_BUDDY
> > > > -       bool
> > > > +       bool "Page based buddy allocator for GPU memory" if KUNIT
> > > > +       depends on DRM || COMPILE_TEST
> > >
> > > What's the justification for COMPILE_TEST here? It might be needed but
> > > you didn't explain why or mention it in the patch description at all.
> >
> > It is customary to add "|| COMPILE_TEST" when adding dependencies that
> > are not strictly needed for a successful build.
>
> I can't tell if this is something so obvious it needs no comment; I feel
> like it should be documented explicitly in the commit log.
>
> If the DRM dependency would be dropped would the COMPILE_TEST have to
> stay? Because then we're forcing a non-drm user to enable it if they want
> to use the buddy alloc at all.

If the DRM dependency would be dropped, the COMPILE_TEST can be
dropped too.
If a (not always enabled) non-drm user appears, it can be added to the
dependency list.

> I think just leaving the "if KUNIT" part would check all the boxes,
> since the tests are actually runnable with KUnit via .kunitconfig
> without building an entire DRM driver, GPU_BUDDY also won't be randomly
> enabled with KUNIT_ALL_TESTS on systems that don't care about it, and
> we're not forcing anyone to enable DRM on a feature that was explictly
> made independent from it.

There are systems that do not use DRM, but still want tests enabled.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
