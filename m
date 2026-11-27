Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D684606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0BEA2oG5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F54A10E499;
	Fri, 27 Nov 2026 17:58:02 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6090C10E499
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 17:57:56 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-85ac281604dso4182569a34.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:57:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795802275; cv=none;
 d=google.com; s=arc-20260327;
 b=VUNdMwG/rT/6yI3P1kBPaYcocGQVOqgyS0xUMjFXL+vnZKypmzYNhrXwXA8797tZDm
 +ZIWIw9k2W+fDBzhg8MUjzlVZxid+I8UUxFTBmBngQs6sn9u4WSf98gLXv1Wa970A/ab
 6me/GJTVe1N+3Mc0rOsGSSRE2sI4PsLbWydwHx9j5sxX7EXDKqGmGhBV5//ubaBGRbUS
 mA7FQGOJ+i1FzZHSTh3VwG6isn16p8Xi4NmHi3qavkz4tOxkfqgBuN3WjZBG5vt+ba5y
 j6dwCw8rG2G1HBhh8DHTJYZ7jeeFkwFfytdwE9e4+Fkg3UteZaDohb/oqkrdo2V9xjIS
 d6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r89bi3N8igRjPKtxY0/AYTvIwguFglFSkm5fyq/4TZ4=;
 fh=ilLqXmjNRPIr55pJvOutiHz7t1Zv8JnNLtrTdWam73g=;
 b=oTf2y7WEdHvVafeSHFVECFq2au8JR+BFGAgSuP0AK2AYRUNUHWH2/4WfJvXnVPRn+u
 pW/O4YpS2yyEb9ckoo1EG5ZHV+jHhCMud4pAuOZuFPT4nABlcL7FGza94X9snedI+ifK
 NXcx/rcj2c6GJSWZKEgs1S7J5/C/KoToDyepGAfQIV5Cpy7Zw1QpMVMPEF1IyrVTzMdE
 PisB4yKptb8AowFBcvkak9pa8aNvEmpUiojjB4jO43x8jVBdn3yX0XmFVbGf1mLd5I5/
 xSJLOcmW+dGYLsScjHnOcFoc6aTuAQ9XXy2sO1xMCBAgjBLcDl9ImUdLdRWVosujcPUC
 O3Ag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795802275; x=1796407075; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r89bi3N8igRjPKtxY0/AYTvIwguFglFSkm5fyq/4TZ4=;
 b=0BEA2oG5fNn6W+uNKHMGW1DL+bpf14UkLJidVpab1rcqMpp/gIzShXx0du8wluMux0
 zyQkOeh2kajQUFjw7XMWvU2AmqfpFOChYBWroF1iS+5GQ928vtGq0J85fWWWJvuqdqwJ
 /e9tLbg0zfszwtXbPsEg5+nkLTJ/C/8bb7mWws7SpX52R5oLQDKzOP+E32of/yHCGNZY
 jBvVC4JWt7UDrtVNtRV1UeRsBniQ4VihOOUI4vZ1auxBMj39DgrwAMNOUlncm92GbocB
 k+esXGkX0sxMG6SfkchR7nqSTCenfG+oLxwBbydneaqFEb3GA6y28GFIkqqR63aKoh7E
 PHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795802275; x=1796407075;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r89bi3N8igRjPKtxY0/AYTvIwguFglFSkm5fyq/4TZ4=;
 b=x26ljWY6ediSeL8v9ISPFAM57uuxQAdW2spZi4RhHVViCGURb4yNC62l7EoIb+pxlC
 INPuCoYHMuQnSG1wVRGcRcf2ttn7f/uK8fh2+EE+TKAOySbtMhOV+VGOJSpoUBnEUo1H
 BmbD794AvMWV1EYApSpu4l0Dsb48JgxBSDj3F0VZp4wusOUPmy5C0uUaEEzQDSKefteK
 oIcRR7Mw5mfjbCnHK5WpbC2MC2+vsX2njMcw+W4ysMHqhFJPWZ3Cp8kzX7Bhy6P7C+3d
 gs9RczIIDl2l5xx0elLpnytQNceUi/91WPm0FdTgMJqeH8OAQ8wvq0PBDbnmwP8KR/Js
 NARw==
X-Gm-Message-State: APuU4Z8Y2TiNDFFv0JNyGqJNjCh+Uil3ZfVVahhpppk3L+fCgL7uNjSA
 AeS3jpgY4eFctSyBhx07o4FxVkTIuFqfX06YMHXg3tJLGhTbWKmQGzitXlTaObDFmFjWKuDrmAm
 U25XqphVmkleyBhvChTB1t/bplb8eWUc=
X-Gm-Gg: AZFdTZd+O203CzZfjWHgp89KPrHBgetIy24gScF80ulDYsllfQ75R2iM6b3erxYoQwh
 2TwNzNkWuXpWK5a8c1ykyUSGovZYd9TWttXukc6A3bCL1lW0PkzHJ/Rk40yRwRQIs5xNqblAVds
 sfjYyy6kK0lJGr8zpBx7vOQsznYhmUTKow29AURiLOpN4Mb6o6rQQTgYozn069cGGnYmvMKedmp
 pgsV0v4rE2FECdNKQX4bNsrIIdzH8+BPSVZmED08AjYeMlDdB9a6iKBNK1FboRUtMeBXngqK9cw
 lCeM/utiIWWwWv2V27fSEXz70Qsd2NXpYAOq3CC9SNU8xM3BpeRz8EJlWrYCc0beBTBzbGmukrY
 EDigr1D+zPKgYgT5ovGbTCDUGvusVYAvzLJFHtwAdMlZBnThFrcq3uTkh6RIIv32I/FC+rj31Yt
 QY2g4o48p7XlcUKfU1OkXQqNlyLr4xbMg=
X-Received: by 2002:a05:6830:4c18:b0:824:e29:e00e with SMTP id
 46e09a7af769-863159c069fmr25712859a34.20.1795802275351; Fri, 27 Nov 2026
 09:57:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112154520.151617-1-hjf3108@gmail.com>
 <55c2f09b-71b7-4aba-8f87-58f98aaf9e13@suse.de>
In-Reply-To: <55c2f09b-71b7-4aba-8f87-58f98aaf9e13@suse.de>
From: Jie Feng <hjf3108@gmail.com>
Date: Sat, 28 Nov 2026 01:57:18 +0800
X-Gm-Features: Aa3M54q895r8_E-MN064VdwuBWxnz6l02qG5-v487UDRTqOZKbwQ6xFMTCrK5KI
Message-ID: <CABOQOSW+Df5STmeexmdwGm4dVtXunezZJoMR_HPKtYZgRYd4Xw@mail.gmail.com>
Subject: Re: [PATCH v6] drm/tiny: trigger5: Add MCT Trigger 5 USB display
 driver
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, cyrozap@gmail.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Fri, 27 Nov 2026 at 17:49, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi,
>
> I think the driver looks much better now. I left a few notes below that
> you might want to address.
>
>
> Am 12.11.26 um 16:45 schrieb Jie Feng:
> > From: Ho Jie Feng <hjf3108@gmail.com>
> >
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
> > Patchwork:
> > https://patchwork.freedesktop.org/series/176855/
> >
> > Changes in v6:
> > - Replace the USB transfer worker and vmalloc frame buffers
> >    with eight URBs that send the frame in chunks
> > - Remove keepalive work, it is not needed if it is never sent,
> >    and disarm any keepalive it already has
> > - Use container_of_const(), drm_dbg(), and drm_err_once()
> > - Group plane code and function tables before CRTC code and tables.
> > - Use the standard NULL-CRTC plane-check pattern and remove redundant
> >    mode checks, the driver-specific no-EDID fallback, and the INF comment.
> >
> > Link to v5:
> > https://lore.kernel.org/dri-devel/20261026112843.69795-1-hjf3108@gmail.com/
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
> > - atomic in these function names mean that the changes should go through
> >    through at once or not at all, nothing to do with atomic context.
> >    Furthermore other drivers also have similar patterns
> > - drm_gem_fb_begin_cpu_access is also required
> >
> >   MAINTAINERS                     |   7 +
> >   drivers/gpu/drm/tiny/Kconfig    |  14 +
> >   drivers/gpu/drm/tiny/Makefile   |   1 +
> >   drivers/gpu/drm/tiny/trigger5.c | 990 ++++++++++++++++++++++++++++++++
> >   4 files changed, 1012 insertions(+)
> >   create mode 100644 drivers/gpu/drm/tiny/trigger5.c
> >
...
> > +static void trigger5_plane_atomic_update(struct drm_plane *plane,
> > +                                      struct drm_atomic_commit *atomic_state)
> > +{
> > +     struct drm_plane_state *old_state =
> > +             drm_atomic_get_old_plane_state(atomic_state, plane);
> > +     struct drm_plane_state *state =
> > +             drm_atomic_get_new_plane_state(atomic_state, plane);
> > +     struct drm_shadow_plane_state *shadow_plane_state =
> > +             to_drm_shadow_plane_state(state);
> > +     struct trigger5_device *trigger5 = to_trigger5(plane->dev);
> > +     struct trigger5_transfer *transfer;
> > +     struct trigger5_bulk_header *header;
> > +     struct drm_rect current_rect, src_rect, clip;
> > +     struct iosys_map data_map;
> > +     size_t payload_len;
> > +     int width, height, lines_per_urb;
> > +     int idx, y;
> > +
> > +     if (!drm_atomic_helper_damage_merged(old_state, state, &current_rect))
> > +             return;
>
> Never use _damage_merged in your display update code. (^1) Userspace
> supplies damage rectangles for ares that have changed in the current
> frame. Merging them creates a bounding box around all of them.  IOW you
> add areas that have not changed.  For example, have a blinking cursor
> near the lower left corner and move the mouse around the window's
> menubar, and your driver easily transfers half of the screen or more for
> nothing.
Talking about cursor, this hardware supports a cursor plane and a form
of lossless image compression, I might add those in a follow up patch.

> Therefore always iterate over the damage rectangles and handle them one
> by one. Don't be concerned with overlapping damage regions. I did some
> tests with Gnome and could not find any operlaps. It appears that Gnome
> already submits an optimized list damage regions.  Overlapping can also
> be detected algorithmically and filtered out by our damage handlers.
> But a merged bounding box cannot be optimized.
>
> ^1: White lie, as we use _damage_merged for ast's cursor. But this code
> really is different.
The hardware seems to only accept 3 damage rects per vblank according
to my tests. Since I do not know in between which of the 3 damage
rects the frame is being output, I think we should just use
_damage_merged to avoid any sort of screen tearing. In this case the
compositor might get wrong feedback if the damage rects are small, so
should I pad some extra rects so that it gets correct feedback of the
current speed of vblank?

This kind of behaviour looks to be quite common, the hardware for
ms91xx only accepts 1 damage rect per vblank, so _damage_merged is
mandatory there.

> > +
> > +     if (!drm_dev_enter(plane->dev, &idx))
> > +             return;
> > +
> > +     src_rect = drm_plane_state_src(state);
> > +
> > +     /* Match drm_atomic_helper_damage_iter_init() rounding. */
> > +     src_rect.x1 >>= 16;
> > +     src_rect.y1 >>= 16;
> > +     src_rect.x2 = (src_rect.x2 >> 16) + !!(src_rect.x2 & 0xffff);
> > +     src_rect.y2 = (src_rect.y2 >> 16) + !!(src_rect.y2 & 0xffff);
> > +
> > +     /* Clip merged damage to the new resolution. */
> > +     if (!drm_rect_intersect(&current_rect, &src_rect))
> > +             goto exit;
> > +
...
> > +             iosys_map_set_vaddr(&data_map, transfer->urb->transfer_buffer);
> > +             drm_fb_xrgb8888_to_rgb888(&data_map, NULL,
> > +                                       &shadow_plane_state->data[0],
> > +                                       state->fb, &clip,
> > +                                       &shadow_plane_state->fmtcnv_state);
> > +
> > +             if (trigger5_submit_urb(transfer,
> > +                                     width * 3 * drm_rect_height(&clip)))
> > +                     break;
> > +     }
>
> Good to see that the worker has been removed.
>
> > +
> > +exit_end_cpu_access:
> > +     drm_gem_fb_end_cpu_access(state->fb, DMA_FROM_DEVICE);
> > +exit:
> > +     drm_dev_exit(idx);
> > +}
> > +
> > +static const struct drm_plane_helper_funcs trigger5_plane_helper_funcs = {
> > +     DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> > +     .atomic_check = trigger5_plane_atomic_check,
> > +     .atomic_update = trigger5_plane_atomic_update,
> > +};
> > +
> > +static const struct drm_plane_funcs trigger5_plane_funcs = {
> > +     .update_plane = drm_atomic_helper_update_plane,
> > +     .disable_plane = drm_atomic_helper_disable_plane,
> > +     .destroy = drm_plane_cleanup,
> > +     DRM_GEM_SHADOW_PLANE_FUNCS,
> > +};
> > +
> > +static const u32 trigger5_plane_formats[] = {
> > +     DRM_FORMAT_XRGB8888,
>
> I suggest to support RGB888 as well. It's not common nowadays. But it's
> the native format and does run slightly faster is used. Can be a
> follow-up patch.
>
> > +};
> > +static enum drm_mode_status
> > +trigger5_crtc_mode_valid(struct drm_crtc *crtc,
> > +                      const struct drm_display_mode *mode)
> > +{
> > +     struct trigger5_pll pll;
> > +     u64 err, ppm;
> > +
> > +     if (mode->hsync_end <= mode->hsync_start ||
> > +         mode->htotal <= mode->hsync_end)
> > +             return MODE_H_ILLEGAL;
> > +
> > +     if (mode->vsync_end <= mode->vsync_start ||
> > +         mode->vtotal <= mode->vsync_end)
> > +             return MODE_V_ILLEGAL;
>
> You don't nee that basic stuff. See [2]. Just test for hardware specifics.
>
> [2]
> https://elixir.bootlin.com/linux/v7.3.4/source/drivers/gpu/drm/drm_modes.c#L1652
Nice that this is already handled. The checks are actually for the
fields in the struct with /* minus one */ comments.
> > +
> > +     if (trigger5_mode_buf_len(mode) > TRIGGER5_MAX_FRAME_SIZE)
> > +             return MODE_MEM;
> > +
> > +     err = trigger5_calculate_pll(&pll, mode->clock);
> > +     ppm = div64_u64(err * 1000, mode->clock);
> > +     if (ppm > 10000)
> > +             return MODE_CLOCK_RANGE;
> > +
> > +     return MODE_OK;
> > +}
> > +
...
> > +
> > +     ret = trigger5_alloc_urbs(trigger5);
> > +     if (ret)
> > +             goto err_free_urbs;
>
> I still thing that URBs should not be pre-allocated and you should go
> for something like i try with udl. But that's fine tuning for later.
> Pre-alloc is fine for now.
I can send in a follow up patch once the udl design is finalised,
along with RGB888.
> Best regards
> Thomas
>
Best regards,
Jie Feng
