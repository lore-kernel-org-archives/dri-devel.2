Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A43CC5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE2B10F0AC;
	Thu, 20 Aug 2026 15:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kyaNfeC6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C346910F0B0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 15:17:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B542860A58;
 Thu, 20 Aug 2026 15:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A141F000E9;
 Thu, 20 Aug 2026 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787239069;
 bh=JB1xb4G0mFZ/KXa6zzxbmpLvovbvjZuKScA8ZVwccKo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kyaNfeC6nnsVtyjsrl/2NzU0iVBMsJHxi7jJcl747R1oMIoYUR3/RwX73d8GfFAem
 UuC4fJl6etm7TBjXHqgjRc0K0GN/KYjmFqQCe+NDUjqqHqqKGO26ZPVS7PqrvhrPty
 RCPRHmTUiLLHxKiXx3V7ZXUVDdUd7s84SF7d5/sp60o5ej6K6w0L45jOQvMrWz9Fwk
 wWPmXKoS+JejxUq3H9ptl6hPpX8T9xAvk+WxXG3qJUKlJwFanAZenPf7IrFdNh2Aa3
 eRbIHO1UEyTzV4KS5M8484DmM8Nun0SaO6a6DXEOgJFDOul4U2tw16NDpGHM6pYasL
 rUHS9/OGeS0Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] irqchip/gic-v3-its: Allocate VPE tables from
 sleepable context
To: "Steven Price" <steven.price@arm.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260820150034.88729-3-steven.price@arm.com>
References: <20260820150034.88729-1-steven.price@arm.com>
 <20260820150034.88729-3-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 15:17:48 +0000
Message-Id: <20260820151749.38A141F000E9@smtp.kernel.org>
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
- [High] Moving VPE L1 table allocation to a late CPU hotplug state exposes=
 uninitialized GICv4.1 redistributor state to concurrent VPE mappings.
--

--- Patch [2]: [PATCH v2 2/4] irqchip/gic-v3-its: Allocate VPE tables from =
sleepable context ---
commit 7ed963cf27a623f2c21ad61ef0162e3eddac65ae
Author: Steven Price <steven.price@arm.com>

irqchip/gic-v3-its: Allocate VPE tables from sleepable context

This patch moves the VPE L1 table allocation from the early CPU-starting
hotplug state to the later CPU-online callback. This permits the use of
GFP_KERNEL allocations, as its_alloc_pages() can sleep. The CPU-online
callback is now registered unconditionally to handle this setup.

> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v=
3-its.c
> index bfd58097261a7..6452888b34fcb 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
[ ... ]
> @@ -3268,16 +3268,6 @@ static void its_cpu_init_lpis(void)
>  		val =3D its_clear_vpend_valid(vlpi_base, 0, 0);
>  	}
> =20
> -	if (allocate_vpe_l1_table()) {
> -		/*
> -		 * If the allocation has failed, we're in massive trouble.
> -		 * Disable direct injection, and pray that no VM was
> -		 * already running...
> -		 */
> -		gic_rdists->has_rvpeid =3D false;
> -		gic_rdists->has_vlpis =3D false;
> -	}
> -
>  	/* Make sure the GIC has seen the above */
>  	dsb(sy);
>  	gic_data_rdist()->flags |=3D RD_LOCAL_LPI_ENABLED;
[ ... ]
> @@ -5454,6 +5444,19 @@ static int its_cpu_memreserve_lpi(unsigned int cpu)
>  	if (gic_data_rdist()->flags & RD_LOCAL_MEMRESERVE_DONE)
>  		return 0;
> =20
> +	if (allocate_vpe_l1_table()) {
> +		/*
> +		 * If the allocation has failed, we're in massive trouble.
> +		 * Disable direct injection, and pray that no VM was
> +		 * already running...
> +		 */
> +		gic_rdists->has_rvpeid =3D false;
> +		gic_rdists->has_vlpis =3D false;
> +	}
> +

[Severity: High]
Does moving this allocation to the CPUHP_AP_ONLINE_DYN callback expose
uninitialized GICv4.1 redistributor state to concurrent VPE mappings?

The CPUHP_AP_ONLINE_DYN state runs for its_cpu_memreserve_lpi() in the hotp=
lug
thread asynchronously after the CPU has already been marked online in
cpu_online_mask.

Could a concurrent process changing IRQ affinities (like irqbalance) observe
the CPU in cpu_online_mask and route a virtual interrupt to it via
its_vpe_set_affinity() before the hotplug thread has executed this table
allocation?

If a VMAPP command executes before allocate_vpe_l1_table() programs the
GICR_VPROPBASER, it appears the hardware could use stale or uninitialized
physical addresses, leading to unpredictable behavior or dropped interrupts.

>  	if (!efi_enabled(EFI_CONFIG_TABLES))
>  		goto out;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820150034.8872=
9-1-steven.price@arm.com?part=3D2
