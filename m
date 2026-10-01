Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B64CCA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D358610F38C;
	Thu,  1 Oct 2026 12:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RUPNXfU7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD5EF10F38C
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:02:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ED2AC60A52;
 Thu,  1 Oct 2026 12:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F261F000FF;
 Thu,  1 Oct 2026 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856162;
 bh=144qZN6CK5nkadRh+grZbQAx/hsRy8TadxTdBV5k+BY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RUPNXfU7jxyyd3QWIBwdQcb8vL/qCa2UlwVaxHjtgyu4HrD/mOJdR8vffpmYRcZJd
 8Kif4rARiqqYlT4A8K07GXCULsQnJkliprMyBXmz9ZTWgbZDbRgccxKMUEVnkyhWoR
 iXJUe6rLs4unYbvS89r7vUQJo60hCdKCKR4Fbll8s/PF+U35MyxXSh60eM/UoJed/q
 rdicIIyLdL0Ghvhpuwhu2qzcBTOpj9C3tiSHHM1Pc8A9P8DwCtq86V8FDU5GdVTuZX
 22KUnN3QwQ5Y0baLavbhlf5MMj/GPQ5KrTRTEoIulEpI4xf+g7/RSVTQ3TKRaUaJrL
 BdHoSU/6oezJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/18] PCI/P2PDMA: Route Translated Requests under
 Direct Translated P2P
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-10-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-10-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:02:42 +0000
Message-Id: <20261001120242.70F261F000FF@smtp.kernel.org>
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
> Add PCI_P2PDMA_TLP_TRANSLATED and consult Direct Translated P2P for the
> Requests it describes.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D10

