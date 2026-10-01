Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3B7CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6553010E3C0;
	Thu,  1 Oct 2026 11:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JDcRhGPE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFE810E3C0
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 11:59:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 21928601E4;
 Thu,  1 Oct 2026 11:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F881F000FF;
 Thu,  1 Oct 2026 11:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790855972;
 bh=tx5M2Oghx5c0OqYMdtecxSSBoIbMKDpofbQ49tmB7hE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JDcRhGPEP6NtxD4FkWKf28dFizbzAFRGJLL/iMvPI3dTBiRiQdH9Ja0tIHDVxtyFq
 XAhz1GA51l5ZDjj4viVsNCl9Jq6NNUHnw9z8t4NG3E1VrBfs0yP9Y+yNiATA0RTLn4
 LYOyNab5w88V70XgnnWO32/IzvUIc0lmr0rHtsdtSvFe7/L7Vz5vRyhzhbtUPGWnsF
 bR2V5UBYV7r7uYB0MJws7RlWf+aU9PJedwA/o/qe/+LxOAAUDA2F38UV1RgaY594JJ
 7hwpyDtTekO/a7h3WeeNLW24mjTxETTo0mRZvXrwKtgiqtBuW7N0mbJOoYxreaR3+z
 sHzFgtn2aSAUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/18] PCI/P2PDMA: Document directional ACS routing
To: "Leon Romanovsky" <leon@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-5-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-5-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 11:59:32 +0000
Message-Id: <20261001115932.75F881F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] doc: repeated sentence in disable_acs_redir description
--

commit 83321a8abe2362759f10e2c9273854fa000319e6
Author: Leon Romanovsky <leon@kernel.org>

PCI/P2PDMA: Document directional ACS routing

P2PDMA documentation describes ACS controls as path-wide, although Request
and Completion controls apply to different transaction directions. This
commit documents the fixed client and provider roles, the divergence port
checked, and clarifies which controls disable_acs_redir changes.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 68647ff4bdd24..bc83e07dd5fce 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5291,12 +5291,15 @@ Kernel parameters
>  		disable_acs_redir=3D<pci_dev>[; ...]
>  				Specify one or more PCI devices (in the format
>  				specified above) separated by semicolons.
> -				Each device specified will have the PCI ACS
> -				redirect capabilities forced off which will
> -				allow P2P traffic between devices through
> -				bridges without forcing it upstream. Note:
> -				this removes isolation between devices and
> -				may put more devices in an IOMMU group.
> +				Each device specified will have the PCI ACS P2P
> +				Request Redirect, Completion Redirect, and Egress
> +				Control features forced off. This may allow P2P
> +				traffic through bridges that would otherwise be
> +				redirected upstream. This may allow P2P traffic
> +				through bridges that would otherwise be redirected

[Severity: Low]
This isn't a bug, but there is a repeated sentence ("This may allow P2P=20
traffic through bridges that would otherwise be redirected upstream.") in=20
this block.

> +				upstream and thus this removes isolation between
> +				devices and may cause affected devices to share
> +				an IOMMU group.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D5
