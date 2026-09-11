Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE30EC88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49D110F547;
	Fri, 11 Sep 2026 08:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kL6SNVtQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEF010F547
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:04:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 085D3601EF;
 Fri, 11 Sep 2026 08:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8613B1F00898;
 Fri, 11 Sep 2026 08:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789113880;
 bh=6oyR78L6RvmW/iegEFLJ89GSvTnmJ7dc2Cgkj6woXzo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kL6SNVtQzmMQpwZlvy3C9xG3WV5CLKgwtHchQarvOlnkOQjsPgwS66ykIeaCu/i5B
 o0bMNb9PnAvn9xdvnu2XIhvlszJcDvJTowG8KjLMIg8qbLbQpxVA+tx2v9Qa1HUaGR
 t1qKXhdkvpqx9uEUwaKmDnzMg55HCpXBTyAqayVenxZiS+HGhvPWlJCETttEjP/Blh
 9zv+DJEXu8JRLzGfTR2XVcMGqDkftgygK5UGC5uVA1JNwL09NAGyOgGDy76OyXU4MZ
 LBj+kTtP0Zv+yvrHyjenF8WrhzCzsadZnhjCeaw8hmKPk0O4QLRRYZE+zGDvCLoFBf
 3asWcvHiHUzNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/13] agp/nvidia: Stop using 32-bit MSR interfaces
To: "Juergen Gross" <jgross@suse.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911074530.3140830-6-jgross@suse.com>
References: <20260911074530.3140830-1-jgross@suse.com>
 <20260911074530.3140830-6-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:04:40 +0000
Message-Id: <20260911080440.8613B1F00898@smtp.kernel.org>
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
- [High] Per-CPU MSR read-modify-write and paired updates are performed wit=
hout disabling preemption, risking cross-CPU corruption on migration.
- [High] Infinite loop during TLB flush caused by a missing timeout break s=
tatement.
--

commit 7751b392f6b4d557ed9824450e0e222fa5475b9b
Author: Juergen Gross <jgross@suse.com>

agp/nvidia: Stop using 32-bit MSR interfaces

The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
removed. This commit replaces them with the related 64-bit variants.

> diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
> index 4787391bb6b4f..3e760bc00afaa 100644
> --- a/drivers/char/agp/nvidia-agp.c
> +++ b/drivers/char/agp/nvidia-agp.c

[ ... ]

> @@ -89,16 +87,16 @@ static int nvidia_init_iorr(u32 base, u32 size)
>  		if (iorr_addr >=3D AMD_K7_NUM_IORR)
>  			return -EINVAL;
>  	}
> -    base_hi =3D 0x0;
> -    base_lo =3D (base & ~0xfff) | 0x18;
> -    mask_hi =3D 0xf;
> -    mask_lo =3D ((~(size - 1)) & 0xfffff000) | 0x800;
> -    wrmsr(IORR_BASE0 + 2 * iorr_addr, base_lo, base_hi);
> -    wrmsr(IORR_MASK0 + 2 * iorr_addr, mask_lo, mask_hi);
> -
> -    rdmsr(SYSCFG, sys_lo, sys_hi);
> -    sys_lo |=3D 0x00100000;
> -    wrmsr(SYSCFG, sys_lo, sys_hi);
> +    base_msr.h =3D 0x0;
> +    base_msr.l =3D (base & ~0xfff) | 0x18;
> +    mask_msr.h =3D 0xf;
> +    mask_msr.l =3D ((~(size - 1)) & 0xfffff000) | 0x800;
> +    wrmsrq(IORR_BASE0 + 2 * iorr_addr, base_msr.q);
> +    wrmsrq(IORR_MASK0 + 2 * iorr_addr, mask_msr.q);
> +
> +    rdmsrq(SYSCFG, sys_msr.q);
> +    sys_msr.l |=3D 0x00100000;
> +    wrmsrq(SYSCFG, sys_msr.q);

[Severity: High]
This isn't a bug introduced by this patch, but does this per-CPU MSR
read-modify-write sequence need to run with preemption disabled?

Because nvidia_init_iorr() is called during device probe and resume in
standard process context, could the thread be preempted and migrated to
another CPU between reading the MSR and writing it? If so, the target
CPU's MSR could be overwritten with the source CPU's state.

Similarly, could paired MSR updates (BASE and MASK) be split across two
CPUs if a migration occurs here, leaving both in a corrupted state?

> =20
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a potential issue in nvidia_tlbflush():

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

Should this loop break when the 3-second timeout is reached?

If the hardware fails to clear the wbc_mask bit, there is no sleep or break
mechanism, which seems like it could lead to an infinite loop and spam
the syslog indefinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911074530.3140=
830-1-jgross@suse.com?part=3D5
