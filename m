Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D322BFB44BB
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3453010F31A;
	Fri, 24 Apr 2026 07:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gRZy9pch";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7FB210F31A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 07:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777015044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocRQwsGxmUd24plQscvID6P4Yrryzt44ghQQY2RzSsk=;
 b=gRZy9pcheJJfNKQc79QzEv5r8/IBDDn08DR1gjiy2fR3/jpGUnWOM5iNst+Y2giyle2K0Y
 N/ib1ATM4AupQy4L2UsgraHZ1TLQTSakdKZbUOrLYIP9GQdOqTk9ZcMD8g85CvVsgi/lo6
 VeBEZksNptqE+6c/+Rr97P39D3fhCWU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-LPyeXd2aOTa737oKlIlTJw-1; Fri, 24 Apr 2026 03:17:18 -0400
X-MC-Unique: LPyeXd2aOTa737oKlIlTJw-1
X-Mimecast-MFC-AGG-ID: LPyeXd2aOTa737oKlIlTJw_1777015038
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7b6fea89dd7so93204377b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 00:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777015038; x=1777619838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ocRQwsGxmUd24plQscvID6P4Yrryzt44ghQQY2RzSsk=;
 b=Aznr1skFWMjtL5WOA4NPpdB7Uavkmo8G1hbUQ7qemg36I4vIpxiN3n+yLcqs2YYnhE
 XNIPSH3AHULHp6MGVMyfJxhn0AQmvNR+8WBPBhwH+w04WMyK3olRZ0Zy4SpK2W2cVf3a
 zMV/GER9HOTLtWEQ3fm6jvyc0jKEp3FHVBeJLGisirkBDPTEGfPdrKzdy1EtvJ7YN0fH
 xV41+2cLrv7D//SIckJmsCOU7OBjLLARF0ra9xWOeRm9cuqkAb8VnCM+MDy2MMyd6dtZ
 z12oQuxrFaiIlq38BIFNL3qCKAZbviTr2L0DAMN12So1j1H+TPRxYB2N+2MU9fEDJ8+B
 Rddw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NSQIN9LZH0+faTU+K6dHNdn+WDYkTyfKHJ1/cCl3nMR1fwj2tnmxmMY8dMzPbl8gzAC4dqm7YKs8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgtfgCoAnD2TmZvgorY2zyHIoRUIpfGvpA0OJz3HSR13i/w3Mb
 y9UKpWApAHqugOgdRYJTEwaOIUBUA3S1VYyvf6KUUinzhfbVkoLlLUREWncoGn5thI7hPii/vxc
 uHRgZIgf0zyGUe1OnhLmVVPjrWCkqVyfcVAFGsHFJWj0btbDpRsE3frNvFqIZvF45RueQvJPxl4
 jAf4Kvj3qwZX50xxHYymP9Ycg5JDzrkGSm2YL39hO0SBsm
X-Gm-Gg: AeBDiethYoyuqx4BNnfnRSR+zYIscfiJWqZpzj8RflYnsMcTBmC4sihhg8YIre68nnV
 T98RyerCVrY14V2wrsWumw0+Rv5zw5ATVk026JQQpYa2xLSV6qS7SGTWIs1MeUDSvqOBwNnpola
 0q2rk2/JqrJlpkj4kRfmr+lwZKcOT/Ir2qWKl98NqoynsFyOCcS1vYpqrgHBkoQ5rWrynzfXHsC
 sz4FdIah6g/0Eka
X-Received: by 2002:a05:690c:2701:b0:79b:cf31:9767 with SMTP id
 00721157ae682-7b9ece638bbmr313691517b3.3.1777015037638; 
 Fri, 24 Apr 2026 00:17:17 -0700 (PDT)
X-Received: by 2002:a05:690c:2701:b0:79b:cf31:9767 with SMTP id
 00721157ae682-7b9ece638bbmr313691117b3.3.1777015037197; Fri, 24 Apr 2026
 00:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com>
 <20260420144702.GM3102624@noisy.programming.kicks-ass.net>
 <CADSE00JJq6fsYbkFN5hBD=-ZWsFG9p4_C55fp3MupMJQj0QCUQ@mail.gmail.com>
 <8a9c125c08206296d698c79c3d3dd6aea36a7e3b@intel.com>
In-Reply-To: <8a9c125c08206296d698c79c3d3dd6aea36a7e3b@intel.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 24 Apr 2026 09:17:05 +0200
X-Gm-Features: AQROBzD6yZWbejVMF7ldH8G24-m4djSD1N4zfjIlQ_Qh0r0EH3w2r9AAFZGj5x0
Message-ID: <CADSE00+b-8moX5FkLjLs+wzyaW5dtJDMxvTT6Gu-QmDoDxJdVA@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] drm: Suppress intentional warning backtraces in
 scaling unit tests
To: Jani Nikula <jani.nikula@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Alessandro Carminati <acarmina@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AJ4Cjy5lPYZLK7EK5H5wlTbm9N1uQlXwBCGvKpXFowk_1777015038
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

On Tue, Apr 21, 2026 at 1:51=E2=80=AFPM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> On Tue, 21 Apr 2026, Albert Esteve <aesteve@redhat.com> wrote:
> > On Mon, Apr 20, 2026 at 4:47=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> >>
> >> On Mon, Apr 20, 2026 at 02:28:06PM +0200, Albert Esteve wrote:
> >> > From: Guenter Roeck <linux@roeck-us.net>
> >> >
> >> > The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tes=
ts
> >> > intentionally trigger warning backtraces by providing bad parameters=
 to
> >> > the tested functions. What is tested is the return value, not the ex=
istence
> >> > of a warning backtrace. Suppress the backtraces to avoid clogging th=
e
> >> > kernel log and distraction from real problems.
> >> >
> >> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >> > Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> > Acked-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> > Cc: David Airlie <airlied@gmail.com>
> >> > Cc: Daniel Vetter <daniel@ffwll.ch>
> >> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> >> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >> > ---
> >> >  drivers/gpu/drm/tests/drm_rect_test.c | 14 ++++++++++++++
> >> >  1 file changed, 14 insertions(+)
> >> >
> >> > diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm=
/tests/drm_rect_test.c
> >> > index 17e1f34b76101..1dd7d819165e7 100644
> >> > --- a/drivers/gpu/drm/tests/drm_rect_test.c
> >> > +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> >> > @@ -409,8 +409,15 @@ static void drm_test_rect_calc_hscale(struct ku=
nit *test)
> >> >       const struct drm_rect_scale_case *params =3D test->param_value=
;
> >> >       int scaling_factor;
> >> >
> >> > +     /*
> >> > +      * drm_rect_calc_hscale() generates a warning backtrace whenev=
er bad
> >> > +      * parameters are passed to it. This affects all unit tests wi=
th an
> >> > +      * error code in expected_scaling_factor.
> >> > +      */
> >> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> >> >       scaling_factor =3D drm_rect_calc_hscale(&params->src, &params-=
>dst,
> >> >                                             params->min_range, param=
s->max_range);
> >> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> >>
> >> Would not something like:
> >>
> >>         scoped_kunit_suppress() {
> >>                 scaling_factor =3D drm_rect_calc_hscale(&params->src, =
&params->dst,
> >>                                                       params->min_rang=
e, params->max_range);
> >>         }
> >>
> >> be better?
> >
> > Since KUnit already has a few macros in its API it didn't occur to me.
> > Good idea, I like it. And I guess the scope approach matches well with
> > your __cleanup comment in the first patch. If no one opposes, I will
> > work toward that pattern for the next version.
>
> There's a catch with kunit and __cleanup and thus (scoped) guards. Kunit
> runs in ktreads, asserts lead to kthread_exit() and the __cleanup won't
> be called.

Hi Jani,

Good point. In this specific case, the actual cleanup is handled by
kunit_add_action_or_reset(), so __cleanup not firing on assert is
harmless.

>
> Warning suppression being part of kunit infrastructure, asserts can and
> should end the suppression too. But setting the example (scoped) guards
> are safe in kunit tests in general feels like a trap waiting to happen.
>

... but I agree it sets a misleading precedent. I'll stick with the
explicit start/end API, then? Or maybe we can clearly document why the
scoped approach is safe in this case and use it.

>
> BR,
> Jani.
>
>
> >
> >>
> >> Also, how can you stand all this screaming in the code?
> >>
> >
> > Again, KUnit already contains many macros, so this use didn't register
> > as such. Now I will not be able to unsee it.
> >
> >
>
> --
> Jani Nikula, Intel
>

