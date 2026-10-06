Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE112CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 19:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 466E910E44A;
	Tue,  6 Oct 2026 19:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ecoYev5e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F0C10E44A
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 19:48:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D233602D3;
 Tue,  6 Oct 2026 19:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DB81F0089B;
 Tue,  6 Oct 2026 19:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791316110;
 bh=Il4TIaCJkAOTW2lltBD1HBc/qYXW6IFEez4Ax8czULc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ecoYev5eI8jTm5EsGE+ZvpjlHTRSYKqBhdMVSggpbqzhLLY4Qy4/Ywa+eNOAl9Lfz
 idlfqxWTQtNUNs8BjCo3Drra0Msg6Dtau1F5QknqfzACOCWs0fSqwoMTyGcI4H9ljI
 L5ZfWaQiC5zAALl/UyupC98sNZkjQi0XyKPIulzRFB0DGBXrLjM3Sxysz9skj2QWbt
 IaRx+LCmAM2jYb8Q1WbQVdeWqTEvEb6QGm3qnxQ2dx30j4jYWKmh0RrNVghQBj6hy6
 npzQaCCRm4Vswx9j2KIK6mXm7n1vBXl8rKtufPOE/52JflzwqcgYLPE8CsWWJuNf2z
 IdvXIlTvLNmCg==
Message-ID: <sashiko-outbox-162412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/9] vfio/pci: Remove DMABUF export dependency on
 vdev->memory_lock
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261006193643.76330-2-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-2-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:48:30 +0000
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

> The VFIO_DEVICE_FEATURE_DMA_BUF export previously used
> vdev->memory_lock to protect VFIO's list of exported DMABUFs
> (vdev->dmabufs) and their revocation status.  When adding a new
> export, memory_lock was taken for write.
>=20
> A future commit will refactor DMABUF export into a function used from
> mmap(), which would create a new mmap_lock -> memory_lock dependency.
>=20
> In preparation, this commit introduces a vdev->dmabuf_lock that
> protects the dmabufs list, per-DMABUF revocation state, and a new
> bars_revoked flag.  The flag tracks the device-wide BAR revocation
> state set via vfio_pci_dma_buf_move() under dmabuf_lock, removing the
> test of __vfio_pci_memory_enabled() and dependency on
> vdev->memory_lock.
>=20
> This is a cleanup currently, but allows the future export path to
> avoid holding memory_lock under mmap_lock and a therefore avoid a
> deadlock scenario (a fault handler attempting to take mmap_lock in a
> vfio-pci variant driver thread that holds memory_lock, vs another
> thread doing an mmap/export holding them both in the other order).
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D1

