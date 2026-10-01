Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6E2CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6E610E252;
	Thu,  1 Oct 2026 12:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SOAx6eO1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5298A10F0C3
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:02:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA5D8601E4;
 Thu,  1 Oct 2026 12:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C231F000FF;
 Thu,  1 Oct 2026 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856140;
 bh=zpy0LRhjqnKx679O4dYdg/EdudqFhuUZwCGO46JumkY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SOAx6eO1/Jm9V2Khk+HeJSx+zwKSFXrrxJ8YC/1W6o3kxDvpSawwllYEqEhHa3OQG
 GY8MXnwDySGgaayGG55sEw2b8PiRzUr7r5+ctfrQIT4BX0bHJTDqApOgwzXziME1Vc
 rWdVLCXC8gp7NkwYkpMyEczm3iCa3dO6g9dPTKVfJ+P5stA8RZGXD0dxuUYn7huLgJ
 YRTg43FTE5IoMqMIimn+Py+XuUi4p1lyw/LvMCpZ7fdcBjGjmOHMD9FwcQ9sVWam0o
 NOYRoJwOViK/w0UdTKDAIqDoREVxIx8mz4FtJui2xkB3V9Tt/iPVAW6ajtOhwyFFXv
 E5EcnfMVYAnHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/18] PCI: Add KUnit coverage for ACS isolation checks
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, kvm@vger.kernel.org, media-ci@linuxtv.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-14-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-14-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:02:19 +0000
Message-Id: <20261001120220.35C231F000FF@smtp.kernel.org>
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
> Direct Translated P2P does not weaken IOMMU isolation because a Translated
> Request carries an address supplied by the IOMMU. Config-space read
> failures, however, leave ACS state unknown and must not report isolation.
>=20
> Exercise both cases with fake config-space operations. Also cover missing
> and unrequested controls and a missing ACS capability.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D14

