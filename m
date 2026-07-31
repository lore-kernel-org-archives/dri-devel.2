Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165A3C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F55C10E1F2;
	Fri, 31 Jul 2026 12:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DbRnn08d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8A410E1F2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:24:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8D8B404AC;
 Fri, 31 Jul 2026 12:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3941F00A3A;
 Fri, 31 Jul 2026 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785500688;
 bh=L2vP8b7HJGpsXI7AuoIDK1bCKjqgQ00jawFq7KGMDt0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DbRnn08drexc/TDA/ysoBvWG9f4xDSnTT8fRAvTJI1rG/XagggWhFzAFXdQi568y6
 Lp7pR6wBsp+e/qM5qYABhkbAzags1hZ3VpX2udpQI2AQTiTMhhlJLQSJOUQ+1Gh1Ea
 n/eSyr7CXPJK56MtG/Wb1PBUnHKkhXeDP9GiONPflvYEjfkXdbhvzuPeqX0e56JB1M
 gvrZipOYmWMgfvUCcd0oeMfoq8f7CIHa8ZlP8vGQ4OIVoc3YGNhUP2XnBVJnINNilF
 jYEdTB2FkSVGA8rdlDKfX8jUFL2dER7LCQnh08ox3ysmk8ZBATJ/vHqlZoZMcMoJ5Z
 sH8ZugyECXSLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] fbdev: tdfxfb: Add helper to read config table
 from BIOS
To: "Daniel Palmer" <daniel@0x0f.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260731121915.3362232-2-daniel@0x0f.com>
References: <20260731121915.3362232-1-daniel@0x0f.com>
 <20260731121915.3362232-2-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 12:24:48 +0000
Message-Id: <20260731122448.9C3941F00A3A@smtp.kernel.org>
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
- [Low] The patch introduces a static function `tdfxfb_get_bios_cfg` withou=
t calling it anywhere in the file, which will cause `-Wunused-function` com=
piler warnings.
--

--- Patch [1]: [PATCH v2 1/5] fbdev: tdfxfb: Add helper to read config tabl=
e from BIOS ---
commit fa478291eec9e5fb1f0dff8fd28bbff72c80da86
Author: Daniel Palmer <daniel@0x0f.com>

fbdev: tdfxfb: Add helper to read config table from BIOS

This commit adds a helper function to read the configuration table from the
video BIOS for Voodoo 3 cards. This is in preparation for manually booting
these cards in environments where the BIOS has not run.

> diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
> index cc6a074f3165b..e92658274411a 100644
> --- a/drivers/video/fbdev/tdfxfb.c
> +++ b/drivers/video/fbdev/tdfxfb.c
[ ... ]
> +static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
> +				struct tdfx_bios_cfg *cfg)
> +{

[Severity: Low]
Does this new static function trigger a -Wunused-function compiler warning?

It doesn't appear to be called anywhere in this patch. Introducing an
unreferenced static function usually causes build failures on configurations
where warnings are treated as errors (CONFIG_WERROR=3Dy).=20

Should this helper be added in the same patch that starts using it, or
perhaps marked with __maybe_unused to prevent the warning in the interim?

> +	u16 romcfg, oemcfg;
> +	void __iomem *rom;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731121915.3362=
232-1-daniel@0x0f.com?part=3D1
