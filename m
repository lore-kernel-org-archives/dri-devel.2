Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88B6C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0829F10E504;
	Fri, 17 Jul 2026 23:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kYfv8uB5";
	dkim-atps=neutral
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3ED10E504
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 23:21:06 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8ee43b3e5abso76837406d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 16:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784330465; cv=none;
 d=google.com; s=arc-20260327;
 b=QsfTt3wsUiBJ/Efe0EPEp8B9HTRMQw9ffpsbZrfQZbPhhYpsdwbZfMV/0dSTP70Hk9
 skZ7pkw0vmzLI6bBx8Qa/1aPKe8AO1WawgoKE4qvEbDNtzzX7234eHfP6WPnUOwBYkih
 o8sh93zTbkXtmTcBJiwJJzS5SONiGAXtwyeQ0cthr9m0/jBddIIY3Tzg6xr2H6oYxzJk
 lr6/knHiwndm9Tz6XJ0SeO8/y8HwmOyn6C+zkKm2mhx0q4m09Feb28ul6GqKOeKZ0EsI
 uaUcEvFziZTAEoSGIaBXMDEm3MCU0G307NMUg8xVxoW0/LNCNyjJ2QG1Hhi4LfqFh4LX
 dK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OuaJDi6ixUGie6kGLnT8WDDcsKqOIGRPe0UrQxCUvdA=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=bKDkYZQbZtXwLRdMCFwzPQhwjSmZa4Y/a9aH23jCVdeZzTYkNW3RWeJudGCyP918Hp
 1tmqh1I5T5/UC0Yt5g0iOm3WkcFgd1Oee/UDSFO7/i+O1vi2WTMwSJDBEr4alnZ3LoZx
 2SUKvOi3qDH41XeaL8p9TY1tUI29y8xvrLoRDmgXxNuXd9yQ0NiWjVHvd3PYoU/e0rwq
 EE6Z0PF2uUGeSt9K5upiCPOJv5EzRSCNuWknceEshOLirgojDBqr8Nih4hd2VDt7fOnK
 7bb4YjYbO5wN7die1ICjSnlD9oKN5SwqFDjBebyM4lQVndCwUYImXlxRa7B04Jrmhdl5
 o77A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784330465; x=1784935265; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OuaJDi6ixUGie6kGLnT8WDDcsKqOIGRPe0UrQxCUvdA=;
 b=kYfv8uB5Ff8A0bVX17Km2GTsfxnbuaGw5MbDJearP0uWc5Fp2eWVa/qC4u0Gt1pSnQ
 7mlf1FO9Tx4ZqrywMCm3enYraaYBiZmuxrwPkV/IzUlCmkog3Wj/VmALy4C9EIfL1dSp
 zWEL/G56DNdSApi+/yzVzakji1hycZ01uC30QPs1V1iap4VU5ut1l5z5hVrKEwNYUulG
 LMGtHvlZEFzG+9LU5WqCVMpBUBBfkyDbwh7EWWoJ7PDEtOsPmjppu8LzxGRmDzsUdzNK
 WS91awQZ1Suv5ZoKBzYfa4wYcdg47M5gI5FUKgXhqmM83hru5NU/8oQ0+OT0eDeDL2Cp
 V3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330465; x=1784935265;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OuaJDi6ixUGie6kGLnT8WDDcsKqOIGRPe0UrQxCUvdA=;
 b=k2PNSHDXFS90nCoobnfvYjFSNoCA6dCMWrozU/US/h83FgYhoVjcBkoI2jDMAnemqj
 ES41qRo6NX8yS7FQVes12+bl9q4GuWa2s2JQhL2TlWehlqofKprFmRnuxG+Xk7MNyQhD
 2JtXuGhkmcD5j9qrF4TPts5ydu4e0F3hHoE+07l2EjW0bZHAw+pPzeWLd79nbnnjHmKo
 Ph9JGjagxRVPXDEfslAgWnZ7CuENAoVSx+vsTUtH6CKhUNcGLwhSlDXEcm7frNLct65E
 0TExxdvKtck2YDzVQkx1ciF5WFZHkXJ3n+jj1kCISeCi1MDaBjGZB1/qwdN/6L/RR4+i
 MZVQ==
X-Gm-Message-State: AOJu0YzqSDt3WZYUt+gpF7WJC1bKNjBg9B5gp6lzuNXa/ahnr3Uf6XnJ
 oabq4zt9VK8haPf8e8jmG/MrXeQgnsjpcWFmDWl3wdXIt7LC10lFjVTJji9xNP2hrCHpPwaqImc
 6J1dAc5w1lk0zVUgATvtKiILWZMDn0AM=
X-Gm-Gg: AfdE7cnQIs/emgfU24AYLcruFvbZdrEEEKVAn2iQLGfTHZEiEYkYdvCfd/6aKS7MYAM
 BJI21PWbhHqXna2A1002LC18mugNezivHiFqBhFC3wJERyFiscv63/Tu8sHNSwirw93JAzyzGZb
 XOv5YPvXABwcjxVMhS9SMvuL7UnRYKDlbVIJUsf39TT/G11x2ccOFBQOxqKAR+6t9I4VWczJ1bk
 hZGqY8ngL71YNcUbl99neH2KDx+yi2k9sygDhbupYBDFqPnQ5MLj/myZg45MxrCUAgsEI/ZCHZQ
 DOqLmSsDHgdGODdH+BDCdxVAXQZiJTnrF79WKylPrrrIszl6iWIHiuMqzQ==
X-Received: by 2002:a05:620a:4713:b0:92b:67e6:4b66 with SMTP id
 af79cd13be357-930b416d8f5mr528897385a.61.1784330465438; Fri, 17 Jul 2026
 16:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tw1j=WYsQjs8Empd1G0CorM-YHFDD87coJSBSXfxOOoXA@mail.gmail.com>
In-Reply-To: <CAPM=9tw1j=WYsQjs8Empd1G0CorM-YHFDD87coJSBSXfxOOoXA@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 18 Jul 2026 09:20:54 +1000
X-Gm-Features: AUfX_mzrTApGr3v05CPW35xbtzCGVJmV8R9vF2qfN87ZFtSpJtgufS-dWP5tfrY
Message-ID: <CAPM=9tyHM7Vz2SyWz03w=+9Jx2rqnCoGR9FX18VR9krkrEwzzQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 7.2-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Please disregard this one, and use the one with the amdgpu ones in it.

Dave.

On Sat, 18 Jul 2026 at 07:31, Dave Airlie <airlied@gmail.com> wrote:
>
> Hi Linus,
>
> Weekly drm fixes, this is xe and i915 and then a lot of scattered
> fixes, there should be a bunch of amdpgu fixes in here, but there was
> some missing Signoffs so I dropped the whole pull request until Alex
> fixes it up, so that might arrive later or might not.
>
> Dave.
>
> drm-fixes-2026-07-18:
> drm fixes for 7.2-rc4
>
> ttm:
> - Handle NULL pages and backup handles in ttm_pool_backup() correctly.
>
> gpusvm:
> - Improve unmap and error handling on gpusvm.
>
> udmabuf:
> - Always synchronize for CPU in begin_cpu_udmabuf.
>
> xe:
> - Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOCK
> - Hold a dma-buf reference for imported BOs
> - Fix writable override for CRI
> - Fix VF CCS attach/detach race with in-flight BO moves
> - Fix WOPCM size for LNL+
> - Reset current_op in xe_pt_update_ops_init
> - Keep scheduler timeline name alive
> - Hold device ref until queue teardown completes
> - Disable display in admin only PF mode
>
> i915:
> - NV12 display fix for bigjoiner
> - clear watermark on plane disable
> - GT selftest fixes
>
> host1x:
> - Fix UAF
>
> amdxdna
> - Fix UAF
> - Reject more invalid amdxdna command submissions.
>
> ivpu:
> - Fix wrong read
> - Handle invalid firmware log in ivpu.
>
> panthor:
> - Fix error handling
>
> virtio:
> - Fix virtio deadlock
> - Fix invalid gem detach.
> The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:
>
>   Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-07-18
>
> for you to fetch changes up to 5554e0599c960a2b320a78ef1429ddb1a1d94aec:
>
>   Merge tag 'drm-intel-fixes-2026-07-17' of
> https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
> (2026-07-18 07:18:18 +1000)
>
> ----------------------------------------------------------------
> drm fixes for 7.2-rc4
>
> ttm:
> - Handle NULL pages and backup handles in ttm_pool_backup() correctly.
>
> gpusvm:
> - Improve unmap and error handling on gpusvm.
>
> udmabuf:
> - Always synchronize for CPU in begin_cpu_udmabuf.
>
> xe:
> - Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOCK
> - Hold a dma-buf reference for imported BOs
> - Fix writable override for CRI
> - Fix VF CCS attach/detach race with in-flight BO moves
> - Fix WOPCM size for LNL+
> - Reset current_op in xe_pt_update_ops_init
> - Keep scheduler timeline name alive
> - Hold device ref until queue teardown completes
> - Disable display in admin only PF mode
>
> i915:
> - NV12 display fix for bigjoiner
> - clear watermark on plane disable
> - GT selftest fixes
>
> host1x:
> - Fix UAF
>
> amdxdna
> - Fix UAF
> - Reject more invalid amdxdna command submissions.
>
> ivpu:
> - Fix wrong read
> - Handle invalid firmware log in ivpu.
>
> panthor:
> - Fix error handling
>
> virtio:
> - Fix virtio deadlock
> - Fix invalid gem detach.
>
> ----------------------------------------------------------------
> Alexander Usyskin (1):
>       drm/xe/nvm: fix writable override for CRI
>
> Arvind Yadav (2):
>       drm/xe/guc: Keep scheduler timeline name alive
>       drm/xe/guc: Hold device ref until queue teardown completes
>
> Daniele Ceraolo Spurio (1):
>       drm/xe/wopcm: fix WOPCM size for LNL+
>
> Dave Airlie (3):
>       Merge tag 'drm-misc-fixes-2026-07-17' of
> https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
>       Merge tag 'drm-xe-fixes-2026-07-17' of
> https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
>       Merge tag 'drm-intel-fixes-2026-07-17' of
> https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
>
> Doruk Tan Ozturk (2):
>       accel/amdxdna: reject user command submission without a command BO
>       accel/amdxdna: reject command submission on devices without a submit op
>
> Emre Cecanpunar (1):
>       drm/i915/selftests: Fix GT PM sort comparators
>
> Himal Prasad Ghimiray (1):
>       drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC
>
> Honglei Huang (3):
>       drm/gpusvm: free the whole IOVA reservation on unmap
>       drm/gpusvm: do not route system pages to device_unmap() on IOVA unmap
>       drm/gpusvm: publish dpagemap early to avoid device mapping leak on error
>
> Jason Macnak (1):
>       drm/virtio: Don't detach GEM from a non-created context
>
> Jhonraushan (1):
>       accel/ivpu: Reject firmware log with size smaller than header
>
> Karol Wachowski (1):
>       accel/ivpu: Fix wrong register read in LNL failure diagnostics
>
> Linmao Li (1):
>       drm/panthor: Check debugfs GEM lock initialization
>
> Lizhi Hou (1):
>       accel/amdxdna: Fix use-after-free of mm_struct in job scheduler
>
> Maarten Lankhorst (1):
>       Merge v7.2-rc3 into drm-misc-fixes
>
> Matthew Brost (2):
>       drm/ttm: Account for NULL and handle pages in ttm_pool_backup
>       drm/xe/vf: Fix VF CCS attach/detach race with in-flight BO moves
>
> Mikko Perttunen (1):
>       gpu: host1x: Fix use-after-free in host1x_bo_clear_cached_mappings
>
> Nitin Gote (1):
>       drm/xe: Hold a dma-buf reference for imported BOs
>
> Osama Abdelkader (1):
>       drm/panthor: return error on truncated firmware
>
> Pengpeng Hou (1):
>       drm/i915/gt: use correct selftest config symbol
>
> Robert Mader (1):
>       udmabuf: Ensure to perform cache synchronisation in begin_cpu_udmabuf()
>
> Ryosuke Yasuoka (1):
>       drm/virtio: fix deadlock in display_info_cb by removing hotplug
> from dequeue worker
>
> Satyanarayana K V P (1):
>       drm/xe/pf: Disable display in admin only PF mode
>
> Vidya Srinivas (1):
>       drm/i915/display: Fix NV12 ceiling division for bigjoiner case
>
> Vinod Govindapillai (1):
>       drm/i915/wm: clear the plane ddb_y entries on plane disable
>
> Zongyao Bai (1):
>       drm/xe/pt: Reset current_op in xe_pt_update_ops_init()
>
>  drivers/accel/amdxdna/amdxdna_ctx.c                | 18 ++++++
>  drivers/accel/ivpu/ivpu_fw_log.c                   |  4 ++
>  drivers/accel/ivpu/ivpu_hw_btrs.c                  |  2 +-
>  drivers/dma-buf/udmabuf.c                          |  9 +--
>  drivers/gpu/drm/drm_gpusvm.c                       | 53 +++++++++++-----
>  drivers/gpu/drm/i915/display/skl_universal_plane.c | 33 ++++------
>  drivers/gpu/drm/i915/display/skl_watermark.c       |  2 +-
>  drivers/gpu/drm/i915/gt/intel_engine_user.c        |  2 +-
>  drivers/gpu/drm/i915/gt/selftest_gt_pm.c           |  8 +--
>  drivers/gpu/drm/panthor/panthor_device.c           |  5 +-
>  drivers/gpu/drm/panthor/panthor_fw.c               |  1 +
>  drivers/gpu/drm/ttm/ttm_pool.c                     | 34 +++++++++--
>  drivers/gpu/drm/virtio/virtgpu_gem.c               | 14 +++--
>  drivers/gpu/drm/virtio/virtgpu_kms.c               |  5 +-
>  drivers/gpu/drm/virtio/virtgpu_vq.c                |  3 -
>  drivers/gpu/drm/xe/xe_bo.c                         | 58 +++++++++++++-----
>  drivers/gpu/drm/xe/xe_bo.h                         |  3 +-
>  drivers/gpu/drm/xe/xe_bo_types.h                   |  2 +
>  drivers/gpu/drm/xe/xe_device.c                     |  4 +-
>  drivers/gpu/drm/xe/xe_device_types.h               |  2 +-
>  drivers/gpu/drm/xe/xe_dma_buf.c                    |  2 +-
>  drivers/gpu/drm/xe/xe_guc_exec_queue_types.h       |  5 ++
>  drivers/gpu/drm/xe/xe_guc_submit.c                 | 70 +++++++++++++---------
>  drivers/gpu/drm/xe/xe_guc_types.h                  |  2 -
>  drivers/gpu/drm/xe/xe_migrate.c                    |  5 +-
>  drivers/gpu/drm/xe/xe_migrate.h                    |  1 +
>  drivers/gpu/drm/xe/xe_module.c                     | 49 +++++++++++++++
>  drivers/gpu/drm/xe/xe_module.h                     |  5 ++
>  drivers/gpu/drm/xe/xe_nvm.c                        |  9 ++-
>  drivers/gpu/drm/xe/xe_pci.c                        |  9 ++-
>  drivers/gpu/drm/xe/xe_pt.c                         |  3 +
>  drivers/gpu/drm/xe/xe_sriov_vf_ccs.c               | 20 ++++++-
>  drivers/gpu/drm/xe/xe_sriov_vf_ccs.h               |  3 +-
>  drivers/gpu/drm/xe/xe_vm.c                         | 25 ++++++--
>  drivers/gpu/drm/xe/xe_wopcm.c                      | 15 +++--
>  drivers/gpu/host1x/bus.c                           |  4 +-
>  36 files changed, 356 insertions(+), 133 deletions(-)
