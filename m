Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BE8C88E41
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB5710E10D;
	Fri, 11 Sep 2026 00:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YFvHjYFA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2916910E10D
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 00:15:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7296A601F1;
 Fri, 11 Sep 2026 00:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB96C1F000FF;
 Fri, 11 Sep 2026 00:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789085720;
 bh=dx/55F9+ssR+hPTxfulYhfAMg2C985PLzhr+9oPMzpQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YFvHjYFAaSxkswqJ0RXVYwbmoNzroRNaFitViRucghAu16ddce5ZPo5k0E618yDqV
 qBemc8sTbVvILKcLveA/l0w9c3XC8vbcWn5hLsXBO6IXLq75zRp7xFd8dbWwFafa/6
 jJdyhvDWWnm/Soqd58OVOZ/3CFrTdwnm2LCSupx5Ylx/9OVGXFQCHOPCYXMP1ge9PZ
 K+LwfpJ3R3kavCLrKVqtUugk5xhhYmBZlSXCFp5GVqfLedxgFZ6g+0UxenSS1sqXr3
 LTSPKW4mhK8Y2ShHpHHaE2UdVwdzENOWlbiMIb+igyCG+Tv0fBCJW2heW3iggkZKTG
 8h0XXnscLO/WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tyr: use bitfield! for non-MMIO fields
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: ojeda@kernel.org, gary@garyguo.net, dri-devel@lists.freedesktop.org
In-Reply-To: <20260910-b4-use-bitfield-v1-1-fdddfccff73b@collabora.com>
References: <20260910-b4-use-bitfield-v1-1-fdddfccff73b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 00:15:19 +0000
Message-Id: <20260911001519.DB96C1F000FF@smtp.kernel.org>
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
- [Low] Missing visibility modifier for `MMU_MEMATTR_STAGE1` causes a visib=
ility boundary compilation error.
--

commit 9dd90ec5533d3a238392c979496e6e4e0ffc41d1
Author: Deborah Brouwer <deborah.brouwer@collabora.com>

drm/tyr: use bitfield! for non-MMIO fields

This commit transitions SectionFlags and MMU_MEMATTR_STAGE1 from the
register! macro to the bitfield! macro. This clarifies that these structures
describe bitfields rather than actual hardware registers.

> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index 0c419c4e1186c..3377b8fc50294 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
[ ... ]
> @@ -1130,14 +1131,12 @@ fn from(val: MemoryType) -> Self {
>              }
>          }
> =20
> -        register! {
> -            base: TyrRegisters;
> -
> +        bitfield! {
>              /// Stage 1 memory attributes (8-bit bitfield).
>              ///
> -            /// This is not an actual register, but a bitfield definitio=
n used by the MEMATTR
> -            /// register. Each of the 8 bytes in MEMATTR follows this la=
yout.
> -            MMU_MEMATTR_STAGE1(u8) @ 0x0 {
> +            /// This bitfield definition is used by the MEMATTR register.
> +            /// Each of the 8 bytes in MEMATTR follows this layout.
> +            struct MMU_MEMATTR_STAGE1(u8) {

[Severity: Low]
Does this missing visibility modifier cause a build failure?

Since the struct is defined without a visibility modifier here, it becomes
private to the module. However, it is used as a return type in the accessor
methods for the pub(crate) MEMATTR register (e.g., via
attribute0 ?=3D> MMU_MEMATTR_STAGE1).

Would it make sense to add a visibility modifier here, similar to the
pub(super) added to SectionFlags, to prevent a private interfaces (E0446)
visibility boundary compilation error?

>                  /// Inner cache write allocation policy.
>                  0:0     alloc_w =3D> bool;
>                  /// Inner cache read allocation policy.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-b4-use-bit=
field-v1-1-fdddfccff73b@collabora.com?part=3D1
