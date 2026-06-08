Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDF0CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0590710F6E8;
	Mon,  8 Jun 2026 16:27:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hG/vBz8H";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB0110F6E8
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780936072;
 bh=3BQZda0/S4cghpNTumiRkujl9IUZQZGizz9uIsHPG00=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hG/vBz8Htcw02qMeMpmoI7Kr1RGRf4BAOdnqS7EdNoemfKapWPDgZ6LOkP83HvdaM
 tqfOLq3ijmOW5tPg8e4jEV3SEqqjI0fIaQEulnerw9tg7WjzlydqbCnAOT3j9wDWXM
 EZjr++nyhLFEEF8zCfjCRAIMQzrs2EeQp90I+VEDbKVICCYorn44wVmG6zOP+dOC7A
 2NSifBkMlebBciXe2tYW5AF3lhioMQyvZpTcSm4uLWva+SN/2FmWgf+lMCtg+S5g72
 EG7lINuK3NSou2aaf75/yR+5oRSqiDCUwWFMRq6Bgeg34ovhgyD4BMPo/WjNgDNPtI
 4/xEL0UnJKvvw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 487B417E0416;
 Mon,  8 Jun 2026 18:27:52 +0200 (CEST)
Date: Mon, 8 Jun 2026 18:27:48 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/18] drm/panthor: Add Mali v15 AM virtualization
 support
Message-ID: <20260608182748.4ac3e272@fedora-2.home>
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
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

On Thu, 28 May 2026 16:05:28 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> This series adds initial support for Mali v15 AM GPUs and the
> HW-assisted virtualization blocks around them.
> 
> The first patches make the core panthor code less dependent on fixed
> register layouts by caching decoded GPU_ID fields and moving register
> base offsets into the HW description. Mali v15 support is then added on
> top, including 64-bit GPU_ID decoding and optional devfreq handling for
> systems where frequency control is owned by AM_GOVERNOR.
> 
> The rest of the series introduces the AM_SYSTEM, AM_PARTITION_CONTROL,
> AM_RESOURCE_GROUP, arbitration scheduler and access-window pieces needed
> to coordinate GPU ownership between the arbiter and VM-side panthor
> instances. Finally, HW component PM is routed through access windows and
> waits are taught to tolerate loss of the access window.
> 
> This series has a soft dependency on firmware scheduling support that
> will be added later to handle YIELD_NOW interrupts.
> 
> The resulting support is intentionally minimal, but provides the
> driver-side plumbing needed for Mali v15 AM systems.
> 
> Kind regards,
> Karunika Choo
> 
> Karunika Choo (18):
>   drm/panthor: Ignore -EOPNOTSUPP for shader-present nvmem lookup
>   drm/panthor: Move register access helpers out of panthor_device.h
>   drm/panthor: Parse and store GPU_ID fields
>   drm/panthor: Add 64-bit GPU_ID decoding for v15 GPUs
>   drm/panthor: Move register base offsets to the HW description
>   drm/panthor: Derive MMU AS register addresses from base and stride
>   drm/panthor: Add Mali v15 hardware support
>   drm/panthor: Skip devfreq when no OPP table is present

The prep patches look mostly okay to me (baring a few nitpicks).

>   drm/panthor: Add basic AM_SYSTEM support
>   drm/panthor: Add AM_PARTITION_CONTROL support
>   drm/panthor: Add AM message helpers
>   drm/panthor: Add AM_RESOURCE_GROUP support
>   drm/panthor: Add arbitration scheduler
>   drm/panthor: Route arbitration events
>   drm/panthor: Add access-window support
>   drm/panthor: Synchronize HW component PM transitions
>   drm/panthor: Route HW component PM through access windows
>   drm/panthor: Tolerate access-window loss during HW waits

For those, I think I'd like to have the full picture before providing a
proper review. Right now it's unclear what the FW-based YIELD looks
like, and the retry-mechanism on an access-window-lost seems a bit
fragile (the only places where I've seen this tested is in iopoll
loops, but AW can go away at any time).

> 
>  drivers/gpu/drm/panthor/Kconfig               |  14 +
>  drivers/gpu/drm/panthor/Makefile              |   3 +
>  drivers/gpu/drm/panthor/arbitration/Makefile  |  17 +
>  .../panthor/arbitration/panthor_arbitration.h |  45 ++
>  .../arbitration/panthor_arbitration_drv.c     | 199 +++++
>  .../arbitration/panthor_arbitration_sched.c   | 692 ++++++++++++++++++
>  .../arbitration/panthor_arbitration_sched.h   |  25 +
>  .../arbitration/panthor_partition_control.c   | 390 ++++++++++
>  .../arbitration/panthor_partition_control.h   |  27 +
>  .../arbitration/panthor_resource_group.c      | 288 ++++++++
>  .../arbitration/panthor_resource_group.h      |  20 +
>  drivers/gpu/drm/panthor/panthor_am_msg.h      | 157 ++++
>  drivers/gpu/drm/panthor/panthor_aw.c          | 576 +++++++++++++++
>  drivers/gpu/drm/panthor/panthor_aw.h          |  46 ++
>  drivers/gpu/drm/panthor/panthor_devfreq.c     |  13 +-
>  drivers/gpu/drm/panthor/panthor_device.c      |  69 +-
>  drivers/gpu/drm/panthor/panthor_device.h      | 134 ++--
>  drivers/gpu/drm/panthor/panthor_device_io.h   |  81 ++
>  drivers/gpu/drm/panthor/panthor_drv.c         |   1 +
>  drivers/gpu/drm/panthor/panthor_fw.c          |   8 +-
>  drivers/gpu/drm/panthor/panthor_fw_regs.h     |   2 -
>  drivers/gpu/drm/panthor/panthor_gpu.c         |  14 +-
>  .../drm/panthor/panthor_gpu_discover_regs.h   |  42 ++
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h    |   2 -
>  drivers/gpu/drm/panthor/panthor_heap.c        |   3 +-
>  drivers/gpu/drm/panthor/panthor_hw.c          | 163 ++++-
>  drivers/gpu/drm/panthor/panthor_hw.h          |  45 +-
>  drivers/gpu/drm/panthor/panthor_mmu.c         |  36 +-
>  drivers/gpu/drm/panthor/panthor_mmu_regs.h    |  23 +-
>  drivers/gpu/drm/panthor/panthor_pwr.c         |  32 +-
>  drivers/gpu/drm/panthor/panthor_pwr_regs.h    |   3 -
>  drivers/gpu/drm/panthor/panthor_sched.c       |   9 +-
>  drivers/gpu/drm/panthor/system/Makefile       |  12 +
>  .../gpu/drm/panthor/system/panthor_system.c   | 298 ++++++++
>  include/uapi/drm/panthor_drm.h                |  20 +-
>  35 files changed, 3338 insertions(+), 171 deletions(-)
>  create mode 100644 drivers/gpu/drm/panthor/arbitration/Makefile
>  create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
>  create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
>  create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
>  create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
>  create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
>  create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h
>  create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
>  create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h
>  create mode 100644 drivers/gpu/drm/panthor/panthor_am_msg.h
>  create mode 100644 drivers/gpu/drm/panthor/panthor_aw.c
>  create mode 100644 drivers/gpu/drm/panthor/panthor_aw.h
>  create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h
>  create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
>  create mode 100644 drivers/gpu/drm/panthor/system/Makefile
>  create mode 100644 drivers/gpu/drm/panthor/system/panthor_system.c
> 
> --
> 2.43.0
> 

