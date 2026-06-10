Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6B4CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F84C10E1AC;
	Wed, 10 Jun 2026 15:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="tHtgDLWe";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9581710EA96
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:50:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2352822C8;
 Wed, 10 Jun 2026 08:50:39 -0700 (PDT)
Received: from [10.57.29.87] (unknown [10.57.29.87])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71B303F99C;
 Wed, 10 Jun 2026 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781106643; bh=AC2CtmNBNABy5OdkjA74aKJda+g8Vv0KQiNLTs/R2F8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tHtgDLWebpdq3pZKdM0S15Jnhee4Chp0Cionot9c2NJbCiZFj7r2RsAW/vvPgdSXq
 E+tqi/Ymo4bxdWBH5JRnvMzdgLr61GPqAIBv9kdQKPZxquUKTWtdaUZennyRt8mAYx
 xCCTBw2hsFYR0a2L2/4WeFRZEdWdRuqI1qhFtwNk=
Message-ID: <3ad7dabb-85de-474c-a02f-2cf4aa317f31@arm.com>
Date: Wed, 10 Jun 2026 16:50:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/18] drm/panthor: Move register access helpers out
 of panthor_device.h
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-3-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260528150546.3168527-3-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 28/05/2026 16:05, Karunika Choo wrote:
> panthor_device.h should describe the panthor device state, not provide
> generic MMIO helpers.
> 
> Move the register accessors and poll-timeout wrappers to a dedicated
> panthor_device_io.h header and include it from the users that need MMIO
> access. This makes the dependency explicit and avoids pulling the full
> device definition into code that only needs register helpers.
> 
> No functional change.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.h    | 72 ------------------
>  drivers/gpu/drm/panthor/panthor_device_io.h | 81 +++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_fw.c        |  1 +
>  drivers/gpu/drm/panthor/panthor_gpu.c       |  1 +
>  drivers/gpu/drm/panthor/panthor_hw.c        |  1 +
>  drivers/gpu/drm/panthor/panthor_mmu.c       |  1 +
>  drivers/gpu/drm/panthor/panthor_pwr.c       |  1 +
>  7 files changed, 86 insertions(+), 72 deletions(-)
>  create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 4e4607bca7cc..c376e52e8564 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -6,7 +6,6 @@
>  #ifndef __PANTHOR_DEVICE_H__
>  #define __PANTHOR_DEVICE_H__
>  
> -#include <linux/atomic.h>
>  #include <linux/io-pgtable.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
> @@ -630,75 +629,4 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
>  
>  extern struct workqueue_struct *panthor_cleanup_wq;
>  
> -static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
> -{
> -	writel(data, iomem + reg);
> -}
> -
> -static inline u32 gpu_read(void __iomem *iomem, u32 reg)
> -{
> -	return readl(iomem + reg);
> -}

This is a bit ugly at the moment because further down in this file
you've still got calls to gpu_read() (in the PANTHOR_IRQ_HANDLER macro).
This of course does build but means that macros are broken unless
panthor_device_io.h is also included.

I think once Boris' change[1] to the IRQ macro machinery lands this will
resolve itself.

Thanks,
Steve

[1]
https://lore.kernel.org/all/20260512-panthor-signal-from-irq-v2-3-95c614a739cb@collabora.com/

> -
> -static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
> -{
> -	return readl_relaxed(iomem + reg);
> -}
> -
> -static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
> -{
> -	gpu_write(iomem, reg, lower_32_bits(data));
> -	gpu_write(iomem, reg + 4, upper_32_bits(data));
> -}
> -
> -static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
> -{
> -	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
> -}
> -
> -static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
> -{
> -	return (gpu_read_relaxed(iomem, reg) |
> -		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
> -}
> -
> -static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
> -{
> -	u32 lo, hi1, hi2;
> -	do {
> -		hi1 = gpu_read(iomem, reg + 4);
> -		lo = gpu_read(iomem, reg);
> -		hi2 = gpu_read(iomem, reg + 4);
> -	} while (hi1 != hi2);
> -	return lo | ((u64)hi2 << 32);
> -}
> -
> -#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
> -	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
> -			  iomem, reg)
> -
> -#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
> -				     timeout_us)				\
> -	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
> -				 false, iomem, reg)
> -
> -#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
> -	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
> -			  iomem, reg)
> -
> -#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
> -				       timeout_us)				\
> -	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
> -				 false, iomem, reg)
> -
> -#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
> -					     timeout_us)			\
> -	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
> -				 timeout_us, false, iomem, reg)
> -
> -#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
> -					timeout_us)				\
> -	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
> -			  false, iomem, reg)
> -
>  #endif
> diff --git a/drivers/gpu/drm/panthor/panthor_device_io.h b/drivers/gpu/drm/panthor/panthor_device_io.h
> new file mode 100644
> index 000000000000..54e206c6aaa5
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_device_io.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
> +/* Copyright 2026 ARM Limited. All rights reserved. */
> +
> +#ifndef __PANTHOR_DEVICE_IO_H__
> +#define __PANTHOR_DEVICE_IO_H__
> +
> +#include <linux/atomic.h>
> +#include <linux/io.h>
> +
> +static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
> +{
> +	writel(data, iomem + reg);
> +}
> +
> +static inline u32 gpu_read(void __iomem *iomem, u32 reg)
> +{
> +	return readl(iomem + reg);
> +}
> +
> +static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
> +{
> +	return readl_relaxed(iomem + reg);
> +}
> +
> +static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
> +{
> +	gpu_write(iomem, reg, lower_32_bits(data));
> +	gpu_write(iomem, reg + 4, upper_32_bits(data));
> +}
> +
> +static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
> +{
> +	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
> +}
> +
> +static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
> +{
> +	return (gpu_read_relaxed(iomem, reg) |
> +		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
> +}
> +
> +static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
> +{
> +	u32 lo, hi1, hi2;
> +	do {
> +		hi1 = gpu_read(iomem, reg + 4);
> +		lo = gpu_read(iomem, reg);
> +		hi2 = gpu_read(iomem, reg + 4);
> +	} while (hi1 != hi2);
> +	return lo | ((u64)hi2 << 32);
> +}
> +
> +#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
> +	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
> +			  iomem, reg)
> +
> +#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
> +				     timeout_us)				\
> +	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
> +				 false, iomem, reg)
> +
> +#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
> +	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
> +			  iomem, reg)
> +
> +#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
> +				       timeout_us)				\
> +	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
> +				 false, iomem, reg)
> +
> +#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
> +					     timeout_us)			\
> +	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
> +				 timeout_us, false, iomem, reg)
> +
> +#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
> +					timeout_us)				\
> +	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
> +			  false, iomem, reg)
> +
> +#endif /* __PANTHOR_DEVICE_IO_H__ */
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 986151681b24..52f176644aa6 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -19,6 +19,7 @@
>  #include <drm/drm_print.h>
>  
>  #include "panthor_device.h"
> +#include "panthor_device_io.h"
>  #include "panthor_fw.h"
>  #include "panthor_fw_regs.h"
>  #include "panthor_gem.h"
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index e52c5675981f..b63a33fe155e 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -18,6 +18,7 @@
>  #include <drm/drm_print.h>
>  
>  #include "panthor_device.h"
> +#include "panthor_device_io.h"
>  #include "panthor_gpu.h"
>  #include "panthor_gpu_regs.h"
>  #include "panthor_hw.h"
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 4c96573b649a..5cf54028f606 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -7,6 +7,7 @@
>  #include <drm/drm_print.h>
>  
>  #include "panthor_device.h"
> +#include "panthor_device_io.h"
>  #include "panthor_gpu.h"
>  #include "panthor_gpu_regs.h"
>  #include "panthor_hw.h"
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 452d0b6d4668..48127313332f 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -31,6 +31,7 @@
>  #include <linux/sizes.h>
>  
>  #include "panthor_device.h"
> +#include "panthor_device_io.h"
>  #include "panthor_gem.h"
>  #include "panthor_gpu.h"
>  #include "panthor_gpu_regs.h"
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index 7c7f424a1436..1cba093a2452 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -11,6 +11,7 @@
>  #include <drm/drm_print.h>
>  
>  #include "panthor_device.h"
> +#include "panthor_device_io.h"
>  #include "panthor_gpu_regs.h"
>  #include "panthor_hw.h"
>  #include "panthor_pwr.h"

