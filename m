Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81049C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC6E10E045;
	Wed, 29 Jul 2026 14:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g5IYgvSk";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB00D10E05F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 14:27:08 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38f0f3c8da5so62970a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 07:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785335228; cv=none;
 d=google.com; s=arc-20260327;
 b=Zn4k3fGPifJ3z1tAFSdF+4+g3FmDup/by+ZF/vHr7Aj/ae6YN46C4WedDAwcAT/Mg7
 A1z24HExKFdGfQwOwwE41B/29qMdcrI7iuQL4uYHgCFHdT9F5mrBErExevZMeeHzdyb9
 pRnEF1se+sn3jyytWEi5XHwXWB0EgwZwGJjdJFoJEvw9MaASZA5qrkUwYJ13Wk6DvCRl
 dY6eu+UOr1pWgonyb+D4NIVW41Opm9IcOPX+hQslYmRSNxzi9TD68F/reloPhpFHunMR
 0wF5slL+lf/Bva7o308K5ZVB/g844KMjAOdRuX/jCP9kye6Zx5u0wfO0/k1SPhpB/+iA
 xaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WcAoRHX5Lz4yZq7liK5NCNwwh2h8iVDwMsz9J02CXj8=;
 fh=fYuTBsOZlA4N5rVdYJ+1cuYwkpsnW1d4utos+TEJfdE=;
 b=jp8PvcXcM3J6WBrfClaHp4bknCyNZbyxXMzR5kdlFWuxhfAocjgZm4my8gBE+pGOmN
 FfZYh/UHOu/0b3Iom4Ra9jZXs/skNgTS5mtOBCNPosGfmrkyhzIODk6VGfs/NRvBK694
 B/Y2uXNeSQnME9FftxoMYcU1Hn76w4Lo7dw80EOxHc/f2K+uMO98x1Xv91F8d8+9aiKi
 Cv4e9Mjw2k84A2I5q2RitHZ4sLlh+DRWELMYfqnA3eptv8Wil9OUXBsQb12cv/x3LaZH
 /I7aicrogTocV302lWAXNbN0B+5YgdAuKRZsdvdyReZ+Bqgp8+gaxtEorvnGO1VykIMv
 fJUA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785335228; x=1785940028; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WcAoRHX5Lz4yZq7liK5NCNwwh2h8iVDwMsz9J02CXj8=;
 b=g5IYgvSkD048zGmDe9uu8d/5fql6q6Yc3qWi3Oyqgymnbybgu9cfA8N6ahFoHK3pgx
 fN4WgLIkNpRCDHiHw5Wx1EChrCA74GYatdsUPJbgIlqqCmfkVnEL5M9ZCb5uSADmITJL
 gs0J37s2FHD4JYKwFPJ1ytP1Kp84ssm3P1R4pmxBQ95qVg92SAnuLPCZgFiOyIAHf+z/
 Ys9nrKoDmLbqyWjMTkeCtuX5cf/wWGAxBXfQ7ZWUYYni2lYztPHvLshsGUD/RfXS8fQ7
 FfDORhoERyd2KQKft7WPNRTifLkqaLqEPUdV2Is6LLuhX0S81Q5W6IirTQFtsEm5Bhe3
 G0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785335228; x=1785940028;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WcAoRHX5Lz4yZq7liK5NCNwwh2h8iVDwMsz9J02CXj8=;
 b=RDdXPbLV0+2hSTKKuhuYJjwLiw/8GJXSeoRphS36SzVlFdzVCr1156FvjqDhBbAgBy
 GcepTppe3Gw/SP5n43DnlFc2u+oX87wrfwtQ2aqxkt89iA1eGDUHVU+2YR2LFv/MZBb1
 1ge4Y/Dtwj3VeJ3Wf/Dww7kRGimRrALgOZXqGsyFA6LrQDS9LreIpN947MSxGnxpoVua
 5dG1DvSKJkecvivAhx5P3A78VHR7dhdYq2NtGFs1boicxbRhDmIHtfz03bdk0HGnMhEy
 SmMX8wqrWE/Rg1yo8kDdC6SO5qhMetYl7VL0qpBb4VMsUUH7hIrXRRXpCbCKFqOeUNQb
 7ldA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQgZqADzTauNjElEqNnxwQA8xW+lh5NRh5rfFxbvF5GSxnGu8sce+Ny7mGtMbra4Jb6zhWm3a+Lt8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKx72ei3KKF0eVV+ZnutM2z/bYUBWH1y+Z5ZcwrrSpxhBRin5Y
 KR8K7cq/aDFFSCjsybMEebQczZzmEyX2M5arnILwPnNYlyLo1uB+O71t5FDjpJ88F0ZjePizMgx
 89+DQAGj2YuhW6L6bEUlFyXWgVFscEjs=
X-Gm-Gg: AR+sD10LZtfpT0O5jg+M22KN8KFIY0pd4EB/g47MobDYsQGG2RQ6B3vYYRMGTvNaQiw
 PL6zn+i4P/y1uuwjMtkBc4X61bjciadrO3Wa26k+cTbWIl/3VOL8LBYsczDhqpvysyLheMMyN6S
 zthnoaPBuhIAKZfJVJ0EqhrtOczr2mgPTi7Zxi0DHicmBEdpb9uHUJicsMG9VUFxhdQmPWHe1Jm
 psh83/srR2G1KcRXBeXCsXx4vRyqqbjxtqH1/6D4klLUGL0MOe+a2ihcJ4P+aPTkGw7sARnod4w
 bCMDofyG5h1bTrauLKeVZHn2wroQQFbR/sgUWgGuLRUpGQg72AdxIPGQHL2uSsN7WFq5wcZlJ9/
 eS1MhFdhqOlyUjnnw6Khc13LtF2Bmh18=
X-Received: by 2002:a17:90b:4490:b0:38e:91a8:fb85 with SMTP id
 98e67ed59e1d1-38f6a45bf0cmr6253567a91.3.1785335228022; Wed, 29 Jul 2026
 07:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260728072643.5F3A71F000E9@smtp.kernel.org>
 <20260728222436.8393-1-ulissespaixao@usp.br>
In-Reply-To: <20260728222436.8393-1-ulissespaixao@usp.br>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Jul 2026 10:26:56 -0400
X-Gm-Features: AUfX_mwXxZxCxY7eR9kHoro_h9YENs2g0VuYvfSP8z2iZ5T2d6LtZNBRvcx7K-0
Message-ID: <CADnq5_PEZTzk4KXDE05LjidaobzGRLDWK1mDxwBBVvVwu1s4qQ@mail.gmail.com>
Subject: Re: [PATCH v6] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
To: Ulisses Paixao <ulissespaixao@usp.br>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Jul 29, 2026 at 9:49=E2=80=AFAM Ulisses Paixao <ulissespaixao@usp.b=
r> wrote:
>
> The functions gfx_v11_0_handle_priv_fault and
> gfx_v12_0_handle_priv_fault share the same logic for searching and
> triggering a scheduler fault on a ring. This patch moves the shared
> ring-searching logic to a common function, amdgpu_gfx_handle_priv_fault,
> in amdgpu_gfx.c. The hardware-specific decoding of ring IDs remains in
> the version-specific files to maintain proper architectural separation.
>
> Signed-off-by: Ulisses Paixao <ulissespaixao@usp.br>
> Co-developed-by: Felipe Sousa <felipesousa@usp.br>
> Signed-off-by: Felipe Sousa <felipesousa@usp.br>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
> v6:
> Updated code with latest changes from amd-staging-drm-next.
>
> v5:
> Return early on adv->gfx.disable_kq check.
>
> v4:
> Restore the adev->gfx.disable_kq check to prevent falsely triggering
> scheduler faults on idle kernel rings when MES is managing user queues.
>
> v3:
> Return early if the ring is found in the gfx rings loop.
>
> v2:
> Keep the HW-specific decoding in gfx_v11_0.c and gfx_v12_0.c.
> Remove the redundant check for adev->gfx.disable_kq.
> Simplify the search loop in amdgpu_gfx_handle_priv_fault to iterate over
> all gfx and compute rings without a switch statement.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 53 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 49 +++--------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 50 +++--------------------
>  4 files changed, 66 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 9d3b40c38..9ff0829ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -34,6 +34,7 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_mes.h"
> +#include "amdgpu_userq.h"
>  #include "mes_userqueue.h"
>  #include "nvd.h"
>
> @@ -855,6 +856,58 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev=
, int xcc_id)
>         return r;
>  }
>
> +/**
> + * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
> + *
> + * @adev: amdgpu_device pointer
> + * @entry: interrupt vector entry containing fault information
> + * @me_id: micro-engine ID of the faulty ring
> + * @pipe_id: pipe ID of the faulty ring
> + * @queue_id: queue ID of the faulty ring
> + *
> + * This function handles privileged instruction faults by identifying
> + * the faulty ring (gfx or compute) and triggering a scheduler fault
> + */
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +                                       struct amdgpu_iv_entry *entry,
> +                                       u8 me_id, u8 pipe_id, u8 queue_id=
)
> +{
> +       struct amdgpu_ring *ring;
> +       int i;
> +
> +       /*
> +        * Try KQ first by ring_id (HW slot is authoritative). The
> +        * KMD compute_hqd_mask contract guarantees KCQ and user queues
> +        * never share a HW slot.
> +        */
> +       if (!adev->gfx.disable_kq) {
> +               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> +                       ring =3D &adev->gfx.gfx_ring[i];
> +                       if (ring->me =3D=3D me_id && ring->pipe =3D=3D pi=
pe_id &&
> +                           ring->queue =3D=3D queue_id) {
> +                               drm_sched_fault(&ring->sched);
> +                               return;
> +                       }
> +               }
> +
> +               for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +                       ring =3D &adev->gfx.compute_ring[i];
> +                       if (ring->me =3D=3D me_id && ring->pipe =3D=3D pi=
pe_id &&
> +                           ring->queue =3D=3D queue_id) {
> +                               drm_sched_fault(&ring->sched);
> +                               return;
> +                       }
> +               }
> +       }
> +
> +       u32 doorbell_offset =3D entry->src_data[0] & AMDGPU_CTXID0_DOORBE=
LL_ID_MASK;
> +
> +       /* No KQ matched: HW slot is a MES-scheduled user queue. */
> +       if (adev->enable_mes && doorbell_offset)
> +               amdgpu_userq_process_reset_irq(adev, entry->pasid,
> +                                              doorbell_offset);
> +}
> +
>  static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enab=
le,
>                                    bool no_delay)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index aefd4f03b..c15f45a73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -620,6 +620,9 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struc=
t amdgpu_device *adev,
>                                                 struct amdgpu_ring *ring)=
;
>  bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
>                                     int pipe, int queue);
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +                                       struct amdgpu_iv_entry *entry,
> +                                       u8 me_id, u8 pipe_id, u8 queue_id=
);
>  void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
>  void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enab=
le);
>  int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *valu=
e);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 0cbbdc369..489e0c97e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6710,52 +6710,13 @@ static int gfx_v11_0_set_priv_inst_fault_state(st=
ruct amdgpu_device *adev,
>  static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
>                                         struct amdgpu_iv_entry *entry)
>  {
> -       u32 doorbell_offset =3D entry->src_data[0] & AMDGPU_CTXID0_DOORBE=
LL_ID_MASK;
> +       u8 me_id, pipe_id, queue_id;
>
> -       /*
> -        * Try KQ first by ring_id (HW slot is authoritative). The
> -        * KMD compute_hqd_mask contract guarantees KCQ and user queues
> -        * never share a HW slot.
> -        */
> -       if (!adev->gfx.disable_kq) {
> -               u8 me_id =3D (entry->ring_id & 0x0c) >> 2;
> -               u8 pipe_id =3D (entry->ring_id & 0x03) >> 0;
> -               u8 queue_id =3D (entry->ring_id & 0x70) >> 4;
> -               struct amdgpu_ring *ring;
> -               int i;
> -
> -               switch (me_id) {
> -               case 0:
> -                       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -                               ring =3D &adev->gfx.gfx_ring[i];
> -                               if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id) {
> -                                       drm_sched_fault(&ring->sched);
> -                                       return;
> -                               }
> -                       }
> -                       break;
> -               case 1:
> -               case 2:
> -                       for (i =3D 0; i < adev->gfx.num_compute_rings; i+=
+) {
> -                               ring =3D &adev->gfx.compute_ring[i];
> -                               if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id) {
> -                                       drm_sched_fault(&ring->sched);
> -                                       return;
> -                               }
> -                       }
> -                       break;
> -               default:
> -                       BUG();
> -                       break;
> -               }
> -       }
> +       me_id =3D (entry->ring_id & 0x0c) >> 2;
> +       pipe_id =3D (entry->ring_id & 0x03) >> 0;
> +       queue_id =3D (entry->ring_id & 0x70) >> 4;
>
> -       /* No KQ matched: HW slot is a MES-scheduled user queue. */
> -       if (adev->enable_mes && doorbell_offset)
> -               amdgpu_userq_process_reset_irq(adev, entry->pasid,
> -                                              doorbell_offset);
> +       amdgpu_gfx_handle_priv_fault(adev, entry, me_id, pipe_id, queue_i=
d);
>  }
>
>  static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index b3887c526..32cd9ad66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5041,53 +5041,13 @@ static int gfx_v12_0_set_priv_inst_fault_state(st=
ruct amdgpu_device *adev,
>  static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
>                                         struct amdgpu_iv_entry *entry)
>  {
> -       u32 doorbell_offset =3D entry->src_data[0] & AMDGPU_CTXID0_DOORBE=
LL_ID_MASK;
> +       u8 me_id, pipe_id, queue_id;
>
> -       /*
> -        * Try KQ first by ring_id; UQ as fallback. KCQ and UQ never shar=
e
> -        * a HW slot (compute_hqd_mask contract).
> -        */
> -       if (!adev->gfx.disable_kq) {
> -               u8 me_id, pipe_id, queue_id;
> -               struct amdgpu_ring *ring;
> -               int i;
> -
> -               me_id =3D (entry->ring_id & 0x0c) >> 2;
> -               pipe_id =3D (entry->ring_id & 0x03) >> 0;
> -               queue_id =3D (entry->ring_id & 0x70) >> 4;
> -
> -               switch (me_id) {
> -               case 0:
> -                       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -                               ring =3D &adev->gfx.gfx_ring[i];
> -                               if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id) {
> -                                       drm_sched_fault(&ring->sched);
> -                                       return;
> -                               }
> -                       }
> -                       break;
> -               case 1:
> -               case 2:
> -                       for (i =3D 0; i < adev->gfx.num_compute_rings; i+=
+) {
> -                               ring =3D &adev->gfx.compute_ring[i];
> -                               if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id) {
> -                                       drm_sched_fault(&ring->sched);
> -                                       return;
> -                               }
> -                       }
> -                       break;
> -               default:
> -                       BUG();
> -                       break;
> -               }
> -       }
> +       me_id =3D (entry->ring_id & 0x0c) >> 2;
> +       pipe_id =3D (entry->ring_id & 0x03) >> 0;
> +       queue_id =3D (entry->ring_id & 0x70) >> 4;
>
> -       /* No KQ matched: HW slot is a MES-scheduled user queue. */
> -       if (adev->enable_mes && doorbell_offset)
> -               amdgpu_userq_process_reset_irq(adev, entry->pasid,
> -                                              doorbell_offset);
> +       amdgpu_gfx_handle_priv_fault(adev, entry, me_id, pipe_id, queue_i=
d);
>  }
>
>  static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
> --
> 2.34.1
>
