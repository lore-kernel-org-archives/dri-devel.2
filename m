Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6C8C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 02:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF78A10E4F3;
	Fri, 24 Jul 2026 02:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T2wDR8QV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2DE10E4F3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 02:44:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84D67600AA;
 Fri, 24 Jul 2026 02:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112401F000E9;
 Fri, 24 Jul 2026 02:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784861069;
 bh=iFutKRl84tB+OHAqsH/civWYosjG/ZKDB8lYJszvT0Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T2wDR8QVtvpxxx5msW/HsXCpTB2Wrl5WZkhPjNWeBGiYnIXy2Vvv7VZcVv99HcL7q
 L4g9dNcFIbyEOStZvXtU3vWRwoXVc/Ln48MVdvpqtUwwfc2X+0QVc87OfTEzh2Ly8D
 bgF7eArWhcJuZh7g6PsJZfqyuQXYFA/e9LaBInm2a2TUlHYsaLS2/9TxXX6OYu0Np3
 KvuE6Gs/vhFyYUK2yqt1ipfVe93Gb/eVAeEYQuSXG4ZGAL4vvbQpDu7q+H8OfsHpYv
 OhVtQaFLC3hvPY2KLorVDPp0GMkTVURUuNlJwXo3sRD4T4XlHa64YA/QXAFLsxxybT
 yptLI8SedB9kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] powerpc/xive: fix use-after-free of xive_ipis
To: "Gou Hao" <gouhao@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724022851.466017-4-gouhao@uniontech.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
 <20260724022851.466017-4-gouhao@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 02:44:28 +0000
Message-Id: <20260724024429.112401F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Incomplete fix: NULL pointer dereference on secondary CPU bring-up.
- [High] Missing error propagation from xive_setup_cpu_ipi().
--

--- Patch [3]: [PATCH v2 3/6] powerpc/xive: fix use-after-free of xive_ipis=
 ---
commit da9c3cedc79737a7541cbdd8b690abe6862a200e
Author: Gou Hao <gouhao@uniontech.com>

powerpc/xive: fix use-after-free of xive_ipis

This commit propagates the error from xive_init_ipis() through
xive_smp_probe() to pnv_smp_probe() and pSeries_smp_probe(). It allows
the boot sequence to cleanly abort XIVE IPI setup if the initial allocation
fails.

> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platform=
s/powernv/smp.c
> index 8f41ef364fc6f..b1201dbafcaf6 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -332,10 +332,12 @@ static void pnv_cause_ipi(int cpu)
> =20
>  static void __init pnv_smp_probe(void)
>  {
> -	if (xive_enabled())
> -		xive_smp_probe();
> -	else
> +	if (xive_enabled()) {
> +		if (xive_smp_probe() < 0)
> +			return;

[Severity: High]
This is a pre-existing issue, but does this early return leave XIVE
globally enabled if initialization fails?

Later during boot, SMP bring-up calls xive_smp_prepare_cpu() for secondary
CPUs because xive_enabled() remains true.

This unconditionally invokes xive_setup_cpu_ipi(), which calls
xive_ipi_cpu_to_irq() and dereferences the xive_ipis array pointer:

arch/powerpc/sysdev/xive/common.c:xive_ipi_cpu_to_irq()
    ...
    return xive_ipis[early_cpu_to_node(cpu)].irq;
    ...

Since xive_init_ipis() frees xive_ipis and sets it to NULL on failure,
could this cause a NULL pointer dereference on secondary CPU bring-up?

> +	} else {
>  		xics_smp_probe();
> +	}

[ ... ]

> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive=
/common.c
> index f9a1229cede73..bb6ce07c1699e 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1256,10 +1256,14 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned=
 int cpu, struct xive_cpu *xc)
> =20
>  int __init xive_smp_probe(void)
>  {
> +	int ret;
> +
>  	smp_ops->cause_ipi =3D xive_cause_ipi;
> =20
>  	/* Register the IPI */
> -	xive_init_ipis();
> +	ret =3D xive_init_ipis();
> +	if (ret < 0)
> +		return ret;
> =20
>  	/* Allocate and setup IPI for the boot CPU */
>  	xive_setup_cpu_ipi(smp_processor_id());

[Severity: High]
This is a pre-existing issue, but shouldn't the return value of
xive_setup_cpu_ipi() be checked and propagated here?

If hardware IPI allocation or configuration fails (e.g., returning -EIO),
the error code is ignored and xive_smp_probe() returns 0 to its caller.

Could this lead to the boot process continuing with uninitialized hardware
IPIs on the boot CPU, eventually resulting in a system hang due to missing
cross-CPU interrupts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724022851.4660=
17-1-gouhao@uniontech.com?part=3D3
