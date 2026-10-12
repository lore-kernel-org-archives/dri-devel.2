Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9325FCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E337610F0F8;
	Mon, 12 Oct 2026 13:20:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833D110F0F9
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:20:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1A5660229;
 Mon, 12 Oct 2026 13:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B01B1F0089E;
 Mon, 12 Oct 2026 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811219;
 bh=jis67edseTgaYxGPkQgotJRGpKv36kj5tWrkBdnm6HM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NKFEJkBh554OcFhDG7aC+WpEk3QFBE6RWEOd8PodcN1eiMYpWrbtiIdI0416nGlEY
 0VlS1cXTXdlxwr69YvSVtKOSdVOPBl3YPm6vovH+hGUxm4x9417mXlI5Tl8xW8HZbg
 CjyUh75dSSFnnGRg+q4oak08mux/OOU+XMuL0zNUTmM0SHO7o3zZE4FkM7MMzcf7fs
 GNgOjuGbnJO/lqEYb6hrHNWmTAi79BuiuwtGSgQjJ77MRKCfJorarcktyOcNrJQE0D
 vI4S53WnIfkdmglLz7QI/lkYQyVbKuSlNsE9P4QR09+j5HWZF79i+/jgN+/IQcNzcs
 IOTXK515xwS7A==
Message-ID: <sashiko-outbox-168166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/18] PCI/P2PDMA: Reject Translated Requests
 blocked by Translation Blocking
To: "Leon Romanovsky" <leon@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-9-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-9-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:20:18 +0000
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
> A Downstream Port with ACS Translation Blocking enabled treats every
> Upstream Memory Request whose Address Type is not Untranslated as an ACS
> Violation, ahead of "any applicable ACS P2P control mechanisms" per PCIe
> r7.0 sec 6.12.1.1. P2PDMA never looks at that bit, so it reports a
> bus-addressable path where the Requester's Translated Requests would be
> rejected.
>=20
> Add PCI_ACS_P2PDMA_BLOCKED, and because blocking is not a routing control,
> scan the path for it rather than the divergence port alone. A blocked
> Request has no host bridge fallback, since the Address Type is rejected
> wherever the Request is addressed.
>=20
> The two routes do not pass the same ports, so scan them separately. A
> direct route turns around at the divergence and only passes the ports
> below it, while the host bridge route keeps climbing and passes that port
> and everything above it as well.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D9

