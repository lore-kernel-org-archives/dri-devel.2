Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A34BC55172
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E7210F42B;
	Fri, 31 Jul 2026 21:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mh/09H8f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F2710F42B
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:37:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19C4D600C3;
 Fri, 31 Jul 2026 21:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CAC1F00AC4;
 Fri, 31 Jul 2026 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785533873;
 bh=ybKNoGvghGU0Ou7ZOs2A2D+Qwu5Isjo95hKQIoRo/sE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mh/09H8fR6wVeJeS3nzsbPGXz8qk2WT06AkpgN1tZCsafBNrPdkiYvBrccl8+nbVO
 oTnz/jSY7LfAR1TW7CMUimSN5l9EH050xq9AyG67O3v680byvosPrEWmyNF4J2SDv3
 v+Lr18aaqZ1GT6sJeUh4y7aAhhnKE2P8j08QaLMcUShWBj6ErfQFhrfMfvTF+qnh7S
 fFEczbIa+CoQYHomITvXnhCWHVkBrYzyIeTlP6xEyG4pXiKvlZeB57arxcq9e3nMbj
 VjqqusauSV7u457izThVk3AwFhSGFWk+KfNM4FsNRdgvo800ubL1RNtJym8LWGj3Bv
 +KwsCXnXEzH2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/5] dma-buf: add optional get_pci_tph() callback
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org
In-Reply-To: <20260731211601.3033906-4-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:37:53 +0000
Message-Id: <20260731213753.A0CAC1F00AC4@smtp.kernel.org>
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

> Add an optional dma_buf_ops.get_pci_tph callback and a
> DMA-buf importer wrapper, dma_buf_get_pci_tph().
>=20
> TPH is PCIe TLP Processing Hint. 8-bit ST and 16-bit Extended ST are
> distinct PCIe TPH namespaces, so the importer requests the namespace it
> can emit and the exporter returns the matching ST/PH tuple or
> -EOPNOTSUPP.
>=20
> dma_buf_get_pci_tph() is the importer entry point. It requires
> &dmabuf->resv to be held while the callback runs and returns
> -EOPNOTSUPP when the exporter does not provide PCI TPH metadata.
>=20
> The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> mlx5 as the first importer.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731211601.3033=
906-1-zhipingz@meta.com?part=3D3

