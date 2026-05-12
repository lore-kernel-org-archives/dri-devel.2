Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E48CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 21:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A3610E5C2;
	Tue, 12 May 2026 21:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aZqR47C7";
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B2B10E5C2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 21:55:43 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-7bd810cdc5dso65212657b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778622942; cv=none;
 d=google.com; s=arc-20240605;
 b=REyiTF7fANFZPHZKP7hGZ++KVOPV2ZpIzRY1G386ywiFwv6/JB4APCNr1yK9clrWqJ
 xDJOTbMquFBxZAUwsKS4mt/6Q8qHSAl7CQ9Ls3/bPYSLp6OiytisqUPnudQEM2ODZiAs
 kpHAKN9NJW+HIwn0mYbvvzKyem/km3rqKucGjzXDj5tCYROuLbY8kBn1TdWp0ErSubNA
 U/LEnrmMkjkoE5zn0c+V+MygbkYs/wfFRveF2iSXtL5mW1YO9Vge4mBqpMEw+qs7XfLV
 W9wHV/xAFCdCSWvFkpP4nhK82w+MFZrwKzp5Utp+rSulaYvCeR6GyaxBunOs53LdIkhT
 /+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6siaRiJCxGUQ4V8uEWAgm41HK+hOsAS6pXUOkS7dfQk=;
 fh=Om8Pkm5C8FLCFfJp/kPrP12kkc0M9DTDl4CeT+dzMwY=;
 b=KmkSrYh2ZkeoYIgko4qfxQxSMwk7JH8JEIVsTgLQfDtX/hPTUw+75/vqhss4IGQ7Z+
 bBgsbskQeFrc8TKU5goNNU46LXUWiZEAEpcqzbtjClKY9cg/cJYUOPIm1sWbageJYepH
 1VkSFHaxpQF2CaryYZ23PheTYd6+jsad/x1LZB3ro/gsqQ9+t/ITtjvSMXWRcV1hR6NL
 zKClqxWi0vB10w3/TU4dy0mpn8TvyFfXgKvV+UiOGVoLVFPYssvgNXODBrOZ8Z+T8+dh
 mnDfftJG840CsbWupOjm1Mn42QpbHylf0KpIzCvbian889/mGmis378uIg4TJP1zI44F
 X+Hw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778622942; x=1779227742; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6siaRiJCxGUQ4V8uEWAgm41HK+hOsAS6pXUOkS7dfQk=;
 b=aZqR47C7DHt3ECTgdc29taMTiwXjLq45GVAboPrLxb34FREzhiCfSF7r5MAGS+g+VL
 aCG0Qb43kA8kuDGE+byKmye0Ub4VsloMtL4Zws+YJd36fPhcSPH+huoUx/PTkFB4J5o8
 xU9MiNuLogYNTyYUO/wGuhUMEMk9+nnRGnQpSLA3cclciz/oQtpZdRJ1TRTGJQXssqxp
 GfVVaCa4fR1fvNyzAAZOX02oB5eKDlDFmCLIiZPVrSMHWoE80tQmnSHF4U23iWYHnwqQ
 3inp1pm5H95y91h1Nty1LhFCFCOci+xhU/0TD893DeUVIkP9SwVZPWU5tQkEy5IzluXh
 TBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778622942; x=1779227742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6siaRiJCxGUQ4V8uEWAgm41HK+hOsAS6pXUOkS7dfQk=;
 b=JbnMRRh3PdUSJvRNiimtAA70HU6nnNGURO/3+QuWy8jvszsN32nD5DPO1MnVZmpGg2
 DnebOFMZSnQUpEsXOyaWyTyuowMbDujIj/XBScnS/mzJMG6h/gnleEprQj5oDRlfElBk
 LZX/bb2L/a7EhGfAMSevCYuK9midd1stS7ELAsIq1wg+ewVO1wmSKYQIZCkYOhRWTQNV
 s1+tyNoKjX1UxE2fpkyBpssW7GSYpuD6cLV5S/w66EjLzUqGJaDY+cwb336P62MJEXQa
 n/yNGMop1bw/ahfIeqVM9L+gS0sJpfjFYtETUP6qozls4nWA8calhaqIPlm+qh99NJrs
 VIEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8e5vqOP+msM81FRnMYr/6bWqFPricnFv9frM64o90QPICb11zsfeV/rEtTjKvap+WCUXsu/iQYq0s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxK/O/VBpRm2IwpBXg64saTM8rpgcUIe7pyC0Js/efF2RQ49luM
 nrUVZSyFOBOnMuea7ojzvcR6I2jRnE4ZC/pq+kTTMdvtgZwSoJZVjeleQ1jD8S9fkgr8kXV7YiO
 6oQv4vjOEJeOpGx+a7CoEA3479837Ing=
X-Gm-Gg: Acq92OGlwNmyQkHLqAYYU/jAiGDGfgMvKmh3GJ/IwiGrOjthYM20xtJ1KCdaV84UexX
 HMExsCZAdQ56Av3orsQuSZ/4M7pVDcFUYnI/WJBFcJaVgoyl5CedaVHEHlXBA5JMScSBHCJVxOM
 PjM3kDX7DqKh9EDiQ7K5dRsWdqJsMLgqWZ+EEcYKXATZ8Q6DzAa2bXbOjbwsyPwPY9HFVRLg3ei
 YSrCQY/umyC8YMbBvjCEJhAVOF6yqynDh0nldNV8rFfmuMiJlzTsMImzYLuTTZnHoAKGv4fxjRO
 2vPhv06+Bs1oHbvDJry3L5XSIq0GjcafHIcBaTJj5Uv97/IV8kcs2832NrZIGibwHnGRegyNaA=
 =
X-Received: by 2002:a05:690c:c50d:b0:7bd:7afc:ec46 with SMTP id
 00721157ae682-7c6ac9a6b5emr7162057b3.45.1778622942568; Tue, 12 May 2026
 14:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-8-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-8-95c614a739cb@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 12 May 2026 14:55:30 -0700
X-Gm-Features: AVHnY4Kem1DJATb6sP9GPBt05_J9zFrJz1SPpcPkgjtdyoJnKiuKs_XPPcYyRX0
Message-ID: <CAPaKu7Sx85JpFFJ_4w3mZ6_OPkCHDqp68Uo+RbeYx=5v03vdww@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] drm/panthor: Automatically enable interrupts in
 panthor_fw_wait_acks()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
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

On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> Rather than assuming an interrupt is always expected for request
> acks, temporarily enable the relevant interrupts when the polling-wait
> failed. This should hopefully reduce the number of interrupts the CPU
> has to process.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
WIth minor comments below, Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c    | 34 +++++++++++++++++++--------=
------
>  drivers/gpu/drm/panthor/panthor_sched.c |  5 +++--
>  2 files changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 8239a6951569..f5e0ceca4130 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1039,16 +1039,10 @@ static void panthor_fw_init_global_iface(struct p=
anthor_device *ptdev)
>         glb_iface->input->progress_timer =3D PROGRESS_TIMEOUT_CYCLES >> P=
ROGRESS_TIMEOUT_SCALE_SHIFT;
>         glb_iface->input->idle_timer =3D panthor_fw_conv_timeout(ptdev, I=
DLE_HYSTERESIS_US);
>
> -       /* Enable interrupts we care about. */
> -       glb_iface->input->ack_irq_mask =3D GLB_CFG_ALLOC_EN |
> -                                        GLB_PING |
> -                                        GLB_CFG_PROGRESS_TIMER |
> -                                        GLB_CFG_POWEROFF_TIMER |
> -                                        GLB_IDLE_EN |
> -                                        GLB_IDLE;
> -
> -       if (panthor_fw_has_glb_state(ptdev))
> -               glb_iface->input->ack_irq_mask |=3D GLB_STATE_MASK;
> +       /* Enable interrupts for asynchronous events that are not
> +        * triggered by request acks.
> +        */
> +       glb_iface->input->ack_irq_mask =3D GLB_IDLE;
We should static_assert or & with GLB_EVT_MASK. Same for CSG and CS.

>
>         panthor_fw_update_reqs(glb_iface, req, GLB_IDLE_EN | GLB_COUNTER_=
EN,
>                                GLB_IDLE_EN | GLB_COUNTER_EN);
> @@ -1318,8 +1312,8 @@ void panthor_fw_unplug(struct panthor_device *ptdev=
)
>   * Return: 0 on success, -ETIMEDOUT otherwise.
>   */
>  static int panthor_fw_wait_acks(const u32 *req_ptr, const u32 *ack_ptr,
> -                               wait_queue_head_t *wq,
> -                               u32 req_mask, u32 *acked,
> +                               u32 *ack_irq_mask_ptr, spinlock_t *lock,
> +                               wait_queue_head_t *wq, u32 req_mask, u32 =
*acked,
>                                 u32 timeout_ms)
>  {
>         u32 ack, req =3D READ_ONCE(*req_ptr) & req_mask;
> @@ -1334,8 +1328,16 @@ static int panthor_fw_wait_acks(const u32 *req_ptr=
, const u32 *ack_ptr,
>         if (!ret)
>                 return 0;
>
> -       if (wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_mask) =3D=
=3D req,
> -                              msecs_to_jiffies(timeout_ms)))
> +       scoped_guard(spinlock_irqsave, lock)
> +               *ack_irq_mask_ptr |=3D req_mask;
> +
> +       ret =3D wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_mask) =
=3D=3D req,
> +                                msecs_to_jiffies(timeout_ms));
> +
> +       scoped_guard(spinlock_irqsave, lock)
> +               *ack_irq_mask_ptr &=3D ~req_mask;
We should add a comment saying that this is safe because
{GLB,CSG,CS}_REQ_MASK and {GLB,CSG,CS}_EVT_MASK are disjoint, and thus
req_mask and ack_irq_mask are disjoint.
> +
> +       if (ret)
>                 return 0;
>
>         /* Check one last time, in case we were not woken up for some rea=
son. */
> @@ -1369,6 +1371,8 @@ int panthor_fw_glb_wait_acks(struct panthor_device =
*ptdev,
>
>         return panthor_fw_wait_acks(&glb_iface->input->req,
>                                     &glb_iface->output->ack,
> +                                   &glb_iface->input->ack_irq_mask,
> +                                   &glb_iface->lock,
>                                     &ptdev->fw->req_waitqueue,
>                                     req_mask, acked, timeout_ms);
>  }
> @@ -1395,6 +1399,8 @@ int panthor_fw_csg_wait_acks(struct panthor_device =
*ptdev, u32 csg_slot,
>
>         ret =3D panthor_fw_wait_acks(&csg_iface->input->req,
>                                    &csg_iface->output->ack,
> +                                  &csg_iface->input->ack_irq_mask,
> +                                  &csg_iface->lock,
>                                    &ptdev->fw->req_waitqueue,
>                                    req_mask, acked, timeout_ms);
>
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 6c5ba747ae45..a9124bcc7de6 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1110,7 +1110,7 @@ cs_slot_prog_locked(struct panthor_device *ptdev, u=
32 csg_id, u32 cs_id)
>         cs_iface->input->ringbuf_output =3D queue->iface.output_fw_va;
>         cs_iface->input->config =3D CS_CONFIG_PRIORITY(queue->priority) |
>                                   CS_CONFIG_DOORBELL(queue->doorbell_id);
> -       cs_iface->input->ack_irq_mask =3D ~0;
> +       cs_iface->input->ack_irq_mask =3D CS_FATAL | CS_FAULT | CS_TILER_=
OOM;
>         panthor_fw_update_reqs(cs_iface, req,
>                                CS_IDLE_SYNC_WAIT |
>                                CS_IDLE_EMPTY |
> @@ -1378,7 +1378,8 @@ csg_slot_prog_locked(struct panthor_device *ptdev, =
u32 csg_id, u32 priority)
>                 csg_iface->input->protm_suspend_buf =3D 0;
>         }
>
> -       csg_iface->input->ack_irq_mask =3D ~0;
> +       csg_iface->input->ack_irq_mask =3D CSG_SYNC_UPDATE | CSG_IDLE |
> +                                        CSG_PROGRESS_TIMER_EVENT;
>         panthor_fw_toggle_reqs(csg_iface, doorbell_req, doorbell_ack, que=
ue_mask);
>         return 0;
>  }
>
> --
> 2.54.0
>

On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> Rather than assuming an interrupt is always expected for request
> acks, temporarily enable the relevant interrupts when the polling-wait
> failed. This should hopefully reduce the number of interrupts the CPU
> has to process.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c    | 34 +++++++++++++++++++--------=
------
>  drivers/gpu/drm/panthor/panthor_sched.c |  5 +++--
>  2 files changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 8239a6951569..f5e0ceca4130 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1039,16 +1039,10 @@ static void panthor_fw_init_global_iface(struct p=
anthor_device *ptdev)
>         glb_iface->input->progress_timer =3D PROGRESS_TIMEOUT_CYCLES >> P=
ROGRESS_TIMEOUT_SCALE_SHIFT;
>         glb_iface->input->idle_timer =3D panthor_fw_conv_timeout(ptdev, I=
DLE_HYSTERESIS_US);
>
> -       /* Enable interrupts we care about. */
> -       glb_iface->input->ack_irq_mask =3D GLB_CFG_ALLOC_EN |
> -                                        GLB_PING |
> -                                        GLB_CFG_PROGRESS_TIMER |
> -                                        GLB_CFG_POWEROFF_TIMER |
> -                                        GLB_IDLE_EN |
> -                                        GLB_IDLE;
> -
> -       if (panthor_fw_has_glb_state(ptdev))
> -               glb_iface->input->ack_irq_mask |=3D GLB_STATE_MASK;
> +       /* Enable interrupts for asynchronous events that are not
> +        * triggered by request acks.
> +        */
> +       glb_iface->input->ack_irq_mask =3D GLB_IDLE;
>
>         panthor_fw_update_reqs(glb_iface, req, GLB_IDLE_EN | GLB_COUNTER_=
EN,
>                                GLB_IDLE_EN | GLB_COUNTER_EN);
> @@ -1318,8 +1312,8 @@ void panthor_fw_unplug(struct panthor_device *ptdev=
)
>   * Return: 0 on success, -ETIMEDOUT otherwise.
>   */
>  static int panthor_fw_wait_acks(const u32 *req_ptr, const u32 *ack_ptr,
> -                               wait_queue_head_t *wq,
> -                               u32 req_mask, u32 *acked,
> +                               u32 *ack_irq_mask_ptr, spinlock_t *lock,
> +                               wait_queue_head_t *wq, u32 req_mask, u32 =
*acked,
>                                 u32 timeout_ms)
>  {
>         u32 ack, req =3D READ_ONCE(*req_ptr) & req_mask;
> @@ -1334,8 +1328,16 @@ static int panthor_fw_wait_acks(const u32 *req_ptr=
, const u32 *ack_ptr,
>         if (!ret)
>                 return 0;
>
> -       if (wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_mask) =3D=
=3D req,
> -                              msecs_to_jiffies(timeout_ms)))
> +       scoped_guard(spinlock_irqsave, lock)
> +               *ack_irq_mask_ptr |=3D req_mask;
> +
> +       ret =3D wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_mask) =
=3D=3D req,
> +                                msecs_to_jiffies(timeout_ms));
> +
> +       scoped_guard(spinlock_irqsave, lock)
> +               *ack_irq_mask_ptr &=3D ~req_mask;
> +
> +       if (ret)
>                 return 0;
>
>         /* Check one last time, in case we were not woken up for some rea=
son. */
> @@ -1369,6 +1371,8 @@ int panthor_fw_glb_wait_acks(struct panthor_device =
*ptdev,
>
>         return panthor_fw_wait_acks(&glb_iface->input->req,
>                                     &glb_iface->output->ack,
> +                                   &glb_iface->input->ack_irq_mask,
> +                                   &glb_iface->lock,
>                                     &ptdev->fw->req_waitqueue,
>                                     req_mask, acked, timeout_ms);
>  }
> @@ -1395,6 +1399,8 @@ int panthor_fw_csg_wait_acks(struct panthor_device =
*ptdev, u32 csg_slot,
>
>         ret =3D panthor_fw_wait_acks(&csg_iface->input->req,
>                                    &csg_iface->output->ack,
> +                                  &csg_iface->input->ack_irq_mask,
> +                                  &csg_iface->lock,
>                                    &ptdev->fw->req_waitqueue,
>                                    req_mask, acked, timeout_ms);
>
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 6c5ba747ae45..a9124bcc7de6 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1110,7 +1110,7 @@ cs_slot_prog_locked(struct panthor_device *ptdev, u=
32 csg_id, u32 cs_id)
>         cs_iface->input->ringbuf_output =3D queue->iface.output_fw_va;
>         cs_iface->input->config =3D CS_CONFIG_PRIORITY(queue->priority) |
>                                   CS_CONFIG_DOORBELL(queue->doorbell_id);
> -       cs_iface->input->ack_irq_mask =3D ~0;
> +       cs_iface->input->ack_irq_mask =3D CS_FATAL | CS_FAULT | CS_TILER_=
OOM;
>         panthor_fw_update_reqs(cs_iface, req,
>                                CS_IDLE_SYNC_WAIT |
>                                CS_IDLE_EMPTY |
> @@ -1378,7 +1378,8 @@ csg_slot_prog_locked(struct panthor_device *ptdev, =
u32 csg_id, u32 priority)
>                 csg_iface->input->protm_suspend_buf =3D 0;
>         }
>
> -       csg_iface->input->ack_irq_mask =3D ~0;
> +       csg_iface->input->ack_irq_mask =3D CSG_SYNC_UPDATE | CSG_IDLE |
> +                                        CSG_PROGRESS_TIMER_EVENT;
>         panthor_fw_toggle_reqs(csg_iface, doorbell_req, doorbell_ack, que=
ue_mask);
>         return 0;
>  }
>
> --
> 2.54.0
>
