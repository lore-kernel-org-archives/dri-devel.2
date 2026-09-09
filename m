Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35221C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E7610F41A;
	Thu, 10 Sep 2026 10:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PSSdoryc";
	dkim-atps=neutral
Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com
 [74.125.230.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE58910E583
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:45:15 +0000 (UTC)
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a30521edd8so8808871fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788975914; x=1789580714; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZFJ8LJvBoSFpLXLWJCrf1H0OwBPOca5szWV2v59OKPs=;
 b=PSSdorycJR9/t0YpIXurj2tYwV4N7hyA2FuG3zOFR6+PT1t9m+xhHOJy4EclqMOJ24
 2rGDH8RZfRej2wSN/AnRMnWT9h6EBNH/XsNI3C6qIlKqFX11TPOXyojlxn9lX75grqqZ
 Y/+GcqFCpyBGdihCzYoJyppOwDOp5s+TTxRPXg6dVMLjFihTS5SSWM/yzg+N1Wt7W3Sy
 qy23TOQLw6ChOZvCBY+nuku0l+xqDd0p6ClEAH23ql0MzzKggpDs402m6VQMYj+iDUGQ
 /F4VfkWjryEKlsWoofUWdLCgteRj4osM1GTBIQUh8ruAWGzxH+cUbcHXYklxSxLl8c5U
 d1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788975914; x=1789580714;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZFJ8LJvBoSFpLXLWJCrf1H0OwBPOca5szWV2v59OKPs=;
 b=MWWmlo+FyW4CQ4SDKr3fHZEiQpmKenj9YqVHlzwGtbgDC65TWNOB10Fmoyma/b5ryb
 GldDIy9K23cHLBeF7+eB0vBLt1qpM2BQbSdXUQXg1fC99oBYf4xqSTgMEbdrjIWuzF0W
 d0bmYZYStQPN7ZKPFXTrCXiPEkCr7sKaPacmRS1gwzS31Qq34/ZvA7jkyNKu52GmDguv
 9dJm4XJPGPGksz6pbV8rvGL2Kjy3oHCmXd5uXvIjz7bLwPJ/AXaO1Aw5PVa9Tl67zCK7
 kkeJ0wPeXXyEd/TxOKJzHnb098/X0+L1xO5X2wPu+Y9ZNmuxdbkcmPSQlxFrXG23KK/Y
 aPKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiGeGWYO+SrCSeMaf6l3hSle37sAeMU/+5m6MDUuRMdMuQ+HihnpU8xkxSmWzL8nFGjydQWe3yw2k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mse2LEKs/rr5du2QU83LF33fVfpEV/TKgSyVmKbE7DQr4q/vMA
 pIQwgK6k9JV3pNGnDhbT2itpYqgYmlaU2hA/7uSsJ2vYEonaQm7iupaQ
X-Gm-Gg: AYBFou2eQqx6INbKnhOuXIaJwPCjLN8c+10wfmKCxUDj6wprdOwTfOVMW9H6Z/JTmuZ
 Qi4R+4k8NJpU9zKhyHrM0n6TSDWUkK7i8GmEtdI/kKK0Z6QqiVkShIx2o85Vlui+hjwZZzypSAo
 TJp30gayIPb8+0jQBNiFkoC0QHG4RkJZNZFH2JhTVg5oBkwfSbakF3aEOfD/P021dZ4XvdfeBKj
 4LXbo8aOmo0takeKg+VHIsq7WT5m+4AwRT86y60vFSHDX1KaI/eHmbKO3woP0pAikYvHYnnc4Si
 O/CMdC0Tfk84sJPpVTYgSRw6yyuIfVvJku+ihI2QnPGQPQp+eaRUuuAt9qqs5UWpob/yDSAfrca
 IdfUL8LqpHYv+15Xicao20XiLXUYAjQidoP7woEX+2zF0/9hPSba9kF4dCKOqra7jl/ES8t8LMJ
 6aLJainz/vTYXb2V66q9jjiJY+rFxdymaIPyk2io0Pw5hAK08CAiCfUDXMrVcToyonumQpnW4eL
 /EVx9RMlVEnEQ==
X-Received: by 2002:a05:6512:1590:b0:5b4:ac27:8f76 with SMTP id
 2adb3069b0e04-5b89a2fb651mr67482e87.7.1788975913434; 
 Wed, 09 Sep 2026 10:45:13 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu.
 [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166ecf24sm4071183e87.16.2026.09.09.10.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 10:45:13 -0700 (PDT)
Date: Wed, 9 Sep 2026 19:45:12 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Alex Deucher <alexdeucher@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thorsten Leemhuis <linux@leemhuis.info>, 
 Gary Guo <gary@garyguo.net>, dri-devel@lists.freedesktop.org, dakr@kernel.org, 
 aliceryhl@google.com, alexander.deucher@amd.com, mukul.joshi@amd.com, 
 rust-for-linux@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] rust: drm: gem: add missing handle_free to the object
 vtables
Message-ID: <aqGaa4sEAvIIOLjK@soda.int.kasm.eu>
References: <20260909094729.1593-1-mike@fireburn.co.uk>
 <CADnq5_Mf5mQ4CF=8UTnEjYPGVUS-Hf29sHmesvtwdfnNxtrQMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Mf5mQ4CF=8UTnEjYPGVUS-Hf29sHmesvtwdfnNxtrQMA@mail.gmail.com>
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

On 2026-09-09 11:57:37 -0400, Alex Deucher wrote:
> Adding a few people.  Alternative patch at:
> https://lists.freedesktop.org/archives/amd-gfx/2026-September/152673.html
> 
> Alex
> 
> On Wed, Sep 9, 2026 at 5:47 AM Mike Lothian <mike@fireburn.co.uk> wrote:
> >
> > Both OBJECT_FUNCS and the shmem VTABLE initialise every member of
> > drm_gem_object_funcs explicitly, so adding a field to the C struct
> > breaks the Rust build:
> >
> >   error[E0063]: missing field `handle_free` in initializer of
> >   `drm_gem_object_funcs`
> >
> > The callback is optional and the Rust abstraction has no equivalent
> > DriverObject method, so leave it unset.
> >
> > The shmem copy is only built with CONFIG_RUST_DRM_GEM_SHMEM_HELPER,
> > which DRM_TYR selects.

Sorry, I missed you when sending my v2. It's at
https://lore.kernel.org/lkml/20260909173103.73656-1-klarasmodin@gmail.com/T/#u
if you want to have a look.

Regards,
Klara Modin

> >
> > Fixes: b67d2d039f64 ("drm/gem: Add callback for when handle count goes to 0")
> > Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> > Assisted-by: Claude:Opus-5 [Claude Code]
> > ---
> >
> > b67d2d039f64 is only in agd5f/drm-next, so this can be squashed into it
> > instead if you would rather keep that branch bisectable.
> >
> > The shmem hunk is by inspection - CONFIG_RUST_DRM_GEM_SHMEM_HELPER is
> > not set in my config, so only the mod.rs copy is compile-tested.
> >
> >  rust/kernel/drm/gem/mod.rs   | 1 +
> >  rust/kernel/drm/gem/shmem.rs | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> > index 80d8f524f9d5..ae61ca7e1246 100644
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
> > diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> > index a687d46d170d..d08a03cb7a13 100644
> > --- a/rust/kernel/drm/gem/shmem.rs
> > +++ b/rust/kernel/drm/gem/shmem.rs
> > @@ -145,6 +145,7 @@ impl<T: DriverObject> Object<T> {
> >          // SAFETY: `drm_gem_shmem_vm_ops` is a valid, static const on the C side.
> >          vm_ops: unsafe { &raw const bindings::drm_gem_shmem_vm_ops },
> >          evict: None,
> > +        handle_free: None,
> >      };
> >
> >      /// Return a raw pointer to the embedded drm_gem_shmem_object.
> > --
> > 2.55.0
> >
