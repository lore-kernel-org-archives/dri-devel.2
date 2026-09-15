Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3222C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E0510FC64;
	Tue, 15 Sep 2026 15:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ibC5vlZU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C9610FA31
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:37:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED8FD41475;
 Tue, 15 Sep 2026 15:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFC11F000FF;
 Tue, 15 Sep 2026 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486626;
 bh=4CrTuEZSFu9uoLUwd8D9N7dRg15ETOXWQTzotPiLW0g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ibC5vlZUdyOkLs5sqekYWmSBsu57nxQ5tiEzp8lroSkfdxR4Y2Br8prUaCJTs+5Xe
 Ilxo47omY2qYUJJqnrcj7DcIupfnAEiBPZvamBw3U0qcclxHP0JVXqYWVIgq22rR8K
 rLXsdE6pDcM31MoNAkVGCvUxihTvp+9sHec3EGePsBRXx9fODrq7j8tKajwLNUOTvU
 DFrIvO2bQNjUPe9uRwT8MSECIpv5vKJ4KGUCFcQq2BdW2lCYpIxLbkV8AYjdkJxMdy
 EhpNKGhitYQaTy5dY7XQ330DhU4hVFswj1yDsWlTNXYG+Q8Ws41fzudlyFRULjaH2C
 YpLBFP7j0/5FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/20] drm/bridge: inno-hdmi: Add .mode_valid
 platform operation
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: lee@kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 olteanv@gmail.com, robh@kernel.org, linux-phy@lists.infradead.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, neil.armstrong@linaro.org,
 mfd@lists.linux.dev, vkoul@kernel.org
In-Reply-To: <20260915-jh7110-clean-send-v4-10-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153231eucas1p1e106fee2d6f7db2aa8bb93d18d0f5dc1@eucas1p1.samsung.com>
 <20260915-jh7110-clean-send-v4-10-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:37:05 +0000
Message-Id: <20260915153706.3EFC11F000FF@smtp.kernel.org>
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
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D10

