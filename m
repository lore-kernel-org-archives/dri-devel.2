Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C6DC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0226410FA8D;
	Tue, 15 Sep 2026 15:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nI1gSoAT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9B610FA8D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:35:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2EEAB600D1;
 Tue, 15 Sep 2026 15:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D2A1F000FF;
 Tue, 15 Sep 2026 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486510;
 bh=b8MGX+xCFQOMeqSYPH2BZXF5sDNIBn+JgMTA6JKV2sk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nI1gSoATvWgHYfuidAE0oPRxuYsTnAh1IQF6VS/hpqxQTL7St+XDu45ezG18IxyWg
 2UQsshK71EW1wdWdkaM/yB34jo6+haB+cjA83zTNdDFX4GOBrLlfTl8R/ZnXoLgLpJ
 mUuolrACU32pWPbttuPirhedylKwnfA0JC8hdcKC4MIFUd8z33c5dT5JCQHXCWe0RR
 gjeFGhxrsMe3+fpHIjw9PJV4Tj5KWUkwxQ+hHwTwOOg/ugXdh5CVSd9LaznmzKPRKj
 gIvkz37KEBCPfO25D2O1UEvKitF09wM7AT8rT3+kfc+Zq2OewupsZXSmc26gy/gEiI
 G0hrdRCMAFJ9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/20] dt-bindings: display: verisilicon: Add
 starfive,jh7110-dc8200
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: neil.armstrong@linaro.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 mfd@lists.linux.dev, robh@kernel.org, olteanv@gmail.com, lee@kernel.org,
 devicetree@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260915-jh7110-clean-send-v4-5-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153222eucas1p213b95b05ea7eb9a18700af8888ef5a44@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-5-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:35:09 +0000
Message-Id: <20260915153510.38D2A1F000FF@smtp.kernel.org>
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

> The JH7110 embeds a DC8200. The binding requires an SoC specific
> compatible ahead of the generic one, so add the JH7110 to the enum.
>=20
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D5

