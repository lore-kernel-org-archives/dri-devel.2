Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E75AC624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D06510F952;
	Fri,  4 Sep 2026 13:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MaaFaaz4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B726F10F952
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:30:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D211A600D4;
 Fri,  4 Sep 2026 13:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A4D1F00A3E;
 Fri,  4 Sep 2026 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788528655;
 bh=B60l+04pVEJwF9CCsix0ruYdcieZB/hTmAshk7wFSYI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MaaFaaz4nSYAq8MkFJX8WlwMDKregF1jJ38pil8/kUZLbAnCG8TxTZe8d+NDnpGeu
 x4kBSbvM4JxDwNm/mtdEPpwV0sCMmnWoEjugG2l7+4egWhj2fHm5wxq1Oxd7zZsogU
 6FaHckjIpcfdp5168g3boalKXjoa7oxU5fna/9dn22Awhn2OCDfIJhFpawBbfxwCsT
 AkeHThzC7CSQHS7TfwbQt0VO1n1s+7iUEqdF0lD+43azAjeTaSR29fBcV9UXwPhDYB
 7Gw2TnQvHIfg4g8+4DmMwBR0vuT77VTQzPibvMNip1FIKljzNHQDs7iFiYKDu7x/mx
 ch5Tc12JdiN6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/19] dt-bindings: phy: Add
 starfive,jh7110-inno-hdmi-phy
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, robh@kernel.org,
 linux-phy@lists.infradead.org, mfd@lists.linux.dev, vkoul@kernel.org,
 conor+dt@kernel.org, lee@kernel.org, neil.armstrong@linaro.org,
 olteanv@gmail.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-jh7110-clean-send-v3-1-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132710eucas1p276bacb1cda0a62d7f29066bd66660fea@eucas1p2.samsung.com>
 <20260904-jh7110-clean-send-v3-1-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:30:54 +0000
Message-Id: <20260904133054.E1A4D1F00A3E@smtp.kernel.org>
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
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D1

