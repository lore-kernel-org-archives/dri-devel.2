Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9E5C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E2310EF17;
	Wed,  9 Sep 2026 06:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SMIRLe+F";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B17EE10ED51
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 18:57:08 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5b5e18f0439so4748791e87.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788893827; x=1789498627; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dPAv9/DNHgYvkBswgfcYE+/SWcKiJRn1AWqpJM/JUGk=;
 b=SMIRLe+F3r4fG3ILlkjTWaww7qGwzhRc4F4ptLUeLX3S64rTL4Swe2EWSUw19E9RUa
 Du60UQFdO1v2vidV7ho953LCiPZ+p26Y9cur55ct4VxeHuiTZmSXQNe9jZ8hk9JO43lh
 YSN1KE63Qq7FyJhYASrc3FR2FWX0Yenc+yvcsRzDbSuTHjKY+YDt7rosaCuf0yi3x5kb
 kUyqHjP69pEN0OFIZMXvg+WPnVxr6SOpHjVlYJWmnFlZAJAGrsb4mlJR9HwzBMy3azCw
 +uMeElNELFMcgTAoTMQoi7AJuhWgQ+tbI7HPDcZcEa3jOJt80lMIyB7BpGCxTsGpJ+oJ
 B/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788893827; x=1789498627;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dPAv9/DNHgYvkBswgfcYE+/SWcKiJRn1AWqpJM/JUGk=;
 b=suvppJLjY+5hYLgySHzbaHuI6VJkaIEbPdAUrtohbK2fEp8EpK8SakXMZk72E5Fxlt
 2JDjJ8J7uqkjZdRwOSzXTqd9pZWsVhb11PEwm0PREEnu9qOaBMurmnjuXPUtNpPWlAks
 s7gwyTUrsqg4vBUEjjTIjmBYx0lvlobaH5+LoiyoPxtGuOYvBA/ko5cvAjyYksEPtK64
 4ClWDTNMip0Gb8CuFsjIKATrxKgFW93fqInbyuw7eUmJTHai4Dgu9p7oGPh1A2zgx9l3
 8Yns7gjHngr2I+RyOjOfbpsmZclhCN0+XydvqDuJEKiMAE+Pp8PtVZmMyrcqH7e9UFl4
 5Xbg==
X-Gm-Message-State: AFuF++l9yKbq9XaHHJnMoPS28AID9yDEISXcWcqKDCWLgIs+75qXomEM
 DYYuYf/P1NIhbDbS37rFepZ3X/5prY6n0hvZk+ONoLs6c02dhOiCR+f4
X-Gm-Gg: AYBFou1ahkDgGf1MatSkid99kQdMVV+MkHsqJuKLBOsE1OYm24PH++ZomAEKPZlFmLb
 h1VzuPMIL74JptlqZV907DL+vhdNDBvkXJ/QamUziUMRUjUe6Z1SHLDnZ8V4vCG3tU09gHP+xB4
 FejkrNiAXnWt6+IB0Ck/pZ/SqsranWXfu+XtPiv7WOYEeNN8VDfHmkbK27/X1M5vXLGYyoUCcof
 N7mwyRBhPNzARAdIypfFK5Gko8T/dMpilpIwuqt5L/noFs3H9HjvHsNwjTZsYdLz2hCeQa36VqY
 AChYjGhrK6MtY/zNbbaEQ4hZwwd+gyOB4KsxvrtllXoYRRKmmNUqZBAvXX3IcJ3gInSNqju2hC7
 Sxi2UnZHaWTiPA7Xcku0hkw3nNAaGCZ+qMhVdIFXgtJlrzkPa8y55prcrJr9Mj4ZBTQGIB80h/u
 /eRzPM7EZm4TtUxs/O52c8NBVKO0LIKyYIa9b8RWcV5AUnpjaCSt68qDnVHoTJWYOfbV3IVc6E4
 ZSuUQNyn9tetw==
X-Received: by 2002:a05:6512:ac2:b0:5b6:4b2:de82 with SMTP id
 2adb3069b0e04-5b6170596d8mr4800979e87.32.1788893826465; 
 Tue, 08 Sep 2026 11:57:06 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu.
 [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166fe6d9sm3239335e87.56.2026.09.08.11.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:57:06 -0700 (PDT)
Date: Tue, 8 Sep 2026 20:57:05 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, 
 rust-for-linux@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust/drm/gem: initialize callbacks with
 ..pin_init::zeroed()
Message-ID: <aqBX1siwtKuBTXBE@soda.int.kasm.eu>
References: <20260908175427.47207-1-klarasmodin@gmail.com>
 <20260908180555.0830E1F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908180555.0830E1F00A3A@smtp.kernel.org>
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

On 2026-09-08 18:05:54 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incomplete fix: missing `handle_free` field in conditionally compiled `shmem.rs`.
> --
> 
> commit b5b83bb373847c99ca6d286c268d2e0ffab299f0
> Author: Klara Modin <klarasmodin@gmail.com>
> 
> rust/drm/gem: initialize callbacks with ..pin_init::zeroed()
> 
> This commit updates the drm_gem_object_funcs struct initialization in the DRM
> GEM module to use pin_init::zeroed() instead of explicitly assigning None to
> unused callbacks. This fixes a build failure caused by a newly added callback
> field in the C structure.
> 
> Closes: https://lore.kernel.org/all/aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info
> 
> > diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> > index e1ebad77ebe2a..c63b0fe5a15e1 100644
> > --- a/rust/kernel/drm/gem/mod.rs
> > +++ b/rust/kernel/drm/gem/mod.rs
> > @@ -266,18 +266,8 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
> >          free: Some(Self::free_callback),
> >          open: Some(open_callback::<T>),
> >          close: Some(close_callback::<T>),
> > -        print_info: None,
> > -        export: None,
> > -        pin: None,
> > -        unpin: None,
> > -        get_sg_table: None,
> > -        vmap: None,
> > -        vunmap: None,
> > -        mmap: None,
> > -        status: None,
> >          vm_ops: core::ptr::null_mut(),
> > -        evict: None,
> > -        rss: None,
> > +        ..pin_init::zeroed()
> >      };
> 
> [Severity: Medium]-
> Does this commit miss a similar update in rust/kernel/drm/gem/shmem.rs?
> 
> The VTABLE initialization in shmem.rs explicitly lists fields without
> using pin_init::zeroed(), similar to what was fixed here. When compiling
> with CONFIG_RUST_DRM_GEM_SHMEM_HELPER=y, won't this cause a missing
> field error for the newly added handle_free callback?

Sure, but it should probably be a different patch in that case. The
current patch fixes an issue to a currently existing build failure,
while the issue mentioned here has not manifested yet.

Regards,
Klara Modin

> 
> rust/kernel/drm/gem/shmem.rs:
>     const VTABLE: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
>         free: Some(Self::free_callback),
>         open: Some(super::open_callback::<T>),
>         close: Some(super::close_callback::<T>),
>         print_info: Some(bindings::drm_gem_shmem_object_print_info),
>         export: None,
>         pin: Some(bindings::drm_gem_shmem_object_pin),
>         unpin: Some(bindings::drm_gem_shmem_object_unpin),
>         get_sg_table: Some(bindings::drm_gem_shmem_object_get_sg_table),
>         vmap: Some(bindings::drm_gem_shmem_object_vmap),
>         vunmap: Some(bindings::drm_gem_shmem_object_vunmap),
>         mmap: Some(bindings::drm_gem_shmem_object_mmap),
>         status: None,
>         rss: None,
>         #[allow(unused_unsafe, reason = "Safe since Rust 1.82.0")]
>         // SAFETY: drm_gem_shmem_vm_ops is a valid, static const on the C side.
>         vm_ops: unsafe { &raw const bindings::drm_gem_shmem_vm_ops },
>         evict: None,
>     };
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260908175427.47207-1-klarasmodin@gmail.com?part=1
