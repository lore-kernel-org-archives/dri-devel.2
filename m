Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19814606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xAOGF4/+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8351F10F073;
	Thu, 19 Nov 2026 17:04:04 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9883110F073
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:03:58 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-71ad2c6491fso671639eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:03:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795107838; cv=none;
 d=google.com; s=arc-20260327;
 b=PzkoeY6AA2vzfL64L5lXgiXOgRIMoeyKd63hMFB8rE9qUaNVymxbx3yHneohZjT4St
 J2FjFGNZDtzmk0pRPUexS/5RTsCAkklNdaYdLQGdsPhjWXpi9Q+EIIZ+hy1uuycgAxB4
 QakZm6tvhwpc75apriaQ0FPOxi46Ry8QTOTvH0bDljK1OZ9NqirSL8oegsbxTeVpEQtb
 7coNjtbmLBdf9sRrKG5hhOATUo2/sUBSWdk64b0ELVZ+GqdBCT8J8gmSwChwmy7fsQ7u
 YJxJIi5YMqp8fkHzIZ44ie5fzXrNrKxzo6OC2C6xPk4BRXy8/PzmcMBEQxiOF8biAI4J
 V13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tuGun+0zjW7dRUYikOaNsmwWDgkDAaBtu6YVJwMcddI=;
 fh=Fh2JyImxHTkuDi/GQxaLLjGwBg715xrG9BY5o98qHM8=;
 b=nQZch14rBiioeJ6FfaXpRQQ1wBe/sIRTIh5q9tFgUERuDuOpOpi/DN9F+0QblGhrGD
 d/fBNkIT5EXr29i2e0oNB9zi6acKn+Lni8Gu6iN+IWd8IuQcP5dkvOtswLNX3oVln+VG
 wHfXcJwBf3fudDOV1+rcZymtW/Fl041LQifeyCryP3/FqGWJRTYGETAx8Ih2FQt1nnAX
 L82UFTZBbgbI0MzOASBQEmucZYO7LrbNQ26gMXSf7b+Q8NJ01v7OWZoYSkdq6il+f63b
 VoWOjKVAzTHfBcdXM2YSEbegDuhBw2Opd22zMeCsUUwz7/myWSCNSl0Vj+58g/xoXht7
 jhWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795107838; x=1795712638; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tuGun+0zjW7dRUYikOaNsmwWDgkDAaBtu6YVJwMcddI=;
 b=xAOGF4/+EzUvEULwQvwh6erIBc0Bk+V91JVKVviy+kAMw88Z+Wd/zU62hg8iDLLA50
 /tDeTsjjTweiWO+rrYBhHJ0aI8gxmbEHp0Nak9W6oFqIGlLRpAsqLTamj5GxAS1zIoRC
 F4erDEGclC0T6Un8HG5kRT+T1P1yNXAJqN4cuTSvYxzNlowYdp+puM3vz2HyiS5L3Dlj
 AN7/tvT/UpqtnUXRPdF82RavZqKxEisSZkfhwEWXEIhIBCwptip+IwDBPz5HZ6JB8NjF
 ykKARNea/MGTnDfELQlSSZ9rG/Hz87KIYUBtS5KOcRrLpjUYP6L/pTSfJ9aszJDlA3W0
 9V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107838; x=1795712638;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tuGun+0zjW7dRUYikOaNsmwWDgkDAaBtu6YVJwMcddI=;
 b=bFznUfRQSGMbOiO5QxjeHmNQMaXkT8PoxWkwvKoTtbcLIS3w4ghalkCq9hrndJL6wQ
 36bs1xMn+ADvNDavY6Qlh7aQOFfk1KS6nmBnJzOtuMFSnrgZlCYb1RIGG3BNdRfNRnaV
 dA0NDbIF4vUiVQ511SydicXG6Ak0qWQUELpqZg2+fOtiK5OObmTfbCqLW2lQyGESH02T
 3LqPbWh8mSxRqkAv4sJM2YmHT4p6/zZxmXuJ4r9fCykaeyNOlTof8IWRB1Fc0y4A1XBQ
 e8mAook/RyVkebfQvct27fiWlM5b6W7KFLJNJ48F9ynacGsN//sNLS3ZgOJSG1nDzcq9
 vBqg==
X-Forwarded-Encrypted: i=1;
 AL+hErFztKX527CALh0+cIs6ImnyZM5u6U80x8cFGXuVxNuHJ39iwOHTYCR3c88f6RQ/BNtI+YhrNMXKGeA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/31IvdUyOnrjg4gkKOlpcF+UJSsqn+GHAIhtg6WHw2wjwfrl+e
 g5UMzteEnx6PPcCEtJDN/zRi5QH29K9y3QxxOM+KBOxomC1oYHh3oJ8Z3wjTA1a+FJJjg42FNJj
 6ki7jQ2xelVc4ZP3BCVcVRVHXmMrgOF4=
X-Gm-Gg: AYBFou1s4JFKsbxk+EsqfnKbGL9albjGrmLBWeYP5QGaj2RfltJboHGULI3QGwlMaWK
 MoOHJWGDGK5b1k7cPF1pmjLanOZ/c2I8z10u6RsoDug6Omy37sze4M9+OFLn1S6IUqFNQUIQg9s
 KGulYlOYedFwTZrN9Xo9ktR2DnRrwO8qwkWA8d1oDYSDuH1KJFQ3bWek0liq5rAFLzK0oRX1m0h
 Tg3xIX8O69p0Ck4tCnu7OBqhH48smJ2InGggls75O7nbt7lDYzFs4AAYITrn2IuaRX6giyNhTJP
 uja24orGH1Kz2vSfpWVnfQPzrtkk+zK9WgoICjbMHcIG4xyOsMxB+DWv/44U4KOd6jWY2jOlV2k
 cNKgI4t/EvMXaaiMgVKFrOs4f1WSPqwavrBjfJ3nwA2JdfEQmQqQe40F15AR8Sakc66lWVgU1ax
 VVXFIPtlUWpOtTOMFaTEHxRjGXPIPJGYw=
X-Received: by 2002:a05:6820:c0d1:10b0:6cd:3fdc:2664 with SMTP id
 006d021491bc7-71b395dde7fmr82537eaf.37.1795107837642; Thu, 19 Nov 2026
 09:03:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119142114.152052-1-tzimmermann@suse.de>
 <20261119142114.152052-2-tzimmermann@suse.de>
In-Reply-To: <20261119142114.152052-2-tzimmermann@suse.de>
From: Jie Feng <hjf3108@gmail.com>
Date: Fri, 20 Nov 2026 01:03:20 +0800
X-Gm-Features: Aa3M54p1Z7ZjenP4XkWfrFINWycd_rZ-DRlvxZfcqUU-F5xalNyIVDzYFMr-4bk
Message-ID: <CABOQOSVebjwJ4hmFYUYHX3JL1TDKcdH-sRUBf4CdmkfJ==qn8w@mail.gmail.com>
Subject: Re: [PATCH 01/11] drm/udl: Release URB in udl_put_urb()
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

On Fri, 20 Nov 2026 at 00:47, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Move URB cleanup from udl_urb_completion() to udl_put_urb().
> udl_put_urb() is the inverse of udl_get_urb(). The new helper will
> allow for further fixes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/udl/udl_drv.h  |  1 +
>  drivers/gpu/drm/udl/udl_main.c | 29 +++++++++++++++++------------
>  2 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
> index 145bb95ccc48..9535e9c59950 100644
> --- a/drivers/gpu/drm/udl/udl_drv.h
> +++ b/drivers/gpu/drm/udl/udl_drv.h
> @@ -73,6 +73,7 @@ int udl_modeset_init(struct udl_device *udl);
>  struct drm_connector *udl_connector_init(struct drm_device *dev);
>
>  struct urb *udl_get_urb(struct udl_device *udl);
> +void udl_put_urb(struct urb *urb);
>
>  int udl_submit_urb(struct udl_device *udl, struct urb *urb, size_t len);
>  void udl_sync_pending_urbs(struct udl_device *udl);
> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
> index 17950fe3a0ec..936fb6565bdb 100644
> --- a/drivers/gpu/drm/udl/udl_main.c
> +++ b/drivers/gpu/drm/udl/udl_main.c
> @@ -149,10 +149,6 @@ int udl_select_std_channel(struct udl_device *udl)
>
>  void udl_urb_completion(struct urb *urb)
>  {
> -       struct urb_node *unode = urb->context;
> -       struct udl_device *udl = unode->dev;
> -       unsigned long flags;
> -
>         /* sync/async unlink faults aren't errors */
>         if (urb->status) {
>                 if (!(urb->status == -ENOENT ||
> @@ -164,14 +160,7 @@ void udl_urb_completion(struct urb *urb)
>                 }
>         }
>
> -       urb->transfer_buffer_length = udl->urbs.size; /* reset to actual */
> -
> -       spin_lock_irqsave(&udl->urbs.lock, flags);
> -       list_add_tail(&unode->entry, &udl->urbs.list);
> -       udl->urbs.available++;
> -       spin_unlock_irqrestore(&udl->urbs.lock, flags);
> -
> -       wake_up(&udl->urbs.sleep);
> +       udl_put_urb(urb);
>  }
>
>  static void udl_free_urb_list(struct udl_device *udl)
> @@ -295,6 +284,22 @@ struct urb *udl_get_urb(struct udl_device *udl)
>         return urb;
>  }
>
> +void udl_put_urb(struct urb *urb)
> +{
> +       struct urb_node *unode = urb->context;
> +       struct udl_device *udl = unode->dev;
> +       unsigned long flags;
> +
> +       urb->transfer_buffer_length = udl->urbs.size; /* reset to actual */
> +
> +       spin_lock_irqsave(&udl->urbs.lock, flags);
> +       list_add_tail(&unode->entry, &udl->urbs.list);
> +       udl->urbs.available++;
> +       spin_unlock_irqrestore(&udl->urbs.lock, flags);
> +
> +       wake_up(&udl->urbs.sleep);
Using a completion might be cleaner than using a counter and a waitqueue?
P
> +}
> +
>  int udl_submit_urb(struct udl_device *udl, struct urb *urb, size_t len)
>  {
>         int ret;
> --
> 2.56.0
>
>

Best regards,
Jie Feng
