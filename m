Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90562606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZnbWUUB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B182410E476;
	Wed, 11 Nov 2026 19:47:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047B310E476
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:47:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A8D840E35;
 Wed, 11 Nov 2026 19:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2741F00A05;
 Wed, 11 Nov 2026 19:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794426462;
 bh=PWVL6bvXnxNkJSOKiby5JwyMlo6cVWinxz0qfpmIGeM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EZnbWUUB3SGpbufZQth3XkFseKjF6chyyQRo3wuQVgSVKHPKY/l2ZOt64e0KpnJSK
 Qvo30j5Vsa22wrFXr91mqkv7rmPzlCuDk69WYStgPgjUG5Q8o+8RvJnoQna9FPnEb7
 NTcB4HCJAJl7rG9y4IaHzbFbRQDEcHdQOaOpiCc804xXaBJVV3UtJPZGOhEXFA7/5/
 l4zmr4igPsiPXByDCGfV/efXTEB3mRf40oszv+sonwMDNuo/Z8TERF86xc/n2o5Qmg
 Pz+HHF9DuOxFdEho4ezEenaIJT4QjIERQeIhTFYiZCfCuNpI1LrDAWF61cidZlTUor
 buyxfgMbVyDsg==
Message-ID: <sashiko-outbox-209593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/7] vfio: selftests: Add P2P DMA selftest
To: "David Matlack" <dmatlack@google.com>, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261111192411.4133780-8-dmatlack@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <20261111192411.4133780-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:47:41 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vfio: selftests: missing -ENOTTY skip check for
  __vfio_pci_dmabuf_create()
--

commit 3d8e1bca27abb87842a5dfc06a0cde5ad88fe0fb
Author: David Matlack <dmatlack@google.com>

vfio: selftests: Add P2P DMA selftest

This commit adds vfio_pci_p2pdma_test to validate peer-to-peer DMA between
an initiator device and a target device's memory BAR across supported IOMMU
modes, including dmabuf revocation.

> diff --git a/tools/testing/selftests/vfio/vfio_pci_p2pdma_test.c b/tools/=
testing/selftests/vfio/vfio_pci_p2pdma_test.c
> new file mode 100644
> index 0000000000000..43e1537076ad1
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_pci_p2pdma_test.c
[ ... ]
> +FIXTURE_SETUP(vfio_pci_p2pdma_test)
> +{
[ ... ]
> +	if (self->iommu->iommufd) {
> +		u32 bar_idx =3D self->mem_bar.bar->info.index;
> +
> +		self->dmabuf_fd =3D __vfio_pci_dmabuf_create(self->target,
> +							   bar_idx,
> +							   self->mem_bar.offset,
> +							   bar_map_size,
> +							   O_RDWR | O_CLOEXEC);
> +		if (self->dmabuf_fd =3D=3D -EOPNOTSUPP)
> +			SKIP(return, "Kernel does not support VFIO_DEVICE_FEATURE_DMA_BUF");
> +		ASSERT_GE(self->dmabuf_fd, 0);

[Severity: Medium]
Should this check also skip when self->dmabuf_fd is -ENOTTY?  When
CONFIG_VFIO_PCI_DMABUF is disabled (or on kernels predating
VFIO_DEVICE_FEATURE_DMA_BUF), the vfio_pci_core_feature_dma_buf() stub and
vfio_pci_core_ioctl_feature() return -ENOTTY rather than -EOPNOTSUPP,
causing the iommufd test variants to fail at ASSERT_GE() instead of
skipping.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192411.4133=
780-1-dmatlack@google.com?part=3D7
