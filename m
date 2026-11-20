Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F0A606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O/F6bN4/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB6D112B9A;
	Fri, 20 Nov 2026 16:16:38 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C925112B92
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 16:16:31 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-4ad60ec5eaaso941493fac.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 08:16:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795191390; cv=none;
 d=google.com; s=arc-20260327;
 b=hcm35nd1hIYSnM1IsZxuK5caJWWfuYoWzS2Y7EMqvBuPK+vHqSwaOMPoAGa33DfueG
 qdyiIDzlw4RE4frw3+xR3kV/uj3k0i5icMe2hn5dVrZ4zRBIu5uGM5K/sm+pDeQ3kUAm
 e41I8F9XOxC9MD8D/7mhgzaNzuDsGE+2KfV9cNYNmHbqG0w3Xez9yGLC5BQmZNpVLbeO
 ftXtdp2tX+XSJqbl0ay7fj8ZRM7z2ymcqJIllqsd3Qkc3J+69buyCRbg0/Zf3Z2NQaX4
 EOf1b107x0HCW3x1hNbbOSs5ULPzIUiq/+XucgFclWeLuFZtdbD/dEhOnhp2cWa98YlM
 BEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8FjMsEwN0CmeAMZH8q3KD8wmJKc2e9X4mLxXlcfAI7g=;
 fh=Tlakk55yZQtGRwx/NKuNR1tKK/HL202Psop8TOOVttg=;
 b=Uenbob533EHcPE+RkVbps0jhzmkGvTQPSuIEFcR5HsISr4PnLj35s9B1ADdN+EvzXr
 MXEPVk1eciUKLs2rpmpvbMwWMWDlzC+yD57Pc3tSBW2InDoxckpiB26p3DufIHWV7ZP3
 OmcEvkkl9lPBij+JX5vWYxYT3f3xS57aEO3dP7bcWZoR0AQs1armGPW2YnlvYleiaxBU
 p4inrwuKbkYoMNb7NK6VxG3BQllIymmbUubBUKgT8ypAHt2qaUCHn/PAH7YPQTxTu0fv
 DVP51I/SFZxgquoUVK0zsbyz7wYyKSG2m7lmUqLonK8uYFthWW24kz9gu34hhqmeVVj3
 1mhQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795191390; x=1795796190; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8FjMsEwN0CmeAMZH8q3KD8wmJKc2e9X4mLxXlcfAI7g=;
 b=O/F6bN4/qk7m9aeljDfXeGdwS1OGtnqiY7UykbIRMDXMQns1jNuzU2xfSy98mvsrKf
 1A/WviijJK+fs5c9LUrzDXU/4JGfQ08kaTEdjaQIr5oGlpsE3bH8mvi7gO9VKOoPF7AP
 7GGy9dtjhKFlC/fBUtPAi5CFvd1HUloIP5BTODg47NkVFRQ3H6Ou+B6y4ZGGVmFNBpFT
 7BjNNmrmAPB4LQjAxnwjCBhY2E1fiivp3IVr715/2VSBN3yW3a9FfuiYgDRU6JllAEU+
 KROp94N2xYTJM5NMW1Lrb0oxZWSFlvZGYv/4+0rpDZ7Og2MQ/rv/L5m9KKf0QOEiuaXI
 gAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795191390; x=1795796190;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8FjMsEwN0CmeAMZH8q3KD8wmJKc2e9X4mLxXlcfAI7g=;
 b=ZPcin5Ic55RDuxbJTS3Ptjb1Xwj3lLWsdfRwYeiWEqlGeR2y5glNJaYVpKZkzQx11F
 W654kcI44stAazvFw4bZLuuc5mIXfEcZ0VpuyK6+gwO0P1AgbT2lFGtWKJjufds4NV9K
 EfUzarPT1l1VblXRcEDiGejFl/oHIctN7jBSNfbvgeVmhGLGA4iv0ocyZi/flzoUWCsN
 n2t7E/HT04WLhPa+FpaNWzWscYiIEXo8zE6iJL6ZscI0YEmAX4hmqgpKihGrZbKwcwbo
 cdpO4UIXqOKZl+ikXm0dUsRY9LTMsh7+1PYFJyQz5iCJ5WBn3gpS/Jd6HtJUMwM7j3YI
 GHSw==
X-Forwarded-Encrypted: i=1;
 AL+hErElJHlB4AqguSH3XQXa3N6vpfLfFk5GJmigqcbnR6Fj3N/CjguOnF9xLDTf0Rg5WeSJAuwJi0nJfdo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/cM+jZ05WYosiED6SQ9avBq7mUL5JKKlPdsIW0g5+FkQXtcXSC
 oJAD/qQjRkbQKMvxfR/dgz452F3ad9AKQewrjJNbrcQjSXjpDLFRu4Rh93XVdkGpT8u2npP5wcU
 ZiuaRVHbuhzWWJSiFC/YhSUEZt3SKFU0=
X-Gm-Gg: AZFdTZf2U3rP7JlBpnn43TA/H4vWnhyGW5+J34bszVP6dc2c28kBCCj+qKnPmbEVwkl
 cCl4KGJlr9lLQwtKO+PpDJ9QNUAAHIg694/aLVkveK430USGEvFCcfodguO+lcIn9V3MpjisfuN
 xXbEVkjZf0nTickhPkBRVjuyj6w8PeF6N11UVicbojKjBQnZi/4+QiTBy7gMaKTejSqII644g2e
 maf2ike1ykK+3PQh/Y5XRIAwpaERnk1vVHiTPQSzFewJA9fD+tAbfde2yvmVgun8fSZDT05UC0t
 J80PCXVgu/L9bummV74vPP+EWlaqu8fcdzbjGwvxX0UOm9Q55UjiSlrz4eNww5KL3JF+L9nq/op
 fBGt7K27myVYpWShV19ZLaiGEi0M31XnkGWLZm7AOOBkSJzi6kRxS8TYaMK3XFTXPx66NfUtn07
 Z2fDr0JNLPvpQudGrqQYKxyM936nfoAYE=
X-Received: by 2002:a05:6871:411:b0:494:2141:c0e4 with SMTP id
 586e51a60fabf-4bc858fc7f1mr2331500fac.29.1795191390312; Fri, 20 Nov 2026
 08:16:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119142114.152052-1-tzimmermann@suse.de>
 <20261119142114.152052-5-tzimmermann@suse.de>
 <CABOQOSW8f2Dw7DATTB-c1jhOzyo4BBsKh4cNVnEA0VpRJ=5H8g@mail.gmail.com>
 <9ba8634d-d714-4967-9a59-1e0ffcf2f8ca@suse.de>
In-Reply-To: <9ba8634d-d714-4967-9a59-1e0ffcf2f8ca@suse.de>
From: Jie Feng <hjf3108@gmail.com>
Date: Sat, 21 Nov 2026 00:15:54 +0800
X-Gm-Features: Aa3M54q1fnfnzzPxReZg0T4qLBs-z01sczs9c2I4joAY-GzySu59IZ41HM2kTHk
Message-ID: <CABOQOSUocweGxzpqa0WPYUF8j4=_CXECNx5w2bLJQS_Z8Lv2DQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] drm/udl: Allocate bulk URBs in helper functions
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, sean@poorly.run, tiwai@suse.com, 
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 20:49, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:
>
> Hi
>
> Am 19.11.26 um 17:38 schrieb Jie Feng:
> > On Fri, 20 Nov 2026 at 00:30, Thomas Zimmermann <tzimmermann@suse.de> w=
rote:
> >> Move the code for allocating an URB into a separate helper function. U=
se
> >> the helper for initializing the URB cache.
> >>
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> ---
> >>   drivers/gpu/drm/udl/udl_main.c | 74 +++++++++++++++++++++-----------=
--
> >>   1 file changed, 47 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_=
main.c
> >> index 67da676f0f94..a799d7710a7b 100644
> >> --- a/drivers/gpu/drm/udl/udl_main.c
> >> +++ b/drivers/gpu/drm/udl/udl_main.c
> >> @@ -163,6 +163,47 @@ static void udl_urb_completion(struct urb *urb)
> >>          udl_put_urb(urb);
> >>   }
> >>
> >> +static struct urb *udl_alloc_bulk_urb(struct udl_device *udl, size_t =
size)
> >> +{
> >> +       struct usb_device *udev =3D udl_to_usb_device(udl);
> >> +       struct urb_node *unode;
> >> +       struct urb *urb;
> >> +       char *buf;
> >> +       int ret;
> >> +
> >> +       urb =3D usb_alloc_urb(0, GFP_KERNEL);
> >> +       if (!urb)
> >> +               return ERR_PTR(-ENOMEM);
> >> +
> >> +       unode =3D kzalloc_obj(struct urb_node);
> >> +       if (!unode) {
> >> +               ret =3D -ENOMEM;
> >> +               goto err_usb_free_urb;
> >> +       }
> >> +       unode->dev =3D udl;
> >> +       unode->urb =3D urb;
> >> +
> >> +       buf =3D usb_alloc_coherent(udev, size, GFP_KERNEL, &urb->trans=
fer_dma);
> > usb_alloc_coherent might map uncached memory on platforms such as ARM.
> > This might be slow for moving large amounts of frame data.
> > Would using kmalloc/usb_alloc_noncoherent be better?
>
> It's worth a try, but i cannot say for sure. The advantage of _coherent
> is that is makes DMA easy. And we don't read from these buffers from the
> CPU, so caching them might not help much for performance. In any case,
> it's a separate patch series.
If I'm not wrong, uncached memory also means that the CPU sends each memory
write as a separate transaction, so it does not wait a while to flush
the entire cache line
at once unlike normal/write-combined memory. Therefore it still makes sense=
 to
use cacheable memory for the write path.

I agree that it should be a separate patch series.
Most of the uses of these USB display adapters should be on x86, where
there isn't
a performance impact, but given that ARM laptops has been rising in popular=
ity,
I think looking into this might be a good idea.

> Best regards
> Thomas
>
> >> +       if (!buf) {
> >> +               ret =3D -ENOBUFS;
> >> +               goto err_kfree;
> >> +       }
> >> +       unode->alloc_size =3D size;
> >> +
> >> +       /* urb->transfer_buffer_length set to actual before submit */
> >> +       usb_fill_bulk_urb(urb, udev, usb_sndbulkpipe(udev, 1), buf, un=
ode->alloc_size,
> >> +                         udl_urb_completion, unode);
> >> +       urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> >> +
> >> +       return urb;
> >> +
> >> +err_kfree:
> >> +       kfree(unode);
> >> +err_usb_free_urb:
> >> +       usb_free_urb(urb);
> >> +       return ERR_PTR(ret);
> >> +}
> >> +
> >>   static void udl_free_urb_list(struct udl_device *udl)
> >>   {
> >>          struct urb_node *unode;
> >> @@ -191,11 +232,7 @@ static void udl_free_urb_list(struct udl_device *=
udl)
> >>
> >>   static int udl_alloc_urb_list(struct udl_device *udl, int count, siz=
e_t size)
> >>   {
> >> -       struct urb *urb;
> >> -       struct urb_node *unode;
> >> -       char *buf;
> >>          size_t wanted_size =3D count * size;
> >> -       struct usb_device *udev =3D udl_to_usb_device(udl);
> >>
> >>          spin_lock_init(&udl->urbs.lock);
> >>          INIT_LIST_HEAD(&udl->urbs.list);
> >> @@ -205,36 +242,19 @@ static int udl_alloc_urb_list(struct udl_device =
*udl, int count, size_t size)
> >>
> >>   retry:
> >>          while (udl->urbs.count * size < wanted_size) {
> >> -               unode =3D kzalloc_obj(struct urb_node);
> >> -               if (!unode)
> >> -                       break;
> >> -               unode->dev =3D udl;
> >> +               struct urb *urb;
> >> +               struct urb_node *unode;
> >>
> >> -               urb =3D usb_alloc_urb(0, GFP_KERNEL);
> >> -               if (!urb) {
> >> -                       kfree(unode);
> >> -                       break;
> >> -               }
> >> -               unode->urb =3D urb;
> >> -               unode->alloc_size =3D size;
> >> -
> >> -               buf =3D usb_alloc_coherent(udev, unode->alloc_size, GF=
P_KERNEL,
> >> -                                        &urb->transfer_dma);
> >> -               if (!buf) {
> >> -                       kfree(unode);
> >> -                       usb_free_urb(urb);
> >> -                       if (size > PAGE_SIZE) {
> >> +               urb =3D udl_alloc_bulk_urb(udl, size);
> >> +               if (IS_ERR(urb)) {
> >> +                       if (PTR_ERR(urb) =3D=3D -ENOBUFS && size > PAG=
E_SIZE) {
> >>                                  size /=3D 2;
> >>                                  udl_free_urb_list(udl);
> >>                                  goto retry;
> >>                          }
> >>                          break;
> >>                  }
> >> -
> >> -               /* urb->transfer_buffer_length set to actual before su=
bmit */
> >> -               usb_fill_bulk_urb(urb, udev, usb_sndbulkpipe(udev, 1),
> >> -                                 buf, size, udl_urb_completion, unode=
);
> >> -               urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> >> +               unode =3D urb->context;
> >>
> >>                  list_add_tail(&unode->entry, &udl->urbs.list);
> >>
> >> --
> >> 2.56.0
> >>
> >>
> > Best regards,
> > Jie Feng
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

Best regards,
Jie Feng
