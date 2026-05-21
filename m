Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14435CD4F5E
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 11:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D7710E17D;
	Thu, 21 May 2026 11:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MzvzRj1/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F60310E17D
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:54:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B37AE40687;
 Thu, 21 May 2026 11:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724561F000E9;
 Thu, 21 May 2026 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779364484;
 bh=vdgcnrs1cNHhDQfHkBD3F2KXqzLos0onnjN5eObbKJQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MzvzRj1/Ap+XqH85Rq3LmLGdPPDoXrwKoypYeXF1yAVGwiEWIvVTD3mV8G3oQDutf
 bZjmKFbv6q74nL9jB4a7IGQxmhrhyAXMSfiMDOTnmpjCnkqeK3YIfC4k6Y+YnFbMvR
 4r4LDxAcpqCVsYUT0W1eaNQw58DDCJmNewLLElQAUR6bqxb7WtQTxL/ORc/Xo7GIKV
 8xllVdwyjF8T4z0oXoW3F6VZsTAa60BahrtKkyGQ5ABPTIJ3XylwRgVNfFSNrLXTyp
 lvL4wXH06yp/qc+Mh8M4BzpcZXyJTHsM1cPW0WTt1bFy2vLJgt2v1KqtNqpMi28Juo
 08WqfqD+uWPEQ==
Date: Thu, 21 May 2026 13:54:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] dma-buf: set SB_I_NOEXEC on the pseudo filesystem
Message-ID: <20260521-dilettanten-klarzukommen-9351cba40c06@brauner>
References: <20260520214350.168689-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520214350.168689-1-jhubbard@nvidia.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, May 20, 2026 at 02:43:50PM -0700, John Hubbard wrote:
> The dma-buf pseudo filesystem dispenses S_ANON_INODE inodes via
> alloc_anon_inode() but never sets SB_I_NOEXEC on its superblock.
> Since commit 1e7ab6f67824 ("anon_inode: rework assertions") in 6.17,
> path_noexec() warns on exactly that combination, so an mmap() on any
> dma-buf fd trips the warning:
> 
>   WARNING: CPU: 11 PID: 121813 at fs/exec.c:118 path_noexec+0x47/0x50
>    do_mmap+0x2b5/0x680
>    vm_mmap_pgoff+0x129/0x210
>    ksys_mmap_pgoff+0x177/0x240
>    __x64_sys_mmap+0x33/0x70
> 
> dma-bufs have no business being executable, which is the invariant
> that the new assertion is enforcing. Set SB_I_NOEXEC on the dmabuf
> superblock.
> 
> Reproducer on a CONFIG_DEBUG_VFS=y kernel:
> 
>   make -C tools/testing/selftests/dmabuf-heaps
>   sudo ./tools/testing/selftests/dmabuf-heaps/dmabuf-heap -t system
> 
> The selftest allocates from /dev/dma_heap/system and mmaps the
> returned fd, which trips the warning without this patch.
> 
> Fixes: 1e7ab6f67824 ("anon_inode: rework assertions")
> Cc: stable@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Perfect, the asserts are paying off. Thanks!
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

>  drivers/dma-buf/dma-buf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 71f37544a5c6..d86a99d7b8dc 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -216,6 +216,7 @@ static int dma_buf_fs_init_context(struct fs_context *fc)
>  	if (!ctx)
>  		return -ENOMEM;
>  	ctx->dops = &dma_buf_dentry_ops;
> +	fc->s_iflags |= SB_I_NOEXEC;

While you're at it, also raise SB_I_NODEV. You're not creating any
device nodes and this is additional hardening.
