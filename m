Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFD606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PZv18s2p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D2C611258D;
	Thu, 29 Oct 2026 22:05:16 +0000 (UTC)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7703611258D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 22:05:10 +0000 (UTC)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3ace1f3897cso32360a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311510; x=1793916310;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=udQPo7L6Eus3UkHZSy/xKpMIrn2VrKa96HkxJUVFZIY=;
 b=PbCw5R+2p0ICq8v4LGqVNO2MyDsuwqN7dL5BLrLAdmyxWa9sqHczeP64EELQEWWBtr
 X3ALOqJfHQklw/EhnG75EXTPVb/P1etaPrHvAjMMMd+6z3iJc8fzDv6HvnEb5WNM6J/Q
 O7nOo2PvW9dlQgME6t++yadnpiFMiyW5GEG3m+ZIX+kUYPukb4iObD4YGmjTLHn/sskE
 oYbfMAzZzt3rHbx5AN6mvu7OjNDBgkS1xug+nXkrluApaq+poK3EFncNJaZ3Zc8epBV4
 WrrCT4tGBfuKxFn5B1kpOV2z8JIaAFMvAmEGt5W+ZN7fWkKQZrth+xf2QK5+AyEhEF5w
 Ppsw==
X-Gm-Message-State: AFq9FYKGKmV0r9eKsfilHvxx5GG3Yed6VvzG1IkgMqKNkE7vnLDSVLpa
 lzhv4ORy2zRrCOudNda4o15bxry+KTjGugfUzlNPuttbp4gaILg84C4NfgSRJCtOYzYIYMD68fI
 qiCbF8ad8MYl0oVib19IOJR6PKF9E/sLmeQvnLUqLB7rhqmTlPWTPkW/44lPkZ1IO0226pMn2ae
 noeVICBvtOa1hlPYT2BBr1mvWLQ/932IJV8Awhmlbnw2VZWfwU7LrCZb545+L1Df865/WHbMGQC
 APd62PXaREdHnecH2aY
X-Gm-Gg: AYBFou0XFRnWtKBRH1SF0E4oZf4HpGKjp4qEXNtFmfuCyCr8ez9pmmxtbRLHoFRkYvX
 9+Rqt5NSZsqRIl1Hg8a7C49vz/pqbvFwh63g11ha2Vx6nkl0YWF28/mk6q37x78bfssF5Y2mg1K
 bPqPT07/RIGpR9IU9mvCkfrRzT9gJhwVrrr3+DdBjWz4NU5YAkkV0UCSt7R2Y93SmB84B9ExDEJ
 Q1RTngomaTIShZQSJ+AzGf7Ajg2/9G43LDISOUlwrqal70Xg8NZSrol77MCKs7AhuYKsNf+o78P
 JepjRydTxhoOgPAXPAlP9al4Q0sDBmte2W6hRT4jEAr4zwElnFdhulPhQZWzCAZ89GOs0KzMxBQ
 4KOoiVqdaTdcXsG41c92lv/VrL6CYbBnAYgE+hHZd/xSXM4ZFzfpBAC6iCEVp39RQqTTur9SR8t
 NxAVEUWp8+oM1VbL+xdAZG9o+V18vnFcLJ
X-Received: by 2002:a17:90a:da86:b0:39e:21a7:5df5 with SMTP id
 98e67ed59e1d1-3ae897f61aamr217052a91.24.1793311509672; 
 Thu, 29 Oct 2026 15:05:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae845f21dasm682270a91.8.2026.10.29.15.05.09
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2026 15:05:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5bcf39533ebso96330e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793311507; x=1793916307;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=udQPo7L6Eus3UkHZSy/xKpMIrn2VrKa96HkxJUVFZIY=;
 b=PZv18s2pQObKn++HaDaxkjrpMnf2YuSPxLcmhpaM8ekGEJzMe1IPs/llzretlsq2Nv
 OAbnZ7GRuNxBxlVymRvr4FtB/9fU1CyXO2jhCg3Sk2zzyEQgGSwcj7+1Il5eCRU7OWvN
 vBQD3ERgTSpM1dn58I502NnoCHeOeSU9/dwK4=
X-Received: by 2002:a05:6512:3c8e:b0:5bf:9fc1:393f with SMTP id
 2adb3069b0e04-5bfd957cee8mr71775e87.52.1793311507456; 
 Thu, 29 Oct 2026 15:05:07 -0700 (PDT)
X-Received: by 2002:a05:6512:3c8e:b0:5bf:9fc1:393f with SMTP id
 2adb3069b0e04-5bfd957cee8mr71767e87.52.1793311506922; Thu, 29 Oct 2026
 15:05:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029165417.249123-1-ian.forbes@broadcom.com>
In-Reply-To: <20261029165417.249123-1-ian.forbes@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 29 Oct 2026 18:04:53 -0400
X-Gm-Features: AclHuK8p6wOpZ26sHQ6FXgcGf9QvZUCIaQz_Pboeu7Vs-qAQ90NAC_YO7-Zk2II
Message-ID: <CABQX2QMPfqdXb1=0ne-=AxqqdEA3DfXau1OnNQY=B1ibiASQGw@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Remove fence event code
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
 maaz.mombasawala@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000065eab6065f01dfa4"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000065eab6065f01dfa4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:54=E2=80=AFPM Ian Forbes <ian.forbes@broadcom.co=
m> wrote:
>
> The last vmwgfx internal use of this code was removed in commit
> 2e10cdc6e85d ("drm/vmwgfx: Remove explicit and broken vblank handling")
>
> The vmw_fence_event ioctl was introduced in commit
> 57c5ee79acba ("vmwgfx: Add fence events") which claimed it would be used
> by the xf86-video-vmware Xorg driver but the git history shows that it wa=
s
> never used in that driver; nor was it used by mesa.
>
> Remove this code as we've had a number of bug reports related to it.
>
> Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 241 +-------------------------
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.h |   6 -
>  2 files changed, 1 insertion(+), 246 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_fence.c
> index 384c6736cf6b..004ed060cf54 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> @@ -23,27 +23,6 @@ struct vmw_user_fence {
>         struct vmw_fence_obj fence;
>  };
>
> -/**
> - * struct vmw_event_fence_action - fence callback that delivers a DRM ev=
ent.
> - *
> - * @base:  For use with dma_fence_add_callback(...)
> - * @event: A pointer to the pending event.
> - * @dev: Pointer to a struct drm_device so we can access the event stuff=
.
> - * @tv_sec: If non-null, the variable pointed to will be assigned
> - * current time tv_sec val when the fence signals.
> - * @tv_usec: Must be set if @tv_sec is set, and the variable pointed to =
will
> - * be assigned the current time tv_usec val when the fence signals.
> - */
> -struct vmw_event_fence_action {
> -       struct dma_fence_cb base;
> -
> -       struct drm_pending_event *event;
> -       struct drm_device *dev;
> -
> -       uint32_t *tv_sec;
> -       uint32_t *tv_usec;
> -};
> -
>  static struct vmw_fence_manager *
>  fman_from_fence(struct vmw_fence_obj *fence)
>  {
> @@ -524,226 +503,8 @@ int vmw_fence_obj_unref_ioctl(struct drm_device *de=
v, void *data,
>                                          arg->handle);
>  }
>
> -/**
> - * vmw_event_fence_action_seq_passed
> - *
> - * @f: The struct dma_fence which provides timestamp for the action even=
t
> - * @cb: The struct dma_fence_cb callback for the action event.
> - *
> - * This function is called when the seqno of the fence has passed
> - * and it is always called from atomic context.
> - * It queues the event on the submitter's event list.
> - */
> -static void vmw_event_fence_action_seq_passed(struct dma_fence *f,
> -                                             struct dma_fence_cb *cb)
> -{
> -       struct vmw_event_fence_action *eaction =3D
> -               container_of(cb, struct vmw_event_fence_action, base);
> -       struct drm_device *dev =3D eaction->dev;
> -       struct drm_pending_event *event =3D eaction->event;
> -
> -       if (unlikely(event =3D=3D NULL))
> -               return;
> -
> -       spin_lock_irq(&dev->event_lock);
> -
> -       if (likely(eaction->tv_sec !=3D NULL)) {
> -               struct timespec64 ts;
> -
> -               ts =3D ktime_to_timespec64(f->timestamp);
> -               /* monotonic time, so no y2038 overflow */
> -               *eaction->tv_sec =3D ts.tv_sec;
> -               *eaction->tv_usec =3D ts.tv_nsec / NSEC_PER_USEC;
> -       }
> -
> -       drm_send_event_locked(dev, eaction->event);
> -       eaction->event =3D NULL;
> -       spin_unlock_irq(&dev->event_lock);
> -       dma_fence_put(f);
> -       kfree(eaction);
> -}
> -
> -/**
> - * vmw_event_fence_action_queue - Post an event for sending when a fence
> - * object seqno has passed.
> - *
> - * @file_priv: The file connection on which the event should be posted.
> - * @fence: The fence object on which to post the event.
> - * @event: Event to be posted. This event should've been alloced
> - * using k[mz]alloc, and should've been completely initialized.
> - * @tv_sec: If non-null, the variable pointed to will be assigned
> - * current time tv_sec val when the fence signals.
> - * @tv_usec: Must be set if @tv_sec is set, and the variable pointed to =
will
> - * be assigned the current time tv_usec val when the fence signals.
> - * @interruptible: Interruptible waits if possible.
> - *
> - * As a side effect, the object pointed to by @event may have been
> - * freed when this function returns. If this function returns with
> - * an error code, the caller needs to free that object.
> - */
> -
> -int vmw_event_fence_action_queue(struct drm_file *file_priv,
> -                                struct vmw_fence_obj *fence,
> -                                struct drm_pending_event *event,
> -                                uint32_t *tv_sec,
> -                                uint32_t *tv_usec,
> -                                bool interruptible)
> -{
> -       struct vmw_event_fence_action *eaction;
> -       struct vmw_fence_manager *fman =3D fman_from_fence(fence);
> -
> -       eaction =3D kzalloc_obj(*eaction);
> -       if (unlikely(!eaction))
> -               return -ENOMEM;
> -
> -       eaction->event =3D event;
> -       eaction->dev =3D &fman->dev_priv->drm;
> -       eaction->tv_sec =3D tv_sec;
> -       eaction->tv_usec =3D tv_usec;
> -
> -       vmw_fence_obj_reference(fence); // Dropped in CB
> -       if (dma_fence_add_callback(&fence->base, &eaction->base,
> -                                  vmw_event_fence_action_seq_passed) < 0=
)
> -               vmw_event_fence_action_seq_passed(&fence->base, &eaction-=
>base);
> -       return 0;
> -}
> -
> -struct vmw_event_fence_pending {
> -       struct drm_pending_event base;
> -       struct drm_vmw_event_fence event;
> -};
> -
> -static int vmw_event_fence_action_create(struct drm_file *file_priv,
> -                                 struct vmw_fence_obj *fence,
> -                                 uint32_t flags,
> -                                 uint64_t user_data,
> -                                 bool interruptible)
> -{
> -       struct vmw_event_fence_pending *event;
> -       struct vmw_fence_manager *fman =3D fman_from_fence(fence);
> -       struct drm_device *dev =3D &fman->dev_priv->drm;
> -       int ret;
> -
> -       event =3D kzalloc_obj(*event);
> -       if (unlikely(!event)) {
> -               DRM_ERROR("Failed to allocate an event.\n");
> -               ret =3D -ENOMEM;
> -               goto out_no_space;
> -       }
> -
> -       event->event.base.type =3D DRM_VMW_EVENT_FENCE_SIGNALED;
> -       event->event.base.length =3D sizeof(event->event);
> -       event->event.user_data =3D user_data;
> -
> -       ret =3D drm_event_reserve_init(dev, file_priv, &event->base, &eve=
nt->event.base);
> -
> -       if (unlikely(ret !=3D 0)) {
> -               DRM_ERROR("Failed to allocate event space for this file.\=
n");
> -               kfree(event);
> -               goto out_no_space;
> -       }
> -
> -       if (flags & DRM_VMW_FE_FLAG_REQ_TIME)
> -               ret =3D vmw_event_fence_action_queue(file_priv, fence,
> -                                                  &event->base,
> -                                                  &event->event.tv_sec,
> -                                                  &event->event.tv_usec,
> -                                                  interruptible);
> -       else
> -               ret =3D vmw_event_fence_action_queue(file_priv, fence,
> -                                                  &event->base,
> -                                                  NULL,
> -                                                  NULL,
> -                                                  interruptible);
> -       if (ret !=3D 0)
> -               goto out_no_queue;
> -
> -       return 0;
> -
> -out_no_queue:
> -       drm_event_cancel_free(dev, &event->base);
> -out_no_space:
> -       return ret;
> -}
> -
>  int vmw_fence_event_ioctl(struct drm_device *dev, void *data,
>                           struct drm_file *file_priv)
>  {
> -       struct vmw_private *dev_priv =3D vmw_priv(dev);
> -       struct drm_vmw_fence_event_arg *arg =3D
> -               (struct drm_vmw_fence_event_arg *) data;
> -       struct vmw_fence_obj *fence =3D NULL;
> -       struct vmw_fpriv *vmw_fp =3D vmw_fpriv(file_priv);
> -       struct ttm_object_file *tfile =3D vmw_fp->tfile;
> -       struct drm_vmw_fence_rep __user *user_fence_rep =3D
> -               (struct drm_vmw_fence_rep __user *)(unsigned long)
> -               arg->fence_rep;
> -       uint32_t handle;
> -       int ret;
> -
> -       /*
> -        * Look up an existing fence object,
> -        * and if user-space wants a new reference,
> -        * add one.
> -        */
> -       if (arg->handle) {
> -               struct ttm_base_object *base =3D
> -                       vmw_fence_obj_lookup(tfile, arg->handle);
> -
> -               if (IS_ERR(base))
> -                       return PTR_ERR(base);
> -
> -               fence =3D &(container_of(base, struct vmw_user_fence,
> -                                      base)->fence);
> -               (void) vmw_fence_obj_reference(fence);
> -
> -               if (user_fence_rep !=3D NULL) {
> -                       ret =3D ttm_ref_object_add(vmw_fp->tfile, base,
> -                                                NULL, false);
> -                       if (unlikely(ret !=3D 0)) {
> -                               DRM_ERROR("Failed to reference a fence "
> -                                         "object.\n");
> -                               goto out_no_ref_obj;
> -                       }
> -                       handle =3D base->handle;
> -               }
> -               ttm_base_object_unref(&base);
> -       }
> -
> -       /*
> -        * Create a new fence object.
> -        */
> -       if (!fence) {
> -               ret =3D vmw_execbuf_fence_commands(file_priv, dev_priv,
> -                                                &fence,
> -                                                (user_fence_rep) ?
> -                                                &handle : NULL);
> -               if (unlikely(ret !=3D 0)) {
> -                       DRM_ERROR("Fence event failed to create fence.\n"=
);
> -                       return ret;
> -               }
> -       }
> -
> -       BUG_ON(fence =3D=3D NULL);
> -
> -       ret =3D vmw_event_fence_action_create(file_priv, fence,
> -                                           arg->flags,
> -                                           arg->user_data,
> -                                           true);
> -       if (unlikely(ret !=3D 0)) {
> -               if (ret !=3D -ERESTARTSYS)
> -                       DRM_ERROR("Failed to attach event to fence.\n");
> -               goto out_no_create;
> -       }
> -
> -       vmw_execbuf_copy_fence_user(dev_priv, vmw_fp, 0, user_fence_rep, =
fence,
> -                                   handle, -1);
> -       vmw_fence_obj_unreference(&fence);
> -       return 0;
> -out_no_create:
> -       if (user_fence_rep !=3D NULL)
> -               ttm_ref_object_base_unref(tfile, handle);
> -out_no_ref_obj:
> -       vmw_fence_obj_unreference(&fence);
> -       return ret;
> +       return -ENOTTY; // Never Used
>  }
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.h b/drivers/gpu/drm/vmwg=
fx/vmwgfx_fence.h
> index e897cccae1ae..24d7b279ca4b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.h
> @@ -101,10 +101,4 @@ extern int vmw_fence_obj_unref_ioctl(struct drm_devi=
ce *dev, void *data,
>                                      struct drm_file *file_priv);
>  extern int vmw_fence_event_ioctl(struct drm_device *dev, void *data,
>                                  struct drm_file *file_priv);
> -extern int vmw_event_fence_action_queue(struct drm_file *filee_priv,
> -                                       struct vmw_fence_obj *fence,
> -                                       struct drm_pending_event *event,
> -                                       uint32_t *tv_sec,
> -                                       uint32_t *tv_usec,
> -                                       bool interruptible);
>  #endif /* _VMWGFX_FENCE_H_ */
> --
> 2.56.0
>

Yea, that's probably a good idea. Unused code is so hard to maintain
in the llm age.
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

--00000000000065eab6065f01dfa4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVIgYJKoZIhvcNAQcCoIIVEzCCFQ8CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKPMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWDCCBECg
AwIBAgIMYT8cPnonh1geNIT5MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NTUwOVoXDTI2MTEyOTA2NTUwOVowgaUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKWmFjayBSdXNpbjEmMCQGCSqG
SIb3DQEJARYXemFjay5ydXNpbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCwQ8KpnuEwUOX0rOrLRj3vS0VImknKwshcmcfA9VtdEQhJHGDQoNjaBEFQHqLqn4Lf
hqEGUo+nKhz2uqGl2MtQFb8oG+yJPCFPgeSvbiRxmeOwSP0jrNADVKpYpy4UApPqS+UfVQXKbwbM
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIL9+
i+g0yIoOke5EbIGtrMNTDIu3bl6191MFcu8arX0sMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAyOTIyMDUwN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEiYBy095fOGoV6S02hvRDVW8MNUnmRt1KS9Ia2A
zaqr/V4J5ruohKRx01mrFAUc7Iy7ihsQmJW9I4xAg7mxoYSh9ahZXa2+AHXJ7SBVtuk/X4wBOSVb
947ZKP57iMtTjZfaX2gpXKu4I4Hlh0flj6PiQevE09Or7HkDV4TY5mg2b/Ojl9PMYMrzaDQczpvp
GOvUPuZp/VhXmPUeKdo1Sumfi33vJ+77ubgeTlp2MdoyD9V8pooZFce0IRHsxGHteUzNaV/WaBwq
Xixu6ml5N9UbM4IqrXEStKShWUJe4FbzzjaIJVCDOjgXiGcNu7megLWvhY6MjOTOAWwD1Rdok/g=
--00000000000065eab6065f01dfa4--
