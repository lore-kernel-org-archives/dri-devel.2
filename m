Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069EAC5DF67
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344C610E013;
	Fri, 14 Aug 2026 02:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fMcIQPOt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A329E10E013
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 02:03:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA6B2600AF;
 Fri, 14 Aug 2026 02:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4098D1F000E9;
 Fri, 14 Aug 2026 02:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786673026;
 bh=uC3vAXQRovUaDbMj+DFVcR+1TewqJurHJ5qrhIgaLu4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fMcIQPOtmxFndT2tP8oMwVzy+CypOT3Zt4jKSnWaXeQ1OoMcnR7EaKgoYybDARupi
 Yf51m8R8ofNh+xqUAu2hvHtJLTDvTQh3aQpvAmnalvCRmw/9Pk9VgJxjQrVCP8Uheh
 PoHU2NLIfNQbXM9tr9/M9NXUC4Qal9Jh9cCdPiINbyTPZ7GNIUbxwAkoLsRm8iKvkh
 a/zBO2nLsbqwOTWZB40P1vvWQMuIZ5/Lns0dny3gmUx+C5TA2oupdJNwa5G4Wo/YVW
 Hyd13jeJlGUqLDrE5FMsvMYiINdVVuqgelxKo1QAEdAU7/EbGFMM8oPDL6jCEs+fLc
 wrUrLVXZCxqvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/03] fbdev: maxine: fix 64-bit build error
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813232934.2718291-4-rdunlap@infradead.org>
References: <20260813232934.2718291-1-rdunlap@infradead.org>
 <20260813232934.2718291-4-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:03:42 +0000
Message-Id: <20260814020346.4098D1F000E9@smtp.kernel.org>
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
- [High] `smem_start` is incorrectly populated with a virtual address inste=
ad of a physical address, which breaks user-space mmap.
--

--- Patch [3]: [PATCH 03/03] fbdev: maxine: fix 64-bit build error ---
commit 4b24e26365b585612a868800c1d954fcade38bb4
Author: Randy Dunlap <rdunlap@infradead.org>
fbdev: maxine: fix 64-bit build error

This commit resolves a 64-bit build error in the maxinefb driver by
replacing the KSEG1ADDR() macro, which is only defined for non-64BIT
builds, with the CKSEG1ADDR() macro.

> diff --git a/include/video/maxinefb.h b/include/video/maxinefb.h
> index 6aeb4acca2bdb..2b66b32f355cf 100644
> --- a/include/video/maxinefb.h
> +++ b/include/video/maxinefb.h
[ ... ]
> @@ -19,7 +19,7 @@
>  /*
>   * Begin of DECstation 5000/xx onboard framebuffer memory, default resol=
ution
>   * is 1024x768x8
>   */
> -#define DS5000_xx_ONBOARD_FBMEM_START	KSEG1ADDR(0x0a000000)
> +#define DS5000_xx_ONBOARD_FBMEM_START	CKSEG1ADDR(0x0a000000)

[Severity: High]
This is a pre-existing issue, but does assigning this virtual address to
the framebuffer's fix.smem_start break user-space mmap?

When user-space applications call mmap() on the framebuffer device, fb_mmap=
=20
calculates the physical frame number by shifting info->fix.smem_start. Sinc=
e=20
this macro defines a virtual CKSEG1 address instead of a physical address=20
(0x0a000000), the resulting physical frame number maps to invalid physical=
=20
memory space.

Looking at drivers/video/fbdev/maxinefb.c in maxinefb_init():

    fb_start =3D DS5000_xx_ONBOARD_FBMEM_START;
    ...
    maxinefb_fix.smem_start =3D fb_start;

Should smem_start be populated with the actual physical address rather than
the CKSEG1-mapped virtual address to prevent bus errors or unintended physi=
cal
memory access during user-space mappings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813232934.2718=
291-1-rdunlap@infradead.org?part=3D3
