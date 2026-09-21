Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D51EC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE3110EA6E;
	Mon, 21 Sep 2026 21:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DY3lmPcl";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD62110EA17
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 21:54:09 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39d67a9ae5bso289959a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 14:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790027649; cv=none;
 d=google.com; s=arc-20260327;
 b=QOhkTgsjhOSIKnrcHXYiZQk95b8i9uaGHEj9PL/NwhSWcffpMk3MCYmkrnuMIqkELR
 MK7O2NWGTp+e1n7ndbKuJ0cCP+e0m9cX5xq/JNmq/rgzRDPMzfkKcsyGOu8gyDc9fsSR
 zfqYqSdQOGSabwqli4236FOaX/hSczt9Tq4L5336iYHva+IbtNIGK+NUAbH2K5iohBU3
 B+WmGEaN/XbphgQLkrTxbW1R3nYPGd/nOR47cq0ngtQsXWwEmsWskVPyvx3+6nbT8qcv
 zisrxpcwm8+BI0CF/JZuCvnfahDAy51TDl3LIUJcRBuNN1LMwmaY/t6G1kWSxfMnXbsF
 oyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t4ksEvNvs9haAxIzxiGMgrkw1b5PC3+AAb7TOca7LJQ=;
 fh=Se1AvVURmonO2q5/A8+cZMZfWSl/+YK0CHis2WU4Y9E=;
 b=AWpkIPJndtF/MUG8VCw7zjuJMPnGBs1q6T9WwqSyE1Vg7vnoAymJbKDWuaKNagxx9u
 AL5Lvx41X9j/k3Ges/onOkSwVya6FzWLgAt5M3ScaCKyuIYsNQTjMaU4/q5XpLic5eq3
 SZdVgYH8nntKoGocxI1Yn8qa6yA7C1JrCCD564vqlqffSsPyoApLpu/hP0SGaACkUmI+
 3V0b4H2MoBM/vZuXvwbv7lV1TYn0BJmF7RmqNWvufRdYREIgjs2mKQM3TVGkIvuLW9Z0
 +3uulbdta0cSiD+7IQPxJCDyHkqZL6TYJhzHp/1BqVZzLKaSBJPRjo0cVk3xDmu2m3Vu
 8ESw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027649; x=1790632449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t4ksEvNvs9haAxIzxiGMgrkw1b5PC3+AAb7TOca7LJQ=;
 b=DY3lmPclMccNefNluAbkjEjyI4MT1OJfmHkmuo/QK8nOosvjXaxkBXznqbIr8tCptF
 IRhPt1Nbbrs4Ss1RCuXUen8cKYEiR8nNA2gGKIVOxbF49cayZpmJZbguBHDooKHUtc4O
 kiY0tiK5/xZ486MEywjWn6WlycV4bp6P1lBsBvl8urNBzn01r9P+FSq5VIVN9iVW//Rd
 x2jK0i219/EKxEEKJp8XtM3S1uUUQ0Owkb/Pkd8L+9D+bb7k6ztLjFDQR3+o+S37CyOq
 uVHP5lCu6eR7Sf3dCymr6eI0oZKbOPkX7E3ri58XDPA8V4sTXnA4keHZfBt/mutsDQsZ
 +ywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027649; x=1790632449;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t4ksEvNvs9haAxIzxiGMgrkw1b5PC3+AAb7TOca7LJQ=;
 b=WEZvNIQ1tHc4CTvBAhnIHH8RWmdMK2LJyYcztsN8odID1d293cft0cOhb4R48shnR/
 YRT2SgrZTDqXbJ3e8A4YveXSNMTaVKV2hWIphWj+aOXKSGajsobkWgEmKFIWkyI1aAwW
 Vqcv9xUtLysueOdfht57Op/z6mmsiQDpS9U5oKDQ6uYkr4xquScJJXUafnLpXRuIsn/9
 ZRlLCYauxp/znwPnDwXErB4codSOcqajCzWpdP0dFd2dt71y4zOyancLSJXMt/PuY9Q3
 hMEM8r19lNkqYXC9i1ral7nVF/665dzcJMRE7OQxtwmZAs7fwqYyAmFv/3oUrYWZb4IP
 yNWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGq0Dt9p57BUcfc8mbWEB/s0IrdxKo3PLPP6B9Au7L+WbRg5OLDZwa6cO6HUxnLyrxtpelttOff2I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mV4hTQZDDnbl5EeBiy4cEC8RkdQSQx0aEwgnA2uHJT/GXFp6Pb
 Xry8R5O0eYPh1M04DXgVShHGUwX/zlN508LQHL3SytP3V3i7Z7D631sz53BtARvmJTYxKooUbOS
 B7phRPWWJ6MdzgHiaJzh6qF3Gz6PpRLg=
X-Gm-Gg: AYBFou1mv+ew5+4zPDCDP4+P9ETHi94EYMtPkzui1AY+pCgcu8siTMswM+bF4sGuyp6
 R+1yl1LOVkeq+RnhkyZ+M78nrI92b0KdsRRBFR783+v4WQxorrmULP2DFQarHA6SgX8PZnKBkJ4
 4gYe3nuu8P9aUnrcgZWquMji+hrFoTiUV3taO4emS3Fm31/SDGisWqll/SDam62V/SkxIwXCzor
 Q+nFRg9FzGMpQX4oScALXvxMrGCiB6Q/we0yVI1ceNiWWkmSv75sqDiUsGI5KuFoqEI4cD8Byri
 tJcuy35INSfua2RjuKD4cW6su57y6SExvxU1/+KYjgTT3eVd+e8uuU429Qdx7CV9ZU9538M38rK
 AHfMhzL9AKRVTXUCadkglQck5XavkA+mdpqWbewB0MQ==
X-Received: by 2002:a17:90b:50cf:b0:39e:2f57:67c0 with SMTP id
 98e67ed59e1d1-39e591e3bd8mr22724496a91.0.1790027649130; Mon, 21 Sep 2026
 14:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260919191432.99342-1-lalitshankarch@gmail.com>
 <20260919200834.114637-1-lalitshankarch@gmail.com>
In-Reply-To: <20260919200834.114637-1-lalitshankarch@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 17:53:57 -0400
X-Gm-Features: AcwNN1V0hEAQbMFmZSiIP-8ykq1wQqclfPaltx0VDGOmUH-U6C4D-99x7HRg-2k
Message-ID: <CADnq5_M+OA60B8sEKH_PQfhwcCa5jT3H8zHFmb4hvAJugQi84g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: replace kcalloc() with kzalloc_objs()
To: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
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

On Mon, Sep 21, 2026 at 3:31=E2=80=AFAM Lalit Shankar Chowdhury
<lalitshankarch@gmail.com> wrote:
>
> Use kzalloc_objs() instead of kcalloc() to simplify object allocations.
> Convert only the instances with sizeof() passed.
>
> No functional change.
>
> Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c     | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      | 2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      | 2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      | 2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      | 2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      | 2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c       | 2 +-
>  19 files changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 132d054900b5..3ffb0f5f7574 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -420,7 +420,7 @@ static ssize_t amdgpu_debugfs_gprwave_read(struct fil=
e *f, char __user *buf, siz
>                 return r;
>         }
>
> -       data =3D kcalloc(1024, sizeof(*data), GFP_KERNEL);
> +       data =3D kzalloc_objs(*data, 1024);
>         if (!data) {
>                 pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>                 amdgpu_virt_disable_access_debugfs(adev);
> @@ -1267,7 +1267,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file =
*f, char __user *buf,
>         thread =3D (*pos & GENMASK_ULL(59, 52)) >> 52;
>         bank =3D (*pos & GENMASK_ULL(61, 60)) >> 60;
>
> -       data =3D kcalloc(1024, sizeof(*data), GFP_KERNEL);
> +       data =3D kzalloc_objs(*data, 1024);
>         if (!data)
>                 return -ENOMEM;
>
> @@ -2035,7 +2035,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u6=
4 val)
>                 return -EBUSY;
>
>         length =3D ring->fence_drv.num_fences_mask + 1;
> -       fences =3D kcalloc(length, sizeof(void *), GFP_KERNEL);
> +       fences =3D kzalloc_objs(*fences, length);
>         if (!fences)
>                 return -ENOMEM;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 3043ad041bb4..017638dd5491 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -460,8 +460,8 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring =
*ring)
>
>         ring->fence_drv.num_fences_mask =3D ring->num_hw_submission * 2 -=
 1;
>         spin_lock_init(&ring->fence_drv.lock);
> -       ring->fence_drv.fences =3D kcalloc(ring->num_hw_submission * 2, s=
izeof(void *),
> -                                        GFP_KERNEL);
> +       ring->fence_drv.fences =3D kzalloc_objs(*ring->fence_drv.fences,
> +                                             ring->num_hw_submission * 2=
);
>
>         if (!ring->fence_drv.fences)
>                 return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_jpeg.c
> index 363b99168478..94e39c486128 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -465,8 +465,8 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_=
device *adev)
>  int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
>                                const struct amdgpu_hwip_reg_entry *reg, u=
32 count)
>  {
> -       adev->jpeg.ip_dump =3D kcalloc(adev->jpeg.num_jpeg_inst * count,
> -                                    sizeof(uint32_t), GFP_KERNEL);
> +       adev->jpeg.ip_dump =3D kzalloc_objs(*adev->jpeg.ip_dump,
> +                                         adev->jpeg.num_jpeg_inst * coun=
t);
>         if (!adev->jpeg.ip_dump) {
>                 dev_err(adev->dev,
>                         "Failed to allocate memory for JPEG IP Dump\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 1a86a47406b1..f257df1c39c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -252,8 +252,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                 }
>
>                 adev->gfx.mec.mes_hung_db_array =3D
> -                       kcalloc(amdgpu_mes_get_hung_queue_db_array_size(a=
dev),
> -                               sizeof(u32), GFP_KERNEL);
> +                       kzalloc_objs(*adev->gfx.mec.mes_hung_db_array,
> +                                    amdgpu_mes_get_hung_queue_db_array_s=
ize(adev));
>
>                 if (!adev->gfx.mec.mes_hung_db_array) {
>                         r =3D -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 17db7264269e..34e1242d66ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1571,8 +1571,8 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
>  int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
>                              const struct amdgpu_hwip_reg_entry *reg, u32=
 count)
>  {
> -       adev->vcn.ip_dump =3D kcalloc(adev->vcn.num_vcn_inst * count,
> -                                    sizeof(uint32_t), GFP_KERNEL);
> +       adev->vcn.ip_dump =3D kzalloc_objs(*adev->vcn.ip_dump,
> +                                        adev->vcn.num_vcn_inst * count);
>         if (!adev->vcn.ip_dump)
>                 return -ENOMEM;
>         adev->vcn.reg_list =3D reg;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 00798d80479f..6e8a0cf23d6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4716,7 +4716,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         uint32_t *ptr;
>         uint32_t inst;
>
> -       ptr =3D kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
>                 adev->gfx.ip_dump_core =3D NULL;
> @@ -4729,7 +4729,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
>                 adev->gfx.mec.num_queue_per_pipe;
>
> -       ptr =3D kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count * inst);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for Compute Queues I=
P Dump\n");
>                 adev->gfx.ip_dump_compute_queues =3D NULL;
> @@ -4742,7 +4742,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         inst =3D adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
>                 adev->gfx.me.num_queue_per_pipe;
>
> -       ptr =3D kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count * inst);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for GFX Queues IP Du=
mp\n");
>                 adev->gfx.ip_dump_gfx_queues =3D NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 0ff5a80aa918..92ff34e38e74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1568,7 +1568,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         uint32_t *ptr;
>         uint32_t inst;
>
> -       ptr =3D kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
>                 adev->gfx.ip_dump_core =3D NULL;
> @@ -1581,7 +1581,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
>                 adev->gfx.mec.num_queue_per_pipe;
>
> -       ptr =3D kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count * inst);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for Compute Queues I=
P Dump\n");
>                 adev->gfx.ip_dump_compute_queues =3D NULL;
> @@ -1594,7 +1594,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         inst =3D adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
>                 adev->gfx.me.num_queue_per_pipe;
>
> -       ptr =3D kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count * inst);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for GFX Queues IP Du=
mp\n");
>                 adev->gfx.ip_dump_gfx_queues =3D NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index e2a81a55c63b..59b99dd37c58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1367,7 +1367,7 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         uint32_t *ptr;
>         uint32_t inst;
>
> -       ptr =3D kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
>                 adev->gfx.ip_dump_core =3D NULL;
> @@ -1380,7 +1380,7 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
>                 adev->gfx.mec.num_queue_per_pipe;
>
> -       ptr =3D kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count * inst);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for Compute Queues I=
P Dump\n");
>                 adev->gfx.ip_dump_compute_queues =3D NULL;
> @@ -1393,7 +1393,7 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         inst =3D adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
>                 adev->gfx.me.num_queue_per_pipe;
>
> -       ptr =3D kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count * inst);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for GFX Queues IP Du=
mp\n");
>                 adev->gfx.ip_dump_gfx_queues =3D NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index e49d8a79045c..db6b8d18bfab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1278,7 +1278,7 @@ static void gfx_v12_1_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>
>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
>
> -       ptr =3D kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL=
);
> +       ptr =3D kzalloc_objs(*ptr, reg_count * num_xcc);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
>                 adev->gfx.ip_dump_core =3D NULL;
> @@ -1291,7 +1291,7 @@ static void gfx_v12_1_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
>                 adev->gfx.mec.num_queue_per_pipe;
>
> -       ptr =3D kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP=
_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count * inst * num_xcc);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for Compute Queues I=
P Dump\n");
>                 adev->gfx.ip_dump_compute_queues =3D NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index c3322058720f..2accca6552e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2190,7 +2190,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_de=
vice *adev)
>         uint32_t *ptr;
>         uint32_t inst;
>
> -       ptr =3D kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
>                 adev->gfx.ip_dump_core =3D NULL;
> @@ -2203,7 +2203,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_de=
vice *adev)
>         inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
>                 adev->gfx.mec.num_queue_per_pipe;
>
> -       ptr =3D kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count * inst);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for Compute Queues I=
P Dump\n");
>                 adev->gfx.ip_dump_compute_queues =3D NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 522981fa182d..edf36e5a3b9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -946,7 +946,7 @@ static void gfx_v9_4_3_alloc_ip_dump(struct amdgpu_de=
vice *adev)
>
>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
>
> -       ptr =3D kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL=
);
> +       ptr =3D kzalloc_objs(*ptr, reg_count * num_xcc);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
>                 adev->gfx.ip_dump_core =3D NULL;
> @@ -959,7 +959,7 @@ static void gfx_v9_4_3_alloc_ip_dump(struct amdgpu_de=
vice *adev)
>         inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
>                 adev->gfx.mec.num_queue_per_pipe;
>
> -       ptr =3D kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP=
_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, reg_count * inst * num_xcc);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for Compute Queues I=
P Dump\n");
>                 adev->gfx.ip_dump_compute_queues =3D NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_0.c
> index 20c8ebf0e159..0160e0b05bf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1926,7 +1926,7 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         }
>
>         /* Allocate memory for SDMA IP Dump buffer */
> -       ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint=
32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
>         if (ptr)
>                 adev->sdma.ip_dump =3D ptr;
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 6fe3d3d56c40..144280dc7583 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1531,7 +1531,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         }
>
>         /* Allocate memory for SDMA IP Dump buffer */
> -       ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint=
32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
>         if (ptr)
>                 adev->sdma.ip_dump =3D ptr;
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index 1ca0e7f65442..0a2acd7a5f2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1434,7 +1434,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUE=
UE;
>
>         /* Allocate memory for SDMA IP Dump buffer */
> -       ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint=
32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
>         if (ptr)
>                 adev->sdma.ip_dump =3D ptr;
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index 81f1e9882177..43aab715a061 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1352,7 +1352,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUE=
UE;
>
>         /* Allocate memory for SDMA IP Dump buffer */
> -       ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint=
32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
>         if (ptr)
>                 adev->sdma.ip_dump =3D ptr;
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index cf3d2997fff8..92f5243e4a7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1363,7 +1363,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         }
>
>         /* Allocate memory for SDMA IP Dump buffer */
> -       ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint=
32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
>         if (ptr)
>                 adev->sdma.ip_dump =3D ptr;
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_0.c
> index 69cb89298a3e..2bf783422ec2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1345,7 +1345,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         if (r)
>                 return r;
>         /* Allocate memory for SDMA IP Dump buffer */
> -       ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint=
32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
>         if (ptr)
>                 adev->sdma.ip_dump =3D ptr;
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_1.c
> index 18366e16ef3f..2d97fc9e0d66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -1333,7 +1333,7 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         if (r)
>                 return r;
>         /* Allocate memory for SDMA IP Dump buffer */
> -       ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint=
32_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, adev->sdma.num_instances * reg_count);
>         if (ptr)
>                 adev->sdma.ip_dump =3D ptr;
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index e9d790914761..393de1399328 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -202,7 +202,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>         r =3D jpeg_v1_0_sw_init(ip_block);
>
>         /* Allocate memory for VCN IP Dump buffer */
> -       ptr =3D kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32=
_t), GFP_KERNEL);
> +       ptr =3D kzalloc_objs(*ptr, adev->vcn.num_vcn_inst * reg_count);
>         if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
>                 adev->vcn.ip_dump =3D NULL;
> --
> 2.53.0
>
