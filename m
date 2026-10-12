Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC4BCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6A410F100;
	Mon, 12 Oct 2026 13:20:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED71D10F101
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:20:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F42560229;
 Mon, 12 Oct 2026 13:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71D11F0089B;
 Mon, 12 Oct 2026 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811251;
 bh=RWwBHXqGspnBAtAriCAV4NJ3pZG9GwGLLo60JD5LsXU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EkD5+6WgGEI7KWqniEn2viIdUCjXQnVob/YDhHW/l0G7efMz7WyPEKWA6otnrHSAe
 weDtr0kLZuZk19j2Vl1qx/aUv2QSyZXL/lX7aI1BSS6J5WeGFTmm/2qzn9Jfq9KmVQ
 FgYQEkoE7D0Zm1+5XdxAYCJlyrZY7FrWhmf4JTk96NaOSxZSxuLsPFAmigyOw+DjZx
 lz+jMMYqUHFQOl4EpNDeEEDJSNRangaiFlp+JAkutJ9HK7Ohx3TpHtNqB0M6ayXBEq
 tYzqvuyjnrFU5fvvT+oM17GX5nZex/e4p3BKXZcD6C4e8VUtCZmOki8NWxx/0evEjY
 Yf0lRpJjLin9A==
Message-ID: <sashiko-outbox-168169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/18] PCI: Add KUnit coverage for ACS isolation checks
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org, media-ci@linuxtv.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-14-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-14-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:20:50 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D14

