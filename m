Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB653CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3020310F387;
	Mon,  8 Jun 2026 13:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XV33uoiL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1549C10F387
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780924062;
 bh=TWhx/12oUFfngY/BubTexh5vA5uldpQZtdFGfasuiv0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XV33uoiL6dTLyzq3Ii3YhmSn3MxGMKCMuMhmSnLnSbkNZA7SFzQQ4iCvGN26voyQ/
 RDUFWaK0/ElFDM2SAv/qOE3CXNBzQOWBKLePR4fDYSrObnxl229dlQnQShOlQbv40O
 h2qkZkKQ3A9XUVA1lMeJmNl/aII3+Dm7QI3QBJakwv7nIi07gX8D4GxbrGXNfgSpJc
 EnEmolg19mY5KVp3qOcN0SFM69FhMYBLmIFPqrHP9+KPQq8RWyTtp/H329pv28+sCe
 HrFeTmI1Y0rnWJJ0NdXUQkmc0HT/Cu56mgYvc7g3jWiNwYBy+RVobkVRde/YK9ipPg
 vCZYiGlT/hySw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5F83E17E023C;
 Mon,  8 Jun 2026 15:07:42 +0200 (CEST)
Date: Mon, 8 Jun 2026 15:07:38 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/18] drm/panthor: Move register access helpers out
 of panthor_device.h
Message-ID: <20260608150738.65210991@fedora-2.home>
In-Reply-To: <20260528150546.3168527-3-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-3-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 28 May 2026 16:05:30 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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

