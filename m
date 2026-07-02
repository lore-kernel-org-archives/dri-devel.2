Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CADDC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF92510F55E;
	Thu,  2 Jul 2026 18:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JzbK/Op+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 729B110F55E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 18:29:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DDAE2407CB;
 Thu,  2 Jul 2026 18:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872431F000E9;
 Thu,  2 Jul 2026 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783016960;
 bh=Ae+/zeh8gCqjCiwqvv8ueORiT2MorjMihfjfDtWkSaw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JzbK/Op+SfICRExFrLAG+b/ClRChB4r2bCf+4ZlLhIWxnsEiEsS23S40ei8AhDTP8
 zuAST4DEH2edhEo0aIYZSgjMVIMq3X0iwLAamlJ3zMRpv8kz/J7rrmrZvnJGWvQesh
 ZipWPK0qUOMWGbPs1BRX7QDGzaXtVpBcWbuDDCdomwXCswyrd7LszucNO4/UI3aLIc
 xkXgIHgqObigMRmeu0gDsKCOAIvCSSfPJWzQjXSkgX0njiBGRrmfe2oG0yLr5vtr1w
 asMCGA6dmesukCrPxva+pmWkjVL77jcRLdTTZvrU3mYn2MgVeAb1OiznzokQzq0uDF
 qY4FE5rStRJbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260702181025.2694961-4-zhipingz@meta.com>
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260702181025.2694961-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:29:19 +0000
Message-Id: <20260702182920.872431F000E9@smtp.kernel.org>
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
> The attach path reads @revoked without holding memory_lock. Annotate it
> with READ_ONCE() to document this intentional lockless access: the read
> is a benign early-out, and a racing revocation is re-checked under
> dmabuf->resv in vfio_pci_dma_buf_map() before any mapping is handed out.
> The annotation only needs to keep the access well-formed against the
> memory_lock-protected writers.
>=20
> Reject requests the device cannot consume as a completer:
> pcie_tph_completer_type() must report at least
> PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Make PROBE follow the same hardware
> gate so the feature only probes as supported when the device can really
> consume it.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702181025.2694=
961-1-zhipingz@meta.com?part=3D3

