Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7F7C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780E010EF22;
	Wed,  9 Sep 2026 06:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r/3VatKH";
	dkim-atps=neutral
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2072510E155
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 17:57:47 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-39c95395230so43856311fa.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788890262; x=1789495062; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YqvYHjfMGh1MW54/g0K1Oez4luMXjAhsckidP9l0mRI=;
 b=r/3VatKHGGlZkOiASNMVrAVNH6ibTS8UB7DZnjm4o5AagSDg2P1hj5CkXRxN/iJm0A
 DMwPW0Ssjohp2zMUxerFmc098y7tzkoGJ+p3yP2yC8/5N0px/qSro6+JFn2wZBbGuwId
 zJAYRJTPNOrg/xfaoue0nztF2GT2VmsTzp/Z7puFwP1KLcaOQxhN3TcmALk17JBFOffY
 K5t+ny8NjV58YcC+9iB9ULn5Jv9Yubf/kRC5UauPyzm6j4BagHxhCSPSSfOopulIKpEM
 tHGC9YM9hVcGe4XZJhCJ8jYP3R1UX9A5dT4czR/knbM2kIaM1vbCziaBTy3xWvu9iAQb
 TIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788890262; x=1789495062;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YqvYHjfMGh1MW54/g0K1Oez4luMXjAhsckidP9l0mRI=;
 b=lL7Uu2NdDNHXIf2tuZO//BfaAMbeQzaii/1yQxCDAWhiVeySI23j9rMEFvTJ0oQxov
 lXAbR+zxj++CDljGWI2bNSJkAAlVoKWZz/WnCiwjio3O8ZxeczMstX5ZM/Y/XBASaj2L
 EMuDTVGP24agNVH4fy+DMMpOhea5hPtxXjrJZt1N/+0xf2Gmu2WmFB9KlH+wWZC1m31B
 4NiNAWF3AMamYEjoGXszXbXYj73QqCP4/wF92AYrA8U463piA3ywwb7kVq8avS5LhzjI
 mTlGdy8cJok0VVZGqfReH41hNnKVEMUD0Kd90uRy3bUcLwnIqhkvtjRMZGGmjnQyzCFz
 /xDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/NpZkr18AdW/qgnPzotekr+OCNs/MnHk41b963uf0skAa39us6LlBPnx1S2VHsPdc2e99/FV+FE0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nUWusF5GwSX4LPjn/x2ol5aVrfae3wGp0eTGP7qLV7Qw3FNn5d
 SoPlr+tuXT8/OkHOMuUcZ0kERmaP9ey0jFCTysG8O8Cc7oNaYQkQTSJJ
X-Gm-Gg: AYBFou15TPdQ5bunnqUPUL87bRMmXDOkJ0zDogyedP7JJ5tgwvcoh1w31vz9xmX5B2t
 /YpmjdIhOBV60Yp3ux8R8Se3hVP7r4aG2pGFTL+9Qu7D65YrpzL5rpxybcmdEjUdXM54zin9PWQ
 74AEcNfjCRKqgvb5pHgB7QPifo3RDGuzSs1dRqRZC1BDktKgpqxOJ1q5Pfzk5fh76k5ZFA+c9AJ
 +fZzbEl/R2XlTJixMPCXZUVnic6EaX0VNc1ByPN+FLLbZPKYk3G/XD0VTX0ARB31mISVu+OKH7U
 Lq3YoBumo5F/xb+lDad+51LuULY1nc0Oj9uac1HiRI6DnW35XTuiByz+AXr0Udz268LIEJCG0LK
 eYkgGXNUmu0U42R97tyQLF7zPrgCVB11G1kUnGK1TwrKGs7+4Kk7yiQy2GHMZ80AJJpE6o+SQhy
 PwoqC0n8c/ubYRV15I+DT3xNOj93x6Jn7LI3KWgnQSSgTgDaJgMnI02LDD8kpRkeTIfvn3iWl8k
 OA=
X-Received: by 2002:a05:651c:543:b0:3a1:8dd6:aaf9 with SMTP id
 38308e7fff4ca-3a371b871c6mr31427461fa.8.1788890262340; 
 Tue, 08 Sep 2026 10:57:42 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu.
 [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a3c2a44f1dsm34401741fa.33.2026.09.08.10.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:57:41 -0700 (PDT)
Date: Tue, 8 Sep 2026 19:57:41 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Manuel Ebner <manuelebner@mailbox.org>, 
 Thorsten Leemhuis <linux@leemhuis.info>,
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Felix.Kuehling@amd.com, Mukul Joshi <mukul.joshi@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Mark Brown <broonie@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 rust-for-linux@vger.kernel.org, 
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
Message-ID: <aqBMUBzgwXT4Ry7u@soda.int.kasm.eu>
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
 <20260831183311.1090131-2-alexander.deucher@amd.com>
 <aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info>
 <e8a53eb241b2cc912e9cfad5f6a0120aa9683481.camel@mailbox.org>
 <apyTR-f8W6Jt7uP5@soda.int.kasm.eu>
 <CADnq5_PjN8X9V0PQ=no39NCAGM9Hp1JezOuKNpHqwo1=WfsPQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PjN8X9V0PQ=no39NCAGM9Hp1JezOuKNpHqwo1=WfsPQQ@mail.gmail.com>
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

On 2026-09-08 12:03:57 -0400, Alex Deucher wrote:
> On Mon, Sep 7, 2026 at 3:25 AM Klara Modin <klarasmodin@gmail.com> wrote:
> >
> > On 2026-09-05 11:31:41 +0200, Manuel Ebner wrote:
> > > On Sat, 2026-09-05 at 07:36 +0200, Thorsten Leemhuis wrote:
> > > > On 8/31/26 20:33, Alex Deucher wrote:
> > > > > From: Mukul Joshi <mukul.joshi@amd.com>
> > > > > ...
> > > > ...
> > > >
> > > > > > error[E0063]: missing field `handle_free` in initializer of `drm_gem_object_funcs`
> > > > > >    --> rust/kernel/drm/gem/mod.rs:265:58
> > > > > >     |
> > > > > > 265 |     const OBJECT_FUNCS: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
> > > > > >     |                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `handle_free`
> > > > > >
> > > > > > error: aborting due to 1 previous error
> > > > > >
> > > > > > For more information about this error, try `rustc --explain E0063`.
> > > > > > make[2]: *** [rust/Makefile:799: rust/kernel.o] Error 1
> > > > > > make[1]: *** [/builddir/build/BUILD/kernel-7.3.0-build/kernel-next-20260904/linux-7.3.0-0.0.next.20260904.221.vanilla.fc43.aarch64/Makefile:1442: prepare] Error 2
> > > > > > make: *** [Makefile:256: __sub-make] Error 2
> > > > """
> > > > Full log:
> > > > https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-43-aarch64/10951622-next-next-all/builder-live.log.gz
> > > >
> > > > Reverting this change and 2/3 from this set fixed the problem for me.
> >
> > That leaves only the documentation without the feature so might as well
> > drop 3/3 too in that case?
> >
> > Otherwise, the following also fixes it for me:
> >
> > diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> > index e1ebad77ebe2..847e0ee38863 100644
> > --- a/rust/kernel/drm/gem/mod.rs
> > +++ b/rust/kernel/drm/gem/mod.rs
> > @@ -278,6 +278,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
> >          vm_ops: core::ptr::null_mut(),
> >          evict: None,
> >          rss: None,
> > +        handle_free: None,
> >      };
> >
> >      /// Returns the `Device` that owns this GEM object.
> >
> 
> Can you send this as a proper patch?

Here: https://lore.kernel.org/lkml/20260908175427.47207-1-klarasmodin@gmail.com

I liked Gary's suggestion so went with that instead.

> 
> Thanks,
> 
> Alex

Regards,
Klara Modin

> 
> > >
> > > Verified.
> > >
> > > Thanks
> > >  Manuel
> > > >
> > > > Ciao, Thorsten
> > > > > ...
> >
> > Regards,
> > Klara Modin
