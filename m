Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D705F327C2
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9113910E1A9;
	Tue, 21 Apr 2026 08:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="an4JMKCf";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C3D10E1A9
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776761411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLkS/Ta9vRJDH5KioddXAEgwRVTq9xjtMihkgqxZ3KQ=;
 b=an4JMKCfL9X6mLxbOWv2fmZhXnnUKbMQYTcMXwSSpCJoJCksiHvjThxIb714+/hkojUKm2
 stshGysuN0NvsxHaeOe+Q7RzYEogYeGS24EaReeuIItS3M7mZ1OXPUMiNYXDox6mPQOLIc
 2fLMMzUgGfWDBNPkyjcW7mUdfOtX0vM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-BSi1x6GJM9ilasxz4bIg6w-1; Tue, 21 Apr 2026 04:50:10 -0400
X-MC-Unique: BSi1x6GJM9ilasxz4bIg6w-1
X-Mimecast-MFC-AGG-ID: BSi1x6GJM9ilasxz4bIg6w_1776761410
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7a45cf7ff24so64685177b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 01:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776761410; x=1777366210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZLkS/Ta9vRJDH5KioddXAEgwRVTq9xjtMihkgqxZ3KQ=;
 b=QHI42z1eGipWR4DRDKafVRynVJldhDVWjKoXi1ztaR83ne4cxM2+u562QnXVuudLxT
 CZWq62IX4dh8ZVfpgsPxHsui3ZFGbfBJHZZQmx3+Zo37EGdhmuHD4doWd3ABkoEaP8cv
 hLzfDp8XNhmF355hMr+NLVap6ap67OPGVwFsvMBXcNQss7TawCoF7PEVYDbXeiCeXtaN
 rVTIoGA8dT4vHg8f4gIA58BGW1+EOeIUDUdcGvzAFWg4el2xhjOT5ssQzrLElRMDLgvY
 w8qemigv82hDW+N3XPxfErECo/LjGGq8dJYsWAV5XzrWvAlgoTKgNuPTyCGB+/OZc0Om
 qrkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+G+vxV8ULswhICGepocfNLavRLlDZcZ0qts52hpctqGJtCC3RM3EGOwaw800D70c+3KyM3Y9e13qk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQ3ICwskwT2Br4BMYGFi7A/ZCpJx9G7+FBKgbRnqqTrURpdCY/
 b/BroCjEeNByn4jNhGxBV8xH8HQygGhfLvfYnDgUzYb9GdEtY8GyPxpOPB46zVKAWG3fKaPN9hO
 5RlqxW8aSsNVhnmEcuIDj2cxUuka0LAYFa862kfIcEBLBJeyhrZxE3Hr/5Premb9wOoNG8Vurit
 6XB5y9ftibluF4iUBDiyJ+vsrdvuOlpLzXHld9+r2NGwgl
X-Gm-Gg: AeBDievj+ze7fP8ZicnyFZo57dEdcU8g86N9HjLUm/1VFsvqhiN77roWqXPj/7DkIgP
 ZmQvGt2q5OI5bULopfrq4MkTrHvW5khKjHSXpTGJfp6/7lawiqXhekEE0Alqi6e2zQblhhWTuvJ
 xZ1g1leXNQKXQS8nhgb0DjkI47iUciqc1ogaqo9QF2FEs07PcPQSSFGoQ1kAyx47fMnVKBW4ZP+
 sQZVIP9Y7n5xooD
X-Received: by 2002:a05:690c:dd5:b0:7b2:9347:7bdf with SMTP id
 00721157ae682-7b9ed000a01mr173415457b3.37.1776761410081; 
 Tue, 21 Apr 2026 01:50:10 -0700 (PDT)
X-Received: by 2002:a05:690c:dd5:b0:7b2:9347:7bdf with SMTP id
 00721157ae682-7b9ed000a01mr173415087b3.37.1776761409658; Tue, 21 Apr 2026
 01:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com>
 <20260420144702.GM3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260420144702.GM3102624@noisy.programming.kicks-ass.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 21 Apr 2026 10:49:58 +0200
X-Gm-Features: AQROBzCldOYbfR8ys3ZZ4dkJqQQZYQ8VWy-mBIRFS67smM8o_e_X6azO-SUJq08
Message-ID: <CADSE00JJq6fsYbkFN5hBD=-ZWsFG9p4_C55fp3MupMJQj0QCUQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] drm: Suppress intentional warning backtraces in
 scaling unit tests
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
 Guenter Roeck <linux@roeck-us.net>,
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Alessandro Carminati <acarmina@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v_a7y8d1vzwR5QsjCxe1gzEoOqA74AdjUASiUaUWa98_1776761410
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

On Mon, Apr 20, 2026 at 4:47=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Apr 20, 2026 at 02:28:06PM +0200, Albert Esteve wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> >
> > The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
> > intentionally trigger warning backtraces by providing bad parameters to
> > the tested functions. What is tested is the return value, not the exist=
ence
> > of a warning backtrace. Suppress the backtraces to avoid clogging the
> > kernel log and distraction from real problems.
> >
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Acked-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/gpu/drm/tests/drm_rect_test.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/te=
sts/drm_rect_test.c
> > index 17e1f34b76101..1dd7d819165e7 100644
> > --- a/drivers/gpu/drm/tests/drm_rect_test.c
> > +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> > @@ -409,8 +409,15 @@ static void drm_test_rect_calc_hscale(struct kunit=
 *test)
> >       const struct drm_rect_scale_case *params =3D test->param_value;
> >       int scaling_factor;
> >
> > +     /*
> > +      * drm_rect_calc_hscale() generates a warning backtrace whenever =
bad
> > +      * parameters are passed to it. This affects all unit tests with =
an
> > +      * error code in expected_scaling_factor.
> > +      */
> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> >       scaling_factor =3D drm_rect_calc_hscale(&params->src, &params->ds=
t,
> >                                             params->min_range, params->=
max_range);
> > +     KUNIT_END_SUPPRESSED_WARNING(test);
>
> Would not something like:
>
>         scoped_kunit_suppress() {
>                 scaling_factor =3D drm_rect_calc_hscale(&params->src, &pa=
rams->dst,
>                                                       params->min_range, =
params->max_range);
>         }
>
> be better?

Since KUnit already has a few macros in its API it didn't occur to me.
Good idea, I like it. And I guess the scope approach matches well with
your __cleanup comment in the first patch. If no one opposes, I will
work toward that pattern for the next version.

>
> Also, how can you stand all this screaming in the code?
>

Again, KUnit already contains many macros, so this use didn't register
as such. Now I will not be able to unsee it.

