Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1BFF327C8
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C9D10E1A8;
	Tue, 21 Apr 2026 08:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AbL8eMy+";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10DD10E1A8
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776760891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mC05YTc5SmuhQF/mCBd5RraHNHqhmq97LDEIrPY8QyQ=;
 b=AbL8eMy+FJQQ8Vx0AitvijyiKUsKAJqy4Yc2G69FD3lAU1f4hmXO2LHkK7uiV1BqzoVn+f
 sJ2dR9Yix/+oTLi01P3EiSkQVI5bppQIsEbD0X73yfJ2Rk5HcwiU80LUsDdDgBEXCL02NO
 kFTn1IrXuAdzl5p785kBLOQJmtvTzPA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-Lca06_YoPXqdZHIu5nwAFg-1; Tue, 21 Apr 2026 04:41:30 -0400
X-MC-Unique: Lca06_YoPXqdZHIu5nwAFg-1
X-Mimecast-MFC-AGG-ID: Lca06_YoPXqdZHIu5nwAFg_1776760890
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-794b240c0d3so130629137b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 01:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776760890; x=1777365690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mC05YTc5SmuhQF/mCBd5RraHNHqhmq97LDEIrPY8QyQ=;
 b=Jwfcju4wQ8gRAH4ov4PEFxHyzAz3Amq4XDZsM8L6aymrTersfGhGudkRSGfVpB/gqC
 MAQcfy8XhtdIEf4oKFjKHTGMMxgw0MMW7QnLa0PKBP0rONQFjibuVU35gmeCK58vtc8H
 3Ocb+DvN4HwNFg3t6oMeO5V2EQrTm9vkyNBqa7C6QRpwBDtBNlhZ7j0CvHGQPpkhxBW2
 6LG4eIqCUbb13d8i3im6wEG5P9MiSaoytPxz7Jj8cQ2JTjjISm9a/KXnZNOgjSCR+oXl
 dvbmDiz1XLB6yNDmbXTVwoFJHCBMyw/bWrRdZNzaANFYuSLZ6pvodZUQ6K2BdABop3Zi
 RuOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8b8bY0JFOOhnReE8VHvry05dcQ49MOqfvsKDDXj7C6ZBdYvJNpgvN2zecQnEPJIVF7pP6gMc0ciWg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJDaOzTvtXPAY2YCfRvymqmBwCRSgbvX2Fn1gxsQC9kVJIRtKd
 kd/h4l4pGnngiGa19EMwRNNHoKx5f7UtjMw8E2l9jGWvYepJsSc+2Oo+s0ITAPYLgeJP9gMBNHB
 NuFlkBW4uzXVjh0IbRMAfi3pAxTqpQhZhOleeTmBzg5ucExtDMqnNzrsqyeoQhdE1/ox5AJrVeE
 q/MSF2P9yRRwqkb5Zc/YcR6G51o23v6IJ7VqKO1D4vwcUr
X-Gm-Gg: AeBDietemnAeMrzeeRBHetBX2Hsp5PDAvEszKspi0frsMGr83vx57O8HBbCuH46ncVA
 8Ji/zJP7K4ih24VJXFLPyXTN6aX5AdcXItmby3ihut/hOnxtMq10Tjg+72TF5GVWeANCP2Df2h0
 kQUn2pSRwuHNszOJvY0O3cucyAFA3JlTJ5NBOZ7YQRw0CTpwcuXE3DDvNalW6GAOZRTvQpOFR66
 TWs+G1TKtMpUPI4
X-Received: by 2002:a05:690c:6e85:b0:7ba:f0ed:c5cd with SMTP id
 00721157ae682-7baf0edf46bmr49084297b3.33.1776760889732; 
 Tue, 21 Apr 2026 01:41:29 -0700 (PDT)
X-Received: by 2002:a05:690c:6e85:b0:7ba:f0ed:c5cd with SMTP id
 00721157ae682-7baf0edf46bmr49084027b3.33.1776760889332; Tue, 21 Apr 2026
 01:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-2-e8bc6e0f70de@redhat.com>
 <20260420144453.GK3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260420144453.GK3102624@noisy.programming.kicks-ass.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 21 Apr 2026 10:41:18 +0200
X-Gm-Features: AQROBzCV0B5mGT_w3fyNoIOcvbOSxwzeCNrVj_GyXS8H3Qz0Owy2xkfDx8OhQQ8
Message-ID: <CADSE00LrkRcuWw_uhbRbjvDhoHX4Ogouu038-9kQEQ_3BxPG5g@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] bug/kunit: Reduce runtime impact of warning
 backtrace suppression
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
 Alessandro Carminati <acarmina@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OWz-PGkhtxoeCRhAfT5C-T4FAchJrWUCN58tZW68MqY_1776760890
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

On Mon, Apr 20, 2026 at 4:45=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Apr 20, 2026 at 02:28:04PM +0200, Albert Esteve wrote:
> > From: Alessandro Carminati <acarmina@redhat.com>
> >
> > KUnit support is not consistently present across distributions, some
> > include it in their stock kernels, while others do not.
> > While both KUNIT and KUNIT_SUPPRESS_BACKTRACE can be considered debug
> > features, the fact that some distros ship with KUnit enabled means it's
> > important to minimize the runtime impact of this patch.
> >
> > To that end, this patch adds an atomic counter that tracks the number
> > of active suppressions. __kunit_is_suppressed_warning() checks this
> > counter first and returns immediately when no suppressions are active,
> > avoiding RCU-protected list traversal in the common case.
> >
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  lib/kunit/bug.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
> > index 356c8a5928828..a7a88f0670d44 100644
> > --- a/lib/kunit/bug.c
> > +++ b/lib/kunit/bug.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <kunit/bug.h>
> >  #include <kunit/resource.h>
> > +#include <linux/atomic.h>
> >  #include <linux/export.h>
> >  #include <linux/rculist.h>
> >  #include <linux/sched.h>
> > @@ -15,11 +16,13 @@
> >  #ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> >
> >  static LIST_HEAD(suppressed_warnings);
> > +static atomic_t suppressed_warnings_cnt =3D ATOMIC_INIT(0);
> >
> >  static void __kunit_suppress_warning_remove(struct __suppressed_warnin=
g *warning)
> >  {
> >       list_del_rcu(&warning->node);
> >       synchronize_rcu(); /* Wait for readers to finish */
> > +     atomic_dec(&suppressed_warnings_cnt);
> >  }
> >
> >  KUNIT_DEFINE_ACTION_WRAPPER(__kunit_suppress_warning_cleanup,
> > @@ -37,6 +40,7 @@ __kunit_start_suppress_warning(struct kunit *test)
> >               return NULL;
> >
> >       warning->task =3D current;
> > +     atomic_inc(&suppressed_warnings_cnt);
> >       list_add_rcu(&warning->node, &suppressed_warnings);
> >
> >       ret =3D kunit_add_action_or_reset(test,
> > @@ -68,6 +72,9 @@ bool __kunit_is_suppressed_warning(void)
> >  {
> >       struct __suppressed_warning *warning;
> >
> > +     if (!atomic_read(&suppressed_warnings_cnt))
> > +             return false;
> > +
> >       rcu_read_lock();
> >       list_for_each_entry_rcu(warning, &suppressed_warnings, node) {
> >               if (warning->task =3D=3D current) {
> >
>
> So the thing you're skipping is:
>
>   rcu_read_lock();
>   list_for_each_entry_rcu() {
>   }
>   rcu_read_unlock();
>
> Which is really cheap. Did you actually have performance numbers for
> this?

No, I do not have performance numbers. I kept the counter and the
separate patch for consistency with the previous version of the
series. But you have a good point, the skipped part is really cheap.

>
> A possibly better option is to add a static_branch() that could elide
> any and all memory access.
>

Previous version had static_branch and I removed it because I
understood from the discussion that the gains would not be significant
as performance gains are irrelevant in warn slowpath. But I think it
would make sense for a disabled feature. I will rework this for the
next version, remove the counter and use static_branch as suggested.

