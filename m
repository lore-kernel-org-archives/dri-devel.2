Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72915FB44C4
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D52D10F3D2;
	Fri, 24 Apr 2026 08:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="F+QfYMoZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA7C10E15C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777019148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iddsQLueoQEOIJwe4Gfj6if9K+aRVWtEbx6BS4m334s=;
 b=F+QfYMoZTU7XcBwnUkuHimuQSmNk1cmsOvh+MiKcv3t0KpN0UAMF65B1qSun+ok+gF7PTF
 0bVDrcfMbVtz8sDVd72ySJKn0a+xfCmQzLOT2wNHZMugfINuNX4FuSfUHOnRE10PzSJ6Lj
 1a42bfHE9mZWpY3m1dv8Y5ZM0hohUW8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-MeSPUAe9M9Go25ydFfktpA-1; Fri, 24 Apr 2026 04:25:47 -0400
X-MC-Unique: MeSPUAe9M9Go25ydFfktpA-1
X-Mimecast-MFC-AGG-ID: MeSPUAe9M9Go25ydFfktpA_1777019147
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79064868702so171539047b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 01:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777019147; x=1777623947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iddsQLueoQEOIJwe4Gfj6if9K+aRVWtEbx6BS4m334s=;
 b=cZocEv+EYkMf2vMDRpR9gA7Tca5SCdWy7wp3wQhSm9uEBH5YTHFcVrsx4jC3EGCD+o
 +OhhwfIxVz5GYECPma0b6aJUvQCIKll3/fa+ipshORXbuivzUbknyIIDUXD5cwGl+GTo
 w+VsHmH/GZcuB2lsoszIoA6Uav5LpY/JZY43P+pqE45GgC6YFhZewHEYyQ3W/p7bKeAC
 0amikCq9/68H+8L+R5MdM8nvPqrHQFYcNuQieOPSyc6+zNggegi3cg/GhgQOB+eRXgAq
 Bk1hYx4SdJWbgSSQCMTzuGOtPpaudlYLixtcwmVKW+R8srZWnso0hdZQbtHeR+VfXxAN
 oeow==
X-Forwarded-Encrypted: i=1;
 AFNElJ++x25Cqpe1UFnQM3YXRlqOsy+GwZxSuSEKAALNNUEhiYSq/hNpslpvlbQdmGMSFaMjWinQyeUWs44=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSBKzRjK6EFEeMrLVnOL17KpEwGL/uj1bOMdNF5yDYp6SpM/9C
 Jzfz8pM1l31og6F8UHHN5GVLBAGhOi94s04ydeHP0i/BESaryn5I3i1H1A6s/g7dt7R3IrnHim9
 N1TInpRpwXREHxJNONj202NgdBsVtPKr7MeH1gMIzqPG7ugsixDROVIVCue1esFs8MrcW06wTMm
 3dqs25INS3pLBhi7CDRjv+bPo95zB8tyF7L8l7pRzM76ED
X-Gm-Gg: AeBDietza7nwArUujbN4R0uoAnXgJeqMFKaOcJ+QlAYr4IQ7mKu23Az6X+lx9sVaXSL
 0jgAehKy4LTekZV/HmdaX5uNBreSGelONXWf2DFMyXct1WMz3xdXMkVtGGGzQJBZzAy6SwrZg1Z
 vwo8my4Xg2dKbMJvddBJrAIAMpEz23xx3fj4m7M7S8BbP3MsfzHSzuBT9AADiMO3HL3/wrU4YCA
 Gi2A5o/beExSTlX
X-Received: by 2002:a05:690c:9:b0:7bb:712:a74f with SMTP id
 00721157ae682-7bb0712abfdmr142445527b3.17.1777019147053; 
 Fri, 24 Apr 2026 01:25:47 -0700 (PDT)
X-Received: by 2002:a05:690c:9:b0:7bb:712:a74f with SMTP id
 00721157ae682-7bb0712abfdmr142445227b3.17.1777019146632; Fri, 24 Apr 2026
 01:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-3-e8bc6e0f70de@redhat.com>
 <6209f24e-750d-4a7d-ad63-1695f5fd1caa@davidgow.net>
In-Reply-To: <6209f24e-750d-4a7d-ad63-1695f5fd1caa@davidgow.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 24 Apr 2026 10:25:35 +0200
X-Gm-Features: AQROBzC8_2POWCOFYR1L1LoP_YwcAOa38lshWUv2qs6X6k9mWiut3V_iTEcCLAA
Message-ID: <CADSE00+Ch2QtfsjOcKRNXY9Au8sv5E7Jdd8Rhb2dA6ODu+EDOw@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] kunit: Add backtrace suppression self-tests
To: David Gow <david@davidgow.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, peterz@infradead.org, 
 Guenter Roeck <linux@roeck-us.net>,
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alessandro Carminati <acarmina@redhat.com>, Kees Cook <kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fQIzzIFeVVfYanBUdmRVFh-x4iSfdWgWFVCu91NsHWg_1777019147
X-Mimecast-Originator: redhat.com
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

On Wed, Apr 22, 2026 at 2:22=E2=80=AFPM David Gow <david@davidgow.net> wrot=
e:
>
> Le 20/04/2026 =C3=A0 8:28 PM, Albert Esteve a =C3=A9crit :
> > From: Guenter Roeck <linux@roeck-us.net>
> >
> > Add unit tests to verify that warning backtrace suppression works,
> > covering WARN() and WARN_ON() with direct calls, indirect calls
> > through helper functions, and multiple warnings in a single window.
> >
> > If backtrace suppression does _not_ work, the unit tests will likely
> > trigger unsuppressed backtraces, which should actually help to get
> > the affected architectures / platforms fixed.
> >
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
>
> Thanks very much for including tests!
>
> Maybe it'd be nice to test that the suppression is disabled after
> KUNIT_END_SUPPRESSED_WARNING(). Of course, then triggering an actual
> stacktrace would be a pain, but maybe we could check that
> __kunit_is_suppressed_warning() returns false? If you wanted to be
> really fancy, you could test that it returns false on another kthread
> even while the suppression is active, too, but I won't hold you to it.
> Equally, you could try setting up a fake test context and ensuring the
> cleanup is called correctly, but I think that's mostly covered by the
> existing KUnit resource tests.

 Good suggestions. I'll add a test for __kunit_is_suppressed_warning()
returning false after END. The cross-kthread test is a nice idea too.
I'll see if I can fit it in without overcomplicating things.

>
> Otherwise, looking good. A couple of other minor suggestions below,
> which may require some reworking of the __kunit_suppress scope, but all
> optional suggestions.
>
> Reviewed-by: David Gow <david@davidgow.net>

Thanks for the review!

>
> >   lib/kunit/Makefile                     |  3 ++
> >   lib/kunit/backtrace-suppression-test.c | 90 +++++++++++++++++++++++++=
+++++++++
> >   2 files changed, 93 insertions(+)
> >
> > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > index fe177ff3ebdef..b2f2b8ada7b71 100644
> > --- a/lib/kunit/Makefile
> > +++ b/lib/kunit/Makefile
> > @@ -23,6 +23,9 @@ obj-$(if $(CONFIG_KUNIT),y) +=3D              hooks.o=
 \
> >
> >   obj-$(CONFIG_KUNIT_TEST) +=3D         kunit-test.o
> >   obj-$(CONFIG_KUNIT_TEST) +=3D         platform-test.o
> > +ifeq ($(CONFIG_KUNIT_SUPPRESS_BACKTRACE),y)
> > +obj-$(CONFIG_KUNIT_TEST) +=3D          backtrace-suppression-test.o
> > +endif
> >
> >   # string-stream-test compiles built-in only.
> >   ifeq ($(CONFIG_KUNIT_TEST),y)
> > diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtra=
ce-suppression-test.c
> > new file mode 100644
> > index 0000000000000..2ba5dcb5fef35
> > --- /dev/null
> > +++ b/lib/kunit/backtrace-suppression-test.c
> > @@ -0,0 +1,90 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test for suppressing warning tracebacks.
> > + *
> > + * Copyright (C) 2024, Guenter Roeck
> > + * Author: Guenter Roeck <linux@roeck-us.net>
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/bug.h>
> > +
> > +static void backtrace_suppression_test_warn_direct(struct kunit *test)
> > +{
> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> > +     WARN(1, "This backtrace should be suppressed");
> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> > +
> > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> > +}
> > +
> > +static void trigger_backtrace_warn(void)
> > +{
> > +     WARN(1, "This backtrace should be suppressed");
> > +}
> > +
> > +static void backtrace_suppression_test_warn_indirect(struct kunit *tes=
t)
> > +{
> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> > +     trigger_backtrace_warn();
> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> > +
> > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> > +}
> > +
> > +static void backtrace_suppression_test_warn_multi(struct kunit *test)
> > +{
> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> > +     WARN(1, "This backtrace should be suppressed");
> > +     trigger_backtrace_warn();
> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> > +
> > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 2);
>
> Would it make sense to test KUNIT_SUPPRESSED_WARNING_COUNT() more
> thoroughly here by checking that it's 0 before any warnings, and
> checking that it's 1 in-between the two warnings?
>
> Of course, the first case doesn't work due to __kunit_suppress not being
> defined, but if the implementation changes to support this, let's add it
> to the test, too.

I thought this was a test gap when you commented the limitation in
patch #1, so I agree to add more granular COUNT checks once the API
supports it (which it should after the rework to expose the pointer).
Thanks!

>
> > +}
> > +
> > +static void backtrace_suppression_test_warn_on_direct(struct kunit *te=
st)
> > +{
> > +     if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE) && !IS_ENABLED(CONFIG_KA=
LLSYMS))
> > +             kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE or CON=
FIG_KALLSYMS");
> > +
> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> > +     WARN_ON(1);
> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> > +
> > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> > +}
> > +
> > +static void trigger_backtrace_warn_on(void)
> > +{
> > +     WARN_ON(1);
> > +}
> > +
> > +static void backtrace_suppression_test_warn_on_indirect(struct kunit *=
test)
> > +{
> > +     if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE))
> > +             kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE");
> > +
> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> > +     trigger_backtrace_warn_on();
> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> > +
> > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> > +}
> > +
> > +static struct kunit_case backtrace_suppression_test_cases[] =3D {
> > +     KUNIT_CASE(backtrace_suppression_test_warn_direct),
> > +     KUNIT_CASE(backtrace_suppression_test_warn_indirect),
> > +     KUNIT_CASE(backtrace_suppression_test_warn_multi),
> > +     KUNIT_CASE(backtrace_suppression_test_warn_on_direct),
> > +     KUNIT_CASE(backtrace_suppression_test_warn_on_indirect),
> > +     {}
> > +};
> > +
> > +static struct kunit_suite backtrace_suppression_test_suite =3D {
> > +     .name =3D "backtrace-suppression-test",
> > +     .test_cases =3D backtrace_suppression_test_cases,
> > +};
> > +kunit_test_suites(&backtrace_suppression_test_suite);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("KUnit test to verify warning backtrace suppression=
");
> >
>

