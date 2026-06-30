Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB70AC43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 02:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD91210E0BB;
	Tue, 30 Jun 2026 02:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LteF3WaG";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB4810E0BB
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 02:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782786001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=/+IkZtkzMHEzg0Z4x19MkrqgJxXPziUidkv9USyQPLo=;
 b=LteF3WaGqWUatAGbnkR9f2PhR69/Tdy0OcFe+Ezc61zxpLxr7YZWWj92ZtxJ4sHLG8+CFD
 WD4jMP0IXUs6KheOYE+kg5YqHMSUKFsXRf2jO7WLjkcgCvb3I+HYzOfwd5KnbzvDz0SF1F
 MN2udwRXuCoUOHGA0OVXHgRSt4wTAcg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-YnzFqFFCM1SodlpYwyma1Q-1; Mon, 29 Jun 2026 22:20:00 -0400
X-MC-Unique: YnzFqFFCM1SodlpYwyma1Q-1
X-Mimecast-MFC-AGG-ID: YnzFqFFCM1SodlpYwyma1Q_1782785999
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37fe90ee192so1798555a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 19:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782785999; x=1783390799;
 h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+nO4d7n+wfa7aWWUlTpTbf1duWXspC4mIfSDeygT6Pw=;
 b=DzfZQlGGNDSIUfGpLhaG8UslC9vS57i7ltqAvwWB56zxMI+vgc4L8aGR7FJjTdWhfY
 jPSkE84fBz7zvVb5lI+3Ap3W0QweMFhBiBk38HFUJGT+bv6UhqTavV64eLjHE94CCj8D
 aHef4O9/K2DHjZsRNPlqAKcQFPypAxXjdIi4iD5KzG6IN4prYbTrvIjPtuutvQM2M7Ke
 QJSzuT6jAPiBWgTMmyUbz2c3U4Uh70sN0ec7vn0qG5B0TK1bHnghw1Jn+XQdw343XKON
 18y7Q4t13khMxaLZU/ohSebCe3M3fhcOayCxNQcTZ5TNLo3Ls532WukTW/Q8G4R+FGQ8
 bJLA==
X-Gm-Message-State: AOJu0Yy9gyIiz+DdAcIwUEOmo7rED1NHx64gxwokKe+DH1A28q/nyXZf
 bUOlAOEWijYWDJfZnMXSBZ01Au6TGMXua/KqzVuVctEC9UeVdYN5CKh2NWQfBc8NRuNndy6xvKS
 jkfExToHbCLmZMlY4Qz6MV5rif/iQQCEvSu4UTrImvxYIbxB2r/KdDG5laCze7MkwrCuIkA==
X-Gm-Gg: AfdE7ckTv7+gh0b3c92X8eUGaZEIyyTa/O/d5f3SRW1iRaMJkRXqOPNiCWgUqVMyaTe
 oA4oxPRUop/5yB/eJwsMPUNPxoNi+68lNm4omzXCnP0uLg+GTKyndUdqAGg7G+PSIGjq+4PnoBe
 1SbrzekiVWaTXa1NXRw0AEpgwzbWJzemhOXUenZ3JdFoTFnC0mIc0hxO5z6ig6uHBXoaPR9qCiA
 VHZVWCNcZ2etQoYfEB3B+p9HLHSIDbSN3FcVsWzNVLip/8X/lbRvcqc8fI69QlY2TG5DIjXG0rj
 wxABYbGN8r/ThUjCZ3BasCs1mfVhWt639P6jP0E0R01Q9Ah8X1kk4jZkGjxjngH53qBjXzuDIzb
 lM+vy1LhRmLSUWlJUi3t9p5h2CSoEXPlCiGxlQUtX9C/kKPdP
X-Received: by 2002:a17:90b:1d4c:b0:37f:db06:229c with SMTP id
 98e67ed59e1d1-380527a8520mr1210989a91.22.1782785998827; 
 Mon, 29 Jun 2026 19:19:58 -0700 (PDT)
X-Received: by 2002:a17:90b:1d4c:b0:37f:db06:229c with SMTP id
 98e67ed59e1d1-380527a8520mr1210975a91.22.1782785998249; 
 Mon, 29 Jun 2026 19:19:58 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38053466339sm638536a91.17.2026.06.29.19.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 19:19:57 -0700 (PDT)
MIME-Version: 1.0
From: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, 
 "David Airlie" <airlied@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>, 
 "Gurchetan Singh" <gurchetansingh@chromium.org>, 
 "Chia-I Wu" <olvaffe@gmail.com>, 
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
 "Maxime Ripard" <mripard@kernel.org>, 
 "Thomas Zimmermann" <tzimmermann@suse.de>, 
 "Simona Vetter" <simona@ffwll.ch>
In-Reply-To: <111d0a7c-60d3-4451-b214-510c98229883@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: warn when virtqueue has no free space for too
 long
Message-ID: <18bdba6a164502b6.9b78b394f2248cc2.16898dc04d9eb039@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Tue, 30 Jun 2026 02:19:52 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PTyhTIaQRSd8n4-Rut73lTcGWcAPKZAOvAyItFGGad4_1782785999
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
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



On 29/06/2026 15:11, Dmitry Osipenko wrote:
> Hi,
>=20
> On 6/18/26 10:18, Ryosuke Yasuoka wrote:
>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() wait for
>> virtqueue space using wait_event() with vqs_released as the only abort
>> condition. This covers the device removal path, where
>> virtio_gpu_release_vqs() sets the flag, but does not help when the host
>> simply stops processing the virtqueue while the device remains present.
>>=20
>> In that case, the virtqueue fills up and subsequent command submissions
>> block indefinitely in D state with no diagnostic output, making the root
>> cause difficult to identify.
>>=20
>> Replace the bare wait_event() with a wait_event_timeout() loop that
>> prints a warning every 5 seconds while the virtqueue remains full. The
>> wait still blocks indefinitely so driver behavior is unchanged. The
>> warnings help identify an unresponsive host device during
>> troubleshooting.
>>=20
>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> ---
>> When the host stops processing the virtio-gpu virtqueue without
>> triggering device removal, the bare wait_event() in
>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() blocks
>> indefinitely with no diagnostic output. A DRM atomic commit worker
>> blocks in virtio_gpu_queue_fenced_ctrl_buffer() while holding the
>> modeset lock. During graceful shutdown, systemd (PID 1) needs the same
>> lock =E2=80=94 either by writing to the console via fbcon, or by closing=
 a DRM
>> file descriptor that triggers framebuffer cleanup =E2=80=94 and blocks a=
s well,
>> making the VM unrecoverable without a forced power-off.
>>=20
>>   PID: 553    COMMAND: "kworker/u4:3"
>>    #0 __schedule
>>    #1 schedule
>>    #2 virtio_gpu_queue_fenced_ctrl_buffer [virtio_gpu]
>>    #3 virtio_gpu_primary_plane_update [virtio_gpu]
>>    ...
>>=20
>>   PID: 1      COMMAND: "systemd"  (console write path)
>>    #0 __schedule
>>    #1 schedule
>>    #2 schedule_preempt_disabled
>>    #3 __ww_mutex_lock
>>    #4 drm_modeset_lock [drm]
>>    #5 drm_atomic_get_plane_state [drm]
>>    #6 drm_client_modeset_commit_atomic [drm]
>>    #7 drm_client_modeset_commit_locked [drm]
>>    #8 drm_fb_helper_pan_display [drm_kms_helper]
>>    #9 fb_pan_display
>>   #10 bit_update_start
>>   #11 fbcon_switch
>>   #12 redraw_screen
>>    ...
>>=20
>> Reproduction steps:
>> 1. Build QEMU with the fault injection patch [1] that adds an
>>    x-ctrl-queue-broken property to virtio-gpu.
>> 2. Boot the VM and trigger the fault injection from the host.
>> 3. Fill the ctrlq (e.g., move the mouse on the guest's display).
>>    The process gets stuck in virtio_gpu_queue_fenced_ctrl_buffer()
>>    in D state.
>> 4. Run a graceful shutdown command (shutdown now or reboot).
>> 5. The shutdown process hangs.
>>=20
>> My earlier patch a46991b334f6 ("drm/virtio: abort virtqueue wait on
>> device removal to avoid hung task") covers the case where the shutdown
>> process reaches the device_shutdown() call path, which sets vqs_released
>> to unblock the wait. However, during graceful shutdown, systemd (PID 1)
>> gets stuck on the modeset lock before ever reaching device_shutdown(),
>> so vqs_released is never set and the wait is never unblocked.
>>=20
>> I initially considered adding a module parameter to abort the wait with
>> -ENODEV on timeout:
>>=20
>>   +static unsigned int virtio_gpu_vq_timeout;
>>   +MODULE_PARM_DESC(vq_timeout,
>>   +     "Timeout in seconds for virtqueue wait (0 =3D no timeout, defaul=
t)");
>>   +module_param_named(vq_timeout, virtio_gpu_vq_timeout, uint, 0444);
>>   ...
>>   +             if (virtio_gpu_vq_timeout) {
>>   +                     if (!wait_event_timeout(vgdev->ctrlq.ack_queue,
>>   +                                             vq->num_free >=3D elemcn=
t ||
>>   +                                             vgdev->vqs_released,
>>   +                                             secs_to_jiffies(virtio_g=
pu_vq_timeout))) {
>>   +                             if (fence && vbuf->objs)
>>   +                                     virtio_gpu_array_unlock_resv(vbu=
f->objs);
>>   +                             free_vbuf(vgdev, vbuf);
>>   +                             drm_dev_exit(idx);
>>   +                             return -ENODEV;
>>   +                     }
>>   +             } else {
>>   +                     wait_event(vgdev->ctrlq.ack_queue,
>>   +                                vq->num_free >=3D elemcnt ||
>>   +                                vgdev->vqs_released);
>>   +             }
>>=20
>> This approach aborts the wait and allows the graceful shutdown process
>> to eventually proceed, albeit with a delay.
>>=20
>> But that approach has drawbacks: it allows users to set arbitrarily
>> short timeouts that could destabilize the driver, and aborting commands
>> mid-flight is a rough recovery path. An unconditional timeout was also
>> discussed previously [2] but is not appropriate without virtio
>> specification support.
>>=20
>> This patch takes a safer approach: replace the bare wait_event() with
>> wait_event_timeout() and print a warning every 5 seconds while the
>> virtqueue remains full. The wait still blocks indefinitely and no
>> commands are aborted, so driver behavior is unchanged. The warnings
>> help identify an unresponsive host device during troubleshooting.
>> Once the user notices the warning, they can work around the hang by
>> unbinding the VT from fbcon, removing the device, or forcing a shutdown
>> via SysRq.
>>=20
>> [1] https://gist.github.com/YsuOS/fbcd181752594af35f954953a1d260b8
>> [2] https://lore.kernel.org/all/8a986c52-964f-42a5-b063-fbe2b242ca36@col=
labora.com/
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_vq.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virti=
o/virtgpu_vq.c
>> index 68d097ad9d1d..a546130d3b6a 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> @@ -410,8 +410,13 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_=
gpu_device *vgdev,
>>  =09if (vq->num_free < elemcnt) {
>>  =09=09spin_unlock(&vgdev->ctrlq.qlock);
>>  =09=09virtio_gpu_notify(vgdev);
>> -=09=09wait_event(vgdev->ctrlq.ack_queue,
>> -=09=09=09   vq->num_free >=3D elemcnt || vgdev->vqs_released);
>> +=09=09while (!wait_event_timeout(vgdev->ctrlq.ack_queue,
>> +=09=09=09=09=09   vq->num_free >=3D elemcnt ||
>> +=09=09=09=09=09   vgdev->vqs_released,
>> +=09=09=09=09=09   5 * HZ) && !vgdev->vqs_released)
>> +=09=09=09DRM_WARN("ctrlq waiting for host: no free space for %d secs\n"=
,
>> +=09=09=09=09 5);
>> +
>>  =09=09/*
>>  =09=09 * Set by virtio_gpu_release_vqs() to unblock
>>  =09=09 * synchronize_srcu() wait in drm_dev_unplug().
>> @@ -592,8 +597,13 @@ static void virtio_gpu_queue_cursor(struct virtio_g=
pu_device *vgdev,
>>  =09ret =3D virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>>  =09if (ret =3D=3D -ENOSPC) {
>>  =09=09spin_unlock(&vgdev->cursorq.qlock);
>> -=09=09wait_event(vgdev->cursorq.ack_queue,
>> -=09=09=09   vq->num_free >=3D outcnt || vgdev->vqs_released);
>> +=09=09while (!wait_event_timeout(vgdev->cursorq.ack_queue,
>> +=09=09=09=09=09   vq->num_free >=3D outcnt ||
>> +=09=09=09=09=09   vgdev->vqs_released,
>> +=09=09=09=09=09   5 * HZ) && !vgdev->vqs_released)
>> +=09=09=09DRM_WARN("cursorq waiting for host: no free space for %d secs\=
n",
>> +=09=09=09=09 5);
>> +
>>  =09=09/* See comment in virtio_gpu_queue_ctrl_sgs(). */
>>  =09=09if (vgdev->vqs_released) {
>>  =09=09=09free_vbuf(vgdev, vbuf);
>=20
> The [1] has a valid point about the hangcheck warning. Is
> wait_event_timeout() worth the change then?
>=20
> [1]
> https://sashiko.dev/#/patchset/20260618-virtiogpu_add_timeout-v1-1-dc36ce=
f609d9%40redhat.com

Thanks for pointing this out.

You're right =E2=80=94 the wait_event_timeout() loop wakes the task every
5 seconds, resetting the context switch counter each time, so
khungtaskd will never detect these tasks as hung.

I originally thought the earlier, virtio-specific warning would be
more useful for troubleshooting than the generic hung task output.
But reconsidering, the practical workflow for the user doesn't
really change either way: the device gets stuck, the user sees a
diagnostic message =E2=80=94 whether that's the hung task warning or my
proposed DRM_WARN =E2=80=94 and then manually intervenes with SysRq or a
forced shutdown.

The difference is what diagnostic information is available. The
hung task warning includes a full stack trace pointing directly at
the virtqueue wait, which is more useful for identifying the root
cause than a short warning line. Suppressing that by resetting the
context switch counter every 5 seconds makes the diagnostics
strictly worse.

More fundamentally, the guest can't recover from this situation
regardless =E2=80=94 the root cause is an unresponsive host, and the fix
has to happen on the host side. The existing wait_event() with the
kernel's built-in hung task detection is the better behavior here.

I'll drop this patch.

Best regards,
Ryosuke

