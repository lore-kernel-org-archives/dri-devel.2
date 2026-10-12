Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3299ECA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BD810E5A8;
	Mon, 12 Oct 2026 13:26:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FB810E5A8
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:26:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C8A5E60AA2;
 Mon, 12 Oct 2026 13:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319B11F0089B;
 Mon, 12 Oct 2026 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811572;
 bh=Dz1utKBSPBzyFUvGOG3ZYzSOmqXlU+lsMevcy2nFCjw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RtFz4ujj/X6dZc/aSi25wbF19egIqFBzWYaljcse+dL7Wf0SnCHmey9Ms/CZBmKDq
 mkSWOhP+/gvFsNZ9dcf0tMbIkLkImNJImBRmCKqV7tslXlrM7HZJt46NbHGdci3UZ4
 1tiGVP8BFini49pMglJTKy601MdxUjCFiAFk3TnfPkhLfw0QvDAhlA+Ef6ociogeZU
 Z4Qvfmq5hgwi+3AKRse2hFVyODBmaiGCULRVLN9Oia8JWTP75jEljI9dWzoFufZ+88
 kkuvABkh1evOkYMeF0IwoaH8zEu+CCsWCAgU8QKXh+/HcVMyt/TVayK+JolD/CiE5L
 XHFjBY1YKAhLg==
Message-ID: <sashiko-outbox-168176@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 16/18] PCI/P2PDMA: Let a client declare that it
 selects ATS per mapping
To: "Leon Romanovsky" <leon@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 media-ci@linuxtv.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-16-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-16-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:26:11 +0000
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
> The PCIe ATS Enable bit covers the whole device, so P2PDMA cannot tell
> from it whether a client will translate a given address. Most devices
> translate any address once ATS is enabled, but some choose ATS per DMA
> mapping and can still use bus addresses for the rest.
>=20
> Add pcim_p2pdma_set_ats_per_mapping() so the driver of such a device can
> declare that before P2PDMA starts treating clients with ATS enabled as
> translating everything. Keep it in the device's P2PDMA state, which
> already ends with the driver binding.
>=20
> Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D16

