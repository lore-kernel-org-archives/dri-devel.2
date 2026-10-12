Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F7ACA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CAE10F0DB;
	Mon, 12 Oct 2026 13:15:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A9AA10F0DB
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:15:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4588960229;
 Mon, 12 Oct 2026 13:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8291F0089B;
 Mon, 12 Oct 2026 13:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810912;
 bh=U7ucs8S4wKunMBhwOvKDYdJ+x3N4ILKHnxrNI+JLyWI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e9MFBouPaNhfw7CYmVJjNzZveFqbGj/R5pndA23KmefsyO9F48klVM7JBeXGrtPEg
 UcpBgqVSklzOZf+J8rLrg/t2R5DbgTNCKlMU0/BgWKSnxnB+SFgNU4fZDZftaifPea
 UF59IW61D9p+I50Sy33Jqhvr3af0nS0jijDKtueKfnlZUXxN2yEEwbtiMojr1Eq9YF
 xss0pljfyZBO0PYYZMXCVMzrir5iAekNa3yVq5KxYNZdw/rX140SMGO1z5qmEmr3M6
 mMqeKnLH7RNxrZHX6Uag7OUrvkGoa2yIrHlumzlriCuUsn2IBnpzL54KyZkCPXejzA
 flANHbb67ENoA==
Message-ID: <sashiko-outbox-168151@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/18] PCI/P2PDMA: Collect the path's ACS controls
 before deciding
To: "Leon Romanovsky" <leon@kernel.org>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, media-ci@linuxtv.org, linux-pci@vger.kernel.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-6-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-6-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:15:11 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D6

