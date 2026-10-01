Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF29CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F9910F0C3;
	Thu,  1 Oct 2026 12:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FDyw4QA6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CCD10E252
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:02:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 730F64126C;
 Thu,  1 Oct 2026 12:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2F81F00898;
 Thu,  1 Oct 2026 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856141;
 bh=J7Fz2fGdas5nxrosVdDGPjVhOboZiCIyF6h6TA5VWQg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FDyw4QA6zHe1gLo+paZPiy4GOkYwGI8cjysK+I1ZvtKGxLf4xIVSswWH9uaWHxxeX
 P7kG48C9DNacdZEzaqhc8nY/tnAO0aIfX0xHH4JTr4WjitnChcZZgzEUT4GlAg8jQ+
 EnFYNqaVLVdOpMKAj1jpR5HJpvUul/dArhQqQz2qKOrHHjyRKd5isTtwV7jFe49s0H
 rx7O9l6nZqLW5ctriMbSQMk61I8d68bYiq9tsTp7lUIqbYPHGHxXIOQ8XcwqV/9xYi
 Afn4j9EpPvbABjgSJURsx2Q3+XMLOWZyQZsy8WNlyFX1dzyMIKOtONjLlDTwZ+LmpS
 JtVinbG1S/D3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/18] PCI/P2PDMA: Evaluate ACS controls at the path
 divergence
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, media-ci@linuxtv.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-4-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-4-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:02:20 +0000
Message-Id: <20261001120221.0B2F81F00898@smtp.kernel.org>
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

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> ACS redirect controls choose between peer and upstream routes only at the
> path divergence. Applying them below that point rejects valid nested
> topologies because traffic already has only an upstream route.
>=20
> Evaluate Request controls on the client-side divergence port and Completi=
on
> Redirect on the provider-side port and reject an unreadable ACS Control
> register.
>=20
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D4

