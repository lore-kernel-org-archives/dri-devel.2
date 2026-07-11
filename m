Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46351C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C2210E723;
	Sat, 11 Jul 2026 06:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JcbUf8BK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B57910E723
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:06:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71E726136C;
 Sat, 11 Jul 2026 06:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CC41F000E9;
 Sat, 11 Jul 2026 06:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750004;
 bh=AScS5Hu9MhskSZVYZ+wkLIepGShss4ol+Q0/xHE6sXw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JcbUf8BKqR6V04qGks4ExkRAp7s/TnN02xCc6a/G3D2joCiHHbE3vvaRdAqBX486G
 ZLbednDl50kSPsdrYn0J9LdNWBMlKS3OruJb9MNfxx1xqMGxB7YdxIqbdsGRI7rqin
 xZLI3oHGnkLNTOgDgrFo0aJgv4JCpYO5WhuJ7yL7qtW7c6Jh2f1+tdHgl4A69Cki+1
 qI5Ki+YZcx76evokg0TcYxtEpNotxYXpe5ex5IxQor3Phokx+vF9QQxFygViRVjcT4
 E5hWx+WO7Qjepes3jc2bZwA4mjIJvzk1sT7ISGQXFKzi4aqITml7DGjbl21saLQ5Gy
 Xb37DGfFDiTWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/16] arm: dts: omap3pandora: Don't use DMA channels
 for unused SPI masters
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, robh@kernel.org, lee@kernel.org
In-Reply-To: <129b1ff8e73235c74ac66dab9041672190065785.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <129b1ff8e73235c74ac66dab9041672190065785.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:06:42 +0000
Message-Id: <20260711060643.C0CC41F000E9@smtp.kernel.org>
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

> From: Grond <grond66@riseup.net>
>=20
> On the pandora, only McSPI1 (spi0) is actually used. Because the device
> tree defaults in arch/arm/boot/dts/omap3.dtsi leave all of the mcspi
> interfaces enabled, the DMA channels which the device tree assigns to them
> cannot be used for anything else. This is a problem because OMAP3's sDMA
> controller can only have 32 DMA channels configured at any one time.
>=20
> So when we try to use (for example) the McBSP subsystem (which is required
> for sound) it doesn't work because we've already exhausted our available
> DMA channels.
>=20
> Fix this by disabling mcspi[2-4] on the pandora device tree.
>=20
> Signed-off-by: Grond <grond66@riseup.net>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D5

