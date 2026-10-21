Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9BC606A31B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=LmwkFp4F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D10710E078;
	Wed, 21 Oct 2026 21:03:31 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F6810E078
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 21:03:24 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-91c11468b5fso12004276d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1792616603; x=1793221403;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rvo1oLlBWLz8SC/wpkS1QHxq0y/4tjxHxfXQ9wd7SCo=;
 b=LmwkFp4F8SmW7kAtBnIR9gsTgno/qsrDdSAlbbfurxnyJOCT8BWZ9Nb5VnqatAXFa3
 MuhOnZtTYcnAs+LbfqVR6AvL2KjRPAakskBSejMC3lSWzd49kZTPpDHKDTz1RPMrUYCb
 kU/CBl7LnnajY8aQU04U+BiLOnHuyucjnJPQUcBQEdjJkYULoH77hvYSILiOH8WXn0u1
 CUPC8DPhKB5n4wJdSYKzMPYpVTFmxGKzPi6L2ndCMkAUkY+Eg6OoI5dRoMe0wr2+/p9K
 cHVPrIiwy26YFuI6nLMLctAPJmjshVsFD3cOwvByn6XaUGIUdhjpjke8Xsj9kEBMpRp0
 r34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792616603; x=1793221403;
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rvo1oLlBWLz8SC/wpkS1QHxq0y/4tjxHxfXQ9wd7SCo=;
 b=V3W2vRxqWaVaVSUelo2nIUFdhxOC6bcxZuUe1IxWFdcoZg/YlLJwusXmd7jNbtc3Pz
 jcWXAZtWExaS/EWI4Y2tRGjxFaTNXihDBjN6EhoDLzhA9FQsdgq4Rg9vUVXAQFsp8wS9
 AqL7n46C0n86msPSV6d0YtXTTOnJdX+Dlu2SRRaq2NMUeHts93HlVfnkry0ob4pw+Ggv
 JhMq+HG7+42nYBmXrJVY+FA/kz/kM6aPYrY8rdzwtao9+WH/nl3P1uOVLRiTqRTU74Mn
 pLmjguvY1znrZ/B1FwjAZudc/FTyWakT5WjXk+lv2OcU/pt5hwPfAJLtijfd3ffenM9C
 8X4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3zYHrdKqvRoEHMrsIE4a/RkgnR13EngFKtyDD4QOJq9XKm4P8BWAEG5ngQlcKVyibxNCle/UitX4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJEKE0f3E19v7T6bdpRm3eIv4q4l4D+wlCQBbUsjeoMHTlKwX7e
 Tdi23g8LXqX75HUYILydJalNSraBewkaGV9cN72Aamdqw0J6KlIDqvDVcaManN97ZK8=
X-Gm-Gg: AYBFou2XRncZGVv3diXOZs7+e9AGizE7sr3ptmmCOBJqz1B/feTf+Tp7tCdg5FK612B
 yspa+t0oelHm7sOsJzlZoE2enNjqFxbi7baVJ4LzuUb7dkrGDADfjF2rWW40b6iQ+uFGUnVdD8U
 FEe7vUzA6NtPWrnGNS6YV4PNaI8KRGesQtKvD8J8TwYD6jxDAP+f2S7InqRrL4/BtOSU1G6D2tp
 YZolu4ygh/14xw7uMrYKBpd+TH9vtn5cfY/0X7qcf0VkeSxVA/eCQNfeVulXde9e7QB13GRD3Ua
 NajuMtcgRC0eRr6xxofmvIA9ENqmwU/0odYVxMgc9P0s9gbrCMFYB+hEB72ynwdNuO7RMHvkndC
 sNgiYlaEvASFBQz62VjXu/O9J1tMlGaRY4kLcRlsExFFpmxOEi9cRZ1VKDuo2Xl73pIgalIIZmQ
 TPNOWSICw7h5m1KsDdv/xNhX9ozfM92P4cy4jsuu9+4wAIqnJXXTz1H7ievRCHaXvPuhDyJEg1m
 Ogk9poSHOiypHpxiYgHSvFQ1Db8TBr+NNfkCvRIOOg5u7TpXqnchMjN4QrxhTf62MLko27mc29D
 t/L5Qg==
X-Received: by 2002:a05:6214:4606:b0:914:45c3:7920 with SMTP id
 6a1803df08f44-91c12ee4515mr55915706d6.31.1792616603478; 
 Wed, 21 Oct 2026 14:03:23 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:34bd::5ac? ([2606:6d00:11:34bd::5ac])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c10bd5d8csm33919576d6.24.2026.10.21.14.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 14:03:21 -0700 (PDT)
Message-ID: <3084b9bc0d4b5593d2bfbfecb0ce272cb813ece9.camel@ndufresne.ca>
Subject: Re: [PATCH 2/4] media: videobuf2: add opt-in DMA-BUF CPU access
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa
 <tfiga@chromium.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, linux-media@vger.kernel.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Hans de Goede	 <hansg@kernel.org>, Hans Verkuil
 <hverkuil@kernel.org>, Benjamin Gaignard	
 <benjamin.gaignard@collabora.com>, Tomasz Stanislawski	
 <t.stanislaws@samsung.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, 	linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Date: Wed, 21 Oct 2026 17:03:19 -0400
In-Reply-To: <20261021175900.GG15441@killaraus.ideasonboard.com>
References: <cover.1792392288.git.kmehltretter@gmail.com>
 <673c04ad9dcc4f12685c076193ebad9e48e5f08d.1792392288.git.kmehltretter@gmail.com>
 <CAAFQd5Djx0kjeFpzPWEgRV5_MhiJAW8tg-2C+cYxqMf45u_-RA@mail.gmail.com>
 <20261021175900.GG15441@killaraus.ideasonboard.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-juzhAGcbo9MJ5wmh/cX5"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-juzhAGcbo9MJ5wmh/cX5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 21 octobre 2026 =C3=A0 20:59 +0300, Laurent Pinchart a =C3=A9cr=
it=C2=A0:
> > It sounds like this series focuses on uvcvideo and vivid, which likely
> > means that 1) alone would be enough to fix the original problem. WDYT?
>=20
> I think the dma-buf API doesn't give us what we need. Cleaning the CPU
> cache through end_cpu_access() when the producer is done writting to the
> buffer is right in some use cases, but not in all of them. It assumes
> that the next consumer will access the data through DMA, which isn't
> always the case. What I think we need is to track the state of the
> cache(s) in the dma_buf, and perform cache management operations
> accordingly when needed. In the uvcvideo -> display use case for
> instance, the dma_buf should track that the CPU cache is dirty when
> finishing CPU access, and should be cleaned on the display side before
> performing the DMA. In a use case where the producer would DMA to the
> buffer, cache management would be skipped as the dma_buf would see that
> the cache is not dirty.

I also second this as the only viable option. Its not only about uvcvideo, =
but
any memory imported by a driver doing DMA (which is not also the exporter).=
 That
includes udmabuf usage. These days, cache artifacts are visible with Intel
display controllers, and Intel mobile GPU drivers. Note that GStreamer prop=
erly
signal CPU read/write using DMABuf sync ioctl.

For most Intel laptop user with GStreamer 1.28, these example produce artif=
acts
on movement. To me, the solution is to track the cache state according to t=
he
access signalling (either userspace or driver), and let DMA user/consumer d=
ecide
if a cache flush is needed. There is a obvious challenge in keeping this st=
ate
coherent whenever there is multiple consumer, of if some broken application=
 do
concurrent write. Result for the last will always be undefined, but the dma=
buf
CPU cache state should not be undefined.

UVC reproducer:
  gst-launch-1.0 v4l2src ! waylandsink

udmabuf reproducer:
  gst-launch-1.0 videotestsrc pattern=3Dball ! waylandsink

Nicolas

p.s. since Intel GPU these days is also affected, you can swap waylandsink =
with
glimagesink and you will also see artifacts. One may blame Intel, I believe=
 they
made the choice of performance over correctness in absence of capable HW or
dmabuf signalling.

--=-juzhAGcbo9MJ5wmh/cX5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCatkolwAKCRDZQZRRKWBy
9Et/APkB+aV3rNqA9frRLxXO+16dYuS0kBW1ojM4JNmBmGIr6gEAo6QGPTHCgiKQ
72TDoedSkF7QsuqeQOHdxaRy+atLJAo=
=WHwY
-----END PGP SIGNATURE-----

--=-juzhAGcbo9MJ5wmh/cX5--
