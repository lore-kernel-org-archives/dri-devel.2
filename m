Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8148BCD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7C310E889;
	Mon, 18 May 2026 14:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RaPQdn8w";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C0E710E5DC
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:23:31 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-13246a5110bso119149c88.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779114211; cv=none;
 d=google.com; s=arc-20240605;
 b=Qo5gznYPsIHWkmSEJyU+G3fEsTjylTyisTkv7GOkT6g+T2qWoBltxfRK/0arzMWbe0
 CrQtsnyZAhaCrDoBtnNi60b+9gj2R+tRQjnNfjTSYzSmhp7XJ/mdot22E7ieV8Th7SbN
 iAZ1Pz5XfsBDlUBpnLAc+SB9oOgRapFoii5vq/7UKoijaLyd28dCm8gkSTtd3cOwdKIK
 nEDeJ+2xwuafJUmbCS5dXgM+I9kJwy8PrAgHZ9naXedapzDeKmQGjxvOWCh0wKI8amzd
 pQU022NBIIvwJ2u/n0zqZXM3YJ4sf29swWTTegeB9FbozElPsAqjzIt56gWy6vIuCQS3
 2K3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6W+8Ad/Vtfal8Be2r/swqERUNXyi4XnkwGbJNcr36fc=;
 fh=3JuRAcUZSxiOD1lch9JCfwUAlQaFWLJY04w8DX0mb8E=;
 b=lpMiPpRKmYm5ofNj+S7ujIYXJSLzgtqgh/UFlnhJx6aEtFTOzGlkXeuWjfYvnnXSce
 2ffBmm68+3xl6NPoD+6inXZQaIsIq7Lt3Yin9tkEGEZoMFR1x72g0ChYwiAiq62OdwAV
 ZzYWfA3XVe7zdLWzMqQT2KhpYr4HPdjZ4aBxr2KTTznNEbfpPE5hn7AZXhWIKvlrR1Vk
 67N+tgQCIk5HKWU3VFAS65kIlh1+tKsp3HXZQKWV59iu6NAoLIwI26/xmuGKkSEC1mSw
 wiaaC+eP33sWKS4KMg2WhHqirtgIJs8eUPTGMnbL9zwcKeTorhlqP0JK5x0hNfkT5QHR
 UoRQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779114211; x=1779719011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6W+8Ad/Vtfal8Be2r/swqERUNXyi4XnkwGbJNcr36fc=;
 b=RaPQdn8w0x4qz0OnbApQ5oZflFqQ1iTsW/XqrBjx1ubMdmoThpuQyBfhLg4keEP4rE
 FY0FKC1tL5zKGrwP/lMoKBBGCWJE0r8veXVMsMJ4MvuhNFNVJlr2eVitLWW5SjzzvkjF
 6oSSiWVAsQbnB+khclh25x4gHMipMO7SVjSg6WnUYnxUvFGyeaEQYeowPoKlfAJMrL4/
 M7Bbhn1bgD6IhmnRfrag/dwUET7TZ6+ACzqaHzA2l0NUMlqRxI+ClcrmoEsHcMjgyQTc
 K66LS5Q002C2ot2MdylHKfqtx5DuW6iZ9ZNn/dZPW+UGbYLUd92wZS62+LbMndVUbA6k
 WF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114211; x=1779719011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6W+8Ad/Vtfal8Be2r/swqERUNXyi4XnkwGbJNcr36fc=;
 b=CN878LK3yFEiWiCjGRUkXAxfuTwZMFLmgOt0ZCDiLfBi6rua/oxbnRyy14n3injhVs
 vnT5yDphz4Qjz/RnfagDipy+uXdqmXVOfvbP9H40s2o5hvZ6Xk/G9uHWNK/MM7DWysPi
 2GmeElk9OoOK/X7lD6nswZ8B2G6fjs0lp/Owc7kKXoXutmq9D84qegt4dCdOW9Uf+d+a
 R8+GE1YWymBrw2+jwzXNPP7JTmV3iVvBMt48caKCRG2w8NgWOb0iUrb3+A1jz/MKjD1L
 fYNfqaa+zcX5y1t7aO38hJEvji8vIeVolQsCt/2Xu/tk9quRyhYeeflo926R9uVaglCl
 JbOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fSx0px40pI3OQyU81NtPS9lBpCnlANuJ/dPTlBxLV4yRGhM+okEqYyeNnzvcrxvzaQXK+hG9ZZTQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGCqg/AxWR14dczvVcvhM7eXqtX+4Y7X+VC2VW+5Auw9W+hWQ7
 as+P1q+jkLSwsnTVLSY0D34zEfK+Lwl7RbtP5mAlhjvbMCa2N4Dmv611YfF64LIAX8G0EEdkZ+E
 NA8xX2A4Wa6OC0obJGRGeTgoAuch0o2w=
X-Gm-Gg: Acq92OH18mLXOBB6gdkrdDh/8wvZ0fa1tW6qJ5wSiZR8mDwA6LoXF35BWRm9j+qUaxH
 4jcopXZKdGIryWXKS7GHWW+v3fxImuoNG7yYWIozOS+rSEFhu9xk19a3INzNrFJGH/wfcs8QXGe
 8CvZyE/Sne9fGu0ltb9u2FpSYe02OgWmwplAxxcHkdwdbcyXFH7LRDvy9RDX3O4X75W1uu+y/Ke
 tz1gP/y1PkM/m2AlgYUa3wL+n+/Q8jkPv5y4U+F2S6iskUAUz299N2zp9E43npToxfVbDYNYWYM
 k/ZZs7VeNFZAzi+SsqSY3mSTvgRjZhlB/no8NKM4f4gXzp/4Q1dNzvePo7eemalyz3p7yg==
X-Received: by 2002:a05:7022:128c:b0:12c:900b:9dee with SMTP id
 a92af1059eb24-1350440ae3fmr2758383c88.1.1779114210581; Mon, 18 May 2026
 07:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260517131742.3435209-1-michael.bommarito@gmail.com>
In-Reply-To: <20260517131742.3435209-1-michael.bommarito@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 May 2026 10:23:18 -0400
X-Gm-Features: AVHnY4IjvymyISKz9AQ3FMuidJRAKWnZZII8h8xQPSu6xFoDXnu8vnz8wJD7U3Y
Message-ID: <CADnq5_PP00biS-F6fG2Zp2Md7_ECS7A6zAdWz8YzcnuWir1Tdg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix lock leak on ENOMEM in
 AMDGPU_GEM_OP_GET_MAPPING_INFO
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 David Francis <David.Francis@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Ziyi Guo <n7l8m4@u.northwestern.edu>
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

Alex

On Sun, May 17, 2026 at 9:24=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> The AMDGPU_GEM_OP_GET_MAPPING_INFO branch of amdgpu_gem_op_ioctl()
> holds three cleanup-tracked resources before calling kvcalloc():
> the drm_gem_object reference from drm_gem_object_lookup(), the
> drm_exec lock on the looked-up GEM via drm_exec_lock_obj(), and
> the drm_exec lock on the per-process VM root page directory via
> amdgpu_vm_lock_pd().  All three are released by the out_exec
> label that every other error path in this function jumps to.
> The kvcalloc() failure path returns -ENOMEM directly, skipping
> out_exec and leaking all three.
>
> The leaked per-process VM root PD dma_resv lock is the
> load-bearing leak: any subsequent operation on the same VM
> (further GEM ops, command-submission, eviction, TTM shrinker
> callbacks) blocks on the held lock.  DRM_IOCTL_AMDGPU_GEM_OP is
> DRM_AUTH | DRM_RENDER_ALLOW, so this is an unprivileged-local
> denial of service against the caller's GPU context, reachable
> by any process with /dev/dri/renderD* access.
>
> Route the failure through out_exec so drm_exec_fini() and
> drm_gem_object_put() run.
>
> Reproduced on stock 7.0.0-10, Ryzen 7 5700U / Radeon Vega
> (Lucienne): the failing ioctl returns -ENOMEM and a second
> GET_MAPPING_INFO on the same fd then blocks in
> drm_exec_lock_obj() on the leaked dma_resv.  SIGKILL on the
> caller does not reap the task; the fd-release path during
> process exit goes through amdgpu_gem_object_close() ->
> drm_exec_prepare_obj() on the same lock, leaving the task in D
> state until the box is rebooted.  The patched kernel was not
> rebuilt and re-tested on this hardware; the fix is mechanical.
> Tested on a single Lucienne / Vega box only.
>
> Ziyi Guo posted an independent INT_MAX-bound check for
> args->num_entries in the same branch [1]; the two patches are
> complementary and can land in either order.
>
> Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioct=
l")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260208000255.4073363-1-n7l8m4@u.north=
western.edu/ # [1]
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 9ef80bca4102..8224fb499fdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1091,8 +1091,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, vo=
id *data,
>                  * be retried.
>                  */
>                 vm_entries =3D kvcalloc(args->num_entries, sizeof(*vm_ent=
ries), GFP_KERNEL);
> -               if (!vm_entries)
> -                       return -ENOMEM;
> +               if (!vm_entries) {
> +                       r =3D -ENOMEM;
> +                       goto out_exec;
> +               }
>
>                 amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
>                         if (num_mappings < args->num_entries) {
> --
> 2.53.0
>
