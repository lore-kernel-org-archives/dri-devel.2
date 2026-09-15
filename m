Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D34BC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963C210FC57;
	Tue, 15 Sep 2026 15:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VsVllUNZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD28310FC57
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:35:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C309143CA7;
 Tue, 15 Sep 2026 15:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101771F00893;
 Tue, 15 Sep 2026 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486555;
 bh=fca0YU5wZJuYa6HE60kkyvWGAmizplbtlVsuBRCSgX8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VsVllUNZS+5kLKM+n1mG2KHU6cnK3h2KUvVNUhsfFd2Ko7dgoep9CXHnfa0zB91Te
 hkrtuX2ENZH2Fhac0m/fU3Ma2a3mxwCpwkk2Dq3PaVItQUgKA4lQLU/miwuCtyYBv2
 +g3Gb1jbHNbRTfCo4wHRUDBOf+DdlERpfdSlFlyA4XkqBq3O6VbzF4fwwPCV37TRc1
 podRWDCorpjkP/OqqpPFtmrD5nt4pxqAdQNo2KaPp5jGjMOWJs1N2ICgJRCwz3zlpF
 /O39RtoJwkGRx051E++XcfqVwUU0KGnQp7M+Nui1LPKLKjv0oMP3KBJzJVY/byeYFV
 +ie1Mw+r3Atog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/20] dt-bindings: display: bridge: Add
 starfive,jh7110-inno-hdmi-controller
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-phy@lists.infradead.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, neil.armstrong@linaro.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org,
 lee@kernel.org, olteanv@gmail.com
In-Reply-To: <20260915-jh7110-clean-send-v4-2-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153216eucas1p2388b49e6b4c064ea49639d21f987e05e@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-2-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:35:54 +0000
Message-Id: <20260915153555.101771F00893@smtp.kernel.org>
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

> Add the dt-binding for the StarFive JH7110 Innosilicon HDMI controller
> (DRM bridge).
>=20
> This device is the second child of the starfive,jh7110-hdmi-subsystem nod=
e.
> It consumes its register access, audio master and audio bit clocks
> (pclk, mclk, bclk) from voutcrg, and both the pixel clock (pixel) and
> the PHY from its hdmi_phy sibling.
>=20
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D2

