Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61638CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 22:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB99710E3D4;
	Thu,  4 Jun 2026 22:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CUB2kY+j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96EC510E3D4
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 22:01:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46C01408C4
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 22:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B65A1F00893
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 22:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780610468;
 bh=tkXvI8bFzA++DakdVDn/EovKnPu/iBwy4fNRUszwgyw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=CUB2kY+j6yb/biki7s2YNx2c36Q2wu97GBim9P/46PiHfgsVeZyEiC8aFO9iXVGb4
 qbvtyFEBNgJLgIIH+Xi7hg0SMCREIfIX0rj36oUE+xvQ2+k7W108Q+AoUXAQ0/oIOs
 xcuPludE4H2zkDatjhfa25pQ/lvdZfqcljSgYp/AWtUpvC2eeOCFXDnhRVyCheqOa6
 p5BiX2Pv1IRIJ1qQBSifnIoVXEUAW8xvXCeXmF8s7/+dNFj/P+ErX1oRwLvUQakj83
 zXV+MyNoHxdzYoSu4Hbi+2g6+G3dFffi3aXzs2oKc1JciP2i5fRLvgX3lPymEWYZEH
 lGjZ41bzzUDng==
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-bec450b950dso181396166b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 15:01:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/YZ3we0Cp+oqbT1hiT5GzDbhoGOJlX5WCLg+bYDYeih7eV2XCoeaT8/CHH1SDmdoQgz1xdnrNPqkg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPj1Sjy3do9UXxughBEQekgpjCMD4Vw1LP+t3p6K0J7fC1LL/R
 0WhS+XqSkeKgpgfWyiLrqAmkNvsm1e6wORLsxdPrBFk6BCndATpJ6fW31WQgrDqin0tj14UL2Jr
 b3WyEcSDkNQ9Apg5M249h3BQe2Wg1tw==
X-Received: by 2002:a17:907:78e:b0:bf0:701e:b148 with SMTP id
 a640c23a62f3a-bf3721590cfmr24420066b.27.1780610466843; Thu, 04 Jun 2026
 15:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+g3TbsDGcsmdPn-p70OO3DwS2Fsq0NN9v1FVYqSa13JCPvFXQ@mail.gmail.com>
In-Reply-To: <CA+g3TbsDGcsmdPn-p70OO3DwS2Fsq0NN9v1FVYqSa13JCPvFXQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 4 Jun 2026 17:00:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ5vzUaX4x+r9fqibwEneTFyxZbW=pRs+_T233HCmp3Ow@mail.gmail.com>
X-Gm-Features: AVVi8CeyKMMR9Zto8xn46sBrdNzU7re09bX2f6ZE0XLkloyA80qiKzAWnawGAdg
Message-ID: <CAL_JsqJ5vzUaX4x+r9fqibwEneTFyxZbW=pRs+_T233HCmp3Ow@mail.gmail.com>
Subject: Re: [PATCH] accel/ethosu: fix integer overflow in cmd_to_addr()
 address computation
To: D D <dhabal123@gmail.com>
Cc: security@kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, May 18, 2026 at 10:32=E2=80=AFAM D D <dhabal123@gmail.com> wrote:
>
> In cmd_to_addr(), the expression (cmd[0] & 0xff0000) << 16 performs the
> left-shift in 32-bit arithmetic because cmd[0] is u32 and the intermediat=
e
> result of the AND is also u32. The meaningful bits (positions 16-23) need
> to land in positions 32-39 of the result, but these positions exceed the
> 32-bit width, so they are silently discarded before the cast to u64.
>
> This causes cmd_to_addr() to always return an address with a zeroed upper
> half, producing an incorrect DMA address for the Ethos-U NPU. The device
> may then read from or write to the wrong physical memory region, leading
> to kernel memory corruption or information disclosure.
>
> Fix by casting to u64 before the shift so the operation is performed in
> 64-bit arithmetic and no bits are lost.
>
> Found by manual source code audit of Linux kernel v6.19
> (drivers/accel/ethosu/ethosu_gem.c, line 157).
> Affected versions: v6.19+ (since initial Ethos-U driver merge).
>
> Signed-off-by: Dhabaleshwar Das (dhabal123@gmail.com)
> ---
>  drivers/accel/ethosu/ethosu_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Already fixed in commit 7be41fb00e2c ("accel: ethosu: Fix shift
overflow in cmd_to_addr()").

Rob
