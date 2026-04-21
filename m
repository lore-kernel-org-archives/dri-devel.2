Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B309F327C0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C183110EBC9;
	Tue, 21 Apr 2026 08:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Jw64UppB";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5249C10EBC9
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776759783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Ml3LPEO/Dye9BzRMaAljrqCo7J3LgoTe33jIVDxQlg=;
 b=Jw64UppBFL0ngHyIMmVGctMZX6C/25mQsSBHt9D3/u+75VXdkD6Nwf5M9A/qhbsKFNq/IS
 Dcj8MtW4SK+Mu9GAPDucgYDouUy+LnZ24YXx3B3AZosS5ZqTPJ/toWZgbtjT5g81jSeYxU
 RSdx9AYlU4m911xBLHX+5fdQTYp61tg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-4X8AoK00NqCxPCtMy1llbw-1; Tue, 21 Apr 2026 04:23:02 -0400
X-MC-Unique: 4X8AoK00NqCxPCtMy1llbw-1
X-Mimecast-MFC-AGG-ID: 4X8AoK00NqCxPCtMy1llbw_1776759781
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7a45cf7ff24so64496507b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 01:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776759781; x=1777364581;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Ml3LPEO/Dye9BzRMaAljrqCo7J3LgoTe33jIVDxQlg=;
 b=WCXEkGfv4nyNKzT6CbVikDch2N576z1bDLkfidL7Vk1dKwXpnsf5kJ1qejoePyBzm7
 269BFy0LY5CnskXwOuUEGHDBgkTbn4vvQ5XvgcmpW7IrBdQjJbFh0RjkdQlCyT8kc2s0
 cUdybYfN6FbUO7CyfU1+24LrOO03+7A6sXbcxQe3OfsEas0DDiaAFtKHyr+Tl4JXv2Np
 SYaW0QnD37m3L4AjM0X8zTGSNUnMnBqxmPxVBa0lPfAXgfbaqi9F4AMyimAbyP9Bbxr2
 k+1gMOWN4+vFdf/5CBR4u+XDcfnudkfss+Cfr3OAJDm2pZADKBjSaKG2GokBIWNmQ0e2
 4Z6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2XRjwjRv1WV8kFzAKlB7rbO5HnMmjde7f8g7m3i82bDOyclbIwXW86sHE/G5ZyZu6X2McBBpRNCc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+Oft8noxQs7ebT+5rr6sDFqoFG0fSe5hlt7sBSpMNje4gLNbk
 ksokeMX8yfcjl1XxLxSlu0aza1/d9uyS3Y3NGOQ9NiVovxfi91bX6uQZYtJtrSvXVejnioqb8kO
 b9U1m9/PAV1MqEuCmrIvT63+OQAEp2fBJjFLu/HJzB/ZJ3pWc/zQCFe6AGX5K6rVjxb3ZazA03i
 XE+wa2ETkx2EnYi4usu3cxvWqYKtSlA7BuBpix+k9tYTcv
X-Gm-Gg: AeBDieulKbpggk3gCKRR2BGyaxdGjzbru9jyqSI2FLzEqe/VZRVwPXBXbhK1rjcVeXo
 ggkcD2C9KIQQhEiR2WQJVzDFL2rSR0a34762xgZykkxm8+G4aivWqvAdssDV4Rb4i+Xq3/UMinE
 oyqrtRA4padE2SovqD6CuuuT3VpMkQyjKY2Z3bhJbQaXkNde71/s5/ZYY3jiTEeJO4jp3jE5n0a
 MxWTH3nuSO/jbnt
X-Received: by 2002:a05:690c:8d05:b0:7b6:f4f:f057 with SMTP id
 00721157ae682-7b9ecfb3418mr143346747b3.24.1776759781349; 
 Tue, 21 Apr 2026 01:23:01 -0700 (PDT)
X-Received: by 2002:a05:690c:8d05:b0:7b6:f4f:f057 with SMTP id
 00721157ae682-7b9ecfb3418mr143346527b3.24.1776759780849; Tue, 21 Apr 2026
 01:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-1-e8bc6e0f70de@redhat.com>
 <20260420143951.GJ3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260420143951.GJ3102624@noisy.programming.kicks-ass.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 21 Apr 2026 10:22:49 +0200
X-Gm-Features: AQROBzBvB1NnJ5S-NBz1guESzMJAomEJ6rR9uRkVOxbuOYlvr_y2_fXZX03ERWQ
Message-ID: <CADSE00+RJ--ku_TBC5GkTtF1N_LEB5Poj=KvvvSK=P3uz8dbPA@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] bug/kunit: Core support for suppressing warning
 backtraces
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 Alessandro Carminati <acarmina@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Kees Cook <kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p4q3FHq3AKrZRElGUnXPABF2Izu_SqqmLoGo2iXMFGE_1776759781
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

On Mon, Apr 20, 2026 at 4:40=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Apr 20, 2026 at 02:28:03PM +0200, Albert Esteve wrote:
> > From: Alessandro Carminati <acarmina@redhat.com>
> >
> > Some unit tests intentionally trigger warning backtraces by passing bad
> > parameters to kernel API functions. Such unit tests typically check the
> > return value from such calls, not the existence of the warning backtrac=
e.
> >
> > Such intentionally generated warning backtraces are neither desirable
> > nor useful for a number of reasons:
> > - They can result in overlooked real problems.
> > - A warning that suddenly starts to show up in unit tests needs to be
> >   investigated and has to be marked to be ignored, for example by
> >   adjusting filter scripts. Such filters are ad hoc because there is
> >   no real standard format for warnings. On top of that, such filter
> >   scripts would require constant maintenance.
> >
> > Solve the problem by providing a means to identify and suppress specifi=
c
> > warning backtraces while executing test code. Support suppressing multi=
ple
> > backtraces while at the same time limiting changes to generic code to t=
he
> > absolute minimum.
> >
> > Implementation details:
> > Suppression is checked at two points in the warning path:
> > - In warn_slowpath_fmt(), the check runs before any output, fully
> >   suppressing both message and backtrace.
> > - In __report_bug(), the check runs before __warn() is called,
> >   suppressing the backtrace and stack dump. Note that on this path,
> >   the WARN() format message may still appear in the kernel log since
> >   __warn_printk() runs before the trap that enters __report_bug().
>
> This is for architectures that implement __WARN_FLAGS but not
> __WARN_printf right? (which is arm64, loongarch, parisc, powerpc, riscv,
> sh, afaict). ARM64 should eventually get __WARN_printf, but other than
> that this should be fixable by moving __WARN_FLAGS() into
> __warn_printk() or so. This is the only __warn_printk() user anyway.

Right. On that path, __warn_printk() prints the message before
__WARN_FLAGS() triggers the trap into __report_bug(), so the
suppression check in __report_bug() only catches the backtrace.

Adding the suppression check to __warn_printk() as well should close
this gap, since it's the only caller in the generic __WARN_printf
path. Something like:

```
diff --git a/kernel/panic.c b/kernel/panic.c
index d7a7a679f56c4..cd73038b7c0bd 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -1108,9 +1108,14 @@ EXPORT_SYMBOL(warn_slowpath_fmt);
#else
void __warn_printk(const char *fmt, ...)
{
- bool rcu =3D warn_rcu_enter();
+ bool rcu;
va_list args;
+ if (__kunit_is_suppressed_warning())
+ return;
+
+ rcu =3D warn_rcu_enter();
+
pr_warn(CUT_HERE);
va_start(args, fmt);
```
Note that the suppression counter tracking may need a small adjustment
to avoid double-counting, since __report_bug() will still see the same
warning through the trap path, but the approach itself should be
straightforward.

>
>
> > diff --git a/include/kunit/bug.h b/include/kunit/bug.h
> > new file mode 100644
> > index 0000000000000..e52c9d21d9fe6
> > --- /dev/null
> > +++ b/include/kunit/bug.h
> > @@ -0,0 +1,56 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * KUnit helpers for backtrace suppression
> > + *
> > + * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
> > + * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
> > + */
> > +
> > +#ifndef _KUNIT_BUG_H
> > +#define _KUNIT_BUG_H
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +#include <linux/kconfig.h>
> > +
> > +struct kunit;
> > +
> > +#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> > +
> > +#include <linux/types.h>
> > +
> > +struct task_struct;
> > +
> > +struct __suppressed_warning {
> > +     struct list_head node;
> > +     struct task_struct *task;
> > +     int counter;
> > +};
> > +
> > +struct __suppressed_warning *
> > +__kunit_start_suppress_warning(struct kunit *test);
> > +void __kunit_end_suppress_warning(struct kunit *test,
> > +                               struct __suppressed_warning *warning);
> > +int __kunit_suppressed_warning_count(struct __suppressed_warning *warn=
ing);
> > +bool __kunit_is_suppressed_warning(void);
> > +
> > +#define KUNIT_START_SUPPRESSED_WARNING(test) \
> > +     struct __suppressed_warning *__kunit_suppress =3D \
> > +             __kunit_start_suppress_warning(test)
> > +
> > +#define KUNIT_END_SUPPRESSED_WARNING(test) \
> > +     __kunit_end_suppress_warning(test, __kunit_suppress)
>
> We have __cleanup for this?

I was unfamiliar with this attribute. I have looked into it a bit, and
it could be a good fit. I saw a good example in seqlock. I could try
to use it for the next version.

>
> > +
> > +#define KUNIT_SUPPRESSED_WARNING_COUNT() \
> > +     __kunit_suppressed_warning_count(__kunit_suppress)
> > +
> > +#else /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> > +
> > +#define KUNIT_START_SUPPRESSED_WARNING(test)
> > +#define KUNIT_END_SUPPRESSED_WARNING(test)
> > +#define KUNIT_SUPPRESSED_WARNING_COUNT() 0
> > +static inline bool __kunit_is_suppressed_warning(void) { return false;=
 }
> > +
> > +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> > +#endif /* __ASSEMBLY__ */
> > +#endif /* _KUNIT_BUG_H */
>
> > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > index 656f1fa35abcc..fe177ff3ebdef 100644
> > --- a/lib/kunit/Makefile
> > +++ b/lib/kunit/Makefile
> > @@ -16,8 +16,10 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
> >  kunit-objs +=3D                                debugfs.o
> >  endif
> >
> > -# KUnit 'hooks' are built-in even when KUnit is built as a module.
> > -obj-$(if $(CONFIG_KUNIT),y) +=3D               hooks.o
> > +# KUnit 'hooks' and bug handling are built-in even when KUnit is built
> > +# as a module.
> > +obj-$(if $(CONFIG_KUNIT),y) +=3D               hooks.o \
> > +                                     bug.o
> >
> >  obj-$(CONFIG_KUNIT_TEST) +=3D          kunit-test.o
> >  obj-$(CONFIG_KUNIT_TEST) +=3D          platform-test.o
> > diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
> > new file mode 100644
> > index 0000000000000..356c8a5928828
> > --- /dev/null
> > +++ b/lib/kunit/bug.c
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit helpers for backtrace suppression
> > + *
> > + * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
> > + * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
> > + */
> > +
> > +#include <kunit/bug.h>
> > +#include <kunit/resource.h>
> > +#include <linux/export.h>
> > +#include <linux/rculist.h>
> > +#include <linux/sched.h>
> > +
> > +#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> > +
> > +static LIST_HEAD(suppressed_warnings);
> > +
> > +static void __kunit_suppress_warning_remove(struct __suppressed_warnin=
g *warning)
> > +{
> > +     list_del_rcu(&warning->node);
> > +     synchronize_rcu(); /* Wait for readers to finish */
> > +}
> > +
> > +KUNIT_DEFINE_ACTION_WRAPPER(__kunit_suppress_warning_cleanup,
> > +                         __kunit_suppress_warning_remove,
> > +                         struct __suppressed_warning *);
> > +
> > +struct __suppressed_warning *
> > +__kunit_start_suppress_warning(struct kunit *test)
> > +{
> > +     struct __suppressed_warning *warning;
> > +     int ret;
> > +
> > +     warning =3D kunit_kzalloc(test, sizeof(*warning), GFP_KERNEL);
> > +     if (!warning)
> > +             return NULL;
> > +
> > +     warning->task =3D current;
> > +     list_add_rcu(&warning->node, &suppressed_warnings);
>
> What if anything serializes this global list?

I considered adding a spinlock, but since the KUnit executor runs
tests sequentially and it had not been a concern in previous versions,
I left it out to keep the changeset minimal unless someone complains.
If we want a hard guarantee, I'm happy to add the spinlock for the
next version.

>
> > +
> > +     ret =3D kunit_add_action_or_reset(test,
> > +                                     __kunit_suppress_warning_cleanup,
> > +                                     warning);
> > +     if (ret)
> > +             return NULL;
> > +
> > +     return warning;
> > +}
> > +EXPORT_SYMBOL_GPL(__kunit_start_suppress_warning);
> > +
> > +void __kunit_end_suppress_warning(struct kunit *test,
> > +                               struct __suppressed_warning *warning)
> > +{
> > +     if (!warning)
> > +             return;
> > +     kunit_release_action(test, __kunit_suppress_warning_cleanup, warn=
ing);
> > +}
> > +EXPORT_SYMBOL_GPL(__kunit_end_suppress_warning);
> > +
> > +int __kunit_suppressed_warning_count(struct __suppressed_warning *warn=
ing)
> > +{
> > +     return warning ? warning->counter : 0;
> > +}
> > +EXPORT_SYMBOL_GPL(__kunit_suppressed_warning_count);
> > +
> > +bool __kunit_is_suppressed_warning(void)
> > +{
> > +     struct __suppressed_warning *warning;
> > +
> > +     rcu_read_lock();
> > +     list_for_each_entry_rcu(warning, &suppressed_warnings, node) {
> > +             if (warning->task =3D=3D current) {
> > +                     warning->counter++;
> > +                     rcu_read_unlock();
> > +                     return true;
> > +             }
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     return false;
> > +}
> > +
> > +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> >
> > --
> > 2.52.0
> >
>

