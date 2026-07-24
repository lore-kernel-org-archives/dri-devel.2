Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C68C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C19910E619;
	Fri, 24 Jul 2026 09:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hB5xMOis";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E205E10E619
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 09:52:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64AB0600AB;
 Fri, 24 Jul 2026 09:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AB01F000E9;
 Fri, 24 Jul 2026 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784886776;
 bh=Ory928+6pZUntvdVDzNb8rVSb/UwWi9P+FeFBzyzG5I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hB5xMOisMtHOs2Ot7banv1QA2/QzPMJF5IR5RpBDIoA9e39Qu0+4TPR5aUHCk0UWa
 fAC/knvz2bHgMDaDAejKbgkaCF+jYyGSW2cJ8QMEJMKMWvGkyp7ItSCjYSycy+nD/G
 IcewPBUw9ZYYEKf+0GkWFuQwQM13nFhpAFowHPFUuOV2KDNqBPhH6MT/KG7IBuIeM4
 CM7+RWdIG11hL4+siHFOFFUDIFOfSzRlDhTsNP9TcoVnI4kamoohRQ0mKlJBtKRJKa
 +UEMa0jvasDM8XjKS+C7HSkCDEUweF3SgqgN9l2zK8pzXnoVZvRT3BKyyI2xLvZE0L
 D+py8/UUiFKSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] iosys-map: Add getter functions for virtual addresses
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724093808.776138-1-oushixiong1025@163.com>
References: <20260724093808.776138-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 09:52:55 +0000
Message-Id: <20260724095255.E6AB01F000E9@smtp.kernel.org>
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
- [Medium] iosys_map_get_vaddr_iomem() unconditionally triggers a kernel wa=
rning (WARN_ON) when called on an unset mapping, contradicting its document=
ation.
- [Low] The patch adds `iosys_map_get_vaddr` to `include/linux/iosys-map.h`=
 but fails to remove the pre-existing static inline definition in `drivers/=
firmware/tegra/ivc.c`, causing a build failure.
- [Low] Missing <linux/bug.h> include for WARN_ON(), leading to potential b=
uild breaks.
--

--- Patch [1]: [PATCH 1/2] iosys-map: Add getter functions for virtual addr=
esses ---
commit f14cef96efd32780d25ba0c941cea2c91611ddcd
Author: Shixiong Ou <oushixiong@kylinos.cn>

iosys-map: Add getter functions for virtual addresses

Add iosys_map_get_vaddr() and iosys_map_get_vaddr_iomem() as the
counterparts to iosys_map_set_vaddr() and iosys_map_set_vaddr_iomem().

This allows drivers to use the iosys_map abstraction layer properly
instead of directly accessing the structure members, improving code
maintainability and safety.

> diff --git a/include/linux/iosys-map.h b/include/linux/iosys-map.h
> index 3e85afe794c0a..658d5038498a7 100644
> --- a/include/linux/iosys-map.h
> +++ b/include/linux/iosys-map.h
> @@ -200,6 +200,42 @@ static inline void iosys_map_set_vaddr_iomem(struct =
iosys_map *map,
>  	map->is_iomem =3D true;
>  }
> =20
> +/**
> + * iosys_map_get_vaddr - Gets the virtual address of a system-memory map=
ping
> + * @map:	The iosys_map structure
> + *
> + * Returns the system-memory address. The caller must ensure the mapping
> + * refers to system memory (not I/O memory).
> + *
> + * Returns:
> + * The system-memory address, or NULL if the mapping is not set or refers
> + * to I/O memory.
> + */
> +static inline void *iosys_map_get_vaddr(const struct iosys_map *map)
> +{
> +	if (WARN_ON(map->is_iomem))
> +		return NULL;

[Severity: Low]
Does this new usage of WARN_ON() require adding an include for <linux/bug.h=
>?

Files including <linux/iosys-map.h> that don't already include <linux/bug.h>
might fail to compile due to implicit declaration of the function.

[Severity: Low]
Could this conflict with the existing static inline definition of
iosys_map_get_vaddr() in drivers/firmware/tegra/ivc.c?

drivers/firmware/tegra/ivc.c already defines this function locally:

static inline void *iosys_map_get_vaddr(const struct iosys_map *map)
{
	if (WARN_ON(map->is_iomem))
		return NULL;
	return map->vaddr;
}

It appears drivers/firmware/tegra/ivc.c might encounter a build failure due
to function redefinition since it includes <linux/iosys-map.h> through
<soc/tegra/ivc.h>.

> +	return map->vaddr;
> +}
> +
> +/**
> + * iosys_map_get_vaddr_iomem - Gets the virtual address of an I/O-memory=
 mapping
> + * @map:	The iosys_map structure
> + *
> + * Returns the I/O-memory address. The caller must ensure the mapping
> + * refers to I/O memory (not system memory).
> + *
> + * Returns:
> + * The I/O-memory address, or NULL if the mapping is not set or refers
> + * to system memory.
> + */
> +static inline void __iomem *iosys_map_get_vaddr_iomem(const struct iosys=
_map *map)
> +{
> +	if (WARN_ON(!map->is_iomem))

[Severity: Medium]
Will this unconditionally trigger a kernel warning for an unset mapping?

The kernel-doc for this function says it returns NULL if the mapping is not
set. However, if iosys_map_clear() is called, the structure is zeroed and
map->is_iomem becomes false.

Calling iosys_map_get_vaddr_iomem() on this cleared mapping would then eval=
uate
!map->is_iomem as true and trigger the WARN_ON.

> +		return NULL;
> +	return map->vaddr_iomem;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724093808.7761=
38-1-oushixiong1025@163.com?part=3D1
