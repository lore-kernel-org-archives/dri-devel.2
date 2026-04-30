Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA1ECD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE41D10E477;
	Thu, 30 Apr 2026 16:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="KOrKyIp9";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B47A810F3DE
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 16:36:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DCFB3597
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:36:33 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 A9A7C3F62B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777566998; bh=Zv9lzobn8czFLu5BMX7JmYoyQ8n7ISSdzoGd9HjAmFQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KOrKyIp9TSAeK9aUljvp9KpzvkxYoNAUeSuckKQNAh8HuceXq0MgrtrWLgYqCvnIH
 GpNL40ZVpqqnpN0cIldH4HG1IbVM43D5xMSWhl5JHrgBgfFVs4p77BNioJCPUxf8+a
 u1oWvNBFks3wClBRvylqzUxZnPYcUWOWquE4Vb6c=
Date: Thu, 30 Apr 2026 17:36:36 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] drm/panthor: Localize register access by component
Message-ID: <afOFFIdNqydY89eT@e142607>
References: <20260427155934.416502-1-karunika.choo@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427155934.416502-1-karunika.choo@arm.com>
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

On Mon, Apr 27, 2026 at 04:59:26PM +0100, Karunika Choo wrote:
> Hi all,
> 
> This series refactors the panthor register access paths so that each
> component uses its own local iomem base instead of relying on the
> global device mapping throughout the driver.
> 
> Today a number of register definitions and helpers are still expressed
> in terms of the full device register space, which makes it easy for one
> component to reach into another component's registers.
> 
> The series prepares the driver for a cleaner per-component layout in 3
> steps:
> - make the low-level GPU register helpers operate on an iomem pointer
>   rather than a panthor_device pointer
> - split register definitions and move cross-component accesses behind
>   helpers owned by the relevant component
> - convert GPU, PWR, firmware and MMU code to use component-local iomem
>   bases, while keeping IRQ handling on a dedicated IRQ-local base.
> 
> The end result is that register accesses become more obviously scoped to
> the component that owns them, cross-component register accesses are
> removed from callers, and the common IRQ helpers no longer depend on
> absolute register offsets.
> 
> No functional change is intended.
> 
> v3:
> - Picked up Acks and Reviewed-bys from Boris, Liviu, and Steve.
> - Cleaned up definition of pwr->iomem and pwr->irq.iomem.
> - Link to v2: https://lore.kernel.org/all/20260412142951.2309135-1-karunika.choo@arm.com/
> v2:
> - Picked up Acks from Boris.
> - Moved GPU_ID definitions into panthor_gpu_regs.h and deleted
>   panthor_hw_regs.h
> - Fixed incorrect spelling of timestamp helper functions.
> - Changed IRQ request function to take an iomem pointer instead of an
>   offset.
> - Update panthor_gpu_info_init() to use the correct block-local iomem
>   pointers for register accesses.
> - Link to v1: https://lore.kernel.org/all/20260410164637.549145-1-karunika.choo@arm.com/
> 
> Kind regards,
> Karunika

Pushed to drm-misc-next.

Best regards,
Liviu

> 
> Karunika Choo (8):
>   drm/panthor: Pass an iomem pointer to GPU register access helpers
>   drm/panthor: Split register definitions by components
>   drm/panthor: Replace cross-component register accesses with helpers
>   drm/panthor: Store IRQ register base iomem pointer in panthor_irq
>   drm/panthor: Use a local iomem base for GPU registers
>   drm/panthor: Use a local iomem base for PWR registers
>   drm/panthor: Use a local iomem base for firmware control registers
>   drm/panthor: Use a local iomem base for MMU AS registers
> 
>  drivers/gpu/drm/panthor/panthor_device.c   |  28 +-
>  drivers/gpu/drm/panthor/panthor_device.h   |  92 ++++---
>  drivers/gpu/drm/panthor/panthor_drv.c      |   7 +-
>  drivers/gpu/drm/panthor/panthor_fw.c       |  40 ++-
>  drivers/gpu/drm/panthor/panthor_fw.h       |   1 +
>  drivers/gpu/drm/panthor/panthor_fw_regs.h  |  29 ++
>  drivers/gpu/drm/panthor/panthor_gpu.c      | 101 +++++--
>  drivers/gpu/drm/panthor/panthor_gpu.h      |   6 +
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h | 119 +++++++++
>  drivers/gpu/drm/panthor/panthor_heap.c     |   2 +-
>  drivers/gpu/drm/panthor/panthor_hw.c       |  54 ++--
>  drivers/gpu/drm/panthor/panthor_hw.h       |   2 +-
>  drivers/gpu/drm/panthor/panthor_mmu.c      |  46 ++--
>  drivers/gpu/drm/panthor/panthor_mmu_regs.h |  69 +++++
>  drivers/gpu/drm/panthor/panthor_pwr.c      |  93 ++++---
>  drivers/gpu/drm/panthor/panthor_pwr_regs.h |  79 ++++++
>  drivers/gpu/drm/panthor/panthor_regs.h     | 291 ---------------------
>  drivers/gpu/drm/panthor/panthor_sched.c    |   5 +-
>  18 files changed, 584 insertions(+), 480 deletions(-)
>  create mode 100644 drivers/gpu/drm/panthor/panthor_fw_regs.h
>  create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_regs.h
>  create mode 100644 drivers/gpu/drm/panthor/panthor_mmu_regs.h
>  create mode 100644 drivers/gpu/drm/panthor/panthor_pwr_regs.h
>  delete mode 100644 drivers/gpu/drm/panthor/panthor_regs.h
> 
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
