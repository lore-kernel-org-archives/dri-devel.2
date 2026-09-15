Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91992C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DB810F7B8;
	Tue, 15 Sep 2026 15:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A9AAdEaY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80AEC10FC52
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:35:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 67BCB4371B;
 Tue, 15 Sep 2026 15:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1571F00898;
 Tue, 15 Sep 2026 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486513;
 bh=XSb8dXizqy5/EqI8CxSB6VpYY3eCdPsC9ugr3cwl2Vc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A9AAdEaYvscgYzGfa9JvOhjKbnzT+IN3imErOzjDuyz0iJhJcHcbJyREaNre0XXFJ
 SGx5nqCAs5uR5DJ0AGfp2sXm1ICyAAEeVL2nMIJ4hQaP4PYABSYWBjtdxudZJ9+KDH
 Ha008Bcwkm0ew36LE9r23SgomnutdEZRal8qcy267B5nLDpC8ZuyYeFl/dPvvoW5mM
 7FaO2aNsmcl43a1a2tzeyUGFtHqmrL1UrkpF7PruvQpp5Gi5bMQ+etrEg4xuAYh/7i
 waEVPF+NL0fFo9yqRX8dqV9UG1Rfb3/HBVLCsaivBeRWICBy0rgIf9wuKGToGgNAFG
 eExbmj9Ag+raA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/20] dt-bindings: soc: starfive: Add
 starfive,jh7110-vout-syscon
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: neil.armstrong@linaro.org, lee@kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, vkoul@kernel.org,
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, olteanv@gmail.com
In-Reply-To: <20260915-jh7110-clean-send-v4-4-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153220eucas1p1f5b0e03015500d9d66db8993426c8734@eucas1p1.samsung.com>
 <20260915-jh7110-clean-send-v4-4-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:35:12 +0000
Message-Id: <20260915153512.AD1571F00898@smtp.kernel.org>
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

> The video output subsystem has its own system controller, documented as
> dom_vout_syscon. Among other things it holds the mux that selects which
> DC8200 output drives the HDMI transmitter, so the HDMI controller needs
> to reach it.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D4

