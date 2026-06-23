Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35E9CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2117010ECB9;
	Tue, 23 Jun 2026 20:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CSq9AdvZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB00B10ECB9
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:59:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AEA860008;
 Tue, 23 Jun 2026 20:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9C81F000E9;
 Tue, 23 Jun 2026 20:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782248349;
 bh=TKb1cmWhiw5ZKtJh2GQY/m1pgz+nVTpTIhb6a/yCB10=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CSq9AdvZ2aF9JvdY6cKXdyxM9h9+ESht2ar+OiDedoVL5fPMoONjKk390IWQWNw+E
 +bBChoybvFy0kgkmwJ5lQErf1lfQdpB9weggQDkmWEh2IK4i+TqFLG89TRsFRnsuhO
 rN87s9llKasAq1jGQWNsEHOw4In0H5wggv6U6+1P7YAZxYatqMReE29Y9Mxrkxf2vu
 /EbIdUzgxYvJQEMm+TB4vqkfTAkkzL1z811wdbDiMRTWIUu5qn0xXotSQpAXG1blkT
 FDBM0/lew54fevwRC1Dfohc/+Wf/HFWmUGYizQaERrszbkpgGleJQ3sdV3JN1DBNiK
 ThhThNRMTqsXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] gpu: nova-core: gsp: move unload bundle error
 handling to Gsp::boot
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org
In-Reply-To: <20260622-nova-bootcontext-v2-5-0ddeafc06f5d@nvidia.com>
References: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
 <20260622-nova-bootcontext-v2-5-0ddeafc06f5d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:59:09 +0000
Message-Id: <20260623205909.AC9C81F000E9@smtp.kernel.org>
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
- [Medium] Early boot failures unconditionally trigger false warnings about=
 unload firmware preparation and incorrectly state a GPU reset is required.
--

commit 273d5dbf9e1e0ce85069f0026ccecdadd0a2d4fd
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: move unload bundle error handling to Gsp::boot

This commit moves the warning for unload bundle creation failure from
the Tu102 specific implementation to Gsp::boot so it applies to all boot
methods. It changes the HAL boot method to return a Result for the
unload bundle.

> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
[ ... ]
> @@ -59,6 +59,18 @@ pub(crate) fn boot(
>          // Perform the chipset-specific boot sequence, and retrieve the =
unload bundle.
>          let (res, unload_bundle) =3D hal.boot(&self, &ctx, &fb_layout, &=
wpr_meta);
> =20
> +        // Display error for unload bundle if any, and convert to Option.
> +        let unload_bundle =3D unload_bundle
> +            .inspect_err(|e| {

[Severity: Medium]
If the hal.boot() implementation fails early (for example, if Vbios::new()
fails in Tu102::boot()), unload_bundle will retain its initial dummy error
value of Err(EAGAIN).

Won't inspect_err() then unconditionally print these warnings about firmware
preparation and the need for a GPU reset, even though the actual failure
occurred before bundle preparation was attempted?

> +                dev_warn!(dev, "Failed to prepare unload firmware: {:?}\=
n", e);
> +                dev_warn!(dev, "The GSP won't be able to unload properly=
 on unbind.\n");
> +                dev_warn!(
> +                    dev,
> +                    "The GPU will need to be reset before the driver can=
 bind again.\n"
> +                );
> +            })
> +            .ok();
> +
>          // Run from a closure so we can retrieve the result, and run the=
 unload sequence of the GSP
>          // in case of error.
>          let res =3D res.and_then(|()| {
[ ... ]
> diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-co=
re/gsp/hal/tu102.rs
> --- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
[ ... ]
> @@ -269,14 +269,14 @@ fn boot(
>          ctx: &GspBootContext<'_>,
>          fb_layout: &FbLayout,
>          wpr_meta: &Coherent<GspFwWprMeta>,
> -    ) -> (Result, Option<crate::gsp::UnloadBundle>) {
> +    ) -> (Result, Result<crate::gsp::UnloadBundle>) {
>          let dev =3D ctx.dev();
>          let bar =3D ctx.bar;
>          let chipset =3D ctx.chipset;
>          let gsp_falcon =3D ctx.gsp_falcon;
>          let sec2_falcon =3D ctx.sec2_falcon;
> =20
> -        let mut unload_bundle =3D None;
> +        let mut unload_bundle =3D Err(EAGAIN);
> =20
>          let res =3D (|| {
>              let bios =3D Vbios::new(dev, bar)?;

[Severity: Medium]
Here is where unload_bundle defaults to Err(EAGAIN). Is there a way to
differentiate between an early boot failure where bundle creation wasn't
reached, versus an actual failure during bundle creation, so that Gsp::boot=
()
doesn't emit false warnings?

> @@ -287,15 +287,6 @@ fn boot(

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-nova-bootc=
ontext-v2-0-0ddeafc06f5d@nvidia.com?part=3D5
