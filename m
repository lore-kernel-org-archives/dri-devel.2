Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB33DCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC2A10F62D;
	Thu,  1 Oct 2026 12:04:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SvsgQNjZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB6E10F62D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:04:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D34B440840;
 Thu,  1 Oct 2026 12:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688BD1F00898;
 Thu,  1 Oct 2026 12:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856272;
 bh=xDiNFuFOqyey5xi/WZeUPxoa/ahinOqXzQ/IRInWIMA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SvsgQNjZnJJEHJIEs4ApGFW3Fz7GAXtC7Ty+Td9ax1Yv/wxy0/CdgiXCSKk3zRnHV
 N+moTRZQaDpf8BmbqUNPVMlJwIlTscRlZ7WMNvDI2T284bzPQ/0JEwTK06Mwf+ga+K
 NA4+SmFj3MYLMAid58j+JSZH495hS9K05zYW8OQ+H2ShjegnaY7nCOyGmxRqfzsRIx
 ZmBy00WUHGm+q2s/O1BTn5KKByKLIKuNv1EjniURpa0cV/LiGDo7v3irDI9tOjdVv0
 iI+bcABhfKwAACxnZ68pZB2FbBnBLZ+Wa/KXPVFUdSh6FwldPN/GUYCC6U3uYtrMAf
 pfDO5FH174xFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/18] PCI/P2PDMA: Reject Translated Requests blocked
 by Translation Blocking
To: "Leon Romanovsky" <leon@kernel.org>
Cc: media-ci@linuxtv.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-9-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-9-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:04:32 +0000
Message-Id: <20261001120432.688BD1F00898@smtp.kernel.org>
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
> bus-addressable path where an ATS client's Requests would be rejected.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D9

