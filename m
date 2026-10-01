Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A80ECA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E82D10F2D3;
	Thu,  1 Oct 2026 12:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b76/f/R/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFD710F2D3
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:02:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 257314126C;
 Thu,  1 Oct 2026 12:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99B91F00899;
 Thu,  1 Oct 2026 12:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856147;
 bh=T9Y5WBVkeqh3B6k3lD2ODR47GJXMSgOk47kgZaLfOHQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b76/f/R/pa0MGWfZGrSOt6xMvnKVxojZzZHPsKVT+sG35SeTX/dbD4upTwWOQTpg8
 o22uhQal6+dPL/0bdaV40swYxK8vwcW2ntveooR6P/7bLvkh0hNZn/frL+HV1w/96D
 gI2/Axt3h21YCZIxRyYTwTrWfX50CZRCDI+xv2kdJjdg3/qbmYH2Ye5K+LJVLsrjWE
 UOzzSvBs78QpT7mAm+shciulkx/Js4z6DgXEvt2zoFR+jE0loML5OVhGdyfcXt5KGw
 N123eTuylNEF5G+dAIcOmf5EUK8I8TLgUndtczdYRC5vEaCIE0FT072mYilHmZKHA0
 4H/WODYfiT/iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/18] PCI/P2PDMA: Answer routing per TLP class
To: "Leon Romanovsky" <leon@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-7-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-7-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:02:26 +0000
Message-Id: <20261001120226.C99B91F00899@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D7

