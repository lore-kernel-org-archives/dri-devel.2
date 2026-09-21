Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248A3C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5071510E5E0;
	Mon, 21 Sep 2026 18:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kkiVZtvI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D39110E5E0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:21:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCAFF4048D;
 Mon, 21 Sep 2026 18:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F761F000FF;
 Mon, 21 Sep 2026 18:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790014864;
 bh=F0jb/M4H+otVLuMrx9aq5D4ceQrwhN6iSrOceq7sh5I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kkiVZtvIeXwUTFzO273peMhE0R8TCCgOipJu9uAQBh5syNFOlm6WSa1WCxT6NgNVr
 TR1aYmJ1hd/ID06dnQY0BGbF2dFfv8uRfMeEm7b1GG2ZfxYEEySPM2hbYCb2om8hdA
 RTaFQLDufj553hRg6NQUFFmoCLmDpGZfcM1LdsnWkWJjWmhnwhsKHT7sL/96wFQ+ax
 fG/xxgCGW1EThMGbaHlMCCaopsx0PSQjBxBjdZulS3LkM55LZIcRrqOKN7sCXwO5pN
 x6GATEN3kZA5pGkgyOtHml5CPJpSW4xw0evtxaXjAcuK9HZB3l0C8Usp+Iz7HYpLyl
 YJ5h7btUASaHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/19] dt-bindings: vendor-prefixes: Add General Mobile
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: mfd@lists.linux.dev, dmitry.torokhov@gmail.com, conor+dt@kernel.org,
 linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 lee@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-6-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-6-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:21:03 +0000
Message-Id: <20260921182104.13F761F000FF@smtp.kernel.org>
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
> Add vendor prefix for General Mobile.
> Link: https://www.generalmobile.com
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D6

