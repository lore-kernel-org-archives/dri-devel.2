Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501E606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=RWm9M5q7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171771122A1;
	Thu, 19 Nov 2026 11:10:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6701D1122A1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:10:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E81161575
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 03:10:24 -0800 (PST)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 9DA223F882
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795086627; bh=0vFrVGLPoOZ2lULqO3Q0WBMmFaK4e3iZvfwtZtTXdoE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RWm9M5q7p3LVjiGaupKWieOWwpAy4tEGF6ivs+Aj/TIHA7EvZuzwjBbghCijp6zwo
 px35DSifiQ1qUaXziw7YjFnZSCuYQU1bgqYIAcr/mA7LV5JwWC+nZTwdgQrUVuJD+c
 Wg8c0duWaAatzCnGVaFwO6dGFBov/RRVTQH0bgv8=
Date: Thu, 19 Nov 2026 11:10:15 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Paul Toadere <paul.toadere@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>
Subject: Re: [PATCH v2 0/3] drm/panthor: Report fault information to userspace
Message-ID: <av7ZFwXVChENRVcd@e142607>
References: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
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

On Wed, Nov 04, 2026 at 08:52:38AM +0100, Christian Gmeiner wrote:
> The Panthor CSF firmware and hardware report extra information when a
> fault happens. Two kinds of faults matter here:
> * faults raised at the address space level. These are fatal for every
>   group bound to that VM.
> * fatal faults raised on one of the queues of a group. They stop
>   further submissions on that group.
> 
> This series exposes that information to userspace, so the
> VK_KHR_device_fault extension can be implemented on top of it.
> 
> VM faults are reported through VM_GET_STATE. The VM keeps the raw
> AS_FAULTSTATUS and AS_FAULTADDRESS of its last fault. Queue fatal
> errors are reported through GROUP_GET_STATE. Each queue keeps its raw
> CS_FATAL and CS_FATAL_INFO, and the ioctl returns them in an array
> indexed by queue. The kernel does not decode the values, userspace
> does. Nothing is allocated in the fault paths.
> 
> Changes in v2:
> - Report VM faults through VM_GET_STATE instead of copying them into
>   every group bound to the VM.
> - Pass the raw register values to userspace instead of decoded fields.
> - Keep one fatal slot per queue. A queue stops at its first fatal
>   error, so no allocation is needed.
> - Store the uAPI structs directly in the kernel objects.
> - Dropped the recoverable CS_FAULT reporting for now.
> - Bump the driver version to 1.10 in a separate patch.
> - Rebased on drm-misc-next. The queue fatal info is protected by
>   events_lock now that fatal events are processed under it.
> 
> Link to v1: https://lore.kernel.org/r/20251215115457.2137485-1-lukas.zapolskas@arm.com
> 
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
> Christian Gmeiner (3):
>       drm/panthor: Report the last VM fault through VM_GET_STATE
>       drm/panthor: Report the CS fatal errors through GROUP_GET_STATE
>       drm/panthor: Bump the driver version to 1.10
> 
>  drivers/gpu/drm/panthor/panthor_drv.c   | 26 +++++++++++++++--
>  drivers/gpu/drm/panthor/panthor_mmu.c   | 33 +++++++++++++++++++--
>  drivers/gpu/drm/panthor/panthor_mmu.h   |  2 ++
>  drivers/gpu/drm/panthor/panthor_sched.c | 32 +++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_sched.h |  5 +++-
>  include/uapi/drm/panthor_drm.h          | 52 +++++++++++++++++++++++++++++++++
>  6 files changed, 143 insertions(+), 7 deletions(-)
> ---
> base-commit: 6f7098738fff3ec7393f924343188cb8e6ebc5d2
> change-id: 20261014-panthor-fault-info-v2-330a9f771fd3
> 
> Best regards,
> -- 
> Christian Gmeiner <cgmeiner@igalia.com>
> 

Sorry for the delay!

For the whole series:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

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
