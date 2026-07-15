Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FDCC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0CF10E206;
	Wed, 15 Jul 2026 18:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g79pTw0W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD5D10E206
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:17:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0BDD40597;
 Wed, 15 Jul 2026 18:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0F41F000E9;
 Wed, 15 Jul 2026 18:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784139428;
 bh=v+8zxm2hctN9rFBpZrMfD07lUo/wL8hxnS2V+M2wSK4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g79pTw0Wb75Afyo5QGF5wgcFC4CZYhhtekVF5e6e9ipb/HpgKgg0l/gZVMdj40M2w
 Fa9IWo7dnZO/+F1FZh2tm2ldzLQeAnosl0xdWx/d52b6/Pg+lBbR2DkvKfENz1Pr4K
 NQtgoYBsoDXVc5z6eLGIbMa4CiVAkbwWeqxhKUXeTPnuYBuK9IMTTsGbNdlgYHB5Id
 2FOaUTiT3ThEd55JlL+Kbs/y8DPrUXXwmJRWZaiDbnmJQ6eipluPIo6tiRxtVlJwPa
 l3fbRnN7qGR1zGG7VwJLmcPdzAjNvIgo8EDKEejbyQsspXzg8RgkGhXYBdW5aefL1c
 M136WQu9BW+Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
To: "Matt Evans" <matt@ozlabs.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260715174737.15287-9-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-9-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:17:08 +0000
Message-Id: <20260715181708.8E0F41F000E9@smtp.kernel.org>
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

> A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
> support for mmap() of this fd.  This provides another route for a
> process to map BARs, in which the process can only map a specific
> subset of a BAR represented by the exported DMABUF.
>=20
> mmap() support enables userspace driver designs that safely delegate
> access to BAR sub-ranges to other client processes by sharing a DMABUF
> fd, without having to share the (omnipotent) VFIO device fd with them.
>=20
> Since the main VFIO BAR mmap() is now DMABUF-aware, the new mmap() reuses
> the existing vm_ops.
>=20
> The lifecycle of an exported DMABUF remains decoupled from that of the
> device fd it came from, i.e. the device fd could be closed with DMABUF
> VMAs present, meaning a fault on a VMA could happen concurrently with
> vfio_pci_dma_buf_cleanup().
>=20
> To deal with this scenario, the fault handler now temporarily takes a
> VFIO device registration to ensure the vdev remains valid, and then
> vdev->memory_lock can be taken on it.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D8

