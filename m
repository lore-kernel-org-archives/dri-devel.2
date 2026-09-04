Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE96C79F82
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72A710F9A8;
	Fri,  4 Sep 2026 13:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QSBvP2ks";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97CF210F9A8
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:40:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C803A600C8;
 Fri,  4 Sep 2026 13:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1F71F00A3D;
 Fri,  4 Sep 2026 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788529204;
 bh=pRZjf1t1QNssaAqOhNxzB26mEPbKaEL3JUk2vDan9u0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QSBvP2ksMLF1HlhDOZ4HoePs3Gz8S/t+Hkbs+sJ052VHD71koRG6fspfUVc8TKy45
 ANcatLlfpm59InFFu5GbAUFzSCfN9pUL7M6v2B8KrsOGxNwr3vPCIgKpFaVJaczWNB
 FtCBsZlL8bQkMxtgV3SpLC1/sP2xdj4ujj47+0XzR6MqJK6krPkiLHop29O8Jv/TnL
 I2XgjRISlnfL9WMrBAHeMJ6XdpkwJj73LkqE31YJCbHh6PJRi4Cz9DyC6Cdhyg3fEY
 oJOrZJQUpXYzxUNjl1sleZjFY87PgQ4y2+BjYGy//3LrW9HiVP8+4wpK2BdRQQkaiz
 SdJ4rq0gjMntw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/19] drm/bridge: inno-hdmi: Add .mode_valid
 platform operation
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: robh@kernel.org, mfd@lists.linux.dev, neil.armstrong@linaro.org,
 lee@kernel.org, vkoul@kernel.org, linux-clk@vger.kernel.org, olteanv@gmail.com,
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-jh7110-clean-send-v3-10-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132727eucas1p241a5ba1517b5c6a2efde7bb2fdebf299@eucas1p2.samsung.com>
 <20260904-jh7110-clean-send-v3-10-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:40:03 +0000
Message-Id: <20260904134003.DB1F71F00A3D@smtp.kernel.org>
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

> inno_hdmi_bridge_mode_valid() validates the pixel clock against
> hdmi->refclk, but that clock is optional and is only present on
> platforms that describe a "ref" clock. Platforms where the pixel clock
> is produced by a separate device - such as the StarFive JH7110, whose
> PHY is both the clock and the PHY provider - have no "ref" clock, so
> the check is skipped entirely and every mode is reported as valid.
>=20
> A mode the platform cannot generate is then advertised to userspace.
> The subsequent modeset appears to succeed, since the atomic enable path
> cannot fail, and the display silently stays blank.
>=20
> Add a .mode_valid platform operation so platforms can reject modes they
> are unable to drive. Platforms that do not implement it are unaffected.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D10

