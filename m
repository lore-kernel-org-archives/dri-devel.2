Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F9BCA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55CFA10F614;
	Thu,  1 Oct 2026 12:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BSyIQHM1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C366810F614
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:01:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 17F1A601E4;
 Thu,  1 Oct 2026 12:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7738B1F00899;
 Thu,  1 Oct 2026 12:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856073;
 bh=C4J0R9HBIZKYjc5evTkydqc/3Ah1h/+1eQj/E3deQyU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BSyIQHM1LvBRo3wXtUsF56Yhx1m0Qt/C2Qynf2u0ivFBLoRjNAXYzPKqkO9LRMjLd
 rjEnjY6UsU4zACGv6z2G3v2ttF/fjsxM8aKcArTgoRrQFBHu8hiyvD1YvaH2Y81Vli
 Rw8yQJNgmQpyjBH8AehpKWs0zW6Izgcy9LwvcPpg3CrvgLORMa9tOYsekDi+cAMsDH
 Fg4UTkOKc8P7eBd/k4WvbGzuYlesUCpmI9uYkn0/JtqcHPLmznhecOqjgQMRhiW8By
 L0WEcdfIph+03Ks5ojsekOpIs+K/p8mRzwnWv7WHEcEHYk4FMbpWnfAPZgXeRhRJN6
 5JLIQfjNyqJGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/18] PCI/P2PDMA: Collect the path's ACS controls
 before deciding
To: "Leon Romanovsky" <leon@kernel.org>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-6-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-6-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:01:13 +0000
Message-Id: <20261001120113.7738B1F00899@smtp.kernel.org>
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
> calc_map_type_and_dist() reads each divergence port's ACS Control register
> and folds the result into running counters as it goes. Any routing proper=
ty
> that depends on the kind of TLP being routed would have to be threaded
> through that code, so there is nowhere to put one without reading the
> registers again for each kind.
>=20
> Collect the two ports' ACS Control values into struct pci_p2pdma_acs_path
> first, then decide from it. pci_p2pdma_route() applies the same rule as
> before: a path routes directly only when both directions do.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D6

