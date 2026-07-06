Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E54C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74F3110EA2C;
	Mon,  6 Jul 2026 17:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M4ffZg7a";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8274810EA29
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 17:56:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A237600AE;
 Mon,  6 Jul 2026 17:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E351F00A3A;
 Mon,  6 Jul 2026 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783360588;
 bh=3Y+/Y5CwYs10KXLLxmpqapZy45ZNjQ90GHLjO/6w3rs=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=M4ffZg7awdC4io/+Ja+LjKF3KJudAwJL4q0LmJjxDLAFMS4moSWt8Qbkx52fvPxoS
 gkqa3WZj62/6hgU596qKNI8H2a+Dk7hYUBvOZfhgbDI0LlPkNOcKuXhidu4oM9nhby
 ev8mWwDmzhYpiPMcNIhPnuS4KIg39vGAEJFgf+NuN74dseIguALVBrLdh0D/qgq3Mf
 +pkyX1K/SmlbFoIBKP8VcUSGMmJWL9QLQLqjX8N0l4fVSt7V9DkOGEpP9Ka7VsIg0a
 EB/8/2VgNvdAL+wJi8T9IDsHoqIg4dRQlfFcweUvWzvgyvB3sft/0/R2c53zu0/pv0
 fPoH0Cr0uV57A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 19:56:24 +0200
Message-Id: <DJROKEFANC4J.1RLIKVEMS878W@kernel.org>
Subject: Re: [PATCH 1/4] gpu: nova-core: Add public driver API to nova-core
Cc: <nova-gpu@lists.linux.dev>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260706053413.154135-1-apopple@nvidia.com>
 <20260706053413.154135-2-apopple@nvidia.com>
In-Reply-To: <20260706053413.154135-2-apopple@nvidia.com>
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

On Mon Jul 6, 2026 at 7:34 AM CEST, Alistair Popple wrote:
> @@ -86,15 +90,34 @@ fn probe<'bound>(
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
> +                        NovaCoreApi {
> +                            // TODO: Use `&gpu` self-referential pin-ini=
t syntax once available.
> +                            //
> +                            // SAFETY: `gpu` is initialized before this =
expression is evaluated
> +                            // (`try_pin_init!()` initializes fields in =
declaration order), lives at
> +                            // a pinned stable address, and is dropped a=
fter `_reg` (struct field
> +                            // drop order).
> +                            gpu: Pin::new_unchecked(
> +                                &*core::ptr::from_ref(gpu.as_ref().get_r=
ef()),
> +                            ),

Hm...it's a bit messy to have this justified in two separate places. It wou=
ld be
better to have separate unsafe blocks for this until pin-init solves this
properly. So, let's just do this.

+                _reg: {
+                    // SAFETY: `gpu` is initialized before this expression=
 is evaluated
+                    // (`try_pin_init!()` initializes fields in declaratio=
n order), lives at
+                    // a pinned stable address, and is dropped after `_reg=
` (struct field
+                    // drop order).
+                    let gpu =3D unsafe {
+                        Pin::new_unchecked(
+                            &*core::ptr::from_ref(gpu.as_ref().get_ref()),
+                        )
+                    };
+
+                    // SAFETY: `NovaCore` is dropped when the device is un=
bound; i.e.
+                    // `mem::forget()` is never called on it.
+                    unsafe {
+                        auxiliary::Registration::new_with_lt(
+                            pdev.as_ref(),
+                            c"nova-drm",
+                            // TODO[XARR]: Use XArray or perhaps IDA for p=
roper ID allocation/recycling.
+                            // For now, use a simple atomic counter that n=
ever recycles IDs.
+                            AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
+                            crate::MODULE_NAME,
+                            NovaCoreApi { gpu },
+                        )?
+                    }
                 },
