Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18FFC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2CD10EC21;
	Tue, 30 Jun 2026 15:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="cj9kS8AZ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 035AE10EC21
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 15:33:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2961C1595
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:33:26 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 561303F66F
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782833610; bh=cK1Lk/xzt+rFMF2bnVB/6vwqC0ncgtXq+k7LZjMzEGE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cj9kS8AZWZUPb0sUnyjxgedi6P3WN/I53EVXbaBhC2vT6GldaMoCof1o4qWzOEDWp
 9+zhw4/1yH0TRlrOKMpTn3TuzBA/fBqU64NWA8f6T07hpHhXlEpZHcmxA7FpgeR6DT
 x8LwBYzR0GCLuBODktWZql4UvE/+c8rKxIIQ+3io=
Date: Tue, 30 Jun 2026 16:33:20 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH 00/11] drm/panthor: Misc fixes for bugs found by shashiko
Message-ID: <akPhwOBDjvgDaw4X@e142607>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
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

On Thu, Jun 25, 2026 at 02:40:26PM +0200, Boris Brezillon wrote:
> This is a collection of fixes for bugs found by shashiko during
> the review of [1] and the previous iterations. Because shashiko
> keeps finding new issues at each new submission, I decided to
> extract the fixes out of this series.
> 
> [1]https://lore.kernel.org/dri-devel/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com/
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> Boris Brezillon (11):
>       drm/panthor: Always use the IRQ-safe variant when acquiring the fence lock
>       drm/panthor: Keep the reset work disabled until everything is initialized
>       drm/panthor: Fix UAF on works queued to panthor_cleanup_wq
>       drm/panthor: Fix potential invalid pointer deref in group_process_tiler_oom()
>       drm/panthor: Fix theoretical IOMEM access in suspended state
>       drm/panthor: Don't overrule pending immediate ticks in sched_resume_tick()
>       drm/panthor: Fix panthor_pwr_unplug()
>       drm/panthor: Drop a needless check in panthor_fw_unplug()
>       drm/panthor: Fix a leak when a group is evicted before the tiler OOM is serviced
>       drm/panthor: Interrupt group start/resumption if group_bind_locked() fails
>       drm/panthor: Keep interrupts masked until they are needed
> 
>  drivers/gpu/drm/panthor/panthor_device.c |   9 +++
>  drivers/gpu/drm/panthor/panthor_device.h |  17 +++--
>  drivers/gpu/drm/panthor/panthor_fw.c     |   6 +-
>  drivers/gpu/drm/panthor/panthor_gpu.c    |   3 +-
>  drivers/gpu/drm/panthor/panthor_mmu.c    |   9 ++-
>  drivers/gpu/drm/panthor/panthor_pwr.c    |  10 +--
>  drivers/gpu/drm/panthor/panthor_sched.c  | 108 +++++++++++++++++--------------
>  7 files changed, 97 insertions(+), 65 deletions(-)
> ---
> base-commit: cdeb2ccd993ed8647adbbda2c3b103aa717fd6f7
> change-id: 20260625-panthor-misc-fixes-e3241ce6ef00
> 
> Best regards,
> -- 
> Boris Brezillon <boris.brezillon@collabora.com>
> 

Except for [3/11] I've pushed the series into drm-misc-fixes.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
