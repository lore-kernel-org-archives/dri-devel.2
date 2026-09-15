Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BC9C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A396F10FC55;
	Tue, 15 Sep 2026 15:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dn/ZCzLv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD81D10FC55
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:35:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 960C543D7F;
 Tue, 15 Sep 2026 15:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85DD1F00893;
 Tue, 15 Sep 2026 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486544;
 bh=/8/hW+qxYN77uifUveBYUvPnrFFoDTHqZaAe2GTTgeI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dn/ZCzLvjCO80mdf2cjHQ4RdPpJ3hR/HtnXU/uzEM2BaeAxtkJO05XqL6yOY7lVNN
 8LhS0X1r5SjuOhBphxE2r90uqcJIUYawoqPmn65oUCkMqC7OD0nr9R3m+Lrg1rFuMq
 s1JjP0I0qmtpQvYXrBht7tlV47gZiAvp9XQEPcIQU+CfQ8sGdrwAYt5ulm0LuW/Wlf
 LBfNNZO8HhZignRnzRwAO9bhHnezvmzP8xqvs8W1nY4t7iaJ6Q+ZAnL2lFuaeumFPb
 qIxhwKssEZ8EbBj47Nw1GmZ/ZoSaawYdYhjEVKVEyLDXMkgSXypbwoi8qpe29tWifK
 7tbxLc54YUOOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/20] dt-bindings: phy: Add
 starfive,jh7110-inno-hdmi-phy
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: vkoul@kernel.org, devicetree@vger.kernel.org, lee@kernel.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org,
 robh@kernel.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com
In-Reply-To: <20260915-jh7110-clean-send-v4-1-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153214eucas1p2b548f3236ef98fb0cbf320e397420125@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-1-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:35:43 +0000
Message-Id: <20260915153543.D85DD1F00893@smtp.kernel.org>
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

> Add the dt-binding for the StarFive JH7110 Innosilicon HDMI PHY.
>=20
> This device is a child of the starfive,jh7110-hdmi-subsystem node. It
> functions as both a PHY provider for the controller and as a clock
> provider for the variable pixel clock (hdmi_pclk), which it generates
> from its refoclk.
>=20
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D1

