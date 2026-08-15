Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D678FC5B572
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 00:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF1710E0D3;
	Sat, 15 Aug 2026 00:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ili/vlGd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E08310E0D3
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 00:08:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CACA4322E;
 Sat, 15 Aug 2026 00:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41551F000E9;
 Sat, 15 Aug 2026 00:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786752499;
 bh=SP3XKis2lr4xx0vV/0T//JuIHdd3xhKpK+cc0SgHZmU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ili/vlGdOlfQeUUY5/Rz6gjMLzD9YNSqsca2VPLTIc0C5SMGznzuvC34cnGFBbl8f
 mRQ96gr+YvtUdlaZhetIW04D7Aa+xyHgyu9rEJiF+Ae9+2sQhPVtEDEOodvk2nTIjn
 pDrLWDy5eebxeWd5NVZvQkebImKhDU0SYpxfeE6Kqf00cVtzsL/odagS9v8NPH4pzf
 6LDQBVTFxTc9y5AI1eBazItBx9MJX3/I4Ok2tcbK7WySth5orv8uk/GS8LgKrbjcBq
 jBKYXHr46Nl64vlkZh4pY/s6rmy1JuIZCagFtcr/xEZvsDf1zE1HHzwk2ylOugh4+Q
 3izRsdSARTSjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] nouveau/disp: add GB20x HDMI vendor infoframe writer
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814235705.59132-2-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-2-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 00:08:18 +0000
Message-Id: <20260815000818.D41551F000E9@smtp.kernel.org>
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
- [High] The newly added `gb202_sor_hdmi_infoframe_vsi` function is never h=
ooked into any display structures, rendering it dead code. Consequently, GB=
20x chips will incorrectly fall back to the legacy `gv100_sor_hdmi_infofram=
e_vsi` function, writing to the removed 0x6f0100 registers.
--

--- Patch [1]: [PATCH 1/7] nouveau/disp: add GB20x HDMI vendor infoframe wr=
iter ---
commit 722f58f6d8bd3ed70d39357b7f9c41339c88e50d
Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>

nouveau/disp: add GB20x HDMI vendor infoframe writer

This commit adds a new HDMI vendor infoframe writer specifically for GB20x=
=20
chips. It handles the hardware change where the legacy VSI unit at 0x6f0100=
=20
was removed and replaced by shared generic infoframe units.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/disp/gb202.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
[ ... ]
> +void
> +gb202_sor_hdmi_infoframe_vsi(struct nvkm_ior *ior, int head, void *data,=
 u32 size)
> +{

[Severity: High]
Is this new function ever called? It appears it is not hooked into any of t=
he
display structures, leaving it as dead code.

Without wiring this up, won't GB20x chips still incorrectly fall back to th=
e=20
legacy function when sending an HDMI vendor infoframe? For example,=20
r535_sor_hdmi in drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c=20
continues to unconditionally use the legacy callback:

    .infoframe_vsi =3D gv100_sor_hdmi_infoframe_vsi,

Could this cause MMIO faults or fail to send the vendor infoframe when=20
the driver attempts to access the removed 0x6f0100 registers on GB20x
hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814235705.5913=
2-1-mohamedahmedegypt2001@gmail.com?part=3D1
