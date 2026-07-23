Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E2BC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0530510F06B;
	Thu, 23 Jul 2026 10:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KHTZYqAV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65AC110F06D
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:16:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3281C40C4B;
 Thu, 23 Jul 2026 10:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C34E1F000E9;
 Thu, 23 Jul 2026 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784801786;
 bh=2AQHtmH++ujNKbkQiRN7j62h7+OBOvExh3JqXe+5XPQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KHTZYqAVAvt67PSRMHBMDYH8ipyCy6lgzElu2e0FiJh6jB71mwZGMR+V0hU7QrxhA
 BISJWx2p4rB6gXSbN1vDUwyfbD4ckv0KaYHnUpDyICq4hakTPL/L0Dnxjnf5zJsaIF
 fT3kQOlSZaXLf2t2e7xF085QhI56vjaGh7EOd+YHIsETQ9oLrjAlMJbbLaLlW3w2G2
 F37SsNficKBJlfMh2MLR1Nv5gZmjrIqnUZ++7Ir5L03n+L8WGtK8bfyzn6O8ZsLTzx
 acuV1ZC9Ip2WPHk/yG9LaeZ92I3VyZ8eOFWTQDkQohEdzPTCgQ0l5k5YEvNzPsLMAX
 SX41MIciNZVOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] ARM: dts: Rename the TPS65217 regulator nodes
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org,
 conor+dt@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260723100605.628882-3-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
 <20260723100605.628882-3-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:16:24 +0000
Message-Id: <20260723101625.7C34E1F000E9@smtp.kernel.org>
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

> The TPS65217 regulator nodes are named regulator@0 to regulator@6 and
> rely on the deprecated 'regulator-compatible' property to be matched
> against the driver, which looks for "dcdc1" to "ldo4".
>=20
> Documentation/devicetree/bindings/regulator/tps65217.txt states the
> regulators must be named after their hardware counterparts, dcdc[1-3]
> and ldo[1-4].
>=20
> Rename the nodes accordingly and drop 'regulator-compatible' along with
> the unit addresses it made necessary.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100605.6288=
82-1-egbostina@gmail.com?part=3D2

