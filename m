Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9D5CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5123810EF43;
	Wed, 17 Jun 2026 10:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bYomQHTP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DE410EF43
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:07:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 28988437A4;
 Wed, 17 Jun 2026 10:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18A61F000E9;
 Wed, 17 Jun 2026 10:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781690855;
 bh=UTy4je1+uMVpfkH3XewADIU8e+hV8PGREkio8CiIraM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bYomQHTPCBDwPR9XW3jPN70yYLuwAKbCflPZe1pMc8lNcQbNY13N6RP/JyfrdV55a
 QJCY4OvIGyHiSgko0fR8SR2+Bowg5aMgXfWuYOW9QhsOQt7OGZHlVbk4adHbPScnnf
 /SKGQSd24w+88AsUPFqzhOv+dlLpKgjIopRk7Cn9sFDfwK8G+TVDXPwnOgvlIJGw4h
 lxeXRgel45m9PreGfMsL663jqsZm4wQrni674qDhnIWA1pd0Wfgqn7Zrbs90TH6+zK
 0LxzOZZKgo2YzNmUjb+OXMOA56sY5+vCavjzbwHS0bH7C+zxrwsO3Qaf9U/bw95JGt
 qSVgXg/+PE67g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Support new NV140FHM-N5B and TM156VDXP25 edp panel, the
 NV140FHM-N5B need 200ms delays from the backlight to valid data, 100ms
 delays from backlight off to valid data, the TM156VDXP25 need 100ms delays
 from the backlight to valid data.
To: "Haikun Zhou" <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617100120.3426673-1-zhouhaikun5@huaqin.corp-partner.google.com>
References: <20260617100120.3426673-1-zhouhaikun5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 10:07:34 +0000
Message-Id: <20260617100734.E18A61F000E9@smtp.kernel.org>
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
- [Medium] Mismatch between stated panel delay requirements in the commit m=
essage and the assigned delay struct.
--

commit a20ff596ba1f763a527dc4fb43598b1e0368d9e8
Author: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>

Support new NV140FHM-N5B and TM156VDXP25 edp panel, the NV140FHM-N5B need 2=
00ms delays from the backlight to valid data, 100ms delays from backlight o=
ff to valid data, the TM156VDXP25 need 100ms delays from the backlight to v=
alid data.

This commit adds support for the NV140FHM-N5B and TM156VDXP25 eDP panels.
It introduces their respective EDID data and defines delay timings required
for their operations.

> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index aa27d6cd932e8..afbeaddca4b9a 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c

[ ... ]

> @@ -2151,6 +2161,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> =20
>  	EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, "TM140VD=
XP01-04"),
>  	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100, "TL140V=
DMS03-01"),
> +	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e50_d100, "TM156V=
DXP25"),

[Severity: Medium]
The commit message states that the TM156VDXP25 panel requires "100ms delays
from the backlight to valid data". Based on the description for the
NV140FHM-N5B panel in the same commit message, this terminology maps to
setting .powered_on_to_enable.

However, the assigned delay struct here (delay_200_500_e50_d100) sets
.disable =3D 100 and does not set .powered_on_to_enable =3D 100.

Does the commit message have a typo and intended to say "100ms delays from
backlight off to valid data", or should this panel be assigned a different
delay structure that sets .powered_on_to_enable =3D 100?

> =20
>  	{ /* sentinal */ }
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617100120.3426=
673-1-zhouhaikun5@huaqin.corp-partner.google.com?part=3D1
