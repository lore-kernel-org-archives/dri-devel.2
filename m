Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5407DC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB62A10E09A;
	Fri, 17 Jul 2026 21:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TmVo8kL4";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF36F10E09A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:20:19 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-9309d4ea213so304784285a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784323219; cv=none;
 d=google.com; s=arc-20260327;
 b=gCFSOiXGuUWdFa+q6rf33mFj6VYsSU82i9CZ5aAosYyvrKTGJc00ktLjfEjeH2dMPj
 YewvZ3MIEWFw06do/LDgNqiNzmy5S6j8X0iX0XtPIV5xCBmymzq1DCqC1gYD1J1OfjVe
 FfaPGeURI7O0O37wMD0NJndOoL8P7q+DeOjKBpTFPvkKm62mOvNtM4Dqx+e/buqKytTk
 UEtKNmSv8WaVURoyuH/44C7DI6jYhWUiLP52pvAynJlmmrUqnRi5D0MlcSavQNtxYQQa
 +C04elFObc1NSEKW2XsPlTJWu3t1q0PPjnZDzsq5VrIunLunoxS/6w7jXEogOJikqME7
 BOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LVO9oFcqHAfiXoC8yBmRh7SOK0Mm4H1Q9jwyseAbOfg=;
 fh=Wrc4TWBEF32Ry3+JZsY+wr5OUBsB2/QT7d/V5hLXhtI=;
 b=qr8U6w6N4hKqoKSflKY8iSXzgmpCf654c/lT5SpkzqpiQ5cLk0DChI538UN6vS1sYB
 r5a/IWhk97evaVEfdTxa2sWyTQx0Pf1tYQcv8YrCL8+QOrGc2TQOXEP69uVoyvHu7oml
 CUKC5yMxhCgmuN8zeQCKM52aPqsJqlTEC9CxgK1wU+x8DF9KovqycYPO7CMSIDkkLz4i
 ZMf1aHSm2FJNI38C2N1qKiJ0unUTWhzT8Ti0yBC5Mt/EeeQrjwGGTaOAkYdC3faDn1+J
 DBKe7fxNVn0E/KYD9S53wKj4TP9N2H39+jUxpRFqjLIHXztriKgfBqXyJb6ao4XfqSjE
 NyrA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784323219; x=1784928019; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LVO9oFcqHAfiXoC8yBmRh7SOK0Mm4H1Q9jwyseAbOfg=;
 b=TmVo8kL4nVFKuAL9JL5J/y1BKi6NlaccepKSR3Ui4wjOplwP7vu9cehIx3s47c2Ypq
 Mw9imSwpAIrvRA1j+XXi17uOtp/z5If2A3gZ6OKJUPVAUAzlRRNpeudvrB8cn6xYkhoU
 PSz/rcMSTccqrX/k7RssIJ+M0Q8XDcbTjNlYJQtM/GrpdyLlV5QBGHO59KeiZSenfP68
 UB7BglcehkVqVyyfeynCHnkOcnezF3BaG8THxF58SKAeLnTR2DJefOMuxOw9l3v8Saic
 HWtc/7kTef76fxEj5nS5xvLxpwxX2A0i4CiRTLlfXEOLAarUvf/Qrw7RTCgOAzXUpVGX
 3ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784323219; x=1784928019;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LVO9oFcqHAfiXoC8yBmRh7SOK0Mm4H1Q9jwyseAbOfg=;
 b=BKkbxwlFlKkfpVRGLf5TWZGPOoOXtt23MkZ2o14gliXajh0jULYZ2EAA29PUaMzGFp
 tKmVOikS8O1T6POqcfWu6eIE/XGa2a36Qxh8irOWcSo/82odsNer29/rUKm8NO0iPV5q
 GEMFsirbWkRUc9GfY1vm6qcuvh7BLeh5c13wgK72Y5G0NcVQW43cWrY6z2waNCNbMIak
 OjjAT+2ZkcNwmHFhCKpSPMaK3iaiU5ZCvEngoN8UBMFgVPAbua/DABEELsGuQAU5WXnW
 JbYH2YpMEWnk5HrblGs2hLtf4S9zw1ejnxahhE6oneAI1MklONx/aBfKBagNoYHK94vv
 YhYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+8g9VHTcCHGppWVGyLxVNi6Go7PQobfqGL2sMUMYIdDBsXkjceIl2aS9ystsmOWpZwSd3m1NG8cI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxA9zM9gUiovYAXuE04fq7sSnlyuZmiFpEvw+I4SMJEkXMdXNXe
 bv/UG/V07y+DE7Vsfyiv1jvumr1wQYOLdlXQgJKG7fDKoLwg0G+CrCEVfbLXjSk+YIrTijnrTzm
 tlEKDq5Ah644fNvAYZS1u3yHVXsv6Gf4=
X-Gm-Gg: AfdE7ckGaZFateb+/Taerl1zPPoNJ3AXtHACWyoN09C+xI+hgapcwgFA8ZDp6rn36D1
 /YMvlBYssl0lTDS8YoYmQneUBzEjhHYurRVOM7/E/3sqwjIuYTEvIWXv/nyw3ZYVawLee5ri2oT
 aspW2Y7WVUEdVn+17+RO41v+h/Y+oQn7gds6WG+Y0Ua3pHkVJPEjxWhRAN86o+SHqSI3oV6FfVQ
 nzTYG3oMYcX8Tzmbo0qtWersCtdUgK31u1eJymFfAuGN1WfrCZzfmRCDZp/WQSs8HG7zoVS02pV
 u3Lalmvlk6y3a29Shj7rLdRrQTMO0koX4qEpR33NgxJh2iE=
X-Received: by 2002:a05:620a:290e:b0:92e:ecbd:3445 with SMTP id
 af79cd13be357-930b41d057amr496262485a.48.1784323217761; Fri, 17 Jul 2026
 14:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260716153020.3171253-1-alexander.deucher@amd.com>
In-Reply-To: <20260716153020.3171253-1-alexander.deucher@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 18 Jul 2026 07:20:06 +1000
X-Gm-Features: AUfX_mynCTXnSZVwHW70F9swYp9kKUCZes0m8B3CGbf_52ZPwccd1uaV1RPjgaE
Message-ID: <CAPM=9tw3H_vuNJdNtMw+3=G8PXGydjxAEHHk9syG3cf7XYHx3Q@mail.gmail.com>
Subject: Re: [pull] amdgpu, amdkfd drm-fixes-7.2
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 simona.vetter@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 17 Jul 2026 at 01:30, Alex Deucher <alexander.deucher@amd.com> wrot=
e:
>
> Hi Dave, Simona,
>
> Fixes for 7.2.
>
> The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074=
aa:
>
>   Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

I pulled this then I jumped through hoops to unpull it.

Alex, there are missing signoffs on at least 4 commits in here from
you, it's probably not massively severe but I think it's good to make
sure it's done.

Dave.

>
> are available in the Git repository at:
>
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.2-2=
026-07-16
>
> for you to fetch changes up to c9ab9622f5b2799fe624a4a134e60112149271dd:
>
>   Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs" (2026=
-07-15 09:55:55 -0400)
>
> ----------------------------------------------------------------
> amd-drm-fixes-7.2-2026-07-16:
>
> amdgpu:
> - DCN 4.2 fixes
> - NUTMEG fixes
> - 8K panel fix
> - Backlight fixes
> - UserQ fix
> - Fix bo->pin leaking in amdgpu_bo_create_reserved()
> - VFCT fixes
> - devcoredump fixes
> - Display fixes
> - SMU7 DPM fix
> - AC/DC fixes for SMU7 and SI
> - Queue reset fix
> - PCIe DPM fix
> - XHCI/GPU resume ordering fix
> - Pageflip timeout fix
>
> amdkfd:
> - Fix potential overflow in CWSR size calculation
> - DQM error clean up fixes
>
> ----------------------------------------------------------------
> Alessandro Rinaldi (1):
>       drm/amd/display: Force PWM backlight on Lenovo Legion 5 15ARH05
>
> Alex Deucher (1):
>       drm/amdgpu: always emit the job vm fence
>
> Andriy Korud (1):
>       drm/amd/display: dce100: skip non-DP stream encoders for DP MST
>
> Dmytro Laktyushkin (2):
>       drm/amd/display: fix dcn42 det allocation order
>       drm/amd/display: fix dcn42b det allocation order
>
> Fangzhi Zuo (1):
>       drm/amd/display: Fix 8K Mode Not Parsed by EDID
>
> Guangshuo Li (1):
>       drm/amdkfd: free MQD managers on DQM init failures
>
> Jesse Zhang (1):
>       drm/amdgpu/userq: fix indefinite fence wait during GPU reset
>
> Leo Li (3):
>       drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_=
no_lock
>       drm/amd/display: check GRPH_FLIP status before sending event
>       Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"
>
> Mario Limonciello (5):
>       drm/amd/display: Fix backlight max_brightness to match exported ran=
ge
>       drm/amdgpu: Fix VFCT bus number matching with soft filter
>       drm/amdgpu: Release VFCT ACPI table reference
>       drm/amdgpu: Disable PCIe dynamic speed switching on Ryzen Pinnacle =
Ridge
>       drm/amd: Create a device link between APU display and XHCI devices
>
> Matthew Stewart (1):
>       drm/amd/display: Fix DCN42B null registers & register masks
>
> Pengpeng Hou (1):
>       drm/amd/display: wire DCN42B mcache programming callback
>
> Roman Li (1):
>       drm/amdgpu/discovery: Fix device family for DCN42
>
> Timur Krist=C3=B3f (10):
>       drm/amd/display: Fix preferred link rate for NUTMEG
>       drm/amd/display: Add dp_skip_rbr flag for NUTMEG
>       drm/amdgpu: Print vmid, pasid and more task info in devcoredump
>       drm/amdgpu: Reserve space for IB contents in devcoredumps
>       drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658 (R7 260X)
>       drm/amd/display: Set native cursor mode for disabled CRTCs
>       drm/amd/pm/si: Don't schedule thermal work when queue isn't initial=
ized
>       drm/amd/pm/si: Fix AC/DC switch notification
>       drm/amd/pm/smu7: Fix AC/DC switch notification
>       drm/amdgpu/ttm: Consider concurrent VM flushes for buffer entities
>
> WenTao Liang (1):
>       drm/amd/display: set new_stream to NULL after release
>
> Yongqiang Sun (1):
>       drm/amdkfd: fix 32-bit overflow in CWSR total size calculation
>
> Zhu Lingshan (1):
>       drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved
>
> yanglinlin (1):
>       drm/amd/display: fix __udivdi3 link error
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |  62 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   9 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  20 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  21 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  10 +-
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   4 +
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |  23 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 551 +++++++++++++--=
------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  70 +--
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  20 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c           |  45 ++
>  drivers/gpu/drm/amd/display/dc/dc.h                |   3 +
>  .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  11 +-
>  .../gpu/drm/amd/display/dc/link/link_detection.c   |   2 +-
>  .../display/dc/link/protocols/link_dp_capability.c |   6 +-
>  .../display/dc/resource/dce100/dce100_resource.c   |   7 +-
>  .../amd/display/dc/resource/dcn42/dcn42_resource.c |   1 +
>  .../display/dc/resource/dcn42b/dcn42b_resource.c   |  23 +-
>  .../display/dc/resource/dcn42b/dcn42b_resource.h   | 116 +----
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  17 +-
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c     |   7 +-
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  16 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  12 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  12 +-
>  .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |  45 ++
>  drivers/gpu/drm/drm_panel_backlight_quirks.c       |   9 +
>  include/drm/drm_utils.h                            |   1 +
>  31 files changed, 720 insertions(+), 431 deletions(-)
