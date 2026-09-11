Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D4AC88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49EBB10E028;
	Fri, 11 Sep 2026 08:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QssYDKOf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669B510E153
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:56:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C50D7601EF;
 Fri, 11 Sep 2026 08:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0380D1F000FF;
 Fri, 11 Sep 2026 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789117001;
 bh=CgA1Xsk4ixk8Enne9s1FJDyGkyhfswytOSbwAT3UYaQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QssYDKOfAtKgIlx5YkQFsqEdvYJYFdqrqKCwpumo+a+jfd3oNId8LibZwRPDdPG7W
 5NuFDUVzKwMaAdK7uGxdV2PRJLMerjtrEq5exU6VL8BJnqRxeFXGU5LAXzDHRfzXYN
 IT48UeWKO+ktVKDqxyyfBm8SjF2GvjgDAUiqmo1d47I38C307g3LKOZ3AFnW+YHIm/
 Nr0hRb9gCfElIKn48OIe2nUwC89pb6bXMKwQWtvX7nkxJUrmUvFVE0KxrZkFoU0g7e
 BZVv9N7jz3DI7cHw4qXP9+6eMRV/Zhi3V9g/Xb4n+fXMwqkQUj9wOjLXpFUbmM5EkJ
 0WuWcaS9RP5qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: backlight: add Kinetic KTD3136
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-1-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-1-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:56:40 +0000
Message-Id: <20260911085641.0380D1F000FF@smtp.kernel.org>
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

> From: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>
>=20
> Add devicetree binding documentation for the Kinetic Technologies
> KTD3136 3-channel LED backlight driver using the official "kinetic"
> vendor prefix.
>=20
> The device is controlled over I2C and supports an optional hardware
> enable GPIO line (enable-gpios), supply regulators, and standard
> backlight brightness range properties.
>=20
> Signed-off-by: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D1

