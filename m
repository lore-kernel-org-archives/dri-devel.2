Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F504CD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 08:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9293F10E50D;
	Wed,  6 May 2026 08:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OUCtbXAI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CBB10E50D
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 08:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778056672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMA+C0TJi4LM3UTvwkCroeu4Tv8AgJe8bHK3v1p/l2E=;
 b=OUCtbXAIom0lydhN+lO9z+XtYHlZR6wu9cdq5HmSfK7CnJmXsciTN8Z3v02qLumj4DI2id
 OFfliZaXwRqboOidSL8DG8FSq3zIeVC+zGqsDIcr5AbjoaZn8D+b1L/0E0TUJhM4l78YbY
 /rSWyMCExd/9MblSpzuuY17E1n7ino4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-168-SeZENUusuogyLnUJiw-1; Wed, 06 May 2026 04:37:51 -0400
X-MC-Unique: 168-SeZENUusuogyLnUJiw-1
X-Mimecast-MFC-AGG-ID: 168-SeZENUusuogyLnUJiw_1778056670
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7bd5c582c4bso148372947b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 01:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778056670; x=1778661470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IMA+C0TJi4LM3UTvwkCroeu4Tv8AgJe8bHK3v1p/l2E=;
 b=XDRo3YHN9TtlaNwFZjd9P6Yb7BDCJhsQTx4aUP5HJmdHPO7lKht2V8nlxwBTGPL94j
 y20GQPWN/9CyJlYsSJiKxigqlFRBu+UsQQ8Z9MtCuNRze6WxRz4Mckkp2aEpUTMEScEc
 O1cG6QzbpYfRsLVqydQoUoE3Bmc4RUd3jgPvQzQrySAAdtkzk0eP/Gcbco4GniHPHttZ
 7t6b/ujH4LCfJ/h2E1gDk0yvixtkMQ1+jObN8312BN+VJaH801TTWIotbNvxxUHXG5nh
 VhaD5acZNsKrdDZ3TOJykI7Zix+e4a4ZmxTR1Izf5mAKweQRnn/fTLxLgVe3ZyI55qAH
 sF5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QoAhU1+PSqNTafF4N2McwuBPMg6P4sDeob8Rt/w2ewfodWLr3UXAuq9MGxodazV1ekUuSNObglCU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yze6Ca+YwJZvwSZKjlIwafclr00qLoZjUtCPrKvXZnTMouEgdyq
 pWEUQyZFBiVdpVXL/T7xGzODqMzKlMrhdBjY3aD/WGhCBtgrJMK7/f5YpHI9VwWjHG1n5/S4evB
 +kYWqCHGhAL5BQIdsPv77d0CktFMj2cFl+wkgHzxteIxUQN0WP3BPjVrbS47BVJA1qz74mdSzIp
 CtSVEemfZ5Dq2pApskZIBTQhbN91SDBBmpcLCNXAJRxDOU
X-Gm-Gg: AeBDiess/x2Y/Icz8TM77AXhcbITmmKZ0LFgx/hJpOwAZWIiTNbC9HOF2WrvEBk8h4R
 GSg495xHToUZQlj0WVMO8MCHmfp0QfTAPriFjj5GM8Fy3LM9CUHXjpzPMDgJmWQirPdS5GRjNAw
 r/bEuzHIjvDlir/xJXdhB2VquEfsg4JF1aIpDiYbyvaBTfLitQoszrEecLRGxmuXtzy7DyJGRpR
 WtuMsW6sTtU8XIV
X-Received: by 2002:a05:690c:60c3:b0:7bd:696d:5137 with SMTP id
 00721157ae682-7bdf5eb872emr28070017b3.41.1778056670492; 
 Wed, 06 May 2026 01:37:50 -0700 (PDT)
X-Received: by 2002:a05:690c:60c3:b0:7bd:696d:5137 with SMTP id
 00721157ae682-7bdf5eb872emr28069617b3.41.1778056670063; Wed, 06 May 2026
 01:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
 <20260504-kunit_add_support-v8-3-3e5957cdd235@redhat.com>
 <20260504-tentacled-free-lobster-38d8d9@houat>
In-Reply-To: <20260504-tentacled-free-lobster-38d8d9@houat>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 May 2026 10:37:39 +0200
X-Gm-Features: AVHnY4LGPM5httthyZYEMeSVpsAZZGIetxyr0Irj5BEH6JEFnHV4PP6tgxL43VM
Message-ID: <CADSE00+TPGWPjD7DGHy5f+=QzwUqYHc=X-G1sEER8=NS5VvV-Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] drm: Suppress intentional warning backtraces in
 scaling unit tests
To: Maxime Ripard <mripard@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>, 
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Alessandro Carminati <acarmina@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WNZjlayz8KWUrQZ4DdGgUhSavtIixTEQQVwE3AcqdoQ_1778056670
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

On Mon, May 4, 2026 at 12:04=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Hi,
>
> On Mon, May 04, 2026 at 09:41:27AM +0200, Albert Esteve wrote:
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
> > Acked-by: David Gow <david@davidgow.net>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/gpu/drm/tests/drm_rect_test.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/te=
sts/drm_rect_test.c
> > index 17e1f34b76101..818e16e80c8f9 100644
> > --- a/drivers/gpu/drm/tests/drm_rect_test.c
> > +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> > @@ -409,8 +409,16 @@ static void drm_test_rect_calc_hscale(struct kunit=
 *test)
> >       const struct drm_rect_scale_case *params =3D test->param_value;
> >       int scaling_factor;
> >
> > -     scaling_factor =3D drm_rect_calc_hscale(&params->src, &params->ds=
t,
> > -                                           params->min_range, params->=
max_range);
> > +     /*
> > +      * drm_rect_calc_hscale() generates a warning backtrace whenever =
bad
> > +      * parameters are passed to it. This affects all unit tests with =
an
> > +      * error code in expected_scaling_factor.
> > +      */
> > +     kunit_warning_suppress(test) {
> > +             scaling_factor =3D drm_rect_calc_hscale(&params->src, &pa=
rams->dst,
> > +                                                   params->min_range,
> > +                                                   params->max_range);
> > +     }
> >
> >       KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_fa=
ctor);
> >  }
> > @@ -420,8 +428,15 @@ static void drm_test_rect_calc_vscale(struct kunit=
 *test)
> >       const struct drm_rect_scale_case *params =3D test->param_value;
> >       int scaling_factor;
> >
> > -     scaling_factor =3D drm_rect_calc_vscale(&params->src, &params->ds=
t,
> > -                                           params->min_range, params->=
max_range);
> > +     /*
> > +      * drm_rect_calc_vscale() generates a warning backtrace whenever =
bad
> > +      * parameters are passed to it. This affects all unit tests with =
an
> > +      * error code in expected_scaling_factor.
> > +      */
> > +     kunit_warning_suppress(test) {
> > +             scaling_factor =3D drm_rect_calc_vscale(&params->src, &pa=
rams->dst,
> > +                                                   params->min_range, =
params->max_range);
> > +     }
> >
> >       KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_fa=
ctor);
> >  }
>
> For both I think we should add KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT call=
s, no?

Hi Maxime,

It may indeed add verification value by ensuring the call actually
generates the expected warning.

The original patch did not include count checks on the version I
inherited it from (i.e.,
https://lore.kernel.org/all/20250526132755.166150-5-acarmina@redhat.com/),
so I kept the same approach while adapting to the API changes. That
said, the check is simple to add, so I could include it in the next
version.

BR,
Albert

>
> Maxime

