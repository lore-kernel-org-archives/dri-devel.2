Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA2ACA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B0610F0F5;
	Mon, 12 Oct 2026 13:19:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C2D010F0F5
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:19:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34FFD41747;
 Mon, 12 Oct 2026 13:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C121F1F0089D;
 Mon, 12 Oct 2026 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811143;
 bh=kr5UNsckQO8vPzxdUZssnArdijq87Q4YdO2m70ZRuY8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a2hul9GsDtccfLBw3VYOP99EEDrEkkiJuLGbLlpGCW7MiJxwU7UpvYYSoT4MPLmS/
 8oG2ihwiZVGAZNEuOGE5Szpo5Azf9RR45Py+nvTBgf9CSITC1q/U9vy6Md+DFfHOQP
 GDNv5AYdmHR3Eclk9ysNJ+gx+jfkhGh36t/YxdKnZ8P44iwVODDkPtwoQIQX2ExYrj
 pWxX2mRjuhxPMSMTOUtbGcCEWCygUPftqJYLnd9e6bhfcNYNDNJULAUsT1ahU04trA
 oTA9MSVKlqdG5ig9Q8kV9Q3wkeMpoaKyKZvnv0+E/2XcztR9Mtm0F1PNZLFhs8yaG6
 c+zoF3541I+hw==
Message-ID: <sashiko-outbox-168164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/18] PCI/P2PDMA: Add KUnit tests for the ACS
 routing decisions
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-12-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-12-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:19:02 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D12

