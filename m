Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D1606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kgqJIyxG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0E810E167;
	Mon, 26 Oct 2026 22:48:46 +0000 (UTC)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7001310E167
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 22:48:40 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-6798eb0d13fso3730504d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793054919; cv=none;
 d=google.com; s=arc-20260327;
 b=Rx78zMtcm9jDKvHT5gTMtK+ScMfHtm3BGv+rV1M742bhm6J8l4kEO4yQxRghQp4Kem
 LNsCR6ssLbmKsMI6Cb7h2XRNMKdS2GvJ3T2+D2DVohMHofffTXhZy9P5oouE55veWYS7
 8NJ2RwEjqtcZNdZZQXd4Aq59Vz38tXQp72No2WFhTt/l9Iit8E6ZSptpK0vIZ6AyRCJc
 CD5ovXzSvNX5WWwr0obcaCf9WiH1jZnSqEo0yVGYCmPf0AK4J89MTGTZSGhwWRgjucQy
 ZJpDImRwyY7EP9tDe5Wbfinya0wD3WiYeXxIKQf9sCubsYhcTaQBE3Rkj0zBXR9VeUh8
 kq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mshdBP7zWJ8tsttLUx6xhnibBdLHVDUK/dBlFucrT6E=;
 fh=NmgDfYKfhh7I9ULjkw2/H3wecvlpkuh0PUPPUt/A+U0=;
 b=EM8nXqwylwUOs5ooCH1JInM0Z+5tjlXVHYvp58UWH+Zt7Qf3j+Q/uXIj2MG3jTXLJo
 eo7FTMUc3EpeNTU6d9uVkHdafchHX94m5IVsFeukzP5RVFRX7tfDVpqVVEvY0BSMGF2W
 uZV3rHxUNYNJi+LVrDd4oL9jLi5o4Yy8RkZ+JsJEdfh1bH34pcE6cKSYJkujRHxDdYzu
 7jqMRuKtHE0lmh63r5+9Q7kfYrvruUHduV6UQVhPZs/7BtJRTUS4yIjMy0rCx79qVG0L
 rxBddEiiudaYG/XjEYaNHBuv6ajQ9kQL+Xxmnxvs2J8zHZyzXL9ysFoXbRV/n5KqF/dC
 HeeQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793054919; x=1793659719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mshdBP7zWJ8tsttLUx6xhnibBdLHVDUK/dBlFucrT6E=;
 b=kgqJIyxGxt1Usi7dtZA+n11FdtSXfpGTww+QBGOn5xd6d9XwLFxxnJI4CqE7YEy6ZD
 OXLKslfDs701TH1S8fSntmgSXgHZ1XQjWRemuNQL6mt7+qmgkCrBIRij7dqhKcelVKP2
 wetYX/B1s9Bioa1fpKuDzbMgx+7wHVHHTTuI1S8p+FSYSLmumcJMu8H21lZz5aWtyY2G
 YCXbGqt8tpDCiP7dswmLw5HASryILydtfvO/dWynrVrt3m9UIfH5C1PIM/DoIlfgGz41
 K+aPWs2NQ3I9RHjC9JNjWkIeh4MWTzyJV2yoQVPA/rCYNrwJWGDKRe4MasW49T9YvBAD
 1Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793054919; x=1793659719;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mshdBP7zWJ8tsttLUx6xhnibBdLHVDUK/dBlFucrT6E=;
 b=JUwADmE6P9+PLIagvFaqtT7n6a1zxSdwkmCahuCFTun3sqgtUSQfpjwXg12XksENd6
 eidjNBuqZNyg3SqeN0pSlggTF+dDyk0yDxYrNNwIe1BHuYyE11Z4smgbMeENqgNIK6k0
 WpXQvqwrL+BBhD3l3VC3MG0pO9StPEv78tXlYcr2JDE3DJDnfObGm8AJmhh50xv/bKwp
 dRELcjW4SaBRFEaAsNbeU7Vvm4R7dBkN4KWzxuysuT5WYzwKHJYeSI1vrApnqfhKvavF
 Y+ULJOl5xAo9Qr/hNPquvZY/lM98UsKlH1th5wyduCiRJhuplFBKRBzu8mfYzh2NUdOd
 2hfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0VuNQNkiiv5XWFoL4pCp8gP6TjvLtGJ9y8TM603T9amr9CL+TDJoK0Ty7XM9tMnVzXcpYN94a9bc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJcLFj8q2GzRE6QzOU3XTFPY5o/Z56tkpWIxWLQcdN6asYaVKA4
 nA4emyxFyFaDJcGLOYNjif+sYwID5r9In2rGaMys5a07KsqOn5zQEGfUJ3Y1mSHQmaj3i3qs23B
 MPs5laDtFWtfobChsH5+NQs8f8n3A588=
X-Gm-Gg: AYBFou1HuSx3ZdPcyoG+gGTo2CwO/j3JrCCDrMw6WvnYRysBxtUokDwr93uub3CDCvI
 rGfqWFkSYm4I1vHUYSq+zMl/Qsia1glXEI8v7Tj+Tct9/qQAvEobBxf6FZF7vZtymF4AfuAcOmW
 LoG7BP7NDiY0ig+DcanxFUYkIl+mvsvVGFhRkOtNNSGkOZMGFkjovkzsZ8Z1vx0c0hpaZoey3P1
 bLwc763gRhej5yQZIuzFVVGn7PIztosk7ubjKUHFmjsILzebG5nF2AEyv995KiJi6sXDejQMyly
 Z5jswy0QHr3Ojy1C7CiTpDR5FzONVxxo/DqkEcpbu5C/dW+pXMUVbnTI8dxa6BYyX7yW1t/B9t4
 4X7f9WGTlqQ4/1BtwEqmh+bNFNCZxexXha8Hluz2D60KrdaePv3dWgch7Xt2EIW9zefGotMrcyu
 0dWwblQ8w68jwgTC8=
X-Received: by 2002:a53:ad85:0:b0:672:ef39:5fc6 with SMTP id
 956f58d0204a3-67a454900ffmr2904378d50.147.1793054919173; Mon, 26 Oct 2026
 15:48:39 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-26-3c8cc5725def@gmail.com>
 <sashiko-outbox-170725@kernel.org>
In-Reply-To: <sashiko-outbox-170725@kernel.org>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 16:48:13 -0600
X-Gm-Features: AclHuK_U9GeBl7u0-5vmIpwTNJsdz2Sn-v3e-HGd_0bRIhFESQNIVxLVo-t00Ow
Message-ID: <CAJfuBxxZ=znaXKhz6w3tT-qq-AKPQHWwzWr53w98k2wDAh3Ytw@mail.gmail.com>
Subject: Re: [PATCH v12 26/40] dyndbg-test: add do_bulk testpoint, rename
 do_prints to do_classes
To: sashiko-reviews@lists.linux.dev
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, 
 linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 8:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Low] test_dynamic_debug: classmap offset mismatch for submodule classe=
s
> - [Low] locking: param_set_do_repeats blocks param_lock for up to 60s
> --
>
> commit adf504f365302c7db4e37850cebef69f82ed353f
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg-test: add do_bulk testpoint, rename do_prints to do_classes
>
> This patch renames do_prints to do_classes to better align with its purpo=
se
> and introduces do_bulk to generate high-volume workloads. It adds support=
 for
> executing these debug operations multiple times or over a timed duration =
using
> shared module parameter callbacks.
>
> > diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> > index 01ce07001d4c7..19e27b5747ac2 100644
> > --- a/lib/test_dynamic_debug.c
> > +++ b/lib/test_dynamic_debug.c
>
> [ ... ]
>
> > @@ -28,25 +28,57 @@
> >  #endif
> >
> >  #include <linux/module.h>
> > +#include <linux/sched.h>
> > +#include <linux/sched/signal.h>
> > +#include <linux/jiffies.h>
> >
> > -/* re-gen output by reading or writing sysfs node: do_prints */
> > +#define TEST_MAX_REPEATS 10000
> > +#define TEST_MAX_SECONDS 60
> >
> > -static void do_prints(void); /* device under test */
> > -static int param_set_do_prints(const char *instr, const struct kernel_=
param *kp)
> > +/* re-trigger debug output by reading or writing sysfs nodes: do_class=
es or do_bulk */
> > +static void do_classes(int); /* device under test */
> > +static void do_bulk(int);    /* device under test */
> > +
> > +static int param_set_do_repeats(const char *instr, const struct kernel=
_param *kp)
> >  {
> > -     do_prints();
> > +     int rc, ct;
> > +     void (*repeat_fn)(int) =3D kp->arg;
> > +
> > +     rc =3D kstrtoint(instr, 0, &ct);
> > +     if (rc) {
> > +             pr_err("expecting numeric input, using 1 instead\n");
> > +             ct =3D 1;
> > +     }
> > +     if (ct > TEST_MAX_REPEATS) {
> > +             pr_warn("%s: clamping %d to %d\n", kp->name, ct, TEST_MAX=
_REPEATS);
> > +             ct =3D TEST_MAX_REPEATS;
> > +     } else if (ct < -TEST_MAX_SECONDS) {
> > +             pr_warn("%s: clamping %d seconds to -%d\n",
> > +                     kp->name, ct, TEST_MAX_SECONDS);
> > +             ct =3D -TEST_MAX_SECONDS;
> > +     }
> > +
> > +     repeat_fn(ct);
>
> [Severity: Low]
> Does this synchronous loop execution block param_lock system-wide?
>
> When test_dynamic_debug is built-in, writing to its module parameters via
> sysfs triggers param_attr_store() in kernel/params.c, which acquires the
> global param_lock mutex around the .set callback:
>
> kernel/params.c:param_attr_store() {
>     ...
>     kernel_param_lock(mk->mod);
>     if (param_check_unsafe(attribute->param))
>         err =3D attribute->param->ops->set(buf, attribute->param);
>     ...
> }
>
> Because param_set_do_repeats() invokes the workload synchronously (which
> can run for up to 60 seconds as shown in do_classes() below), this starve=
s
> param_lock, preventing other processes from reading or writing any
> built-in module parameters for the duration.


    In standard usage, test_dynamic_debug is built as a module
(CONFIG_TEST_DYNAMIC_DEBUG=3Dm).
    Under kernel/params.c:KPARAM_MUTEX(mod), modular parameters
acquire the module's
    private &(mod)->param_lock rather than the global param_lock. The
lock-hold is
    strictly local to test_dynamic_debug's own sysfs nodes and has
zero impact on
    core kernel or other module parameters.

    Even in the hypothetical built-in case
(CONFIG_TEST_DYNAMIC_DEBUG=3Dy in a test
    kernel, which I would consider mis-configured),
    test_dynamic_debug is exclusively a test harness whose workloads are
    triggered on demand by explicit sysfs writes. The loops call
cond_resched() and
    check signal_pending(current) on every iteration, keeping the execution
    cooperative and immediately abortable via SIGINT.




>
> > +
> >       return 0;
> >  }
>
> [ ... ]
>
> > @@ -103,7 +135,10 @@ enum cat_disjoint_bits {
> >       D2_DRMRES };
> >
> >  /* numeric verbosity, V2 > V1 related.  V1 is > D2_DRMRES */
> > -enum cat_level_num { V1 =3D 16, V2, V3, V4, V5, V6, V7 };
> > +enum cat_level_num { V1 =3D 16, V2, V3, V4, V5, V6, V7, V8 };
> > +
> > +/* test _USE_ w offset */
> > +enum cat_level_offset { Vu1 =3D V1 + 8, Vu2, Vu3, Vu4, Vu5, Vu6, Vu7, =
Vu8 };
> >
> >  /* recapitulate DRM's multi-classmap setup */
> >  #if !defined(TEST_DYNAMIC_DEBUG_SUBMOD)
>
> [ ... ]
>
> > @@ -160,6 +183,19 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_emptyclass, 0, =
0 /* ,empty */);
> >  DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_maptype, 3, 10, "no such type");
> >  DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_len, 0, 60,
> >                             "base", "plus", "classes", "length", "too-b=
ig");
> > +#endif
> > +
> > +#else /* TEST_DYNAMIC_DEBUG_SUBMOD */
> > +
> > +/*
> > + * in submod/drm-drivers, use the classmaps defined in top/parent
> > + * module above.
> > + */
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
> > +DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 7);
>
> [Severity: Low]
> Is this registration macro passing an outdated offset?
>

yes - fixed in v13 (forthcoming)

> The patch adds V8 to map_level_num, increasing its length to 8. While
> cat_level_offset correctly shifts the submodule's class definitions by 8
> (Vu1 =3D V1 + 8) above, this registration macro still tells dyndbg the
> classes start at offset 7.
>
> This mismatch causes submodule debug callsites to map to the wrong class
> IDs, leaving the last class (Vu8) completely out of bounds and
> uncontrollable.
>
> > +
> > +#if defined(DD_MACRO_ARGCHECK)
> >  DYNAMIC_DEBUG_CLASSMAP_USE_(fail_offset_big, 100);
> >  #endif /* DD_MACRO_ARGCHECK */
>
> [ ... ]
>
> > @@ -210,20 +247,85 @@ static void do_levels(void)
>
> [ ... ]
>
> > -static void do_prints(void)
> > +static void do_classes(int ct)
> > +{
> > +     if (ct < 0) {
> > +             unsigned long timeout =3D jiffies + (-ct) * HZ;
> > +
> > +             pr_debug("%s for %d seconds:\n", __func__, -ct);
> > +             while (time_before(jiffies, timeout)) {
> > +                     if (signal_pending(current))
> > +                             break;
> > +                     do_cats();
> > +                     do_levels();
> > +                     cond_resched();
> > +             }
> > +             return;
> > +     }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-=
part2-clean-v12-0-3c8cc5725def@gmail.com?part=3D26
