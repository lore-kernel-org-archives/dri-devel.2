Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA44C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3C310EFFC;
	Thu, 23 Jul 2026 07:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jnM/tBJy";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6DA10EFED
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 07:14:27 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5aeb98460c6so333643e87.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784790866; x=1785395666; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bFo0mK2Twky9T7qEB2bTUDQtTh7rdNsTlOuaha0+uKE=;
 b=jnM/tBJyQ+p5o2PHDDGpXKep3XBH32uyca/a7YYwgYMvqLeBEw/O1BaiQ822W2d2oE
 /SC4lzyFFnt+hQbR4O8EZQOUoWZw0MPw5PYk5xuruvUckhLWIZx1a/6X26UnV0ongpWq
 iZtmGpN2hqA+8/3bRZLMwI5R56k6Ii/IqlexszyUaohj9QXEe2v/dxS15EkaVBwIEFSH
 intJ2gfgz/aeoV+v5VZ2Rw9Nx96p9xnPM5VMq7n+PVem9YNu78Kn+try7zO8t5ntaa1F
 5T3BB1nCATTFJXwEDLcZPR6h/YjEGF7apH+fOSJVGn/yWWd/N9Gt6Ej+8bIrenH/WXiu
 ochw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790866; x=1785395666;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bFo0mK2Twky9T7qEB2bTUDQtTh7rdNsTlOuaha0+uKE=;
 b=TbkptF9eXfLnH8/qF+RCBphbRcqBtprT9lH2khq5nZmTuEObB1t0AsuNLtsJVYNkjd
 2DHPmkVixWLVZrGiNDUrodLtOQNgiLieeuwIfkhB0tLgF4Dl+KBcbn7d8iot4/Wuj5hB
 F0YXFoLLRUe2zHz66fZjHBO+fZ9oHP7uoqJ728A+SI6OCgQf1Ou581xy502zOJdfLCy+
 DPKEAQp8kXhmZ9ayeifKHGdycdov46WqkUwQYicNKmUW9oSWfGdIOnktZ0MuC+nE1zis
 83USv5AgMm0If+nox1SIstvldLVwAaZdx4p9glkNXDtMoekwYmsMQ6tn6JE73WdSgi0e
 5Dug==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJAyqZSxM13+X+jdw6N9dpMmybiElsui12uQwbmlLtDcWPZNC8Qtr1MPNBnho1exFwotSNfgzOgYQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLAyS7X3sIffzxawYl4wwEFs+G4opQjmVsndV/hwlIQAg9NxHH
 7gyEkbYkZViMju8EBq9UzkLklPap6PqjlRq7jamPauizWhJIBEajCM0rAfrFhrOVdcY=
X-Gm-Gg: AR+sD13/Cw1ASNTEQj80kcj8S+GFbvOsqCtpnmA/6hzESOw98UPlaHFVGeJ3tgtYaUG
 UsyisBPd7HXBgsOeAsyItL/S5IOPmzrlgpHidMKH/ZaGEn+R17IdphrkxvHyD7vNnkmjcy/30GS
 TSyOobUzEmFNY3WdMZSyDg+BnpUKxJhMzloYl2Vp8MC27qCU2WIitQewVpEP44vX1smacE3a9e4
 VyuKmTBIVHJA1y4d5AMdCNJyfshRDDOmVolfFdYtyM1Z8Tvao4XAGEyI7StgGYpzrO8jzBtV4fo
 HG5UhiHKgzmLZhF9NX49emkPGc2XOs3iRfPudwFwiYBZ0OoyU06T9/ncilquGnfAQVD0pI7fMs9
 WwGlHlbfeyIPwwEOenldAKaIaexBhuwmEweCp/Zhy63wMLlpZ6zTc2xnHbC6EmGoTZB7vCpNDNo
 7Hgo2sKbx96okHXjdHswzgfYvZiRV2vA==
X-Received: by 2002:a05:6512:3e2a:b0:5ae:af98:497f with SMTP id
 2adb3069b0e04-5b2b2e4995cmr317702e87.7.1784790865836; 
 Thu, 23 Jul 2026 00:14:25 -0700 (PDT)
Received: from nuoska (78-27-71-225.bb.dnainternet.fi. [78.27.71.225])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9f4d42esm844102e87.79.2026.07.23.00.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:14:25 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:14:23 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, stable@vger.kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/virtio: fix deadlock in display_info_cb by
 removing hotplug from dequeue worker
Message-ID: <amG_T7Kb7DW3VTxm@nuoska>
References: <20260713-virtiogpu_syzbot-v2-1-2958fa37d46d@redhat.com>
 <ba8a2de8-8ac7-490d-b48e-767d1e7893a9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba8a2de8-8ac7-490d-b48e-767d1e7893a9@collabora.com>
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

Hi, adding stable@vger.kernel.org

In Yocto distro, this change released in v7.2-rc4 seems to fix quite severe qemu
boot hangs seen with 6.18 stable kernels. Details in
https://bugzilla.yoctoproject.org/show_bug.cgi?id=16217

Please apply this to to 6.18 and other stable trees.

Cheers,

-Mikko

On Mon, Jul 13, 2026 at 07:31:14PM +0300, Dmitry Osipenko wrote:
> On 7/13/26 16:01, Ryosuke Yasuoka wrote:
> > A probe-time deadlock can occur between the dequeue worker and
> > drm_client_register(). During probe, drm_client_register() holds
> > clientlist_mutex and calls the fbdev hotplug callback, which triggers an
> > atomic commit that ends up sleeping in virtio_gpu_queue_ctrl_sgs()
> > waiting for virtqueue space. The dequeue worker that would free that
> > space calls virtio_gpu_cmd_get_display_info_cb(), which invokes
> > drm_kms_helper_hotplug_event() -> drm_client_dev_hotplug(), attempting
> > to acquire the same clientlist_mutex. Since wake_up() is only called
> > after the resp_cb loop, the probe thread is never woken and both threads
> > deadlock.
> > 
> > Fix this by removing the hotplug notification from
> > virtio_gpu_cmd_get_display_info_cb(). The display data (outputs[i].info)
> > is still updated synchronously in the callback.
> > 
> > For the init path, drm_client_register() already fires an initial
> > hotplug when the client is registered, which picks up the connector
> > state updated by display_info_cb.
> > 
> > For the runtime config_changed path, add a wait_event_timeout() in
> > config_changed_work_func() so that display_info_cb updates the connector
> > data before the hotplug notification is sent. Also replace
> > drm_helper_hpd_irq_event() with drm_kms_helper_hotplug_event() since
> > virtio-gpu never calls drm_kms_helper_poll_init() and thus
> > drm_helper_hpd_irq_event() always returns false without doing anything.
> > 
> > Fixes: 27655b9bb9f0 ("drm/client: Send hotplug event after registering a client")
> > Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
> > Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
> > Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> > I checked whether drm_helper_hpd_irq_event() is needed in
> > virtio_gpu_init(), as Dmitry suggested. AFAIS, it is not needed because:
> > 
> > 1. drm_helper_hpd_irq_event() is always a no-op in virtio-gpu.
> >    It returns false immediately probe_helper.c:1088 because
> >    dev->mode_config.poll_enabled is false — virtio-gpu never calls
> >    drm_kms_helper_poll_init(). Even if it passed that gate, no
> >    virtio-gpu connectors set DRM_CONNECTOR_POLL_HPD.
> > 
> > 1082 bool drm_helper_hpd_irq_event(struct drm_device *dev)
> > 1083 {
> > ...
> > 1088         if (!dev->mode_config.poll_enabled)
> > 1089                 return false;
> > 
> > 2. virtio_gpu_init() runs before drm_dev_register() and
> >    drm_client_setup(), so no DRM clients are registered yet.
> >    drm_kms_helper_hotplug_event() would iterate an empty client list.
> >    The initial hotplug is handled by drm_client_register(), which fires
> >    a hotplug callback to the newly registered client. By that time,
> >    display_info_cb has already updated the connector data.
> > 
> > For the same reason, drm_helper_hpd_irq_event() in
> > config_changed_work_func() was also a no-op. The actual runtime hotplug
> > notification was always delivered by display_info_cb's call to
> > drm_kms_helper_hotplug_event(). This patch replaces it with a direct
> > drm_kms_helper_hotplug_event() call after waiting for the display info
> > response.
> > ---
> > Changes in v2:
> > - Dropped the work_struct approach from v1.
> > - Instead, removed the hotplug calls from display_info_cb entirely, as
> > suggested by Dmitry.
> > - Added wait_event_timeout() in config_changed_work_func() so that the
> > display info response is received before sending the hotplug
> > notification.
> > - Replaced drm_helper_hpd_irq_event() with drm_kms_helper_hotplug_event()
> > in config_changed_work_func() since drm_helper_hpd_irq_event() is
> > always a no-op in virtio-gpu (poll_enabled is never set).
> > - No changes to virtio_gpu_init() — drm_client_register() already
> > handles the initial hotplug and hotplug event does nothing before DRM
> > device/client has been registered.
> > - Link to v1: https://lore.kernel.org/r/20260630-virtiogpu_syzbot-v1-1-0aa06630750e@redhat.com
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_kms.c | 5 ++++-
> >  drivers/gpu/drm/virtio/virtgpu_vq.c  | 3 ---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > index cfde9f573df6..b4329f28e976 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > @@ -49,7 +49,10 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
> >  				virtio_gpu_cmd_get_edids(vgdev);
> >  			virtio_gpu_cmd_get_display_info(vgdev);
> >  			virtio_gpu_notify(vgdev);
> > -			drm_helper_hpd_irq_event(vgdev->ddev);
> > +			wait_event_timeout(vgdev->resp_wq,
> > +					   !vgdev->display_info_pending,
> > +					   5 * HZ);
> > +			drm_kms_helper_hotplug_event(vgdev->ddev);
> >  		}
> >  		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
> >  	}
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> > index c8b9475a7472..e5e1af8b8e8a 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> > @@ -840,9 +840,6 @@ static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
> >  	vgdev->display_info_pending = false;
> >  	spin_unlock(&vgdev->display_info_lock);
> >  	wake_up(&vgdev->resp_wq);
> > -
> > -	if (!drm_helper_hpd_irq_event(vgdev->ddev))
> > -		drm_kms_helper_hotplug_event(vgdev->ddev);
> >  }
> >  
> >  static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device *vgdev,
> > 
> > ---
> > base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> > change-id: 20260619-virtiogpu_syzbot-bdab508ffcd5
> > 
> > Best regards,
> 
> Appled to misc-fixes, thanks!
> 
> -- 
> Best regards,
> Dmitry
