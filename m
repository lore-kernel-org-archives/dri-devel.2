Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DA6CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7789D10F4BF;
	Thu,  1 Oct 2026 12:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IOiF0p22";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4465A10F4BF
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:03:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6357860A52;
 Thu,  1 Oct 2026 12:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DC61F00899;
 Thu,  1 Oct 2026 12:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856234;
 bh=BTOVgDCuYiHcmSugzZUL3bMU3P+G1dAmVFWk+BqkZa0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IOiF0p22PmW/JGvLGE6ydcDSs7Yd2TwyGus9te3gzLUY7HhF10Aklmsus2La8ixuU
 Ai2ucOiwSPNNBn14SW3qk3oTmjNdkh6AoNJGeWMBTUk8+CR1mYKMBxx8VnWK1novlx
 VtivIYi9CgpNbflbMp8+K7end+1A6yzJ1fp8Lk5Dpj7Zt/b8aL6/0KWD8UrAPU1N1H
 fvsp7Yr/uXJHlpVl0UUKdJojA+f+h9Yi5qXT4Lke5DF5P7e69DZ3JeLTYKJKa8oIfE
 izzDSyUeo5++mUjN4EZ/Fnh6qA3rXqQ9PaOg/leQGwptpnGCRJnuaJkrsicG7sNcGe
 97p7YcSRY3qGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional
 ACS controls
To: "Leon Romanovsky" <leon@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 linux-rdma@vger.kernel.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-2-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-2-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:03:53 +0000
Message-Id: <20261001120353.C2DC61F00899@smtp.kernel.org>
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
> pci_bridge_has_acs_redir() treats Request and Completion Redirect as
> interchangeable. On asymmetric fabrics, a control for only the reverse TLP
> direction can unnecessarily force P2PDMA through the host bridge.
>=20
> Evaluate Request Redirect for client Requests and Completion Redirect for
> provider read Completions. Continue treating enabled Egress Control
> conservatively as a Request redirect.
>=20
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D2

