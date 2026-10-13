Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E629CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB2110F9D1;
	Tue, 13 Oct 2026 21:23:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8249810F9CD
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:23:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 359494241D;
 Tue, 13 Oct 2026 21:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A511F00893;
 Tue, 13 Oct 2026 21:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791926616;
 bh=jzyXKGbVkuoeho0qqy5SSr+BcSXl5Xzhf6Jn/mnzPf0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ATmOwUZtIpU3T5yCtsPtADWwIZX3UTK0eKSpl630vEtXJEGsUXzrtt8zxl3i6ROE6
 TIxTjBTcRNEiN9/ky5+pna4EnesEPDkjGMZsT5pYrWIR/6/52YyqYx4BdIAneEpyd0
 m/fJzNg8T60vvOXoxJTLMaW8hfsWz2XFJunX0jbnq4i0TTbt5BjknhC+PEeLVItDAm
 wcaD/vTSV1014npfV2PO7eFsiZEWil9EG45+O01wybDhJYW2qKAcMYnkGyKngqgQH5
 WlSA85yOBc0wjS924ArPQ4P8UDrC+A2Tgf/6b41bcxAnq4S8iate7lP1y9RHbyVA/V
 BPpHi8XWdZ/FA==
Message-ID: <sashiko-outbox-170530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/13] nvme-pci: implement dma-buf backed requests
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <a8c9ff112d4295e7a3f7c361e03f03ee5eb42e74.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
 <a8c9ff112d4295e7a3f7c361e03f03ee5eb42e74.1791924581.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 21:23:35 +0000
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
- [High] nvme: missing controller state check allows attaching DMA-BUF to d=
ead PCI device
--

commit 6741fe43dc1132ae4f51db272567ac5b56987f17
Author: Pavel Begunkov <asml.silence@gmail.com>

nvme-pci: implement dma-buf backed requests

This patch implements DMA-BUF backed requests for the NVMe PCI driver. It
allows mapping DMA-BUFs on registration and storing them as a PRP list to
initialize requests. Attached contexts are tracked in a new list
synchronized with a lock.

> diff --git a/drivers/nvme/host/pci-dmabuf.c b/drivers/nvme/host/pci-dmabu=
f.c
> new file mode 100644
> index 0000000000000..8dab59d936507
> --- /dev/null
> +++ b/drivers/nvme/host/pci-dmabuf.c

[ ... ]

> +static int nvme_init_io_ctx_locked(struct nvme_ctrl *ctrl,
> +		struct nvme_dma_buf_list *buf_list,
> +		struct dma_buf_io_ctx *ctx)
> +{
> +	struct nvme_dma_buf_io_ctx *nvme_ctx;
> +	struct dma_buf_attachment *attach;
> +
> +	nvme_ctx =3D kzalloc_obj(*nvme_ctx);
> +	if (!nvme_ctx)
> +		return -ENOMEM;
> +
> +	attach =3D dma_buf_dynamic_attach(ctx->dmabuf, ctrl->dev,
> +					&nvme_dmabuf_importer_ops, ctx);

[Severity: High]
Does this code allow attaching a DMA-BUF to a tearing-down or dead PCI devi=
ce?

If the PCI device is hot-unplugged or its driver is unbound, nvme_remove()
calls nvme_dev_disable() which cleans up existing DMA-BUF contexts via
nvme_pci_remove_dmabuf().

Since nvme_get_ctrl() only pins the char device, not the underlying
PCI device binding, could an unprivileged user with an open file descriptor
to the block device invoke the register buffers ioctl and race with
device removal?

> +	if (IS_ERR(attach)) {
> +		kfree(nvme_ctx);
> +		return PTR_ERR(attach);
> +	}
> +
> +	nvme_get_ctrl(ctrl);
> +	list_add(&nvme_ctx->list, &buf_list->ctxs);
> +	nvme_ctx->attach =3D attach;
> +	nvme_ctx->base =3D ctx;
> +	nvme_ctx->ctrl =3D ctrl;
> +	nvme_ctx->buf_list =3D buf_list;
> +	ctx->dev_priv =3D nvme_ctx;
> +	ctx->dev_ops =3D &nvme_dma_buf_io_ops;
> +	return 0;
> +}
> +
> +int __nvme_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
> +		struct nvme_dma_buf_list *buf_list,
> +		struct dma_buf_io_ctx *ctx)
> +{
> +	int ret;
> +
> +	mutex_lock(&buf_list->lock);
> +	ret =3D nvme_init_io_ctx_locked(ctrl, buf_list, ctx);

[Severity: High]
Is a controller state check needed here before proceeding with the attachme=
nt?

Without verifying ctrl->state, this function can successfully add a new
attachment to the device's list, mapping it to a PCI device that is no
longer managed by the driver. This could lead to IOMMU domain use-after-free
or memory leaks.

> +	mutex_unlock(&buf_list->lock);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791924581.gi=
t.asml.silence@gmail.com?part=3D7
