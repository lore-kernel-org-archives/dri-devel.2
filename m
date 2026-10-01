Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECB7CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D3910F624;
	Thu,  1 Oct 2026 12:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d+uVEg0I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DCD10F624
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:04:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DABAC403A9;
 Thu,  1 Oct 2026 12:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735081F000FF;
 Thu,  1 Oct 2026 12:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856250;
 bh=KZ+9knHWFZ60Z1hvetFWx4nv/zUuLcYYrzjsKCKJ/jU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d+uVEg0I5f3F0pAxAao4gd4rY4iC3cQYxufbdd+NcmPspG+OVSZtJiW3Duvfy+3S9
 vGwB9CPqfe86KMqWvfyGCRAbhD8eoDanRjJV0sFxkvexo/xBQZaRGBPP20wnFCZzn4
 XVhBgG8O9UcPtM8aJd3tpGoQqWGyAOatMwc2Qgqq1eXvn+mRMnEph8kC/j+GsUs7QU
 4Idxlaer50+Pv9P5l/ByqbxlPfUK4he2F2KY1jA4qfMAr7exIW3I1hjJUxO4W70kJ9
 9ymGATUWPbXfk+JSxSTeqV8phSYbHNOwaAcjF7+Wmqw4BOOg+kjofvFhQCMbHJ6KQy
 ao5BSOMczt9Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/18] PCI/P2PDMA: Route Relaxed Ordering Completions
 directly
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-8-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-8-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:04:10 +0000
Message-Id: <20261001120410.735081F000FF@smtp.kernel.org>
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
> ACS P2P Completion Redirect leaves Completions carrying the Relaxed
> Ordering attribute alone. PCIe r7.0 sec 6.12.1.1 redirects only those "th=
at
> do not have the Relaxed Ordering Attribute bit set", and sec 7.7.12.5
> describes the enable bit as "applicable only to Completions whose Relaxed
> Ordering Attribute is clear". P2PDMA reports one answer for every kind of
> TLP, so a client whose provider returns such Completions is sent through
> the host bridge for a redirect that never happens to it.
>=20
> Add enum pci_p2pdma_tlp_flags and let a caller state that property.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D8

