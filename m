Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A5E606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rcxN/fKf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F1A910FCBC;
	Wed, 11 Nov 2026 17:08:40 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB22F10FC9E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:08:33 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-48ed0b68895so2211381fac.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416913; cv=none;
 d=google.com; s=arc-20260327;
 b=AK035Li+SibHiSsQD0KIJPLaF7mP7cijra4Mas2Z803OxPcunjYT6cZIsRMkwKdAWT
 dLXJwD26NS35r3w3rtd5vyhXRL0/gbeymdxz0Rh39RuEe10m8lzygH6P9iF86TFtcnHU
 JhJlzZZaSOAaGyiT1uT/jo/mj2vpXtz8ZCO8/UPgAldYBEddEbGqvJIG7G4jva5U4tgk
 aon79xlv2/J0S0WQYeof7rt0oDQj0Vsi3QiiDrRrPqpyuteoe31swrck0tTcYxmbj8fy
 8vc5M0YRNA8Xuk4YYyVoi6gGcIIzZ2aOgaZ3Mra9jb1PCdtra+yLW7cxzdaXBHBAr3mT
 EJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kVPjB5hQmOFQLlE+4NngKPps2k6g7Y4uA9ABWeTM8QU=;
 fh=ilLqXmjNRPIr55pJvOutiHz7t1Zv8JnNLtrTdWam73g=;
 b=obGL4LbvH5NRHicke8uYW8CTmhuuX1u/s7DH0Sox+S7YLNyyiOaBI5a3a+g1JZNASz
 b5ED55fPJUqFjytJIv29sFH1c1grV5vJ0iuwrDockTYomVSLStuYH0VP1pt6unKJKiyC
 bzA7RtAFDXJExpdgsHHYW7Ip4WnO0C3YFmWsn0uiZNvwb1r7qtZCol6aXy7mLPmO/X37
 M+CGWm2GBICMUwBEg6gjEWQJriGxWVHdSvPqiC6rGvLmpActxdqBQjPZqAAdlkQh3tBw
 Dh6v620TThO+VeQWJ3ERl2xOSddrjgIKbkueu2h/3y1jYRCbHK5hJiCXX5MZ51PKQhCF
 miiw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794416913; x=1795021713; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kVPjB5hQmOFQLlE+4NngKPps2k6g7Y4uA9ABWeTM8QU=;
 b=rcxN/fKf5yPrVYLM1PmxRKhSnUOXf8uU3FJh/kCGNdxiJpFqeboCLEvCOAVxK5o8mY
 HLIIpkpqEBZTbJcnEnl5vaMFE8Sar6TKs0S5AYalXK+c/uw58ctce17QLLFSxJHAfkes
 O2NgkTBxG6sZgpgtipsUKjOSfTmJf3UwIu04MOmYhNnZWT0VzukKTeBbRa5tgWceLEJg
 rKDAyS1tDiMAZe8m/6NP1HPPQ6eGDMSSDN6oNhdeMPk4Ljl3L0jKIXvhuLxfQQxdSWJH
 7QEtvaRUQRLDNYOvdkyK/4M+S7EujhDdxGVY+XLMT8Qdey5itPtyS77tk43lqBZxbosm
 bWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416913; x=1795021713;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kVPjB5hQmOFQLlE+4NngKPps2k6g7Y4uA9ABWeTM8QU=;
 b=FoF9V3bO21/nF2P8HJX2kLw27ht2Gv9/63zH/+23F6M0M29ABbaUc4aTkfKLWcIDYH
 4YMwWWRocHgmXdNe2EHQBDPK5JCIYbbPkRk1SoX7Wx5Fj5lrOSoT6+a6C8Ag/Q29YiHP
 aHpiZGnuhMaNihTsSrRhyFXjEEHQQzyrTZN06c+FEx8B5+0xlJQHu93xkHut5oIroZmk
 tUfQDZj6ictxz1mBpV5wEv/4ifZ8MzSMa6V54NrZ4IBA5gg+x44bAoAjN1HXifC6hkhp
 6LqGmbgMDEjSMVP6yLVpdlgAfAIg8wf74h8nHGoh8hHk+NNZftATB/UeTtyapm02xXRE
 JgcA==
X-Gm-Message-State: APuU4Z/Yd02ZKUbZHTvN225HHCSD2jgrwg8NmywlSjbLmyjQ7rHHY3Pw
 xxvKDbilhXKcGs34P2e4++ka5z5fATVQU1Sp3xLtSJQa2M8d0G1FQ/VGrQPNqAzPzhWqIlKJDc9
 nJ7WLzosuB3iohiLvmpXuXsj7D8eXiUw=
X-Gm-Gg: AYBFou25t+vVgdvxq7vy2zH+vVdJv6EYKWGwBTCwVGbmP9WaahuiOGV7pX4vHXWRc03
 lDdkgLEWEZ7h36LhqYZj2eT2Tpv3JC5V57uqTDYh99o3VIjX7Yw0UYCae0XSIqX67PTUiyBYjTU
 ZdozItTe+Vk3T0f1cIhDhvoMghHMPcMOPMCxqHeUysQ3dxefUbaFf3FnisSng+sc99E+6jgP+Jb
 +cosOdQNkAX+fYZRt02+gX+ZyYJ40Eknl2mFQDPRTmpk24Nd0oJmMokVS+chYXoc6QFVTPVq2ln
 AHeMP2HulDiJFBvNvBtcd3azK+LTTDXqLICEU4ImyDEFp4/ipcfcNzO5evieqtRjvledwfAsOYe
 nZiJ9HH5TPL6xURrtNTw5MSmtevCeFlOAjvKcKqqxiGJjUFbgpOHae2zBRZuE4JKDgw2REKMFnW
 snHDjbRxmiDkuz/EYPhnL1R39Kpsmp+Bc=
X-Received: by 2002:a05:6870:3927:b0:439:a524:a29d with SMTP id
 586e51a60fabf-4ae467f98fbmr2595794fac.1.1794416912718; Wed, 11 Nov 2026
 09:08:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026112843.69795-1-hjf3108@gmail.com>
 <1b25256b-5fb5-4b4a-bc05-7a2bfc309128@suse.de>
 <CABOQOSWGUmaR2wSso37rYgg0QoJL3K1qoDPqsp8OzOk_ifpgCw@mail.gmail.com>
 <5dbac304-65a4-45c6-8c9f-01416951c293@suse.de>
In-Reply-To: <5dbac304-65a4-45c6-8c9f-01416951c293@suse.de>
From: Jie Feng <hjf3108@gmail.com>
Date: Thu, 12 Nov 2026 01:07:56 +0800
X-Gm-Features: AclHuK-8Nfci6G0cOgHqvxMVo-Wx05JTLMB6lBtW9UjkLuL40BKWP-vTQnFqEw0
Message-ID: <CABOQOSXQvHG_7-S1UxErfF3crhAMPHjtcpPzS_zim9VVHHEecQ@mail.gmail.com>
Subject: Re: [PATCH v5] drm/tiny: trigger5: Add MCT Trigger 5 USB display
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 at 23:21, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 10.11.26 um 16:49 schrieb Jie Feng:
> > On Tue, 10 Nov 2026 at 22:23, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Hi,
> >>
> >> sorry for letting you wait for so long. You'll find a review below.
> > Thanks for the review! Since this driver shares many similarities
> > with the ms91xx driver I am submitting too, I will be making
> > the changes in that driver too.
>
> I've briefly seen that other driver. Let's focus on one of them first.
> The other will then be easier, I guess.
Sure, let's focus on the review here, this is a much smaller driver.
>
> >
> >>> +     ret = drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE);
> >>> +     if (ret < 0) {
> >>> +             complete(&current_transfer->frame_complete);
> >>> +             goto exit_save_pending;
> >>> +     }
> >>> +
> >>> +     drm_fb_xrgb8888_to_rgb888(&data_map, NULL,
> >>> +                               &shadow_plane_state->data[0],
> >>> +                               state->fb, &current_rect,
> >>> +                               &shadow_plane_state->fmtcnv_state);
> >>> +
> >>> +     drm_gem_fb_end_cpu_access(state->fb, DMA_FROM_DEVICE);
> >>> +
> >>> +     flush_kernel_vmap_range(current_transfer->buf.data, frame_len);
> >>> +
> >>> +     queue_work(trigger5->transfer_wq, &current_transfer->transfer_work);
> >>> +     trigger5->current_transfer = !trigger5->current_transfer;
> >> Why do you need a separate work item for the transfer. Can't you just
> >> send from here?  We do this in udl.
> > I want to make the send async, so drm_fb_xrgb8888_to_rgb888 can run
> > in parallel with the usb transfer. This is done since drm_fb_*_to_*
> > functions are slow when copying on write-combined memory due to
> > dma-buf sharing between the main GPU and this device.
>
> We do this in other drivers as well. Neither is supposed to be fast.
> There's always this memcpy from the imported buffer.
>
>
> >
> > udl does usb_submit_urb, which is async, but the usb_sg_wait has no async
> > counterpart, so I opted for putting it in a worker.
>
> Why do you use usb_sg_wait() in the first place? It appears to be a loop
This part is referenced from gud. I thought it makes sense since I need a large
vmalloc buffer, so using usb_sg_* looked like the right approach instead of
asking for kmalloc(8MB).

Alternative I considered are:
- usb_alloc_noncoherent: but that requires implementing a fallback if a
  controller doesn't support scatter gather DMA, while usb_sg_* does
  handle all of these cases.
- pool of fixed kmalloc buffers: 64K seems too small, too many URBs
  for a 1080p frame, and tuning the number so that kmalloc will likely
  to succeed on a fragmented system while keeping the number
  of URBs per 1080p frame small doesn't seem like the right
  approach to me.

Are there other possible approaches to this?

> around usb_submit_urb() plus the waiting. (The comment at [1] is
> actually quite funny.
>
> [1]
> https://elixir.bootlin.com/linux/v7.3.1/source/drivers/usb/core/message.c#L761
Indeed!
> >
> > I saw there's a TODO within the format helpers for io memory, so
> > maybe in a future patch I could change it to use drm_memcpy_from_wc
> > to speed it up. Currently it couldn't run at full 1080p at 60fps on bare-metal,
> > but on a VM it is fine due to not copying from WC memory.
> >
> > There's also the other issue of some compositors calling _update
> > in the render loop or something that causes visible stutter when a device's
> > _update callback is slow.
> >
> > The ideal way to solve this, with both low latency and low memory footprint
> > is to take inspiration from gm12u320 and store the fb and update rect in
> > the device struct, and let a worker obtain the latest one from the struct.
>
> It's not. None of our USB-based drivers are well optimized. You can take
> some inspiration from them, but don't take them as they are.
>
> At the end of each page flip, DRM sends out a FLIP_COMPLETE event, [2]
> telling the compositor that it's done with the display update. This
> gives the compositor an idea about the performance of the device.  It
> can adapt to that and end out less updates. By moving out the actual
> work into a separate thread, you break that feedback. The compositor
> will see an early complete from the page flip and queue up the next
> frame immediately. The driver will pile up updates for the worker to
> send out. Hence, leave the copying and sending operations in the regular
> update code.  If you build this with usb_submit_urb(), there's no
> waiting necessary.
In that case, assuming I keep the usb_sg_wait, doing something like
wait_for_completion(previous_transfer) would be more correct.

> [2]
> https://elixir.bootlin.com/linux/v7.3.1/source/include/uapi/drm/drm.h#L1395
>
> What I have in mind for udl is this logic:
>
> 1. send the current frame's updates as usual using usb_submit_urb()
>    - transfer runs in parallel to current display update
>    - count the number of submitted urbs
> 2. in each complete handler, decrement the urb count.
> 3. in the next frame's atomic_begin, wait until the urb counter reaches zero
>    - most parallelism
>    - max out USB
>    - maintains correct transfer statistics and events
> 4. if the second frame takes longer than expected, the FLIP_COMPLETE
> event wil be late; the compositor can throttle the page-flip rate
For this one, wait_for_completion(previous_transfer) looks to be
similar in behaviour.

> I made a nicely working prototype from this.
>
> Best regards
> Thomas
>
>
> > The transfer is then sent in blocks, while overlapping the drm copy
> > and usb transfer in parallel. I think this is a bit too much complexity
> > for a drm/tiny driver though.
>
>
>
>
> > ...
