Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2615EC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74DE210F8C3;
	Fri, 10 Jul 2026 13:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UwlyvmeR";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D4010F8C7
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:21:05 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2ccdce28edeso1340465ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 06:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783689664; cv=none;
 d=google.com; s=arc-20260327;
 b=sR7pCteqOWne+i0hSZjT2XUdZDoAdRDeULLBrZYG9e3xeTGhe5A/35+1uDTbSBm34f
 RHx3utsmU3c3Z4kAr/vHK7uMWDudv+xg0OEfaH9N8caUVzCMfpG6ZHNQLJ/sHWp+Mkbw
 0yIlDjGSGOLxg0JLQLlW6hxI8SbM/LH1lrYR73vc9D/gcJ5/yECb/HWrwqe49ZdEqQ4F
 LDR0q05rMlft9COqyu9aKN4VpuiiLUUELwcUYWTUk0CigRXV39FGKslqo0uNJMGWSIBN
 IAHRIRJZpgKqi7Ia47ihk9qrZq/AWBn0bYqDA+oariIgvXWfymK782D+aQpynYvhidcv
 fc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6Iv3/dHJP9eh11tlfDrZvOZIybFL9oIplbeFCapfAmc=;
 fh=14TPffEYvViGHtj/n2hq8watyIAMK5ZP/D/JcZ0/r/4=;
 b=Y6quE4gWLLcFakTcTQ4P50MZxMSz+1e8uED15ur3NK7++PLhPY/jcK5cFMd5N3GXq4
 JOHyWlmO+Qn0hMnjh97Jrdt//R9TfyceOsHNVH5EHrBDGzW/1RouUSK+WpCvRXgwyRGK
 YrKfBsVNjmU08od/garI5ip4JxaZDRB4tQeDDig0u+FnFAFSYmdbpvnjazTkJQ/BlUwv
 X5iAllfcl6LvSofj73wpHvDuxQzj9pMHGTrlniFMS62xHOz/rPvAIwjQ3ZyFuNydbam+
 6oWs7weJAHbA9fmPFMu7oad+XX7waT5QpefEcPCgt92u1DzKE1BNZcZ1G+Z7UyzmIE1K
 STgg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783689664; x=1784294464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Iv3/dHJP9eh11tlfDrZvOZIybFL9oIplbeFCapfAmc=;
 b=UwlyvmeRQkvUJG8Kl2nxCt+d9I15hSxFVRPhl4zQAaSB6Bug5/x/jcSMhR7thLWdao
 nkhEqTQ+MehDeVlcbRH7RAhYTf+Sq6q7epdtu58Za4nOAlr5iiszrSf5hqHtS9fPCHZN
 SFX67lQaIbOyWWMbvV47MlzJg4xufR+zL9FsAKULcctOmKU4vocUO6SvrHdZv+HFLORt
 oImoXgiIU/teESm7Mpnauns/LmbMS1SItdQoB3GkrlxHe87MKHaTNqPHAYkdTO594hjZ
 CKOud7VhBzvlgk0hRuLseTvqqOTQ72ntIsrWpaIaIjnOxZBGrEsIDRjpO8JV56cun7jY
 LSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783689664; x=1784294464;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Iv3/dHJP9eh11tlfDrZvOZIybFL9oIplbeFCapfAmc=;
 b=UfFXnyfSVZTT7sktFrM3Hf7C8Z1MCOTomyQrAWCx0OjL3G3IJOXwfVqXEdfYWbNiCt
 hPWirLS28TaDubsxtXIYurhE1k7RzES+lpqhyitK2BPfijecZ5Xvw9lbjNGvVl/moY+Z
 DHLXTrrNFyLRiZz+e09RB+ABmyN9swVfRNH432sXXT3qopHHsq5KExxjiasb21CwNMBB
 0RRfbG7GKKi1azTUkUbFNqmp8eO7Q7svSAfB10p+qqlYQ04SD3cRbXQ5sftSEPXyKkfA
 SWyn4+mbdSHh0VS0TmJnNWo5agH74AOx5Cv9HlrJogWyLzp38ddx/dZD9UZSXUWu69eA
 +M0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+5MNGCLJGL2LDRAeRqrOVKxpMtG0KbUPdxKlsPDuid/ab59C2tyEZMqy7o6WF07Hh+42ErUQxOLA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymIlC/bdv42S2tIIFWGUp47ZDP4TkSjM+Oi6E2qHCkZTJ584zs
 dauArbGcpyuaseXlensKxgRco6z+Skov/CTWBntTQtO97JOpqb+OO2Qt9KFEvLnadia2E1//t6q
 BHYiZkQxeO00NTzLAT0JuIwX1EJIrAFk=
X-Gm-Gg: AfdE7ckyU2gZLvpHAhoR7z08TvzMpKNqxMIVyVL1QSM0EacakQsIek0aujMMTWTVm5y
 gzcv+N57vRCCWlc9z6kbS76LcJ+P/aPhVAX36YUk/pT+3HxhzukhbnoR3DFnGeyC6+X13bILAhh
 +leYV1mKTOJyjKRxg8fop4UTokLKS2sMafHLsKf3yJv94XjbxDKtcNDEeCOfTs5xXtQ1gCVhDVn
 xicxdXSeUNLSxr/2ze449z26IHjtlFhOTxb+xXp2DsEjnpNDAByk2+AwMcD52RSJo2yExMEl0T2
 H1Q1m/6t6dGbVXK6gV0iLuGG411YKTrzwyIrH7cuIkgsiSmsdCp9ERnMbit23CBdAMsw/w==
X-Received: by 2002:a17:902:e5c5:b0:2c6:b3d9:9bbd with SMTP id
 d9443c01a7336-2ccea4822d3mr83423935ad.8.1783689664480; Fri, 10 Jul 2026
 06:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260708163013.221986-1-andrebueno.mac@gmail.com>
In-Reply-To: <20260708163013.221986-1-andrebueno.mac@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2026 09:20:52 -0400
X-Gm-Features: AVVi8CdHtR54ckxCbr800ZtgJ2GncqvnzX-KSnJuu5g2WzyX6D9T6ZYw-f3QraM
Message-ID: <CADnq5_PXnX97HrF3t1xXeEZR7iV6ojDyTc3ReiNurY15e8bvLg@mail.gmail.com>
Subject: Re: [PATCH V2] drm/amdgpu: deduplicate JPEG v5.0 interrupt routine
To: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 Enzo Furegatti Spinella <enzo.spinella@usp.br>, dri-devel@lists.freedesktop.org
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

Applied.  Thanks!

On Thu, Jul 9, 2026 at 3:44=E2=80=AFAM Andre Luiz Batista Bueno
<andrebueno.mac@gmail.com> wrote:
>
> Both jpeg_v5_0_1.c and jpeg_v5_0_2.c implement identical
> interrupt processing routines. To avoid code duplication,
> make the implementation in jpeg_v5_0_1.c non-static and
> call it directly from jpeg_v5_0_2.c.
>
> Signed-off-by: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
> Co-developed-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
> Signed-off-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
> ---
>
> v2:
>  - Dropped the new jpeg_v5_0_interrupt.c/h files and Makefile changes.
>  - Kept the interrupt routine in jpeg_v5_0_1.c but removed the 'static' m=
odifier.
>  - Declared the function prototype in jpeg_v5_0_1.h and included it in jp=
eg_v5_0_2.c to call it directly, as suggested by Alex Deucher.
>
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h |  8 +++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 63 ++----------------------
>  3 files changed, 12 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_1.c
> index edecbfe66c79..46bcbecd89e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -755,7 +755,7 @@ static int jpeg_v5_0_1_set_ras_interrupt_state(struct=
 amdgpu_device *adev,
>
>
>
> -static int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
> +int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
>                                          struct amdgpu_irq_src *source,
>                                          struct amdgpu_iv_entry *entry)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_1.h
> index a7e58d5fb246..67346faecb47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
> @@ -108,4 +108,12 @@ enum amdgpu_jpeg_v5_0_1_sub_block {
>         AMDGPU_JPEG_V5_0_1_MAX_SUB_BLOCK,
>  };
>
> +struct amdgpu_irq_src;
> +struct amdgpu_iv_entry;
> +struct amdgpu_device;
> +
> +int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
> +                                       struct amdgpu_irq_src *source,
> +                                       struct amdgpu_iv_entry *entry);
> +
>  #endif /* __JPEG_V5_0_1_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_2.c
> index 285c459379c4..250e7f849037 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -34,6 +34,8 @@
>  #include "vcn/vcn_5_0_0_sh_mask.h"
>  #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
>
> +#include "jpeg_v5_0_1.h"
> +
>  static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
>  static int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_=
block,
> @@ -583,65 +585,6 @@ static int jpeg_v5_0_2_set_interrupt_state(struct am=
dgpu_device *adev,
>         return 0;
>  }
>
> -static int jpeg_v5_0_2_process_interrupt(struct amdgpu_device *adev,
> -                                        struct amdgpu_irq_src *source,
> -                                        struct amdgpu_iv_entry *entry)
> -{
> -       u32 i, inst;
> -
> -       i =3D node_id_to_phys_map[entry->node_id];
> -       DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
> -
> -       for (inst =3D 0; inst < adev->jpeg.num_jpeg_inst; ++inst)
> -               if (adev->jpeg.inst[inst].aid_id =3D=3D i)
> -                       break;
> -
> -       if (inst >=3D adev->jpeg.num_jpeg_inst) {
> -               dev_WARN_ONCE(adev->dev, 1,
> -                             "Interrupt received for unknown JPEG instan=
ce %d",
> -                             entry->node_id);
> -               return 0;
> -       }
> -
> -       switch (entry->src_id) {
> -       case VCN_5_0__SRCID__JPEG_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[0]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG1_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[1]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG2_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[2]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG3_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG4_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG5_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG6_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG7_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG8_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[8]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG9_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[9]);
> -               break;
> -       default:
> -               DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
> -                             entry->src_id, entry->src_data[0]);
> -               break;
> -       }
> -
> -       return 0;
> -}
>
>  static void jpeg_v5_0_2_core_stall_reset(struct amdgpu_ring *ring)
>  {
> @@ -749,7 +692,7 @@ static void jpeg_v5_0_2_set_dec_ring_funcs(struct amd=
gpu_device *adev)
>
>  static const struct amdgpu_irq_src_funcs jpeg_v5_0_2_irq_funcs =3D {
>         .set =3D jpeg_v5_0_2_set_interrupt_state,
> -       .process =3D jpeg_v5_0_2_process_interrupt,
> +       .process =3D jpeg_v5_0_1_process_interrupt,
>  };
>
>  static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev)
> --
> 2.43.0
>
