Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8372C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1616D10F545;
	Fri, 17 Jul 2026 12:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jDuNfiXx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BCE810F548
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:30:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B02C60A5E;
 Fri, 17 Jul 2026 12:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1F91F000E9;
 Fri, 17 Jul 2026 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784291431;
 bh=1ycxZC2wtNKQ+x4yH6H19ifoAwp4Ht+9QQRRfMv/9cA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jDuNfiXxdU5RGxPNgAiyQ5iZk95BXrK97EtOXeJKZjrq4D94wXzsos90UBYoZy0ts
 RCT48wG3acwQ4HNumc1fPprNXj5i2NCxJOOdswcT0gUW/RVX11i0/8OdnikXPEqFrz
 ep9aSkB88V8EHrh1DKApN0Ra7ptHpg4okIytOt1bMKIMPSKgw8MKYwRQkcO75pkCr6
 NAOzUL4YYbOMs4lM4wtoMz1478j2JWi1SbeDSpV5n2Bc05x9mmdP91swiRI4xy8Qrv
 +zLNUUh1LTOU2zSGjOEpLQQWOs7p3axqPKNInRaI86EWI/q3sYm+/FtKKEaTsp3OWQ
 NTM+GIFJsYmlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/4] ARM: dts: imx7-colibri: Set LCDIF format
To: "Francesco Dolcini" <francesco@dolcini.it>
Cc: imx@lists.linux.dev, robh@kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260717121847.488148-5-francesco@dolcini.it>
References: <20260717121847.488148-1-francesco@dolcini.it>
 <20260717121847.488148-5-francesco@dolcini.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 12:30:30 +0000
Message-Id: <20260717123031.6B1F91F000E9@smtp.kernel.org>
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
- [Medium] The commit message body incorrectly refers to `colibri imx6ull` =
instead of `colibri imx7`.
--

--- Patch [4]: [PATCH v1 4/4] ARM: dts: imx7-colibri: Set LCDIF format ---
commit 9c45712860f8ad12db4bc3a18c8c4e7039c7f51b
Author: Francesco Dolcini <francesco.dolcini@toradex.com>

ARM: dts: imx7-colibri: Set LCDIF format

This commit updates the device tree for the Colibri i.MX7 to explicitly set
the LCDIF pixel format to rgb666 for its 18-bit width bus.

> The lcd DPI interface on colibri imx6ull uses a 18-bit width bus, set
> the interface-pix-fmt accordingly.

[Severity: Medium]
Is this description accurate for this patch? The subject and the modified=20
file (imx7-colibri.dtsi) both target the i.MX7 hardware, but the commit=20
message body mentions the colibri imx6ull. Should this text be updated to=20
refer to the i.MX7?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717121847.4881=
48-1-francesco@dolcini.it?part=3D4
