Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B601C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A525910E213;
	Wed, 15 Jul 2026 18:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Iy++/YYa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A12810E213
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:00:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B2D8416F7;
 Wed, 15 Jul 2026 18:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461811F000E9;
 Wed, 15 Jul 2026 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784138446;
 bh=mt/qyZsjAXmu+EfSDpNx+Y+StIHSiAcH3j4YcjkH7Hg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Iy++/YYaF3cXdzJyt4kddA0w69eF1nL5DbVdlXExYU0VAih2ODGzrrpE/3yP7MWrE
 oSEZmbIFClt5THVbqjaJmzMcM3f/wzymieIOi0Do2CYGpVSsQzVo3ur+OF+hcYQoSF
 ZhGkGSt5DcHZDFxrBIHdRPXPF8ehjDFS/2/Q+Jjk9cV93880fOPUiDFmRTh7/u8qly
 7hs9UD9J6uL6kmY0xe5UwBhMuXF7IYOty9UsNYmkdOB4s2ZXSpncSYFXJouXOiJr0f
 SvA2Kc7sD14CFfAUWYrYSq11UXS9MxgGGPoK7vtvkGmUcI+mv5A67OllrF+4AhC3H4
 SGntUnodngy+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260715174737.15287-8-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-8-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:00:45 +0000
Message-Id: <20260715180046.461811F000E9@smtp.kernel.org>
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

> Previously, vfio_pci_zap_bars() (and the wrapper
> vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
> calls to vfio_pci_dma_buf_move().
>=20
> This commit replaces them with a unified new function,
> vfio_pci_revoke_bars() containing both the vfio_pci_dma_buf_move() and
> the unmap_mapping_range(), making it harder for callers to omit one.
> It adds a wrapper, vfio_pci_lock_revoke_bars(), which takes the write
> memory_lock before zapping, and adds a new vfio_pci_unrevoke_bars()
> for the re-enable path.
>=20
> As of "vfio/pci: Convert BAR mmap() to use a DMABUF", the zap via
> unmap_mapping_range() is no longer performed for vfio-pci since the
> DMABUFs used for BAR mappings already zap PTEs when the
> vfio_pci_dma_buf_move() occurs.
>=20
> However, it must be assumed that VFIO drivers which override the .mmap
> op could create mappings _not_ backed by DMABUFs.  So, the zap is
> still performed on revoke if .mmap is overridden, using a new
> zap_bars_on_revoke flag.  A driver can explicitly opt out; the flag is
> cleared by the hisi_acc_vfio_pci driver, since its .mmap just wraps
> vfio_pci_core_mmap() and so still uses DMABUFs.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D7

