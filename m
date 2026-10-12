Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC487CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5134A10F06F;
	Mon, 12 Oct 2026 13:15:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEA410F0EE
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:15:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E4E2B4039E;
 Mon, 12 Oct 2026 13:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8EF1F0089B;
 Mon, 12 Oct 2026 13:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810917;
 bh=pbwolV2gpLlhco6YnOqT4f0AFWu7v8BeH4SkpDuXrms=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=algrs0+yoH1mDGhKhiinVo4Tojv/6YsugbCK8b5gMgSmwb+By68xiMTvfEUg14eas
 4MrEsFDZntb28NSPVZrl21Q1tcJXZnZCP9ovv71msbBleWC/5vmgmspv00gJ0J8GKu
 ur5klKTANWlCw61b+3SawqWTY5DKOv9hp/Ms4MogqJd32hqLEvQ1WsQ/SlKK9yP2Wc
 FMSRFaRYjxWu0OkMeOdWdnVg4kbhNDMCPTjQg4A3wz+5A//xUuK5sRUpKpPT4Ny16G
 FnDiLDVHfftJqTVIPMToImL+HdHOUy/yc+0YIEK6CfH724feJ2beZWQLAtr7hb4OUz
 7VU2OBZsRj5RQ==
Message-ID: <sashiko-outbox-168152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/18] PCI/P2PDMA: Evaluate ACS controls at the path
 divergence
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, media-ci@linuxtv.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-4-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-4-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:15:17 +0000
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
>     Host bridge 1      Host bridge 2
>           |                  |
>     PCIe switch 1      PCIe switch 2
>        |     |               |
>        A     B               C
>=20
> A's and B's paths diverge in switch 1. A and C share no upstream bridge,
> so no direct route exists for ACS to gate.
>=20
> Evaluate Request controls on the Requester-side divergence port and
> Completion Redirect on the Completer-side port and reject an unreadable A=
CS
> Control register.
>=20
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D4

