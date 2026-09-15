Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEB6C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0EC10FB14;
	Tue, 15 Sep 2026 15:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hmTD19Y1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B93E10E00D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:42:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B324F600C8;
 Tue, 15 Sep 2026 15:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4881F000FF;
 Tue, 15 Sep 2026 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486958;
 bh=7Vx16qxwEkTNfbzykTnvh+0c27LHNjH/X44JjJbizcg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hmTD19Y1PJoy/SdbWt4a2mLXPgWnUpHE1h1tBiQ6NGZZd6cCd3Dhw7qzbRzLCxlqA
 lzzCSHyUCca76SFKQAeRwr4OPeXd3szV9vRefA4Dh6uzRA6KMi2kctNrbF1UPGHohR
 lOrnsIMs+kHtfF39nNQqYkPAKrdNJRZjA/p5H3xWzfKLvuR+OBi1cB9mumP1Jv3Iau
 fY66LyNP6d5eSUd7pMipafLAfLVLmgRT+hcBSWNyonw27jmRKc4RZqgRcKbWnx09W1
 0KsrqjiHYkRSxVHRj+gS4iVx9qE6/5zIdtTwpSltWso5kEtD1RoV6Y4qCUpTlwYqP9
 0DBzvZ2QF5bSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/20] drm/bridge: inno-hdmi: Allow the register map
 to come from a parent
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-clk@vger.kernel.org, robh@kernel.org, olteanv@gmail.com,
 neil.armstrong@linaro.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, lee@kernel.org,
 vkoul@kernel.org
In-Reply-To: <20260915-jh7110-clean-send-v4-8-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153227eucas1p2c51b87dc8da5d9dfacd6db6bb7d6774e@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-8-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:42:37 +0000
Message-Id: <20260915154237.CB4881F000FF@smtp.kernel.org>
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

> On some SoCs the HDMI controller does not own its register window. The
> StarFive JH7110 documents one 64 KB block, u0_hdmitx, that holds both
> the controller and the PHY, so the parent device maps it and owns the
> regmap while the two children share it.
>=20
> Use a regmap supplied by the parent device when there is one, and keep
> mapping our own resource when there is not, so platforms that own their
> register window are unaffected.
>=20
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D8

