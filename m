Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A17606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqYySniO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DEE310E14C;
	Wed, 21 Oct 2026 09:47:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7092110FD2B
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:47:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2606F41FAB;
 Wed, 21 Oct 2026 09:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21541F000C9;
 Wed, 21 Oct 2026 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792576035;
 bh=GH8Qk1/WfxQSgJBi35NXz9t+jSl6sSOcHGyAocy4pfM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LqYySniObs+87c+0LGbPOvxS5PGqTiimUQmhR1S/Z8oiG6EZsDSiL9Lh6dR5NSYzJ
 TdVRgZCjhaQwby9jkoAhRlAkDo221zTHnI1LaQJAhnWHJ/PLWEskjf9r0YQDaOWMBg
 do4D9BZjErWpBDR8qDzmlsfXO9jeTpZ3rJrtYjuXa/ZW4ZrsxKX9OgGh94SEQVkEWA
 gUTYIgGHWhA1VpHn9MrNW9JPMht+vqfHG2rXDPxGjLEoPipUFND+YeY1X2g0SGCaJD
 jjW1CAc6E5cB27CQHViEhhICCrfctRn3GHiedtUr/ZX8gUQ7SCjGHUJpCqGRCQpLyg
 7Zhj+HvQU5E7A==
Message-ID: <sashiko-outbox-180068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: Add DMA_BUF_IOCTL_SET_RELEASE_EVENTFD
To: "Val Packett" <val@invisiblethingslab.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261021093533.1990028-1-val@invisiblethingslab.com>
References: <20261021093533.1990028-1-val@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 09:47:14 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] dma-buf: race in dma_buf_set_release_eventfd() causes eventfd =
UAF and leak
- [Medium] dma-buf: ioctl argument type mismatch in dma_buf_ioctl()
- [Medium] dma-buf: single overwritable release_eventfd allows disarming no=
tifications
--

commit 006342891462f158abfae40fb1d0a9db415351f4
Author: Val Packett <val@invisiblethingslab.com>

dma-buf: Add DMA_BUF_IOCTL_SET_RELEASE_EVENTFD

This commit introduces the DMA_BUF_IOCTL_SET_RELEASE_EVENTFD ioctl so
userspace can register an eventfd context to be signaled when a dma-buf
is released.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 36cdc342627ee..f6437a4e9284b 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
[ ... ]
> @@ -185,6 +186,11 @@ static void dma_buf_release(struct dentry *dentry)
>  	if (dmabuf->resv =3D=3D (struct dma_resv *)&dmabuf[1])
>  		dma_resv_fini(dmabuf->resv);
> =20
> +	if (dmabuf->release_eventfd) {
> +		eventfd_signal(dmabuf->release_eventfd);
> +		eventfd_ctx_put(dmabuf->release_eventfd);
> +	}
> +
>  	WARN_ON(!list_empty(&dmabuf->attachments));
>  	module_put(dmabuf->owner);
>  	kfree(dmabuf->name);
> @@ -537,6 +543,21 @@ static long dma_buf_import_sync_file(struct dma_buf =
*dmabuf,
>  }
>  #endif
> =20
> +static long dma_buf_set_release_eventfd(struct dma_buf *dmabuf,
> +					u32 fd)
> +{
> +	struct eventfd_ctx *ev_fd_ctx =3D eventfd_ctx_fdget(fd);
> +
> +	if (IS_ERR(ev_fd_ctx))
> +		return PTR_ERR(ev_fd_ctx);
> +
> +	if (dmabuf->release_eventfd)
> +		eventfd_ctx_put(dmabuf->release_eventfd);
> +
> +	dmabuf->release_eventfd =3D ev_fd_ctx;
> +	return 0;
> +}

[Severity: Critical]
Can concurrent DMA_BUF_IOCTL_SET_RELEASE_EVENTFD calls on the same dma-buf
race in dma_buf_set_release_eventfd() in drivers/dma-buf/dma-buf.c and cause
a use-after-free or leak of struct eventfd_ctx?

dma_buf_ioctl() runs from .unlocked_ioctl without holding a lock and calls
dma_buf_set_release_eventfd(). Unlike dma_buf_set_name(), which serializes
updates with dmabuf->name_lock, dma_buf_set_release_eventfd() reads, puts,
and overwrites dmabuf->release_eventfd without locking or an atomic exchang=
e:

Thread 1                                Thread 2
dma_buf_ioctl()                         dma_buf_ioctl()
  dma_buf_set_release_eventfd()           dma_buf_set_release_eventfd()
    if (dmabuf->release_eventfd)            if (dmabuf->release_eventfd)
      eventfd_ctx_put(release_eventfd);       eventfd_ctx_put(release_event=
fd);
    dmabuf->release_eventfd =3D ctx1;         dmabuf->release_eventfd =3D c=
tx2;

If dmabuf->release_eventfd is already set, both threads can observe the same
old pointer and call eventfd_ctx_put() on it twice, underflowing its refere=
nce
count and leading to a use-after-free when the eventfd is later signaled in
dma_buf_release() or closed.

Similarly, if Thread 1 assigns dmabuf->release_eventfd =3D ctx1 after Threa=
d 2
has already checked dmabuf->release_eventfd, Thread 2 will overwrite ctx1
with ctx2 without calling eventfd_ctx_put(ctx1), leaking the ctx1 reference
acquired by eventfd_ctx_fdget().

Should dmabuf->release_eventfd updates be synchronized with a lock or
xchg()?

> +
>  static long dma_buf_ioctl(struct file *file,
>  			  unsigned int cmd, unsigned long arg)
>  {
> @@ -587,6 +608,9 @@ static long dma_buf_ioctl(struct file *file,
>  		return dma_buf_import_sync_file(dmabuf, (const void __user *)arg);
>  #endif
> =20
> +	case DMA_BUF_IOCTL_SET_RELEASE_EVENTFD:
> +		return dma_buf_set_release_eventfd(dmabuf, (u32)arg);
> +
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d15b2b31d3c91..07b4a589a7935 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -429,6 +429,9 @@ struct dma_buf {
> =20
>  		__poll_t active;
>  	} cb_in, cb_out;
> +
> +	/** @release_eventfd: for userspace release notification */
> +	struct eventfd_ctx *release_eventfd;
>  };

[Severity: Medium]
What happens if more than one process registers a release eventfd on the
same struct dma_buf, or if a recipient of the dma-buf fd calls
DMA_BUF_IOCTL_SET_RELEASE_EVENTFD?

Because struct dma_buf in include/linux/dma-buf.h stores a single
release_eventfd pointer and dma_buf_set_release_eventfd() in
drivers/dma-buf/dma-buf.c drops and replaces any existing context:

	if (dmabuf->release_eventfd)
		eventfd_ctx_put(dmabuf->release_eventfd);

	dmabuf->release_eventfd =3D ev_fd_ctx;

if a host backend registers an eventfd and then passes the dma-buf file
descriptor over a socket to another process (such as a compositor or client)
that also invokes DMA_BUF_IOCTL_SET_RELEASE_EVENTFD, the first eventfd_ctx
is released via eventfd_ctx_put() without ever being signaled by
dma_buf_release().

Could that leave the original waiter blocked indefinitely waiting for buffer
release, and would a list of registered eventfd contexts (or rejecting
re-registration) avoid allowing one holder to disarm another's notification?

> =20
>  /**
> diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
> index e827c9d20c5d3..566dea778ad06 100644
> --- a/include/uapi/linux/dma-buf.h
> +++ b/include/uapi/linux/dma-buf.h
> @@ -179,5 +179,6 @@ struct dma_buf_import_sync_file {
>  #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
>  #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, struct dma=
_buf_export_sync_file)
>  #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct dma_=
buf_import_sync_file)
> +#define DMA_BUF_IOCTL_SET_RELEASE_EVENTFD	_IOW(DMA_BUF_BASE, 4, __u32)

[Severity: Medium]
Is DMA_BUF_IOCTL_SET_RELEASE_EVENTFD in include/uapi/linux/dma-buf.h intend=
ed
to take a user pointer to __u32 or a file descriptor value directly?

Here DMA_BUF_IOCTL_SET_RELEASE_EVENTFD is defined with _IOW(DMA_BUF_BASE, 4,
__u32), which indicates a user pointer argument, and dma_buf_fops in
drivers/dma-buf/dma-buf.c uses compat_ptr_ioctl:

static const struct file_operations dma_buf_fops =3D {
	...
	.unlocked_ioctl	=3D dma_buf_ioctl,
	.compat_ioctl	=3D compat_ptr_ioctl,
	...
};

However, dma_buf_ioctl() in drivers/dma-buf/dma-buf.c casts arg directly by
value instead of copying from a user pointer:

	case DMA_BUF_IOCTL_SET_RELEASE_EVENTFD:
		return dma_buf_set_release_eventfd(dmabuf, (u32)arg);

Callers or language bindings following the _IOW(..., __u32) definition and
passing a pointer to a __u32 will have the truncated pointer address treated
as the file descriptor, while passing an integer by value conflicts with
compat_ptr_ioctl(). Should dma_buf_ioctl() read the descriptor via
get_user() / copy_from_user() to match the _IOW(..., __u32) definition?

> =20
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021093533.1990=
028-1-val@invisiblethingslab.com?part=3D1
