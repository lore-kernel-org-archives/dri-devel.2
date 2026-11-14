Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9A606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Be+ohPw0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6E210E686;
	Sat, 14 Nov 2026 09:06:24 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657F510E685
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 09:06:18 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-702fd86d674so2010739eaf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 01:06:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794647177; cv=none;
 d=google.com; s=arc-20260327;
 b=fVxBHpb7Z+ya5o5iyO3vcze/KzCrxNm/iNUIppzmFKcWJq6zjs6MKi5DORkG5lPmHI
 uV5MvOnvFBOPoVoQW22EsoeFAZcOFQylsbWzWmscoZUN4UpBWRNhmkVgSHfRY7fc/EI6
 XN78W9tctkjwVAeFK86Gb1YHwX0nZs+LZzO7zwu9tIlX79dDeVjB1TSbtviaNtgFmUsx
 naX2lQyyzQMdsrcKqoFFZzDGVUC7+d2KQ4eejhf0AyueRb2vAVcoGfo6G3RkP9SYLjrK
 0WTt31wWhNo53iBF3Jw5iNgIidWRljfZ8nJCzu5zusxbU+gV4B46cxrQkj5fXIhDQ6it
 BjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RZ5vy8RANYnca4hkXz3ab9aTAWuJWi2Fj9oMmb9Aj8s=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=JUk7Cd/qfRAFEdy4pVRHmZSpI2Vy69qBpXptfWPNFFswJMxy2bYhgiJu4Xqk4OgV5M
 bMG94xQZAPzckO/jh40wAm77LRY3s+30tML012BZYW8uYMuCKIvHRsVUkfglQYDU/yMH
 igF66wsFoeg+6ulBWSwkT9tl2DRdzUHhgHtQJ84ID9k/+3W+2pJmnySiPALysOgXxTLJ
 J+bA7s3TcoIIEWhnRs+awOKkTHqa58MPcCAUaYtdztyCipCZjLNImc0R7YbEKk/NzFe9
 KBehrF6LlUJ7mz+wZdiQrWJ3YYYi/Vcfr3FHx+UbjeiA6gP1PP8lYUG/sBIayBUoa2jy
 PcPw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794647177; x=1795251977; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RZ5vy8RANYnca4hkXz3ab9aTAWuJWi2Fj9oMmb9Aj8s=;
 b=Be+ohPw0Wc6z7wsK04gWXe25rIuv04TnNZ8oKgIVpd1kP6m1ZHg2QS0kcktN3Px7aU
 Ab54ZCAODcHsToPL2brkzotzCJ8cSYljxd+LzwZnwAEbR8TVEwM5v8tHcWQx8HeOoXoM
 gPimtkRT1p3ZWIVaiMFKu6At6b9I6IwvuyIVc4bwagIp6Cy9HE5BpX9bfV6tfMdOaShg
 3aKtFqDDv4S7oSfYryyRSw9Q4GLsPWI2nYKoc5yOQqDLWlvH0VvfpsH5DJpim8qZbIcD
 ivp7BQdJbdavhprLG+njiA37OObX8GoPlOvxA07dSvUu/j6pmnzu51hnuZCvkRTECfu8
 ULqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794647177; x=1795251977;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RZ5vy8RANYnca4hkXz3ab9aTAWuJWi2Fj9oMmb9Aj8s=;
 b=T0OLWZF/bjWpo2Cn5MsyZ6i4fZBNK7C/Yj9EgjPpC/hmRIalhYwuE0eEPctYWgMrEH
 uzhZMy2QpjGUFNLog0eciR+6Is7Sa+g03gywbYpVpuoxc65jxMCTkXzOw2ibuJB99ZNn
 hdMcPAyLcXCW+6bqMFCWK/Ac9GdEyjLGPwUCDENI8IVx7ObVXt2SyjOyGfS8qA7Ci+rC
 DHTq72ZTm6sfNRPKr9lVzuc7wOEuahiIqer2FBSSqXQYALN8fi5oZ3rSU3J41QwwaiV4
 I4ISr51u1hieTQcdZ5OvzzNJrZWHziwENp6N6fzSOdtCwQD4ms5UH8KAWM9UjLzWeiq3
 cA+w==
X-Gm-Message-State: APuU4Z/dcrIe1O5BYMXlwET5q8brPlVnLuyoiPfKcAMSUYVdTKtnKpOD
 1dCHmXKBBpHCLmMjxzuiYNzJzTljHp7vrAw77wrtZZhEkgAsOhRWGq/xp6AScsPPYpM9u1L9oSV
 gQzOiDxbqf2js8YP7KkIVALlvo6/R9bo=
X-Gm-Gg: AYBFou33xl005idYNDXwcuxm+/wKC38ld0z/i7FWqru7YdYYS5aT/P8QkjDNTNzYPst
 knWeSUEOshEUDhZN3PIpYNHV/cEIAfcu/r5FFCBlOsIDF6gXys2bQLzwCFZTEFtzmk77WYoT1Jf
 HWPPBB0PtkXdoLDEXYxJOrUhxu00snxiAryMzkx7csUY8TMuR9WtyQzZ2akzybGaTYbYrEudoAe
 04lep+qr8a6l1UsBGOyqhMvri4Egx4r5ajJ4zxkhWgx7MoHa7d1DozDkVwe60aPpnSTG7eSk3PN
 kuhMwG1PR/Hn+080bgw+3WjWI73stalHrH3ITUYonfa2mtUxz5VMxqq8H9nO+q42VA9Xv5HeMG+
 i/djZPZUjdpcaAucTZWYj8qk8twouCaoxCU1pY2T+MrTsGHjndw+HK8UfpgdAVerMzeyKAk6kKj
 JaXuh2sfF3501Hi9c3fmIdVzhlD/J5wm4=
X-Received: by 2002:a05:6820:16a4:b0:71a:d76b:fb33 with SMTP id
 006d021491bc7-71ad76c01c4mr437690eaf.8.1794647177240; Sat, 14 Nov 2026
 01:06:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112154520.151617-1-hjf3108@gmail.com>
 <sashiko-outbox-211483@kernel.org>
In-Reply-To: <sashiko-outbox-211483@kernel.org>
From: Jie Feng <hjf3108@gmail.com>
Date: Sat, 14 Nov 2026 17:05:40 +0800
X-Gm-Features: AclHuK-fxtZtzSrYZq5Ia8tIP8l0GJcIV9BNm0D0_BtKMQe6yD4RSHnGlCq51Fc
Message-ID: <CABOQOSXbR9mOgpK5JGfnDHN9rbH8JFiYiqyBahw13nLFX7OzAA@mail.gmail.com>
Subject: Re: [PATCH v6] drm/tiny: trigger5: Add MCT Trigger 5 USB display
 driver
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 at 00:15, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] drm/tiny: trigger5: broken USB reset lifecycle in
>   trigger5_reset()
> - [Medium] drm/tiny: trigger5: unclipped src_rect in
>   trigger5_plane_atomic_update()
> - [Medium] drm/tiny: trigger5: bulk stream desync on mid-frame
>   trigger5_submit_urb() error
> --
>
> commit efc535dee28f1fcc3c108a02e819d423382ef63b
> Author: Ho Jie Feng <hjf3108@gmail.com>
>
> drm/tiny: trigger5: Add MCT Trigger 5 USB display driver
>
> This commit adds a DRM driver for MCT Trigger 5 USB 3 to HDMI/VGA display
> adapters, implementing modesetting, EDID retrieval, and bulk URB frame
> updates.
>
> > diff --git a/drivers/gpu/drm/tiny/trigger5.c b/drivers/gpu/drm/tiny/tri=
gger5.c
> > new file mode 100644
> > index 0000000000000..46fa6e6babe9c
> > --- /dev/null
> > +++ b/drivers/gpu/drm/tiny/trigger5.c
>
> [ ... ]
>
> > +static void trigger5_reset(struct trigger5_device *trigger5, int err)
> > +{
> > +     if (!atomic_xchg(&trigger5->needs_reset, 1))
> > +             usb_queue_reset_device(trigger5->intf);
> > +
> > +     drm_err(&trigger5->drm, "USB transfer failed: %d, resetting adapt=
er\n",
> > +             err);
> > +}
> > +
> > +static void trigger5_urb_complete(struct urb *urb)
> > +{
> > +     struct trigger5_transfer *transfer =3D urb->context;
> > +     struct trigger5_device *trigger5 =3D transfer->trigger5;
> > +
> > +     switch (urb->status) {
> > +     case -ENOENT:
> > +     case -ECONNRESET:
> > +     case -ESHUTDOWN:
> > +             break;
> > +     case 0:
> > +             if (urb->actual_length =3D=3D urb->transfer_buffer_length=
)
> > +                     break;
> > +             fallthrough;
> > +     default:
> > +             trigger5_reset(trigger5, urb->status);
> > +             break;
> > +     }
> > +
> > +     complete(&transfer->done);
> > +}
> > +
> > +static struct trigger5_transfer *
> > +trigger5_get_next_urb(struct trigger5_device *trigger5)
> > +{
> > +     struct trigger5_transfer *transfer =3D
> > +             &trigger5->transfers[trigger5->next_transfer];
> > +
> > +     if (atomic_read(&trigger5->needs_reset))
> > +             return ERR_PTR(-EIO);
> > +
> > +     if (!wait_for_completion_timeout(&transfer->done,
> > +                                      msecs_to_jiffies(TRIGGER5_BULK_T=
IMEOUT_MS))) {
> > +             trigger5_reset(trigger5, -ETIMEDOUT);
> > +             return ERR_PTR(-ETIMEDOUT);
> > +     }
> > +
> > +     trigger5->next_transfer =3D
> > +             (trigger5->next_transfer + 1) % TRIGGER5_NUM_URBS;
> > +
> > +     return transfer;
> > +}
>
> [Severity: High]
> Does trigger5_reset() cause the active DRM device to be permanently
> unplugged or stuck returning -EIO after any USB transfer failure?
Don't know. In any case, assuming the device isn't faulty, a user replug
should recover it.

> trigger5_driver does not define .pre_reset and .post_reset callbacks
> (.reset_resume is only used when resuming a suspended device), so
> usb_reset_device() falls back to usb_forced_unbind_intf(), which runs
> trigger5_usb_disconnect() -> drm_dev_unplug() and kills the active DRM
> device instead of resetting the adapter in place.
This is intentionally kept simple for the first revision to be upstreamed.
A reset is simple to implement and correctly recovers the device in my test=
s.

> In addition, nothing in the driver ever clears trigger5->needs_reset once
> trigger5_reset() sets it to 1, so if the queued reset does not unbind the
> device (for example if usb_lock_device_for_reset() fails or after a
> reset_resume), trigger5_get_next_urb() rejects all future display updates
> with -EIO.
The only reason it fails should be that the device is unplugged, so the poi=
nt
about reset failing is moot here.

> Two smaller issues in this path: trigger5_get_next_urb() only checks
> trigger5->needs_reset before wait_for_completion_timeout(), so if the URB
> being waited on completes with an error it still returns the transfer to
> the caller; and on a short transfer in trigger5_urb_complete(), falling
> through from case 0 passes urb->status (0) to trigger5_reset().
This passes at most one more URB to a failing device?

trigger5_reset is only put in there in case the dongle fails. However, I ha=
ve
never observed it to fail in that way, apart from intentionally introducing
some fault condition such as putting a keepalive in the middle of the frame=
.
Since in this v6, keepalive is disarmed and never sent, it will not happen.

This reset seems to be the most reliable way to recover from something
wrong from my experiments. I do not know enough about the behaviour
when hardware is faulty or some weird condition appears enough to
say that it works in *all* conditions.

> [ ... ]
>
> > +static void trigger5_plane_atomic_update(struct drm_plane *plane,
> > +                                      struct drm_atomic_commit *atomic=
_state)
> > +{
>
> [ ... ]
>
> > +     src_rect =3D drm_plane_state_src(state);
> > +
> > +     /* Match drm_atomic_helper_damage_iter_init() rounding. */
> > +     src_rect.x1 >>=3D 16;
> > +     src_rect.y1 >>=3D 16;
> > +     src_rect.x2 =3D (src_rect.x2 >> 16) + !!(src_rect.x2 & 0xffff);
> > +     src_rect.y2 =3D (src_rect.y2 >> 16) + !!(src_rect.y2 & 0xffff);
> > +
> > +     /* Clip merged damage to the new resolution. */
> > +     if (!drm_rect_intersect(&current_rect, &src_rect))
> > +             goto exit;
> > +
> > +     width =3D drm_rect_width(&current_rect);
> > +     height =3D drm_rect_height(&current_rect);
> > +     payload_len =3D array3_size(width, height, 3);
> > +     lines_per_urb =3D TRIGGER5_URB_BUF_SIZE / (width * 3);
> > +
> > +     if (drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE) < 0)
> > +             goto exit;
> > +
> > +     transfer =3D trigger5_get_next_urb(trigger5);
> > +     if (IS_ERR(transfer))
> > +             goto exit_end_cpu_access;
> > +
> > +     header =3D transfer->urb->transfer_buffer;
> > +     header->magic =3D 0xfb;
> > +     header->length =3D 0x14;
> > +     /* flags 0: uncompressed 24-bit RGB888. */
> > +     header->counter =3D
> > +             cpu_to_le16((trigger5->frame_counter++) & 0xfff);
> > +     header->horizontal_offset =3D cpu_to_le16(current_rect.x1 - src_r=
ect.x1);
> > +     header->vertical_offset =3D cpu_to_le16(current_rect.y1 - src_rec=
t.y1);
> > +     header->width =3D cpu_to_le16(width);
> > +     header->height =3D cpu_to_le16(height);
> > +     header->payload_length =3D cpu_to_le32((u32)payload_len);
>
> [Severity: Medium]
> Should src_rect come from the clipped state->src (via
> drm_rect_fp_to_int(&src_rect, &state->src)) rather than the unclipped
> drm_plane_state_src(state)?
>
> In trigger5_plane_atomic_check(), drm_atomic_helper_check_plane_state()
> clips state->dst to the active CRTC mode and stores the visible source
> rectangle in state->src, while leaving state->src_x/y/w/h unclipped.
> Because drm_atomic_helper_damage_iter_init() also initializes its plane_s=
rc
> from the unclipped drm_plane_state_src(state), intersecting current_rect
> with drm_plane_state_src(state) here does not clip damage to the active
> CRTC mode when a larger framebuffer (up to 8191x8191) is panned with
> negative crtc_x/crtc_y, and outward rounding of fractional 16.16 src
> coordinates expands src_rect by an extra pixel.  This computes
> horizontal_offset and vertical_offset relative to the off-screen origin a=
nd
> can send frame dimensions and payload_length exceeding the active display
> mode and TRIGGER5_MAX_FRAME_SIZE.
Real bug, but unlikely there are weird userspace DRM users weird
enough to hit this bug.

> > +     header->flags =3D 0x1;
> > +     header->unknown1 =3D 0;
> > +     header->unknown2 =3D 0;
> > +     header->checksum =3D trigger5_bulk_header_checksum(header);
> > +
> > +     if (trigger5_submit_urb(transfer, sizeof(*header)))
> > +             goto exit_end_cpu_access;
> > +
> > +     clip =3D current_rect;
> > +     for (y =3D current_rect.y1; y < current_rect.y2; y +=3D lines_per=
_urb) {
> > +             clip.y1 =3D y;
> > +             clip.y2 =3D min(y + lines_per_urb, current_rect.y2);
> > +
> > +             transfer =3D trigger5_get_next_urb(trigger5);
> > +             if (IS_ERR(transfer))
> > +                     break;
> > +
> > +             iosys_map_set_vaddr(&data_map, transfer->urb->transfer_bu=
ffer);
> > +             drm_fb_xrgb8888_to_rgb888(&data_map, NULL,
> > +                                       &shadow_plane_state->data[0],
> > +                                       state->fb, &clip,
> > +                                       &shadow_plane_state->fmtcnv_sta=
te);
> > +
> > +             if (trigger5_submit_urb(transfer,
> > +                                     width * 3 * drm_rect_height(&clip=
)))
> > +                     break;
> > +     }
>
> [Severity: Medium]
> Does breaking out of this loop when trigger5_submit_urb() fails leave the
> adapter's bulk stream out of sync?
>
> At that point the 20-byte trigger5_bulk_header URB declaring
> header->payload_length bytes has already been submitted, and unlike
> trigger5_urb_complete() or trigger5_get_next_urb(), trigger5_submit_urb()
> does not call trigger5_reset() on usb_submit_urb() failure.  The device
> will keep waiting for the remaining bytes of the aborted frame and treat
> subsequent frame headers and pixel data as part of the old payload.
Known bug, however, on submit urb failure it should queue a reset.
I am not sure what is the best way to recover the device
beyond queuing a reset, since further URB submissions to pad the
frame to its entirety might fail too.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112154520.15=
1617-1-hjf3108@gmail.com?part=3D1
