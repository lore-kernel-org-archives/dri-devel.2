Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5ECC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E6910EE77;
	Tue, 22 Sep 2026 21:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oPhfkUcu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC0710EE77
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:00:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54BE443981;
 Tue, 22 Sep 2026 21:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0961F000FF;
 Tue, 22 Sep 2026 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110816;
 bh=9Sd6Ev1Q4VByW1/vDoQKB80QdXb3R+LoiAFMcDjbd3I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oPhfkUcubxBqLIYmVonL0Lj+jziVwQgvqyFaUIz2eRo33wP1Jj14ltDHztjhraQbu
 Wdcm+ndBT4fDu7NWPHMm8/7+9EGKWD20ZZcOBAeyIDLOmn3A6Sh0RMvuGa6cY8BCL2
 HF+yLyBuC/oLTytHGCDOiJJRAbGOLJxRzLrwOg36miL+JqXovQcomSuPwx/iw8ZySS
 6pj0Ga92+vP0pKBK3ap2KtOSDE6MjQV9qLoIDaJ5mzs4Ugjjp6qEAPTsEx0FH33kAE
 OQ34G9P3Kc5pI9gx6kPK7Mrgcr48r4DYWJ/ZEJx5Z1fo88a8TuBR4YHaInWbNO6/j/
 MJ+9awH7xwcwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/27] drm/panthor: Derive MMU AS register addresses
 from base and stride
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-7-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-7-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:00:15 +0000
Message-Id: <20260922210016.0C0961F000FF@smtp.kernel.org>
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
- [High] panthor: NULL pointer dereference in MMU IRQ handler on spurious i=
nterrupts
--

commit 9aecd8c0de2222b2839590424b986eaecb02eee6
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Derive MMU AS register addresses from base and stride

This commit moves the MMU address-space register layout into the hardware
description. It computes the iomem pointer for each AS slot based on the ba=
se
offset and per-AS stride to prepare for GPUs with non-fixed MMU AS register
regions.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index d75d575473da4..169550413a1a5 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1871,8 +1877,8 @@ static void panthor_mmu_irq_handler(struct panthor_=
irq *pirq, u32 status)
>  		u32 access_type;
>  		u32 source_id;
> =20
> -		fault_status =3D gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
> -		addr =3D gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
> +		fault_status =3D gpu_read(as_iomem(mmu, as), AS_FAULTSTATUS);
> +		addr =3D gpu_read64(as_iomem(mmu, as), AS_FAULTADDRESS);

[Severity: High]
Could this lead to a NULL pointer dereference on a spurious interrupt?

If the MMU interrupt status register has bits set for non-present AS slots
(such as from a hardware glitch, or reading 0xFFFFFFFF during a device
unplug or reset state), the loop in panthor_mmu_irq_handler() will process
these unpopulated slots.

Since as_iomem() returns NULL for slots that weren't initialized, passing
that NULL pointer to gpu_read() would trigger a kernel crash.

[ ... ]

> @@ -3408,7 +3417,13 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
> =20
> -	mmu->iomem =3D ptdev->iomem + MMU_AS_BASE;
> +	for_each_set_bit(as_id, &as_present_mask, MAX_AS_SLOTS) {
> +		u64 offset =3D regbank->offset + (regbank->stride * as_id);
> +
> +		guard(mutex)(&mmu->as.slots_lock);
> +		mmu->as.slots[as_id].iomem =3D ptdev->iomem + offset;
> +	}
> +

[Severity: High]
Because we only initialize the iomem pointers for present AS slots here,
the remaining array elements are left as NULL. Is there a need to guard
against accessing uninitialized slots in panthor_mmu_irq_handler() before
calling as_iomem() to prevent the issue mentioned above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D6
