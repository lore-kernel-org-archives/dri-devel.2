Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE7ECA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2A210E1C8;
	Thu,  1 Oct 2026 12:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HWbGvBnd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAFB510E3AE
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:06:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A65FD4166F;
 Thu,  1 Oct 2026 12:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6181F000FF;
 Thu,  1 Oct 2026 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856419;
 bh=tJODK09rrvwoeThByl8zpjHYPzoO3G/XFWoxUU8cenI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HWbGvBndHM0VDI/5CiKKzZOGZaDEyQ5kpHg1TqdY37p34YlhlfQFZEI2GPOGwQnu6
 B+oWKi3laed4pknGiA1NU+CEk9E30OTnevRdFXhsM9ORs4hX4HUYJQ/BbXxEZaE9uV
 DthRXSv//Kfde3lJKIcCiRRG+DMyo2FujVDkNJRyoGA8I4Hdmj1nWkcHiM74WxT0P6
 wDwgGpWlioCZElS7YQjdfa1oR6lqlf1Y7v2KFYM3aYTSX+498f9uo8fcb2f3m0szCo
 a0YybhhTKnG5ugXhFB5Z8hTTnA1x4nu2FKmKMf/FyfKUCqxvZkA7KHWJyv5XmakM4A
 29J1ggqti1Ihw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/18] PCI/P2PDMA: Log detailed ACS routing diagnostics
To: "Leon Romanovsky" <leon@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 linux-rdma@vger.kernel.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-11-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-11-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:06:58 +0000
Message-Id: <20261001120659.3D6181F000FF@smtp.kernel.org>
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
> When P2PDMA rejects a mapping, existing warnings identify only the final
> ACS or host-bridge result. They omit topology, live controls, divergence
> ports, cache state, and intermediate routing decisions.
>=20
> Emit debug-level messages for verbose calculations and cache lookups.
> Report both paths, decoded ACS controls, directional decisions, host
> fallback, and the final mapping. This keeps incidental unsupported probes
> quiet while allowing the diagnostics to be enabled when needed.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D11

