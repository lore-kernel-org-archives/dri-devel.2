Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC55CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 21:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88BC811255B;
	Fri, 29 May 2026 21:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="C442guxE";
	dkim-atps=neutral
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com
 [209.85.222.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1226611255B
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 21:52:24 +0000 (UTC)
Received: by mail-qk1-f226.google.com with SMTP id
 af79cd13be357-914bb8e95c2so447269585a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091543; x=1780696343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jY9wZKDcLMvFwHgrOC9f0YgLLuMqtpPcjebmizaYhOg=;
 b=ca7srzxtSYsq9stiA05rEGrMaOVaBbUHrrR1s8g7QhUDFV8dvTPcN5yepQuzQa+NB6
 YcPDTIQeAKxtgMyK6wV51nqbpfz6vlknLPSG229YQWSd5CyDKprliLUatpfTyXt9Qo7n
 ouEqbQswCHulXNZ2goGToehEJ5Qv2f1HHCR73aftsAARU4XosH7+s85VGylkVjHpHgy0
 P1nXoah/K/6QKMHonlFxmv7lx2LOMgzXj42rNrwZa1yjIbpbhQuIXSNJAxD7dLi8wFGf
 j4im7XGpBez8dx5UGvs7KI3c7c2hKsOMGR6jxN7x+nrMPQk6pVNfHqxa9lIxMDR8FJR4
 2syA==
X-Gm-Message-State: AOJu0YwYYuYeUCEXTPuGbWQsD/1NKCe6q4EJ74pLc8ZO/5IRzPufUSXj
 GumqXbE5B/fsU2H9lMj96HhK4ai6wYjplXYrmOA79LcB5m2HHtwa7uOJdFZ1cA+2C2fyZIi6O5c
 1A45Iz/jLl+rWcPOkNFEJ/aq5LluXBgEFTuCZTTo9u40pMNSAnkA43XPPWxwKn/j2rIkIP/Rpfr
 kU5tZ+wLrRY9c060YlE9XDMwd+3lVSfzhSAPaBtizAYt0jCxaoZWX6jFRu8ee7W9oNB3tynwM3i
 EvKDYrG7bLoF8hVuFGa
X-Gm-Gg: Acq92OFbII9mIu/t7Rizz+QhYGkdR9Z1GhNHa4nkz1Ad9mpX8QBHmZ4J1S3zrFZDU1/
 K7cH15E6CzHNrPFzWDzHuYsipMImtFyz/w/j9w46mmiPsrHWWTVYLcpC6T58SKsIzK62sFDguGR
 4rFso1HVoAxDezmR9wO5s1HrI7dVKYpj/x5ZkZrx0d8Q5ltepmohI6ZhM9F9TE9fILbZzAAWTvX
 +CEEGJuNoktgqHODUUy0p2NK0QjExXs3y5Wvwsqgof2J3i+OIn/ZJ4y5SrOPiWW1U0xPaqJVvrM
 KGPXNIZedUsJsxB8XiziwVeLIrlt7/1P+Cf3BUJagSyVNAl2YjYb3zMwpGpfEz8FciiNcDoahh8
 uzGcki7Sl39bTVZA6fH6gVlqK6V3EljY85FiwmphyFSgY0XXOsi9uR4sdX70q5s4tVSN9jhByh/
 GgOm7Wj3yBoUVRw+KNrNOSMSFTpsVR0y1VkbFiAqek74RBRdVT/c+fobLQ5AHqjWob
X-Received: by 2002:a05:620a:1792:b0:902:5778:d312 with SMTP id
 af79cd13be357-9153d931f44mr252817385a.12.1780091542574; 
 Fri, 29 May 2026 14:52:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-91532543521sm19540985a.4.2026.05.29.14.52.22
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 May 2026 14:52:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5a858039ddaso11774270e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780091541; x=1780696341;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jY9wZKDcLMvFwHgrOC9f0YgLLuMqtpPcjebmizaYhOg=;
 b=C442guxEoS3knC9nEFYm03A8sW14XvW6g28Kww+6B+LxbccgwAJEfIwq16WlIBe4j4
 fZOm0ma+HskNtvAlNyqP8i15WFLqzL00klDdlhmb+zJ3VMMw3ICzQmDcfTmdiJ0T88fC
 Ho1QAii+oXdLoAuyGIhxuKj2ZZgdtjXbYGCt8=
X-Received: by 2002:a05:6512:b8d:b0:5aa:b6a:7a8e with SMTP id
 2adb3069b0e04-5aa60a532b6mr427125e87.45.1780091540672; 
 Fri, 29 May 2026 14:52:20 -0700 (PDT)
X-Received: by 2002:a05:6512:b8d:b0:5aa:b6a:7a8e with SMTP id
 2adb3069b0e04-5aa60a532b6mr427115e87.45.1780091540109; Fri, 29 May 2026
 14:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260521224137.628035-1-maaz.mombasawala@broadcom.com>
In-Reply-To: <20260521224137.628035-1-maaz.mombasawala@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 29 May 2026 17:52:06 -0400
X-Gm-Features: AVHnY4KdjNykAgcTdxBCV0uJ7v6YrTkONnCgVxyL5kIXv0s7rorWcj4k5L3-AuA
Message-ID: <CABQX2QNp1kYeO5Y9uaE7JwmpARnTAQo7JgLy8D6Csak=WH6Jig@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Remove duplicates in vmwgfx_bo.h
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
 ian.forbes@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000fa016f0652fbdbbd"
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

--000000000000fa016f0652fbdbbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 6:39=E2=80=AFPM Maaz Mombasawala
<maaz.mombasawala@broadcom.com> wrote:
>
> The vmw_user_bo_ref and vmw_user_bo_unref functions are identical to
> vmw_bo_reference and vmw_bo_unreference respectively, remove them.
>
> Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.c       |  4 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.h       | 15 ---------------
>  drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c  |  4 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h      |  1 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c  |  4 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c      |  4 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c  |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_prime.c    |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 12 ++++++------
>  drivers/gpu/drm/vmwgfx/vmwgfx_shader.c   |  4 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c  |  6 +++---
>  11 files changed, 21 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index d1ce1a58e134..a9a204234ed6 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -539,7 +539,7 @@ static int vmw_user_bo_synccpu_release(struct drm_fil=
e *filp,
>                 if (!(flags & drm_vmw_synccpu_allow_cs)) {
>                         atomic_dec(&vmw_bo->cpu_writers);
>                 }
> -               vmw_user_bo_unref(&vmw_bo);
> +               vmw_bo_unreference(&vmw_bo);
>         }
>
>         return ret;
> @@ -581,7 +581,7 @@ int vmw_user_bo_synccpu_ioctl(struct drm_device *dev,=
 void *data,
>                         return ret;
>
>                 ret =3D vmw_user_bo_synccpu_grab(vbo, arg->flags);
> -               vmw_user_bo_unref(&vbo);
> +               vmw_bo_unreference(&vbo);
>                 if (unlikely(ret !=3D 0)) {
>                         if (ret =3D=3D -ERESTARTSYS || ret =3D=3D -EBUSY)
>                                 return -EBUSY;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.h
> index cf84a163bfcb..f3c2cfb42588 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
> @@ -213,21 +213,6 @@ static inline struct vmw_bo *vmw_bo_reference(struct=
 vmw_bo *buf)
>         return buf;
>  }
>
> -static inline struct vmw_bo *vmw_user_bo_ref(struct vmw_bo *vbo)
> -{
> -       drm_gem_object_get(&vbo->tbo.base);
> -       return vbo;
> -}
> -
> -static inline void vmw_user_bo_unref(struct vmw_bo **buf)
> -{
> -       struct vmw_bo *tmp_buf =3D *buf;
> -
> -       *buf =3D NULL;
> -       if (tmp_buf)
> -               drm_gem_object_put(&tmp_buf->tbo.base);
> -}
> -
>  static inline struct vmw_bo *to_vmw_bo(struct drm_gem_object *gobj)
>  {
>         return container_of((gobj), struct vmw_bo, tbo.base);
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_cotable.c
> index 091f1039a052..9c882e746e3c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
> @@ -502,7 +502,7 @@ static int vmw_cotable_resize(struct vmw_resource *re=
s, size_t new_size)
>
>         vmw_resource_mob_attach(res);
>         /* Let go of the old mob. */
> -       vmw_user_bo_unref(&old_buf);
> +       vmw_bo_unreference(&old_buf);
>         res->id =3D vcotbl->type;
>
>         ret =3D dma_resv_reserve_fences(bo->base.resv, 1);
> @@ -521,7 +521,7 @@ static int vmw_cotable_resize(struct vmw_resource *re=
s, size_t new_size)
>  out_wait:
>         ttm_bo_unpin(bo);
>         ttm_bo_unreserve(bo);
> -       vmw_user_bo_unref(&buf);
> +       vmw_bo_unreference(&buf);
>
>  out_done:
>         MKS_STAT_TIME_POP(MKSSTAT_KERN_COTABLE_RESIZE);
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.h
> index cda55ee009d2..cd46d3995ade 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -96,7 +96,6 @@ struct vmwgfx_hash_item {
>
>  struct vmw_res_func;
>
> -struct vmw_bo;
>  struct vmw_bo;
>  struct vmw_resource_dirty;
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_execbuf.c
> index e1f18020170a..f3fd45f28140 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -1148,7 +1148,7 @@ static int vmw_translate_mob_ptr(struct vmw_private=
 *dev_priv,
>         vmw_bo_placement_set(vmw_bo, VMW_BO_DOMAIN_MOB, VMW_BO_DOMAIN_MOB=
);
>         ret =3D vmw_validation_add_bo(sw_context->ctx, vmw_bo);
>         tmp_bo =3D vmw_bo;
> -       vmw_user_bo_unref(&tmp_bo);
> +       vmw_bo_unreference(&tmp_bo);
>         if (unlikely(ret !=3D 0))
>                 return ret;
>
> @@ -1205,7 +1205,7 @@ static int vmw_translate_guest_ptr(struct vmw_priva=
te *dev_priv,
>                              VMW_BO_DOMAIN_GMR | VMW_BO_DOMAIN_VRAM);
>         ret =3D vmw_validation_add_bo(sw_context->ctx, vmw_bo);
>         tmp_bo =3D vmw_bo;
> -       vmw_user_bo_unref(&tmp_bo);
> +       vmw_bo_unreference(&tmp_bo);
>         if (unlikely(ret !=3D 0))
>                 return ret;
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index 4db29b645a38..6bd83e49885b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -1968,7 +1968,7 @@ int vmw_connector_get_modes(struct drm_connector *c=
onnector)
>  struct vmw_user_object *vmw_user_object_ref(struct vmw_user_object *uo)
>  {
>         if (uo->buffer)
> -               vmw_user_bo_ref(uo->buffer);
> +               vmw_bo_reference(uo->buffer);
>         else if (uo->surface)
>                 vmw_surface_reference(uo->surface);
>         return uo;
> @@ -1977,7 +1977,7 @@ struct vmw_user_object *vmw_user_object_ref(struct =
vmw_user_object *uo)
>  void vmw_user_object_unref(struct vmw_user_object *uo)
>  {
>         if (uo->buffer)
> -               vmw_user_bo_unref(&uo->buffer);
> +               vmw_bo_unreference(&uo->buffer);
>         else if (uo->surface)
>                 vmw_surface_unreference(&uo->surface);
>  }
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_overlay.c
> index 679adf7c7183..d4a1cd50c325 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
> @@ -451,7 +451,7 @@ int vmw_overlay_ioctl(struct drm_device *dev, void *d=
ata,
>
>         ret =3D vmw_overlay_update_stream(dev_priv, buf, arg, true);
>
> -       vmw_user_bo_unref(&buf);
> +       vmw_bo_unreference(&buf);
>
>  out_unlock:
>         mutex_unlock(&overlay->mutex);
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_prime.c
> index 598b90ac7590..6abeb1ee1f8f 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
> @@ -117,7 +117,7 @@ int vmw_prime_handle_to_fd(struct drm_device *dev,
>                                                                  handle, =
flags,
>                                                                  prime_fd=
);
>                 }
> -               vmw_user_bo_unref(&vbo);
> +               vmw_bo_unreference(&vbo);
>         }
>
>         return ret;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/v=
mwgfx/vmwgfx_resource.c
> index 388011696941..1391bed79f7b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
> @@ -143,7 +143,7 @@ static void vmw_resource_release(struct kref *kref)
>                 if (res->coherent)
>                         vmw_bo_dirty_release(res->guest_memory_bo);
>                 ttm_bo_unreserve(bo);
> -               vmw_user_bo_unref(&res->guest_memory_bo);
> +               vmw_bo_unreference(&res->guest_memory_bo);
>         }
>
>         if (likely(res->hw_destroy !=3D NULL)) {
> @@ -315,7 +315,7 @@ int vmw_user_object_lookup(struct vmw_private *dev_pr=
iv,
>                                                             uo->buffer,
>                                                             handle);
>                 if (uo->surface)
> -                       vmw_user_bo_unref(&uo->buffer);
> +                       vmw_bo_unreference(&uo->buffer);
>         }
>
>         return ret;
> @@ -466,11 +466,11 @@ void vmw_resource_unreserve(struct vmw_resource *re=
s,
>                         vmw_resource_mob_detach(res);
>                         if (res->coherent)
>                                 vmw_bo_dirty_release(res->guest_memory_bo=
);
> -                       vmw_user_bo_unref(&res->guest_memory_bo);
> +                       vmw_bo_unreference(&res->guest_memory_bo);
>                 }
>
>                 if (new_guest_memory_bo) {
> -                       res->guest_memory_bo =3D vmw_user_bo_ref(new_gues=
t_memory_bo);
> +                       res->guest_memory_bo =3D vmw_bo_reference(new_gue=
st_memory_bo);
>
>                         /*
>                          * The validation code should already have added =
a
> @@ -560,7 +560,7 @@ vmw_resource_check_buffer(struct ww_acquire_ctx *tick=
et,
>         drm_gem_object_put(&val_buf->bo->base);
>         val_buf->bo =3D NULL;
>         if (guest_memory_dirty)
> -               vmw_user_bo_unref(&res->guest_memory_bo);
> +               vmw_bo_unreference(&res->guest_memory_bo);
>
>         return ret;
>  }
> @@ -736,7 +736,7 @@ int vmw_resource_validate(struct vmw_resource *res, b=
ool intr,
>                 goto out_no_validate;
>         else if (!res->func->needs_guest_memory && res->guest_memory_bo) =
{
>                 WARN_ON_ONCE(vmw_resource_mob_attached(res));
> -               vmw_user_bo_unref(&res->guest_memory_bo);
> +               vmw_bo_unreference(&res->guest_memory_bo);
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmw=
gfx/vmwgfx_shader.c
> index eca4e3e97eb4..ede4de9dc8b0 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
> @@ -180,7 +180,7 @@ static int vmw_gb_shader_init(struct vmw_private *dev=
_priv,
>
>         res->guest_memory_size =3D size;
>         if (byte_code) {
> -               res->guest_memory_bo =3D vmw_user_bo_ref(byte_code);
> +               res->guest_memory_bo =3D vmw_bo_reference(byte_code);
>                 res->guest_memory_offset =3D offset;
>         }
>         shader->size =3D size;
> @@ -809,7 +809,7 @@ static int vmw_shader_define(struct drm_device *dev, =
struct drm_file *file_priv,
>                                     shader_type, num_input_sig,
>                                     num_output_sig, tfile, shader_handle)=
;
>  out_bad_arg:
> -       vmw_user_bo_unref(&buffer);
> +       vmw_bo_unreference(&buffer);
>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index 34e55ad07ca9..5a9c953eb73c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -972,7 +972,7 @@ static int vmw_buffer_prime_to_surface_base(struct vm=
w_private *dev_priv,
>
>         *base_p =3D base;
>  out:
> -       vmw_user_bo_unref(&bo);
> +       vmw_bo_unreference(&bo);
>
>         return ret;
>  }
> @@ -1593,12 +1593,12 @@ vmw_gb_surface_define_internal(struct drm_device =
*dev,
>                 if (ret =3D=3D 0) {
>                         if (res->guest_memory_bo->is_dumb) {
>                                 VMW_DEBUG_USER("Can't backup surface with=
 a dumb buffer.\n");
> -                               vmw_user_bo_unref(&res->guest_memory_bo);
> +                               vmw_bo_unreference(&res->guest_memory_bo)=
;
>                                 ret =3D -EINVAL;
>                                 goto out_unlock;
>                         } else if (res->guest_memory_bo->tbo.base.size < =
res->guest_memory_size) {
>                                 VMW_DEBUG_USER("Surface backup buffer too=
 small.\n");
> -                               vmw_user_bo_unref(&res->guest_memory_bo);
> +                               vmw_bo_unreference(&res->guest_memory_bo)=
;
>                                 ret =3D -EINVAL;
>                                 goto out_unlock;
>                         } else {
> --
> 2.54.0
>

Looks good. Thanks!

Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

--000000000000fa016f0652fbdbbd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEop
AuolmQLxqdTwUBtQeLKKzPO+iDAquaj1bqlkqS5vMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDUyOTIxNTIyMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAyERnMKpE4uYT9T5gwW14vUXYLHMdBS7+Qx/kcQ
h85dQyLJzFmQtSeo0iYfGDL29xTUUjwiAiN0o4JMk9I4srGMxaQkulT+Sxua0mjW2qBWmUEAIRAS
Jel/fewt1FQNdPBnPZ1p45VZ7N9BSjxwEOL3EEHVFMbt2kGToNAEJ4WUGjP280IuGo25zd2oFQna
0I+nbRNb/myFgbDKaGuuQ3YbWrK2IbrWyd1FJdlJzQ+ZN8w4K7ig6yfGAer5+IPFmbdmW32snskv
YH9xQ2X78Rfy0BwnOWkBiRUibuLT7H8IgCF01wAD13Weu1vjf2D30AAZhaSfsxTI7ZFnMoaBAc4=
--000000000000fa016f0652fbdbbd--
