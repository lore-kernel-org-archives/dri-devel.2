Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148C6CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7965B112118;
	Fri,  9 Oct 2026 13:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HciRhrKs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C5211211E
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:11:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C06960098;
 Fri,  9 Oct 2026 13:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BD31F000FF;
 Fri,  9 Oct 2026 13:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791551482;
 bh=tBGq2YWxOqF20P82M4nCR1m9mzE7GvQKJJv9QXYi+i0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HciRhrKs0ccmvEwH/dM62v/+0pU30RcB9pMXzJEHKKFPGPBSf33XFIzUd6QnEY7JW
 JLTo60yq7hqdAjCYMna5M2TI9EFNPyFm0lbyliuxMdISEZSCh2Q7Yh+6+BZckz++Cd
 IBcGiCtKmTWptImvlbgZ7gqNioqOhfrh0aDawJd3WwJ5MM/WNB7Y7NZL78SMnxRfL0
 v3xEz85Jn1Iri/kQjCfdAiJB3JEy7saCD45h62p4j7emqAScS95iU3Sivzfdec9MNo
 Q3s55z+M8EhHbdII/WFq1m63NR243Db4JaOiRPaKRA1hF6gCs1g8eDgJ1g8ZJ6slvA
 61xnAYXct++kA==
Message-ID: <sashiko-outbox-165603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] dma-buf: Annul dmabuf->file on file release
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261009123601.94079-3-matt@ozlabs.org>
References: <20261009123601.94079-1-matt@ozlabs.org>
 <20261009123601.94079-3-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:11:21 +0000
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
- [High] dma-buf: NULL pointer dereference of dmabuf->file in exporter driv=
ers
--

commit b5be810d5fa3244638a9bad8503cacb8ca86027e
Author: Matt Evans <matt@ozlabs.org>

dma-buf: Annul dmabuf->file on file release

This patch sets dmabuf->file to NULL in dma_buf_file_release() to prevent a
use-after-free window if the dentry outlives the file. By clearing the
pointer, exporters using get_file_active() can safely observe that the file
is closed.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 36cdc342627ee..d0f8b766e8fd1 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -193,11 +193,26 @@ static void dma_buf_release(struct dentry *dentry)
> =20
>  static int dma_buf_file_release(struct inode *inode, struct file *file)
>  {
> -	if (!is_dma_buf_file(file))
> -		return -EINVAL;
> +	struct dma_buf *dmabuf =3D file->private_data;
> +
> +	if (!dmabuf)
> +		return 0;
> =20
> -	__dma_buf_list_del(file->private_data);
> +	__dma_buf_list_del(dmabuf);
> =20
> +	/*
> +	 * As the file is being closed, dmabuf->file is no longer
> +	 * valid and NULL replaces an otherwise stale pointer.  If a
> +	 * reference to the file isn't already held, the file can be
> +	 * closed at any time, including before dmabuf->ops->release()
> +	 * happens: dmabuf->file _must not_ be accessed directly.  An
> +	 * exporter should use get_file_active(&dmabuf->file) which
> +	 * atomically tests and acquires a reference to the file (or
> +	 * returns NULL if the file has closed).  The barrier ensures
> +	 * get_file_active() observes the store before file_free()
> +	 * frees the memory.
> +	 */
> +	smp_store_mb(dmabuf->file, NULL);

[Severity: High]
Does setting dmabuf->file to NULL here cause a NULL pointer dereference in
exporter drivers that still hold a reference to the dma_buf?

For example, if a GEM object is exported to a DMA-BUF and the file descript=
or
is closed, the dma_buf is kept alive by the GEM object. If a user then reads
the debugfs file, amdgpu_bo_print_info() in
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c dereferences dmabuf->file:

		seq_printf(m, " imported from ino:%llu", file_inode(dma_buf->file)->i_ino=
);
	else if (dma_buf)
		seq_printf(m, " exported as ino:%llu", file_inode(dma_buf->file)->i_ino);

Similarly, during cleanup, amdgpu_ualink_cleanup_imp_xa_node() in
drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c attempts to read the file count:

	dev_dbg(adev->dev,
		"IMP-CLEANUP: dmabuf free for NPA:%llx handle:%llx:%llx, fc:%lu\n",
		imp_xa_node->npa_addr, imp_xa_node->handle.handle_hi,
		imp_xa_node->handle.handle_lo,
		file_count(imp_xa_node->dmabuf->file));

Could these routines trigger a kernel panic when dmabuf->file is NULL?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009123601.9407=
9-1-matt@ozlabs.org?part=3D2
