Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD0606A333
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aghFouHX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B410810E3D9;
	Sun, 22 Nov 2026 00:11:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E340210E3D9
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:11:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C3AEB61C79;
 Sun, 22 Nov 2026 00:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5731F000C6;
 Sun, 22 Nov 2026 00:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795306292;
 bh=m7s7Xa6rrd7cr8qC0aVtfhU1YIDVWAjohRUVAD0IZAY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aghFouHX2FtIlrNU9T36sGfpe7HVRiutNjQRQM70lyLodbKj0jLwtNbAtJwTHqUe+
 GKF5S9J/2X5lADlIAJFe7Ps5HQpgSo4mQr0De10dI1iyOx/YLaXM+SE/vJIl+wVsLK
 6vpj4r5BCG1VhDlse3UXGfUdhN8bJG1956KytKw9lpfi0VWfssMdSQCpqsU0ucnTb4
 kcaEGARGMUDRcfPmlEJ/tIIwOs9YELL5JUUE0Gwuhx8uCEvulL9Pcjpa6rjUrFR+aQ
 +7Arqt1MGSz3wBqE77qYLimOrdAQwQ1k8iSkn5FHF6eXg8spZ/5Fo1Wa3fiXsneL9q
 bDU9xqAsh5a0Q==
Message-ID: <sashiko-outbox-227561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: fix leak of ctx and dmabuf reference in
 dma_buf_io_ctx_create() WARN path
To: Falconet3 <Falconet3@proton.me>
Cc: =?utf-8?b?ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw==?=
 <dri-devel@lists.freedesktop.org>, media-ci@linuxtv.org
In-Reply-To: <htm5h9oaY-vk0g9JVYJmz5XCaKe_nPoWkUJYJqDulyNvv_sAWfzSMp0T6GWt5okc8R4SyvXXpJQ3VGhetKnjEa2KGem5uCYdxpmdzUFf6XA=@proton.me>
References: <htm5h9oaY-vk0g9JVYJmz5XCaKe_nPoWkUJYJqDulyNvv_sAWfzSMp0T6GWt5okc8R4SyvXXpJQ3VGhetKnjEa2KGem5uCYdxpmdzUFf6XA=@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 00:11:31 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] dma-buf: use-after-free on WARN_ON_ONCE path in
  dma_buf_io_ctx_create()
- [Low] dma-buf: malformed Fixes trailer and scratch notes in commit
  message
--

commit e9d30f7c9b6146d91fac7e600ae7718d7d49f057
Author: Falconet3 <Falconet3@proton.me>

> dma-buf: fix leak of ctx and dmabuf reference in dma_buf_io_ctx_create() =
WARN path
>
> (leak of ctx + dmabuf ref on the WARN_ON_ONCE path, new file in v7.4-rc1,=
 patch attached)
>
> The file drivers/dma-buf/dma-buf-io.c (and the io_uring dmabuf regbuf
> feature on top of it) is new in v7.4-rc1. In dma_buf_io_ctx_create(),
> the error path of init_dma_buf_io_ctx() correctly does
> kfree(ctx) + dma_buf_put(dmabuf) (dma-buf-io.c:178-182), but the
> WARN_ON_ONCE() path right below it returns -EINVAL without freeing
> either (dma-buf-io.c:184-188):
>
>         if (WARN_ON_ONCE(!ctx->dev_ops || ...))
>                 return -EINVAL;          /* leaks ctx and the get_dma_buf=
() ref */
>
> Reachable from userspace via io_uring buffer registration
> (IORING_REGISTER_BUF / rsrc update with IO_REGBUF_TYPE_DMABUF,
> io_uring/dma-buf.c -> dma_buf_io_ctx_create()) whenever an importer's
> init_dma_buf_io_ctx() succeeds but leaves dev_ops incomplete:
> kernel memory + dma-buf reference leak (DoS-grade).
>
> Affects v7.4-rc1..v7.4-rc3 only; the file does not exist in v7.3.5.
>
> Fix was verified with git apply --check against v7.4-rc3; not
> build-tested and no reproducer available in this environment.
>
> Fixes: FILL-IN-SHA ("dma-buf: introduce ... file I/O ...")
> Assisted-by: LLM Mistral Vibe
> Signed-off-by: Falconet3 <Falconet3@proton.me>

[Severity: Low]
The Fixes trailer is still a placeholder and should be:

  Fixes: 0d3120db2cbe ("dma-buf: introduce initial file I/O infrastructure")

Also, the submission scratch notes at the top and bottom should be dropped
from the changelog, and the claim that this path is reachable from
userspace is inaccurate because the only in-tree init_dma_buf_io_ctx()
implementation (nvme_init_io_ctx_locked()) populates all three callbacks in
nvme_dma_buf_io_ops.

> diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
> index 8440151de8600..d4d37e109a7e4 100644
> --- a/drivers/dma-buf/dma-buf-io.c
> +++ b/drivers/dma-buf/dma-buf-io.c
> @@ -184,8 +184,11 @@ int dma_buf_io_ctx_create(struct file *file,
>  	if (WARN_ON_ONCE(!ctx->dev_ops ||
>  			 !ctx->dev_ops->map ||
>  			 !ctx->dev_ops->unmap ||
> -			 !ctx->dev_ops->release))
> +			 !ctx->dev_ops->release)) {
> +		kfree(ctx);
> +		dma_buf_put(dmabuf);
>  		return -EINVAL;
> +	}
> =20
>  	*out_ctx =3D ctx;
>  	return 0;

[Severity: Medium]
Can freeing ctx and dropping its dmabuf reference here cause a
use-after-free once file->f_op->init_dma_buf_io_ctx() has succeeded?

When init_dma_buf_io_ctx() returns 0, the importer has already attached ctx
to dmabuf and linked it into importer tracking lists:

drivers/nvme/host/pci-dmabuf.c:nvme_init_io_ctx_locked() {
	...
	attach =3D dma_buf_dynamic_attach(ctx->dmabuf, ctrl->dev,
					&nvme_dmabuf_importer_ops, ctx);
	...
	list_add(&nvme_ctx->list, &buf_list->ctxs);
	nvme_ctx->attach =3D attach;
	nvme_ctx->base =3D ctx;
	...
}

As in dma_buf_io_ctx_release(), ctx->dev_ops->release(ctx) must run before
dma_buf_put() and kfree(ctx) to detach the importer and remove ctx from its
tracking list.  Freeing ctx directly without detaching leaves dangling
pointers in attach->importer_priv and nvme_ctx->base, causing a
use-after-free on subsequent mapping invalidation or controller teardown in
__nvme_pci_remove_dmabuf().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2xySoxkTOy_cwwTsVb3=
MjcYIN2J0LJftOab-bhMICCuE_LxaBfqRKUCBOrBQQpQeTBzizv3ci1RqJH09_VL9RbAFk9n8dv=
QO9YaWIoIT7tE=3D@proton.me?part=3D1
