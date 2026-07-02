Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3477C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0B510F56C;
	Thu,  2 Jul 2026 18:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MGP2hANp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1DFA10F56C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 18:33:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A45044163F;
 Thu,  2 Jul 2026 18:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3851F000E9;
 Thu,  2 Jul 2026 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783017216;
 bh=q1l5gsRWtbKLXK/O8MLTQEF8W3gIBNxoSoLVBDKohz0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MGP2hANpKbsyd8+AYl0TW8f6TlpL1ZWv3x76vk2uOurgbmxDbeXl/JiuTNQE2uf5R
 xJ7rswngzlTYoIkwJO+i9v8F9SmqPo4nbwF4ha5flvFwINlZSpVVg8qmv/hZtf/CZ3
 8DzzeoL0bVasY5qLAuvtun83Le8spjnbE5MNEyQ1Pb+PV+gt6+LEcENbVqSGhzEAJW
 DmlRIcnQfoSLnnPeZu887opg9MI3lf4XxPfJu3PhZujNMkDZo5gGsFiCEPd7ChJdTh
 zrO1JT4yHGFJkKO6vwAkaeN7LuM/UI2FeT2MA0Qm+844QgpXTlTp/HMVFvm6MJsXQa
 oAelZcWWSfinQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/4] dma-buf: add optional get_pci_tph() callback
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org
In-Reply-To: <20260702181025.2694961-3-zhipingz@meta.com>
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260702181025.2694961-3-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:33:36 +0000
Message-Id: <20260702183336.5C3851F000E9@smtp.kernel.org>
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
- [Low] The kernel-doc comment references a non-existent callback `move_not=
ify` in `struct dma_buf_attach_ops`.
--

commit 335ebd67b3a2610991185474a464ea3b3511fff0
Author: Zhiping Zhang <zhipingz@meta.com>
Subject: dma-buf: add optional get_pci_tph() callback

This commit adds an optional get_pci_tph callback to dma_buf_ops and a=20
wrapper function dma_buf_get_pci_tph(). This allows importers to retrieve=20
PCIe TLP Processing Hints (TPH) from the exporter to emit matching hints on=
=20
outbound TLPs.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c

[ ... ]

> + * The returned steering tag and processing hint are only valid until the
> + * exporter invalidates the current mapping (signalled to the importer v=
ia
> + * &dma_buf_attach_ops.move_notify). Importers must re-query after a new

[Severity: Low]
This isn't a bug, but should this kernel-doc reference invalidate_mappings=
=20
instead of move_notify? There does not appear to be a move_notify callback=
=20
defined in struct dma_buf_attach_ops.

> + * mapping is established following invalidation.
> + */
> +int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> +			u16 *steering_tag, u8 *ph)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702181025.2694=
961-1-zhipingz@meta.com?part=3D2
