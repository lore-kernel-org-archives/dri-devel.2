Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55A5CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 19:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D459A10E0FC;
	Tue,  6 Oct 2026 19:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IfUD5+IL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5235010E0FC
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 19:48:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2325440951;
 Tue,  6 Oct 2026 19:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EC21F0089B;
 Tue,  6 Oct 2026 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791316105;
 bh=nj3394WSvWjO9Ky7954FHH86JHXjkxYr/8u2g+5vpKk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IfUD5+ILpXR8vcSwuOemGZnhdR3JjELT1mUp7xcj34PsVUVCydWbTQqFRqtFd6TeG
 j8HHLnFgdSwInF9cWc2K6Xt6hsvP6uX6TRAaNRc5YrHu71WHIjQdDhUbBRYcdsSrYx
 VWfb/VMF1jwBdj3S0bgnDekUV94ZNflsFGxi3mLP5RW1AG9HMqeLS/WkKKdw8iauRl
 MfJX4qMiuHOkpjR3a/0KpwzIj+Lj50sAocHlR/w10cUwl476apV9YfNmPymcZK7mpF
 XgIGKBXNdddb6qeYh8/BHCTmPFJVUKm4HAcfuXnWfsGL+vkLV1hkfiJTtwgVA6je+Y
 QluY72l5ftxvQ==
Message-ID: <sashiko-outbox-162411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 media-ci@linuxtv.org, kvm@vger.kernel.org
In-Reply-To: <20261006193643.76330-5-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-5-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:48:24 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D4

