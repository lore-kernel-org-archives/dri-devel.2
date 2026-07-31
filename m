Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E643C55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8132E10E25A;
	Fri, 31 Jul 2026 21:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l6/ghXRw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F21310E25A
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:38:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4462D41A06;
 Fri, 31 Jul 2026 21:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37C41F00AC4;
 Fri, 31 Jul 2026 21:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785533905;
 bh=o7kaIlIb15EcE0hMc1jTcbz3QH3sjCuPYtJCxBOZ8pA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l6/ghXRwYNMzGq2nwoR2G9qwn1A5TNF0SxPKs+bD0Lw+j9PRg7A6PxKXf8w44cmIi
 hXWjLAepyoa2s1OtsyK2mbEM3tEFSFRA2Ao4Pfr2t4PowqcA/ph7zFJa9fotObc7Mg
 tLgK6N8puw9qTtCdXI0Wznpv23Jr4OIKLaEQBBV8LMaszNVeckyhg+RavEgt17lJX+
 j7JMiIc4soUUKv44kHhvTYWYga+c2gfFdzeG/W099O7cuMkQOmA5sM9/4/jnpGWjax
 xu7Hd1n9hVcyjI4L7KoqhIpRapkae/yWSHqvQMJQXPkAeUAdEoUsk1OeEiTxObSPyL
 D0t415YWcBnPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/5] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260731211601.3033906-5-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:38:24 +0000
Message-Id: <20260731213824.E37C41F00AC4@smtp.kernel.org>
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

> Implement dma-buf get_pci_tph for vfio-pci exported dma-bufs and add
> VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> for a VFIO-owned device.
>=20
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> uAPI carries both with explicit validity flags, and get_pci_tph()
> returns the value matching the importer's requested namespace or
> -EOPNOTSUPP.
>=20
> Publish and read the TPH descriptor under dmabuf->resv, matching the
> locking used for other importer-visible dma-buf state. The SET ioctl
> takes dma_resv_lock_interruptible(), while the callback runs under
> DMA-buf's asserted resv lock.
>=20
> Hold memory_lock in the SET path while checking that the dma-buf still
> [ ... ]
> supported on a device that advertises TPH Completer support but cannot
> export a vfio dma-buf at all, so no dma-buf can ever exist to carry the
> metadata and every SET would fail later at the ownership check.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731211601.3033=
906-1-zhipingz@meta.com?part=3D4

