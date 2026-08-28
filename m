Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7C9C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CAC10E2A2;
	Fri, 28 Aug 2026 13:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QF4fewV3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2351210E2A2
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 13:54:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9DCD417E9;
 Fri, 28 Aug 2026 13:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F12C1F000E9;
 Fri, 28 Aug 2026 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787925244;
 bh=2c8diSklvVUd6K6I6bSdgpwdYZU6SUVzQlMEjE+KPWA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QF4fewV3m9gBHaINgD97JHB3uR/xyDcmpuJKAR5IGoBnglde8KYq9Wu5FNZ/ZDL9o
 axes+Ku5Awi2vrgnlRXUp9jifxGsrIsFzgCIrgJzCMALs5LDxiPV2RjLC/rBoVtYWZ
 ZXZ9xdX5I/dKFwfulnZLw+YglsXjur8c4ekU48lZhxVEY/HQU2FTweL+Itv+LNvb4i
 CCQh9KxJegNhbxxfqAMrdZebY7bo3bl+oXtOo+PoCcIItd+ovh2rVrZsjiA8QEOEKJ
 c7I3MP6ZJy676XVwqHpqbj8+S0osR6f1YlmYFZwo4lWD2IV5cEUZjId1nBYKYVl55f
 rqeqZQWM6seBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/15] dt-bindings: mfd: Add
 starfive,jh7110-hdmi-subsystem
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, olteanv@gmail.com, robh@kernel.org,
 conor+dt@kernel.org, linux-phy@lists.infradead.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, devicetree@vger.kernel.org, mfd@lists.linux.dev,
 lee@kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260828-jh7110-clean-send-v2-3-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134819eucas1p2c8e2bb95dd957981ec5e60e1da03223c@eucas1p2.samsung.com>
 <20260828-jh7110-clean-send-v2-3-331680c8b9d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 13:54:03 +0000
Message-Id: <20260828135404.2F12C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The compatible string 'starfive,jh7110-hdmi-subsystem' embeds softw=
are architecture details into the hardware description.
--

commit f244c8f1868df1c7d5507202956114ed3dbd675e
Author: Michal Wilczynski <m.wilczynski@samsung.com>

dt-bindings: mfd: Add starfive,jh7110-hdmi-subsystem

This commit adds a device tree binding for the StarFive JH7110 HDMI subsyst=
em.
The binding describes a parent device acting as an MFD to hold shared
registers for PHY and controller children, addressing a circular clock
dependency.

> diff --git a/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-s=
ubsystem.yaml b/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-=
subsystem.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsyste=
m.yaml
[ ... ]
> +description:
> +  The StarFive JH7110 HDMI block is a monolithic IP containing both
> +  the digital controller logic and the analog PHY logic in a single
> +  register space.
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-hdmi-subsystem

[Severity: Low]
Is the use of "subsystem" in this compatible string intentional?

Device tree bindings typically describe the physical hardware block rather
than the software architecture. Since the commit message and description
indicate the HDMI IP is a monolithic physical block, encoding a Linux-speci=
fic
driver concept like a subsystem or an MFD parent into the compatible string
appears to embed software details into the hardware description.

Could this compatible string be updated to reflect the actual hardware bloc=
k's
designation without the "subsystem" suffix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-jh7110-cle=
an-send-v2-0-331680c8b9d1@samsung.com?part=3D3
