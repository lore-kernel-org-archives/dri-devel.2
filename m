Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A6DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF3C10E032;
	Mon, 29 Jun 2026 06:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S7QUsexC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C9B10E032
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:25:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 096D340952;
 Mon, 29 Jun 2026 06:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B615C1F000E9;
 Mon, 29 Jun 2026 06:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782714327;
 bh=+fIEM7v2Hmb8uxLTx4z2TdFkTr9yxAfqxrqH2zMJ5us=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S7QUsexCpDNWhK/B+pAIn6G3n6Ryq4bEe5jT1CI6WFOSpJliXFhedJip5E6tpiico
 3G3V/sSt6DoOCdfdfHEma6nG9PdeilwqQPurMDTIONXEbSYB+0adk3qSKIzHzcng9k
 Te7bW+DePw/ppXCqfjXQTI3iqQ9Wh9fb0IzX5aN3XIbCMnsd4CSIYB4OoSLe26v3k5
 PJdYjdBL0Noe63MQGxYUEOG8rgwVJ/w01aCPEEWpu32JJeG/k2vROOYMvWP22ckqFI
 ULqjNLeM+czuCkyN0o7TjtCYzxha+a4GLjJsBjOB+tFkl8Og+nrrj83WZjuDWFM0eq
 aZl3FFW7YBBoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/32] agp/nvidia: Stop using 32-bit MSR interfaces
To: "Juergen Gross" <jgross@suse.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629060526.3638272-22-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-22-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:25:23 +0000
Message-Id: <20260629062527.B615C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a memor=
y leak of the ioremap virtual memory area on suspend/resume.
- [High] This problem wasn't introduced by this patch, but an ignored initi=
alization error on resume leads to a guaranteed NULL pointer dereference in=
 the hardware TLB flush path.
- [High] This problem wasn't introduced by this patch, but a missing break =
in a timeout loop causes a soft lockup if the hardware fails to complete a =
TLB flush.
--

commit 809ee345f7a00dcaa6e844219a8b666a3f9ffadb
Author: Juergen Gross <jgross@suse.com>

agp/nvidia: Stop using 32-bit MSR interfaces

This commit replaces the deprecated 32-bit MSR interfaces rdmsr() and wrmsr=
()
with their 64-bit equivalents in the NVIDIA AGP driver. This is part of a
planned removal of the 32-bit variants.

> diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
> index 4787391bb6b4f..3e760bc00afaa 100644
> --- a/drivers/char/agp/nvidia-agp.c
> +++ b/drivers/char/agp/nvidia-agp.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential memory
leak on suspend/resume.

Does this code leak the vmap area leading to vmalloc space exhaustion after
repeated suspend/resume cycles?

drivers/char/agp/nvidia-agp.c:nvidia_configure() {
...
	/* map aperture */
	apbase_phys =3D pci_resource_start(agp_bridge->dev, AGP_APERTURE_BAR);
	nvidia_private.aperture =3D
		(volatile u32 __iomem *) ioremap(apbase_phys, 33 * PAGE_SIZE);
...
}

Because the driver defines no suspend hook:

drivers/char/agp/nvidia-agp.c:
...
static DEFINE_SIMPLE_DEV_PM_OPS(agp_nvidia_pm_ops, NULL, agp_nvidia_resume);
...

The previous ioremap allocation is never unmapped via iounmap() when the
system suspends.

[Severity: High]
This is a pre-existing issue, but I spotted a potential NULL pointer
dereference in the hardware TLB flush path.

Could a failure in nvidia_configure() during resume lead to a kernel crash?

drivers/char/agp/nvidia-agp.c:agp_nvidia_resume() {
...
	/* reconfigure AGP hardware again */
	nvidia_configure();

	return 0;
}

The return value of nvidia_configure() is ignored. If ioremap fails during
resume, nvidia_configure() returns -ENOMEM and nvidia_private.aperture
remains NULL.=20

Later, when nvidia_tlbflush() is called, it unconditionally dereferences
nvidia_private.aperture:

drivers/char/agp/nvidia-agp.c:nvidia_tlbflush() {
...
	/* flush TLB entries */
	for (i =3D 0; i < 32 + 1; i++)
		temp =3D readl(nvidia_private.aperture+(i * PAGE_SIZE / sizeof(u32)));
...
}

[Severity: High]
This isn't a bug introduced by this patch, but the timeout loop in
nvidia_tlbflush() appears to be missing a break statement.

Can this cause a soft lockup if the hardware fails to complete a TLB flush?

drivers/char/agp/nvidia-agp.c:nvidia_tlbflush() {
...
		end =3D jiffies + 3*HZ;
		do {
			pci_read_config_dword(nvidia_private.dev_1,
					NVIDIA_1_WBC, &wbc_reg);
			if (time_before_eq(end, jiffies)) {
				printk(KERN_ERR PFX
				    "TLB flush took more than 3 seconds.\n");
			}
		} while (wbc_reg & nvidia_private.wbc_mask);
...
}

If the hardware enters an unexpected state and the timeout expires, the code
prints an error message but lacks a break statement to exit the loop, which
could trap the kernel in an infinite loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629060526.3638=
272-1-jgross@suse.com?part=3D21
