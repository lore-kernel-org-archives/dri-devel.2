Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FD7CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D6B10E563;
	Mon, 12 Oct 2026 13:23:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D458510E563
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:23:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B9FB41595;
 Mon, 12 Oct 2026 13:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2C71F0089B;
 Mon, 12 Oct 2026 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811407;
 bh=RAf0PxXprLYYnwzidh4/H5bSyLy9i7/l1qep+L8tsxY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DntkaKeeUOIOwed2ECaW0od+jrp9eoPnMkY0GOAtKticLE9TRPiqHfTuFYqmaG2yb
 EfjDZvMBrDm68TpuLJqyU4UZWR65i70tnOQFEIX4e0qkzZK2LM9o/lITBzmxN3LB2B
 UytKVm3oDHND7qzxwVlHa03M6yiV7XljVOdEkgU9yI3w0dl16wI2AroyBABLEdkRbH
 Fbj3Rh6FmJ2XNeC2lQLOYcXUPalXhVOqnR0RdbJOh4zR6BhuoEIVCCt11oeqoPtGBS
 h2f7ETe8Rg5jGbmDPKdkJZwDa1ZSPoZxb831r9FsjD1euaruXENKTZ0mQ8p/EgBDnq
 EggOQhSgLHwbQ==
Message-ID: <sashiko-outbox-168171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 13/18] PCI/P2PDMA: Test the ACS P2P routing walk
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, media-ci@linuxtv.org,
 dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-13-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-13-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:23:26 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D13

