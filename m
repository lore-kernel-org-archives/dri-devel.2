Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBE9C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7088710F8AF;
	Fri, 25 Sep 2026 07:09:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DEb2rwZ8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DC010F8AC;
 Fri, 25 Sep 2026 07:09:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4705142088;
 Fri, 25 Sep 2026 07:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58B51F000FF;
 Fri, 25 Sep 2026 07:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790320182;
 bh=+J4xHXaY9R9kLQ7szYwmx/wU+8/NKKFT7t+1HnxrAIU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DEb2rwZ8krH5ND5HAWvMaTLizes8sChFPaJM/ptw0TZ8VkiHNPXxHKBgBYKpLbmnZ
 aFU6SfD2BkJM+mw9+WbSGR9ae4v7KX6v9DTfVu5wTgRl/LXbkxjZGHWFrL5V4Kg8sl
 D3Dh/yBHHy/ldDFdDqPGEB0PX9RR8jlxbawBZdjOT54wRLpjeDXcwhVFOlp/9PxrB0
 i6UIJqGqm6s+6/ZY2Odfo7QG+bCjbh3afS6zOpupTXiTVa25Ng2fg3kRR76dWgzuur
 nq/4mWTIWUsvW7DhE9q+FSCHQ3ghkn2Y+pzehcAufrHQpjylzSDqDXEJyeiatG59oF
 idh4cUqP3/nSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] i2c: designware: Support per-variant reg/bit
 offsets and intr handling
To: "Aniket Limaye" <a-limaye@ti.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 intel-xe@lists.freedesktop.org, devicetree@vger.kernel.org
In-Reply-To: <20260925-tda54-upstream-i2c-v3-2-544d74e992ff@ti.com>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <20260925-tda54-upstream-i2c-v3-2-544d74e992ff@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 07:09:41 +0000
Message-Id: <20260925070941.C58B51F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] i2c: designware: wangxun hardware register access broken
- [Low] i2c: designware: dw_i2c_reg_offsets array bloat in header
--

commit 5382481b0ab458e2922590488d443f56e4cc2c8b
Author: Aniket Limaye <a-limaye@ti.com>

    i2c: designware: Support per-variant reg/bit offsets and intr handling

This commit introduces support for per-variant register and bit offsets,
and interrupt handling in the DesignWare I2C driver. It changes register
offsets from compile-time constants to a logical enum, resolving physical
offsets via a regmap-based mapping table to prepare for different register
layouts.

Link: https://lore.kernel.org/all/20260925-tda54-upstream-i2c-v2-2-261785e5=
8493@ti.com/
Link: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-2-b0b9f77be1=
8b@ti.com/

> diff --git a/include/linux/designware_i2c.h b/include/linux/designware_i2=
c.h
> index 53f37f18a7229..994e0e5ea623f 100644
> --- a/include/linux/designware_i2c.h
> +++ b/include/linux/designware_i2c.h
> @@ -11,48 +11,103 @@
>  #include <linux/bits.h>
> =20
>  /*
> - * Registers offset
> + * Logical register IDs. Each ID is resolved to a physical offset via a
> + * per-variant table (see dw_i2c_reg_offsets[] below); regmap backends
> + * (dw_reg_read()/dw_reg_write() and the Xe I2C_REG() macro) perform that
> + * lookup so callers never need to know the real offset.
>   */
> -#define DW_IC_CON				0x00
> -#define DW_IC_TAR				0x04
[ ... ]
> -#define DW_IC_COMP_TYPE				0xfc
> +enum dw_ic_reg_id {
> +	DW_IC_CON,
> +	DW_IC_TAR,

[Severity: High]
Does changing these constants to logical enum IDs break Wangxun hardware
register access?

When the Wangxun driver's parent (txgbe) provisions an external parent regm=
ap,
the I2C core skips its built-in regmap initialization:

drivers/i2c/busses/i2c-designware-common.c:i2c_dw_init_regmap() {
    ...
    /*
     * Skip detecting the registers map configuration if the regmap has
     * already been provided by a higher code.
     */
    if (dev->map)
        return 0;
    ...
}

Because the parent regmap hasn't been updated to expect logical register ID=
s,
it will pass these new enum values directly to the hardware. For example, it
would pass 26 for DW_IC_ENABLE instead of the physical offset 0x6c.

Will this cause the driver to read and write to incorrect register offsets =
on
Wangxun platforms?

[ ... ]
> +	DW_IC_COMP_TYPE,
> +	AMD_UCSI_INTR_REG,
> +	DW_IC_REG_MAX
> +};
> +
> +/*
> + * Default "snps,designware-i2c" register offsets, indexed by
> + * enum dw_ic_reg_id.
> + */
> +static const __maybe_unused u32 dw_i2c_reg_offsets[DW_IC_REG_MAX] =3D {
> +	[DW_IC_CON]			=3D 0x00,

[Severity: Low]
Does defining this static const array in a header file cause binary bloat?

Including linux/designware_i2c.h will embed a private copy of this 164-byte
array into every translation unit that includes the header.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-tda54-upst=
ream-i2c-v3-0-544d74e992ff@ti.com?part=3D2
