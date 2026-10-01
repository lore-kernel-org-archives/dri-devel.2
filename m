Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C93CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E175710F634;
	Thu,  1 Oct 2026 12:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aq+by9ba";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24EA10F634
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:05:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E10D660A52;
 Thu,  1 Oct 2026 12:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF8F1F000FF;
 Thu,  1 Oct 2026 12:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856323;
 bh=vXyYZ47Shvz1+FFMohijPoX/VcThcKjXql21tUaN4Q4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aq+by9bask+EcWUnL6vXApSXHmXzWPA2ZxRlo5IR46oIfVHXSHNi4+kwf3ouAWDxG
 Ux+XfdRIwlqEucpdVujdTdWcO3uWO1n/wsDwdx4Gk0olVFVua9f7eEY982Cjfo8kEt
 VJXS2bOBcA0hU2jDvoo7M2oA35xMQQ/QmkIkCSL84BNDiWZEz4yTjXuH6cOw8Ep/t/
 9wQycpnzpTYjtZjy/Cl78L5DK2nQwZ3MdOY8UqWOccLjdz5XPSv5hFAO5rPBkxHKPc
 ftfEXtQub0ISESXe71atKOCzIMQUc/Wkg+HwgqV6JPqKOQbmfgbAi5HOGQfWRWzac2
 WhzGgkSOjIObw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/18] PCI: Reject unreadable ACS controls in
 isolation checks
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-3-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-3-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:05:22 +0000
Message-Id: <20261001120523.4CF8F1F000FF@smtp.kernel.org>
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
> pci_acs_flags_enabled() and the Intel SPT PCH quirk use ACS registers
> without checking config-space read errors. A failed read may leave control
> state indeterminate yet allow the device to satisfy requested isolation
> controls.
>=20
> Return false when either ACS capability or control state cannot be read.
> An unknown state cannot prove isolation.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D3

