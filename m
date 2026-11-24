Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03E606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MCFGb6oi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0904210F543;
	Tue, 24 Nov 2026 12:19:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 687AC10F543
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:19:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03050339
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 04:19:15 -0800 (PST)
Received: from [10.2.11.19] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 AA38E3F632
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 04:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795522757; bh=fy8LvUxVco45rPYAg/8+0Y0711j3GbM8FlbMCmL5I/w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MCFGb6oiHhiSbuHWuknghFv1lzrGHIsle7Eegz6DA80oF8h/sby836lrenQ5ecTOE
 Q9CXeFDBZU0TJ9lZWxDga4L042SAHGBgd4Vne4+8jAEW7qCvStfvMgnk1jQubPm+NA
 7/sAgunRMmjHR87Jj71DZNqm4irOKwF26REGIYsY=
Date: Tue, 24 Nov 2026 12:19:07 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Haoming Gao <Naixumogu@whut.edu.cn>
Cc: boris.brezillon@collabora.com, adrian.larumbe@collabora.com,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix overflow in fdinfo engine time conversion
Message-ID: <awWAu9ESYXXygiLP@e142607>
References: <20261121152728.210765-1-Naixumogu@whut.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261121152728.210765-1-Naixumogu@whut.edu.cn>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 11:27:28PM +0800, Haoming Gao wrote:
> The timestamp counter accumulates GPU ticks per DRM client. Multiplying
> that counter by NSEC_PER_SEC in u64 can overflow before the division by
> the timer frequency, even when the result in nanoseconds fits in u64.
> 
> On an RK3588 with a 24 MHz timer, drm-engine-panthor dropped from
> 768569012750 ns to 422647638 ns between two reads of the same client's
> fdinfo. The GPU cycle counter continued to advance.
> 
> Use mul_u64_u64_div_u64_roundup() to preserve the full product and keep
> the existing rounding. The helper was checked against a 128-bit
> reference on the board, including at the first wrap boundary.
> 
> Fixes: e16635d88fa0 ("drm/panthor: add DRM fdinfo support")
> Signed-off-by: Haoming Gao <Naixumogu@whut.edu.cn>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index dc8d0191aef4..39b827a9b9cc 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -8,6 +8,7 @@
>  #endif
>  
>  #include <linux/list.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/pagemap.h>
> @@ -1708,8 +1709,8 @@ static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
>  	if (ptdev->profile_mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP) {
>  #ifdef CONFIG_ARM_ARCH_TIMER
>  		drm_printf(p, "drm-engine-panthor:\t%llu ns\n",
> -			   DIV_ROUND_UP_ULL((pfile->stats.time * NSEC_PER_SEC),
> -					    arch_timer_get_cntfrq()));
> +			   mul_u64_u64_div_u64_roundup(pfile->stats.time, NSEC_PER_SEC,
> +						       arch_timer_get_cntfrq()));
>  #endif
>  	}
>  	if (ptdev->profile_mask & PANTHOR_DEVICE_PROFILING_CYCLES)
> 
> base-commit: 878c885830ef004a32e8974c4d1ae14e2ea30c5a
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
