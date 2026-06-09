Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2A7CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E244710E315;
	Tue,  9 Jun 2026 15:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vq4v6QBE";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B38910E158
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:30:26 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30759632453so8422161eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 08:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019025; cv=none;
 d=google.com; s=arc-20240605;
 b=LpzfJQ+eZjx6aQg1/yLhBf5nHl83vKCxwyudqjn6yhue+8ogYnYI5PasEoWCs3O8Fp
 tE1egLOCQ/WjfITDGcszJhxYOFSe8j3+zC+OabKdWS/gsdPVd2g/S+nYgMaFAcdqlNZZ
 MBndBNoU4SC5ox8WZfPOYys8RQns02rhf3nu0526mURxZBl39qy5V5S5bPwHVdjgPZnd
 WAZBHvbglr6tHxvsbeb9S6uBrKKHhmFhpZ+8h4wXi7C802zql5K3eBbKgX0j+RCI6myJ
 GIa3MDhG4qMV5MeECVDP8a5d2TAbjjUc4XIExpFfq+dR3ANBF7AybZHwkWMYa3LD9ZPH
 rKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vJU+o++m0aasR83bRIxN574z9aspy1ro3TGM/ArKaY4=;
 fh=OBxAXQYv2J0xPqpWeyjIww00+MTWlaSsd8TxfmjYH7o=;
 b=MoTLU5hsS8Ohv+TELYVrk7gYGETC15DfbU5E1I9794nSLhdYCFW2DFH3Voa21RDAb9
 FA3hc+lqAka4wrnDrbXfbuR19+SotoPZwD3WPvNohBlpGPrbd5WahmYiUWW7oh39nTmk
 bg4EZLc+yoLM5b/m3h1kth1Jt0653o/acksF/kzFzff7JR39GO+DGR4ATy3RYd9VVrFE
 DHo/5XkmwENSzFvwNHOK3vP5aFzmsZO+P+nEG+Q/Lhgvd0DdFDx89DeLsnBUsN4xQfOo
 NabsKuvawSR952+MlbBeoEpBbb1iZy0JuezqB3xNBdVt/hArL54ZcA6y0q16h4CmC8+o
 KV4w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781019025; x=1781623825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJU+o++m0aasR83bRIxN574z9aspy1ro3TGM/ArKaY4=;
 b=Vq4v6QBEBboFQPVTXbYNm6DI7GbHESlpjC1Oxa95ZCIysVCuyMqxdEH/fMF0uZELCZ
 hsCwX0fa15ahIOk9MszVFklQf4iK/iUIWWwyqxPQnm8BhhbZUQBI5DKWUAhvY0ddV6Q0
 rFqfajeOmYbfIoY3EAPdgK+HP0HYveuGp/0YfLFxLU3Wvet2EccCiw59HS1tnEvYSey3
 nJDYSvYH22wecN9pgMpsYT9rtJ15YeZhmUwAIa7mHERSmJnhDUo/bbMstTZBIypUumt3
 1OQoKZzlKaj02MDkJ4xzstbS1CMoXxZzuowIJC0rY+nP5jbQhAS6se4t9av3ycvbA7eA
 Omuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781019025; x=1781623825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vJU+o++m0aasR83bRIxN574z9aspy1ro3TGM/ArKaY4=;
 b=TNUeKG2nYsTeADld6vcwQBCM3lbWR2j5OecMli6LYuqCxDURJyjySAy7Yqa7szoegQ
 h+wUdFuf9Vz96UDWQ39NgLV1ibnE0R0udgkcU6h5qF58c9ckkTaRU3M5FiZGsHOP4DcX
 EMu09SH5XXwrJMLP/JyJWxxfIqjRxqkHnuBOFjKaHG7SEffSvd0Gtv55ggfEAfmp0R6P
 Ssb3B7spzJoCmP7a4J6rYW+FBEntlbEjiUwVKkjWNgRBZYipEVqrqXpZo0O227h0jyUc
 6c/fXZzyzutb7LOAwaUYR9sdNKh7iuQGS9uXbYipypWnnAQuC1DOv4kPJu6+k75Fl9kv
 orlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ82z4uXFuBvTnj8ml5W3ymIifKBtWu71XkQI8fAaN4sKQc3YUHzXHP9HLo72dqY14e/KiErtmt4iig=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx01ffwGURuwty6bVjMv5i+zUhXvEr3LaxEvBkh10Uuai1WqAac
 kAfyKPDTdF8+d0NPJtTvYv83xBSylGeYFqAK2WIR0WFugpKS8G1i9ko6DnMKd+en3HWm/wQtWFp
 oaZG2Rp5QrqjHhQbhMFVxYpK2YfPh6Vs=
X-Gm-Gg: Acq92OE/cbqelj+I9tc6lngJJ217rzOC27Z47U+7MldnUo3UMyanwt2ixV0TqLz2mg+
 5+2+xxj3Q3Goax8Qz7h0H+dBo37ObS4qvdVNjNSbKd/OIfgt+xpNKYnj5q///6fHhrEamkymiId
 6lIz4euDs4vNMF0SH/9nljKp+OM32bEUJr++gL8ScVR+tVK1R3VjDrL4kkxWMZNad1l09iP3EZj
 NMJf0IcYGwgmq8L8jEh0pNaAeJUTXSOhfmO74uZfqJRP7WWK1TkUmi0crm+UjaNi+U2AbPHivr2
 5XsWSQUAH3hWP7pA5CQ=
X-Received: by 2002:a05:7300:730a:b0:307:2e1c:17f1 with SMTP id
 5a478bee46e88-3077b1f6abcmr12851372eec.25.1781019025332; Tue, 09 Jun 2026
 08:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260604063943.1412955-1-lgs201920130244@gmail.com>
 <42b82b4f-43ce-4943-bc64-d7386998473c@amd.com>
In-Reply-To: <42b82b4f-43ce-4943-bc64-d7386998473c@amd.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 9 Jun 2026 23:30:11 +0800
X-Gm-Features: AVVi8CcZdB41eilVcYzozusawa1g5tNYIXVlt10eHy4mOCLoqWYvJODpLiDSN_s
Message-ID: <CANUHTR9YUmkjrDSGL0uSfHHGxhGtOgfPuF2OudbjTyrCAvd1sA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: clean up VA state on create failure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Prike Liang <Prike.Liang@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, "Jesse.Zhang" <Jesse.Zhang@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi Christian,

Thanks for pointing this out.

On Fri, 5 Jun 2026 at 17:32, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> On 6/4/26 08:39, Guangshuo Li wrote:
> > amdgpu_userq_input_va_validate() is not a side-effect-free validator.
> > When it succeeds, it allocates a VA cursor, links it on
> > queue->userq_va_list and marks the corresponding bo_va as userq mapped.
>
> That was already removed, you are looking at outdated code.
>
> Regards,
> Christian.
>
> >
> > The user queue create path validates queue_va, rptr_va and wptr_va with=
 a
> > short-circuit OR expression. If an earlier validation succeeds and a
> > later validation fails, the error path frees the queue directly. The VA
> > cursor added by the successful validation is leaked and
> > bo_va->userq_va_mapped remains set even though no user queue was create=
d.
> >
> > The same stale VA tracking state can also survive later create failures
> > after all VA validations have succeeded, because those paths also free
> > the queue without unwinding queue->userq_va_list.
> >
> > Route the create error paths through common unwind labels and call
> > amdgpu_userq_buffer_vas_list_cleanup() before freeing the queue. This
> > releases any VA cursors added during validation and clears the stale
> > userq VA mapping state.
> >
> > Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address=
 and size")
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 32 +++++++++++------------
> >  1 file changed, 15 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userq.c
> > index 0a1b93259887..dba0f786ae4a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -826,17 +826,15 @@ amdgpu_userq_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
> >             amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_v=
a, AMDGPU_GPU_PAGE_SIZE) ||
> >             amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_v=
a, AMDGPU_GPU_PAGE_SIZE)) {
> >                 r =3D -EINVAL;
> > -               kfree(queue);
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >
> >         /* Convert relative doorbell offset into absolute doorbell inde=
x */
> >         index =3D amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, fil=
p);
> >         if (index =3D=3D (uint64_t)-EINVAL) {
> >                 drm_file_err(uq_mgr->file, "Failed to get doorbell for =
queue\n");
> > -               kfree(queue);
> >                 r =3D -EINVAL;
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >
> >         queue->doorbell_index =3D index;
> > @@ -844,15 +842,14 @@ amdgpu_userq_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
> >         r =3D amdgpu_userq_fence_driver_alloc(adev, queue);
> >         if (r) {
> >                 drm_file_err(uq_mgr->file, "Failed to alloc fence drive=
r\n");
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >
> >         r =3D uq_funcs->mqd_create(queue, &args->in);
> >         if (r) {
> >                 drm_file_err(uq_mgr->file, "Failed to create Queue\n");
> >                 amdgpu_userq_fence_driver_free(queue);
> > -               kfree(queue);
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >
> >         /* drop this refcount during queue destroy */
> > @@ -862,21 +859,17 @@ amdgpu_userq_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
> >         down_read(&adev->reset_domain->sem);
> >         r =3D xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queu=
e, GFP_KERNEL));
> >         if (r) {
> > -               kfree(queue);
> >                 up_read(&adev->reset_domain->sem);
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >
> >         r =3D xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> >                      XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
> >         if (r) {
> >                 drm_file_err(uq_mgr->file, "Failed to allocate a queue =
id\n");
> > -               amdgpu_userq_fence_driver_free(queue);
> > -               uq_funcs->mqd_destroy(queue);
> > -               kfree(queue);
> >                 r =3D -ENOMEM;
> >                 up_read(&adev->reset_domain->sem);
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >         up_read(&adev->reset_domain->sem);
> >
> > @@ -892,10 +885,7 @@ amdgpu_userq_create(struct drm_file *filp, union d=
rm_amdgpu_userq *args)
> >                 if (r) {
> >                         drm_file_err(uq_mgr->file, "Failed to map Queue=
\n");
> >                         xa_erase(&uq_mgr->userq_xa, qid);
> > -                       amdgpu_userq_fence_driver_free(queue);
> > -                       uq_funcs->mqd_destroy(queue);
> > -                       kfree(queue);
> > -                       goto unlock;
> > +                       goto free_queue;
> >                 }
> >         }
> >
> > @@ -915,7 +905,15 @@ amdgpu_userq_create(struct drm_file *filp, union d=
rm_amdgpu_userq *args)
> >
> >         args->out.queue_id =3D qid;
> >         atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> > +       goto unlock;
> >
> > +free_mqd:
> > +       uq_funcs->mqd_destroy(queue);
> > +free_fence_driver:
> > +       amdgpu_userq_fence_driver_free(queue);
> > +free_queue:
> > +       amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> > +       kfree(queue);
> >  unlock:
> >         mutex_unlock(&uq_mgr->userq_mutex);
> >
> > --
> > 2.43.0
> >
>

I was looking at an outdated codebase. Sorry for the noise.

Regards,
Guangshuo
