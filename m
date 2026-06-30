Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B4CC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4137910EB06;
	Tue, 30 Jun 2026 07:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ed55Usx/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C12A892E0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 07:09:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14FC6435E5;
 Tue, 30 Jun 2026 07:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94AE1F00A3A;
 Tue, 30 Jun 2026 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782803356;
 bh=EL+3SOD2DHjiyG+h6uCKoPpc2E9PWXtT98yKL7rgBHM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ed55Usx/O9bTgXiUtOJu2ujdXzbgtXbcl9K9HjARrxu7NXS7hdgHlXd+iCIlzA5Rh
 j1sUDQRR7kKLKu4XCgkP5Lbzlbra4t2dpVw66zKh5qNjz79AyAxPTejbuWUOf7DCZe
 PSFYi2GpIMbqR928k59U6dOWpk2P631eX8ETfwHcA0ngYKMdhHhEJjlZ7z8DqtVaXV
 BiXKjJ3ZhQqvtHtKjCnOpffTOSaATX0lgguT75d5CpabK7O8dFhcd9KPVFnV3xQFfC
 ynAZ2bYow/Qns/thPa7TS0ZEq/2ADY2tdt878vxOTlfrp74yVa+bI6/2ycuz+7Okfd
 HWXYCJcvQ52tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] pwm: th1520: use vertical import style
To: "Guru Das Srinagesh" <linux@gurudas.dev>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-2-98bc71d4810b@gurudas.dev>
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-2-98bc71d4810b@gurudas.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:09:15 +0000
Message-Id: <20260630070915.A94AE1F00A3A@smtp.kernel.org>
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
- [Low] Incomplete conversion to vertical import style; missed multiple imp=
orts.
--

commit 6d048655750f08bf1b238e917a37ca506f11dd45
Author: Guru Das Srinagesh <linux@gurudas.dev>

pwm: th1520: use vertical import style

This commit converts use imports to a vertical layout for improved readabil=
ity
and maintainability.

> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index 3e3fa51ccef91..3e4524a1910bc 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -23,12 +23,16 @@
>  use core::ops::Deref;
>  use kernel::{
>      clk::Clk,
> -    device::{Bound, Core, Device},
> +    device::{
> +        Bound,
> +        Core,
> +        Device, //
> +    },
>      devres,
>      io::{
>          mem::IoMem,
>          Io, //
>      },
>      of, platform,
>      prelude::*,
>      pwm, time,

[Severity: Low]
Are some modules still grouped horizontally here?

The commit message states the goal is to convert imports to a vertical layo=
ut.
However, the use kernel::{ ... } block still contains horizontal imports for
of, platform, pwm, and time.

Could these remaining imports be split onto their own lines to fully implem=
ent
the vertical style?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-b4-rust-ve=
rtical-imports-v1-0-98bc71d4810b@gurudas.dev?part=3D2
