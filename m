Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B061F8A176
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DDF10E1E5;
	Thu, 16 Apr 2026 13:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MoonP/c0";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C7D10E1E5
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 13:28:08 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2d9b27e4aa3so185383eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 06:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776346088; cv=none;
 d=google.com; s=arc-20240605;
 b=LdMBpyJUKHA8TbpJPPzGe+Qmw2/TPJWIpa37Jgi3P3wCvRLlS4zPGYZQyyINp4M4KZ
 kZaKPyg2/A1+xlY1QLRWUoPlx3RU2zew4mpt+li5jItA7hl5Jhu2ZLXRE+xSZY9OeJbh
 mDs2CSwUe6WF9nWoUspz9y8ttgx0KiBcqjW10PApvFI5o+RGcrh6QGr//sUWkCBnzl+P
 xRhylatCTU6y75U5frfFijX4yuJKVxmw+s8ZTnXZ40R+g+dhAXk0Kbs3lm2OdxeTiUD6
 xItgH/Cj8zHMPb0dxPKe0stUa0XMDtxtkX0Wdq9/SDIueM5pY7iaQu0hiY0ooed1yOS5
 hAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jwhq/rWJv+hSIncbqP+T4zRf5Z8JAVJckW0Tn/6VCys=;
 fh=mWlmI8fyiNvvP12RzMimJojmEy66muhiPHwSUCQduv4=;
 b=Ic4UH1nP4uraNRFEJJ90PIPQTYa3WojvWbbeziCjiqOkqFUAawJrzS8D8QwyPqRv39
 ZvH73xOWy52vAEXShsNo2nVmPrDqARr3QwRaLYH4K7mhAFzuiZ67pftO1MRCxzViqKQ8
 S7Iu/wWgSvx133OGSSyh9ORSSXHrqhNGwmq33GWWYzR2jqVo1x/KztyC96tYnwYkbBH3
 ld0oLAo2ZZ7MZ0XZlm/XqBYNCHmCRIKpSDCeuxsdcnMpgmjmymEBVe9L6+ndFtrPYiIY
 G0cy5UGgpMUp/ANDG4Ls2pd/x+L5xa+cRBVdnJG1hQ11E0eeWFru1O7KhAcF+m2qA/wJ
 iZBA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776346088; x=1776950888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwhq/rWJv+hSIncbqP+T4zRf5Z8JAVJckW0Tn/6VCys=;
 b=MoonP/c0aocnapVDPtFcfopjTw9ri/Y8AfmaXmwSCcVWhAIroKIOCMct76rTF4dTjs
 IvRFxvlLy9Xpdtk4fhuNAMZr1a7/5IrsrbgYykMMVSFEvUJAYYQrc/Na+iywmVn485EV
 zbUW3L7+wo85cgFNZWGXesrtWpzgc1xJr8EetfLMt7d7kF9DdFYrhG/cmfQgxnnTgh2c
 gxWaMulobxEVtLlPIFTXuvxLFrFjZeNml738+EaoM8QekR2JdR+p1rzw02VQTk3FnmCM
 00lOguYr1MjVmzPHYgFhbF4vSV3q5PJ4648u69al5qKjPUfyuzG+yoHhx7gU8PceQuIy
 ogug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776346088; x=1776950888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jwhq/rWJv+hSIncbqP+T4zRf5Z8JAVJckW0Tn/6VCys=;
 b=gJH8dK658MMKAQNrZB/GcX1rUvoi+1Ulfsj8WQ4MaQAipk4YDvcXRLORJI2QGlo2dG
 NPolEUnmyzLMcZFWz+f8v4/FBPw+QuJYc4XAXRhGgSPrqfABz7AdG0axxrIIrFtF0plH
 7QwfT85LW4Ei0xYNAdIynwmsOU7+GipCZ+1gBoVzKPLWz2srJ2ckFgyejPR6Xo9Th77V
 NOVcsRn7DYFyHs0Z911hW1uawFih+yDIyN4qNXdm2ud4GfdRvxdpQJsjijf7vZJkmoYQ
 PCHptTWcJgSeh7e3ypZxdOH8haVLaeAX9akRQWphkcnJWqEz7rl2hJ2DF9FEZ7Gu5jbI
 btgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bpNQiRso3FO/3u2vQaHynZGBLslLC2ubl0YJeCjkQ39/+1emqN7Bntf5JijShYhOIVKH/dal3hVQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSKQz+CGf4uEsJeaKJ27OU58UI0Isnx2I3/Ym18Q8RXb0Ie/fY
 IworUYvmqObIpR4fgriL+OhewJ6weir/V2r0D4RAmJvUIisSK18DrrmU2LLk/ONBLL/jhALdqMG
 wcH0xaR1qkaCQ97UChKCZ7UiOdZAwidY=
X-Gm-Gg: AeBDies3kviPnj61KE04OgKabMDvPXc9c/UfA1A1oqN73wLm35iNOUMX/xxiA0GQXWT
 OBZeHhRa5CsnWnV3hFhOQh6a9PPIFz0f+Fye+AdHdETQp1yuuRf9M14io4R6+TiBzr66wqEZ+WG
 py0i0M8YJim2+VvmI2LIzMbJxYF27MzdyJabcaJF1G6umkXDsVM8VOHZ3QwFDIWdzBNbpyeQvt3
 d+bGq8Xf88RS+IL3KbdiA29x+B78CasPWfZ5aaAcHa9y2WGLEV/+Ot9P9wun85E/yqePFC3RHfE
 pHGN/Xs3HxzP3O9tEvJjuJVgKfwOepEbT4YzvroytekLcZznHuqRHQIVcpbyeRIdwTgtwQ==
X-Received: by 2002:a05:7022:698e:b0:127:def:dd72 with SMTP id
 a92af1059eb24-12c65906a48mr552300c88.2.1776346087791; Thu, 16 Apr 2026
 06:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260415164029.52537-1-leonardocesar@usp.br>
In-Reply-To: <20260415164029.52537-1-leonardocesar@usp.br>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Apr 2026 09:27:54 -0400
X-Gm-Features: AQROBzABpaNT6X8DJN-YvzCXN2JUjZTRyimTed_f2ZFWFV7TJ7I7jo0CAlHdb0I
Message-ID: <CADnq5_MbpE9AT8qZiLQkYZ7QZ2YWwmu2U8vj3+C+umR1dnJL9A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: deduplicate ring preempt ib function
To: Leonardo Cesar <leonardocesar@usp.br>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
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

On Thu, Apr 16, 2026 at 4:54=E2=80=AFAM Leonardo Cesar <leonardocesar@usp.b=
r> wrote:
>
> The ring preemption function is identical for both gfx_v11_0 and
> gfx_v12_0. This patch refactors the code by moving the core logic
> into a generic function inside amdgpu_gfx.c to reduce code
> duplication and simplify future maintenance.
>
> Signed-off-by: Leonardo Cesar <leonardocesar@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 51 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 47 +----------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 47 +----------------------
>  4 files changed, 55 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 2956e45c9..a157cbd8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2684,3 +2684,54 @@ void amdgpu_debugfs_compute_sched_mask_init(struct=
 amdgpu_device *adev)
>  #endif
>  }
>
> +int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
> +{
> +       int i, r =3D 0;
> +       struct amdgpu_device *adev =3D ring->adev;
> +       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> +       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> +       unsigned long flags;
> +
> +       if (adev->enable_mes)
> +               return -EINVAL;
> +
> +       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> +               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +               return -ENOMEM;
> +       }
> +
> +       /* assert preemption condition */
> +       amdgpu_ring_set_preempt_cond_exec(ring, false);
> +
> +       /* assert IB preemption, emit the trailing fence */
> +       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMA=
P,
> +                                       ring->trail_fence_gpu_addr,
> +                                       ++ring->trail_seq);
> +       amdgpu_ring_commit(kiq_ring);
> +
> +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +       /* poll the trailing fence */
> +       for (i =3D 0; i < adev->usec_timeout; i++) {
> +               if (ring->trail_seq =3D=3D
> +                       le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> +                       break;
> +               udelay(1);
> +       }
> +
> +       if (i >=3D adev->usec_timeout) {
> +               r =3D -EINVAL;
> +               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> +       }
> +
> +       /* deassert preemption condition */
> +       amdgpu_ring_set_preempt_cond_exec(ring, true);
> +       return r;
> +}
> +
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index a0cf0a3b4..77050f988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -664,6 +664,8 @@ void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 cou=
nt);
>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>
> +int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring);
> +
>  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
>  {
>         switch (mode) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5097de940..ef9c61d9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6208,52 +6208,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct =
amdgpu_ring *ring,
>
>  static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
>  {
> -       int i, r =3D 0;
> -       struct amdgpu_device *adev =3D ring->adev;
> -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> -       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> -       unsigned long flags;
> -
> -       if (adev->enable_mes)
> -               return -EINVAL;
> -
> -       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -               return -EINVAL;
> -
> -       spin_lock_irqsave(&kiq->ring_lock, flags);
> -
> -       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> -               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -               return -ENOMEM;
> -       }
> -
> -       /* assert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, false);
> -
> -       /* assert IB preemption, emit the trailing fence */
> -       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMA=
P,
> -                                  ring->trail_fence_gpu_addr,
> -                                  ++ring->trail_seq);
> -       amdgpu_ring_commit(kiq_ring);
> -
> -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -       /* poll the trailing fence */
> -       for (i =3D 0; i < adev->usec_timeout; i++) {
> -               if (ring->trail_seq =3D=3D
> -                   le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> -                       break;
> -               udelay(1);
> -       }
> -
> -       if (i >=3D adev->usec_timeout) {
> -               r =3D -EINVAL;
> -               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> -       }
> -
> -       /* deassert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, true);
> -       return r;
> +       return amdgpu_gfx_ring_preempt_ib(ring);

There's no need to wrap this.  Just replace the call sites with the
new function.

Alex

>  }
>
>  static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool r=
esume)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 65c33823a..fc5ec2778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4613,52 +4613,7 @@ static unsigned gfx_v12_0_ring_emit_init_cond_exec=
(struct amdgpu_ring *ring,
>
>  static int gfx_v12_0_ring_preempt_ib(struct amdgpu_ring *ring)
>  {
> -       int i, r =3D 0;
> -       struct amdgpu_device *adev =3D ring->adev;
> -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> -       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> -       unsigned long flags;
> -
> -       if (adev->enable_mes)
> -               return -EINVAL;
> -
> -       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -               return -EINVAL;
> -
> -       spin_lock_irqsave(&kiq->ring_lock, flags);
> -
> -       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> -               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -               return -ENOMEM;
> -       }
> -
> -       /* assert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, false);
> -
> -       /* assert IB preemption, emit the trailing fence */
> -       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMA=
P,
> -                                  ring->trail_fence_gpu_addr,
> -                                  ++ring->trail_seq);
> -       amdgpu_ring_commit(kiq_ring);
> -
> -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -       /* poll the trailing fence */
> -       for (i =3D 0; i < adev->usec_timeout; i++) {
> -               if (ring->trail_seq =3D=3D
> -                   le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> -                       break;
> -               udelay(1);
> -       }
> -
> -       if (i >=3D adev->usec_timeout) {
> -               r =3D -EINVAL;
> -               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> -       }
> -
> -       /* deassert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, true);
> -       return r;
> +       return amdgpu_gfx_ring_preempt_ib(ring);
>  }
>
>  static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t =
reg,
> --
> 2.43.0
>
