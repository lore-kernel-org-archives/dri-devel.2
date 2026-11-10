Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED2606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRRkD8Zr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E8510F7C7;
	Tue, 10 Nov 2026 15:49:46 +0000 (UTC)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0CD210F7C7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:49:40 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-677d35fd1d2so2620549d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:49:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794325779; cv=none;
 d=google.com; s=arc-20260327;
 b=NbQhRYYWwk6w70+GCN3zqh0VSRqu0QpobMRWGWsswk65uvJ74QwsNjYrxTMef7AJ7o
 4Gus6/3Cctg6Xz+1veZE0X27cfmYSjXnpm/0Ckgd8afxTqxb8ufMbsRQDRDTxs/O+8rs
 aoHUuP8Sse5sK4FgiP4L6KgnPUK8rgnK8Nf6Ouec45XtipKAZHSXcN8RZiQGdUaUd5iN
 SoL91VDYS/ft2nPA6uPumQ6Pw/LVgj/sjBH8W26j8C6xmER/9WadA9NyU7lDYyY8MqHS
 AmhkEjJMVvr6YPG2r5MOWIwEFgMfqwGkSp4yQlhV7GUi+wSKUOwgnjcViyJUMkJ4lpt1
 qNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RMoOmz54uXAGmyKpCDNKToNL+SRGzDUucQwa71Z0R60=;
 fh=ilLqXmjNRPIr55pJvOutiHz7t1Zv8JnNLtrTdWam73g=;
 b=MpQ/0oxXsxwGl15f3Zde8JJpskj5IorI8bbOS7sIedqD9ULwbrWiEehlHVSkDWnXze
 DW4lmb86E+b1lNn7zL30zJM6Kyja0i65qTVazty/Q5RjIMYiyeoiEvXjl7iE4ySHoq6P
 FDTAKQcakAZ49UYQbHxWcFagacNlkPhgGYz5Gw7KI3s+FSxPuZMLqBi+RoItD0ifpUlI
 bt6vmji0xLTaj2Dm0T6bgE1hQCY9wBl7+1+N2n5Cu4eSvhhU18ymVV/ih6oZ1vhO56cB
 c5D5JA14Dmc54N9oNpr5x7X/9p6fqH9eyGjqf6Gn2nvmnpW96HE0DOM5uw9+0rOsGwF/
 ZfgQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794325779; x=1794930579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RMoOmz54uXAGmyKpCDNKToNL+SRGzDUucQwa71Z0R60=;
 b=bRRkD8ZrTDGOW0fp9rd0g9AS6ijJBVX3c6E6+2t0o6WQ9COGCLY1aLkcz1aCg3X4mV
 pHsWFdJmuSYrUod2lmm/PYDARRCUy+h9mFqSHpTYKRQzg2yBGewMf7s8511EMCN1+g+X
 wzm/cghft2ydSKqtJ39/ddJWXbN41172/ZQXRzewPrZPynFrHE2b4F13gdIyHMjKG/Fb
 99wJpkLX7BmfsdRo5AyOedaFl4J2zwBLEdx041qgh9tjQ5cLCOtBR+c454Gsyy6lx1s3
 5VvC4UDxyL/OVw5A9ei7/5yZYPgePapSsikmzPvaO8vP+WSe68u6QTXuM2O7wNqVpVAF
 smFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794325779; x=1794930579;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RMoOmz54uXAGmyKpCDNKToNL+SRGzDUucQwa71Z0R60=;
 b=MfVJv0Q0wMsrgngBkV9c7HqAsyX1fs11k/wWht3UwubIPi9Tx1RhEN7939X1A2/dXN
 iJsQ07lhDGutF8gUBSsc5aUeaG/vtDMXqGShnW6zo0tXpNzNnC8jccpTRIEujN8jSo91
 LsdqK0smHuUygF6xi8a9QEa29DhywO9hluuB+SeKTnnUhp1ILQ1orKgvUi1yzGJJbTm4
 YkNZYW31N34b80Yyv/BHXcZQE0rZtuxWtS/D+mxgv08B0Hd3KLBRGiTsJsi36SQRGZqe
 /sKiQXscDhYf7S0V3eJsPClsihwXzDsP8Sw8DMW+dmGwhNTAepad0126hJ63MRipnPuK
 mHUg==
X-Gm-Message-State: APuU4Z/9dUUAlvv20vn6TecYdwOJiVcPN73fcJ1NZ4x4eA25LT5b4lsQ
 UdICoSAx11AiD1e9FKXF9H4pipVt76kbpQTM7Qa2cKtgrUoREyhZa+rTVoIKrFpDYYr8UHNNuU6
 bC+AmMI/QhMRGOagvpjPSTV37iqwDdhc=
X-Gm-Gg: AYBFou1XNVIeQQq5AaTfAaM+Wxcs5otVXLV2vsVbP3CTTxHVzT2px8pHFwIb3cVNYIR
 3jtdCCerxOUlsAeY3dChg+2fTRzaxaV6gnE+JpxbasaIMtdKwxKORmUziqR9eUTQYjLx5dnb1dP
 +ixZHiL8mlO+5l7Xuq1mGa0Yxza9fKwWZ/l5YpMFg+uyMypPwa/+vBzftkBvlHqXqjLP6f3HH2y
 Rq4Ud423j647Fwl0+ST/S/TYzRoKp7I4RYx6n4yJsDoV/BJz1Z06z+oPrhvAVpyiHBE/3I3wxZu
 alUDKfPUTMHSUT6k+Hd47XU72ewj9EaIeF91fjl9mR+EFDai4Yzcz1RQEB78H1H1e3INzK50Nkg
 3WlP7i7IFfWR2F4ayi5KSyRrdUg8XD6INFQ7V9WE4Eq4P7er8ArmOnmW6giccWm0dssNDKOE=
X-Received: by 2002:a05:690e:458a:10b0:676:9193:eff5 with SMTP id
 956f58d0204a3-67c5687bd84mr1066452d50.105.1794325779240; Tue, 10 Nov 2026
 07:49:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026112843.69795-1-hjf3108@gmail.com>
 <1b25256b-5fb5-4b4a-bc05-7a2bfc309128@suse.de>
In-Reply-To: <1b25256b-5fb5-4b4a-bc05-7a2bfc309128@suse.de>
From: Jie Feng <hjf3108@gmail.com>
Date: Tue, 10 Nov 2026 23:49:01 +0800
X-Gm-Features: AclHuK99KoaO0amqZ99e4i_PatGBNT7EbBDEpqRGGN2fwYSF_nWtWNy0RPwgtrY
Message-ID: <CABOQOSWGUmaR2wSso37rYgg0QoJL3K1qoDPqsp8OzOk_ifpgCw@mail.gmail.com>
Subject: Re: [PATCH v5] drm/tiny: trigger5: Add MCT Trigger 5 USB display
 driver
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, cyrozap@gmail.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 open list <linux-kernel@vger.kernel.org>
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 at 22:23, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:
>
> Hi,
>
> sorry for letting you wait for so long. You'll find a review below.
Thanks for the review! Since this driver shares many similarities
with the ms91xx driver I am submitting too, I will be making
the changes in that driver too.

> The driver looks quite good already. Details below.  To give one advice,
> I'd recommend to do away with the complicated transfer-worker logic and
> simply send everything as part of the plane update, if possible.
More details about this below.

> Am 26.10.26 um 12:28 schrieb Ho Jie Feng:
> > Add a DRM driver for MCT Trigger 5 USB display adapters.
> > This supports USB 3 to HDMI/VGA displays adapters with
> > trigger5 chipsets from j5create, StarTech and various others.
> >
> > The driver implements modesetting and USB framebuffer updates,
> > connector detection, and EDID retrieval.
> >
> > The protocol is based on reverse-engineering work by Forest Crossman
> > (cyrozap) at: https://github.com/cyrozap/mct-usb-display-adapter-re
> > and usb packet captures between the Windows driver and the device.
> >
> > Only the HDMI path has been tested. VGA selection is inferred from the
> > absence of USB audio interfaces.
> >
> > Tested on JUA355. The list of USB device IDs are taken from the
> > Windows driver INF.
> >
> > Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
> > ---
> > Changes in v5:
> > - Fix warnings found by kernel test robot
> >
> > Changes in v4:
> > - Move the driver to drm/tiny
> > - Remove the buffer resizing to reduce size of file
> >
> > Changes in v3:
> > - Flush the vmalloc buffer before submitting the USB transfer.
> > - Support display panning by using the source offset
> >
> > Changes in v2:
> > - Move the buffer resizing to crtc_* functions so that we can report
> >    out of memory errors to userspace
> > - Change the PLL search function so that it is faster and doesn't
> >    produce checkpatch warnings
> > - Update drm functions: crtc reset becomes create_state
> > - Fix warnings reported by kernel test robot
> >
> > sashiko review false positives in v1-4:
> > - atomic in these function names mean that the changes should go throug=
h
> >    through at once or not at all, nothing to do with atomic context.
> >    Furthermore other drivers also have similar patterns
>
> Exactly. Somehow Sashiko doesn't get this. It thinks atomic means
> "atomic context".
It's the old sashiko using the older gemini 3.5 model, the newer one
using gemimi-4-argon
doesn't seem to make the same mistake, so that's great.

> > - drm_gem_fb_begin_cpu_access is also required
> >
> >   MAINTAINERS                     |    7 +
> >   drivers/gpu/drm/tiny/Kconfig    |   14 +
> >   drivers/gpu/drm/tiny/Makefile   |    1 +
> >   drivers/gpu/drm/tiny/trigger5.c | 1115 ++++++++++++++++++++++++++++++=
+
> >   4 files changed, 1137 insertions(+)
> >   create mode 100644 drivers/gpu/drm/tiny/trigger5.c
> > ...
> > +struct trigger5_device {
> > +     struct drm_device drm;
> > +     struct usb_interface *intf;
> > +     unsigned int bulk_pipe;
> > +
> > +     struct drm_connector connector;
> > +     struct drm_plane plane;
> > +     struct drm_crtc crtc;
> > +     struct drm_encoder encoder;
> > +
> > +     u16 frame_counter;
> > +
> > +     int current_transfer;
> > +     struct drm_rect pending_rect;
> > +     struct workqueue_struct *transfer_wq;
>
> Do you really need your own queue?
>
> I'd recommend to push work on one of the system work queues.
Most of the time in the usb transfer is spent on waiting, I didn't feel lik=
e
blocking a system work queue on a mostly waiting task. Also, the failure pa=
th
can wait up to 5s, so I want the failure impact to be small on the rest
of the system.

> > +     bool display_enabled;
>
> This field only seems to control the dependency between transfer and
> keepalive.
It signals the keepalive worker to stop immediately if display is not enabl=
ed.
The keepalive is only launched with queue_delayed_work after a transfer.

> > ...
> > +#define to_trigger5(x) container_of(x, struct trigger5_device, drm)
>
> container_of_const() is nowadays the preferred macro.
> > ...
> > +     drm_dbg_kms(&trigger5->drm,
>
> Drivers should use drm_dbg()
>
> > ...
> > +     drm_err(&trigger5->drm, "failed to configure display mode: %d\n",=
 ret);
>
> No error messages in the display-update code paths please.  Maybe use
> drm_err_once().  Otherwise you might spam the kernel logs with endless
> error messages or give malicious user space a way to do that. Here and
> in other functions.
>
>
> > +     new_crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
>
> The pointer crtc can be NULL!  Then you cannot use it here. The pattern
> for this code is
>
>    new_crtc_state =3D NULL;
>
>    if (crtc)
>      new_crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc)
>
> The call to _check_plane_state() will then work correctly and make the
> plane as !visible.
The above changes will be made in v6 (and the ms91xx patch)

> > +static void trigger5_plane_atomic_update(struct drm_plane *plane,
> > +                                      struct drm_atomic_commit *atomic=
_state)
> > +{
> > +     struct drm_plane_state *old_state =3D
> > +             drm_atomic_get_old_plane_state(atomic_state, plane);
> > +     struct drm_plane_state *state =3D
> > +             drm_atomic_get_new_plane_state(atomic_state, plane);
> > +     struct drm_shadow_plane_state *shadow_plane_state =3D
> > +             to_drm_shadow_plane_state(state);
> > +     struct trigger5_device *trigger5 =3D to_trigger5(plane->dev);
> > +     struct trigger5_transfer *current_transfer, *previous_transfer;
> > +     struct trigger5_bulk_header *header;
> > +     struct drm_rect current_rect, src_rect;
> > +     struct iosys_map data_map;
> > +     size_t frame_len, payload_len;
> > +     int width, height;
> > +     int idx, ret;
> > +
> > +     if (!drm_atomic_helper_damage_merged(old_state, state, &current_r=
ect))
> > +             return;
> > +
> > +     if (!drm_dev_enter(plane->dev, &idx))
> > +             return;
> > +
> > +     current_transfer =3D
> > +             &trigger5->transfers[trigger5->current_transfer];
> > +     previous_transfer =3D &trigger5->transfers[1 - trigger5->current_=
transfer];
> > +
> > +     src_rect =3D drm_plane_state_src(state);
> > +
> > +     /* Match drm_atomic_helper_damage_iter_init() rounding. */
> > +     src_rect.x1 >>=3D 16;
> > +     src_rect.y1 >>=3D 16;
> > +     src_rect.x2 =3D (src_rect.x2 >> 16) + !!(src_rect.x2 & 0xffff);
> > +     src_rect.y2 =3D (src_rect.y2 >> 16) + !!(src_rect.y2 & 0xffff);
> > +
> > +     /* Latency reduction: requeue with the latest frame data. */
> > +     if (cancel_work(&previous_transfer->transfer_work)) {
> > +             complete(&previous_transfer->frame_complete);
>
> I would not recommend this logic.  For rapid successive updates, your
> driver might end up canceling transfers and not sending any data for
> extended periods.  Better take each frame on its own.
The only small window when that could happen is that it might keep
cancelling after the first frame finishing and before the next frame
queued work item runs.

It could be solved with triple-buffering, but the additional memory
footprint might be worth considering.
>
> > +
> > +             trigger5_merge_rect(&current_rect, &previous_transfer->tr=
ansfer_rect);
> > +
> > +             current_transfer =3D previous_transfer;
> > +             trigger5->current_transfer =3D !trigger5->current_transfe=
r;
> > +     }
> > +
> > +     /* Damage deferred by an earlier failed update. */
> > +     trigger5_merge_rect(&current_rect, &trigger5->pending_rect);
> > +     trigger5_clear_rect(&trigger5->pending_rect);
> > +
> > +     /* Clip merged damage to the new resolution. */
> > +     if (!drm_rect_intersect(&current_rect, &src_rect))
> > +             goto exit;
> > +
> > +     width =3D drm_rect_width(&current_rect);
> > +     height =3D drm_rect_height(&current_rect);
> > +     payload_len =3D array3_size(width, height, 3);
> > +     frame_len =3D size_add(payload_len, sizeof(*header));
> > +
> > +     if (drm_WARN_ON_ONCE(plane->dev, frame_len > current_transfer->bu=
f.len))
> > +             goto exit;
> > +
> > +     /*
> > +      * This should almost never wait because we have should have a
> > +      * pending transfer ready to be de-queued above in case the trans=
fer
> > +      * hasn't finished, but do a bounded wait just in case it gets st=
uck
> > +      */
> > +     if (!wait_for_completion_timeout(&current_transfer->frame_complet=
e,
> > +                                      msecs_to_jiffies(20)))
> > +             goto exit_save_pending;
> > +
> > +     current_transfer->transfer_rect =3D current_rect;
> > +
> > +     current_transfer->frame_len =3D frame_len;
> > +     header =3D current_transfer->buf.data;
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
> > +     header->flags =3D 0x1;
> > +     header->unknown1 =3D 0;
> > +     header->unknown2 =3D 0;
> > +     header->checksum =3D trigger5_bulk_header_checksum(header);
> > +
> > +     iosys_map_set_vaddr(&data_map,
> > +                         current_transfer->buf.data + sizeof(*header))=
;
> > +
> > +     ret =3D drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE);
> > +     if (ret < 0) {
> > +             complete(&current_transfer->frame_complete);
> > +             goto exit_save_pending;
> > +     }
> > +
> > +     drm_fb_xrgb8888_to_rgb888(&data_map, NULL,
> > +                               &shadow_plane_state->data[0],
> > +                               state->fb, &current_rect,
> > +                               &shadow_plane_state->fmtcnv_state);
> > +
> > +     drm_gem_fb_end_cpu_access(state->fb, DMA_FROM_DEVICE);
> > +
> > +     flush_kernel_vmap_range(current_transfer->buf.data, frame_len);
> > +
> > +     queue_work(trigger5->transfer_wq, &current_transfer->transfer_wor=
k);
> > +     trigger5->current_transfer =3D !trigger5->current_transfer;
>
> Why do you need a separate work item for the transfer. Can't you just
> send from here?  We do this in udl.
I want to make the send async, so drm_fb_xrgb8888_to_rgb888 can run
in parallel with the usb transfer. This is done since drm_fb_*_to_*
functions are slow when copying on write-combined memory due to
dma-buf sharing between the main GPU and this device.

udl does usb_submit_urb, which is async, but the usb_sg_wait has no async
counterpart, so I opted for putting it in a worker.

I saw there's a TODO within the format helpers for io memory, so
maybe in a future patch I could change it to use drm_memcpy_from_wc
to speed it up. Currently it couldn't run at full 1080p at 60fps on bare-me=
tal,
but on a VM it is fine due to not copying from WC memory.

There's also the other issue of some compositors calling _update
in the render loop or something that causes visible stutter when a device's
_update callback is slow.

The ideal way to solve this, with both low latency and low memory footprint
is to take inspiration from gm12u320 and store the fb and update rect in
the device struct, and let a worker obtain the latest one from the struct.
The transfer is then sent in blocks, while overlapping the drm copy
and usb transfer in parallel. I think this is a bit too much complexity
for a drm/tiny driver though.

> > +     goto exit;
> > +
> > +     /* Retry the dropped damage on the next update. */
> > +exit_save_pending:
> > +     trigger5->pending_rect =3D current_rect;
> > +exit:
> > +     drm_dev_exit(idx);
> > +}
> > +
> > +static const struct drm_mode_config_helper_funcs
> > +trigger5_mode_config_helper_funcs =3D {
> > +     .atomic_commit_tail =3D drm_atomic_helper_commit_tail_rpm,
>
> This helper will first switch on the CRTC and then update the plane.
> But there's a comment somewhere that says "Keepalive must only be sent
> after a frame has been sent". The keepalive message is started in CRTC
> enable before sending the frame, (right?)  Isn't that a contradiction?
CRTC enable only sets display_enabled, but the first keepalive will
only be launched in the transfer worker after the usb transfer finished.

> > +
> > +static const struct drm_plane_funcs trigger5_plane_funcs =3D {
> > +     .update_plane =3D drm_atomic_helper_update_plane,
> > +     .disable_plane =3D drm_atomic_helper_disable_plane,
> > +     .destroy =3D drm_plane_cleanup,
> > +     DRM_GEM_SHADOW_PLANE_FUNCS,
> > +};
>
> I suggest to put the plane code and _funcs before the CRTC code and _func=
s.
> > ...
> > +static int trigger5_connector_get_modes(struct drm_connector *connecto=
r)
> > +{
> > +     struct trigger5_device *trigger5 =3D to_trigger5(connector->dev);
> > +     const struct drm_edid *edid;
> > +     int count;
> > +
> > +     edid =3D drm_edid_read_custom(connector, trigger5_read_edid, trig=
ger5);
> > +     drm_edid_connector_update(connector, edid);
> > +     count =3D drm_edid_connector_add_modes(connector);
> > +     if (!count)
> > +             count =3D drm_add_modes_noedid(connector, 1920, 1200);
>
> Please don't call drm_add_modes_noedid().  DRM helpers will set up safe
> modes if no EDID could be found.  In you driver simply return he value
> of count and let the helpers do their job.
> > ...
> > +static const struct usb_device_id id_table[] =3D {
> > +     /* From Windows driver INF file */
>
> Please remove that comment.  It's likely to bit rot quickly.  Maybe
> mention it in the commit description, if you think it is important.
Will be implemented in v6.

> Best regards
> Thomas
>
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5800, 0) }, /* HDMI */
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5801, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5802, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5803, 0) },
> > +     { USB_DEVICE(0x0711, 0x5804) }, /* VGA */
> > +     { USB_DEVICE(0x0711, 0x5805) },
> > +     { USB_DEVICE(0x0711, 0x5806) },
> > +     { USB_DEVICE(0x0711, 0x5807) },
> > +     { USB_DEVICE(0x0711, 0x5808) },
> > +     { USB_DEVICE(0x0711, 0x5809) },
> > +     { USB_DEVICE(0x0711, 0x580A) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580B, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580C, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580D, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580E, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580F, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5810, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5811, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5812, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5813, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5814, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5815, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5816, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5817, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5818, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5819, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581A, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581B, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581C, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581D, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581E, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581F, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5820, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5821, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5822, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5823, 0) },
> > +     { USB_DEVICE(0x0711, 0x5824) },
> > +     { USB_DEVICE(0x0711, 0x5825) },
> > +     { USB_DEVICE(0x0711, 0x5826) },
> > +     { USB_DEVICE(0x0711, 0x5827) },
> > +     { USB_DEVICE(0x0711, 0x5828) },
> > +     { USB_DEVICE(0x0711, 0x5829) },
> > +     { USB_DEVICE(0x0711, 0x582A) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582B, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582C, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582D, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582E, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582F, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5830, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5831, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5832, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5833, 0) },
> > +     { USB_DEVICE(0x0711, 0x5834) },
> > +     { USB_DEVICE(0x0711, 0x5835) },
> > +     { USB_DEVICE(0x0711, 0x5836) },
> > +     { USB_DEVICE(0x0711, 0x5837) },
> > +     { USB_DEVICE(0x0711, 0x5838) },
> > +     { USB_DEVICE(0x0711, 0x5839) },
> > +     { USB_DEVICE(0x0711, 0x583A) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583B, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583C, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583D, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583E, 0) },
> > +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583F, 0) },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(usb, id_table);
> > +
> > +static struct usb_driver trigger5_driver =3D {
> > +     .name =3D DRIVER_NAME,
> > +     .probe =3D trigger5_usb_probe,
> > +     .disconnect =3D trigger5_usb_disconnect,
> > +     .suspend =3D trigger5_usb_suspend,
> > +     .resume =3D trigger5_usb_resume,
> > +     .reset_resume =3D trigger5_usb_resume,
> > +     .id_table =3D id_table,
> > +};
> > +module_usb_driver(trigger5_driver);
> > +MODULE_AUTHOR("Ho Jie Feng <hjf3108@gmail.com>");
> > +MODULE_DESCRIPTION(DRIVER_DESC);
> > +MODULE_LICENSE("GPL");
> >
> > base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG N=C3=BCrnbe=
rg)
>
>
