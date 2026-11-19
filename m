Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64A606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Vn+ozZgu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E15910FE01;
	Thu, 19 Nov 2026 07:53:55 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7275010FE83
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795074796;
 bh=MUwt9KfpyJd9a2TBoMoV2jG2Vpo8Te/ybW2eWXncKqE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Vn+ozZgutN5WDR8GCmpvLL3pVPuV/A0XSubOkLlYwNSurXN8Ju9lV1QLuVmqdNi1R
 LYjpLeUu3Y/GwkUAkixqWq8KU3CgaWWLKF19aSWSmldiWDkPfQw83UlN7vE12bd2HB
 DNnDWfKI2ChVHA6PY2iNkUPzt7wRq3srk1+5DUwtpYI6qpvREZZ1IB/793+ONpB2sr
 LJysqecSZl5KeXp9P/HK1hUKH3wxh4shxL3lp/l5Yt2/PJsVdgHXimEwXhJYZULZNt
 FZUKO1dXqP5yzqMKHrV69IgoIl6q4TgxbjKTnB3YGRTemTBFNjGPTZrkyYVionn+/a
 Qw9gA5gumrEjA==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A34FC17E047C;
 Thu, 19 Nov 2026 08:53:15 +0100 (CET)
Date: Thu, 19 Nov 2026 08:53:11 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3 03/10] drm/panthor: Move register access helpers out
 of panthor_device.h
Message-ID: <20261119085311.7a53e88e@fedora1.home>
In-Reply-To: <20261118175332.519657-4-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
 <20261118175332.519657-4-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 17:53:19 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> Move register access helpers out of panthor_device.h to allow reuse by
> other panthor drivers that will be added to enable v15 support.
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> v2:
> - Picked up R-b from Liviu
> - Fix includes raised by sashiko
> - Link: https://lore.kernel.org/all/20260922205441.263661F000FF@smtp.kernel.org/
> v1:
> - Includes "panthor_device_io.h" directly in "panthor_device.h" instead
>   of peppering multiple files with the header.
> 
>  drivers/gpu/drm/panthor/panthor_device.h    | 73 +-----------------
>  drivers/gpu/drm/panthor/panthor_device_io.h | 84 +++++++++++++++++++++
>  2 files changed, 86 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index b55a3f9edd414..4add31b12cfd7 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -19,6 +19,8 @@
>  #include <drm/gpu_scheduler.h>
>  #include <drm/panthor_drm.h>
>  
> +#include "panthor_device_io.h"
> +
>  struct panthor_csf;
>  struct panthor_csf_ctx;
>  struct panthor_device;
> @@ -495,77 +497,6 @@ panthor_exception_is_fault(u32 exception_code)
>  const char *panthor_exception_name(struct panthor_device *ptdev,
>  				   u32 exception_code);
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
>  #define INT_RAWSTAT 0x0
>  #define INT_CLEAR   0x4
>  #define INT_MASK    0x8
> diff --git a/drivers/gpu/drm/panthor/panthor_device_io.h b/drivers/gpu/drm/panthor/panthor_device_io.h
> new file mode 100644
> index 0000000000000..ce417c64abb44
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_device_io.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
> +/* Copyright 2026 ARM Limited. All rights reserved. */
> +
> +#ifndef __PANTHOR_DEVICE_IO_H__
> +#define __PANTHOR_DEVICE_IO_H__
> +
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/wordpart.h>
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
> +
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
> +
> +#endif /* __PANTHOR_DEVICE_IO_H__ */

