Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F10606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1345810E4D5;
	Thu, 29 Oct 2026 13:19:31 +0000 (UTC)
Received: from aposti.net (aposti.net [185.119.170.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8213C10E4D5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:19:29 +0000 (UTC)
Message-ID: <7fd62daa875e4a3772e980127d368704a849caee.camel@crapouillou.net>
Subject: Re: [PATCH] usb: gadget: f_fs: Remove deprecated dma_fence->ops
From: Paul Cercueil <paul@crapouillou.net>
To: Philipp Stanner <phasta@kernel.org>, Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Al Viro <viro@zeniv.linux.org.uk>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Sam Day <me@samcday.com>,
 Michael Bommarito	 <michael.bommarito@gmail.com>, Gabriel Prostitis
 <prostitisgabriel@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Date: Thu, 29 Oct 2026 14:19:23 +0100
In-Reply-To: <20261029125143.1744481-2-phasta@kernel.org>
References: <20261029125143.1744481-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Philipp,

Le jeudi 29 octobre 2026 =C3=A0 13:51 +0100, Philipp Stanner a =C3=A9crit=
=C2=A0:
> The dma_fence_ops function ops->release() has been deprecated because it
> prevents drivers from unloading. f_fs's implementation merely frees the
> fence. The dma_fence backend performs this deallocation automatically in
> the correct manner if ops->release() is not implemented.
>=20
> The backend simultaneously correctly frees struct ffs_dma_fence since
> struct dma_fence is its base class.

For context, this .release() callback was added to avoid the implicit free =
of
the base class, which IIRC was a request I got during the review process of=
 this
change set.

I'm personally fine with the change, but do we need a "keep this field at t=
he
top" comment for the base class in the ffs_dma_fence struct? Or what's the
policy here?

Cheers,
-Paul

>=20
> Remove ops->release().
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> =C2=A0drivers/usb/gadget/function/f_fs.c | 9 ---------
> =C2=A01 file changed, 9 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/function/f_fs.c
> b/drivers/usb/gadget/function/f_fs.c
> index c64a268e98a4..e8672b37e890 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1479,18 +1479,9 @@ static const char *ffs_dmabuf_get_timeline_name(st=
ruct
> dma_fence *fence)
> =C2=A0	return "";
> =C2=A0}
> =C2=A0
> -static void ffs_dmabuf_fence_release(struct dma_fence *fence)
> -{
> -	struct ffs_dma_fence *dma_fence =3D
> -		container_of(fence, struct ffs_dma_fence, base);
> -
> -	kfree(dma_fence);
> -}
> -
> =C2=A0static const struct dma_fence_ops ffs_dmabuf_fence_ops =3D {
> =C2=A0	.get_driver_name	=3D ffs_dmabuf_get_driver_name,
> =C2=A0	.get_timeline_name	=3D ffs_dmabuf_get_timeline_name,
> -	.release		=3D ffs_dmabuf_fence_release,
> =C2=A0};
> =C2=A0
> =C2=A0static int ffs_dma_resv_lock(struct dma_buf *dmabuf, bool nonblock)
