Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B46AC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C914A10EE69;
	Tue, 22 Sep 2026 20:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZwHBugrd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B052310EE69
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:54:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DD264057F;
 Tue, 22 Sep 2026 20:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263661F000FF;
 Tue, 22 Sep 2026 20:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110481;
 bh=8g82BDbtih9kTZ6PGF+nIr3UKL4tyRrrlfAOFA3vU+8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZwHBugrdw9uxskSpiX09vczVdrkgPbsAsPk2deIro7iT5yjoZi6krjRcg5qipW09K
 FXUNXJ5CNrIurt1D/vD7DH60DgK6rGz6KF4PcCC1nlRtcft8Yrsb0uyBS9NHavLU3O
 AO5IpeFUmF2OxGjt620EM2qDp7Tg8xkdJyXrEDkbuU7F+LMfab5L2tcJve9AiIrIni
 Epbu0d4Mhmay8sK5x66y/2sTum2h9YHynMilakaKbx/0g63wM5afz9MCdwwktfo3kW
 nKgxfz/FgZvr8sz/LPomDqwE1ajeuuDUQr+4QdbtkELRUoHb70YbSWI6yXF8/2i7Nu
 78ofsZn7bm6mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/27] drm/panthor: Move register access helpers out
 of panthor_device.h
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-3-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-3-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:54:40 +0000
Message-Id: <20260922205441.263661F000FF@smtp.kernel.org>
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
- [Low] drm/panthor: missing and incorrect header dependencies in panthor_d=
evice_io.h
--

commit 4a15e81aefbe1480e274e929d06e5e1ad5234842
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Move register access helpers out of panthor_device.h

Move register access helpers out of panthor_device.h to allow reuse by
other panthor drivers that will be added to enable v15 support.

> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> index b55a3f9edd414..54031c5252473 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -6,7 +6,6 @@
>  #ifndef __PANTHOR_DEVICE_H__
>  #define __PANTHOR_DEVICE_H__
> =20
> -#include <linux/atomic.h>

[Severity: Low]
Is it okay to remove <linux/atomic.h> here? struct panthor_device (defined
further down in this file) relies heavily on atomic_t, such as for
retry_count and pending reset state. It seems to currently rely on
transitive inclusion from the newly added panthor_device_io.h.

>  #include <linux/io-pgtable.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>

[ ... ]

> diff --git a/drivers/gpu/drm/panthor/panthor_device_io.h b/drivers/gpu/dr=
m/panthor/panthor_device_io.h
> new file mode 100644
> index 0000000000000..2287a0d9f86c2
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_device_io.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
> +/* Copyright 2026 ARM Limited. All rights reserved. */
> +
> +#ifndef __PANTHOR_DEVICE_IO_H__
> +#define __PANTHOR_DEVICE_IO_H__
> +
> +#include <linux/atomic.h>

[Severity: Low]
Does this file actually need <linux/atomic.h>? It doesn't appear to use any
atomic types.

> +#include <linux/io.h>
> +
> +
> +static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
> +{
> +	writel(data, iomem + reg);
> +}

[ ... ]

> +static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
> +{
> +	gpu_write(iomem, reg, lower_32_bits(data));
> +	gpu_write(iomem, reg + 4, upper_32_bits(data));
> +}

[Severity: Low]
Should <linux/wordpart.h> be included for lower_32_bits() and
upper_32_bits()? Files including this header directly might fail to build if
the dependency isn't met transitively.

> +static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
> +{
> +	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
> +}

[ ... ]

> +static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
> +{
> +	u32 lo, hi1, hi2;
> +	do {
> +		hi1 =3D gpu_read(iomem, reg + 4);
> +		lo =3D gpu_read(iomem, reg);
> +		hi2 =3D gpu_read(iomem, reg + 4);
> +	} while (hi1 !=3D hi2);
> +	return lo | ((u64)hi2 << 32);
> +}
> +
> +#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_u=
s)	\
> +	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
> +			  iomem, reg)

[Severity: Low]
Should <linux/iopoll.h> be included here for the read_poll_timeout() macros?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D2
