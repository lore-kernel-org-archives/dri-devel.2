Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7413CCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06B010E475;
	Mon, 12 Oct 2026 13:17:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3AA10E475
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:16:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A248D42AF6;
 Mon, 12 Oct 2026 13:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A8E1F0089B;
 Mon, 12 Oct 2026 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811017;
 bh=Fkm1iFcb2sHuFSqHNn0RIxRFaBK2HnB/BntYmcKe1vI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b3kJpwgqo/mdZZoDO07n1E1+VSq1+S8aInFO+PiG1q/ug0aOugzzcrJcfu3mVWf95
 srBl1SBE2XJuF6iIiVlWqkhHianVvINJSAhJiwLAEtaQvLcZgTb1keajPIS1rg4Aud
 z9JNpM28SpdrRipURUKP1imLphukrhzSrR3c3oIyO9gsB8GimUpZyJ3HTHJ3VzxVRY
 HXx3f0dtJcVjI03HCzDD41WouvZhc4O+cXPS2VD5RfwKn5/hBfXuYAIY49xOmDqA4U
 QYp5BsI2HvxaL2jBSlfjc0iRvFWFin3dDXCVBN3LZwlsgYglljZn5nAfVe5EjVmi2V
 H90RuwlHpBUBQ==
Message-ID: <sashiko-outbox-168158@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/18] PCI/P2PDMA: Derive routing from directional
 ACS controls
To: "Leon Romanovsky" <leon@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
 dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-2-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-2-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:16:56 +0000
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
> pci_bridge_has_acs_redir() treats Request and Completion Redirect as
> interchangeable. On asymmetric fabrics, a control for only the reverse TLP
> direction can unnecessarily force P2PDMA through the host bridge.
>=20
> Evaluate Request Redirect for the Requester's Requests and Completion
> Redirect for the Completer's read Completions. Continue treating enabled
> Egress Control conservatively as a Request redirect.
>=20
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D2

