Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0878CCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EBCF10EB25;
	Wed, 17 Jun 2026 20:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ohGbgKTC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1056310EB25
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 20:18:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C1D8940418;
 Wed, 17 Jun 2026 20:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB571F000E9;
 Wed, 17 Jun 2026 20:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781727523;
 bh=7MdwJViQb0RmNwqluhhyP5oZ+nuNiLOSRI9dmb92iEA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ohGbgKTCFoh+Z3bUZPWQee1rlmBj8bLPHkuVYmYYRcpPt1AuxRoj3slONyobvNNpm
 J+2qwePCDglpwshX/KhtnIWX/xkQ0+LtW5xxOF+BqsoDNNN0wsxBizAMPPxodAoIsm
 gNd9H18LzWolV9r0RAREFf0WnEtmK3IRw4MeR3IYAIHIKTrEOBd8dX1yzs33MTjhJ/
 6qWxJWOiBsbX2tv5uCmzT7akVi/EoYcQ2j/aVi9ezjGFAx/waEBI0tmxgNYBxv6y4D
 BQyqtOFReFZ4dV1xxO13gCDKk0fp03CzJPmkv4fqH5NTflwRVDlLtnxTrmcHKV+mcM
 d9MiN4eUrVt5g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/7] drm/vino: add KUnit self-tests for the protocol
 and crypto paths
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260617151249.2937-8-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260617151249.2937-8-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:18:42 +0000
Message-Id: <20260617201843.7AB571F000E9@smtp.kernel.org>
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
- [Low] Incorrect Kconfig conditional compilation attribute `#[cfg(CONFIG_K=
UNIT =3D "y")]` causes a build failure when KUnit is enabled.
--

commit 5c04ae06d96b8f9a5712fdd9c7e8f73f7a3cbf26
Author: Mike Lothian <mike@fireburn.co.uk>

Add offline KUnit self-tests for the pure protocol builders/parsers and

This commit adds offline KUnit self-tests for the pure protocol
builders/parsers and the crypto bindings the control plane relies on.
The crypto cases use published known-answer vectors and there are
tests for EDID extraction and DDC/CI encoding.

> diff --git a/drivers/gpu/drm/vino/vino.rs b/drivers/gpu/drm/vino/vino.rs
> index ee63ce7e4625..2d22c3f822cd 100644
> --- a/drivers/gpu/drm/vino/vino.rs
> +++ b/drivers/gpu/drm/vino/vino.rs
[ ... ]
> +/// Build a minimal valid 128-byte EDID with a 1920x1080@60 detailed tim=
ing at base-block
> +/// offset `dtd_at` (54 =3D preferred slot), a correct checksum, and the=
 standard magic.
> +#[cfg(CONFIG_KUNIT =3D "y")]

[Severity: Low]
Will this configuration attribute work correctly in the kernel's Rust build
system? The Kconfig symbols are passed to rustc as boolean configuration fl=
ags
(e.g., --cfg CONFIG_KUNIT), not as key-value strings.

Since #[cfg(CONFIG_KUNIT =3D "y")] always evaluates to false, the mk_test_e=
did()
function will be stripped from the build. Does this cause a compilation err=
or
when KUnit is enabled and the test module attempts to call it? Should this =
be
changed to #[cfg(CONFIG_KUNIT)] instead?

> +fn mk_test_edid(dtd_at: usize) -> [u8; 128] {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617151249.2937=
-1-mike@fireburn.co.uk?part=3D7
