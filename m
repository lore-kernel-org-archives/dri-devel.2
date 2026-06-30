Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183BCC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E9F310EAD9;
	Tue, 30 Jun 2026 07:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eyyKAsQB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 700A310EAD9
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 07:09:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47C954349D;
 Tue, 30 Jun 2026 07:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB771F00A3A;
 Tue, 30 Jun 2026 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782803355;
 bh=9Bxmo98MPLl/+3oewFZbixbQc2Igc5vg1ItRDlVvRSY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eyyKAsQBQDmy1VeDvAanzKH2rWFxOUbyes9zA+TxsAlvZ6ciuYplZHmT73s6M3+Tf
 Duxtlt4rt7DV6OZWX7b0jiMtMksMUf2l/5R6viaI5DV26NFf5m/vvGCmNylybPrjID
 WTrC5oYu4tyBWcLhCeC3lPYSQ4TI4N5AO18K4q097PVs0RA9Ehwdcrj0qjyOGJxXdu
 iLzdXWsj1r57RXuLvGvnwgsaR54V/EgmNa6f5DxWiS70rx/Xld/1KUxhtEaRPUFlwQ
 m/Lcd0tDKq8RXvM3wabFsHJBXGTWYOnOIlN/iXzAyfxxUgARyBRcya9r2rqRmZEUaS
 BFIMEln66/jfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: "Guru Das Srinagesh" <linux@gurudas.dev>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:09:14 +0000
Message-Id: <20260630070914.DBB771F00A3A@smtp.kernel.org>
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
- [Low] Incomplete conversion to vertical import style.
--

commit 515257218c25a2eecc8bad4b4c78d96ae90b1e95
Author: Guru Das Srinagesh <linux@gurudas.dev>

cpufreq: rcpufreq_dt: use vertical import style

This commit updates the device imports in rcpufreq_dt.rs to use a vertical
layout for better readability.

> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt=
.rs
> index 10106fa13095e..6f83cf8955a68 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -6,7 +6,10 @@
>      clk::Clk,
>      cpu, cpufreq,
>      cpumask::CpumaskVar,
> -    device::{Core, Device},
> +    device::{
> +        Core,
> +        Device, //
> +    },
>      error::code::*,
>      macros::vtable,
>      module_platform_driver, of, opp, platform,

[Severity: Low]
This isn't a bug, but since this commit touches the imports to convert them=
=20
to a vertical layout, should the rest of this outer block also be updated?

Items like cpu, cpufreq, and module_platform_driver, of, opp, platform, are
still grouped horizontally. The Rust subsystem guidelines prefer a fully=20
vertical style when an import block is modified.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-b4-rust-ve=
rtical-imports-v1-0-98bc71d4810b@gurudas.dev?part=3D3
