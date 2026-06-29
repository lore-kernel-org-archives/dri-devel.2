Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7C0C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102CB10E68C;
	Mon, 29 Jun 2026 01:27:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AimSEG7I";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF3B10E68C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 01:27:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1FA860052;
 Mon, 29 Jun 2026 01:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613EC1F000E9;
 Mon, 29 Jun 2026 01:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782696475;
 bh=TUk2fg0P95yeALXI3wB2Iam5/Gl75lmhtXJf94dnAD4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AimSEG7IcWzTe918dB4e7zpjZmjd3m552z+Lr14a/Ueva7I11G/8X/ZfsqeLruH0G
 zfHZ3FngkTiumViLs0W/bBp3q0msRA7filqP6yVs/YkLPYPkKCp0l2STE8a32v8fOv
 qDnw24ElWajhdXoUZVBEmP6KIfeQRuBHaqSmdB9HsiRcU4nDn1wjsOncfkjkRziiil
 3VY/KqjFJ3a4n1ApTcnaps2lwacGnx0vg037p3/TgaMkr0jPAPfUzNB4hd8vuxPp0S
 FE+nd5FvGI/6EOB6qE9iYP9lGqH/Oz8/9TCYOKqMhCL9yNVtRA8aiPLaIpsyQIKF3r
 X0DHjkSARZYHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel-edp: Support MB116AS01-3 edp panel
To: "Haikun Zhou" <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629012200.248066-1-zhouhaikun5@huaqin.corp-partner.google.com>
References: <20260629012200.248066-1-zhouhaikun5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 01:27:54 +0000
Message-Id: <20260629012755.613EC1F000E9@smtp.kernel.org>
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
- [Medium] The panel name string in `EDP_PANEL_ENTRY` does not match the ac=
tual hardware EDID, breaking the primary identity match.
--

commit 0f4c5c953c19a29919cb343c3bc25a2803059da7
Author: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
drm/panel-edp: Support MB116AS01-3 edp panel

This commit adds support for the HKC MB116AS01-3 eDP panel to the generic
panel-edp driver. It introduces the necessary delay configuration and EDID
identifiers for this display.

> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2099,6 +2099,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> =20
>  	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335,=
 "LP079QX1-SP0V"),
> =20
> +	EDP_PANEL_ENTRY('H', 'K', 'C', 0x1203, &delay_200_500_e80, "MB116AS01-3=
"),

[Severity: Medium]
Does the panel name string in this entry match the actual hardware EDID?

Looking at the raw EDID payload provided in the commit message:
00 4d 42 31 31 36 41 53 30 31 27 33 20 20 01 cb

The byte 0x27 translates to an apostrophe ('), which makes the hardware name
"MB116AS01'3" rather than "MB116AS01-3" (which would use a hyphen, 0x2d).

Because drm_edid_match() strictly compares this string against the EDID
payload using strncmp(), this character mismatch will cause the primary
identity match to fail during panel probe. While the code will currently fa=
ll
back to a secondary panel ID match, this completely bypasses the primary na=
me
matching mechanism designed to distinguish panels when vendors incorrectly
reuse panel IDs.

>  	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d51, &delay_200_500_e200, "Unknown"),
>  	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "MB116AN01"=
),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629012200.2480=
66-1-zhouhaikun5@huaqin.corp-partner.google.com?part=3D1
