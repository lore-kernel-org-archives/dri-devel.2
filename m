Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CBBC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 13:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35A189A60;
	Sun,  5 Jul 2026 13:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NjeA4CqQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC53589A60
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 13:00:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DBA7960008;
 Sun,  5 Jul 2026 13:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4589F1F000E9;
 Sun,  5 Jul 2026 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783256431;
 bh=Jutbyyrw/SBMWGHBk/O6fdtwki4002XeR8UqjVv5bMo=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=NjeA4CqQ5CBJRRawXBJ06mx/kDAjFdQEZRwhNd0Evj4Dinvao15JMMwk99HPAxU8W
 Y+ZB0LFEvZnKiwLP8lh0gDDCmjchESiotWQMYnAg6wSIXYmtDqrLh7ip6YY7hgxEQg
 msW9da4rwTjq0RSdwIEjciyeXPfZw8UZueSOdXzBFYgBzdJSHJJzU4ezB8vAqvNZUF
 tAUmcZ1mfP++mnNBG1/9GQ7SsoWc/Y4GzwNB9sTGrovXADxBgR65CP0VdX8KXIG0tm
 q0og/KPkei8e8Wmjfru2Ss2toL3KoReCYmXn8iuH+PGDyhFCMxIySoUixdvfdA2i49
 FHYPm43N8RLdQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 15:00:27 +0200
Message-Id: <DJQNN9FRZN3C.3DQE4H9HAZ8W6@kernel.org>
Subject: Re: [RFC 1/3] gpu: nova-core: Add auxiliary bus registration data
 to nova-core
Cc: <nova-gpu@lists.linux.dev>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260703064526.3630668-1-apopple@nvidia.com>
 <20260703064526.3630668-2-apopple@nvidia.com>
In-Reply-To: <20260703064526.3630668-2-apopple@nvidia.com>
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

On Fri Jul 3, 2026 at 8:45 AM CEST, Alistair Popple wrote:
> diff --git a/drivers/gpu/nova-core/auxdata.rs b/drivers/gpu/nova-core/aux=
data.rs
> new file mode 100644
> index 000000000000..266b5ce4ee89
> --- /dev/null
> +++ b/drivers/gpu/nova-core/auxdata.rs

I think it'd just call it something along the lines of api.rs, as this is g=
oing
to be the file where the entry points into nova-core will live.

> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Nova-core auxbus data. Contains all the methods used by the auxbus d=
rivers
> +//! to interact with nova-core.
> +
> +use crate::gpu::Gpu;
> +
> +/// Auxiliary bus registration data. Used by the auxbus drivers to call =
methods on
> +/// the GPU.
> +pub struct AuxData<'bound> {

Since this will also be the data type that will be exposed as an API entry =
point
into nova-core, I'd rather call it e.g. NovaCoreApi.

We should provide an assoicated function NovaCoreApi::of(), which takes an =
&'a
auxiliary::Device<Bound> as argument and returns &'a NovaCoreApi<'a> (at le=
ast
as long as the type remains covariant).

This makes it a bit cleaner since it keeps the type assertion local to a si=
ngle
place and makes it transparent to nova-drm that this also is the
auxiliary::Registration private data of nova-core.

(I'm already working on getting rid of the type ID check, but going through
NovaCoreApi::of() is cleaner regardless.)

> +    pub(crate) _gpu: &'bound Gpu<'bound>,

I'd store this as Pin<&'bound Gpu<'bound>> as it better documents the pinni=
ng
guarantee and allows calling Pin<&Self> methods on Gpu.

> @@ -78,7 +82,7 @@ fn probe<'bound>(
>              pdev.enable_device_mem()?;
>              pdev.set_master();
> =20
> -            Ok(try_pin_init!(NovaCore {
> +            Ok(try_pin_init!(&this in NovaCore {

This change shouldn't be needed.

>                  bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core=
/bar0")?,
>                  // TODO: Use `&bar` self-referential pin-init syntax onc=
e available.
>                  //
> @@ -86,15 +90,32 @@ fn probe<'bound>(
>                  // (`try_pin_init!()` initializes fields in declaration =
order), lives at a pinned
>                  // stable address, and is dropped after `gpu` (struct fi=
eld drop order).
>                  gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar=
) }),
> -                _reg: auxiliary::Registration::new(
> -                    pdev.as_ref(),
> -                    c"nova-drm",
> -                    // TODO[XARR]: Use XArray or perhaps IDA for proper =
ID allocation/recycling. For
> -                    // now, use a simple atomic counter that never recyc=
les IDs.
> -                    AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
> -                    crate::MODULE_NAME,
> -                    (),
> -                )?,
> +
> +                // SAFETY:
> +                // - `NovaCore` is dropped when the device is unbound; i=
.e.
> +                //   `mem::forget()` is never called on it.
> +                // - `gpu` is initialized above, lives at a pinned stabl=
e
> +                //   address, and is dropped after `_reg` (struct field =
drop
> +                //   order).
> +                _reg: unsafe {
> +                    auxiliary::Registration::new_with_lt(
> +                        pdev.as_ref(),
> +                        c"nova-drm",
> +                        // TODO[XARR]: Use XArray or perhaps IDA for pro=
per ID allocation/recycling.
> +                        // For now, use a simple atomic counter that nev=
er recycles IDs.
> +                        AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
> +                        crate::MODULE_NAME,
> +                        AuxData {
> +                            // TODO: Use `&gpu` self-referential pin-ini=
t syntax once available.
> +                            //
> +                            // SAFETY: `this.gpu` is initialized before =
this expression is evaluated
> +                            // (`try_pin_init!()` initializes fields in =
declaration order), lives at
> +                            // a pinned stable address, and is dropped a=
fter `_reg` (struct field
> +                            // drop order).
> +                            _gpu: &*core::ptr::from_ref(&this.as_ref().g=
pu),

This is UB, we can't create a reference from 'this' before it is fully
initialized.

	gpu: &*core::ptr::from_ref(gpu.as_ref().get_ref()),

should work instead and also gets us rid of this entirely. Or rather

	gpu: Pin::new_unchecked(
	    &*core::ptr::from_ref(gpu.as_ref().get_ref()),
	),

if stored as Pin<&'bound Gpu<'bound>>.

> +                        },
> +                    )?
> +                },
>              }))
>          })
>      }
