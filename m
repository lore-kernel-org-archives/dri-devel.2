Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C08F419A2
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF3210E6F7;
	Wed, 15 Apr 2026 12:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IdAogUoH";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D72810E6E3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:42:10 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1273c690e5bso1193617c88.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776256930; cv=none;
 d=google.com; s=arc-20240605;
 b=SBCmZfZ4ZoAoYRYXdtK5Fe/LhaTiyE438v+s8KDLjLtacOtA5JWHAfHPZP9He5oHkh
 FwTcOMV7oDpdfuoAW0fBK3FkZtIVoiS2JKDd56JfRmquj7EGuHAWifn2JVHjQhCGpnJ0
 /mTAfhOeP4liK3zTMUWZwzm2yOp3iFafPppIWQ+VaIYCNAIM6VTV0F9Nwp6ezrLMQXRY
 SAp0r4WLHb3DUGvUA2Z2a9Oe6nsuw5CA2HTK61WZTlb1/V94kwBMwQZQAjPSBzOBw1B5
 XM4ZN7ndZdLb8T4/qY45rq/JYtA0rLTZH8ZnWyN+XIbvcx6URPJOiZzbmwNTPbaoml4/
 h18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m6mhDh8ZVimpaQsmL7r1x1xR/f0QJ/vDpnN2yyq/t1k=;
 fh=bOm5I5Dt1ktxmpy0DxD2Bovjo8CiJdDvFXE2XzrmWHo=;
 b=AVWtzu8//MTCmWUbkefBWx5KKz/KKxowjEBjVJTmpHQvC0CyDcBaWT7rSnL0Qrmob4
 DikEr1cepXOr9BEz0a1y1v9CL6QbDpoxzlhUcDcsi9kjUguzdQIOM7ggsfxPOwG3KVzz
 f7XHK9DyK2kSPCLs7+ZA6lhYVY0hrCAiqWgPvMUHxDIVzdfUKb8k9qmDt7kUp7bdVCLH
 XF361fYSkH3Vj3ekvL6r03WTsaLC2XG4KB6ES5Pc47kr/qabMBIZtz19YHACvF92m1/x
 ZtTyJGe3qGwDZm6Imf8B5rGoKQNpFLzKAn4h1aS4RxbP8l9tN6FcnwfU+5O5mWY6uATP
 Arow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776256930; x=1776861730; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6mhDh8ZVimpaQsmL7r1x1xR/f0QJ/vDpnN2yyq/t1k=;
 b=IdAogUoHqovoxMB+5nBOxrgHTq6YA1hk1CamLTW+R2c63+F3cysk76vvf0cWXrlIBc
 pS6cvZeumHKXRu34T5Iv+JH0M1ZTLo2SVn1Ls/NWxt54LoyX4j7Pgy1PYlDNsxZyeOJq
 g8+m1mpBIYlPrs0p2xXNcaaQaGGVUc/Dwzsdfd6newn77BQRk6X+h6htasoQbbW5oX/o
 EeNLCOvGXieFTuDBoNYlB4C5I2+0yATtcbNUDpmqpKqzw5/ZJ5CSVp1ynR6b8f2hMGaa
 pDhPAT+7aK7dQBD2onLHfxPz95Ldbwj2Okfj46UdFYyPwcjRpvXzIIey8d4weT8Nl6SR
 scqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776256930; x=1776861730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m6mhDh8ZVimpaQsmL7r1x1xR/f0QJ/vDpnN2yyq/t1k=;
 b=VJ41bMDGqyBMtvHs2UO1MU03fu7dlp1B/lwTxoGK+flFjRBBVOi9CRcVBQByLiEzyf
 BzCzH6bBPdRgSfTNxBGFVZ60n+lqJZiiAMUJ1zagANXvoi4Rihe2voLDlTC6dsHaUE3z
 q20sx7pqWFcE2wyc6/V2nTexMYxVIaXVl0YoY5q2AQZxpC5b801RKrPF96hN3EkYu05/
 /fBCUTRtCRqRCBVt7Wx8FGFNtVVIwhBzS1ygVYtpnHaGj+QPWs7Xv8WqE6f45lXyinid
 Ofa7lIafevZKFHqCng6Z25oXhEY3hKID026AQrWrLoZ/ft9EH+goWnBzzPFjNivvAMX0
 Sz3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WyC/qb2aboUqHJDaEG0xTDmpvPhq3GViWJthq/azBfwzXl5dQ3DmVl1q7GCkw/SQzEMn9vf+qlQE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwrREvElgvtl+64H2ddljG+4IFG0L4RgBI6uLbHE3JgjOdGjhs
 b2eivNPM2Q52U72s3mjOU+zWapBdPHrN4l2oBo3U0ppb07XurqIlseF80qa2ByPO6Uc9VwRR/gB
 4w/dqXuiNQyoZuSL3vHv5RQpa3iOcBzo=
X-Gm-Gg: AeBDievWLboCp5lSg4nxHzJ4/l8u88c1u3oryo/HO//fBLjYmybZbwrPJ0k+qUVtyiu
 5MDVk5F6/1cnPDLcAeZO/11RnwF47JZmYNaPHe+hjAd7zKxgY5b+gmp2zDIiRPnI3uZkaDxPRhC
 bbyMnVcC1yQ59dIZbP/OrFJIuc369sC7bneR6p2rtgFhi+4Q3HEfirnDrMXO4SDoyLRAEVviPhv
 3lXs6D/VzaolzSycTKHwefdSZm3OJMr9GuN6q8nc0NgFC+VxHV1DPTocVa9OQkKAFRveeKU/biq
 G+vZtn6cY+bVLsPhCGwClOamHFtLtJ2z37g7so7xBB32Dxcxfddu65MwaQm0YXy2EINeFg==
X-Received: by 2002:a05:7022:6288:b0:128:d4d5:93b9 with SMTP id
 a92af1059eb24-12c5d4f349emr470556c88.7.1776256929440; Wed, 15 Apr 2026
 05:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260403214329.2976329-1-alexander.deucher@amd.com>
In-Reply-To: <20260403214329.2976329-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Apr 2026 08:41:56 -0400
X-Gm-Features: AQROBzBw9xzWFFRU4nNxAhqgJRDrt_tA99Kk_T2mlZd3GoHhkm4ke_mPtIzELW4
Message-ID: <CADnq5_OG-R0AVesZyxoAxS+yQFaEigA0yu5wZSyukm4PH8bjug@mail.gmail.com>
Subject: Re: [pull] amdgpu, amdkfd, radeon, drm drm-next-7.1
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 airlied@gmail.com, simona.vetter@ffwll.ch
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

Hi, looks like this got missed.  Can you still pick it up?

Thanks,

Alex

On Fri, Apr 3, 2026 at 6:09=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Hi Dave, Simona,
>
> A few last changes for 7.1.
>
> The following changes since commit 512f9f150f367176fa9e5f4613b4863409a6f6=
86:
>
>   Merge tag 'drm-msm-next-2026-04-02' of https://gitlab.freedesktop.org/d=
rm/msm into drm-next (2026-04-03 18:57:00 +1000)
>
> are available in the Git repository at:
>
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.1-20=
26-04-03
>
> for you to fetch changes up to 7b15fc2d1f1a00fb99f0146e404ff2600999ec74:
>
>   drm/amdgpu: dump job ibs in the devcoredump (2026-04-03 16:16:25 -0400)
>
> ----------------------------------------------------------------
> amd-drm-next-7.1-2026-04-03:
>
> amdgpu:
> - Audio regression fix
> - Use drm edid parser for AMD VSDB
> - Misc cleanups
> - VCE cs parse fixes
> - VCN cs parse fixes
> - RAS fixes
> - Clean up and unify vram reservation handling
> - GPU Partition updates
> - system_wq cleanups
> - Add CONFIG_GCOV_PROFILE_AMDGPU kconfig option
> - SMU vram copy updates
> - SMU 15 fixes
> - SMU 13 fixes
> - SMU 14 fixes
> - UserQ fixes
> - Replace pasid idr with an xarray
> - Dither handling fix
> - Enable amdgpu by default for CIK APUs
> - Add IBs to devcoredump
>
> amdkfd:
> - system_wq cleanups
>
> radeon:
> - system_wq cleanups
>
> drm:
> - Add support for AMD VSDB parsing to drm_edid
>
> ----------------------------------------------------------------
> Benjamin Cheng (5):
>       drm/amdgpu: Add bounds checking to ib_{get,set}_value
>       drm/amdgpu/vce: Prevent partial address patches
>       drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg
>       drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg
>       drm/amdgpu/vcn4: Prevent OOB reads when parsing IB
>
> Ce Sun (1):
>       drm/amd/ras: enable uniras via IP version check
>
> Chenyu Chen (2):
>       drm/edid: Parse AMD Vendor-Specific Data Block
>       drm/amd/display: Use drm_display_info for AMD VSDB data
>
> Ionut Nechita (1):
>       drm/amd/display: Wire up dcn10_dio_construct() for all pre-DCN401 g=
enerations
>
> Lijo Lazar (17):
>       drm/amdgpu: Add reserved region ids
>       drm/amdgpu: Add stolen vga reserve-region
>       drm/amdgpu: Add extended stolen vga reserve-region
>       drm/amdgpu: Add stolen_reserved reserve-region
>       drm/amdgpu: Add fw_reserved reserve-region
>       drm/amdgpu: Add firmware extended reserve-region
>       drm/amdgpu: Add fw vram usage reserve-region
>       drm/amdgpu: Add host driver reserved-region
>       drm/amdgpu: Add memory training reserve-region
>       drm/amdgpu: Group filling reserve region details
>       drm/amdgpu: Add function to fill fw reserve region
>       drm/amdgpu: Add function to fill training region
>       drm/amdgpu: Move validation of reserve region info
>       drm/amdgpu: Consolidate reserve region allocations
>       drm/amd/pm: Add smu vram copy function
>       drm/amd/pm: Use smu vram copy in SMUv13
>       drm/amd/pm: Use smu vram copy in SMUv15
>
> Linus Probert (2):
>       drm/amd/display: Replace inline NUM_ELEMENTS macro with ARRAY_SIZE
>       drm/amd/display: Remove unused NUM_ELEMENTS macros
>
> Marco Crivellari (5):
>       drm/amd/display: Replace use of system_wq with system_percpu_wq
>       drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
>       drm/amdgpu: replace use of system_wq with system_dfl_wq
>       amd/amdkfd: add WQ_UNBOUND to alloc_workqueue users
>       drm/radeon: add WQ_PERCPU to alloc_workqueue users
>
> Mario Kleiner (1):
>       drm/amd/display: Change dither policy for 10 bpc output back to dit=
hering
>
> Mikhail Gavrilov (1):
>       drm/amdgpu: replace PASID IDR with XArray
>
> Pierre-Eric Pelloux-Prayer (4):
>       drm/amdgpu: save ring content before resetting the device
>       drm/amdgpu: extract amdgpu_vm_lock_by_pasid from amdgpu_vm_handle_f=
ault
>       drm/amdgpu: store ib info for devcoredump
>       drm/amdgpu: dump job ibs in the devcoredump
>
> Prike Liang (2):
>       drm/amdgpu: rework userq fence driver alloc/destroy
>       drm/amdgpu: make userq fence_drv drop explicit in queue destroy
>
> Srinivasan Shanmugam (3):
>       drm/amd/display: Fix dc_is_fp_enabled name mismatch
>       drm/amd/display: Fix parameter mismatch in panel self-refresh helpe=
r
>       drm/amd/display: Fix missing parameter details in amdgpu_dm_ism
>
> Sunil Khatri (5):
>       drm/amdgpu/userq: dont need check for return values in amdgpu_userq=
_evict
>       drm/amdgpu/userq: fence wait for max time in amdgpu_userq_wait_for_=
signal
>       drm/amdgpu/userq: add the return code too in error condition
>       drm/amdgpu/userq: call dma_resv_wait_timeout without test for signa=
lled
>       drm/amdgpu/userq: use dma_fence_wait_timeout without test for signa=
lled
>
> Timur Krist=C3=B3f (1):
>       drm/amdgpu: Use amdgpu by default for CIK APUs too
>
> Vitaly Prosyak (1):
>       drm/amdgpu: add CONFIG_GCOV_PROFILE_AMDGPU Kconfig option
>
> Xiaogang Chen (1):
>       drm/amdgpu: add an option to allow gpu partition allocate all avail=
able memory
>
> Yang Wang (4):
>       drm/amd/pm: correct mem_busy_percent display due to calculation err=
ors
>       drm/amd/pm: fix null pointer dereference issue in smu_v15_0_8_get_p=
ower_limit()
>       drm/amd/pm: optimize logic and remove unnecessary checks in smu v15=
.0.8
>       drm/amd/pm: fix memleak issue in smu_v15_0_8_get_gpu_metrics()
>
>  drivers/gpu/drm/amd/amdgpu/Kconfig                 |  17 +
>  drivers/gpu/drm/amd/amdgpu/Makefile                |   4 +
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c             |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   5 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |  18 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   | 191 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |  21 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  39 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |  17 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  23 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |  39 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c          |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |  11 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 362 +++++++++------=
------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |  53 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  81 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  32 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  50 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  89 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h            |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  10 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  10 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  11 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   2 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   2 -
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |  10 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |  10 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  23 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |  44 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   3 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 128 ++++----
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  14 -
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  21 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |   9 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c     |   2 +-
>  .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   5 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   2 +-
>  .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   6 +-
>  .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c    |   3 -
>  .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |   3 -
>  .../gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c   |   2 -
>  .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |   4 -
>  .../amd/display/dc/resource/dcn10/dcn10_resource.c |  41 +++
>  .../amd/display/dc/resource/dcn20/dcn20_resource.c |  42 +++
>  .../display/dc/resource/dcn201/dcn201_resource.c   |  41 +++
>  .../amd/display/dc/resource/dcn21/dcn21_resource.c |  34 ++
>  .../amd/display/dc/resource/dcn30/dcn30_resource.c |  42 +++
>  .../display/dc/resource/dcn301/dcn301_resource.c   |  42 +++
>  .../display/dc/resource/dcn302/dcn302_resource.c   |  41 +++
>  .../display/dc/resource/dcn303/dcn303_resource.c   |  41 +++
>  .../amd/display/dc/resource/dcn31/dcn31_resource.c |  40 +++
>  .../display/dc/resource/dcn314/dcn314_resource.c   |  40 +++
>  .../display/dc/resource/dcn315/dcn315_resource.c   |  40 +++
>  .../display/dc/resource/dcn316/dcn316_resource.c   |  40 +++
>  .../amd/display/dc/resource/dcn32/dcn32_resource.c |  43 +++
>  .../display/dc/resource/dcn321/dcn321_resource.c   |  43 +++
>  .../amd/display/dc/resource/dcn35/dcn35_resource.c |  43 +++
>  .../display/dc/resource/dcn351/dcn351_resource.c   |  43 +++
>  .../amd/display/dc/resource/dcn36/dcn36_resource.c |  43 +++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  17 +
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  10 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |   9 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  19 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  10 +-
>  .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  10 +-
>  .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |  76 ++---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  12 +
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |   3 +
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |   9 +-
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |  16 +-
>  drivers/gpu/drm/drm_edid.c                         |  72 ++++
>  drivers/gpu/drm/radeon/radeon_display.c            |   3 +-
>  drivers/gpu/drm/radeon/radeon_drv.c                |   3 +-
>  include/drm/drm_connector.h                        |  38 +++
>  92 files changed, 1756 insertions(+), 703 deletions(-)
