Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583A7C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997A410F8D4;
	Fri, 10 Jul 2026 13:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZOGXUMS";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FAD110F8D4
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:23:40 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-384422b05b5so162450a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 06:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783689820; cv=none;
 d=google.com; s=arc-20260327;
 b=qyExDIxe2NFVL8FvyzLuKUM8VmUEalloFmTt2WDj0gGKPmHW+TP6UoXqcRmV0SWGTW
 meo95dWBQUGlYRU9WIZL3AQhlG3k4+JgR1IJVn4vhFdBdNqlMvYnePjEJ9uAUbhQOfe3
 GVJjMo8qMmViLeHN6XBeUYlcdg3+E6fg1dJ104lD7VpIc3C2ze2HilPlA4K5HWsTWrGv
 GewBWAyQylv8g6CqAmta/fiZPB9TZkSrzePEZOJcnKw2sH1WmjxgFODAhZ4KYpldVzsr
 shBAWel+jUP68DVxJFns3k3CLHE67WEhxD/OUX3E/TZFXA/8d+voJzLx68bPZsbQ31IA
 AOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A+55NFv/oNTAVwlYXY4Qavuiv1ZmlNGS6X9JQC9FXiU=;
 fh=9SUtHDOyXuHZCY2eAbb6JrbyB8UhaP2x1ieZX5HS+gc=;
 b=Ve+RwUkQmgEykeR5R0jygmkYo6lzReNKfNo4mlDYAY57n295H8UbzL/KgCASEb1zh0
 91jhRmCkgdFsA91JM8vBQi/EqsV1kIGof8gMT8HeICRsriTawr3gaK+V7/ABv9KmbeeV
 JL8dCDNMZDRBJcfAUVvuS5VTi31fIrXBqp5w6Zl0jv9Br++6sg2okm54sHlkVX2i7tBz
 7az1G60VJiSEiL/A1eeaR7nX/XnmONoxqiUkyz1vYodnfQapcj/ZpMY2Zlml12vwPY79
 N+pbg9lBXrJXhZFQzKCg8WD9HJmB1pJZ5kPqqywJeVk9dW4WL+tLt1jwUL0IBmLz97FG
 285Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783689820; x=1784294620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A+55NFv/oNTAVwlYXY4Qavuiv1ZmlNGS6X9JQC9FXiU=;
 b=QZOGXUMS6l3ZiuwCTTHtRlN+nPZHOaki4W2X6Dv6NNCH/bMewK8TyEykLz+dMRt3TS
 cBXEX3elB3yA5kj20NG3/8sLLl46PAWsep0RTuRwH16ccXQt4drQcrHuht5Q3ur9GLzS
 Xu/OJorBacMTtek+UhoW3wa2lJHD/qTMkAbzG/Z/3r5v35WKpTq9g+TZeQ8v+kRL1ZA5
 2vebasPARYoF9ZXWNMVfpG0smPwaTgBHnjhUf/A03jpgOhzttzjVGDiZQzvy5Kpvykpf
 xKrw2Cqhx+chLFZD8F/TvmS9QjDArInJDyIoo0iNCsQlXCnKyt/OeKZlPGVm/1/5rNqQ
 rmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783689820; x=1784294620;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A+55NFv/oNTAVwlYXY4Qavuiv1ZmlNGS6X9JQC9FXiU=;
 b=nwVes5R4GDAkGFl3CLAjMfxBwrlK+MyXdgbEVmkfkNqEO32bEN1o2xWwYzdsj8ZUh3
 iXCqFFEnaqn8D5VIYsIk18Ijg3kyp8v3zrOf9JgyjK4krGMXH7WnwFVaEGd0+ezli0yK
 Z/sVfQse6Zxd+pqxMAs4X5YLdnrsNBafiTDJrsRDVg/gJnsPIq7fVc/2Wwmr4alRUs4J
 gLCv8TC/h6C7PHpzJCTu7O0PXHhlYZYM52y+EhxH00HP0eDd+HlDe9wfeXRR0kQWr5Xy
 i/fcfc8tj+tKGQutBKEoqxTz88gsvaU8EnkSF/s2v6fSMbjScpMJcW8zpoQKYufpHh/Q
 rp2w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rob+UfKMpLkymLlh84kSygFSOFpgyB3tR0ScKYc80MMaaEPgQhq3LBqubpxe8/L70RQWYsGS854sFg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUpLF3JuPPGnD++YmxEs5dluX0vKBbW+8iZLg5I5CWxEn1Hsqz
 SftaU8R02Z427mJ85+jPyTRCTnjHjIniXpUULR3TnwXFVk4+JxBoHonvSMwC2itK4bk3NZOLf3S
 W8GROnYOMmzRyY+LMiQBJSyDhEk52vZ0=
X-Gm-Gg: AfdE7clxlPq0/Bbqr7mk42iv26PGyO+rtUew5jmk1/GkSYmLEgTiD9VFsMQuBkDwfb2
 SAfRmxRc7nV+qa2o8XjKZbRfomEq4+6nVU92ZCgA3yCiSwEGACrGFn0kjp6ur6z5QGqtA0t9ddt
 hq95XS3kd6jkevTDVsweaw8coP0z+jqgAl+jpc/tGgx76aDa+lQ7LAbTGR6IsdCUYzaV7FDZhF7
 1FpDUAlbSFSKP49PaoqLVMncg+5lCm1nmh1X76W2z2mG0pPywmwg5Ob2Mtiw/iJPOYWds+ESVMA
 dyrC7QVwK5BAl5D7d5Albnlxn3jyE2GDDD/G5DZ1yLtfsBGaV4tGQ3RHIjU=
X-Received: by 2002:a17:90b:37ce:b0:37e:2053:3489 with SMTP id
 98e67ed59e1d1-389419cded7mr9478697a91.3.1783689819489; Fri, 10 Jul 2026
 06:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <b12cbd03-9e11-44ff-9ce1-8afb82379b53@amd.com>
 <20260708125636.8103-1-ulissespaixao@usp.br>
In-Reply-To: <20260708125636.8103-1-ulissespaixao@usp.br>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2026 09:23:27 -0400
X-Gm-Features: AVVi8Cc0t-wJtq5yy-2Tj_W8I3d59dgHnZyoqjlSrmN3XT5Z4bZFbexSiJ5wtro
Message-ID: <CADnq5_OkpYczJu0LK9pEmBWFx=3Cq4GXNhSghRLGO-jXQvomJA@mail.gmail.com>
Subject: Re: [PATCH v5] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
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

On Wed, Jul 8, 2026 at 9:19=E2=80=AFAM Ulisses Paixao <ulissespaixao@usp.br=
> wrote:
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

This code recently changed.  Can you respin against the latest
linux-next or amd-staging-drm-next?

Alex

> ---
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 42 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +---------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +---------------
>  4 files changed, 46 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index b8ca87669..50e265abe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -830,6 +830,48 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev=
, int xcc_id)
>         return r;
>  }
>
> +/**
> + * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
> + *
> + * @adev: amdgpu_device pointer
> + * @me_id: micro-engine ID of the faulty ring
> + * @pipe_id: pipe ID of the faulty ring
> + * @queue_id: queue ID of the faulty ring
> + *
> + * This function handles privileged instruction faults by identifying
> + * the faulty ring (gfx or compute) and triggering a scheduler fault
> + */
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +                                       u8 me_id, u8 pipe_id, u8 queue_id=
)
> +{
> +       struct amdgpu_ring *ring;
> +       int i;
> +
> +       /*
> +        * The scheduler only handles kernel queues so this is a no-op
> +        * without them.
> +        */
> +       if (adev->gfx.disable_kq)
> +               return;
> +
> +
> +       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> +               ring =3D &adev->gfx.gfx_ring[i];
> +               if (ring->me =3D=3D me_id && ring->pipe =3D=3D pipe_id &&
> +                   ring->queue =3D=3D queue_id) {
> +                       drm_sched_fault(&ring->sched);
> +                       return;
> +               }
> +       }
> +
> +       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +               ring =3D &adev->gfx.compute_ring[i];
> +               if (ring->me =3D=3D me_id && ring->pipe =3D=3D pipe_id &&
> +                   ring->queue =3D=3D queue_id)
> +                       drm_sched_fault(&ring->sched);
> +       }
> +}
> +
>  static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enab=
le,
>                                    bool no_delay)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index a0cf0a3b4..0b2f6ce85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -611,6 +611,8 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struc=
t amdgpu_device *adev,
>                                                 struct amdgpu_ring *ring)=
;
>  bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
>                                     int pipe, int queue);
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +                                       u8 me_id, u8 pipe_id, u8 queue_id=
);
>  void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
>  void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enab=
le);
>  int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *valu=
e);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 2c6f1e25c..888c9f3c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6688,37 +6688,12 @@ static void gfx_v11_0_handle_priv_fault(struct am=
dgpu_device *adev,
>                                         struct amdgpu_iv_entry *entry)
>  {
>         u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
>
>         me_id =3D (entry->ring_id & 0x0c) >> 2;
>         pipe_id =3D (entry->ring_id & 0x03) >> 0;
>         queue_id =3D (entry->ring_id & 0x70) >> 4;
>
> -       if (!adev->gfx.disable_kq) {
> -               switch (me_id) {
> -               case 0:
> -                       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -                               ring =3D &adev->gfx.gfx_ring[i];
> -                               if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               case 1:
> -               case 2:
> -                       for (i =3D 0; i < adev->gfx.num_compute_rings; i+=
+) {
> -                               ring =3D &adev->gfx.compute_ring[i];
> -                               if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               default:
> -                       BUG();
> -                       break;
> -               }
> -       }
> +       amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
>  }
>
>  static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 6baac533a..3f0d29372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5019,37 +5019,12 @@ static void gfx_v12_0_handle_priv_fault(struct am=
dgpu_device *adev,
>                                         struct amdgpu_iv_entry *entry)
>  {
>         u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
>
>         me_id =3D (entry->ring_id & 0x0c) >> 2;
>         pipe_id =3D (entry->ring_id & 0x03) >> 0;
>         queue_id =3D (entry->ring_id & 0x70) >> 4;
>
> -       if (!adev->gfx.disable_kq) {
> -               switch (me_id) {
> -               case 0:
> -                       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -                               ring =3D &adev->gfx.gfx_ring[i];
> -                               if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               case 1:
> -               case 2:
> -                       for (i =3D 0; i < adev->gfx.num_compute_rings; i+=
+) {
> -                               ring =3D &adev->gfx.compute_ring[i];
> -                               if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               default:
> -                       BUG();
> -                       break;
> -               }
> -       }
> +       amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
>  }
>
>  static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
> --
> 2.34.1
>
