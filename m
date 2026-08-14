Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FB1C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE4E10F68C;
	Fri, 14 Aug 2026 15:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f1iCb/wJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA0C10F68C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:36:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 132464011A;
 Fri, 14 Aug 2026 15:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC83B1F000E9;
 Fri, 14 Aug 2026 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786721799;
 bh=PQIkyo7HBubH8g3zjI9SYWhaMUDhOOXr/Ae4jDKqfEQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f1iCb/wJ6ZG8MaK8teuItWrg3jOWRTUPslK+k7nfH7pmg/QnxBHhXhlOB04G+CwMk
 PjtK3rcXUPHbEa7OroWd8j/1UpDX5EilKUz7ykmAeUVgREuqHNLWpkLgtasUAgQvSZ
 8ZG5l7aW5JoPsudX2m61RpCWxpgkh0EpvyTraJNUN9lruz8+0Wgj9FLjTX7vq+5EUp
 OumlpyqTEftxuiSjMA92rmVYKaIgzgzVd0/MmShfC2OQc//2OvyNdKoh79PZkPt/yx
 kB0Qt9gmjqeDOIq2U6OVeaEkcIyuERdl3zd0wRVmbowDIBciYLSCQ7PdUE8efcOHEt
 /dJIpuTEKuefA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/10] bitmap: Add bitmap_allocate() function
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: media-ci@linuxtv.org, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 devicetree@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260814-tegra-vpr-v5-4-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-4-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:36:37 +0000
Message-Id: <20260814153637.CC83B1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D4

