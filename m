Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AFBE9A747
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C8810E5A6;
	Tue, 24 Mar 2026 09:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lGZrL11D";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919CB10E0D8;
 Tue, 24 Mar 2026 09:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774344229;
 bh=yZQ2+xLkFUtBrYQ3kuAajM2CQ/yzEgdmGO+VpSJ/vQg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lGZrL11Dgp1MgW2ycqLbXRcHCAZA8iv27awxZMEyBVAHyVhAZnl+TandY2rcL4a3r
 rvISn7tigekike1wKrxwoajmHiOYyJYCCotofjPz5Q19TDJ4doX+TdZ1ziwW98+Upu
 LsRC/jiz2LtzUZAOKZOAPASF3xmTaFuidaMgf/Z+ACMHNq6yEi5Zikk+dGCbBohVSq
 zi7GBGC/X3yW8lNIUKAEW30CpMk/1YyzzCKPvmmEhJDN7g8u2Rna25oYhwdZVCIFTt
 OHZDB+Z4ms92sH2/EMKDykyGYiLOaBu13GeaBblK36cknrcu44M6mFcrYHHnWO1UtF
 1AkGv+dSDomGA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A777E17E54A9;
 Tue, 24 Mar 2026 10:23:48 +0100 (CET)
Date: Tue, 24 Mar 2026 10:23:45 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Simona Vetter <simona@ffwll.ch>, Sumit
 Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <20260324102345.17742bef@fedora>
In-Reply-To: <acGIjjLXuxUzv3aI@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <20260317155512.7250be13@fedora>
 <abs1Da8ntfAQISL6@lstrano-desk.jf.intel.com>
 <20260319101153.169c7f36@fedora>
 <acDGf9BYQj6KwRIX@lstrano-desk.jf.intel.com>
 <20260323105504.2d9ae741@fedora>
 <acFzpZruqlZQnQNk@lstrano-desk.jf.intel.com>
 <acGIjjLXuxUzv3aI@lstrano-desk.jf.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Mon, 23 Mar 2026 11:38:06 -0700
Matthew Brost <matthew.brost@intel.com> wrote:

> 
> Ok, getting stats is easier than I thought...
> 
> ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions /home/mbrost/xe/source/drivers.gpu.i915.igt-gpu-tools/build/tests/xe_exec_threads --r threads-basic
> 
> This test creates one thread per engine instance (7 instances this BMG
> device) and submits 1k exec IOCTLs per thread, each performing a DW
> write. Each exec IOCTL typically does not have unsignaled input dependencies.
> 
> With IRQ putting of jobs off + no bypass (drm_dep_queue_flags = 0):
> 
>              8,449      context-switches
>                412      cpu-migrations
>           2,531.43 msec task-clock
>      1,847,846,588      cpu_atom/cycles/
>      1,847,856,947      cpu_core/cycles/
>    <not supported>      cpu_atom/instructions/
>        460,744,020      cpu_core/instructions/
> 
> With IRQ putting of jobs off + bypass (drm_dep_queue_flags =
> DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED):
> 
>              8,655      context-switches
>                229      cpu-migrations
>           2,571.33 msec task-clock
>        855,900,607      cpu_atom/cycles/
>        855,900,272      cpu_core/cycles/
>    <not supported>      cpu_atom/instructions/
>        403,651,469      cpu_core/instructions/
> 
> With IRQ putting of jobs on + bypass (drm_dep_queue_flags =
> DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED |
> DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE):
> 
>              5,361      context-switches
>                169      cpu-migrations
>           2,577.44 msec task-clock
>        685,769,153      cpu_atom/cycles/
>        685,768,407      cpu_core/cycles/
>    <not supported>      cpu_atom/instructions/
>        321,336,297      cpu_core/instructions/

Thanks for sharing those numbers. For completeness, can you also add the
"With IRQ putting of jobs on + no bypass" case?

I'm a bit surprised by the difference in number of context switches
given I'd expect the local-CPU to be picked in priority, and so queuing
work items on the same wq from another work item to be almost free in
term on scheduling. But I guess there's some load-balancing happening
when you execute jobs at such a high rate.

Also, I don't know if that's just noise or if it's reproducible, but
task-clock seems to be ~40usec lower with the deferred cleanup and
no-bypass (higher throughput because you're not blocking the dequeuing
of the next job on the cleanup of the previous one, I suspect).

