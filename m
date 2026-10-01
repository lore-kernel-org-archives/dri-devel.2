Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A9CCA5FCC
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04EA310E3AE;
	Thu,  1 Oct 2026 12:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IOeGcL+6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A145E10E0C1
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:07:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AAB2F60A57;
 Thu,  1 Oct 2026 12:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159921F00898;
 Thu,  1 Oct 2026 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856425;
 bh=mcMVQzXG95eO3ITecvGsmKsKXAEOB9s8JTPfoxFOw+o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IOeGcL+6YtKjEaHeeKJFd9qwbSjGygahNrfUxXJroc+UYL/uJxcNM406AAA2ct/g5
 l7TwkY1HYtSXOrqY0KK9+PaqBy6BUZdTFBktoZYFhHXFLzIPnG2cPTU50xIkSWpfRt
 TkMIq3RLUmmNoxrvH98/mvpSp3pL/X3BXXMLP4IbyzJfENZM+5OU8DEjqrWpOM4c0E
 M0jm1dbPoeIigGpzeldLUxXpFZF9i7nhr0tOQWReNZrLjhn2IYFu2t+zMmo2zgzRYm
 mCk+enUUAdPrQrGf6RB1/jfCZM0qByGK1mzXnbmdzGfG2R7C9XQ99ChVvUHLDLI27t
 X0IpgHT39nGdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/18] PCI/P2PDMA: Test the ACS P2P routing walk
To: "Leon Romanovsky" <leon@kernel.org>
Cc: kvm@vger.kernel.org, media-ci@linuxtv.org, linux-pci@vger.kernel.org,
 linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-13-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-13-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:07:04 +0000
Message-Id: <20261001120705.159921F00898@smtp.kernel.org>
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
> calc_map_type_and_dist() decides which ports along a path carry the
> routing controls, and holds every class's answer in one cache entry.
> Neither depends on a single register, so a table of them cannot reach the
> walk itself.
>=20
> Drive the walk over a fabricated fabric of two devices below a switch,
> with fake config space supplying the ACS Control registers. Cover the
> ports below the divergence, the three cases where two classes of one path
> disagree, and the packed cache, which the fabric has no provider state to
> exercise indirectly.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D13

