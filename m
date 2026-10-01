Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B0ECA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F21D10E039;
	Thu,  1 Oct 2026 12:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iPeILIQY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A42A10E039
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:01:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F212E60A57;
 Thu,  1 Oct 2026 12:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8571F000FF;
 Thu,  1 Oct 2026 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856114;
 bh=CQSTihuvb/SazjypSDkBT7pkKSV2l50EwDS1UfOSrTc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iPeILIQY1rAYJYQuur7i29DQtkJesf77WMxcHo97Qf+yZ0M1gjZLAcMt39pYJrgz2
 2pbjcD8uwgGmbkPKULoT+2KAdLa19bK1EfCGhc49NqL+T4s8WLSXbeoycd6C50MMUJ
 ih0HrWrobMq4T5DXiRX7nOOCs1n5DT1pMp4ojo7iA2z6irhkI1K81fKJaTuTqK3Mu4
 btcxhoo6d3VAUcdNk3efSEMGfNCaZLcudqUe4Xo5ic9e+Jc4te5Q8PG/3z6WXFLs3f
 u8HHCf6RcmBqsy1xcmWr7qVYD3wZQ0FH3Ge/J065VeezpLTbwCkRj5lox6yGDN8h5R
 TWr8DWrIe5Idw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/18] PCI/P2PDMA: Add KUnit tests for the ACS
 routing decisions
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org, linux-rdma@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-12-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
 <20261001-fix-p2p-acs-v4-0-v9-12-1a8e0f50ddd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:01:53 +0000
Message-Id: <20261001120154.5C8571F000FF@smtp.kernel.org>
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
> pci_acs_p2pdma_request() and pci_acs_p2pdma_completion() turn an ACS
> Control register and a TLP class into a routing decision. Which bits apply
> to which direction and which class is easy to get wrong, and hardware that
> exposes a given combination may not be at hand.
>=20
> Drive both from a table of register values and classes, covering the
> redirect controls per direction and Translation Blocking, Direct Translat=
ed
> P2P and Relaxed Ordering. Direct Translated P2P gets a case with and
> without a redirect to override, since it changes nothing without one.
> Exposing the two helpers moves their state enum and the TLP flags into
> pci.h.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-fix-p2p-ac=
s-v4-0-v9-0-1a8e0f50ddd9@nvidia.com?part=3D12

