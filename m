Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD58C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5811A10E415;
	Tue,  7 Jul 2026 08:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QMhwkUXU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3270410E46C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 08:10:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 66CD2618AF;
 Tue,  7 Jul 2026 08:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37011F000E9;
 Tue,  7 Jul 2026 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783411821;
 bh=09PwQgM5Wz/0uckHMwIavgpphWnPyKug1AOyELSlFpw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QMhwkUXUoY7bDZSr3ubTHuQKklxOlghYHsSfj0EEZZrzME+NW4me/wzesA0403lhH
 tbp9N+vxPVe4kX48d113ihY2ZEMZzjMyBd1hmIhuR5nbvu8gweOpzKbnL/X00jYVTC
 E7Vw80q1hNSWIwBnMA2I1Eq8Bafib9mIrQXYuknNZFcK5iHh+h98dKqZMWzZCjmTiu
 +4f4RTxTsTfpJda1yGWY6NjKVIOMBDp3OFue5QWc/LEiFUgKxoCDL/U98QeCgTyy/u
 bPw6A5BaxEggbnumYxnnJXDezUNq6DJlPFc1QGHv5aY/SYiHdGYgyHVDIY5SJIuDGX
 qVbLTRixeSKPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/13] gpu: nova-core: gsp: replace BootUnloadGuard
 with local handlers
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-3-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
 <20260707-nova-bootcontext-v5-3-ecad9346387f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:10:20 +0000
Message-Id: <20260707081020.C37011F000E9@smtp.kernel.org>
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
- [Medium] Unconditional 30-second poll for GSP lockdown release in `gh100:=
:boot` even if FSP boot fails synchronously.
--

--- Patch [3]: [PATCH v5 03/13] gpu: nova-core: gsp: replace BootUnloadGuar=
d with local handlers ---
commit 5f271d8ce96c42826048a3921af9e3b0c91b646e
Author: Alexandre Courbot <acourbot@nvidia.com>
Subject: gpu: nova-core: gsp: replace BootUnloadGuard with local handlers

This commit removes BootUnloadGuard and replaces it with local error handli=
ng
strategies across the GSP boot process. HALs are now responsible for handli=
ng
their own errors and returning an unload bundle on success. Gsp::boot now
utilizes a ScopeGuard to run Gsp::unload.

> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-co=
re/gsp/hal/gh100.rs
> index 1d06405a32f61..18c889f9f4130 100644
> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs

[ ... ]

> @@ -174,11 +169,23 @@ fn boot<'a>(
>              false,
>          )?;
> =20
> -        fsp.boot_fmc(dev, fb_layout, &args)?;
> -
> -        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_=
dma_handle())?;
> -
> -        Ok(unload_guard)
> +        // Keep the result as we want to wait for lockdown release even =
in case of error, to make
> +        // sure `args` is not accessed by the GSP anymore.
> +        let fsp_res =3D fsp.boot_fmc(dev, fb_layout, &args);
> +
> +        // Wait for GSP-FMC to release the GSP lockdown, indicating that=
 `args` is not accessed
> +        // anymore.
> +        let lockdown_res =3D
> +            wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_par=
ams_dma_handle());
> +
> +        match fsp_res.and(lockdown_res) {
            ^^^^

[Severity: Medium]
Will this unconditionally wait for the full timeout if fsp.boot_fmc() fails
synchronously?

If fsp.boot_fmc() fails early (for example, due to memory allocation failure
or invalid firmware signatures) before sending the message to the FSP, the
FSP will never be commanded to boot the GSP.

Because the early return was removed, wait_for_gsp_lockdown_release() is
called anyway and will inevitably block for its full 30-second timeout
since the lockdown will never be released.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-nova-bootc=
ontext-v5-0-ecad9346387f@nvidia.com?part=3D3
