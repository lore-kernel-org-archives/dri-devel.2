Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7092CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B3C10EDD6;
	Wed,  6 May 2026 15:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="NcQbZM4P";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E59BD10EDD6
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 15:07:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 284A919F6;
 Wed,  6 May 2026 08:06:57 -0700 (PDT)
Received: from [10.57.69.49] (unknown [10.57.69.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A5703F7B4;
 Wed,  6 May 2026 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778080022; bh=lBGCayGvLObt4utL3x/Gntz0gbSLpK2Kdmd/cyJzcXs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NcQbZM4Pxnep1uNs1Um11J1hVT4lQXEnAMaOkFxE3oksqybNtjvFrceF/FnFfkn9g
 jh8S5taoT7IRtqSRtBPfp9E+d0EAnUFMSexiz68GGXUka5oKG0UUBLCj/XQiyWb2wF
 +NbXo5ZBqYWbUaGmo2Hfzo5bVWF1ITcgQzm7dHLc=
Message-ID: <829b8887-48de-4cfa-8bb2-79db1471bb8d@arm.com>
Date: Wed, 6 May 2026 16:06:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Let userspace explicitly trigger memory reclaims
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260506-panthor-explicit-reclaim-v1-0-44f82ac147ce@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260506-panthor-explicit-reclaim-v1-0-44f82ac147ce@collabora.com>
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

On 06/05/2026 11:45, Nicolas Frattaroli wrote:
> RAM is not, in fact, cheap. Especially on embedded systems with a low
> amount of memory, but known and well-defined userspace, more explicit
> resource management can lead to better utilisation patterns. As an
> example, a resource manager process on a purpose-built device may wish
> to launch, and then explicitly swap out, memory of processes that are
> kept "warm", to improve perceived startup latency of individual
> full-screen applications without making the kernel figure out the usage
> pattern from observation alone in order to swap out the right pages.

Have you considered memory control groups (memcg) for this purpose?
Imposing a lower limit than currently allocated should trigger reclaim,
so 'background' applications could have the limit lowered and then
restored when moved to the foreground.

> To allow for this explicit control in the context of panthor's GPU
> memory, add two new sysfs knobs. The first, mem_reclaim, runs an
> explicit priv BO reclaim cycle on the TGID written to it.
> 
> The second, mem_claim, does the opposite: it swaps BOs back into active
> memory.

How necessary is this mem_claim for performance? Have you done any
benchmarking of explicitly claiming vs just allowing it to happen
naturally? My gut feeling is that mem_claim should be unnecessary in
most situations, but I'm prepared to be proved wrong.

I'm not saying this series is necessarily the wrong approach - but I
think we need a bit more justification for adding a new API for this.

Thanks,
Steve

> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> Nicolas Frattaroli (4):
>       drm/panthor: Add freed_sz parameter to reclaim_priv_bos
>       MAINTAINERS: Add sysfs ABI docs to list of panthor files
>       drm/panthor: Add explicit memory reclaim sysfs knob
>       drm/panthor: Add explicit memory claim sysfs knob
> 
>  Documentation/ABI/testing/sysfs-driver-panthor-mem | 34 ++++++++
>  MAINTAINERS                                        |  1 +
>  drivers/gpu/drm/panthor/panthor_drv.c              | 93 ++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_gem.c              |  7 +-
>  drivers/gpu/drm/panthor/panthor_gem.h              |  1 +
>  drivers/gpu/drm/panthor/panthor_mmu.c              | 70 +++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_mmu.h              |  4 +
>  7 files changed, 205 insertions(+), 5 deletions(-)
> ---
> base-commit: 2c4b906cd135bbb44855287d0d0eff0ee0b47afe
> change-id: 20260506-panthor-explicit-reclaim-3dffed028d8c
> 
> Best regards,
> --  
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 

