Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7BACA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B4410E62D;
	Mon, 12 Oct 2026 13:15:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C3B10F0EF
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:15:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E42E41756;
 Mon, 12 Oct 2026 13:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F245C1F0089C;
 Mon, 12 Oct 2026 13:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810924;
 bh=YEFM1zCeU+S3WieHOaSiaNmgbDTa7ojyhqE8Yfkatuo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GgTZ/6BACJupGnVvkVNPXYQJocRU5Dz/8p9E8w5/lB0vWBKiQH8P6MBgNekZz3Npq
 tDtRlNs9+uAYusMdtvYzywPv2k3MuHrreLwq0D7PQb30cUMbywWsg8uJhwjCYaDD4W
 tdKFLT956OikQpqhHXogmKVm8VPZ9VyeMSs+jRBa2HRKZ1yorvKWiE9+4d/KDPQFkE
 YOkAbLRng2JSKcFxGY27odrXp9/ROotitJBIdSW/vraTPKpSa5cPaB+vVWShRHwBKr
 RtJxJTK5mxx7Z1a8fIlaVRvHdwf+94Yd5haCM7k1uM7h/D/KuHpUcpkAhtfdDc55ho
 s8wcdd5nKItsg==
Message-ID: <sashiko-outbox-168154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/18] PCI/P2PDMA: Route Translated Requests under
 Direct Translated P2P
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-10-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-10-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:15:23 +0000
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
> A Downstream Port with ACS Direct Translated P2P enabled routes a Request
> whose Address Type is Translated "to the peer Egress Port without
> redirection, regardless of ACS P2P Request Redirect and ACS P2P Egress
> Control", per PCIe r7.0 sec 6.12.3. P2PDMA assumes every Request carries =
an
> Untranslated address, so it sends an ATS client through the host bridge
> even where the fabric would route it straight to the peer.
>=20
> Consult Direct Translated P2P for the PCI_P2PDMA_TLP_TRANSLATED classes.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D10

