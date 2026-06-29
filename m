Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E78DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7019710E058;
	Mon, 29 Jun 2026 14:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K7M/1GXt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8812510E058
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:27:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 582ED42D5F;
 Mon, 29 Jun 2026 14:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6141F000E9;
 Mon, 29 Jun 2026 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782743258;
 bh=xx/5YjsXIruUGQj/mKNwO8Lzlpv2QSmLswkJrGNTINI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K7M/1GXtdpbpY6OFCXSfrcguynVfVaxTp3BexnqGdGfNsefAXnwpPgMKeh82LRKKV
 cqWnAcbrf9wJT+HreaiYcZB9kfXcv3u7NcDIUMjP9n2Q+ynylG/qvWnrI9LNtQzveW
 1GS0Hw81uIw8lH1GwTUkd7/Tssris4d9c60LU0I05+pI1IXfVzDlpQGoqSz6eCLF3N
 czjIXSS1RJbk9EbXOtq/3tO340xEOUTYDOkqDNzUuEgyPG0e9Vo9YmBHCU88sbcVWR
 emctrYRE+MkgUAQw/rCuh1aTugSlddOdDtXcmZnT8f1/GZWOotCWND32T8aaAz6Gzy
 kjcasfUKpggQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/13] gpu: nova-core: store Fsp instance in Gpu
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260629-nova-bootcontext-v4-13-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-13-5539d8469590@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:27:37 +0000
Message-Id: <20260629142737.ED6141F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] DMA Use-After-Free due to freeing buffers while GSP is still a=
ctive on timeout
--

commit ad8609a0c320b89583cef07a17ca5ce5c85167ea
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: store Fsp instance in Gpu

The Fsp instance was only used in the Hopper+ boot path, and
consequently built locally (and immediately dropped) in it.

This worked well as a temporary measure, but the FSP is a GPU
sub-device, so its lifetime should match the GPU rather than a single
boot invocation.

> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-co=
re/gsp/hal/gh100.rs
> index 2805a35abb798..de786871c8ec4 100644
> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
[ ... ]
> @@ -150,7 +146,7 @@ fn boot(
>              KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBu=
ndle>
>          );
> =20
> -        let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset)?;
> +        let fsp =3D ctx.fsp.as_mut().ok_or(ENODEV)?;
> =20
>          let args =3D FmcBootArgs::new(
>              dev,

[Severity: Critical]
This is a pre-existing issue, but I wanted to ask about the error handling
in this function and how it affects DMA buffers.

If wait_for_gsp_lockdown_release() times out later in Gh100::boot(), the ?
operator causes an early return:

        let res =3D fsp.boot_fmc(dev, fb_layout, &args);

        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_dma=
_handle())?;

When this happens, args is dropped, and the error propagates back to
Gsp::boot(), which bypasses the unload_guard creation and immediately
drops wpr_meta:

        let unload_bundle =3D hal
            .boot(&self, &mut ctx, &fb_layout, &wpr_meta)?

Dropping these structures frees their underlying DMA memory. However, since
the timeout occurred, the GSP hardware is not forcefully halted.

A similar issue appears during the unload path in FspUnloadBundle::run().
If a timeout occurs while waiting for RISC-V to halt, the code explicitly
detects that the engine is still active but returns an error without
forcefully halting it:

        read_poll_timeout(
            || Ok(ctx.gsp_falcon.is_riscv_active()),
            |&active| !active,
            Delta::from_millis(10),
            Delta::from_secs(5),
        )
        .map(|_| ())
        .inspect_err(|_| dev_err!(ctx.dev(), "GSP falcon failed to halt\n"))

Since the error propagates and allows the DMA memory to be freed while the
engine continues executing, could the active GSP hardware write to the freed
host memory and cause memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-nova-bootc=
ontext-v4-0-5539d8469590@nvidia.com?part=3D13
