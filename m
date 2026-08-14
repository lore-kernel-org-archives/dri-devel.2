Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD87C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 01:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B271110E03C;
	Fri, 14 Aug 2026 01:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c/+gkh8o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF1F10E03C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 01:54:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DF3D600AD;
 Fri, 14 Aug 2026 01:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004791F000E9;
 Fri, 14 Aug 2026 01:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786672491;
 bh=Vqhfd2ghJohXTnQCA/c7wJkevVENPY1AHeuwgEswkvE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c/+gkh8oW6cFNjxQtpIsZIIu2BGfX8jJ4yx50eKLKuhr6G/LK4VYj0fgaLA3NKx2L
 Gf78MwNIiogIVfTFLUy6UHBIer8UkPqCKgg/YMDQ3YHJ2KkB/y1BCwG4VC2dtz+CfK
 MlS7LMMmmCSLkUWv18FMOqHZcU1OdZYsOMg5zfTSPlIl3gWa/GtItv17IDmks4fhfR
 DBTaWm54fUcOO236BUw714QhQ9IpLOVghyGBgaDf4blh2dyKt7QVJASYkqQDvMCc23
 iJJtsn+QcD1eytJAYUPhlBuIGj7Nf9SoIDBnuL0vfdlD+ZgWSlgbrx56eNhUr/H2kq
 IQQWK+jAEtP8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/03] fbdev: maxine: elide an unused function
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813232934.2718291-3-rdunlap@infradead.org>
References: <20260813232934.2718291-1-rdunlap@infradead.org>
 <20260813232934.2718291-3-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:54:50 +0000
Message-Id: <20260814015451.004791F000E9@smtp.kernel.org>
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
- [Low] The patch uses an `#if 0` block to retain the unused function `maxi=
nefb_ims332_read_register` instead of removing it from the source file.
--

--- Patch [2]: [PATCH 02/03] fbdev: maxine: elide an unused function ---
commit 603e8df0aa8d23f85b3ef46ca55422bc6d08d6c9
Author: Randy Dunlap <rdunlap@infradead.org>

fbdev: maxine: elide an unused function

This commit addresses a compiler warning about an unused function by wrappi=
ng
maxinefb_ims332_read_register() in an #if 0 block. The author notes that the
function is intentionally retained to serve as documentation for the hardwa=
re
interface.

> diff --git a/drivers/video/fbdev/maxinefb.c b/drivers/video/fbdev/maxinef=
b.c
> --- a/drivers/video/fbdev/maxinefb.c
> +++ b/drivers/video/fbdev/maxinefb.c
> @@ -71,6 +71,8 @@ static void maxinefb_ims332_write_register(int regno, r=
egister unsigned int val)
>  	*((volatile unsigned short *) (wptr)) =3D val;
>  }
> =20
> +#if 0
> +/* dead code: leave here for hardware interface documentation */
>  static unsigned int maxinefb_ims332_read_register(int regno)

[Severity: Low]
Is it better to just delete this unused function entirely? Section 21 of the
kernel coding style states that if a function always goes unused, it should=
 be
deleted rather than commented out or hidden behind preprocessor conditional=
s.

While the comment notes it acts as hardware documentation, leaving uncompil=
ed
code in the tree skips compiler checks and often leads to bit-rot over time.
Could this be removed, relying on git history if anyone needs to reference
the hardware interface in the future?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813232934.2718=
291-1-rdunlap@infradead.org?part=3D2
