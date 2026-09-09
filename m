Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79827C88E40
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8360A10F1DE;
	Wed,  9 Sep 2026 15:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bh/6liQj";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B1310F1DD
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 15:57:51 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39d67a9ae5bso86758a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 08:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788969471; cv=none;
 d=google.com; s=arc-20260327;
 b=KShgyw2l5c5Ki3KVrt4XxTnWXKR1b3HIpEh+ajq6BGaDsloFV0cXagVXEw5kcz5bAa
 MkLgng2YRyU/uAhGG0AOLNZZGqRu/uiBkEoTtuR7pqEWmkxeqXlgVTgOOo0ZWgPYrsFu
 2veAAqIjJLc5LA+8EDLm0SR4ZQwj7QXBtsjv7gNzJk6AOgYBmgZHgka7u+ydkfjguhM+
 wFvbXcYhF2JDijOtnIDlD+uDd+9/I1HwFh7C/z3DVaSKoVvCydg5sSinzhPrAJSLvIFo
 nS8aLcltesN3TWrWHbEZONI8VoAbE8COgW5cBeFUiZFU2STr41jEaHdyjNPqonU2jBaJ
 zyvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0v9v/l61LJDXvYLeJKA3EU6R7TFlt+aBLu3xlyi9va8=;
 fh=soI/ZPgZnVdrvf6oamwlyJdLstSublmc4Nv9fiTjSIA=;
 b=fAdFS3bYMXQqbVy1aF115wCakjkK+6j2qO1KI6A91kuLNnStSe8PVun8uEYN4UgNcv
 /zcjDF7znk5n1Th+c/9mc3kmmfa4FZpAyF5wrmiTxjyK8QFDvKlLnFVa5Tvmp67pancU
 Sw+TawhAQIJ6nTEmt9m6glK99y920MAf1HjRSObxQ1TpMzO/srsKTdpip0HpchSsWE/B
 6RO+FIA73xBUhozqVLyRFjlgvSEp5kJ+QfngcY0TQ9VDaaPiseqlzdula8U0WfJSnB5I
 20N1jUTehw1SyuzhqcbUV1GHFX2I5VUQJgBO7vKUvcaV8pg9izx5WBpuAcLo2fv8mjZr
 WPmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788969471; x=1789574271; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0v9v/l61LJDXvYLeJKA3EU6R7TFlt+aBLu3xlyi9va8=;
 b=Bh/6liQjP6e2MkGCks1A1daQf6nnd/tv2oSLs5C1Jk8leCywFmjus5QFJrcy7Ney96
 r/Q0D5wogduE7Deyox/dBsANcGTsAZKs0BNzq1P8yVQzlJgjpjG0teZ56W4YUVP5ufk6
 c1TKJEixKDCwmvgEjDDUZDbiOlZcQ+CpB0HttwxDpsHoNhEq4t25B8ay3wDyKX5Y84hW
 1LuAvskZ/ysErmcOKMx0hW0rnhbM27zyHWCP89Tiwj+PsY+tiGTV5Kc0xkcUyyKVzRFc
 4H2pkAllvr5hJYeNXo5/mI5VKjGSQOxKEjsYmBfuemqeyRgfCe+rBIV7t3vddZZPCTXW
 fSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969471; x=1789574271;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0v9v/l61LJDXvYLeJKA3EU6R7TFlt+aBLu3xlyi9va8=;
 b=F75A/J4IikwCMlUndnXERzVudwrELAt1lU/PPAh/iLXuHS7JIzg5IrZcVRKOJCl1CT
 6Q0/jS1jHsp22FCws85LhtpJF72/tAltmgNRz14I8WgAJBm11NgB481JOFPV5/45Fz8O
 tvTV+wR0YYl8rK1dKaPtJr7Uj+fVRs0tAQFKZAMTaFu3gsuxPxaR91vMOaLLfBW1QW5X
 Ksu6F8Ue6CVFbkbb5Vjq+iD27tRSW94KoNo7NR4rVyE0djJVNIWKU39xxNS+jkUahOG+
 AzY8RUGctjiZsK+DNF2XJKP6bV0TCEAcBZN+Ou2A8+I76pUCT03jkLS1jTL2HLgc+b2z
 9reg==
X-Gm-Message-State: AFuF++m3m7rbjkMmcEzR29RDLJWxXV0pOv+fjQHgpEwcYB53Dfx58g4W
 2NM2RbLWpemdP5jW8dLM9pMfTqsu68OPJ9tWp1cUKI+ovZAmsDwlv5H91GroNtU8GksZgfgsrnZ
 lcazs5pS9dHeYPu6cIdzHvrLZnYkKhwc=
X-Gm-Gg: AYBFou0aQvLsmhd+C9PW+FUfvY5HyTEv/vsbMDxaQfUAAJWixLAar487rrEr4U8/zOA
 jeCFRq/1Dt7RU41yn5HvqJ1hiS/AMsbNCC6rtWHuox4CxA/viKRQK/FZCpIgyjaiRzXso3BnFO5
 V/mrrEvWSS2qcfGRODYp5Ve05VZ9TlSr0ZrWIe7zAuA/2oYOIvsIg8APhem3Z5iC0erePlYNc4X
 PQWmkwzYwpAsjRMqrScsaxLORurYbPLSdxlv3J8MJhCG5197ZyG7XqvDx8GGl+tOt3mfbdmwdX4
 nno+MOlUJkVPmsI01G+5pSZCBIAAa1CS3yKvUN1mU1NXT3G/M9/szOSAyzLgT1LE4LaiXbgVHiN
 P4ihLMAIL06yIbbsZGTUdE2o66rCp4JJdstxQLkxzoKV4SbD8zVKD
X-Received: by 2002:a17:90b:2251:b0:398:bac0:238d with SMTP id
 98e67ed59e1d1-39b3d7fc6a1mr28548919a91.5.1788969470558; Wed, 09 Sep 2026
 08:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260909094729.1593-1-mike@fireburn.co.uk>
In-Reply-To: <20260909094729.1593-1-mike@fireburn.co.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Sep 2026 11:57:37 -0400
X-Gm-Features: AcwNN1V2tAyfr-GYaZ5JcK9f7LxBdPRCMCy96FW7mYbvwWHGJtRYNOXLOtAWttM
Message-ID: <CADnq5_Mf5mQ4CF=8UTnEjYPGVUS-Hf29sHmesvtwdfnNxtrQMA@mail.gmail.com>
Subject: Re: [PATCH] rust: drm: gem: add missing handle_free to the object
 vtables
To: Mike Lothian <mike@fireburn.co.uk>, Klara Modin <klarasmodin@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thorsten Leemhuis <linux@leemhuis.info>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com, 
 alexander.deucher@amd.com, mukul.joshi@amd.com, 
 rust-for-linux@vger.kernel.org, amd-gfx@lists.freedesktop.org
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

Adding a few people.  Alternative patch at:
https://lists.freedesktop.org/archives/amd-gfx/2026-September/152673.html

Alex

On Wed, Sep 9, 2026 at 5:47=E2=80=AFAM Mike Lothian <mike@fireburn.co.uk> w=
rote:
>
> Both OBJECT_FUNCS and the shmem VTABLE initialise every member of
> drm_gem_object_funcs explicitly, so adding a field to the C struct
> breaks the Rust build:
>
>   error[E0063]: missing field `handle_free` in initializer of
>   `drm_gem_object_funcs`
>
> The callback is optional and the Rust abstraction has no equivalent
> DriverObject method, so leave it unset.
>
> The shmem copy is only built with CONFIG_RUST_DRM_GEM_SHMEM_HELPER,
> which DRM_TYR selects.
>
> Fixes: b67d2d039f64 ("drm/gem: Add callback for when handle count goes to=
 0")
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> Assisted-by: Claude:Opus-5 [Claude Code]
> ---
>
> b67d2d039f64 is only in agd5f/drm-next, so this can be squashed into it
> instead if you would rather keep that branch bisectable.
>
> The shmem hunk is by inspection - CONFIG_RUST_DRM_GEM_SHMEM_HELPER is
> not set in my config, so only the mod.rs copy is compile-tested.
>
>  rust/kernel/drm/gem/mod.rs   | 1 +
>  rust/kernel/drm/gem/shmem.rs | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 80d8f524f9d5..ae61ca7e1246 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -278,6 +278,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, C=
tx> {
>          vm_ops: core::ptr::null_mut(),
>          evict: None,
>          rss: None,
> +        handle_free: None,
>      };
>
>      /// Returns the `Device` that owns this GEM object.
> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index a687d46d170d..d08a03cb7a13 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -145,6 +145,7 @@ impl<T: DriverObject> Object<T> {
>          // SAFETY: `drm_gem_shmem_vm_ops` is a valid, static const on th=
e C side.
>          vm_ops: unsafe { &raw const bindings::drm_gem_shmem_vm_ops },
>          evict: None,
> +        handle_free: None,
>      };
>
>      /// Return a raw pointer to the embedded drm_gem_shmem_object.
> --
> 2.55.0
>
