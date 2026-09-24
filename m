Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8723C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F6E10F674;
	Thu, 24 Sep 2026 15:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZPI02YoR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1569110F674
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:35:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8197C601EF;
 Thu, 24 Sep 2026 15:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA0D1F000FF;
 Thu, 24 Sep 2026 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790264108;
 bh=8dvQ0YkOHOVnvCqW6zuRUA8sOxa9Q6m6f3jc73jM9xc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZPI02YoR6gqKIq9iseZqS+D0tb8btuGXszm2+MPzVSUuZYpsT+HNvlnRy0kBHZ9qc
 XbNDRfl3cfGvLKOwYihDzloLYV9W21YKRFlCczjFU0/cjlbkMJbrS/MGr7fW3NLYht
 eYd+HfjsnPPD0NkEYwjR9DMdD4RpVKZ3A/hu8GwNX+oIsPbxDLEWn4GLJlFudhWyny
 m+U5TfCv+GlYGSNGFy3HnNAXYibnpFXe0PntMxyvIqJU4DcEaIKAUNjd6DklN1Wp0N
 U0vtZ5+4qlLKeahf1pEk1L6BvlvWbFV7DhSEXGq7DwkTTrG0f8xjiigCuJTaQYyNyg
 lSK2bcvNsWcGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260924152159.49702-5-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-5-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:35:07 +0000
Message-Id: <20260924153507.EDA0D1F000FF@smtp.kernel.org>
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

> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
> find a PFN.
>=20
> This supports multi-range DMABUFs, which typically would be used to
> represent scattered spans but might even represent overlapping or
> aliasing spans of PFNs.
>=20
> Because this is intended to be used in vfio_pci_core.c, we also need
> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
>=20
> This move also adds a new member, vma_pgoff_adjust; this is consumed
> by vfio_pci_dma_buf_find_pfn(), but will be set in a future commit.
> Add it now to reduce the number of functions touched by later commits.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D4

