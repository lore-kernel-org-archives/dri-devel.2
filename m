Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B61F589DA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58EF10F142;
	Thu, 23 Apr 2026 14:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bG8Wk1dN";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D8C810F142
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:00:16 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12c1161232dso417463c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 07:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776952816; cv=none;
 d=google.com; s=arc-20240605;
 b=PA2IUR6zDq+qs9ozz0z3ZSNJcwyVfgpdXT3xCBOrLOOMzObDgEZRkDdBv6Ci0CXAjl
 t++jZOpKiGi4OtQzjvxFjzX2hmyvELsdmps+67TPOG9lhnHu8znCmx5v4qjtdEYdnLey
 znGtv4KmcFeGXzWxvNhxtjp0icrS/a5MsjsiGidxA2sBCXXtKUSjLHR62vFM7B/Hmok5
 8xJItuLNSU0XSwSg/BjKhdnhbIFbym4WNqklIo1gOWlc4sOZbMAvF6kWsrUTE7k6mq1i
 1SwMraPMwPMafByPQI4N/+STza+aNHI9O3WP2grYx5F7QO73Wn94a3eqnp1Qd9oe0FeS
 dgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I6CFLHuMNx88CjyYDUQpHwR3+vyQaKEvOKoH2tj3KBI=;
 fh=nV7vQc0K4k2zuDMvVV/4/3C6xVkMPW/hqTrcRB4Q4ns=;
 b=PnZFCyTSQHQCZ0rVfTOa+AU5koqGBAOOFMlp/rckHthZx/kp5xRkL/xEBLXWgVvWIc
 ITW9g9CDrQboyHNu7muTqk2CgR0Pk59mBblY4TeubnrnQPUgCiOjeH2aCgUEGtlIncVG
 /+5biz5IivyaY6Bo0ODlIgX4I9iQT29X0gWb2QV0coVdq1qtoekq/bbu5FsJSpu9MOi/
 rzmSNnRZ/IHTR7udIcfj7tixR1S7fc4B31CW+2vODapYBtAdJ9ZyI3VjQYlm94ryZ3Mu
 gUPKrydLufbGIjywwlDbN7QWUvC93AdXPgD7nWpKdTx8c3fDxLK/CX6oTDZbGYAtc8QA
 B/xQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776952816; x=1777557616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6CFLHuMNx88CjyYDUQpHwR3+vyQaKEvOKoH2tj3KBI=;
 b=bG8Wk1dNk4xYTwzsL9yGHOoQKsfcFuBNZIHOsUPpe+aDjibR/EkQii9nF650cdO4go
 POrFVgwE/KlSCd99/zTq+k0Ub9mNXQm5P7HY8sk7SFiWmWWtANam/esdyrjiBVnxn1vN
 ItpflU9k14ZCzSPXvDyfHLPjpkP1rgE2iY9+ZLyVHM4JrgmMeFzQUgOqpbSq88qOdvmo
 Xis0CPVTLsZRGHXCvKa4wj4nu+3UbeCNqXYmRZ39nGHzPbZkp/9J7EB1omAtcnx7lwcd
 n9lXZM/LtvLCCMhmtdRq5+Ozwt1g8fyxLMnPkeGmgjZgEpyYLOXhZ3nu3tEqUefOhrLi
 iRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952816; x=1777557616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I6CFLHuMNx88CjyYDUQpHwR3+vyQaKEvOKoH2tj3KBI=;
 b=PYE16EBXfkQcOl9RY39MfLmJkURhSvwkpMMZRbLESozlyA5mOSQLcc3GS8TFBpwKyX
 htI3Vgv2aBJMq8ixiT33T2SsQaEeI0O9w5tvZmKLcY3SDFSJC7q7PwkVwHTFdZyp3MKE
 D1smEzBsi0q68eua31cbY3WH672d1OJ4BoqMqy0c5njOgrzDdfl6dNylQmVchcr6wO5u
 wXOJwXe6NDm5SbcBiyqzsUzBoBbBih8M9eVfijLUteRiMqvCLApWNeRcPOaA0YKu+BDi
 no2Wh7+uSSNrM0RjPtq+kivV3fSllK7I2uwloege9UkqWudoDFd0HPTi18frtnNwET68
 ly6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hGeHWZsgIdruhEFzogXOA5FXvZoKQYKX/ZERFJNXDP5nsqtAyUxmwY+MqztDf4X+08z0ZGmyYuos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2ywpYSl+RHBtXk0rLObDeDlBkSeUD7A/JgIRk2LBaO5FJ3xbN
 i1tMaU8FhxVeUwmXb14icPTjtKbkLyooG5Ay4dIrwIH8VgYk8FlanYSUT31ugbKo+D+OyD516as
 XBOOP8xRbd2ZFqSoJj4qVdp4my2/xriM=
X-Gm-Gg: AeBDietm2B8cKqc1FGNvEL7251phTq0OfbkYqUq6GM3g6q7u4Wq8xsF3uCi15EmjvdW
 WeNImnlViiUBWcVxKrOuOzaoSE2YaMSfZR3fqfw01BXUic6sr3fcF9P9txu1lQiQtMmtRBmgLRo
 aZR47Ml/HBZhh+opKA29YvsF9LarWFUhYcVCCH3KJrSYY0i+68+V2rNAl6s0lOgFeXDmpgE4X/4
 gHR3c/BuD1hRzFTH6eZLoOO/V4z0eMREgvWaQsUObRIbwtyZhI4ZL4N5dBtm+exWiPWmDs237Hh
 GDM2RG8WlmbeVhnC4Lr9RYPYFbGhX5sdSa4/TsLmorD5NafsH13LW9s9DOgcZ4n2EXn5MbpX5GW
 n88l2
X-Received: by 2002:a05:7022:1282:b0:128:e6e2:0 with SMTP id
 a92af1059eb24-12c73fa23aemr5510335c88.6.1776952815140; Thu, 23 Apr 2026
 07:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260423000629.47095-1-gabrielsousa230@gmail.com>
In-Reply-To: <20260423000629.47095-1-gabrielsousa230@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Apr 2026 10:00:03 -0400
X-Gm-Features: AQROBzABuIfAhLr_mlMeNhXvA3-uI3tYv_M94OeLMXiq2n7dT17FCYn4jQr2u48
Message-ID: <CADnq5_NAykPRCEAPAP7G9jJX7hLdtTfbfhMSt_1r_Z=UtstbmA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: deduplicate register access and helper
 routines
To: Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Thu, Apr 23, 2026 at 4:52=E2=80=AFAM Gabriel Almeida
<gabrielsousa230@gmail.com> wrote:
>
> Several helper functions are duplicated across multiple files with
> identical logic.
>
> Move these helpers to more appropriate locations based on their
> functionality:
> - move read_indexed_register to amdgpu_reg_access.c as
>   amdgpu_read_indexed_register
> - move program_aspm to amdgpu_nbio.c as
>   amdgpu_nbio_program_aspm

Can you split this into two patches?  one for the nbio change and one
for the read_indexed_register change?

Thanks!

Alex

>
> No functional changes intended.
>
> Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> ---
> v2:
> - Move read_indexed_register to amdgpu_reg_access.c instead of a new file
> - Move program_aspm to amdgpu_nbio.c
> - Drop amdgpu_common.[ch]
> - Drop changes to common_sw_init
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      | 10 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |  2 ++
>  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 18 +++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  3 ++
>  drivers/gpu/drm/amd/amdgpu/nv.c               | 30 ++-----------------
>  drivers/gpu/drm/amd/amdgpu/soc15.c            | 30 ++-----------------
>  drivers/gpu/drm/amd/amdgpu/soc21.c            | 30 ++-----------------
>  drivers/gpu/drm/amd/amdgpu/soc24.c            | 21 +------------
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         | 20 +------------
>  9 files changed, 41 insertions(+), 123 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_nbio.c
> index a97426583..e4c8e9872 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -84,3 +84,13 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *ad=
ev, struct ras_common_if *
>         amdgpu_ras_block_late_fini(adev, ras_block);
>         return r;
>  }
> +
> +
> +void amdgpu_nbio_program_aspm(struct amdgpu_device *adev)
> +{
> +       if (!amdgpu_device_should_use_aspm(adev))
> +               return;
> +
> +       if (adev->nbio.funcs->program_aspm)
> +               adev->nbio.funcs->program_aspm(adev);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_nbio.h
> index b528de6a0..a61f3a6e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> @@ -121,4 +121,6 @@ u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_d=
evice *adev);
>
>  bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev);
>
> +void amdgpu_nbio_program_aspm(struct amdgpu_device *adev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_reg_access.c
> index 540040c76..daefbeeee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> @@ -956,3 +956,21 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_de=
vice *adev, uint32_t inst,
>         }
>         return ret;
>  }
> +
> +
> +uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
> +                              u32 se_num, u32 sh_num, u32 reg_offset)
> +{
> +       uint32_t val;
> +
> +       mutex_lock(&adev->grbm_idx_mutex);
> +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> +
> +       val =3D RREG32(reg_offset);
> +
> +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> +       mutex_unlock(&adev->grbm_idx_mutex);
> +       return val;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_reg_access.h
> index 4d88e5cd1..a1011af6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> @@ -160,4 +160,7 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_dev=
ice *adev, uint32_t inst,
>                                     uint32_t reg_addr, char reg_name[],
>                                     uint32_t expected_value, uint32_t mas=
k);
>
> +uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
> +                                       u32 se_num, u32 sh_num, u32 reg_o=
ffset);
> +
>  #endif /* __AMDGPU_REG_ACCESS_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 7ce1a1b95..1ab9d450e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -354,29 +354,13 @@ static struct soc15_allowed_register_entry nv_allow=
ed_read_registers[] =3D {
>         { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
>  };
>
> -static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32=
 se_num,
> -                                        u32 sh_num, u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> -
> -       val =3D RREG32(reg_offset);
> -
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
>
>  static uint32_t nv_get_register_value(struct amdgpu_device *adev,
>                                       bool indexed, u32 se_num,
>                                       u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return nv_read_indexed_register(adev, se_num, sh_num, reg=
_offset);
> +               return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
>         } else {
>                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_C=
ONFIG))
>                         return adev->gfx.config.gb_addr_config;
> @@ -511,16 +495,6 @@ static int nv_set_vce_clocks(struct amdgpu_device *a=
dev, u32 evclk, u32 ecclk)
>         return 0;
>  }
>
> -static void nv_program_aspm(struct amdgpu_device *adev)
> -{
> -       if (!amdgpu_device_should_use_aspm(adev))
> -               return;
> -
> -       if (adev->nbio.funcs->program_aspm)
> -               adev->nbio.funcs->program_aspm(adev);
> -
> -}
> -
>  const struct amdgpu_ip_block_version nv_common_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
>         .major =3D 1,
> @@ -984,7 +958,7 @@ static int nv_common_hw_init(struct amdgpu_ip_block *=
ip_block)
>                 adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev);
>
>         /* enable aspm */
> -       nv_program_aspm(adev);
> +       amdgpu_nbio_program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
>         /* remap HDP registers to a hole in mmio space,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index b456e4541..87b398dd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -401,29 +401,12 @@ static struct soc15_allowed_register_entry soc15_al=
lowed_read_registers[] =3D {
>         { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
>  };
>
> -static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev, =
u32 se_num,
> -                                        u32 sh_num, u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> -
> -       val =3D RREG32(reg_offset);
> -
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
> -
>  static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
>                                          bool indexed, u32 se_num,
>                                          u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc15_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> +               return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
>         } else {
>                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_C=
ONFIG))
>                         return adev->gfx.config.gb_addr_config;
> @@ -695,15 +678,6 @@ static int soc15_set_vce_clocks(struct amdgpu_device=
 *adev, u32 evclk, u32 ecclk
>         return 0;
>  }
>
> -static void soc15_program_aspm(struct amdgpu_device *adev)
> -{
> -       if (!amdgpu_device_should_use_aspm(adev))
> -               return;
> -
> -       if (adev->nbio.funcs->program_aspm)
> -               adev->nbio.funcs->program_aspm(adev);
> -}
> -
>  const struct amdgpu_ip_block_version vega10_common_ip_block =3D
>  {
>         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> @@ -1284,7 +1258,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_bl=
ock *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         /* enable aspm */
> -       soc15_program_aspm(adev);
> +       amdgpu_nbio_program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
>         /* remap HDP registers to a hole in mmio space,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index fbd1d97f3..93c002e51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -306,29 +306,12 @@ static struct soc15_allowed_register_entry soc21_al=
lowed_read_registers[] =3D {
>         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>  };
>
> -static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, =
u32 se_num,
> -                                        u32 sh_num, u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> -
> -       val =3D RREG32(reg_offset);
> -
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
> -
>  static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
>                                       bool indexed, u32 se_num,
>                                       u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc21_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> +               return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
>         } else {
>                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG) && adev->gfx.config.gb_addr_config)
>                         return adev->gfx.config.gb_addr_config;
> @@ -470,15 +453,6 @@ static int soc21_set_vce_clocks(struct amdgpu_device=
 *adev, u32 evclk, u32 ecclk
>         return 0;
>  }
>
> -static void soc21_program_aspm(struct amdgpu_device *adev)
> -{
> -       if (!amdgpu_device_should_use_aspm(adev))
> -               return;
> -
> -       if (adev->nbio.funcs->program_aspm)
> -               adev->nbio.funcs->program_aspm(adev);
> -}
> -
>  const struct amdgpu_ip_block_version soc21_common_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
>         .major =3D 1,
> @@ -925,7 +899,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         /* enable aspm */
> -       soc21_program_aspm(adev);
> +       amdgpu_nbio_program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
>         /* remap HDP registers to a hole in mmio space,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amd=
gpu/soc24.c
> index d1adf19a5..265db9331 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -132,31 +132,12 @@ static struct soc15_allowed_register_entry soc24_al=
lowed_read_registers[] =3D {
>         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>  };
>
> -static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev,
> -                                           u32 se_num,
> -                                           u32 sh_num,
> -                                           u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> -
> -       val =3D RREG32(reg_offset);
> -
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
> -
>  static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
>                                          bool indexed, u32 se_num,
>                                          u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc24_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> +               return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
>         } else {
>                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG) &&
>                     adev->gfx.config.gb_addr_config)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/soc_v1_0.c
> index 709b1669b..4a5fe8e9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -184,31 +184,13 @@ static struct soc15_allowed_register_entry soc_v1_0=
_allowed_read_registers[] =3D {
>         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
>  };
>
> -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *ade=
v,
> -                                              u32 se_num,
> -                                              u32 sh_num,
> -                                              u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> -
> -       val =3D RREG32(reg_offset);
> -
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
>
>  static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev,
>                                             bool indexed, u32 se_num,
>                                             u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc_v1_0_read_indexed_register(adev, se_num, sh_nu=
m, reg_offset);
> +               return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
>         } else {
>                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG_1) &&
>                     adev->gfx.config.gb_addr_config)
> --
> 2.43.0
>
