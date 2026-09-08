Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEAFC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091CA10EF03;
	Wed,  9 Sep 2026 06:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GBmHPlxR";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99F210E355
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 19:09:43 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5b457a0b4e5so4815450e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 12:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788894582; x=1789499382; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JzCxaqYiEeBDnH0h79ydYlAnHFlqut2ERcxebrbyVOA=;
 b=GBmHPlxRIysmkQx2dvrnMgttBx8SMyAGa/ntdMhWfj5OeEac3sueb6doZYb4B9QT4u
 ijpgMX6Mq4b1dX7P2oDKXXk/RV4YTT4xLUtHMlitPChndG2UexVOQTH2yvFSxBdP8hY1
 tRkunYHNdui1jJ7J4US8Mm50VuiteNisuTcO6L0AhlbeEDKRJM1T0QQtezd3CnrTKm4I
 Bab3Tv7AkG+HJ/6jWleKPy4AgH/QtfNirYoNCsuikceoHmRkf9/CNLdPSWlRwKbHi94E
 lM311qy5UiFFvQyJz0jupXhLbtx4CfriMciFsoG5IEUs7fvC75Ls1mZxieb7ihlEevnD
 FjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788894582; x=1789499382;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JzCxaqYiEeBDnH0h79ydYlAnHFlqut2ERcxebrbyVOA=;
 b=IeJEHbr3Y3b4Ef0lzrPwWJ1vxKP6PiSH6qcu0uPJWb0UbJlmFDP7zQY8xhbTjWqrQm
 kh7t9KHpCA4+fn6XbNJo7uvuFm/dLQfMTPyBNjpwm0EgCFlJFRGXJhXjwV7gz9xJXA3t
 tJzoVpy/D+QbAPgvakc/vhLstoJcFsq5LPgsn74mDblRpiLhbTLWYsbLgb0lvr8debyv
 qIDqGyUyxjJexbt0bV0nBbbO+7EgAyOQblA7yGXA5rBZnWP80PVL7OCpycJ92toQJiCS
 Iua479A1MaJIRqT7f700caE/h+SQY437oCQShpLHfd38yhY3mswcpnirlzw8nWZ3V4jf
 CNQw==
X-Gm-Message-State: AFuF++l/HrfKtMiJc28lbhrSCH60y0sETnQyioal3tgzKoaEuQob99f7
 zFLSxfaJknU8DfjJjCVT2hYa65uyXRI5dwgq+T0Js5EzaoDA6w3xUPIp
X-Gm-Gg: AYBFou19T84lUiovFYl3gRa4r30MplZUKRQIBpiqoMDkS442x9XD9SnPoKV5qp6PRAR
 Xe5Azvcy0Qn1dSdjTetDAb+jMnC8GPGKs5hoxdi1vx8x39wf2b76p5IIO/eK9eKkeAExc1DYLK3
 ZQ/iO8qrf/Qn0Vhd/gJpR1JEgTdpJ4oxF85WHT5pkNRuv0/5UuMohMTUQZt6aUEp4+0jF8kRwEf
 pqo3KzF67outBdoinNpLzW8pAr+GU4U6zvRkg8F1qJ2yhK2pS7N855tsg1SkRVjEUDXINqzcjQm
 goGM1w4wE7DKYPHw1ZU8756KXQznw3XywFXh2ULZSLVyGX/QPm+VYhan7vbObDb3EdUrjCBFyYV
 ihAIffZtRkhp/snwg9r/y5TYrEO2/YK7svTbIJe85p2NCzQMKt0le+KYitSbHxRYYnYTiy/h6Sk
 hQSp5zEdyabqVmqRwK5sbwXocx7TPnNZ3QN5bVjZTSXtnHxfBGO8QIVaU2FzTGcSeSY2NQhnUNL
 80k
X-Received: by 2002:a05:6512:15a1:b0:5b5:e3b9:2236 with SMTP id
 2adb3069b0e04-5b616edef30mr4548116e87.1.1788894581868; 
 Tue, 08 Sep 2026 12:09:41 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu.
 [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166ed4dcsm3212290e87.20.2026.09.08.12.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 12:09:41 -0700 (PDT)
Date: Tue, 8 Sep 2026 21:09:40 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, 
 rust-for-linux@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust/drm/gem: initialize callbacks with
 ..pin_init::zeroed()
Message-ID: <aqBdJY43QlnN5wnx@soda.int.kasm.eu>
References: <20260908175427.47207-1-klarasmodin@gmail.com>
 <20260908180555.0830E1F00A3A@smtp.kernel.org>
 <aqBX1siwtKuBTXBE@soda.int.kasm.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqBX1siwtKuBTXBE@soda.int.kasm.eu>
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

On 2026-09-08 20:57:05 +0200, Klara Modin wrote:
> On 2026-09-08 18:05:54 +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Incomplete fix: missing `handle_free` field in conditionally compiled `shmem.rs`.
> > --
> > 
> > commit b5b83bb373847c99ca6d286c268d2e0ffab299f0
> > Author: Klara Modin <klarasmodin@gmail.com>
> > 
> > rust/drm/gem: initialize callbacks with ..pin_init::zeroed()
> > 
> > This commit updates the drm_gem_object_funcs struct initialization in the DRM
> > GEM module to use pin_init::zeroed() instead of explicitly assigning None to
> > unused callbacks. This fixes a build failure caused by a newly added callback
> > field in the C structure.
> > 
> > Closes: https://lore.kernel.org/all/aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info
> > 
> > > diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> > > index e1ebad77ebe2a..c63b0fe5a15e1 100644
> > > --- a/rust/kernel/drm/gem/mod.rs
> > > +++ b/rust/kernel/drm/gem/mod.rs
> > > @@ -266,18 +266,8 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
> > >          free: Some(Self::free_callback),
> > >          open: Some(open_callback::<T>),
> > >          close: Some(close_callback::<T>),
> > > -        print_info: None,
> > > -        export: None,
> > > -        pin: None,
> > > -        unpin: None,
> > > -        get_sg_table: None,
> > > -        vmap: None,
> > > -        vunmap: None,
> > > -        mmap: None,
> > > -        status: None,
> > >          vm_ops: core::ptr::null_mut(),
> > > -        evict: None,
> > > -        rss: None,
> > > +        ..pin_init::zeroed()
> > >      };
> > 
> > [Severity: Medium]-
> > Does this commit miss a similar update in rust/kernel/drm/gem/shmem.rs?
> > 
> > The VTABLE initialization in shmem.rs explicitly lists fields without
> > using pin_init::zeroed(), similar to what was fixed here. When compiling
> > with CONFIG_RUST_DRM_GEM_SHMEM_HELPER=y, won't this cause a missing
> > field error for the newly added handle_free callback?
> 
> Sure, but it should probably be a different patch in that case. The
> current patch fixes an issue to a currently existing build failure,
> while the issue mentioned here has not manifested yet.

On second thought, this is seems to be using the same binding so this
might be accurate.

> 
> Regards,
> Klara Modin
> 
> > 
> > rust/kernel/drm/gem/shmem.rs:
> >     const VTABLE: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
> >         free: Some(Self::free_callback),
> >         open: Some(super::open_callback::<T>),
> >         close: Some(super::close_callback::<T>),
> >         print_info: Some(bindings::drm_gem_shmem_object_print_info),
> >         export: None,
> >         pin: Some(bindings::drm_gem_shmem_object_pin),
> >         unpin: Some(bindings::drm_gem_shmem_object_unpin),
> >         get_sg_table: Some(bindings::drm_gem_shmem_object_get_sg_table),
> >         vmap: Some(bindings::drm_gem_shmem_object_vmap),
> >         vunmap: Some(bindings::drm_gem_shmem_object_vunmap),
> >         mmap: Some(bindings::drm_gem_shmem_object_mmap),
> >         status: None,
> >         rss: None,
> >         #[allow(unused_unsafe, reason = "Safe since Rust 1.82.0")]
> >         // SAFETY: drm_gem_shmem_vm_ops is a valid, static const on the C side.
> >         vm_ops: unsafe { &raw const bindings::drm_gem_shmem_vm_ops },
> >         evict: None,
> >     };
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260908175427.47207-1-klarasmodin@gmail.com?part=1
