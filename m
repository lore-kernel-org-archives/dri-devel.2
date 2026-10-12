Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574CCCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A97C410E577;
	Mon, 12 Oct 2026 13:15:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 899A510F0F1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:15:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0782B602D1;
 Mon, 12 Oct 2026 13:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656A21F0089B;
 Mon, 12 Oct 2026 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810950;
 bh=9K0G3pe7nJ1H/EdXv5+Mf0RJTwGuH5nexEMHdWSZqaY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ioTJi0Icn72IoFWqhyYezS2uydt/MVIY7c88Ve0sZ2AUqAj7aiGFa9u/DZ6uuN+5O
 dJTbcowmOysMrykfGRu/8RxBlxcu9A9j26FyYpSVrKDB2G8XnLRtddJsjLTVtX6r0f
 lWhzGyx/Z67BXBoBeXHFQwAV6eAXSQKrbBqCbTXecCS8FtShYkeK5KJOEqqWgA995X
 u+cZAf6FKE4Zdm0XFZJ4npQyd/V/+D02b+EgxjmldItR4NkFXiHXixl7/Zmy+/sNbE
 DKfrVyj/M3zfQGIlgMJJsjtKbuSTKEAFM7EIijePmz3v85P1f8Q4X9rtvk6lR3Xsab
 B87fBfxAygLAQ==
Message-ID: <sashiko-outbox-168156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/18] PCI/P2PDMA: Document directional ACS routing
To: "Leon Romanovsky" <leon@kernel.org>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, media-ci@linuxtv.org,
 linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-5-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-5-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:15:50 +0000
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
> P2PDMA documentation describes ACS controls as path-wide, although Request
> and Completion controls apply to different transaction directions and only
> affect peer-versus-upstream decisions at the path divergence.
>=20
> Document the client as the Requester and the provider as the Completer,
> the divergence port checked for each TLP direction, and the conservative
> handling of unreadable ACS state. Clarify which controls disable_acs_redir
> changes.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D5

