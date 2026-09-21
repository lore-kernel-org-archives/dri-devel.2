Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D1EC982F1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C047410E3E0;
	Mon, 21 Sep 2026 18:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gn+Rqw8J";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65BA10E3E0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:44:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C589B60008;
 Mon, 21 Sep 2026 18:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAFE1F000FF;
 Mon, 21 Sep 2026 18:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790016265;
 bh=Brk3K24u0/lPXan924zoDImNVkSErDdrsyqHIFP4Ro4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gn+Rqw8JQ3a0QF5Okxp6vDUI5BzFxeeoQwPCaKnfgN5bK5A4Q3Yj1gf3bupACALYh
 WoVHTlGUmrNcW0Ua+9GtLVP+V/sptKP0sKA7WN/txtxbTi/beyFN6WEK/zAn0m2pj1
 2XExFSl6tOpyqpOhFwt2TOWVAPWflugI8FKu+X/GBqz/oa3TPfQuL2uaSOQlevW2D6
 v164IzAE5+nij4GIR3Xv7yUfF27dbVNm3nBZROGlNmGcuQI8nm8PPbmgNncPKuEyYc
 9c4dAkdcf5UClfttmAlc8H6if3VhczOpX21ERbIvRJrboTmCsA6fJNGBw1h1s018pZ
 YFWeGAViP/SOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/19] clk: qcom: Add global clock controller driver
 for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, lee@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org,
 dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 linux-clk@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-2-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-2-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:44:24 +0000
Message-Id: <20260921184424.EFAFE1F000FF@smtp.kernel.org>
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

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> This driver provides clocks, resets and power domains needed for various
> components of the MSM8952.
>=20
> Some downstreams merge MSM8952 to MSM8917 and MSM8937. But upstreamed
> GCC driver for 8917 series has different pll structure and ported from
> different GCC driver.
>=20
> MSM8952 GCC driver is mainly based on MSM8939 GCC driver, with
> some parts added from existing other GCC drivers.
>=20
> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android=
-wear-7.0.0_r0.3/drivers/clk/qcom/clock-gcc-8952.c
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D2

