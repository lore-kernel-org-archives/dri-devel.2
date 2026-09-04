Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE60C61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE45510FA9D;
	Fri,  4 Sep 2026 11:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kSBVDR1i";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2AE10FA9D
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 11:13:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 45C9F60120;
 Fri,  4 Sep 2026 11:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819631F00A3D;
 Fri,  4 Sep 2026 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788520408;
 bh=GGdEdtKn7kkgQkWrDXlVDLAtR8IIDSrfcQgr/GicTdI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kSBVDR1iVhBGpSa5O73IaGc5mASR/Lv7px82EN+fkIwDhqWvBuH8sqT5ZvepLzp42
 xWHoF19ZnzHeYcHSjOxIZdHnsub1HWLWNw3Qdv4CF04/eh7SSP9cNOUerfRJIvI0zx
 GsqxOveAyeVe9W/G4K/kpSlg5wJgApTpTYeufXMJfoHQS4KZDBsKsbc0HOQ0E86Ssg
 1+fjoqBUQnS2EC7pDvj3FOOska8Jkp7O95N1B/BGUmI/e+7AF3teHAKB/W/9+x/Vtq
 mJV4c2pgChXv3Ie+AGEp2bhg/fiS5asZGXyB+SQtjL/N7aifrH9qJWu2uyd01AUpcS
 i4pGIL+NNg6ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/12] bitmap: Add bitmap_allocate() function
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, "Heiko
 Carstens" <hca@linux.ibm.com>, conor+dt@kernel.org,
 linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, robh@kernel.org,
 linux-s390@vger.kernel.org
In-Reply-To: <20260904-tegra-vpr-v6-5-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-5-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:13:27 +0000
Message-Id: <20260904111327.819631F00A3D@smtp.kernel.org>
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

> From: Thierry Reding <treding@nvidia.com>
>=20
> This is similar to bitmap_allocate_region() but allows allocation of
> non-power of two pages/bits.
>=20
> While at it, reimplement bitmap_allocate_region() in terms of this new
> helper to remove a sliver of code duplication.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D5

