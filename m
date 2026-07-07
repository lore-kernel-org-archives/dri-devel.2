Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5694C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A74510E49E;
	Tue,  7 Jul 2026 08:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P3NFxCX5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308AC10E49E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 08:30:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D84C618A8;
 Tue,  7 Jul 2026 08:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3AD1F000E9;
 Tue,  7 Jul 2026 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783413032;
 bh=CgjH/8X+ClHCKckwJtqZW4E1Z20nPkOTpKL31UDrbbQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P3NFxCX5jyjuEcrFSzVz9DsIFq3rzcaHbtRvYVNry2+eALXceveh/Kn6P1UamV8Co
 4CqM706Ri2jHiEQsp4QYrYcDCwRT5+JvglyhnI9SrnPIyy1LhRhVckruHBIUlTJhil
 L4M4XxTJWoSryNyRcGXC8K/4k7gzPGU5W6DKSPFc4DJKnSTyODgdZh7GKwtwKSFoYP
 zdcjsEmWDNxhGvK2KPy04meMlyIpviCq6z+ARLMYbZq57juQZhYFZ5hs3EzMvqEj9M
 jcXM1M7Rsm7+rhZI1higv4APBvy2yKUuqSHOesUDh9JZMFzO4ImVssBVDudp9u/5or
 9Pge68YPywoog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/13] gpu: nova-core: gsp: centralize missing unload
 bundle warnings
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-5-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
 <20260707-nova-bootcontext-v5-5-ecad9346387f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:30:31 +0000
Message-Id: <20260707083031.CC3AD1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Diagnostic warnings about a missing unload bundle and the need t=
o reset the GPU are silently dropped if `hal.boot()` fails after a failed u=
nload bundle creation.
--

--- Patch [5]: [PATCH v5 05/13] gpu: nova-core: gsp: centralize missing unl=
oad bundle warnings ---
commit 5c2f2654dd3e426ece23d356efc67204a24f8fc0
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: centralize missing unload bundle warnings

This commit centralizes the warning emitted when the unload bundle cannot
be constructed by moving it from the Tu102-specific boot sequence to the
common Gsp::boot method.

> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index 75054424a9516..430ffc57b1366 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -56,7 +56,15 @@ pub(crate) fn boot(
>          let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::n=
ew(&gsp_fw, &fb_layout))?;
> =20
>          // Perform the chipset-specific boot sequence, and retrieve the =
unload bundle.
> -        let unload_bundle =3D hal.boot(&self, &ctx, &fb_layout, &wpr_met=
a)?;
> +        let unload_bundle =3D hal.boot(&self, &ctx, &fb_layout, &wpr_met=
a)?.or_else(|| {
> +            dev_warn!(dev, "The GSP won't be able to unload properly on =
unbind.\n");
> +            dev_warn!(
> +                dev,
> +                "The GPU will need to be reset before the driver can bin=
d again.\n"
> +            );
> +
> +            None
> +        });

[Severity: Medium]
Does the `?` operator here inadvertently skip these warnings if a subsequent
step in `hal.boot()` fails?

In the previous implementation, the warnings were printed immediately when
`Sec2UnloadBundle::build()` failed in `Tu102::boot()`.

With this change, if the unload bundle creation fails, but a subsequent
operation inside `hal.boot()` also fails and returns an `Err`, the `?`
operator will immediately propagate that error. This entirely bypasses the
`.or_else()` block, dropping the diagnostic warnings about the GPU needing
a reset.

> diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-co=
re/gsp/hal/tu102.rs
> index c0956fb1c9cff..ef465b99af051 100644
> --- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
[ ... ]
> @@ -278,14 +278,7 @@ fn boot(
>          // If the unload bundle creation fails, the GPU will need to be =
reset before the driver can
>          // be probed again.
>          let unload_bundle =3D Sec2UnloadBundle::build(dev, chipset, &bio=
s, gsp_falcon, sec2_falcon)
> -            .inspect_err(|e| {
> -                dev_warn!(dev, "Failed to prepare unload firmware: {:?}\=
n", e);
> -                dev_warn!(dev, "The GSP won't be able to unload properly=
 on unbind.\n");
> -                dev_warn!(
> -                    dev,
> -                    "The GPU will need to be reset before the driver can=
 bind again.\n"
> -                );
> -            })
> +            .inspect_err(|e| dev_warn!(dev, "Failed to prepare unload fi=
rmware: {:?}\n", e))
>              .ok()
>              .map(crate::gsp::UnloadBundle);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-nova-bootc=
ontext-v5-0-ecad9346387f@nvidia.com?part=3D5
