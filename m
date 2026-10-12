Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89471CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E434210E57F;
	Mon, 12 Oct 2026 13:18:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72BE310E57F
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:18:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 57AAD432D2;
 Mon, 12 Oct 2026 13:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25111F0089B;
 Mon, 12 Oct 2026 13:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811132;
 bh=6nLpGzCs4ZJzQFQG/eZFkypqKHhs9/FdIHKlTsSnmOs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L+c8EZaBZ8mTwZJy15xn0LycE1KNEZGdfbkqg0LHoueL2hS8QLf3jX+tKuXRyp57m
 FoEf6joOyq2dywMeoMGyXeDSZrppdbJXpV8uO7svumWwd/b99oTywVtcWrZBh6VbXT
 UW+pb0rf/Jm55NqNPyCAhS47CsK8/MoYG4iCDPJ2Qaj9Y7Xo+jsK/ON8yxwUdA9S+4
 MpVkebjxzktNepqrGXX96TMNN/2kyfWjn+uTyceOPJqpGF1mKZUkFy9+KbNlLhlqJ2
 B3SCZFSJVc65lzBgxKqXocAVy3v92pNF6KdlXI8cUxP3iWOUdFVg441rDVY7d3sW9z
 1OE9M/U5vudXw==
Message-ID: <sashiko-outbox-168163@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/18] PCI/P2PDMA: Answer routing per TLP class
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-7-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-7-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:18:51 +0000
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
> calc_map_type_and_dist() returns one mapping type per provider and client,
> valid only for strictly ordered Requests carrying an Untranslated address.
> Clients that use Relaxed Ordering or ATS cannot ask what the fabric would
> do with their traffic.
>=20
> Add enum pci_p2pdma_tlp_flags to name a class and pci_p2pdma_map_type_tlp=
()
> to ask about one. The topology walk and the ACS Control reads do not depe=
nd
> on the class, so decide all of them from the one walk and cache them
> together, four bits each. Every class still answers alike; the controls
> that tell them apart come next.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D7

