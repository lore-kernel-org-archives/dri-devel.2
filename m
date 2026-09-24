Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76A6C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C97A10F67F;
	Thu, 24 Sep 2026 15:36:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ame1mdR6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9812210F67F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:36:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C747601DE;
 Thu, 24 Sep 2026 15:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873F51F000FF;
 Thu, 24 Sep 2026 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790264185;
 bh=b4NwMMgsnsnmscbFkzQifG2tl4vFRUBJnT/cp6joCs8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ame1mdR64Eoe3pCMx7I1yMPGh7hQmQGtnwhWFImGyTFmSoKP7/pGs3VZO4885C4PS
 CyT8aIx3kADQqWHeB+hX0wWVHhPiXBCu1mmMYcpuSYYfRZ+DQzVsWdWU+gPUUZEQOy
 TMOGQiaoFQOG7TpDkxVIM01ADqNyVsFUZjYfaqPTGEa7cWqpl5UPD3bA1b+28zJo7r
 6/OVA8QBsvNnMtsHKEDOtnrViaOzJfNjJA+z/O9shgTZjLK2QTxlQRUTH2szgZY4rK
 JF0n2hzCCNIaf272WhnJr5Qv+lhhwB0/NnuWLf8KbsnrZdfIT1ujjZajuManogswSK
 qT1+WwMBQ2x4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
To: "Matt Evans" <matt@ozlabs.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260924152159.49702-9-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-9-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:36:25 +0000
Message-Id: <20260924153625.873F51F000FF@smtp.kernel.org>
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
> mmap() support enables userspace drivers to safely delegate BAR
> sub-ranges to other processes by sharing a DMABUF fd, without having
> to share the (omnipotent) VFIO device fd with them.
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
> vdev locks can be taken.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D8

