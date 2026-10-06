Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ABACA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 19:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365BD10E455;
	Tue,  6 Oct 2026 19:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NlfE12ko";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A97A10E455
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 19:53:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2878343B6D;
 Tue,  6 Oct 2026 19:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB2F1F0089B;
 Tue,  6 Oct 2026 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791316398;
 bh=0hmkFwt9p2NisZAv7OaJv3bc/TXSWBRTiUQhA7DyGsk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NlfE12kovdalabd3rXaub0z1DL7mYW+xBlsTCsUdCN+jWEo92UR89X2NJGxys3Ayq
 JOQyQMkrBnZS4nwFEWsFcXOMPddTPTbOo6X2zcDgndIr0X1RBmbAxwfwt0VxPY+wXH
 gTmt5ceH0bnmzS0JeJ7GCdSLsia5AQHlYYUIjCoMN+/bzAg6LgnNdgSliy2M7JWQm9
 AyyQNC4cYP57sngQnIyu4zbwJCwtMFhmZVfrrsIjIPzBPmTq1M3VJW6oSPG3zwcxga
 pA9fvOU9XUtzHo87QOO5mTlWW0hSfrZ2nvcx5eo2TPrRfB/gpgflGEebzt2qs8bjP/
 JVO08kMzfHGKg==
Message-ID: <sashiko-outbox-162413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 media-ci@linuxtv.org, kvm@vger.kernel.org
In-Reply-To: <20261006193643.76330-6-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-6-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:53:17 +0000
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

> This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
> DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
> commit by VFIO's ordinary mmap() path.
>=20
> This function transfers ownership of the VFIO device fd to the
> DMABUF, which fput()s when it's released.
>=20
> Refactor the existing vfio_pci_core_feature_dma_buf() to split out
> export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
> this new VFIO_BAR mmap().
>=20
> By exchanging the VMA file, we lose the original device path in
> /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented synthetic
> 'filename' for BAR mappings based on the BDF, plus resource index.
> (This does not apply to explicitly-exported DMABUFs which are named by
> DMA_BUF_SET_NAME.)
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D5

