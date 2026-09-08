Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABF8C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A8E10EF0C;
	Wed,  9 Sep 2026 06:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oD4sGvza";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90EC10E165
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 19:25:49 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f1e022so563692e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788895548; x=1789500348; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qs8C9B+WUBDgq8aRTUIEYiHOvCr2S97eqgKrz0PamYA=;
 b=oD4sGvza9eCXWfTJvkdhoRXuLEWhsCZki4fzAVmGzAO1EqnZWgH93PYJwfwKsySNVW
 acGHb8HZuejVwwsmHRoVeGN1/V9brWhSwAlP63cSKS0N2mLtIbN3yCJ+q0x7jeCHKeb3
 lqBTQjVSECQWem7rdQYAzjmKSuZ9CFJ1KA7xC7QxNCLZ7zMaiPtvf7S1/bgoaSeO/NbW
 qNBqhbfZx1irRgOjv+dgxE7cClmB+HKc5/xVNzIg3Z859fSZ38sACegD3e7NMILN66uE
 SGHHVmlC59ycUl10uUWboT5VaXz6djYTQOhqEOaEkSuVPKt2EFVm7oNc3BV79xXFvQOG
 KPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788895548; x=1789500348;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qs8C9B+WUBDgq8aRTUIEYiHOvCr2S97eqgKrz0PamYA=;
 b=ApT/PSMAoMeFKHeaZAV1ksLpD/xO3kcj8lk+tbvl3jDfXO4JbHyeGdJ1Uyice2p7mN
 Xv/c9O+ysJYqjghhZsyEaE6ACuPPtGulx+DTH+LR/Ew/iV8PrjQFnhPrU0PV8bBNzJdu
 F99eG1ktoQBWjPfzZsWApqk+SnIc16h4ri1uU7cgCLxaVQmtvjOjgl+M+awSYZi1oDmd
 fY6MWl7LBLKIqCTyfJAX6Plbp6VpKhtzUcmLbhyDadZFk8Uuz1wi2Ax+NYUhO5lzJ/Fi
 ZYSyr/QLFkg2VAJPlVUshNe3pAukiKQtgSYjpYRT4QQDQAtpzKA/A55TVRImSbPSGSys
 2jlw==
X-Gm-Message-State: AFuF++lEwCO7/wfE/rhVHXXiqKtTxiJMmbNLcY+MeGtpwtaUg196Cz1e
 fTPiG4Ixc+z04ksk3MBVgHdUYgZtbt+N0x7Qs5V7+q/gKtsglwFQ/UT8
X-Gm-Gg: AYBFou08JlDj4fLCu9ufrI6yO/qub37QtbsL829/yxekwQvOsW/tXAAsAhSPFXhhZdZ
 eWkFSD8XdHhHZ6ssHW/qJAF2eNYMPlbGE11h1lpWE38DXtLJAd5VRHKQVVjaP6K5eUtIXK3fdfY
 u2pIW9PD3SMzoYvWIOzNg8/grX/na2HdnycfSNFC4r91GeX6ck8HfeQcJheIfvZePpDyTuhs9rZ
 agjU3LKtfvQWXsg8lMU0Es7C0DoGyn1iNGgV/69aNQqYX26UqgMisWIls7BNADbKBiT/7P/Vrvi
 EaFOVaymMh13tbdWgpAFmvHFvvA4M/4BRZQ/S2x0My6G6N7R+xZt39zH40+hOMwrtPJaWd4RJve
 gwkhtXjUjEMjdvoHvPv2B/czdq1rOZCFXqHuBvhbgv3gbyICT9FT+QHPGyfUYNKJwFR1NAT/5c8
 3P/XTbIev4gT7DGGVI7pznDvCtiHojF0XkicgTgmVSUj2L3lysxE6uQWC8HHa1VaGPKUcYv7M5N
 Kw=
X-Received: by 2002:a05:6512:3b96:b0:5b6:10bc:b867 with SMTP id
 2adb3069b0e04-5b75c926908mr1490072e87.21.1788895547733; 
 Tue, 08 Sep 2026 12:25:47 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu.
 [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166f6ca3sm3289156e87.32.2026.09.08.12.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 12:25:47 -0700 (PDT)
Date: Tue, 8 Sep 2026 21:25:46 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, 
 rust-for-linux@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alice Ryhl <aliceryhl@google.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Thorsten Leemhuis <linux@leemhuis.info>, 
 Manuel Ebner <manuelebner@mailbox.org>, Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH] rust/drm/gem: initialize callbacks with
 ..pin_init::zeroed()
Message-ID: <aqBf1UYNR-Q3T-cs@soda.int.kasm.eu>
References: <20260908175427.47207-1-klarasmodin@gmail.com>
 <20260908180555.0830E1F00A3A@smtp.kernel.org>
 <aqBX1siwtKuBTXBE@soda.int.kasm.eu>
 <aqBdJY43QlnN5wnx@soda.int.kasm.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqBdJY43QlnN5wnx@soda.int.kasm.eu>
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

On 2026-09-08 21:09:40 +0200, Klara Modin wrote:
> On 2026-09-08 20:57:05 +0200, Klara Modin wrote:
> > On 2026-09-08 18:05:54 +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [Medium] Incomplete fix: missing `handle_free` field in conditionally compiled `shmem.rs`.
> > > --
> > > 
> > > commit b5b83bb373847c99ca6d286c268d2e0ffab299f0
> > > Author: Klara Modin <klarasmodin@gmail.com>
> > > 
> > > rust/drm/gem: initialize callbacks with ..pin_init::zeroed()
> > > 
> > > This commit updates the drm_gem_object_funcs struct initialization in the DRM
> > > GEM module to use pin_init::zeroed() instead of explicitly assigning None to
> > > unused callbacks. This fixes a build failure caused by a newly added callback
> > > field in the C structure.
> > > 
> > > Closes: https://lore.kernel.org/all/aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info
> > > 
> > > > diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> > > > index e1ebad77ebe2a..c63b0fe5a15e1 100644
> > > > --- a/rust/kernel/drm/gem/mod.rs
> > > > +++ b/rust/kernel/drm/gem/mod.rs
> > > > @@ -266,18 +266,8 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
> > > >          free: Some(Self::free_callback),
> > > >          open: Some(open_callback::<T>),
> > > >          close: Some(close_callback::<T>),
> > > > -        print_info: None,
> > > > -        export: None,
> > > > -        pin: None,
> > > > -        unpin: None,
> > > > -        get_sg_table: None,
> > > > -        vmap: None,
> > > > -        vunmap: None,
> > > > -        mmap: None,
> > > > -        status: None,
> > > >          vm_ops: core::ptr::null_mut(),
> > > > -        evict: None,
> > > > -        rss: None,
> > > > +        ..pin_init::zeroed()
> > > >      };
> > > 
> > > [Severity: Medium]-
> > > Does this commit miss a similar update in rust/kernel/drm/gem/shmem.rs?
> > > 
> > > The VTABLE initialization in shmem.rs explicitly lists fields without
> > > using pin_init::zeroed(), similar to what was fixed here. When compiling
> > > with CONFIG_RUST_DRM_GEM_SHMEM_HELPER=y, won't this cause a missing
> > > field error for the newly added handle_free callback?
> > 
> > Sure, but it should probably be a different patch in that case. The
> > current patch fixes an issue to a currently existing build failure,
> > while the issue mentioned here has not manifested yet.
> 
> On second thought, this is seems to be using the same binding so this
> might be accurate.

Confirmed, on an arm64 build with the Tyr driver enabled:

 error[E0063]: missing field `handle_free` in initializer of `drm_gem_object_funcs`
    --> /home/klara/git/linux/trees/next-local/rust/kernel/drm/gem/shmem.rs:130:52
     |
 130 |     const VTABLE: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
     |                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `handle_free`
 
 error: aborting due to 1 previous error
 
 For more information about this error, try `rustc --explain E0063`.

I'll wait a while for other thoughts and otherwise respin with this
included.

> 
> > 
> > Regards,
> > Klara Modin
> > 
> > > 
> > > rust/kernel/drm/gem/shmem.rs:
> > >     const VTABLE: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
> > >         free: Some(Self::free_callback),
> > >         open: Some(super::open_callback::<T>),
> > >         close: Some(super::close_callback::<T>),
> > >         print_info: Some(bindings::drm_gem_shmem_object_print_info),
> > >         export: None,
> > >         pin: Some(bindings::drm_gem_shmem_object_pin),
> > >         unpin: Some(bindings::drm_gem_shmem_object_unpin),
> > >         get_sg_table: Some(bindings::drm_gem_shmem_object_get_sg_table),
> > >         vmap: Some(bindings::drm_gem_shmem_object_vmap),
> > >         vunmap: Some(bindings::drm_gem_shmem_object_vunmap),
> > >         mmap: Some(bindings::drm_gem_shmem_object_mmap),
> > >         status: None,
> > >         rss: None,
> > >         #[allow(unused_unsafe, reason = "Safe since Rust 1.82.0")]
> > >         // SAFETY: drm_gem_shmem_vm_ops is a valid, static const on the C side.
> > >         vm_ops: unsafe { &raw const bindings::drm_gem_shmem_vm_ops },
> > >         evict: None,
> > >     };
> > > 
> > > -- 
> > > Sashiko AI review · https://sashiko.dev/#/patchset/20260908175427.47207-1-klarasmodin@gmail.com?part=1
