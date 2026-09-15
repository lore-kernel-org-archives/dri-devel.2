Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897CFC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDC010E5A3;
	Tue, 15 Sep 2026 15:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EwVsqkgl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5BB10E5A3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:40:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C9C5B600C8;
 Tue, 15 Sep 2026 15:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4731F000FF;
 Tue, 15 Sep 2026 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486849;
 bh=yPAbk7xHpMR4UIVrHHyhM9TISgEmvd92P6HdWfgzRAA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EwVsqkglB8nG7QQhouls1YoCYwZp6BueS50C5QZ2LEnxBF4uK8Rk0HOPKvNdYquTC
 skVctbFd3T19TaI4YqtaKiVKMNMdFCbTUgjgNSkHoet7fqhLeybmJj6udQaKTa+8Yp
 2ROddcj722mbG1T1EAFWl2B7MPRIpJj9woTRWrJKs3cs66jmyc5CRsCfLOLPSVtqfe
 8xHRks81n7WSpy51DObQ6LGP0VqHc7m1v8QJGZfVl2O9XsR0THaldnj3nX49rbCg19
 vgJV/zhhzu7HdFKLmn9c23q+jxZcDcMZz4P+q6OY87lIJe8sN+uRHQJEVCIAyz7HFG
 DmRr1t/IWr+7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/20] drm/bridge: inno-hdmi: Make the PHY
 configuration table optional
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com, robh@kernel.org,
 lee@kernel.org, vkoul@kernel.org, linux-phy@lists.infradead.org,
 neil.armstrong@linaro.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260915-jh7110-clean-send-v4-11-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153233eucas1p2e26a6953a31c5f836aeaed03a4ae325e@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-11-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:40:48 +0000
Message-Id: <20260915154048.DD4731F000FF@smtp.kernel.org>
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

> The pre-emphasis and drive-strength values in inno_hdmi_phy_config, and
> the registers they are written to, belong to the PHY integrated into the
> controller. A platform whose PHY is a separate device has neither, and
> its own .mode_valid already validates the pixel clock against the real
> PHY, so the table only bounds the generic check.
>=20
> Let such a platform omit the table: skip the integrated-PHY register
> writes in the power-up path and the table lookup in .mode_valid when it
> is absent. Platforms that supply one are unaffected.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D11

