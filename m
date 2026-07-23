Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275FBC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C00910E568;
	Thu, 23 Jul 2026 08:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M4Bx8oPl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57CB10E568
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 08:28:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D9CA439BA;
 Thu, 23 Jul 2026 08:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2121F000E9;
 Thu, 23 Jul 2026 08:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784795285;
 bh=Ed06Scf2+mUfTgNdVkcX8DxH3VfnQO1yfWDvlOT9vZ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M4Bx8oPlaTk/tDtYFf9m9USzGv6qn5ybQjM5U/JQOV8QEmPQYGjMNBaS/43AdBl8u
 ROG5WRpOkT+x60CJjKInxDmRMVLIfyn8u8eg2V4riMV/SPIWsrd441TZMZy7MeP8El
 vyfIDWIWmsBVgLo098XrMFCZBa8RJTjtFiMhm05xDxrHKgmfGoq4MCoI1wrwzIVu0W
 v9Ai6y3TLZzLw2+XWzXbUISWpKAMu4zUIqy+i3bhe5q3OmX20V1MwbNix3L/jMUjko
 i8JJwMWVEALvn2H+0XG2SLStdNEAPFUaoSSNxffl8O6pEtxqgo3lO5pFXJhXAgSEPx
 05HBrgBdUVPIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] powerpc/xive: remove dead NULL check after
 GFP_NOFAIL allocation
To: "Gou Hao" <gouhao@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723081813.176792-2-gouhao@uniontech.com>
References: <20260723081813.176792-1-gouhao@uniontech.com>
 <20260723081813.176792-2-gouhao@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 08:28:04 +0000
Message-Id: <20260723082805.0C2121F000E9@smtp.kernel.org>
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

New issues:
- [Low] Unused label `out_free_domain:` causes a compiler warning.

Pre-existing issues:
- [High] Use-After-Free on early boot error path when `xive_init_ipis()` fa=
ils.
--

--- Patch [1]: [PATCH 1/4] powerpc/xive: remove dead NULL check after GFP_N=
OFAIL allocation ---
commit 4043ea10e99c6ca83c1b85c8920beef1a521e167
Author: Gou Hao <gouhao@uniontech.com>

powerpc/xive: remove dead NULL check after GFP_NOFAIL allocation
   =20
kzalloc_objs with the __GFP_NOFAIL flag will never return NULL, so the
subsequent NULL check is unreachable dead code. Remove it.

> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive=
/common.c
> index dadd1f46ec939..79d7854259cb4 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1134,9 +1134,6 @@ static int __init xive_init_ipis(void)
> =20
>  	xive_ipis =3D kzalloc_objs(*xive_ipis, nr_node_ids,
>  				 GFP_KERNEL | __GFP_NOFAIL);
> -	if (!xive_ipis)
> -		goto out_free_domain;

[Severity: Low]
Does removing this goto leave out_free_domain: as an unused label at the
end of xive_init_ipis()? This might cause a compiler warning.

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
xive_init_ipis() lead to a use-after-free?

If irq_domain_alloc_irqs() fails later in this function, it takes the error
path:

arch/powerpc/sysdev/xive/common.c:xive_init_ipis() {
    ...
out_free_xive_ipis:
    kfree(xive_ipis);
out_free_domain:
    ...
}

The global pointer xive_ipis is freed but not set to NULL.

The caller xive_smp_probe() ignores the return value of xive_init_ipis() and
continues execution, eventually dereferencing the dangling pointer:

arch/powerpc/sysdev/xive/common.c:xive_smp_probe() {
    ...
    xive_init_ipis();

    /* Allocate and setup IPI for the boot CPU */
    xive_setup_cpu_ipi(smp_processor_id());
    ...
}

Which accesses the freed pointer:

arch/powerpc/sysdev/xive/common.c:xive_ipi_cpu_to_irq() {
    return xive_ipis[early_cpu_to_node(cpu)].irq;
}

Can this cause memory corruption or a crash if early IPI setup fails?

> -
>  	for_each_node(node) {
>  		struct xive_ipi_desc *xid =3D &xive_ipis[node];
>  		struct xive_ipi_alloc_info info =3D { node };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723081813.1767=
92-1-gouhao@uniontech.com?part=3D1
