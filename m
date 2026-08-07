Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26E6C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0440A10E110;
	Fri,  7 Aug 2026 16:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c+kxaUlQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B0A510E110
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 16:11:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB67743672;
 Fri,  7 Aug 2026 16:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADB61F000E9;
 Fri,  7 Aug 2026 16:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786119094;
 bh=/uehqPtO6fzvorRMmv219lG/7VimKmOUdSTBW8oIl5M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c+kxaUlQONT3sLNGEKIRX9f+F4zKkKkIabkmQljybGp31Q6KWjO7ziUymsBSPXp4E
 nZDbTCAFsx5D0JAxfzGLNMLG++lzL1eYLpwcS+AalcPfvQbVMiL/hKth3Gjfqp7qot
 631vmTn22+aq9v8l/1eCB4/qttoIaykS//C10qh4nD0nvPhS1V8AZ/g3ep55l/pyG8
 7luys8SUY2gmM4bSJzOxQgNJ/dtBn8bmuectYO/bl3iab1RsbPnE2YGO0cw+AQXvin
 Z1sSlgq6SieF+flvJhoG+P8AhlRE0tn9Vf4g1o2CDOQCt5BwU9I/l5immvXkINOVjU
 eN+6fM8Z0fXvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/10] bitmap: Add bitmap_allocate() function
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-s390@vger.kernel.org, devicetree@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, media-ci@linuxtv.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260807-tegra-vpr-v4-4-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-4-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:11:33 +0000
Message-Id: <20260807161134.3ADB61F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D4

