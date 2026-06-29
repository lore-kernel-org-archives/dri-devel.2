Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D51AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E09310E089;
	Mon, 29 Jun 2026 14:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AF8fDWde";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A669810E089
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:20:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 25E0F600AA;
 Mon, 29 Jun 2026 14:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3E71F000E9;
 Mon, 29 Jun 2026 14:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782742807;
 bh=6oRCQ8EZXiYOXZpbLQCcrzslZScqqUfiSaO9pzyrSHk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AF8fDWdet9GSF8wld/LXdTKo9TCUiPfEw0DmvcoImXIq3FW90XBgVokLBoIHACXIO
 mXPrkuHu4T6ktg4bcnPLc0Oi8ixyoyg1bnbJ0mJyrFFGA1zcjdszlWiA+FmYtnIAK1
 DLgMh51WIgudndGYXCwQuAA+jPgFzknucLCjBRR9by4DvwbMUmTuZiwERKG2WAc717
 fKREUlLUciUzDSN7nkOOed4xkecsYAU4MO178PtzfGd6NK/tGzD3MprS/mVTuzrGPb
 iszhITiBZy/kh0dU51jXqtvJ70JrpI/U0cTE9hq/5HAJYOJ9rWGurTX/AMr9xQJvRr
 q2YOVXORFBorg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/13] gpu: nova-core: gsp: centralize missing unload
 bundle warnings
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260629-nova-bootcontext-v4-5-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-5-5539d8469590@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:20:06 +0000
Message-Id: <20260629142007.8E3E71F000E9@smtp.kernel.org>
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
- [Medium] Moving the unload bundle warning to `Gsp::boot` using `hal.boot(=
...)?.or_else(...)` drops the warning on error paths and is dead code for `=
Gh100`.
--

commit 6422f17d0c05bd4c3b60d0655dea96518aadd1a5
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: centralize missing unload bundle warnings

This commit moves the warning emitted when the unload bundle cannot be
constructed from the Tu102-specific boot code to the generic Gsp::boot
method so it applies to all boot methods.

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

[Severity: Medium]
Will this `.or_else()` block be skipped if `hal.boot()` returns an error
due to the `?` operator?

For example, if `Gh100::boot()` returns an `Err` directly when it fails to
build its bundle (e.g., KBox::new failure) rather than returning `Ok(None)`,
it seems this block would be completely unreachable, contrary to the commit
message's goal of applying it to all boot methods.

Likewise for `Tu102`, if `Sec2UnloadBundle::build()` fails and results in
`None`, but a subsequent step in `Tu102::boot()` fails and returns an `Err`,
the immediate error propagation would swallow these warnings.

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-nova-bootc=
ontext-v4-0-5539d8469590@nvidia.com?part=3D5
