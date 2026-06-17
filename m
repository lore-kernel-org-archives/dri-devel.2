Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97CDCD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B6A010EB0D;
	Wed, 17 Jun 2026 20:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kaBjCCFK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC9610EB0D
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 20:44:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7F5F41667;
 Wed, 17 Jun 2026 20:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F881F000E9;
 Wed, 17 Jun 2026 20:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781729068;
 bh=abI4EJ6HjUtKXwBnxKk+3FdeYIBrA7YyZBZEC88oH9c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kaBjCCFK/plkvha+CtKEt389b5Dq/wAn9eyLfP6XQHCKOflmD0BdwApO8JAwVcD+4
 qf+YMuQkTRSLBS2ygyKFb3xJVwWqHIn+p6qLcEVO/XMNTUChFYqDDfDktb6Zx4z7jE
 gtGLfiCTc7LzBcuyL1j4xPXbgm6Lex6kiYUkN+TfThVeSDtGqbVa/iyG/9ynL+us7A
 GTiCT6bRdrxEJOvMUGWysh6EntxDHpwAZnvJpWR+KsQ5CwnLpBvv6ZnA/JLiuNj6jV
 w+lbM/ilwqzLgSZU1gjH0TBokxRvdF0NxRNMYfi96wVpzoZmXfj8s4EjhTuTenRjVJ
 rmSGYVxwaJ+Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/habanalabs: publish mmap buffers after allocation
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617182109.953680-1-ruoyuw560@gmail.com>
References: <20260617182109.953680-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:44:28 +0000
Message-Id: <20260617204428.82F881F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free and IDR corruption due to uninitialized `buf->handl=
e` during concurrent access.
--

commit 9226a7a050a5049d6df96f0ca7493dec14b9b65d
Author: Ruoyu Wang <ruoyuw560@gmail.com>

accel/habanalabs: publish mmap buffers after allocation

This commit attempts to prevent racing lookups on newly allocated mmap
buffers by initializing the descriptor and running the behavior allocation
callback before publishing the object in the IDR.

> diff --git a/drivers/accel/habanalabs/common/memory_mgr.c b/drivers/accel=
/habanalabs/common/memory_mgr.c
> index 9fdd34acf389f..b5b92dbbe5ddd 100644
> --- a/drivers/accel/habanalabs/common/memory_mgr.c
> +++ b/drivers/accel/habanalabs/common/memory_mgr.c
[ ... ]
> @@ -156,6 +156,17 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
[ ... ]
>  	spin_lock(&mmg->lock);
>  	rc =3D idr_alloc(&mmg->handles, buf, 1, 0, GFP_ATOMIC);
>  	spin_unlock(&mmg->lock);
> @@ -163,27 +174,16 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
>  		dev_err(mmg->dev,
>  			"%s: Failed to allocate IDR for a new buffer, rc=3D%d\n",
>  			behavior->topic, rc);
> -		goto free_buf;
> +		goto destroy_buf;
>  	}
> =20
> -	buf->mmg =3D mmg;
> -	buf->behavior =3D behavior;
>  	buf->handle =3D (((u64)rc | buf->behavior->mem_id) << PAGE_SHIFT);

[Severity: High]
This is a pre-existing issue, but does assigning buf->handle after releasing
mmg->lock leave a window for use-after-free and IDR corruption?

If a concurrent thread discovers this buffer in the IDR via a lookup and
then triggers a destruction path before buf->handle is set, the destruction
path will use the uninitialized buf->handle (which is 0 from kzalloc) to
calculate the IDR index:

hl_mmap_mem_buf_remove_idr_locked() {
    idr_remove(&buf->mmg->handles, lower_32_bits(buf->handle >> PAGE_SHIFT)=
);
}

Because buf->handle is 0, this removes index 0 instead of the actual IDR
index. The actual IDR entry is left pointing to the buffer, which is then
freed by hl_mmap_mem_buf_destroy().

When the allocating thread resumes, it will write to buf->handle, causing a
write-after-free, and leaving a dangling pointer in the IDR.

Could buf->handle be assigned while still holding mmg->lock to ensure the
handle is fully initialized before the buffer is visible to other threads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617182109.9536=
80-1-ruoyuw560@gmail.com?part=3D1
