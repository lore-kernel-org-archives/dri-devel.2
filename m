Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E36BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA5D10E937;
	Mon, 29 Jun 2026 14:21:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AHUog5aN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4961110E937
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:21:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E88B0402E5;
 Mon, 29 Jun 2026 14:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718671F00A3A;
 Mon, 29 Jun 2026 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782742899;
 bh=rH+EGOumzuOUisi+L8BodGjc9+mbeXzIgFqqJooIfwI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AHUog5aNpg2Dz5XuLBUkidjvj53auWYu//6mqouuNMKYXtQlIoZ6BmbDtQm/yQ/WI
 LosHKwA3hB9iT0Z9nOVTsge/BRJSjooIDodXKegad+jF/NwXGAMOGXaNLvnMRYAx4T
 DAlgQRak5Oz/8Te2wGyWQOEZ8uM6sp/SwWc5wpPhNfA8UkB9wnHEogdH3l5JDPLJg9
 lO9mlgm5AxTBoU9Lni0rvoV29dd3R6PHF3PMJyBqlC868TMV0/pDXSovaXSCEbUcAN
 0exmfZ2WZYrsA1V8BcDP3fRJqF8b/jEqOOgedrHnwpCKOd8B9P3mhoOsDKX4lhG4rR
 7DWbsxf+E4Z/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/13] gpu: nova-core: gsp: replace BootUnloadGuard
 with local handlers
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260629-nova-bootcontext-v4-3-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-3-5539d8469590@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:21:38 +0000
Message-Id: <20260629142139.718671F00A3A@smtp.kernel.org>
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
- [Medium] The root cause error from `fsp.boot_fmc` is masked by a subseque=
nt timeout error from `wait_for_gsp_lockdown_release`.
--

commit 24f94e0b36617b6956b3b5c28c4a63019c91588f
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: replace BootUnloadGuard with local handlers

This commit removes the BootUnloadGuard abstraction, replacing it with a
two-level error handling strategy. HALs handle their own errors and
Gsp::boot uses a ScopeGuard to run Gsp::unload.

> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-co=
re/gsp/hal/gh100.rs
> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
[ ... ]
> @@ -174,11 +168,13 @@ fn boot<'a>(
>              false,
>          )?;
> =20
> -        fsp.boot_fmc(dev, fb_layout, &args)?;
> +        // Keep the result as we want to wait for lockdown release even =
in case of error, to make
> +        // sure args is not accessed by the GSP anymore.
> +        let res =3D fsp.boot_fmc(dev, fb_layout, &args);
> =20
>          wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_=
dma_handle())?;

[Severity: Medium]
Will this mask the original error if fsp.boot_fmc() fails?

If fsp.boot_fmc() fails, its error is stored in res. The function then calls
wait_for_gsp_lockdown_release() to ensure the boot arguments are no longer
accessed. Because the FSP boot failed, the lockdown release polling will
inevitably time out. The ? operator on wait_for_gsp_lockdown_release() will
propagate this timeout error immediately, causing the function to return ea=
rly
and silently discard the original root cause error held in res.

> =20
> -        Ok(unload_guard)
> +        res.map(|()| Some(unload_bundle))
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-nova-bootc=
ontext-v4-0-5539d8469590@nvidia.com?part=3D3
