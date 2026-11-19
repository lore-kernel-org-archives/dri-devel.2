Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232A8606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6qG5LM1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA5EB1124DC;
	Thu, 19 Nov 2026 14:47:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD071124DC
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:47:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED92E44250;
 Thu, 19 Nov 2026 14:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B631F000C7;
 Thu, 19 Nov 2026 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795099636;
 bh=5Z/ndMB+b8oYyalCg6KdXYCAkEmWVrgUaaAQQDpOPWQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W6qG5LM1hm0w8GBGu0i4x4Y65ehrfsAq1GeAQ+2fNPNMVBIbqURxJdwVKnN15KQR/
 Pq9QcnILSOomXOMthDQ/Yg4VxR4YITSg6sABi+bFjxb8xXl0PnIz1tfncM8eYq/u7e
 mPLDLquwi2/VWRzK5w55bx1tHSFK4QXQQD/MTlYrgJxw7Ono9Cp8233umKLWmZTGSa
 tMdfexjiq+v4sZctpLY6xjmzOvRm8HW4sCPEroBvnvjCMyD5+3CNFnJVhKVYlR0dKs
 phc5Ws8Imb/e0LtMxoH+BUTwt/7iQ3gL2K+eApe8HrwFnvaEax8KrictJaVW25xfWH
 q9sR8SwdTw6mQ==
Message-ID: <sashiko-outbox-223315@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] drm/udl: Allocate URBs on demand
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119142114.152052-11-tzimmermann@suse.de>
References: <20261119142114.152052-1-tzimmermann@suse.de>
 <20261119142114.152052-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 14:47:16 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/udl: missing size fallback and in-flight wait in
  udl_get_urb()
--

commit 2b67449c9bc54fc48767cd1733efcaed21d924b2
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/udl: Allocate URBs on demand

This commit removes the fixed upfront allocation of URBs and instead
allocates URBs on demand in udl_get_urb(), caching them for reuse across
frames.

> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_mai=
n.c
> index d0195bd4213df..adddcf4b34518 100644
> --- a/drivers/gpu/drm/udl/udl_main.c
> +++ b/drivers/gpu/drm/udl/udl_main.c
[ ... ]
> @@ -244,71 +257,16 @@ static void udl_urb_list_release(void *data)
>  	udl_free_urb_list(udl);
>  }
> =20
> -static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t =
size)
> +static int udl_init_urb_list(struct udl_device *udl)
>  {
>  	struct drm_device *drm =3D &udl->drm;
> -	size_t wanted_size =3D count * size;
> -	int ret;
> =20
>  	spin_lock_init(&udl->urbs.lock);
>  	INIT_LIST_HEAD(&udl->urbs.list);
>  	init_waitqueue_head(&udl->urbs.sleep);
> -	udl->urbs.count =3D 0;
>  	udl->urbs.in_flight =3D 0;
> =20
> -retry:
> -	while (udl->urbs.count * size < wanted_size) {
> -		struct urb *urb;
> -		struct urb_node *unode;
> -
> -		urb =3D udl_alloc_bulk_urb(udl, size);
> -		if (IS_ERR(urb)) {
> -			if (PTR_ERR(urb) =3D=3D -ENOBUFS && size > PAGE_SIZE) {
> -				size /=3D 2;
> -				udl_free_urb_list(udl);
> -				goto retry;
> -			}
> -			break;
> -		}
> -		unode =3D urb->context;
> -
> -		list_add_tail(&unode->entry, &udl->urbs.list);
> -
> -		udl->urbs.count++;
> -	}
[ ... ]
> @@ -321,9 +279,18 @@ struct urb *udl_get_urb(struct udl_device *udl)
>  			return NULL;
>  		++udl->urbs.in_flight;
> =20
> -		urb =3D udl_get_urb_locked(udl, HZ * 2);
> -		if (!urb)
> -			--udl->urbs.in_flight;
> +		urb =3D __udl_get_cached_urb_locked(udl);
> +	}
> +
> +	if (!urb) {
> +		urb =3D udl_alloc_bulk_urb(udl, MAX_TRANSFER);
> +		if (IS_ERR(urb)) {
> +			scoped_guard(spinlock_irqsave, &udl->urbs.lock) {
> +				if (udl->urbs.in_flight)
> +					--udl->urbs.in_flight;
> +			}
> +			return NULL;
> +		}
>  	}
> =20
>  	return urb;

[Severity: Medium]
Should udl_get_urb() fall back to smaller allocation sizes or wait for an
in-flight URB when udl_alloc_bulk_urb(udl, MAX_TRANSFER) fails?

MAX_TRANSFER is PAGE_SIZE * 16 - BULK_SIZE, which requires an order-4
contiguous coherent DMA allocation via usb_alloc_coherent().  Previously,
udl_alloc_urb_list() handled -ENOBUFS by halving the buffer size down to
PAGE_SIZE (added in 542bb9788a1f ("udl-kms: handle allocation failure")),
and udl_alloc_bulk_urb() still records unode->alloc_size and returns
-ENOBUFS for this purpose.

Because URBs are now allocated on demand during modesets and frame updates
when memory may be fragmented, a single order-4 allocation failure causes
udl_get_urb() to return NULL immediately (even when other URBs are already
in flight), aborting udl_crtc_helper_atomic_enable() or udl_handle_damage()
and leaving the display blank or partially updated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119142114.1520=
52-1-tzimmermann@suse.de?part=3D10
