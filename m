Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF7606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CJzbz18+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90E5112638;
	Thu, 19 Nov 2026 16:39:28 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E15210EBA2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:39:21 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-703be215729so1201713eaf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:39:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795106361; cv=none;
 d=google.com; s=arc-20260327;
 b=QWAtTgNN/4y0IMDy16BxDUu+igRXGKgimeg8480OgxItJLDbFbnqwLM2+k8pBe3WXp
 owQaIIrgr2PPOnX8dVUQh9UD6I6sZjoVjoGvLbGAxCV0Gyle3zfaoB0DF1tgoktY5pJn
 0t8IxIkM4FA53HbAgCsiqMwJvUforL1L/oOTTJSbAAZBg0Ag1klMKha0grBbi2hzNLBc
 QR7mSfyKDy0Y3DFCnZE5VLbXOPPq0kERKGbUcZlwx9ckiZ8qeURaANb0UaT8uDp8jabX
 CGiQeqGGIQNybsJNeOv4RwBvSNhw61+Z277fX4Dq8l0JVa7kEhpA/y0SIhtdjpRFlSTU
 bPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b7FItsl8wpDWWtVp85YkbDLxbtweLFpOBExBkGzSVQw=;
 fh=DwXUxDr6sUBQH3wb9xWkJRX3c+YPb3CRxzfgKSi0BbU=;
 b=lQVtBPdancYu6I4C6B4oYmpj03k0KknbJdMQX5/6v3ZvMLurtO6ZY4Dxa35rjhdoaJ
 76fRgz0N9REDrsXXSeXivEiPN3U/XhFRhQW8PSEgQNZbqFDpY7/QJjbyI84562QOW4Vi
 rp+baHyWoiVqSobNOB8l/dIem1Sdqcpjb6Uftl4ArePwavwIBoDEoA9iYcQbcLxe0iyt
 ZJbPnE1kPKnO4OdWFXyq0RjgJkDlbSL7XUYgIwKp6GjIgmsjdj41yV0DrTwgu92pWLc+
 6QQC5cx7Q8f3ibqpJpYs/vJ7cE5RwL11oxlQNRaCrTi7ND5G+N0uGhLXdzNVBt34Tw6D
 ESYQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795106361; x=1795711161; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b7FItsl8wpDWWtVp85YkbDLxbtweLFpOBExBkGzSVQw=;
 b=CJzbz18+nUleM36lapACUvPJSazvSvCcuTsiQlQ6xVW/snHyxJg4pkQs4O2SzVq19k
 0zXI2PSfeahDKFbUYzG01oP7E9p40g85oUE+LgZ6MpeHL8mN4JAt6ASbnsDBgHNN/JUS
 FKie5osW9qnJogQdU+PD+Ej2riC/Buzyxbw9LoMsFRRr7GK5m/5CuyoiGICszW26BYEu
 mLtolsQC8aZhYDec9vpSgbJpoAVN0jvH6iRz7w0jKQPBdFRrd1s4wIswWOfJ1HXy7JO2
 Ui5+dTnHobTgcncNzNnANqGeACpi8dOAm0+9q4RVKBAy7W7P3yZPfCAqkyafL+qTAJWn
 k/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106361; x=1795711161;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b7FItsl8wpDWWtVp85YkbDLxbtweLFpOBExBkGzSVQw=;
 b=Nt/u6lxTfFi+Y3iDBTxT8kd1QaKypmkUrm4vfdr0VzrUeoD6e67FHPmtsHTCogEm2+
 N/JneUHkhiKZVvPvL1WQQo9kNGg+Jsmps0O0tK4hR82NOWYzD5NjIq+hEA+BMbyRi1MI
 ZOx0C16aHincDLquWpO4mKaDFRlhYRpSH5y3Pgg5REBRLoYj49oIW7ytvDU6khYE17m8
 6H7h6DO5Iu6vsWU0CEyGRTJDd2dxkjox5T7YnJ2P7uP/2UgQs/MX+YMj3KXhORa/HCys
 b3HGS+XNdacbaqjy5MzShB9+gHD14yXEWBnCC9744Z74TkWGUdEuyHpOulzKvH1z5R2A
 LfyQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGxwxlMHciBp0YOqwDx4cLKm5FFm7aDtiFYOZ30YO6+Q5rhrk6c8qH5MHIZt4UkJVn0w1oZOePxn2Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9hGTKOQvINplMJVVvvLGsnBdwvqwa2D6BA9zUJ2iF7lS2uMT15
 mUhaPETFs6V+4YgRJ6emJ+2/AmIi3L4y9DTiH9yJCpWUztxGmHFkSQfXFb57bvYBR5gCQUnZnRy
 uUi3RwbgBTYvWrQQ//ThodU+k0XeynBQ=
X-Gm-Gg: AYBFou3MKMcfUA5MhM4bh2Ty0W3TIh7S6YiqRdZsnlhq7JHoJlEuCS9MAeY6OiR17u3
 VRtPguVL1v25s0hWMFo+D8Ozrsua0MdAyQnLz4JhJK0TPLjYV5IGOsSxIPRnLAPgPxB/D3zuw3g
 x3XjlyB+sZCT2/27hyo+cgoGoxxwuAtr1tNbH8GkWQ1+4RvLuBFZn7smgJ4fW5Rot1GSDFQ1yy6
 TUFoX3+r2LPYSSHQaOeXdiQMM/OzDCBr0CNTXqKZF/7YLrpkEwSMQ3iUABMBZ7CR8AzYQUrC3kT
 VdxCj/rcttZF+QqVpiqRvYCQEctvluVu7p/55MIYE7LcViRxprnsOST+eyuV0tf/rK1K1SsnQpH
 8hOA8AxNL9UfYRs9p0Wm4Myyfvwx85CvTm0K9nC1otnF7PO71BlzwNBL3UlQCOtDQ+OUygkXUDE
 d1BmaMrysLZ3PI/q7zos87jb9Vvz4Z0k4=
X-Received: by 2002:a05:6820:83d6:20b0:71a:fbc6:6a9d with SMTP id
 006d021491bc7-71b39496a07mr80280eaf.41.1795106360618; Thu, 19 Nov 2026
 08:39:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119142114.152052-1-tzimmermann@suse.de>
 <20261119142114.152052-5-tzimmermann@suse.de>
In-Reply-To: <20261119142114.152052-5-tzimmermann@suse.de>
From: Jie Feng <hjf3108@gmail.com>
Date: Fri, 20 Nov 2026 00:38:43 +0800
X-Gm-Features: AclHuK8BQ0beJx04YFSpWnOXXOCfB9S0SZrWi3J3-CqIecB4FFduuegLi2YFnbw
Message-ID: <CABOQOSW8f2Dw7DATTB-c1jhOzyo4BBsKh4cNVnEA0VpRJ=5H8g@mail.gmail.com>
Subject: Re: [PATCH 04/11] drm/udl: Allocate bulk URBs in helper functions
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, sean@poorly.run, tiwai@suse.com, 
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 00:30, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Move the code for allocating an URB into a separate helper function. Use
> the helper for initializing the URB cache.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/udl/udl_main.c | 74 +++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
> index 67da676f0f94..a799d7710a7b 100644
> --- a/drivers/gpu/drm/udl/udl_main.c
> +++ b/drivers/gpu/drm/udl/udl_main.c
> @@ -163,6 +163,47 @@ static void udl_urb_completion(struct urb *urb)
>         udl_put_urb(urb);
>  }
>
> +static struct urb *udl_alloc_bulk_urb(struct udl_device *udl, size_t size)
> +{
> +       struct usb_device *udev = udl_to_usb_device(udl);
> +       struct urb_node *unode;
> +       struct urb *urb;
> +       char *buf;
> +       int ret;
> +
> +       urb = usb_alloc_urb(0, GFP_KERNEL);
> +       if (!urb)
> +               return ERR_PTR(-ENOMEM);
> +
> +       unode = kzalloc_obj(struct urb_node);
> +       if (!unode) {
> +               ret = -ENOMEM;
> +               goto err_usb_free_urb;
> +       }
> +       unode->dev = udl;
> +       unode->urb = urb;
> +
> +       buf = usb_alloc_coherent(udev, size, GFP_KERNEL, &urb->transfer_dma);
usb_alloc_coherent might map uncached memory on platforms such as ARM.
This might be slow for moving large amounts of frame data.
Would using kmalloc/usb_alloc_noncoherent be better?
> +       if (!buf) {
> +               ret = -ENOBUFS;
> +               goto err_kfree;
> +       }
> +       unode->alloc_size = size;
> +
> +       /* urb->transfer_buffer_length set to actual before submit */
> +       usb_fill_bulk_urb(urb, udev, usb_sndbulkpipe(udev, 1), buf, unode->alloc_size,
> +                         udl_urb_completion, unode);
> +       urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
> +
> +       return urb;
> +
> +err_kfree:
> +       kfree(unode);
> +err_usb_free_urb:
> +       usb_free_urb(urb);
> +       return ERR_PTR(ret);
> +}
> +
>  static void udl_free_urb_list(struct udl_device *udl)
>  {
>         struct urb_node *unode;
> @@ -191,11 +232,7 @@ static void udl_free_urb_list(struct udl_device *udl)
>
>  static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
>  {
> -       struct urb *urb;
> -       struct urb_node *unode;
> -       char *buf;
>         size_t wanted_size = count * size;
> -       struct usb_device *udev = udl_to_usb_device(udl);
>
>         spin_lock_init(&udl->urbs.lock);
>         INIT_LIST_HEAD(&udl->urbs.list);
> @@ -205,36 +242,19 @@ static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
>
>  retry:
>         while (udl->urbs.count * size < wanted_size) {
> -               unode = kzalloc_obj(struct urb_node);
> -               if (!unode)
> -                       break;
> -               unode->dev = udl;
> +               struct urb *urb;
> +               struct urb_node *unode;
>
> -               urb = usb_alloc_urb(0, GFP_KERNEL);
> -               if (!urb) {
> -                       kfree(unode);
> -                       break;
> -               }
> -               unode->urb = urb;
> -               unode->alloc_size = size;
> -
> -               buf = usb_alloc_coherent(udev, unode->alloc_size, GFP_KERNEL,
> -                                        &urb->transfer_dma);
> -               if (!buf) {
> -                       kfree(unode);
> -                       usb_free_urb(urb);
> -                       if (size > PAGE_SIZE) {
> +               urb = udl_alloc_bulk_urb(udl, size);
> +               if (IS_ERR(urb)) {
> +                       if (PTR_ERR(urb) == -ENOBUFS && size > PAGE_SIZE) {
>                                 size /= 2;
>                                 udl_free_urb_list(udl);
>                                 goto retry;
>                         }
>                         break;
>                 }
> -
> -               /* urb->transfer_buffer_length set to actual before submit */
> -               usb_fill_bulk_urb(urb, udev, usb_sndbulkpipe(udev, 1),
> -                                 buf, size, udl_urb_completion, unode);
> -               urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
> +               unode = urb->context;
>
>                 list_add_tail(&unode->entry, &udl->urbs.list);
>
> --
> 2.56.0
>
>

Best regards,
Jie Feng
