Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88D1C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F10E10EEFD;
	Wed, 15 Jul 2026 18:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zec8rbCo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D1B10EEFD
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:08:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CAB340531;
 Wed, 15 Jul 2026 18:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39101F000E9;
 Wed, 15 Jul 2026 18:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784138928;
 bh=l1y7113DF7l7Rs+6OfnVn7EnwfjFDeiAFOCdHirTt2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zec8rbCoOHApi2RccjN0vTTzhHo5qLIHO+6AClHp+0G6So8V1aqxBj1IkpZrozx1O
 QIE4NVk8pHFZefDk6Ly3wkZRQdH8sLDpEDrBlzors7XIJc5sWTnjEdl9ATidct8Mcx
 covCjY6+jpOhgFpMMt6zKJWYymEyO8mHJOC8dcxpw4L9n4n8VyFr0FcukzxOo0haKJ
 yNsti/88xw+kg4DLpoXWc3Jq1/HNshOeaZGlKPjZI+gg9u7m5EW8pHe+IkCLeWiOwj
 l5gQ4Dg9N4lJ7aX1eZtqudY+fVZETTU2SpRMEUBkJse8IpzVhO/fGUZ2oWVHLyJNfN
 WZNeNh5tzF8BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org
In-Reply-To: <20260715174737.15287-4-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-4-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:08:47 +0000
Message-Id: <20260715180847.E39101F000E9@smtp.kernel.org>
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
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D3

